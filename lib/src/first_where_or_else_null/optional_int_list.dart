void main(List<String> args) {
  final List<int?> list = [1, 2, 3];
  final x = list.firstWhere((element) => element! > 3, orElse: () => null);

  assert(x == null);
}
