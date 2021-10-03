package com.jhta.project.controller.kjy;

import java.util.Date;
import java.util.HashMap;
import java.util.Properties;
import java.util.Random;

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
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jhta.mybatis.mapper.kjy.AccountdeleteMapperkjy;
import com.jhta.project.service.jhr.MembersService;
import com.jhta.project.vo.jhr.MembersVo;

@Controller
public class AccountdeleteController_kjy {
	@Autowired private AccountdeleteMapperkjy service;
	@Autowired private MembersService membersService;
	
	@RequestMapping(value="/user/kjy/pwdcheck", produces= {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> pwdcheck(HttpServletRequest req, HttpServletResponse resp,
			String mpw){
		HashMap<String, Object> map=new HashMap<String, Object>();
		HttpSession session=req.getSession();
		String mid=(String)session.getAttribute("mid");
		String mpwcheck=service.mpwcheck(mid);
		if(mpw.equals(mpwcheck)) {
			map.put("code", "success");
		}else {
			map.put("code", "fail");
		}
		return map;
	}
	@RequestMapping(value="/user/kjy/memberdel", produces= {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody int memberdel(HttpServletRequest req, HttpServletResponse resp){
		HttpSession session=req.getSession();
		String mid=(String)session.getAttribute("mid");
		int n=service.memberdel(mid);
		session.removeAttribute("mid");//세션 비우기
		
		String test=(String)session.getAttribute("mid");
		return n;
	}
	
	//인증코드 메일발송
	@RequestMapping(value="/user/kjy/emailcheck", produces= {MediaType.APPLICATION_JSON_VALUE})
	public @ResponseBody HashMap<String, Object> emailcheck(HttpServletRequest req, HttpServletResponse resp,HttpSession usesession) throws Exception{
		Random random=new Random();
		String key="";
		for(int i =0; i<3;i++) {
			int index=random.nextInt(25)+65; //A~Z까지 랜덤 알파벳 생성
			key+=(char)index;
		}
		int numIndex=random.nextInt(9999)+1000; //4자리 랜덤 정수를 생성
		key+=numIndex;//최종랜덤코드
		HashMap<String, Object> map=new HashMap<String, Object>();
		
		//메일 보낼 이메일 db에서 받아오기
		String getId = (String)usesession.getAttribute("mid");
		MembersVo vo = membersService.checkId(getId);
		String userEmail = vo.getMemail();
		
		map.put("key", key);//인증코드 받아가기
		final String bodyEncoding = "UTF-8";
		String subject = "J6 인증코드";
	    String fromEmail = "kjy1004kln2@gmail.com";
	    String fromUsername = "J6 관리자";
	    String toEmail = userEmail; // 콤마(,)로 여러개 나열
	    
	    final String username = "kjy1004kln2";         
	    final String password = "dbzlzfihuhbvjyxc";
	    
	    // 메일에 출력할 텍스트
	    StringBuffer sb = new StringBuffer();
	    sb.append("<h3>보안 인증코드입니다.</h3>\n");
	    sb.append("<h4>"+key+"</h4>\n");    
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
	      // 메일 서버  인증 계정 설정
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
	      Transport.send( message );
	      
	    } catch ( Exception e ) {
	      e.printStackTrace();
	    }
		return map;
	}
}
