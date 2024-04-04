package com.yido.clubd.config;


import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.yido.clubd.common.utils.Globals;
import com.yido.clubd.common.utils.SessionVO;
import com.yido.clubd.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Configuration
@Component
@Slf4j
public class NotLoginInterceptor extends HandlerInterceptorAdapter {
	
	public String[] interceptY = { 
		  "/**"
	};
		
	public String[] interceptN = {
		  "/fonts/**"
	    , "/images/**"
		, "/scripts/**"
		, "/scss/**"
		, "/styles/**"
		, "/store/**"
		, "/**/*.js"
		, "/**/*.jpg"
		, "/**/*.jpeg"
		, "/**/*.png"
		, "/exception"		
		, "/member/memberModify/**"
		, "/vipCard/**"
		, "/pro/proGallery/**"
		, "/pro/proForm/**"
		, "/book/**"
		, "/voucher/**"
		, "/promotion/**"
		, "/member/doLogin*"
		, "/login"
		, "/api/**"
	};
	
	@Autowired
	private MemberService drMsMaininfoService;
	
	@Override
    public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) throws Exception {
		String destUri = req.getRequestURI();
        HttpSession session = req.getSession();        
		SessionVO sessionVO = (SessionVO) session.getAttribute("msMember");
		
		// 1) 세션에 로그인 정보 없음
		if(sessionVO == null) {	
			Cookie loginCookie = WebUtils.getCookie(req, "sessionKey");
			
			// 2-1) 쿠키에 자동 로그인 세션키가 있는 경우
			if (loginCookie != null) {	
				
				Map<String, Object> params = new HashMap<String, Object>();			
				params.put("msSessionKey", loginCookie.getValue());
				SessionVO member = drMsMaininfoService.selectSessionLoginUser(params);
				
				// 2-1-1) 세션키로 조회시 유저 정보 있음
				if (member != null) {
					String ua = null;
					
					if(params.get("ua") != null) {
						ua = params.get("ua").toString();
					} else {
						ua = req.getHeader("user-agent");
						if (ua.indexOf("Android") != -1) {
							ua = "Android";
						} else if( ua.indexOf("iPad") != -1 || ua.indexOf("iPhone") != -1 || ua.indexOf("iOS") != -1 || ua.indexOf("MAC") != -1 ) {
							ua = "iPhone";
						} else if( ua.indexOf("Windows") != -1) {
							ua = "windows";
						} else {
							ua = req.getHeader("user-agent");
						}
					}
			
					session.setAttribute("msMember", member);
	
					params.put("msNum",member.getMsNum());
					params.put("platform", "APP");
					params.put("loginAuto", "Y");
					params.put("userAgent", ua);
					params.put("inputStaff", "APP");
					params.put("ipAddr", Globals.serverIpAddress);
	
					drMsMaininfoService.insertLoginLog(params);
				
				// 2-1-2) 세션키로 조회시 유저 정보 없으면 세션 삭제
				} else {	
					//delete cookie
					Cookie[] cookies = req.getCookies();
			    	if(cookies != null) {
			    		for(Cookie cookie : cookies) {
			    			if(cookie.getName().contains("sessionKey")) {
			    				System.out.println("delete cookie = " + cookie.getName());    			
			        			cookie.setMaxAge(0);
			        			cookie.setValue(null);
			        			res.addCookie(cookie); 
			    			}
			        	}
			    	}
				}
			} 
			
		// 2) 세션에 로그인 정보 없음  => 자동로그인인지 확인
		} 
		
		return true;
	}		
	
	// 로그인이 필요한 페이지가 아니면 기존 dest 정보 삭제
	@Override
    public void postHandle(HttpServletRequest req, HttpServletResponse res, Object handler, ModelAndView modelAndView) throws Exception {
		String destUri = req.getRequestURI(); 
		if(req.getSession().getAttribute("dest") != null) {			
			System.out.println("=====================> dest ( " + req.getSession().getAttribute("dest") + ") removed from " + destUri);
			req.getSession().removeAttribute("dest"); 
		}
		res.setHeader("Pragma", "no-cache");
		res.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    }
	

}
