import 'package:flutter/material.dart';
import 'package:the_key_to/widgets/display_book_widget.dart';

class CoverLetterScreen extends StatefulWidget {
  const CoverLetterScreen({Key? key}) : super(key: key);

  @override
  State<CoverLetterScreen> createState() => _CoverLetterScreenState();
}

class _CoverLetterScreenState extends State<CoverLetterScreen> {
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
