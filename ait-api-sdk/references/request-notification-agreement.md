---
url: >-
  https://developers-apps-in-toss.toss.im/bedrock/reference/framework/인터렉션/requestNotificationAgreement.md
description: >-
  requestNotificationAgreement는 사용자에게 알림 수신 동의 UI를 요청하는 함수예요. 재입고 알림, 이벤트 시작
  알림처럼 사전 동의가 필요한 경우에 사용해요.
---

# 알림 동의문 요청하기 (`requestNotificationAgreement`)

`requestNotificationAgreement`는 스마트 발송의 **기능성 메시지**를 보내기 전, 사용자에게 알림 수신 동의 UI를 요청하는 함수예요.

사용자가 특정 알림을 받겠다고 선택하는 상황에서는 반드시 동의를 먼저 받아야 해요.\
동의 결과는 `onEvent` 콜백으로 전달되며, 결과에 따라 알림 발송 여부를 결정할 수 있어요.

::: tip 콘솔에서 알림 동의문을 먼저 등록해야 해요
`templateCode`는 콘솔 → **스마트 발송 → 알림 동의문** 탭에서 등록한 알림 동의문 코드예요.\
콘솔에 알림 동의문을 등록하지 않으면 이 함수를 호출해도 동의 UI가 표시되지 않아요.\
설정 방법은 [스마트 발송 소개](/smart-message/intro.html#_2-1-알림-동의문) 문서를 참고해 주세요.
:::

***

## 동의문이 필요한 경우

사용자가 **특정 조건을 충족했을 때 알림을 받겠다고 선택**하는 경우에는 동의문이 필요해요.

* 재입고 알림 신청
* 이벤트 시작 알림 신청
* 가격 변동 알림 신청
* 예약 오픈 알림 신청

반면 서비스 이용에 필수적인 정보는 동의 없이도 발송할 수 있어요.

* 결제 완료, 배송 시작, 배송 완료, 환불 완료
* 정보 변경 안내, 약관 변경 안내

***

## 시그니처

```typescript
function requestNotificationAgreement(params: RequestNotificationAgreementOptions): () => void;
```

## 파라미터

## 반환값

## 예제

::: code-group

```tsx [React]
import { requestNotificationAgreement } from '@apps-in-toss/web-framework';

function NotificationAgreementButton() {
  const handleRequestAgreement = () => {
    const cleanup = requestNotificationAgreement({
      options: {
        templateCode: 'your-template-code',
      },
      onEvent: ({ type }) => {
        if (type === 'newAgreement') {
          console.log('알림 수신에 동의했어요.');
        } else if (type === 'alreadyAgreed') {
          console.log('이미 동의된 상태예요.');
        } else if (type === 'agreementRejected') {
          console.log('알림 수신을 거부했어요.');
        }
        cleanup();
      },
      onError: (error) => {
        console.error('알림 동의 요청에 실패했어요:', error);
        cleanup();
      },
    });
  };

  return <button onClick={handleRequestAgreement}>알림 받기</button>;
}
```

```tsx [React Native]
import { Button } from 'react-native';
import { requestNotificationAgreement } from '@apps-in-toss/framework';

function NotificationAgreementButton() {
  const handleRequestAgreement = () => {
    const cleanup = requestNotificationAgreement({
      options: {
        templateCode: 'your-template-code',
      },
      onEvent: ({ type }) => {
        if (type === 'newAgreement') {
          console.log('알림 수신에 동의했어요.');
        } else if (type === 'alreadyAgreed') {
          console.log('이미 동의된 상태예요.');
        } else if (type === 'agreementRejected') {
          console.log('알림 수신을 거부했어요.');
        }
        cleanup();
      },
      onError: (error) => {
        console.error('알림 동의 요청에 실패했어요:', error);
        cleanup();
      },
    });
  };

  return <Button title="알림 받기" onPress={handleRequestAgreement} />;
}
```

:::

## `RequestNotificationAgreementOptions`

`requestNotificationAgreement` 함수에 전달하는 파라미터 타입이에요.

### 시그니처

```typescript
interface RequestNotificationAgreementOptions {
  options: {
    templateCode: string;
  };
  onEvent: (result: { type: NotificationAgreementResult }) => void;
  onError: (error: unknown) => void | Promise<void>;
}
```

### 프로퍼티

## `NotificationAgreementResult`

`onEvent` 콜백으로 전달되는 동의 결과 타입이에요.

### 시그니처

```typescript
type NotificationAgreementResult = 'newAgreement' | 'alreadyAgreed' | 'agreementRejected';
```

### 값 설명

| 값                  | 설명                                                       |
| ------------------- | ---------------------------------------------------------- |
| `newAgreement`      | 사용자가 새로 동의를 완료한 경우예요.                      |
| `alreadyAgreed`     | 이미 동의된 상태로, 추가 동의 없이 결과가 반환된 경우예요. |
| `agreementRejected` | 사용자가 동의를 거부한 경우예요.                           |

## 참고사항

* `onEvent` 또는 `onError` 콜백에서 반환된 cleanup 함수를 반드시 호출해 주세요.
* 동일 컴포넌트에서 함수를 재호출하기 전에 이전 cleanup을 먼저 실행해 주세요. 그렇지 않으면 이전 이벤트 리스너가 중복으로 남아 있을 수 있어요.
* 알림 동의문 등록 방법과 기능성 메시지 발송 흐름은 [스마트 발송 소개](/smart-message/intro.html) 문서를 참고해 주세요.
* 사용자 동의 후 메시지를 발송하려면 파트너사 서버에서 [기능성 메시지 발송하기](/smart-message/develop.html)를 호출해 주세요.
