<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>장바구니 - 모닥모닥</title>
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <link rel="stylesheet" href="cart.css" />
</head>
<body>

<!-- ===== 메인 ===== -->
<main class="main-wrap">

  <!-- 브레드크럼 -->
  <div class="breadcrumb">
    <a href="#">홈</a>
    <span class="bc-sep">/</span>
    <a href="#">장바구니</a>
    <span class="bc-sep">/</span>
    <strong>장바구니</strong>
    <span class="bc-badge" id="totalCartBadge">0</span>
  </div>

  <!-- 탭 -->
  <div class="cart-tabs">
    <button class="tab-btn active" data-tab="rental" onclick="switchTab('rental')">
      대여 장바구니
      <span class="tab-badge" id="rentalTabBadge">0</span>
    </button>
    <button class="tab-btn" data-tab="purchase" onclick="switchTab('purchase')">
      구매 장바구니
      <span class="tab-badge" id="purchaseTabBadge">0</span>
    </button>
  </div>

  <!-- 콘텐츠 -->
  <div class="cart-layout">

    <!-- ── 왼쪽 상품 목록 ── -->
    <div class="cart-left">

      <!-- 대여 패널 -->
      <div id="panel-rental" class="tab-panel">

        <div class="period-bar">
          <span class="period-label">대여 기간</span>
          <input type="date" id="rentalStart" class="date-input" onchange="onDateChange()" />
          <span class="period-arrow">→</span>
          <input type="date" id="rentalEnd" class="date-input" onchange="onDateChange()" />
          <span class="nights-badge" id="nightsBadge"></span>
        </div>

        <div class="select-all-bar">
          <label class="chk-label">
            <input type="checkbox" id="allRentalChk" onchange="toggleAllRental(this)" />
            <span class="chk-box"></span>
            전체 선택&nbsp;<span id="rentalSelCount">0</span>/<span id="rentalTotalCount">0</span>개
          </label>
          <button class="text-btn" onclick="deleteSelectedRental()">선택 삭제</button>
        </div>

        <div id="rentalItemList">
          <div class="loading-msg">장바구니를 불러오는 중...</div>
        </div>

        <div class="add-product-btn" onclick="location.href='/products?type=rental'">
          + 대여 상품 추가하기
        </div>
      </div>

      <!-- 구매 패널 -->
      <div id="panel-purchase" class="tab-panel" style="display:none">

        <div class="select-all-bar">
          <label class="chk-label">
            <input type="checkbox" id="allPurchaseChk" onchange="toggleAllPurchase(this)" />
            <span class="chk-box"></span>
            전체 선택&nbsp;<span id="purchaseSelCount">0</span>/<span id="purchaseTotalCount">0</span>개
          </label>
          <button class="text-btn" onclick="deleteSelectedPurchase()">선택 삭제</button>
        </div>

        <div id="purchaseItemList">
          <div class="loading-msg">장바구니를 불러오는 중...</div>
        </div>

        <div class="add-product-btn" onclick="location.href='/products?type=purchase'">
          + 구매 상품 추가하기
        </div>
      </div>

    </div><!-- /cart-left -->

    <!-- ── 오른쪽 주문 요약 ── -->
    <aside class="order-summary">
      <h3 class="summary-title">주문 요약</h3>

      <div class="summary-row">
        <span>상품 금액 (<span id="summaryItemCount">0</span>개)</span>
        <span id="summaryProductPrice">0원</span>
      </div>
      <div class="summary-row discount-row">
        <span>할인 금액</span>
        <span id="summaryDiscount">-0원</span>
      </div>
      <div class="summary-row" id="summaryPeriodRow" style="display:none">
        <span>대여 기간</span>
        <span id="summaryPeriodText">-</span>
      </div>
      <div class="summary-row">
        <span>배송비</span>
        <span class="free-label">무료</span>
      </div>

      <div class="coupon-row">
        <input type="text" id="couponInput" class="coupon-input" placeholder="쿠폰 선택" />
        <button class="coupon-apply-btn" onclick="applyCoupon()">적용</button>
      </div>

      <hr class="summary-divider" />

      <div class="summary-final-row">
        <span>최종 결제 금액</span>
        <span class="final-price" id="summaryFinalPrice">0원</span>
      </div>
      <p class="vat-note">VAT 포함</p>

      <button class="checkout-btn" onclick="goCheckout()">결제하기 →</button>

      <p class="cancel-note">
        반나 전 취소 불가합니다.<br />
        반나 주 영업일 기준 최대 3일 내 환불됩니다.
      </p>
    </aside>

  </div><!-- /cart-layout -->

  <!-- ===== 추천 상품 ===== -->
  <section class="rec-section" id="recSection">
    <h3 class="rec-title">함께 대여하면 좋아요</h3>
    <div class="rec-list" id="recList"></div>
  </section>

</main>

<script src="cart.js"></script>
</body>
</html>