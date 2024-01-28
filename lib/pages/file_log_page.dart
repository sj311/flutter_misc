import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_misc/file_logger.dart';
import 'package:flutter_misc/mixin/build_floating_action.dart';

class FileLogPage extends StatefulWidget {
  const FileLogPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<FileLogPage> createState() => _FileLogPageState();
}

class _FileLogPageState extends State<FileLogPage> with BuilderFloatingActions {
  int _fileSize = 0;
  int _lineCount = 0;
  String _firstFiveLines = '';

  @override
  void initState() {
    super.initState();
    gdefaultFileLogger.init();
    gdefaultFileLogger.setFileLimit(1024 * 500, 1024 * 1024);
    _readLogStatus();
  }

  Future<void> _readLogStatus() async {
    List<String> loadedLogs =
        (await gdefaultFileLogger.readLogs()).reversed.toList();

    File file = File(await FileLogger.getDefaultLogPath());
    int currentSize = await file.length();

    setState(() {
      _lineCount = loadedLogs.length;
      _fileSize = currentSize;
      _firstFiveLines = _firstFiveLines = loadedLogs
          .take(5)
          .map((line) => truncateToMaxLength(line, 100))
          .join('\n');
    });
  }

  void _incrementCounter() async {
    for (int i = 1; i <= 1000; i++) {
      gdefaultFileLogger.log(
          '[${i + _lineCount} ] this is sample log, ${generateDummyString(300)}');
    }
    await gdefaultFileLogger.waitLogFin();
    _readLogStatus();
  }

  void _truncateFile() async {
    await gdefaultFileLogger.truncateFile(0);
    _readLogStatus();
  }

  void _truncateTest() async {
    await gdefaultFileLogger.truncateFile(500, 1000);
    _readLogStatus();
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
        // Here we take the value from the FileLogPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('File Log Test'),
      ),
      body: Stack(
        children: [
          Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              //
              // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
              // action in the IDE, or press "p" in the console), to see the
              // wireframe for each widget.
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Last 5 lines:',
                ),
                Text(_firstFiveLines),
                Text(
                  'fileSize: ${(_fileSize / 1024).toInt()}K ($_fileSize bytes)',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  'lineCount: $_lineCount',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),

          // floating actions
          buildFloatingActions(child:Row(
			crossAxisAlignment: CrossAxisAlignment.end, // 자식들을 우측 정렬
			mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildFloatingActionButton(
                  icon: Icons.add,
                  text: '더미',
                  onPressed: _incrementCounter),
              buildFloatingActionButton(
                  icon: Icons.refresh,
                  text: 'Refresh',
                  onPressed: _readLogStatus),
              buildFloatingActionButton(
                  icon: Icons.settings,
                  text: 'test',
                  onPressed: _truncateTest),
              buildFloatingActionButton(
                  icon: Icons.add, text: 'clear', onPressed: _truncateFile),
            ],
          ))
        ],
      ),
    //   floatingActionButton: Column(
    //     mainAxisAlignment: MainAxisAlignment.end,
    //     children: [
    //       FloatingActionButton(
    //         onPressed: _incrementCounter,
    //         tooltip: 'Increment',
    //         child: const Icon(Icons.add),
    //       ),
    //       const SizedBox(height: 16),
    //       FloatingActionButton(
    //         onPressed: _readLogStatus,
    //         tooltip: 'Refresh',
    //         child: const Icon(Icons.refresh),
    //       ),
    //       const SizedBox(height: 16),
    //       FloatingActionButton(
    //         onPressed: _truncateTest,
    //         tooltip: 'trancate to 500, 1000',
    //         child: const Icon(Icons.settings),
    //       ),
    //       const SizedBox(height: 16),
    //       FloatingActionButton(
    //         onPressed: _truncateFile,
    //         tooltip: 'clear',
    //         child: const Icon(Icons.delete),
    //       ),
    //     ],
    //   ),
    );
  }
}

String generateDummyString(int length) {
  // ASCII 문자를 사용하여 더미 문자열 생성
  List<int> charCodes = List.generate(length, (index) => 65 + (index % 26));
  String dummyString = String.fromCharCodes(charCodes);

  return dummyString;
}

String truncateToMaxLength(String input, int maxLength) {
  // 문자열을 주어진 최대 길이로 자름
  return input.length <= maxLength ? input : input.substring(0, maxLength);
}
