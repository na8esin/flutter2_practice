void main() {
  int? row;
  row ??= 1;
  row ??= 2;
  assert(row == 1);
}
