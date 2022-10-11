import 'package:flutter/material.dart';
import 'package:the_key_to/widgets/display_book_widget.dart';

class EntranceExamScreen extends StatefulWidget {
  const EntranceExamScreen({Key? key}) : super(key: key);

  @override
  State<EntranceExamScreen> createState() => _EntranceExamScreenState();
}

class _EntranceExamScreenState extends State<EntranceExamScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DisplayBookWidget(),
          DisplayBookWidget(),
          DisplayBookWidget(),
          DisplayBookWidget(),
          DisplayBookWidget(),
          DisplayBookWidget(),
          DisplayBookWidget(),
          DisplayBookWidget(),
          DisplayBookWidget(),
          DisplayBookWidget(),
          DisplayBookWidget(),
          DisplayBookWidget(),
          DisplayBookWidget(),
          DisplayBookWidget(),
        ],
      ),
    );
  }
}
