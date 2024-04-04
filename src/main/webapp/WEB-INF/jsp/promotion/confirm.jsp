<!-- 
기능 : 프로모션 결제완료 페이지 
작성자 :bae
-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.yido.clubd.common.utils.Globals" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<fmt:parseDate value="${apply.PM_EVENT_FROM_DAY}" var="fromDt" pattern="yyyyMMdd"/>
<fmt:parseDate value="${apply.PM_EVENT_END_DAY}" var="endDt" pattern="yyyyMMdd"/>
<fmt:parseDate value="${cancelDt}" var="cancelDt" pattern="yyyy-MM-dd"/>

<jsp:include page="../common/head.jsp" />
<jsp:include page="../common/script.jsp" />

<body class="theme-dark">
    
<div id="preloader"><div class="spinner-border color-highlight" role="status"></div></div>
    
<div id="page">
    
	<c:if test="${!empty apply.PM_NAME}">
    <div class="page-content mt-5">
		<div class="menu-title">
			<h1 class="my-0 py-0 text-center">
				<i class="fa fa-3x fa-check-circle scale-box color-green-dark shadow-xl rounded-circle mb-2"></i>
				<br/>
				결제완료
			</h1>
			<p class="text-center mt-2 font-14">결제가 정상적으로 완료되었습니다. <br/>고객센터: 02-6403-7717</p>
		</div>
		        
        <div class="divider mt-3"></div>
        
        <div class="content">
			<div class="row mb-3 mt-4">

				<!-- 프로모션 이름 -->
				<h5 class="col-4 text-left font-15">프로모션</h5>
				<h5 class="col-8 text-right font-14 opacity-60">
					
					<c:if test="${not empty mainPrm}">
						${mainPrm.pmName} <BR>${apply.PM_NAME}
					</c:if>
					<c:if test="${empty mainPrm}">
						${apply.PM_NAME}
					</c:if>
									
				</h5>
				
				<!-- 행사일 -->
				<h5 class="col-4 text-left font-15">행사일 </h5>
				<h5 class="col-8 text-right font-14 opacity-60">
							
					<c:if test="${apply.PM_EVENT_FROM_DAY == apply.PM_EVENT_END_DAY}">
						<fmt:formatDate value="${fromDt}" pattern="yy.MM.dd"/>
					</c:if>
					<c:if test="${apply.PM_EVENT_FROM_DAY != apply.PM_EVENT_END_DAY}">
						<fmt:formatDate value="${fromDt}" pattern="yy.MM.dd"/> ~ <fmt:formatDate value="${endDt}" pattern="yy.MM.dd"/>
					</c:if>
					
				</h5>
			
				<!-- 결제금액 -->
				<h5 class="col-4 text-left font-15">결제금액</h5>
				<h5 class="col-8 text-right font-14 opacity-60 ">
					<fmt:formatNumber value="${apply.MN_AMOUNT}" pattern="#,###" />원
				</h5>
				
				<!-- 취소가능일  -->
				<h5 class="col-4 text-left font-15">취소가능일</h5>
				<h5 class="col-8 text-right font-14 opacity-60 ">
					<fmt:formatDate value="${cancelDt}" pattern="yy.MM.dd"/> 까지 취소 가능
				</h5>
			</div>
		
			<div class="divider"></div>
			
			<a href="javascript:onClick=goList('${apply.CO_DIV}')" class="mt-1 mb-3 btn btn-md bg-blue-dark btn-full shadow-xl text-uppercase font-800 rounded-s">
				프로모션 내역확인
			</a>
			
			<!-- 홈으로 -->
			<a href="javascript:location.href='/main';" class="mt-1 mb-4 btn btn-md bg-green-dark btn-full shadow-xl text-uppercase font-800 rounded-s">
				홈으로
			</a>
        </div> 
	</div>  
	</c:if>
	<!--  content ends -->   
</div>   

<!--   Global Footer-->
<jsp:include page="../common/footerBar.jsp" />

</body>

<script type="text/javascript">

// 프로모션 신청내역 페이지로 이동 
function goList(coDiv) {
	location.href='/promotion/applyList/'+coDiv;
}
</script>
</html>