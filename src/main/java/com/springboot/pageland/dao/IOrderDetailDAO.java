package com.springboot.pageland.dao;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.pageland.dto.OrderDetailDTO;

@Mapper
public interface IOrderDetailDAO {
	// 주문 상세 등록
	public int orderDetailInsert(OrderDetailDTO dto);
}
