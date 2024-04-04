package com.yido.clubd.repository;

import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.yido.clubd.model.MnInHistory;

/**
 * 입금내역
 * 
 * @author bae
 *
 */
@Mapper
@Repository
public interface MnInHistoryMapper {

	public int getMnSeq(Map<String, Object> params);

	public MnInHistory getMnInHistory(MnInHistory mnInHistory);
	
	// 입금내역 등록
	public int insertMnInHistory(Map<String, Object> params);
	
	// 입금내역 변경
	public int updateMnInHistory(Map<String, Object> params);
	
	// MN_CANCEL_YN = 'Y' 로 변경
	public int updateMnCancelYn(Map<String, Object> params);
	
	// MnSerialNo 변경 
	public int updateMnSerialNo(Map<String, Object> params);
	
	// 카드사 정보조회
	public Map<String, Object> selectCardInfo(Map<String, Object> params);
	
}
