package com.yido.clubd.controller;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.yido.clubd.common.utils.ResultVO;
import com.yido.clubd.common.utils.SessionVO;
import com.yido.clubd.repository.MemberMapper;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/admin")
public class AdminController {

	@Autowired
    private MemberMapper memberMapper;
	
	/**
	 * 사용자 로그인 페이지 (관리자가 사용하는 기능) 
	 * 
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("/userLogin")  
	public String userLogin(HttpServletRequest req) {
		return "/admin/userLogin";
	}
	
	/**
	 * 사용자 로그인 (관리자가 사용하는 기능) 
	 * 
	 * @param model
	 * @param req
	 * @param msNum
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/userLogin/{msNum}")  
	@ResponseBody
	public ResultVO userLogin(HttpSession session, @PathVariable String msNum) throws Exception {
		Map<String, Object> param = new HashMap<String, Object>();
		ResultVO result = new ResultVO();
		
		try {
			param.put("msNum", msNum);
	
			SessionVO sessionVO = memberMapper.selectMsSession(param);
			session.setAttribute("msMember", sessionVO);
			session.setMaxInactiveInterval(60 * 60 * 24 * 30);
			
		} catch (Exception e) {
			result.setCode("9999");
			e.printStackTrace();
		}
		return result;
	}
}
