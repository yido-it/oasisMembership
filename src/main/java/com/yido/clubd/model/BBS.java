package com.yido.clubd.model;

import java.time.LocalDateTime;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
import lombok.EqualsAndHashCode;

/** 
 * 게시판
 * 
 * @author bae
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class BBS {

	private int idx;			// 번호
	private int bbsType;		// 게시판종류 (공지사항 : 1, 이벤트 : 2, 프로모션 : 3)	
	private String title;		// 제목	
	private String content;		// 내용
	private String userName;	// 글쓴이
	private String userId;		// 글쓴이아이디
	private String userEmail;	// 글쓴이메일주소
	private String userIp;		// 글쓴이아이피
	private int viewCount;		// 조회수
	private String upFileName;	// (상세) 이미지파일명 
	private String upFileUrl;	// (상세) 이미지파일경로  
	private String upFileName2;	// (메인) 이미지파일명 
	private String upFileUrl2;	// (메인) 이미지파일경로
	private String startDay;	// 이벤트 시작일
	private String endDay;		// 이벤트 종료일
	
	public String getFileURL() {
		return "/store/" + this.upFileUrl + this.upFileName; 
	}	

	public String getFileURL2() {
		return "/store/" + this.upFileUrl2 + this.upFileName2; 
	}	
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime regDate;	// 작성일
}


