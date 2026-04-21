<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>모닥모닥 - 장비 목록</title>

<!-- 구글 폰트 -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Serif+KR:wght@300;400;600&family=Noto+Sans+KR:wght@300;400;500&display=swap" rel="stylesheet">

<!-- jQuery, Vue3 -->
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<script src="https://unpkg.com/vue@3/dist/vue.global.js"></script>

<!-- <style>
/* ════════════════════════════════════════
   1. CSS 변수 (색상, 공통 디자인 토큰)
   ════════════════════════════════════════ */
:root {
  --forest:    #2C3E2D;
  --pine:      #3D5A40;
  --moss:      #5A7A4E;
  --sage:      #8FAF7E;
  --mist:      #C8D8B8;
  --smoke:     #EDF2E6;
  --ember:     #C8602A;
  --flame:     #E8884A;
  --ash:       #F5EFE4;
  --bark:      #7A5C3E;
  --stone:     #A09080;
  --parchment: #FBF7F0;
  --ink:       #1E2A1F;
  --border:    rgba(90,122,78,0.15);
  --card-bg:   #FDF9F3;
}
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
html { scroll-behavior: smooth; }
body {
  background: var(--parchment);
  color: var(--ink);
  font-family: 'Noto Sans KR', sans-serif;
  font-weight: 300;
  line-height: 1.7;
  min-height: 100vh;
}

/* ════════════════════════════════════════
   2. 상단 내비게이션 바
   ════════════════════════════════════════ */
