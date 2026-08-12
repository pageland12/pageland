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
import com.springboot.pageland.dao.IQnaDAO;
import com.springboot.pageland.dto.MemberDTO;
import com.springboot.pageland.dto.QnaDTO;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class QnaController {
	@Autowired
	private IQnaDAO dao;
	
	@Autowired
	private IMemberDAO mDao;
	
	@RequestMapping("/board/qnaList")
	public String qnaList(Model model) {
		model.addAttribute("qnaList", dao.qnaList());
	
		return "board/qnaList";
	}
	
	@RequestMapping("/board/qnaWriteForm")
	public String qnaWriteForm() {
		return "board/qnaWriteForm";
	}
	
	@RequestMapping("/board/qnaWrite")
	public String qnaWrite(@RequestParam(value = "qupload", required = false) MultipartFile qupload, Principal principal, QnaDTO dto) throws Exception {
		String memail = principal.getName();
		
		MemberDTO mDto = mDao.findByEmail(memail);
		
		dto.setMno(mDto.getMno());
				
		if (qupload != null && !qupload.isEmpty()) {
	        String qfiles = qupload.getOriginalFilename();
	        qupload.transferTo(new File("C:\\pageland\\src\\main\\resources\\static\\images\\" + qfiles));
	        dto.setQfiles(qfiles);
	    }
			
		dao.qnaWrite(dto);
		
		return "redirect:/board/qnaList";
	}
	
	@RequestMapping("/board/qnaView")
	public String qnaView(HttpServletRequest request, Model model) {
		int qno = Integer.parseInt(request.getParameter("qno"));
		model.addAttribute("view", dao.qnaView(qno));
		
		return "board/qnaView";
	}
	
	@RequestMapping("/board/qnaDelete")
	public String qnaDelete(@RequestParam("qno") int qno) {
		dao.qnaDelete(qno);
		
		return "redirect:/board/qnaList";
	}
	
	@RequestMapping("/board/qnaUpdateForm")
	public String qnaUpdateForm(@RequestParam("qno") int qno, Model model) {
		model.addAttribute("update", dao.qnaView(qno));
		
		return "board/qnaUpdateForm";
	}
	
	@RequestMapping("/board/qnaUpdate")
	public String qnaUpdate(@RequestParam(value = "qupload", required = false) MultipartFile qupload, QnaDTO dto) throws IOException {
		if (qupload != null && !qupload.isEmpty()) {
	        String qfiles = qupload.getOriginalFilename();
	        qupload.transferTo(new File("C:\\pageland\\src\\main\\resources\\static\\images\\" + qfiles));
	        dto.setQfiles(qfiles);
	    }
		
		dao.qnaUpdate(dto);
		
		return "redirect:/board/qnaList";
	}
}
