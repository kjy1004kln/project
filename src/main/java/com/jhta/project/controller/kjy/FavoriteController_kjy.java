package com.jhta.project.controller.kjy;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhta.mybatis.mapper.kjy.FavoriteMapperkjy;
import com.jhta.project.vo.kjy.FavoriteVo_kjy;

@Controller
public class FavoriteController_kjy {
	@Autowired private FavoriteMapperkjy service;
	
	@RequestMapping(value="/user/kjy/portlist", produces= {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> portlist(HttpServletRequest req, HttpServletResponse resp){
		HttpSession session=req.getSession();
		String mid=(String)session.getAttribute("mid");
		HashMap<String, Object> map=new HashMap<String, Object>();
		FavoriteVo_kjy vo=service.list(mid);
		String airport=vo.getFavairport();
		ArrayList<String> arrayport=new ArrayList<String>();
		//null이 아닐경우
		if(airport!=null) {
			//문자열에 " "가 포함되었으면
			if(airport.contains(" ")==true) {
				String[] airports=airport.split(" ");
				for(int i=0;i<airports.length;i++) {
					arrayport.add(airports[i]);
				}
			}else {
				arrayport.add(airport);
			}
		}
		map.put("arrayport", arrayport);
		return map;
	}
	
	@RequestMapping(value="/user/kjy/linelist", produces= {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> linelist(HttpServletRequest req, HttpServletResponse resp){
		HttpSession session=req.getSession();
		String mid=(String)session.getAttribute("mid");
		HashMap<String, Object> map=new HashMap<String, Object>();
		FavoriteVo_kjy vo=service.list(mid);
		String airline=vo.getFavairline();
		ArrayList<String> arrayline=new ArrayList<String>();
		if(airline!=null) {
			//문자열에 " "가 포함되었으면
			if(airline.contains(" ")==true) {
				String[] airlines=airline.split(" ");
				for(int i=0;i<airlines.length;i++) {
					arrayline.add(airlines[i]);
				}
			}else {
				arrayline.add(airline);
			}
		}
		map.put("arrayline", arrayline);
		return map;
	}
	
	@RequestMapping(value="/user/kjy/hotellist", produces= {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> hotellist(HttpServletRequest req, HttpServletResponse resp){
		HttpSession session=req.getSession();
		String mid=(String)session.getAttribute("mid");
		HashMap<String, Object> map=new HashMap<String, Object>();
		FavoriteVo_kjy vo=service.list(mid);
		String hotel=vo.getFavhotel();
		ArrayList<String> arrayhotel=new ArrayList<String>();
		if(hotel!=null) {
			//문자열에 " "가 포함되었으면
			if(hotel.contains(" ")==true) {
				String[] hotels=hotel.split(" ");
				for(int i=0;i<hotels.length;i++) {
					arrayhotel.add(hotels[i]);
				}
			}else {
				arrayhotel.add(hotel);
			}
		}
		map.put("arrayhotel", arrayhotel);
		return map;
	}
	
	@RequestMapping(value="/user/kjy/airportup", produces= {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody int airportup(HttpServletRequest req, HttpServletResponse resp,
			String airport){
		HttpSession session=req.getSession();
		String mid=(String)session.getAttribute("mid");
		HashMap<String, Object> map=new HashMap<String, Object>();
		FavoriteVo_kjy vo=service.list(mid);
		String airportname=vo.getFavairport();
		if(airportname!=null) {
			airportname=airportname+airport;
			map.put("airport", airportname+" ");
		}else {
			map.put("airport", airport+" ");
		}
		map.put("mid", mid);
		int n=service.airportup(map);
		return n;
	}
	@RequestMapping(value="/user/kjy/airlineup", produces= {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody int airlineup(HttpServletRequest req, HttpServletResponse resp,
			String airline){
		HttpSession session=req.getSession();
		String mid=(String)session.getAttribute("mid");
		HashMap<String, Object> map=new HashMap<String, Object>();
		FavoriteVo_kjy vo=service.list(mid);
		String airlinename=vo.getFavairline();
		if(airlinename!=null) {
			airlinename=airlinename+airline;
			map.put("airline", airlinename+" ");
		}else {
			map.put("airline", airline+" ");
		}
		map.put("mid", mid);
		int n=service.airlineup(map);
		return n;
	}
	@RequestMapping(value="/user/kjy/hotelup", produces= {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody int hotelup(HttpServletRequest req, HttpServletResponse resp,
			String hotel){
		HttpSession session=req.getSession();
		String mid=(String)session.getAttribute("mid");
		HashMap<String, Object> map=new HashMap<String, Object>();
		FavoriteVo_kjy vo=service.list(mid);
		String name[]=hotel.split(",");
		String hotelname=vo.getFavhotel();
		if(hotelname!=null) {
			hotelname=hotelname+name[0];
			map.put("hotel", hotelname+" ");
		}else {
			map.put("hotel", name[0]+" ");
		}
		map.put("mid", mid);
		int n=service.hotelup(map);
		return n;
	}
	
	@RequestMapping(value="/user/kjy/linedel", produces= {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody int linedel(HttpServletRequest req, HttpServletResponse resp,
			String linenum){
		int num=Integer.parseInt(linenum);
		HttpSession session=req.getSession();
		String mid=(String)session.getAttribute("mid");
		HashMap<String, Object> map=new HashMap<String, Object>();
		int n=0;
		FavoriteVo_kjy vo=service.list(mid);
		String linename=vo.getFavairline();
		if(linename.contains(" ")==true) {
			String name[]=linename.split(" ");
			if(name.length>1) {
				String airline=linename.replace(name[num]+" ","");
				map.put("mid",mid);
				map.put("airline",airline);
				n=service.airlineup(map);
			}else {
				map.put("mid",mid);
				map.put("airline","");
				n=service.airlineup(map);
			}
		}
		return n;
	}
	
	@RequestMapping(value="/user/kjy/hoteldel", produces= {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody int hoteldel(HttpServletRequest req, HttpServletResponse resp,
			String hotelnum){
		int num=Integer.parseInt(hotelnum);
		HttpSession session=req.getSession();
		String mid=(String)session.getAttribute("mid");
		HashMap<String, Object> map=new HashMap<String, Object>();
		int n=0;
		FavoriteVo_kjy vo=service.list(mid);
		String hotelname=vo.getFavhotel();
		if(hotelname.contains(" ")==true) {
			String name[]=hotelname.split(" ");
			if(name.length>1) {
				String hotel=hotelname.replace(name[num]+" ","");
				map.put("mid",mid);
				map.put("hotel",hotel);
				n=service.hotelup(map);
			}else {
				map.put("mid",mid);
				map.put("hotel","");
				n=service.hotelup(map);
			}
		}
		return n;
	}
	
	@RequestMapping(value="/user/kjy/portdel", produces= {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody int portdel(HttpServletRequest req, HttpServletResponse resp,
			String portnum){
		int num=Integer.parseInt(portnum);
		HttpSession session=req.getSession();
		String mid=(String)session.getAttribute("mid");
		HashMap<String, Object> map=new HashMap<String, Object>();
		int n=0;
		FavoriteVo_kjy vo=service.list(mid);
		String portname=vo.getFavairport();
		if(portname.contains(" ")==true) {
			String name[]=portname.split(" ");
			if(name.length>1) {
				String airport=portname.replace(name[num]+" ","");
				map.put("mid",mid);
				map.put("airport",airport);
				n=service.airportup(map);
			}else {
				map.put("mid",mid);
				map.put("airport","");
				n=service.airportup(map);
			}
		}
		return n;
	}
}
