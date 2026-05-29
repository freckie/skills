---
url: 'https://developers-apps-in-toss.toss.im/development/test/sandbox.md'
description: '앱인토스 샌드박스 앱으로 미니앱을 테스트하는 방법을 안내해요. 환경 설정부터 설치, 로그인, 미니앱 실행까지 전체 과정을 다뤄요.'
---

# 테스트앱(샌드박스)

앱인토스는 개발용 토스앱을 별도로 제공하지 않아요.\
대신 **전용 샌드박스 앱**을 통해 개발·테스트 환경을 구성할 수 있어요.

::: tip 반드시 확인해주세요
실서비스 출시 전, 샌드박스 앱에서 기능 검증을 완료해야 해요.\
샌드박스 앱에서 테스트를 완료했더라도, 출시 검수에서 가이드에 위반한 사항이 있다면 반려될 수 있어요.
:::

***

## 샌드박스 앱이란?

앱인토스는 토스앱 안에서 파트너사의 서비스를 **앱인앱(App-in-App)** 형태로 제공해요.\
별도의 개발용 토스앱 대신, **개발·QA 전용 샌드박스 앱**을 통해 연동 테스트를 진행할 수 있어요.

샌드박스 앱을 설치한 뒤 아래 순서로 개발을 시작하세요.

1. 환경 설정
2. 샌드박스 앱 설치
3. 로그인 → 앱 선택 → 스킴(URL) 접속

### 지원 OS 버전

| 구분    | 최소 버전 |
| ------- | --------- |
| Android | Android 7 |
| iOS     | iOS 16    |

::: tip App Transport Security (ATS)
App Transport Security(ATS) 정책 위반을 방지하기 위해 **샌드박스 앱에서는 http 통신이 허용**돼요.\
단, 라이브 환경에서는 **https만 지원**되므로, http 기반 기능은 샌드박스에서만 정상 동작해요.
:::

***

## 1. 환경 설정하기

### iOS 환경 설정

iOS 시뮬레이터에서 테스트하려면 **Xcode**가 필요해요.

::: tip iOS의 서드파티 쿠키 차단 정책
iOS/iPadOS 13.4 이상에서는 **서드파티 쿠키가 완전히 차단**돼요.\
앱인토스 도메인이 아닌 파트너사 도메인에서 쿠키 기반 로그인을 구현하면 정상 동작하지 않아요.\
**토큰 기반 등 대체 인증 방식**을 적용해 주세요.
:::

#### 1-1. Xcode 설치하기

