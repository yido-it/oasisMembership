<!-- PG결제취소 페이지 -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="common/head.jsp" />
<jsp:include page="common/script.jsp" />

<body class="theme-dark">
<div id="preloader"><div class="spinner-border color-highlight" role="status"></div></div>
<div id="page">        
<div class="header header-fixed header-logo-app header-transparent">
<a href="#" class="color-white header-title header-subtitle">PG결제취소</a>
<jsp:include page="common/top.jsp" />
</div>
<jsp:include page="common/menu.jsp" />

<div data-card-height="cover-card" class="content bg-1" style="height: 120vh !important;background-size: cover;background-position: 50% 50%;">
<div class="card-center ">

	<form id="frmCancelForm" name="frmCancelForm">
	<div style="max-width:300px;" class="mx-auto mb-n5">
	
		<div class="input-style input-light input-style-1 has-icon input-required all">
			<input class="form-control" type="text" id="orderId" name="orderId" placeholder="주문번호(orderId)" data-name="주문번호">
		</div> 
	
		<div class="input-style input-light input-style-1 has-icon input-required all">
			<input class="form-control" type="text" id="authAmount" name="authAmount" placeholder="승인금액(authAmount)" data-name="승인금액">
		</div> 
		
		<div class="input-style input-light input-style-1 has-icon input-required all">
			<span class="color-highlight">거래번호</span>
			<input class="form-control" type="text" id="transactionId" name="transactionId" placeholder="거래번호(transactionId)" data-name="거래번호">
		</div> 
		
		<div class="input-style input-light input-style-1 has-icon input-required all">
			<input class="form-control" type="text" id="cancelKey" name="cancelKey" placeholder="취소키(cancelKey)" data-name="취소키">
		</div> 
	
		
		<button type="button" class="col-12 mt-4 mb-4 btn btn-md bg-blue-dark btn-full shadow-xl text-uppercase font-800 rounded-s" id="btnCancel">
		취소
		</button>
	</div>
	</form> 
</div>
<div class="card-overlay bg-black opacity-80"></div>
</div>        


</div> <!-- page end-->


<div class="menu-hider"><div></div></div>
<script>

var msId = "<c:out value='${sessionScope.msMember.msId}'/>";

if (msId != "admin") {
	alert("※※※※ 접근권한없음 ※※※※");
	location.href = "/main";	
}

$('#btnCancel').on('click', function() {
	$.ajax({
        url: "<c:out value='/pay/cancelPay'/>"
      , type: "post"
      , dataType: 'json'
      , data: $("#frmCancelForm").serialize()
      , contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
      , success: function(data) {    	
                  
      }, error: function(data) {
      	
      }
  });
});
</script>	
</body>
</html>