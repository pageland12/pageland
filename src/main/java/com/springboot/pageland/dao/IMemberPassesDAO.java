package com.springboot.pageland.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.pageland.dto.MemberPassesDTO;
import com.springboot.pageland.dto.RatingDTO;

@Mapper
public interface IMemberPassesDAO {
	public int memberPassesInsert(MemberPassesDTO dto);
	public List<MemberPassesDTO> mbList();
	public List<MemberPassesDTO> mbCheck(int mno);
}
