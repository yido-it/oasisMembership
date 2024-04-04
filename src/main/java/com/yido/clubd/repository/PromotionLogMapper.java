package com.yido.clubd.repository;


import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.yido.clubd.model.DrPromotionList;
import com.yido.clubd.model.DrPromotionMark;
import com.yido.clubd.model.DrVoucherSale;

/**
 * 프로모션 로그  
 * 
 * @author bae
 *
 */
@Mapper
@Repository
public interface PromotionLogMapper {

	public int insertPrmMarkLog(DrPromotionMark prmMark);
	
	//로그 등록
	public int insPrmListLog(DrPromotionList drPromotionList);

}
