<!-- 
기능 : 예약 2단계 페이지 (예약 정보 확인, 이용권 선택) 
	-> 해당 페이지에서는 하단바, 메뉴 모두 안보이게 처리함
	   ( 예약선점된 채로 페이지 이동되는 문제 때문에 )
작성자 :bae
-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.yido.clubd.common.utils.Globals" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:include page="../common/head.jsp" />
<jsp:include page="../common/script.jsp" />
<style>
.line-through{
 text-decoration: line-through; /* 중간 선 추가 */
}
</style>
<body class="theme-light">
    
	<div id="preloader"><div class="spinner-border color-highlight" role="status"></div></div>
    
	<div id="page">
	    
	    <div class="header header-fixed header-logo-app">
	        <a href="#" class="header-title header-subtitle">예약확인</a>
			<jsp:include page="../common/topBook.jsp" />
	    </div>
    
    <div class="page-content header-clear-medium">
      <!--   <div class="menu-title">
            <h1 class="my-0 py-0">예약정보확인</h1>
        </div>
        <div class="divider"></div> -->
        <div class="content">
            <div class="d-flex mb-3" style="width:100%">
                <div>
                	<!-- 베이 이미지 -->
                    <img src="/images/gallery/${bay.bayCd}.jpg?now=<%=new Date()%>" height="80" class="rounded-s shadow-xl">
                </div>
                <div class="pl-3" style="width:80%">
                	<!-- 지점 -->
                    <h1 class="font-20 mb-n3"> ${place.coName} </h1>
                    <!-- 베이 -->
                    <p class="mb-1 mt-2 color-highlight font-15"> ${bay.bayName} </p>
                    <!-- <p class="line-height-s font-12 font-500">서울시 청담동 청담로 988</p>  --> 
                </div>
            </div>

            <div class="row mb-3 mt-4">
            	<!-- 방문날짜 -->
                <h5 class="col-4 text-left font-15">방문날짜</h5>
                <h5 class="col-8 text-right font-14 opacity-60"> ${bkDay} </h5>

				<!-- 이용시간 -->
                <h5 class="col-4 text-left font-15">이용시간</h5>
                <h5 class="col-8 text-right font-14 opacity-60"> ${bkHis.bkTime} </h5>
             
             	<p class="col-12 text-right font-11 color-red-dark">
             	※ 이용시간 ${useTime}분, 정리시간은 ${gapTime}분입니다.
             	</p>	
             	<!-- 
                <h5 class="col-4 text-left font-15">예약장소</h5>
                <h5 class="col-8 text-right font-14 opacity-60 ">서울시 청담동 클럽디청담</h5>
 				-->
          
            </div>
            <div class="divider"></div>

			<!-- 보유 이용권 -->
            <div class="">
                <h4 class="font-700">보유 이용권</h4>

				<!-- 이용권 목록 -->	
				<c:forEach items="${vcList}" var="vc">
					<!-- 조건 추가 - 배은화 (20230524) -->
					<c:if test="${vc.VC_SALE == '%' or vc.VC_SALE == sessionScope.msMember.msDivision}">
					<div class="d-flex mb-2"> 
						<input type="hidden" id="remCnt${vc.SALE_SEQ}" value="${vc.VC_REM_CNT}"/>			<!-- 잔여수량 -->
						<input type="hidden" id="saleDay${vc.SALE_SEQ}" value="${vc.SALE_DAY}"/> 			<!-- 이용권 구매일자 -->
						<input type="hidden" id="dayLimit${vc.SALE_SEQ}" value="${vc.VC_DAY_LIMIT_CNT}"/> 	<!-- 이용권 일 사용제한 횟수 -->
						<input type="hidden" id="coDiv${vc.SALE_SEQ}" value="${vc.CO_DIV}"/> 		
						<div class="w-100">
						
							<div class="form-check icon-check">
							
								<!-- 이용권 선택 체크박스 --> 
								<input class="form-check-input" type="checkbox" name="chkVoucher" id="check_${vc.SALE_SEQ}_${vc.SALE_DAY}" 
									value="${vc.SALE_SEQ}" onchange="chkVoucher(this, ${vc.SALE_SEQ}, '${vc.SALE_DAY}')"  
									<c:if test="${vc.voucherUseYn == 'N'}">disabled</c:if>>
								<!-- 이용권 (잔여수량) -->
								<label class="form-check-label color-gray-dark  <c:if test="${vc.voucherUseYn == 'N'}">line-through</c:if>" for="check_${vc.SALE_SEQ}_${vc.SALE_DAY}" > 
									${vc.VC_NAME}(잔여${vc.VC_REM_CNT}장)
								</label>
								
								<!-- 이용권 개당 가격 
								<input type="hidden" name="" id="" value="${vc.SALE_SEQ}" />-->
								
								<i class="icon-check-1 far fa-square color-gray-dark font-16" style="top:0"></i>
								<i class="icon-check-2 far fa-check-square font-16 color-highlight"></i>
							</div>
							
							<!-- 유효기간 -->
							<p class="mb-0 mt-n2 pl-4 color-red-dark font-10 opacity-80">유효기간: ${vc.VC_TO_DAY}까지</p>
						</div>
						
						<c:if test="${vc.voucherUseYn != 'N'}">
						<div class="ml-auto text-right">
							<div class="stepper rounded-s switch-s mr-n2 mt-n2">
								<!-- 수량 선택 -->
								<a href="#" class="stepper-sub font-14" onClick="chkQuantity('minus', ${vc.SALE_SEQ}, '${vc.SALE_DAY}')">
									<i class="fa fa-minus color-theme opacity-40"></i>
								</a>
								<input style="font-size:15px !important" id="quantity_${vc.SALE_SEQ}_${vc.SALE_DAY}" type="number" min="1" max="${vc.VC_REM_CNT}" value="0" readonly>
								<a href="#" class="stepper-add font-14" onClick="chkQuantity('plus',${vc.SALE_SEQ}, '${vc.SALE_DAY}')">
									<i class="fa fa-plus color-theme opacity-40"></i>
								</a>
							</div>
							<div class="clearfix"></div>
						</div>
						</c:if>
					</div>
					</c:if>
					
				</c:forEach>
				<c:if test="${empty vcList}">
				보유중인 이용권이 없습니다.
				</c:if>
				<!--//이용권-->
            </div>
			
			<div class="divider mt-4"></div>
			
			<div class="row">
				<!-- 결제금액 -->
				<div class="col-6">
					<h6 class="font-16">결제금액</h6>
				</div>
				<div class="col-6">
					<h6 class="font-16">
						<fmt:formatNumber value="${amount}" pattern="#,###" />원 
						<input type="hidden" name="amount" id="amount" value="${amount}"/>
					</h6>
				</div>
				<div class="w-100 pt-1"></div>
			
				<!-- 이용권사용 -->
				<div class="col-6 vcCnt" style="display:none">
					<h6 class="font-16 color-blue-dark">이용권사용 </h6>
				</div>
				<div class="col-6 vcAmt" style="display:none">
					<!-- 이용권 금액 -->
					<h6 class="font-16 color-blue-dark txtVcAmt"></h6>
					<input type="hidden" name="vcAmount" id="vcAmount" value=""/>
				</div>
				<div class="w-100 pt-2"></div>
			
				<!-- 최종결제금액 -->
				<div class="col-6 mt-1">
					<h6 class="font-700 font-21">최종결제금액 </h6>
				</div>
				<div class="col-6">
					<h6 class="font-700 font-26 txtTotAmt">
						<fmt:formatNumber value="${amount}" pattern="#,###" />원 
					</h6>
					<input type="hidden" name="totAmount" id="totAmount" value="${amount}"/>
				</div>
			</div>
			
			<div class="divider mt-3"></div>
			<c:if test="${empty vcList}">
				<!-- 보유중인 이용권 없는경우 -->
				<a data-menu="modal_buyTicket" href=""  class="mt-1 mb-10 btn btn-s bg-green-dark btn-full text-uppercase"> 
					결제진행
				</a>
			</c:if>
			<c:if test="${not empty vcList}">
				<a data-menu="modal_pay" href=""  class="mt-1 mb-10 btn btn-s bg-green-dark btn-full text-uppercase"> 
					결제진행
				</a>
			</c:if>
		</div> 
	</div>  
	<!--  content ends -->   
