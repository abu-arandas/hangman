import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

const kActionButtonTextStyle = TextStyle(
  fontSize: 25,
  color: Colors.white,
  fontWeight: FontWeight.w300,
  letterSpacing: 0.5,
);

const kWordButtonTextStyle = TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: 27,
);

const kHighScoreTableHeaders = TextStyle(
  color: Colors.white,
  fontSize: 30,
  fontWeight: FontWeight.w300,
  letterSpacing: 1,
);

const kHighScoreTableRowsStyle = TextStyle(
  color: Colors.white,
  fontSize: 27,
  fontWeight: FontWeight.w300,
  letterSpacing: 1,
);

var kSuccessAlertStyle = AlertStyle(
  animationType: AnimationType.grow,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  animationDuration: const Duration(milliseconds: 500),
  backgroundColor: const Color(0xFF2C1E68),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  titleStyle: const TextStyle(
    color: Color(0xFF00e676),
    fontWeight: FontWeight.bold,
    fontSize: 30,
    letterSpacing: 1.5,
  ),
);

var kExitAlertStyle = AlertStyle(
  animationType: AnimationType.grow,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  descStyle: const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 27,
    letterSpacing: 2,
  ),
  animationDuration: const Duration(milliseconds: 500),
  backgroundColor: const Color(0xFF2C1E68),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  titleStyle: const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 27,
    letterSpacing: 2,
  ),
);

var kGameOverAlertStyle = AlertStyle(
  animationType: AnimationType.grow,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  animationDuration: const Duration(milliseconds: 450),
  backgroundColor: const Color(0xFF2C1E68),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  titleStyle: const TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.bold,
    fontSize: 30,
    letterSpacing: 1.5,
  ),
  descStyle: const TextStyle(
    color: Colors.lightBlue,
    fontWeight: FontWeight.bold,
    fontSize: 25,
    letterSpacing: 1.5,
  ),
);

var kFailedAlertStyle = AlertStyle(
  animationType: AnimationType.grow,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  animationDuration: const Duration(milliseconds: 450),
  backgroundColor: const Color(0xFF2C1E68),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  titleStyle: const TextStyle(
    color: Colors.red,
    fontWeight: FontWeight.bold,
    fontSize: 30,
    letterSpacing: 1.5,
  ),
);

const kDialogButtonTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 25,
  fontWeight: FontWeight.w300,
  letterSpacing: 0.5,
);

const kWordTextStyle = TextStyle(fontSize: 57, color: Colors.white, fontFamily: 'FiraMono', letterSpacing: 8);

const kDialogButtonColor = Color(0x00000000);

const kWordCounterTextStyle = TextStyle(fontSize: 29.5, color: Colors.white, fontWeight: FontWeight.w900);
