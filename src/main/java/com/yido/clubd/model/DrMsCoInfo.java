package com.yido.clubd.model;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 테이블명 : DR_MS_CO_INFO
 * 테이블 설명 : 회원지점연결정보
 * 
 * @author bae
 *
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class DrMsCoInfo {
	
	private int logSeq; 				// 로그순번
	private String logDiv; 				// 로그종류(I,U,D)

	private String coDiv;				// 지점코드
	private String msNum; 				// 회원번호
	private String msRegister; 			// 최초등록업장 여부
	private String msFirstPick;			// 선호 업장
	private String useYn;				// 사용여부
	private String msVoucherDay;
	private int lessonWeekCnt;			// 주 레슨 횟수(일정 집계)
	private String lessonOutdoor;		// 필드 레슨 요일(YYNYYNY)
	
	private String inputStaff; 											// 입력사번
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime inputDatetime;								// 입력일시
	private String inputIp;												// 입력IP

}


