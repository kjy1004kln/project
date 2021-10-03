package com.jhta.project.vo.hjy;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommentsVo {
	private int cid;
	private String ccontent;
	private Date crdate;
	private int cref;
	private int cstep;
	private int clev;
	private String cisdel; 
	private int bid;
	private String mid;
}
