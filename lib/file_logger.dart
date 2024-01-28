import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

import 'log_func.dart';

class FileLogger {
  String _logFilePath = '';
  int _minSizeToPreserve = 1 * 1024 * 1024; //1M, 이 크기까지는 보존한다.
  int _allowedMaxSize = 2 * 1024 * 1024; //2M , 잦은 업데이트 방지를 위해 여기 까지는 허용

  Future<void>? _asyncLogFuture;

  init([String? logFilePath]) async {
    _logFilePath = logFilePath ?? await getDefaultLogPath();

    File file = File(_logFilePath);
    if (!await file.exists()) {
      await file.writeAsString('');
    }
    logcolor(LogColor.white, '[FileLogger] init : $_logFilePath');
  }

  setFileLimit(int minSizeToPreserve, int allowedMaxSize) {
    //size가 뒤바뀌면 세팅 안하고 넘어감.
    if (allowedMaxSize < minSizeToPreserve) {
      print('Invalid setFileLimit: $minSizeToPreserve, $allowedMaxSize');
      return;
    }
    _minSizeToPreserve = minSizeToPreserve;
    _allowedMaxSize = allowedMaxSize;
  }

  static Future<String> getDefaultLogPath() async {
    // 앱의 문서 디렉토리 경로 얻기
    var appDocDir = await getApplicationDocumentsDirectory();
    return "${appDocDir.path}/app_logs.txt";
  }

  //await 없이 log 호출이 가능하도록
  log(String message) {
    //이전호출 확인 후 가자.
    var prevWait = _asyncLogFuture;
    _asyncLogFuture = logAsync(message, prevWait);
  }

  waitLogFin() async {
    if (_asyncLogFuture != null) {
      await _asyncLogFuture;
      _asyncLogFuture = null;
    }
  }

  Future<void> logAsync(String message, [Future<void>? prevLogFuture]) async {
    if (prevLogFuture != null) {
      await prevLogFuture;
    }
    if (_logFilePath.isEmpty) {
      await init();
    }

    // 현재 시간과 메시지를 로그 형식으로 만듭니다.
    String logEntry = "${DateTime.now()} - $message\n";

    logcolor(LogColor.white, '[FileLogger] log : $logEntry');

    await truncateFile(_minSizeToPreserve, _allowedMaxSize);

    // 파일에 로그를 추가합니다.
    await File(_logFilePath).writeAsString(logEntry, mode: FileMode.append);
  }

  Future<List<String>> readLogs() async {
    if (_logFilePath.isEmpty) {
      await init();
    }

    // 파일에서 로그를 읽어옵니다.
    if (await File(_logFilePath).exists()) {
      List<String> logs = await File(_logFilePath).readAsLines();

      logcolor(LogColor.white, '[FileLogger] readLogs : $logs');
      return logs;
    } else {
      logcolor(LogColor.white, '[FileLogger] readLogs : empty');
      return [];
    }
  }

  Future<void> clear() async {
    if (_logFilePath.isEmpty) {
      await init();
    }

    // 로그 파일을 초기화 (비우기)
    await File(_logFilePath).writeAsString('');
  }

  Future<void> truncateFile(int newSize, [int allowedSize = 0]) async {
    if (_logFilePath.isEmpty) {
      await init();
    }
    //값을 지정하지 않음녀 newSize로 재조정
    if (allowedSize == 0) allowedSize = newSize;

    File file = File(_logFilePath);

    // 파일 크기 가져오기
    int currentSize = await file.length();

    // 이미 원하는 크기 이하이면 pass
    if (currentSize <= allowedSize) {
      return;
    }
    //크기가 0인경우
    if (newSize == 0) {
      // 파일 크기를 0으로 조정
      await file.writeAsString('');
      return;
    }

    RandomAccessFile raf = await file.open(mode: FileMode.append);

    // 파일을 newSize만큼 전진시킨다.
    await raf.setPosition(currentSize - newSize);

    // 마지막 newSize만큼의 데이터를 읽어온다.
    Uint8List lastChunkBytes = await raf.read(newSize);
    String lastChunk = utf8.decode(lastChunkBytes);

    // 첫 번째 개행 문자의 위치를 찾음
    int firstNewlineIndex = lastChunk.indexOf('\n');

    // 파일의 처음부터 firstNewlineIndex까지 삭제하여 파일을 잘라냄
    await raf.setPosition(0);
    var writeChunk = Uint8List.fromList(utf8.encode(firstNewlineIndex >= 0
        ? lastChunk.substring(firstNewlineIndex + 1)
        : lastChunk));
    await raf.writeFrom(writeChunk);

    // 파일을 크기를 조정
    await raf.truncate(writeChunk.length);

    await raf.close();
  }
}

FileLogger gdefaultFileLogger = FileLogger();
