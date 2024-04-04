<!-- 이벤트 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<c:if test="${!empty eList}">
<div class="content" style="margin:10px 10px 10px 10px"> 
	<div class="mb-0">
	
		<h2 class="font-700 ml-1">EVENT</h2>

		<div class="single-slider-boxed owl-carousel owl-no-dots">
			<!-- 이벤트 -->
			<c:forEach items="${eList}" var="event" varStatus="status">
			<div class="item" onclick="location.href='/boardView/${event.idx}'">
				<div class="card card-style mx-0 bg-9" data-card-height="170" style="background-image: url(${event.fileURL2});">
					<div class="card-bottom m-3">
                		<!-- 시작일~종료일 -->
                		<c:if test="${event.endDay ne null && event.endDay ne ''}">
						<p class="color-white mb-0 opacity-80">${event.startDay}~${event.endDay}</p>
                		</c:if>
						<!-- 제목 -->
						<h2 class="color-white">${event.title}</h2>
					</div>
					<div class="card-overlay bg-gradient"></div>
				</div>
			</div>
			</c:forEach>
			
		</div>    
	</div>	 
	<div class="divider divider-margins mb-0"></div>
</div>
</c:if>