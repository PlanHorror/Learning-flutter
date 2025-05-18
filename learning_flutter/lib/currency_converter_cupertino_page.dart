import 'package:flutter/cupertino.dart';

class CurrencyConverterCurpertinoPage extends StatefulWidget {
  const CurrencyConverterCurpertinoPage({super.key});

  @override
  State<CurrencyConverterCurpertinoPage> createState() =>
      _CurrencyConverterCurpertinoPageState();
}

class _CurrencyConverterCurpertinoPageState
    extends State<CurrencyConverterCurpertinoPage> {
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
    return CupertinoPageScaffold(
      backgroundColor: Color.fromRGBO(3, 7, 18, 1),
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          "Currency Converter",

          style: TextStyle(
            color: CupertinoColors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
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
              color: CupertinoColors.white,
              fontSize: 28,
              fontWeight: FontWeight.w800,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: CupertinoTextField(
              controller: textEditingController,
              style: TextStyle(color: CupertinoColors.white),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color.fromARGB(255, 155, 255, 253),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              placeholderStyle: TextStyle(
                color: CupertinoColors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              placeholder: "Input amout of USD",
              prefix: const Icon(CupertinoIcons.money_dollar),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: CupertinoButton(
              onPressed: convert,

              color: Color.fromARGB(255, 51, 51, 51),
              child: Text('Convert'),
            ),
          ),
        ],
      ),
    );
  }
}
