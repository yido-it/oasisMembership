<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.yido.clubd.common.utils.Globals" %>
<jsp:include page="../common/script.jsp" />

    <div class="menu-title">
        <h1 class="my-0 py-0">선택정보입력</h1>
        <a id="btnSkip" class="font-14 mr-2 mb-3 bold btn btn-sm color-red-dark border-red-dark rounded-s" style="width:auto;height:auto;top:30%" >
            건너뛰기
        </a>
    </div>
	<form id="frmMemberAdd" name="frmMemberAdd">
    <div class="content mt-5">
       <h4 class="font-700 mt-5 mb-3">개인정보</h4>
        <input type="hidden" id="msNum" name="msNum" value="${sessionScope.msMember.msNum}">

		<span class="">생년월일</span> 
       	<div class="row mb-1 mt-1">
       	<input type="hidden" id="msBirth" name="msBirth"/>
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
        
		
		<div class="row mt-3 mb-0">
            <div class="col-6 mb-1">
                <div class="input-style input-style-2  input-required">
                    <span class="color-highlight">지역(시/도)</span>
                    <em><i class="fa fa-angle-down"></i></em>
                      <select id="msArea1" name="msArea1">
                        <option value="" disabled selected>선택하세요</option>
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
                    <em><i class="fa fa-angle-down"></i></em>
                    <select id="msArea2" name="msArea2">
                        <option value="" disabled>선택하세요</option>                     
                    </select>
                </div> 
            </div> 
        </div>
          
               <div class="row mb-0 mt-2" id="carArea1">
		            <div class="col-12 mb-1">
		                <div class="input-style input-style-2 input-required">
		                    <span class="color-highlight input-style-1-active">차량번호(최대3대)</span>
		                    <p class="font-13 color-green-dark mb-0" style="position: absolute; right: 10px;top:12px;height:30px;z-index:1;" id="btnAddCar">
		                     <i class="fa-solid fa-plus font-12"></i> 차량추가</p>
		                    <input class="form-control" type="name" id="msCarNo1" name="msCarNo1" maxLength="8">
		                </div> 
		            </div>
		         </div>
				<!--차량추가2-->
		        <div class="row mb-0 mt-0" id="carArea2" style="display:none;">
		            <div class="col-12 mb-1">
		                <div class="input-style input-style-2 input-required">
		                    <p class="font-13 color-red-dark mb-0" style="position: absolute; right: 10px;top:12px;height:30px;z-index:1;" id="btnDelCar2"> 
		                    <i class="fa-solid fa-x  font-12"></i> 차량삭제</p>
		                    <input class="form-control" type="name" id="msCarNo2" name="msCarNo2" maxLength="8">
		                </div> 
		            </div>
		        </div>
				<!--차량추가3-->
				<div class="row mb-0 mt-0" id="carArea3" style="display:none;">
				    <div class="col-12 mb-1">
				        <div class="input-style input-style-2 input-required">
				            <p class="font-13 color-red-dark mb-0" style="position: absolute; right: 10px;top:12px;height:30px;z-index:1;" id="btnDelCar3"> 
				            <i class="fa-solid fa-x  font-12"></i> 차량삭제</p>
				            <input class="form-control" type="name" id="msCarNo3" name="msCarNo3" maxLength="8">
				        </div> 
				    </div>
				</div>
            
           <div class="input-style input-style-2 input-required">
            <span class="color-highlight">선호 업장</span>
            <em><i class="fa fa-angle-down"></i></em>
             <select id="coDiv" name="coDiv">
                 <option value="" disabled selected>선호하는 업장</option>
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
				<c:forEach items="${unitList}" var="item" varStatus="status">
		            <div class="col-3 mb-1">
		               <div class="form-check icon-check">
							<input class="form-check-input" type="radio" name="msLessonUnit" value="${item.cdCode}" id="${'msLessonUnit'}${item.cdCode}">
							<label class="form-check-label" for="${'msLessonUnit'}${item.cdCode}">${item.cdTitle1}</label>
							<i class="icon-check-1 fa fa-circle color-gray-dark font-16"></i>
							<i class="icon-check-2 fa fa-check-circle font-16 color-highlight"></i>
						 </div>
		            </div>
		        </c:forEach>				          
				<div class="col-6 mb-1">
                     <div class="mx-auto">
                        <div class="stepper rounded-s float-left" style="border-color: rgba(255, 255, 255, 0.15) !important;top: -3px;position: relative;">
                            <a href="#" class="stepper-sub"><i class="fa fa-minus color-theme"></i></a>
                            <input type="number" max="99" placeholder="0" id="msLessonTrem" name="msLessonTrem" onKeyup="checkNumberInput(this, 2)">
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
                            <input type="number" max="99" placeholder="0" id="msRoundCnt" name="msRoundCnt" onKeyup="checkNumberInput(this, 2)">
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
 						<input type="number" max="999" placeholder="0" id="msLessonMinute" name="msLessonMinute" onKeyup="checkNumberInput(this, 3)">
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
	   					<input type="number" max="99" placeholder="0" id="msHandcap" name="msHandcap" onKeyup="checkNumberInput(this, 2)">
	   					<a href="#" class="stepper-add"><i class="fa fa-plus color-green-dark"></i></a>
					</div>  
					<span class="ml-1" style=""> 회</span>
					<div class="clearfix"></div> 
				</div>
      		</div>
		</div>				   
		
		<h4 class="font-700 mt-5 mb-3">직장정보</h4>
		
        <div class="row mb-0"> 
            <div class="col-6 mb-3">
                <div class="input-style input-style-2 input-required">
                    <span class="color-highlight">직업</span>
                    <em><i class="fa fa-angle-down"></i></em>
                    <select id="msJobCd" name="msJobCd">
		                <option value="" disabled selected>직업 선택</option>
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
                    <input class="form-control" type="name" placeholder="" id="msCompnm" name="msCompnm" maxLength="30">
                </div> 
            </div>
       	 </div>
       
    </div>
	</form>
    <div class="content mb-0 ">
          <button type="button" class="col-12 mb-4 btn btn-md  bg-blue-dark btn-full shadow-xl text-uppercase font-800 rounded-s" id="btnSave">
			입력완료
          </button>   
    </div>  
	<!-- // 선택정보 입력 -->
	
	<!-- 가입완료 팝업 -->
	<div id="memberComplete" class="menu menu-box-modal rounded-0 " data-menu-height="310" data-menu-width="330" data-menu-effect="menu-parallax" 
	data-backdrop="static" data-keyboard="false" style="display: block;height: 310px;width: 330px;z-index:99;" >
	    <h1 class="text-center mt-4"><i class="fa fa-3x fa-crown scale-box color-yellow-light shadow-xl rounded-circle"></i></h1>
	    <h3 class="text-center mt-3 font-700">회원가입 완료!</h3>
	    <p class="boxed-text-xl opacity-70">
	        ${sessionScope.msMember.msName} 회원님 반갑습니다!<br/>
	        클럽디청담 서비스 이용이 가능합니다 <br>
	    </p>
	    <div class="row mb-0 mr-3 ml-3">
	     
	        <div class="col-12">
	            <a href="javascript:location.href='/main'" class="btn btn-full btn-md bg-blue-dark font-800 text-uppercase rounded-s">시작하기</a>
	        </div>
	    </div>
	</div>
	<!-- // 가입완료 팝업 -->
	
	<script type="text/javascript">
		$().ready(function() {			
		    /* $('#msBirth').datepicker({
		        changeYear: true,
		        changeMonth: true,
		        dateFormat: 'yy-mm-dd',
		        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		        showMonthAfterYear: true,
		        yearSuffix: '년',
		        yearRange: '-100:+00',
       	
		    }); */		    
		    
		})		
		//setDateValue('msBirth');
		// var frqReg = /^[월주]{1,1}[0-9]{1,3}([회]{1,1})?$/g;	
		
		initMsBirth();		
			
		function initMsBirth() {			
			var now = new Date();
			var year = now.getFullYear();
			
			for(var i = year - 20; i >= year - 80; i--) {
			    $('#msBirth1').append('<option value="' + i + '">' + i + '</option>');
			} 
			$("#msBirth1").val(year - 30).prop('selected', true);
			for(var i = 1; i <= 12; i++) {
			    $('#msBirth2').append('<option value="' + i.toString().padStart(2, '0') + '">' + i + '</option>');
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
		
		$('#btnSkip').on('click', function() {
			$('#memberComplete').addClass('menu-active');
		})
		
		$('#msLessonTrem, #msRoundCnt, #msHandcap').on('keyup', function() {
			var msVal = $(this).val();
			$(this).val(msVal.replace(/[^0-9]/g, '').replace(/[0-9]{3,}/g, ''));	
		})
		$('#msLessonMinute').on('keyup', function() {
			var msVal = $(this).val();
			$(this).val(msVal.replace(/[^0-9]/g, '').replace(/[0-9]{4,}/g, ''));	
		})
		
		$('#btnSave').on('click', function() {
			
			if ($('input[name="msLessonUnit"]:checked').val() == undefined && $('#msLessonTrem').val() != '') {
				alertModal.fail('레슨빈도 단위를 입력해주세요.');
				return;
			}		
			if ($('input[name="msRoundUnit"]:checked').val() == undefined && $('#msRoundCnt').val() != '') {
				alertModal.fail('라운드빈도 단위를 입력해주세요.');
				return;
			}	
			if ($('input[name="msLessonUnit"]:checked').val() != undefined && $('#msLessonTrem').val() == '') {
				console.log($('input[name="msLessonUnit"]:checked').val());
				console.log($('#msLessonTrem').val());
				alertModal.fail('레슨빈도 횟수를 입력해주세요.');
				return;
			}
			if ($('input[name="msRoundUnit"]:checked').val() != undefined && $('#msRoundCnt').val() == '') {
				alertModal.fail('라운드빈도 횟수를 입력해주세요.');
				return;
			}
			if($('#msBirth3').val() != '' && $('#msBirth3').val() != null){
				var msBirth = $('#msBirth1').val() + '-' + $('#msBirth2').val() + '-' + $('#msBirth3').val();
				$('#msBirth').val(msBirth);
			}
			// console.log($('#frmMemberAdd').serializeArray());
			saveMemberAdd();
		})				
	
		function saveMemberAdd() {
			var obj = new Object();
			var frmArr = $('#frmMemberAdd').serializeArray();
			
			$.each(frmArr, function() {
				if(this.value != null && this.value != '') {
					obj[this.name] = this.value;
				}
			})
			
			//console.log(obj);
			
			$.ajax({
		        url: "<c:out value='/member/saveMemberAdd'/>"
		        , type: "post"
		        , dataType: 'json'
		        , data: obj
		        , contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
		        , success: function(data) {
		            if(data.result){		            	
		            	document.getElementById("memberAddPop").scrollTo(0,0);
		    			$('#memberComplete').addClass('menu-active');
		            } else {
		                alertModal.fail(data.message);                    
		            }                
		        }
		        , error: function(data) {
		        	 alertModal.fail('[error] 추가정보 등록 중 오류가 발생했습니다.');
		        }
		    });
		
		}
	</script>