package com.yido.clubd.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
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
import com.yido.clubd.model.BookInfoVO;
import com.yido.clubd.model.CdCommon;
import com.yido.clubd.model.CoPlace;
import com.yido.clubd.model.DrBayInfo;
import com.yido.clubd.model.DrBkHistoryTemp;
import com.yido.clubd.model.DrBkMark;
import com.yido.clubd.model.DrBkOpenTime;
import com.yido.clubd.model.DrBkTime;
import com.yido.clubd.service.BookService;
import com.yido.clubd.service.ClDayInfoService;
import com.yido.clubd.service.CoPlaceService;
import com.yido.clubd.service.DrBayInfoService;
import com.yido.clubd.service.DrBkHistoryService;
import com.yido.clubd.service.DrBkHistoryTempService;
import com.yido.clubd.service.DrBkMarkService;
import com.yido.clubd.service.DrBkOpenTimeService;
import com.yido.clubd.service.DrBkTimeService;
import com.yido.clubd.service.DrCostInfoService;
import com.yido.clubd.service.DrVoucherListService;
import com.yido.clubd.service.DrVoucherSaleService;
import com.yido.clubd.service.MemberService;

import ch.qos.logback.classic.pattern.Util;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/book")
public class BookController {
 
	@Autowired
	private DrBayInfoService drBayInfoService;
	
	@Autowired
	private DrBkOpenTimeService drBkOpenTimeService;
	
	@Autowired
	private DrBkTimeService drBkTimeService;

	@Autowired
	private MemberService memberService;
	
	@Autowired
	private BookService bookService;
	
	@Autowired
	private ClDayInfoService clDayInfoService;
	
	@Autowired
	private DrBkHistoryTempService drBkHistoryTempService;
	
	@Autowired
	private DrBkHistoryService drBkHistoryService;
	
	@Autowired
	private CoPlaceService coPlaceService;
	
	@Autowired
	private DrCostInfoService drCostInfoService;
	
	@Autowired
	private DrVoucherSaleService drVoucherSaleService;
	
	@Autowired
	private DrVoucherListService drVoucherListService;
	
	@Autowired
	private CommonService commonService;

	@Autowired
	private DrBkMarkService drBkMarkService;
	
