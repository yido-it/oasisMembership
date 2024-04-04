package com.yido.clubd.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yido.clubd.model.MembershipVO;
import com.yido.clubd.repository.MembershipMapper;

import lombok.extern.slf4j.Slf4j;

/**
 * 회원정보 (회원/프로)
 * 
 * @author YOO
 *
 */
@Slf4j
@Service
public class MembershipService {

	@Autowired
    private MembershipMapper membershipMapper;
	
	public List<MembershipVO> getMembershipList(Map<String, Object> params) {
		return membershipMapper.selectMembershipList(params);
	}	
	
	public List<MembershipVO> getBenefitList(Map<String, Object> params) {
		return membershipMapper.selectBenefitList(params);
	}	

}
