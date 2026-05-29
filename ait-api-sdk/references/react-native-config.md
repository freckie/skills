---
url: >-
  https://developers-apps-in-toss.toss.im/bedrock/reference/framework/UI/RNConfig.md
description: 'React Native SDK의 브랜드 정보, 권한, 환경 변수 등 전역 설정 방법을 안내해요.'
---

# 설정하기

미니앱에서 사용하는 **브랜드 정보, 권한, 빌드 옵션** 등의 전역 설정을 한 곳에서 관리할 수 있어요.

***

## 설정 항목

* `scheme` : 앱 라우팅 스킴을 입력해 주세요. `intoss`로 입력하면 돼요.
* `appName` : 콘솔에 등록한 앱 ID를 입력해 주세요.
* `displayName` : 사용자에게 노출될 앱 이름을 입력해 주세요. 콘솔에 등록된 이름과 동일하게 입력해야 해요.
* `primaryColor` : 앱의 기본 색상 값을 지정해 주세요. 지정한 색상은 버튼 등에 적용돼요.
* `icon` : 앱의 로고 이미지 URL을 입력해 주세요. 콘솔의 앱 정보에서 업로드한 이미지를 우클릭해 링크 복사 후 넣어 주세요.
* `permissions` : 권한이 필요한 경우 설정해 주세요. [필요한 권한 설정하기](/bedrock/reference/framework/권한/permission.md) 문서를 참고해 주세요.

::: code-group

```typescript [게임]
interface defineConfig({
  scheme: string,            // 앱 라우팅 스킴 (intoss)
  appName: string,           // 콘솔에 등록한 앱ID
  plugins: [
    appsInToss({
      brand: {
        displayName: string,  // 사용자에게 노출될 앱 이름
        primaryColor: string, // 브랜드 기본 색상(hex)
        icon: string,         // 콘솔에서 업로드한 이미지의 URL(콘솔의 앱 정보에서 업로드한 이미지를 우클릭해 링크 복사 후 넣어주세요)
      },
      permissions: Permission[], // 런타임 권한(필요 시 확장)
    }),
  ],
});
```

```typescript [비게임]
interface defineConfig({
  scheme: string,            // 앱 라우팅 스킴 (intoss)
  appName: string,           // 콘솔에 등록한 앱ID
  plugins: [
    appsInToss({
      brand: {
        displayName: string,  // 사용자에게 노출될 앱 이름
        primaryColor: string, // 브랜드 기본 색상(hex)
        icon: string,         // 콘솔에서 업로드한 이미지의 URL(콘솔의 앱 정보에서 업로드한 이미지를 우클릭해 링크 복사 후 넣어주세요)
      },
      permissions: Permission[], // 런타임 권한(필요 시 확장)
    }),
  ],
});
```

```tsx [예시]
import { appsInToss } from '@apps-in-toss/framework/plugins';
import { defineConfig } from '@granite-js/react-native/config';

export default defineConfig({
  scheme: 'intoss',
  appName: 'rn-template',
  plugins: [
    appsInToss({
      brand: {
        displayName: 'rn-template',
        primaryColor: '#3182F6',
        icon: 'https://static.toss.im/icons/png/4x/icon-person-man.png',
      },
      permissions: [
        { name: 'clipboard', access: 'read' },
        { name: 'clipboard', access: 'write' },
        { name: 'camera', access: 'access' },
        { name: 'photos', access: 'read' },
      ],
    }),
  ],
});
```

:::

***

## 환경 변수 설정

`plugin-env`는 **빌드 시점에 환경 변수를 주입**하고, `import.meta.env` 형태로 접근할 수 있도록 도와주는 플러그인이에요.\
API 키, 환경 구분 값(`staging` / `production`)처럼 **코드에 직접 노출되면 안 되는 값이나 환경별로 달라지는 값**을 관리할 때 사용해요.

`granite.config.ts`에서만 설정할 수 있어요.

### 설치하기

::: code-group

```sh [npm]
npm install @granite-js/plugin-env
```

```sh [yarn]
yarn add @granite-js/plugin-env
```

```sh [pnpm]
pnpm add @granite-js/plugin-env
```

:::

### 사용 예시

```tsx
import { appsInToss } from '@apps-in-toss/framework/plugins';
import { defineConfig } from '@granite-js/react-native/config';
import { env } from '@granite-js/plugin-env';

export default defineConfig({
  scheme: 'intoss',
  appName: 'my-granite-app',
  plugins: [
    appsInToss({
      brand: {
        displayName: 'my-granite-app',
        primaryColor: '#3182F6',
        icon: '',
      },
      permissions: [],
    }),
    env({ MY_ENV_VAR: 'Hello, World!' }),
  ],
});

// 사용
import.meta.env.MY_ENV_VAR; // 'Hello, World!'
```

::: tip 참고하세요

* 환경 변수는 런타임이 아닌 **빌드 시점에 고정**돼요.
* 여러 환경(`staging`, `production`)을 구분해야 한다면 `env()`에 환경별 객체를 전달하거나 `.env` 파일과 함께 사용하는 방식을 권장해요.
  :::

***

## 내비게이션 바

내비게이션 바 구성, 기본 기능(공유하기, 신고하기 등), 액세서리 아이콘 추가 방법은 [내비게이션 바](/bedrock/reference/framework/UI/NavigationBar.html) 문서에서 확인할 수 있어요.
