
import 'package:flutter/material.dart';


showWaitingDialog(BuildContext context, {String? text}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        // child: WaitCircularProgress(title: 'Please wait'),
        child: Padding(
          padding: EdgeInsets.only(top: 49, bottom: 39),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              //CircularProgressIndicator(),

              //isFacebook ? Image.asset('assets/images/facebook.png', width: 100, height: 100,): pixaliveLoader(),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.secondary),
                backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.25),
              ),
              SizedBox(
                height: 41,
              ),
              Text(
                text ?? 'Please Wait',
                style: Theme.of(context).textTheme.caption,
              )

            ],
          ),
        ),
      );
    },
  );
}

showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
  ));
}
