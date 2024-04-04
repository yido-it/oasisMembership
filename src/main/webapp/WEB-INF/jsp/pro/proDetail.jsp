<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.yido.clubd.common.utils.Globals" %>
<jsp:include page="../common/head.jsp" />
<jsp:include page="../common/script.jsp" />
<style>
.lb-nav, .lb-prev, .lb-next {
	display:none !important;
}
.image-container {
	touch-action: none !important;
}
.lb-image {
	touch-action: none !important;
}
</style>

<body class="theme-light">
	<div id="preloader"><div class="spinner-border color-highlight" role="status"></div></div> 
	<div id="page"> 
		
		<!-- 좌측GNB-->
		<jsp:include page="../common/menu.jsp" />
		<!-- //좌측GNB-->
	
		<!--Header-->
		<div class="page-title page-title-fixed" style="opacity: 1; z-index:99; position:absolute">
			<a href="#" class="page-title-icon bg-white float-right mr-3 font-20 color-black" data-menu="menu-main"><i class="fa fa-bars"></i></a>
		</div>
		<!--//Header-->		
		
		<!-- <div class="page-title page-title-fixed" style="opacity: 1; z-index: 99;">
	        프로 정보 수정 아이콘
	        <a href="javascript:location.href='/pro/proForm'" class="page-title-icon shadow-xl bg-theme color-theme" id="btnEdit" style="display:none;">
	        	<i class="fa fa-gear"></i>
	        </a>
	        <a href="#" data-menu="menu-main" class="page-title-icon shadow-xl bg-theme color-theme"><i class="fas fa-bars"></i></a>
	    </div> -->
	    
         
	    <div class="card card-fixed" data-card-height="400">
	        <div class="splide ">
	            <div class="splide__track">
	                <div class="splide__list">	                    
	                    <div class="splide__slide">
	                        <!--700x466 이미지사이즈-->
	                        <c:choose>
	                        	<c:when test="${proProfile.fileURL != null && proProfile.fileURL != ''}">
	                       			<div class="card proimage" data-card-height="400" style="background: url(${proProfile.fileURL}) no-repeat 0 0;background-size: cover;"">
	                        	</c:when>                       
	        					<c:otherwise>
	        						<div class="card bg-empty_pro" data-card-height="400">
	        					</c:otherwise>
	                        </c:choose>
	                        <div class="card-bottom text-center mb-3">
	                        	<h1 class="color-white font-700 mb-0">${proInfo.msName} 프로</h1>
	                            <p class="color-white"><!-- KLPGA 서울 경기 --></p>
	                        </div>
	                        <div class="card-overlay bg-gradient"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        
    </div>    

    <div class="card card-clear" data-card-height="400"></div>
         
    <div class="page-content pb-3">  
        <div class="card card-full rounded-m" style="margin-bottom:-10px">        
            
            <div class="content mt-5">
                <p class="font-600 mb-n1 color-highlight">${proInfo.msEname}</p>
                <h1 class="font-30">${proInfo.msName} 프로</h1>
                <p class="mb-0">
                	<c:choose>
	                	<c:when test="${not empty proNoticeList}">
		                	<c:forEach items="${proLicList}" var="item" varStatus="status">
		                	<c:if test="${item.licOpenYn ne 'N'}">
		                    	<span class="badge bg-highlight px-2 py-1 mt-2 mr-2 text-uppercase">${item.licName}</span>
		                	</c:if>
		                    </c:forEach>
	                    </c:when>
	                    <c:otherwise>
	                    	<span class="badge bg-highlight px-2 py-1 mt-2 mr-2 text-uppercase"></span>
	                    </c:otherwise>
                	</c:choose>
                </p>
                <div class="">
                	<c:if test="${not empty proNoticeList}">
	                    <c:forEach items="${proNoticeList}" var="item" varStatus="status">
	                    <c:if test="${item.noticeDiv == '003'}">	                    
	                    <a href="https://m.youtube.com/${item.proRemark}" class="icon icon-m rounded-sm mb-2 mt-2  mr-2" >
	                    	<img src="/images/icons/icon_youtube.png" style="width:40px">
	                    </a>
	                    </c:if>
	                    <c:if test="${item.noticeDiv == '005'}">
	                    <a href="https://open.kakao.com/o/${item.proRemark}" class="icon icon-m rounded-sm mb-2 mt-2 mr-2">
	                    	<img src="/images/icons/icon_kakao.png" style="width:40px">
						</a>
	                    </c:if>
	                    <c:if test="${item.noticeDiv == '006'}">			            
	                        <a href="https://www.instagram.com/${item.proRemark}" class="icon icon-m rounded-sm mb-2 mt-2  mr-2">	                        	
	                    		<img src="/images/icons/icon_insta.png" style="width:40px">
	                        </a>
	                    </c:if>
	                    </c:forEach>
                	</c:if>
                </div> 
                
               	<c:if test="${not empty proNoticeList}">
           	    <c:forEach items="${proNoticeList}" var="item" varStatus="status">
	                <c:if test="${item.noticeDiv == '001' && item.noticeOpenYn != 'N'}">
	                <div class="divider mb-2 mt-2"></div>        
	                
	                <p class="mb-n1 color-highlight font-600 mb-n1">Career</p>
	                <h2>경력사항</h2>
	                <p>
	                	${item.proRemark}
	                </p> 
	                </c:if>
                </c:forEach>
                </c:if>

                <c:if test="${not empty proNoticeList}">
                	<c:forEach items="${proNoticeList}" var="item" varStatus="status">
                	<c:if test="${item.noticeDiv == '002' && item.noticeOpenYn != 'N'}">                
	               		<div class="divider mb-2 mt-2"></div>        
	                
		                <p class="mb-n1 color-highlight font-600 mb-n1">Lesson</p>
		                <h2>레슨계획</h2>
		                <p>
							${item.proRemark}
	                	</p>
					</c:if>
	                </c:forEach>
	             </c:if> 
                
				<c:if test="${not empty proNoticeList}">
					<c:forEach items="${proNoticeList}" var="item" varStatus="status">
					<c:if test="${item.noticeDiv == '007' && item.noticeOpenYn != 'N'}">
						<div class="divider mb-2 mt-2"></div>    
                
		                <p class="mb-n1 color-highlight font-600 mb-n1">Lesson</p>
		                <h2>레슨일정 <span class="sub_txt">상세일정은 프로와 상의하세요</span></h2>
		                <p>
                			${item.proRemark}	                    
                		</p> 
                	</c:if>
	                </c:forEach>
				</c:if>
                
            </div>
            <!-- // content -->
        
            <div class="divider mb-0"></div>
                
            <div class="content mb-0">                 
                <p class="mb-n1 color-highlight font-600 mb-n1">Gallery</p>
                <h2 style="display:inline-block">갤러리</h2>
        
            	<!--프로만 보임-->
                <a href="javascript:location.href='/pro/proGallery'" class="bold font-12 ml-2 mr-2 btn btn-xs color-white border-white rounded-s" id="btnGallery" style="width:auto;height:auto;display:none;">
                	<i class="fa fa-gear"></i>
                </a>
            	<!--//프로만 보임-->
            	
                <ul class="gallery-filter-controls mb-4 pb-1">
                    <li class="gallery-filter-active gallery-filter-all color-highlight" data-filter="all">모두</li>
                    <li data-filter="2">영상</li>
                    <li data-filter="1">사진</li>
                </ul>
            </div>
            <!-- // content -->
            
            <div class="content mb-3 text-center pro_detail">
	            <c:if test="${not empty proImgList}">
                	<div class="gallery gallery-filter-links" style="padding: 0px; position: relative; height: 234.75px;">
		             	<c:forEach items="${proImgList}" var="item" varStatus="status">
		             	<c:choose>
		              	<c:when test="${item.imgDiv eq 1}">
	                    	<a href="${item.fileURL}" data-lightbox="gallery-1" class="filtr-item default-link btn-pic" data-pic-url="${item.fileURL}" data-category="${item.imgDiv}" >								
								<img src="${item.thumbURL}" class="preload-img rounded-s shadow-m" >								
							</a>
		              	</c:when>
		              	<c:otherwise>
							<a href="${item.videoFileURL}" data-menu="menu-video" class="filtr-item default-link btn-video" data-video-url="${item.videoFileURL}" data-category="${item.imgDiv}">
							<div class="btn_videoplay"><i class="fa-regular fa-circle-play"></i></div>
								<img src="${item.videoThumbURL}" onerror="this.src='/images/thumb_loading.jpg'" class="preload-img rounded-s shadow-m">
							</a>
		                </c:otherwise>
		                </c:choose>
		                </c:forEach>
	            	</div>                
	            </c:if>
            </div>
            <!-- // content -->
              <div class="mb-10">
        </div>      
    </div>
	<!-- Page content ends here--> 
