void main(List<String> args) {
  final list = [1, 2, 3];
  // The return type 'Null' isn't a 'int', as required by the closure's context.
  final x = list.firstWhere((element) => element > 3, orElse: () => null);

  if (x == null) {
    // do stuff...
  }
}
