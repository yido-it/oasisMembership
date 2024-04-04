<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
				<div class="card m-0" data-card-height="320" style="background: url(/images/gallery/rest_main10.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-overlay bg-gradient"></div>
				</div>
				<div class="card m-0" data-card-height="320" style="background: url(/images/gallery/rest_main16.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-overlay bg-gradient"></div>
				</div>
				<div class="card m-0" data-card-height="320" style="background: url(/images/gallery/rest_main11.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-overlay bg-gradient"></div>
				</div>
				<div class="card m-0" data-card-height="320" style="background: url(/images/gallery/rest_main12.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-overlay bg-gradient"></div>
				</div>
				<div class="card m-0" data-card-height="320" style="background: url(/images/gallery/rest_main13.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-overlay bg-gradient"></div>
				</div>
			</div>
		</div> 
		
		<div class="card card-clear" data-card-height="323"></div>
        
        <div class="card card-full rounded-m">
	        <div class="page-content p-4">
		    	
		        <h2 class="py-3">CLUBD CAVE RESTAURANT</h2>
		        <span class="bg-green-dark font-15 px-3 py-1 text-uppercase rounded-xs">B1 &nbsp;클럽디 카브 비스트로</span>
		        
				<p class="py-3 mb-0">
					유럽에서 요리하며 인연을 맺은 강민구, 송하슬람 셰프가 디자인한 시그니처 요리와 다양한 와인과 위스키를 함께 맛보실 수 있습니다.
					클럽디 카브의 모든 레시피는 마마리 다이닝과 함께 기획했습니다.
				</p>
			</div>
			
			<!-- 메뉴 -->
			<h5 class="bold px-4 py-2">대표메뉴</h5>
			
            <div class="double-slider owl-carousel owl-no-dots mb-0">	            	
            	<div class="item">
                    <div class="card card-style mx-0 bg-pro1" data-card-height="180" style="background: url(../images/gallery/sandwich.jpg) no-repeat 0 0;background-size:cover">
                        <div class="card-bottom mb-2">
                            <h5 class="color-white font-15 px-2">Sandwich</h5> 
                        </div>
                        <div class="card-overlay bg-gradient opacity-30"></div>
                        <div class="card-overlay bg-gradient"></div>
                    </div>
               </div>	                
               <div class="item">
                    <div class="card card-style mx-0 bg-pro1" data-card-height="180" style="background: url(../images/gallery/setmenu.jpg) no-repeat 0 0;background-size:cover">
                        <div class="card-bottom mb-2">
                            <h5 class="color-white font-15 px-2">Set Menu</h5> 
                        </div>
                        <div class="card-overlay bg-gradient opacity-30"></div>
                        <div class="card-overlay bg-gradient"></div>
                    </div>
                </div>	                
                <div class="item">
                    <div class="card card-style mx-0 bg-pro1" data-card-height="180" style="background: url(../images/gallery/pasta.jpg) no-repeat 0 0; background-size:cover">
                        <div class="card-bottom mb-2">
                            <h5 class="color-white font-15 px-2">Pasta</h5>	                           
                        </div>
                        <div class="card-overlay bg-gradient opacity-30"></div>
                        <div class="card-overlay bg-gradient"></div>
                    </div>
                </div>	                
                <div class="item">
                    <div class="card card-style mx-0 bg-pro1" data-card-height="180" style="background: url(../images/gallery/salad.jpg) no-repeat 0 0; background-size:cover">
                        <div class="card-bottom mb-2">
                            <h5 class="color-white font-15 px-2">Salad</h5> 
                        </div>
                        <div class="card-overlay bg-gradient opacity-30"></div>
                        <div class="card-overlay bg-gradient"></div>
                    </div>
                </div>
                <div class="item">
                    <div class="card card-style mx-0 bg-pro1" data-card-height="180" style="background: url(../images/gallery/smalldish.jpg) no-repeat 0 0; background-size:cover">
                        <div class="card-bottom mb-2">
                            <h5 class="color-white font-15 px-2">Small Dish</h5>
                        </div>
                        <div class="card-overlay bg-gradient opacity-30"></div>
                        <div class="card-overlay bg-gradient"></div>
                    </div>
                </div>
                <div class="item">
                    <div class="card card-style mx-0 bg-pro1" data-card-height="180" style="background: url(../images/gallery/dessert.jpg) no-repeat 0 0; background-size:cover">
                        <div class="card-bottom mb-2">
                            <h5 class="color-white font-15 px-2">Dessert</h5>	                           
                        </div>
                        <div class="card-overlay bg-gradient opacity-30"></div>
                        <div class="card-overlay bg-gradient"></div>
                    </div>
                </div>	                
                <div class="item">
                    <div class="card card-style mx-0 bg-pro1" data-card-height="180" style="background: url(../images/gallery/food7.jpg) no-repeat 0 0; background-size:cover">
                        <div class="card-bottom mb-2">
                            <h5 class="color-white font-15 px-2">Wine</h5>	                           
                        </div>
                        <div class="card-overlay bg-gradient opacity-30"></div>
                        <div class="card-overlay bg-gradient"></div>
                    </div>
                </div>
                <div class="item">
                    <div class="card card-style mx-0 bg-pro1" data-card-height="180" style="background: url(../images/gallery/food8.jpg) no-repeat 0 0; background-size:cover">
                        <div class="card-bottom mb-2">
                            <h5 class="color-white font-15 px-2">Alcoholic Drink & beverage</h5>	                           
                        </div>
                        <div class="card-overlay bg-gradient opacity-30"></div>
                        <div class="card-overlay bg-gradient"></div>
                    </div>
                </div>
            </div>
               
            <!-- 영업시간 -->
			<h5 class="bold px-4 pt-4 pb-1">영업시간</h5>
			<div class="page-content mb-5 px-4">
				<ul>
					<li>LUNCH: 11:00 ~ 15:00</li>
					<li>DINNER: 17:00 ~ 24:00</li>
					<li>BREAK TIME: 15:00 ~ 17:00</li>
					<li>LAST ORDER: 22:30</li>
				</ul>
				
				<h5 class="mt-4"><b>위치안내</b></h5>
				<img src="/images/bay/B1.jpg" class="mb-5" style="width: 100%;">
			
            </div>            
        </div>
	</div>   
	<!-- 하단바 -->
	<jsp:include page="../common/footerBar.jsp" />
	
</body>
</html>