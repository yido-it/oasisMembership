package com.yido.clubd.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.yido.clubd.common.service.CommonService;
import com.yido.clubd.common.utils.Globals;
import com.yido.clubd.common.utils.ResultVO;
import com.yido.clubd.common.utils.SessionVO;
import com.yido.clubd.common.utils.StringUtils;
import com.yido.clubd.common.utils.Utils;
import com.yido.clubd.model.BookInfoVO;
import com.yido.clubd.model.DrBkHistory;
import com.yido.clubd.model.DrBkHistoryTemp;
import com.yido.clubd.model.DrBkMnMap;
import com.yido.clubd.model.DrPromotion;
import com.yido.clubd.model.DrVoucherSale;
import com.yido.clubd.model.MnInHistory;
import com.yido.clubd.repository.DrBkHistoryMapper;
import com.yido.clubd.repository.DrBkHistoryTempMapper;
import com.yido.clubd.repository.DrBkMarkMapper;
import com.yido.clubd.repository.DrBkMnMapMapper;
import com.yido.clubd.repository.DrVoucherSaleMapper;
import com.yido.clubd.repository.MemberMapper;
import com.yido.clubd.repository.MnInHistoryMapper;

import lombok.extern.slf4j.Slf4j;

/**
 * 입금내역
 * 
 * @author bae
 *
 */
@Slf4j
@Service
public class MnInHistoryService {
	
	@Autowired
    private VoucherService voucherService;
	
	@Autowired
    private DrBkHistoryService drBkHistoryService;
	
	@Autowired
    private PromotionService promotionService;
	
	@Autowired
    private DrBkHistoryTempMapper drBkHistoryTempMapper;
	
	@Autowired
    private MemberMapper memberMapper;
	
	@Autowired
    private MnInHistoryMapper mnInHistoryMapper;
	
	@Autowired
    private DrVoucherSaleMapper drVoucherSaleMapper;

	public int getMnSeq(Map<String, Object> params) {
		return mnInHistoryMapper.getMnSeq(params);
	}
	
	public MnInHistory getMnInHistory(MnInHistory mnInHistory) {
		return mnInHistoryMapper.getMnInHistory(mnInHistory);
	}
	
	/**
	 * 입금내역 등록
	 * 
	 * @param params
	 * @return
	 
	public int insertMnInHistory(Map<String, Object> params) {
		return mnInHistoryMapper.insertMnInHistory(params);
	}*/

	/**
	 * 입금내역 변경
	 * 
	 * @param params
	 * @return
	 */
	public int updateMnInHistory(Map<String, Object> params) {
		return mnInHistoryMapper.updateMnInHistory(params);
	}

