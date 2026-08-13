package com.springboot.pageland.dto;

import lombok.Data;

@Data
public class OrderDetailDTO {
	private	int		odno;		// 주문 상세 번호
	private	int		odstock;	// 주문 수량
	private	int		odprice;	// 결제 가격
	private	int		odsale;		// 할인
	private	String	olno;		// 주문 번호
	private	int		bno;		// 도서 번호
	private int		bprice;		// 도서 가격
	private	int		pno;		// 구독권 번호
	private int		pprice;		// 구독권 가격
	private	int		mpno;		// 회원 구독권 번호
}
