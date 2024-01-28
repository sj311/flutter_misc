import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_misc/mixin/alert_dialogs.dart';
import 'package:flutter_misc/pages/file_log_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with ConfirmationDialogMixin {
  @override
  void initState() {
    super.initState();
  }

// 함수 추가: 새로운 페이지로 이동
  void _navigateToPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //file log page
            ElevatedButton(
              onPressed: () => _navigateToPage(const FileLogPage()),
              child: const Text('File Log Test'),
            ),
            SizedBox(height: 20),

            //confirm
            ElevatedButton(
              onPressed: () async {
                var a = await showConfirmation(
                    contents: '확인할래요?',
                    onOk: () {
                      print('ok~~~~~~~~~~~~');
                    });
                print('>>>>> ${a == "ok" ? "result is ok" : "cancel"}');
              },
              child: const Text('Confirm 팝업'),
            ),

            //alert
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                var a = await showAlert(contents: '으응?');
                print('>>>> ${a}');
              },
              child: const Text('Alert 팝업'),
            ),

			//alert
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () async {
                var a = await showAlert(contents: '으응?', title: '이거슨 타이틀~');
                print('>>>> ${a}');
              },
              child: const Text('Alert With Title'),
            ),
          ],
        ),
      ),
    );
  }
}
