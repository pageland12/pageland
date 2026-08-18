package com.springboot.pageland.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.springboot.pageland.dto.QnaDTO;

@Mapper
public interface IQnaDAO {
	public List<QnaDTO> qnaList(); 		// qna 목록
	public QnaDTO qnaView(int qno); 	// qna 상세보기, 수정폼
	public int qnaWrite(QnaDTO dto); 	// qna 등록
	public int qnaUpdate(QnaDTO dto); 	// qna 수정
	public int qnaDelete(int qno); 		// qna 삭제
	public int qnaHit(int qno);			// qna 조회수 증가
	
	// --- 페이징 추가 ---
    public List<QnaDTO> qnaListPaging(@Param("startRow") int startRow, @Param("endRow") int endRow);
    public int getTotalCount();
	
}
