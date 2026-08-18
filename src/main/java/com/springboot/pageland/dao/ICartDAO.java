package com.springboot.pageland.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.pageland.dto.CartDTO;

@Mapper
public interface ICartDAO {
	// 장바구니 목록 (전체 장바구니)
	public List<CartDTO> cartList();
	
	// 장바구니 목록 (결제용)
	public List<CartDTO> cartPayList(List<Integer> cnoList);
	
	// 장바구니 목록 (회원용)
	public List<CartDTO> mcartList(int mno);
	
	// 장바구니 상세
	public CartDTO cartDetail(CartDTO dto);
	
	// 장바구니 등록
	public int cartInsert(CartDTO dto);
	
	// 장바구니 수정
	public int cartUpdate(CartDTO dto);
	
	// 장바구니 삭제
	public int cartDelete(int cno);
	
	// 장바구니 도서 삭제
	public int cartBookDelete(CartDTO dto);
}
