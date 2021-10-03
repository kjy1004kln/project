package com.jhta.project.vo.lhjcjy;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*
 * CREATE TABLE ROOM_INFO
(
	RIID NUMBER(4) NOT NULL,
	RIROOMTYPE VARCHAR2(100),
	RIROOM NUMBER(4),
	RISERVICE VARCHAR2(3000),
	RISIZE VARCHAR2(50),
	RIMINPER NUMBER(3),
	RIMAXPER NUMBER(3),
	RIPEAK NUMBER(10),
	RISEMIPEAK NUMBER(10),
	RIOFF NUMBER(10),
	RIMAINIMG VARCHAR2(3000),
	RIEXTRAIMG1 VARCHAR2(3000),
	RIEXTRAIMG2 VARCHAR2(3000),
	AID NUMBER(4) NOT NULL,
	PRIMARY KEY (RIID)
);


 */

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Room_InfoVolhjcjy {
	private int riid;
	private String riroomtype;
	private int riroom;
	private String riservice;
	private String risize;
	private int riminper;
	private int rimaxper;
	private int rireak;
	private int risemipeak;
	private int rioff;
	private String rimainimg;
	private String riextraimg1;
	private String riextraimg2;
	private int aid;
}