	/**
	 * [예약] 예약페이지
	 * 
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("/bookMain/{coDiv}")  
	public String bookMain(Model model, HttpServletRequest req, @PathVariable String coDiv) {
		HttpSession session = req.getSession();
		SessionVO sessionVO = (SessionVO) session.getAttribute("msMember");
		String returnPage = "/book/bookMain";
		
		try {
			if (sessionVO == null) return returnPage;
			
			// BAY 목록
			Map<String, Object> map = new HashMap<String, Object>();
			List<DrBayInfo> bayList = drBayInfoService.selectList(map);
			model.addAttribute("bayList", bayList);
			
			// 현재 시간 기준으로 가장 마지막 오픈날짜 구하기
			DrBkOpenTime drBkOpenTime = new DrBkOpenTime();
			drBkOpenTime.setMsLevel(sessionVO.getMsLevel());
			drBkOpenTime.setBayCondi("001");
			drBkOpenTime = drBkOpenTimeService.getBkDay(drBkOpenTime);
			model.addAttribute("maxBkDay", drBkOpenTime.getBkDay());
			model.addAttribute("coDiv", coDiv);
			
			// 위약 정보 ( grantYn > N : 예약불가 )
			Map<String, Object> msMap = new HashMap<String, Object>();
			msMap.put("msId", sessionVO.getMsId());
			String grantYn = memberService.chkMsBkGrant(msMap);
			model.addAttribute("grantYn", grantYn);			
			
			// 예약 갯수 조회 (조건 : 회원번호 & 상태 : 취소,노쇼,정산완료 아닌 것) 
			int bkCnt = drBkHistoryService.getBkCnt(sessionVO.getMsNum());
			model.addAttribute("bkCnt", bkCnt);		
			
			// 예약 최대 개수 
			CdCommon common = new CdCommon();
			common.setCdDivision("002");
			common.setCdCode(sessionVO.getMsLevel());	// 등급
			common = commonService.getCommonCode(common);
			int maxBkCnt = common != null && common.getCdLength() != null && !common.getCdLength().equals("") 
					? Integer.parseInt(common.getCdLength()) : 4;				
			model.addAttribute("maxBkCnt", maxBkCnt);
			// end.
			
		} catch(Exception e) {
			e.printStackTrace();
		}

		return returnPage;
	}

	/**
	 * [예약] 예약 2단계 페이지로 이동 (사용자가 담아둔 예약 정보를 임시테이블에 넣기)
	 * 
	 * @param req
	 * @param bookInfo
	 * @param coDiv
	 * @return
	 */
	@RequestMapping("/book2/{coDiv}")
	@ResponseBody
	public ResultVO tempBook2(HttpServletRequest req, BookInfoVO bInfo, @PathVariable String coDiv){
		
		log.info("[tempBook2] 결제 페이지로 이동 > param : " + bInfo);
    	ResultVO result = new ResultVO();
		
		HttpSession session = req.getSession();
		SessionVO sessionVO = (SessionVO) session.getAttribute("msMember");
		String ipAddr = Utils.getClientIpAddress(req);
		
		try {
			if (sessionVO == null) {
				return result;
			}

			bInfo.setMsId(sessionVO.getMsId());
			bInfo.setMsNum(sessionVO.getMsNum());
			bInfo.setCoDiv(coDiv);
			bInfo.setIpAddr(ipAddr);
			/**
			 * 예약가능여부 체크 
			 * --> 예약 가능하다면 예약선점 처리 + 임시테이블에 데이터 저장
			 * --> 예약 불가하다면 중단 처리 
			 */
			result = bookService.chkBookLogic(bInfo);
				
		} catch(Exception e) {
			e.printStackTrace();
			result.setCode("9999");
			result.setMessage("처리중 오류가 발생하였습니다.");
		}
		
		return result;
	}
	
