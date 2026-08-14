package com.springboot.pageland.dao;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.pageland.dto.MemberPassesDTO;

@Mapper
public interface IMemberPassesDAO {
	// 구매한 구독권 등록
	public int memberPassesInsert(MemberPassesDTO dto);
}
