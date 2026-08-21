package com.springboot.pageland.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.List;

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
	public String noticeList(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum, Model model) {
	    int amount = 16; // 한 페이지당 16개 출력
	    
	    int startRow = (pageNum - 1) * amount + 1;
	    int endRow = pageNum * amount;
	    
	    List<AdminBoardDTO> noticeList = abdao.noticeListPaging(startRow, endRow);
	    int total = abdao.getNoticeTotalCount();
	    int totalPages = (int) Math.ceil((double) total / amount);
	    
	    // --- 하단 페이지 번호 계산 (5개 단위) ---
	    int navSize = 5;
	    int startPage = ((pageNum - 1) / navSize) * navSize + 1;
	    int endPage = startPage + navSize - 1;
	    
	    if (endPage > totalPages) {
	        endPage = totalPages;
	    }
	    
	    model.addAttribute("notice", noticeList);
	    model.addAttribute("pageNum", pageNum);
	    model.addAttribute("startPage", startPage);
	    model.addAttribute("endPage", endPage);
	    model.addAttribute("totalPages", totalPages);
	    
	    return "guest/noticeList";
	}
	
	@Autowired
    private IAdminBoardDAO abdao; // IAdminBoardDAO로 주입

    @RequestMapping("/guest/eventList")
    public String eventList(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum, Model model) {
        int amount = 16; // 한 페이지당 16개 출력
        
        int startRow = (pageNum - 1) * amount + 1;
        int endRow = pageNum * amount;
        
        List<AdminBoardDTO> eventList = abdao.eventListPaging(startRow, endRow);
        int total = abdao.getTotalCount();
        int totalPages = (int) Math.ceil((double) total / amount);
        
        // --- 하단 페이지 번호 계산 (5개 단위) ---
        int navSize = 5;
        int startPage = ((pageNum - 1) / navSize) * navSize + 1;
        int endPage = startPage + navSize - 1;
        
        if (endPage > totalPages) {
            endPage = totalPages;
        }
        
        model.addAttribute("event", eventList);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("totalPages", totalPages);
        
        return "guest/eventList";
    }
	
	@RequestMapping("/admin/abWriteForm")
	public String abWriteForm(@RequestParam(value = "category", required = false, defaultValue = "NOTICE") String category, Model model) {
		model.addAttribute("category", category);
		
		return "admin/abWriteForm";
	}
	
	@RequestMapping("/admin/abWrite")
	public String abWrite(@RequestParam(value = "abupload", required = false) MultipartFile abupload, Principal principal, AdminBoardDTO dto) throws Exception {
		String memail = principal.getName();
		
		MemberDTO mDto = mDao.findByEmail(memail);
		
		dto.setMno(mDto.getMno());
				
		if (abupload != null && !abupload.isEmpty()) {
			String abfiles = abupload.getOriginalFilename();
	        
	        // 저장 디렉터리 준비
	        File uploadDir = new File("C:\\pageland_images\\");
	        if (!uploadDir.exists()) {
	            uploadDir.mkdirs();
	        }
	        
	        // 파일 저장
	        abupload.transferTo(new File(uploadDir, abfiles));
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
	        
	        // 저장 디렉터리 준비
	        File uploadDir = new File("C:\\pageland_images\\");
	        if (!uploadDir.exists()) {
	            uploadDir.mkdirs();
	        }
	        
	        // 파일 저장
	        abupload.transferTo(new File(uploadDir, abfiles));
	        dto.setAbfiles(abfiles);
	    }
		
		dao.abUpdate(dto);
		
		if (dto != null && dto.getAbcategory().equals("NOTICE")) {
	        return "redirect:/guest/noticeList";
	    } 
		
		return "redirect:/guest/eventList";
	}
}
