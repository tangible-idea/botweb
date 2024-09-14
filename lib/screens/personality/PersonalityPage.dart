import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayers/riverpod/message_statistics_provider.dart';
import 'package:prayers/screens/homepage.dart';
import 'package:prayers/styles/txt_style.dart';
import 'package:prayers/widgets/avatar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../constants/app_sizes.dart';
import '../../widgets/shimmers/shimmers_people.dart';
import '../routing/app_router.dart';
class PersonalityPage extends ConsumerWidget {
  final String roomTag;
  final String senderKey;

  const PersonalityPage({
    Key? key,
    required this.roomTag,
    required this.senderKey,
  }) : super(key: key);

  Future<String?> _fetchPersonalityFile(BuildContext context) async {
    final supabase = Supabase.instance.client;
    final String filePath = "$roomTag/$senderKey.md";

    try {
      final bytes = await supabase.storage.from('personality').download(filePath);
      // UTF-8로 디코딩
      return utf8.decode(bytes);
    } catch (e) {
      print('Error fetching file: $e');
      return null;
    }
  }

  void _createPersonalityFile() {
    // TODO: Implement file creation logic
    print('Create personality file');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStat= ref.watch(messageStatisticsProvider(senderKey));

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _goBack(context, ref);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Personality'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => _goBack(context, ref),
          ),
        ),
        body: Column(
          children: [
            userStat.when(data: (userData) {
              return ListTile(
                leading: Avatar(radius: 30, roomTag: globalRoomTag, senderKey: senderKey),
                title: Text(userData?.sender ?? "", style: FigmaTextStyles.title20),
                subtitle: Text("메시지 개수 : ${userData?.messageCount ?? "알수없음"}" +
                            "\n총 단어 개수 : ${userData?.totalWordCount ?? "알수없음"}"
                      ,style: FigmaTextStyles.content12,),
                );
            },
              error: (err, stack) => const Text("error"),
              loading: () => const RepeatedShimmerList(peopleCount: 1)),

            Divider(),
            gapW16,
            Expanded(
              child: FutureBuilder<String?>(
                future: _fetchPersonalityFile(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return Markdown(data: snapshot.data!);
                  } else {
                    return Center(
                      child: ElevatedButton(
                        onPressed: _createPersonalityFile,
                        child: Text('성격 분석하기'),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goBack(BuildContext context, WidgetRef ref) {
    final router = ref.read(goRouterProvider);
    if (router.canPop()) {
      router.pop();
    } else {
      router.goNamed(
        AppRoute.home.name,
        pathParameters: {'room': roomTag},
      );
    }
  }
}