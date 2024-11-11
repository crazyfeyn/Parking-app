import 'package:flutter/material.dart';

extension SizedBoxExtention on int {
  Widget hs() {
    return SizedBox(
      height: toDouble(),
    );
  }

  Widget ws() {
    return SizedBox(
      width: toDouble(),
    );
  }
}
