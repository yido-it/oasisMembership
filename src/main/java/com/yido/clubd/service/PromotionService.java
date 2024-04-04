package com.yido.clubd.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.yido.clubd.common.repository.CommonMapper;
import com.yido.clubd.common.service.CommonService;
import com.yido.clubd.common.utils.ResultVO;
import com.yido.clubd.common.utils.SessionVO;
import com.yido.clubd.common.utils.Utils;
import com.yido.clubd.model.CdCommon;
import com.yido.clubd.model.DrPromotion;
import com.yido.clubd.model.DrPromotionList;
import com.yido.clubd.model.DrPromotionMark;
import com.yido.clubd.model.DrPromotionMnMap;
import com.yido.clubd.model.DrVoucherSale;
import com.yido.clubd.model.MnInHistory;
import com.yido.clubd.model.PrmInfoVO;
import com.yido.clubd.repository.DrVoucherSaleLogMapper;
import com.yido.clubd.repository.MnInHistoryMapper;
import com.yido.clubd.repository.PromotionLogMapper;
import com.yido.clubd.repository.PromotionMapper;

import lombok.extern.slf4j.Slf4j;

/**
 * 프로모션관련
 * 
 * @author bae
 *
 */
@Slf4j
@Service
public class PromotionService {

	@Autowired
    private PromotionMapper prmMapper;

	@Autowired
    private MnInHistoryMapper mnInHisMapper;
	
	@Autowired
    private CommonMapper cdCommonMapper;

	@Autowired
    private PromotionLogMapper prmLogMapper;
	
	@Autowired
    private MnInHistoryService mnInHisService;

	@Autowired
    private CommonService commonService;
	
	/**
	 * 프로모션 신청인원 조회
	 * 
	 * @param map
	 * @return
	 */
    public int getApplyCnt(Map<String, Object> map) {
    	return prmMapper.getApplyCnt(map);
    }
    
	/**
	 * 프로모션 조회 
	 * 
	 * @param map
	 * @return
	 */
    public List<DrPromotion> selectList(Map<String, Object> map) {
    	return prmMapper.selectList(map);
    }

	/**
	 * 프로모션 상세 
	 * 
	 * @param map
	 * @return
	 */
    public DrPromotion getPromotion(Map<String, Object> map) {
    	return prmMapper.getPromotion(map);
    }
    
	/**
	 * 프로모션 신청 내역 조회 
	 * 
	 * @param map
	 * @return
	 */
    public List<Map<String, Object>> applyList(Map<String, Object> map) {
    	return prmMapper.applyList(map);
    }

	/**
	 * 프로모션 신청 내역 1건
	 * 
	 * @param map
	 * @return
	 */
    public Map<String, Object> getApplyInfo(Map<String, Object> map) {
    	return prmMapper.getApplyInfo(map);
    }
    
	/**
	 * 프로모션 선점 테이블  조회
	 * 
	 * @param pInfo
	 * @return
	 */
	public List<DrPromotionMark> selectMarkList(PrmInfoVO pInfo) {
    	return prmMapper.selectMarkList(pInfo);
	}

	/**
	 * 프로모션 선점 테이블에서 신청 가능한 데이터 조회하기 
	 *  
	 * @param pInfo
	 * @return
	 */
	public List<DrPromotionMark> selectAvailableData(PrmInfoVO pInfo) {
    	return prmMapper.selectAvailableData(pInfo);
	}

