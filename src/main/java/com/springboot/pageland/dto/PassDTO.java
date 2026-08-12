package com.springboot.pageland.dto;

import lombok.Data;

@Data
public class PassDTO {
	private int 			pno;			// 구독권 번호
	private String 			pname;			// 구독권 이름
	private int 			pprice;			// 가격
	private String 			ptype;			// 구독권 타입: 정기권, N회권
	private String 			pperiod;		// 구독 기간(정기권)
	private String			pcount;			// 남은 횟수(N회권)	
	private String			pimg;			// 구독권 상품 사진(URL)
	private String		 	pinfo;			// 구독권 정보
}
