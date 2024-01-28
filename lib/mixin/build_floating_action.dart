import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


//float action 버튼 그룹,
mixin BuilderFloatingActions<T extends StatefulWidget> on State<T> {
  //float action 버튼하고 비슷하게 생긴버튼 리턴
  @protected
  Widget buildFloatingActionButton(
      {IconData? icon, String? text, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16.0),
        elevation: 8.0, // 그림자 높이 조절
      ),
      child: Row(
        children: [
          if(icon != null) Icon(icon),
          if(icon != null && text != null) const SizedBox(width: 8.0), // 아이콘과 텍스트 사이의 간격 조절
          if(text != null) Text(text),
        ],
      ),
    );
  }

  //float action 버튼하고 비슷하게 생긴버튼 리턴
  @protected
  Widget buildFloatingActions(Widget child) {
    return 
        // 부모 우측 하단에 배치되는 자식 위젯
        Positioned(
          right: 16,
          bottom: 16,
        //   right: 16,
          child: child,
        );
  }
}
