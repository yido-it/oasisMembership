package com.yido.clubd.repository;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.yido.clubd.model.MemberVO;

/**
 * 회원정보 로그
 * 
 * @author MSYOO
 *
 */
@Mapper
@Repository
public interface MemberLogMapper {

	public MemberVO selectMember(Map<String, Object> map);
	public void insertDrMsMaininfoLog(MemberVO memberVO);
	public void insertDrMsBasicLog(MemberVO memberVO);
	public void insertDrMsCarLog(MemberVO memberVO);

}
