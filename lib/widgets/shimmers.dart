
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomWidget extends StatelessWidget {

  final double? width;
  final double? height;
  final ShapeBorder shapeBorder;

  const CustomWidget.rectangular({super.key,
    required this.width,
    required this.height,
    this.shapeBorder = const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
  });

  const CustomWidget.circular({super.key,
    required this.width ,
    required this.height,
    this.shapeBorder = const CircleBorder()
  });

  @override
  Widget build(BuildContext context)  => Shimmer.fromColors(
    baseColor: const Color(0x99BBBBBB),
    highlightColor: const Color(0x88DDDDDD),
    period: const Duration(milliseconds: 500),
    child: Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: Colors.grey[400]!,
        shape: shapeBorder,

      ),
    ),
  );
}