	/**
	 * 카드사 정보조회
	 * 
	 * @param params
	 * @return
	 */
	public Map<String, Object> selectCardInfo(Map<String, Object> params) {
		return mnInHistoryMapper.selectCardInfo(params);
	}
		
	
	/**
	 * PG 결제 성공 후 처리 로직..
	 * 
	 * @param params
	 * @param action	: 예약 or 이용권
	 * @param reserved 	: 결제 관련 정보 
	 * @param session 	
	 * @return
	 */
	@Transactional
	public ResultVO successPayLogic(Map<String, Object> params, String action, String reserved, HttpSession session) {	
		ResultVO resultVO = new ResultVO();
		Gson gson = new Gson();
		
		try {
			
	        Map<String, Object> tmpMap = new HashMap<String, Object>();
	        tmpMap.put("coDiv", params.get("coDiv").toString());
	        int mnSeq = this.getMnSeq(tmpMap);	// 입금 순번 채번
	        log.debug("입금순번 > mnSeq > " + mnSeq);
			params.put("mnSeq", mnSeq);
			
			String orderId = StringUtils.isNullOrEmpty(params.get("orderId"), "");	// 주문번호
			String msNum = orderId.split("_")[0];									// 회원번호
			
			params.put("msNum", msNum);

			SessionVO sessionVO = memberMapper.selectMsSession(params);
			if(sessionVO == null) {
				log.info("[successPayLogic] 회원정보가 존재하지 않음");
				//throw new Exception("회원정보가 존재하지 않습니다.");
				resultVO.setCode("9999");
				resultVO.setMessage("회원정보가 존재하지 않습니다.");
				return resultVO;
			}		
			
			if (session.getAttribute("msMember") == null) {
				session.setAttribute("msMember", sessionVO);
				session.setMaxInactiveInterval(60 * 60 * 24 * 30);
			}
			
			if(action.equals("RESERVATION")) {	// RESERVATION = 예약
				String isVoucherUse = "N";
				List<Map<String, Object>> vList = new ArrayList<Map<String, Object>>();
				BookInfoVO bkInfo = new BookInfoVO();				
				JSONObject data = new JSONObject(reserved.replaceAll("&quot;", "\""));
				
				params.put("bayName"		, Utils.getJsonValue(data, "bayName"));
				params.put("bayName2"		, Utils.getJsonValue(data, "bayName2"));
				params.put("bkDay"			, Utils.getJsonValue(data, "bkDay"));
				params.put("bkTime"			, Utils.getJsonValue(data, "bkTime"));
				params.put("bayCondi"		, Utils.getJsonValue(data, "bayCondi"));
				params.put("bkAmount"		, Utils.getJsonValue(data, "bkAmount"));		// 최종 결제금액
				params.put("oriBkAmount"	, Utils.getJsonValue(data, "oriBkAmount"));		// 결제금액 
				params.put("vList"			, Utils.getJsonValue(data, "vList"));			// vList : 이용권 고유번호, 이용권 금액, 사용수량 등
				params.put("serialNo"		, Utils.getJsonValue(data, "tempSerialNo"));	// tempSerialNo : 예약 임시테이블 고유번호 (결제 완료 후 임시테이블 데이터 삭제 해야함)											
				params.put("action"			, action);										// action > RESERVATION = 예약, VOUCHER = 이용권
				
				params.put("bkPayDiv"		, "2"); 										// 지불수단 > 선불
				params.put("mnPayDiv"		, "02"); 										// 지불수단 > 카드
				params.put("mnBeforeDiv"	, "A"); 										// 입금구분 > 선불
				
				// vList : 이용권  
				if (params.get("vList") != null) {
					vList = gson.fromJson(params.get("vList").toString(), new TypeToken<List<Map<String, Object>>>() {}.getType());			
					if (vList.size() > 0) isVoucherUse = "Y";
				}
			
				log.info("[successPayLogic] 예약정보 : " + params);
				
				// 예약 내역 insert 				
				Map<String, Object> returnMap = drBkHistoryService.actionReservation(params, sessionVO);
							
				if (isVoucherUse.equals("Y")) {
					// 이용권 사용처리 

					bkInfo.setVList(vList);
					bkInfo.setCoDiv(params.get("coDiv").toString());
					bkInfo.setIpAddr(params.get("ipAddr").toString());

					voucherService.useVoucher(bkInfo, returnMap, params);					
				} 

        		this.afterPayLogic(params);

			} else if(action.equals("VOUCHER")) {	// VOUCHER = 이용권
				JSONObject data = new JSONObject(reserved.replaceAll("&quot;", "\""));
				
				params.put("vcCd"			, Utils.getJsonValue(data, "vcCd"));
				params.put("vcAmount"		, Utils.getJsonValue(data, "vcAmount"));
				params.put("msLevel"		, sessionVO.getMsLevel());
				params.put("bkName"			, sessionVO.getMsName());
				params.put("userMail"		, sessionVO.getMsEmail());
				params.put("phone"			, sessionVO.getMsPhone());
				params.put("msId"			, sessionVO.getMsId());		
				
				params.put("mnPayDiv"		, "02"); 						// 지불수단 > 카드
				params.put("mnBeforeDiv"	, "9"); 						// 입금구분 > 이용권판매	
					
				log.info("[successPayLogic] 이용권 결제 정보 : " + params);
				
				// 이용권 구매 내역 insert 				
				voucherService.insertVouInfo(params, sessionVO);
								
			} else if(action.equals("PROMOTION")) {	// PROMOTION = 프로모션
				
				JSONObject data 	= new JSONObject(reserved.replaceAll("&quot;", "\""));

				String pmName 		=  data.has("pmName") ? Utils.getJsonValue(data, "pmName") : "";
				String content 		= data.has("content") ? Utils.getJsonValue(data, "content") : "";
				String pmSerialNo 	= Utils.getJsonValue(data, "pmSerialNo");

				params.put("pmSerialNo", pmSerialNo );
				DrPromotion prm = promotionService.getPromotion(params);
				
				// pmUseCount 추가 - 배은화 (2023-07-10)
				params.put("pmUseCount" 	, prm.getPmUseCount());
				params.put("pmDivision"		, prm.getPmDivision());
				
				if (pmName.equals("")) params.put("pmName", prm.getPmName());
				else params.put("pmName", pmName);
				
				params.put("eventFromDay"	, prm.getPmEventFromDay());	// 행사시작일
				params.put("eventEndDay"	, prm.getPmEventEndDay());	// 행사종료일
				params.put("content"		, content);
				params.put("msLevel"		, sessionVO.getMsLevel());
				params.put("bkName"			, sessionVO.getMsName());
				params.put("userMail"		, sessionVO.getMsEmail());
				params.put("phone"			, sessionVO.getMsPhone());
				params.put("msId"			, sessionVO.getMsId());			
				
				params.put("mnPayDiv"		, "02"); 						// 지불수단 > 카드
				params.put("mnBeforeDiv"	, "B"); 						// 입금구분 > 프로모션선불

				log.info("[successPayLogic] 프로모션 결제 정보 : " + params);
				
				// 프로모션 신청&결제 내역 insert 				
				promotionService.insertPromotion(params, sessionVO);
								
			}
		} catch (Exception e) {
			log.info("[successPayLogic] 결제 처리 중 오류 발생 > " + e.getMessage());
			e.printStackTrace();
			resultVO.setCode("9999");
			resultVO.setMessage(e.getMessage());
		}
		
		return resultVO;
	}

