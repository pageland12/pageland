package com.springboot.pageland.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.pageland.dto.AdminBoardDTO;

@Mapper
public interface IAdminBoardDAO {
	public List<AdminBoardDTO> noticeList(); // 공지사항
	public List<AdminBoardDTO> eventList(); // 이벤트
	public AdminBoardDTO abView(int adno);
	public int abWrite(AdminBoardDTO dto);
	public int abUpdate(AdminBoardDTO dto);
	public int abDelete(int adno);
}
