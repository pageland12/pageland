package com.springboot.pageland.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.springboot.pageland.dto.MemberBooksDTO;

@Mapper
public interface IMemberBooksDAO {
	// 대여한 도서 목록: 회원
	public List<MemberBooksDTO> myBookList(int mno);
	
	// 대여한 도서 등록
	public int memberBooksInsert(MemberBooksDTO dto);
	
	// 대여한 도서 반납
	public int memberBooksReturn(MemberBooksDTO dto);
	
	// 대여 도서 연장
	public int memberBookExtend(@Param("mbno") int mbno, @Param("extendDays") int extendDays);
}
