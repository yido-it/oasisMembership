package com.yido.clubd.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

/** 
 * 프로모션 관련 
 * 
 * @author bae
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class PrmInfoVO {

	private String coDiv;			// 지점코드
	private String pmSerialNo;		// 프로모션고유번호
	private String pmDivision;		// 프로모션구분
	private String pmAmt;			// 결제금액
	private String ipAddr;			// ip
	private String msNum;			// 회원번호
	private String msId;			// 회원아이디
	private String msName;			// 회원이름
	private String msPhone;			// 회원전화번호
	private String customerNotice;	// 신청서
	
	/* 접수내역 */
	private int listSeq;			// 중복접수에 대한 순번
	
	/* 선점 테이블 */
	private int markSeq;			// 선점테이블 SEQ 
	private String entryUser;		// 선점 아이디 
	private String markState;		// 상태 
	
	/* 입금 테이블 */
	private int mnSeq;				// 입금순번
	
	/* 기타 */
	private String isMarkChk;		// 이미 선점한 데이터 조회할지 여부 
	private String minusRemCnt;
	private String addRemCnt;
	
	
}