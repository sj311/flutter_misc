# flutter_misc

## flutter alert dialog 

- mixin으로 구성 `StatefulWidget`을 상속받은 상태에서 사용가능

- alert 띄우는 코드가 너무 복잡한거 같아서 mixin을 기본 구성

`home_page.dart` 파일 참조

- await로 alert 종료 대기 가능

```
await showAlert(contents: '으응?', title: '이거슨 타이틀~');
```

- confirm의 경우, 리턴값 확인.

```
var a = await showConfirmation(
                    contents: '확인할래요?',
                    onOk: () {
                      print('ok~~~~~~~~~~~~');
                    });
                print('>>>>> ${a == "ok" ? "result is ok" : "cancel"}');
```

## flutter file logger

- 백그라운드 작업등에서 파일로 로그 확인이 필요한 경우 사용

- 최대 파일 크기를 지정할 수 있음

- 파일

class FileLogger


```
file_logger.dart
```


## flutter floating actions

- mixin으로 구성 `StatefulWidget`을 상속받은 상태에서 사용가능

- 기본 floating 버튼에 텍스트가 안들어가서 텍스트 추가 가능하게

- 사용예

`file_log_page.dart` 파일 참조

- ** `buildFloatingActions` 을 사용할때  parent는 `Stack`이어야 한다.

```
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
```
