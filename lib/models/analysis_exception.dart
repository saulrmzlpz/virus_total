class AnalysisException implements Exception {
  String message;

  AnalysisException(this.message);

  @override
  String toString() {
    return message;
  }
}
