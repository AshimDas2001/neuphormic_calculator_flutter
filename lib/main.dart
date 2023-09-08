import 'dart:math';

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
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: CalculatorApp(),
    );
  }
}

const Color colorDark = Color(0xFF374352);
const Color colorLight = Color(0xFFe6eeff);

class CalculatorApp extends StatefulWidget {
  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String expression = '0';
  String result = '';
  bool darkMode = false;
  String expressReal = '';
  String equals = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkMode ? colorDark : colorLight,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    darkMode ? darkMode = false : darkMode = true;
                  });
                },
                child: _switch()),
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                color: darkMode ? colorDark : colorLight,
                child: Text(
                  '$expression',
                  style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.w500,
                      color: darkMode ? Colors.green : Colors.redAccent),
                ),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "$equals",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w500,
                      color: darkMode ? Colors.green : Colors.redAccent,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  color: darkMode ? colorDark : colorLight,
                  child: Text(
                    '$result',
                    style: TextStyle(
                        fontSize: 38,
                        fontWeight: FontWeight.w500,
                        color: darkMode ? Colors.white : Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonOval(
                          title: 'sin(',
                          textcolor:
                              darkMode ? Colors.green : Colors.redAccent),
                      _buttonOval(
                          title: 'cos(',
                          textcolor:
                              darkMode ? Colors.green : Colors.redAccent),
                      _buttonOval(
                          title: 'tan(',
                          textcolor:
                              darkMode ? Colors.green : Colors.redAccent),
                      _buttonOval(
                          title: ' % ',
                          textcolor: darkMode ? Colors.green : Colors.redAccent)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonRounded(
                          title: 'C',
                          textcolor:
                              darkMode ? Colors.green : Colors.redAccent),
                      _buttonRounded(
                          title: '(',
                          textcolor:
                              darkMode ? Colors.green : Colors.redAccent),
                      _buttonRounded(
                          title: ')',
                          textcolor:
                              darkMode ? Colors.green : Colors.redAccent),
                      _buttonRounded(
                          title: '/',
                          textcolor: darkMode ? Colors.green : Colors.redAccent)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonRounded(title: '7'),
                      _buttonRounded(title: '8'),
                      _buttonRounded(title: '9'),
                      _buttonRounded(
                          title: '*',
                          textcolor: darkMode ? Colors.green : Colors.redAccent)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonRounded(title: '4'),
                      _buttonRounded(title: '5'),
                      _buttonRounded(title: '6'),
                      _buttonRounded(
                          title: '-',
                          textcolor: darkMode ? Colors.green : Colors.redAccent)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonRounded(title: '1'),
                      _buttonRounded(title: '2'),
                      _buttonRounded(title: '3'),
                      _buttonRounded(
                          title: '+',
                          textcolor: darkMode ? Colors.green : Colors.redAccent)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buttonRounded(
                          title: '.',
                          textcolor:
                              darkMode ? Colors.green : Colors.redAccent),
                      _buttonRounded(title: '0'),
                      _buttonRounded(
                          icon: Icons.backspace_outlined,
                          iconColor:
                              darkMode ? Colors.green : Colors.redAccent),
                      _buttonRounded(
                          title: '=',
                          textcolor: darkMode ? Colors.green : Colors.redAccent)
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  operation(String? title) {
    if (title == 'C') {
      expression = '0';
      result = '';
      equals = '';
      expressReal = '';
    } else if (title == null) {
      expression = expression.substring(0, expression.length - 1);
      expressReal = expressReal.substring(0, expressReal.length - 1);
    } else if (expression == '0') {
      if (title == 'sin(' || title == 'cos(' || title == 'tan(') {
        if (title == 'sin(') {
          expressReal = "sin($pi/180*";
          expression = title;
        } else if (title == 'cos(') {
          expressReal = "cos($pi/180*";
          expression = title;
        } else if (title == 'tan(') {
          expressReal = "tan($pi/180*";
          expression = title;
        }
      } else {
        expression = title;
        expressReal = title;
      }
    } else if (title == 'sin(' || title == 'cos(' || title == 'tan(') {
      if (title == 'sin(') {
        expressReal += "sin($pi/180*";
        expression += title;
      } else if (title == 'cos(') {
        expressReal += "cos($pi/180*";
        expression += title;
      } else if (title == 'tan(') {
        expressReal += "tan($pi/180*";
        expression += title;
      }
    } else if (title == '=') {
      try {
        Parser p = new Parser();
        Expression exp = p.parse(expressReal);
        ContextModel cm = ContextModel();
        result = exp.evaluate(EvaluationType.REAL, cm).toString();
        if (result.length > 16 && result.length < 20) {
          result = result.substring(0, 16);
        } else if (result.length > 20) {
          result = "infinity";
        }
        equals = '=';
      } catch (e) {
        result = "error";
        equals = '=';
      }
    } else {
      expression += title;
      expressReal += title;
    }
    setState(() {});
  }

  Widget _switch() {
    return NuContainer(
      darkMode: darkMode,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      borderRadius: BorderRadius.circular(40),
      child: Container(
        width: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.sunny,
              color: darkMode ? Colors.grey : Colors.redAccent,
            ),
            Icon(
              Icons.nightlight_round_sharp,
              color: darkMode ? Colors.green : Colors.grey,
            )
          ],
        ),
      ),
    );
  }

  Widget _buttonOval(
      {String? title, double padding = 20, Color? textcolor, IconData? icon}) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: NuContainer(
        darkMode: darkMode,
        borderRadius: BorderRadius.circular(50),
        padding:
            EdgeInsets.symmetric(horizontal: padding, vertical: padding / 2),
        child: Center(
          child: GestureDetector(
            child: Text(
              '$title',
              style: TextStyle(
                  color: textcolor != null
                      ? textcolor
                      : darkMode
                          ? Colors.white
                          : Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              setState(() {
                operation(title);
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buttonRounded(
      {String? title,
      double padding = 14.5,
      IconData? icon,
      Color? iconColor,
      Color? textcolor}) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: GestureDetector(
        onTap: () {
          setState(() {
            operation(title);
          });
        },
        child: NuContainer(
          darkMode: darkMode,
          borderRadius: BorderRadius.circular(40),
          padding: EdgeInsets.all(padding),
          child: Container(
            width: padding * 2,
            height: padding * 2,
            child: Center(
              child: title != null
                  ? Text(
                      '$title',
                      style: TextStyle(
                          color: textcolor != null
                              ? textcolor
                              : darkMode
                                  ? Colors.white
                                  : Colors.black,
                          fontSize: 30),
                    )
                  : Icon(
                      icon,
                      color: iconColor,
                      size: 30,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class NuContainer extends StatefulWidget {
  final bool darkMode;
  final Widget? child;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  NuContainer(
      {this.darkMode = false, this.child, this.borderRadius, this.padding});

  @override
  _NuContainerState createState() => _NuContainerState();
}

class _NuContainerState extends State<NuContainer> {
  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool darkMode = widget.darkMode;
    return Listener(
      onPointerUp: _onPointerUp,
      onPointerDown: _onPointerDown,
      child: Container(
        padding: widget.padding,
        decoration: BoxDecoration(
            color: darkMode ? colorDark : colorLight,
            borderRadius: widget.borderRadius,
            boxShadow: _isPressed
                ? null
                : [
                    BoxShadow(
                        color: darkMode
                            ? Colors.black54
                            : Colors.blueGrey.shade200,
                        offset: Offset(4.0, 4.0),
                        blurRadius: 15.0,
                        spreadRadius: 1.0),
                    BoxShadow(
                      color: darkMode ? Colors.blueGrey.shade700 : Colors.white,
                      offset: Offset(-4.0, -4.0),
                      blurRadius: 15.0,
                      spreadRadius: 1.0,
                    )
                  ]),
        child: widget.child,
      ),
    );
  }
}
