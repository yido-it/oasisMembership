<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.yido.clubd.common.utils.Globals" %>
<jsp:include page="../common/head.jsp" />
<jsp:include page="../common/script.jsp" />
    
<body class="theme-light">
    
	<div id="preloader"><div class="spinner-border color-highlight" role="status"></div></div>

	<div id="page">
    
	    <div class="header header-fixed header-logo-app">
	        <a href="javascript:history.back()" class="header-title header-subtitle">정보수정</a>
	        <jsp:include page="../common/top.jsp" />
	    </div>    
		<jsp:include page="../common/menu.jsp" />
    
    	<div class="page-content header-clear">
        	<div class="divider divider-margins"></div>
	        <div class="menu-title">
	            <h1 class="my-0 py-0" style="display:inline"></h1>
	            <button type="button" class="font-12 mr-3 fr btn btn-sm color-red-dark border-red-dark" id="btnDelete">
	                회원탈퇴</button>
	        </div>
             
        <div class="content">
        <form id="frmMember" name="frmMember">            
            <div style="">    
                <div class="input-style input-light input-style-1 has-icon input-required app">
                    <i class="input-icon fa fa-address-card ml-3"></i>
                    <span class="color-highlight">아이디</span>
                    <input class="form-control" type="" value="${sessionScope.msMember.msId}" disabled>
                    <input class="form-control pl-2" type="hidden" id="msId" name="msId" value="${sessionScope.msMember.msId}">
                </div> 
                <div class="input-style input-light input-style-1 has-icon input-required">
                    <i class="input-icon fa fa-user ml-3"></i>
                    <span class="color-highlight">이름</span>                   
                    <input class="form-control" type="" value="${sessionScope.msMember.msName}" disabled>
                    <input class="form-control" type="hidden" id="msName" name="msName" value="${sessionScope.msMember.msName}">
                </div> 
                <div class="input-style input-light input-style-1 has-icon input-required app">
                    <i class="input-icon fa fa-lock ml-3"></i>
                    <span class="color-highlight">현재비밀번호</span>
                    <input class="form-control" type="password" id="msPassword" name="msPassword" data-name="비밀번호" placeholder="현재비밀번호" >
                </div> 
                <div class="input-style input-light input-style-1 has-icon input-required app">
                    <i class="input-icon fa fa-lock ml-3"></i>
                    <span class="color-highlight">변경할 비밀번호</span>
                    <input class="form-control" type="password" id="newMsPassword" name="newMsPassword" data-name="변경할 비밀번호" placeholder="변경할 비밀번호">
                    <p class="text-right font-12 color-red-light mb-1" id="pwdMsg1"></p>
                </div> 
                <div class="input-style input-light input-style-1 has-icon input-required app">
                    <i class="input-icon fa fa-lock ml-3"></i>
                    <span class="color-highlight">비밀번호 확인</span>
                    <input class="form-control" type="password" id="msPasswordChk" name="msPasswordChk" data-name="비밀번호 확인" placeholder="비밀번호 확인">
                    <p class="text-right font-12 color-red-light mb-1" id="pwdMsg2"></p>
                </div> 
                <div class="input-style input-light input-style-1 has-icon input-required">
                    <i class="input-icon fa-solid fa-mobile-screen-button ml-3"></i>     
                    <span class="color-highlight">휴대폰번호</span>
                    <em style="top:4px"><button type="button" class="btn btn-xs font-12 mt-1 bg-green-dark border-green-dark btn-primary" id="sendCode">인증요청</button></em>
                    <input class="form-control" type="" id="msPhone" name="msPhone" data-name="휴대폰번호" placeholder="휴대폰번호">
                </div> 
                <div class="input-style input-light input-style-1 has-icon input-required">
                    <i class="input-icon fa fa-key ml-3"></i>
                    <span class="color-highlight">인증번호입력</span>
                    <em style="top:4px"><button type="button" class="btn btn-xs bg-green-dark mt-1 border-green-dark font-12 btn-primary" id="verifyChk">인증확인</button></em>
                    <input class="form-control" type="" id="verifyCode" name="verifyCode" data-name="인증번호입력" placeholder="인증번호입력">
                </div>
                <input type="hidden" id="hiddenCode" name="hiddenCode"/>
                <input type="checkbox" id="chkSmsYn"/> SMS 수신에 동의합니다
                <input type="hidden" id="smsChk1" name="smsChk1"/>
                <input type="hidden" id="msNum" name="msNum" value="${sessionScope.msMember.msNum}"/>  
                <input type="hidden" id="msLoginCd" name="msLoginCd" value="${sessionScope.msMember.msLoginCd}"/>
                <input type="hidden" id="msBirth" name="msBirth" value="${sessionScope.msMember.msBirth}"/>
            </div>

            <h4 class="font-700 mt-5 mb-3">개인정보</h4> 
            
            <div class="">                
            	<span class="">생년월일</span> 
             	<div class="row mb-1 mt-1">
		            <div class="col-4 mb-1">
		                <div class="input-style input-style-2  input-required">
		                    <span class="color-highlight">년</span>
		                 <em><i class="fa fa-angle-down"></i></em>
				          <select class="form-control" id="msBirth1"></select>
		                </div> 
		            </div>
	                <div class="col-4 mb-1">
	                    <div class="input-style input-style-2  input-required">
	                        <span class="color-highlight">월</span>
	                         <em><i class="fa fa-angle-down"></i></em>
	                   	<select class="form-control" id="msBirth2"></select>
	                    </div> 
	                </div>
	               <div class="col-4 mb-1">
	                    <div class="input-style input-style-2  input-required">
	                        <span class="color-highlight">일</span>
	                         <em><i class="fa fa-angle-down"></i></em>
	                       	<select class="form-control" id="msBirth3"></select>
	                    </div> 
	                </div>
	              </div>
	                
	                
                <div class="row mb-1 mt-3">
		            <div class="col-6 mb-1">
		                <div class="input-style input-style-2  input-required">
		                    <span class="color-highlight">지역(시/도)</span>
		                    <input class="form-control" type="hidden" id="msArea1Val" value="${sessionScope.msMember.msArea1}" >
		                    <em><i class="fa fa-angle-down"></i></em>
		                    <select id="msArea1" name="msArea1">
		                        <option value="" selected disabled>선택하세요</option>
		                        <c:forEach items="${msArea1List}" var="item" varStatus="status">
		                        <option value="${item.cdCode}">${item.cdTitle1}</option>
				                </c:forEach>
				                <option value="">선택안함</option>
		                    </select>
		                </div> 
		            </div>
	                <div class="col-6 mb-1">
	                    <div class="input-style input-style-2  input-required">
	                        <span class="color-highlight">시/군/구</span>
	                        <input class="form-control" type="hidden" id="msArea2Val" value="${sessionScope.msMember.msArea2}" >
	                        <em><i class="fa fa-angle-down"></i></em>
	                        <select id="msArea2" name="msArea2">
	                            <option value="" selected disabled>선택하세요</option>
	                        </select>
	                    </div> 
	                </div>
	                
					<div class="col-12 mb-0">               
						<!--차량번호1-->
				        <div class="row mb-0 mt-1" id="carArea1">
				            <div class="col-12 mb-1">
				                <div class="input-style input-style-2 input-required">
				                    <span class="color-highlight input-style-1-active">차량번호(최대3대)</span>
				                    <p class="font-13 color-green-dark mb-0" style="position: absolute; right: 10px;top:12px;height:30px;z-index:1;" id="btnAddCar">
				                     <i class="fa-solid fa-plus font-12"></i> 차량추가</p>
				                    <input class="form-control" type="" id="msCarNo1" name="msCarNo1" value="${carList[0].msCarNo}" maxLength="8">
				                </div> 
				            </div>
				         </div>
						<!--차량추가2-->
				        <div class="row mb-0 mt-0" id="carArea2" style="display:none;">
				            <div class="col-12 mb-1">
				                <div class="input-style input-style-2 input-required">
				                    <p class="font-13 color-red-dark mb-0" style="position: absolute; right: 10px;top:12px;height:30px;z-index:1;" id="btnDelCar2"> 
				                    <i class="fa-solid fa-x  font-12"></i> 차량삭제</p>
				                    <input class="form-control" type="" id="msCarNo2" name="msCarNo2" value="${carList[1].msCarNo}" maxLength="8">
				                </div> 
				            </div>
				        </div>
						<!--차량추가3-->
						<div class="row mb-0 mt-0" id="carArea3" style="display:none;">
						    <div class="col-12 mb-1">
						        <div class="input-style input-style-2 input-required">
						            <p class="font-13 color-red-dark mb-0" style="position: absolute; right: 10px;top:12px;height:30px;z-index:1;" id="btnDelCar3"> 
						            <i class="fa-solid fa-x  font-12"></i> 차량삭제</p>
						            <input class="form-control" type="" id="msCarNo3" name="msCarNo3" value="${carList[2].msCarNo}" maxLength="8">
						        </div> 
						    </div>
						</div>
					</div>
	            </div>  
	            
				<div class="input-style input-style-2 input-required">
                    <span class="color-highlight">선호 업장</span>
                    <input class="form-control" type="hidden" id="coDivVal" value="${msFirstPick}">
                    <em><i class="fa fa-angle-down"></i></em>
                    <select id="coDiv" name="coDiv" >
                        <option value="" selected disabled>선호하는 업장</option>
                        <c:forEach items="${placeList}" var="item" varStatus="status">
                        <option value="${item.coDiv}">${item.coName}</option>
                        </c:forEach>
                        <option value="">선택안함</option>
                    </select>
				</div>       
	                
	            <h4 class="font-700 mt-5 mb-3">레슨정보</h4> 
            	
				<!--레슨경험 --> 	
				<div class="">                
                	<p class="mb-0">레슨경험</p> 
					<div class="row mb-1 mt-1">
                	<input class="form-control" type="hidden" id="msLessonExpYnVal" value="${basicInfo.msLessonExpYn}" >
						<div class="col-6 mb-1">
							<div class="form-check icon-check">
								<input class="form-check-input" type="radio" name="msLessonExpYn" value="Y" id="msLessonExpY">
								<label class="form-check-label" for="msLessonExpY" >있음</label>
								<i class="icon-check-1 fa fa-circle color-gray-dark font-16"></i>
								<i class="icon-check-2 fa fa-check-circle font-16 color-highlight"></i>
							</div>
			            </div>
		                <div class="col-6 mb-1">
		                      <div class="form-check icon-check">
									<input class="form-check-input" type="radio" name="msLessonExpYn" value="N" id="msLessonExpN">
									<label class="form-check-label" for="msLessonExpN" >없음</label>
									<i class="icon-check-1 fa fa-circle color-gray-dark font-16"></i>
									<i class="icon-check-2 fa fa-check-circle font-16 color-highlight"></i>
							  </div>
		                </div>
					</div> 
				</div>	
            	
            	
				<!--레슨빈도 --> 	
				<div class="">                
					<p class="mb-0">레슨빈도</p> 
		            <div class="row mb-1 mt-1">
		            <input class="form-control" type="hidden" id="msLessonUnitVal" value="${basicInfo.msLessonUnit}">
						<c:forEach items="${unitList}" var="item" varStatus="status">
				            <div class="col-3 mb-1">
				               <div class="form-check icon-check">
									<input class="form-check-input" type="radio" name="msLessonUnit" value="${item.cdCode}" id="${'lu_'}${item.cdCode}">
									<label class="form-check-label" for="${'lu_'}${item.cdCode}">${item.cdTitle1}</label>
									<i class="icon-check-1 fa fa-circle color-gray-dark font-16"></i>
									<i class="icon-check-2 fa fa-check-circle font-16 color-highlight"></i>
								 </div>
				            </div>
				        </c:forEach>				          
						<div class="col-6 mb-1">
		                     <div class="mx-auto">
		                        <div class="stepper rounded-s float-left" style="border-color: rgba(255, 255, 255, 0.15) !important;top: -3px;position: relative;">
		                            <a href="#" class="stepper-sub"><i class="fa fa-minus color-theme"></i></a>
		                            <input type="number" max="99" placeholder="0" id="msLessonTrem" name="msLessonTrem" value="${basicInfo.msLessonTrem}" onKeyup="checkNumberInput(this, 2)">
		                            <a href="#" class="stepper-add"><i class="fa fa-plus color-green-dark"></i></a>
		                        </div>  
		                        <span class="ml-1" style=""> 회</span>
		                        <div class="clearfix"></div> 
						    </div>
						</div>
					</div> 
	            </div>
	              
				<!--라운드빈도 --> 	
				<div class="">                
                	<p class="mb-0">라운드빈도</p> 
		            <div class="row mb-1 mt-1">
		            <input class="form-control" type="hidden" id="msRoundUnitVal" value="${basicInfo.msRoundUnit}">
						<c:forEach items="${unitList}" var="item" varStatus="status">
							<div class="col-3 mb-1">
	          					<div class="form-check icon-check">
									<input class="form-check-input" type="radio" name="msRoundUnit" value="${item.cdCode}" id="${'ru_'}${item.cdCode}">
									<label class="form-check-label" for="${'ru_'}${item.cdCode}">${item.cdTitle1}</label>
									<i class="icon-check-1 fa fa-circle color-gray-dark font-16"></i>
									<i class="icon-check-2 fa fa-check-circle font-16 color-highlight"></i>
								</div>
							</div>
						</c:forEach>
						<div class="col-6 mb-1">
							<div class="mx-auto">
								<div class="stepper rounded-s float-left" style="border-color: rgba(255, 255, 255, 0.15) !important;top: -3px;position: relative;">
		                            <a href="#" class="stepper-sub"><i class="fa fa-minus color-theme"></i></a>
		                            <input type="number" max="99" placeholder="0" id="msRoundCnt" name="msRoundCnt" value="${basicInfo.msRoundCnt}" onKeyup="checkNumberInput(this, 2)">
		                            <a href="#" class="stepper-add"><i class="fa fa-plus color-green-dark"></i></a>
		                        </div>  
		                        <span class="ml-1" style=""> 회</span>
		                        <div class="clearfix"></div> 
							</div>
			            </div>
			        </div> 
	             </div>
	             
	                         
				<!--선호시간 --> 	           
				<div class="row mb-0 mt-3">
					<div class="col-6">
						<p>레슨선호시간</p>
					</div>
					<div class="col-6 mb-1">
  						<div class="mx-auto">
      						<div class="stepper rounded-s float-left" style="border-color: rgba(255, 255, 255, 0.15) !important;top: -3px;position: relative;">
	    						<a href="#" class="stepper-sub-10"><i class="fa fa-minus color-theme"></i></a>
	    						<input type="number" max="999" placeholder="0" id="msLessonMinute" name="msLessonMinute" value="${basicInfo.msLessonMinute}" onKeyup="checkNumberInput(this, 3)">
	    						<a href="#" class="stepper-add-10"><i class="fa fa-plus color-green-dark"></i></a>
							</div>  
						<span class="ml-1" style=""> 분</span>
						<div class="clearfix"></div> 
						</div>
       				 </div>
				</div>
				
				<!--핸디캡 -->
				<div class="row mb-0 mt-3">
					<div class="col-6">
						<p>핸디캡</p>
					</div>
					<div class="col-6 mb-1">
   						<div class="mx-auto">
      						<div class="stepper rounded-s float-left" style="border-color: rgba(255, 255, 255, 0.15) !important;top: -3px;position: relative;">
	    						<a href="#" class="stepper-sub"><i class="fa fa-minus color-theme"></i></a>
	    						<input type="number" max="99" placeholder="0" id="msHandcap" name="msHandcap" value="${basicInfo.msHandcap}" onKeyup="checkNumberInput(this, 2)">
	    						<a href="#" class="stepper-add"><i class="fa fa-plus color-green-dark"></i></a>
							</div>  
						<span class="ml-1" style=""> 회</span>
						<div class="clearfix"></div> 
						</div>
        			</div>
				</div>
				
                <h4 class="font-700 mt-3 mb-3">직장정보</h4> 
        
                <div class="row mb-0"> 
                    <div class="col-6 mb-3">
                        <div class="input-style input-style-2  input-required">
                            <span class="color-highlight">직업</span>
                            <input class="form-control" type="hidden" id="msJobCdVal" value="${sessionScope.msMember.msJobCd}">
                            <em><i class="fa fa-angle-down"></i></em>
                            <select id="msJobCd" name="msJobCd" >                            
                                <option value="" selected disabled>선택</option>
                                <c:forEach items="${jobList}" var="item" varStatus="status">
                                <option value="${item.cdCode}">${item.cdTitle1}</option>
                                </c:forEach>
                                <option value="">선택안함</option>
                            </select>
                        </div> 
                    </div>
                    <div class="col-6 mb-3">
                        <div class="input-style input-style-2  input-required">
                            <span class="color-highlight input-style-1-active">직장명</span>
                            <input class="form-control" type="" placeholder="" id="msCompnm" name="msCompnm" value="${sessionScope.msMember.msCompnm}"  maxLength="30">
                        </div> 
                    </div>
                </div>
            
            </div>
        
        </form>
        <button type="button" class="col-12 mt-4 mb-4 btn btn-sm bg-green-dark btn-full text-uppercase" id="btnSave">수정완료</button>
        </div>
        
    </div>
    <!-- Page content ends here--> 
