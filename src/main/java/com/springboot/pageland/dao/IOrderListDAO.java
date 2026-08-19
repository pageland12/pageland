package com.springboot.pageland.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.springboot.pageland.dto.BookDTO;
import com.springboot.pageland.dto.OrderListDTO;

@Mapper
public interface IOrderListDAO {
	// 주문 목록: 회원
	public List<OrderListDTO> morderList(int mno);
	
	// 주문 목록 등록
	public int orderListInsert(OrderListDTO dto);
	
	// 회원의 전체 주문 페이징 목록
    public List<OrderListDTO> memberOrderListPaging(@Param("mno") int mno, @Param("startRow") int startRow, @Param("endRow") int endRow);
    
    // 회원의 전체 책 개수
    public int getTotalOrderCountByMno(int mno);
	
}
