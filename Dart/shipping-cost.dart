void main() {
  String zone = 'XYS';
  int weight = 5;
  print(calculator(zone, weight));
}

int calculator(String zone, int weight) {
  switch (zone) {
    case 'XYZ':
      return weight * 5;
    case 'ABC':
      return weight * 7;
    case 'PQR':
      return weight * 10;
    default:
      throw new Exception('Invalid zone');
  }
}
