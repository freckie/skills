---
url: 'https://developers-apps-in-toss.toss.im/smart-message/develop.md'
description: >-
  기능성 메시지를 파트너사 서버에서 직접 발송하는 API 가이드예요. 테스트 메시지, 메시지, 대량 메시지 발송 API 사용법을 확인할 수
  있어요.
---

# 기능성 메시지 발송하기

![](/assets/push_3.DH8L-yZy.webp)

결제 완료, 배송 안내처럼 **서비스 이용에 필요한 기능성 메시지**를 파트너사 서버에서 직접 발송할 때 사용하는 API예요.

::: tip BaseURL
`https://apps-in-toss-api.toss.im`
:::

::: tip API 발송 전 콘솔 설정이 필요해요
API를 호출하기 전에 아래 절차를 먼저 완료해야 해요.

1. 콘솔에서 기능성 캠페인을 생성하고 템플릿 코드(`templateSetCode`)를 발급받아요.
2. 알림 동의문이 필요한 메시지라면 캠페인 생성 전에 먼저 등록해야 해요.
3. 문구 검수 승인을 받아야 해요. 승인 전에는 테스트 메시지도 발송할 수 없어요.

설정 방법은 [스마트 발송 소개](/smart-message/intro.html) 문서를 참고해 주세요.
:::

## 1. 테스트 메시지 발송하기

콘솔에서 기능성 캠페인을 생성하고 문구 검수 승인을 받은 뒤, 실제 배포 전에 번들이 정상 동작하는지 확인할 때 사용해요.

* Content-Type: `application/json`
* Method: `POST`
* URL: `/api-partner/v1/apps-in-toss/messenger/send-test-message`

**요청 헤더**

| 이름            | 타입   | 필수 | 설명                                                                                          |
| --------------- | ------ | ---- | --------------------------------------------------------------------------------------------- |
| x-toss-user-key | string | Y    | 사용자를 인증하기 위한 키예요. [사용자 정보 받기](/api/loginMe.html)를 통해 획득할 수 있어요. |

**요청 바디**

| 이름            | 타입   | 필수 | 설명                                                                                                     |
| --------------- | ------ | ---- | -------------------------------------------------------------------------------------------------------- |
| templateSetCode | string | Y    | 사용할 메시지 템플릿 코드예요. 콘솔에서 등록한 템플릿 코드를 입력해요.                                   |
| deploymentId    | string | Y    | 테스트에 사용할 번들 식별값이에요. UUID 형식이며, 콘솔 → 앱 출시에서 업로드한 번들에서 확인할 수 있어요. |
| context         | object | Y    | 템플릿 변수값들이에요. 사용자 이름, 인증번호 등 템플릿에 들어갈 값을 넣어요.                             |

```json
{
  "templateSetCode": "ALERT_OTP_TEMPLATE",
  "deploymentId": "019abfe8-fd68-7021-9cdc-30d6053cc009",
  "context": {
    "userName": "홍길동",
    "otp": "123456"
  }
}
```

**성공 응답**

| 이름                | 타입    | 설명                                             |
| ------------------- | ------- | ------------------------------------------------ |
| msgCount            | integer | 총 발송된 메시지 수예요.                         |
| sentPushCount       | integer | 푸시(Push)로 발송된 메시지 수예요.               |
| sentInboxCount      | integer | 인박스(Inbox)로 발송된 메시지 수예요.            |
| sentSmsCount        | integer | SMS로 발송된 메시지 수예요.                      |
| sentAlimtalkCount   | integer | 알림톡으로 발송된 메시지 수예요.                 |
| sentFriendtalkCount | integer | 친구톡으로 발송된 메시지 수예요.                 |
| detail              | object  | 전송에 성공한 메시지들의 채널별 상세 목록이에요. |
| fail                | object  | 전송에 실패한 메시지들의 채널별 상세 목록이에요. |

`detail` / `fail` 하위 공통 필드:

