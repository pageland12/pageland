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
			
			// 대여 도서가 3권이면 장바구니 등록 X
			int currentRentCount = mbdao.activeRentBooksCount(mno);
	        if (currentRentCount >= 3) {
	            model.addAttribute("msg", "동시 대여는 최대 3권까지만 가능합니다.\\n(현재 대여 중인 도서: " + currentRentCount + "권)");
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
			
			// 장바구니에 담겨있는 도서 + 대여 도서가 3권이면 장바구니 등록 X
			int CurrentCartBookCount = cdao.getTotalCountByMnoCtype(mno);
			int bookCount = CurrentCartBookCount + currentRentCount;
			if (bookCount >= 3) {
				model.addAttribute("msg", "동시 대여는 최대 3권까지만 가능합니다.\\n(현재 대여 중인 도서: " + currentRentCount + "권)"
											+ "\\n(현재 장바구니에 담긴 도서: " + CurrentCartBookCount + "권)");
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