package com.jhta.project.controller.hjy;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.UUID;

import javax.activation.CommandMap;
import javax.activation.MailcapCommandMap;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.mail.internet.MimeMultipart;
import javax.servlet.ServletContext;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.jhta.project.service.hjy.AccommodationsServiceHjy;
import com.jhta.project.service.hjy.AccommodationsTempServiceHjy;
import com.jhta.project.service.hjy.Additional_feeService_hjy;
import com.jhta.project.service.hjy.Additional_fee_tempService_hjy;
import com.jhta.project.service.hjy.PeriodService_hjy;
import com.jhta.project.service.hjy.Period_tempService_hjy;
import com.jhta.project.service.hjy.Room_infoService_hjy;
import com.jhta.project.service.hjy.Room_info_tempService_hjy;
import com.jhta.project.vo.hjy.AccommodationsVo;
import com.jhta.project.vo.hjy.Additional_feeVo;
import com.jhta.project.vo.hjy.PeriodVo;
import com.jhta.project.vo.hjy.Room_InfoVo;

@Controller
public class HotelManageControllerHjy {
	@Autowired
	AccommodationsServiceHjy accommodationsservice;
	@Autowired
	Room_infoService_hjy roomInfoservice;
	@Autowired
	PeriodService_hjy periodservice;
	@Autowired
	Additional_feeService_hjy additional_feeservice;
	@Autowired
	AccommodationsTempServiceHjy accommodations_tempservice;
	@Autowired
	Room_info_tempService_hjy roomInfo_tempservice;
	@Autowired
	Period_tempService_hjy period_tempservice;
	@Autowired
	Additional_fee_tempService_hjy additional_fee_tempservice;
	@Autowired
	ServletContext sc;

	@GetMapping("hjy/hotelForm")
	public String hotelInsertForm(String type) {
		return "user/hjy/hotelManage/form";
	}

	/**
	 * hotelAllow
	 * 메일에서 등록버튼 눌렀을때 수행
	 * @param aid
	 */
	@GetMapping("hjy/ok")
	public String hotelAllow(String aid,Model model) {
//		찐db에 저장하기

		// 숙소테이블
		AccommodationsVo accommodationsVo = accommodations_tempservice.find(Integer.parseInt(aid));
		int n = accommodationsservice.insert(accommodationsVo);
		int aidSave = accommodationsservice.seq();

		// 파일 경로 옮기기 temp->찐으로
		String hotelpath_temp = sc.getRealPath("/resources/hjy/hotelmain_temp");
		String srcFile = hotelpath_temp + "//" + accommodationsVo.getAmainimg();
		String hotelpath = sc.getRealPath("/resources/images/accommodations");
		String dstFile = hotelpath + "//" + accommodationsVo.getAmainimg();
		File src = new File(srcFile);
		File dst = new File(dstFile);
		try {
			FileUtils.moveFile(src, dst);
		} catch (Exception e) {
			e.printStackTrace();
		}
		accommodations_tempservice.delete(Integer.parseInt(aid));

		// 객실세부정보
		List<Room_InfoVo> Room_info_tempVoList = roomInfo_tempservice.find(Integer.parseInt(aid));
		for (Room_InfoVo roomInfoVo : Room_info_tempVoList) {
			roomInfoVo.setAid(aidSave);
			int n1 = roomInfoservice.insert(roomInfoVo);

			// 파일 경로 옮기기 temp->찐으로
			String roommainpath_temp = sc.getRealPath("/resources/hjy/roommain_temp");
			String roomsrcFile = roommainpath_temp + "//" + roomInfoVo.getRimainimg();
			String roommainpath = sc.getRealPath("/resources/images/room_info");
			String roomdstFile = roommainpath + "//" + roomInfoVo.getRimainimg();
			File roomsrc = new File(roomsrcFile);
			File roomdst = new File(roomdstFile);
			try {
				FileUtils.moveFile(roomsrc, roomdst);
			} catch (Exception e) {
				e.printStackTrace();
			}
			String roomexpath_temp = sc.getRealPath("/resources/hjy/roomextra_temp");
			String roomexsrcFile = roomexpath_temp + "//" + roomInfoVo.getRiextraimg1();
			String roomexpath = sc.getRealPath("/resources/images/room_info");
			String roomexdstFile = roomexpath + "//" + roomInfoVo.getRiextraimg1();
			File roomexsrc = new File(roomexsrcFile);
			File roomexdst = new File(roomexdstFile);
			try {
				FileUtils.moveFile(roomexsrc, roomexdst);
			} catch (Exception e) {
				e.printStackTrace();
			}
			String roomex2srcFile = roomexpath_temp + "//" + roomInfoVo.getRiextraimg2();
			String roomex2dstFile = roomexpath + "//" + roomInfoVo.getRiextraimg2();
			File roomex2src = new File(roomex2srcFile);
			File roomex2dst = new File(roomex2dstFile);
			try {
				FileUtils.moveFile(roomex2src, roomex2dst);
			} catch (Exception e) {
				e.printStackTrace();
			}

			// 임시테이블의 riid번호
			int riid = roomInfoVo.getRiid();
			// 찐테이블에 넣을 riid번호
			int rid = roomInfoservice.seq();
			// 추가요금정보
			Additional_feeVo additional_feeVo = additional_fee_tempservice.find(riid);
			additional_feeVo.setRiid(rid);
			int n2 = additional_feeservice.insert(additional_feeVo);
			additional_fee_tempservice.delete(riid);
		}
		roomInfo_tempservice.delete(Integer.parseInt(aid));

		// 기간정보
		List<PeriodVo> periodVoList = period_tempservice.find(Integer.parseInt(aid));
		for (PeriodVo periodVo : periodVoList) {
			periodVo.setAid(aidSave);
			int n2 = periodservice.insert(periodVo);
		}
		period_tempservice.delete(Integer.parseInt(aid));
		model.addAttribute("result", "yes");
		return "user/hjy/hotelManage/mailResult";
	}

