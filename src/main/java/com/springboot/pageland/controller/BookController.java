package com.springboot.pageland.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springboot.pageland.dao.IBookDAO;
import com.springboot.pageland.dto.BookDTO;

@Controller
public class BookController {
	@Autowired
	private IBookDAO bdao;
	
	@RequestMapping("/guest/allBookList")
	public String bookList(Model model) {
		model.addAttribute("books", bdao.bookList());
		
		return "guest/allBookList";
	}
	
	@RequestMapping("/guest/bookDetail")
	public String bookDetail(Model model, @RequestParam("bno") int bno) {
		model.addAttribute("book", bdao.bookDetail(bno));
		
		return "guest/bookDetail";
	}
	
	
	@RequestMapping("/admin/bookWriteForm")
	public String bookWriteForm() {
		return "admin/bookWriteForm";
	}
	
	@RequestMapping("/admin/bookWrite")
	public String bookWrite(BookDTO dto) {
		bdao.bookInsert(dto);
		
		return "redirect:/admin/adminMain";
	}
	
	@RequestMapping("/guest/allBookAgeList")
	public String bookAgeList(
	        @RequestParam(value = "category", required = false, defaultValue = "전체") String category, 
	        Model model) {
	    
	    List<BookDTO> list;
	    
	    // '전체' 버튼을 눌렀거나 파라미터가 없을 때
	    if (category.equals("전체") || category.trim().isEmpty()) {
	        list = bdao.bookList();
	        model.addAttribute("currentCategory", "연령별 전체 도서");
	    } else {
	        // [0-3세], [4-7세], [초등 저학년], [초등 고학년] 버튼을 눌렀을 때 해당 연령만 필터링
	        list = bdao.bookListByCategory(category);
	        model.addAttribute("currentCategory", category + " 추천 도서");
	    }
	    
	    model.addAttribute("books", list);
	    model.addAttribute("selectedCategory", category); // 현재 선택된 버튼 스타일링용
	    
	    return "guest/allBookAgeList";
	}
	
	@RequestMapping("/guest/allBookGenreList")
	public String bookGenreList(
	        @RequestParam(value = "genre", required = false, defaultValue = "전체") String genre, 
	        Model model) {
	    
	    List<BookDTO> list;
	    
	    // '전체' 클릭 또는 파라미터가 비어있을 경우 전체 도서 조회
	    if (genre.equals("전체") || genre.trim().isEmpty()) {
	        list = bdao.bookList();
	        model.addAttribute("currentGenre", "분야별 전체 도서");
	    } else {
	        // 지정한 분야(생활/창작, 수학/영어 등)로 필터링 조회
	        list = bdao.bookListByGenre(genre);
	        model.addAttribute("currentGenre", genre + " 추천 도서");
	    }
	    
	    model.addAttribute("books", list);
	    model.addAttribute("selectedGenre", genre); // 선택된 버튼 활성화 표시용
	    
	    return "guest/allBookGenreList";
	}
	
	@RequestMapping("/guest/allBookPublisherList")
	public String bookPublisherList(
	        @RequestParam(value = "publisher", required = false, defaultValue = "전체") String publisher, 
	        Model model) {
	    
	    List<BookDTO> list;
	    
	    // '전체' 클릭 또는 파라미터가 비어있을 경우 전체 도서 조회
	    if (publisher.equals("전체") || publisher.trim().isEmpty()) {
	        list = bdao.bookList();
	        model.addAttribute("currentPublisher", "출판사별 전체 도서");
	    } else {
	        // 지정한 출판사(그레이트북스, 아람북스 등)로 필터링 조회
	        list = bdao.bookListByPublisher(publisher);
	        model.addAttribute("currentPublisher", publisher + " 추천 도서");
	    }
	    
	    model.addAttribute("books", list);
	    model.addAttribute("selectedPublisher", publisher); // 선택된 버튼 활성화 표시용
	    
	    return "guest/allBookPublisherList";
	}
	
}
