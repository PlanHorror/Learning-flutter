import 'dart:async';

void main() {
  countTo(10).listen((val) => print(val));
}

// Stream<int> countTo(int j) async* {
//   for (int i = 0; i <= j; i++) {
//     await Future.delayed(Duration(seconds: 1));
//     yield i;
//   }
// }

Stream<int> countTo(int j) {
  final controller = StreamController<int>();
  controller.sink.add(10);
  controller.sink.add(20);
  controller.sink.add(120);
  controller.stream.listen((val) => print(val));
  return Stream.periodic(Duration(seconds: 1), (val) {
    if (val <= j) {
      return val + 1;
    } else {
      return 0;
    }
  });
}
