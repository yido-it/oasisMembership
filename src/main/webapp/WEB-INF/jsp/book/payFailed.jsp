<!-- 
기능 : 결제실패 
작성자 :bae
-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.yido.clubd.common.utils.Globals" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<jsp:include page="../common/head.jsp" />
<jsp:include page="../common/script.jsp" />

<body class="theme-light">
    
<div id="preloader"><div class="spinner-border color-highlight" role="status"></div></div>
    
<div id="page">
    <div class="page-content mt-5">
		<div class="menu-title">
			<h1 class="my-0 py-0 text-center">
				<i class="fa fa-3x fa-triangle-exclamation scale-box color-red-dark shadow-xl rounded-circle mb-2"></i>
				<br/>
				결제실패
			</h1>
			<p class="text-center mt-2 font-14">결제 실패 하였습니다. <br/>카드사 또는 고객센터로 문의해주세요. <br/>고객센터: 02-6403-7717</p>
		</div>
	</div>  
	<!--  content ends -->   
</div>   

<!--   Global Footer-->
<jsp:include page="../common/footerBar.jsp" />

</body>


</html>