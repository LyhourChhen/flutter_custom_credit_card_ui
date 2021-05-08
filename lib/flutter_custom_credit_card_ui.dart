// ---------------------------
// @author: @lyhourchhen
// @email: chhenlyhour@gmail.com
// @date: 6/9/20 / 9:40 AM
// @objective: component to render CreditCard UI
// --------------------------

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:credit_card_type_detector/credit_card_type_detector.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomCreditCard extends StatefulWidget {
  CustomCreditCard({
    @required this.cardNumber,
    @required this.cardHolder,
    @required this.month,
    @required this.year,
    this.isGradient = true,
    this.bgColor = Colors.blueAccent,
  });
  String cardNumber;
  String cardHolder;
  int month;
  int year;
  bool isGradient;
  Color bgColor;
  @override
  _CustomCreditCardState createState() => _CustomCreditCardState();
}

class _CustomCreditCardState extends State<CustomCreditCard> {
  int randomColor = 0;
  static final firstColor = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xffFFB775),
        Color(0xffD736FF),
      ]);
  static final secondColor = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xff98B4E9),
        Color(0xff9C1FFF),
      ]);
  final bgColor = <LinearGradient>[firstColor, secondColor];
  @override
  void initState() {
    var rng = new Random().nextInt(2);
    setState(() {
      randomColor = rng;
    });

    super.initState();
  }

  String renderCreditCardNumberUI(String creditCardNumber) {
    final value = creditCardNumber.replaceAllMapped(
        RegExp(r".{4}"), (match) => "${match.group(0)}  ");
    return value;
  }

  IconData renderCreditCardIconUI(String creditCardNumber) {
    var icons;
    var type = detectCCType(creditCardNumber);
    print(type);
    if (type == CreditCardType.visa) {
      return icons = FontAwesomeIcons.ccVisa;
    } else if (type == CreditCardType.mastercard) {
      return icons = FontAwesomeIcons.ccMastercard;
    } else if (type == CreditCardType.unknown) {
      return icons = FontAwesomeIcons.solidCreditCard;
    } else {
      return icons = FontAwesomeIcons.solidCreditCard;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
              gradient: widget.isGradient ? bgColor[randomColor] : null,
              color: widget.isGradient != true ? widget.bgColor : null,
              borderRadius: BorderRadius.circular(15),
            ),
            height: 190,
            width: 343,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 21),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                          child: Icon(
                        renderCreditCardIconUI(
                          widget.cardNumber == null
                              ? "1234123412346666"
                              : widget.cardNumber,
                        ),
                        size: 30,
                        color: Colors.white,
                      )),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 21),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          renderCreditCardNumberUI(
                            widget.cardNumber == null ||
                                    widget.cardNumber.length == 0
                                ? "0000000000000000"
                                : widget.cardNumber,
                          ),
                          style: CreditNumber,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "CARD HOLDER",
                            style: headStyle,
                          ),
                          SizedBox(height: 4),
                          Text(
                            widget.cardHolder == null ||
                                    widget.cardHolder.length == 0
                                ? "Your Name"
                                : widget.cardHolder,
                            style: childStyle,
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            "Expiry Date",
                            style: headStyle,
                          ),
                          SizedBox(height: 4),
                          Text(
                            "${widget.month.toString() == null || widget.month.toString().length == 0 ? "00" : widget.month}/${widget.year.toString() == null || widget.year.toString().length == 0 ? "00" : widget.year}",
                            style: childStyle,
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )),
        Positioned(
          top: 0,
          left: 25,
          child: Container(
            child: Image.asset(
              "assets/icons/creditCardStyleTop.png",
              width: 10,
              height: 10,
              package: "flutter_custom_credit_card_ui",
            ),
            height: 53,
            width: 23,
          ),
        ),
        Positioned(
          bottom: 0,
          right: 343 / 2,
          child: Container(
            child: Image.asset(
              "assets/icons/creditCardStyleBottom.png",
              package: "flutter_custom_credit_card_ui",
            ),
            height: 53,
            width: 23,
          ),
        ),
      ],
    );
  }
}

const CreditNumber = TextStyle(
  color: Colors.white,
  fontSize: 20,
  fontFamily: "Poppins",
  fontWeight: FontWeight.bold,
  letterSpacing: 0.5,
);
const headStyle = TextStyle(
  fontFamily: "Poppins",
  color: Colors.white70,
  fontSize: 10,
);
const childStyle = TextStyle(
  fontFamily: "Poppins",
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 10,
);