</div>   

<!-- 모달-->
<jsp:include page="../common/pop/modal.jsp" />

</body>

<jsp:include page="../common/alertModal.jsp" />  

<script type="text/javascript">

var coDiv 			= "<c:out value='${place.coDiv}'/>";				// 지점코드
var entryDatetime	= "<c:out value='${markData.entryDatetime}'/>";		// 해당예약에 대한 선점시간 (15분) 
var entryDt 		= "";

var msId 			= "<c:out value='${sessionScope.msMember.msId}'/>";
var amount 			= "<c:out value='${amount}'/>";		// 결제할 금액
var timeAmt 		= "<c:out value='${timeAmt}'/>";	// 시간당 금액 (이용권1장 = 시간당금액)
var totAmount		= "<c:out value='${amount}'/>";		// 최종 결제할 금액
var vAmount 		= 0;								// 총 사용할 이용권금액
var selectedCnt 	= 0;								// 선택된 이용권의 총 수량

var msNum			= "<c:out value='${sessionScope.msMember.msNum}'/>";
var msLevel 		= "<c:out value='${sessionScope.msMember.msLevel}'/>";
var msEmail 		= "<c:out value='${sessionScope.msMember.msEmail}'/>";
if (msEmail=="undefined") msEmail = "";

var msName 			= "<c:out value='${sessionScope.msMember.msName}'/>";

