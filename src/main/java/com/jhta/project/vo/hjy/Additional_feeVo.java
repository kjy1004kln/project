package com.jhta.project.vo.hjy;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Additional_feeVo {
	private int afid;
	private int afpersonnel;
	private int afbreakfast;
	private int afbed;
	private int riid;
	
	private List<Additional_feeVo> additional_feeVo;

}
