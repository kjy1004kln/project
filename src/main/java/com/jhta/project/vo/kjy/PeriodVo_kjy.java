package com.jhta.project.vo.kjy;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class PeriodVo_kjy {
	private int peid;
	private String peseason;
	private Date pestart;
	private Date peend;
	private int aid;
}
