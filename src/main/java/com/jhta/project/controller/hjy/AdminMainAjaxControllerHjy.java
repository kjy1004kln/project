package com.jhta.project.controller.hjy;


import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.jhta.project.service.hjy.MembersServiceHjy;
import com.jhta.project.service.hjy.PaymentServiceHjy;
import com.jhta.project.vo.hjy.PaymentVo;

@RestController
public class AdminMainAjaxControllerHjy {
	@Autowired PaymentServiceHjy paymentService;
	@Autowired MembersServiceHjy membersService;
	/**
	 * 결제수단 통계
	 * @return
	 */
	@GetMapping(value="hjy/admin/payType")
	public HashMap<String, Object> payType() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<PaymentVo> list = paymentService.payType();
		map.put("list", list);
		return map;
	}
	
	/**
	 * 월간매출
	 * @return
	 */
	@GetMapping(value="hjy/admin/monthlySales")
	public HashMap<String, Object> monthlySales() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int monthlySales=paymentService.monthlySales();
		map.put("monthlySales",monthlySales);
		return map;
	}
	
	/**
	 * 연간매출
	 * @return
	 */
	@GetMapping(value="hjy/admin/annualSales")
	public HashMap<String, Object> annualSales() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int annualsales=paymentService.annualSales();
		map.put("annualsales",annualsales);
		return map;
	}
	/**
	 * 현재 달
	 * @return
	 */
	@GetMapping(value="hjy/admin/month")
	public HashMap<String, Object> month() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int month=paymentService.month();
		map.put("month",month);
		return map;
	}
	/**
	 * 현재 년도
	 * @return
	 */
	@GetMapping(value="hjy/admin/year")
	public HashMap<String, Object> year() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int year=paymentService.year();
		map.put("year",year);
		return map;
	}
	/**
	 * 전체 회원수
	 * @return
	 */
	@GetMapping(value="hjy/admin/allMembers")
	public HashMap<String, Object> allMembers() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int allMembers=membersService.allMembers();
		map.put("allMembers",allMembers);
		return map;
	}
	/**
	 * 전체 회원수
	 * @return
	 */
	@GetMapping(value="hjy/admin/monthMembers")
	public HashMap<String, Object> monthMembers() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		int monthMembers=membersService.monthMembers();
		map.put("monthMembers",monthMembers);
		return map;
	}
	/**
	 * 매출차트
	 * @return
	 */
	@GetMapping(value="hjy/admin/salesChart")
	public HashMap<String, Object> SalesChart() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<HashMap<String, Object>> salesChart=paymentService.salesChart();
		for (int i= 0; i < salesChart.size(); i++) {
			map.put("month"+salesChart.get(i).get("LV"), salesChart.get(i).get("PTOTAL"));
		}
		return map;
	}
	/**
	 * 예약률 top5
	 * @return
	 */
	@GetMapping(value="hjy/admin/reservationRate")
	public HashMap<String, Object> reservationRate() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<HashMap<String, Object>> reservationRate=paymentService.reservationRate();
		map.put("list", reservationRate);
		return map;
	}
}
