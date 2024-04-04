<!-- 
기능 : 예약내역
작성자 :bae
-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.yido.clubd.common.utils.Globals" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<c:set var="now" value="<%=new java.util.Date()%>" />
<c:set var="nowDt"><fmt:formatDate value="${now}" pattern="yyyyMMdd" /></c:set> 

<jsp:include page="../common/head.jsp" />
<jsp:include page="../common/script.jsp" />

<body class="theme-light">
    
	<div id="preloader"><div class="spinner-border color-highlight" role="status"></div></div>
    
	<div id="page">
    
	    <div class="header header-fixed header-logo-app">
	        <a href="#" class="header-title header-subtitle">예약내역</a>
			<jsp:include page="../common/top.jsp" />
	    </div>
    
	    <!-- 좌측GNB-->
		<jsp:include page="../common/menu.jsp" />
		<!-- //좌측GNB-->
	
	    <div class="page-content header-clear-medium pb-5 mb-3">
	        <div class="menu-title pb-5 mt-0 mr-3">
	            <div class="float-right">
	                <!-- <div class="form-check icon-check">
	                    <input class="form-check-input" type="checkbox" value="" id="check1" >
	                    <label class="form-check-label font-15 ml-n1" for="check1">지난예약 보기</label>
	                    <i class="icon-check-1 fa fa-square color-gray-dark font-16"></i>
	                    <i class="icon-check-2 fa fa-check-square font-16 color-highlight"></i>
	                </div> -->
	                <a href="" data-menu="modal_day" class="page-title-icon bg-orange-dark"><i class="fa-solid fa-calendar-days color-white"></i></a>
	            </div>
	        </div>
	
			<!-- ┌──────────────────────── 예약카드 ────────────────────────┐-->
			<div id="bookList"></div>
			<!-- └──────────────────────── 예약카드 ────────────────────────┘-->
	
			 <a href="#" onClick="doSearch('more')" class="btn btn-border btn-sm btn-full font-12 mb-5 mr-3 ml-3 text-uppercase border-gray-dark color-black" id="btnMore">
	        	더보기 <i class="fa-solid fa-chevron-down"></i>
	        </a>
	        
		</div>  
	
		<!--  content ends -->   
	</div>   
    
	<!-- 내역조회 모달 -->
	<div id="modal_day" class="menu menu-box-modal rounded-0" data-menu-height="auto" data-menu-width="330" data-menu-effect="menu-parallax" style="padding:20px">
		<h3 class="pl-2">예약내역 조회</h3>
		<div class="row">		
			<div class="col-6"> 
				<div class="form-check icon-check">
					<input class="form-check-input" type="radio" name="searchType" value="1" id="searchType1">
					<label class="form-check-label" for="searchType1">전체보기</label>
					<i class="icon-check-1 fa fa-circle color-gray-dark font-16"></i>
					<i class="icon-check-2 fa fa-check-circle font-16 color-highlight"></i>
				</div>	
				<div class="form-check icon-check">
					<input class="form-check-input" type="radio" name="searchType" value="2" id="searchType2" >
					<label class="form-check-label" for="searchType2">지난예약</label>
					<i class="icon-check-1 fa fa-circle color-gray-dark font-16"></i>
					<i class="icon-check-2 fa fa-check-circle font-16 color-highlight"></i>
				</div> 
			</div>
			<div class="col-6"> 
				<div class="form-check icon-check">
					<input class="form-check-input" type="radio" name="searchType" value="3" id="searchType3" checked>
					<label class="form-check-label" for="searchType3">예약내역</label>
					<i class="icon-check-1 fa fa-circle color-gray-dark font-16"></i>
					<i class="icon-check-2 fa fa-check-circle font-16 color-highlight"></i>
				</div>
			</div>
		</div>
		<div class="divider mb-4 mt-4"></div>
			
		<h3 class="pl-2">예약일자 조회</h3>
		<div class="row">
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
		<div class="col-12 pl-0 pr-0 mt-3">
			<a href="#" onClick="doSearch('search')" class="btn font-13 btn-full btn-s bg-green-dark text-uppercase">
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
var cancelSerialNo 	= "";		// 취소할때 필요한 serialno
var cancelAmt 		= "";		// 취소할때 필요한 금액

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