var reservationInfo 			= {};
reservationInfo.coDiv 			= coDiv;		
reservationInfo.bkAmount 		= totAmount; 
reservationInfo.oriBkAmount	 	= amount; 
reservationInfo.bayCondi 		= "<c:out value='${bay.bayCd}'/>"; 			// 베이코드 
reservationInfo.bayName			= "<c:out value='${bay.bayName}'/>";
reservationInfo.bayName2		= "<c:out value='${bay.bayName2}'/>";		// SMS 전송시 공통코드 cd_title2 컬럼 사용
reservationInfo.bkDay 			= "<c:out value='${bkHis.bkDay}'/>"; 		// 예약임시테이블 
reservationInfo.bkTime 			= "<c:out value='${bkHis.bkTime2}'/>"; 		// 예약임시테이블 
reservationInfo.tempSerialNo	= "<c:out value='${bkHis.serialNo}'/>"; 	// 예약임시테이블 
reservationInfo.bkSeq			= "<c:out value='${markData.bkSeq}'/>";		// 선점테이블 SEQ
reservationInfo.ipAddr			= "<c:out value='${markData.entryIp}'/>";	// 선점테이블 USER IP

var vList 						= new Array();		// 이용권 정보 

timeAmt = Number(timeAmt);
amount = Number(amount);

$(document).ready(function() {
	
	if (entryDatetime != null && entryDatetime != "") {
		entryDt = new Date(entryDatetime);
	} else {		
		location.href = "/book/bookMain/"+coDiv;	
		return;
	}
	
	// 하단바  버튼 클릭시 모달창 뜨도록 
	// document.getElementById('footerBook').setAttribute( 'data-menu', 'modal_btnBook' );
	
	// 좌측 상단 [뒤로가기] 클릭시 모달창 뜨도록 
	$('#topGoBack').removeClass('back-button');
	document.getElementById('topGoBack').setAttribute( 'data-menu', 'modal_back' );
	
	setInterval("chkMark()", 5000); // 5초마다 chkMark() 함수 실행
});

function goVoucherMain() {
	// 이용권 구매 페이지로 이동 
	location.href="/voucher/voucherMain/" + coDiv;
}

// 예약선점 시간 지난 경우에 페이지 벗어나도록  
function chkMark() {
	var now = new Date();
	
	if (entryDt <= now) {
    	$.ajax({
    		url: "/book/getMark/"
    		, type: "post"
    		, dataType: 'json'
    		, data: reservationInfo
    		, contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
    		, success: function(data) {
				// 데이터 존재하지 않으면 예약 메인 페이지로 이동
				if (data == null || data.bkDay == null) {
					location.href="/book/bookMain/" + coDiv;
					
				}
    		}
    	});	   		
	}
}

