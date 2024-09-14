import 'package:flutter/material.dart';

enum FABAction {
  lastConversation, // 마지막 대화
  viewStatus,       // 상태보기
  viewContent,      // 대화내용
  activityRank,     // 활동순위
}

extension FABActionExtension on FABAction {

  String get title {
    switch (this) {
      case FABAction.lastConversation:
        return '마지막대화';
      case FABAction.viewStatus:
        return '유저상태';
      case FABAction.viewContent:
        return '대화내용';
      case FABAction.activityRank:
        return '활동순위';
    }
  }

  String get label {
    switch (this) {
      case FABAction.lastConversation:
        return '각 유저별 마지막 대화를 봅니다.';
      case FABAction.viewStatus:
        return '각 유저별 메시지 개수를 봅니다.';
      case FABAction.viewContent:
        return '각 유저별 대화내용을 봅니다.';
      case FABAction.activityRank:
        return '각 유저별 활동순위를 봅니다.';
    }
  }

  IconData get icon {
    switch (this) {
      case FABAction.lastConversation:
        return Icons.notifications;
      case FABAction.viewStatus:
        return Icons.receipt_long;
      case FABAction.viewContent:
        return Icons.text_fields;
      case FABAction.activityRank:
        return Icons.star;
    }
  }
}