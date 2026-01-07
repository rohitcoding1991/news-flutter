import 'package:flutter/material.dart';

import '../../../components/coreComponents/imageView.dart';
import '../../../components/resources/appColors.dart';
import '../../../components/resources/appIcons.dart';
import '../../../components/resources/fontSize.dart';

const List<Map<String,dynamic>> _list = [
  {
    'icon': AppIcons.home,
    'index':0
  },
  {
    'icon': AppIcons.bookMark,
    'index':1
  }
];

class BottomNavBar extends StatelessWidget {
  final int activeIndex;
  final Function(int) onTap;
  const BottomNavBar({super.key, required this.activeIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:  S.s10,
        bottom: S.s10 + MediaQuery.of(context).padding.bottom
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _list.map((data) => _tab(data)).toList(),
      ),
    );
  }

  Widget _tab(Map<String,dynamic> data){
    return ImageView(
      onTap: ()=> onTap(data['index']),
      tintColor: data['index'] == activeIndex ? AppColors.black : AppColors.grey50,
      url: data['icon'], size: S.s24,);
  }
}
