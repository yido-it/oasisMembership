package com.yido.clubd.repository;


import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.yido.clubd.model.DrMsCoInfo;

/**
 * 회원지점연결정보 LOG
 * 
 * @author bae
 *
 */
@Mapper
@Repository
public interface DrMsCoInfoLogMapper {
	public void insertDrMsCoInfoLog(DrMsCoInfo drMsCoInfo);

}