	/**
	 * [예약] 예약 2단계 페이지 (예약 임시 데이터 조회 해서 화면에 표출해주기)
	 * 
	 * @param model
	 * @param req
	 * @param serialNo
	 * @return
	 */
	@RequestMapping("/book2/{coDiv}/{serialNo}")  
	public String book2(Model model, HttpServletRequest req, @PathVariable String coDiv, @PathVariable String serialNo) {
		HttpSession session = req.getSession();
		SessionVO sessionVO = (SessionVO) session.getAttribute("msMember");
		String ipAddr = Utils.getClientIpAddress(req);
		String returnPage = "/book/book2";
		
		try {
			if (coDiv == null || serialNo == null || sessionVO == null 
					|| coDiv.equals("") || serialNo.equals("") || sessionVO.getMsId().equals("")) {
				return returnPage;
			}

			// 예약 임시 테이블 조회
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("coDiv"		, coDiv);
			map.put("serialNo"	, serialNo);
			map.put("msNum"		, sessionVO.getMsNum());
			DrBkHistoryTemp temp = drBkHistoryTempService.getHistory(map);

			if (temp != null) {
	
				model.addAttribute("bkHis", temp);
				
				// 날짜 포맷 변경
				String tmpDay = temp.getBkDay();	// 20230131			
				String bkDay = tmpDay.substring(0, 4) + "년 " 
							+ tmpDay.substring(4, 6) + "월 " 
							+ tmpDay.substring(6) + "일" ;
				model.addAttribute("bkDay", bkDay);
				// end.
							
				// 지점 정보 조회 
				List<CoPlace> place = coPlaceService.selectList(map); 
				model.addAttribute("place", place.get(0));
				// end.
				
				// 베이 정보 조회
				map.put("bayCondi",temp.getBayCd());
				List<DrBayInfo> bay = drBayInfoService.selectList(map);
				model.addAttribute("bay", bay.get(0));
				// end.
				
				// 해당 날짜의 요금 조회
				Integer amount = 0;
				map.put("bkDay", temp.getBkDay());
				Map<String, Object> cost = drCostInfoService.getCostInfo(map);

				model.addAttribute("timeAmt", cost.get("DR_AMOUNT").toString());	// 시간당 금액 (이용권1장 = 시간당금액)
				if (temp.getBkTime().indexOf(",") > 0) {
					String[] strArr = temp.getBkTime().split(",");	
					amount = Integer.parseInt(cost.get("DR_AMOUNT").toString());
					amount = amount * strArr.length;
					model.addAttribute("amount", amount);
				} else {
					amount = Integer.parseInt(cost.get("DR_AMOUNT").toString());
					model.addAttribute("amount", amount);
				}
				// end.
				
				// 이용권 내역 조회
				List<Map<String, Object>> vList = drVoucherSaleService.selectList(map);
				model.addAttribute("vcList", vList);
				
				for (Map<String, Object> vou : vList) {
					log.debug("[book2] 사용가능한 이용권 : " + vou);
					
					int dayLimitCnt = vou.get("VC_DAY_LIMIT_CNT") == null 
							? 0 : Integer.parseInt(vou.get("VC_DAY_LIMIT_CNT").toString());

					log.debug("[book2] dayLimitCnt : " + dayLimitCnt);
					if (dayLimitCnt > 0) {
						// 일 제한 횟수값이 있는 경우만..
						
						log.debug("[book2] 이용권명 : {}, dayLimitCnt : {}", vou.get("VC_NAME"), dayLimitCnt);
						
						Map<String, Object> vMap = new HashMap<String, Object>();
						vMap.put("bkDay", tmpDay);
						vMap.put("msNum", sessionVO.getMsNum());
						vMap.put("vcCd", vou.get("VC_CD"));
						List<Map<String, Object>> chkList = drBkHistoryService.voucherUseCount(vMap);

						log.debug("[book2] 해당 이용권으로 같은날에 예약된 데이터 있는지 : {}", chkList);
						
						if (dayLimitCnt <= chkList.size()) {
							log.debug("[book2] 해당 이용권 일제한 횟수 초과로 더이상 예약불가");
							vou.put("voucherUseYn", "N");
						}
					
					}
					
				}
				// end.
				
				// 예약선점 시간 조회
				BookInfoVO bkInfo = new BookInfoVO();
				bkInfo.setCoDiv(coDiv);
				bkInfo.setBkDay(temp.getBkDay());
				if (temp.getBkTime2().indexOf(",") > 0) {
					String tmpBkTime[] = temp.getBkTime2().split(",");
					bkInfo.setBkTime(tmpBkTime[0]);
				} else {
					bkInfo.setBkTime(temp.getBkTime2());
				}
				bkInfo.setMsId(sessionVO.getMsId());
				bkInfo.setIpAddr(ipAddr);
				List<DrBkMark> mList = drBkMarkService.selectList(bkInfo);
				
				if (mList.size() > 0) {
					model.addAttribute("markData", mList.get(0));	
				}			
				// end.
				
				// 베이 이용시간&정리시간 조회
				BookInfoVO bkInfo2 = new BookInfoVO();
				bkInfo2.setCoDiv(coDiv);
				bkInfo2.setBayCondi(temp.getBayCd());
				bkInfo2.setBkDay(temp.getBkDay());
				List<DrBkTime> bkTimeList = drBkTimeService.getBkTime(bkInfo2);
				model.addAttribute("useTime", bkTimeList.get(0).getBkUseTime());	// 이용시간
				model.addAttribute("gapTime", bkTimeList.get(0).getBkGapTime());	// 정리시간
				// end.
			}

		} catch(Exception e) {
			e.printStackTrace();
		}

		return returnPage;
	}
	
