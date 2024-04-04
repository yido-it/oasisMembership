<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<jsp:include page="../common/head.jsp" />
<jsp:include page="../common/script.jsp" />

<body class="theme-light pb-5">    
	<div id="preloader"><div class="spinner-border color-highlight" role="status"></div></div>	    
	<div id="page">	
		<!--스크롤내리면 보이는 Header-->
		<div class="header header-auto-show header-fixed header-logo-app">
			<a href="#" class="header-title header-subtitle mt-1">시설안내</a> 
			<a href="javascript:history.back()" class="header-icon header-icon-1 mt-1" id="topGoBack"><i class="fa fa-arrow-left"></i></a>
			<a href="#" data-menu="menu-main" class="header-icon header-icon-2 font-20 mt-1"><i class="fas fa-bars"></i></a> 
		</div>
		
		<!-- 좌측GNB-->
		<jsp:include page="../common/menu.jsp" />
		<!-- //좌측GNB-->
	
		<!--Header-->
		<div class="page-title page-title-fixed" style="opacity: 1; z-index:99; position:absolute">
			<a href="#" class="page-title-icon bg-white float-right mr-3 font-20 color-black" data-menu="menu-main"><i class="fa fa-bars"></i></a>
		</div>
		<!--//Header-->		
         
        <div class="card card-fixed" data-card-height="320">
			<div class="single-slider slider-has-arrows owl-carousel owl-dots-over">
				<div class="card m-0" data-card-height="320" style="background: url(/images/gallery/cave_main10.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-overlay bg-gradient"></div>
				</div>
				<div class="card m-0" data-card-height="320" style="background: url(/images/gallery/cave_main5.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-overlay bg-gradient"></div>
				</div>
				<div class="card m-0" data-card-height="320" style="background: url(/images/gallery/cave_main7.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-overlay bg-gradient"></div>
				</div>
				<div class="card m-0" data-card-height="320" style="background: url(/images/gallery/cave_main9.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-overlay bg-gradient"></div>
				</div>
				<div class="card m-0" data-card-height="320" style="background: url(/images/gallery/cave_main4.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-overlay bg-gradient"></div>
				</div>
			</div>
		</div> 
		
        <div class="card card-clear" data-card-height="323"></div>
        
        <div class="card card-full rounded-m p-4">
	    	
	        <h2 class="py-3">CLUBD CAVE GOLF</h2>
	        <span class="bg-green-dark font-15 px-3 py-1 text-uppercase rounded-xs">B1 &nbsp;클럽디 카브 골프</span>
            
            <h5 class="mt-4"><b>운영시간</b></h5>
			<ul>
				<li>08:00-24:00</li>
			</ul>
			
			<h5 class="mt-4"><b>와이드 스크린</b></h5>
			<ul>
				<li>오픈형 타석으로 가장 큰 BAY 입니다.</li>
				<li>여럿이서 즐기기 좋은 공간으로 4명 이상일 경우 추천드립니다.</li>
			</ul>
			
			<h5 class="mt-4"><b>프라이빗 스크린</b></h5>
			<ul>
				<li>룸 형식 타석으로 프라이빗하게 즐길 수 있는 BAY 입니다.</li>
				<li>여럿이서 즐기기 좋은 공간으로 4명 이상일 경우 추천드립니다.</li>
				<li>3, 4번 BAY를 함께 예약하시면 가벽을 제거하여 공간을 연결해 드립니다.</li>
			</ul>
			
			<h5 class="mt-4"><b>스탠다드 스크린</b></h5>
			<ul>
				<li>스탠다드 형식 타석으로 프라이빗하게 즐길 수 있는 BAY 입니다.</li>
				<li>미니멀한 공간으로 4명 이하일 경우 추천드립니다.</li>
				<li>5, 6번 BAY를 함께 예약하시면 가벽을 제거하여 공간을 연결해 드립니다.</li>
			</ul>
			
			<h5 class="mt-4"><b>기타</b></h5>
			<ul>
				<li>타이거 우즈가 공동개발한 골프 시뮬레이터 ‘Full Swing’이 전 타석 설치되어 있습니다.</li>
				<li>세계 명문 골프장에서 생생한 라운드를 경험 할 수 있습니다.</li>
				<li>골프를 치시는 동안 스타 셰프의 요리와 와인을 드실 수 있습니다.</li>
				<li>축구와 농구 등 다양한 스포츠 게임도 즐기실 수 있습니다.</li>
				<li>클럽을 대여 하실 수 있습니다.</li>
			</ul>
			
			<h5 class="mt-4"><b>위치안내</b></h5>
			<img src="/images/bay/B1.jpg" class="mb-5">
        </div>
	</div>

	<!-- 하단바 -->
	<jsp:include page="../common/footerBar.jsp" />
	
</body>
</html>