// 이용권 체크박스 선택
function chkVoucher(checked, seq, saleDay) {

	let vouKey = "_"+seq+"_"+saleDay;
	
	// 이용권 체크박스 
    const chkVou = document.getElementsByName("chkVoucher");
    const chkLength = $("input:checkbox[name='chkVoucher']:checked").length;   
	var quantity = Number($('#quantity'+vouKey).val());

	if( checked.checked == true ){
		// 이용권 선택

		if (quantity == 0) {
			$('#quantity'+vouKey).val(1);
			quantity = Number($('#quantity'+vouKey).val());
		}
		
		if ((timeAmt * quantity) > totAmount) {
			$("input:checkbox[id='check"+vouKey+"']").prop("checked", false);
			$('#quantity'+vouKey).val(quantity-1);	// 현재 선택된 이용권의 수량 -1 
			alertModal.fail('이용권 사용금액이 결제금액보다 클 수 없습니다.');
			return;
		}

		vAmount += (timeAmt * quantity);	// 이용권 1장당 금액 * 수량 
		totAmount = amount - vAmount;		// 결제금액 - 이용권 총 사용금액
		selectedCnt += 1;

		// 이용권금액
	 	document.querySelector(".txtVcAmt").innerHTML = "-" + (vAmount).toLocaleString("ko-KR") + "원";
		$("#vcAmount").val(vAmount);
		
		// 총결제금액
	 	document.querySelector(".txtTotAmt").innerHTML = (totAmount).toLocaleString("ko-KR") + "원";
		$("#vcAmount").val(totAmount);
		
		$('.vcCnt').css('display', 'inline');
		$('.vcAmt').css('display', 'inline');
				
	} else {
		// 이용권 선택 해제
		
		// 총금액 - 선택된 이용권 금액 
		vAmount -= (timeAmt * quantity);
		totAmount = amount - vAmount;	// 결제금액 - 이용권금액 = 최종 결제할 금액
		selectedCnt -= 1;
		
		// 이용권금액
	 	document.querySelector(".txtVcAmt").innerHTML = "-" + (vAmount).toLocaleString("ko-KR") + "원";
		$("#vcAmount").val(vAmount);
		
		// 총결제금액
	 	document.querySelector(".txtTotAmt").innerHTML = (totAmount).toLocaleString("ko-KR") + "원";
		$("#vcAmount").val(totAmount);

		// 선택되어있는 이용권이  0개인 경우에만 숨김처리 
		if (chkLength == 0) {
    		$('.vcCnt').css('display', 'none');
    		$('.vcAmt').css('display', 'none');
		}
		
		$('#quantity'+vouKey).val('0');	
	}
	
	console.log("이용권 총 금액 : " , vAmount);
}

