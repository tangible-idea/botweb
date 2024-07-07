
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prayers/constants/app_sizes.dart';
import 'package:prayers/screens/routing/app_router.dart';
import 'package:prayers/styles/my_color.dart';
import 'package:prayers/styles/txt_style.dart';
import 'package:prayers/widgets/avatar.dart';
import '../riverpod/room_name_notifier.dart';
import 'default_layout.dart';

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
  }


@override
  Widget build(BuildContext context) {

      final groupNameAsyncValue = ref.watch(groupNameProvider(roomTag));
      //final name= ref.watch(onBoardingNameProvider);
        // for tabs
      final tabIndex= ref.watch(tabIndexProvider);
      // for tabs
      return DefaultLayout(
          title: "",
          bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: MyColor.kPrimary,
          unselectedItemColor: MyColor.kGrayedPrimary,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          type: BottomNavigationBarType.fixed,
          onTap: (int index)
      {
        ref.read(tabIndexProvider.notifier).update((state) => index);
      },
      currentIndex: tabIndex,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          groupNameAsyncValue.when(
                            data: (name) => Text(name ?? '.', style: FigmaTextStyles.title30,),
                            loading: () => const CircularProgressIndicator(),
                            error: (error, stack) => Text('Error: $error'),
                          ),
                        gapH4,
                        const Text("우리 목장: 매주 주일 14시 모임!\n느헤미야 기도 프로젝트 참석해주세요~", style: FigmaTextStyles.content16),
                        gapH48,
                        /// Button1. TODO🎥
                        const Row(children: [
                          Avatar(radius: 30,),
                          gapW16,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("김아영", style: FigmaTextStyles.title26),
                                Text("목자", style: FigmaTextStyles.content16)
                              ],
                            ),
                          ],
                        ),
                        gapH20,
                        const Row(children: [
                          Avatar(radius: 30,),
                          gapW16,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("왕단비", style: FigmaTextStyles.title26),
                              Text("부목자", style: FigmaTextStyles.content16)
                            ],
                          ),
                        ],
                        ),

                      /// Button2. get POE bot
                      Expanded(
                        flex: 1,
                        child: Center(
                        child: IconButton(onPressed: () async {
                      }, icon: const Icon(Icons.golf_course)),
                      ),
                      ),
                  ],
                ),
                  const Placeholder(),
                  const Placeholder(),
                  const Placeholder(),
            ],
          )
        )
      );

  }
}

