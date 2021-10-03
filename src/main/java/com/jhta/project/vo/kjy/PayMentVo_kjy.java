package com.jhta.project.vo.kjy;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class PayMentVo_kjy {
	private int pid;
	private String pmethod;
	private Date pdate;
	private int ptotal;
	private String ptoken;
	private String prefund;
	private int rid;
	private String mid;
}