// 수량 선택시 호출되는 함수
function chkQuantity(type, seq, saleDay){

	let vouKey = "_"+seq+"_"+saleDay;
	
	// 이용권 체크박스 
    const chkVou = document.getElementsByName("chkVoucher");					// 모든 이용권
	const chkThis = document.getElementById('check'+vouKey);					// 현재 선택한 이용권
    const chkLength = $("input:checkbox[name='chkVoucher']:checked").length;   	// 선택된 이용권 개수
	const dayLimit = document.getElementById('dayLimit'+seq).value;				// 현재 선택한 이용권 일 사용제한 횟수
		  
	var quantity = Number($('#quantity'+vouKey).val());
	var remCnt = Number($('#remCnt'+seq).val());

	console.log("수량선택 > amount : ", amount , " , vAmount : " , vAmount); 
	switch (type) {
		case "minus" :
			
			quantity -= 1;
			
			if (quantity == 0 && chkThis.checked == false) {
				quantity += 1;
				$('#quantity'+vouKey).val(quantity+1);	
				alertModal.fail('이용권을 선택해주세요.');
				return;
			} else if (quantity < 0) {
				quantity += 1;
				$('#quantity'+vouKey).val(quantity+1);					
				return;
			}
			
			if (chkLength == 1 && quantity <= 0) {
				// 수량이 0이면 체크박스 자동으로 해제되도록
				$("input:checkbox[id='check"+vouKey+"']").prop("checked", false);
				$('.vcCnt').css('display', 'none');
				$('.vcAmt').css('display', 'none');	
			}
			// 이용권 일 사용횟수 체크 로직 추가 - 배은화 (20231107)
			if (quantity > dayLimit) {
				quantity -= 1;
				$('#quantity'+vouKey).val(quantity-1);	// 현재 선택된 이용권의 수량 -1 
				alertModal.fail('일 사용 제한횟수를 초과하였습니다. 일 사용 제한 횟수는 ' + dayLimit + '회 입니다.');
				return;
			}
			
			// 이용권 체크박스 반복문 
			var totSelectedAmt = 0;		// [선택된 이용권+수량]의 금액 합계 	
		    for (let i = 0; i < chkVou.length; i++) {
		    
		    	if (chkVou[i].checked == true) {
					let chkVouVal = Number(chkVou[i].value);
					let chkVouId = (chkVou[i].id).substr(6);
					let oriChkVouId = (chkVou[i].id).trim();		
					let cprVouId = "check_"+seq+"_"+saleDay;

		    		// 선택된 이용권 수량 
		    		var tmpCnt = 0;
		    		
		    		if (oriChkVouId == cprVouId ) {
		    			// 현재 선택된 이용권이라면 + 1 
		    			tmpCnt = Number($('#quantity_'+chkVouVal+"_"+saleDay).val()) - 1; 	
		    		} else {
		    			tmpCnt = Number($('#quantity_'+chkVouId).val()); 	
		    		}
		    		// end.
		    		
		    	    totSelectedAmt += timeAmt * tmpCnt;		
		    	    			    	   
					if (tmpCnt == 0) {
						// 수량 0개되면 해당 이용권 체크박스 선택해제	
						$("input:checkbox[id='check_"+chkVouVal+"_"+saleDay+"']").prop("checked", false);
					}
		    	}
		    	vAmount = totSelectedAmt;
		    }			
			// end.

			totAmount = amount - vAmount;	// 결제금액 - 이용권금액 = 최종 결제할 금액 
			
			break;

		case "plus" :
			quantity += 1;
			
			// 수량이 1이상이면 체크박스 자동으로 선택되도록
			if (quantity > 0) {
				$("input:checkbox[id='check"+vouKey+"']").prop("checked", true);
			}	
			
			if (quantity == 2) selectedCnt = quantity;
			else selectedCnt += 1;

			// 선택된 수량이 잔여수량보다 크면 중단 
			if (quantity > remCnt) {
				quantity -= 1;
				$('#quantity'+vouKey).val(quantity-1);	// 현재 선택된 이용권의 수량 -1 
				alertModal.fail('잔여수량 초과하였습니다.');
				return;
			}	
			
			// 이용권 일 사용횟수 체크 로직 추가 - 배은화 (20231107)
			if (quantity > dayLimit) {
				quantity -= 1;
				$('#quantity'+vouKey).val(quantity-1);	// 현재 선택된 이용권의 수량 -1 
				alertModal.fail('일 사용 제한횟수 초과! 일 사용 제한 횟수는 ' + dayLimit + '회 입니다.');
				return;
			}
			

			// 이용권 체크박스 반복문 
			var totSelectedAmt = 0;		// [선택된 이용권+수량]의 금액 합계 	
		    for (let i = 0; i < chkVou.length; i++) {
		    	if (chkVou[i].checked == true) {
					let chkVouVal = Number(chkVou[i].value);
					let chkVouId = (chkVou[i].id).substr(6);
					let oriChkVouId = (chkVou[i].id).trim();		
					let cprVouId = "check_"+seq+"_"+saleDay;

		    		// 선택된 이용권 수량 
		    		var tmpCnt = 0;
		    		console.log('선택된 이용권 : ', oriChkVouId, ', 수량 선택된 이용권 ; ', cprVouId);
		    		if (oriChkVouId == cprVouId) {
		    			console.log('현재 선택된 이용권');
		    			// 현재 선택된 이용권이라면 + 1 
		    			tmpCnt = Number($('#quantity_'+chkVouVal+"_"+saleDay).val()) + 1; 	
		    			console.log('수량 : ' , tmpCnt);
		    		} else {
		    			console.log('현재 선택된 이용권 아님');
		    			tmpCnt = Number($('#quantity_'+chkVouId).val()); 	
		    			console.log('수량 : ' , tmpCnt);
		    		}
		    		// end.
					
		    		console.log('==> 1 > vAmount : ', vAmount, ', totSelectedAmt : ', totSelectedAmt , ', timeAmt : ' ,  timeAmt , ', tmpCnt : ' ,  tmpCnt);
					totSelectedAmt += timeAmt * tmpCnt;
		    		console.log('==> 2 > vAmount : ', vAmount, ', totSelectedAmt : ', totSelectedAmt , ', timeAmt : ' ,  timeAmt , ', tmpCnt : ' ,  tmpCnt);
		    	}
		    	vAmount = totSelectedAmt;
		    }			
			// end.

			// 선택된 수량의 금액이 결제금액보다 크면 중단
			console.log('선택된 이용권 금앣 : ', totSelectedAmt , ', 결제금액 : ' , amount);
			if (totSelectedAmt > amount) {
				quantity -= 1;
				$('#quantity'+vouKey).val(quantity-1);	// 현재 선택된 이용권의 수량 -1 
				
				vAmount -= timeAmt;
				totSelectedAmt -= vAmount;

				alertModal.fail('이용권 사용금액이 결제금액보다 클 수 없습니다.');
				return;
			}
			// end.
			
			$('.vcCnt').css('display', 'inline');
			$('.vcAmt').css('display', 'inline');

			totAmount = amount - vAmount;
			
			break;
	}

	// 이용권금액
 	document.querySelector(".txtVcAmt").innerHTML = "-" + (vAmount).toLocaleString("ko-KR") + "원";
	$("#vcAmount").val(vAmount);
	
	// 총결제금액
 	document.querySelector(".txtTotAmt").innerHTML = (totAmount).toLocaleString("ko-KR") + "원";
	$("#vcAmount").val(totAmount);
	
}

