package com.jhta.project.vo.hjy;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AccommodationsVo {
	private int aid;
	private String acate;
	private String aname;
	private String aaddress;
	private String aphone;
	private String axcoordi;
	private String aycoordi;
	private int atotalroom;
	private String agrade;
	private String adetail;
	private String amainimg;
	private Date aregdate;
}
