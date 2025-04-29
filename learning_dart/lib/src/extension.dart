void main() {
  String name = "My name is nothing";
  print(name.lengthEven());
  print('something'.capitaliseFirstLetter());
}

extension ExtensionForString on String {
  bool lengthEven() {
    return this.length % 2 == 0;
  }

  String capitaliseFirstLetter() {
    return this[0].toUpperCase() + substring(1);
  }
}
