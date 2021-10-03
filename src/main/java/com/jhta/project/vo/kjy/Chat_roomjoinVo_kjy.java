package com.jhta.project.vo.kjy;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Chat_roomjoinVo_kjy {
	private String cmid;
	private String cmname;
	private Date cmbirth;
	private String cmprofile;
	private String cmscname;
	private String cmdrop;
	private int joinid;
	private Date joincontime;
	private int crid;
}
