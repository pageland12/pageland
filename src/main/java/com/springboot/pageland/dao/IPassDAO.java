package com.springboot.pageland.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.pageland.dto.PassDTO;

@Mapper
public interface IPassDAO {
	// 도서 목록 (관리자)
	public List<PassDTO> passList();

	// 도서 등록
	public int passInsert(PassDTO dto);
	
	// 도서정보 수정
	public int passUpdate(PassDTO dto);
	
	// 도서 삭제
	public int passDelete(int pno);
}
