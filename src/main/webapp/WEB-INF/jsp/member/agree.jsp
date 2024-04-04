<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.yido.clubd.common.utils.Globals" %>
<jsp:include page="../common/head.jsp" />
<jsp:include page="../common/script.jsp" />

<div id="preloader"><div class="spinner-border color-highlight" role="status"></div></div>
<body class="is-not-ios theme-light" style="background-color: #fff;">
    
    <div id="page">
		<div class="header header-fixed header-logo-app header-transparent">
			<a href="#" class="header-title header-subtitle">약관 확인하기</a>
			<a href="javascript:history.back()" data-back-button class="header-icon header-icon-1" id="topGoBack"><i class="fa fa-arrow-left"></i></a>
        	<a href="#" data-menu="menu-main" class="header-icon header-icon-2 mt-1"><i class="fas fa-bars"></i></a>
	    </div>
	    <jsp:include page="../common/menu.jsp" />
	    
	    <div class="page-content">
        
		    <div data-card-height="cover-card">
		        <div class="card-center">
		            <div class="text-center pb-5">
		                <img src="../images/logo_brown.png" style="width: 150px;">
		         	</div> 
		            <div style="max-width:300px;" class="mx-auto">
		            	<div class="mx-auto mt-4 list-group list-custom-small"> 
							<!--전체동의-->
			                <div class="form-check icon-check" style="position:relative">
			                    <input class="form-check-input" type="checkbox" value="" id="chkAgreeAll">
			                    <label class="form-check-label" style="position: relative;" for="chkAgreeAll">약관 전체동의</label>
			                    <i class="icon-check-1 far fa-circle color-gray-dark"></i>
			                    <i class="icon-check-2 far fa-check-circle"></i>
			                    
			                     <div class="divider bg-gray-dark mt-3 mb-3 opacity-50"></div>
			                </div>			                	
			               
			                
							<!--이용약관 동의 (필수)-->
		                    <div>
		                        <div class="form-check icon-check mt-0 mb-3" style="position:relative; display:inline-block">
		                            <input class="form-check-input agree-item required-item" type="checkbox" value="" id="check1">
		                            <label class="form-check-label" style="position: relative;" for="check1">이용약관 동의 <span class="color-red-light">(필수)</span></label>
		                            <i class="icon-check-1 far fa-circle color-gray-dark"></i>
		                            <i class="icon-check-2 far fa-check-circle"></i>   
		                        </div> 
		                        <i data-menu="modal_agree1" class="fa fa-chevron-right accordion-icon" style="position: relative;top:-5px"></i>
		                           
		                    </div>		              
			                <div class="clear"></div>
							<!--개인정보 수집 및 이용동의 (필수)-->              
							<div>
			                    <div class="form-check icon-check  mt-0 mb-0 " style="position:relative;display:inline-block">
			                        <input class="form-check-input agree-item required-item" type="checkbox" value="" id="check2">
			                        <label class="form-check-label"style="position: relative;"  for="check2">개인정보 수집 및 이용동의 <span class="color-red-light">(필수)</span></label>
			                        <i class="icon-check-1 far fa-circle color-gray-dark"></i>
			                        <i class="icon-check-2 far fa-check-circle"></i>   
			                    </div> 
			                    <i data-menu="modal_agree2" class="fa fa-chevron-right accordion-icon" style="position: relative;top:-5px"></i>
			                       
			                </div> 
			                <div class="clear"></div>
			              
			                <a href="#" class="btn btn-sm mt-3 bg-green-dark btn-full text-uppercase" id="btnNext">
			                    다음 단계</a>
			            </div>
		             
		                <!-- <div class="col-12" style="margin:0 auto">
		                    <a href="#" data-menu="modalAgree" class="btn btn-border btn-md btn-full mb-3 rounded-xl text-uppercase 
		                    font-900 border-blue-dark color-blue-dark bg-theme">약관 확인하기</a>
		                </div>
		                <div class="form-check icon-check mt-3 opacity-60"  style="margin:0 auto">
		                    <input class="form-check-input" type="checkbox" value="" id="check1">
		                    <label class="form-check-label color-white" for="check1">약관에 동의합니다</label>
		                    <i class="icon-check-1 fa fa-square color-gray-dark font-16 ml-n1"></i>
		                    <i class="icon-check-2 fa fa-check-square font-16 color-highlight ml-n1"></i>
		                </div>
		                <a href="#" class="mt-4 mb-4 btn btn-md bg-blue-dark btn-full shadow-xl text-uppercase font-800 rounded-s" id="btnNext">
		                    다음단계
		                </a> -->
		                
				       	<input type="hidden" id="msLoginCd" name="msLoginCd" value="${msLoginCd}"/>
		            </div>
		        </div>
		    </div>
		   </div>
    
	</div> <!-- page end-->
<!-- </div> --> <!-- Page content ends-->

<!-- 모달-->
<jsp:include page="../common/pop/modal.jsp" />
 
<div class="menu-hider"><div></div></div>
	<script type="text/javascript">
		if('${sessionScope.msMember.msNum}' != '' && '${sessionScope.msMember.msNum}' != null) {
			location.href="<c:url value='/main?login=y'/>";
		}
	
		$('#btnNext').on('click', function () {
			var sParams = "";			
			var result = true;
			
			$('.required-item').each(function () {
				var checkVal = $(this).prop('checked');
				if(!checkVal) {
					alertModal.fail("필수 약관에 동의가 필요합니다.");
					result = false;
					return;
				}
			})
			
			if(!result){
				return;
			} else {
				sParams += String.format("msMktAgreeYn=Y");
			}
			sParams += String.format("&msLoginCd={0}", $('#msLoginCd').val());			
			location.href = "<c:url value='/member/memberForm'/>" + "?" + encodeURI(sParams);
		})
				
		
		// 약관 전체동의 클릭 이벤트
		$('#chkAgreeAll').on('click', function() {
			var checkVal;
			if($('#chkAgreeAll').prop('checked') != true) {
				checkVal = false;
			} else {
				checkVal = true;
			}
			$('.agree-item').each(function() {
				$(this).prop('checked', checkVal);
			})			
		})
		
		// 약관 항목 클릭 시 전체동의 자동 체크 로직
		$('.agree-item').on('click', function() {
			var checkVal = $(this).prop('checked'); // 체크인지 체크해제인지
			var result = true;
			
			$('.agree-item').each(function() {
				if(checkVal != $(this).prop('checked')) { // 다른게 하나라도 있으면 false를 return
					result = false;
					return;
				} 
			})
			
			// 모두 체크/체크해제인 경우 전체동의에도 체크/체크해제
			if(result) {
				$('#chkAgreeAll').prop('checked', checkVal);
			} else {
				$('#chkAgreeAll').prop('checked', false);
			}

		})
			
	</script>
</body>
</html>