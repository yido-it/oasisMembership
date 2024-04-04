<!-- 
기능 : 프로모션 신청내역 목록 
작성자 :bae
-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.yido.clubd.common.utils.Globals" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<jsp:include page="../common/head.jsp" />
<jsp:include page="../common/script.jsp" />
<style>
.collapse { border-bottom : none }
</style>
<body class="theme-light">
    
<div id="preloader"><div class="spinner-border color-highlight" role="status"></div></div>
    
<div id="page">
    
    <div class="header header-fixed header-logo-app">
        <a href="#" class="header-title header-subtitle">프로모션 신청내역</a>
		<jsp:include page="../common/top.jsp" />
    </div>
    
    <!-- 좌측GNB-->
	<jsp:include page="../common/menu.jsp" />
	<!-- //좌측GNB-->

    <div class="page-content header-clear-medium mb-5 pb-4">
        <div class="menu-title">        
        	<p class="font-12 text-center pb-3 line-height-s">프로모션 취소가 안되는 경우는 클럽디청담에 문의 부탁드립니다.<br>(TEL:02-6403-7717)</p>
        </div>

		<!-- ┌──────────────────────── 신청내역 ────────────────────────┐-->
		<div id="applyList"></div>
		<!-- └──────────────────────── 신청내역 ────────────────────────┘-->

		 <a href="#" onClick="doSearch('more')" class="btn btn-border btn-sm btn-full font-12 mb-5 mr-3 ml-3 text-uppercase border-gray-dark color-black" id="btnMore">
        	더보기 <i class="fa-solid fa-chevron-down"></i>
        </a>
        
	</div>  

	<!--  content ends -->   
</div>   
    
<!-- 내역조회 모달 -->
<div id="modal_day" class="menu menu-box-modal rounded-0"  style="background-color: #303030;z-index:99999;padding: 15px 0;"
	data-menu-height="auto" 
	data-menu-width="330"
	data-menu-effect="menu-parallax" style="padding:20px">
<!-- 	<h3 class="text-center mt-3 font-600">예약내역 기간조회</h3> -->
	<h3 class="ml-3 mt-4">신청일자 조회</h3>
	<div class="row mb-0 mr-1 ml-1 mt-2">
		<div class="col-6"> 
			<div class="form-check icon-check">
				<input class="form-check-input" type="radio" name="srchPeriod" value="1" id="srchPeriod1" onclick='search(this.value)' >
				<label class="form-check-label" for="srchPeriod1">최근 1개월</label>
				<i class="icon-check-1 fa fa-circle color-gray-dark font-16"></i>
				<i class="icon-check-2 fa fa-check-circle font-16 color-highlight"></i>
			</div>
			<div class="form-check icon-check">
				<input class="form-check-input" type="radio" name="srchPeriod" value="12" id="srchPeriod2" onclick='search(this.value)'>
				<label class="form-check-label" for="srchPeriod2">최근 1년</label>
				<i class="icon-check-1 fa fa-circle color-gray-dark font-16"></i>
				<i class="icon-check-2 fa fa-check-circle font-16 color-highlight"></i>
			</div> 
		</div>
		<div class="col-6"> 
			<div class="form-check icon-check">
				<input class="form-check-input" type="radio" name="srchPeriod" value="3" id="srchPeriod3" onclick='search(this.value)'>
				<label class="form-check-label" for="srchPeriod3">최근 3개월</label>
				<i class="icon-check-1 fa fa-circle color-gray-dark font-16"></i>
				<i class="icon-check-2 fa fa-check-circle font-16 color-highlight"></i>
			</div>
			
			<div class="form-check icon-check">
				<input class="form-check-input" type="radio" name="srchPeriod" value="0" id="srchPeriod4" onclick='search(this.value)'>
				<label class="form-check-label" for="srchPeriod4">직접설정</label>
				<i class="icon-check-1 fa fa-circle color-gray-dark font-16"></i>
				<i class="icon-check-2 fa fa-check-circle font-16 color-highlight"></i>
			</div>
		</div>
	</div>
	
	<!--기간달력선택 -->
	<div class="row mt-3 mb-0" style="padding:10px;position:relative;display:none" id="calendar">
		<div class="col-6" class=""> 
			<div class="input-style input-style-2">
				<span style="border-radius: 5px;" class="input-style-1-active input-style-1-inactive">시작일</span>
				<input type="text" name="strtDt" id="strtDt" readonly>
			</div>
		</div>
		<span style="position: absolute;left: 50%;top: 20px;">~</span>
		<div class="col-6"> 
			<div class="input-style input-style-2">
				<span style="border-radius: 5px;" class="input-style-1-active input-style-1-inactive">종료일</span>
				<input type="text" name="endDt" id="endDt" readonly>
			</div>
		</div>
	</div>
	<!--//기간달력선택-->
	
	<!-- 조회 버튼 -->
	<div class="col-12 mt-1">
		<a href="#" onClick="doSearch('search')" class="btn btn-full btn-md bg-blue-dark font-800 text-uppercase rounded-s">
			조회
		</a>
	</div>
