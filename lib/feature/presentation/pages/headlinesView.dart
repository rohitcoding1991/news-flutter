import 'package:flutter/material.dart';

import '../widgets/headlinesListing.dart';

class HeadlinesView extends StatelessWidget {
  const HeadlinesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const HeadLinesListing(appTitle: 'News App');
  }
}
