package com.yido.clubd.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yido.clubd.common.utils.Globals;
import com.yido.clubd.model.ProVO;
import com.yido.clubd.repository.ProLogMapper;

import lombok.extern.slf4j.Slf4j;

/**
 * 레슨프로특이사항
 * 
 * @author bae
 *
 */
@Slf4j
@Service
public class ProLogService {

	@Autowired
    private ProLogMapper proLogMapper;

	/**
	 * 레슨프로특이사항 등록
	 * 
	 * @param proNotice
	 * @return
	 */
	public void insertProNoticeLog(ProVO proVO) {
		proVO.setInputIp(Globals.serverIpAddress);
		proVO.setInputStaff("APP");
		proLogMapper.insertProNoticeLog(proVO);
	}
	/**
	 * 레슨프로자격사항 등록
	 * 
	 * @param proLicense
	 * @return
	 */
	public void insertProLicenseLog(ProVO proVO) {
		proVO.setInputIp(Globals.serverIpAddress);
		proVO.setInputStaff("APP");
		proLogMapper.insertProLicenseLog(proVO);
	}
	
}