//예약 취소 모달창 표출
function showModal(idx){
	
	// 예약취소
	var pMnAmt = Number($('#mnAmt_'+idx).val()).toLocaleString("ko-KR")+'원';
	
	$('#popBayName').text($('#bayName_'+idx).val()); 	// 예약명
	$('#popBkDay').text($('#bkDay_'+idx).val());		// 방문날짜 
	$('#popBkTime').text($('#bkTime_'+idx).val());		// 이용시간 
	$('#popMnAmt').text(pMnAmt);						// 결제금액 
	
	if ( $('#vcCnt_'+idx).val() == 0 ) {
		$('#popVoucherTxt').css('display', 'none');
		$('#popVoucher').css('display', 'none');
	} else {

		$('#popVoucher').text($('#vcName_'+idx).val() + '(' + $('#vcCnt_'+idx).val() + '매 사용)');		// 이용권 
	}
	
	cancelSerialNo 	= $('#serialNo_'+idx).val();			// 취소할때 필요한 serialno
	cancelAmt 		= $('#mnAmt_'+idx).val();				// 취소할때 필요한 금액
	
	$('#modal_cancle').addClass('menu-active');
	$('.menu-hider').addClass('menu-active');
	
}

// 부분취소 페이지로 이동 
function goCancelPage(idx){
			
	location.href="/book/cancelBook/"+coDiv+"/"+$('#serialNo_'+idx).val();

}


