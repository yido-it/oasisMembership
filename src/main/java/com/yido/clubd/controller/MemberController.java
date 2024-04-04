package com.yido.clubd.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.WebUtils;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.yido.clubd.common.service.CommonService;
import com.yido.clubd.common.utils.Globals;
import com.yido.clubd.common.utils.KakaoRestAPI;
import com.yido.clubd.common.utils.SessionVO;
import com.yido.clubd.common.utils.Utils;
import com.yido.clubd.model.CdCommon;
import com.yido.clubd.model.CoPlace;
import com.yido.clubd.model.DrMsCoInfo;
import com.yido.clubd.model.MemberVO;
import com.yido.clubd.service.CoPlaceService;
import com.yido.clubd.service.DrMsCoInfoLogService;
import com.yido.clubd.service.DrMsCoInfoService;
import com.yido.clubd.service.MemberService;

import lombok.extern.slf4j.Slf4j;

/**
 * 회원정보 (회원/프로)
 * 
 * @author YOO
 *
 */
@Controller
@Slf4j
@RequestMapping("/member")
public class MemberController {

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private CoPlaceService coPlaceService;
	
	@Autowired
	private DrMsCoInfoService drMsCoInfoService;
	
	@Autowired
	private DrMsCoInfoLogService drMsCoInfoLogService;
		
	/**
	 * 회원가입 첫 페이지 (약관 동의)
	 * 
	 * @param req
	 * @param model
	 * @return String
	 */
	@RequestMapping("/agree")  
	public String goAgree(HttpServletRequest req, Model model) {
		model.addAttribute("msLoginCd", req.getParameter("msLoginCd"));
		return "/member/agree";
	}
	
	/**
	 * 회원가입 > 필수정보 입력 페이지
	 * 
	 * @param req
	 * @param model
	 * @return String
	 */
	@RequestMapping("/memberForm")  
	public String goMemberForm(HttpServletRequest req, Model model) {
		model.addAttribute("msMktAgreeYn", req.getParameter("msMktAgreeYn"));
		model.addAttribute("msLoginCd", req.getParameter("msLoginCd"));
		return "/member/memberForm";
	}
	
	/**
	 * 회원가입 > 회원 추가정보 팝업
	 * 
	 * @param model
	 * @return String
	 */
	@RequestMapping("/memberAddPop")  
	public String goMemberAddPop(Model model) throws Exception {
		CdCommon cdCommon = new CdCommon();
		cdCommon.setCoDiv("001");
		
		cdCommon.setCdDivision("025");
		List<CdCommon> jobList = commonService.getCommonCodeList(cdCommon);
		cdCommon.setCdDivision("220");
		List<CdCommon> msArea1List = commonService.getCommonCodeList(cdCommon);
		cdCommon.setCdDivision("029");
		List<CdCommon> unitList = commonService.getCommonCodeList(cdCommon);
		
		List<CoPlace> placeList = coPlaceService.selectPlaceList();
		model.addAttribute("jobList", jobList);
		model.addAttribute("msArea1List", msArea1List);
		model.addAttribute("unitList", unitList);
		model.addAttribute("placeList", placeList);
		return "/member/memberAddPop";
	}
	
	/*@RequestMapping("/memberAddrPop")  
	public String goMemberAddrPop(Model model, HttpServletRequest req) throws Exception {
		String searchAddr = (String) req.getParameter("searchAddr");
		Map<String, Object> params = new HashMap<>();
		params.put("searchAddr", searchAddr);
		model.addAttribute("addrList", commonService.getAddrList(params));
		return "/member/memberAddrPop";
	}*/
		
	/**
	 * 회원가입 > 아이디 중복확인
	 * 
	 * @param msId
	 * @return Map
	 */
	@RequestMapping("/checkIdExist")
	@ResponseBody
	public Map<String, Object> checkIdExist (@RequestParam(required = false) String msId) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("msId", msId);
		
