import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prayers/screens/routing/app_router.dart';

class PersonalityPage extends ConsumerWidget {
  final String roomTag;
  final String senderKey;

  const PersonalityPage({
    super.key,
    required this.roomTag,
    required this.senderKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _goBack(ref);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Personality'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => _goBack(ref),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Room Tag: $roomTag'),
              Text('Sender Key: $senderKey'),
              // 여기에 추가적인 personality 관련 내용을 구현합니다.
            ],
          ),
        ),
      ),
    );
  }

  void _goBack(WidgetRef ref) {
    // 홈 페이지로 돌아갑니다.
    ref.read(goRouterProvider).goNamed(
      AppRoute.home.name,
      pathParameters: {'room': roomTag},
    );
  }
}