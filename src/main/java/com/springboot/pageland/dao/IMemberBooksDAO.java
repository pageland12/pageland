package com.springboot.pageland.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.springboot.pageland.dto.MemberBooksDTO;
import com.springboot.pageland.dto.OrderListDTO;

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
	
	// 연체 상태, 일수, 연체료 업데이트
	public int overdueStatusUpdate(int mno);
	
	// 연체 중인 도서 권수 확인
	public int overdueBooksCount(int mno);
	
	// 특정 회원의 총 연체료 합계 조회
	public int memberLateFeeTotal(int mno);
	
	// 특정 도서의 대여, 연체 여부 확인
	public MemberBooksDTO memberBooksDetail(MemberBooksDTO dto);
	
	// 현재 대여 중인 도서 권수 확인
	public int activeRentBooksCount(int mno);
	
}