		if (memberService.selectFindUser(map) != null) {
			map.put("message",  "이미 가입된 아이디입니다.");
			map.put("result", false);			
		} else {
			map.put("message",  "사용 가능한 아이디입니다.");
			map.put("result", true);
		}
		return map;
	}
	
	/**
	 * 회원가입 > 인증번호 전송
	 * 
	 * @param req
	 * @param params
	 * @return Map
	 */
	@RequestMapping(value = "/verifybyCode")
	@ResponseBody
	public Map<String, Object> verifybyCode(HttpServletRequest req, @RequestParam Map<String, Object> params) {
		Map<String, Object> map = new HashMap<>();
		String[] msPhone = ((String)params.get("msPhone")).split("-");
		
		params.put("msFirstPhone1", msPhone[0]);
		params.put("msMidPhone1", msPhone[1]);
		params.put("msLastPhone1", msPhone[2]);
				
		try {
			if(memberService.selectFindUser(params) != null) {				
				map.put("result", false);
				map.put("message", "이미 가입된 번호입니다.");				
			} else {
				// 인증번호 메시지 전송
				params.put("coDiv", "001");
				params.put("msPhone", ((String)params.get("msPhone")).replace("-", ""));
				params.put("sendMsg", (String)params.get("sendMsg"));
				params.put("bayName", (String)params.get("verifyCode"));
				
				commonService.sendSms(params);
				map.put("result", true);
				map.put("message", "문자로 인증번호를 전송했습니다.");
				} 
		} catch (Exception e) {
			map.put("message", "인증번호 전송에 실패했습니다");
		}
		return map;
	}	
	
	/**
	 * 회원가입
	 * 
	 * @param req
	 * @param res
	 * @param session
	 * @param memberVO
	 * @return Map
	 */
	@RequestMapping("/doSignUp")
	@ResponseBody
	public Map<String, Object> doSignUp (HttpServletRequest req, HttpServletResponse res, HttpSession session, MemberVO member) throws Exception{
		
		Map<String, Object> map = new HashMap<String, Object>();
		member.setIpAddr(Globals.serverIpAddress);
		log.debug(String.valueOf(session.getAttribute("msMember")));
		
				
		if(member.getMsLoginCd() != "APP" && member.getMsLoginCd() != "HOMEPAGE") {
			//String msId = member.getMsPhone().replaceAll("-", "");
			String msId = member.getMsId();
			map.put("msId", msId);
			if(memberService.checkSocialId(map) != null) {				
				map.put("result",  false);
				map.put("message", "이미 소셜 아이디로 가입된 회원입니다.");
				return map;
			}
			member.setMsId(msId);
		}
			
		try {
			memberService.insertMember(member);
			
			// DR_MS_CO_INFO 사업장별 유저 정보 최초 등록
			DrMsCoInfo drMsCoInfo = new DrMsCoInfo();
			drMsCoInfo.setCoDiv("001");
			drMsCoInfo.setMsNum(member.getMsNum());
			drMsCoInfo.setMsFirstPick("N");
			
			drMsCoInfoService.insertDrMsCoInfo(drMsCoInfo);
			
			// 등록 로그 저장
			drMsCoInfo.setLogDiv("I");
			drMsCoInfoLogService.insertDrMsCoInfoLog(drMsCoInfo);
			
			memberService.loginUserInfo(req, res, session, Utils.convertVotoMap(member));
			
			map.put("result",  true);
			map.put("userInfo",  member);
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "가입중 오류가 발생했습니다.");
		}
		
		return map;
	}	
	
	/**
     * 휴면상태 확인
     * 
     * @param params
     * @return Map
     */
    @RequestMapping(value = "/checkDormantYn")
    @ResponseBody
    public Map<String, Object> checkDormantYn (@RequestParam Map<String, Object> params) {

		Map<String, Object> map = new HashMap<String, Object>();

    	try {
    		MemberVO userInfo = memberService.selectLoginUser(params);    		
    		// 유저 정보 불일치
    		if(userInfo == null) {
        		map.put("result",  false);
        		map.put("message",  "해당하는 사용자 정보가 없습니다.");
        	// 휴면상태 확인
    		} else {
    			map.put("result",  true);
    			map.put("userInfo",  userInfo);
        		if("N".equals(userInfo.getMsDormant())) {
	        		map.put("msDormantYn",  false);
        		} else {
        			map.put("msDormantYn",  true);
        		}       
    		}
    	} catch (Exception e) {
    		map.put("result",  false);
    		map.put("message",  "로그인 중 에러가 발생했습니다.");
    	}
    	
    	return map;
    }
    
    /**
	 * 휴면상태 해제
	 * 
	 * @param params
	 * @return Map
	 */
	@RequestMapping("/changeDormant")
	@ResponseBody
	public Map<String, Object> changeDormant(@RequestParam Map<String, Object> params) {
		Map<String, Object> map = new HashMap<String, Object>();	
		try {
			memberService.updateDormant(params);			
			map.put("result", true);
    	} catch (Exception e) {
    		map.put("result", false);
    		map.put("message", "수정 중 오류가 발생했습니다.");
    	}
		return map;
	}	
	
	/**
     * 일반 로그인
     * 
     * @param req
     * @param res
     * @param session
     * @param params
     * @return Map
	 * @throws JsonProcessingException 
     */
    @RequestMapping(value = "/doLogin")
    @ResponseBody
    public Map<String, Object> doLogin (HttpServletRequest req, HttpServletResponse res, HttpSession session
    		, @RequestParam Map<String, Object> params) throws JsonProcessingException {

		Map<String, Object> map = new HashMap<String, Object>();
		params.put("ipAddr", Globals.serverIpAddress);
		params.put("msLoginCd", "APP");

    	try {
    		MemberVO userInfo = memberService.selectLoginUser(params);    		
    		if(userInfo == null) {
    			// 유저 정보 불일치
        		map.put("result",  false);
        		map.put("message",  "해당하는 사용자 정보가 없습니다.");
    		} else {
    			memberService.loginUserInfo(req, res, session, params);  
    			
    			String dest = (String)session.getAttribute("dest") == null? "/main?login=y" : (String)session.getAttribute("dest");
    			session.setAttribute("dest", dest);
    			
    			map.put("result",  true);		
        		map.put("userInfo",  userInfo);
        		        
    		}
    	} catch (Exception e) {
    		map.put("result",  false);
    		map.put("message",  "로그인 중 에러가 발생했습니다.");
    	}
    	
    	return map;
    }
    
    /**
     * 소셜 로그인
     * 
     * @param req
     * @param res
     * @param session
     * @param params ( 로그인타입 : msLoginCd, 이름 : msName )
     * @return Map
     */
    @RequestMapping(value = "/doLoginForSocial")
    @ResponseBody
    public Map<String, Object> doLoginForSocial (HttpServletRequest req, HttpServletResponse res, HttpSession session
    		, @RequestParam Map<String, Object> params) {

		Map<String, Object> map = new HashMap<String, Object>();
    	try {
    		params.put("ipAddr", Globals.serverIpAddress);
    		
    		if(memberService.selectFindUser(params) == null) {
    			// 최초가입 -> 간편회원가입 페이지로 이동
    			session.setAttribute("joinInfo", params);
    			session.setAttribute("msLoginCd", params.get("msLoginCd"));
        		session.setMaxInactiveInterval(60 * 60 * 24 * 30);
        		
        		map.put("result", true);
        		map.put("dest", "/member/agree?msLoginCd=" + params.get("msLoginCd"));
				
    		} else {
    			// 기존가입 -> 로그인처리
    			memberService.loginUserInfo(req, res, session, params);
    			map.put("result",  true);
    			map.put("dest", (String)session.getAttribute("dest")); 
    			
    			session.removeAttribute("dest");
    		}
    	} catch (Exception e) {
    		log.debug(e.getMessage());
    		map.put("result", false);
			map.put("message", "소셜로그인 중 오류가 발생했습니다.");
    	}
    	
		return map;
    }
    
    /**
	 * 네이버 로그인 동의하기 콜백 페이지
	 * 
	 * @param req
	 * @param res
	 * @return String
	 */
    @RequestMapping(value = "/succNaverLogin")
    public String goNaverCallbackPage(HttpServletRequest req, HttpServletResponse res) {
    	// 프로필 조회 페이지로 이동
        return "/member/succNaverLogin";
    }
    
    /**
     * 카카오 로그인 동의하기 콜백 페이지
     * 
     * @param code
     * @param req
     * @param model
     * @return String
     */
    @RequestMapping(value = "/succKakaoLogin")
    public String oauthKakao(@RequestParam(value = "code", required = false) String code, HttpServletRequest req, Model model) throws Exception {
        try {
        	String access_Token = KakaoRestAPI.getAccessToken(code);
        	HashMap<String, Object> joinInfo = KakaoRestAPI.getKakaoUserInfo(access_Token);
        	model.addAttribute("joinInfo", joinInfo);               
        } catch(Exception e) {
        	log.debug(e.getMessage());
        	model.addAttribute("message", "카카오 가입 정보를 불러올 수 없습니다.");  
        }
        return "/member/succKakaoLogin"; 
    }
    
    /**
	 * 회원 추가정보 저장
	 * 
	 * @param session
	 * @param params
	 * @return Map
	 */
	
	@RequestMapping("/saveMemberAdd")
	@ResponseBody
	public Map<String, Object> saveMemberAdd(HttpServletRequest req, HttpSession session, @RequestParam Map<String, Object> params){
		Map<String, Object> map = new HashMap<String, Object>();
		SessionVO member = new SessionVO();

		try {
			memberService.updateMember(params);
			memberService.saveMemberBasic(params);
			memberService.saveMemberCar(params);
			memberService.saveFirstPick(params);
			
			member = memberService.selectMsSession(params);	
			
			session.setAttribute("msMember", member);
			map.put("result",  true);
		} catch(Exception e) {
			e.printStackTrace();
			map.put("result",  false);
			map.put("message", "추가정보 등록중 오류가 발생했습니다.");
		}
		
		return map;
	}
    
    /**
	 * 회원정보 수정 페이지
	 * 
	 * @param model
	 * @param session
	 * @return String
	 */
	@RequestMapping("/memberModify")  
	public String goMemberModify(Model model, HttpSession session) throws Exception {
		CdCommon cdCommon = new CdCommon();
		cdCommon.setCoDiv("001");
		
		cdCommon.setCdDivision("025");		
		List<CdCommon> jobList = commonService.getCommonCodeList(cdCommon);
		cdCommon.setCdDivision("220");
		List<CdCommon> msArea1List = commonService.getCommonCodeList(cdCommon);
		cdCommon.setCdDivision("029");
		List<CdCommon> unitList = commonService.getCommonCodeList(cdCommon);
		
		List<CoPlace> placeList = coPlaceService.selectPlaceList();
		
		SessionVO member = (SessionVO)session.getAttribute("msMember");
		String msNum = member.getMsNum();
		MemberVO basicInfo = memberService.selectMemberBasic(msNum);
		List<MemberVO> carList = memberService.selectMemberCarList(msNum);
		DrMsCoInfo drMsInfo = drMsCoInfoService.selectFirstPick(msNum);
		
		model.addAttribute("jobList", jobList);
		model.addAttribute("msArea1List", msArea1List);
		model.addAttribute("unitList", unitList);
		model.addAttribute("placeList", placeList);
		
		model.addAttribute("basicInfo", basicInfo);
		model.addAttribute("carList", carList);
		
		if(drMsInfo != null) {
			model.addAttribute("msFirstPick", drMsInfo.getCoDiv());			
		}else {			
			model.addAttribute("msFirstPick", "");			
		}
		
		return "/member/memberModify";
	}	
	
	/**
	 * 회원정보 수정 저장
	 * 
	 * @param session
	 * @param params
	 * @return Map
	 */
	@RequestMapping("/saveMemberModify")
	@ResponseBody
	public Map<String, Object> saveMemberModify(HttpServletRequest req, HttpSession session, @RequestParam Map<String, Object> params) {
		Map<String, Object> map = new HashMap<String, Object>();
		SessionVO member = new SessionVO();
		
		try {
			if((String)params.get("newMsPassword") != null && (String)params.get("newMsPassword") != "") {
				MemberVO userInfo = memberService.selectLoginUser(params);    		
				if(userInfo == null) {
					// 유저 정보 불일치
		    		map.put("result",  false);
		    		map.put("message",  "비밀번호가 일치하지 않습니다.");
		    		return map;
				}
			}
			
			memberService.updateMember(params);
			memberService.saveMemberBasic(params);
			memberService.saveMemberCar(params);	
			memberService.saveFirstPick(params);
			
			member = memberService.selectMsSession(params);	
			
    		session.setAttribute("msMember", member);
			map.put("result", true);
    	} catch (Exception e) {
    		map.put("result", false);
    		map.put("message", "수정 중 오류가 발생했습니다.");
    	}
		return map;
	}	
	
	/**
	 * 회원탈퇴
	 * 
	 * @param session
	 * @param req
	 * @return Map
	 */
	@RequestMapping("/deleteMember")
	@ResponseBody
	public Map<String, Object> deleteMember(HttpSession session, HttpServletRequest req, @RequestParam Map<String, Object> params) {
		Map<String, Object> map = new HashMap<String, Object>();
		SessionVO member = (SessionVO)session.getAttribute("msMember");
		params.put("msNum", member.getMsNum());
		params.put("ipAddr", Globals.serverIpAddress);
		try {
			memberService.updateMemberQuit(params);			
			map.put("result", true);
    	} catch (Exception e) {
    		map.put("result", false);
    		map.put("message", "탈퇴 중 오류가 발생했습니다.");
    	}
		return map;
	}	
		
	/**
	 * 아이디/비밀번호 찾기 페이지
	 * 
	 * @param model
	 * @param req
	 * @return String
	 */
	@RequestMapping("/memberFind")  
	public String goMemberFind(Model model, HttpServletRequest req) {
		return "/member/memberFind";
	}
	
	/**
	 * 아이디 찾기
	 * 
	 * @param params
	 * @return Map
	 */	
	@RequestMapping(value = "/doFindId")
	@ResponseBody
	public Map<String, Object> doFindId(@RequestParam Map<String, Object> params) {
			Map<String, Object> map = new HashMap<String, Object>();
		try {
			MemberVO member = memberService.selectFindUser(params);

			if (member == null) {
				throw new Exception("등록 된 아이디가 없습니다.");
			}
			
			if(member.getMsLoginCd().equals("KAKAO")) {
				throw new Exception("KAKAO 간편 로그인으로 로그인 부탁드립니다.");
			}

			if(member.getMsLoginCd().equals("NAVER")) {
				throw new Exception("NAVER 간편 로그인으로 로그인 부탁드립니다.");
			}

			map.put("result", true);
			map.put("msId", member.getMsId());
			
		} catch (Exception e) {
			map.put("result", false);
			map.put("message", e.getMessage());
		}
		return map;
	}

	/**
	 * 비밀번호 초기화
	 * 
	 * @param req
	 * @param params
	 * @return Map
	 */
	@RequestMapping(value = "/doResetPw")
	@ResponseBody
	public Map<String, Object>  doResetPw(HttpServletRequest req, @RequestParam Map<String, Object> params) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			MemberVO member = memberService.selectFindUser(params);

			if (member == null) {
				throw new Exception("등록 된 정보가 없습니다.");
			}

			StringBuffer newMsPassword = new StringBuffer();
			Random rnd = new Random();
			for (int i = 0; i < 6; i++) {
				int rIndex = rnd.nextInt(2);
				switch (rIndex) {
				case 0:
					newMsPassword.append((char) ((int) (rnd.nextInt(26)) + 97));
					break;
				case 1:
					newMsPassword.append((rnd.nextInt(10)));
					break;
				}
			}

			params.put("msNum", member.getMsNum());
			params.put("newMsPassword", newMsPassword.toString());

			memberService.updatePassword(params);

			// 새 비밀번호 SMS 전송
			params.put("coDiv", "001");
			params.put("tplCd", "10022");
			params.put("msPhone", (params.get("msPhone")).toString().replace("-", ""));
			params.put("msId", member.getMsId());
			params.put("msPassword", newMsPassword.toString());
			
			commonService.sendSms(params);
			
			map.put("result", true);
		} catch (Exception e) {
			map.put("result", false);
			map.put("message", e.getMessage());
		}
		return map;
	}
	
	/**
	 * 회원 조회
	 * 
	 * @param req
	 * @param params
	 * @return List
	 */
	@RequestMapping(value = "/searchMemberList")
	@ResponseBody
	public List<MemberVO> memberList(HttpServletRequest req, @RequestParam Map<String, Object> params) {
		List<MemberVO> mList = new ArrayList<MemberVO>();		
		log.info("[searchMemberList] params : " + params);
		
		try {
			if (params.get("searchType") == null || params.get("searchTxt") == null ) {
				return mList;
			}
			
			mList = memberService.selectMemberList(params);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mList;
	}
	

	/*@RequestMapping(value = "/checkPhoneNumber")
	public void checkPhoneNumber(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@RequestParam Map<String, Object> params) {
		ResultVO result = new ResultVO();

		try {
			if(memberService.selectPhoneNumber(params) > 0) {
				params.put("mergeYn", "Y");
				if(memberService.selectPhoneNumber(params) > 0) {
					result.setCode("1000");
	        		result.setMessage("이미 가입된 핸드폰번호 입니다.");
    			}else {
    				result.setCode("2000");
    				result.setMessage("이미 가입한 이력이 있습니다. 통합회원으로 새로 가입하시겠습니까?");
    			}
			}
		} catch (Exception e) {
			result.setCode("9999");
			result.setMessage(e.getMessage());
		} finally {
			Utils.sendData(response, Utils.makeJsonString(result));
		}
	}
	*/
	
	@RequestMapping("/sessionChk") 
	@ResponseBody
    public boolean sessionChk(HttpServletRequest req, HttpServletResponse res) throws Exception {
		Boolean loginYn;
        HttpSession session = req.getSession();        
		SessionVO sessionVO = (SessionVO) session.getAttribute("msMember");
		log.debug("sessionChk > " + sessionVO);
		
		if (sessionVO != null) {
			// 1) 세션에 로그인 정보 있음 => 로그인 상태
			loginYn = true;
		} else {
			// 2) 세션에 로그인 정보 없음  => 자동로그인인지 확인
			Cookie loginCookie = WebUtils.getCookie(req, "sessionKey");
			
			// 2-1) 쿠키에 자동 로그인 세션키가 있는 경우
			if (loginCookie != null) {	
				
				Map<String, Object> params = new HashMap<String, Object>();			
				params.put("msSessionKey", loginCookie.getValue());
				SessionVO member = memberService.selectSessionLoginUser(params);
						
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
	
					memberService.insertLoginLog(params);
					loginYn = true;
				
				// 2-1-2) 세션키로 조회시 유저 정보 없음
				} else {	
					loginYn = false;
				}
		
			// 2-2) 자동 로그인 세션키가 없으면 로그인 페이지로 이동
			} else {
				loginYn = false;
			}			
		}
		return loginYn;
	}
	
}
