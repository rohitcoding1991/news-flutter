import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../components/coreComponents/bookMarkBtn.dart';
import '../../../components/coreComponents/imageView.dart';
import '../../../components/coreComponents/tapGesture.dart';
import '../../../components/coreComponents/textView.dart';
import '../../../components/resources/constants.dart';
import '../../../components/resources/fontSize.dart';
import '../../../components/resources/textStyles.dart';
import '../../domain/entities/articleEntity.dart';
class HeadlineTile extends StatelessWidget {
  final ArticleEntity data;
  final Function(ArticleEntity) onTap;
  final Function(bool) onBookMarkBtnAction;
  const HeadlineTile({super.key, required this.data, required this.onTap, required this.onBookMarkBtnAction});

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
         Row(
          children: [
            ImageView(
              url: data.urlToImage ?? '',
              imageType: ImageType.network,
              size: 100,
              margin: const EdgeInsets.only(right: S.s10),
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextView(
                            text: data.sourceName ?? '',
                          textStyle: TextStyles.regular12Hint,
                          margin: EdgeInsets.only(right: S.s20),
                        ),
                      ),
                    ],
                  ),
                  TextView(
                      text: data.title ?? '',
                    textStyle: TextStyles.medium14Black,
                    maxlines: 3,
                    margin: const EdgeInsets.symmetric(vertical: 2),
                  ),
                  Visibility(visible: data.author != null && data.author!.trim().isNotEmpty,
                    child: TextView(text: 'By ${data.author ?? ''}',
                      textStyle: TextStyles.regular12Hint,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Positioned.fill(child: TapGesture(
          onTap: !data.isArticleRemoved ? ()=> onTap(data) : null,
        )),
        Visibility(
          visible: !data.isArticleRemoved,
          child: Positioned(top: 0, right: 0,
              child: BookMarkBtn(onTap: ()=> onBookMarkBtnAction(data.bookMarked ?? false), status: data.bookMarked ?? false)),
        )
      ],
    );
  }
}
