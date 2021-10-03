package com.jhta.project.vo.kjy;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Chat_messageVo_kjy {
	private int msgid;
	private String msgmessage;
	private Date msgtime;
	private String msgsysmsg;
	private String cmid;
	private int crid;
	//추가사항
	private String msgshottime;//ex.오후 1:02
	private String cmname;
	private String cmprofile;
}
