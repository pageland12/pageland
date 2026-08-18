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
	
	// 만료된 정기권 업데이트
	public int expiredSubscriberPassesUpdate(int mno);
	
	// 활성화된 정기권 개수 새기
	public int activeSubcriberPassesCount(int mno);
	
	// 활성화된 정기권 중 하나의 mpno 찾기
	public MemberPassesDTO findActiveSubscriberPass(int mno);
	
	// 정기권 만료일 연장
	public int subscriberPassExtend(MemberPassesDTO dto);
	
	// 활성화된 N회권 중 하나의 mpno 찾기
	public MemberPassesDTO findActiveNPass(int mno);
	
	// N회권 횟수 추가
	public int nPassIncrease(MemberPassesDTO dto);
}
