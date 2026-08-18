package com.springboot.pageland.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springboot.pageland.dao.IMemberDAO;
import com.springboot.pageland.dao.IMemberPassesDAO;
import com.springboot.pageland.dto.MemberPassesDTO;

@Controller
public class MemberPassesController {
	@Autowired
	private IMemberPassesDAO mpdao;
	
	@Autowired
	private IMemberDAO mdao;
	
	@RequestMapping("/member/myPassList")
	public String myPassList(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
							 Model model,
							 @AuthenticationPrincipal User user) {
		if (user == null) {
			return "redirect:/loginForm";
		}
		
		int mno = mdao.findByEmail(user.getUsername()).getMno();
		
		int amount = 16; // 한 페이지당 16개 출력
		int startRow = (pageNum - 1) * amount + 1;
		int endRow = pageNum * amount;
		
		List<MemberPassesDTO> passList = mpdao.mbCheckPaging(mno, startRow, endRow);
		int total = mpdao.getTotalCountByMno(mno);
		int totalPages = (int) Math.ceil((double) total / amount);
		
		// 5개 단위 페이지 번호 구하기
		int navSize = 5;
		int startPage = ((pageNum - 1) / navSize) * navSize + 1;
		int endPage = startPage + navSize - 1;
		if (endPage > totalPages) {
			endPage = totalPages;
		}
		
		model.addAttribute("passList", passList);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("startPage", startPage);
		model.addAttribute("endPage", endPage);
		model.addAttribute("totalPages", totalPages);
		
		return "member/myPassList";
	}
}