package com.springboot.pageland.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springboot.pageland.dao.IBookDAO;
import com.springboot.pageland.dao.ICartDAO;
import com.springboot.pageland.dao.IMemberBooksDAO;
import com.springboot.pageland.dao.IMemberDAO;
import com.springboot.pageland.dao.IPassDAO;
import com.springboot.pageland.dto.CartDTO;
import com.springboot.pageland.dto.MemberBooksDTO;

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
	
	@Autowired
	private IMemberBooksDAO mbdao;
	
	@RequestMapping("/member/cartInsert")
	public String cartInsert(Model model, CartDTO cdto,
							@AuthenticationPrincipal User user) {
		String memberEmail = user.getUsername();
		int mno = mdao.findByEmail(memberEmail).getMno();
		
		if (cdto.getBno() != null && cdto.getBno() > 0) {
			// 연체 중이면 장바구니 등록 X
			if (mbdao.overdueBooksCount(mno) > 0) {
				model.addAttribute("msg", "현재 연체 중인 도서가 있습니다. 연체료 정산 및 반납 후 이용해 주세요.");
				model.addAttribute("book", bdao.bookDetail(cdto.getBno()));
					
				return "guest/bookDetail";
			}
			
			// 이미 대여 중인 도서는 장바구니 등록 X
			MemberBooksDTO rentCheck = new MemberBooksDTO();
			rentCheck.setMno(mno);
			rentCheck.setBno(cdto.getBno());
			if (mbdao.memberBooksDetail(rentCheck) != null) {
				model.addAttribute("msg", "이미 대여 중이거나 대여 진행 중인 도서입니다.");
				model.addAttribute("book", bdao.bookDetail(cdto.getBno()));
					
				return "guest/bookDetail";
			}
			
			// 이미 장바구니에 추가되어 있는 도서는 장바구니 등록 X
			CartDTO cartCheck = new CartDTO();
			cartCheck.setMno(mno);
			cartCheck.setBno(cdto.getBno());
			if (cdao.cartDetail(cartCheck) != null) {
				model.addAttribute("msg", "이미 장바구니에 담겨있는 도서입니다.");
				model.addAttribute("book", bdao.bookDetail(cdto.getBno()));
					
				return "guest/bookDetail";
			}
		}
		
		cdto.setMno(mno);
		
		cdao.cartInsert(cdto);
		
		model.addAttribute("msg", "장바구니에 담겼습니다.");
		
		if (cdto.getBno() != null) {
			model.addAttribute("book", bdao.bookDetail(cdto.getBno()));
			
			return "guest/bookDetail";
		} else {
			model.addAttribute("pass", pdao.passDetail(cdto.getPno()));
			
			return "guest/passDetail";
		}
	}
	
	@RequestMapping("/cart/cartList")
	public String cartList(Model model,
						@AuthenticationPrincipal User user) {
		String memberEmail = user.getUsername();
		int mno = mdao.findByEmail(memberEmail).getMno();
		
		CartDTO cdto = new CartDTO();
		
		cdto.setMno(mno);
		
		model.addAttribute("carts", cdao.mcartList(mno));
		
		return "cart/cartList";
	}
	
	@RequestMapping("/cart/cartDelete")
	public String cartDelete(@RequestParam("cno") int cno) {
		cdao.cartDelete(cno);
		
		return "redirect:/cart/cartList";
	}
}
