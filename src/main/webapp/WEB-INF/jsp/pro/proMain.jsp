<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.yido.clubd.common.utils.Globals" %>
<jsp:include page="../common/head.jsp" />
<jsp:include page="../common/script.jsp" />
<style>
	.card {box-shadow: 0 3px 5px 2px rgba(0, 0, 0, 0.1);}
	/* 조태형 프로 임시로 가림 */
	.col-6:last-child {
	    display: none;
	}
</style>
<body class="theme-light">
    
	<div id="preloader"><div class="spinner-border color-highlight" role="status"></div></div>
	
	<div id="page">
	    
		<div class="header header-fixed header-logo-app">
			<a href="#" class="header-title header-subtitle">프로선택</a>
			<jsp:include page="../common/top.jsp" />
		</div>
	    <jsp:include page="../common/menu.jsp" />
	
	    <div class="header-clear-large px-4">
	        
	       	<!-- 앰배서더 -->
	       	<c:if test="${not empty ambassadorList}">
				<div>
					<h2>AMBASSADOR</h2>
					
					<div class="card card-style m-0" data-card-height="250">
						<c:forEach items="${ambassadorList}" var="item" varStatus="status">
							<c:choose>
								<c:when test="${item.msImgName != null && item.msImgName != ''}">
									<div onclick="location.href='/pro/proDetail?msNum=123456789195';"} data-card-height="250" class="card proimage card-style bg-5 m-0 rounded-m"  style="background: url(${item.fileURL}) no-repeat 0 0; background-position-y: 28% !important; background-size: cover;">
								</c:when>
								<c:otherwise>
									<div onclick="javascript:location.href='pro/proDetail?msNum=${item.msNum}'" data-card-height="250" class="card proimage card-style bg-5 m-0 rounded-m bg-empty_pro"  style="background-size: cover;">
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
			
			<!-- 프로 골퍼 -->
			<div>
				<h2 class="mt-5">PRO GOLFER</h2></div>              
	            <div class="row pb-5 mb-5 mt-2 ">
	            	<c:choose>
		            	<c:when test="${not empty proList}">
		            		<c:forEach items="${proList}" var="item" varStatus="status">
			                	<div class="col-6" onclick="javascript:location.href='proDetail?msNum=${item.msNum}'">
			                		<c:choose>
				                		<c:when test="${item.msImgName != null && item.msImgName != ''}">
				                    		<div class="card card-style m-0 mb-2 rounded-m proimage" data-card-height="200" style="background: url(${item.fileURL}) no-repeat 0 0;  background-size: cover;">
				                    	</c:when>
						                    	<c:otherwise>
						                    		<div class="card card-style m-0 mb-2 rounded-m bg-empty_pro proimage" data-card-height="200" style="background-size: cover;">
						                    	</c:otherwise>
			                    	</c:choose>
				                    <c:if test="${item.licName != null && item.licName != ''}">
				                        <div class="card-bottom"><span class="badge bg-highlight p-1 pl-2 rounded-0">${item.licName}</span></div>
				                    </c:if>
			              							</div>
		                    					<p class="text-center mb-3">${item.msName} 프로 </p>
		                					</div>
			                </c:forEach>         
		            	</c:when>
			           	<c:otherwise>
			           		등록된 프로 정보가 없습니다.
			           	</c:otherwise>
	            	</c:choose>
		            			</div>
		        </div>            
			</div>
	    	<!--// 프로골퍼 -->    
		</div>
	

	<div class="menu-hider"><div></div></div>
	
	<!-- 하단바 -->
	<jsp:include page="../common/footerBar.jsp" />
	
<script type="text/javascript">		
	
	//getProList();
	
	function getProList(){		
    	$.ajax({
              url : "/pro/getProList"
            , type : "post"
            , dataType : 'json'
    		, contentType : 'application/x-www-form-urlencoded; charset=UTF-8'
    		, success : function(data) {
            	if(data.result) {
            		drawProList(data.proList);
            	} else {
            		alertModal.fail(data.message);
            	}
            }
    		, error : function(data) {	    			
    			alertModal.fail("프로 조회에 실패했습니다.");
            }
        })
	}
	
	function drawProList(proList) {
		var html = "";
		var count = 0;
		var arrNum = 3;
		
		// 셀 3개씩 정렬
		for(var i = 0; i < proList.length; i++) {
			if(count == 0) {
				html += "<tr>";
			}
			html += "<td><a href='/pro/proDetail?msNum=" + proList[i].msNum + "'>" + proList[i].msName + "</a></td>";
			if(count == arrNum-1) {
				html += "</tr>";
				count = 0;
			}				
			count++;
		}
		$('#proTBody').append(html);
		} 
</script>
</body>
</html>