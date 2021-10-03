package com.jhta.project.vo.jhr;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class MembersVo {
	private String mid; //아이디
	private String mpw; //비밀번호
	private String mname; //이름
	private String mphone; //전화번호
	private String memail; //이메일
	private Date mrdate; //가입일 : DATE DEFAULT SYSDATE
	@DateTimeFormat(pattern="yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	private Date mbirth; //생년월일
	private String mprofile; //프로필사진
	private String mdrop; //탈퇴여부 : 탈퇴 -> Y
}

/*
-- 아이디
MID VARCHAR2(100) NOT NULL,
-- 비밀번호
MPW VARCHAR2(15),
-- 이름
MNAME VARCHAR2(100),
-- 전화번호
MPHONE VARCHAR2(300),
-- 이메일
MEMAIL VARCHAR2(25),
-- 가입일 : DATE DEFAULT SYSDATE
MRDATE DATE,
-- 생년월일
MBIRTH DATE,
-- 프로필사진
MPROFILE VARCHAR2(3000),
-- 탈퇴여부 : 탈퇴 -> Y
MDROP VARCHAR2(1),
PRIMARY KEY (MID)
*/