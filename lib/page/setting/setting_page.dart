
import 'package:first_flutter_app/page/setting/update_dialog.dart';
import 'package:first_flutter_app/res/styles.dart';
import 'package:first_flutter_app/router/fluro_navigator.dart';
import 'package:first_flutter_app/widgets/app_bar.dart';
import 'package:first_flutter_app/widgets/click_item.dart';
import 'package:flutter/material.dart';

import 'exit_dialog.dart';
import 'setting_router.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: "设置",
      ),
      body: Column(
        children: <Widget>[
          Gaps.vGap5,
          ClickItem(
            title: "账号管理",
            onTap: (){
              NavigatorUtils.push(context, SettingRouter.accountManagerPage);
            }
          ),
          ClickItem(
            title: "清除缓存",
            content: "23.5MB",
            onTap: (){}
          ),
          ClickItem(
            title: "检查更新",
            onTap: (){
              _showUpdateDialog();
            }
          ),
          ClickItem(
            title: "关于我们",
            onTap: (){
              NavigatorUtils.push(context, SettingRouter.aboutPage);
            }
          ),
          ClickItem(
            title: "退出当前账号",
            onTap: (){
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => ExitDialog()
              );
            }
          ),
        ],
      ),
    );
  }

  void _showUpdateDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return UpdateDialog();
        }
    );
  }
}
