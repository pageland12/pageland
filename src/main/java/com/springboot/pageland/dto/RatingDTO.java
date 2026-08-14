package com.springboot.pageland.dto;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class RatingDTO {
	private int rno;
	private double rrate;
	private String rtitle;
	private String rcontent;
	private String rfiles;
	private MultipartFile rupload;
	private Date rdate;
	private int rhit;
	private int mno;
	private int bno;
	private int odno;
	private String mname;
	private String bimg;
	private String bname;
	private int bprice;
	private int cnt;
}
