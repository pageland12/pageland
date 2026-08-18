package com.springboot.pageland.controller;

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
	
	@RequestMapping("/guest/allPassList")
	public String passList(Model model) {
		model.addAttribute("passes", pdao.passList());
		
		return "guest/allPassList";
	}
	
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
}
