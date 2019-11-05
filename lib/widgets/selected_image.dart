import 'dart:io';

import 'package:first_flutter_app/util/utils.dart';
import 'package:flutter/material.dart';

class SelectedImage extends StatelessWidget{

  const SelectedImage({
    Key key,
    this.size : 80.0,
    this.onTap,
    this.image
  }): super(key: key);

  final double size;
  final GestureTapCallback onTap;
  final File image;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          image: DecorationImage(
            image: image == null ? AssetImage(Utils.getImgPath("store/icon_zj")) : FileImage(image),
            fit: BoxFit.cover,
          )
        ),
      ),
    );
  }
}