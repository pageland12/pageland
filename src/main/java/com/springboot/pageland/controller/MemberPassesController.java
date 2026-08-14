package com.springboot.pageland.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.springboot.pageland.dao.IMemberPassesDAO;
import com.springboot.pageland.dto.MemberPassesDTO;

import jakarta.servlet.http.HttpServletRequest;


@Controller
public class MemberPassesController {
	@Autowired
	private IMemberPassesDAO dao;
	
	@RequestMapping("/member/myPassList")
	public String myPassList(HttpServletRequest request, Model model) {
		int mno = Integer.parseInt(request.getParameter("mno"));
		
		List<MemberPassesDTO> passList = dao.mbCheck(mno);
		
		model.addAttribute("passList", passList);
		
		return "member/myPassList";
	}
}
