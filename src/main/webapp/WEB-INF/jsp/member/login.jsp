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
	        <a href="javascript:history.back()" class="header-title header-subtitle">로그인</a>
	        <a href="#" data-back-button class="header-icon header-icon-1" id="topGoBack"><i class="fa fa-arrow-left"></i></a>
	        <a href="#" data-menu="menu-main" class="header-icon header-icon-2 mt-1"><i class="fas fa-bars"></i></a>
	    </div>
	   	<jsp:include page="../common/menu.jsp" />
	
	    <div class="page-content">            
	
	        <div data-card-height="cover-card">
	            <div class="card-center">
	                <div class="text-center mb-3">
	                	<img src="../images/logo_brown.png" style="width: 150px;">
	                </div>
	                <div style="max-width:300px;" class="mx-auto">
	                    <div class="input-style input-light input-style-1 has-icon">
	                        <i class="input-icon fa fa-user"></i>
	                        <input class="form-control" type="" id="msId" name="msId" placeholder="아이디">
	                    </div> 
	                    <div class="input-style input-light input-style-1 has-icon">
	                        <i class="input-icon fa fa-lock"></i>
	                        <input class="form-control" type="password" id="msPassword" name="msPassword" placeholder="비밀번호" onkeyup="checkCapsLock(event)">
	                    </div> 
	                    <p class="font-12 color-red-light mb-1" id="pwdMsg"></p>
	                    <div class="form-check icon-check mt-4 mb-4">
	                        <input class="form-check-input" type="checkbox" value="" id="chkSaveLogin" name="chkSaveLogin">
	                        <label class="form-check-label" for="chkSaveLogin">로그인유지</label>
	                        <i class="icon-check-1 fa fa-square color-gray-dark font-16 ml-n1"></i>
	                        <i class="icon-check-2 fa fa-check-square font-16 color-highlight ml-n1"></i>
	                    </div>
	                
	                    <a href="#" class="btn btn-sm bg-green-dark btn-full text-uppercase" id="btnLogin">로그인</a>
	                    
	                    <div class="row pt-3 mb-3">
	                        <div class="col-6 text-start">
	                        <a href="javascript:location.href='/member/agree?msLoginCd=APP'" class="color-green-dark">회원가입</a>
	                        </div>
	                        <div class="col-6 text-right">
	                         <a href="javascript:location.href='/member/memberFind'" class="color-green-dark">아이디 · 비밀번호찾기</a>
	                        </div>
	                    </div>
	
	                   <!-- <p class="mb-1 opacity-80" style="border-top: 1px solid #3a3a3a;padding-top: 10px;">SNS간편로그인</p>
	                   <div class="row mb-0"> 
	                     <div class="col-6" id="naver_id_login"></div>
	                       <div class="col-6">
	                            <a href="#" class="letter1 font-14 btn  btn-md btn-full font-800 text-uppercase rounded-sm=" id="kakao_id_login" style="background-color:#f9e748  !important;color:#333">
	                              <img src="/images/icons/icon_kakao2.png" style="width:20px">
	                       	      카카오톡</a>
	                       </div>
	                   </div> -->
	                 </div>
	            </div>
	        </div>
	
	    </div><!-- Page-content ends-->
	</div> <!-- Page ends-->  
