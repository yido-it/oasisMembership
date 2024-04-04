package com.yido.clubd.repository;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;
import com.yido.clubd.model.DrBkTimeVoucher;

/**
 * 예약타입별 이용권 설정
 * 
 * @author bae
 *
 */
@Mapper
@Repository
public interface DrBkTimeVoucherMapper {

	public List<Map<String, Object>> getBayList(DrBkTimeVoucher drBkTimeVoucher);

}
