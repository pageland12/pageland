package com.springboot.pageland.dto;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class QnaDTO {
	private int qno;
	private String qtitle;
	private String qcontent;
	private String qfiles;
	private MultipartFile qupload;
	private String qpasswd;
	private String qsecret;
	private Date qdate;
	private int qhit;
	private int mno;
	private String memail;
	private String mname;
}