    /**
     * 프로모션 결제  
     * -> 프로모션 접수내역 insert, 프로모션 입금 연결 정보 insert
     * -> SMS전송
     * 
     * @param param
     * @param session
     * @return
     * @throws Exception
     */
	@Transactional
	public Map<String, Object> insertPromotion(@RequestParam Map<String, Object> param, SessionVO session) throws Exception {

		Map<String, Object> returnMap = new HashMap<String, Object>();

		/*
		 * {ipAddr=10.10.85.85, SERVICE_CODE=0900, SERVICE_ID=glx_api, ORDER_ID=123456789177_20230328141518
		 * , ORDER_DATE=20230328141518, coDiv=001, mnInDay=20230328, mnRevAmount=50000, mnInAmount=50000, mnChangeAmount=0
		 * , mnInNo=52414400****085*, mnCardApproval=28141541, mnMonth=0, mnAppDate=20230328, cardCompanyCode=0084
		 * , orderId=123456789177_20230328141518, transactionId=2023032814TT007525
		 * , cancelKey=9fe782d4e24a8f82b19cb0289f0be8c935d1041b, mnCancelYn=N, mnCardDiv=914, mnCardName=씨티
		 * , mnSeq=00000000008, msNum=123456789177, pmSerialNo=P00000000001, pmDivision=001, msLevel=11
		 * , bkName=테스트, userMail=null, phone=null, msId=test}
		 * */
		
		String coDiv 		= param.get("coDiv").toString();
		String pmDivision 	= param.get("pmDivision").toString();
		String pmSerialNo 	= param.get("pmSerialNo").toString();
		String msNum		= session.getMsNum();
		String content		= param.get("content").toString();
		String mnInDay		= param.get("mnInDay").toString();
		int mnInAmount		= Integer.parseInt(param.get("mnInAmount").toString());
		int mnSeq			= Integer.parseInt(param.get("mnSeq").toString());

		// 중복접수에 대한 순번 채번
		int listSeq = prmMapper.getListSeq(param);
		
		// PG 결제내역 등록
		if (param.get("mnSeq") != null ) {
			
			// mnMonth, mnSerialNo 추가 - 배은화 (2023-07-10)
			param.put("saleSeq"   	, listSeq);
			param.put("mnMonth"		, "00");	
			param.put("mnSerialNo"  , pmSerialNo);
	        param.put("mnSeq"		, param.get("mnSeq"));
	        param.put("msNum"		, session.getMsNum());
	        param.put("mnInName"	, session.getMsName());		// 결제자 이름
	 
	        mnInHisMapper.insertMnInHistory(param);
		}
        // end.
		
		// 프로모션 접수내역 insert 
		DrPromotionList dpList = new DrPromotionList();
		// useName, markseq, remCount 추가 - 배은화 (2023-07-10)
		dpList.setUseName(session.getMsName());
		dpList.setPmRemCount(Integer.parseInt(param.get("pmUseCount").toString()));
		dpList.setCoDiv(coDiv);
		dpList.setPmDivision(pmDivision);
		dpList.setPmSerialNo(pmSerialNo);
		dpList.setMsNum(msNum);
		dpList.setListSeq(listSeq);
		dpList.setCustomerNotice(content);
		dpList.setInputIp(param.get("ipAddr").toString());
		
		prmMapper.insertPromotionList(dpList);
		
		DrPromotionList dpList2 = prmMapper.getPrmList(dpList);
		dpList2.setLogDiv("I");
		prmLogMapper.insPrmListLog(dpList2);
		// end.
		
		// 프로모션 입금 연결 정보 insert
		DrPromotionMnMap dpMap = new DrPromotionMnMap();
		dpMap.setCoDiv(coDiv);
		dpMap.setPmDivision(pmDivision);
		dpMap.setPmSerialNo(pmSerialNo);
		dpMap.setMsNum(msNum);
		dpMap.setListSeq(listSeq);
		dpMap.setMnInDay(mnInDay);
		dpMap.setMnSeq(mnSeq);
		dpMap.setMnCoDiv(coDiv);
		dpMap.setMnAmount(mnInAmount);
		//log.info("[insertPromotion] 프로모션 입금 연결 정보 : " + dpMap);
		prmMapper.insertPromotionMnMap(dpMap);
		
		// 해당 아이디로 선점한거 가져오기 (MARK_SEQ 필요함)
		PrmInfoVO pInfo = new PrmInfoVO();
		pInfo.setCoDiv(coDiv);
		pInfo.setPmDivision(pmDivision);
		pInfo.setPmSerialNo(pmSerialNo);
		pInfo.setMsId(session.getMsId());
		pInfo.setMsNum(session.getMsNum());
		pInfo.setIpAddr(param.get("ipAddr").toString());
		pInfo.setMarkState("N");
		
		List<DrPromotionMark> markList = prmMapper.selectMarkList(pInfo);
		log.info("[insertPromotion] 해당 아이디로 선점한거 조회 > 결과 : {}", markList);
		// end.
		if (markList != null && markList.size() > 0) {
			pInfo.setMarkSeq(markList.get(0).getMarkSeq());
			pInfo.setListSeq(listSeq);
			
			// 선점 테이블 변경 (LIST_SEQ, MS_NUM)  
			int updMark = prmMapper.updatePrmMark2(pInfo);	

			// 선점 테이블 로그
			commonService.insPrmMarkLog(pInfo);
			
			// 프로모션 신청내역 MARK_SEQ 변경
			int updList = prmMapper.updatePrmList(pInfo);
			
			log.info("[insertPromotion] 선점테이블 변경건수: {}, 신청내역 변경건수: {}", updMark, updList);
		}
		
		// 수량 증가 시키기 - 배은화 (2023-07-17)
		pInfo.setAddRemCnt("Y");
		prmMapper.updRemCount(pInfo);
		// end.
		
		// ┌───────────────── SMS 전송 ─────────────────┐
		String eventFromDay = param.get("eventFromDay").toString();	// 행사시작일
		/*
		String eventEndDay 	= param.get("eventEndDay").toString();	// 행사종료일
		String eventDay 	= ""; 									// 문자에 들어갈 행사일
		
		if (eventFromDay.equals(eventEndDay)) {
			// [시작일 = 종료일] 같으면 '시작일'만 사용
			eventDay = eventFromDay;
		} else {
			eventDay = eventFromDay + "~" + eventEndDay;
		}*/
		
		Map<String, Object> smsParam = new HashMap<String, Object>();
		smsParam.put("coDiv"		, coDiv);
		smsParam.put("tplCd"		, "10030");	 
		smsParam.put("msPhone"		, session.getFullMsPhone());
		smsParam.put("msName"		, session.getMsName());

		// 문자 보낼때 무조건 행사시작일로 보내도록 변경 (이원경 과장님 요청) - 배은화 (2023-05-11) 
		smsParam.put("bkDay"		, eventFromDay);			// 행사일자
		// smsParam.put("bkDay"		, eventDay);				// 행사일자
		
		smsParam.put("bayName"		, param.get("pmName"));	// 프로모션명
		smsParam.put("msPassword"	, mnInAmount+"원");		// 결제금액
		log.debug("프로모션 결제 SMS 전송 > param:" + smsParam);
		commonService.sendSms(smsParam);  		      		
		// └───────────────── SMS 전송 ─────────────────┘
		
		return returnMap;
	}
	
