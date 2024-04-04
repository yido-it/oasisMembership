package com.yido.clubd.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yido.clubd.common.service.CommonService;
import com.yido.clubd.common.utils.ResultVO;
import com.yido.clubd.common.utils.SessionVO;
import com.yido.clubd.common.utils.Utils;
import com.yido.clubd.model.BBS;
import com.yido.clubd.model.BookInfoVO;
import com.yido.clubd.model.CdCommon;
import com.yido.clubd.model.CoPlace;
import com.yido.clubd.model.DrBayInfo;
import com.yido.clubd.model.DrBkHistory;
import com.yido.clubd.model.DrBkHistoryTemp;
import com.yido.clubd.model.DrBkMark;
import com.yido.clubd.model.DrBkOpenTime;
import com.yido.clubd.model.DrBkTime;
import com.yido.clubd.model.DrPromotion;
import com.yido.clubd.model.DrPromotionMark;
import com.yido.clubd.model.DrVoucherCode;
import com.yido.clubd.model.DrVoucherList;
import com.yido.clubd.model.PrmInfoVO;
import com.yido.clubd.service.BBSService;
import com.yido.clubd.service.BookService;
import com.yido.clubd.service.ClDayInfoService;
import com.yido.clubd.service.CoPlaceService;
import com.yido.clubd.service.DrBayInfoService;
import com.yido.clubd.service.DrBkHistoryService;
import com.yido.clubd.service.DrBkHistoryTempService;
import com.yido.clubd.service.DrBkOpenTimeService;
import com.yido.clubd.service.DrBkTimeService;
import com.yido.clubd.service.DrCostInfoService;
import com.yido.clubd.service.PromotionService;
import com.yido.clubd.service.DrVoucherCodeService;
import com.yido.clubd.service.DrVoucherListService;
import com.yido.clubd.service.DrVoucherSaleService;
import com.yido.clubd.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/promotion")
public class PromotionController {

	@Autowired
	private PromotionService promotionService;


