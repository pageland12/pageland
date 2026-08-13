package com.springboot.pageland.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.pageland.dto.MemberDTO;

@Mapper
public interface IMemberDAO {
		// 회원 목록 (관리자)
		public List<MemberDTO> memberList();
		
		//회원정보상세보기, 수정폼
		public MemberDTO memberView(int mno);
	
		// 회원 등록
		public int memberInsert(MemberDTO dto);
		
		// 회원정보 수정 -> 회원 본인이 수정하는 것
		public int memberUpdate(MemberDTO dto);
		
		// 회원 삭제
		public int memberDelete(int mno);
}