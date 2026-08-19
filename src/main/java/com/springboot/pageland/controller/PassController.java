package com.springboot.pageland.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springboot.pageland.dao.IPassDAO;
import com.springboot.pageland.dto.PassDTO;

@Controller
public class PassController {
	@Autowired
	private IPassDAO pdao;
	
	@RequestMapping("/guest/passDetail")
	public String passDetail(Model model, @RequestParam("pno") int pno) {
		model.addAttribute("pass", pdao.passDetail(pno));
		
		return "guest/passDetail";
	}
	
	@RequestMapping("/admin/passWriteForm")
	public String passWriteForm() {
		return "admin/passWriteForm";
	}
	
	@RequestMapping("/admin/passWrite")
	public String passWrite(PassDTO pdto) {
		if (pdto.getPtype() == "정기권") {
			pdto.setPcount(null);
		} else if (pdto.getPtype() == "N회권") {
			pdto.setPperiod(null);
		}
		
		pdao.passInsert(pdto);
		
		return "redirect:/admin/adminMain";
	}
	
	// 등록 구독권 관리
	@RequestMapping("/admin/passList")
	public String adminPassList(Model model) {
		model.addAttribute("pass", pdao.passList());
		return "admin/passList";
	}
	
	// 등록 구독권 상세정보
	@RequestMapping("/admin/passDetail")
	public String adminPassDetail(Model model, @RequestParam("pno") int pno) {
		model.addAttribute("pass", pdao.passDetail(pno));
		return "admin/passDetail";
	}
	
	// 구독권 수정폼
	@RequestMapping("/admin/passUpdateForm")
	public String passUpdateForm(Model model, @RequestParam("pno") int pno) {
		model.addAttribute("update", pdao.passDetail(pno));
		return "admin/passUpdateForm";
	}
	
	// 구독권 수정
	@RequestMapping("/admin/passUpdate")
	public String passUpdate(PassDTO pdto) {
		pdao.passUpdate(pdto);
		return "redirect:/admin/passDetail?pno=" + pdto.getPno();
	}
	
	// 구독권 삭제
	@RequestMapping("/admin/passDelete")
	public String passDelete(@RequestParam("pno") int pno) {
		pdao.passDelete(pno);
		return "redirect:/admin/passList";
	}	
	
	@RequestMapping("/guest/allPassList")
	public String allPassList(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum, Model model) {
	    int amount = 16; // 한 페이지당 16개 출력
	    
	    int startRow = (pageNum - 1) * amount + 1;
	    int endRow = pageNum * amount;
	    
	    List<PassDTO> passes = pdao.passListPaging(startRow, endRow);
	    int total = pdao.getTotalCount();
	    int totalPages = (int) Math.ceil((double) total / amount);
	    
	    // --- 화면 하단 페이지 번호 개수 (최대 5개) ---
	    int navSize = 5;
	    int startPage = ((pageNum - 1) / navSize) * navSize + 1;
	    int endPage = startPage + navSize - 1;
	    
	    if (endPage > totalPages) {
	        endPage = totalPages;
	    }
	    
	    model.addAttribute("passes", passes);
	    model.addAttribute("pageNum", pageNum);
	    model.addAttribute("startPage", startPage);
	    model.addAttribute("endPage", endPage);
	    model.addAttribute("totalPages", totalPages);
	    
	    return "guest/allPassList";
	}
}
