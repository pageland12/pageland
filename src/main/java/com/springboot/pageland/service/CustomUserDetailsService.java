package com.springboot.pageland.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.springboot.pageland.dao.IMemberDAO;
import com.springboot.pageland.dao.IMemberPassesDAO;
import com.springboot.pageland.dto.MemberDTO;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private IMemberDAO dao;
    
    @Autowired
    private IMemberPassesDAO mpdao;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // 1. WebSecurityConfig의 usernameParameter("memail")에 의해 memail 값이 username 매개변수로 들어옴
        MemberDTO dto = dao.findByEmail(username);
        
        // 2. 사용자가 존재하지 않을 경우 처리
        if (dto == null) {
            throw new UsernameNotFoundException("존재하지 않는 사용자입니다: " + username);
        }
        
        // 3. 만료일이 지난 정기권 만료 처리
        mpdao.expiredSubscriberPassesUpdate(dto.getMno());
        
        // 4. 현재 유효한 정기권 보유 개수 확인
        int activePassCount = mpdao.activeSubcriberPassesCount(dto.getMno());
        
        // 5-1. DB 권한(mgrade)이 "ROLE_USER" 형태일 때 Safe하게 적용해 가져오기
        String currentGrade = dto.getMgrade();
        if (currentGrade != null && currentGrade.startsWith("ROLE_")) {
            currentGrade = currentGrade.substring(5);
        }
        
        // 5-2. 유효 정기권이 없는데 SUBSCRIBER인 경우 NORMAL로 변경
        // equalsIgnoreCase: 대소문자 무시
        if (activePassCount == 0 && "SUBSCRIBER".equalsIgnoreCase(currentGrade)) {
            dto.setMgrade("NORMAL");
        	dao.memberGradeUpdate(dto);
            currentGrade = "NORMAL";
        }
        
        // 5-3. 유효 정기권이 있는데 NORMAL인 경우 SUBSCRIBER로 변경
        if (activePassCount > 0 && "NORMAL".equalsIgnoreCase(currentGrade)) {
        	dto.setMgrade("SUBSCRIBER");
        	dao.memberGradeUpdate(dto);
        	currentGrade = "SUBSCRIBER";
        }
        
        // 6. Spring Security 인증용 UserDetails 객체 생성 반환
        return User.builder()
                .username(dto.getMemail())   // 로그인 아이디 (memail)
                .password(dto.getMpasswd())  // DB에 저장된 암호화된 비밀번호
                .roles(currentGrade) // 기본 권한 지정
                .build();
    }
}