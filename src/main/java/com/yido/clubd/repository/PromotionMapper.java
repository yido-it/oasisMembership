package com.yido.clubd.repository;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.yido.clubd.model.DrPromotion;
import com.yido.clubd.model.DrPromotionList;
import com.yido.clubd.model.DrPromotionMark;
import com.yido.clubd.model.DrPromotionMnMap;
import com.yido.clubd.model.PrmInfoVO;

/**
 * 프로모션 관련 
 * 
 * @author bae
 *
 */
@Mapper
@Repository
public interface PromotionMapper {

	// 중복접수에 대한 순번 채번
	public int getListSeq(Map<String, Object> param);
	
	// 프로모션 신청인원 조회
	public int getApplyCnt(Map<String, Object> param);
	
	public List<DrPromotion> selectList(Map<String, Object> param);
	
	public DrPromotion getPromotion(Map<String, Object> param);
	
	public DrPromotionList getPrmList(DrPromotionList dpList);
	
	// 프로모션 신청 내역 조회 
	public List<Map<String, Object>> applyList(Map<String, Object> param);
	
	// 프로모션 신청 내역 1건 조회 
	public Map<String, Object> getApplyInfo(Map<String, Object> param);
	
	// 프로모션 입금 연결 정보 조회
	public DrPromotionMnMap getMnMap(PrmInfoVO pInfo);
	
	// 프로모션 접수내역 insert
	public int insertPromotionList(DrPromotionList dpList);

	// 프로모션 입금 연결 정보 insert
	public int insertPromotionMnMap(DrPromotionMnMap dpMap);
	
	// 접수내역 삭제
	public int deletePrmList(PrmInfoVO pInfo);
	
	// 프로모션 선점 테이블에서 신청 가능한 데이터 조회하기 
	public List<DrPromotionMark> selectAvailableData(PrmInfoVO pInfo);
	
	// 프로모션 선점 처리 
	public int updatePrmMark1(Map<String, Object> param);
	
	// 선점테이블 데이터 변경 (신청완료되었을때)
	public int updatePrmMark2(PrmInfoVO pInfo);

	// 선점해제
	public int updatePrmUnMark(PrmInfoVO pInfo);
	
	// 프로모션 선점 테이블  조회
	public List<DrPromotionMark> selectMarkList(PrmInfoVO pInfo);
	
	// 프로모션 신청내역 MARK_SEQ 변경 - 배은화 (2023-07-10)
	public int updatePrmList(PrmInfoVO pInfo);
	
	// 프로모션 수량 변경 - 배은화 (2023-07-17)
	public int updRemCount(PrmInfoVO pInfo);
	
}