| 이름           | 타입  | 설명                                       |
| -------------- | ----- | ------------------------------------------ |
| sentPush       | array | 푸시(Push) 채널의 발송 결과 목록이에요.    |
| sentInbox      | array | 인박스(Inbox) 채널의 발송 결과 목록이에요. |
| sentSms        | array | SMS 채널의 발송 결과 목록이에요.           |
| sentAlimtalk   | array | 알림톡 채널의 발송 결과 목록이에요.        |
| sentFriendtalk | array | 친구톡 채널의 발송 결과 목록이에요.        |

각 채널 배열의 항목 필드:

| 이름              | 타입   | 설명                                               |
| ----------------- | ------ | -------------------------------------------------- |
| contentId         | string | 발송된 메시지의 고유 ID예요.                       |
| reachedFailReason | string | 메시지 도달에 실패한 경우 실패 사유가 담겨 있어요. |

```json
{
  "resultType": "SUCCESS",
  "success": {
    "msgCount": 1,
    "sentPushCount": 1,
    "sentInboxCount": 0,
    "sentSmsCount": 0,
    "sentAlimtalkCount": 0,
    "sentFriendtalkCount": 0,
    "detail": {
      "sentPush": [{ "contentId": "MSG_ABC123" }],
      "sentInbox": [],
      "sentSms": [],
      "sentAlimtalk": [],
      "sentFriendtalk": []
    },
    "fail": {
      "sentPush": [],
      "sentInbox": [],
      "sentSms": [],
      "sentAlimtalk": [],
      "sentFriendtalk": []
    }
  }
}
```

**실패 응답**

```json
{
  "resultType": "FAIL",
  "error": {
    "errorCode": "INVALID_PARAMETER",
    "reason": "요청에 실패했습니다."
  }
}
```

| HTTP 상태 코드 | 설명                                        |
| -------------- | ------------------------------------------- |
| 400            | 요청이 잘못됐거나 필요한 정보가 누락됐어요. |
| 401            | 인증되지 않은 사용자예요.                   |
| 403            | 메시지를 전송할 권한이 없어요.              |

***

## 2. 메시지 발송하기

특정 사용자 1명에게 기능성 메시지를 발송해요.\
문구 검수 승인 후 파트너사 서버에서 원하는 시점에 직접 호출할 수 있어요.

* Content-Type: `application/json`
* Method: `POST`
* URL: `/api-partner/v1/apps-in-toss/messenger/send-message`

::: tip 호출 제한
userKey별로 분당 최대 10회까지 호출할 수 있어요. 초과 시 에러가 반환돼요.
:::

**요청 헤더**

| 이름            | 타입   | 필수 | 설명                                                                                          |
| --------------- | ------ | ---- | --------------------------------------------------------------------------------------------- |
| x-toss-user-key | string | Y    | 사용자를 인증하기 위한 키예요. [사용자 정보 받기](/api/loginMe.html)를 통해 획득할 수 있어요. |

**요청 바디**

| 이름            | 타입   | 필수 | 설명                                                                         |
| --------------- | ------ | ---- | ---------------------------------------------------------------------------- |
| templateSetCode | string | Y    | 사용할 메시지 템플릿 코드예요. 콘솔에서 등록한 템플릿 코드를 입력해요.       |
| context         | object | Y    | 템플릿 변수값들이에요. 사용자 이름, 인증번호 등 템플릿에 들어갈 값을 넣어요. |

```json
{
  "templateSetCode": "ALERT_OTP_TEMPLATE",
  "context": {
    "userName": "홍길동",
    "otp": "123456"
  }
}
```

```
curl --location 'https://apps-in-toss-api.toss.im/api-partner/v1/apps-in-toss/messenger/send-message' \
--header 'Content-Type: application/json' \
--header 'x-toss-user-key: {{userKey}}' \
--data '{
  "templateSetCode": "ALERT_OTP_TEMPLATE",
  "context": {
    "userName": "홍길동",
    "otp": "123456"
  }
}'
```

**성공 응답**

