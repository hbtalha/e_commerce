import 'dart:convert';

import 'package:e_commerce/constants/http_status_codes.dart';
import 'package:e_commerce/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandling({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  bool isError = true;
  String msg = '';
  print('StatusCode: ${response.statusCode}');
  switch (response.statusCode) {
    case HTTP_200_OK:
      onSuccess();
      break;
    case HTTP_400_BAD_REQUEST:
      msg = jsonDecode(response.body)['msg'];
      break;
    case HTTP_500_INTERNAL_SERVER_ERROR:
      msg = jsonDecode(response.body)['error'];
      break;
    case HTTP_408_REQUEST_TIMEOUT:
      msg = "request timeout";
      break;
    default:
      msg = response.body;
      isError = false;
  }

  if (response.statusCode != HTTP_200_OK) {
    print('ErrMsg: $msg');
    showSnackBar(context: context, msg: msg, isError: isError);
  }
}
