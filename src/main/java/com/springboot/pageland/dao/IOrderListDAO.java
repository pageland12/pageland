package com.springboot.pageland.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.pageland.dto.OrderListDTO;

@Mapper
public interface IOrderListDAO {
	// 주문 목록: 회원
	public List<OrderListDTO> morderList(int mno);
	
	// 주문 목록 등록
	public int orderListInsert(OrderListDTO dto);
	
}
