package com.springboot.pageland.dto;

import java.time.LocalDate;

import lombok.Data;

@Data
public class MemberPassesDTO {
	private	int			mpno;
	private	Integer		mpcount;
	private	LocalDate	mpstart;
	private	LocalDate	mpend;
	private	String		mpstatus;
	private	int			mno;
	private	String		olno;
	private	int			pno;
	private String		pname;
	private String		pimg;
	private String		ptype;
	private int			daysLeft;
}
