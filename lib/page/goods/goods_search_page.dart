

import 'package:first_flutter_app/util/toast.dart';
import 'package:first_flutter_app/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class GoodsSearch extends StatefulWidget {
  @override
  _GoodsSearchState createState() => _GoodsSearchState();
}

class _GoodsSearchState extends State<GoodsSearch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBar(
        hintText: "请输入商品名称查询",
        onPressed: (text){
          Toast.show("搜索内容：$text");
        },
      ),
      body: Container(
      ),
    );
  }
}
