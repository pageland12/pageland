package com.springboot.pageland.dto;

import lombok.Data;

@Data
public class CartDTO {
	private	int			cno;
	private	String		ctype;
	private	int			cstock;
	private	int			mno;
	private	Integer	 	bno;
	private String 		bname;
	private int 		bprice;
	private	String		bimg;
	private	Integer		pno;
	private String		pname;
	private int			pprice;
	private	String		pimg;
	private String		ptype;
}
