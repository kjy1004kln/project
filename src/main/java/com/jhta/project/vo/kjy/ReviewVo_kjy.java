package com.jhta.project.vo.kjy;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class ReviewVo_kjy {
	private int reid;
	private String retitle;
	private String recontent;
	private String rephoto;
	private Date rerdate;
	private int restar;
	private String mid;
	private int rid;
}
