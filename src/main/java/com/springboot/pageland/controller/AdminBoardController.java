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

import com.springboot.pageland.dao.IAdminBoardDAO;
import com.springboot.pageland.dao.IMemberDAO;
import com.springboot.pageland.dto.AdminBoardDTO;
import com.springboot.pageland.dto.MemberDTO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class AdminBoardController {
	@Autowired
	private IAdminBoardDAO dao;
	
	@Autowired
	private IMemberDAO mDao;
	
	@RequestMapping("/guest/noticeList")
	public String noticeList(Model model) {
		model.addAttribute("notice", dao.noticeList());
		
		return "guest/noticeList";
	}
	
	@RequestMapping("/guest/eventList")
	public String eventList(Model model) {
		model.addAttribute("event", dao.eventList());
		
		return "guest/eventList";
	}
	
	@RequestMapping("/admin/abWriteForm")
	public String abWriteForm() {
		return "admin/abWriteForm";
	}
	
	@RequestMapping("/admin/abWrite")
	public String abWrite(@RequestParam(value = "abupload", required = false) MultipartFile abupload, Principal principal, AdminBoardDTO dto) throws Exception {
		String memail = principal.getName();
		
		MemberDTO mDto = mDao.findByEmail(memail);
		
		dto.setMno(mDto.getMno());
				
		if (abupload != null && !abupload.isEmpty()) {
	        String abfiles = abupload.getOriginalFilename();
	        abupload.transferTo(new File("C:\\pageland\\src\\main\\resources\\static\\images\\" + abfiles));
	        dto.setAbfiles(abfiles);
	    }
			
		dao.abWrite(dto);
		
		if (dto != null && dto.getAbcategory().equals("NOTICE")) {
	        return "redirect:/guest/noticeList";
	    } 
		
		return "redirect:/guest/eventList";
	}
	
	@RequestMapping("/guest/abView")
	public String abView(HttpServletRequest request, Model model) {
		int abno = Integer.parseInt(request.getParameter("abno"));
		dao.abHit(abno);
		model.addAttribute("view", dao.abView(abno));
		
		return "guest/abView";
	}
	
	@RequestMapping("/admin/abDelete")
	public String abDelete(@RequestParam("abno") int abno) {
		AdminBoardDTO dto = dao.abView(abno);
		
		dao.abDelete(abno);
		
		if (dto != null && dto.getAbcategory().equals("NOTICE")) {
	        return "redirect:/guest/noticeList";
	    } 
		
		return "redirect:/guest/eventList";
	}
	
	@RequestMapping("/admin/abUpdateForm")
	public String abUpdateForm(@RequestParam("abno") int abno, Model model) {
		model.addAttribute("update", dao.abView(abno));
		
		return "admin/abUpdateForm";
	}
	
	@RequestMapping("/admin/abUpdate")
	public String abUpdate(@RequestParam(value = "abupload", required = false) MultipartFile abupload, AdminBoardDTO dto) throws IOException {
		if (abupload != null && !abupload.isEmpty()) {
	        String abfiles = abupload.getOriginalFilename();
	        abupload.transferTo(new File("C:\\pageland\\src\\main\\resources\\static\\images\\" + abfiles));
	        dto.setAbfiles(abfiles);
	    }
		
		dao.abUpdate(dto);
		
		if (dto != null && dto.getAbcategory().equals("NOTICE")) {
	        return "redirect:/guest/noticeList";
	    } 
		
		return "redirect:/guest/eventList";
	}
}
