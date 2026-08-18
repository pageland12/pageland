package com.springboot.pageland.dto;

import java.time.LocalDate;

import lombok.Data;

@Data
public class MyBoardDTO {
	private String 		btype;     // 게시판 분류 ("QNA", "REVIEW")
    private int 		bno;          // 글 번호 (qno 또는 rno)
    private String 		title;     // 제목 (qtitle 또는 rtitle)
    private LocalDate 	regdate;     // 작성일 (qdate 또는 rdate)
    private int 		hit;          // 조회수 (qhit 또는 rhit)
    private String 		extraInfo; // 부가정보 (QNA: 비밀글여부, REVIEW: 평점 또는 도서명)
}