[Xcode 최신버전 다운로드](https://apps.apple.com/kr/app/xcode/id497799835?mt=12)를 클릭해서 Mac App Store에서 설치해 주세요.

#### 1-2. iOS 컴포넌트 설치하기

Xcode를 처음 설치한 경우, iOS 15 이상의 컴포넌트를 추가로 설치해야 해요.\
아래와 같은 창이 표시되면 iOS를 선택해 설치해 주세요.

#### 1-3. Xcode Command Line Tools 설치하기

Xcode Command Line Tools는 **Xcode 본체와 버전이 동일해야** 해요.

**Xcode 버전 확인하기**

1. Xcode를 열고 상단 메뉴에서 \[Xcode] > \[About Xcode]를 클릭하세요.
2. 화면에 표시된 버전을 확인하세요.

**Xcode Command Line Tools 버전 확인하기**

1. Xcode에서 \[Xcode] > \[Settings]를 클릭하세요.
2. \[Locations] 탭에서 Command Line Tools 항목의 버전을 확인하세요.

#### 1-4. 시뮬레이터 실행하기

1. Xcode 상단 메뉴에서 \[Xcode] > \[Open Developer Tool] > \[Simulator]를 선택하세요.
2. iOS 15 이상의 버전을 사용할 수 있는지 확인하세요.

::: details 시뮬레이터가 보이지 않는다면

1. Simulator 앱을 열어요.
2. 상단 메뉴에서 \[File] > \[Open Simulator]를 클릭하세요.
3. iOS 15 이상 버전에서 원하는 기기를 선택하세요.

***

### Android 환경 설정

React Native를 Android 환경에서 실행하려면 **Android SDK**와 [`adb`(Android Debug Bridge)](https://developer.android.com/tools/adb?hl=ko)가 필요해요.

#### 1-1. Android Studio 설치하기

[Android Studio 설치 링크](https://developer.android.com/studio?hl=ko)에서 설치해 주세요.

#### 1-2. Android SDK Command-line Tools 설치하기

1. Android Studio에서 상단 메뉴 \[Android Studio] > \[Settings]를 클릭하세요.
2. \[Languages & Frameworks] > \[Android SDK]를 선택하세요.
3. \[SDK Tools] 탭에서 "Android SDK Command-line Tools"를 체크하고 OK를 눌러 설치하세요.

![Android SDK Command-line Tools 설치](/assets/setup-android-adb._yG9Scbj.webp)

#### 1-3. 환경 변수 설정하기

`adb`를 사용하려면 환경 변수를 설정해야 해요.

::: code-group

```bash [macOS]
# .zshrc 또는 .bashrc에 추가하세요.
export ANDROID_HOME=~/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools
```

:::

::: details Windows 환경 변수 설정하기

**1. 실행 프롬프트 열기**

`Windows` + `R` 키를 눌러 실행 창을 열고 `SystemPropertiesAdvanced`를 입력한 뒤 Enter를 눌러요.

![실행 프롬프트](/assets/setup-android-windows-1.G08uZ1Km.webp)

**2. 환경 변수 메뉴로 진입하기**

\[시스템 속성] 창에서 \[고급] 탭을 선택하고, 하단의 \[환경 변수] 버튼을 눌러요.

![환경 변수](/assets/setup-android-windows-2.DjoB7z_Q.webp)

**3. 사용자 변수에서 Path 편집하기**

사용자 변수 섹션에서 `Path` 변수를 선택한 뒤 \[편집] 버튼을 눌러요.\
`Path` 변수가 없다면 \[새로 만들기] 버튼을 눌러 이름을 `Path`로 설정하세요.

![Path 환경 변수](/assets/setup-android-windows-3.CBHFqHou.webp)

**4. Android SDK 경로 추가하기**

편집 창에서 \[새로 만들기] 버튼을 눌러 다음 경로를 추가하세요.\
`{사용자명}`은 현재 Windows 사용자 계정 이름으로 바꿔 입력하세요.

`C:\Users\{사용자명}\AppData\Local\Android\sdk\platform-tools`

![환경 변수 추가](/assets/setup-android-windows-4.DvJDS1y8.webp)
:::

환경 변수가 정상적으로 등록되었는지 아래 명령어로 확인하세요.

```sh
adb version
# Android Debug Bridge version 1.0.41
```

#### 1-4. 기기 연결하기

**개발자 옵션 활성화**

::: tip
기기 제조사에 따라 개발자 옵션을 활성화하는 방법이 다를 수 있어요. 사용 중인 기기의 제조사별 가이드는 인터넷 검색으로 확인하세요.
:::

갤럭시 기기 기준으로 아래와 같이 활성화해요.

1. \[설정] 앱 열기
2. \[휴대전화 정보] > \[소프트웨어 정보] 메뉴로 이동
3. \[빌드 번호] 항목을 빠르게 여러 번 탭하기

**USB 디버깅 활성화**

1. \[설정] > \[개발자 옵션] 메뉴로 이동해요.
2. \[USB 디버깅] 항목을 활성화해요.

**PC와 기기 연결하기**

USB 케이블로 PC와 기기를 연결한 뒤, 아래 명령어로 연결 상태를 확인해요.

```sh
adb devices
# List of devices attached
# R3CTA0BMCPK  device
```

"List of devices attached" 아래에 디바이스 아이디가 표시되면 연결이 성공한 거예요.

::: details 디바이스 아이디가 표시되지 않는다면

* **USB 디버깅 활성화 확인**: \[설정] > \[개발자 옵션] > \[USB 디버깅]이 켜져 있는지 확인해요.
* **ADB 서버 재시작**: `adb kill-server` 실행 후 `adb devices`로 다시 확인해요.
  :::

#### 1-5. 에뮬레이터 설정하기

> ⚠️ 디버깅과 QA는 가능한 **실제 기기**에서 진행하는 것을 권장해요.

Android Studio를 실행한 후 오른쪽 메뉴에서 \[Virtual Device Manager] > \[+ 버튼]을 눌러 에뮬레이터를 추가해요.

![에뮬레이터 설정 화면 열기](/assets/setup-android-6.80Io82T7.webp)

::: tip 갤럭시 S23 사양 참고

* 디스플레이: 6.1인치
* 운영체제: API 33부터 지원
  :::

\[Pixel 8a] > \[VanillaIceCream (API 35)] > \[AVD Name 설정] 순으로 진행하면 에뮬레이터 설정이 완료돼요.

![에뮬레이터 설정](/assets/setup-android-7.CdeW0gcC.webp)

추가된 에뮬레이터는 \[Virtual Device Manager]에서 재생 버튼을 눌러 실행할 수 있어요.

![에뮬레이터 실행하기](/assets/setup-android-exec-emulator.ofcQwjRL.webp)

***

## 2. 샌드박스 앱 설치하기

샌드박스 앱은 수시로 업데이트돼요. 오류가 보이면 **최신 버전으로 업데이트**해 주세요.

| 구분             | 빌드번호   | 다운로드                                                                                                                                        |
| ---------------- | ---------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| Android          | 2026-05-21 | 다운로드                             |
| iOS (시뮬레이터) | 2026-03-26 | 다운로드                             |
| iOS (실기기)     | 2026-03-11 |  |

### iOS에 설치하기

**시뮬레이터**

다운로드한 샌드박스 앱 파일을 **시뮬레이터 화면으로 드래그 앤드 드롭**하세요.\
설치가 완료되면 앱이 시뮬레이터 홈 화면에 표시돼요. 설치 완료까지 잠시 기다려 주세요.

**실기기**

위 표의 QR 코드로 앱스토어에서 설치하세요.

### Android에 설치하기

실제 기기와 에뮬레이터 모두 동일한 APK 파일을 사용해요.

**Android Studio로 설치하기**

1. Android Studio 오른쪽 메뉴 \[Device Manager]에 연결된 기기가 표시되는지 확인해요.

![기기 목록](/assets/setup-android-2.C9Ou2usM.webp)

2. \[Start Mirroring] 버튼을 클릭해 기기 화면을 Android Studio에 표시해요.

![Start Mirroring](/assets/setup-android-3.Czxv1HX6.webp)

3. 다운로드한 APK 파일을 기기 화면으로 드래그해서 설치해요.

![APK 드래그 설치](/assets/setup-android-4.DYHWv31c.webp)

**adb 명령어로 설치하기**

```sh
# APK 파일이 있는 폴더로 이동 후 실행
adb install -r -t {파일이름}

# 예시
adb install -r -t apssintoss-debug.apk
```

![adb 설치](/assets/setup-android-5.DeP6dGzv.webp)

***

## 3. 샌드박스 앱 사용하기

### 1. 개발자 로그인

콘솔에서 사용하는 토스 비즈니스 계정으로 로그인하세요.\
토스 비즈니스 가입이 필요하다면 [콘솔에서 앱 등록하기](/prepare/console-workspace)를 확인해 주세요.

::: tip 개인 계정을 사용해 주세요
토스 비즈니스에 가입한 **개인 계정으로 로그인해 주세요.**\
공용 계정을 사용할 경우 로그인 실패 또는 세션이 자주 종료될 수 있어요.\
개인 계정 사용이 어려운 경우, 채널톡으로 문의해 주세요.
:::

### 2. 앱 선택

소속된 워크스페이스의 앱 목록이 노출돼요. **테스트할 앱**을 선택하세요.

### 3. 토스 인증

콘솔에 등록한 **토스 계정**으로 본인 인증을 진행해요.\
해당 계정의 **토스앱이 설치된 스마트폰**에서 푸시를 열어 인증을 완료해 주세요.

### 4. 스킴(URL)으로 접속

접속할 스킴을 입력하면 미니앱이 실행돼요.

```
intoss://{appName}
```

***

## 4. 미니앱 실행하기

### iOS 시뮬레이터에서 실행하기

1. 샌드박스 앱을 실행해요.
2. 스킴을 입력하고 "스키마 열기" 버튼을 눌러요. 예: `intoss://kingtoss`

### iOS 실기기에서 실행하기

로컬 서버와 같은 와이파이에 연결되어 있어야 해요.

1. 샌드박스 앱 실행 시 **"로컬 네트워크"** 권한 요청이 표시되면 **"허용"** 버튼을 눌러요.
2. 서버 주소 입력 화면에서 로컬 서버 IP 주소를 입력하고 저장해요.
   * macOS에서는 `ipconfig getifaddr en0` 명령어로 IP 주소를 확인할 수 있어요.
3. "스키마 열기" 버튼을 눌러요.
4. 화면 상단에 `Bundling {n}%...`가 표시되면 연결 성공이에요.

::: details "로컬 네트워크" 권한을 수동으로 허용하는 방법

1. 아이폰 \[설정] 앱에서 **"앱인토스"** 를 검색해 이동해요.
2. **"로컬 네트워크"** 옵션을 켜주세요.

### Android 에뮬레이터 또는 실기기에서 실행하기

1. USB 케이블로 PC와 기기를 연결해요.

2. `adb` 명령어로 포트를 연결해요.

   ```sh
   adb reverse tcp:8081 tcp:8081
   adb reverse tcp:5173 tcp:5173
   ```

   특정 기기를 연결하려면 `-s` 옵션을 추가해요.

   ```sh
   adb -s {디바이스아이디} reverse tcp:8081 tcp:8081
   adb -s {디바이스아이디} reverse tcp:5173 tcp:5173
   ```

3. 샌드박스 앱에서 스킴을 입력하고 실행 버튼을 눌러요. 예: `intoss://kingtoss`

::: details 자주 쓰는 adb 명령어

```sh
# 연결 끊기
adb kill-server

# 포트 연결하기
adb reverse tcp:8081 tcp:8081
adb reverse tcp:5173 tcp:5173

# 연결 상태 확인하기
adb reverse --list
```

:::

***

## 테스트 가능한 기능

샌드박스에서 지원하지 않는 기능은 콘솔 '출시하기'의 QR 코드로 [토스앱](/development/test/toss.html)에서 테스트해 주세요.

| 기능                   | 테스트 가능 여부                 |
| ---------------------- | -------------------------------- |
| 토스 로그인            | ✅ 가능                          |
| 유저 식별키 발급       | ✅ 가능 (단, mock 데이터 내려감) |
| 토스 페이              | ✅ 가능                          |
| 인앱 결제              | ✅ 가능                          |
| 게임 프로필 & 리더보드 | ✅ 가능                          |
| 분석                   | ❌ 불가능                        |
| 공유 리워드            | ❌ 불가능                        |
| 인앱 광고              | ❌ 불가능                        |
| 가로 버전 게임         | ❌ 불가능                        |
| 내비게이션 바 공유하기 | ❌ 불가능                        |

***

## 자주 묻는 질문

***

## 트러블슈팅

::: details `서버에 연결할 수 없습니다` 에러가 발생해요 (Android)
`granite.config.ts`의 `web.commands`에 `--host`를 추가한 뒤 서비스를 실행해 호스트 주소를 확인하세요.

```ts [granite.config.ts]
web: {
  commands: {
    dev: 'vite --host', // --host 추가
    build: 'tsc -b && vite build',
  },
},
```

호스트 주소 확인 후 `web.host`에 입력하세요.

```ts [granite.config.ts]
web: {
  host: 'x.x.x.x', // 서비스가 실행되는 호스트 주소
},
```

:::

::: details Metro 개발 서버가 열려 있는데 `잠시 문제가 생겼어요` 메시지가 표시돼요
개발 서버에 제대로 연결되지 않은 문제일 수 있어요. `adb` 연결을 끊고 8081, 5173 포트를 다시 연결해 보세요.
:::

::: details PC 웹에서 Not Found 오류가 발생해요
8081 포트는 샌드박스 내에서 인식하기 위한 포트예요. PC 웹에서는 Not Found 오류가 발생해요.
:::
