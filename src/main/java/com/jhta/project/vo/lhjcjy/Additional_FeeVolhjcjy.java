package com.jhta.project.vo.lhjcjy;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * CREATE TABLE ADDITIONAL_FEE
(
	-- 추가비용아이디
	AFID NUMBER(4) NOT NULL,
	-- 인원추가비용
	AFPERSONNEL NUMBER(10),
	-- 조식추가비용
	AFBREAKFAST NUMBER(10),
	-- 침대추가비용
	AFBED NUMBER(10),
	-- 객실아이디
	RIID NUMBER(4) NOT NULL,
	PRIMARY KEY (AFID)
);

 */

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Additional_FeeVolhjcjy {
	private int afid;
	private int afpersonnel;
	private int afbreakfast;
	private int afbed;
	private int riid;
}
