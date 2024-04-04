<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	#__loading {
		width: 100%;
		height: 100%;
		top: 0px;
		left: 0px;
		position: fixed;
		display: block;
		z-index: 9999;
	}
	.fa-spinner {
		position: absolute;
		top: 50%;
		left: 48%;
		z-index: 100;
		color:white;
		font-size:30px;
		padding:
	}
</style>
<div id="__loading" style="display:none;">
	<i class="fa fa-spinner fa-pulse fa-fw"></i>
</div>
<div id="menu-main" class="menu menu-box-left bg-green-dark" data-menu-width="250" data-menu-effect="menu-parallax">
	<!-- 상단 로그인 버튼 -->
	<div class="text-center pt-4 notch-clear">
		<p><a class="color-white" href="javascript:location.href='/main'">CLUBD CHEONGDAM</a></p>
	
		<c:if test="${empty sessionScope.msMember.msNum}">
			<!-- 비로그인 상태 -->
			<div class="row" style="margin: 0 auto;">
				<div class="col-6 pr-1">
					<a href="javascript:location.href='/login'" class="btn btn-border btn-sm btn-full text-uppercase bg-green-light">
					로그인
					</a>
				</div>
				<div class="col-6 pl-1 pr-2">
					<a href="javascript:location.href='/member/agree?msLoginCd=APP'" 
						class="btn btn-border btn-sm btn-full text-uppercase bg-green-light">
					회원가입
					</a>
				</div>
			</div>
		</c:if>
		
		<c:if test="${!empty sessionScope.msMember.msNum}">
			<!-- 로그인 상태 -->
			<p class="mt-n3 font-13 opacity-50 mb-3">${sessionScope.msMember.msName} 회원님의 방문을 환영합니다.</p>		
		</c:if>	
	</div> 
	
	<div class="divider mt-3 mb-3"></div>
	
	<div class="menu-list">
		<!-- 이용관련 메뉴 -->
		
		<a href="javascript:location.href='/guide'" id="nav-welcome">
			<i class="fa fa-star color-brown-dark"></i>이용안내<i class="fa fa-angle-right"></i>
		</a>		
		
		<a href="javascript:location.href='/charge'" id="nav-charge">
			<i class="fa-sharp fa-solid fa-credit-card color-brown-dark"></i>이용요금<i class="fa fa-angle-right"></i>
		</a>
		
		<a href="javascript:location.href='/facility'" id="nav-homepages">
			<i class="fa fa-file color-brown-dark"></i>시설안내<i class="fa fa-angle-right"></i>
		</a>
		
		<a href="" data-menu="menu-maps" id="nav-components">
			<i class="fa fa-map-location-dot color-brown-dark"></i>오시는길<i class="fa fa-angle-right"></i>
		</a>
		
		<a href="javascript:location.href='/pro/proMain'" id="nav-pro">
			<i class="fa fa-user color-brown-dark"></i>프로정보<i class="fa fa-angle-right"></i>
		</a>
		
	<!-- 	<a href="event.html" id="nav-pages">
			<i class="fa fa-gift color-green-light"></i>이벤트<i class="fa fa-angle-right"></i>
		</a> -->
		
		<a href="javascript:location.href='/boardList/001/1'" id="nav-notice">
			<i class="fa fa-list color-brown-dark"></i>공지사항<i class="fa fa-angle-right"></i>
		</a>
		<!-- <a href="javascript:location.href='/qrscan'" id="nav-media">
			<i class="fa fa-list color-teal-dark"></i>QR코드조회<i class="fa fa-angle-right"></i>
		</a> -->
		
		<div class="divider mt-3 mb-3"></div>
		
		<!-- 개인설정 메뉴 -->
		<c:if test="${!empty sessionScope.msMember.msNum}">
			<h6 class="ml-1 font-14 font-400">개인설정</h6>
			<a href="javascript:location.href='/vipCard';" id="nav-ticket">
				<i class="fa fa-user color-brown-dark"></i>멤버십<i class="fa fa-angle-right"></i>
			</a>
			<a href="javascript:location.href='/voucher/voucherMain/001';" id="nav-ticket">
				<i class="fa-solid fa-money-check color-brown-dark"></i>이용권<i class="fa fa-angle-right"></i>
			</a>
			
			<c:choose>
			<c:when test="${sessionScope.msMember.msDivision ne '00'}">
			<a href="javascript:location.href='/member/memberModify'" id="nav-modify">
			</c:when>
			<c:otherwise>
			<a href="javascript:location.href='/pro/proForm'" id="nav-modify">
			</c:otherwise>
			</c:choose>
				<i class="fa fa-pen color-brown-dark"></i>정보수정<i class="fa fa-angle-right"></i>
			</a>
			
			<a href="javascript:location.href='/book/bookList/001';" id="nav-bookList">
				<i class="fa fa-calendar-check color-brown-dark"></i>예약내역<i class="fa fa-angle-right"></i>
			</a>
			
			<a href="javascript:location.href='/promotion/applyList/001';" id="nav-prmAplList">
				<i class="fa fa-calendar-check color-brown-dark"></i>프로모션 신청내역<i class="fa fa-angle-right"></i>
			</a>
		
			<c:if test="${sessionScope.msMember.msId == 'admin'}">
				<a href="javascript:location.href='/admin/userLogin'" id="nav-userLogin">
					<i class="fa fa-user color-brown-dark"></i>사용자 로그인<i class="fa fa-angle-right"></i>
				</a>
			</c:if>	
		</c:if>
		<c:if test="${!empty sessionScope.msMember.msId}">
			<!-- 로그인 상태 일때-->
			<a href="#" class="" id="btnLogout">
				<i class="fa fa-right-to-bracket"></i>로그아웃<i class="fa fa-angle-right"></i>
			</a>
		</c:if>	
	
	</div>
	
	<br/><br/><br/><br/>
	
