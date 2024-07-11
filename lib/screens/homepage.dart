
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prayers/constants/app_sizes.dart';
import 'package:prayers/data/api/send_message.dart';
import 'package:prayers/screens/routing/app_router.dart';
import 'package:prayers/styles/my_color.dart';
import 'package:prayers/styles/txt_style.dart';
import 'package:prayers/widgets/avatar.dart';
import '../riverpod/room_name_notifier.dart';
import 'default_layout.dart';
import 'group_view.dart';
import 'message_form.dart';
import 'message_screen.dart';

final tabIndexProvider = StateProvider((ref) => 0);

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

      //final groupNameAsyncValue = ref.watch(groupNameProvider(roomTag));
      //final name= ref.watch(onBoardingNameProvider);
      final tabIndex = ref.watch(tabIndexProvider);

      // Ensure the TabController is in sync with the provider
      if (controller.index != tabIndex) {
        controller.index = tabIndex;
      }

      // for tabs
      return DefaultLayout(
          title: "",
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
      items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups),
            label: "Group"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.church),
            label: "Church"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile"
          ),
        ],),
        fab: FloatingActionButton(
          onPressed: ()=> {},
          tooltip: 'tooltip',
          child: const Icon(Icons.add),
        ),
      body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TabBarView(
                controller: controller,
                children: [
                  MessageScreen(roomTag),
                  GroupView(roomTag),
                  const MessageForm(),
                  const Placeholder(),
            ],
          )
        )
      );

  }
}

