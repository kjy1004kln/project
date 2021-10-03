package com.jhta.project.vo.lhjcjy;
/*
 * CREATE TABLE ACCOMMODATIONS
(
	AID NUMBER(4) NOT NULL,
	ACATE VARCHAR2(100),
	ANAME VARCHAR2(200),
	AADRESS VARCHAR2(200),
	APHONE VARCHAR2(30),
	AXCOORDI VARCHAR2(30),
	AYCOORDI VARCHAR2(30),
	ATOTALROOM NUMBER(5),
	AGRADE VARCHAR2(20),
	ADETAIL VARCHAR2(2000),
	AMAINIMG VARCHAR2(3000),
	AREGDATE DATE,
	AISDEL VARCHAR2(1),
	PRIMARY KEY (AID)
);
 */

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class AccommodationsVo2lhjcjy {
	private int aid;
	private int riid;
	private String acate;
	private String aname;
	private String aaddress;
	private String aphone;
	private String axcoordi;
	private String aycoordi;
	private String atotalroom;
	private String agrade;
	private String adetail;
	private String amainimg;
	private Date aregdate;
	private String aisdel;
	
	private String amountsum; //전체금액
	private int restar;
	private int star;
}
