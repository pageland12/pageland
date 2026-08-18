package com.springboot.pageland.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.springboot.pageland.dto.AdminBoardDTO;

@Mapper
public interface IAdminBoardDAO {
	public List<AdminBoardDTO> noticeList(); // 공지사항
	public List<AdminBoardDTO> eventList(); // 이벤트
	public AdminBoardDTO abView(int adno);
	public int abWrite(AdminBoardDTO dto);
	public int abUpdate(AdminBoardDTO dto);
	public int abDelete(int adno);
	public int abHit(int abno);
	
	// 페이징 처리된 이벤트 목록 조회
    public List<AdminBoardDTO> eventListPaging(@Param("startRow") int startRow, @Param("endRow") int endRow);
    
    // 전체 이벤트 게시글 수 조회
    public int getTotalCount();
    
    public List<AdminBoardDTO> noticeListPaging(@Param("startRow") int startRow, @Param("endRow") int endRow);
    public int getNoticeTotalCount(); // 공지사항 개수
    
}
