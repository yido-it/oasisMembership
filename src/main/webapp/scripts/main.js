/**
* Template Name: EstateAgency - v2.1.0
* Template URL: https://bootstrapmade.com/real-estate-agency-bootstrap-template/
* Author: BootstrapMade.com
* License: https://bootstrapmade.com/license/
*/
(function($) {
  "use strict";

  // Preloader
  $(window).on('load', function() {
    if ($('#preloader').length) {
      $('#preloader').delay(100).fadeOut('slow', function() {
        $(this).remove();
      });
    }
  });

  // Back to top button
  $(window).scroll(function() {
    if ($(this).scrollTop() > 100) {
      $('.back-to-top, .back-to-top2').fadeIn('slow');
    } else {
      $('.back-to-top, .back-to-top2').fadeOut('slow');
    }
  });
  $('.back-to-top').click(function() {
    $('html, body').animate({
      scrollTop: 0
    }, 500, 'easeInOutExpo');
    return false;
  });

  var nav = $('nav');
  var navHeight = nav.outerHeight();

  /*--/ ScrollReveal /Easy scroll animations for web and mobile browsers /--
  window.sr = ScrollReveal();
  sr.reveal('.foo', {
    duration: 1000,
    delay: 15
  });*/

  /*--/ Carousel owl /--*/
  $('#carousel').owlCarousel({
    loop: true,
    margin: -1,
    items: 1,
    nav: true,  
    navText: ['<i class="fa-solid fa-arrow-left" aria-hidden="true"></i>', '<i class="fa-solid fa-arrow-right" aria-hidden="true"></i>'],
    autoplay: true,
    autoplayTimeout: 6000,
    autoplayHoverPause: true
  });

  /*--/ Animate Carousel /--*/
  $('.intro-carousel').on('translate.owl.carousel', function() {
    $('.intro-content .intro-title').removeClass('animate__zoomIn animate__animated').hide();
    $('.intro-content .intro-price').removeClass('animate__fadeInUp animate__animated').hide();
    $('.intro-content .intro-title-top, .intro-content .spacial').removeClass('animate__fadeIn animate__animated').hide();
  });

  $('.intro-carousel').on('translated.owl.carousel', function() {
    $('.intro-content .intro-title').addClass('animate__zoomIn animate__animated').show();
    $('.intro-content .intro-price').addClass('animate__fadeInUp animate__animated').show();
    $('.intro-content .intro-title-top, .intro-content .spacial').addClass('animate__fadeIn animate__animated').show();
  });

  /*--/ Navbar Collapse /--*/
  $('.navbar-toggle-box-collapse').on('click', function() {
    $('body').removeClass('box-collapse-closed').addClass('box-collapse-open');
  });
  $('.close-box-collapse, .click-closed').on('click', function() {
    $('body').removeClass('box-collapse-open').addClass('box-collapse-closed');
    $('.menu-list ul').slideUp(700);
  });

  /*--/ Navbar Menu Reduce /--*/
  $(window).trigger('scroll');
  $(window).bind('scroll', function() {
    var pixels = 50;
    var top = 1200;
    if ($(window).scrollTop() > pixels) {
      $('.navbar-default').addClass('navbar-reduce');
      $('.navbar-default').removeClass('navbar-trans');
    } else {
      $('.navbar-default').addClass('navbar-trans');
      $('.navbar-default').removeClass('navbar-reduce');
    }
    if ($(window).scrollTop() > top) {
      $('.scrolltop-mf').fadeIn(1000, "easeInOutExpo");
    } else {
      $('.scrolltop-mf').fadeOut(1000, "easeInOutExpo");
    }
  });

  /*--/ Property owl /--*/
  $('#property-carousel').owlCarousel({
    loop: true,
    margin: 30,
    responsive: {
      0: {
        items: 1,
      },
      769: {
        items: 2,
      },
      992: {
        items: 3,
      }
    }
  });

  /*--/ Property owl owl /--*/
  $('#property-single-carousel').owlCarousel({
    loop: true,
    margin: 0,
    nav: true,
    navText: ['<i class="fa-solid fa-arrow-left" aria-hidden="true"></i>', '<i class="fa-solid fa-arrow-right" aria-hidden="true"></i>'],
    responsive: {
      0: {
        items: 1,
      }
    }
  });

  /*--/ News owl /--*/
  $('#new-carousel').owlCarousel({
    loop: true,
    margin: 30,
    responsive: {
      0: {
        items: 1,
      },
      769: {
        items: 2,
      },
      992: {
        items: 3,
      }
    }
  });

  /*--/ Testimonials owl /--*/
  $('#testimonial-carousel').owlCarousel({
    margin: 0,
    autoplay: true,
    nav: true,
    animateOut: 'fadeOut',
    animateIn: 'fadeInUp',
    navText: ['<i class="fa-solid fa-arrow-left" aria-hidden="true"></i>', '<i class="fa-solid fa-arrow-right" aria-hidden="true"></i>'],
    autoplayTimeout: 4000,
    autoplayHoverPause: true,
    responsive: {
      0: {
        items: 1,
      }
    }
  });

})(jQuery);

