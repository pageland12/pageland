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
			pdto.setPcount("-");
		} else if (pdto.getPtype() == "N회권") {
			pdto.setPperiod("-");
		}
		
		pdao.passInsert(pdto);
		
		return "redirect:/admin/adminMain";
	}
}
