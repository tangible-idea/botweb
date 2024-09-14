
import 'package:flutter/material.dart';
import 'package:prayers/constants/app_sizes.dart';
import 'package:prayers/styles/my_color.dart';
import 'package:prayers/styles/txt_style.dart';
import 'package:prayers/widgets/shimmers/shimmers.dart';

class RoundedPeopleIndicator extends StatelessWidget {
  final int peopleCount;

  // Constructor to accept number of people
  const RoundedPeopleIndicator({super.key, required this.peopleCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
        color: MyColor.kGold2, // Background color similar to the image
        borderRadius: BorderRadius.circular(10), // Rounded border
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.person,
            size: 16,
            color: MyColor.kAccent2, // Icon color
          ),
          gapW4, // Spacing between the icon and text
            Text(
              "$peopleCount", // Display the number of people
              style: FigmaTextStyles.content12, // Text color
            )
        ],
      ),
    );
  }
}