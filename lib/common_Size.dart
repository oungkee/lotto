import 'package:flutter/material.dart';

const double common_h_padding = 16.0;
const double common_w_padding = 10.0;

common_Sized_Heigh() {
  return const SizedBox(
    height: 16.0,
  );
}

common_Sized_Weight() {
  return const SizedBox(
    width: 16.0,
  );
}

String checkNumber(String value) {
  // 숫자 검증.
  RegExp regExp = RegExp(('[0-9]'));
  if (value.isEmpty) {
    return "숫자를 입력 하세요.";
  } else if (!regExp.hasMatch(value)) {
    return "숫자만 입력되어야 합니다.";
  }
  return "검증됨 숫자 입니다.";
}

String validateString(String value) {
  // 문자 검증.
  String patttern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = RegExp(patttern);
  if (value.isEmpty) {
    return "문자를 입력하세요.";
  } else if (!regExp.hasMatch(value)) {
    return "문자만 입력되어야 합니다.";
  }
  return "검증됨 문자 입니다.";
}
