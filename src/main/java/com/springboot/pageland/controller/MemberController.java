package com.springboot.pageland.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springboot.pageland.dao.IMemberDAO;
import com.springboot.pageland.dto.MemberDTO;

@Controller
public class MemberController {
	@Autowired
	private IMemberDAO mdao;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@RequestMapping("/")
	public String root() {
		return "guest/main";
	}
	
	@RequestMapping("/main")
	public String main() {
		return "guest/main";
	}
	
	@RequestMapping("/guest/writeForm")
	public String writeForm() {
		return "guest/writeForm";
	}
	
	@RequestMapping("/guest/write")
	public String write(MemberDTO mdto,
						@RequestParam("mtel1") String mtel1,
						@RequestParam("mtel2") String mtel2,
						@RequestParam("mtel3") String mtel3,
						@RequestParam("maddr1") String maddr1,
						@RequestParam("maddr2") String maddr2,
						@RequestParam("mzipno") String mzipno,
						@RequestParam("maccount1") String maccount1,
						@RequestParam("maccount2") String maccount2,
						@RequestParam("maccount3") String maccount3
						) {
		mdto.setMtel(mtel1+"-"+mtel2+"-"+mtel3);
		mdto.setMaddr(maddr1+","+maddr2+","+mzipno);
		mdto.setMaccount(maccount1+","+maccount2+","+maccount3);

		mdto.setMpasswd(passwordEncoder.encode(mdto.getMpasswd()));
		
		mdao.memberInsert(mdto);
		return "redirect:/main";
	}
	
	@RequestMapping("/guest/jusoPopup")
	public String jusoPopup() {
		return "guest/jusoPopup";
	}
	
	@RequestMapping("/loginForm")
	public String loginForm() {
		return "guest/loginForm";
	}
	
	@RequestMapping("/loginError")
	public String loginError(Model model) {
		model.addAttribute("msg", "이메일과 비밀번호를 확인해주세요.");
	    return "guest/loginForm"; // 바로 loginForm.jsp를 뿌려줌
	}
	
	@RequestMapping("/logout")
	public String logout() {
		return "logout";
	}	
	
	// 마이페이지
	@RequestMapping("/member/main")
	public String membermain() {
		return "member/memberMain";
	}
	
	// 회원 수정폼
	@RequestMapping("/member/memberUpdateForm")
	public String memberUpdateForm(@RequestParam("mno") int mno, Model model) {
		model.addAttribute("update", mdao.memberView(mno));
		return "member/memberUpdateForm";
	}
	
	// 회원 탈퇴
	@RequestMapping("/member/memberdelete")
	public String deleteForm(@RequestParam("mno") int mno) {
		mdao.memberDelete(mno);
		return "redirect:/main";
	}
	
	// 관리자페이지
	@RequestMapping("/admin/main")
	public String adminMain() {
		return "admin/adminMain";
	}
	
	// 관리자 신규도서 등록 폼
	@RequestMapping("/admin/bookWriteForm")
	public String bookWriteForm() {
		return "admin/bookWriteForm";
	}
	
}
