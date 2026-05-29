---
url: 'https://developers-apps-in-toss.toss.im/bedrock/intro.md'
description: '앱인토스 전체 아키텍처와 SDK, API 연동을 시작하는 방법을 안내해요.'
---

# 시작하기

앱인토스는 **클라이언트 SDK**와 **서버 API** 두 가지 방식으로 연동해요.\
SDK는 토스 앱 내 미니앱 실행 환경을 구성하고, API는 서버 간 통신으로 로그인·결제 등 핵심 기능을 처리해요.

::: tip 주의해 주세요
iframe은 사용할 수 없어요.\
iframe을 사용하면 앱인토스 기능이 정상 동작하지 않고, 내부 보안 심사에서도 반려돼요.\
단, YouTube 영상 콘텐츠를 삽입하는 용도는 예외적으로 iframe 사용이 가능해요.
:::

***

## 앱인토스 아키텍처

앱인토스는 크게 **SDK(클라이언트)** 와 **서버 API** 두 레이어로 구성돼요.

![앱인토스 아키텍처 개요](/assets/overview.CSNwoeqd.webp)

SDK는 카메라, 위치정보, 결제 UI 같은 **네이티브 기능**을 미니앱에서 바로 쓸 수 있도록 브릿지 역할을 해요.\
서버 API는 **파트너사 서버와 앱인토스 서버 간 통신**을 담당해요.\
로그인 토큰 검증, 결제 승인, 스마트 발송처럼 서버에서 처리해야 하는 기능들이 여기에 해당해요.

![](/assets/overview_flow.BohwmFtr.webp)

### SDK — 미니앱 실행 환경

파트너사는 **WebView SDK** 또는 **React Native SDK** 중 하나를 선택해 미니앱을 개발해요.\
두 SDK 모두 `Granite`을 공통 런타임 레이어로 사용해요.

| SDK              | 설명                                                      |
| ---------------- | --------------------------------------------------------- |
| WebView SDK      | 기존 웹 서비스를 토스 앱에서 빠르게 실행할 수 있어요.     |
| React Native SDK | 네이티브 수준의 성능과 토스 앱 통합이 필요할 때 사용해요. |

파트너사는 SDK만 연동해 빌드 결과물을 업로드하면, 내부 검수 절차 후 바로 출시할 수 있어요.\
복잡한 네이티브 개발 없이도 로그인·결제·인증 같은 핵심 기능을 바로 사용할 수 있어요.

### 서버 API — 서버 간 통신

로그인 토큰 검증, 결제 처리, 스마트 발송 등은 **파트너사 서버 ↔ 앱인토스 서버** 간 API 통신으로 처리해요.\
모든 API 통신은 **mTLS(양방향 TLS 인증)** 로 보호돼요.

***

## SDK 소개

앱인토스 SDK의 핵심은 `Granite`이에요.\
`Granite`은 앱 실행 환경을 초기화하고, 토스 앱과의 통신을 담당하는 공통 런타임 레이어예요.

### AppsInToss

`AppsInToss.registerApp`은 서비스의 기본 환경을 설정하고, 복잡한 초기 구성 없이 개발을 빠르게 시작할 수 있도록 도와줘요.\
**`appName`만 전달해도** 아래 기능들을 즉시 사용할 수 있어요.

* **파일 기반 라우팅**: Next.js처럼 경로와 URL이 자동 매핑돼요.
  * 예시: `/my-service/pages/home.ts` → `intoss://my-service/home`
* **쿼리 파라미터 처리**: URL 스킴 파라미터(referrer 등)를 바로 사용 가능해요.
* **뒤로 가기 제어**: 뒤로 가기 이벤트를 가로채 다이얼로그 표시나 화면 닫기를 처리할 수 있어요.
* **화면 가시성 감지**: 화면이 보이거나 가려지는 이벤트에 맞춰 동작을 제어할 수 있어요.

#### 시그니처

```typescript
AppsInToss: {
    registerApp(
      AppContainer: ComponentType<PropsWithChildren<InitialProps>>,
      { appName, context, router }: BedrockProps
    ): (initialProps: InitialProps) => JSX.Element;
    readonly appName: string;
}
```

#### 예제: 앱 등록하기

```tsx
import { AppsInToss } from '@apps-in-toss/framework';
import { PropsWithChildren } from 'react';
import { InitialProps } from '@granite-js/react-native';
import { context } from '../require.context';

function AppContainer({ children }: PropsWithChildren<InitialProps>) {
  return <>{children}</>;
}

// appName과 context만 전달하면 기본 설정이 완료돼요.
export default AppsInToss.registerApp(AppContainer, { context });
```

### InitialProps

사용자가 화면으로 진입할 때 네이티브(Android / iOS)가 앱으로 전달하는 **초기 데이터 타입**이에요.\
플랫폼에 따라 구조가 달라요.

```typescript
type InitialProps = AndroidInitialProps | IOSInitialProps;
```

#### 프로퍼티

#### 예제: 초기 데이터 활용하기

```tsx
import { AppsInToss } from '@apps-in-toss/framework';
import { PropsWithChildren } from 'react';
import { InitialProps } from '@granite-js/react-native';
import { context } from '../require.context';

function AppContainer({ children, ...initialProps }: PropsWithChildren<InitialProps>) {
  // 화면 진입 시 네이티브가 내려준 초기값을 활용할 수 있어요
  console.log({ initialProps });
  return <>{children}</>;
}

export default AppsInToss.registerApp(AppContainer, { context });
```

***

## API 사용하기

::: tip 서버 API 연동이 필요한 경우에만 확인해 주세요
토스 로그인, 토스 페이, 스마트 발송 등 서버 간 통신이 필요한 기능을 사용할 때 설정해요.\
SDK만 사용한다면 이 섹션은 건너뛰어도 돼요.
:::

mTLS 인증서 설정, 방화벽 구성, API 공통 규격은 [API 사용하기](/development/integration-process.html) 문서에서 확인해 주세요.
