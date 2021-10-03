package com.jhta.project.controller.cjy;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.jhta.project.refund.PayRefund;
import com.jhta.project.service.cjy.Admin_CancelRefundServiceCjy;
import com.jhta.project.service.hjy.PaymentServiceHjy;
import com.jhta.project.service.hjy.ReservationServiceHjy;
import com.jhta.project.vo.cjy.Admin_ManageMemVo;
import com.jhta.project.vo.cjy.ReservationVo;
import com.jhta.project.vo.cjy.RsvPaymentVo;
import com.jhta.project.vo.hjy.PaymentVo;
import com.jhta.project.vo.hjy.ReservationRateVo;
import com.jhta.util.PageUtil;

import lombok.Data;


@RestController

public class Admin_CancelRefundControllerCjy {
	@Autowired Admin_CancelRefundServiceCjy crservice;
	@Autowired PaymentServiceHjy payService;

	//취소환불 리스트
	@RequestMapping(value="admin/cjy/rvcancel", produces = {MediaType.APPLICATION_JSON_VALUE})
	public HashMap<String, Object> cancelrefunddata(){
		HashMap<String, Object> map = new HashMap<String,Object>();
		try {
			//rcheckin, rcheckout이 yy/mm/dd형태로 들어가 있기 때문에 회원목록과 통일성을 주기 위해 보여지는 형식 변경
			SimpleDateFormat beforeFormat = new SimpleDateFormat("yyyyMMdd");
			SimpleDateFormat afterFormat = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date tempDate1=null;
			java.util.Date tempDate2=null;
			List<RsvPaymentVo> data=crservice.list();
			System.out.println("pdate:"+data.get(0).getPdate());
			map.put("data", data);
			System.out.println(data);
			for(int i=0; i<data.size() ;i++) {
				System.out.println("dd:"+data.get(i).getRcheckin());
				tempDate1=beforeFormat.parse(data.get(i).getRcheckin());
				tempDate2=beforeFormat.parse(data.get(i).getRcheckout());
				String rcheckin=afterFormat.format(tempDate1);
				String rcheckout=afterFormat.format(tempDate2);
				data.get(i).setRcheckin(rcheckin);
				data.get(i).setRcheckout(rcheckout);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	

	//취소승인
	@RequestMapping(value="admin/cjy/rvcancelapproval", produces = {MediaType.APPLICATION_JSON_VALUE})
	public  HashMap<String, Object> cancelapproval(String rid,String mid){
		HashMap<String, Object> map = new HashMap<String,Object>();
		HashMap<String, Object> map1 = new HashMap<String,Object>();
		PayRefund pay = new PayRefund();
		map.put("rid", rid);
		PaymentVo vo = payService.find(rid);
		System.out.println(vo.getPtoken());
		try {
			int result = pay.cancelPayment(pay.getImportToken(), vo.getPtoken());
			int data=crservice.update(map);
			map1.put("data", data);
			if(result>0) {
				map1.put("msg", "취소승인 되었습니다");
			}else {
				map1.put("msg", "취소승인이 실패되었습니다");
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return map1;
	}
	/*
	//취소승인후 리스트 제외
	@RequestMapping(value="admin/cjy/rvcancelaftapporoval", produces = {MediaType.APPLICATION_JSON_VALUE})
	public HashMap<String, Object> rvcancelaftapporoval(){
		HashMap<String, Object> map = new HashMap<String,Object>();
		try {
			//rcheckin, rcheckout이 yy/mm/dd형태로 들어가 있기 때문에 회원목록과 통일성을 주기 위해 보여지는 형식 변경
			SimpleDateFormat beforeFormat = new SimpleDateFormat("yyyyMMdd");
			SimpleDateFormat afterFormat = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date tempDate1=null;
			java.util.Date tempDate2=null;
			List<ReservationVo> data=crservice.list();
			map.put("data", data);
			System.out.println(data);
			for(int i=0; i<data.size() ;i++) {
				System.out.println("dd:"+data.get(i).getRcheckin());
				tempDate1=beforeFormat.parse(data.get(i).getRcheckin());
				tempDate2=beforeFormat.parse(data.get(i).getRcheckout());
				String rcheckin=afterFormat.format(tempDate1);
				String rcheckout=afterFormat.format(tempDate2);
				data.get(i).setRcheckin(rcheckin);
				data.get(i).setRcheckout(rcheckout);
				System.out.println("rcheckin:"+rcheckin);
				System.out.println("rcheckout:"+rcheckout);
			}

		}catch(Exception e) {
			e.printStackTrace();
		}
		return map;
	}
	*/
}
