import 'dart:math';

import 'package:flutter/material.dart';

class Utils{
  String getUid() {
    return (100000 + Random().nextInt(10000)).toString();
  }
}