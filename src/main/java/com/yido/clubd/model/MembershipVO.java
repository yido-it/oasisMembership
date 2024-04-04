package com.yido.clubd.model;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 모델명 : MembershipVO 
 * 모델 설명 : 클럽디 멤버십 정보
 * 
 * DR_CD_CO_BRAND
 * DR_CD_MEMBERSHIP
 * DR_CD_BENEFIT
 * DR_MEMBERSHIP_BARCODE
 * DR_MEMBERSHIP_MAIN
 * DR_MEMBERSHIP_USER
 * DR_MEMBERSHIP_BENEFIT
 * 
 * @author MSYOO
 *
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class MembershipVO {
	
	private String coBrandDiv;
	private String coBrandName;
	private String useYn;
	private String inputStaff;	
	private String inputIp;							
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime inputDatetime;

	private String membershipDiv;
	private String membershipName;
	private String imgFileName;
	
	private String benefitNo;
	private String benefitNm;
	
	private String membershipNo;
	private String membershipNoSeq;
	private String barcodeNo;
	
	private String contractorNum;
	private String expFrom;
	private String expTo;
	private String transYn;
	private String memo;
	
	private String msNum;
		
	private String qr;
	public String getFileURL() {
		return "/store/membership/" + this.imgFileName; 
	}	
}