	/**
	 * 예약 캘린더에 표출할 데이터 조회 
	 * 
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("/getCalendar")  
	@ResponseBody
	public List<Map<String, Object>> getCalendar(Model model, HttpServletRequest req) {
		HttpSession session = req.getSession();
		SessionVO sessionVO = (SessionVO) session.getAttribute("msMember");
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		try {
			if (sessionVO == null) return list;
				
			Map<String, Object> cMap = new HashMap<String, Object>();

			cMap.put("coDiv"		, req.getParameter("coDiv"));
			cMap.put("bayCondi"		, req.getParameter("bayCondi"));
			cMap.put("selYM"		, req.getParameter("selYM"));
			cMap.put("msLevel"		, req.getParameter("msLevel"));
			
			if (req.getParameter("bayCondi").toString().equals("")) {				
				// 기본 달력
				list = clDayInfoService.selectBasicList(cMap); 
			} else {
				// 지점, 베이, 회원등급에 따른 달력 조회 
				list = clDayInfoService.selectList(cMap); 
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}

		return list;
	}
	
	/**
	 * [예약] 예약내역 페이지
	 * 
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("/bookList/{coDiv}")  
	public String bookList(Model model, HttpServletRequest req, @PathVariable String coDiv) {
		HttpSession session = req.getSession();
		SessionVO sessionVO = (SessionVO) session.getAttribute("msMember");
		String returnPage =  "/book/bookList";
		
		try {
			if (sessionVO == null) return returnPage;

			model.addAttribute("coDiv", coDiv);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return returnPage;
	}
	

	/**
	 * [예약] 예약내역 조회 + 더보기 
	 * 
	 * @param model
	 * @param req
	 * @param coDiv
	 * @return
	 */
	@RequestMapping("/searchBookList/{coDiv}")  
	@ResponseBody
	public List<Map<String, Object>> searchBookList(Model model, HttpServletRequest req, @PathVariable String coDiv) {
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
				String strtDt 	= req.getParameter("strtDt").toString();
				String endDt 	= req.getParameter("endDt").toString();
				
				map.put("strtDt"	, strtDt.replace("-", ""));
				map.put("endDt"		, endDt.replace("-", ""));
				map.put("srchPeriod", req.getParameter("srchPeriod"));
			}
			
			// searchType > 전체 : 1, 지난예약 : 2, 예약내역(취소제외) : 3
			if (req.getParameter("searchType") != null) {
				map.put("searchType", req.getParameter("searchType"));
			}
		
			map.put("msNum", sessionVO.getMsNum());
			map.put("coDiv", coDiv);
			list = drBkHistoryService.selectBkHis(map);		
			
