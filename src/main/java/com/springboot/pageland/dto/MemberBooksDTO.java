package com.springboot.pageland.dto;

import java.time.LocalDate;

import lombok.Data;

@Data
public class MemberBooksDTO {
	private	int			mbno;
	private	LocalDate	mbstart;
	private	LocalDate	mbend;
	private	LocalDate	mbreturn;
	private	int			mbextension;
	private	int			mblatedate;
	private	int			mblatefee;
	private	String		mbstatus;
	private	int			mno;
	private	String		olno;
	private	int			bno;
	private	int			bprice;
	private String		bname;
	private String		bimg;
	private	Integer		mpno;
}
