package com.yido.clubd.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.yido.clubd.model.DrBkTimeVoucher;
import com.yido.clubd.repository.DrBkTimeVoucherMapper;
import lombok.extern.slf4j.Slf4j;

/**
 * 예약타입별 이용권 설정
 * 
 * @author bae
 *
 */
@Slf4j
@Service
public class DrBkTimeVoucherService {

	@Autowired
    private DrBkTimeVoucherMapper drBkTimeVoucherMapper;

    public List<Map<String, Object>> getBayList(DrBkTimeVoucher drBkTimeVoucher) {
    	return drBkTimeVoucherMapper.getBayList(drBkTimeVoucher);
    }
}