	/**
	 * 결제 완료 후 처리 
	 * - 예약 임시테이블 데이터 삭제
	 * 
	 * @param param
	 * @throws Exception
	 */
	public void afterPayLogic(Map<String, Object> param) throws Exception {

		// 예약 임시테이블 데이터 삭제
		DrBkHistoryTemp temp = new DrBkHistoryTemp();
		temp.setSerialNo(param.get("serialNo").toString());
		drBkHistoryTempMapper.deleteHistoryTemp(temp);
		// end.
		
	}
	
	/**
	 * PG 결제 취소 로직 
	 * - MN_IN_HISTORY insert 
	 * 
	 * @param cMap
	 * @return
	 */
    public boolean cancelLogic(Map<String, Object> cMap) { 
    	boolean resultValue = false;
    	
		String orderDate             = "";
		String cancelDate            = "";
		String partCancelAmount      = "";
		String seqNumber             = "";
		String responseCode          = "";
		String responseMessage       = "";
		String detailResponseCode    = "";
		String detailResponseMessage = "";
    	
    	BufferedReader br = null;

		try {
			String coDiv 			= cMap.get("coDiv").toString();
			String orderId 			= cMap.get("orderId").toString();
			String cancelAmount 	= cMap.get("authAmount").toString();
			String transactionId 	= cMap.get("transactionId").toString();
			String cancelType 		= cMap.get("cancelType").toString();
			String cancelKey 		= cMap.get("cancelKey").toString();
			//String gubun 			= cMap.get("gubun").toString();
			String ipAddr 			= cMap.get("ipAddr").toString();			
			String current 			= new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
			MnInHistory mnHis 		= (MnInHistory) cMap.get("mnHis");
			
			// onlyPgYn : Y인경우 PG사 결제취소만 처리함. DB는 X
			String onlyPgYn 		= cMap.get("onlyPgYn") != null ? cMap.get("onlyPgYn").toString() : "N";
			
	    	URL url = new URL(Globals.cancelUrl); 
	        Map<String, Object> params = new LinkedHashMap<>();
	        params.put("SERVICE_ID", Globals.serviceId);
	        params.put("SERVICE_CODE", "0900");
	        params.put("ORDER_ID", orderId);
	        params.put("ORDER_DATE", current);
	        params.put("CANCEL_AMOUNT", cancelAmount);
	        params.put("TRANSACTION_ID", transactionId);
	        params.put("CANCEL_TYPE", cancelType);
	        params.put("CANCEL_KEY", cancelKey);

	        params.put("ACCESS_TARGET", Globals.accessTarget);
	        params.put("HIDDEN_KEY", Globals.hiddenKey);
	        
	        StringBuilder postData = new StringBuilder();
	        for(Map.Entry<String,Object> param : params.entrySet()) {
	            if(postData.length() != 0) postData.append('&');
	            postData.append(URLEncoder.encode(param.getKey(), "EUC-KR"));
	            postData.append('=');
	            postData.append(URLEncoder.encode(String.valueOf(param.getValue()), "EUC-KR"));
	        }
	        byte[] postDataBytes = postData.toString().getBytes("EUC-KR");
	        
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        conn.setRequestProperty("Accept", "application/x-www-form-urlencoded xml");
	        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded; charset=EUC-KR");
	        conn.setRequestProperty("Accept-language", "gx");        
	        conn.setDoOutput(true);
	        conn.getOutputStream().write(postDataBytes);
	 
	        br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "EUC-KR"));
	 
