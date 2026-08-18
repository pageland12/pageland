package com.springboot.pageland.controller;

import java.io.File;
import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.springboot.pageland.dao.IMemberDAO;
import com.springboot.pageland.dao.IRatingDAO;
import com.springboot.pageland.dto.MemberDTO;
import com.springboot.pageland.dto.RatingDTO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class RatingController {
	@Autowired
	private IRatingDAO dao;
	
	@Autowired
	private IMemberDAO mDao;
	
	@RequestMapping("/member/myOrderBookList")
	public String myOrderBookList(@AuthenticationPrincipal User user, Model model) {
		if (user == null) {
			return "redirect:/loginForm";
		}
		
		int mno = mDao.findByEmail(user.getUsername()).getMno();
		List<RatingDTO> orderList = dao.ratingCheck(mno);
		
		model.addAttribute("orderList", orderList);
		return "member/myOrderBookList";
	}
	
	// --- 페이징 적용된 후기 목록 ---
	@RequestMapping("/guest/ratingList")
	public String ratingList(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum, Model model) {
		int amount = 16; // 한 페이지당 16개 출력
		
		int startRow = (pageNum - 1) * amount + 1;
		int endRow = pageNum * amount;
		
		List<RatingDTO> list = dao.ratingListPaging(startRow, endRow);
		int total = dao.getTotalCount();
		int totalPages = (int) Math.ceil((double) total / amount);
		
		// 하단 페이지 번호 계산 (5개 단위)
		int navSize = 5;
		int startPage = ((pageNum - 1) / navSize) * navSize + 1;
		int endPage = startPage + navSize - 1;
		
		if (endPage > totalPages) {
			endPage = totalPages;
		}
		
		model.addAttribute("list", list);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("totalPages", totalPages);
		
		return "guest/ratingList";
	}
	
	@RequestMapping("/board/ratingWriteForm")
	public String ratingWriteForm(@ModelAttribute("rating") RatingDTO dto, @AuthenticationPrincipal User user) {
		if (user == null) {
			return "redirect:/loginForm";
		}
		
		int mno = mDao.findByEmail(user.getUsername()).getMno();
		dto.setMno(mno);
		
		return "board/ratingWriteForm";
	}
	
	@RequestMapping("/board/ratingWrite")
	public String ratingWrite(@RequestParam(value = "rupload", required = false) MultipartFile rupload, Principal principal, RatingDTO dto) throws Exception {
		String memail = principal.getName();
		
		MemberDTO mDto = mDao.findByEmail(memail);
		
		dto.setMno(mDto.getMno());
		
		if (rupload != null && !rupload.isEmpty()) {
			String rfiles = rupload.getOriginalFilename();
			rupload.transferTo(new File("C:\\pageland\\src\\main\\resources\\static\\images\\" + rfiles));
			dto.setRfiles(rfiles);
		}
		
		dao.ratingWrite(dto);
		
		return "redirect:/guest/ratingList";
	}
	
	@RequestMapping("/guest/ratingView")
	public String ratingView(HttpServletRequest request, Model model) {
		int rno = Integer.parseInt(request.getParameter("rno"));
		dao.ratingHit(rno);
		model.addAttribute("view", dao.ratingView(rno));
		
		return "guest/ratingView";
	}
	
	@RequestMapping("/board/ratingDelete")
	public String ratingDelete(@RequestParam("rno") int rno) {
		dao.ratingDelete(rno);
		
		return "redirect:/guest/ratingList";
	}
	
	@RequestMapping("/board/ratingUpdateForm")
	public String ratingUpdateForm(@RequestParam("rno") int rno, Principal principal, Model model) {
		if (principal == null) {
			return "redirect:/loginForm";
		}
		
		RatingDTO dto = dao.ratingView(rno);
		String memail = principal.getName();
		
		model.addAttribute("update", dto);
		return "board/ratingUpdateForm";
	}
	
	@RequestMapping("/board/ratingUpdate")
	public String ratingUpdate(@RequestParam(value = "rupload", required = false) MultipartFile rupload, Principal principal, RatingDTO dto) throws Exception {
		String memail = principal.getName();
		
		MemberDTO mDto = mDao.findByEmail(memail);
		
		dto.setMno(mDto.getMno());
		
		if (rupload != null && !rupload.isEmpty()) {
	        String rfiles = rupload.getOriginalFilename();
	        rupload.transferTo(new File("C:\\pageland\\src\\main\\resources\\static\\images\\" + rfiles));
	        dto.setRfiles(rfiles);
	    }
		
		dao.ratingUpdate(dto);
		
		return "redirect:/guest/ratingList";
	}
	
}
