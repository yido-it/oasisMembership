package com.yido.clubd.repository;


import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.yido.clubd.model.ProVO;

/**
 * 레슨프로 로그
 * 
 * @author YOO
 *
 */
@Mapper
@Repository
public interface ProLogMapper {
	
	// 레슨프로 특이사항 로그 등록
	public void insertProNoticeLog(ProVO prLogoVO);
	// 레슨프로 자격사항 로그 등록
	public void insertProLicenseLog(ProVO proLogVO);

}
