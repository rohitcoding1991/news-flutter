import 'package:flutter/material.dart';

import '../resources/appIcons.dart';
import '../resources/fontSize.dart';
import 'imageView.dart';

class BookMarkBtn extends StatelessWidget {
  final Function() onTap;
  final bool status;
  const BookMarkBtn({super.key, required this.onTap, required this.status});

  @override
  Widget build(BuildContext context) {
    return ImageView(
      onTap: onTap,
      url: status ? AppIcons.bookMarkFill : AppIcons.bookMark,
      size: S.s20,
    );
  }
}
