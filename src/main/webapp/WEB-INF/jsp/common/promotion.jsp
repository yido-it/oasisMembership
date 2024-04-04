<!-- 프로모션 -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${!empty pList}">
<div class="mt-3">
	<h2 class="px-4 py-2 mt-3">PROMOTION</h2>
	
		<!-- 
		프로모션 1개 일때
	 	<div class="cover-slider owl-carousel owl-no-dots owl-no-controls" style="touch-action: auto;">
			<div class="item" onclick="location.href='event'">
				<div class="card card-style mx-0 bg-9" data-card-height="150" style="background-image: url(/images/event/promotion.jpg);">
					<div class="card-bottom m-3">
						<p class="color-white mb-0 opacity-90">02/01~02/03</p>
						<h2 class="color-white">박세리프로 프로모션</h2>
					</div>
					<div class="card-overlay bg-gradient"></div>
				</div>
			</div>
		</div>
		-->       
		
		<!-- 슬라이드 좌우가 보이는 프로모션   -->
		<div class="single-slider-boxed owl-carousel owl-no-dots">
			<c:forEach items="${pList}" var="pro" varStatus="status">
			<div data-card-height="130" class="card card-style m-0" style="background-image: url('/images/event/240216.jpg');" onclick="location.href='/promotionView/P00000000043'">
			</div>
			<div data-card-height="130" class="card card-style m-0" style="background-image: url('/images/event/240216.jpg');" onclick="location.href='/promotionView/P00000000043'" >
			</div>
			</c:forEach>  
		</div>
        
		
		<!-- 슬라이드 좌우없는 프로모션 -->		
	<%-- 	<div class="single-slider owl-no-controls owl-carousel owl-no-dots">
		<c:forEach items="${pList}" var="pro" varStatus="status">
            <div data-card-height="130" class="card card-style bg-5 mb-0 rounded-m shadow-l" style="background-image: url(${pro.fileURL});" onclick="location.href='/promotionView/${pro.pmSerialNo}'">
                <div class="card-bottom ml-2  mb-3">
                	<!-- 시작일~종료일 -->
                   	<p class="color-white mb-0 opacity-90">${pro.pmFromDay}~${pro.pmEndDay}</p>
                   	<!-- 제목 -->
					<h2 class="color-white">${pro.pmName}</h2>
                </div>
              <!--   <div class="card-overlay bg-gradient"></div> -->
            </div> 
        </c:forEach>  
        </div> --%>
        
	</div>	
</c:if>