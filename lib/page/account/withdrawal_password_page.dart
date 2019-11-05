
import 'package:first_flutter_app/page/account/sms_verify_dialog.dart';
import 'package:first_flutter_app/page/account/withdrawal_password_setting_dialog.dart';
import 'package:first_flutter_app/res/styles.dart';
import 'package:first_flutter_app/router/fluro_navigator.dart';
import 'package:first_flutter_app/util/utils.dart';
import 'package:first_flutter_app/widgets/app_bar.dart';
import 'package:first_flutter_app/widgets/base_dialog.dart';
import 'package:first_flutter_app/widgets/click_item.dart';
import 'package:flutter/material.dart';

class WithdrawalPasswordPage extends StatefulWidget {
  @override
  _WithdrawalPasswordPageState createState() => _WithdrawalPasswordPageState();
}

class _WithdrawalPasswordPageState extends State<WithdrawalPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle: "提现密码",
      ),
      body: Column(
        children: <Widget>[
          Gaps.vGap5,
          ClickItem(
            title: "修改密码",
            onTap: (){
              showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return WithdrawalPasswordSettingDialog();
                  }
              );
            }
          ),
          ClickItem(
            title: "忘记密码",
            onTap: (){
              showElasticDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return BaseDialog(
                    hiddenTitle: true,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: const Text("为了您的账户安全需先进行短信验证并设置提现密码。", style: TextStyles.textDark14, textAlign: TextAlign.center),
                    ),
                    onPressed: (){
                      NavigatorUtils.goBack(context);
                      _showVerifyDialog();
                    },
                  );
                }
              );
            }
          ),
        ],
      ),
    );
  }
  
  _showVerifyDialog(){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SMSVerifyDialog();
        }
    );
  }
}
