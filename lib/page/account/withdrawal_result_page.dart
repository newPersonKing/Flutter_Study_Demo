
import 'package:first_flutter_app/res/styles.dart';
import 'package:first_flutter_app/router/fluro_navigator.dart';
import 'package:first_flutter_app/util/image_utils.dart';
import 'package:first_flutter_app/widgets/MyButton.dart';
import 'package:first_flutter_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';

class WithdrawalResultPage extends StatefulWidget {
  @override
  _WithdrawalResultPageState createState() => _WithdrawalResultPageState();
}

class _WithdrawalResultPageState extends State<WithdrawalResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "提现结果",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Gaps.vGap50,
            loadAssetImage("account/sqsb",
              width: 80.0,
              height: 80.0,
            ),
            Gaps.vGap12,
            Text(
              "提现申请提交失败，请重新提交",
              style: TextStyles.textDark16,
            ),
            Gaps.vGap8,
            Text(
              "2019-02-21 15:20:10",
              style: TextStyles.textGray12,
            ),
            Gaps.vGap8,
            Text(
              "5秒后返回提现页面",
              style: TextStyles.textGray12,
            ),
            Gaps.vGap12,
            Gaps.vGap12,
            MyButton(
              onPressed: (){
                NavigatorUtils.goBack(context);
              },
              text: "返回",
            )
          ],
        ),
      ),
    );
  }
}
