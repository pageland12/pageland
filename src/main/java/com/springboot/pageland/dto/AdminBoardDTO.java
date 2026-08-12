package com.springboot.pageland.dto;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class AdminBoardDTO {
	private int abno;
	private String abtitle;
	private String abcontent;
	private String abfiles;
	private MultipartFile abupload;
	private Date abdate;
	private int abhit;
	private String abcategory;
	private int mno;
	private String mname;
}
