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
				<div class="card m-0" data-card-height="320" style="background: url(/images/gallery/store_main10.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-overlay bg-gradient"></div>
				</div>
				<div class="card m-0" data-card-height="320" style="background: url(/images/gallery/store_main11.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-overlay bg-gradient"></div>
				</div>
				<div class="card m-0" data-card-height="320" style="background: url(/images/gallery/store_main12.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-overlay bg-gradient"></div>
				</div>
				<div class="card m-0" data-card-height="320" style="background: url(/images/gallery/store_main13.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-overlay bg-gradient"></div>
				</div>
				<div class="card m-0" data-card-height="320" style="background: url(/images/gallery/store_main14.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-overlay bg-gradient"></div>
				</div>
			</div>
		</div> 

		<div class="card card-clear" data-card-height="323"></div>
        
        <div class="card card-full rounded-m">
	        <div class="page-content p-4">
		    	
		        <h2 class="py-3">RECEPTION<br>POP-UP STORE</h2>
		        <span class="bg-green-dark font-15 px-3 py-1 text-uppercase rounded-xs">1F &nbsp;리셉션 &amp; 팝업스토어</span>
		        
				<h5 class="mt-4"><b>운영시간</b></h5>
				<ul>
					<li>08:00-24:00</li>
				</ul>
				
				<h5><b>Reception</b></h5>
				<ul>
					<li>클럽디 청담의 시설 안내를 받을 수 있는 공간 입니다.</li>
				</ul>
				
				<h5><b>POP-UP Store</b></h5>
				<ul>
					<li>시즌별 최신 트렌드를 반영한 다양한 브랜드의 팝업 전시 및 이벤트가 준비되어 있습니다.</li>
					<li>Full Swing KIT 구매 문의도 가능합니다.</li>
				</ul>
				
				<h5 class="mt-4"><b>위치안내</b></h5>
				<img class="mb-4" src="/images/bay/F1.jpg" style="width: 100%;">
			</div>
		</div>
	</div>
	
	<!-- 하단바 -->
	<jsp:include page="../common/footerBar.jsp" />

</body>
</html>