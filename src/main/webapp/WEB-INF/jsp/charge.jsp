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
		<a href="#" class="header-title header-subtitle">이용요금</a>
		<jsp:include page="common/top.jsp" />
	</div>

	<!-- 좌측GNB-->
	<jsp:include page="common/menu.jsp" />
	<!-- //좌측GNB-->

    <div class="page-content header-clear">
        <div class="page-content pb-3">  
            <div class="content">
            	<h5 class="mt-4"><b>이용요금 (골프)</b></h5>
				<table class="table table-striped text-center">
					<thead>
						<tr class="bg-green-dark">
							<th>구분</th>
							<th>요금</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>B1<br>스크린골프</td>
							<td>17시 이전, 1시간 45,000원<br>17시 이후, 1~4번 BAY 1시간 80,000원<br>17시 이후, 5~6번 BAY 1시간 60,000원</td>
						</tr>
						<tr>
							<td>2F 오픈타석</td>
							<td>1회 60분 45,000원</td>
						</tr>
						<tr class="border-bottom">
							<td>3F 레슨룸</td>
							<td>1회 60분 45,000원 (레슨비 별도)</td>
						</tr>
					</tbody>
				</table>
				<ul>
					<li>강사료 : 별도 문의</li>
				</ul>
				
				<h5 class="mt-5"><b>이용요금(이용권)</b></h5>
				<table class="table table-striped text-center">
					<thead>
						<tr class="bg-green-dark">
							<th>구분</th>
							<th>요금</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>10회 이용권 + 1회</td>
							<td>450,000원</td>
						</tr>
						<tr>
							<td>30회 이용권 + 5회</td>
							<td>1,350,000원</td>
						</tr>
						<tr>
							<td>50회 이용권 + 8회</td>
							<td>2,250,000원</td>
						</tr>
						<tr class="border-bottom">
							<td>100회 이용권 + 20회</td>
							<td>4,500,000원</td>
						</tr>
					</tbody>
				</table>
			
				<ul class="mb-5 pb-5">
					<li>클럽 대여는 무료로 가능합니다.</li>
					<li>신발과 장갑은 대여가 불가합니다.</li>
					<li>모든 외부 음식은 반입 금지입니다.</li>
				</ul>            
	    	</div>
	    </div>  
	</div>
</div>

<!-- 하단바 -->
<jsp:include page="common/footerBar.jsp" />

</body>

</html>