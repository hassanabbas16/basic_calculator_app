import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorAppHome(),
    );
  }
}

class CalculatorAppHome extends StatefulWidget {
  const CalculatorAppHome({Key? key}) : super(key: key);

  @override
  State<CalculatorAppHome> createState() => _CalculatorAppHomeState();
}

class _CalculatorAppHomeState extends State<CalculatorAppHome> {
  String equation = "0";
  String result = "0";
  String expression = "";

  buttonPressed(btnText) {
    setState(() {
      if (btnText == "AC") {
        equation = "0";
        result = "0";
      } else if (btnText == "⌫") {
        equation = equation.substring(0, equation.length - 1);

        if (equation == "") {
          equation = "0";
        }
      } else if (btnText == "=") {
        expression = equation;
        expression = expression.replaceAll("x", "*");
        expression = expression.replaceAll("÷", "/");

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = "${exp.evaluate(EvaluationType.REAL, cm)}";
        } catch (e) {
          "Error";
        }
      } else {
        if (equation == "0") {
          equation = btnText;
        } else
          equation = equation + btnText;
      }
    });
  }

  Widget calButtons(String btnText, Color txtColor, double btnWidth, Color btnColor) {
    return InkWell(
      onTap: () {
        buttonPressed(btnText);
      },
      child: Container(
        alignment: Alignment.center,
        height: 80,
        width: btnWidth,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          btnText,
          style: TextStyle(color: txtColor, fontSize: 30, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset : false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[900], // Set header background color
        title: Text(
          "Calculator Pro",
          style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.normal),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            //display expression
            Container(
              alignment: Alignment.centerRight,
              color: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: 180,
              width: double.infinity,
              child: SingleChildScrollView(
              child: Text(
                '$equation\n$result',
                style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.normal),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      calButtons('AC', Colors.white, 80, Colors.grey[900]!),
                      calButtons('⌫', Colors.white, 80, Colors.grey[900]!),
                      calButtons('%', Colors.white, 80, Colors.grey[900]!),
                      calButtons('÷', Colors.white, 80, Colors.grey[900]!),
                    ],
                  ),
                  const SizedBox(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      calButtons('7', Colors.white, 80, Colors.grey[800]!),
                      calButtons('8', Colors.white, 80, Colors.grey[800]!),
                      calButtons('9', Colors.white, 80, Colors.grey[800]!),
                      calButtons('x', Colors.white, 80, Colors.grey[900]!),
                    ],
                  ),
                  const SizedBox(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      calButtons('4', Colors.white, 80, Colors.grey[800]!),
                      calButtons('5', Colors.white, 80, Colors.grey[800]!),
                      calButtons('6', Colors.white, 80, Colors.grey[800]!),
                      calButtons('-', Colors.white, 80, Colors.grey[900]!),
                    ],
                  ),
                  const SizedBox(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      calButtons('1', Colors.white, 80, Colors.grey[800]!),
                      calButtons('2', Colors.white, 80, Colors.grey[800]!),
                      calButtons('3', Colors.white, 80, Colors.grey[800]!),
                      calButtons('+', Colors.white, 80, Colors.grey[900]!),
                    ],
                  ),
                  const SizedBox(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      calButtons('0', Colors.white, 170, Colors.grey[800]!),
                      calButtons('.', Colors.white, 80, Colors.grey[900]!),
                      calButtons('=', Colors.white, 80, Colors.grey[900]!),
                    ],
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
