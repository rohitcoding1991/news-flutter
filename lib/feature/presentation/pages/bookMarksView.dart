import 'package:flutter/material.dart';

import '../widgets/headlinesListing.dart';

class BookMarksView extends StatelessWidget {
  const BookMarksView({super.key});

  @override
  Widget build(BuildContext context) {
    return const HeadLinesListing(
        appTitle: 'Book Marks',
    );
  }
}