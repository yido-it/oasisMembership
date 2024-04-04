<!-- 
기능 : 프로모션 상세
작성자 :bae
-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.yido.clubd.common.utils.Globals" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<c:if test="${not empty prm}">
	<fmt:parseDate value="${prm.pmEventFromDay}" var="fromDt" pattern="yyyyMMdd"/>
	<fmt:parseDate value="${prm.pmEventEndDay}" var="endDt" pattern="yyyyMMdd"/>
</c:if>

<jsp:include page="../common/head.jsp" />
<jsp:include page="../common/script.jsp" />

<body class="theme-light">
    
	<div id="preloader"><div class="spinner-border color-highlight" role="status"></div></div>
    
	<div id="page">
	    <div class="header header-fixed header-logo-app">
	        <a href="#" class="header-title header-subtitle">프로모션</a>
			<jsp:include page="../common/top.jsp" />
	    </div>
	    
	    <!-- 좌측GNB-->
		<jsp:include page="../common/menu.jsp" />
		<!-- //좌측GNB-->
	
	<c:if test="${not empty prm}">
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
					<!-- 기간 -->
					<p class="mb-0 pl-3 font-12 pt-1 opacity-60"><i class="fa fa-clock pr-1"></i>
					신청기간 : ${prm.pmFromDay} ~ ${prm.pmEndDay}
					</p> 
			
				</div>
			</div>
			<div class="divider mb-3"></div>
		</div>

		<div class="content">
					
			<!-- 상세 -
			<p class="mt-2">
			- 행사일 :
			<c:if test="${prm.pmEventFromDay == prm.pmEventEndDay}">
				<fmt:formatDate value="${fromDt}" pattern="yy.MM.dd"/>
			</c:if>
			<c:if test="${prm.pmEventFromDay != prm.pmEventEndDay}">
				<fmt:formatDate value="${fromDt}" pattern="yy.MM.dd"/> ~ <fmt:formatDate value="${endDt}" pattern="yy.MM.dd"/>
			</c:if>
			
			
			<br/> - 금액 : <fmt:formatNumber value="${prm.drAmount}" pattern="#,###" />원 
			<br/> - 인원 : <fmt:formatNumber value="${prm.pmLimitCount}" pattern="#,###" />명
			(현재 신청 가능 인원 : <fmt:formatNumber value="${avlPrs}" pattern="#,###" />명)
			->
			<!--<c:if test="${promotion.pmDrinkYn == 'Y'}"><br/> - 주류판매여부 : O</c:if>
			
			<c:if test="${prm.pmSex == '1'}"><br/> - 남성만 신청 가능 </c:if>
			<c:if test="${prm.pmSex == '2'}"><br/> - 여성만 신청 가능 </c:if>
			</p>-->
			
			<!-- 이미지 -->
			<c:if test="${not empty prm.imgPath}">
			<div>
				<img src="${prm.fileURL}" style="width:100%">
			</div>
			</c:if>
			
			<!-- 내용 -->
			<p class="mt-2" id="pmContent">${prm.pmContent}</p>

		</div>
		
		<!-- 서브프로모션 있는 경우 -->
		<c:if test="${not empty subList}">
			<!-- 이미지 없는 경우 버튼으로 표출 -->
			<c:if test="${subBtnYn == 'Y'}">
				<div id="subPromotion"> 
				<div class="content"> 
					<div class="row mb-0">
						<c:forEach items="${subList}" var="subPm">
		                <div class="col-12 btn_subPromotion">
		                    <a href="#" onclick="location.href='/promotionView/${subPm.pmSerialNo}'" class="btn btn-sm btn-full mb-3 bg-green-dark">
		                    	${subPm.pmName}
		                    </a>
		                </div>
						</c:forEach>
		
		            </div>
				</div>		
				</div>		
			</c:if>
			
			<!-- 이미지 있는 경우 이미지로 표출 -->
			<c:if test="${subBtnYn == 'N'}">
				<div id="subPromotion" style="margin:0px 15px"> 
				<c:forEach items="${subList}" var="subPm">
					<c:if test="${not empty subPm.imgPath}">
						 <div class="card card-style mx-0 bg-9"  
							style="background-image: url(${subPm.fileURL});height: 130px;" 
							onclick="location.href='/promotionView/${subPm.pmSerialNo}'">
						</div>  
					</c:if>
				</c:forEach>
			</div>	
			</c:if>		
		</c:if>

		<!-- 서브프로모션 없는 경우 -->
		<c:if test="${empty subList}">
			<c:if test ="${prm.pmBasicYn == 'N'}">
			<!-- 기본폼 사용하지 않는 경우 바로 결제창 표출 -->
			<div class="row" id="btnOpen">
				<button type="button"  data-menu="modal_pay" id="btnPay"  class="col-10 btn btn-sm btn-full mb-3 bg-green-dark" style="margin:0 auto">            	
					신청하기 
				</button>
			</div>
			</c:if>
			<c:if test ="${prm.pmBasicYn == 'Y'}">
			<!-- 기본폼 사용하는 경우 신청폼으로 이동 -->
			<div class="row" id="btnOpen">
				<button onClick="doPay()" type="button" class="btn col-10 btn-sm btn-full mb-3 bg-green-dark" style="margin:0 auto">            	
					신청하기 
				</button>
			</div>
			</c:if>
			<div class="row" id="btnClose" style="display:none">
				<button type="button" class="col-6 mt-2 mb-10 btn btn-md bg-red-dark shadow-xl text-uppercase font-800 rounded-s" style="margin:0 auto">            	
					신청마감
				</button>
			</div>
		</c:if>
		<div class="row" id="btnLogin" style="display:none">
			<button type="button" onclick="javascript:location.href='/login'" class="btn btn-border btn-sm btn-full  mt-3 text-uppercase bg-green-dark" style="margin:0 auto">            	
				로그인해주세요
			</button>
		</div>

	</div>  
	</c:if>
