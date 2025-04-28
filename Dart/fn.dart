void main() {
  final fn = printFn();
  printFn();
  fn();
  print("Some thing");
}

Function printFn() {
  return () {
    print('Hello, Dart!');
  };
}
