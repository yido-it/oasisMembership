package com.yido.clubd.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.yido.clubd.common.utils.Globals;
import com.yido.clubd.common.utils.SessionVO;
import com.yido.clubd.common.utils.Utils;
import com.yido.clubd.model.BBS;
import com.yido.clubd.model.DrPromotion;
import com.yido.clubd.model.MemberVO;
import com.yido.clubd.model.Push;
import com.yido.clubd.service.BBSService;
import com.yido.clubd.service.MemberService;
import com.yido.clubd.service.PromotionService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/")
public class WebController {

	@Autowired
	private BBSService bbsService;
	
	@Autowired
	private PromotionService drPromotionService;
	
	@Autowired
	private MemberService memberService;
	
	@GetMapping(value = "")
	public String index(Model model) {
		return "redirect:main";	
	}
	
	/**
	 * 메인페이지
	 * 
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("/main")
	public String index(Model model, HttpServletRequest req) {
		
		// 프로모션 
		Map<String, Object> pMap = new HashMap<String, Object>();
		pMap.put("openYn", "Y");		// 오픈되어있는 프로모션 조회 
		pMap.put("coDiv", "001");
		pMap.put("mainYn", "Y");
		List<DrPromotion> pList = drPromotionService.selectList(pMap);
		model.addAttribute("pList", pList);
		// end.
		
		LocalDate now = LocalDate.now(ZoneId.of("Asia/Seoul"));
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
		String formatedNow = now.format(formatter);
		
		// 이벤트 
		Map<String, Object> eMap = new HashMap<String, Object>();
		eMap.put("today", formatedNow);
		eMap.put("bbsType", 2);
		eMap.put("coDiv", "001");
		List<BBS> eList = bbsService.selectList(eMap);	
		model.addAttribute("eList", eList);
		// end.
		
		// 초대장
		Map<String, Object> iMap = new HashMap<String, Object>();
		iMap.put("today", formatedNow);
		iMap.put("coDiv", "001");
		iMap.put("bbsType", 4);
		List<BBS> iList = bbsService.selectList(iMap);	
		model.addAttribute("iList", iList);
		// end.
		
		// 프로 리스트
		List<MemberVO> proList = memberService.selectProList();
		model.addAttribute("proList", proList);
		// end.
		
		// 앰배서더 리스트
		List<MemberVO> ambassadorList = memberService.selectAmbassadorList();
		model.addAttribute("ambassadorList", ambassadorList);
		// end.
		
		return "/index";
	}

    @RequestMapping("/qrscan")
    public String qrCode(Model model, HttpServletRequest request) {
    	
		// 프로모션 
		Map<String, Object> pMap = new HashMap<String, Object>();
		pMap.put("openYn", "Y");		// 오픈되어있는 프로모션 조회 
		pMap.put("coDiv", "001");
		List<DrPromotion> pList = drPromotionService.selectList(pMap);	
		model.addAttribute("pList", pList);
		// end.
		
		// 이벤트 
		Map<String, Object> eMap = new HashMap<String, Object>();
		eMap.put("bbsType", 2);
		eMap.put("coDiv", "001");
		List<BBS> eList = bbsService.selectList(eMap);	
		model.addAttribute("eList", eList);
		// end.
		
		// 프로 리스트
		List<MemberVO> proList = memberService.selectProList();
		model.addAttribute("proList", proList);
		// end.
		
		// 앰배서더 리스트
		List<MemberVO> ambassadorList = memberService.selectAmbassadorList();
		model.addAttribute("ambassadorList", ambassadorList);
		// end.
		
		return "/index";
    }
    
    
	/**
	 * 로그인 페이지
	 * 
	 * @param error
	 * @param req
	 * @param model
	 * @return
	 */
    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(@RequestParam(required = false) String error, HttpServletRequest req, Model model) throws IOException {
    	
        String referrer = req.getHeader("Referer");
		log.debug("referrer - {}", referrer);
	
        Cookie[] cookies = req.getCookies();
    	if(cookies != null) {
    		for(Cookie cookie : cookies) {
    			model.addAttribute(cookie.getName(), cookie.getValue());
        	}
    	}

        log.debug("ip1 - {}", req.getRemoteAddr());
        return "/member/login";
    }  
    
    /**
	 *
	 * @param model
	 * @return
	 * 비동기로 APP에 접속자의 msNum을 넘겨줌
	 */
	@RequestMapping("/api/appInfo")
	public String appInfo(Model model, HttpServletRequest req) {
		HttpSession session = req.getSession();
		SessionVO msMember = (SessionVO)session.getAttribute("msMember");	
		return "redirect:/api/getAppInfo?msNum=" + msMember.getMsNum();
	}
	
	@RequestMapping("/api/getAppInfo")
	public String getAppInfo(Model model, HttpServletRequest req) {
		HttpSession session = req.getSession();
		String dest = (String)session.getAttribute("dest");
		model.addAttribute("dest", dest);		
		session.removeAttribute("dest");
		return "/member/redirect";
	}

	/**
	 * 접속자 토큰정보 저장
	 * @param push
	 * @throws IOException
	 */
	@RequestMapping("/api/setToken")
	public void setToken(Push push, HttpServletRequest req, HttpServletResponse res) throws IOException {
		System.out.println("============push : " + push + " [" + LocalDate.now() + "]==========");
		push.setIpAddr(Globals.serverIpAddress);
		if(push != null) {			
			memberService.updateMemberToken(push);
		}
	}
    
    /**
	 * 로그아웃 처리
	 * 
	 * @param model
	 * @param req
	 * @param model
	 * @return
	 */
    @RequestMapping("/succ-logout")
	public String successLogout(Model model, HttpServletRequest req, HttpServletResponse res) {
    	
    	SessionVO msMember = (SessionVO)req.getSession().getAttribute("msMember");
    	
    	if(req.getHeader("User-Agent").toLowerCase().indexOf("mobi") > -1) {
	    	Push push = new Push();
			push.setMsNum(msMember.getMsNum());
			push.setToken("");
			push.setIpAddr(Globals.serverIpAddress);
			memberService.updateMemberToken(push);
    	}

		//세션 invalidate
    	req.getSession().invalidate();
		
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
    	
    	return "redirect:/main";
	}

	/**
	 * 공지사항 상세
	 * 
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("/noticeView")  
	public String noticeView(Model model, HttpServletRequest req) {
		return "/notice/noticeView";
	}

	/**
	 * 이용안내
	 * 
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("/guide")  
	public String guide(Model model, HttpServletRequest req) {
		return "/guide";
	}

	/**
	 * 시설안내
	 * 
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("/facility")  
	public String facility(Model model, HttpServletRequest req) {
		return "/facility";
	}

	/**
	 * 요금안내 
	 * 
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("/charge")  
	public String charge(Model model, HttpServletRequest req) {
		return "/charge";
	}
	
	@RequestMapping("/bay1")  
	public String bay1(Model model, HttpServletRequest req) {
		return "/bay/bay1";
	}
	
	@RequestMapping("/bay2")  
	public String bay2(Model model, HttpServletRequest req) {
		return "/bay/bay2";
	}
	
	@RequestMapping("/bay3")  
	public String bay3(Model model, HttpServletRequest req) {
		return "/bay/bay3";
	}
	
	@RequestMapping("/bay4")  
	public String bay4(Model model, HttpServletRequest req) {
		return "/bay/bay4";
	}
	
	@RequestMapping("/bay5")  
	public String bay5(Model model, HttpServletRequest req) {
		return "/bay/bay5";
	}
	
}
 	