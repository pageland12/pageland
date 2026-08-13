package com.springboot.pageland.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.pageland.dto.RatingDTO;

@Mapper
public interface IRatingDAO {
	public List<RatingDTO> ratingList();
	public RatingDTO ratingView(int rno);
	public int ratingWrite(RatingDTO dto);
	public int ratingUpdate(RatingDTO dto);
	public int ratingDelete(int rno);
}
