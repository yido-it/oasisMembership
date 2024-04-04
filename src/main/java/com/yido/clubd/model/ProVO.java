package com.yido.clubd.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 모델명 : ProVO
 * 모델 설명 : 프로 정보
 * 
 * @author MSYOO
 *
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class ProVO {

	private int logSeq; 			// 로그순번
	private String logDiv; 			// 로그종류(I,U,D)
	private String inputStaff;
	private String inputDatetime;
	private String inputIp;
	
	private String msName;
	
	/* PRO_NOTICE 레슨프로특이사항 */
	private String msNum;			// 회원번호
	private String noticeDiv;		// 비고 종류(경력, 레슨계획, 유투브채널,..)
	private String proMustYn;		// 필수 입력 여부
	private String proRemark;		// 비고 사항
	private String noticeOpenYn;	// 공개 여부
	
	/* PRO_IMAGE 레슨프로 이미지/영상 */
	private String imgDiv;
	private String imgSeq;
	private String imgLink;
	private String imgPath;
	private String imgFilename;
	private String imgData;
	
	/* PRO_LICENSE 레슨프로자격사항 */
	private Integer licSeq;			// 순번
	private String licKind;			// 자격 코드
	private String licRemark;		// 비고
	private String licName;			// 자격 이름
	private String licOpenYn;		// 자격 노출 여부
	
	private String coDiv;			// 선호업장
	
	public String getFileURL() {
		return "/store/" + this.imgPath + this.imgFilename; 
	}	
	public String getThumbURL() {
		String str = "";
		if(this.imgFilename != "" && this.imgFilename != null) {
			str = this.imgFilename.substring(0, (this.imgFilename.lastIndexOf(".") + 1)).concat("jpg");
		}
		return "/store/" + this.imgPath + "thumb/" + str; 
	}
	public String getVideoFileURL() {
		return "https://ixeewzeyqupw16148943.cdn.ntruss.com/" + this.imgPath + this.imgFilename; 
	}
	public String getVideoThumbURL() {
		String str = "";
		if(this.imgFilename != "" && this.imgFilename != null) {
			str = this.imgFilename.replace("_default.mp4", "_01.jpg");
		}
		return "/store/" + this.imgPath + str; 
	}
}


