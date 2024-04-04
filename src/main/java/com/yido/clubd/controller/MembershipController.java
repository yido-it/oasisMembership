package com.yido.clubd.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yido.clubd.common.utils.SessionVO;
import com.yido.clubd.model.MembershipVO;
import com.yido.clubd.service.MembershipService;

import lombok.extern.slf4j.Slf4j;

/**
 * 회원정보 (회원/프로)
 * 
 * @author YOO
 *
 */
@Controller
@Slf4j
public class MembershipController {

	@Autowired
	private MembershipService membershipService;
	
	
	/**
	 * 멤버십 조회 페이지
	 * 
	 * @param model
	 * @param req
	 * @return String
	 */
	@RequestMapping("/vipCard")  
	public String goVipCard(Model model, HttpServletRequest req) {
		HttpSession session = req.getSession();
		SessionVO member = (SessionVO) session.getAttribute("msMember");
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("msNum", member.getMsNum());
		// params.put("msNum", "000000002144");
		params.put("coBrandDiv", "001");
		
		List<MembershipVO> membership = membershipService.getMembershipList(params);
		model.addAttribute("membership", membership);
		return "/vipCard";
	}
	
	@ResponseBody
	@RequestMapping("/vipCard/getBenefitInfo")  
	public Map<String, Object> getBenefitInfo(Model model, HttpServletRequest req
			, @RequestParam Map<String, Object> params) {
		params.put("coBrandDiv", "001");
		Map<String, Object> resMap = new HashMap<String, Object>();
		try {			
			List<MembershipVO> benefitList = membershipService.getBenefitList(params);
			resMap.put("result", true);
			resMap.put("list", benefitList);
		} catch(Exception e) {
			resMap.put("result", false);
			resMap.put("messeage", e.getMessage());			
		}
		return resMap;
	}
}