</div>
<div class="menu-hider"><div></div></div>
	<script>
		if(${sessionScope.msMember.msDivision} == "00") {
			location.href = "/pro/proForm";
		}
	
		var checkVerify = false; // 인증 완료 여부
		var pwdReg = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&*()+=\-_.~]).*$/;
		var frqReg = /^[월주]{1,1}[0-9]{1,3}([회]{1,1})?$/g;
		
		var msLoginCd = $('#msLoginCd').val();
		var msName = "${sessionScope.msMember.msName}";
		var msPhone = "${sessionScope.msMember.msFirstPhone1}" + "-" + "${sessionScope.msMember.msMidPhone1}" + "-" + "${sessionScope.msMember.msLastPhone1}";
		var smsChk1 = "${sessionScope.msMember.smsChk1}";
		$('#msPhone').val(msPhone);		
		$('#smsChk1').val(smsChk1);		
		
		var params;
		
		if(msLoginCd == 'APP') {	
			$('.app').show();
		} else {				
			$('.app').hide();
		}
		
		$().ready(function() {
			
			if($('#smsChk1').val() == 'Y') {
				$('#chkSmsYn').prop("checked", true);
			} else {
				$('#chkSmsYn').prop("checked", false);			
			}
			
			
			setRadioValue('msLessonExpYn');
			setRadioValue('msLessonUnit');
			setRadioValue('msRoundUnit');
		
			setSelectValue('msJobCd');
			setSelectValue('coDiv');
			
			setSelectValue('msArea1');
			if($('#msArea1').val() != '') {
				getArea2List();
			}
			
			showCarInput();
		})
		
		
		initMsBirth();		
			
		function initMsBirth() {	
			var now = new Date();
			var year = now.getFullYear();	
			var msBirth = $('#msBirth').val();
			
			for(var i = year - 20; i >= year - 80; i--) {
			    $('#msBirth1').append('<option value="' + i + '">' + i + '</option>');
			}
			$("#msBirth1").val(year - 30).prop('selected', true);
			
			for(var i = 1; i <= 12; i++) {
			    $('#msBirth2').append('<option value="' + i.toString().padStart(2, '0') + '">' + i + '</option>');
			} 
			
			if(msBirth != null && msBirth != '') {
				year = msBirth.split('-')[0];
				var month = msBirth.split('-')[1];
				var date = msBirth.split('-')[2];
				
				$("#msBirth1").parent().find('span').removeClass('input-style-1-inactive input-style-1-active');
				$("#msBirth1").val(year).prop('selected', true);
				$("#msBirth1").parent().find('span').addClass('input-style-1-inactive input-style-1-active');
				
				$("#msBirth2").parent().find('span').removeClass('input-style-1-inactive input-style-1-active');
				$("#msBirth2").val(month).prop('selected', true);
				$("#msBirth2").parent().find('span').addClass('input-style-1-inactive input-style-1-active');
				
				setDate();
				$("#msBirth3").parent().find('span').removeClass('input-style-1-inactive input-style-1-active');
				$("#msBirth3").val(date).prop('selected', true);		
				$("#msBirth3").parent().find('span').addClass('input-style-1-inactive input-style-1-active');
			}
		}
		
		function setDate() {
			$('#msBirth3').empty();
			var yearVal = $("#msBirth1").val();
			var monVal = $("#msBirth2").val();
			var maxDate = new Date(yearVal, monVal, 0).getDate();			
			for(var i = 1; i <= maxDate; i++) {				
			    $('#msBirth3').append('<option value="' + i.toString().padStart(2, '0') + '">' + i + '</option>');
			}
		}
		
		$("#msBirth1, #msBirth2").on('change', function() {
			setDate();
		});
		
		function showCarInput() {
			if($('#msCarNo2').val() != '' && $('#msCarNo2').val() != null) {
				$('#carArea2').show();
			}
			if($('#msCarNo3').val() != '' && $('#msCarNo3').val() != null) {
				$('#carArea3').show();
			}
		}
		
		$('#msArea1').on('change', function() {
			getArea2List();
		})
		
		function getArea2List() {
			if($('#msArea1').val() != null && $('#msArea1').val() != "") {				
				var params = {
					  coDiv : '001'
					, cdDivision : '221'	
					, cdCode : $('#msArea1').val()
				}		
				
				$.ajax({
			        url: "<c:out value='/common/getCommonCodeDetailList'/>"
			        , type: "post"
			        , dataType: 'json'
			        , data: params
			        , contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
			        , success: function(data) {
			            if(data.result){		          
			            	var list = data.detailList;
			            	$('.cd_detail_list').remove();
							for(var i = 0; i < list.length; i++) {
								var option = $("<option value='" + list[i].cdCode + "' class='cd_detail_list'>" + list[i].cdTitle1 + "</option>");
								$('#msArea2').append(option);
							}
							setSelectValue('msArea2');
			            } else {
			                alertModal.fail(data.message);                    
			            }                
			        }
			        , error: function(data) {
			        	 alertModal.fail('[error] 코드 호출 중 오류 발생했습니다.');
			        }
			    });
			} else {
				$('.cd_detail_list').remove();
			}
		}

		$('#btnAddCar').on('click', function() {
			if(!$('#carArea2').is(':visible')) {
				$('#carArea2').show();				
			} else {				
				$('#carArea3').show();
			}
		})
		
		$('#btnDelCar2').on('click', function() {			
			$('#carArea2').hide();
			$('#msCarNo2').val('');
		})
		
		$('#btnDelCar3').on('click', function() {
			$('#carArea3').hide();
			$('#msCarNo3').val('');		
		})
		
		$('#newMsPassword').on('keyup', function() {
			if(!$('#newMsPassword').val().match(pwdReg)) {
				$('#pwdMsg1').html('특수문자를 포함한 영어/숫자로 8자 이상 입력해주세요.');
			} else {
				$('#pwdMsg1').html('');
			}
		})
				
		$('#msPasswordChk').on('keyup', function() {
			if($('#newMsPassword').val() != $('#msPasswordChk').val()) {
				$('#pwdMsg2').html('비밀번호 확인이 일치하지 않습니다.');				
			} else {
				$('#pwdMsg2').html('');								
			}
		})		
		
		// 인증번호 전송
		$('#sendCode').on('click', function() {
			if (!chkInputVal ('msPhone')) return;
			
			var ran = Math.random();
			var verifyCode = (ran.toString()).substring(2,6);
			var verifyMsg = "[ClubD 청담] 본인확인 인증번호 ["+verifyCode+"]입니다."

			$.ajax({
		          url: "/member/verifybyCode"
		        , type: "post"
		        , dataType: 'json'
		        , data: {
		        	msPhone : $('#msPhone').val()
		        	, sendMsg : verifyMsg
		        	}
		        , contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
		        , success: function(data) {
		        	if(data.result){
						alertModal.fail('[TEST]' + verifyCode);
			        	$('#hiddenCode').val(verifyCode);
			        	alertModal.send(data.message);
		        	}else{
		        		$('#hiddenCode').val("");
		        		alertModal.fail(data.message);
		        	}
		        }
		        , error: function(data) {
		        	 alertModal.fail("[error] 오류가 발생했습니다.");
		        }
		    });
		})
		
		// 인증번호 확인
		$('#verifyChk').on('click', function () {
			if (!chkInputVal ('verifyCode')) return;
			if($('#verifyCode').val() != $('#hiddenCode').val()) {
				alertModal.fail('입력하신 인증번호가 일치하지 않습니다.');
				return;
			} else {
				alertModal.success('인증이 완료되었습니다');
				checkVerify = true;
				$('#verifyCode').prop('readonly', true);
			}
			
		})
		
		$('#msPhone').on('keyup', function() {
			var msPhone = $('#msPhone').val();
			$('#msPhone').val(msPhone.replace(/[^0-9]/g, '').replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`));
		})		
		
		$('#chkSmsYn').on('change', function () {
			if($('#chkSmsYn').is(':checked')) {
				$('#smsChk1').val('Y');
			} else {
				$('#smsChk1').val('N');
			}
		})
		
		// 수정완료 클릭
		$('#btnSave').on('click', function() {			
			var result = true;
			
			if(msLoginCd == 'APP') {
				if($('#newMsPassword').val() != "") {
					if(!chkInputVal('msPassword')) {
						result = false;
						return;
					}
					if(!$('#newMsPassword').val().match(pwdReg)) {
						alertModal.fail('올바른 비밀번호가 아닙니다.');
						result = false;
						return;
					}
					if($('#newMsPassword').val() != $('#msPasswordChk').val()) {
						alertModal.fail('비밀번호 확인이 일치하지 않습니다.');
						result = false;
						return;
					}
				}
			}			
			
			if (!result) return;
			
			if($('#msPhone').val() != msPhone) {
				if(!checkVerify) {
					alertModal.fail('본인인증이 완료되지 않았습니다.');
					result = false;
					return;
				}
			}			
			if (!result) return;
			if ($('input[name="msLessonUnit"]:checked').val() == undefined && ($('#msLessonTrem').val() != '' && $('#msLessonTrem').val() > 0)) {
				alertModal.fail('레슨빈도 단위를 입력해주세요.');
				return;
			}		
			if ($('input[name="msRoundUnit"]:checked').val() == undefined && ($('#msRoundCnt').val() != '' && $('#msRoundCnt').val() > 0)) {
				alertModal.fail('라운드빈도 단위를 입력해주세요.');
				return;
			}	
			if ($('input[name="msLessonUnit"]:checked').val() != undefined && ($('#msLessonTrem').val() == ''  || $('#msLessonTrem').val() < 1)) {
				alertModal.fail('레슨빈도 횟수를 입력해주세요.');
				return;
			}
			if ($('input[name="msRoundUnit"]:checked').val() != undefined && ($('#msRoundCnt').val() == '' || $('#msRoundCnt').val() < 1)) {
				alertModal.fail('라운드빈도 횟수를 입력해주세요.');
				return;
			}

			if($('#msBirth3').val() != '' && $('#msBirth3').val() != null){
				var msBirth = $('#msBirth1').val() + '-' + $('#msBirth2').val() + '-' + $('#msBirth3').val();
				$('#msBirth').val(msBirth);
			}

			// console.log($('#frmMember').serializeArray());
			saveMemberModify();
		})
		
		// 회원정보 수정 저장
		function saveMemberModify() {			
		    $.ajax({
		          url: "/member/saveMemberModify"
		        , type: "post"
		        , dataType: 'json'
		        , data: $('#frmMember').serialize()
		        , contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
		        , success: function(data) {		    	
		            if(data.result){
		            	alertModal.success('수정이 완료되었습니다.');
		            	goAfterModal();
		            } else {
		            	alertModal.fail(data.message);                    
		            }                
		        }
		        , error: function(data) {
		        	alertModal.fail('[error] 오류가 발생했습니다.');
		        }
		    });		
		}
		
		$('#btnDelete').on('click', function() {
			params =  $('#frmMember').serialize();
			alertModal.confirm1('정말로 클럽디 청담를 탈퇴하시겠습니까?', 'deleteMember(params)', '회원탈퇴')
		})
		
		function deleteMember(params) {			
		    $.ajax({
		          url: "/member/deleteMember"
		        , type: "post"
		        , dataType: 'json'
		        , data: params
		        , contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
		        , success: function(data) {		    	
		            if(data.result){
		            	alertModal.success('탈퇴가 완료되었습니다.');
		            	goAfterModal("/succ-logout");
		            } else {
		            	alertModal.fail(data.message);                    
		            }                
		        }
		        , error: function(data) {
		        	alertModal.fail('[error] 오류가 발생했습니다.');
		        }
		    });		
		}
		
	</script>	
</body>
</html>