import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AcceptInviteAlertForm extends StatefulWidget {
  Function onSend;
  AcceptInviteAlertForm({required this.onSend});

  @override
  _AcceptInviteFormSAlertstate createState() =>
      _AcceptInviteFormSAlertstate(onSend: this.onSend);
}

class _AcceptInviteFormSAlertstate extends State<AcceptInviteAlertForm> {
  Function onSend;
  _AcceptInviteFormSAlertstate({required this.onSend});

  final iniviteReplyController = TextEditingController();
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Reply and Accept Invite"),
      content: Container(
        constraints: BoxConstraints(minHeight: 60.0, minWidth: 300.w),
        child: TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: iniviteReplyController,
          decoration: InputDecoration(
            errorText: _validate ? "Reply can't be blank" : null,
            border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: const Color(0xFFCDCFD2), width: 2.0),
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
        TextButton(
          child: Text("Send & Accept"),
          onPressed: () {
            if (iniviteReplyController.text.isEmpty) {
              setState(() {
                _validate = true;
              });
            } else {
              onSend(iniviteReplyController.text);
            }
          },
        ),
      ],
    );
  }
}
