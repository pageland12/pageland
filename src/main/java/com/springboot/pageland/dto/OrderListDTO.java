package com.springboot.pageland.dto;

import java.util.Date;

import lombok.Data;

@Data
public class OrderListDTO {
	private	String	olno;		// 주문 번호
	private	int		olprice;	// 주문 정가
	private	int		olfee;		// 배송료
	private	int		olsale;		// 할인
	private	int		oltotal;	// 주문 총액
	private	String	olpayment;	// 결제 방식
	private	Date	oldate;		// 결제 일시
	private	int		mno;		// 회원 번호
	private	int 	memail;		// 회원 이메일
}
