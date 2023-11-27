import 'package:calculator1/button_details_2.dart';  //Home property of the app
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:calculator1/calculator_face.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
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
          children: [
            
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
                          //height: 60.0,
                          //fit: BoxFit.cover,
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
                      width: value == Btn.n0
                          ? screenSize.width / 3
                          : (screenSize.width / 6), // Dynamic value of Width based on U.I
                      height: screenSize.width / 5, // Dynamic value of Height based on U.I
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
                color: getTetColor(value),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onBtnTap(String value) {
    if (value == Btn.del) {
      delete();
      return;
    }

    if (value == Btn.clr) {
      clearAll();
      return;
    }

    if (value == Btn.per) {
      convertToPercentage();
      return;
    }

    if (value == Btn.fac) {
      factorial();
      return;
    }

    if (value == Btn.log) {
      logof();
      return;
    }

    if (value == Btn.res) {
      reciprocal();
      return;
    }
    
    if (value == Btn.sqr) {
      square();
      return;
    }

    if (value == Btn.cub) {
      cube();
      return;
    }

    if (value == Btn.e) {
      expon();
      return;
    }

    if (value == Btn.les) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => CalculatorFace(),
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
    if (number1.isEmpty && operand.isNotEmpty) number1='0';
    if (number1.isEmpty) return;
    if (operand.isEmpty) return;
    if (number2.isEmpty) return;

    double num1 = double.parse(number1);
    double num2 = double.parse(number2);
    double num;

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
      case Btn.pow:
        num = num1;
        for (int i=1; i < num2; i++){
        num1 = num1 * num;
        }
        result = num1;
        break;
      case Btn.p:
        if (int.tryParse(number1) == null) return;
        if (int.tryParse(number2) == null) return;
        if (num2 > num1) return;

        num2 = num1 - num2;
        num = 1;
        for (int i = 1; i < num1+1; i++){
          num = num*i;
        }
        result = num;
        num = 1;
        for (int i = 1; i < num2+1; i++){
          num = num*i;
        }
        result = result/num;
        break;
        case Btn.c:
        if (int.tryParse(number1) == null) return;
        if (int.tryParse(number2) == null) return;
        if (num2 > num1) return;

        num = 1;
        for (int i = 1; i < num1+1; i++){
          num = num*i;
        }
        result = num;

        num = 1;
        for (int i = 1; i < num2+1; i++){
          num = num*i;
        }
        result = result/num;

        num2 = num1 - num2;

        num = 1;
        for (int i = 1; i < num2+1; i++){
          num = num*i;
        }
        result = result/num;

        break;
      default:
    }

    
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

  // ##############
  // converts output to %
  void convertToPercentage() {
    // ex: 434+324
    if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
      // calculate before conversion
      calculate();
    }

    if (operand.isNotEmpty) {
      // cannot be converted
      return;
    }

    final number = double.parse(number1);
    setState(() {
      number1 = "${(number/100)}";
      operand = "";
      number2 = "";
    });
  }

  void logof() {
    if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
      calculate();
    }

    if (operand.isNotEmpty) {
      return;
    }

    var number = double.parse(number1);
    number = log(number);
    setState(() {
      number1 = "${(number)}";
      operand = "";
      number2 = "";
    });
  } 

  void expon() {
    if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
      calculate();
    }

    if (operand.isNotEmpty) {
      return;
    }

    var number = double.parse(number1);
    double n = 1;
    for (int i = 1; i < number +1; i++){
      n = n * 2.7182818284590452353602874713527;
    }
    setState(() {
      number1 = "${(n)}";
      operand = "";
      number2 = "";
    });
  } 

  void factorial() {
    if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
      // calculate before conversion
      calculate();
    }

    if (operand.isNotEmpty) {
      // cannot be converted
      return;
    }

    if (int.tryParse(number1) == null) return;


    var n = int.parse(number1);
    int fact = 1;
    for (int i = 1; i < n+1; i++){
      fact = fact * i;
    };
    setState(() {
      number1 = "${(fact)}";
      operand = "";
      number2 = "";
    });
  }

  void reciprocal() {
    if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
      calculate();
    }

    if (operand.isNotEmpty) {
      return;
    }

    var n = double.parse(number1);
    setState(() {
      number1 = "${(1/n)}";
      operand = "";
      number2 = "";
    });
  }

  void square() {
    if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
      calculate();
    }

    if (operand.isNotEmpty) {
      return;
    }

    var number = double.parse(number1);
    number = number*number;
    setState(() {
      number1 = "${(number)}";
      operand = "";
      number2 = "";
      if (number1.endsWith(".0")) {
        number1 = number1.substring(0, number1.length - 2);
      }
      else if (number1.endsWith(".00")) {
        number1 = number1.substring(0, number1.length - 3);
      }
    });
  }

  void cube() {
    if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
      calculate();
    }

    if (operand.isNotEmpty) {
      return;
    }

    var number = double.parse(number1);
    number = number*number*number;
    setState(() {
      number1 = "${(number)}";
      operand = "";
      number2 = "";
      if (number1.endsWith(".0")) {
        number1 = number1.substring(0, number1.length - 2);
      }
      else if (number1.endsWith(".00")) {
        number1 = number1.substring(0, number1.length - 3);
      }
    });
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
    return [Btn.del, Btn.clr, Btn.les,].contains(value)
        ? Colors.blueGrey
        : [
            Btn.per,
            Btn.multiply,
            Btn.add,
            Btn.subtract,
            Btn.divide,
            Btn.calculate,
            Btn.fac,
            Btn.log,
            Btn.res,
            Btn.pow,
            Btn.sqr,
            Btn.cub,
            Btn.p,
            Btn.c,
            Btn.e,
          ].contains(value)
            ? Colors.amber
            : Colors.black87;
  }

  Color getTetColor(value) {
    return 
        [
                        Btn.del,
                        Btn.clr,
                        Btn.les,
                        Btn.per,
                        Btn.multiply,
                        Btn.add,
                        Btn.subtract,
                        Btn.divide,
                        Btn.calculate,
                        Btn.fac,
                        Btn.log,
                        Btn.res,
                        Btn.pow,
                        Btn.sqr,
                        Btn.cub,
                        Btn.p,
                        Btn.c,
                        Btn.e,
                        ].contains(value)
            ? Colors.black
            : Colors.grey;
  }

}