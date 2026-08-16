package com.springboot.pageland.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
	public String myPassList(Model model,
							@AuthenticationPrincipal User user) {
		int mno = mdao.findByEmail(user.getUsername()).getMno();
		
		List<MemberPassesDTO> passList = mpdao.mbCheck(mno);
		
		model.addAttribute("passList", passList);
		
		return "member/myPassList";
	}
}
