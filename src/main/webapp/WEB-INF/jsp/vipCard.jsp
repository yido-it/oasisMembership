<!-- 이용안내 페이지 -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.yido.clubd.common.utils.Globals" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<jsp:include page="common/head.jsp" />
<jsp:include page="common/script.jsp" />
<style>
	.owl-dots {
		position: relative;
		padding-top: 2rem
	}
	.box-area {
		width:100%;
		min-height: 420px;
		display: flex;
		align-items: center;
	}
	.qr-box {
		width: 100%;
		display: none;
		flex-direction: column;
		align-items: center;
	}
</style>
<body class="theme-light">
    
	<div id="preloader"><div class="spinner-border color-highlight" role="status"></div></div>
    
	<div id="page">
	
		<div class="header header-fixed header-logo-app">
			<a href="#" class="header-title header-subtitle">VIP Membership</a>
			<jsp:include page="common/top.jsp" />
		</div>
	
		<!-- 좌측GNB-->
		<jsp:include page="common/menu.jsp" />
		<!-- //좌측GNB-->
	
	    <div class="page-content header-clear">
	        <div class="page-content pb-3">  
	            <div class="content">	
	            
	            <div class="owl-carousel owl-theme">
	            
		            <c:choose>
		            <c:when test="${not empty membership}">
		            <c:forEach items="${membership}" var="item" varStatus="status">		            
			            <!-- 카드 -->
						<div class="row" id="${status.index}">
							<div class="p-0 my-2 box-area">
								<div class="img-box justify-content-center" style="display:flex;">
									<img src="${item.fileURL}" class="img-fluid col-9 card-img" onclick="showQr('${status.index}', '${item.qr}')">
								</div>
								<!-- 이미지 클릭하면 나오는 qr이미지와 숫자 -->
								<div class="qr-box" onclick="showCard('${status.index}')">
									<div class="img-fluid qr-img" style=""></div>
									<p class="text-center mt-3" onclick="return false;">${item.barcodeNo}</p>
								</div> 
							</div>
							<div class="col-12">
								<div class="justify-content-center" style="display:flex;">
									<button type="button" class="btn col-4 text-center btn-dark py-1 btn-qr" onclick="showQr('${status.index}', '${item.qr}')">
										QR
									</button>
									<button type="button" class="btn col-4 text-center btn-dark py-1 btn-img" onclick="showCard('${status.index}')" style="display:none;">
										<i class="fa fa-undo" aria-hidden="true"></i>
									</button>
									<button type="button" class="btn col-4 text-center py-1 ml-2" data-toggle="modal" data-target="#benefit" style="background: #ea5439; border: #ea5439;" onclick="getBenefitInfo('${item.membershipDiv}','${item.membershipName}' )">
										BENEFIT
									</button>										
								</div>					
							</div>
						</div>
					</c:forEach>					
		            </c:when>
		            <c:otherwise>
		            	<h5>등록된 카드가 없습니다.</h5>
		            </c:otherwise>		            
		            </c:choose>
				</div>		
			</div>  
		</div>
	</div>
</div>

<!-- 하단바 -->
<jsp:include page="common/footerBar.jsp" />
<script type="text/javascript" src="/scripts/jquery-qrcode-0.18.0.js"></script>
<script>
	
	$('.owl-carousel').owlCarousel({
		autoplay: false,
		nav: false,
		margin: 10,
		items: 1,
		onDragged: callbackOnDrag
	})
	
	function callbackOnDrag(e) {
		$('.btn-img').hide();
		$('.btn-qr').show();
		
		$('.qr-box').hide();
		$('.img-box').css('display', 'flex');
	}

	function showQr(id, qrText) {
		console.log(qrText);
		$('#' + id).find('.btn-qr').hide();
		$('#' + id).find('.btn-img').show();
		$('#' + id).find('.qr-img').empty();
		let options = {			    
			    render: 'image',	// render method: 'canvas', 'image' or 'div'			   
			    minVersion: 1,		// version range somewhere in 1 .. 40
			    maxVersion: 40,			    
			    ecLevel: 'L',		// error correction level: 'L', 'M', 'Q' or 'H'

			    left: 0,
			    top: 0,
			    size: 200,
			    fill: '#000',
			    background: null,
			    text: qrText,
			    
			    radius: 0,	// corner radius relative to module width: 0.0 .. 0.5			  
			    quiet: 0,	// quiet zone in modules
			    
			    mode: 0,	// modes (0: normal, 1: label strip, 2: label box, 3: image strip, 4: image box)
			    mSize: 0.1,
			    mPosX: 0.5,
			    mPosY: 0.5,
			    label: '',
			    fontname: 'sans',
			    fontcolor: '#000',
			    image: null
			}
		
		$('#' + id).find('.qr-img').qrcode(options);
		
		$('#' + id).find('.img-box').hide();
		$('#' + id).find('.qr-box').css('display', 'flex');
	}
		
	function showCard(id) {
		$('#' + id).find('.btn-img').hide();
		$('#' + id).find('.btn-qr').show();
		
		$('#' + id).find('.qr-box').hide();
		$('#' + id).find('.img-box').css('display', 'flex');
	}
	
	function getBenefitInfo(div, name) {
		$('.benefit-title').text(name);
		$.ajax({
			url: "/vipCard/getBenefitInfo"
			, type: "post"
			, contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
			, data: {
				'membershipDiv': div
			}
			, success: function(data) {
				if(data.result) {
					setBenefitInfo(data.list);
				}
			}
		})
	}
	
	function setBenefitInfo(list) {
		let str = "";		
		for (var i in list) {
			str += "<li>" + list[i].benefitNm + "</li>";
		}
		$('.benefit-contents').html(str);
	}
	
</script>

<!-- 혜택 모달창 -->
<div class="modal fade" id="benefit" data-backdrop="static" data-keyboard="false" aria-labelledby="benefitLabel" aria-hidden="true" style="z-index:9999">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title benefit-title"></h5>								
			</div>
			<div class="modal-body">
				<ul class="benefit-contents">					
				</ul>
			</div>
			<div class="modal-footer" style="justify-content: center;" data-dismiss="modal" aria-label="Close">
		        <button type="button" class="btn btn-close text-dark p-0">닫기</button>
			</div>
		</div>
	</div>
</div>

</body>
<!-- /* #benefit .row {
	    border-top: 1px solid #eee;
	}
	#benefit .col-4 {
	    border-bottom: 1px solid #eee;
	    border-left: 1px solid #eee;
	    text-align: center;
	    padding: 5px;
	}
	#benefit .col-4:nth-child(3n) {
		border-right: 1px solid #eee;
	}
	#benefit .col-4:last-child {
		border-right: 1px solid #eee;
	} */ -->
</html>