</div>
<!-- Page--> 

<!--  Video -->
<div id="menu-video" class="menu menu-box-bottom rounded-0" data-menu-height="300" data-menu-effect="menu-parallax">
    <div class="menu-title"> 
        <h1 class="my-0 py-0">영상</h1>
        <a href="#" class="close-menu"><i class="fa fa-times-circle"></i></a>
    </div>
    <div class="content mt-n2">
        <video controls playsinline style="width:100%;height:200px" src="" type="video/mp4"></video>          
    </div>
</div>   
<!------------->
	    
<div class="menu-hider"><div></div></div>
<jsp:include page="../common/footerBar.jsp" />
<script type="text/javascript">
	
	var msNum = "<c:out value='${sessionScope.msMember.msNum}'/>";

	$().ready(function() {
		if(urlParam('msNum') == msNum) {		
			$('#btnEdit').show();
			$('#btnGallery').show();
		}

	});
	
	var screen;
	var el;
	var img;
	var imageX;
	var imageY;
	var currentX;
	var currentY;
	var initScale;
	var transform = [];
	
	$('.btn-pic').on('click', function() {
		var url = $(this).data('pic-url');
		$(this).find('img').attr('data-src', url);		
		
		// ------------------------------------------ hammer.js
		
		screen = document.querySelector(".lightbox");
		el = document.querySelector('.image-container');
		img = document.querySelector('.lb-image');
		var mc = new Hammer.Manager(el);
		
		imageX = Math.round((screen.offsetWidth - el.offsetWidth) / 2);
		imageY = Math.round((screen.offsetHeight - el.offsetHeight) / 2);
		
		mc.add(new Hammer.Pan({ threshold: 0, pointers: 2}));	
		mc.add(new Hammer.Pinch({ threshold: 0 })).recognizeWith(mc.get('pan'));
		
		mc.on("panstart panmove", onPan);
		mc.on("pinchstart pinchmove", onPinch);
		mc.on("panend pancancel", onEnd);
				
		// ------------------------------------------ hammer.js
		
	})	
	
	function onPinch(ev) {
	    if(ev.type == 'pinchstart') {
	        initScale = transform.scale || 1;
	    }
	    if(initScale * ev.scale > 1) {	    	
		    transform.scale = initScale * ev.scale;
	    } else {
	    	transform.scale = 1;
	    }

	    elementUpdate();
	}
		
	function onPan(ev) {
		currentX = imageX + ev.deltaX
		currentY = imageY + ev.deltaY
	    transform.translate = {
			x: imageX + ev.deltaX,
			y: imageY + ev.deltaY
		};
		elementUpdate();		
	}
	
	function onEnd(ev) {
		
		minRangeX = 0 - (img.width * ev.scale / 2);
		minRangeY = 0 - (img.height * ev.scale / 2);		
		maxRangeX = img.width * ev.scale / 2;
		maxRangeY = img.height * ev.scale / 2;	
		
		if(currentX >= minRangeX && currentX <= maxRangeX) {
			imageX = currentX;
		} else if (currentX <= minRangeX) {
			imageX = minRangeX;
		} else {
			imageX = maxRangeX;
		}
		
		if(currentY >= minRangeY && currentY <= maxRangeY) {
			imageY = currentY;
		} else if (currentY <= minRangeY) {
			imageY = minRangeY;
		} else {
			imageY = maxRangeY;
		}
		
		//$('.lb-number').text('imageX : ' + imageX + ', imageY : ' + imageY);
		
		elementUpdate();
	}
	
	function elementUpdate() {
		if(transform.scale <= 1) {
			transform.translate = {
				x: 0,
				y: 0
			};
		}
	    var value = [
	    	'translate3d(' + transform.translate.x + 'px, ' + transform.translate.y + 'px, 0)',
	        'scale(' + transform.scale + ', ' + transform.scale + ')'
	    ];	   
	    	    
	    value = value.join(" ");
	    el.style.webkitTransform = value;
	    el.style.mozTransform = value;
	    el.style.transform = value;
	    
	}
	
	function initImgPos() {	
		var value =  'translate3d(0px, 0px, 0) scale(1, 1)';		
		
		el.style.webkitTransform = value;
	    el.style.mozTransform = value;
	    el.style.transform = value;
	}
	
	$('.btn-video').on('click', function() {
		var url = $(this).data('video-url');
		var thumb = $(this).attr('href');
		$('#menu-video').find('video').attr('src', url);
		$('#menu-video').find('video').attr('poster', thumb);
	})
	
</script>
</body>
</html>