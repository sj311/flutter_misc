import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//confirm 및 alert 대화 상자 보이기
// await로 종료를 기다릴수 있다.
mixin ConfirmationDialogMixin<T extends StatefulWidget> on State<T> {
  //
  //alert보임, await로 종료를 기다릴수 있음, 버튼 눌릴때 콜백은 별도로 없음.
  @protected
  Future<dynamic> showAlert({required String contents, String? title}) {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: Text(
            contents,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Clear 동작 수행
                Navigator.pop(context); // 다이얼로그 닫기
              },
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.titleMedium,
              ),
              child: Text(AppLocalizations.of(context)!.btnYes),
            ),
          ],
        );
      },
    );
  }

  //confirm 대화상자, ok click시의 callback 있음, 
  //await로 기다릴시, ok click 'ok' 리턴  result == 'ok' 이것으로 비교하면됨.
  @protected
  Future<dynamic> showConfirmation(
      {String? title, required String contents, VoidCallback? onOk}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: title != null ? Text(title) : null,
          content: Text(
            contents,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // 다이얼로그 닫기
              },
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.titleMedium,
              ),
              child: Text(AppLocalizations.of(context)!.btnNo),
            ),
            TextButton(
              onPressed: () {
                // Clear 동작 수행
                Navigator.pop(context, 'ok'); // 다이얼로그 닫기
                if(onOk != null){
					onOk();
				}
              },
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.titleMedium,
              ),
              child: Text(AppLocalizations.of(context)!.btnYes),
            ),
          ],
        );
      },
    );
  }
}
