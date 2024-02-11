import 'package:firebase_auth/firebase_auth.dart';
import 'package:calculator1/screens/login.dart';
import 'package:calculator1/button_details.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:calculator1/screens/calculator_page_2.dart';

class CalculatorFace extends StatefulWidget {
  const CalculatorFace({super.key});

  @override
  State<CalculatorFace> createState() => _CalculatorFaceState();
}

class _CalculatorFaceState extends State<CalculatorFace> {
  String number1 = ""; // . 0-9
  String operand = ""; // + - * /
  String number2 = ""; // . 0-9
  bool img = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; //Getting the screensize for dynamic button sizes.
    return Scaffold(
      body: SafeArea( // wrapping widget in SafeArea
        bottom: false, // If you don't want SafeArea in bottom part,
        child: Column( //Column allows for multiple widgets to be in one widget, Vertical.
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              'images/logo1.png', width: 100.0, height: 100.0,
            ),
            
            // Answer (Output)
            Expanded( //This is required for SingleChildScrollView needs some size when used inside column or row
              child: SingleChildScrollView( // Wrapping the widget to be scroll-able, so Answer doesn't overflow.
                reverse: true, // If not for this, By default SingleChildScrollView starts at top. As this is there, It stars from bottom.
                child: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.all(16), // Giving paddings
                  child: ("$number1$operand$number2" == "300")
                    ? 
                    new Image.asset(
                        'images/300.jpeg',
                      )
                    : ("$number1$operand$number2" == "3")
                      ?
                      new Image.asset(
                        'images/3.jpg',
                      )
                      : ("$number1$operand$number2" == "1000")
                        ?
                        new Image.asset(
                          'images/1000.jpeg',
                        )
                        : ("$number1$operand$number2" == "69")
                          ?
                          new Image.asset(
                          'images/69.jpg',
                          )
                          : ("$number1$operand$number2" == "3.14")
                            ? 
                            Text(
                              "π",
                              style: const TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.bold,
                              ),    // For Adjusting style
                              textAlign: TextAlign.end,
                            )
                            : ("$number1$operand$number2" == "2012")
                              ?
                              new Image.asset(
                              'images/2012.jpg',
                              )
                              : ("$number1$operand$number2" == "2")
                              ?
                              new Image.asset(
                              'images/2.jpg',
                              )
                              : 
                              Text(
                                "$number1$operand$number2".isEmpty
                                    ? "0"
                                    : 
                                      "$number1$operand$number2",
                                style: const TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                ),    // For Adjusting style
                                textAlign: TextAlign.end,
                              ),
                )
              ),
            ),

            // Input buttons
            Wrap( // Multiple widgets in one widget.
              children: Btn.buttonValues //Using a list from buttton_details.dart
                  .map(
                    (value) => SizedBox( //Giving each button a sized box
                      width: value == Btn.logout
                        ? screenSize.width
                        : value == Btn.n0
                          ? screenSize.width / 2
                          : (screenSize.width / 4), // Dynamic value of Width based on U.I
                      height: value == Btn.logout
                        ? screenSize.width / 8
                        : screenSize.width / 5, // Dynamic value of Height based on U.I
                      child: buildButton(value),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildButton(value) {
    return Padding( //each button having a space between them.
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: getBtnColor(value),
        clipBehavior: Clip.hardEdge, //Splash on click effect, stays inside due to this.
        shape: OutlineInputBorder( //Shape property to look good.
          borderSide: const BorderSide(
            color: Colors.white24, //Border color
          ),
          borderRadius: BorderRadius.circular(100), //Border radius
        ),
        child: InkWell(
          onTap: () => onBtnTap(value),
          child: Center( //Centering in each buttons.
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: getTextColor(value),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ########
  void onBtnTap(String value) {
    if (value == Btn.logout) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => SignInScreen(),
      ),
      (route) => false,
      );
    }

    if (value == Btn.del) {
      delete();
      return;
    }

    if (value == Btn.clr) {
      clearAll();
      return;
    }

    if (value == Btn.mor) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => Page2(),
      ),
      (route) => false,
      );
      //return;
    }

    if (value == Btn.calculate) {
      calculate();
      return;
    }

    appendValue(value);
  }

  // calculates the result
  void calculate() {
    if (number1.isEmpty) return;
    if (operand.isEmpty) return;
    if (number2.isEmpty) return;

    final double num1 = double.parse(number1);
    final double num2 = double.parse(number2);

    var result = 0.0;
    switch (operand) {
      case Btn.add:
        result = num1 + num2;
        break;
      case Btn.subtract:
        result = num1 - num2;
        break;
      case Btn.multiply:
        result = num1 * num2;
        break;
      case Btn.divide:
        result = num1 / num2;
        break;
      default:
    }

    if(result != 300){
      setState(() {
      number1 = result.toStringAsPrecision(3);

      if (number1.endsWith(".0")) {
        number1 = number1.substring(0, number1.length - 2);
      }
      else if (number1.endsWith(".00")) {
        number1 = number1.substring(0, number1.length - 3);
      }

      operand = "";
      number2 = "";
      });
    }
    else {
      setState(() {
      number1 = result.toStringAsPrecision(3);

      if (number1.endsWith(".0")) {
        number1 = number1.substring(0, number1.length - 2);
      }
      else if (number1.endsWith(".00")) {
        number1 = number1.substring(0, number1.length - 3);
      }

      operand = "";
      number2 = "";
      });

      img = true;

      }
  }

  // ##############
  // clears all output
  void clearAll() {
    setState(() {
      number1 = "";
      operand = "";
      number2 = "";
    });
  }

  // ##############
  // delete one from the end
  void delete() {
    if (number2.isNotEmpty) {
      // 12323 => 1232
      number2 = number2.substring(0, number2.length - 1);
    } else if (operand.isNotEmpty) {
      operand = "";
    } else if (number1.isNotEmpty) {
      number1 = number1.substring(0, number1.length - 1);
    }

    setState(() {});
  }



  // #############
  // appends value to the end
  void appendValue(String value) {
    // number1 opernad number2
    // 234       +      5343

    //

    // if is operand and not "."
    if (value != Btn.dot && int.tryParse(value) == null) {
      // operand pressed
      if (operand.isNotEmpty && number2.isNotEmpty) {
        // TODO calculate the equation before assigning new operand
        calculate();
      }
      operand = value;
    }
    // assign value to number1 variable
    else if (number1.isEmpty || operand.isEmpty) {
      // check if value is "." | ex: number1 = "1.2"
      if (value == Btn.dot && number1.contains(Btn.dot)) return;
      if (value == Btn.dot && (number1.isEmpty || number1 == Btn.n0)) {
        // ex: number1 = "" | "0"
        value = "0.";
      }
      number1 += value;
    }
    // assign value to number2 variable
    else if (number2.isEmpty || operand.isNotEmpty) {
      // check if value is "." | ex: number1 = "1.2"
      if (value == Btn.dot && number2.contains(Btn.dot)) return;
      if (value == Btn.dot && (number2.isEmpty || number2 == Btn.n0)) {
        // number1 = "" | "0"
        value = "0.";
      }
      number2 += value;
    }

    setState(() {});
  }

  // ########
  Color getBtnColor(value) {
    return [Btn.del, Btn.clr, Btn.mor, Btn.logout,].contains(value)
        ? Colors.blueGrey
        : [
            //Btn.mor,
            Btn.multiply,
            Btn.add,
            Btn.subtract,
            Btn.divide,
            Btn.calculate,
          ].contains(value)
            ? Colors.amber
            : Colors.black87;
  }

  Color getTextColor(value) {
    return [
              Btn.del,
              Btn.clr,
              Btn.mor,
              Btn.multiply,
              Btn.add,
              Btn.subtract,
              Btn.divide,
              Btn.calculate,
              Btn.logout,
                  ].contains(value)
                  ? Colors.black
                  : Colors.grey;
  }

}