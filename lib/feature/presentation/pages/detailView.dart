import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/core/utils/appUtils.dart';
import 'package:news_flutter/core/utils/dateTimeUtils.dart';

import '../../../components/coreComponents/appButton.dart';
import '../../../components/coreComponents/bookMarkBtn.dart';
import '../../../components/coreComponents/imageView.dart';
import '../../../components/coreComponents/textView.dart';
import '../../../components/resources/appColors.dart';
import '../../../components/resources/constants.dart';
import '../../../components/resources/fontSize.dart';
import '../../../components/resources/textStyles.dart';
import '../block/news_bloc.dart';
import 'fullArticleView.dart';

class DetailView extends StatelessWidget {
  static const String id = 'DetailView';
  const DetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<NewsBloc>();
    return Scaffold(
      appBar: appBar(bloc),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(S.s20),
        child: BlocConsumer<NewsBloc, NewsState>(
          listener: (context, state) {
            if(state is LoadingState && state.screenId == id ){
              context.load;
            }else if(state is SuccessState && state.screenId == id ){
              context.stopLoader;
            }else if(state is FailureState && state.screenId == id){
              context.stopLoader;
              context.openFailureDialog(state.errorMsg);
            }
          },
          builder: (context, state) {
            final data = bloc.articleDetail;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageView(
                  url: data?.urlToImage ?? '',
                  height: 200,
                  imageType: ImageType.network,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),

                TextView(
                  text: data?.title ?? '',
                  textStyle: TextStyles.semiBold16Black,
                  margin: const EdgeInsets.symmetric(vertical: S.s20),
                ),
                TextView(
                  text: data?.description ?? '',
                  textStyle: TextStyles.regular14Charcoal,
                ),

                AppButton(
                  onTap: () =>
                      context.pushNavigator(
                          FullArticleView(url: bloc.articleDetail?.url ?? '',)),
                  label: 'Read full article',
                  margin: const EdgeInsets.only(top: S.s40),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  AppBar appBar(NewsBloc bloc) {
    return AppBar(
      elevation: 0,
      iconTheme: const IconThemeData(
          color: AppColors.black
      ),
      backgroundColor: AppColors.transparent,
      titleTextStyle: TextStyles.regular10GreyText,
      centerTitle: true,
      title: Column(
        children: [
          const TextView(
            text: 'Detail News', textStyle: TextStyles.semiBold16Black,),
          BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              return TextView(
                  text: bloc.articleDetail?.publishedAt?.EEEEc_MMM_ddc_yyyy ??
                      '');
            },
          ),
        ],
      ),

      actions: [
        Padding(
          padding: const EdgeInsets.only(right: S.s16),
          child: Center(child: BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              return BookMarkBtn(onTap: () {
                if (bloc.articleDetail?.bookMarked ?? false) {
                  bloc.add(RemoveBookMarksEvent(data: bloc.articleDetail!,screenId: id));
                } else {
                  bloc.add(AddBookMarksEvent(data: bloc.articleDetail!,screenId: id));
                }
              }, status: bloc.articleDetail?.bookMarked ?? false);
            },
          )),
        )
      ],
    );
  }
}