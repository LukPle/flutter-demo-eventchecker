import 'package:event_checker/components/elevated_button.dart';
import 'package:event_checker/res/strings.dart';
import 'package:event_checker/res/styles.dart';
import 'package:event_checker/screens/event_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void askUserForName(BuildContext context) async {
  final usernameController = TextEditingController();
  bool isButtonEnabled = false;

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) => StatefulBuilder(builder: (context, setState) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: AppBorders.borderRadius,
          ),
          title: const Text(AppStrings.userNameDialogHeader),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(AppStrings.userNameDialogBody,
                  textAlign: TextAlign.justify),
              const SizedBox(height: 25),
              TextField(
                controller: usernameController,
                maxLines: 1,
                onChanged: (String newValue) {
                  setState(() {
                    if (newValue.isNotEmpty) {
                      isButtonEnabled = true;
                    } else {
                      isButtonEnabled = false;
                    }
                  });
                },
              ),
              const SizedBox(height: 50),
              buildElevatedButton(
                AppStrings.saveUsernameButtonLabel,
                () => setUsernameAndCloseDialog(
                    context, usernameController.text.trim()),
                isEnabled: isButtonEnabled,
              ),
            ],
          ),
        ),
      );
    }),
  );
}

void setUsernameAndCloseDialog(BuildContext context, String username) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(AppStrings.usernameKey, username);

  Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
      MaterialPageRoute(builder: (BuildContext context) => EventList()),
      (Route<dynamic> route) => false);
}

Future<String> getUsername(BuildContext context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? username = prefs.getString(AppStrings.usernameKey);

  if (username == null) {
    askUserForName(context);
    return "";
  } else {
    return username;
  }
}
