import 'package:logger/logger.dart';
import 'package:workmanager/workmanager.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

class WorkManager {
  //* cancel all tasks
  static void cancelTask() async {
    await Workmanager().cancelAll();
  }

  //* Schedule the Workmanager Task for reminder
  static void scheduleReminder(int minutes, String note) async {
    var uniqueID = DateTime.now().second.toString();
    Workmanager().registerOneOffTask(uniqueID, "reminder",
        inputData: {"note": note}, initialDelay: Duration(minutes: minutes));
  }
}
