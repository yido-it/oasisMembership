<!-- 초대장 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<c:if test="${!empty iList}">
<div class="content" style="margin:10px 10px 0px 10px;"> 
	<div class="mb-0">
	
		<h2 class="font-700 ml-1">INVITATION</h2>
		<c:choose>
		<c:when test="${fn:length(iList) == 1}">
		<div class="single-slider owl-carousel owl-no-dots owl-no-controls" style="touch-action: auto;padding:10px;padding:0 10px">
		</c:when>
		<c:otherwise>
		<div class="single-slider owl-carousel owl-no-dots">
		</c:otherwise>
		</c:choose>
			<c:forEach items="${iList}" var="invitation" varStatus="status">
			<div class="item">
				<div class="card card-style mx-0 bg-9" data-card-height="170" style="background-image: url(${invitation.fileURL});">
					<%-- <div class="card-bottom m-3">
                		<!-- 시작일~종료일 -->
                		<c:if test="${event.endDay ne null && event.endDay ne ''}">
						<p class="color-white mb-0 opacity-80">${event.startDay}~${event.endDay}</p>
                		</c:if>
						<!-- 제목 -->
						<h2 class="color-white">${event.title}</h2>
					</div>
					<div class="card-overlay bg-gradient"></div> --%>
				</div>
			</div>
			</c:forEach>
			
		</div>    
	</div>	 
</div>
</c:if>