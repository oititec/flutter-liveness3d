extension EnumCaseName on Enum {
  String caseName() {
    return toString().split('.').last;
  }
}