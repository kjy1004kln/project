package com.jhta.project.vo.cjy;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class UserqnaVo {
	private String qid;
	private String qcate;
	private String qpw;
	private String qtitle;
	private String qcontent;
	private String qfile;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	private Date qrdate;
	private String qlev;
	private int qref;
	private int qstep;
	private String mid;
}

/*
-- 문의글아이디
QID NUMBER(4) NOT NULL,
-- 문의글카테고리 : 1.상품 2.교환/환불 3.사이트이용 4.기타
QCATE VARCHAR2(20),
-- 문의글비번
QPW VARCHAR2(100),
-- 문의글제목
QTITLE VARCHAR2(300),
-- 문의글내용
QCONTENT VARCHAR2(4000),
-- 문의글첨부
QFILE VARCHAR2(4000),
-- 문의글등록일 : DATE DEFAULT SYSDATE
QRDATE DATE,
-- 문의글처리여부 : 처리->Y
QLEV VARCHAR2(1),
-- 그룹번호
QREF NUMBER(3),
-- 글번호
QSTEP NUMBER(3),
-- 아이디
MID VARCHAR2(100) NOT NULL,
PRIMARY KEY (QID)
*/