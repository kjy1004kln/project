package com.jhta.project.controller.kjy;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.jhta.project.service.kjy.AccommodationsService_kjy;
import com.jhta.project.service.kjy.PeriodService_kjy;
import com.jhta.project.service.kjy.Room_infoService_kjy;
import com.jhta.project.vo.kjy.AccommodationsVo_kjy;
import com.jhta.project.vo.kjy.Room_infoVo_kjy;

@Controller
public class Room_infoController_kjy {
	@Autowired private Room_infoService_kjy service;
	@Autowired private PeriodService_kjy peservice;
	@Autowired private AccommodationsService_kjy accservice;
	
	@RequestMapping(value="/user/kjy/room_info", method= RequestMethod.GET)
	public ModelAndView Room_infoForm(@RequestParam("aid")String aid, @RequestParam("person")String person,
			@RequestParam("roomnum")String roomnum, @RequestParam("startday")String startday,  
			@RequestParam("endday")String endday,@RequestParam("riid")String riid,
			HttpServletRequest request) {
		ModelAndView mv=new ModelAndView("user/kjy/room_info");
		try {
			
			//객실세부정보
			//person(사람수),startday(시작),endday(끝), roomnum(예약할 개수)
			int aid1=Integer.parseInt(aid);
			DateFormat df1=new SimpleDateFormat("yyyyMMdd");
			String startday1=startday.replace("-", "");
			String endday1=endday.replace("-", "");
			HashMap<String, Object> hs=new HashMap<String, Object>();
			hs.put("aid", aid1);
			hs.put("roomnum", roomnum);
			hs.put("startday", startday1);
			hs.put("endday", endday1);
			hs.put("person", person);
			List<Room_infoVo_kjy> alllist=service.list(hs);
			System.out.println(alllist);
			//list가 비었을경우 result 페이지로 이동
			if(alllist.isEmpty()) {
				ModelAndView mv1=new ModelAndView("user/kjy/result");
				mv1.addObject("code", "입력하신 날짜는 예약이 모두 완료되었습니다.");
				return mv1;
			}
			//입력한 날짜 중간포함 리스트 얻기
			HashMap<String, Object> hs1=new HashMap<String, Object>();
			hs1.put("startday", startday1);
			hs1.put("endday", endday1);
			String days=service.daylist(hs1);
			//숙소정보
			AccommodationsVo_kjy accvo=accservice.aidlist(aid1);

			//날짜사이 성수기,준성수기,비수기 숫자 구하기
			int off=0;//비수기
			int semi=0;//준성수기
			int peak=0;//성수기

			DateFormat df=new SimpleDateFormat("yyyy-MM-dd");
			Date d1=df.parse(startday);//시작날짜
			Date d2=df.parse(endday);//종료날짜
			Calendar c1=Calendar.getInstance();
			Calendar c2=Calendar.getInstance();
			c1.setTime(d1);//calendar 타입으로 변경, add메소드로 1일씩 추가해 주기위해 셋팅
			c2.setTime(d2);
			//시작날짜와 끝 날짜를 비교해, 시작날짜가 작거나 같은 경우 출력
			while( c1.compareTo( c2 ) !=1 ){
				HashMap<String, Object> daymap=new HashMap<String, Object>();
				//비수기,성수기,준성수기 확인
				Date day=c1.getTime();
				//7/1~7/4
				daymap.put("day", day);
				daymap.put("aid", aid);
				String peseason=peservice.list(daymap);
				if(peseason.equals("비수기")) {
					off++;//분류별 카운터
				}else if(peseason.equals("준성수기")) {
					semi++;
				}else {
					peak++;
				}
				//시작날짜 + 1일(시작~끝)
				c1.add(Calendar.DATE, 1);
			}
			int offprice=0;//비수기
			int semiprice=0;//준성수기
			int peakprice=0;//성수기
			int resernum=0;//남은 방의 개수
			DecimalFormat formatt=new DecimalFormat("###,###,###");//콤마찍기
			int currentper=Integer.parseInt(person);//현재인원 Integer형변환
			int currentsum=0;//인원추가금액
			int persum=0;
			for(Room_infoVo_kjy vo:alllist) {
				//총금액
				offprice=vo.getRioff();
				semiprice=vo.getRisemipeak();
				peakprice=vo.getRipeak();
				String offpr=formatt.format(off*offprice);
				String semipr=formatt.format(semi*semiprice);
				String peakpr=formatt.format(peak*peakprice);
				
				//인원추가금액
				currentsum=service.personnel(vo.getRiid());
				if(currentper >= vo.getRiminper()) {
					persum=currentper-vo.getRiminper();
				}else {
					persum=0;
				}
				String current=formatt.format(currentsum*persum);
				
				
				if(off>0 && semi>0 && peak > 0 && persum  > 0) {
					vo.setPrice("비수기 "+off+"박, 요금: "+offpr+" + 준성수기 "+semi+"박, 요금: "+semipr+" + 성수기 "+peak+"박, 요금: "+peakpr+" 인원추가 "+persum+"명, 요금: "+current);
				}else if(off>0 && semi>0 && peak > 0) {
					vo.setPrice("비수기 "+off+"박, 요금: "+offpr+" + 준성수기 "+semi+"박, 요금: "+semipr+" + 성수기 "+peak+"박, 요금: "+peakpr);
				}else if(off>0 && semi>0 && persum  > 0) {
					vo.setPrice("비수기 "+off+"박, 요금: "+offpr+" + 준성수기 "+semi+"박, 요금: "+semipr+" 인원추가 "+persum+"명, 요금: "+current);
				}else if(off>0 && semi>0) {
					vo.setPrice("비수기 "+off+"박, 요금: "+offpr+" + 준성수기 "+semi+"박, 요금: "+semipr);
				}else if(semi>0 && peak>0 && persum  > 0) {
					vo.setPrice("준성수기 "+semi+"박, 요금: "+semipr+" + 성수기 "+peak+"박, 요금: "+peakpr+" 인원추가 "+persum+"명, 요금: "+current);
				}else if(semi>0 && peak>0) {
					vo.setPrice("준성수기 "+semi+"박, 요금: "+semipr+" + 성수기 "+peak+"박, 요금: "+peakpr);
				}else if(off>0 && peak>0 && persum  > 0) {
					vo.setPrice("비수기 "+off+"박, 요금: "+offpr+" + 성수기 "+peak+"박, 요금: "+peakpr+" 인원추가 "+persum+"명, 요금: "+current);
				}else if(off>0 && peak>0) {
					vo.setPrice("비수기 "+off+"박, 요금: "+offpr+" + 성수기 "+peak+"박, 요금: "+peakpr);
				}else if(off>0 && semi<1 && peak<1 && persum  > 0) {
					vo.setPrice("비수기 "+off+"박, 요금: "+offpr+" 인원추가 "+persum+"명, 요금: "+current);
				}else if(off>0 && semi<1 && peak<1) {
					vo.setPrice("비수기 "+off+"박, 요금: "+offpr);
				}else if(off<1 && semi>0 && peak<1 && persum  > 0) {
					vo.setPrice("준성수기 "+semi+"박, 요금: "+semipr+" 인원추가 "+persum+"명, 요금: "+current);
				}else if(off<1 && semi>0 && peak<1) {
					vo.setPrice("준성수기 "+semi+"박, 요금: "+semipr);
				}else if(off<1 && semi<1 && peak>0 && persum  > 0) {
					vo.setPrice("성수기 "+peak+"박, 요금: "+peakpr+" 인원추가 "+persum+"명, 요금: "+current);
				}else if(off<1 && semi<1 && peak>0) {
					vo.setPrice("성수기 "+peak+"박, 요금: "+peakpr);
				}

				int sum=(off*offprice)+(semiprice*semi)+(peakprice*peak)+(currentsum*persum);
				String finalsum=formatt.format(sum);
				vo.setSum(finalsum);

				//특수문자 치환(,->√ ,♥, ♡)
				String service=vo.getRiservice();
				service=service.replace(",", "√ ");
				vo.setRiservice(service);

				//인원그림(♥, ♡)
				int maxper=vo.getRimaxper();
				//최대인원
				if(maxper==1) {
					vo.setMaxperimg("resources/images/room_info/person1.png");
				}else if(maxper==2) {
					vo.setMaxperimg("resources/images/room_info/person2.png");
				}else if(maxper==3) {
					vo.setMaxperimg("resources/images/room_info/person3.png");
				}else if(maxper==4) {
					vo.setMaxperimg("resources/images/room_info/person4.png");
				}else if(maxper==5) {
					vo.setMaxperimg("resources/images/room_info/person5.png");
				}else if(maxper==6) {
					vo.setMaxperimg("resources/images/room_info/person6.png");
				}
				
				//인원그림(♥, ♡)
				int minper=vo.getRiminper();
				//최소인원
				if(minper==1) {
					vo.setMinperimg("resources/images/room_info/person1.png");
				}else if(minper==2) {
					vo.setMinperimg("resources/images/room_info/person2.png");
				}else if(minper==3) {
					vo.setMinperimg("resources/images/room_info/person3.png");
				}else if(minper==4) {
					vo.setMinperimg("resources/images/room_info/person4.png");
				}else if(minper==5) {
					vo.setMinperimg("resources/images/room_info/person5.png");
				}else if(minper==6) {
					vo.setMinperimg("resources/images/room_info/person6.png");
				}

				//현재인원
				if(person.equals("1")) {
					vo.setPerimg("resources/images/room_info/minperson1.png");
				}else if(person.equals("2")) {
					vo.setPerimg("resources/images/room_info/minperson2.png");
				}else if(person.equals("3")) {
					vo.setPerimg("resources/images/room_info/minperson3.png");
				}else if(person.equals("4")) {
					vo.setPerimg("resources/images/room_info/minperson4.png");
				}else if(person.equals("5")) {
					vo.setPerimg("resources/images/room_info/minperson5.png");
				}else if(person.equals("6")) {
					vo.setPerimg("resources/images/room_info/minperson6.png");
				}
				
				//마감임박
				resernum=vo.getResernum();
				if(resernum <= 5) {
					vo.setReserimg("resources/images/room_info/reserimg1.png");
				}


				//예약이 꽉찼을경우 페이지이동
				if(!days.equals(vo.getReday())) {
					ModelAndView mv1=new ModelAndView("user/kjy/result");
					mv1.addObject("code", "입력하신 날짜는 예약이 모두 완료되었습니다.");
					return mv1;
				}
			}
			mv.addObject("riid", riid);
			mv.addObject("roomnum", roomnum);
			mv.addObject("startday",startday1);
			mv.addObject("endday",endday1);
			mv.addObject("accvo",accvo);
			mv.addObject("person", person);
			mv.addObject("list",alllist);
		}catch(Exception e){
			e.printStackTrace();
		}
		return mv;
	}
}
