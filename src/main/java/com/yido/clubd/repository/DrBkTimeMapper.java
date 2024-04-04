package com.yido.clubd.repository;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.yido.clubd.model.BookInfoVO;
import com.yido.clubd.model.DrBkMark;
import com.yido.clubd.model.DrBkTime;

/**
 * 예약타임
 * 
 * @author bae
 *
 */
@Mapper
@Repository
public interface DrBkTimeMapper {

	// DrBkTime 테이블 그대로 조회하는 용도 
	public DrBkTime getDrBkTime(Map<String, Object> map);
	
	// 베이별 잔여시간 조회 
	public List<DrBkTime> bookAvailableTime(Map<String, Object> map);
	
	public List<DrBkTime> getBkTime(BookInfoVO bkInfo);

	// [예약 타임] 테이블 데이터 변경 
	public int updateBkRemCount(Map<String, Object> map);
	
	// 로그테이블 기록 
	public int insertDrBkTimeLog(DrBkTime drBkTime);

}
