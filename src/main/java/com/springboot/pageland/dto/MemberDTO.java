package com.springboot.pageland.dto;

import java.util.Date;

import lombok.Data;

@Data
public class MemberDTO {
	private int mno;
	private String memail;
	private String mpasswd;
	private String mname;
	private String maddr;
	private String mtel;
	private String maccount;
	private String mgrade;
	private Date mdate;
	private int mpoint;
}