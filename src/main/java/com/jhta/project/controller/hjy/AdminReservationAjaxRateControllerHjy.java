package com.jhta.project.controller.hjy;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.jhta.project.service.hjy.ReservationServiceHjy;
import com.jhta.project.vo.hjy.ReservationRateVo;

@RestController
public class AdminReservationAjaxRateControllerHjy {
	@Autowired ReservationServiceHjy reservationService;
	/**
	 * 호텔별 예약율
	 * @return
	 */
	@GetMapping(value="hjy/admin/hotelReservationRate")
	public HashMap<String, Object> hotelReservationRate(String time) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<ReservationRateVo> list = reservationService.hotelReserRate(time);
		map.put("list", list);
		return map;
	}
	/**
	 * 방별 예약율
	 * @return
	 */
	@GetMapping(value="hjy/admin/roomReservationRate")
	public HashMap<String, Object> roomReservationRate(String time) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<ReservationRateVo> list = reservationService.RoomReserRate(time);
		map.put("list", list);
		return map;
	}
}
