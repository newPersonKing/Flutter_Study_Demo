
import 'package:first_flutter_app/res/colors.dart';
import 'package:first_flutter_app/res/styles.dart';
import 'package:first_flutter_app/util/image_utils.dart';
import 'package:flutter/material.dart';

class StoreSelectTextItem extends StatelessWidget{

  StoreSelectTextItem({
    Key key,
    this.ontap,
    @required this.title,
    this.content,
    this.textStyle, style
  });

  GestureTapCallback ontap;
  String title;
  String content;
  TextAlign textAlign;
  TextStyle textStyle;


  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: ontap,
      child: Container(
        height: 50.0,
        margin: const EdgeInsets.only(right: 8.0,left: 16.0),
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border(
              bottom: Divider.createBorderSide(context, color: Colours.line, width: 0.6),
            )
        ),
        child: Row(
          children: <Widget>[
            Text(
              title,
              style: TextStyles.textDark14,
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 16.0),
                child: Text(
                  content,
                  maxLines: 2,
                  textAlign: textAlign,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle ?? TextStyles.textDark14,
                ),
              ),
            ),
            loadAssetImage("ic_arrow_right",
              height: 16.0,
              width: 16.0,
            )
          ],
        ),
      ),
    );
  }
}