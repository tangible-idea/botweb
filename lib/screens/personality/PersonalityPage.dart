import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayers/data/api/analyze_whole_messages.dart';
import 'package:prayers/riverpod/message_statistics_provider.dart';
import 'package:prayers/screens/homepage.dart';
import 'package:prayers/styles/txt_style.dart';
import 'package:prayers/widgets/avatar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../constants/app_sizes.dart';
import '../../widgets/shimmers/shimmers_people.dart';
import '../routing/app_router.dart';

final isAnalyzingProvider = StateProvider<bool>((ref) => false);

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

  void _createPersonalityFile(WidgetRef ref, BuildContext context, String userName) async {

    Fluttertoast.showToast(
      msg: '분석이 시작 됐습니다.\n메세지 양에 따라, 약 10-20초 정도 소요됩니다.',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0
    );
    ref.read(isAnalyzingProvider.notifier).state= true; // loading done.

    var response= await analyzeWholeMessage(roomTag, senderKey, userName);

    ref.read(isAnalyzingProvider.notifier).state= false; // loading done.
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userStat= ref.watch(messageStatisticsProvider(senderKey));
    final isWorking= ref.watch(isAnalyzingProvider);

    var userName= "";

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _goBack(context, ref);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('분석'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => _goBack(context, ref),
          ),
        ),
        body: Column(
          children: [
            userStat.when(data: (userData) {

              // 받은 유저 이름 기록.
              //ref.read(userNameProvider.notifier).state = userData?.sender ?? "";
              userName= userData?.sender ?? "";

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

            const Divider(),
            gapW16,
            Expanded(
              child: FutureBuilder<String?>(
                future: _fetchPersonalityFile(context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (isWorking) {
                    return const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("분석 중!\n메세지 양에 따라,\n약 10-20초 정도 소요됩니다. \n "),
                        Center(child: CircularProgressIndicator()),
                      ],
                    );
                  }  else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return Markdown(data: snapshot.data!);
                  } else {
                    return Center(
                      child: ElevatedButton(
                        onPressed: () => {
                          _createPersonalityFile(ref, context, userName)
                        },
                        child: const Text('성격 분석하기'),
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