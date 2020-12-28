import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  Function onPressed;
  String label;
  bool showProgress;

  AppButton(this.label, {this.onPressed, this.showProgress = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46,
      child: RaisedButton(
        onPressed: onPressed,
        color: Colors.blue,
        child: showProgress
            ? Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(
                label,
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
      ),
    );
  }
}
