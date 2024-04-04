<!-- 프로 -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${not empty ambassadorList}">
	<div>
		<h2 class="px-4 py-2 mt-2">AMBASSADOR</h2>
		
		<div class="card card-style mr-4 ml-4" data-card-height="250">
			<c:forEach items="${ambassadorList}" var="item" varStatus="status">
				<c:choose>
					<c:when test="${item.msImgName != null && item.msImgName != ''}">
						<div onclick="javascript:location.href='pro/proDetail?msNum=${item.msNum}'" data-card-height="250" class="card proimage card-style bg-5 m-0 rounded-m"  style="background: url(${item.fileURL}) no-repeat 0 0; background-position-y: 28% !important; background-size: cover;">
					</c:when>
					<c:otherwise>
						<div onclick="javascript:location.href='pro/proDetail?msNum=${item.msNum}'" data-card-height="250" class="card proimage card-style bg-5 m-0 rounded-m bg-empty_pro""  style="background-size: cover;">
					</c:otherwise>
				</c:choose>    		
				<div class="card-bottom p-3">
					<p class="color-white mb-0">앰배서더</p>
					<h2 class="color-white mb-0">${item.msName} 프로</h2>
				</div>
				<div class="card-overlay bg-gradient"></div>
			</c:forEach>
		</div>
	</div>
</c:if>
    
<c:if test="${not empty proList}">
	<div class="mt-4">
		<h2 class="px-4 py-2">PRO GOLFER</h2>
		<div class="double-slider owl-carousel owl-no-dots mb-4">			
			<c:forEach var="item" items="${proList}" varStatus="status">
				<c:if test="${item.msLevel != '02' and item.msNum != '000000002182'}">
					<div class="item" style="">
						<c:choose>
							<c:when test="${item.msImgName != null && item.msImgName != ''}">
								<div class="card proimage card-style mx-0 bg-pro1" data-card-height="200" style="background: url(${item.fileURL}) no-repeat 0 0; background-size: cover; background-position-y: 28% !important;" onclick="javascript:location.href='pro/proDetail?msNum=${item.msNum}'">
							</c:when>
							<c:otherwise>					
								<div class="card proimage card-style mx-0 bg-pro1 bg-empty_profile" data-card-height="200" onclick="javascript:location.href='pro/proDetail?msNum=${item.msNum}'">
							</c:otherwise>
						</c:choose>
					</div>
					<a href="javascript:location.href='pro/proDetail?msNum=${item.msNum}'" class="btn btn-sm btn-center-xs bg-green-dark under-slider-btn text-uppercase font-12 rounded-sm" style="z-index:999;">
						${item.msName} 프로
					</a>
		</div>
				</c:if>
			</c:forEach>			
			</div>
		</div>
	</div>
</c:if>