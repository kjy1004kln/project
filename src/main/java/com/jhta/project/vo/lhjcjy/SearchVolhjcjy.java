package com.jhta.project.vo.lhjcjy;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class SearchVolhjcjy {
	private int aid;
	private String acate;
	private String aname;
	private String aaddress;
	private String aphone;
	private String axcoordi;
	private String aycoordi;
	private String atotalroom;
	private String agrade;
	private String acgrade;
	private String adetail;
	private String amainimg;
	private Date aregdate;
	private String aisdel;
	
	private String sum; //전체금액
	private String amountsum; //평점순 전체금액
	private String reday; //예약가능날짜
	private int ripeak;
	private int risemipeak;
	private int rioff;

	private int riid;

	private int afid;
	private int afpersonnel;
	
	private int peid;
	private String peseason;
	private Date pestart;
	private Date peend;
	
	private int reid;
	private int restar;
	private int star;
	private int rnum;
}
