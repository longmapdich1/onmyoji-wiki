extension UpperCaseFirst on String {
  String get upperCaseFirst {
    return substring(0,1).toUpperCase()+substring(1);
  }
}