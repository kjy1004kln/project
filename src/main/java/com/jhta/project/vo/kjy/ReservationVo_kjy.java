package com.jhta.project.vo.kjy;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ReservationVo_kjy {
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
	
	//룸정보
	private String riroomtype;
	private String rimainimg;
	//결제정보
	private int pid;
	private String pmethod;
	private String pdate;
	private int ptotal;
	private String prefund;
	//리뷰정보
	private int reid;
}
