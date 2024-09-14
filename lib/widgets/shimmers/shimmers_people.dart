import 'package:flutter/material.dart';
import 'package:prayers/widgets/shimmers/shimmers.dart';
import 'package:prayers/widgets/shimmers/shimmers_avatar.dart';

class RepeatedShimmerList extends StatelessWidget {
  final int? peopleCount;
  const RepeatedShimmerList({super.key, this.peopleCount});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(peopleCount ?? 10, (index) {
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