	        StringBuffer sb = new StringBuffer();

	        String s = "";
	        while ((s = br.readLine()) != null) {
	            sb.append(s);
	        }
	    	
	        JSONObject result = new JSONObject(sb.toString());

	        log.info("=================== 취소 결과 시작 ===================");
	        log.info("가맹점 아이디 (SERVICE_ID) : " + Utils.getJsonValue(result, "SERVICE_ID"));
	        log.info("서비스코드 (SERVICE_CODE) : " + Utils.getJsonValue(result, "SERVICE_CODE"));
	        log.info("주문번호 (ORDER_ID) : " + Utils.getJsonValue(result, "ORDER_ID"));
	        log.info("주문일시 (ORDER_DATE) : " + Utils.getJsonValue(result, "ORDER_DATE"));
	        log.info("거래번호 (TRANSACTION_ID) : " + Utils.getJsonValue(result, "TRANSACTION_ID"));
	        log.info("전문코드 (COMMAND) : " + Utils.getJsonValue(result, "COMMAND"));
	        log.info("취소타입 (CANCEL_TYPE) : " + Utils.getJsonValue(result, "CANCEL_TYPE"));
	      
	        log.info("응답코드 (RESPONSE_CODE) : " + Utils.getJsonValue(result, "RESPONSE_CODE"));
	        log.info("응답메세지 (RESPONSE_MESSAGE) : " + Utils.getJsonValue(result, "RESPONSE_MESSAGE"));
	        log.info("상세응답코드 (DETAIL_RESPONSE_CODE) : " + Utils.getJsonValue(result, "DETAIL_RESPONSE_CODE"));
	        log.info("상세응답메세지 (DETAIL_RESPONSE_MESSAGE) : " + Utils.getJsonValue(result, "DETAIL_RESPONSE_MESSAGE"));               

	        if ( result.has("CANCEL_DATE") ) {
	        	log.info("취소일시 (CANCEL_DATE) : " + Utils.getJsonValue(result, "CANCEL_DATE"));
		        cancelDate = Utils.getJsonValue(result, "CANCEL_DATE");
	        }
	        if ( result.has("CANCEL_AMOUNT")) {
	        	log.info("취소금액 (CANCEL_AMOUNT) : " + Utils.getJsonValue(result, "CANCEL_AMOUNT"));
		        cancelAmount = Utils.getJsonValue(result, "CANCEL_AMOUNT");
	        }
	        
	        log.info("=================== 취소 결과 끝 ===================");

	        if (onlyPgYn.equals("Y")) {
	        	resultValue = true;
	        	return resultValue;
	        }
	        
	        orderId               = Utils.getJsonValue(result, "ORDER_ID");
	        orderDate             = Utils.getJsonValue(result, "ORDER_DATE");
	        transactionId         = Utils.getJsonValue(result, "TRANSACTION_ID");
	        cancelType            = Utils.getJsonValue(result, "CANCEL_TYPE");
	        responseCode          = Utils.getJsonValue(result, "RESPONSE_CODE");
	        responseMessage       = Utils.getJsonValue(result, "RESPONSE_MESSAGE");
	        detailResponseCode    = Utils.getJsonValue(result, "DETAIL_RESPONSE_CODE");
	        detailResponseMessage = Utils.getJsonValue(result, "DETAIL_RESPONSE_MESSAGE");
            