	/**
	 * 프로모션 취소 
	 * - 결제 취소
	 * - 신청 취소 
	 * 
	 * @param bInfo
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public ResultVO prmCancel(PrmInfoVO pInfo) throws Exception {	
		ResultVO resultVO = new ResultVO();
		
		// 프로모션 입금연결 테이블(DR_PROMOTION_MN_MAP) 조회해서 [MN_IN_HISTORY]의 MN_SEQ 획득
		DrPromotionMnMap mnMap = new DrPromotionMnMap();
		mnMap = prmMapper.getMnMap(pInfo);
		// end.
		
		// 입금테이블 조회
		MnInHistory mnHis = new MnInHistory();
		mnHis.setMnSeq(mnMap.getMnSeq());
		mnHis.setMnInDay(mnMap.getMnInDay());
		mnHis = mnInHisMapper.getMnInHistory(mnHis);
		// log.debug("[prmCancel] mnHis > " + mnHis);
		// end.
		
		String orderId = mnHis.getOrderId();
		String authAmount = String.valueOf(mnHis.getMnInAmount());
		String transactionId = mnHis.getTransactionId();
		String cancelKey = mnHis.getCancelkey();
		String ipAddr = pInfo.getIpAddr();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("coDiv"		, pInfo.getCoDiv());
		map.put("orderId"	, orderId);
		int mnSeq = mnInHisMapper.getMnSeq(map);
		
		log.info("[prmCancel] 주문번호(orderId): {}, 승인금액: {}, 거래번호(transactionId): {}, 취소키: {}"
				, orderId, authAmount, transactionId, cancelKey);
		
		// PG 결제 취소 처리 
		Map<String, Object> cMap = new HashMap<String, Object>();
		cMap.put("coDiv"		, pInfo.getCoDiv());
		cMap.put("orderId"		, orderId);
		cMap.put("mnSeq"		, mnSeq);
		cMap.put("authAmount"	, authAmount);
		cMap.put("transactionId", transactionId);
		cMap.put("cancelKey"	, cancelKey);
		cMap.put("ipAddr"		, ipAddr);
		cMap.put("cancelType"	, "C");
		cMap.put("mnHis"		, mnHis);
		cMap.put("gubun"		, "PROMOTION");
		
		mnInHisService.cancelLogic(cMap);

		// PM_SERIAL_NO 로 프로모션 테이블 조회
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("pmSerialNo", pInfo.getPmSerialNo());
		DrPromotion prm = prmMapper.getPromotion(param);
		pInfo.setPmDivision(prm.getPmDivision());
		// end.
		
		// 프로모션 신청취소 
		pInfo.setMnSeq(mnSeq); 
		this.cancelPrm(pInfo, cMap, prm);
		
		// 수량 차감 시키기 - 배은화 (2023-07-17)
		pInfo.setMinusRemCnt("Y");
		prmMapper.updRemCount(pInfo);
		// end.
		
		return resultVO;
	}
	
	/**
	 *  프로모션 신청취소
	 * -> 접수내역 삭제처리
	 * -> 선점해제
	 * -> 입금연결정보 insert 
	 * -> SMS전송
	 * 
	 * @param pInfo
	 * @param session
	 * @param cMap
	 * @throws Exception
	 */
	@Transactional
	public void cancelPrm(PrmInfoVO pInfo, Map<String, Object> cMap, DrPromotion prm) throws Exception {	

		log.info("[cancelPrm] pInfo: {}", pInfo);

		MnInHistory mnHis = (MnInHistory) cMap.get("mnHis");
		int mnSeq = 0;
		if (cMap.get("mnSeq") != null) {
			mnSeq = Integer.parseInt(cMap.get("mnSeq").toString());
		}

		DrPromotionList dpList = new DrPromotionList();
		dpList.setPmSerialNo(pInfo.getPmSerialNo());
		dpList.setListSeq(pInfo.getListSeq());
		dpList = prmMapper.getPrmList(dpList);
		
		// 접수내역 삭제처리 (DEL_YN = 'N')
		prmMapper.deletePrmList(pInfo);
		
		// 접수내역 로그
		dpList.setLogDiv("D");
		prmLogMapper.insPrmListLog(dpList);
		// end.
		
		
		// 선점해제 
		// 해당 아이디로 예약 선점한거 가져오기 (MARK_SEQ 필요함)
		pInfo.setMarkState("N");
		List<DrPromotionMark> mList = prmMapper.selectMarkList(pInfo);
		// log.info("[cancelPrm] 해당 아이디로 선점한거 조회 > 결과 : {}", mList.get(0));
		// end.

		if (mList != null && mList.size() > 0) {
			log.info("[cancelPrm] 선점 데이터 > {}", mList.get(0));

			// 선점 해제 
			pInfo.setMarkSeq(mList.get(0).getMarkSeq());
			pInfo.setEntryUser(pInfo.getMsId()); 
			prmMapper.updatePrmUnMark(pInfo);

			// 선점 테이블 로그
			commonService.insPrmMarkLog(pInfo);
			
		}   
	
        // 프로모션 입금 연결 정보 insert
		DrPromotionMnMap dpMap = new DrPromotionMnMap();
		dpMap.setCoDiv(pInfo.getCoDiv());
		dpMap.setPmDivision(pInfo.getPmDivision());
		dpMap.setPmSerialNo(pInfo.getPmSerialNo());
		dpMap.setMsNum(pInfo.getMsNum());
		dpMap.setListSeq(pInfo.getListSeq());
		dpMap.setMnInDay(mnHis.getMnInDay());
		dpMap.setMnSeq(mnSeq);
		dpMap.setMnCoDiv(pInfo.getCoDiv());
		dpMap.setMnAmount(-mnHis.getMnInAmount());
		//log.info("[insertPromotion] 프로모션 입금 연결 정보 : " + dpMap);
		
		prmMapper.insertPromotionMnMap(dpMap);
        // end.
        
		// ┌───────────────── SMS 전송 ─────────────────┐
		String eventFromDay = prm.getPmEventFromDay();	// 행사시작일
		String pmName 		= prm.getMainPmName() != null ? prm.getMainPmName() : "";
		
		if (prm.getPmMainYn().equals("N") && prm.getPmRealYn().equals("Y")) pmName += " [" + prm.getPmName() + "]";
		
		/*
		String eventEndDay 	= prm.getPmEventEndDay();	// 행사종료일
		String eventDay 	= ""; 									// 문자에 들어갈 행사일
		
		if (eventFromDay.equals(eventEndDay)) {
			// [시작일 = 종료일] 같으면 '시작일'만 사용
			eventDay = eventFromDay;
		} else {
			eventDay = eventFromDay + "~" + eventEndDay;
		}*/
		Map<String, Object> smsParam = new HashMap<String, Object>();
		smsParam.put("coDiv"		, pInfo.getCoDiv());
		smsParam.put("tplCd"		, "10031");	 
		smsParam.put("msPhone"		, pInfo.getMsPhone());
		smsParam.put("msName"		, pInfo.getMsName());
		
		// 문자 보낼때 무조건 행사시작일로 보내도록 변경 (이원경 과장님 요청) - 배은화 (2023-05-11) 
		smsParam.put("bkDay"		, eventFromDay);				// 행사일자
		// smsParam.put("bkDay"		, eventDay);					// 행사일자
		
		smsParam.put("bayName"		, pmName);						// 프로모션명
		smsParam.put("msPassword"	, mnHis.getMnInAmount()+"원");	// 결제금액
		log.debug("프로모션 결제 SMS 전송 > param:" + smsParam);
		commonService.sendSms(smsParam);  		      		
		// └───────────────── SMS 전송 ─────────────────┘
		
	}
	
