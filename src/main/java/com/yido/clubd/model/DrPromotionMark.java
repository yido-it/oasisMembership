package com.yido.clubd.model;

import java.time.LocalDateTime;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 테이블명 : DR_PROMOTION_MARK 
 * 테이블 설명 : 프로모션 선점 내역
 * 
 * @author bae
 *
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class DrPromotionMark {

	private String coDiv;			// 지점코드
	private String pmDivision;		// 프로모션 종류
	private String pmSerialNo; 		// 프로모션번호
	private int markSeq;			// 선점순번
	private String markState;		// 상태(Y,N)
	private String msNum; 			// 접수내역 KEY1(회원번호)
	private int listSeq; 			// 접수내역 KEY2

	private String entryUser;		// 점유자ID
	private String entryIp; 		// 점유IP
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime entryDatetime;	// 점유종료시간
	
	private String inputStaff; 				// 입력사번

	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime inputDatetime;	// 입력일시
	
	private String inputIp;					// 입력IP

	/* 로그테이블 */
	private int logSeq; 			// 로그순번
	private String logDiv; 			// 로그종류(I,U,D)
}