</div>
<!--//내역조회 모달-->

<!-- 모달-->
<jsp:include page="../common/pop/modal.jsp" />

<!-- 하단바 -->
<jsp:include page="../common/footerBar.jsp" />

</body>

<script type="text/javascript">

var listSize		= 0;	
var msId 			= "<c:out value='${sessionScope.msMember.msId}'/>";
var coDiv 			= "<c:out value='${coDiv}'/>";
var cancelSerialNo 	= "";	// 취소할때 필요 (pm_serialno)
var cancelSeq		= ""	// 취소할때 필요한 seq	
var cancelAmt 		= "";	// 취소할때 필요한 금액

$(document).ready(function() {

	init();
	doSearch('search');

});

function init() {

    $('#strtDt, #endDt').datepicker({
        dateFormat: 'yy-mm-dd',
        prevText: '이전 달',
        nextText: '다음 달',
        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
        showMonthAfterYear: true,
        yearSuffix: '년'     	
    });
    
	$('#strtDt').val(searchDate('1'));		// 1달전 날짜
	$('#endDt').val(getToDay("-"));			// 오늘 날짜
}

// 날짜 검색 > 조회 개월 클릭했을때 실행되는 함수 
function search(value) {
	
	$('#calendar').css('display', '');
	
	switch(value) {
		case '1' :
			// 1개월전
			$('#strtDt').val(searchDate('1'));		// 1달전 날짜
			$('#endDt').val(getToDay("-"));			// 오늘 날짜
			break;
		case '3' : 
			// 3개월전
			$('#strtDt').val(searchDate('3'));		// 3달전 날짜
			$('#endDt').val(getToDay("-"));			// 오늘 날짜
			break;
		case '12': 
			// 1년전
			$('#strtDt').val(searchDate('12'));		// 3달전 날짜
			$('#endDt').val(getToDay("-"));			// 오늘 날짜
			break;
		case '0' :
			// 직접설정 
			$('#strtDt').val(getToDay("-"));			// 오늘 날짜
			$('#endDt').val(getToDay("-"));			// 오늘 날짜
			break;
	}
}


//프로모션 신청 취소 모달창 표출
function showModal(idx){
	
	// 취소
	var pPmAmt = Number($('#mnAmt_'+idx).val()).toLocaleString("ko-KR")+'원';
	
	$('#popPmName').text($('#pmName_'+idx).val()); 		// 프로모션
	$('#popPmAmt').text(pPmAmt);						// 결제금액 
	var eFromDt = $('#eventFromDay_'+idx).val();		// 행사 시작일
	var eEndDt = $('#eventEndDay_'+idx).val();			// 행사종료일 
	
	// 행사일 
	if (eFromDt == eEndDt) {
		$('#popPmDate').text(eFromDt);					
	} else {
		$('#popPmDate').text(eFromDt + '~' + eEndDt);		
	}
	
	cancelSerialNo  = $('#pmSerialNo_'+idx).val();		// 취소할때 필요한 serialno
	cancelSeq		= $('#pmSeq_'+idx).val();			// 취소할때 필요한 seq
	cancelAmt 		= $('#mnAmt_'+idx).val();			// 취소할때 필요한 금액
	
	$('#modal_prmCancle').addClass('menu-active');
	$('.menu-hider').addClass('menu-active');
	
}

// 프로모션 신청서확인 버튼 클릭
function showPrmTxt(idx){

	// 신청서 내용 줄바꿈처리
	var prmCnt = $("#prmCnt_"+idx).val();

	if(prmCnt.indexOf("\n") != -1){
		prmCnt = prmCnt.replaceAll("\n", "<br/>"); 
	}

	$("#collapse"+idx).html(prmCnt); 
	
	if (prmCnt == '') {
		$("#collapse"+idx).html('작성한 내용이 없습니다.'); 
	}
	
}

