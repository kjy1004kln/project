package com.jhta.project.vo.kjy;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class Room_infoVo_kjy {
	private int riid;
	private int rordernum;
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
	
	//추가
	private String sum; //전체금액
	private String price; //숙박금액
	private String maxperimg; //최대인원이미지
	private String minperimg; //최소인원이미지
	private String perimg; //현재인원이미지
	private String reday; //예약가능날짜
	private int resernum;//남은방개수
	private String reserimg;//마감임박이미지
}