            params.put("coDiv"				, coDiv);
            params.put("mnInDay"			, cancelDate.substring(0,8));	// 취소일자
            params.put("mnSeq"				, this.getMnSeq(params)); 	 	// MN_IN_HISTORY 테이블 조회 (주문번호에 해당하는 마지막 mnSeq 조회)
            params.put("mnSerialNo"			, mnHis.getMnSerialNo());		// 이용권 매출 고유번호 
            params.put("mnBeforeDiv"		, mnHis.getMnBeforeDiv());		// 지불수단 
            params.put("mnPayDiv"			, mnHis.getMnPayDiv());			// 입금구분
        	params.put("mnInName"			, mnHis.getMnInName());			// 회원 명 
          	params.put("msNum"				, mnHis.getMsNum());			// 회원 번호 
            params.put("mnRevAmount"		, -Integer.parseInt(cancelAmount));			// 총입금액
            params.put("mnInAmount"			, -Integer.parseInt(cancelAmount));			// 결제금액
            params.put("mnChangeAmount"		, 0);							// 반환금액
            params.put("mnInNo"				, mnHis.getMnInNo());			// 카드번호
            params.put("mnCardApproval"		, mnHis.getMnCardApproval());	// 승인번호
            params.put("mnMonth"            , mnHis.getMnMonth());			// 할부개월수
            
            // 시분초까지 기록되도록 변경 - 배은화 (2023-07-10)
            // params.put("mnAppDate"		, cancelDate.substring(0,8));	// 승인일자
            params.put("mnAppDate"			, cancelDate);	// 승인일자
            
            params.put("mnCardDiv"			, mnHis.getMnCardDiv());		
            params.put("mnCardName"			, mnHis.getMnCardName());		

            params.put("mnCancelYn"			, "Y");							// 취소여부 
        	params.put("mnOriCoDiv"			, mnHis.getCoDiv());			// 원본 지점코드
        	params.put("mnOriInDay"			, mnHis.getMnInDay());			// 원본 입금일자
        	params.put("mnOriMnSeq"			, mnHis.getMnSeq());			// 원본 입금순번
        	
            params.put("orderId"			, orderId);						// 주문번호
            params.put("transactionId"		, transactionId);				// 거래번호
            params.put("ipAddr"             , ipAddr);
       
            log.debug("[cancelLogic] insertMnInHistory : " + params);
            int insMnHis = mnInHistoryMapper.insertMnInHistory(params);
            log.debug("[cancelLogic] insertMnInHistory > 결과값 : " + insMnHis);
            
            // 원본 데이터 MN_CANCEL_YN = 'Y' 로 변경 
            Map<String, Object> cParam = new HashMap<String, Object>();
            cParam.put("coDiv"	, mnHis.getCoDiv());
            cParam.put("mnInDay", mnHis.getMnInDay());
            cParam.put("mnSeq"	, mnHis.getMnSeq());

            log.debug("[cancelLogic] updateMnCancelYn : " + cParam);
            int updMnHis = mnInHistoryMapper.updateMnCancelYn(cParam);
            log.debug("[cancelLogic] updateMnCancelYn > 결과값 : " + updMnHis);
            // end.
            
