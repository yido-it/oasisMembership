<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:include page="common/head.jsp" />
<jsp:include page="common/script.jsp" />

<style>
	.owl-dots{transform: translateY(-30px) !important;}/* 메인슬라이드 닷 위치조정 owl-dots-over */
	.touch {touch-action: auto !important;user-select: auto !important;}
</style>

<body class="theme-light touch" style="background: rgb(233, 229, 220);">
	<div id="preloader"><div class="spinner-border color-highlight" role="status"></div></div>

	<div id="page">
		
		<!--Header-->
		<div class="page-title page-title-fixed" style="opacity: 1; z-index:99; position:absolute">
			<!-- <h2><img src="/images/logo_white.png" style="width:60px; position:absolute; top:-10px; left: 0;"></h2> -->
			<a href="#" class="page-title-icon bg-white float-right mr-3 font-20 color-black" data-menu="menu-main"><i class="fa fa-bars"></i></a>
		</div>
		<!--//Header-->
			
		<!--스크롤내리면 보이는 Header-->
		<div class="header header-auto-show header-fixed header-logo-center">
			<a href="javascript:void(0);" class="header-title header-subtitle pl-3">CLUBD CHEONGDAM</a>
			<a href="#" data-menu="menu-main" class="header-icon header-icon-4 mt-1"><i class="fas fa-bars"></i></a>
		</div>
		<!--스크롤내리면 보이는 Header-->
		
		<!-- 좌측GNB -->
		<jsp:include page="common/menu.jsp" />
		<!-- //좌측GNB-->
	
		<div class="card card-fixed" data-card-height="320">
			<div class="single-slider slider-has-arrows owl-carousel owl-dots-over">
				<div class="card m-0" data-card-height="320" style="background: url(/images/gallery/cave_main10.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-bottom">
						<h2 class="color-white px-4 pb-4 mb-5 font-26 line-height-xl">
							<span class="bg-green-dark font-15 px-3 py-1 text-uppercase rounded-xs mb-2">B1</span><br>
							CLUBD<br>CAVE GOLF
						</h2>
					</div>
					<div class="card-overlay bg-gradient"></div>
				</div>
				<div class="card m-0" data-card-height="320" style="background: url(/images/gallery/rest_main4.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-bottom">
					 	<h2 class="color-white px-4 pb-4 mb-5 font-26 line-height-xl">
							<span class="bg-green-dark font-15 px-3 py-1 text-uppercase rounded-xs mb-2">B1</span><br>
							CLUBD CAVE RESTAURANT
						</h2>
					</div>
					<div class="card-overlay bg-gradient"></div>
				</div>
				<div class="card m-0" data-card-height="320" style="background: url(/images/gallery/store_main4.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-bottom">
						<h2 class="color-white px-4 pb-4 mb-5 font-26 line-height-xl">
							<span class="bg-green-dark font-15 px-3 py-1 text-uppercase rounded-xs mb-2">1F</span><br>
							RECEPTION<br>POPUP STORE
						</h2>
					</div>
					<div class="card-overlay bg-gradient"></div>
				</div>
				<div class="card m-0" data-card-height="320" style="background: url(/images/gallery/open_main0.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-bottom">
						<h2 class="color-white px-4 pb-4 mb-5 font-26 line-height-xl">
							<span class="bg-green-dark font-15 px-3 py-1 text-uppercase rounded-xs mb-2">2F</span><br>
							OPENBAY&BUNKER<br>VIRTUAL GREEN
						</h2>
					</div>
					<div class="card-overlay bg-gradient"></div>
				</div>
				<div class="card m-0" data-card-height="320" style="background: url(images/gallery/lesson_main7.jpg) no-repeat 0 0; background-size: cover">
					<div class="card-bottom">
						<h2 class="color-white px-4 pb-4 mb-5 font-26 line-height-xl">
							<span class="bg-green-dark font-15 px-3 py-1 text-uppercase rounded-xs mb-2">3F</span><br>
							LESSON ROOM
						</h2>
					</div>
					<div class="card-overlay bg-gradient"></div>
				</div>
			</div>
		</div> 
		
        <div class="card card-clear" data-card-height="323"></div>
        
        <div class="page-content card card-full rounded-m" style="background: #e9e5dc;">
        
	        <!--초대장(230417 추가 - YOO)-->
			<c:if test="${not empty sessionScope.msMember.msNum}">
				<jsp:include page="common/invitation.jsp" />
			</c:if>
			<!-- 프로모션 -->
			<jsp:include page="common/promotion.jsp" />
			
			<!-- 이벤트 -->
			<%-- <jsp:include page="common/event.jsp" /> --%>
		
			<!-- 프로 -->
			<jsp:include page="common/pro.jsp" />
				
			<!-- 베이소개 -->		
			<jsp:include page="common/bay.jsp" />
	    </div>  
	</div> 
	
	<jsp:include page="common/footer.jsp" />
	
	<!-- 하단바 -->
	<jsp:include page="common/footerBar.jsp" />
	
	<!-- 팝업 
	<div class="layer_popup" id="layer_pop">				
		<div style="display:block;">
			<a href="/boardView/19"><img style="width:100%" class="img_popup" src="/images/event/231207(3).jpg"></a>
		</div>
		<div class="close" style="opacity: 0.8;">
			<div id="close"  style="margin: auto; cursor: pointer; float: left; margin-right: 10px; padding-bottom: 5px;">
				<a style="color: #fff; font-size: 15px; font-weight: normal;" href="javascript:todaycloseWin('todaycookie1')">오늘하루보지않기</a>
			</div>
			<div id="close" style="margin: auto; cursor: pointer; float: right; margin-right: 10px; padding-bottom: 5px;">
				<a style="color: #fff; font-size: 15px; font-weight: normal;" href="javascript:popClose('layer_pop')">닫기</a>
			</div>
		</div>
	</div> 
	-->
	<div class="layer_popup" id="layer_pop">				
		<div style="display:block;">
			<div class="single-slider slider-has-arrows owl-carousel">
				<div class="card m-0 bg-main_slide01">
					<a href="/boardView/21"><img style="width:100%" class="img_popup" src="/images/event/event-240119.jpg"></a>
				</div>	
				<div class="card m-0 bg-main_slide01">
					<a href="/boardView/17"><img style="width:100%" class="img_popup" src="/images/event/event_241011.jpg"></a>
				</div>				
				<!-- 	<div class="card m-0 bg-main_slide02">
					<a href="/boardView/20"><img style="width:100%" class="img_popup" src="/images/event/231218(2).jpg"></a>
				</div>		 -->		
			</div>  			
		</div>
		<div class="close" style="opacity: 0.8;">
			<div id="close"  style="margin: auto; cursor: pointer; float: left; margin-right: 10px; padding-bottom: 5px;">
				<a style="color: #fff; font-size: 15px; font-weight: normal;" href="javascript:todaycloseWin('todaycookie1')">오늘하루보지않기</a>
			</div>
			<div id="close" style="margin: auto; cursor: pointer; float: right; margin-right: 10px; padding-bottom: 5px;">
				<a style="color: #fff; font-size: 15px; font-weight: normal;" href="javascript:popClose('layer_pop')">닫기</a>
			</div>
		</div>
	</div> 
	<!-- 팝업끝 -->

