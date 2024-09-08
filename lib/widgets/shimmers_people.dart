import 'package:flutter/material.dart';
import 'package:prayers/widgets/shimmers.dart';
import 'package:prayers/widgets/shimmers_avatar.dart';

class RepeatedShimmerList extends StatelessWidget {
  const RepeatedShimmerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(10, (index) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),  // Optional: Adds spacing between items
          child: Row(
            children: [
              ShimmersAvatar(),
              SizedBox(width: 8),  // Equivalent to gapW8
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomWidget.rectangular(width: 100, height: 30),
                  SizedBox(height: 4),  // Equivalent to gapH4
                  CustomWidget.rectangular(width: 200, height: 20),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}