package com.springboot.pageland.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.springboot.pageland.dto.RatingDTO;

@Mapper
public interface IRatingDAO {
	public List<RatingDTO> ratingList();
	public List<RatingDTO> ratingCheck(int mno);
	public RatingDTO ratingView(int rno);
	public int ratingWrite(RatingDTO dto);
	public int ratingUpdate(RatingDTO dto);
	public int ratingDelete(int rno);
	public int ratingHit(int rno);
	
	// --- 페이징 처리 전용 메서드 추가 ---
    public List<RatingDTO> ratingListPaging(@Param("startRow") int startRow, @Param("endRow") int endRow);
    public int getTotalCount();
	
}
