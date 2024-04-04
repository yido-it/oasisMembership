package com.yido.clubd.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yido.clubd.model.MemberLogVO;
import com.yido.clubd.model.MemberVO;
import com.yido.clubd.repository.MemberLogMapper;

import lombok.extern.slf4j.Slf4j;

/**
 * 회원정보 로그
 * 
 * @author YOO
 *
 */
@Slf4j
@Service
public class MemberLogService {

	@Autowired
    private MemberLogMapper memberLogMapper;

	public MemberVO selectMember(Map<String, Object> map) {
		return memberLogMapper.selectMember(map);
	};
	public void insertDrMsMaininfoLog(MemberVO memberVO) {
		memberLogMapper.insertDrMsMaininfoLog(memberVO);
	};
	public void insertDrMsBasicLog(MemberVO memberVO) {
		memberLogMapper.insertDrMsBasicLog(memberVO);
	};
	public void insertDrMsCarLog(MemberVO memberVO) {
		memberLogMapper.insertDrMsCarLog(memberVO);
	};
	
}