</div>   
<div class="mb-10"></div>

<!-- 하단바 -->
<jsp:include page="../common/footerBar.jsp" />
</body>

<!-- 모달-->
<jsp:include page="../common/pop/modal.jsp" />

<script type="text/javascript">

let existPrm = "<c:out value='${existPrm}'/>";

if (existPrm != null && existPrm == "N") {
	alert("존재하지않는 프로모션입니다.");
	location.href="/main";
}


let msId 		= "<c:out value='${sessionScope.msMember.msId}'/>";
let pmSerialNo 	= "<c:out value='${prm.pmSerialNo}'/>";
let pmBasicYn 	= "<c:out value='${prm.pmBasicYn}'/>";
let avlPrs 		= "<c:out value='${avlPrs}'/>";

let msNum		= "<c:out value='${sessionScope.msMember.msNum}'/>";
let msEmail 	= "<c:out value='${sessionScope.msMember.msEmail}'/>";
let msName 		= "<c:out value='${sessionScope.msMember.msName}'/>";
let coDiv 		= "<c:out value='${prm.coDiv}'/>";
let totAmount 	= "<c:out value='${prm.drAmount}'/>";			// 결제금액

let mainPrm		= "<c:out value='${mainPrm}'/>";
let pmName		= "<c:out value='${prm.pmName}'/>";

if (mainPrm == "") {
	console.log('메인프로모션');
} else {
	console.log('서브프로모션');
	let mainPmName = "<c:out value='${mainPrm.pmName}'/>";
	pmName = mainPmName + " [" + pmName + "]";
}
	
let reservationInfo 			= {};
reservationInfo.coDiv 			= coDiv;
reservationInfo.pmSerialNo 		= pmSerialNo; 	// 프로모션번호
reservationInfo.pmName 			= pmName; 		// 프로모션명


$(document).ready(function() {

	init();	
	
	// 로그인 체크 
	if (msId == null || msId == '') {
		$('#btnOpen').css('display', 'none');		// 일반 프로모션 [신청하기] 버튼
		$('#subPromotion').css('display', 'none');	// 서브 프로모션 이미지 영역 
		$('#btnLogin').css('display', '');
	} else {
		// 신청가능인원 0명일때 
		if (avlPrs <= 0) {
			$('#btnOpen').css('display', 'none');
			$('#btnClose').css('display', '');
		}
	}
	// end.
});

function init() {
	// 프로모션 내용 줄바꿈 처리
	var pmContent = $('#pmContent').text();
	
	if(pmContent.indexOf("\n") != -1){
		$("#pmContent").html(pmContent.replaceAll("\n", "<br/>"));
	}
	
}

/* 신청하기 버튼 클릭 */
function doApply() {
	
	// 로그인 한번 더 체크 
	$.ajax({
		url: "/member/sessionChk"
		, type: "post"
		, dataType: 'json'
		, contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
		, success: function(data) {
			if (!data) {
				// 로그인 페이지로 이동 
				location.href="/login";
			} else {
				fnPrmMarking('Y');
			}
		}
	});			
	// end.	
}

/* 신청하기 버튼 클릭 (기본폼 사용하지 않는 경우 바로 결제창 표출) */
function doPay() {	
	// 로그인 한번 더 체크 
	$.ajax({
		url: "/member/sessionChk"
		, type: "post"
		, dataType: 'json'
		, contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
		, success: function(data) {
			if (!data) {
				// 로그인 페이지로 이동 
				location.href="/login";
			} else {
				fnPrmMarking('N');
			}
		}
	});			
	// end.	
}

function fnPrmMarking() {	
	// 예약선점가능여부 체크 , 선점가능하다면 선점처리 , 선점불가하면 메세지 표출 후 새로고침     
	$.ajax({
		url: "/promotion/prmMarking"
		, type: "post"
		, dataType: 'json'
		, data: {'pmSerialNo' : pmSerialNo}
		, contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
		, success: function(data) {
			
			if (data.code == '0000') {
				if (pmBasicYn == 'Y') {
					// 신청 페이지로 이동 
					location.href="/promotion/apply/"+pmSerialNo;
				} else {
					// 바로 결제 
					const checkbox = document.getElementById('chkAgree');
					const isChk = checkbox.checked;
					
					if (isChk == false) {
						alertModal.fail('결제규정 약관에 동의해주세요.');
						return;
					}
	
					reservationInfo.markSeq	= data.data;	// 선점 고유번호 
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
			} else if (data.code == '9999') {
				alertModal.fail(data.message);
				setTimeout(function() { location.reload() }, 800);
			}
		}, error: function(result, status, error){
			//
		}
	});	
}
</script>
</html>