var pUrl = window.location.pathname;

// 요일 반환 
function getDate(sDate){ 
    var week = ['일', '월', '화', '수', '목', '금', '토'];
    var dayOfWeek = week[new Date(sDate).getDay()];
    return dayOfWeek;
}

// 오늘 날짜 반환 
function getToDay(separator){
	var today = new Date();   

	var year = today.getFullYear(); // 년도
	var month = today.getMonth() + 1;  // 월
	var date = today.getDate();  // 날짜
	var day = today.getDay();  // 요일
	
	var realMonth;
	if (month < 10) {
		realMonth = "0" + month;
	} else {
		realMonth = month;
	}
	var realDate;
	if (date < 10) {
		realDate = "0" + date;
	} else {
		realDate = date;
	}
	
	return year + separator + realMonth + separator + realDate;
}

function searchDate(value) {
	var endDt = new Date(getToDay("-"));
	var strtDt = new Date(getToDay("-"));
	
	switch(value) {
		case '1' : 
			// 1개월전
			strtDt.setMonth(strtDt.getMonth() - 1);
			strtDt = dateFormatter(strtDt, endDt);
			break;
		case '3' :
			// 3개월 전 
			strtDt.setMonth(strtDt.getMonth() - 3);
			strtDt = dateFormatter(strtDt, endDt);
			break;
		case '12' : 
			// 1년전
			strtDt.setFullYear(strtDt.getFullYear() - 1);
			strtDt = dateFormatter(strtDt, endDt);
			break;
	}
	
	return strtDt;
} 

function dateFormatter(newDay, today) {
	var year = newDay.getFullYear();
	var month = newDay.getMonth() + 1;
	var date = newDay.getDate();
	
	if (today) {
		var todayDate = today.getDate();
		if (date != todayDate) {
			if (month == 0) year -=1;
			month = (month + 11) % 12;
			date = new Date(year, month, 0).getDate();
		}
	}
	month = ("0"+month).slice(-2);
	date = ("0"+date).slice(-2);
	
	return year + "-" + month + "-" + date;
}

//내일 날짜 반환 
function getToTomorrow(separator){
	var today = new Date();   

	var year = today.getFullYear(); // 년도
	var month = today.getMonth() + 1;  // 월
	var date = today.getDate() + 1;  // 날짜
	var day = today.getDay();  // 요일
	
	var realMonth;
	if (month < 10) {
		realMonth = "0" + month;
	} else {
		realMonth = month;
	}
	var realDate;
	if (date < 10) {
		realDate = "0" + date;
	} else {
		realDate = date;
	}
	
	return year + separator + realMonth + separator + realDate;
}

// 날짜 문자열로 반환 
function getStringDt(date, separator){
	
	var strtYear = date.getFullYear(); // 년도
	var strtMonth = date.getMonth() + 1;  // 월
	var strtDate = date.getDate();  // 날짜
	
	var realMonth;
	if (strtMonth < 10) {
		realMonth = "0" + strtMonth;
	} else {
		realMonth = strtMonth;
	}
	var realDate;
	if (strtDate < 10) {
		realDate = "0" + strtDate;
	} else {
		realDate = strtDate;
	}
	
	return strtYear + separator + realMonth + separator + realDate;
}

// 날짜 문자열로 반환  
// separator 가 B 이면 년월일로 return 
function getStringDt2(date, separator){

	// 파라미터 : 20230117
	var year = date.substr(0, 4);
	var month = date.substr(4, 2);
	var day = date.substr(6);
	
	var returnDate = "";
	if (separator == "B") {
		returnDate = year + "년 " + month + "월 " + day + "일";
	} else {
		returnDate =  year + separator + month + separator + day;
	}
	
	return returnDate;
}

function getTimeFormat(data){
	var returnValue = data;
		
	if (data < 10) {
		returnValue = "0" + data;
	}
	return returnValue;
}

function randomNum(){
    const randomNum = Math.floor(Math.random() * 899 + 100);

    return randomNum;
}

// input 입력 여부 체크
function chkInputVal (id) {
	var str = $('#' + id).data('name');
	const charCode = str.charCodeAt(str.length - 1);
    const consonantCode = (charCode - 44032) % 28;
    
    if($('#' + id).val() == "" || $('#' + id).val() == null) {
    	if(consonantCode === 0){
	        alertModal.fail(str + '를 입력해주세요');
	    } else {	
	        alertModal.fail(str + '을 입력해주세요');
	    }
		return false;
	}
    return true;
}

