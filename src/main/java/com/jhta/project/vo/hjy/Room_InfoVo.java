package com.jhta.project.vo.hjy;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Room_InfoVo {
	private int riid;
	private String riroomtype;
	private int riroom;
	private String riservice;
	private String risize;
	private int riminper;
	private int rimaxper;
	private int ripeak;
	private int risemipeak;
	private int rioff;
	private String rimainimg;
	private String riextraimg1;
	private String riextraimg2;
	private int aid;
	
	private List<Room_InfoVo> room_InfoVo;

}