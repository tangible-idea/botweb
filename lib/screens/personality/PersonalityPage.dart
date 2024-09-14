import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayers/screens/homepage.dart';
import 'package:prayers/widgets/avatar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../../constants/app_sizes.dart';
import '../routing/app_router.dart';

class PersonalityPage extends ConsumerStatefulWidget {
  final String roomTag;
  final String senderKey;

  const PersonalityPage({
    Key? key,
    required this.roomTag,
    required this.senderKey,
  }) : super(key: key);

  @override
  _PersonalityPageState createState() => _PersonalityPageState();
}

class _PersonalityPageState extends ConsumerState<PersonalityPage> {
  Future<String?>? _personalityFuture;

  @override
  void initState() {
    super.initState();
    _personalityFuture = _fetchPersonalityFile();
  }


  Future<String?> _fetchPersonalityFile() async {
    final supabase = Supabase.instance.client;
    final String filePath = "${widget.roomTag}/${widget.senderKey}.md";

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
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        _goBack();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Personality'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: _goBack,
          ),
        ),
        body: Column(
          children: [
            ListTile(
              leading: Avatar(radius: 30, roomTag: globalRoomTag, senderKey: widget.senderKey),
              title: Text(widget.senderKey),
              subtitle: Text(widget.senderKey),
            ),
            Divider(),
            gapW16,
            Expanded(
              child: FutureBuilder<String?>(
                future: _personalityFuture,
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

  void _goBack() {
    final router = ref.read(goRouterProvider);
    if (router.canPop()) {
      router.pop();
    } else {
      router.goNamed(
        AppRoute.home.name,
        pathParameters: {'room': widget.roomTag},
      );
    }
  }
}