// 예약취소 
function doCancel(idx){
	
	$('#btnBookCancel').attr('onclick', '');		// 중복클릭방지
	
	var reservationInfo 			= {};
	reservationInfo.calcSerialNo 	= cancelSerialNo;
	reservationInfo.coDiv 			= coDiv;
	
	var url = "";
	
    if (cancelAmt == 0) {
    	url = "/voucher/vCancel/";
    } else {	    
    	url = "/book/bookCancel/";
    }
    
   	$.ajax({
   		url: url
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
	
	var searchType = document.querySelector('input[name="searchType"]:checked').value;

	$.ajax({
        url: "/book/searchBookList/" + coDiv
        , type: "post"
       	, dataType: 'json'
      	, data: { 
           	"listSize" : listSize
           	, "strtDt" : $('#strtDt').val()
           	, "endDt" : $('#endDt').val()
           	, "searchType" : searchType
           	, "srchPeriod" : srchPeriod
    	}
        , contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
        , success: function(data) {	
        	
			if (data != null && data.length > 0) {
				$('#bookList').css('display','');	// 리스트 표출 
				var divCnt = '';
				for (let i=0; i<data.length; i++) {
					
					let vcName 	= data[i].VC_NAME;
					let vcCnt 	= data[i].VC_CNT;
					let bayName = data[i].BAY_NAME;
					let bkTime 	= data[i].BK_TIME;
					let mnAmt	= data[i].MN_AMOUNT;
					
					var lastIdx = Number(listSize);
					var bkDay = getStringDt2(data[i].BK_DAY, '-');
					var mnAmtTxt = Number(data[i].MN_AMOUNT).toLocaleString("ko-KR")+'원';
					
					divCnt += '<input type="hidden" id="serialNo_'+(lastIdx+i)+'" value="'+data[i].CALC_SERIAL_NO+'">';
					divCnt += '<input type="hidden" id="bayName_'+(lastIdx+i)+'" value="'+bayName+'">';
					divCnt += '<input type="hidden" id="bkDay_'+(lastIdx+i)+'" value="'+bkDay+'">';
					divCnt += '<input type="hidden" id="bkTime_'+(lastIdx+i)+'" value="'+bkTime+'">';
					divCnt += '<input type="hidden" id="vcName_'+(lastIdx+i)+'" value="'+vcName+'">';
					divCnt += '<input type="hidden" id="vcCnt_'+(lastIdx+i)+'" value="'+vcCnt+'">';
					divCnt += '<input type="hidden" id="mnAmt_'+(lastIdx+i)+'" value="'+mnAmt+'">';
					
					divCnt += '<div class="card card-style shadow-sm" id=bookList_'+(lastIdx+i)+'>';
					divCnt += '<div class="content mb-3">';
					divCnt += '<div class="d-flex mb-3" style="width:100%">';
					divCnt += '<div>';
					divCnt += '<img src="/images/gallery/'+data[i].BAY_CD+'.jpg?v=1" height="80" class="rounded-s shadow-xl">';
					divCnt += '</div>';
					divCnt += '<div class="pl-3" style="width:80%">';
					divCnt += '<h4 class="bold mt-1">'+data[i].CO_NAME+'</h4>';
					divCnt += '<p>'+bayName+'</p>';
					divCnt += '</div>';
					divCnt += '</div>';
					divCnt += '<div class="row mb-3 mt-3">';
					divCnt += '<h5 class="col-4 text-left font-15">방문날짜</h5>';
					divCnt += '<h5 class="col-8 text-right font-14 opacity-60">'+bkDay+'</h5>';
					divCnt += '<h5 class="col-4 text-left font-15">이용시간</h5>';
					divCnt += '<h5 class="col-8 text-right font-14 opacity-60">'+bkTime+'</h5>';
					divCnt += '<h5 class="col-4 text-left font-15">결제금액</h5>';
					divCnt += '<h5 class="col-8 text-right font-14 opacity-60 ">'+mnAmtTxt+'</h5>';
					
					if (vcCnt > 0) {
						divCnt += '<h5 class="col-4 text-left font-15">이용권</h5>';
						divCnt += '<h5 class="col-8 text-right font-14 opacity-60 ">';
						if (data[i].VC_MULTI_CNT > 1) {
							divCnt += vcName+' 외 '+ (data[i].VC_MULTI_CNT-1) +'건 ('+vcCnt+'매)';
						} else {
							divCnt += vcName+'('+vcCnt+'매)';
						}
						divCnt += '</h5>';
					}
				
					divCnt += '</div>';					
					 
					switch (data[i].BK_STATE) {
						case '1' : 
							if ( ${nowDt} == data[i].BK_DAY ) {
								// 당일취소불가
								divCnt += '<div class="divider mb-3"></div>';
								divCnt += '<span class="fr btn btn-xs font-12 text-uppercase color-gray-dark bg-gray-light">';
								divCnt += '당일취소불가';
								divCnt += '</span>';
							} else if ( ${nowDt} > data[i].BK_DAY ) {
								// 취소불가
								divCnt += '<div class="divider mb-3"></div>';
								divCnt += '<span class="fr btn btn-xs font-12 text-uppercase color-gray-dark bg-gray-light">';
								divCnt += '취소불가';
								divCnt += '</span>';
							} else {
								// 예약취소
								divCnt += '<div class="divider mb-3"></div>';

								if (mnAmt == 0) {
									divCnt += '<a href="javascript:void(0);" onClick="goCancelPage('+(lastIdx+i)+')" style="margin-left:5px" class="fr btn btn-xs font-12 text-uppercase bg-orange-dark">';								
									divCnt += '부분취소';
									divCnt += '</a> &nbsp;';
								}
								divCnt += '<a href="javascript:void(0);" onClick="showModal('+(lastIdx+i)+')" class="fr btn btn-xs font-12 text-uppercase bg-orange-light">';								
								divCnt += '전체취소';
								divCnt += '</a>';
							}
							break;
						case '3' :	
							divCnt += '<span class="fr btn btn-xs font-12 text-uppercase color-gray-dark bg-gray-light">';
							divCnt += data[i].BK_STATE_NAME+' 된 예약';
							divCnt += '</span>';
							break;
					}
					divCnt += '</div>';
					divCnt += '</div>';
				}
				
				
				if (listSize == 0) {
				 	document.querySelector("#bookList").innerHTML = divCnt;
				} else {
					var tmp = listSize - 1;
					var sTmp = String(tmp);
					$("#bookList_"+ sTmp).after(divCnt);
				}
				listSize += data.length;
				
				if (data.length < 5) {
					$('#btnMore').text("더이상 조회할 내역이 없습니다.");
					document.getElementById("btnMore").setAttribute("href", "#");
				} else {  	
					$('#btnMore').html("더보기 <i class='fa-solid fa-chevron-down'></i>");
					$('#btnMore').attr("onclick", "doSearch('more')");
				}
			} else {
				if (type == "search") {
					// 조회 결과 없을때 
					$('#bookList').css('display','none');	// 리스트 숨기기 
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