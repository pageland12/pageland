package com.springboot.pageland.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.springboot.pageland.dto.QnaDTO;

@Mapper
public interface IQnaDAO {
	public List<QnaDTO> qnaList(); 		// qna 목록
	public QnaDTO qnaView(int qno); 	// qna 상세보기, 수정폼
	public int qnaWrite(QnaDTO dto); 	// qna 등록
	public int qnaUpdate(QnaDTO dto); 	// qna 수정
	public int qnaDelete(int qno); 		// qna 삭제
}
