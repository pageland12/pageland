package com.springboot.pageland.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	
	@RequestMapping("/guest/ratingList")
	public String ratingList(Model model) {
		model.addAttribute("list", dao.ratingList());
		
		return "guest/ratingList";
	}
	
	@RequestMapping("/board/ratingWriteForm")
	public String ratingWriteForm(HttpServletRequest request, Model model, RatingDTO dto) {
		int odno = Integer.parseInt(request.getParameter("odno"));
		int bno = Integer.parseInt(request.getParameter("bno"));
		String bname = request.getParameter("bname");
		String bimg = request.getParameter("bimg");
		int bprice = Integer.parseInt(request.getParameter("bprice"));
		
		dto.setOdno(odno);
		dto.setBno(bno);
		dto.setBname(bname);
		dto.setBimg(bimg);
		dto.setBprice(bprice);
		
		model.addAttribute("rating", dto);
		
		
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
		model.addAttribute("view", dao.ratingView(rno));
		
		dao.ratingView(rno);
		
		return "guest/ratingView";
	}
	
	@RequestMapping("/board/ratingDelete")
	public String ratingDelete(@RequestParam("rno") int rno) {
		dao.ratingDelete(rno);
		
		return "redirect:/guest/ratingList";
	}
	
}
