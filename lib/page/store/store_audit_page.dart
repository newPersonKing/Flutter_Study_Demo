import 'dart:io';

import 'package:first_flutter_app/page/shop/shop_router.dart';
import 'package:first_flutter_app/page/store/store_router.dart';
import 'package:first_flutter_app/res/styles.dart';
import 'package:first_flutter_app/router/fluro_navigator.dart';
import 'package:first_flutter_app/util/toast.dart';
import 'package:first_flutter_app/widgets/MyButton.dart';
import 'package:first_flutter_app/widgets/app_bar.dart';
import 'package:first_flutter_app/widgets/selected_image.dart';
import 'package:first_flutter_app/widgets/store_select_text_item.dart';
import 'package:first_flutter_app/widgets/text_field_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2d_amap/flutter_2d_amap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:permission/permission.dart';

class StoreAudit extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StoreAuditState();
  }
}

class _StoreAuditState extends State<StoreAudit>{

  File _imageFile;

  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();
  String _address = "陕西省 西安市 雁塔区 高新六路201号";

  KeyboardActionsConfig _config;

  @override
  void initState() {
    _config = _buildConfig();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: CustomAppBar(
        centerTitle:"店铺审核资料",
      ),
      body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(/*Expanded 填充剩余的空间 在row 或者column 中使用*/
                flex: 1,
                child: defaultTargetPlatform == TargetPlatform.iOS ? FormKeyboardActions(
                    child: _buildBody()
                ) : SingleChildScrollView(
                    child: _buildBody()
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
                child: MyButton(
                  onPressed: (){
                    NavigatorUtils.push(context, StoreRouter.auditResultPage);
                  },
                  text: "提交",
                ),
              )
            ],
          )
      ),
    );
  }

  _buildBody(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,/*控制 child 在负轴上 的位置*/
        children: <Widget>[
          Gaps.vGap5,
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: const Text("店铺资料", style: TextStyles.textBoldDark18,), /*这里的内容显示居左 是因为1 Center 撑大了布局 2 设置的负轴居左*/
          ),
          Gaps.vGap16,
          Center(
            child: SelectedImage(
                image: _imageFile,
                onTap: _getImage
            ),
          ),
          Gaps.vGap10,
          const Center(
            child: const Text(
              "店主手持身份证或营业执照",
              style: TextStyles.textGray14,
            ),
          ),
          Gaps.vGap16,
          TextFieldItem(
              focusNode: _nodeText1,
              title: "店铺名称",
              hintText: "填写店铺名称"
          ),
          StoreSelectTextItem(
              title: "主营范围",
              content: _sortName,
              ontap: (){
                _showBottomSheet();
              }
          ),
          StoreSelectTextItem(
              title: "店铺地址",
              content: _address,
              ontap: (){
                NavigatorUtils.pushResult(context, ShopRouter.addressSelectPage, (result){
                  setState(() {
                    PoiSearch model = result;
                    _address = model.provinceName + " " +
                        model.cityName + " " +
                        model.adName + " " +
                        model.title;
                  });
                });
              }
          ),
          Gaps.vGap16,
          Gaps.vGap16,
          const Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: const Text("店主信息", style: TextStyles.textBoldDark18),
          ),
          Gaps.vGap16,
          TextFieldItem(
              focusNode: _nodeText2,
              title: "店主姓名",
              hintText: "填写店主姓名"
          ),
          TextFieldItem(
              focusNode: _nodeText3,
              keyboardActionsConfig: _config,
              textInputType: TextInputType.phone,
              title: "联系电话",
              hintText: "填写店主联系电话"
          )
        ],
      ),
    );
  }

  /*选择图片*/
  _getImage() async{
    try {
      var permissions = await Permission.getPermissionsStatus([ PermissionName.Camera,PermissionName.Sensors]);

      _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 800, imageQuality: 95);
      setState(() {});
    } catch (e) {
      Toast.show("没有权限，无法打开相册！");
    }
  }

  String _sortName = "";
  var _list = ["水果生鲜", "家用电器", "休闲食品", "茶酒饮料", "美妆个护", "粮油调味", "家庭清洁", "厨具用品", "儿童玩具", "床上用品"];

  _showBottomSheet(){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return Container(
            height: 360.0,
            child: ListView.builder(
                itemCount: _list.length,
                itemBuilder: (_,index){
                  return InkWell(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      alignment: Alignment.center,
                      child: Text(_list[index]),
                    ),
                    onTap: (){
                      setState(() {
                        _sortName = _list[index];
                      });
                      NavigatorUtils.goBack(context);
                    },
                  );
                }
            ),
          );
        });
  }

  KeyboardActionsConfig _buildConfig() {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardAction(
          focusNode: _nodeText1,
          displayCloseWidget: false,
        ),
        KeyboardAction(
          focusNode: _nodeText2,
          displayCloseWidget: false,
        ),
        KeyboardAction(
          focusNode: _nodeText3,
          closeWidget: Padding(
            padding: EdgeInsets.all(5.0),
            child: const Text("关闭"),
          ),
        ),
      ],
    );
  }

}