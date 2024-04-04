<!-- 
기능 : 프로모션 신청 
	-> 해당 페이지에서는 하단바, 메뉴 모두 안보이게 처리함
	   ( 선점된 채로 페이지 이동되는 문제 때문에 )
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
	    
	    <div class="header header-fixed header-logo-appf bg-brown-dark">
	        <a href="#" class="header-title header-subtitle color-white ml-3">프로모션</a>
	    </div>
	    
	    <!-- 좌측GNB-->
		<jsp:include page="../common/menu.jsp" />
		<!-- //좌측GNB-->
	
	    <div class="page-content header-clear-medium">
	
			<div class="mt-3 mb-0">
				<div class="d-flex mb-3">
					<div>
						<!-- 제목 -->
						<p class="pl-3 line-height-s color-theme mb-1 font-15">
						<c:if test="${not empty mainPrm}">
							${mainPrm.pmName} <br>${prm.pmName}
						</c:if>
						<c:if test="${empty mainPrm}">
							${prm.pmName}
						</c:if>
						</p>
					</div>
				</div>
				
			</div>

		<div class="content">
			<!-- 신청서 -->
			<textarea style="height: 200px;padding: 10px;line-height: unset; "id="pmFormat" class="form-control">${prm.pmFormat}</textarea>
			<br/>
			<a href="#" data-menu="modal_pay" id="btnPay"  class="mt-1 mb-3 btn btn-s bg-green-dark btn-full text-uppercase">
				신청하기
			</a>
			
			<a href="#" id="pageGoBack" data-menu="modal_prmBack" class="mt-1 mb-4 btn btn-s bg-gray-dark btn-full text-uppercase">
				이전페이지
			</a>
		</div>
				
		<div class="row">
		</div>
	</div>  
</div>   

</body>

<!-- 모달-->
<jsp:include page="../common/pop/modal.jsp" />

<script type="text/javascript">

var msId 			= "<c:out value='${sessionScope.msMember.msId}'/>";
var msNum			= "<c:out value='${sessionScope.msMember.msNum}'/>";
var msEmail 		= "<c:out value='${sessionScope.msMember.msEmail}'/>";
var msName 			= "<c:out value='${sessionScope.msMember.msName}'/>";
var coDiv 			= "<c:out value='${prm.coDiv}'/>";
var cancelLimit 	= "<c:out value='${prm.pmCancelLimit}'/>";		// 취소가능일자 (2 = 2일전까지 가능)
var totAmount 		= "<c:out value='${prm.drAmount}'/>";			// 결제금액
var entryDatetime	= "<c:out value='${markData.entryDatetime}'/>";	// 해당 프로모션 선점시간
var entryDt 		= "";

let mainPrm		= "<c:out value='${mainPrm}'/>";
let pmName		= "<c:out value='${prm.pmName}'/>";

if (mainPrm == "") {
	console.log('메인프로모션');
} else {
	console.log('서브프로모션');
	let mainPmName = "<c:out value='${mainPrm.pmName}'/>";
	pmName = mainPmName + " [" + pmName + "]";
}

var reservationInfo 			= {};
reservationInfo.coDiv 			= coDiv;
reservationInfo.pmSerialNo 		= "<c:out value='${prm.pmSerialNo}'/>"; 	// 프로모션번호
reservationInfo.markSeq			= "<c:out value='${markData.markSeq}'/>";	// 선점 고유번호 
reservationInfo.pmName 			= pmName; 		// 프로모션명

var prmViewUrl		= "/promotionView/" + reservationInfo.pmSerialNo;

$(document).ready(function() {
	init();

	if (entryDatetime != null && entryDatetime != "") {
		entryDt = new Date(entryDatetime);
	} else {		
		location.href = prmViewUrl;
		return;
	}
	
	setInterval("chkMark()", 5000); // 5초마다 chkMark() 함수 실행
});

function init() {
	// 기본서식 textarea 줄바꿈 처리 
	var str = document.getElementById("pmFormat").value;
	str = str.replaceAll("<br/>", "\r\n");
	document.getElementById("pmFormat").value = str;
}


//뒤로가기 (선점해제)
function goBack() {
	fnUnBkMark(reservationInfo);
}

// 선점된거 풀기 
function fnUnBkMark(reservationInfo) {
	var result = new Object();
	
	$.ajax({
		url: "/promotion/unBkMark"
		, type: "post"
		, dataType: 'json'
		, data: reservationInfo
		, contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
		, success: function(result) {
			if (result.code == '0000'){
				location.href = prmViewUrl;
			}
		}
	});
	
	return result;
}

// 선점 시간 지난 경우에 페이지 벗어나도록  
function chkMark() {

	var now = new Date();

	if (entryDt <= now) {
	 	$.ajax({
	 		url: "/promotion/getMark/"
	 		, type: "post"
	 		, dataType: 'json'
	 		, data: reservationInfo
	 		, contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
	 		, success: function(data) {
	 	
				// 데이터 존재하지 않으면 예약 메인 페이지로 이동
				if (data == null || data.msId == null) {
					location.href = prmViewUrl;					
				}
	 		}
	 	});	   		
	}
}

/* 결제하기 버튼 클릭 */
function doPay() {
	
	const checkbox = document.getElementById('chkAgree');
	const isChk = checkbox.checked;
	
	if (isChk == false) {
		alertModal.fail('결제규정 약관에 동의해주세요.');
		return;
	}
	
	reservationInfo.content = $('#pmFormat').val();
    console.log('reservationInfo: ', reservationInfo);
    
	// 결제창 띄우기 
	var params = {
		"key"      	  : msNum
		, "serviceId" : "<%=Globals.serviceId%>"
		, "amount"    : totAmount
		, "returnUrl" : "<%=Globals.returnPayUrl%>"
		, "itemCode"  : "0006"
		, "itemName"  : "프로모션"
		, "userId"    : msId
		, "userName"  : msName
		, "userMail"  : msEmail
		, "reserved1" : coDiv
		, "reserved2" : "PROMOTION"
		, "reserved3" : JSON.stringify(reservationInfo)
		, "protocol"  : "<%=Globals.protocolType%>"
	}

	mPay.action(params, function() {
		// 결제완료 페이지로 이동
		location.href="/promotion/confirm";
	}, function() {
		// 결제 실패했을때	
		location.href="/pay/payFailed";
	});  
}

</script>
</html>