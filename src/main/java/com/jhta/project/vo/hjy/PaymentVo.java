package com.jhta.project.vo.hjy;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PaymentVo {
	private int pid;
	private String pmethod;
	private Date pdate;
	private int ptotal;
	private String prefund;
	private String ptoken;
	private int rid;
	private String mid;
	private int cnt;
}
