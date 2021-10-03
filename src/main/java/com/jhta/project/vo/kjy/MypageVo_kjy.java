package com.jhta.project.vo.kjy;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class MypageVo_kjy {
	private String mid;
	private String mpw;
	private String mname;
	private String mphone;
	private String memail;
	private Date mrdate;
	private Date mbirth;
	private String mprofile;
	private String mdrop;
}
