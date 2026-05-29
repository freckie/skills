---
url: 'https://developers-apps-in-toss.toss.im/tutorials/webview.md'
description: 'WebView 방식으로 앱인토스 미니앱을 개발하는 방법을 안내해요. 프로젝트 생성부터 설정, 실행, 디버깅, 출시까지 전체 과정을 다뤄요.'
---

# WebView 시작하기

::: tip 처음 시작한다면?
앱인토스 개발이 처음이거나 AI와 함께 빠르게 미니앱을 만들어보고 싶다면,\
[AI로 미니앱 만들기](/tutorials/ai-vibe-coding.html) 문서를 먼저 읽어보세요.
:::

CSR / SSG 방식의 웹 서비스를 미니앱으로 실행하는 방식이에요.\
기존 웹 서비스를 미니앱으로 전환하거나, 빠른 업데이트 사이클이 중요한 팀에 적합해요.

* 이미 React, Vue, Svelte 등으로 만든 웹 서비스가 있어요.
* 웹 개발 경험을 그대로 활용하고 싶어요.
* 빠른 출시와 빠른 업데이트 사이클이 중요해요.

React Native로 개발하고 싶다면 → [React Native로 시작하기](/tutorials/react-native.html)

***

## 1. 프로젝트 만들기

### 새 프로젝트로 시작하기

앱을 만들 위치에서 다음 명령어를 실행하세요.

::: code-group

```sh [npx]
npx create-ait-app <app-name>
```

```sh [npm]
npm create ait-app <app-name>
```

```sh [yarn]
yarn create ait-app <app-name>
```

```sh [pnpm]
pnpm create ait-app <app-name>
```

:::

실행하면 대화형 프롬프트가 나와요. 아래 항목을 차례로 선택하세요.

| 항목                     | 설명                                                                             |
| ------------------------ | -------------------------------------------------------------------------------- |
| TDS (Toss Design System) | 토스 디자인 시스템 사용 여부를 선택해요.                                         |
| AI Skills                | Cursor, Claude Code, Codex 등 AI 코딩 도구를 위한 스킬 파일을 추가할지 선택해요. |
| 예제 코드                | 인앱결제, 인앱광고 등 필요한 예제 코드를 추가할 수 있어요.                       |

선택이 끝나면 프로젝트가 자동으로 생성돼요. 프로젝트 폴더로 이동한 뒤 의존성을 설치하세요.

::: code-group

```sh [npm]
cd <app-name>
npm install
```

```sh [yarn]
cd <app-name>
yarn install
```

```sh [pnpm]
cd <app-name>
pnpm install
```

:::

### 기존 웹 프로젝트에 SDK 추가하기

이미 운영 중인 웹 프로젝트에 `@apps-in-toss/web-framework`를 직접 설치해서 시작할 수도 있어요.

::: tip 알아두세요
기존 서비스를 그대로 iframe으로 불러오거나 토스앱 외부 URL로 이동하는 방식은 정책상 제한돼요.\
프론트엔드 소스코드는 토스 인프라에 배포되어야 하며, 필요한 경우 자체 서버와 HTTPS 통신은 가능해요.
:::

#### 1. SDK 설치하기

::: code-group

```sh [npm]
npm install @apps-in-toss/web-framework
```

```sh [pnpm]
pnpm install @apps-in-toss/web-framework
```

```sh [yarn]
yarn add @apps-in-toss/web-framework
```

:::

#### 2. 환경 초기화하기

::: code-group

```sh [npm]
npx ait init
```

```sh [pnpm]
pnpm ait init
```

```sh [yarn]
yarn ait init
```

:::

***

## 2. 설정 파일 수정하기

프로젝트를 생성하면 `granite.config.ts` 파일이 자동으로 만들어져요.\
`appName`, `displayName`, `icon`을 앱인토스 콘솔에 등록한 앱 정보와 동일하게 수정해 주세요.

```ts [granite.config.ts]
import { defineConfig } from '@apps-in-toss/web-framework/config';

export default defineConfig({
  appName: 'my-mini-app', // 콘솔에 입력한 appName을 입력하세요.
  brand: {
    displayName: '앱 이름', // 콘솔에 입력한 앱 이름을 입력하세요.
    primaryColor: '#FF91D5', // 화면에 노출될 앱의 기본 색상으로 바꿔주세요.
    icon: '', // 콘솔에서 업로드한 이미지의 URL을 입력하세요.(콘솔의 앱 정보에서 업로드한 이미지를 우클릭해 링크 복사 후 넣어주세요)
  },
  web: {
    host: 'localhost',
    port: 5173,
    commands: {
      dev: 'vite dev',
      build: 'vite build',
    },
  },
  permissions: [],
  outdir: 'dist',
});
```

::: tip 중요해요

* `appName`은 각 앱을 식별하는 **고유한 키**로 사용돼요.
* `intoss://{appName}` 형태의 딥링크 경로나 테스트·배포 시에도 사용돼요.
* 샌드박스 앱에서 테스트할 때도 `intoss://{appName}`으로 접근해요.\
  단, 출시하기 메뉴의 QR 코드로 테스트할 때는 `intoss-private://{appName}`이 사용돼요.
  :::