// select input 입력하기
function setSelectValue(id, value) {
	var id = "#" + id;	
	if(value == undefined || value == null) {
		value = $(id + "Val").val();	
	}
	if(value != null && value != "") {		
			$(id).parent().find('span').removeClass('input-style-1-inactive input-style-1-active');
			$(id).val(value).prop("selected", true);
			$(id).parent().find('span').addClass('input-style-1-inactive input-style-1-active');
	}	
}

// radio 선택하기
function setRadioValue(name, value) {	
	if(value == undefined || value == null) {
		value = $('#' + name + "Val").val();
	}
	if(value != null && value != "") {		
		$('input[name="' + name + '"]:radio[value="' + value + '"]').prop("checked", true);		
	}
	
}

// date input 입력하기
function setDateValue(id, value) {
	var id = "#" + id;
	if(value == undefined || value == null) {
		value = $(id).val();
		if(value == null || value == "") {
			value = getToDay("-");			
		}
		$(id).val(value);		
		$(id).parent().find('span').removeClass('input-style-1-inactive input-style-1-active');
		$(id).parent().find('span').addClass('input-style-1-inactive input-style-1-active');	
	} else {
		$(id).parent().find('span').removeClass('input-style-1-inactive input-style-1-active');
		$(id).parent().find('span').addClass('input-style-1-inactive input-style-1-active');
	}

}

// alertModal 후 페이지 이동
function goAfterModal(url) {
	var time = 1200;
	var str = "";
	
	if (url != undefined && url != null && url != "") {
		str = "location.href='" + url + "'";
	} else if (url == "back") {
		str = "history.back()"
	} else {
		str = "location.reload()";
	}
	setTimeout(str, time);
}

/**
 * url parameter 구하기<br/>
 *  @returns : 파라미터의 값<br/>
 *  @param name : url에서 가져올 파라미터 이름<br/>
 */
function urlParam(name) {
	var queryString = window.location.search;
	var urlParams = new URLSearchParams(queryString);
	if (!urlParams.has(name)) { 
		return false;
	} 
	return urlParams.get(name);
}	

/** @param txt<br/>
 *  @param len : 생략시 기본값 20<br/>
 *  @param lastTxt : 생략시 기본값 "..."<br/>
 *  @returns 결과값
 * <br/>
 * <br/>
 * 특정 글자수가 넘어가면 넘어가는 글자는 자르고 마지막에 대체문자 처리<br/>
 *  ex) 가나다라마바사 -> textLengthOverCut('가나다라마바사', '5', '...') : 가나다라마...<br/>
 */
function textLengthOverCut(txt, len, lastTxt) {
    if (len == "" || len == null) { // 기본값
        len = 20;
    }
    if (lastTxt == "" || lastTxt == null) { // 기본값
        lastTxt = "...";
    }
    if (txt.length > len) {
        txt = txt.substr(0, len) + lastTxt;
    }
    return txt;
}

// 모바일 기기 여부 확인
function mobileYn() {
		return /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
}

/** 
 * 폼데이터 수정<br/>
 * @param values : formData<br/>
 * @param k : 변경할 input Name<br/>
 * @param v : 변경될 input Value<br/>
 */
function changeSerialize(values, k, v) {
    var found = false;
    for (i = 0; i < values.length && !found; i++) {
        if ( values[i].name == k ) { 
            values[i].value = v;
            found = true;
        }
    }
    if (!found) {
        values.push(
            {
                name: k,
                value: v
            }  
        );
    }
    return values;
}

/**
 * number input에 정해진 길이의 숫자만 입력<br/>
 * @param item : input 대상<br/>
 * @param len : 제한 자리수<br/>
 */
function checkNumberInput(item, len) {
	var numberValidator = /^[0-9]/;
	if(!item.value.match(numberValidator)) {
		item.value = '';
	}
	if(item.value.length > len)  {
    	item.value = item.value.substr(0, len);
	}
}

// 필요한 라이브러리 로드
$(function() {	
  var myElement = document.querySelector('body');
  var hammertime = new Hammer(myElement);

  hammertime.get('pan').set({ direction: Hammer.DIRECTION_VERTICAL });

  hammertime.on('panstart', function(ev) {
    if (ev.angle > 50 && ev.angle < 130) {
      // 팬 동작이 수직 방향인 경우
      // $('body').addClass('panning');
    }
  });

  hammertime.on('panend', function(ev) {
    if (ev.angle > 50 && ev.angle < 130) {
      // 팬 동작이 수직 방향인 경우
      // $('body').removeClass('panning');
      $('#preloader').removeClass('preloader-hide');
      location.reload();
    }
  });
});



