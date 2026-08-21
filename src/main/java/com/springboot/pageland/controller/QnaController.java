package com.springboot.pageland.controller;

import java.io.File;
import java.io.IOException;
import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
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
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
    private IQnaDAO qnadao;

    @RequestMapping("/guest/qnaList")
    public String qnaList(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum, Model model) {
        int amount = 16; // 한 페이지당 16개 출력
        
        int startRow = (pageNum - 1) * amount + 1;
        int endRow = pageNum * amount;
        
        List<QnaDTO> qnaList = qnadao.qnaListPaging(startRow, endRow);
        int total = qnadao.getTotalCount();
        int totalPages = (int) Math.ceil((double) total / amount);
        
        // --- 하단 페이지 번호 계산 (5개 단위) ---
        int navSize = 5;
        int startPage = ((pageNum - 1) / navSize) * navSize + 1;
        int endPage = startPage + navSize - 1;
        
        if (endPage > totalPages) {
            endPage = totalPages;
        }
        
        model.addAttribute("qnaList", qnaList);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("totalPages", totalPages);
        
        return "guest/qnaList";
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
	        
	        // 저장 디렉터리 준비
	        File uploadDir = new File("C:\\pageland\\pageland_images\\");
	        if (!uploadDir.exists()) {
	            uploadDir.mkdirs();
	        }
	        
	        // 파일 저장
	        qupload.transferTo(new File(uploadDir, qfiles));
	        dto.setQfiles(qfiles);
	    }
		
		if ("공개글".equals(dto.getQsecret())) {
			dto.setQpasswd("-");
		}
		
		dto.setQpasswd(passwordEncoder.encode(dto.getQpasswd()));
			
		dao.qnaWrite(dto);
		
		return "redirect:/guest/qnaList";
	}
	
	@RequestMapping("/guest/qnaView")
	public String qnaView(HttpServletRequest request, Model model) {
		int qno = Integer.parseInt(request.getParameter("qno"));
		dao.qnaHit(qno);
		model.addAttribute("view", dao.qnaView(qno));
		
		return "guest/qnaView";
	}
	
	// 비밀번호 확인폼 (수정/삭제 공용)
	@RequestMapping("/board/qnaPasswordCheckForm")
	public String qnaPasswordCheckForm(HttpServletRequest request, Model model) {
		String mode = request.getParameter("mode");
	    int qno = Integer.parseInt(request.getParameter("qno"));
	    
	    model.addAttribute("qno", qno);
	    model.addAttribute("mode", mode);
	    
	    return "board/qnaPasswordCheckForm";
	}

	// 비밀번호 확인 처리
	@RequestMapping("/board/qnaPasswordCheck")
	public String qnaPasswordCheck(HttpServletRequest request, Model model) {
	    String mode = request.getParameter("mode");
	    int qno = Integer.parseInt(request.getParameter("qno"));
	    String qpasswd = request.getParameter("qpasswd");
		
	    QnaDTO dto = dao.qnaView(qno);
	    
	    if (dto != null && passwordEncoder.matches(qpasswd, dto.getQpasswd())) {
	        if ("update".equals(mode)) {
	            model.addAttribute("update", dto);
	            return "board/qnaUpdateForm";
	            
	        } else if ("delete".equals(mode)) {
	            dao.qnaDelete(qno);
	            return "redirect:/guest/qnaList";
	        } else if ("view".equals(mode)) {
	        	dao.qnaHit(qno);
	        	model.addAttribute("view", dto);
	        	return "guest/qnaView";
	        }
	    }
	    
	    model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
	    model.addAttribute("qno", qno);
	    model.addAttribute("mode", mode);
	    
	    return "board/qnaPasswordCheckForm";
	}
	
	@RequestMapping("/board/qnaDelete")
	public String qnaDelete(@RequestParam("qno") int qno) {
		dao.qnaDelete(qno);
		
		return "redirect:/guest/qnaList";
	}
	
	@RequestMapping("/board/qnaUpdateForm")
	public String qnaUpdateForm(@RequestParam("qno") int qno, Model model) {
		model.addAttribute("update", dao.qnaView(qno));
		
		return "board/qnaUpdateForm";
	}
	
	@RequestMapping("/board/qnaUpdate")
	public String qnaUpdate(@RequestParam(value = "qupload", required = false) MultipartFile qupload, QnaDTO dto) throws IOException {
		dto.setQpasswd(passwordEncoder.encode(dto.getQpasswd()));
		
		if (qupload != null && !qupload.isEmpty()) {
			String qfiles = qupload.getOriginalFilename();
	        
	        // 저장 디렉터리 준비
	        File uploadDir = new File("C:\\pageland\\pageland_images\\");
	        if (!uploadDir.exists()) {
	            uploadDir.mkdirs();
	        }
	        
	        // 파일 저장
	        qupload.transferTo(new File(uploadDir, qfiles));
	        dto.setQfiles(qfiles);
	    }
		
		dao.qnaUpdate(dto);
		
		return "redirect:/guest/qnaList";
	}
}
