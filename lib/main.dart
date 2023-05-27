import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({Key? key}) : super(key: key);

  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = '0';
  String expression = '';
  double equationFontSize = 38.0;
  double resultFontSize = 48.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Calculator"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.black,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFontSize,color: Colors.white),
            ),
          ),
          Container(width: MediaQuery.of(context).size.width,height: 1,color: Colors.white,),
          Container(

            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              color: Colors.black,

            ),
            padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFontSize,color: Colors.white),
            ),
          ),
          Container(width: MediaQuery.of(context).size.width,height: 1,color: Colors.white,),
          Expanded(child: Container(
            color: Colors.black,
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        BuildButton("C", 1, Colors.black),
                        BuildButton("back", 1, Colors.black),
                        BuildButton("÷", 1, Colors.black),
                        //÷
                      ],
                    ),
                    TableRow(
                      children: [
                        BuildButton("7", 1, Colors.black),
                        BuildButton("8", 1, Colors.black),
                        BuildButton("9", 1, Colors.black),
                      ],
                    ),
                    TableRow(
                      children: [
                        BuildButton("4", 1, Colors.black),
                        BuildButton("5", 1, Colors.black),
                        BuildButton("6", 1, Colors.black),
                      ],
                    ),
                    TableRow(
                      children: [
                        BuildButton("1", 1, Colors.black),
                        BuildButton("2", 1, Colors.black),
                        BuildButton("3", 1, Colors.black),
                      ],
                    ),
                    TableRow(
                      children: [
                        BuildButton(".", 1, Colors.black),
                        BuildButton("0", 1, Colors.black),
                        BuildButton("00",1, Colors.black),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        BuildButton('×', 1 , Colors.black),
                      ],
                    ),
                    TableRow(
                      children: [
                        BuildButton('-', 1, Colors.black),
                      ],
                    ),TableRow(
                      children: [
                        BuildButton('+', 1, Colors.black),
                      ],
                    ),TableRow(
                      children: [
                        BuildButton('=', 2, Colors.black),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget BuildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      decoration: BoxDecoration(
          color: buttonColor,
          border: Border.all(width: 1, color: Colors.white)),
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      child: TextButton(
        onPressed: () => PressedButton(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
    );
  }
   PressedButton(String buttonText){
    setState(() {
      if(buttonText == 'C'){
        equation = '0';
        result = '0';
      }else if(buttonText == 'back'){
        equation = equation.substring(0,equation.length -1);
        if(equation == ''){
          equation = '0';
        }
      }else if(buttonText == '='){
         expression = equation ;
         expression = expression.replaceAll('*', '×');
         expression = expression.replaceAll('÷', '/');
        try{
          Parser p = new Parser();
          Expression exp = p.parse(equation);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = "error";
      }
      }else{
        if(equation =='0'){
          equation = buttonText;
        }else{
          equation = equation + buttonText;
        }

      }
    });
  }
}
