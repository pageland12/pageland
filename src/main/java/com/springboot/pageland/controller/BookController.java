package com.springboot.pageland.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springboot.pageland.dao.IBookDAO;
import com.springboot.pageland.dao.IMemberBooksDAO;
import com.springboot.pageland.dao.IMemberDAO;
import com.springboot.pageland.dto.BookDTO;
import com.springboot.pageland.dto.MemberBooksDTO;

@Controller
public class BookController {
	@Autowired
	private IBookDAO bdao;
	
	@Autowired
	private IMemberDAO mdao;
	
	@Autowired
	private IMemberBooksDAO mbdao;
	
	@RequestMapping("/guest/allBookList")
	public String allBookList(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum, Model model) {
	    int amount = 16; // 한 페이지당 16개
	    
	    int startRow = (pageNum - 1) * amount + 1;
	    int endRow = pageNum * amount;
	    
	    List<BookDTO> books = bdao.bookListPaging(startRow, endRow);
	    int total = bdao.getTotalCount();
	    int totalPages = (int) Math.ceil((double) total / amount);
	    
	    // --- 화면에 보여줄 페이지 번호 개수 (최대 5개) ---
	    int navSize = 5;
	    int startPage = ((pageNum - 1) / navSize) * navSize + 1;
	    int endPage = startPage + navSize - 1;
	    
	    // 실제 총 페이지 수를 넘지 않도록 조정
	    if (endPage > totalPages) {
	        endPage = totalPages;
	    }
	    
	    model.addAttribute("books", books);
	    model.addAttribute("pageNum", pageNum);
	    model.addAttribute("startPage", startPage);
	    model.addAttribute("endPage", endPage);
	    model.addAttribute("totalPages", totalPages);
	    
	    return "guest/allBookList";
	}
	
	@RequestMapping("/guest/bookDetail")
	public String bookDetail(Model model, @RequestParam("bno") int bno) {
		model.addAttribute("book", bdao.bookDetail(bno));
		
		return "guest/bookDetail";
	}
	
	@RequestMapping("/member/myBookList")
	public String myBookList(Model model,
							@AuthenticationPrincipal User user) {
		int mno = mdao.findByEmail(user.getUsername()).getMno();
		
		model.addAttribute("books", mbdao.myBookList(mno));
		
		return "member/myBookList";
	}
	
	@RequestMapping("/member/returnBook")
	public String returnBook(MemberBooksDTO mbdto,
							@AuthenticationPrincipal User user) {
		int mno = mdao.findByEmail(user.getUsername()).getMno();
		mbdto.setMno(mno);
		
		mbdao.memberBooksReturn(mbdto);
		bdao.bookStockIncrease(mbdto.getBno());
		
		return "redirect:/member/myBookList";
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
	
	// 도서 등록관리 (페이징 적용)
    @RequestMapping("/admin/bookList")
    public String bookList(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum, Model model) {
        int amount = 16; // 한 페이지당 보여줄 개수
        
        int startRow = (pageNum - 1) * amount + 1;
        int endRow = pageNum * amount;
        
        // DAO를 통해 페이징된 도서 목록과 전체 개수 가져오기
        List<BookDTO> books = bdao.bookListPaging(startRow, endRow);
        int total = bdao.getTotalCount();
        int totalPages = (int) Math.ceil((double) total / amount);
        
        // 5개 단위 페이징 계산
        int navSize = 5;
        int startPage = ((pageNum - 1) / navSize) * navSize + 1;
        int endPage = startPage + navSize - 1;
        
        if (endPage > totalPages) {
            endPage = totalPages;
        }
        
        // JSP로 데이터 전달
        model.addAttribute("books", books);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("totalPages", totalPages);
        
        return "admin/bookList";
    }
	
    // 관리자 도서 상세정보
    @RequestMapping("/admin/bookDetail")
	public String adminBookDetail(Model model, @RequestParam("bno") int bno) {
		model.addAttribute("book", bdao.bookDetail(bno));		
		return "admin/bookDetail";
	}
    
	// 도서 수정
	@RequestMapping("/admin/bookUpdateForm")
	public String bookUpdateForm(@RequestParam("bno") int bno, Model model) {
		model.addAttribute("update", bdao.bookDetail(bno));
		return "admin/bookUpdateForm";
	}
	
	@RequestMapping("/admin/bookUpdate")
	public String bookUpdate(BookDTO bdto) {
		bdao.bookUpdate(bdto);
		return "redirect:/admin/bookDetail?bno=" + bdto.getBno();
	}
	
	// 도서 삭제
	@RequestMapping("/admin/bookDelete")
	public String bookDelete(BookDTO bdto) {
		bdao.bookDelete(bdto.getBno());
		return "redirect:/admin/bookList";
	}
}
