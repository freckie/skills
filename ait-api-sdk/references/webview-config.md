---
url: >-
  https://developers-apps-in-toss.toss.im/bedrock/reference/framework/UI/Config.md
description: 'WebView SDK의 브랜드 정보, 호스트 설정, 권한, 빌드 옵션 등 전역 설정 방법을 안내해요.'
---

# 설정하기

미니앱에서 사용하는 **브랜드 정보, 호스트 설정, 권한, 빌드 옵션** 등의 전역 설정을 한 곳에서 관리할 수 있어요.

***

## 설정 항목

* `appName` : 콘솔에 등록한 앱 ID를 입력해 주세요.
* `displayName` : 사용자에게 노출될 앱 이름을 입력해 주세요. 콘솔에 등록된 이름과 동일하게 입력해야 해요.
* `primaryColor` : 앱의 기본 색상 값을 지정해 주세요. 지정한 색상은 버튼 등에 적용돼요.
* `icon` : 앱의 로고 이미지 URL을 입력해 주세요. 콘솔의 앱 정보에서 업로드한 이미지를 우클릭해 링크 복사 후 넣어 주세요.
* `permissions` : 권한이 필요한 경우 설정해 주세요. [필요한 권한 설정하기](/bedrock/reference/framework/권한/permission.md) 문서를 참고해 주세요.
* `webViewProps.type` : 미니앱 유형에 맞게 내비게이션 바를 설정해 주세요.
  * 게임 : `game`
  * 비게임 : `partner`

::: code-group

```typescript [게임]
interface defineConfig {
  appName: string; // 콘솔에 등록한 앱ID
  brand: {
    displayName: string; // 사용자에게 노출될 앱 이름
    primaryColor: string; // 브랜드 기본 색상(hex)
    icon: string; // 콘솔에서 업로드한 이미지의 URL(콘솔의 앱 정보에서 업로드한 이미지를 우클릭해 링크 복사 후 넣어주세요)
  };
  web: {
    host: string; // 개발 서버 호스트
    port: number; // 개발 서버 포트
    commands: {
      dev: string; // 실행 명령어
      build: string; // 빌드 명령어
    };
  };
  permissions: Permission[]; // 런타임 권한(필요 시 확장)
  outdir: string; // 빌드 산출물 경로
  webViewProps: {
    type: 'game'; // 게임 내비게이션 // [!code highlight]
  };
}
```

```typescript [비게임]
interface defineConfig {
  appName: string; // 콘솔에 등록한 앱ID
  brand: {
    displayName: string; // 사용자에게 노출될 앱 이름
    primaryColor: string; // 브랜드 기본 색상(hex)
    icon: string; // 콘솔에서 업로드한 이미지의 URL(콘솔의 앱 정보에서 업로드한 이미지를 우클릭해 링크 복사 후 넣어주세요)
  };
  web: {
    host: string; // 개발 서버 호스트
    port: number; // 개발 서버 포트
    commands: {
      dev: string; // 실행 명령어
      build: string; // 빌드 명령어
    };
  };
  permissions: Permission[]; // 런타임 권한(필요 시 확장)
  outdir: string; // 빌드 산출물 경로
  webViewProps: {
    type: 'partner'; // 비게임 // [!code highlight]
  };
}
```

```tsx [예시]
import { defineConfig } from '@apps-in-toss/web-framework/config';

export default defineConfig({
  appName: 'webview-template',
  brand: {
    displayName: '웹뷰템플릿',
    primaryColor: '#3182F6',
    icon: 'https://static.toss.im/icons/png/4x/icon-person-man.png',
  },
  web: {
    host: 'localhost',
    port: 5173,
    commands: {
      dev: 'vite',
      build: 'tsc -b && vite build',
    },
  },
  permissions: [
    { name: 'clipboard', access: 'read' },
    { name: 'clipboard', access: 'write' },
    { name: 'camera', access: 'access' },
    { name: 'photos', access: 'read' },
  ],
  outdir: 'dist',
  webViewProps: {
    type: 'partner',
  },
});
```

:::

***

## 내비게이션 바

내비게이션 바 구성, 기본 기능(공유하기, 신고하기 등), 액세서리 아이콘 추가 방법은 [내비게이션 바](/bedrock/reference/framework/UI/NavigationBar.html) 문서에서 확인할 수 있어요.
