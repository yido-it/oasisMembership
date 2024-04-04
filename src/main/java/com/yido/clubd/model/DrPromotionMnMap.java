package com.yido.clubd.model;

import java.time.LocalDateTime;
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 테이블명 : DR_PROMOTION_MN_MAP 
 * 테이블 설명 : 프로모션 입금 연결 정보
 * 
 * @author bae
 *
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class DrPromotionMnMap {

	private String coDiv;			// 지점코드
	private String pmDivision;		// 프로모션 종류
	private String pmSerialNo; 		// 프로모션번호
	private String msNum; 			// 회원번호
	private int listSeq; 			// 중복 접수에 대한 순번
	private String mnInDay; 		// 입금일자
	private int mnSeq; 				// 입금순번
	private String mnCoDiv; 		// 입금지점코드
	private int mnAmount; 			// 할당금액

}


