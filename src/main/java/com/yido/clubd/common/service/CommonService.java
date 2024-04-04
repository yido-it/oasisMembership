package com.yido.clubd.common.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mysql.cj.log.Log;
import com.yido.clubd.common.repository.CommonMapper;
import com.yido.clubd.model.CdCommon;
import com.yido.clubd.model.DrPromotionMark;
import com.yido.clubd.model.PrmInfoVO;
import com.yido.clubd.repository.PromotionLogMapper;
import com.yido.clubd.repository.PromotionMapper;
import com.yido.clubd.service.VoucherService;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service("CommonService")
public class CommonService {
	
	@Autowired
	private CommonMapper commonMapper;
	
	@Autowired
    private PromotionLogMapper prmLogMapper;

	@Autowired
    private PromotionMapper prmMapper;
	
//	public List<Map<String, Object>> getCommonCode(Map<String, Object> params) throws Exception {
//		return commonMapper.getCommonCode(params);
//	}
	
    public CdCommon getCommonCode(CdCommon cdCommon) {
    	return commonMapper.getCommonCode(cdCommon);
    }

    public List<CdCommon> getCommonCodeList(CdCommon cdCommon) {
    	return commonMapper.getCommonCodeList(cdCommon);
    }
    
    public List<CdCommon> getCommonCodeDetailList(CdCommon cdCommon) {
    	return commonMapper.getCommonCodeDetailList(cdCommon);
    }
    
	public List<Map<String, Object>> getAddrList(Map<String, Object> params) {
		return commonMapper.getAddrList(params);
	}
    
	public void savePushKey(Map<String, Object> params) throws Exception {
		commonMapper.savePushKey(params);
	}

	public void sendSms(Map<String, Object> params) throws Exception {
		commonMapper.sendSms(params);
	}

	public void actionAgree(Map<String, Object> params) throws Exception {
		commonMapper.actionAgree(params);
	}
	
	/**
	 * 템블릿 조회
	 * 
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public String getTemplateContent(Map<String, Object> params) throws Exception {
		return commonMapper.getTemplateContent(params);
	}

	/**
	 * 프로모션 선점 테이블 로그 기록
	 * 
	 * @param pmInfo
	 * @param param
	 * @throws Exception
	 */
	public void insPrmMarkLog(PrmInfoVO pInfo) throws Exception {
		
		log.info("[insPrmMarkLog] pInfo : {}", pInfo);
		
		PrmInfoVO pmInfo = new PrmInfoVO();
		pmInfo.setCoDiv(pInfo.getCoDiv());
		pmInfo.setPmDivision(pInfo.getPmDivision());
		pmInfo.setPmSerialNo(pInfo.getPmSerialNo());
		pmInfo.setMarkSeq(pInfo.getMarkSeq());
		
		List<DrPromotionMark> prmMarkList = prmMapper.selectMarkList(pmInfo);
		DrPromotionMark prmMark = prmMarkList.get(0);
		log.info("[insPrmMarkLog] prmMark : {}", prmMark);
		
		prmMark.setInputIp(pInfo.getIpAddr());			
		prmMark.setLogDiv("U");
		int insCnt = prmLogMapper.insertPrmMarkLog(prmMark);

		log.info("[insPrmMarkLog] insCnt : {}", insCnt);
		
	}
}