자세한 설정 방법은 [공통 설정](/bedrock/reference/framework/UI/Config.html) 문서를 확인해 주세요.

***

## 3. TDS 설치하기

**TDS(Toss Design System) WebView** 패키지를 사용하면 토스 디자인 시스템 기반의 컴포넌트를 쉽게 적용할 수 있어요.

::: code-group

```sh [npm]
npm install @toss/tds-mobile @toss/tds-mobile-ait @emotion/react@^11 react@^18 react-dom@^18
```

```sh [yarn]
yarn add @toss/tds-mobile @toss/tds-mobile-ait @emotion/react@^11 react@^18 react-dom@^18
```

```sh [pnpm]
pnpm add @toss/tds-mobile @toss/tds-mobile-ait @emotion/react@^11 react@^18 react-dom@^18
```

:::

TDS 컴포넌트 사용법과 가이드는 [TDS WebView 문서](https://tossmini-docs.toss.im/tds-mobile/)를 확인해 주세요.

***

## 4. 프로젝트 실행하기

::: code-group

```sh [npm]
npm run dev
```

```sh [yarn]
yarn dev
```

```sh [pnpm]
pnpm run dev
```

:::

***

## 5. 미니앱 실행하기

개발 서버가 실행되면 샌드박스 앱에서 미니앱을 확인할 수 있어요.\
로컬 샌드박스 앱에서 테스트하는 자세한 방법은 [샌드박스앱](/development/test/sandbox.html) 문서를 확인해 주세요.

### 실기기에서 개발 서버 접근하기

실기기에서 테스트하려면 번들러 실행 시 `--host` 옵션을 활성화하고, `web.host`를 실기기에서 접근할 수 있는 네트워크 주소로 설정해야 해요.

```ts [granite.config.ts]
import { defineConfig } from '@apps-in-toss/web-framework/config';

export default defineConfig({
  appName: 'ping-pong',
  web: {
    host: '192.168.0.100', // 실기기에서 접근할 수 있는 IP 주소로 변경
    port: 5173,
    commands: {
      dev: 'vite --host', // --host 옵션 활성화
      build: 'vite build',
    },
  },
  permissions: [],
});
```

설정이 완료되면 실기기에서 다음 순서로 진행하세요.

1. [샌드박스 앱 설치하기](/development/test/sandbox.html#_2-샌드박스-앱-설치하기)를 참고해 기기에 맞는 샌드박스 앱을 설치하세요.
2. 샌드박스 앱에서 Metro 서버 주소를 `web.host`에 설정한 IP 주소로 변경하세요.
3. `intoss://{appName}` 딥링크로 미니앱에 접근하세요.

***

## 6. 디버깅하기

### Android — Chrome DevTools

::: tip 준비가 필요해요
디바이스에서 디버깅하려면 USB 디버깅을 먼저 활성화해야 해요.\
`설정 → 시스템 → 휴대전화 정보 → 개발자 옵션 → USB 디버깅 활성화`
:::

1. Android 에뮬레이터나 실기기에서 미니앱을 실행해요.
2. Chrome 브라우저에서 `chrome://inspect/#devices` 페이지를 열어요.
3. Remote Target에서 디버깅할 WebView 콘텐츠 아래 **inspect** 버튼을 선택해요.
4. 일반 웹 페이지를 디버깅하듯 WebView 콘텐츠를 디버깅할 수 있어요.

### iOS — Safari 개발자 도구

::: tip 준비가 필요해요

* Safari 개발자 메뉴를 활성화해야 해요.\
  `Safari 환경설정 → 고급 탭 → 웹 개발자를 위한 기능 보기 체크박스 활성화`
* 디바이스에서 디버깅하려면 Web Inspector(웹 검사기)를 활성화해야 해요.\
  `설정 → Safari → 고급 → Web Inspector 활성화`
* 개발자용 메뉴에 디바이스가 표시되지 않으면 Safari를 재시작해 보세요.
  :::

1. iOS 시뮬레이터 또는 실기기에서 미니앱을 실행해요.
2. Safari 상단 메뉴 `개발자용 → [디바이스 이름] → [앱 이름] → [URL - 제목]`을 선택해요.
3. 웹에서 디버깅하듯 WebView 콘텐츠를 디버깅할 수 있어요.

***

## 7. 빌드하고 토스앱에서 최종 테스트하기

샌드박스 앱에서 개발과 기본 검증이 끝나면 `npm run build`로 앱 번들을 생성한 뒤, 콘솔에 업로드해 최종 테스트를 진행해 주세요.\
토스앱 테스트를 완료해야 출시 요청을 보낼 수 있어요. 자세한 방법은 [토스앱 테스트하기](/development/test/toss) 문서를 참고해 주세요.

***

## 8. 출시하기

출시하는 방법은 [미니앱 출시](/development/deploy) 문서를 참고하세요.