</body>

<script type="text/javascript">
	function goBayDetail(idx) {
		location.href='/bay'+idx;
	}
	
	function fnQrScan(){
		location.href="/qrscan";
	}
</script>
<script type="text/javascript">
$(document).ready(function() {
	
	if (getCookie('todaycookie1') != undefined) {

		if(getCookie('todaycookie1') == 'done') {
			document.getElementById('layer_pop').style.display = "none";	// 안 보임 
		} else {
			document.getElementById('layer_pop').style.display = "block";
		}
	
	}
			
});	

// 쿠키 생성 함수
function setCookie(cName, cValue, cDay){
	var expire = new Date();
	expire.setDate(expire.getDate() + cDay);
	cookies = cName + '=' + escape(cValue) + '; path=/ '; // 한글 깨짐을 막기위해
	if(typeof cDay != 'undefined') cookies += ';expires=' + expire.toGMTString() + ';';
	document.cookie = cookies;
}
   
// 쿠키 가져오기 함수
function getCookie(cName) {
	var x, y; var val = document.cookie.split(';');
	for (var i = 0; i < val.length; i++) {
		x = val[i].substr(0, val[i].indexOf('='));
		y = val[i].substr(val[i].indexOf('=') + 1);
		x = x.replace(/^\s+|\s+$/g, ''); // 앞과 뒤의 공백 제거하기
		if (x == cName) {
			return unescape(y);
			// unescape로 디코딩 후 값 리턴
		}
	}
}

// 닫기
function popClose(popId) {
	document.getElementById('layer_pop').style.display = "none";
}

   // 오늘 하루 보지 않기 닫기
function todaycloseWin(cookiename) {
	setCookie(cookiename, "done", 1);     // 저장될 쿠키명 , 쿠키 value값 , 기간
	var popId = 'layer_pop';
		document.getElementById(popId).style.display = "none";    // 팝업창 아이디
}
</script>
</html>