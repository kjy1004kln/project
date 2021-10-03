package com.jhta.project.vo.lhj;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
/*
 * 	-- 결제아이디
	PID NUMBER(4) NOT NULL,
	-- 결제수단
	PMETHOD VARCHAR2(100),
	-- 결제날짜
	PDATE DATE,
	-- 총 비용
	PTOTAL NUMBER(10),
	-- 환불 : 환불 시 Y
	PREFUND VARCHAR2(1),
	-- 예약아이디
	RID NUMBER(4) NOT NULL,
	-- 아이디
	MID VARCHAR2(100) NOT NULL,
 */

@AllArgsConstructor
@NoArgsConstructor
@Data
public class PaymentVo {
	private int pid;
	private String pmethod;
	private String pdate;
	private int ptotal;
	private String prefund;
	private int rid;
	private String mid;
}
