<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.yido.clubd.common.utils.Globals"%>
<jsp:include page="../common/head.jsp" />
<jsp:include page="../common/script.jsp" />
<style type="text/css">
	#msId {
		-webkit-ime-mode: disabled !important;
		-moz-ime-mode: disabled !important;
		-ms-ime-mode: disabled !important;
		ime-mode: disabled !important;
	}
	#msName {
		-webkit-ime-mode: active !important;
		-moz-ime-mode: active !important;
		-ms-ime-mode: active !important;
		ime-mode: active !important;
	}
</style>
<body class="theme-light" style="background-color: #fff;">
	<div id="preloader"><div class="spinner-border color-highlight" role="status"></div></div>
    <div id="page">        
        <div class="header header-fixed header-logo-app header-transparent">
            <a href="#" class="header-title header-subtitle">회원가입</a>
            <jsp:include page="../common/top.jsp" />
        </div>
        <jsp:include page="../common/menu.jsp" />
            
        <div data-card-height="cover-card">
            <div class="card-center mt-4">              
	            <form id="frmMemberForm" name="frmMemberForm">
	                <div style="max-width: 300px;" class="mx-auto mb-n5">
	                   <h4 class="bold color-black">회원정보입력</h4>
	                    <div class="input-style input-light input-style-1 has-icon mt-3 input-required app">
	                        <i class="input-icon fa fa-address-card"></i>
	                        <span class="color-highlight">아이디</span>
	                        <em><button type="button" class="btn btn-xs font-12 bg-brown-dark border-brown-dark btn-primary" id="btnCheckExist">중복확인</button></em>
	                        <input class="form-control" type="email" id="msId" name="msId" placeholder="아이디" data-name="아이디" style="ime-mode:disabled;">
	                    </div> 
	                    <p class="text-right font-12 color-red-light mb-1" id="idMsg"></p>
	                    <div class="input-style input-light input-style-1 has-icon input-required app">
	                        <i class="input-icon fa fa-lock"></i>
	                        <span class="color-highlight">비밀번호</span>
	                        <em class="color-red-light">(필수)</em>
	                        <input class="form-control" type="password" id="msPassword" name="msPassword" placeholder="비밀번호" data-name="비밀번호">
	                    </div> 
	                    <p class="text-right font-12 color-red-light mb-1" id="pwdMsg1"></p>
	                    <div class="input-style input-light input-style-1 has-icon input-required app" >
	                        <i class="input-icon fa fa-lock"></i>
	                        <span class="color-highlight">비밀번호 확인</span>
	                        <em class="color-red-light">(필수)</em>
	                        <input class="form-control" type="password" id="msPasswordChk" name="msPasswordChk" placeholder="비밀번호 확인" data-name="비밀번호 확인">
	                    </div>
	                    <p class="text-right font-12 color-red-light mb-1" id="pwdMsg2"></p>
	                
	                    <div class="input-style input-light input-style-1 has-icon input-required all">
	                        <i class="input-icon fa fa-user"></i>
	                        <span class="color-highlight">이름</span>
	                        <em class="color-red-light">(필수)</em>
	                        <input class="form-control" type="text" id="msName" name="msName" placeholder="이름" data-name="이름">
	                    </div> 
	                
                        <div class="input-style input-light input-style-1 has-icon input-required all">
                            <i class="input-icon fa-solid fa-mobile-screen-button"></i>     
                            <span class="color-highlight">휴대폰번호</span>
                            <em><button type="button" class="btn btn-xs font-12 bg-brown-dark border-brown-dark btn-primary" id="sendCode">인증요청</button></em>
                            <input class="form-control" type="" id="msPhone" name="msPhone" placeholder="휴대폰번호" data-name="휴대폰번호" inputmode="tel" pattern="[0-9]*">
                        </div> 
                        <div class="input-style input-light input-style-1 has-icon input-required all">
                            <i class="input-icon fa fa-key"></i>
                            <span class="color-highlight">인증번호입력</span>
                            <em><button type="button" class="btn btn-xs font-12 bg-brown-dark border-brown-dark btn-primary" id="verifyChk">인증확인</button></em>
                            <input class="form-control" type="" id="verifyCode" name="verifyCode" placeholder="인증번호 입력" data-name="인증번호" inputmode="numeric" pattern="[0-9]*">
                        </div> 
	
			            <div class="row mb-0 mt-3">
		                  	<div class="col-12">
		                  		<p>성별선택</p>
		                  	</div>
				            <div class="col"> 
				                <div class="form-check icon-check">
									<input class="form-check-input" type="radio" name="msSex" value="1" id="msSexM">
									<label class="form-check-label" for="msSexM">남</label>
									<i class="icon-check-1 fa fa-circle color-gray-dark font-16"></i>
									<i class="icon-check-2 fa fa-check-circle font-16"></i>
								</div>
					        </div>
				             <div class="col"> 
				               	<div class="form-check icon-check">
									<input class="form-check-input" type="radio" name="msSex" value="2" id="msSexF">
									<label class="form-check-label" for="msSexF">여</label>
									<i class="icon-check-1 fa fa-circle color-gray-dark font-16"></i>
									<i class="icon-check-2 fa fa-check-circle font-16"></i>
								</div>
				             </div>
				             <div class="col-5"> 
				               	<div class="form-check icon-check">
									<input class="form-check-input" type="radio" name="msSex" value="N" id="msSexN">
									<label class="form-check-label" for="msSexN">선택안함</label>
									<i class="icon-check-1 fa fa-circle color-gray-dark font-16"></i>
									<i class="icon-check-2 fa fa-check-circle font-16"></i>
								</div>
				             </div>
				         </div>
				                   
					     <!--       
					            <div class="d-flex mb-2"> 
				                    <div class="w-100">
				                        <div class="form-check icon-check">
				                            <input class="form-check-input" type="checkbox" value="" id="check3">
				                            <label class="form-check-label color-gray-dark" for="check3">오픈타석 이용권1(잔여10장)</label>
				                            <i class="icon-check-1 far fa-square color-gray-dark font-16"></i>
				                            <i class="icon-check-2 far fa-check-square font-16 color-highlight"></i>
				                        </div>
				                        
				                     
				                    </div>
				                    <div class="">
				                        <div class="stepper rounded-s switch-s mr-n2 mt-n2" >
				                            <a href="#" class="stepper-sub font-14"><i class="fa fa-minus color-theme opacity-40"></i></a>
				                            <input style="font-size:15px !important" type="number" min="1" max="99" value="1">
				                            <a href="#" class="stepper-add font-14"><i class="fa fa-plus color-theme opacity-40"></i></a>
				                        </div>
				                        <div class="clearfix"></div>
				                    </div>
				                </div> -->
				                
                         <input type="hidden" id="hiddenCode" name="hiddenCode"/>
                         <input type="checkbox" id="chkSmsYn"/> 
                         <label for="chkSmsYn" class="form-check-label mt-4">&nbsp;&nbsp;SMS 수신에 동의합니다 </label>
                       
                         <input type="hidden" id="smsChk1" name="smsChk1"/>
                         <input type="hidden" id="msEmail" name="msEmail"/>
                         <input type="hidden" id="msMktAgreeYn" name="msMktAgreeYn" value="${msMktAgreeYn}"/>
                         <input type="hidden" id="msLoginCd" name="msLoginCd" value="${msLoginCd}"/>
                     <button type="button" class="col-12 mt-3 mb-4 btn btn-sm bg-green-dark btn-full text-uppercase" id="btnSignUp">가입하기</button>
                 </div>
             </form> 
         </div>
     </div>        
        <!-- </div>  --><!-- page-content end-->
        
    </div> <!-- page end-->
    
    <!-- 추가 정보 입력 팝업 -->
	<div id="memberAddPop" class="menu menu-box-bottom rounded-0 modal_bay" data-menu-height="93%" data-menu-effect="menu-parallax" style="display: block; background: #fff;">
	</div>
	<!-- // 추가 정보 입력 팝업 -->
    
	<div class="menu-hider"><div></div></div>
	<script>
		var checkId = false; // 아이디 중복 여부
		var checkVerify = false; // 인증 완료 여부
		var idReg = /^([a-z]+[a-z0-9-_]{3,16})$/;
		var idRegNeg = /^([^a-z]+[^a-z0-9-_]{3,16})$/g;
		var pwdReg = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&*()+=\-_.~]).*$/;

		var msLoginCd = $('#msLoginCd').val();
		var msId = "<c:out value='${sessionScope.joinInfo.msId}'/>";
		var msName = "<c:out value='${sessionScope.joinInfo.msName}'/>";
		var msEmail = "<c:out value='${sessionScope.joinInfo.msEmail}'/>";
			
		if(msLoginCd == 'APP') {			
			$('#msId').val('');
			$('#msName').val('');			
			$('#msEmail').val('');	
			$('.app').show();
			$('#btnCheckExist').show();
		} else {
			if('${sessionScope.joinInfo}' == '' || '${sessionScope.joinInfo}' == undefined) {
				location.href="/main";
			}
			$('#msId').val(msId);
			$('#msName').val(msName);			
			$('#msEmail').val(msEmail);			
			$('.app').hide();
			$('#btnCheckExist').hide();
		}
		
		$('#chkSmsYn').on('change', function () {
			if($('#chkSmsYn').is(':checked')) {
				$('#smsChk1').val('Y');
			} else {
				$('#smsChk1').val('N');
			}
		})
		
		$('#btnCheckExist').on('click', function() {
			if (!chkInputVal ('msId')) return;
			if(!$('#msId').val().match(idReg)) {
				alertModal.fail('3~16자의 영문/숫자 조합으로 입력해주세요.');
				return;
			}
			$.ajax({
		          url: "<c:out value='/member/checkIdExist'/>"
		        , type: "post"
		        , dataType: 'json'
		        , data: {msId : $('#msId').val()}
		        , contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
		        , success: function(data) {    	
		            if(data.result == true){
		            	alertModal.success('사용 가능한 아이디입니다.');
		            	$('#msId').prop('readonly', true);
		            	checkId = true;
		            } else {
		            	alertModal.fail('이미 가입된 아이디입니다.');
		                checkId = false;
		            }                
		        }
		        , error: function(data) {
		        	alertModal.fail('[error] 오류가 발생했습니다.');
		        }
		    });
		})
		
		
		$('#msId').on('keyup', function() {
			var msIdVal = $('#msId').val();
			if(!msIdVal.match(idReg)) {
				$('#msId').val(msIdVal.replace(/^[^a-z0-9-_]/g, ''));
				$('#idMsg').html('3~16자의 영문/숫자 조합으로 입력해주세요.');
			} else {
				$('#idMsg').html('');
			}
		});
		
		$('#msPassword').on('keyup', function() {
			if(!$('#msPassword').val().match(pwdReg)) {
				$('#pwdMsg1').html('특수문자를 포함한 영어/숫자로 8자 이상 입력해주세요.');
			} else {
				$('#pwdMsg1').html('');
			}
		});
		
		$('#msPasswordChk').on('keyup', function() {
			if($('#msPassword').val() != $('#msPasswordChk').val()) {
				$('#pwdMsg2').html('비밀번호 확인이 일치하지 않습니다.');				
			} else {
				$('#pwdMsg2').html('');								
			}
		});
				
		$('#sendCode').on('click', function() {
			if (!chkInputVal ('msPhone')) return;
			checkVerify = false;
			
			var ran = Math.random();
			var verifyCode = (ran.toString()).substring(2,6);			
			var verifyMsg = "[ClubD 청담] 본인확인 인증번호 ["+verifyCode+"]입니다."	
			
			$('#hiddenCode').val(verifyCode);
			
			/////////////////////////////////////// 앱 심사용 (나중에 삭제)
			if($('#msPhone').val() == '010-2672-7866') {
				alertModal.send('인증번호를 전송했습니다.');
				return;
			}
			
			$.ajax({
		          url: "<c:out value='/member/verifybyCode'/>"
		        , type: "post"
		        , dataType: 'json'
		        , data: {
		        	  msPhone : $('#msPhone').val()
		        	, verifyCode : verifyCode
		        	, sendMsg : verifyMsg
		        	}
		        , contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
		        , success: function(data) {
		        	if(data.result){
			        	$('#hiddenCode').val(verifyCode);
		        		alertModal.send(data.message);
		        	}else{
		        		$('#hiddenCode').val("");
		        		alertModal.fail(data.message);
		        	}
		        }
		        , error: function(data) {
		        	alertModal.fail('[error] 오류가 발생했습니다.');
		        }
		    });
		})
		
		$('#verifyChk').on('click', function () {
			if (!chkInputVal ('verifyCode')) return;
			
			/////////////////////////////////////// 앱 심사용 (나중에 삭제)
			if($('#msPhone').val() == '010-2672-7866') {
				alertModal.success('인증이 완료되었습니다');
				checkVerify = true;
				return;
			}
			
			if($('#verifyCode').val() != $('#hiddenCode').val()) {
				alertModal.fail('입력하신 인증번호가 일치하지 않습니다.');
				return;
			} else {
				alertModal.success('인증이 완료되었습니다');
				checkVerify = true;
				$('#verifyCode').attr('readonly', true);
			}
			
		})
		
		$('#msPhone').on('keyup', function() {
			var msPhone = $('#msPhone').val();
			$('#msPhone').val(msPhone.replace(/[^0-9]/g, '').replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`));
		})
		
		$('#btnSignUp').on('click', function() {
			if(msLoginCd == 'APP') {
				if(!chkInputVal('msId')) return;
				if(!checkId) {
					alertModal.fail('아이디 중복확인을 해주세요.');
					return;
				}
				if(!$('#msPassword').val().match(pwdReg)) {
					alertModal.fail('올바른 비밀번호가 아닙니다.');
					return;
				}
				if(!chkInputVal('msPassword')) return;
				if($('#msPassword').val() != $('#msPasswordChk').val()) {
					alertModal.fail('비밀번호가 일치하지 않습니다.');
					return;
				}
			} 
			if(!chkInputVal('msName')) return;
			if(!checkVerify) {
				alertModal.fail('본인인증이 완료되지 않았습니다.');
				return;
			}
			if($('input[name="msSex"]:checked').val() == undefined) {
				alertModal.fail('성별을 선택해주세요.');
				return;
			}
			doSignUp();
		})
		
		function doSignUp() {
		    $.ajax({
		          url: "<c:out value='/member/doSignUp'/>"
		        , type: "post"
		        , dataType: 'json'
		        , data: $('#frmMemberForm').serialize()
		        , contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
		        , success: function(data) {		    	
		            if(data.result){
		    			$('#memberAddPop').load('/member/memberAddPop');
		    			$('#memberAddPop').addClass('menu-active');        	
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