package com.jhta.project.vo.phj;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class PaymentVo_phj {
	private int pid;
	private String pmethod;
	private Date pdate;
	private int ptotal;
	private String prefund;
	private String ptoken;
	private int rid;
	private String mid;
}