// 결제 약관동의 및 결제진행
function doPay() {
	
	const checkbox = document.getElementById('chkAgree');
	const isChk = checkbox.checked;
	
	if (isChk == false) {
		alertModal.fail('예약규정 약관에 동의해주세요.');
		return;
	}

	// 이용권 정보
    const chkVou = document.getElementsByName("chkVoucher");	// 모든 이용권

    for (let i = 0; i < chkVou.length; i++) {
    	if (chkVou[i].checked == true) {
			let chkVouId = (chkVou[i].id).substr(6);
   
    		var vData = new Object();	
    		vData.coDiv 	= $('#coDiv'+chkVou[i].value).val();
    		vData.saleSeq 	= chkVou[i].value;
    		vData.saleDay 	= $('#saleDay'+chkVou[i].value).val();
    		vData.amount 	= $('#amount'+chkVou[i].value).val(); 	
    		vData.quantity	= $('#quantity_'+chkVouId).val(); 	
    		vList.push(vData);
    	}
    }
    
    if (vList != null) reservationInfo.vList = vList;
    // end.
	
	// 이용권 사용하는 경우에는 잔여수량 체크 
    if (vList != null && vList.length > 0) {
	   	$.ajax({
	   		url: "/voucher/checkRemCnt/"
	   		, type: "post"
	   		, dataType: 'json'
	   		, data: reservationInfo
	   		, contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
	   		, success: function(data) {	   			
	   			if (data) {
	   				alert("잔여수량이 부족한 이용권이 존재합니다. 확인 후 다시 예약해주세요.");
	   				location.reload();
	   			} else {
	   				doPay2(vList, totAmount);
	   			}
	   		}
	   	});	       
    } else {
    	doPay2(vList, totAmount);
    }
}

function doPay2(vList, totAmount) {
	
    if (vList != null && totAmount == 0) {
        // 결제할 요금이 0원이면 결제창 띄우지 않고, 이용권으로 처리
    	$.ajax({
    		url: "/voucher/vPay/"
    		, type: "post"
    		, dataType: 'json'
    		, data: reservationInfo
    		, contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
    		, success: function(data) {
    			if (data.code == '0000') {
    				// 결제완료 페이지로 이동
    				location.href="/book/bookConfirm";
    			} else if (data.code == '9999') {
    				alertModal.fail(data.message);   				
    			}
    		}
    	});	        
    	
    } else {
    	// 결제창 띄우기 
    	var params = {
    		"key"      	  : msNum
    		, "serviceId" : "<%=Globals.serviceId%>"
    		, "amount"    : totAmount
    		, "returnUrl" : "<%=Globals.returnPayUrl%>"
    		, "itemCode"  : "0004"
    		, "itemName"  : "예약"
    		, "userId"    : msId
    		, "userName"  : msName
    		, "userMail"  : msEmail
    		, "reserved1" : coDiv
    		, "reserved2" : "RESERVATION"
    		, "reserved3" : JSON.stringify(reservationInfo)
    		, "protocol"  : "<%=Globals.protocolType%>"
    	}
    	
    	mPay.action(params, function() {
			// 결제완료 페이지로 이동
			location.href="/book/bookConfirm";
    	}, function() {
    		// 결제 실패했을때 예약 선점된거 풀기 
    		fnUnBkMark(reservationInfo, 'reload');		
    		
    	});   	   	
    } 		
    
}

// 예약 선점된거 풀기 + 예약 임시테이블 데이터 삭제 
function fnUnBkMark(reservationInfo, type) {
	var result = new Object();
	
	reservationInfo.tempDelYn = 'Y';
	
	$.ajax({
		url: "/book/unBkMark"
		, type: "post"
		, dataType: 'json'
		, data: reservationInfo
		, contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
		, success: function(result) {
	
			if (result.code == '0000'){
				if ( type == "reload" ){
					setTimeout(function() { 
						location.href="/pay/payFailed";
					}, 50);
				}
			}
		}
	});
	
	return result;
}

// 뒤로가기 (예약선점해제)
function goBack() {
	fnUnBkMark(reservationInfo, 'back');
	setTimeout(function() { window.history.go(-1); }, 50);
}
</script>
</html>