</div>  


<!-- 오시는길 팝업 -->
<div id="menu-maps" class="menu menu-box-bottom bg-white-light" data-menu-height="610" data-menu-effect="menu-parallax">
	<div class="menu-title">
		<h3 class="ml-3">오시는 길</h3>
		<a href="#" class="close-menu"><i class="fa fa-times-circle"></i></a>
	</div> 
	<!-- * 카카오맵 - 지도퍼가기 -->
	<!-- 1. 지도 노드 -->
	<div id="daumRoughmapContainer1677222586033" class="root_daum_roughmap root_daum_roughmap_landing" style="width:100%"></div>
	<!-- 2. 설치 스크립트 -->
	<!-- * 지도 퍼가기 서비스를 2개 이상 넣을 경우, 설치 스크립트는 하나만 삽입합니다. -->
	<script charset="UTF-8" class="daum_roughmap_loader_script" src="https://ssl.daumcdn.net/dmaps/map_js_init/roughmapLoader.js"></script>
	<!-- 3. 실행 스크립트 -->
	<script charset="UTF-8">
		new daum.roughmap.Lander({
			"timestamp" : "1677222586033",
			"key" : "2duqe",
			"mapWidth" : "100%",
			"mapHeight" : "250"
		}).render();
	</script>
	<!-- <div class='responsive-iframe max-iframe mb-n3'>
		<iframe src='https://maps.google.com/?ie=UTF8&ll=47.595131,-122.330414&spn=0.006186,0.016512&t=h&z=17&output=embed' frameborder='0' allowfullscreen></iframe>
	</div> -->	
	<div class="content">
		<h3 class="font-700">Address</h3>
		<p class="mb-0" id="text">서울시 강남구 도산대로 439 소봉빌딩 </p>
		<p class="mb-0">클럽디청담(지하 1층 ~ 3층) </p>
		<p class="box01">	  
	        <span id="button" class="badge bg-green-dark font-13">주소복사</span>	      
	    </p>	    
	   	<div class="divider mt-2 mb-3"></div>
	 
	<!-- <div class="map_navi"> 
		<a href="javascript:kakaoMap('클럽디 청담','37.524119','127.043771');">
		<img src="/images/icons/navi_kakao.png" class="ml-1"> 카카오네비</a>
		<a href="javascript:tMap('클럽디 청담','37.524119','127.043771');">
		<img src="/images/icons/navi_tmap.jpg" class="ml-1"> 티맵</a>
	</div> -->
		
		<h3 class="font-700">Contact</h3>
		<div class="list-group list-custom-small">
			<a href="tel:02-6403-7717" class="mt-2">
				<i class="fa fa-phone color-phone pl-1 pr-1"></i>
				<span>+82 02-6403-7717</span>
				<span class="badge bg-green-dark font-13 float-right">전화걸기</span>				
			</a>        
			<a href="mailto:mail@domain.com" class="mt-1">
				<i class="fa fa-envelope color-mail pl-1 pr-1"></i>
				<span>cheongdam@clubd.com</span>
				<span class="badge bg-green-dark font-13 float-right">메일발송</span>
			</a>         
		</div>
	</div>   
</div>
<!--//오시는길 팝업--> 

<jsp:include page="../common/alertModal.jsp" /> 
<script type="text/javascript">

//티맵 길안내
function tMap(name,lat,lng){
location.href = "https://apis.openapi.sk.com/tmap/app/routes?appKey=L9AuFlEbSCDhgsisOzKhaKcvcCOe2tQ7g6qn6H5h&name="+name+"&lon="+lng+"&lat="+lat;
}

//카카오맵 길안내
function kakaoMap(name,lat,lng){
location.href = "https://map.kakao.com/link/to/"+name+","+lat+","+lng;
}

//네이버맵 길안내
function naverMap(name,lat,lng){
location.href = "http://app.map.naver.com/launchApp/?version=11&menu=navigation&elat="+lat+"&elng="+lng+"&etitle="+name;
}

	$('#btnLogout').on('click', function() {
		alertModal.confirm2('로그아웃 하시겠습니까?', 'location.href="/succ-logout"');
	})
		
	// 메뉴 active 관련 
	var className = 'active-nav bg-highlight nav-item-active';
	
	if (pUrl.indexOf('/guide') >= 0) $('#nav-welcome').addClass(className);						// 이용안내
	else if (pUrl.indexOf('/charge') >= 0) $('#nav-charge').addClass(className);				// 요금안내
	else if (pUrl.indexOf('/facility') >= 0) $('#nav-homepages').addClass(className);			// 시설안내
	else if (pUrl.indexOf('/pro/proMain') >= 0) $('#nav-pro').addClass(className);				// 프로정보
	else if (pUrl.indexOf('/boardList') >= 0) $('#nav-notice').addClass(className);				// 공지사항
	else if (pUrl.indexOf('/voucher/voucherMain') >= 0) $('#nav-ticket').addClass(className);	// 이용권
	else if (pUrl.indexOf('/member/memberModify') >= 0 || pUrl.indexOf('/pro/proForm') >= 0) 
		$('#nav-modify').addClass(className);	// 정보수정
	else if (pUrl.indexOf('/book/bookList') >= 0) $('#nav-bookList').addClass(className);		// 예약내역
	else if (pUrl.indexOf('promotion/applyList') >= 0) $('#nav-prmAplList').addClass(className);// 프로모션 신청내역
		
</script>

