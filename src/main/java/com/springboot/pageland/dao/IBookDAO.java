package com.springboot.pageland.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.springboot.pageland.dto.BookDTO;

@Mapper
public interface IBookDAO {
		// 도서 목록 (관리자)
		public List<BookDTO> bookList();
		
		// 도서 상세
		public BookDTO bookDetail(int bno);
		
		// 도서 등록
		public int bookInsert(BookDTO dto);
		
		// 도서정보 수정
		public int bookUpdate(BookDTO dto);
		
		// 도서 삭제
		public int bookDelete(int bno);

		// best 도서 목록 (상위 16개)
		public List<BookDTO> bestList();
		
		// 연령별 도서 목록 조회
		public List<BookDTO> bookListByCategory(@Param("category") String category);
		
		// 분야별(bgenre) 도서 목록 조회
	    public List<BookDTO> bookListByGenre(@Param("genre") String genre);
	    
	    // 출판사별(bpublisher) 도서 목록 조회
	    public List<BookDTO> bookListByPublisher(@Param("publisher") String publisher);
}