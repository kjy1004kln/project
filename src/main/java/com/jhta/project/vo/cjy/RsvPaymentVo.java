package com.jhta.project.vo.cjy;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data

public class RsvPaymentVo {
	private int rid;
	private int rordernum;
	private int ramount;
	private String rcheckin;
	private String rcheckout;
	private String rresname;
	private String rresphone;
	private String rresemail;
	private int rexbreaknum;
	private int rexbed;
	private int rexperson;
	private String rcancel;
	private String mid;
	private int riid;
	private String pmethod;
	//@DateTimeFormat(pattern="yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	private Date pdate;
	private int ptotal;
	private String prefund;
}
