

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../styles/my_color.dart';

class ShimmersAvatar extends StatelessWidget {
  const ShimmersAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: MyColor.kGreyB0,
        highlightColor: MyColor.kGrayedPrimary,
        child: const CircleAvatar(radius: 30.0,
        child: Icon(Icons.camera_alt))
    );
  }
}
