<!-- 
기능 : 예약취소 페이지
	> 이용권으로만 결제한 경우 부분취소가능하게 해달라고해서 추가되었음 
작성자 : 배은화 (20231212)
-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.yido.clubd.common.utils.Globals" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:include page="../common/head.jsp" />
<jsp:include page="../common/script.jsp" />

<body class="theme-light">
    
<div id="preloader"><div class="spinner-border color-highlight" role="status"></div></div>
   
<div id="page">
	    
    <div class="header header-fixed header-logo-app">
        <a href="#" class="header-title header-subtitle">예약취소</a>
		<jsp:include page="../common/topBook.jsp" />
    </div>
    
    <div class="page-content header-clear-medium">

        <div class="content">
            <div class="d-flex mb-3" style="width:100%">
                <div>
                	<!-- 베이 이미지 -->
                    <img src="/images/gallery/${bkData.BAY_CD}.jpg?now=<%=new Date()%>" height="80" class="rounded-s shadow-xl">
                </div>
                <div class="pl-3" style="width:80%">
                	<!-- 지점 -->
                    <h1 class="font-20 mb-n3"> ${bkData.CO_NAME} </h1>
                    <!-- 베이 -->
                    <p class="mb-1 mt-2 color-highlight font-15"> ${bkData.BAY_NAME} </p>
                </div>
            </div>

            <div class="row mb-3 mt-4">
            	<!-- 방문날짜 -->
                <h5 class="col-4 text-left font-15">방문날짜</h5>
                <h5 class="col-8 text-right font-14 opacity-60"> ${bkDay} </h5>

				<!-- 이용시간 -->
                <h5 class="col-4 text-left font-15">이용시간</h5>
                <h5 class="col-8 text-right font-14 opacity-60"> ${bkData.BK_TIME} </h5>
  
            </div>
            <div class="divider"></div>

			<!-- 이용권 사용내역 -->
            <div class="">
                <h4 class="font-700">이용권 사용내역</h4>
                <div class="form-check icon-check">
				<input type="checkbox" name="checkbox" id="chkAll"> <label for="chkAll"> 전체선택</label>
					<i class="icon-check-1 far fa-square font-16" style="top:0"></i>
					<i class="icon-check-2 far fa-check-square font-16 color-highlight"></i>
				</div>
				<div class="divider mb-3"></div>
				
				<c:forEach items="${bkList}" var="bk">
				
					<div class="d-flex mb-2"> 
						<div class="w-100">
							<div class="form-check icon-check">
								<input type="hidden" id="bkTime_${bk.BK_SERIAL_NO}" value="${bk.BK_TIME}"/>	
						
								<!-- 이용권 선택 체크박스 -->
								<input class="form-check-input" type="checkbox" name="chkVoucher" id="check_${bk.SALE_SEQ}_${bk.SALE_DAY}_${bk.LIST_SEQ}" 
									value="${bk.BK_SERIAL_NO}" >
									<!-- onchange="chkVoucher(this, ${vc.SALE_SEQ}, '${vc.SALE_DAY}')"  -->
							
								<label class="form-check-label color-gray-dark" for="check_${bk.SALE_SEQ}_${bk.SALE_DAY}_${bk.LIST_SEQ}"> 
									${bk.VC_NAME} ( ${bk.BK_TIME2} )
								</label>
								
								<i class="icon-check-1 far fa-square color-gray-dark font-16" style="top:0"></i>
								<i class="icon-check-2 far fa-check-square font-16 color-highlight"></i>
							</div>
						</div>			
					</div>
					
				</c:forEach>
			
            </div>
            
			<div class="divider mt-4"></div>
			
			<div class="row">
				<div class="col-12">
				<a href="javascript:void(0);" onclick="showModal()"  class="mt-1 mb-10 btn btn-s bg-green-dark btn-full text-uppercase"> 
					취소하기
				</a>
				</div>
			</div>            
		</div> 
	</div>  
	<!--  content ends -->   
</div>   

<!-- 모달-->
<jsp:include page="../common/pop/modal.jsp" />

</body>

<jsp:include page="../common/alertModal.jsp" />  

<script type="text/javascript">

let coDiv	= "<c:out value='${coDiv}'/>";	
let bayName	= "<c:out value='${bkData.BAY_NAME}'/>";		
let bkDay	= "<c:out value='${bkDay}'/>";	
let bkListSize	= "<c:out value='${bkListSize}'/>";	

$(document).ready(function() {

	if (bkListSize <= 0 ) location.href="/book/bookList/"+coDiv;
	
	// 체크박스 최상단 click 
	$("#chkAll").click(function() {
		if($("#chkAll").is(":checked")) {
			$("input[name=chkVoucher]").prop("checked", true);
		} else{
			$("input[name=chkVoucher]").prop("checked", false);
		}		
	});
	
});

// 예약 취소 모달창 표출
function showModal(){
	
	$('#popBayName').text(bayName); 	// 예약명
	$('#popBkDay').text(bkDay);			// 방문날짜 
	
	// 선택된 목록 가져오기
	const query = 'input[name="chkVoucher"]:checked';
	const selectedEls = document.querySelectorAll(query);
	
	// 선택된 목록에서 value 찾기
	let bkTimeList = '';
	selectedEls.forEach((el) => {
		var tmpTime = $('#bkTime_'+el.value).val();
		var selectedTime = tmpTime.substring(0,2) + ":" + tmpTime.substring(2);
		
		if (bkTimeList=="") bkTimeList += selectedTime;
		else bkTimeList += "," + selectedTime;
	});

	if (bkTimeList == '') {
		alertModal.fail("취소할 이용권 사용내역을 선택해주세요.");
		return;
	}
	$('#popBkTime').text(bkTimeList);	// 예약시간
	
	$('#popVoucherTxt').css('display', 'none');
	$('#popVoucher').css('display', 'none');
	$('#popMnAmtTxt').css('display', 'none');
	$('#popMnAmt').css('display', 'none');
	  
	$('#modal_cancle').addClass('menu-active');
	$('.menu-hider').addClass('menu-active');
}

// 예약취소 
function doCancel(){
	
	$('#btnBookCancel').attr('onclick', '');		// 중복클릭방지
	
	// 선택된 목록 가져오기
	const query = 'input[name="chkVoucher"]:checked';
	const selectedEls = document.querySelectorAll(query);

	// 선택된 목록에서 value 찾기
	let csList = '';
	selectedEls.forEach((el) => {
		if (csList=="") csList += el.value;
		else csList += "," + el.value;
	});

	
	var reservationInfo 			= {};
	reservationInfo.cancelSerialNo 	= csList;
	reservationInfo.coDiv 			= coDiv;

   	$.ajax({
   		url: "/voucher/partialCancel/"
   		, type: "post"
   		, dataType: 'json'
   		, data: reservationInfo
   		, contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
   		, success: function(data) {    			
   			if (data.code == '0000') {
   				location.reload();
   			} else if (data.code == '9999') {
   				alertModal.fail(data.message);
   			}
   		}
   	});	    
}

</script>
</html>