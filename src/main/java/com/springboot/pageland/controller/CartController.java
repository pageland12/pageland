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
import com.springboot.pageland.dao.ICartDAO;
import com.springboot.pageland.dao.IMemberDAO;
import com.springboot.pageland.dao.IPassDAO;
import com.springboot.pageland.dto.CartDTO;

@Controller
public class CartController {
	@Autowired
	private ICartDAO cdao;
	
	@Autowired
	private IBookDAO bdao;

	@Autowired
	private IPassDAO pdao;
	
	@Autowired
	private IMemberDAO mdao;
	
	@RequestMapping("/member/cartInsert")
	public String cartInsert(Model model, CartDTO cdto,
							@AuthenticationPrincipal User user) {
		String memberEmail = user.getUsername();
		int mno = mdao.findByEmail(memberEmail).getMno();
		cdto.setMno(mno);
		
		cdao.cartInsert(cdto);
		
		if (cdto.getBno() != null) {
			model.addAttribute("book", bdao.bookDetail(cdto.getBno()));
			
			return "guest/bookDetail";
		} else {
			model.addAttribute("pass", pdao.passDetail(cdto.getPno()));
			
			return "guest/passDetail";
		}
	}
	
	// --- 페이징이 추가된 장바구니 목록 ---
	@RequestMapping("/cart/cartList")
	public String cartList(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
						   Model model,
						   @AuthenticationPrincipal User user) {
		if (user == null) {
			return "redirect:/loginForm";
		}
		
		String memberEmail = user.getUsername();
		int mno = mdao.findByEmail(memberEmail).getMno();
		
		int amount = 16; // 한 페이지당 16개 출력
		int startRow = (pageNum - 1) * amount + 1;
		int endRow = pageNum * amount;
		
		List<CartDTO> carts = cdao.mcartListPaging(mno, startRow, endRow);
		int total = cdao.getTotalCountByMno(mno);
		int totalPages = (int) Math.ceil((double) total / amount);
		
		// 5개 단위 페이지 번호 구하기
		int navSize = 5;
		int startPage = ((pageNum - 1) / navSize) * navSize + 1;
		int endPage = startPage + navSize - 1;
		if (endPage > totalPages) {
			endPage = totalPages;
		}
		
		model.addAttribute("carts", carts);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("totalPages", totalPages);
		
		return "cart/cartList";
	}
	
	@RequestMapping("/cart/cartDelete")
	public String cartDelete(@RequestParam("cno") int cno) {
		cdao.cartDelete(cno);
		
		return "redirect:/cart/cartList";
	}
}