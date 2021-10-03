package com.jhta.project.controller.phj;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jhta.project.service.phj.PaymentService_phj;
import com.jhta.project.vo.phj.PaymentVo_phj;
import com.jhta.project.vo.phj.ReservationVo;

@Controller
public class PaymentController {
	@Autowired private PaymentService_phj service;
	@GetMapping("/pay")
	public String reservationForm() {
		return "user/phj/pay";
	}
	@GetMapping("/approval")
	public ModelAndView approval(String mid) {
		ModelAndView mv=new ModelAndView("user/phj/approval");
		mv.addObject("mid",mid);
		return mv;
	}
	@GetMapping("/cancle")
	public String cancle() {
		return "user/phj/cancle";
	}
	@GetMapping("/fail")
	public String fail() {
		return "user/phj/fail";
	}
	
	@RequestMapping(value="phj/paymentInsertOk",produces = {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, String> insert(
			@RequestBody PaymentVo_phj vo) {
		HashMap<String, String> map=new HashMap<String, String>();
		try {
			service.insertPayOk(vo);
			map.put("code","success");
		}catch(Exception e) {
			e.printStackTrace();
			map.put("code","fail");
		}
		return map;
	}
	
	@ResponseBody
	@RequestMapping("/kakaopay")
	public String kakaoPay() {
		try {
			URL url=new URL("https://kapi.kakao.com/v1/payment/ready");//서버주소
			HttpURLConnection conn=(HttpURLConnection)url.openConnection();//서버연결
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Authorization", "KakaoAK 2368cf3d67040ab660a2f93fd912b982");
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			conn.setDoOutput(true);
			String parm="cid=TC0ONETIME&partner_order_id=partner_order_id&partner_user_id=partner_user_id&item_name=hotel&quantity=1&total_amount=2200&tax_free_amount=0&approval_url=http://localhost:8090/project/approval&fail_url=http://localhost:8090/project/fail&cancel_url=http://localhost:8090/project/cancel";
			OutputStream ops=conn.getOutputStream();//전해주는역할
			DataOutputStream dops=new DataOutputStream(ops);
			dops.writeBytes(parm);
			dops.flush();
			dops.close();
			
			int resultcode=conn.getResponseCode();
			System.out.println(resultcode);
			InputStream ips;//받는역할
			if(resultcode==200) { //200이 정상코드(통신되었다는뜻)
				ips=conn.getInputStream();
			}else {
				ips=conn.getErrorStream();
			}
			
			InputStreamReader ipsr=new InputStreamReader(ips);//읽는역할
			BufferedReader br=new BufferedReader(ipsr);//byte를 받아서 String으로 변환
			
			return br.readLine();
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "user/phj/approval";

	}
}