	/**
	 * 프로모션 선점
	 * 
	 * @param pInfo
	 * @return
	 * @throws Exception
	 */
	@Transactional
    public ResultVO prmMarking(PrmInfoVO pInfo) throws Exception  {
		ResultVO result = new ResultVO();
		log.info("[prmMarking] pInfo: {}", pInfo);	
		
		// 선점 데이터 조회
		List<DrPromotionMark> markList = prmMapper.selectAvailableData(pInfo);
		log.info("[prmMarking] 프로모션 코드: {} - 선점 테이블 조회 건수 > {}", pInfo.getPmSerialNo(), markList.size());
		
		if (markList == null || markList.size() == 0) {
			result.setCode("9999");
			result.setMessage("죄송합니다. 프로모션 신청 마감되었습니다.");	
			return result;
		} 
		// end.
		
		// 선점 시간 조회 ( 15분 )
		Map<String, Object> param = new HashMap<String, Object>();
		
		CdCommon common = new CdCommon();
		common.setCoDiv(pInfo.getCoDiv());
		common.setCdDivision("999");
		common.setCdCode("DRC03");
		common = cdCommonMapper.getCommonCode(common);
		Integer eTime = common != null && !common.getCdLength().equals("") ? 
				Integer.parseInt(common.getCdLength()) : 15;
		// end.
		
		param.put("stateIsYn"		, "Y");		// 예약가능한거 찾아서 선점처리 
		param.put("updMsId"			, pInfo.getMsId());		
		param.put("ipAddr"			, pInfo.getIpAddr());		
		param.put("entryTime"		, eTime);		
		param.put("coDiv"			, pInfo.getCoDiv());
		param.put("pmSerialNo"		, pInfo.getPmSerialNo());
		param.put("pmDivision"		, pInfo.getPmDivision());
		param.put("markSeq"			, markList.get(0).getMarkSeq());	
		
		// 선점 처리
		prmMapper.updatePrmMark1(param);
		
		// 선점 테이블 로그
		commonService.insPrmMarkLog(pInfo);
		
		result.setData(markList.get(0).getMarkSeq());
		return result;
	}
	
