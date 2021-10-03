package com.jhta.project.vo.cjy;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ReservationVo {
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
	//추가
	
}
