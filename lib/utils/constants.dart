import 'package:flutter/material.dart';
import 'package:the_key_to/screens/account_screen.dart';
import 'package:the_key_to/screens/book_shelf_screen.dart';
import 'package:the_key_to/screens/main_home.dart';
import 'package:the_key_to/screens/more_screen.dart';

List<Widget> screens = [
  MainHome(),
  BookShelfScreen(),
  AccountScreen(),
  MoreScreen(),
];

double appBarHeight = 105;

List<String> notices = [
  '[이벤트] 출시 기념 이벤트! 수수료 할인 적용!',
  '1.0.0 패치 안내',
];
List<String> notices_content = [
  '1[이벤트] 출시 기념 이벤트! 수수료 할인 적용!d[이벤트] 출시 기념 이벤트! 수수료 할인 적용![이벤트] 출시 기념 이벤트! 수수료 할인 적용![이벤트] 출시 기념 이벤트! 수수료 할인 적용n[이벤트] 출시 기념 이벤트! 수수료 할인 적용![이벤트] 출시 기념 이벤트! 수수료 할인 적용![이벤트] 출시 기념 이벤트! 수수료 할인 적용!\n',
  '2[이벤트] 출시 기념 이벤트! 수수료 할인 적용!\n[이벤트] 출시 기념 이벤트! 수수료 할인 적용!\n[이벤트] 출시 기념 이벤트! 수수료 할인 적용!\n[이벤트] 출시 기념 이벤트! 수수료 할인 적용!\n[이벤트] 출시 기념 이벤트! 수수료 할인 적용!\n[이벤트] 출시 기념 이벤트! 수수료 할인 적용!\n[이벤트] 출시 기념 이벤트! 수수료 할인 적용!\n',
];