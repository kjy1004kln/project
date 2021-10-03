package com.jhta.project.vo.hjy;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class BoardVo {
	private int bid;
	private String bcate;
	private String btitle;
	private String bcontent;
	private Date brdate;
	private String mid;
	private String bfile1;
	private String bfile2;
	private String bfile3;
}
