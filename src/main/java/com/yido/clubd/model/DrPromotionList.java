package com.yido.clubd.model;

import java.time.LocalDateTime;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 테이블명 : DR_PROMOTION_LIST 
 * 테이블 설명 : 프로모션 접수내역 
 * 
 * @author bae
 *
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class DrPromotionList {

	private String coDiv;			// 지점코드
	private String pmDivision;		// 프로모션 종류
	private String pmSerialNo; 		// 프로모션번호
	private String msNum; 			// 회원번호
	private int listSeq; 			// 중복 접수에 대한 순번
	private String customerNotice; 	// 접수내용
	private String inputStaff; 		// 입력사번
	private String useName;			// 사용자명
	private int pmRemCount;			// 총사용가능횟수
	private int remCount;			

	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime inputDatetime;	// 입력일시

	private String inputIp;			// 입력IP

	/* 로그테이블 */
	private int logSeq; 					// 로그순번
	private String logDiv; 					// 로그종류(I,U,D)

}