nav {
  display: flex; align-items: center; justify-content: space-between;
  padding: 0 48px; height: 60px;
  background: var(--forest);
  position: sticky; top: 0; z-index: 200;
}
.nav-logo { display: flex; align-items: center; gap: 10px; text-decoration: none; }
.logo-text { font-family: 'Noto Serif KR', serif; font-size: 16px; font-weight: 600; color: #FBF7F0; letter-spacing: .06em; }
.nav-links { display: flex; gap: 28px; }
.nav-links a { font-size: 12px; color: var(--mist); text-decoration: none; letter-spacing: .08em; transition: color .2s; }
.nav-links a:hover { color: #fff; }
.nav-links a.active { color: var(--flame); }
.nav-right { display: flex; align-items: center; gap: 12px; }
.nav-icon { color: var(--mist); cursor: pointer; }
.nav-icon svg { width: 18px; height: 18px; stroke: currentColor; fill: none; stroke-width: 1.4; }
.nav-cta {
  font-size: 11px; padding: 6px 16px;
  border: 1px solid var(--sage); border-radius: 2px;
  color: var(--mist); background: transparent; cursor: pointer;
  letter-spacing: .08em; transition: all .2s;
}
.nav-cta:hover { background: var(--sage); color: var(--forest); }

/* ════════════════════════════════════════
   3. 브레드크럼 (경로 표시)
   ════════════════════════════════════════ */
.breadcrumb {
  padding: 14px 0;
  border-bottom: 1px solid var(--border);
  background: var(--parchment);
}
.breadcrumb-inner {
  max-width: 1200px; margin: 0 auto; padding: 0 32px;
  display: flex; align-items: center; gap: 6px;
}
.bc { font-size: 12px; color: var(--stone); text-decoration: none; transition: color .2s; }
.bc:hover { color: var(--ember); }
.bc-sep { font-size: 11px; color: var(--mist); }
.bc-current { font-size: 12px; color: var(--ink); }

/* ════════════════════════════════════════
   4. 카테고리 필터 pill 바 (가로 스크롤)
   ════════════════════════════════════════ */
.cat-bar {
  background: var(--parchment);
  border-bottom: 1px solid var(--border);
  padding: 16px 0;
  position: sticky; top: 60px; z-index: 100;
}
.cat-bar-inner {
  max-width: 1200px; margin: 0 auto; padding: 0 32px;
  display: flex; align-items: center; gap: 10px;
  overflow-x: auto; scrollbar-width: none;
}
.cat-bar-inner::-webkit-scrollbar { display: none; }
.cat-pill {
  display: flex; align-items: center; gap: 7px;
  padding: 8px 16px; border-radius: 40px;
  border: 1px solid var(--border); background: var(--card-bg);
  font-size: 12px; font-weight: 300; color: var(--stone);
  cursor: pointer; transition: all .2s; white-space: nowrap;
  font-family: 'Noto Sans KR', sans-serif;
}
.cat-pill .pill-emoji { font-size: 14px; line-height: 1; }
.cat-pill:hover { border-color: var(--ember); color: var(--ember); }
/* Vue :class 바인딩으로 active 클래스 제어 */
.cat-pill.active { background: var(--ember); border-color: var(--ember); color: #fff; font-weight: 400; }
.cat-pill.active .pill-emoji { filter: brightness(10); }

/* ════════════════════════════════════════
   5. 메인 레이아웃 (페이지 감싸기)
   ════════════════════════════════════════ */
.page-wrap { max-width: 1200px; margin: 0 auto; padding: 32px 32px 80px; }

.top-row {
  display: flex; align-items: flex-end; justify-content: space-between;
  margin-bottom: 24px; flex-wrap: wrap; gap: 14px;
}
.result-label { font-size: 12px; color: var(--stone); margin-bottom: 4px; letter-spacing: .04em; }
.result-title { font-family: 'Noto Serif KR', serif; font-size: 22px; font-weight: 400; color: var(--forest); }
.result-count { font-size: 13px; color: var(--stone); margin-left: 8px; }
.controls { display: flex; align-items: center; gap: 10px; flex-wrap: wrap; }

/* 정렬 셀렉트 박스 */
.sort-select {
  padding: 8px 28px 8px 14px;
  border: 1px solid var(--border); border-radius: 3px;
  background: var(--card-bg);
  font-family: 'Noto Sans KR', sans-serif; font-size: 12px; color: var(--ink);
  cursor: pointer; outline: none; -webkit-appearance: none;
  background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%23A09080' stroke-width='2'%3E%3Cpolyline points='6 9 12 15 18 9'/%3E%3C/svg%3E");
  background-repeat: no-repeat; background-position: right 10px center;
}
.sort-select:focus { border-color: var(--ember); }

/* 그리드 / 리스트 뷰 전환 버튼 */
.view-toggle { display: flex; border: 1px solid var(--border); border-radius: 3px; overflow: hidden; }
.vbtn {
  padding: 7px 11px; background: var(--card-bg); border: none;
  cursor: pointer; color: var(--stone); transition: all .2s;
}
.vbtn:hover { background: var(--smoke); }
.vbtn.active { background: var(--ember); color: #fff; }
.vbtn svg { width: 15px; height: 15px; stroke: currentColor; fill: none; stroke-width: 1.5; display: block; }

/* 필터 토글 버튼 */
.filter-toggle {
  display: flex; align-items: center; gap: 6px;
  padding: 8px 14px; border: 1px solid var(--border); border-radius: 3px;
  background: var(--card-bg); font-size: 12px; color: var(--stone);
  cursor: pointer; font-family: 'Noto Sans KR', sans-serif; transition: all .2s;
}
.filter-toggle:hover { border-color: var(--ember); color: var(--ember); }
.filter-toggle svg { width: 14px; height: 14px; stroke: currentColor; fill: none; stroke-width: 1.5; }
.filter-badge {
  background: var(--ember); color: #fff; font-size: 10px;
  width: 16px; height: 16px; border-radius: 50%;
  display: flex; align-items: center; justify-content: center; font-weight: 500;
}

/* ════════════════════════════════════════
   6. 사이드바 (필터 패널)
   ════════════════════════════════════════ */
.content-wrap { display: flex; gap: 28px; align-items: flex-start; }
.sidebar {
  width: 220px; flex-shrink: 0;
  background: var(--card-bg); border: 1px solid var(--border);
  border-radius: 6px; overflow: hidden; transition: all .3s;
}
/* Vue v-show로 숨김/표시 제어 */
.filter-section { border-bottom: 1px solid var(--border); padding: 18px 20px; }
.filter-section:last-child { border-bottom: none; }
.fs-header {
  display: flex; align-items: center; justify-content: space-between;
  cursor: pointer; margin-bottom: 14px;
}
.fs-title { font-size: 12px; font-weight: 500; color: var(--forest); letter-spacing: .06em; }
.fs-arrow { width: 12px; height: 12px; stroke: var(--stone); fill: none; stroke-width: 2; transition: transform .2s; }
.fs-arrow.open { transform: rotate(180deg); }
.filter-opts { display: flex; flex-direction: column; gap: 8px; }
.fopt {
  display: flex; align-items: center; gap: 8px; cursor: pointer;
  font-size: 12px; color: var(--stone); transition: color .15s;
}
.fopt:hover { color: var(--ember); }
.fopt input { accent-color: var(--ember); cursor: pointer; }
.fopt-count { margin-left: auto; font-size: 11px; color: var(--mist); }

/* 가격 범위 슬라이더 */
.range-wrap { padding-top: 4px; }
.range-row { display: flex; justify-content: space-between; margin-bottom: 8px; }
.range-val { font-size: 11px; color: var(--stone); }
input[type=range] {
  -webkit-appearance: none; width: 100%; height: 3px;
  background: linear-gradient(to right, var(--ember) 0%, var(--ember) 50%, var(--border) 50%, var(--border) 100%);
  border-radius: 3px; outline: none; cursor: pointer;
}
input[type=range]::-webkit-slider-thumb {
  -webkit-appearance: none; width: 14px; height: 14px;
  border-radius: 50%; background: var(--ember);
  border: 2px solid #fff; box-shadow: 0 1px 4px rgba(200,96,42,.3);
}
.filter-reset {
  width: 100%; margin-top: 14px; padding: 9px;
  border: 1px solid var(--border); border-radius: 3px;
  background: transparent; font-family: 'Noto Sans KR', sans-serif;
  font-size: 12px; color: var(--stone); cursor: pointer; transition: all .2s;
}
.filter-reset:hover { border-color: var(--ember); color: var(--ember); }

/* ════════════════════════════════════════
   7. 상품 카드 (그리드 뷰)
   ════════════════════════════════════════ */
.grid-wrap { flex: 1; min-width: 0; }
.product-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 18px;
}
/* 리스트 뷰일 때 그리드 변경 */
.product-grid.view-list { grid-template-columns: 1fr; gap: 12px; }

.pcard {
  background: var(--card-bg); border: 1px solid var(--border);
  border-radius: 10px; overflow: hidden;
  transition: transform .25s, box-shadow .25s;
  cursor: pointer; position: relative;
}
.pcard:hover { transform: translateY(-4px); box-shadow: 0 12px 32px rgba(44,62,45,.1); }

/* 카드 이미지 영역 */
.pcard-img {
  position: relative; background: var(--ash);
  aspect-ratio: 1 / 0.85;
  display: flex; align-items: center; justify-content: center; overflow: hidden;
}
.pcard-emoji { font-size: 56px; line-height: 1; user-select: none; }

/* 찜(위시리스트) 버튼 */
.pcard-wish {
  position: absolute; top: 12px; right: 12px;
  width: 30px; height: 30px; border-radius: 50%;
  background: rgba(255,255,255,.85);
  display: flex; align-items: center; justify-content: center;
  border: none; cursor: pointer; transition: all .2s;
}
.pcard-wish svg { width: 15px; height: 15px; stroke: #A09080; fill: none; stroke-width: 1.6; transition: all .2s; }
.pcard-wish:hover svg { stroke: var(--ember); }
/* Vue :class로 wished 상태 토글 */
.pcard-wish.wished svg { stroke: var(--ember); fill: var(--ember); }

/* 뱃지 (NEW, 인기, 할인 등)
.badge-row { position: absolute; top: 12px; left: 12px; display: flex; gap: 5px; }
.pbadge { font-size: 10px; padding: 3px 8px; border-radius: 3px; font-weight: 500; letter-spacing: .04em; }
.pbadge-hot  { background: #E8453C; color: #fff; }
.pbadge-sale { background: var(--ember); color: #fff; }
.pbadge-new  { background: var(--forest); color: var(--mist); }
.pbadge-best { background: var(--bark); color: #FAF0E0; } */

/* 카드 텍스트 영역 */
.pcard-body { padding: 14px 16px 16px; }
.pcard-cat  { font-size: 10px; color: var(--stone); letter-spacing: .06em; margin-bottom: 4px; }
.pcard-name {
  font-size: 13px; font-weight: 400; color: var(--ink);
  margin-bottom: 7px; line-height: 1.4;
  display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;
}
.stars { display: flex; align-items: center; gap: 4px; margin-bottom: 8px; }
.star { font-size: 10px; color: var(--flame); }
.star-count { font-size: 11px; color: var(--stone); }
.price-row { display: flex; align-items: baseline; gap: 6px; margin-bottom: 12px; }
.price-main { font-size: 16px; font-weight: 500; color: var(--ink); }
.price-unit { font-size: 11px; color: var(--stone); }
.price-orig { font-size: 11px; color: var(--mist); text-decoration: line-through; }

/* 버튼 행 (대여 / 구매) */
.btn-row { display: flex; gap: 7px; }
.btn-rent {
  flex: 1; padding: 9px 0;
  background: var(--ember); color: #fff;
  border: none; border-radius: 4px;
  font-family: 'Noto Sans KR', sans-serif; font-size: 12px; letter-spacing: .04em;
  cursor: pointer; transition: background .2s;
}
.btn-rent:hover { background: var(--flame); }
.btn-buy {
  flex: 1; padding: 9px 0;
  background: transparent; color: var(--forest);
  border: 1px solid var(--border); border-radius: 4px;
  font-family: 'Noto Sans KR', sans-serif; font-size: 12px; letter-spacing: .04em;
  cursor: pointer; transition: all .2s;
}
.btn-buy:hover { border-color: var(--forest); background: var(--smoke); }

/* ════════════════════════════════════════
   8. 리스트 뷰 카드 (가로 레이아웃)
   ════════════════════════════════════════ */
.pcard.list-card { display: flex; flex-direction: row; border-radius: 8px; }
.pcard.list-card .pcard-img {
  width: 160px; flex-shrink: 0;
  aspect-ratio: auto; height: auto; min-height: 130px; border-radius: 0;
}
.pcard.list-card .pcard-emoji { font-size: 44px; }
.pcard.list-card .pcard-body {
  flex: 1; display: flex; align-items: center;
  gap: 24px; flex-wrap: wrap; padding: 16px 20px;
}
.pcard.list-card .pcard-main { flex: 1; min-width: 180px; }
.pcard.list-card .pcard-price-wrap { text-align: right; min-width: 100px; }
.pcard.list-card .pcard-price-wrap .price-main { font-size: 18px; }
.pcard.list-card .btn-row { flex-direction: column; min-width: 110px; gap: 6px; }
.pcard.list-card .btn-rent,
.pcard.list-card .btn-buy { padding: 8px 16px; }

/* ════════════════════════════════════════
   9. 페이지네이션
   ════════════════════════════════════════ */
.pagination {
  display: flex; align-items: center; justify-content: center;
  gap: 4px; margin-top: 48px;
}
.ppage {
  width: 34px; height: 34px; border-radius: 3px;
  display: flex; align-items: center; justify-content: center;
  font-size: 13px; color: var(--stone);
  border: 1px solid transparent; cursor: pointer; transition: all .2s;
  background: none; font-family: 'Noto Sans KR', sans-serif;
}
.ppage:hover { border-color: var(--border); color: var(--ink); }
.ppage.active { background: var(--ember); color: #fff; border-color: var(--ember); }
.ppage.arrow { border: 1px solid var(--border); background: var(--card-bg); }
.ppage.arrow svg { width: 13px; height: 13px; stroke: currentColor; fill: none; stroke-width: 2; }

/* ════════════════════════════════════════
   10. 데이터 없을 때 빈 상태 표시
   ════════════════════════════════════════ */
.empty { text-align: center; padding: 80px 20px; }
.empty-emoji { font-size: 48px; margin-bottom: 16px; }
.empty-msg { font-size: 14px; color: var(--stone); }

/* ════════════════════════════════════════
   11. 카드 등장 애니메이션
   ════════════════════════════════════════ */
@keyframes fadeUp {
  from { opacity: 0; transform: translateY(14px); }
  to   { opacity: 1; transform: translateY(0); }
}
.pcard { animation: fadeUp .45s ease both; }

/* ════════════════════════════════════════
   12. 반응형 미디어 쿼리
   ════════════════════════════════════════ */
@media (max-width: 900px) {
  .sidebar { display: none; }
  .product-grid { grid-template-columns: repeat(3, 1fr); }
}
@media (max-width: 640px) {
  nav { padding: 0 16px; }
  .nav-links { display: none; }
  .page-wrap { padding: 20px 16px 60px; }
  .cat-bar-inner { padding: 0 16px; }
  .product-grid { grid-template-columns: repeat(2, 1fr); }
  .breadcrumb-inner { padding: 0 16px; }
}
</style> -->
</head>
<body>

<!-- Vue 마운트 대상 루트 요소 -->
<div id="app">

  <!-- ── 상단 내비게이션 ── -->
  <nav>
    <a href="#">
      <svg width="28" height="28" viewBox="0 0 32 32" fill="none">
        <path d="M16 3C16 3 10 10 10 16a6 6 0 0 0 12 0c0-6-6-13-6-13z" fill="#E8884A" opacity=".9"/>
        <path d="M16 10C16 10 12 15 12 18a4 4 0 0 0 8 0c0-3-4-8-4-8z" fill="#FAC878"/>
        <ellipse cx="16" cy="26" rx="7" ry="2.5" fill="#5A7A4E" opacity=".6"/>
      </svg>
      <span>모닥모닥</span>
    </a>

    <div>
      <a href="#">홈</a>
      <a href="#">대여</a>
      <a href="#">구매</a>
      <a href="#">커뮤니티</a>
      <a href="#">고객센터</a>
    </div>

    <div>
      <span>
        <svg viewBox="0 0 24 24"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
      </span>
      <span>
        <svg viewBox="0 0 24 24"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"/></svg>
      </span>
      <span>
        <svg viewBox="0 0 24 24"><circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6"/></svg>
      </span>
      <button>로그인</button>
    </div>
  </nav>

  <!-- ── 브레드크럼 ── -->
  <div>
    <div>
      <a href="#">홈</a>
      <span>›</span>
      <a href="#">장비</a>
    </div>
  </div>

  <!-- ── 카테고리 ── -->
  <div>
    <div>
      <button
        v-for="cat in categories"
        :key="cat.name"
        :class="{ active: currentCat === cat.name }"
        @click="selectCat(cat)"
      >
        <span>{{ cat.emoji }}</span> {{ cat.name }}
      </button>
    </div>
  </div>

  <!-- ── 상단 정보 / 컨트롤 ── -->
  <div>
    <div>
      <div>인기 장비</div>
      <div>
        <span>{{ currentCat === '전체' ? '전체 장비' : currentCat }}</span>
        <span>총 {{ filteredProducts.length }}개</span>
      </div>
    </div>

    <div>
      <button @click="sidebarVisible = !sidebarVisible">
        필터
      </button>

      <select v-model="sortKey" @change="currentPage = 1">
        <option value="popular">인기순</option>
        <option value="newest">최신순</option>
        <option value="price-low">가격 낮은순</option>
        <option value="price-high">가격 높은순</option>
        <option value="rating">평점순</option>
      </select>

      <div>
        <button @click="currentView = 'grid'">GRID</button>
        <button @click="currentView = 'list'">LIST</button>
      </div>
    </div>
  </div>

  <!-- ── 콘텐츠 ── -->
  <div>

    <!-- 사이드바 -->
    <div v-show="sidebarVisible">

      <div>
        <div @click="toggleSection($event)">
          <span>대여 / 구매</span>
        </div>
        <div>
          <label>
            <input type="checkbox" v-model="filter.rentable"> 대여 가능
          </label>
          <label>
            <input type="checkbox" v-model="filter.buyable"> 구매 가능
          </label>
        </div>
      </div>

      <div>
        <div @click="toggleSection($event)">
          <span>대여 기간</span>
        </div>
        <div>
          <label><input type="checkbox" v-model="filter.period" value="1"> 1박 2일</label>
          <label><input type="checkbox" v-model="filter.period" value="2"> 2박 3일</label>
          <label><input type="checkbox" v-model="filter.period" value="3"> 3박 이상</label>
        </div>
      </div>

      <div>
        <div @click="toggleSection($event)">
          <span>1박 가격</span>
        </div>
        <div>
          <span>0원</span>
          <span>{{ priceRangeLabel }}</span>
          <input type="range" v-model="filter.priceRange" @input="updateRangeStyle">
        </div>
      </div>

      <div>
        <div @click="toggleSection($event)">
          <span>평점</span>
        </div>
        <div>
          <label><input type="radio" v-model="filter.minRating" value="5"> 5.0</label>
          <label><input type="radio" v-model="filter.minRating" value="4"> 4.0 이상</label>
          <label><input type="radio" v-model="filter.minRating" value="3"> 3.0 이상</label>
        </div>
      </div>

      <button @click="resetFilter">필터 초기화</button>

    </div>

    <!-- 상품 -->
    <div>

      <div v-if="loading">
        <div>로딩중...</div>
      </div>

      <div v-else-if="pagedProducts.length === 0">
        <div>결과 없음</div>
      </div>

      <div v-else>

        <div
          v-for="(product, idx) in pagedProducts"
          :key="product.productId"
          :class="{ 'list-card': currentView === 'list' }"
        >

          <div>
            <a href="javascript:;" @click="fnView(item.empNo)">
              <img
                :src="product.imgUrl ? '/product-img/' + product.imgUrl : '/product-img/default.jpg'"
              />
            </a>

            <button
              :class="{ wished: wishedIds.has(product.productId) }"
              @click.stop="toggleWish(product.productId)"
            >
              ♥
            </button>
          </div>

          <div>

            <div v-if="currentView === 'list'">
              <div>{{ product.categoryId }}</div>
              <div>{{ product.productName }}</div>
              <div v-html="starsHTML(product.rating)"></div>
              <div>{{ product.rating }} ({{ product.rCount }})</div>
              <div>{{ product.price }}</div>
            </div>

            <div v-else>
              <div>{{ product.productName }}</div>
              <div v-html="starsHTML(product.rating)"></div>
              <div>{{ product.price }}</div>
            </div>

            <div>
              <button v-if="product.productType !== 'PURCHASE'">대여</button>
              <button v-if="product.productType !== 'RENTAL'">구매</button>
            </div>

          </div>

        </div>

      </div>

    </div>

    <!-- 페이지네이션 -->
    <div v-if="totalPages > 1">
      <button @click="goPage(currentPage - 1)">‹</button>

      <button
        v-for="n in totalPages"
        :key="n"
        :class="{ active: n === currentPage }"
        @click="goPage(n)"
      >
        {{ n }}
      </button>

      <button @click="goPage(currentPage + 1)">›</button>
    </div>

  </div>
</div>
<script>
    const app = Vue.createApp({
        data() {
            return {
                // 변수 - (키 : 값)
                // list : [] 
            };
        },
        methods: {
            // 함수(메소드) - (key : function())
            fnList: function () {
                let self = this;
                let param = {
                    // 백엔드로 전달할 데이터
                };
                $.ajax({
                    url: "http://localhost:8080/default.dox",
                    dataType: "json",
                    type: "POST",
                    data: param,
                    success: function (data) {
                        // 받은 데이터를 변수에 저장하세요
                        // self.list = data.list;
                    }
                });
            }
        }, // methods
        mounted() {
            // 처음 시작할 때 실행되는 부분
            let self = this;
        }
    });

    app.mount('#app');
</script>
</body>
</html>
