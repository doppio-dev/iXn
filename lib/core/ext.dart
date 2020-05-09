extension Linq<T> on List<T> {
  /// default = null
  T get firstOrDefault => isEmpty ? null : first;
}
