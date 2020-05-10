extension Linq<T> on List<T> {
  /// default = null
  T get firstOrDefault => isEmpty ? null : first;
}

extension XDart on String {
  bool isNullOrEmpty({bool checkNullWord = false}) => this == null || isEmpty || checkNullWord && toLowerCase().trim() == 'null';
  bool isNullOrWhiteSpaces({bool checkNullWord = false}) => trim()?.isNullOrEmpty(checkNullWord: checkNullWord) != false;
}
