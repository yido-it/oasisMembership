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
				<div class="card m-0" data-card-height="320" style="background: url(/images/gallery/lesson_main6.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-overlay bg-gradient"></div>
				</div>
				<div class="card m-0" data-card-height="320" style="background: url(/images/gallery/lesson_main7.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-overlay bg-gradient"></div>
				</div>
				<div class="card m-0" data-card-height="320" style="background: url(/images/gallery/lesson_main12.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-overlay bg-gradient"></div>
				</div>
				<div class="card m-0" data-card-height="320" style="background: url(/images/gallery/lesson_main8.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-overlay bg-gradient"></div>
				</div>				
			</div>
		</div> 

		<div class="card card-clear" data-card-height="323"></div>

		<div class="card card-full rounded-m">
	        <div class="page-content p-4">
		    	
		        <h2 class="py-3">LESSON ROOM</h2>
		        <span class="bg-green-dark font-15 px-3 py-1 text-uppercase rounded-xs">3F &nbsp;레슨룸</span>
		        
				<h5 class="mt-4"><b>운영시간</b></h5>
				<ul>
					<li>08:00-22:00</li>
				</ul>
				
				<h5><b>Lesson Room</b></h5>
				<ul>
					<li>타이거 우즈, 존람, 조던 스피스 등 세계 정상급 선수들이 사용하는 Full Swing PRO 가 설치된 프라이빗 룸에서 최고의 프로들에게 체계적이고 열정적인 레슨 받으실 수 있습니다.</li>
				</ul>
				
				<!-- <h5><b>TINO X</b></h5>
				<ul>
					<li>TINO X 의 최신 트렌드를 반영한 골프 용품 쇼핑과 전문적인 클럽 피팅을 받으실 수 있습니다.</li>
					<li>피팅 예약은 미리 문의주시면 도와드리겠습니다.</li>
					<li class="color-red-light">사전예약필수</li>
				</ul> -->
				
				<h5 class="mt-4"><b>위치안내</b></h5>
				<img class="mb-4" src="/images/bay/F3.jpg" style="width: 100%;">			
			</div>
		</div>
	</div>
	
	<!-- 하단바 -->
	<jsp:include page="../common/footerBar.jsp" />

</body>
</html>