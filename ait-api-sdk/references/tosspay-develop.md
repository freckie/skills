---
url: 'https://developers-apps-in-toss.toss.im/tosspay/develop.md'
description: '토스페이 개발 가이드예요. SDK 연동, API 사용법, 구현 예제를 확인할 수 있어요.'
---

# 개발하기

![](/assets/pay_flow.DZfDwACF.webp)

서비스 소개와 콘솔 설정 방법은 [토스페이 소개](/tosspay/intro.html) 문서를 참고해 주세요.

::: tip BaseURL
`https://pay-apps-in-toss-api.toss.im`
:::

연동 흐름은 아래 순서를 따라 주세요.

1. [결제 생성하기](#_1-결제-생성하기) — 서버에서 결제를 생성하고 `payToken`을 발급받아요.
2. [결제 인증하기](#_2-결제-인증하기) — SDK로 결제창을 띄우고 사용자 인증을 수행해요.
3. [결제 실행하기](#_3-결제-실행하기) — 인증이 완료된 `payToken`으로 실제 결제를 승인해요.
4. [결제 환불하기](#_4-결제-환불하기) — 결제 건을 환불해요.
5. [결제 상태 조회하기](#_5-결제-상태-조회하기) — 결제 상태와 트랜잭션을 조회해요.

***

## 1. 결제 생성하기

결제 건을 생성해요.

* Content-type: `application/json`
* Method: `POST`
* URL: `/api-partner/v1/apps-in-toss/pay/make-payment`

::: tip 현금영수증 사용 시 반드시 확인해 주세요
현금영수증 발급이 필요한 파트너사는 결제 생성 요청 시 `cashReceipt: true`를 반드시 전달해야 해요.\
`cashReceipt`는 결제 생성 시점에만 설정할 수 있으며, 결제 완료 후에는 현금영수증 발급 대상을 변경할 수 없어요.\
`cashReceipt`를 누락하거나 `false`로 보내면 현금영수증 발급 대상이 아니에요.
:::

**요청 헤더**

| 이름            | 타입   | 필수 | 설명                                        |
| --------------- | ------ | ---- | ------------------------------------------- |
| x-toss-user-key | string | Y    | 토스 로그인을 통해 획득한 userKey 값이에요. |

**요청 파라미터**

| 이름                   | 타입    | 필수 | 설명                                                                                                                                                                                                                                                                                         |
| ---------------------- | ------- | ---- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| orderNo                | String  | Y    | **가맹점의 주문번호**예요. 가맹점별로 매회 유니크해야 하며, 중복될 경우 결제 생성 요청이 실패해요.  숫자, 영문자, 특수문자 `_-:.^@`만 사용 가능하며 50자 이내여야 해요. 동일 주문번호는 구매자 인증 완료 이후 재사용이 불가해요. 최초 생성 후 2년이 지난 주문번호도 재사용할 수 없어요. |
| productDesc            | String  | Y    | **상품 설명**이에요. 공백으로만 설정할 수 없고, 백슬래시 `\`와 따옴표 `"`를 포함할 수 없으며 총 255자 이내여야 해요. 한글이 포함된 경우 UTF-8 인코딩을 사용해 주세요.                                                                                                                        |
| amount                 | Integer | Y    | **총 결제 금액**이에요. 금액과 관련된 모든 파라미터는 숫자 형태로 전달해야 해요.                                                                                                                                                                                                             |
| amountTaxFree          | Integer | Y    | **결제 금액 중 비과세 금액**이에요. 과세 품목이면 `0`으로 전달해 주세요.                                                                                                                                                                                                                     |
| amountTaxable          | Integer | N    | **결제 금액 중 과세 금액**이에요. 별도로 설정하지 않고 비과세 금액을 `0`원으로 보내면 서버에서 자동으로 계산해요.                                                                                                                                                                            |
| amountVat              | Integer | N    | **결제 금액 중 부가세**예요. 값이 없으면 과세 금액을 11로 나눈 후 소수점 첫째 자리에서 올림으로 계산해요.                                                                                                                                                                                    |
| amountServiceFee       | Integer | N    | **결제 금액 중 봉사료**예요.                                                                                                                                                                                                                                                                 |
| enablePayMethods       | String  | N    | **결제수단 구분 변수**예요.  - `TOSS_MONEY`: 토스머니만 노출  - `CARD`: 카드만 노출  - `null` 또는 그 외: 상점에 설정된 기본 결제수단으로 노출                                                                                                                                |
| cashReceipt            | boolean | N    | **현금영수증 발급 가능 여부**예요. 현금영수증 기능을 사용하는 경우 `true`, 미사용의 경우 `false`를 전달해 주세요. `null` 같은 비정상 값을 전달하면 명시적으로 `false`로 처리돼요.                                                                                                            |
| cashReceiptTradeOption | String  | N    | **현금영수증 발급 타입**이에요.  - `GENERAL`: 일반(기본값)  - `CULTURE`: 문화비  - `PUBLIC_TP`: 교통비                                                                                                                                                                        |
| installment            | String  | N    | **할부 제한 타입**이에요.  - `USE`: 할부 사용(기본값)  - `NOT_USE`: 할부 미사용                                                                                                                                                                                                    |
| isTestPayment          | boolean | Y    | 샌드박스 결제 요청이면 `true`, 라이브앱 결제 요청이면 `false`예요.                                                                                                                                                                                                                           |

```
curl --location 'https://{{domain}}/api-partner/v1/apps-in-toss/pay/make-payment' \
--header 'Content-Type: application/json' \
--header 'x-toss-user-key: 1234' \
--data '{
    "orderNo": "test-20250417-3",
    "productDesc": "test02",
    "amount": 10,
    "amountTaxFree": 0,
    "cashReceipt": false,
    "isTestPayment": true
}'
```

**응답 파라미터**

| 이름     | 타입   | 설명                                                                                      |
| -------- | ------ | ----------------------------------------------------------------------------------------- |
| payToken | String | **토스페이 토큰**이에요. 매회 유니크한 토큰 값이 생성돼요. 반드시 저장하고 관리해야 해요. |

```json
{
  "resultType": "SUCCESS",
  "success": {
    "payToken": "string"
  }
}
```

***

## 2. 결제 인증하기

`TossPay.checkoutPayment`는 토스페이 결제창을 띄우고 사용자 인증을 수행해요.\
인증이 완료되면 성공 여부를 반환해요. 실제 결제 처리는 인증 성공 후 서버에서 별도로 진행해야 해요.

### `TossPay`

`TossPay`는 토스페이 결제 관련 함수를 모아둔 객체예요.

#### 시그니처

```typescript
TossPay: {
  checkoutPayment: typeof checkoutPayment;
}
```

#### 프로퍼티

### `checkoutPayment`

#### 시그니처

```typescript
function checkoutPayment(options: CheckoutPaymentOptions): Promise<CheckoutPaymentResult>;
```

#### 파라미터

#### 반환값

#### 예제

::: code-group

```js [js]
import { checkoutPayment } from '@apps-in-toss/web-framework';

async function handleCheckoutPayment() {
  try {
    // 실제 구현 시 결제 생성 역할을 하는 API 엔드포인트로 대체해 주세요.
    const { payToken } = await fetch('/my-api/payment/create').then((res) => res.json());
    const { success, reason } = await checkoutPayment({ payToken });

    if (success) {
      // 실제 구현 시 결제를 실행하는 API 엔드포인트로 대체해 주세요.
      await fetch('/my-api/payment/execute', {
        method: 'POST',
        body: JSON.stringify({ payToken }),
        headers: { 'Content-Type': 'application/json' },
      });
      console.log('결제 성공');
    } else {
      console.log('인증 실패:', reason);
    }
  } catch (error) {
    console.error('결제 인증 중 오류가 발생했어요:', error);
  }
}
```

```tsx [React]
import { checkoutPayment } from '@apps-in-toss/web-framework';
import { Button } from '@toss/tds-mobile';

function TossPayButton() {
  async function handlePayment() {
    try {
      const { payToken } = await fetch('/my-api/payment/create').then((res) => res.json());
      const { success, reason } = await checkoutPayment({ payToken });

      if (success) {
        await fetch('/my-api/payment/execute', {
          method: 'POST',
          body: JSON.stringify({ payToken }),
          headers: { 'Content-Type': 'application/json' },
        });
        console.log('결제 성공');
      } else {
        console.log('인증 실패:', reason);
      }
    } catch (error) {
      console.error('결제 인증 중 오류가 발생했어요:', error);
    }
  }

  return <Button onClick={handlePayment}>결제하기</Button>;
}
```

```tsx [React Native]
import { TossPay } from '@apps-in-toss/framework';
import { Button } from '@toss/tds-react-native';

function TossPayButton() {
  async function handlePayment() {
    try {
      const { payToken } = await fetch('/my-api/payment/create').then((res) => res.json());
      const { success, reason } = await TossPay.checkoutPayment({ payToken });

      if (success) {
        await fetch('/my-api/payment/execute', {
          method: 'POST',
          body: JSON.stringify({ payToken }),
          headers: { 'Content-Type': 'application/json' },
        });
        console.log('결제 성공');
      } else {
        console.log('인증 실패:', reason);
      }
    } catch (error) {
      console.error('결제 인증 중 오류가 발생했어요:', error);
    }
  }

  return <Button onPress={handlePayment}>결제하기</Button>;
}
```

:::

### `CheckoutPaymentOptions`

`CheckoutPaymentOptions`는 토스페이 결제창을 띄울 때 필요한 옵션이에요.

#### 시그니처

```typescript
interface CheckoutPaymentOptions {
  payToken: string;
}
```

#### 프로퍼티

### `CheckoutPaymentResult`

`CheckoutPaymentResult`는 토스페이 결제창에서 사용자가 인증에 성공했는지 여부예요.

#### 시그니처

```typescript
interface CheckoutPaymentResult {
  success: boolean;
  reason?: string;
}
```

#### 프로퍼티

***

## 3. 결제 실행하기

구매자가 결제 인증을 완료하면 결제 상태는 '대기' 상태예요.\
`payToken`과 주문번호로 이 API를 호출하면 실제 승인이 완료되고 구매자의 결제 수단에서 금액이 출금돼요.

* Content-type: `application/json`
* Method: `POST`
* URL: `/api-partner/v1/apps-in-toss/pay/execute-payment`

**요청 헤더**

| 이름            | 타입   | 필수 | 설명                                        |
| --------------- | ------ | ---- | ------------------------------------------- |
| x-toss-user-key | string | Y    | 토스 로그인을 통해 획득한 userKey 값이에요. |

**요청 파라미터**

| 이름          | 타입    | 필수 | 설명                                                                                    |
| ------------- | ------- | ---- | --------------------------------------------------------------------------------------- |
| payToken      | String  | Y    | 토스페이 토큰이에요.                                                                    |
| orderNo       | String  | N    | 가맹점 주문번호예요.                                                                    |
| isTestPayment | boolean | Y    | `payToken`이 샌드박스에서 발급된 것이면 `true`, 라이브앱에서 발급된 것이면 `false`예요. |

```
curl --location 'https://{{domain}}/api-partner/v1/apps-in-toss/pay/execute-payment' \
--header 'Content-Type: application/json' \
--header 'x-toss-user-key: 1234' \
--data '{
    "payToken": "test-20250417-3",
    "orderNo": "test02",
    "isTestPayment": true
}'
```

**응답**

| 이름                | 타입    | 설명                                                                                                                                                                                                |
| ------------------- | ------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| mode                | String  | 결제 환경이에요. `LIVE`: 실거래용, `TEST`: 테스트용                                                                                                                                                 |
| orderNo             | String  | 승인된 상품 주문번호예요.                                                                                                                                                                           |
| amount              | Integer | 상품 금액이에요.                                                                                                                                                                                    |
| approvalTime        | String  | 결제 승인 처리 시간이에요. (yyyy-MM-dd HH:mm:ss)                                                                                                                                                    |
| stateMsg            | String  | 상태 응답 텍스트예요. 정상 응답일 경우 `"결제 완료"`로 내려와요.                                                                                                                                    |
| discountedAmount    | Integer | 할인된 금액이에요. 할인 적용이 없으면 `0`으로 내려와요. 즉시할인과 토스 포인트 사용금액이 포함돼요.                                                                                                 |
| paidAmount          | Integer | 지불수단 승인금액이에요. 총 금액 중 할인 금액을 제외한 순수 지불수단 승인금액이에요.                                                                                                                |
| payMethod           | String  | 결제수단이에요. `TOSS_MONEY`: 토스머니, `CARD`: 카드                                                                                                                                                |
| payToken            | String  | 토스페이 토큰이에요. 반드시 저장하고 관리해야 해요.                                                                                                                                                 |
| transactionId       | String  | 거래 트랜잭션 아이디예요. 매출전표 호출이나 환불 진행 시 구분 값으로 활용할 수 있어요.                                                                                                              |
| cardCompanyCode     | String  | 승인 카드사 코드예요.                                                                                                                                                                               |
| cardCompanyName     | String  | 승인 카드사명이에요.                                                                                                                                                                                |
| cardAuthorizationNo | String  | 구매자가 확인할 수 있는 카드사 승인번호예요. 라이브 키 결제에서 확인할 수 있어요.                                                                                                                   |
| spreadOut           | String  | 사용자가 선택한 카드 할부개월이에요. 5만원 미만 금액 및 일시불 결제의 경우 `0`으로 내려와요.                                                                                                        |
| noInterest          | String  | 카드 무이자 적용 여부예요. `true`: 무이자, `false`: 일반                                                                                                                                            |
| salesCheckLinkUrl   | String  | 신용카드 매출전표 호출 URL이에요.                                                                                                                                                                   |
| cardMethodType      | String  | 카드 타입이에요. `CREDIT`: 신용카드, `CHECK`: 체크카드, `PREPAYMENT`: 선불카드                                                                                                                      |
| cardNumber          | String  | 마스킹된 카드번호예요. 카드번호 16자리 중 중간 자리는 마스킹돼요.                                                                                                                                   |
| cardUserType        | String  | 카드 사용자 구분이에요. `PERSONAL`: 본인카드, `PERSONAL_FAMILY`: 가족카드, `CORP_PERSONAL`: 법인지정 결제계좌 임직원, `CORP_PRIVATE`: 법인 공용, `CORP_COMPANY`: 법인지정 결제계좌 회사(하나카드만) |
| cardNum4Print       | String  | 사용자가 선택한 카드의 끝 4자리예요.                                                                                                                                                                |
| cardBinNumber       | String  | 카드 BIN 번호예요.                                                                                                                                                                                  |
| cashReceiptMgtKey   | String  | 현금영수증 관리번호 식별값이에요. 이 필드가 있으면 현금영수증 발급 여부를 구분할 수 있어요.                                                                                                         |
| accountBankCode     | String  | 은행 코드예요. 토스머니 결제의 경우 토스가 정의한 은행 코드를 전달해요.                                                                                                                             |
| accountBankName     | String  | 은행명이에요.                                                                                                                                                                                       |
| accountNumber       | String  | 계좌번호예요. 일부 마스킹이 포함돼요.                                                                                                                                                               |
| msg                 | String  | 응답이 성공이 아닌 경우 설명 메시지예요.                                                                                                                                                            |
| errorCode           | String  | 에러 코드예요.                                                                                                                                                                                      |

```json
{
  "resultType": "SUCCESS",
  "success": {
    "code": 0,
    "mode": "TEST",
    "orderNo": "20250417-2",
    "amount": 10,
    "approvalTime": "2025-04-17 12:32:10",
    "stateMsg": "결제 완료",
    "discountedAmount": 0,
    "paidAmount": 10,
    "payMethod": "TOSS_MONEY",
    "payToken": "O1NZck9XME8ureeVJVJP67",
    "transactionId": "45a77cf4-5577-4d5c-8827-4d4dd328bf12",
    "cardCompanyCode": null,
    "cardCompanyName": null,
    "cardAuthorizationNo": null,
    "spreadOut": null,
    "noInterest": null,
    "salesCheckLinkUrl": null,
    "cardMethodType": null,
    "cardNumber": null,
    "cardUserType": null,
    "cardNum4Print": null,
    "cardBinNumber": null,
    "cashReceiptMgtKey": null,
    "accountBankCode": "092",
    "accountBankName": "토스뱅크",
    "accountNumber": "100******094",
    "msg": null,
    "errorCode": null
  }
}
```

***

## 4. 결제 환불하기

결제 건을 구매자에게 환불해요.

* Content-type: `application/json`
* Method: `POST`
* URL: `/api-partner/v1/apps-in-toss/pay/refund-payment`

**요청 헤더**

| 이름            | 타입   | 필수 | 설명                                        |
| --------------- | ------ | ---- | ------------------------------------------- |
| x-toss-user-key | string | Y    | 토스 로그인을 통해 획득한 userKey 값이에요. |

**요청 파라미터**

| 이름          | 타입    | 필수 | 설명                                                                                        |
| ------------- | ------- | ---- | ------------------------------------------------------------------------------------------- |
| payToken      | String  | Y    | 토스페이 토큰이에요.                                                                        |
| reason        | String  | Y    | 환불 사유예요. 한글 및 숫자, 영문자, 특수문자 `_ - : . ^ @ ( ) [ ] # / ! % ? &`만 허용해요. |
| isTestPayment | boolean | Y    | `payToken`이 샌드박스에서 발급된 것이면 `true`, 라이브앱에서 발급된 것이면 `false`예요.     |

**응답**

| 이름                   | 타입    | 설명                                                                                                                                                                                                |
| ---------------------- | ------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| refundNo               | String  | 환불 번호예요.                                                                                                                                                                                      |
| approvalTime           | String  | 환불 처리 시간이에요. (yyyy-MM-dd HH:mm:ss)                                                                                                                                                         |
| cashReceiptMgtKey      | String  | 현금영수증 관리번호 식별값이에요.                                                                                                                                                                   |
| refundableAmount       | Integer | 환불 가능 금액이에요.                                                                                                                                                                               |
| discountedAmount       | Integer | 할인된 금액이에요.                                                                                                                                                                                  |
| paidAmount             | Integer | 지불수단 승인금액이에요.                                                                                                                                                                            |
| refundedAmount         | Integer | 환불 요청 금액이에요.                                                                                                                                                                               |
| refundedDiscountAmount | Integer | 환불 요청 금액 중 실 차감된 할인 금액이에요.                                                                                                                                                        |
| refundedPaidAmount     | Integer | 환불 요청 금액 중 실 차감된 지불수단 금액이에요.                                                                                                                                                    |
| payToken               | String  | 환불된 결제 토큰이에요.                                                                                                                                                                             |
| transactionId          | String  | 거래 트랜잭션 아이디예요.                                                                                                                                                                           |
| cardMethodType         | String  | 카드 타입이에요. `CREDIT`: 신용카드, `CHECK`: 체크카드, `PREPAYMENT`: 선불카드                                                                                                                      |
| cardNumber             | String  | 마스킹된 카드번호예요.                                                                                                                                                                              |
| cardUserType           | String  | 카드 사용자 구분이에요. `PERSONAL`: 본인카드, `PERSONAL_FAMILY`: 가족카드, `CORP_PERSONAL`: 법인지정 결제계좌 임직원, `CORP_PRIVATE`: 법인 공용, `CORP_COMPANY`: 법인지정 결제계좌 회사(하나카드만) |
| cardNum4Print          | String  | 사용자가 선택한 카드의 끝 4자리예요.                                                                                                                                                                |
| cardBinNumber          | String  | 카드 BIN 번호예요.                                                                                                                                                                                  |
| accountBankCode        | String  | 은행 코드예요. 토스머니 결제의 경우 토스가 정의한 은행 코드를 전달해요.                                                                                                                             |
| accountBankName        | String  | 은행명이에요.                                                                                                                                                                                       |
| accountNumber          | String  | 마스킹된 계좌번호예요.                                                                                                                                                                              |

```json
{
  "resultType": "SUCCESS",
  "success": {
    "refundNo": "string",
    "approvalTime": "string",
    "cashReceiptMgtKey": "string",
    "refundableAmount": 0,
    "discountedAmount": 0,
    "paidAmount": 0,
    "refundedAmount": 0,
    "refundedDiscountAmount": 0,
    "refundedPaidAmount": 0,
    "payToken": "string",
    "transactionId": "string",
    "cardMethodType": "string",
    "cardNumber": "string",
    "cardUserType": "string",
    "cardNum4Print": "string",
    "cardBinNumber": "string",
    "accountBankCode": "string",
    "accountBankName": "string",
    "accountNumber": "string"
  }
}
```

***

## 5. 결제 상태 조회하기

생성된 결제 건의 거래 상태와 트랜잭션을 조회할 수 있어요.\
승인 혹은 환불 응답을 수신하지 못한 경우에도 활용할 수 있어요.

* Content-type: `application/json`
* Method: `POST`
* URL: `/api-partner/v1/apps-in-toss/pay/get-payment-status`

**요청 헤더**

| 이름            | 타입   | 필수 | 설명                                        |
| --------------- | ------ | ---- | ------------------------------------------- |
| x-toss-user-key | string | Y    | 토스 로그인을 통해 획득한 userKey 값이에요. |

**요청 파라미터**

| 이름          | 타입    | 필수 | 설명                                                                                    |
| ------------- | ------- | ---- | --------------------------------------------------------------------------------------- |
| payToken      | String  | Y    | 토스페이 토큰이에요.                                                                    |
| orderNo       | String  | Y    | 가맹점 주문번호예요.                                                                    |
| isTestPayment | boolean | Y    | `payToken`이 샌드박스에서 발급된 것이면 `true`, 라이브앱에서 발급된 것이면 `false`예요. |

**응답**

| 이름                 | 타입    | 설명                                                                                   |
| -------------------- | ------- | -------------------------------------------------------------------------------------- |
| mode                 | String  | 결제 환경이에요. `LIVE`: 실거래용, `TEST`: 테스트용                                    |
| payToken             | String  | 토스페이 토큰이에요.                                                                   |
| orderNo              | String  | 토스페이와 연계된 가맹점 주문번호예요.                                                 |
| payStatus            | String  | 결제 상태예요.                                                                         |
| payMethod            | String  | 결제수단이에요. `TOSS_MONEY`: 토스머니, `CARD`: 카드                                   |
| amount               | Integer | 가맹점이 전달한 결제 총 금액이에요.                                                    |
| discountedAmount     | Integer | 할인된 금액이에요.                                                                     |
| discountAmountV2     | Integer | 즉시 할인 적용 금액이에요.                                                             |
| paidPointV2          | Integer | 토스 포인트 사용금액이에요.                                                            |
| paidAmount           | Integer | 지불수단 승인금액이에요.                                                               |
| refundableAmount     | Integer | 환불 가능 잔액이에요.                                                                  |
| amountTaxable        | Integer | 총 결제 금액 중 과세 금액이에요.                                                       |
| amountTaxFree        | Integer | 총 결제 금액 중 비과세 금액이에요.                                                     |
| amountVat            | Integer | 총 결제 금액 중 부가세 금액이에요.                                                     |
| amountServiceFee     | Integer | 총 결제 금액 중 봉사료예요.                                                            |
| disposableCupDeposit | Integer | 일회용 컵 보증금이에요.                                                                |
| accountBankCode      | String  | 은행 코드예요.                                                                         |
| accountBankName      | String  | 은행명이에요.                                                                          |
| accountNumber        | String  | 마스킹된 계좌번호예요.                                                                 |
| card                 | Object  | 카드 정보예요.                                                                         |
| noInterest           | Boolean | 카드 무이자 적용 여부예요. `true`: 무이자, `false`: 일반                               |
| spreadOut            | Integer | 사용자가 선택한 카드 할부개월이에요.                                                   |
| cardAuthorizationNo  | String  | 구매자가 확인할 수 있는 카드사 승인번호예요.                                           |
| cardMethodType       | String  | 카드 타입이에요. `CREDIT`: 신용카드, `CHECK`: 체크카드, `PREPAYMENT`: 선불카드         |
| cardUserType         | String  | 카드 사용자 구분이에요.                                                                |
| cardNumber           | String  | 마스킹된 카드번호예요.                                                                 |
| cardBinNumber        | String  | 카드 BIN 번호예요.                                                                     |
| cardNum4Print        | String  | 사용자가 선택한 카드의 끝 4자리예요.                                                   |
| salesCheckLinkUrl    | String  | 신용카드 매출전표 호출 URL이에요.                                                      |
| cardCompanyName      | String  | 승인 카드사명이에요.                                                                   |
| cardCompanyCode      | Integer | 카드사 코드예요.                                                                       |
| transactions         | list    | 거래 트랜잭션 목록이에요.                                                              |
| stepType             | String  | 요청된 거래 타입이에요. `PAY`: 결제, `REFUND`: 환불                                    |
| transactionId        | String  | 거래 트랜잭션 아이디예요. 거래 대사 시 활용하는 것을 권장해요.                         |
| paidAmount           | Integer | 요청된 거래 타입 중 지불수단 금액이에요.                                               |
| transactionAmount    | Integer | 요청된 거래 타입의 가맹점 전달금액이에요. 환불 요청의 경우 마이너스 금액이 내려와요.   |
| discountedAmount     | Integer | 요청된 거래 타입 중 적용된 할인금액이에요. 즉시할인과 토스 포인트 사용금액이 포함돼요. |
| pointAmount          | Integer | 요청된 거래 타입 중 포인트 금액이에요.                                                 |
| regTs                | String  | 요청 처리 시간이에요.                                                                  |
| createdTs            | String  | 결제 생성 시간이에요. 사용자 최초 결제 요청 시간이에요.                                |
| paidTs               | String  | 결제 완료 처리 시간이에요.                                                             |

```json
{
  "resultType": "SUCCESS",
  "success": {
    "mode": "string",
    "payToken": "string",
    "orderNo": "string",
    "payStatus": "string",
    "payMethod": "string",
    "amount": 0,
    "discountedAmount": 0,
    "discountAmountV2": 0,
    "paidPointV2": 0,
    "paidAmount": 0,
    "refundableAmount": 0,
    "amountTaxable": 0,
    "amountTaxFree": 0,
    "amountVat": 0,
    "amountServiceFee": 0,
    "disposableCupDeposit": 0,
    "accountBankCode": "string",
    "accountBankName": "string",
    "accountNumber": "string",
    "card": {
      "noInterest": true,
      "spreadOut": 0,
      "cardAuthorizationNo": "string",
      "cardMethodType": "string",
      "cardUserType": "string",
      "cardNumber": "string",
      "cardBinNumber": "string",
      "cardNum4Print": "string",
      "salesCheckLinkUrl": "string",
      "cardCompanyName": "string",
      "cardCompanyCode": 0
    },
    "transactions": [
      {
        "stepType": "string",
        "transactionId": "string",
        "paidAmount": 0,
        "transactionAmount": 0,
        "discountedAmount": 0,
        "pointAmount": 0,
        "regTs": "string"
      }
    ],
    "createdTs": "string",
    "paidTs": "string"
  }
}
```

***

## 6. 코드 정리

### 결제 상태 리스트

| 값                         | 설명             |
| -------------------------- | ---------------- |
| PAY\_STANDBY                | 결제 대기 중     |
| PAY\_APPROVED               | 구매자 인증 완료 |
| PAY\_CANCEL                 | 결제 취소        |
| PAY\_PROGRESS               | 결제 진행 중     |
| PAY\_COMPLETE               | 결제 완료        |
| REFUND\_PROGRESS            | 환불 진행 중     |
| REFUND\_SUCCESS             | 환불 성공        |
| SETTLEMENT\_COMPLETE        | 정산 완료        |
| SETTLEMENT\_REFUND\_COMPLETE | 환불 정산 완료   |

### 은행코드 리스트

토스머니 결제의 경우 사용자가 선택한 계좌 정보를 함께 전달해요.

| 은행 코드 (accountBankCode) | 은행 명 (accountBankName) |
| --------------------------- | ------------------------- |
| 002                         | KDB산업은행               |
| 003                         | IBK기업은행               |
| 004                         | KB국민은행                |
| 005                         | KEB하나은행               |
| 007                         | 수협은행                  |
| 011                         | NH농협은행                |
| 020                         | 우리은행                  |
| 023                         | SC은행                    |
| 027                         | 씨티은행                  |
| 031                         | 대구은행                  |
| 032                         | 부산은행                  |
| 034                         | 광주은행                  |
| 035                         | 제주은행                  |
| 037                         | 전북은행                  |
| 039                         | 경남은행                  |
| 045                         | MG새마을금고              |
| 048                         | 신협                      |
| 050                         | 저축은행                  |
| 064                         | 산림조합                  |
| 071                         | 우체국                    |
| 081                         | 하나은행                  |
| 088                         | 신한은행                  |
| 089                         | 케이뱅크                  |
| 090                         | 카카오뱅크                |
| 092                         | 토스뱅크                  |
| 103                         | SBI저축은행               |
| 218                         | KB증권                    |
| 230                         | 미래에셋증권              |
| 238                         | 미래에셋증권              |
| 240                         | 삼성증권                  |
| 243                         | 한국투자증권              |
| 247                         | NH투자증권                |
| 261                         | 교보증권                  |
| 262                         | 하이투자증권              |
| 263                         | 현대차투자증권            |
| 264                         | 키움증권                  |
| 265                         | 이베스트증권              |
| 266                         | SK증권                    |
| 267                         | 대신증권                  |
| 269                         | 한화투자증권              |
| 270                         | 하나증권                  |
| 271                         | 토스증권                  |
| 278                         | 신한투자증권              |
| 279                         | DB금융투자                |
| 280                         | 유진투자                  |
| 287                         | 메리츠증권                |
| 888                         | 토스머니                  |
| 889                         | 토스포인트                |

### 카드사코드 리스트

| 카드사 이름  | 카드(매입사) 코드 |
| ------------ | ----------------- |
| 신한         | 1                 |
| 현대         | 2                 |
| 삼성         | 3                 |
| 국민         | 4                 |
| 롯데         | 5                 |
| 하나         | 6                 |
| 우리         | 7                 |
| 농협         | 8                 |
| 씨티(미지원) | 9                 |
| 비씨(BC)     | 10                |

### 에러 코드

| 값                                                            | 설명                                                       |
| ------------------------------------------------------------- | ---------------------------------------------------------- |
| PAYMENT\_EXISTING\_PAYMENT                                      | 이미 존재하는 결제예요.                                    |
| COMMON\_INVALID\_API\_KEY                                        | 바르지 않은 apiKey예요.                                    |
| COMMON\_BREAK\_TIME\_OF\_BANK                                     | 지금은 은행 점검 시간이에요. 점검이 끝난 후 사용해 주세요. |
| [그 외의 에러코드](https://docs-pay.toss.im/guide/error-code) |                                                            |
