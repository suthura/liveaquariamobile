import 'package:aquaria_mobile/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Alert errorMessage(
  context, {
  required String errorTxt,
  bool showIcon = true,
  int btnType = 1,
  List<DialogButton>? buttons,
}) =>
    Alert(
      onWillPopActive: buttons != null,
      context: context,
      style: const AlertStyle(
        backgroundColor: Colors.grey,
      ),
      closeIcon: Container(),
      content: Column(
        children: [
          if (showIcon)
            Icon(
              btnType == 1
                  ? Ionicons.alert_circle
                  : btnType == 2
                      ? Ionicons.warning
                      : Ionicons.information_circle,
              color: btnType == 1
                  ? Colors.red
                  : btnType == 2
                      ? Colors.amber
                      : Colors.blue,
              size: SizeConfig().getTextSize(50),
            ),
          if (showIcon)
            Text(
              btnType == 1
                  ? 'Error'
                  : btnType == 2
                      ? "Warning"
                      : "Information",
              style: TextStyle(
                color: btnType == 1
                    ? Colors.red
                    : btnType == 2
                        ? Colors.amber
                        : Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          if (showIcon)
            Container(
              height: 20,
            ),
          Text(
            errorTxt,
            style: TextStyle(
              fontSize: SizeConfig().getTextSize(17),
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
      buttons: buttons ?? [],
    );