// 프로모션 신청취소 
function doCancel(idx){
	
	var reservationInfo 			= {};
	reservationInfo.pmSerialNo 		= cancelSerialNo;
	reservationInfo.listSeq 		= cancelSeq;
	reservationInfo.pmAmt 			= cancelAmt;
	reservationInfo.coDiv 			= coDiv;
	
	console.log('doCancel > reservationInfo:', reservationInfo);

   	$.ajax({
   		url:  "/promotion/cancel/"
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

// 검색 
// type > 더보기 : more , 조회 : search
function doSearch(type) {
	
	if (type == "search") {
		listSize = 0;
	}
	
	var srchPeriod = "";
	if (document.querySelector('input[name="srchPeriod"]:checked') != null) {
		srchPeriod = document.querySelector('input[name="srchPeriod"]:checked').value;
	}
	
	$.ajax({
        url: "/promotion/searchList/" + coDiv
        , type: "post"
       	, dataType: 'json'
      	, data: { 
           	"listSize" : listSize
           	, "strtDt" : $('#strtDt').val()
           	, "endDt" : $('#endDt').val()
           	, "srchPeriod" : srchPeriod
    	}
        , contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
        , success: function(data) {	
        	console.log('applyList:', data);
        	
			if (data != null && data.length > 0) {
				$('#applyList').css('display','');	// 리스트 표출 
				var divCnt = '';
				for (let i=0; i<data.length; i++) {
					
					let lastIdx 	= Number(listSize);
					let pmMainYn 	= data[i].PM_MAIN_YN;
					let pmRealYn 	= data[i].PM_REAL_YN;
					let pmFromDay 	= data[i].PM_EVENT_FROM_DAY;
					let pmEndDay 	= data[i].PM_EVENT_END_DAY;
					let eFromDt 	= getStringDt2(pmFromDay, '.');		// 행사시작일 (화면에 보여줄 용도)
					let eEndDt 		= getStringDt2(pmEndDay, '.');		// 행사종료일 (화면에 보여줄 용도)
					let pmName		= data[i].PM_NAME;
					let mnAmt 		= Number(data[i].MN_AMOUNT).toLocaleString("ko-KR")+'원';

					let now = new Date();
					let now2 = new Date();
					// 행사 시작일 날짜 변환
					let eFromDt2 = new Date(pmFromDay.substr(0,4), Number(pmFromDay.substr(4,2))-1, pmFromDay.substr(6));	
					// 취소가능일자 구하기 
					let cancelDt = new Date(eFromDt2.setDate(eFromDt2.getDate() - data[i].PM_CANCEL_LIMIT));	
					eCancelDt = getStringDt(cancelDt, '.');	// 취소가능일자 (화면에 보여줄 용도)
					
					if (pmMainYn == "N" && pmRealYn == "Y") {
						pmName = data[i].mainPmName + "<BR>" + pmName + ""; 
					}
					divCnt += '<input type="hidden" id="pmSerialNo_'+(lastIdx+i)+'" value="'+data[i].PM_SERIAL_NO+'">';
					divCnt += '<input type="hidden" id="pmSeq_'+(lastIdx+i)+'" value="'+data[i].LIST_SEQ+'">';
					divCnt += '<input type="hidden" id="pmName_'+(lastIdx+i)+'" value="'+data[i].PM_NAME+'">';
					divCnt += '<input type="hidden" id="mnAmt_'+(lastIdx+i)+'" value="'+data[i].MN_AMOUNT+'">';
					divCnt += '<input type="hidden" id="prmCnt_'+(lastIdx+i)+'" value="'+data[i].CUSTOMER_NOTICE+'">';
					divCnt += '<input type="hidden" id="eventFromDay_'+(lastIdx+i)+'" value="'+eFromDt.substr(2)+'">';
					divCnt += '<input type="hidden" id="eventEndDay_'+(lastIdx+i)+'" value="'+eFromDt.substr(2)+'">';
				
					divCnt += '<div class="card card-style shadow-sm" id=applyList_'+(lastIdx+i)+'>';
					divCnt += '<div class="content mb-3">';
					divCnt += '<div class="row mb-3 mt-2">';
					divCnt += '<h5 class="col-3 text-left font-15">프로모션</h5>';
					divCnt += '<h5 class="col-9 text-right font-14 opacity-60">'+pmName+'</h5>';
					divCnt += '<h5 class="col-3 text-left font-15">행사일자</h5>';
				
					if (pmFromDay == pmEndDay) {
						divCnt += '<h5 class="col-9 text-right font-14 opacity-60 ">'+eFromDt.substr(2)+'</h5>';
					} else {
						divCnt += '<h5 class="col-9 text-right font-14 opacity-60 ">'+eFromDt.substr(2)+'~'+eEndDt.substr(2) +'</h5>';
					}
					divCnt += '<h5 class="col-3 text-left font-15">결제금액</h5>';
					divCnt += '<h5 class="col-9 text-right font-14 opacity-60">'+mnAmt+'</h5>';
					
					// 취소가능일 (행사일로부터 PM_CANCEL_LIMIT일 전까지 가능)
					// now2 : 현재날짜  / eFromDt2 : 행사시작일 
					if ( data[i].DEL_YN == 'N' && now2 < eFromDt2 ) {
						divCnt += '<h5 class="col-3 text-left font-15">취소가능</h5>';
						divCnt += '<h5 class="col-9 text-right font-14 opacity-60">'+eCancelDt.substr(2)+' 까지 취소 가능</h5>';
					}
					// 신청서내용 있는 경우만 표출하도록 변경 - 배은화 (2023-07-31)
					if (data[i].CUSTOMER_NOTICE != "") {
						divCnt += '<h5 class="col-12 text-right font-14" onClick="showPrmTxt('+(lastIdx+i)+')" data-toggle="collapse" data-target="#collapse'+i+'">▶ 신청서내용(클릭)</h5>';
						divCnt += '<h5 class="col-12 text-right font-14" id="collapse'+(lastIdx+i)+'" ></h5>';
					}
					divCnt += '</div>';
					divCnt += '<div class="divider mb-3"></div>';

					// 취소 버튼
					if (data[i].DEL_YN == 'Y') {
						divCnt += '<span class="fr btn btn-xs font-12 text-uppercase color-gray-dark bg-gray-light">';								
						divCnt += '취소된내역';
						divCnt += '</span>';
					} else {
						if ( now2 < eFromDt2 ) {
							divCnt += '<a href="javascript:void(0);" onClick="showModal('+(lastIdx+i)+')" class="fr btn btn-border btn-sm rounded-0 text-uppercase font-900 border-red-dark color-red-dark bg-theme">';								
							divCnt += '취소';
							divCnt += '</a>';
						} else {
							divCnt += '<span class="fr btn btn-border btn-sm rounded-0 text-uppercase font-900 border-pink-dark color-pink-dark bg-theme">';
							divCnt += '취소불가';
							divCnt += '</span>';
						}
					}
					
					divCnt += '</div>';
					divCnt += '</div>';
				}
				
				if (listSize == 0) {
				 	document.querySelector("#applyList").innerHTML = divCnt;
				} else {
					var tmp = listSize - 1;
					var sTmp = String(tmp);
					$("#applyList_"+ sTmp).after(divCnt);
				}
				listSize += data.length;
				
				if (data.length < 5) {
					$('#btnMore').text("더이상 조회할 내역이 없습니다.");
					document.getElementById("btnMore").setAttribute("href", "#");
				}
			} else {
				if (type == "search") {
					// 조회 결과 없을때 
					$('#applyList').css('display','none');	// 리스트 숨기기 
					$('#btnMore').text("검색 결과가 없습니다.");	// 더보기 버튼 텍스트 변경
					$('#btnMore').attr('onclick','');		// 더보기 버튼 onclick 값 제거 
					$('#btnMore').attr('href','#');			// 더보기 버튼 a태그 값 변경
				} else {
					// 더보기 결과 없을때
					$('#btnMore').text("더이상 조회할 내역이 없습니다.");
					document.getElementById("btnMore").setAttribute("href", "#");
				}
			}

        }
	});
	
	if (type == "search") {
		// 조회 팝업 닫기 
		$('#modal_day').removeClass('menu-active');
		$('.menu-hider').removeClass('menu-active menu-active-clear');
		$('.header').css('transform','translate(0,0)');
		$('.page-content').css('transform','translate(0,0)');
		$('.menu-hider').css('transform','translate(0,0)');
	}
}
</script>
</html>