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
