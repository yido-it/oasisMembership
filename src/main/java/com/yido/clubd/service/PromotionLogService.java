package com.yido.clubd.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yido.clubd.model.DrPromotionMark;
import com.yido.clubd.repository.PromotionLogMapper;

import lombok.extern.slf4j.Slf4j;

/**
 * 프로모션관련
 * 
 * @author bae
 *
 */
@Slf4j
@Service
public class PromotionLogService {

	@Autowired
    private PromotionLogMapper prmLogMapper;

    public int insertPrmMarkLog(DrPromotionMark prmMark) {
    	return prmLogMapper.insertPrmMarkLog(prmMark);
    }
    

 
}
