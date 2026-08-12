package com.springboot.pageland.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.springboot.pageland.dao.IPassDAO;
import com.springboot.pageland.dto.PassDTO;

@Controller
public class PassController {
	@Autowired
	private IPassDAO pdao;
	
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
		
		return "redirect:/admin/main";
	}
}
