<!-- 시설안내 페이지 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<jsp:include page="common/head.jsp" />
<jsp:include page="common/script.jsp" />

<body class="theme-light">
    
	<div id="preloader"><div class="spinner-border color-highlight" role="status"></div></div>
    
	<div id="page">
		<!--스크롤header -->
		<div class="header header-fixed header-logo-app">
			<a href="#" class="header-title header-subtitle mt-1">시설안내</a>
			<jsp:include page="common/top.jsp" />
		</div>
		<!--//스크롤header -->
		
		<!-- 하단바 -->
		<jsp:include page="common/footerBar.jsp" />
		
	
		<!-- 좌측GNB-->
		<jsp:include page="common/menu.jsp" />
		<!-- //좌측GNB-->
	
    	<div class="page-content header-clear">
    	
    	<a href="bay1" class="card card-style mr-4 ml-4 mt-5" data-card-height="150" style="background: url(/images/pictures/1.jpg) no-repeat 0 0; background-size: cover">
			<div class="card-center pl-3 pr-3">
				<span class="badge bg-green-dark px-3 py-1 text-uppercase mb-2">B1</span>
				<h3 class="color-white mb-2">CLUBD CAVE<br>GOLF</h3>
			</div>
			<div class="card-center">
				<span class="icon icon-s fr bg-theme mr-2 rounded-xl"><i class="fa fa-arrow-right"></i></span>
			</div>
			<div class="card-overlay bg-black opacity-50"></div>
		</a>
		
		<a href="bay2" class="card card-style mr-4 ml-4" data-card-height="150" style="background: url(/images/gallery/rest_main10.jpg) no-repeat 0 0; background-size: cover">
			<div class="card-center pl-3 pr-5">
				<span class="badge bg-green-dark px-3 py-1 text-uppercase mb-2">B1</span>
				<h3 class="color-white mb-2">CLUBD CAVE<br>RESTAURANT</h3>
			</div>
			<div class="card-center">
				<span class="icon icon-s fr bg-theme mr-2 rounded-xl"><i class="fa fa-arrow-right"></i></span>
			</div>
			<div class="card-overlay bg-black opacity-50"></div>
		</a>
		
		<a href="bay3" class="card card-style mr-4 ml-4" data-card-height="150" style="background: url(/images/gallery/store_main12.jpg) no-repeat 0 0; background-size: cover">
			<div class="card-center pl-3 pr-5">
				<span class="badge bg-green-dark px-3 py-1 text-uppercase mb-2">1F</span>
				<h3 class="color-white mb-2">RECEPTION<br>POP-UP STORE</h3>
			</div>
			<div class="card-center">
				<span class="icon icon-s fr bg-theme mr-3 rounded-xl"><i class="fa fa-arrow-right"></i></span>
			</div>
		
			<div class="card-overlay bg-black opacity-50"></div>
		</a>
		
		<a href="bay4" class="card card-style mr-4 ml-4" data-card-height="150"	style="background: url(/images/gallery/open_main8.jpg) no-repeat 0 0; background-size: cover">
			<div class="card-center pl-3 pr-5">
				<span class="badge bg-green-dark px-3 py-1 text-uppercase mb-2">2F</span>
				<h3 class="color-white mb-2">OPEN BAY&BUNKER<br>VIRTUAL GREEN</h3>
			</div>
			<div class="card-center">
				<span class="icon icon-s fr bg-theme mr-3 rounded-xl"><i class="fa fa-arrow-right"></i></span>
			</div>
			<div class="card-overlay bg-black opacity-50"></div>
		</a>

		<a href="bay5" class="card card-style mr-4 ml-4" data-card-height="150"	style="background: url(/images/gallery/lesson_main8.jpg) no-repeat 0 0; background-size: cover">
			<div class="card-center pl-3 pr-5">
				<span class="badge bg-green-dark px-3 py-1 text-uppercase mb-2">3F</span>
				<h3 class="color-white mb-2">LESSON ROOM</h3>
			</div>
			<div class="card-center">
				<span class="icon icon-s fr bg-theme mr-3 rounded-xl"><i class="fa fa-arrow-right"></i></span>
			</div>
			<div class="card-overlay bg-black opacity-60"></div>
		</a>
		<div class="mb-5 pb-5"></div>
    </div>  
</div>   


</body>

</html>