<div class="menu-hider"><div></div></div>
<script type="text/javascript">

	if('${sessionScope.msMember.msNum}' != '' && '${sessionScope.msMember.msNum}' != null) {
		location.href="<c:url value='/main?login=y'/>";
	}

	var kakao_key = "${Globals.KakaoKey}";
	var kakao_client_id = "${Globals.KakaoClientId}";
	var kakao_redirect_url = "${Globals.KakaoRedirectUrl}";
	
	var naver_domain = "${Globals.NaverDomain}";
	var naver_key = "${Globals.NaverKey}"; 
	var naver_callback = "${Globals.NaverCallbackUrl}";
    var naver_id_login = new naver_id_login(naver_key, naver_callback);
    
    var userInfo;
    
	$(document).ready(function(){
		
 		/* kakaoInit();
		naverInit(); */
	});
	

	// 카카오 로그인 버튼 클릭
	$('#kakao_id_login').on('click', function () {
		// REST api 방법
		/* location.href = "https://kauth.kakao.com/oauth/authorize?response_type=code"
					  + "&client_id=" + kakao_client_id
					  + "&redirect_uri=" + kakao_redirect_url; */
		
		// Javascript api 방법
		window.Kakao.Auth.login({
		    success: function(authObj) {
		    	window.Kakao.Auth.setAccessToken(authObj.access_token);
		    	window.Kakao.API.request({
		            url: '/v2/user/me',
		            success: function(res) {
		            	var obj =  {
	            			  msId : res.id
	        				, msName : res.properties.nickname	
		            	}
		            	succLoginWithKakao(obj);
			        },
			        fail: function(error) {
			          alert(JSON.stringify(error));
			        }
		      });
		    },
		    fail: function(err) {
		      alert('카카오 로그인에 실패했습니다. 관리자에게 문의하세요.' + JSON.stringify(err));
		    }
		  });
	})	
	
	function succLoginWithKakao(obj) {
		obj['msLoginCd'] = "KAKAO";
		$.ajax({
			  url: "<c:url value='/member/doLoginForSocial'/>"
			, type: "post"
			, dataType: 'json'
			, data: obj
			, contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
			, success: function(data) {
				if(data.result) {							
          		// 페이지 이동
          		if(data.dest != null && data.dest != "") {	  
      				location.href = data.dest;
      			} else {	            			
						location.href = "<c:url value='/main'/>";
          		}        		
				} else {
					alertModal.fail(data.message);
				}
			}
			, error: function(data) {
				alertModal.fail('[error] 오류가 발생했습니다.');
			}
		});
	}

	$('#btnLogin').on('click', function () {	
		var msId = $("#msId").val();
		var msPassword = $("#msPassword").val();
		var saveLogin = $('input:checkbox[id="chkSaveLogin"]').is(":checked") ? "Y" : "N";

		if(msId == "") {
			alertModal.fail('아이디를 입력해주세요.');
			return;
		}
		if(msPassword == "") {
			alertModal.fail('비밀번호를 입력해주세요.');
			return;
		}		
		var sParams = {
				  msId : msId
				, msPassword : msPassword
				, loginAuto : saveLogin
				, ua : getUserAgent()
		};
		checkDormantYn(sParams);	
			
	})
	
	$('#msPassword').on('keyup', function(e){
		if(e.keyCode == 13) $('#btnLogin').trigger('click');
	});
	
	function checkCapsLock(event) {
		if(event.getModifierState('CapsLock')) {			
			document.getElementById('pwdMsg').innerText = "Caps Lock이 켜져 있습니다.";
		} else {
			document.getElementById('pwdMsg').innerText = "";			
		}
	}
	
	function kakaoInit() {
	  	// 카카오 로그인 javascript키 초기화 
		Kakao.init(kakao_key);
	}
		
	function naverInit() {
	    var state = naver_id_login.getUniqState();
	    naver_id_login.setDomain(naver_domain);
	    naver_id_login.setState(state);
	    naver_id_login.init_naver_id_login();
	    // 네이버 로그인 버튼 자동 css 막기
	    $('#naver_id_login_anchor').addClass('letter1 font-14 btn btn-m btn-full font-800 text-uppercase rounded-sm= bg-naver-green');
	    $('#naver_id_login_anchor').empty();
	    $('#naver_id_login_anchor').css('background-color', '#00c63b !important');
	    $('#naver_id_login_anchor').append(' <img src="/images/icons/icon_naver.png" style="width:20px"> 네이버</a>');
	}
	
	function checkDormantYn(sParams) {	
		$.ajax({
			  url: "<c:url value='/member/checkDormantYn'/>"
			, type: "post"
			, dataType: 'json'
			, data: sParams
			, contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
			, success: function(data) {
				if(data.result) {
					userInfo = data.userInfo;
					if(data.msDormantYn) {						
						alertModal.confirm2('휴면계정입니다. 휴면 상태를 해제하시겠습니까?', 'changeDormant(userInfo)');
					}else{						
						doLogin(sParams);
					}
				} else {
					alertModal.fail(data.message);
				}
			}
			, error: function(data) {
				alertModal.fail('[error] 오류가 발생했습니다.');
			}
		});
	}
	
	function changeDormant(userInfo) {
		$.ajax({
			  url: "<c:url value='/member/changeDormant'/>"
			, type: "post"
			, dataType: 'json'
			, data: userInfo
			, contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
			, success: function(data) {
				if(data.result) {
					alertModal.success('휴면상태를 해제했습니다. 로그인해주세요');
				} else {
					alertModal.fail(data.message);
				}
			}
			, error: function(data) {
				alertModal.fail('[error] 오류가 발생했습니다.');
			}
		});
	}
	
	function doLogin(sParams) {		
		$.ajax({
			  url: "<c:url value='/member/doLogin'/>"
			, type: "post"
			, dataType: 'json'
			, data: sParams
			, contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
			, success: function(data) {
				if(data.result) {
					location.href = '/api/appInfo';
				} else {
					alertModal.fail(data.message);
				}
			}
			, error: function(data) {
				alertModal.fail('[error] 오류가 발생했습니다.');
			}
		});
	}
	
	function getUserAgent(){
		var varUA = navigator.userAgent.toLowerCase();
		var ua;
		if (varUA.indexOf("android") > -1) {
			ua = "Android";
		} else if (varUA.indexOf("iphone") > -1 || varUA.indexOf("ipad") > -1 || varUA.indexOf("ipod") > -1 || varUA.indexOf("apple") > -1) {
			ua = "iPhone";
		} else {
			ua = "etc";
		}
		return ua;
	}	
	
</script>

</body>	
</html>