			log.debug("==>" + list);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	
	/**
	 * [예약] 결제 완료 페이지 
	 * 
	 * @param model
	 * @param req
	 * @return
	 */
	@RequestMapping("/bookConfirm")  
	public String bookConfirm(Model model, HttpServletRequest req) {
		HttpSession session = req.getSession();
		SessionVO sessionVO = (SessionVO) session.getAttribute("msMember");
		String returnPage = "/book/bookConfirm";
		
		try {
			if (sessionVO == null) return returnPage;

			Map<String, Object> param = new HashMap<String, Object>();
			param.put("msNum", sessionVO.getMsNum());
			String calcSerialNo = drBkHistoryService.selectCalcSNo(param);
			
			// 대표 예약고유번호로 데이터 조회 
			param.put("calcSerialNo", calcSerialNo);
			
			// 예약정보 
			List<Map<String, Object>> list = drBkHistoryService.selectBkHis(param);
			if (list.size() > 0) model.addAttribute("bk", list.get(0));

		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return returnPage;
	}
	
	/**
	 * 베이별 잔여시간 조회
	 * - 파라미터 : 베이, 날짜, 회원등급 등
	 * 
	 * @param req
	 * @param params
	 * @return
	 */
	@RequestMapping("/bookAvailableTime")
	@ResponseBody
	public List<DrBkTime> bookAvailableTime(HttpServletRequest req, @RequestParam Map<String, Object> params){
		
		List<DrBkTime> timeList = new ArrayList<DrBkTime>();
		
		try {
			log.info("[bookAvailableTime] 예약시간 조회 > params:" + params);
			timeList = drBkTimeService.bookAvailableTime(params);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return timeList;
	}
	
	/**
	 * 예약(결제)취소  
	 * 
	 * @param model
	 * @param req
	 * @param bInfo
	 * @return
	 */
	@RequestMapping("/bookCancel")  
	@ResponseBody
	public ResultVO bookCancel(Model model, HttpServletRequest req, BookInfoVO bInfo) {

		HttpSession session = req.getSession();
		SessionVO sessionVO = (SessionVO) session.getAttribute("msMember");
    	ResultVO result = new ResultVO();
		String ipAddr = Utils.getClientIpAddress(req);
    
		try {
			bInfo.setMsId(sessionVO.getMsId());
			bInfo.setPhone(sessionVO.getFullMsPhone());
			bInfo.setIpAddr(ipAddr);
			result = bookService.bookCancel(bInfo);
		} catch(Exception e) {
			e.printStackTrace();
			result.setCode("9999");
			result.setMessage("처리중 오류가 발생하였습니다.");
		}

		return result;
	}
	
	/**
	 * 예약 선점해제
	 * 
	 * @param req
	 * @param params
	 * @return
	 */
	@RequestMapping("/unBkMark")
	@ResponseBody
	public ResultVO unBkMark(HttpServletRequest req, BookInfoVO bookInfo){
		HttpSession session = req.getSession();
		SessionVO sessionVO = (SessionVO) session.getAttribute("msMember");
    	ResultVO result = new ResultVO();
    	
		try {
			bookInfo.setMsId(sessionVO.getMsId());
			result = bookService.unBkMarkLogic(bookInfo);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	/**
	 * 예약선점 테이블 조회
	 * 
	 * @param req
	 * @param params
	 * @return
	 */
	@RequestMapping("/getMark")
	@ResponseBody
	public DrBkMark getMark(HttpServletRequest req, BookInfoVO bkInfo){
		HttpSession session = req.getSession();
		SessionVO sessionVO = (SessionVO) session.getAttribute("msMember");
		DrBkMark drBkMark = new DrBkMark();
		
		try {
			bkInfo.setMsId(sessionVO.getMsId());
			List<DrBkMark> list = drBkMarkService.selectList(bkInfo);
			
			if (list.size() > 0) drBkMark = list.get(0);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return drBkMark;
	}	
	
	/**
	 * 예약취소 페이지로 이동
	 * > 이용권으로만 결제한 경우 부분취소가능하게 해달라고해서 추가되었음 - 배은화 (20231212)
	 *  
	 * @param model
	 * @param req
	 * @param coDiv
	 * @param serialNo
	 * @return
	 */
	@RequestMapping("/cancelBook/{coDiv}/{calcSerialNo}")  
	public String cancelBook(Model model, HttpServletRequest req, @PathVariable String coDiv, @PathVariable String calcSerialNo) {
		
		HttpSession session = req.getSession();
		SessionVO sessionVO = (SessionVO) session.getAttribute("msMember");
		
		try {
			
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("coDiv", coDiv);
			param.put("msNum", sessionVO.getMsNum());
			param.put("calcSerialNo", calcSerialNo);
			param.put("bkState", 1);
			List<Map<String, Object>> bkList = drBkHistoryService.selectBkDetail(param);
			model.addAttribute("bkList", bkList);
			model.addAttribute("bkListSize", bkList.size());
			
			List<Map<String, Object>> bkData = drBkHistoryService.selectBkHis(param);
			model.addAttribute("bkData", bkData.get(0));
			
			// 날짜 포맷 변경
			String tmpDay = bkData.get(0).get("BK_DAY").toString();	// 20230131			
			String bkDay = tmpDay.substring(0, 4) + "년 " 
						+ tmpDay.substring(4, 6) + "월 " 
						+ tmpDay.substring(6) + "일" ;
			model.addAttribute("bkDay", bkDay);
			// end.

		} catch(Exception e) {
			e.printStackTrace();
		}

		return "/book/cancelBook";
	}
	
}
