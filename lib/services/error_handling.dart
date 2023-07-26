import 'package:flutter/material.dart';

class ErrorHandler {
  static String errorMessage = '';
  SnackBar snackbar = SnackBar(content: Text(errorMessage));

  var userAuthErrors = {
    'user-not-found': 'No user found for that email',
    'invalid_username': 'Please use a valid username',
    'wrong-password': 'Please use a valid password',
    'invalid-email': 'Please use a valid email',
    'taken_username': 'That username is already taken',
    'email-already-in-use': 'That email is already in use',
    'weak-password': 'Please use a stronger password',
    'mismatch-password': 'Your passwords do not match',
    'default': 'Something went wrong'
  };

  var postErrors = {
    'event_fail': 'Unable to save event',
    'flyer_fail': 'Unable to save image',
    'blog_fail': 'Unable to save blog',
    'default': 'Failed to post'
  };

  var fetchErrors = {
    'event_fail': 'Unable to get events',
    'flyer_fail': 'Unable to get flyers',
    'blog_fail': 'Unable to get blogs',
    'default': 'unable to fetch request'
  };

  String userAuthErrorMessage(String errorType, BuildContext context) {
    errorMessage = userAuthErrors[errorType] ?? userAuthErrors['default']!;
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    return errorMessage;
  }

  String postReqMessage(String errorType, BuildContext context) {
    errorMessage = postErrors[errorType] ?? postErrors['default']!;
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
    return errorMessage;
  }

  String fetchReqMessage(String errorType) {
    errorMessage = fetchErrors[errorType] ?? fetchErrors['default']!;
    print(errorMessage);
    //ScaffoldMessenger.of(context).showSnackBar(snackbar);
    return errorMessage;
  }

  customMessage(String message, BuildContext context) {
    errorMessage = message;
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
