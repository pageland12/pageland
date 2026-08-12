package com.springboot.pageland.dao;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.pageland.dto.CartDTO;

@Mapper
public interface ICartDAO {
	// 도서 등록
	public int cartInsert(CartDTO dto);
}
