package com.springboot.pageland.dao;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
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

	// --- 페이징 처리 전용 메서드 추가 ---
	public List<CartDTO> mcartListPaging(@Param("mno") int mno, @Param("startRow") int startRow, @Param("endRow") int endRow);
	public int getTotalCountByMno(int mno);
	
	// 장바구니에 도서가 얼마나 담겨있는지 확인
	public int getTotalCountByMnoCtype(int mno);
}
