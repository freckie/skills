---
url: 'https://developers-apps-in-toss.toss.im/analytics/logging.md'
---
# 로그(이벤트) 가이드

데이터 로깅은 미니앱 성과 개선에 가장 중요한 도구예요.\
사용자 행동과 요소 노출을 기록하면 이탈 지점을 찾고 전환율을 개선하며 마케팅 전략을 고도화할 수 있어요.\
단순히 데이터를 쌓는 것이 목적이 아니라, **사용자가 어디에서 멈추는지**와 **무엇에 반응하는지**를 파악하는 것이 핵심이에요.

***

## 요약 빠르게 보기

* 페이지 이동 로그는 자동 기록돼요. 추가 설정 불필요해요.
* 클릭 이벤트와 요소 노출 이벤트는 직접 설정하면 더 정교하게 분석할 수 있어요.
* SDK 버전 `0.0.26` 이상에서 데이터 확인이 가능해요.

***

## 로깅을 잘 활용하는 원칙

* 의미 있는 상호작용만 기록해요\
  버튼 클릭, 상품 조회, 결제 완료처럼 실제 분석 가치가 있는 이벤트 중심으로 기록하세요.

* 파라미터를 구체적으로 설정해요\
  예를 들어 `button_name: "subscribe_button"`처럼 구체적으로 지정하면 무엇이 성과를 내는지 명확해져요.

* 전환 퍼널을 중심으로 설계해요\
  각 단계별 이탈률을 측정해 UI 개선이나 프로모션 타겟팅에 활용하세요.

***

## 사전 요구사항

* SDK 버전 `0.0.26` 이상이어야 해요.
* 샌드박스나 출시 준비 단계 데이터는 제공되지 않으며 실제 런칭 후 데이터부터 집계돼요.
* 서비스 런칭 다음 날부터 분석 화면에서 데이터를 확인할 수 있어요.

SDK에서 `Analytics` 객체를 사용하는 방법은 [사용자 행동 기록하기](/bedrock/reference/framework/분석/Analytics.html) 문서를 참고해 주세요.

***

## 클릭 이벤트 로깅 예시

사용자가 버튼을 클릭했을 때 이벤트를 전송하는 기본 패턴이에요.

```javascript
import { Analytics } from '@apps-in-toss/web-framework';

document.getElementById('myButton').addEventListener('click', function () {
  Analytics.click({ button_name: 'my_button' });
  // 클릭 후 실행할 추가 동작을 여기에 작성하세요.
});
```

* `Analytics.click`는 클릭 이벤트를 로깅해요.
* `button_name`은 버튼을 식별하는 값이에요. 가능한 한 화면과 기능을 쉽게 구분할 수 있는 이름을 사용하세요.

***

## 요소 노출 이벤트 로깅 예시

특정 요소가 화면에 보일 때 노출 이벤트를 보내면 어떤 콘텐츠가 주목받는지 알 수 있어요.

```javascript
import { Analytics } from '@apps-in-toss/web-framework';

const target = document.getElementById('impressionItem');

const observer = new IntersectionObserver(
  ([entry]) => {
    if (entry.isIntersecting) {
      Analytics.impression({ item_id: target.dataset.itemId });
      observer.disconnect();
    }
  },
  { threshold: 0.1 },
);

observer.observe(target);
```

* `IntersectionObserver`는 요소가 화면에 10% 이상 보일 때 콜백을 실행해요.
* `Analytics.impression`은 노출 이벤트를 로깅해요.
* `item_id`는 노출된 아이템을 식별하는 값이에요.

### HTML 예시

```html
<div id="impressionItem" data-item-id="1234">노출을 감지할 요소</div>
```

***

## 이벤트 파라미터

이벤트 파라미터는 이벤트와 함께 전달하는 추가 정보예요.\
같은 이벤트라도 어떤 파라미터를 함께 보내느냐에 따라,
콘솔에서 더 세분화된 분석이 가능해요.

이때 `log_name`은 콘솔에 표시되는 이벤트 이름이에요.\
콘솔의 **분석 > 이벤트** 화면에서 이벤트를 구분하는 기준이 되기 때문에, 의미가 명확한 이름을 사용하는 것이 중요해요.

