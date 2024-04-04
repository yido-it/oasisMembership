package com.yido.clubd.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.yido.clubd.model.MembershipVO;

/**
 * 회원정보
 * 
 * @author MSYOO
 *
 */
@Mapper
@Repository
public interface MembershipMapper {

	public List<MembershipVO> selectMembershipList(Map<String, Object> params);
	public List<MembershipVO> selectBenefitList(Map<String, Object> params);

}
