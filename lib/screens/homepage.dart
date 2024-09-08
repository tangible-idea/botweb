
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayers/screens/normal_message_screen.dart';
import 'package:prayers/styles/my_color.dart';
import '../widgets/fab_group.dart';
import 'group_view.dart';
import 'message_form.dart';
import 'target_message_screen.dart';

final tabIndexProvider = StateProvider((ref) => 0);
final roomTagProvider = StateProvider<String>((ref) => '');

String globalRoomTag = '';

class MyHomePage extends ConsumerStatefulWidget {
  static String id = "/home";

  MyHomePage({super.key, this.title, this.roomTag}) {
    //gptUtils.initGPT();

  }

  //final GPTUtils gptUtils= GPTUtils();
  // final AIUtils aiUtils= AIUtils();
  // final FlutterInsta flutterInsta= FlutterInsta();
  final String? title;
  final String? roomTag;


  Future<List<int>> _readDocumentData(String name) async {
    File inputFile= File(name);
    Uint8List bytes = inputFile.readAsBytesSync();
    return bytes;
  }


  // store clipboard data
  String currClipboard= "";

  getClipboardData() async {
    ClipboardData? data = await Clipboard.getData('text/plain');
    currClipboard= data?.text.toString() ?? "";
    //ref.read(messageProvider.notifier).state= currClipboard;
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends ConsumerState<MyHomePage> with SingleTickerProviderStateMixin {
  late TabController controller;
  late String roomTag; // 방 id

  @override
  void initState() {
    super.initState();

    roomTag = widget.roomTag ?? "";

    controller= TabController(length: 4, vsync: this);
    controller.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    controller.removeListener(_handleTabSelection);
    controller.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    if (controller.indexIsChanging) {
      ref.read(tabIndexProvider.notifier).state = controller.index;
    }
  }

  @override
  Widget build(BuildContext context) {

    globalRoomTag= roomTag;

      //ref.read(roomTagProvider.notifier).state = roomTag;

      //final groupNameAsyncValue = ref.watch(groupNameProvider(roomTag));
      //final name= ref.watch(onBoardingNameProvider);
      final tabIndex = ref.watch(tabIndexProvider);

      // Ensure the TabController is in sync with the provider
      if (controller.index != tabIndex) {
        controller.index = tabIndex;
      }

      // for tabs
      return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: MyColor.kPrimary,
          unselectedItemColor: MyColor.kGrayedPrimary,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          type: BottomNavigationBarType.fixed,
          onTap: (int index) {
            //ref.read(tabIndexProvider.notifier).update((state) => index);
            controller.animateTo(index);
          },
      currentIndex: controller.index,
      backgroundColor: MyColor.kLightBackground,
      items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.groups),
              label: "그룹"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_important_outlined),
            label: "미션공지"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_add),
            label: "일반공지"
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "프로필"
          ),
        ],),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: const GroupViewFAB(),
      body: TabBarView(
        controller: controller,
        children: [
          GroupView(roomTag),
          TargetMessageScreen(roomTag),
          NormalMessageScreen(roomTag),
          const MessageForm(),
                  ],
                )
      );

  }
}

