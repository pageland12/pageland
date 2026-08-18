package com.springboot.pageland.auth;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.springboot.pageland.dao.IMemberBooksDAO;
import com.springboot.pageland.dao.IMemberDAO;
import com.springboot.pageland.dto.MemberDTO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class CustomAuthSuccessHandler implements AuthenticationSuccessHandler{
	@Autowired 
	private IMemberDAO mdao;
	
	@Autowired
	private IMemberBooksDAO mbdao;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
            							Authentication authentication) throws IOException, ServletException {
        
        String email = authentication.getName();
        MemberDTO member = mdao.findByEmail(email);
        
        if (member != null) {
            int overdueCount = mbdao.overdueBooksCount(member.getMno());
            
            // 연체 도서가 있다면 세션에 건수 및 총 연체료 저장
            if (overdueCount > 0) {
                int lateFee = mbdao.memberLateFeeTotal(member.getMno());
                HttpSession session = request.getSession();
                session.setAttribute("overdueCount", overdueCount);
                session.setAttribute("overdueFee", lateFee);
            }
        }
        
        // 로그인 성공 후 메인 페이지로 이동
        response.sendRedirect("/main");
    }
}
