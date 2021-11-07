void main(List<String> args) {
  final List<int> list = [1, 2, 3];
  final found = list.where((element) => element > 3);
  final x = found.isEmpty ? null : found.first;

  assert(x == null);
}
