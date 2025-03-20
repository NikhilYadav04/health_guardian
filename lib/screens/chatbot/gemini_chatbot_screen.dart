import 'dart:convert';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:health_guardian/styling/colors.dart';
import 'package:health_guardian/styling/images.dart';
import 'package:health_guardian/styling/sizeConfig.dart';
import 'package:http/http.dart' as http;

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  bool _isLoading = false;
  bool _isGeminiTyping = false;
  final Gemini gemini = Gemini.instance;
  final TextEditingController _textEditingController = TextEditingController();

  List<ChatMessage> messages = [];

  ChatUser currentUser =
      ChatUser(id: "0", firstName: "Nikhil", profileImage: Images.heartPNG);
  ChatUser geminiUser =
      ChatUser(id: "1", firstName: 'AI Assistant', profileImage: Images.botPNG);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Your AI Doctor",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Poppins-Bold",
              fontWeight: FontWeight.bold,
              fontSize: 4.21348 * SizeConfig.heightMultiplier,
            ),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 233, 81, 70),
          toolbarHeight: 8.8 * SizeConfig.heightMultiplier,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            //* Chat UI
            Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                image: DecorationImage(
                  image: AssetImage(
                    "assets/chatbot/summary.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: DashChatUI(),
            ),
          ],
        ),
      ),
    );
  }

  Widget DashChatUI() {
    return DashChat(
        currentUser: currentUser,
        onSend: _sendMessages,
        messages: messages,
        inputOptions: InputOptions(
          sendButtonBuilder: (_) => SizedBox.shrink(),
          textController: _textEditingController,
          inputMaxLines: 5,
          inputTextStyle: TextStyle(fontFamily: "Glacial_Bold"),
          trailing: [
            IconButton(
              icon: Icon(
                Icons.send,
                size: 3.42809 * SizeConfig.heightMultiplier,
              ),
              color: Colours.buttonColorRed,
              onPressed: () {
                if (_textEditingController.text.trim().isNotEmpty) {
                  _sendMessages(ChatMessage(
                    text: _textEditingController.text.trim(),
                    user: currentUser,
                    createdAt: DateTime.now(),
                  ));
                  _textEditingController.clear();
                }
              },
            ),
          ],
        ),
        typingUsers:
            _isGeminiTyping ? [geminiUser] : [], //* Show only Gemini typing
        messageOptions: MessageOptions(
          textBeforeMedia: true,
          messageTextBuilder: (message, previousMessage, nextMessage) {
            return SelectableText(
              message.text,
              style: TextStyle(
                color: message.user.id == currentUser.id
                    ? Colors.white
                    : Colors.white,
              ),
            );
          },
          timeTextColor: Colors.black,
          currentUserContainerColor: Colours.buttonColorRed,
          currentUserTimeTextColor: Colors.black,
          containerColor: Colours.buttonColorRed,
          currentUserTextColor: Colors.black,
          timeFontSize: 3.37079 * SizeConfig.heightMultiplier,
          showOtherUsersName: true,
          showCurrentUserAvatar: true,
        ));
  }

  void _sendMessages(ChatMessage chatMessage) async {
    setState(() {
      _isLoading = true;
      _isGeminiTyping = true;
      messages = [chatMessage, ...messages];
    });

    try {
      String question = chatMessage.text;
      print("Prompt is: $question");
      const maxAttempts = 3;
      int attempt = 0;
      bool receivedResponse = false;
      String fullResponse = "";

      while (attempt < maxAttempts) {
        try {
          if (attempt > 0) {
            _showRetryMessage(attempt);
          }

          print("Making API call to localhost...");
          final IP = await dotenv.get('PC_IP');
          final response = await http.post(
            Uri.parse("https://gemini-server-2.onrender.com/generate"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"prompt": question}),
          );

          if (response.statusCode == 200) {
            final data = jsonDecode(response.body);
            fullResponse = data["response"] ?? "";
            receivedResponse = fullResponse.isNotEmpty;
          } else {
            throw Exception("Invalid response: ${response.statusCode}");
          }

          if (!receivedResponse) {
            throw Exception("No response received from API.");
          }

          messages = [
            ChatMessage(
              user: geminiUser,
              createdAt: DateTime.now(),
              text: fullResponse,
            ),
            ...messages
          ];

          setState(() {});
          break; // Exit the loop on success
        } catch (e) {
          print("Attempt ${attempt + 1} error: $e");
          attempt++;

          if (attempt == maxAttempts) {
            _showErrorMessage(
                "Service is currently unavailable. Please try again later.");
            return;
          }

          await Future.delayed(Duration(seconds: attempt * 2));
        }
      }
    } catch (e) {
      print("Final error: $e");
      _showErrorMessage("Failed to process request. Please try again.");
    } finally {
      setState(() {
        _isLoading = false;
        _isGeminiTyping = false;
      });
    }
  }

  void _showErrorMessage(String message) {
    setState(() {
      messages = [
        ChatMessage(
          user: geminiUser,
          createdAt: DateTime.now(),
          text: message,
        ),
        ...messages
      ];
      _isLoading = false;
      _isGeminiTyping = false;
    });
  }

  void _showRetryMessage(int attempt) {
    setState(() {
      messages = [
        ChatMessage(
          user: geminiUser,
          createdAt: DateTime.now(),
          text: "Server is busy. Retrying... (Attempt $attempt/3)",
        ),
        ...messages
      ];
    });
  }
}