	/**
	 * hotelRefusal
	 * 메일에서 거부 눌렀을때 수행
	 * @param aid
	 */
	@GetMapping("hjy/no")
	public String hotelRefusal(String aid,Model model) {
		// 거부
		// db삭제
		List<Room_InfoVo> Room_info_tempVoList = roomInfo_tempservice.find(Integer.parseInt(aid));
		for (Room_InfoVo roomInfoVo : Room_info_tempVoList) {
			int riid = roomInfoVo.getRiid();
			additional_fee_tempservice.delete(riid);

			// 방 메인이미지,추가이미지1,2 삭제하기+db삭제
			String roommainpath = sc.getRealPath("/resources/hjy/roommain_temp");
			try {
				File file = new File(roommainpath + "//" + roomInfoVo.getRimainimg());
				if (file.exists()) {
					file.delete();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			String roomextrapath = sc.getRealPath("/resources/hjy/roomextra_temp");
			try {
				File file1 = new File(roomextrapath + "//" + roomInfoVo.getRiextraimg1());
				File file2 = new File(roomextrapath + "//" + roomInfoVo.getRiextraimg2());
				if (file1.exists()) {
					file1.delete();
				}
				if (file2.exists()) {
					file2.delete();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		roomInfo_tempservice.delete(Integer.parseInt(aid));
		period_tempservice.delete(Integer.parseInt(aid));

		// 메인이미지 삭제하기+db삭제
		String path = sc.getRealPath("/resources/hjy/hotelmain_temp");
		AccommodationsVo accommodationsVo = accommodations_tempservice.find(Integer.parseInt(aid));
		try {
			File file = new File(path + "//" + accommodationsVo.getAmainimg());
			if (file.exists()) {
				file.delete();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		accommodations_tempservice.delete(Integer.parseInt(aid));
		model.addAttribute("result", "no");
		return "user/hjy/hotelManage/mailResult";
	}

	/**
	 * hotelRequest
	 * 호텔등록폼에서 등록버튼 눌렀을때 수행.
	 * tempdb, tempimg폴더에 저장하기,메일보내기메소드 포함.
	 * @param accommodationsVo
	 * @param additional_feeVoList
	 * @param periodVoList
	 * @param roomInfoVoList
	 * @param mtfRequest
	 * @return
	 */
	@RequestMapping(value = "hjy/hotelreq", method = RequestMethod.POST)
	public String hotelRequest(AccommodationsVo accommodationsVo, Additional_feeVo additional_feeVoList,
			PeriodVo periodVoList, Room_InfoVo roomInfoVoList, MultipartHttpServletRequest mtfRequest) {
		
		// temp 테이블에 저장하기
		// 다중파일 가져와서 저장하기
		List<MultipartFile> fileList = mtfRequest.getFiles("file");
		
		// 다중파일 vo에 세팅하기
		fileList.get(0).getOriginalFilename();

		// 숙소테이블
		// 파일 업로드,숙소db에저장하기
		String path = sc.getRealPath("/resources/hjy/hotelmain_temp");
		String orgfilename = fileList.get(0).getOriginalFilename();// 전송된 파일명
		String savefilename = UUID.randomUUID() + "_" + orgfilename;// 저장할 파일명(중복되지 않는 이름으로 만들기)
		try {
			// 1. 파일 업로드하기
			InputStream is = fileList.get(0).getInputStream();
			FileOutputStream fos = new FileOutputStream(path + "//" + savefilename);
			FileCopyUtils.copy(is, fos);
			is.close();
			fos.close();
			// 2. 업로드된 파일정보 DB에 저장하기
			accommodationsVo.setAmainimg(savefilename);
		} catch (Exception e) {
			e.printStackTrace();
		}
		int n = accommodations_tempservice.insert(accommodationsVo);
		int aidseq = accommodations_tempservice.seq();
		accommodationsVo.setAid(aidseq);

		// 객실세부정보
		for (int i = 0; i < roomInfoVoList.getRoom_InfoVo().size(); i++) {
			int fileNum = i + 1;
			Room_InfoVo roomInfoVo = roomInfoVoList.getRoom_InfoVo().get(i);
			if (roomInfoVo.getRiroomtype() != null) {
				roomInfoVo.setAid(aidseq);
				// 파일 업로드,상세방db에저장하기
				// 메인이미지
				String roompath = sc.getRealPath("/resources/hjy/roommain_temp");
				String roomorgfilename = fileList.get(fileNum).getOriginalFilename();// 전송된 파일명
				String roomsavefilename = UUID.randomUUID() + "_" + roomorgfilename;// 저장할 파일명(중복되지 않는 이름으로 만들기)
				try {
					// 1. 파일 업로드하기
					InputStream is = fileList.get(fileNum).getInputStream();
					FileOutputStream fos = new FileOutputStream(roompath + "//" + roomsavefilename);
					FileCopyUtils.copy(is, fos);
					is.close();
					fos.close();
					// 2. 업로드된 파일정보 DB에 저장하기
					roomInfoVo.setRimainimg(roomsavefilename);
				} catch (Exception e) {
					e.printStackTrace();
				}

				// 추가이미지1
				fileNum += roomInfoVoList.getRoom_InfoVo().size();
				String roomexpath1 = sc.getRealPath("/resources/hjy/roomextra_temp");
				String roomexorgfilename1 = fileList.get(fileNum).getOriginalFilename();// 전송된 파일명
				String roomexsavefilename1 = UUID.randomUUID() + "_" + roomexorgfilename1;// 저장할 파일명(중복되지 않는 이름으로 만들기)
				try {
					// 1. 파일 업로드하기
					InputStream is = fileList.get(fileNum).getInputStream();
					FileOutputStream fos = new FileOutputStream(roomexpath1 + "//" + roomexsavefilename1);
					FileCopyUtils.copy(is, fos);
					is.close();
					fos.close();
					// 2. 업로드된 파일정보 DB에 저장하기
					roomInfoVo.setRiextraimg1(roomexsavefilename1);
				} catch (Exception e) {
					e.printStackTrace();
				}

				// 추가이미지2
				fileNum += roomInfoVoList.getRoom_InfoVo().size();
				String roomexorgfilename2 = fileList.get(fileNum).getOriginalFilename();// 전송된 파일명
				String roomexsavefilename2 = UUID.randomUUID() + "_" + roomexorgfilename2;// 저장할 파일명(중복되지 않는 이름으로 만들기)
				try {
					// 1. 파일 업로드하기
					InputStream is = fileList.get(fileNum).getInputStream();
					FileOutputStream fos = new FileOutputStream(roomexpath1 + "//" + roomexsavefilename2);
					FileCopyUtils.copy(is, fos);
					is.close();
					fos.close();
					// 2. 업로드된 파일정보 DB에 저장하기
					roomInfoVo.setRiextraimg2(roomexsavefilename2);
				} catch (Exception e) {
					e.printStackTrace();
				}
				int n1 = roomInfo_tempservice.insert(roomInfoVo);
				int riidseq = roomInfo_tempservice.seq();

				// 추가요금정보
				Additional_feeVo additional_feeVo = additional_feeVoList.getAdditional_feeVo().get(i);
				additional_feeVo.setRiid(riidseq);
				int n2 = additional_fee_tempservice.insert(additional_feeVo);
			}
		}
		// 기간정보
		for (int i = 0; i < periodVoList.getPeriodVo().size(); i++) {
			PeriodVo periodVo = periodVoList.getPeriodVo().get(i);
			if (periodVo.getPeseason() != null) {
				periodVo.setAid(aidseq);
				int n3 = period_tempservice.insert(periodVo);
			}
		}

		sendMail(accommodationsVo, additional_feeVoList, periodVoList, roomInfoVoList);
		return "user/hjy/hotelManage/formResult";
	}

	/**
	 * 메일보내기
	 * @param accommodationsVo
	 * @param additional_feeVoList
	 * @param periodVoList
	 * @param roomInfoVoList
	 */
	public static void sendMail(AccommodationsVo accommodationsVo, Additional_feeVo additional_feeVoList,
			PeriodVo periodVoList, Room_InfoVo roomInfoVoList) {

		// 메일 인코딩
		final String bodyEncoding = "UTF-8"; // 콘텐츠 인코딩

		String subject = "[숙소등록]";
		String fromEmail = "hgyoung06@gmail.com";
		String fromUsername = "J6 MANAGER";
		String toEmail = "hgyoung06@gmail.com"; // 콤마(,)로 여러개 나열

		final String username = "hgyoung06@gmail.com";
		final String password = "cyqbwmbqaoqkpjum";

		// 메일에 출력할 텍스트
		StringBuffer sb = new StringBuffer();
		sb.append("<!DOCTYPE html>");
		sb.append("<head>");
		sb.append("<meta charset='utf-8'>");
		sb.append("<title>메일보내기test</title>");
		sb.append("<meta name='viewport' content='width=device-width, initial-scale=1'>");
		sb.append(
				"<link rel='stylesheet' href='https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css'>\n");
		sb.append("<script src='https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js'></script>\n");
		sb.append(
				"<script src='https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js'></script>\n");
		sb.append("<script src='https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js'></script>\n");
		sb.append("</head>");
		sb.append(
				"<body style=\"font-family: Arial, '맑은 고딕', 'Malgun Gothic', Dotum, '돋움',sans-serif, Helvetica; font-size:12px; color:#464646; line-height:0;\">");
		sb.append("<div style=\"width:100%; padding:20px 0;\">");
		sb.append("<div style=\"width:700px; margin:0 auto;\">");
		sb.append("<div style=\"padding:30px;\">");
		sb.append(
				"<p style=\"background-color:#f4f4f4; color:#754c24; border:1px solid #d7d7d7; padding:30px; text-align:center; font-size:18px; font-weight:bold; margin-bottom:50px;\">숙소 등록 요청</p>");
		sb.append("<p style=\"line-height:1.6em;\">숙소 정보</p>");
		sb.append(
				"<div style=\"background-color:#DFCFBE border-top:1px solid #d7d7d7; border-bottom:1px solid #d7d7d7; padding:10px 10px 10px 50px; margin-bottom:50px;\">");
		sb.append("<p style=\"line-height:1.6em; color:#754c24;\">");
		sb.append("숙박업소명: " + accommodationsVo.getAname());
		sb.append("</p>");
		sb.append("<p style=\"line-height:1.6em; color:#754c24;\">");
		sb.append("주소: " + accommodationsVo.getAaddress());
		sb.append("</p>");
		sb.append("<p style=\"line-height:1.6em; color:#754c24;\">");
		sb.append("전화번호: " + accommodationsVo.getAphone());
		sb.append("</p>");
		sb.append("<p style=\"line-height:1.6em; color:#754c24;\">");
		sb.append("x좌표: " + accommodationsVo.getAxcoordi());
		sb.append("</p>");
		sb.append("<p style=\"line-height:1.6em; color:#754c24;\">");
		sb.append("y좌표: " + accommodationsVo.getAycoordi());
		sb.append("</p>");
		sb.append("<p style=\"line-height:1.6em; color:#754c24;\">");
		sb.append("총객실수: " + accommodationsVo.getAtotalroom());
		sb.append("</p>");
		sb.append("<p style=\"line-height:1.6em; color:#754c24;\">");
		sb.append("숙소성급: " + accommodationsVo.getAgrade());
		sb.append("</p>");
		sb.append("<p style=\"line-height:1.6em; color:#754c24;\">");
		sb.append("대표소개: " + accommodationsVo.getAdetail());
		sb.append("</p>");
		sb.append("<p style=\"line-height:1.6em; color:#754c24;\">");
		sb.append("대표이미지: " + accommodationsVo.getAmainimg());
		sb.append("</p>");
		sb.append("</div>");
		sb.append(
				"<div style=\"background-color:#DFCFBE left center no-repeat; border-top:1px solid #d7d7d7; border-bottom:1px solid #d7d7d7; padding:10px 10px 10px 50px;\">");
		sb.append("<p style=\"line-height:1.4em; font-weight:bold;\">객실세부정보</p>");
		for (int i = 0; i < roomInfoVoList.getRoom_InfoVo().size(); i++) {
			Room_InfoVo roomInfoVo = roomInfoVoList.getRoom_InfoVo().get(i);
			if (roomInfoVo.getRiroomtype() != null) {
				sb.append("<p style=\"font-size:12px; color:#636363; margin-bottom: 2px;\">");
				sb.append("객실종류: " + roomInfoVo.getRiroomtype());
				sb.append("</p>");
				sb.append("<p style=\"font-size:12px; color:#636363; margin-bottom: 2px;\">");
				sb.append("객실수: " + roomInfoVo.getRiroom());
				sb.append("</p>");
				sb.append("<p style=\"font-size:12px; color:#636363; margin-bottom: 2px;\">");
				sb.append("부가서비스: " + roomInfoVo.getRiservice());
				sb.append("</p>");
				sb.append("<p style=\"font-size:12px; color:#636363; margin-bottom: 2px;\">");
				sb.append("객실크기: " + roomInfoVo.getRisize());
				sb.append("</p>");
				sb.append("<p style=\"font-size:12px; color:#636363; margin-bottom: 2px;\">");
				sb.append("숙박가능인원: " + roomInfoVo.getRiminper());
				sb.append("</p>");
				sb.append("<p style=\"font-size:12px; color:#636363; margin-bottom: 2px;\">");
				sb.append("숙박최대인원: " + roomInfoVo.getRimaxper());
				sb.append("</p>");
				sb.append("<p style=\"font-size:12px; color:#636363; margin-bottom: 2px;\">");
				sb.append("성수기 1박 기본요금: " + roomInfoVo.getRipeak());
				sb.append("</p>");
				sb.append("<p style=\"font-size:12px; color:#636363; margin-bottom: 2px;\">");
				sb.append("준성수기 1박 기본요금: " + roomInfoVo.getRisemipeak());
				sb.append("</p>");
				sb.append("<p style=\"font-size:12px; color:#636363; margin-bottom: 2px;\">");
				sb.append("비성수기 1박 기본요금: " + roomInfoVo.getRioff());
				sb.append("</p>");
				sb.append("<p style=\"font-size:12px; color:#636363; margin-bottom: 2px;\">");
				sb.append("대표이미지: " + roomInfoVo.getRimainimg());
				sb.append("</p>");
				sb.append("<p style=\"font-size:12px; color:#636363; margin-bottom: 2px;\">");
				sb.append("추가이미지1: " + roomInfoVo.getRiextraimg1());
				sb.append("</p>");
				sb.append("<p style=\"font-size:12px; color:#636363; margin-bottom: 2px;\">");
				sb.append("추가이미지2: " + roomInfoVo.getRiextraimg2());
				sb.append("</p>");
				Additional_feeVo additional_feeVo = additional_feeVoList.getAdditional_feeVo().get(i);
				sb.append("<p style=\"line-height:1.4em; font-weight:bold;\">추가요금설정</p>");
				sb.append("<p style=\"font-size:11px; color:#636363;\">");
				sb.append("인원추가비용: " + additional_feeVo.getAfpersonnel());
				sb.append("</p>");
				sb.append("<p style=\"font-size:11px; color:#636363;\">");
				sb.append("조식추가비용: " + additional_feeVo.getAfbreakfast());
				sb.append("</p>");
				sb.append("<p style=\"font-size:11px; color:#636363;\">");
				sb.append("침대추가비용: " + additional_feeVo.getAfbed());
				sb.append("</p>");
				sb.append("<hr style='border-bottom:1px solid #d7d7d7;'>");
			}
		}
		sb.append("</div>");
		sb.append("<div style=\"padding:20px 50px; line-height:1.6em; border-bottom:1px solid #d7d7d7;\">");
		sb.append("기간정보<br>");
		for (PeriodVo periodVo : periodVoList.getPeriodVo()) {
			if (periodVo.getPeseason() != null) {
				sb.append("시즌: " + periodVo.getPeseason() + "<br>");
				sb.append("시즌시작날짜: " + periodVo.getPestart() + "<br>");
				sb.append("시즌끝날짜: " + periodVo.getPeend() + "<br>");
				sb.append("<hr style='border-bottom:1px solid #d7d7d7;'>");
			}
		}
		sb.append("</div>");
		sb.append("</div>");
		sb.append(
				"<div style=\"font-size:11px; background-color:#f4f4f4; text-align:center; line-height:1.3em; padding:20px 30px; text-align:center; font-size:18px; font-weight:bold; margin-top:50px;\">");
		sb.append("<a href='http://localhost:8090/project/hjy/ok?aid=" + accommodationsVo.getAid()
				+ "' style='color:#754c24;'>등록</a><br>");
		sb.append("<a href='http://localhost:8090/project/hjy/no?aid=" + accommodationsVo.getAid()
				+ "' style='color:#754c24;'>거부</a>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</div>");
		sb.append("</body>");
		sb.append("</html>");

		String html = sb.toString();

		// 메일 옵션 설정
		Properties props = new Properties();
		props.put("mail.transport.protocol", "smtp");
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.port", "465");
		props.put("mail.smtp.auth", "true");

		props.put("mail.smtp.quitwait", "false");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.socketFactory.fallback", "false");

		try {
			// 메일 서버 인증 계정 설정
			Authenticator auth = new Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(username, password);
				}
			};

			// 메일 세션 생성
			Session session = Session.getInstance(props, auth);

			// 메일 송/수신 옵션 설정
			Message message = new MimeMessage(session);
			message.setFrom(new InternetAddress(fromEmail, fromUsername));
			message.setRecipients(RecipientType.TO, InternetAddress.parse(toEmail, false));
			message.setSubject(subject);
			message.setSentDate(new Date());

			// 메일 콘텐츠 설정
			Multipart mParts = new MimeMultipart();
			MimeBodyPart mTextPart = new MimeBodyPart();
			MimeBodyPart mFilePart = null;

			// 메일 콘텐츠 - 내용
			mTextPart.setText(html, bodyEncoding, "html");
			mParts.addBodyPart(mTextPart);

			// 메일 콘텐츠 설정
			message.setContent(mParts);

			// MIME 타입 설정
			MailcapCommandMap MailcapCmdMap = (MailcapCommandMap) CommandMap.getDefaultCommandMap();
			MailcapCmdMap.addMailcap("text/html;; x-java-content-handler=com.sun.mail.handlers.text_html");
			MailcapCmdMap.addMailcap("text/xml;; x-java-content-handler=com.sun.mail.handlers.text_xml");
			MailcapCmdMap.addMailcap("text/plain;; x-java-content-handler=com.sun.mail.handlers.text_plain");
			MailcapCmdMap.addMailcap("multipart/*;; x-java-content-handler=com.sun.mail.handlers.multipart_mixed");
			MailcapCmdMap.addMailcap("message/rfc822;; x-java-content-handler=com.sun.mail.handlers.message_rfc822");
			CommandMap.setDefaultCommandMap(MailcapCmdMap);

			// 메일 발송
			Transport.send(message);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
