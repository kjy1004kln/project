package com.jhta.project.vo.kjy;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@AllArgsConstructor
@Data
public class FavoritesearchVo_kjy  {
	//호텔체인 검색
	private String krchainname;
	private String engchainname;
	//공항 검색
	private String portname;
	//항공사 검색
	private String airname;
}
