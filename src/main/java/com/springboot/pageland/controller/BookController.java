package com.springboot.pageland.controller;

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

@Controller
public class BookController {
	@Autowired
	private IBookDAO bdao;
	
	@Autowired
	private IMemberDAO mdao;
	
	@Autowired
	private IMemberBooksDAO mbdao;
	
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
	
	@RequestMapping("/member/myBookList")
	public String myBookList(Model model,
							@AuthenticationPrincipal User user) {
		int mno = mdao.findByEmail(user.getUsername()).getMno();
		
		model.addAttribute("books", mbdao.myBookList(mno));
		
		return "member/myBookList";
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
}
