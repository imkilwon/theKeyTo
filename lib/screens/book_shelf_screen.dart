import 'package:flutter/material.dart';
import 'package:the_key_to/widgets/my_book_widget.dart';

class BookShelfScreen extends StatefulWidget {
  const BookShelfScreen({Key? key}) : super(key: key);

  @override
  State<BookShelfScreen> createState() => _BookShelfScreenState();
}

class _BookShelfScreenState extends State<BookShelfScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("책 장"),
        ),
        body: ListView(
          children: [
            MyBookWidget(),
            MyBookWidget(),
            MyBookWidget(),
            MyBookWidget(),
            MyBookWidget(),
            MyBookWidget(),
            MyBookWidget(),
            MyBookWidget(),
          ],
        ),
      ),
    );
  }
}
