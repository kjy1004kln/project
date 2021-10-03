package com.jhta.project.vo.hjy;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserqnaVo {
	private int qid;
	private String qcate;
	private String qpw;
	private String qtitle;
	private String qcontent;
	private String qfile;
	private Date qrdate;
	private String qlev;
	private int qref;
	private int qstep;
	private String mid;
}
