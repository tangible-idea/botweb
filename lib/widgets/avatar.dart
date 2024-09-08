import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayers/styles/my_color.dart';
import 'package:prayers/widgets/shimmers_avatar.dart';
import 'package:shimmer/shimmer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

typedef RoomAndSender= ({String roomTag, String senderKey});

// Define a provider to fetch images
final imageProvider = FutureProvider.family<String, RoomAndSender>((ref, params) async {
  final supabase = Supabase.instance.client;

  final response = await supabase.from('kakao_profile')
      .select('image')
      .eq('room_tag', params.roomTag)
      .eq('sender_key', params.senderKey).single();

  final profileImage= response['image'] as String;
  return profileImage;
});


// Function to convert base64 string to an image widget
ImageProvider? base64ToImage(String base64String) {
  try {
    final removeWhitespace = base64String.replaceAll(RegExp(r'\s'), '');
    final bytes2 = base64.decode(removeWhitespace);
    return MemoryImage(bytes2);
  }catch (Exception) {
    return null;
  }
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
    print('imageAsyncValue:: Avatar widget is rebuilding');
    //final params = {'room_tag': roomTag.toString(), 'sender_key': senderKey.toString()};
    final imageAsyncValue = ref.watch(imageProvider((roomTag: roomTag.toString(), senderKey: senderKey.toString())));

    return Container(
      decoration: _borderDecoration(),
      child: imageAsyncValue.when(
        data: (profileImage) {
          print('imageAsyncValue:: Data received: $profileImage');
          return CircleAvatar(radius: radius, backgroundImage: base64ToImage(profileImage));
        },
        error: (error, stackTrace) {
          print('imageAsyncValue:: Error occurred: $error');
          return CircleAvatar(radius: radius,
              child: const Icon(Icons.camera_alt));
        },
        loading: () => const ShimmersAvatar()
      ),
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
