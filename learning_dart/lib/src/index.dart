import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  try {
    final res = await http.get(
      Uri.https('jsonplaceholder.typicode.com', 'users'),
    );
    print(jsonDecode(res.body)[0]['names']);
  } catch (e) {
    print('Some thing went wrong');
  }

  http
      .get(Uri.https('jsonplaceholder.typicode.com', 'users'))
      .then((val) => print(jsonDecode(val.body)[0]['name']))
      .catchError((e) => print(e));
}
