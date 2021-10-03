package com.jhta.project.vo.jhr;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Chat_membersVo {
	private String cmid;
	private String cmname;
	private Date cmbirth;
	private String cmprofile;
	private String cmscname;
	private String cmdrop;
}