	/**
	 * [프로모션] 신청 페이지 
	 * 
	 * @param model
	 * @param res
	 * @param req
	 * @param pmSerialNo
	 * @return
	 */
	@RequestMapping("/apply/{pmSerialNo}")  
	public String promotionApply(Model model, HttpServletResponse res, HttpServletRequest req
			, @PathVariable String pmSerialNo) {

		ResultVO result = new ResultVO();
		DrPromotion prm = new DrPromotion();
		Map<String, Object> map = new HashMap<String, Object>();
		HttpSession session = req.getSession();
		SessionVO sessionVO = (SessionVO) session.getAttribute("msMember");
		String ipAddr = Utils.getClientIpAddress(req);
		String returnPage = "/promotion/apply";
		
		try {
			map.put("pmSerialNo", pmSerialNo);
			prm = promotionService.getPromotion(map);		
			model.addAttribute("prm", prm);
		
			// 프로모션 선점 처리
			PrmInfoVO pInfo = new PrmInfoVO();
			pInfo.setMsId(sessionVO.getMsId());
			pInfo.setMsNum(sessionVO.getMsNum());
			pInfo.setIpAddr(ipAddr);
			pInfo.setPmDivision(prm.getPmDivision());
			pInfo.setPmSerialNo(pmSerialNo);
			pInfo.setCoDiv(prm.getCoDiv());
						
			// 프로모션 선점시간 조회 
			pInfo.setMarkState("N");
    		List<DrPromotionMark> mList = promotionService.selectMarkList(pInfo);
			
    		if (mList.size() > 0) {
				model.addAttribute("markData", mList.get(0));	
			}		
			// end.
    		
			// 메인프로모션의 경우, 서브프로모션 조회
			if (prm.getPmMainYn().equals("Y") && prm.getPmRealYn().equals("N")) {
				log.info("메인프로모션의 경우, 서브프로모션 조회");
				String subBtnYn = "N";
				
				map.put("subPrmSearch", "Y");
				List<DrPromotion> subList = promotionService.selectList(map);
				
				for (DrPromotion subInfo : subList) {
					if(subInfo.getImgPath() == null || subInfo.getImgPath().equals("")) {
						subBtnYn = "Y";
					}
				}
				model.addAttribute("subBtnYn", subBtnYn);
				model.addAttribute("subList", subList);
			}
			// 서브프로모션의 경우, 메인프로모션 조회 
			if (prm.getPmMainYn().equals("N") && prm.getPmRealYn().equals("Y")) {
				log.info("서브프로모션의 경우, 메인프로모션 조회 ");
				
				map.put("mainSerialNo", prm.getMainSerialNo());
				map.put("mainPrmSearch", "Y");
				List<DrPromotion> mList2 = promotionService.selectList(map);
				model.addAttribute("mainPrm", mList2.get(0));
			}   		
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return returnPage;
	}

	/**
	 * 프로모션 선점 처리
	 * 
	 * @param model
	 * @param req
	 * @param pInfo
	 * @return
	 */
	@RequestMapping("/prmMarking") 
	@ResponseBody
	public ResultVO prmMarking(Model model, HttpServletRequest req, PrmInfoVO pInfo) {
		
		ResultVO result = new ResultVO();
		DrPromotion prm = new DrPromotion();
		HttpSession session = req.getSession();
		SessionVO sessionVO = (SessionVO) session.getAttribute("msMember");
		String ipAddr = Utils.getClientIpAddress(req);
		Map<String, Object> map = new HashMap<String, Object>();
		
		try {
			log.debug("[prmMarking] pmSerialNo > " + pInfo.getPmSerialNo());
			
			map.put("pmSerialNo", pInfo.getPmSerialNo());
			prm = promotionService.getPromotion(map);
			
			// 프로모션 선점 처리
			pInfo.setMsId(sessionVO.getMsId());
			pInfo.setMsNum(sessionVO.getMsNum());
			pInfo.setIpAddr(ipAddr);
			pInfo.setPmDivision(prm.getPmDivision());
			pInfo.setCoDiv(prm.getCoDiv());
			
			// 신청 불가능한 경우 , 마감 메세지 리턴 
			result = promotionService.prmMarking(pInfo);
			// end.
			
		} catch(Exception e) {
			e.printStackTrace();
			result.setCode("9999");
			result.setMessage("처리중 오류가 발생하였습니다.");
		}
		
		return result;
	}
	
	/**
	 * [프로모션] 결제 완료 페이지 
	 * 
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("/confirm")  
	public String promotionConfirm(Model model, HttpServletRequest req) {
		HttpSession session = req.getSession();
		Map<String, Object> map = new HashMap<String, Object>();
		SessionVO sessionVO = (SessionVO) session.getAttribute("msMember");
		String returnPage = "/promotion/confirm";
		
		try {
			if (sessionVO == null) return returnPage;

			// 프로모션 신청 내역 조회 
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("msNum", sessionVO.getMsNum());
			Map<String, Object> apply = promotionService.getApplyInfo(param);
			model.addAttribute("apply", apply);
			
			// 취소가능일 계산
			String sFromDt = apply.get("PM_EVENT_FROM_DAY").toString();	// 행사시작일
			int cancelLimit = Integer.parseInt(apply.get("PM_CANCEL_LIMIT").toString());	// 취소가능일수
			LocalDate cancelDt = LocalDate.of(
					Integer.parseInt(sFromDt.substring(0, 4))
					, Integer.parseInt(sFromDt.substring(4, 6))
					, Integer.parseInt(sFromDt.substring(6)));
		
			cancelDt = cancelDt.minusDays(cancelLimit);
			model.addAttribute("cancelDt", cancelDt);
			// end
			
			// 서브프로모션의 경우, 메인프로모션 조회 
			if (apply.get("PM_MAIN_YN").equals("N") && apply.get("PM_REAL_YN").equals("Y")) {
				log.info("서브프로모션의 경우, 메인프로모션 조회 ");
				
				map.put("mainSerialNo", apply.get("MAIN_SERIAL_NO"));
				map.put("mainPrmSearch", "Y");
				List<DrPromotion> mList = promotionService.selectList(map);
				model.addAttribute("mainPrm", mList.get(0));
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return returnPage;
	}

	/**
	 * [프로모션] 신청내역 목록 페이지   
	 * 
	 * @param model
	 * @param req
	 * @param coDiv
	 * @return
	 */
	@RequestMapping("/applyList/{coDiv}")  
	public String applyList(Model model, HttpServletRequest req, @PathVariable String coDiv) {
		HttpSession session = req.getSession();
		SessionVO sessionVO = (SessionVO) session.getAttribute("msMember");
		String returnPage = "/promotion/applyList";
		
		try {
			if (sessionVO == null) return returnPage;
			
			model.addAttribute("coDiv", coDiv);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return returnPage;
	}
	
	/**
	 * [프로모션] 조회 + 더보기 
	 * 
	 * @param model
	 * @param req
	 * @param coDiv
	 * @return
	 */
	@RequestMapping("/searchList/{coDiv}")  
	@ResponseBody
	public List<Map<String, Object>> searchList(Model model, HttpServletRequest req, @PathVariable String coDiv) {
		HttpSession session = req.getSession();
		SessionVO sessionVO = (SessionVO) session.getAttribute("msMember");
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		Map<String, Object> map = new HashMap<String, Object>();

		try {
			if (req.getParameter("listSize") != null) {
				// listSize : 어디서 부터 가져올지
				int listSize = Integer.parseInt(req.getParameter("listSize").toString());
				// 조회할 건수
				int limit = 5; 
				map.put("limit", limit);
				map.put("offset", listSize);
			}
			
			if (req.getParameter("srchPeriod") != null && !req.getParameter("srchPeriod").equals("") 
					&& req.getParameter("strtDt") != null && req.getParameter("endDt") != null) {
				String strtDt = req.getParameter("strtDt").toString();
				String endDt = req.getParameter("endDt").toString();
				
				map.put("strtDt", strtDt.replace("-", ""));
				map.put("endDt", endDt.replace("-", ""));
				map.put("srchPeriod", req.getParameter("srchPeriod"));
			}
			
			map.put("msNum", sessionVO.getMsNum());
			map.put("coDiv", coDiv);
			list = promotionService.applyList(map);		
		
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	/**
	 * 프로모션(결제)취소  
	 * 
	 * @param model
	 * @param req
	 * @param bInfo
	 * @return
	 */
	@RequestMapping("/cancel")  
	@ResponseBody
	public ResultVO promotionCancel(Model model, HttpServletRequest req, PrmInfoVO pInfo) {

		HttpSession session = req.getSession();
		SessionVO sessionVO = (SessionVO) session.getAttribute("msMember");
    	ResultVO result = new ResultVO();
		String ipAddr = Utils.getClientIpAddress(req);
	
    	log.info("[promotionCancel] 파라미터 > " + pInfo);
    	
		try {
			pInfo.setMsId(sessionVO.getMsId());
			pInfo.setMsNum(sessionVO.getMsNum());
			pInfo.setMsName(sessionVO.getMsName());
			pInfo.setMsPhone(sessionVO.getFullMsPhone());
			pInfo.setIpAddr(ipAddr);			
			result = promotionService.prmCancel(pInfo);
		} catch(Exception e) {
			e.printStackTrace();
			result.setCode("9999");
			result.setMessage("처리중 오류가 발생하였습니다.");
		}

		return result;
	}	
	
	/**
	 * 선점해제
	 * 
	 * @param req
	 * @param params
	 * @return
	 */
	@RequestMapping("/unBkMark")
	@ResponseBody
	public ResultVO unBkMark(HttpServletRequest req, PrmInfoVO pInfo){
		
    	ResultVO result = new ResultVO();
		HttpSession session = req.getSession();
		SessionVO sessionVO = (SessionVO) session.getAttribute("msMember");
		String ipAddr = Utils.getClientIpAddress(req);
    	
		try {
			pInfo.setMsId(sessionVO.getMsId());
			pInfo.setIpAddr(ipAddr);			
			result = promotionService.prmUnMarkLogic(pInfo);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	/**
	 * 선점 데이터 조회
	 * 
	 * @param req
	 * @param params
	 * @return
	 */
	@RequestMapping("/getMark")
	@ResponseBody
	public DrPromotionMark getMark(HttpServletRequest req, PrmInfoVO pInfo){
		DrPromotionMark drMark = new DrPromotionMark();
		HttpSession session = req.getSession();
		SessionVO sessionVO = (SessionVO) session.getAttribute("msMember");
		
		try {
			// 선점 테이블 조회
			pInfo.setMsId(sessionVO.getMsId());
    		List<DrPromotionMark> mList = promotionService.selectMarkList(pInfo);
			
			if (mList.size() > 0) drMark = mList.get(0);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return drMark;
	}	
}
