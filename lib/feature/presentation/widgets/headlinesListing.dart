import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/core/utils/appUtils.dart';

import '../../../components/coreComponents/textView.dart';
import '../../../components/resources/appColors.dart';
import '../../../components/resources/fontSize.dart';
import '../../../components/resources/textStyles.dart';
import '../block/news_bloc.dart';
import '../pages/detailView.dart';
import 'headlineTile.dart';

class HeadLinesListing extends StatelessWidget {
  static const String id = 'mainListing';
  final String appTitle;

  const HeadLinesListing({super.key, required this.appTitle});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<NewsBloc>();
    return Column(
      children: [
        AppBar(title: TextView(text: appTitle),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyles.semiBold20Black,
          backgroundColor: AppColors.transparent,
        ),
        Expanded(
            child: BlocConsumer<NewsBloc, NewsState>(
              listener: (context, state) {
                if(state is LoadingState && state.screenId == id && !bloc.listLoadingFlag){
                  bloc.listLoadingFlag = true;
                  context.load;
                }else if(state is SuccessState && state.screenId == id && bloc.listLoadingFlag){
                  bloc.listLoadingFlag = false;
                  context.stopLoader;
                }else if(state is FailureState && state.screenId == id && bloc.listLoadingFlag ){
                  bloc.listLoadingFlag = false;
                  context.stopLoader;
                  context.openFailureDialog(state.errorMsg);
                }
              },
              builder: (context, state) {
                final list = bloc.activeTab == 0 ? bloc.latestArticles : bloc.bookMarks;
                return ListView.separated(
                    padding: const EdgeInsets.all(S.s20),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => HeadlineTile(
                      onBookMarkBtnAction: (status){
                        if(status){
                          bloc.add(RemoveBookMarksEvent(data: list[index],screenId: id));
                        }else{
                          bloc.add(AddBookMarksEvent(data: list[index],screenId: id));
                        }
                      },
                      onTap: (data){
                        bloc.articleDetail = data;
                        context.pushNavigator(const DetailView());
                      },
                      data: list[index],
                    ),
                    separatorBuilder: (context, index) =>
                    const SizedBox(height: S.s20,),
                    itemCount: list.length);
              },
            )
        )
      ],
    );
  }
}