예를 들어 `product_detail_screen`라는 화면 이벤트에 `product_id`, `product_category` 같은 파라미터를 함께 보내면 어떤 상품이나 카테고리가 더 많이 조회되는지 확인할 수 있어요.

### 이벤트 파라미터 예시

상품 상세 화면에 진입했을 때, 화면 이벤트와 함께
현재 보고 있는 상품 정보를 파라미터로 전달할 수 있어요.

```javascript
import { Analytics } from '@apps-in-toss/web-framework';

Analytics.screen({
  log_name: 'product_detail_screen',
  product_id: 'prod_123',
  product_name: '무선 이어폰',
  product_category: 'electronics',
  price: 29900,
});
```

* log\_name은 콘솔에 표시되는 이벤트 명이에요.
* 나머지 값들은 해당 이벤트에 함께 저장되는 커스텀 파라미터예요.

### 콘솔에서 어떻게 보이나요

위와 같이 이벤트를 전송하면, 콘솔 > **분석 > 이벤트** 메뉴에서 이벤트를 확인할 수 있어요.\
이벤트 상세 화면에서는 다음 정보를 확인할 수 있어요.

* 이벤트 발생 추이(그래프)
* 최근 발생 수
* 함께 전송된 파라미터 목록
  * `product_id`
  * `product_name`
  * `product_category`
  * `price`

파라미터 목록에서 특정 키를 선택하면, 해당 파라미터의 실제 값과 발생 현황을 확인할 수 있어요.

### Click 이벤트 파라미터 예시

사용자가 상품 구매 버튼을 클릭했을 때,\
클릭 이벤트와 함께 상품 정보를 전달할 수 있어요.

```javascript
import { Analytics } from '@apps-in-toss/web-framework';

Analytics.click({
  log_name: 'purchase_button_click',
  product_id: 'prod_123',
  product_name: '무선 이어폰',
  product_price: 29900,
  product_category: 'electronics',
});
```

이렇게 전송한 이벤트는 콘솔에서 `purchase_button_click` 이벤트로 집계돼요.\
이를 통해 다음과 같은 분석이 가능해요.

* 어떤 상품이 가장 많이 클릭됐는지
* 어떤 카테고리의 상품이 전환으로 이어지는지
* 가격대별 클릭 패턴 비교

***

## 콘솔에서 데이터 확인하기

로깅 데이터는 관리 콘솔의 **분석 > 이벤트** 메뉴에서 확인해요.\
해당 화면에서 클릭률, 노출 대비 전환율, 주요 이탈 지점을 바로 볼 수 있어요.

***

## 베스트 프랙티스

* 이벤트 이름과 파라미터는 표준화해요\
  팀 내 이벤트 네이밍 규칙을 만들고 일관되게 사용하세요. 예: `category_action_label` 형태

* 불필요한 이벤트는 기록하지 마세요\
  너무 많은 이벤트는 노이즈가 돼요. 분석 목적을 기준으로 선별하세요.

* 추가 속성은 구조화해서 전송하세요\
  예: `item_id`, `item_category`, `price`, `position` 등을 포함하면 세분화된 분석이 가능해요.

* 개인정보나 민감 정보는 로깅하지 마세요\
  사용자 식별자 사용 시 익명화 또는 해시 처리 정책을 따르세요.

* 에러 핸들링과 재시도 로직을 마련하세요\
  네트워크 실패로 이벤트 전송이 실패할 때를 대비해 큐잉 또는 재시도 전략을 적용하면 데이터 유실을 줄일 수 있어요.

***

## 트러블슈팅 요약

* 아이템 노출이나 클릭이 기록되지 않을 때
  1. `Analytics` 호출 위치가 DOM 상에 존재하는지 확인하세요.
  2. 콜백 등록 시점이 늦어 이벤트를 놓치지 않았는지 확인하세요. 스크립트는 가급적 상단에 배치하세요.

* 콘솔에 데이터가 보이지 않을 때
  1. SDK 버전이 `0.0.26` 이상인지 확인하세요.
  2. 서비스가 실제로 런칭되어 있는지 확인하세요. 샌드박스 데이터는 제공되지 않아요.

* 이벤트 파라미터가 비어 있을 때
  1. 전송하는 객체의 키 이름과 값이 올바른지 확인하세요.
  2. JSON 직렬화 오류 등 클라이언트 측 에러가 없는지 확인하세요.
