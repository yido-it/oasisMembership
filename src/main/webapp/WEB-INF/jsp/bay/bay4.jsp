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
				<div class="card m-0" data-card-height="320" style="background: url(/images/gallery/open_main8.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-overlay bg-gradient"></div>
				</div>
				<div class="card m-0" data-card-height="320" style="background: url(/images/gallery/open_main9.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-overlay bg-gradient"></div>
				</div>
				<div class="card m-0" data-card-height="320" style="background: url(/images/gallery/open_main7.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-overlay bg-gradient"></div>
				</div>
				<div class="card m-0" data-card-height="320" style="background: url(/images/gallery/open_main10.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-overlay bg-gradient"></div>
				</div>
				<div class="card m-0" data-card-height="320" style="background: url(/images/gallery/open_main6.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-overlay bg-gradient"></div>
				</div>
			</div>
		</div>
		
		<div class="card card-clear" data-card-height="323"></div>
        
        <div class="card card-full rounded-m">
	        <div class="page-content p-4">
		    	
		        <h2 class="py-3">OPEN BAY&amp;BUNKER<br>VIRTUAL GREEN</h2>
		        <span class="bg-green-dark font-15 px-3 py-1 text-uppercase rounded-xs">2F &nbsp;오픈베이 &amp; 벙커 &amp; 버츄얼그린</span>
		        
				<h5 class="mt-4"><b>운영시간</b></h5>
				<ul>
					<li>08:00-22:00</li>
				</ul>
				
				<h5><b>Open Bay</b></h5>
				<ul>
					<li>타이거 우즈가 신뢰하는 Full Swing KIT 런치 모니터를 통해 스윙의 데이터를 분석합니다. </li>
					<li>6개의 오픈 타석으로 탁트인 공간에서 자유롭게 연습이 가능하며, 일반 레슨과 주니어 그룹 레슨이 진행되고 있습니다.</li>
				</ul>
				
				<h5><b>Bunker</b></h5>
				<ul>
					<li>프리미엄 샌드로 구성된 벙커로, 서울 시내 중심에서 야외 벙커를 즐기실 수 있습니다.</li>
					<li>숏게임 레슨도 가능하며, 다양한 시타채가 구비되어 있습니다.</li>
				</ul>
				
				<h5><b>Virtual Green</b></h5>
				<ul>
					<li>최첨단 기술이 반영된 Virtual Green을 경험하실 수 있습니다.</li>
					<li>그린을 설정하여 다양한 환경에서 퍼팅 연습하실 수 있습니다.</li>
				</ul>
				
				<h5 class="mt-4"><b>위치안내</b></h5>
				<img class="mb-4" src="/images/bay/F2.jpg" style="width: 100%;">
			</div>
		</div>
	</div>
	
	<!-- 하단바 -->
	<jsp:include page="../common/footerBar.jsp" />

</body>
</html>