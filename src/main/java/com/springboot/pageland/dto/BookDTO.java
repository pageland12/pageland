package com.springboot.pageland.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data	
public class BookDTO {
	private int 			bno;			// 도서 번호
	private String 			bname;			// 도서 제목
	private int 			bprice;			// 가격
	private String 			bage;			// 연령
	private String 			bgenre;			// 분야
	private String			bpublisher;		// 출판사
	private MultipartFile 	pricture;			
	private String			bimg;			// 도서 이미지
	private MultipartFile	binfo;			// 도서 정보
	private int				bstock;			// 재고 수량
	private int				blike;			// 추천수
}