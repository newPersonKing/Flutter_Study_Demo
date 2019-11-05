import 'package:first_flutter_app/res/colors.dart';
import 'package:first_flutter_app/res/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


/*自定义Appbar 需要继承PreferredSizeWidget*/
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{

  const CustomAppBar({
    Key key,
    this.backgroundColor: Colors.white,
    this.title: "",
    this.centerTitle: "",
    this.actionName: "",
    this.backImg: "assets/images/ic_back_black.png",
    this.onPressed,
    this.isBack: true
  }): super(key: key);

  final Color backgroundColor;
  final String title;
  final String centerTitle;
  final String backImg;
  final String actionName;
  final VoidCallback onPressed;
  final bool isBack;

  @override
  Widget build(BuildContext context) {

    SystemUiOverlayStyle _overlayStyle = ThemeData.estimateBrightnessForColor(backgroundColor) == Brightness.dark
        ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;
    /*AnnotatedRegion 修改树上的一些配置 比如在这个区域 会使用自己设置_overlayStyle*/
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _overlayStyle,
      child: Material(
        color: backgroundColor,
        child: SafeArea(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,/*垂直居中*/
                  children: <Widget>[
                    Container(
                      alignment: centerTitle.isEmpty ? Alignment.centerLeft:Alignment.center,
                      width: double.infinity,
                      child: Text(
                          title.isEmpty ? centerTitle : title,
                          style: TextStyle(
                            fontSize: Dimens.font_sp18,
                            color: _overlayStyle == SystemUiOverlayStyle.light ? Colors.white : Colours.text_dark,
                          )
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 48.0),
                    )
                  ],
                ),
                isBack ? IconButton(
                    icon: Image.asset(backImg),
                    onPressed: (){

                    }) : SizedBox(),
                Positioned(
                  right: 0.0,
                  child: Theme(
                    data: ThemeData(
                        buttonTheme: ButtonThemeData(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            minWidth: 60.0
                        )
                    ),
                    child: actionName.isEmpty ? Container() :
                    FlatButton(
                      child: Text(actionName),
                      textColor: _overlayStyle == SystemUiOverlayStyle.light ? Colors.white : Colours.text_dark,
                      highlightColor: Colors.transparent,
                      onPressed: onPressed,
                    ),),
                )
              ],
            )
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(48.0);
}

