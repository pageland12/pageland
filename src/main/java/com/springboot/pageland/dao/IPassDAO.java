package com.springboot.pageland.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.springboot.pageland.dto.PassDTO;

@Mapper
public interface IPassDAO {
	// 구독권 목록 (관리자)
	public List<PassDTO> passList();
	
	// 구독권 상세
	public PassDTO passDetail(int pno);

	// 구독권 등록
	public int passInsert(PassDTO dto);
	
	// 구독권정보 수정
	public int passUpdate(PassDTO dto);
	
	// 구독권 삭제
	public int passDelete(int pno);
	
	// 전체 구독권 목록 페이징 조회
    public List<PassDTO> passListPaging(@Param("startRow") int startRow, @Param("endRow") int endRow);
    
    // 전체 구독권 개수 조회 (페이지 번호 계산용)
    public int getTotalCount();
    
}