            if( responseCode.equals("0000") ) {
            	resultValue = true;
            } else {
            	resultValue = false;
            }
		} catch(Exception e) {
			log.info("[cancelLogic] 취소 처리 중 오류 발생 > " + e.getMessage());
			resultValue = false;
			e.printStackTrace();
		} finally {
			try {
	            if (br != null) br.close();
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
		}
		
		return resultValue;
    }	

	
	/**
	 * PG 결제 취소 로직 
	 * - DB 테이블 건들이지 않고, PG 결제만 취소하는 경우 
	 * 
	 * @param coDiv
	 * @param orderId
	 * @param cancelAmount
	 * @param transactionId
	 * @param cancelType
	 * @param cancelKey
	 * @param ipAddr
	 * @return
	 */
    public boolean cancelPay(Map<String, Object> cMap) { 
    	// (String coDiv, String orderId, String cancelAmount
		// String transactionId, String cancelType, String cancelKey, String ipAddr, MnInHistory mnHis)
    	boolean resultValue = false;
    	
		String orderDate             = "";
		String cancelDate            = "";
		String partCancelAmount      = "";
		String seqNumber             = "";
		String responseCode          = "";
		String responseMessage       = "";
		String detailResponseCode    = "";
		String detailResponseMessage = "";
    	
    	BufferedReader br = null;

		try {
			String orderId 			= cMap.get("orderId").toString();
			String cancelAmount 	= cMap.get("authAmount").toString();
			String transactionId 	= cMap.get("transactionId").toString();
			String cancelType 		= cMap.get("cancelType").toString();
			String cancelKey 		= cMap.get("cancelKey").toString();
			String current 			= new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
			MnInHistory mnHis 		= (MnInHistory) cMap.get("mnHis");
			
	    	URL url = new URL(Globals.cancelUrl); 
	        Map<String, Object> params = new LinkedHashMap<>();
	        params.put("SERVICE_ID", Globals.serviceId);
	        params.put("SERVICE_CODE", "0900");
	        params.put("ORDER_ID", orderId);
	        params.put("ORDER_DATE", current);
	        params.put("CANCEL_AMOUNT", cancelAmount);
	        params.put("TRANSACTION_ID", transactionId);
	        params.put("CANCEL_TYPE", cancelType);
	        params.put("CANCEL_KEY", cancelKey);

	        params.put("ACCESS_TARGET", Globals.accessTarget);
	        params.put("HIDDEN_KEY", Globals.hiddenKey);
	        
	        StringBuilder postData = new StringBuilder();
	        for(Map.Entry<String,Object> param : params.entrySet()) {
	            if(postData.length() != 0) postData.append('&');
	            postData.append(URLEncoder.encode(param.getKey(), "EUC-KR"));
	            postData.append('=');
	            postData.append(URLEncoder.encode(String.valueOf(param.getValue()), "EUC-KR"));
	        }
	        byte[] postDataBytes = postData.toString().getBytes("EUC-KR");
	        
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("POST");
	        conn.setRequestProperty("Accept", "application/x-www-form-urlencoded xml");
	        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded; charset=EUC-KR");
	        conn.setRequestProperty("Accept-language", "gx");        
	        conn.setDoOutput(true);
	        conn.getOutputStream().write(postDataBytes);
	 
	        br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "EUC-KR"));
	 
	        StringBuffer sb = new StringBuffer();

	        String s = "";
	        while ((s = br.readLine()) != null) {
	            sb.append(s);
	        }
	    	
	        JSONObject result = new JSONObject(sb.toString());

	        log.info("=================== 취소 결과 시작 ===================");
	        log.info("가맹점 아이디 (SERVICE_ID) : " + Utils.getJsonValue(result, "SERVICE_ID"));
	        log.info("서비스코드 (SERVICE_CODE) : " + Utils.getJsonValue(result, "SERVICE_CODE"));
	        log.info("주문번호 (ORDER_ID) : " + Utils.getJsonValue(result, "ORDER_ID"));
	        log.info("주문일시 (ORDER_DATE) : " + Utils.getJsonValue(result, "ORDER_DATE"));
	        log.info("거래번호 (TRANSACTION_ID) : " + Utils.getJsonValue(result, "TRANSACTION_ID"));
	        log.info("전문코드 (COMMAND) : " + Utils.getJsonValue(result, "COMMAND"));
	        log.info("취소타입 (CANCEL_TYPE) : " + Utils.getJsonValue(result, "CANCEL_TYPE"));
	        log.info("취소일시 (CANCEL_DATE) : " + Utils.getJsonValue(result, "CANCEL_DATE"));
	        log.info("취소금액 (CANCEL_AMOUNT) : " + Utils.getJsonValue(result, "CANCEL_AMOUNT"));
	        log.info("응답코드 (RESPONSE_CODE) : " + Utils.getJsonValue(result, "RESPONSE_CODE"));
	        log.info("응답메세지 (RESPONSE_MESSAGE) : " + Utils.getJsonValue(result, "RESPONSE_MESSAGE"));
	        log.info("상세응답코드 (DETAIL_RESPONSE_CODE) : " + Utils.getJsonValue(result, "DETAIL_RESPONSE_CODE"));
	        log.info("상세응답메세지 (DETAIL_RESPONSE_MESSAGE) : " + Utils.getJsonValue(result, "DETAIL_RESPONSE_MESSAGE"));               
	        log.info("=================== 취소 결과 끝 ===================");

            if(responseCode.equals("0000")) {
            	resultValue = true;
            }
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
	            if (br != null) br.close();
	        } catch (IOException e) {
	            e.printStackTrace();
	        }
		}
		
		return resultValue;
    }	    
}
