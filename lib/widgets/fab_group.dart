import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayers/styles/my_color.dart';

import '../constants/fab_actions.dart';

// Define a provider to track the clicked FAB using the enum
final clickedFabProvider = StateProvider<FABAction>((ref) => FABAction.viewStatus);

class GroupViewFAB extends ConsumerWidget {
  const GroupViewFAB({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the provider to listen for changes in the clicked FAB
    final clickedFab = ref.watch(clickedFabProvider);

    return ExpandableFab(
      type: ExpandableFabType.up,
      childrenAnimation: ExpandableFabAnimation.none,
      distance: 70,
      overlayStyle: ExpandableFabOverlayStyle(
        color: MyColor.kGrayedPrimary.withOpacity(0.25),
      ),
      children: [
        _buildActionRow(context, ref, FABAction.lastConversation),
        _buildActionRow(context, ref, FABAction.viewStatus),
        _buildActionRow(context, ref, FABAction.viewContent),
        _buildActionRow(context, ref, FABAction.activityRank),
      ],
    );
  }

  // Helper function to build an action row using the FABAction enum
  Row _buildActionRow(BuildContext context, WidgetRef ref, FABAction action) {
    return Row(
      children: [
        Text(action.label), // Using the label from the enum extension
        const SizedBox(width: 20),
        FloatingActionButton.small(
          heroTag: action.toString(),
          onPressed: () {
            ref.read(clickedFabProvider.notifier).state = action;
          },
          child: Icon(action.icon), // Using the icon from the enum extension
        ),
      ],
    );
  }
}