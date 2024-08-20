import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayers/styles/my_color.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


// Define a provider to fetch images
final imageProvider = FutureProvider.family<String, Map<String, String>>((ref, params) async {
  final supabase = Supabase.instance.client;

  final response = await supabase
      .from('kakao_profile')
      .select('image')
      .eq('room_tag', params['room_tag'] as String)
      .eq('sender_key', params['sender_key'] as String).single();

  return response['image'] as String;
});


// Function to convert base64 string to an image widget
Widget base64ToImage(String base64String) {
  Uint8List bytes2 = const Base64Decoder().convert(base64String);
  return Image.memory(bytes2);
}

class Avatar extends ConsumerWidget {
  const Avatar({
    super.key,
    required this.roomTag,
    required this.senderKey,
    required this.radius,
    this.borderColor,
    this.borderWidth,
  });
  final String? roomTag;
  final String? senderKey;
  final double radius;
  final Color? borderColor;
  final double? borderWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = {'room_tag': 'yourRoomTag', 'sender_key': 'yourSenderKey'};
    final imageAsyncValue = ref.watch(imageProvider(params));

    return Container(
      decoration: _borderDecoration(),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: MyColor.kPrimary,
        child: imageAsyncValue.when(
          data: (images) => base64ToImage(images),
          error:(error, stackTrace) => Icon(Icons.camera_alt, size: radius),
          loading: () => Icon(Icons.camera_alt, size: radius)
      ),
    )
    );
  }

  Decoration? _borderDecoration() {
    if (borderColor != null && borderWidth != null) {
      return BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor!,
          width: borderWidth!,
        ),
      );
    }
    return null;
  }
}
