<!-- 이용안내 페이지 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.yido.clubd.common.utils.Globals" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<jsp:include page="common/head.jsp" />
<jsp:include page="common/script.jsp" />

<body class="theme-light">
    
<div id="preloader"><div class="spinner-border color-highlight" role="status"></div></div>
    
<div id="page">

	<div class="header header-fixed header-logo-app">
		<a href="#" class="header-title header-subtitle">이용안내</a>
		<jsp:include page="common/top.jsp" />
	</div>

	<!-- 좌측GNB-->
	<jsp:include page="common/menu.jsp" />
	<!-- //좌측GNB-->

    <div class="page-content header-clear">
        <div class="page-content pb-3">  
            <div class="content">
            	<h5 class="mt-4"><b>운영시간 (클럽디 청담 골프)</b></h5>
            	<table class="table table-striped text-center">
					<thead>
						<tr class="bg-green-dark">
							<th>구분</th>
							<th>공간</th>
							<th>주중/주말</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>B1</td>
							<td>스크린골프</td>
							<td>08:00 - 24:00</td>
						</tr>
						<tr>
							<td>2F</td>
							<td>오픈타석</td>
							<td>08:00 - 22:00</td>
						</tr>
						<tr>
							<td>3F</td>
							<td>레슨룸</td>
							<td>08:00 - 22:00</td>
						</tr>
					</tbody>
				</table>
				<ul>
					<li>클럽 대여는 무료로 가능합니다.</li>
					<li>신발과 장갑은 대여가 불가합니다.</li>
					<li>모든 외부 음식은 반입 금지입니다.</li>
				</ul>
				
				<h5 class="mt-5"><b>운영시간 (클럽디 카브 레스토랑/카페)</b></h5>
	            <table class="table table-striped text-center">
					<thead>
						<tr class="bg-green-dark">
							<th>구분</th>
							<th>주중/주말</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>B1 클럽디 카브 레스토랑</td>
							<td>LUNCH 11:00 - 15:00<br>DINNER 17:00 - 24:00</td>
						</tr>
						<tr class="border-bottom">
							<td>B1 클럽디 카브 카페</td>
							<td>08:00 - 23:30</td>
						</tr>
					</tbody>
				</table>
				<ul class="mb-5 pb-5">
					<li>평일 브레이크 타임 15:00 - 17:00</li>
					<li>클럽디 카브 레스토랑 라스트오더는 22:30 입니다.</li>
					<li>클럽디 카브 카페 음료는 영업시간 내 주문 가능합니다.</li>
					<li>모든 외부 음식은 반입 금지입니다.</li>
					<li>유아식 및 일부 섭식장애 (알러지성 등) 고객은 사전에 직원에게 따로 요청하여 주시기 바랍니다.</li>
				</ul>            
	    	</div>
	    </div>  
	</div>
</div>

<!-- 하단바 -->
<jsp:include page="common/footerBar.jsp" />

</body>

</html>