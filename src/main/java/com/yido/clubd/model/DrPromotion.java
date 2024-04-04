package com.yido.clubd.model;

import java.time.LocalDateTime;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 테이블명 : DR_PROMOTION , DR_PROMOTION_IMAGE
 * 테이블 설명 : 프로모션 , 이미지
 * 
 * @author bae
 *
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class DrPromotion {

	/* 프로모션  */
	private String coDiv;			// 지점코드
	private String pmDivision;		// 프로모션 종류
	private String pmSerialNo; 		// 프로모션번호
	private String mainSerialNo; 	// 메인프로모션번호
	private String pmName;			// 프로모션 명
	private String mainPmName;		// 메인 프로모션 명
	private String pmOpenFromDay; 	// 프로모션 게시 시작일자
	private String pmOpenEndDay;	// 프로모션 게시 종료일자
	private String pmFromDay;		// 프로모션 신청 시작일자
	private String pmEndDay;		// 프로모션 신청 종료일자
	private String pmEventFromDay;	// 행사 시작일
	private String pmEventEndDay;	// 행사 종료일
	private String pmContent;		// 프로모션 내용
	private String pmFormat;		// 기본폼
	private int pmCancelLimit;		// 취소가능일
	private int pmLimitCount;		// 최대 대상 인원
	private String costCoDiv;		// 요금지점코드
	private String costName;		// 요금 명칭
	private String costCd;			// 요금코드(공통코드 : 004)
	private String costDiv;			// 요금구분(공통코드 : 003) 이용권,일반
	private String pmSex;			// 성별(1:남자,2:여자,3:모두)
	private String pmDrinkYn;		// 주류판매여부
	private String pmState;			// 프로모션상태 (Y, N)
	private int pmUseCount;			// 총사용가능횟수
	private String pmBasicYn;		// 기본폼사용여부 (Y, N)
	private String pmMainYn;		// 메인프로모션여부
	private String pmRealYn;		
	
	private String inputStaff; 		// 입력사번

	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime inputDatetime;	// 입력일시
	
	private String inputIp;					// 입력IP
	
	/* 프로모션 이미지 */
	private String imgPath; 		// 이미지 경로
	private String imgName; 		// 이미지 명

	/* 컬럼 외 */
	public int drAmount;			// 행사금액
	private String cancelDate;		// 취소가능일자
	
	public String getFileURL() {
		return "/store/" + this.imgPath + this.imgName; 
	}	
	
}


