import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static void fieldFocus(BuildContext context, FocusNode currentfocusNode,
      FocusNode nextFocusNode) {
    currentfocusNode.unfocus();
    FocusScope.of(context).requestFocus(nextFocusNode);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: Colors.orange[400],
        textColor: Colors.white,
        fontSize: 16);
  }
}

extension EmptySpace on num {
  SizedBox get spaceY => SizedBox(
        height: toDouble(),
      );
  SizedBox get spaceX => SizedBox(
        width: toDouble(),
      );
}
