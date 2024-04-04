package com.yido.clubd.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import lombok.Data;
import lombok.EqualsAndHashCode;

/** 
 * 예약 관련 
 * 
 * @author bae
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class BookInfoVO {

	private String bkSerialNo;		// 예약고유번호
	private String calcSerialNo;	// 대표예약고유번호
	private String coDiv;			// 지점코드
	private String bkDay;			// 예약일자
	private String bkTime;			// 시작시간 (1100)
	private String bayCondi;		// 예약BAY 구성 단위
	private String bayName;			// 예약BAY 이름
	private String bayName2;		// 예약BAY 이름2
	private int bkAmount;			// 예약금액
	private int oriBkAmount;		// 원래 결제금액
	private String msLevel;			// 회원등급
	private String userMail;		// 이메일
	private String msId;			// 아이디
	private String msNum;			
	private String userName;		// 이름
	private String ipAddr;			// ip
	private String phone; 			// 전화번호
	private String bkState; 		// 예약상태
	
	private String tempDelYn;		// 임시테이블 데이터 삭제 여부
	private String tempSerialNo;	// 임시테이블 serialNo

	private String availableYn;		// (예약선점용 조회할때 사용) Y이면 예약 가능한 데이터 조회
	
	private List<Map<String, Object>> bkList;		// [{"bkTime":"08:00","amount":50000},{"bkTime":"13:00","amount":50000}]
	private List<Map<String, Object>> vList;		// [{coDiv=001, quantity=1, saleDay=20230119, saleSeq=3}, {coDiv=001, quantity=1, saleDay=20230119, saleSeq=4}]
	private List<String> timeList;					// 08:00, 13:00
	
	/* 예약선점 테이블 */
	private int bkSeq;			// 선점테이블 seq
	
	/* 기타 */
	private String cancelSerialNo;	// 취소할 bkSerialNo  > B00000018784, B00000018785, B00000018786

}