	/**
	 * 선점해제 
	 * 
	 * @param pInfo
	 * @return
	 * @throws Exception
	 */
	@Transactional
    public ResultVO prmUnMarkLogic(PrmInfoVO pInfo) throws Exception  {
    	ResultVO result = new ResultVO();

    	log.info("[prmUnMarkLogic] 프로모션 선점해제  > param: {}", pInfo);
		
    	try {
    	
    		// 해당 아이디로 예약 선점한거 가져오기 (MARK_SEQ 필요함)
    		pInfo.setMarkState("N");
    		List<DrPromotionMark> mList = prmMapper.selectMarkList(pInfo);
    		log.info("[prmUnMarkLogic] 해당 아이디로 선점한거 조회 > 결과 : {}", mList.get(0));
    		// end.
	
			if (mList != null && mList.size() > 0) {
    			log.info("[prmUnMarkLogic] 선점 데이터 > {}", mList.get(0));

    			// 선점 해제 
    			pInfo.setMarkSeq(mList.get(0).getMarkSeq());
    			pInfo.setEntryUser(pInfo.getMsId());
    			prmMapper.updatePrmUnMark(pInfo);
    			
    			// 선점 테이블 로그
    			commonService.insPrmMarkLog(pInfo);
    			
			}
		
		} catch(Exception e) {
			e.printStackTrace();
			result.setCode("9999");
			result.setMessage("서버와의 통신에 오류가 있습니다.");
		}	    	
    	return result;
	}
	
}