응답 구조는 [테스트 메시지 발송하기](#_1-테스트-메시지-발송하기)와 동일해요.

```json
{
  "resultType": "SUCCESS",
  "success": {
    "msgCount": 1,
    "sentPushCount": 1,
    "sentInboxCount": 0,
    "sentSmsCount": 0,
    "sentAlimtalkCount": 0,
    "sentFriendtalkCount": 0,
    "detail": {
      "sentPush": [{ "contentId": "MSG_ABC123" }],
      "sentInbox": [],
      "sentSms": [],
      "sentAlimtalk": [],
      "sentFriendtalk": []
    },
    "fail": {
      "sentPush": [],
      "sentInbox": [],
      "sentSms": [],
      "sentAlimtalk": [],
      "sentFriendtalk": []
    }
  }
}
```

**실패 응답**

```json
{
  "resultType": "FAIL",
  "error": {
    "errorCode": "INVALID_PARAMETER",
    "reason": "요청에 실패했습니다."
  }
}
```

| HTTP 상태 코드 | 설명                                        |
| -------------- | ------------------------------------------- |
| 400            | 요청이 잘못됐거나 필요한 정보가 누락됐어요. |
| 401            | 인증되지 않은 사용자예요.                   |
| 403            | 메시지를 전송할 권한이 없어요.              |

***

## 3. 대량 메시지 발송하기

여러 사용자에게 동일한 기능성 메시지 템플릿으로 한 번에 발송해요.\
50건 이상의 발송에 사용하며, 한 번 요청 시 최대 2,500건까지 발송할 수 있어요.

* Content-Type: `application/json`
* Method: `POST`
* URL: `/api-partner/v1/apps-in-toss/messenger/send-bulk-message`

**요청 바디**

| 이름            | 타입   | 필수 | 설명                                                                   |
| --------------- | ------ | ---- | ---------------------------------------------------------------------- |
| templateSetCode | string | Y    | 사용할 메시지 템플릿 코드예요. 콘솔에서 등록한 템플릿 코드를 입력해요. |
| contextList     | array  | Y    | 메시지를 받을 사용자 목록이에요. 최소 1건, 최대 2,500건까지 가능해요.  |

`contextList` 항목 필드:

| 이름    | 타입    | 필수 | 설명                                                                         |
| ------- | ------- | ---- | ---------------------------------------------------------------------------- |
| userKey | integer | Y    | 사용자의 고유 식별자예요.                                                    |
| context | object  | Y    | 템플릿 변수값들이에요. 사용자 이름, 인증번호 등 템플릿에 들어갈 값을 넣어요. |

```json
{
  "templateSetCode": "ALERT_OTP_TEMPLATE",
  "contextList": [
    {
      "userKey": 12345678,
      "context": {
        "userName": "홍길동",
        "otp": "123456"
      }
    },
    {
      "userKey": 87654321,
      "context": {
        "userName": "김철수",
        "otp": "654321"
      }
    }
  ]
}
```

```
curl --location 'https://apps-in-toss-api.toss.im/api-partner/v1/apps-in-toss/messenger/send-bulk-message' \
--header 'Content-Type: application/json' \
--data '{
  "templateSetCode": "ALERT_OTP_TEMPLATE",
  "contextList": [
    {
      "userKey": 12345678,
      "context": { "userName": "홍길동", "otp": "123456" }
    },
    {
      "userKey": 87654321,
      "context": { "userName": "김철수", "otp": "654321" }
    }
  ]
}'
```

**성공 응답**

응답 구조는 [테스트 메시지 발송하기](#_1-테스트-메시지-발송하기)와 동일해요.

```json
{
  "resultType": "SUCCESS",
  "success": {
    "msgCount": 2,
    "sentPushCount": 2,
    "sentInboxCount": 0,
    "sentSmsCount": 0,
    "sentAlimtalkCount": 0,
    "sentFriendtalkCount": 0,
    "detail": {
      "sentPush": [{ "contentId": "MSG_ABC123" }, { "contentId": "MSG_DEF456" }],
      "sentInbox": [],
      "sentSms": [],
      "sentAlimtalk": [],
      "sentFriendtalk": []
    },
    "fail": {
      "sentPush": [],
      "sentInbox": [],
      "sentSms": [],
      "sentAlimtalk": [],
      "sentFriendtalk": []
    }
  }
}
```
