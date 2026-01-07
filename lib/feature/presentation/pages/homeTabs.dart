import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../block/news_bloc.dart';
import '../widgets/bottomNavBar.dart';
import 'bookMarksView.dart';
import 'headlinesView.dart';

class HomeTabs extends StatelessWidget {
  const HomeTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<NewsBloc>();
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                return bloc.activeTab == 0 ? HeadlinesView() : BookMarksView();
              },
            ),
          ),
          bottomNavigationBar:
          BottomNavBar(onTap: (index) => bloc.add(ChangeTabEvent(index: index)),
            activeIndex: bloc.activeTab,
          ),
        );
      },
    );
  }
}
