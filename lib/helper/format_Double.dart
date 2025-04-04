String doubleDigit(num value) {
  return value.toStringAsFixed(2);
}

String tripleDigit(num value) {
  return value.toStringAsFixed(1);
}

double roundOff(num value){
  return double.parse((value).toStringAsFixed(2));
}
