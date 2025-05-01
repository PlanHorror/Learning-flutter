import 'package:flutter/material.dart';

int num = 0;

class CurrencyConverterMaterialPage extends StatefulWidget {
  const CurrencyConverterMaterialPage({super.key});
  @override
  State<CurrencyConverterMaterialPage> createState() {
    return _CurrencyConverterMaterialPage();
  }
}

class _CurrencyConverterMaterialPage
    extends State<CurrencyConverterMaterialPage> {
  @override
  void initState() {
    super.initState();
  }

  double currency = 0;
  TextEditingController textEditingController = TextEditingController();
  convert() {
    currency = double.parse(textEditingController.text) * 23;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: Color.fromARGB(255, 155, 255, 253),
        width: 2,
      ),
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${currency == 0
                  ? "0"
                  : currency.toStringAsFixed(2).endsWith("00")
                  ? currency.toStringAsFixed(0)
                  : currency.toStringAsFixed(2).endsWith("0")
                  ? currency.toStringAsFixed(1)
                  : currency.toStringAsFixed(2)} VND",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w800,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: textEditingController,
                style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
                decoration: InputDecoration(
                  hintText: "Input amout of USD",
                  hintStyle: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  prefixIcon: Icon(Icons.monetization_on_outlined),
                  prefixIconColor: Colors.black,
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: border,
                  focusedBorder: border,
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: convert,
                style: TextButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 51, 51, 51),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                child: Text('Convert'),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromRGBO(3, 7, 18, 1),
    );
  }
}
