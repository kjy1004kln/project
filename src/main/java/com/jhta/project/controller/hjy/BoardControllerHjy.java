package com.jhta.project.controller.hjy;

import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.mail.Session;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.jhta.project.service.hjy.BoardServiceHjy;
import com.jhta.project.service.hjy.CommentsServiceHjy;
import com.jhta.project.service.phj.BoardService_phj;
import com.jhta.project.vo.hjy.AccommodationsVo;
import com.jhta.project.vo.hjy.Additional_feeVo;
import com.jhta.project.vo.hjy.BoardVo;
import com.jhta.project.vo.hjy.CommentsVo;
import com.jhta.project.vo.hjy.PeriodVo;
import com.jhta.project.vo.hjy.Room_InfoVo;
import com.jhta.project.vo.phj.BoardVo_phj;
import com.jhta.util.PageUtil;

@Controller
public class BoardControllerHjy {
	@Autowired
	BoardServiceHjy boardService;
	@Autowired
	BoardService_phj boardService_phj;
	@Autowired
	CommentsServiceHjy commentsService;
	@Autowired
	ServletContext sc;
	@GetMapping("phj/board/delete")
	public String boardDelete(int bid) {
		boardService_phj.deleteBoard(bid);
		return "redirect:/phj/home";
	}
	@GetMapping("phj/board/update")
	public String updateForm(int bid,Model model) {
		BoardVo_phj vo=boardService.detail(bid);
		model.addAttribute("vo",vo);
		return "user/hjy/board/mypage_update";
	}
	@PostMapping("phj/board/update")
	public String update(Model model,BoardVo_phj vo,MultipartHttpServletRequest mtfRequest) {
		List<MultipartFile> fileList = mtfRequest.getFiles("file");
		String path = sc.getRealPath("/resources/images/board");
		for(MultipartFile file : fileList) {
			if(file.getOriginalFilename()!="") {
				String orgfilename = file.getOriginalFilename();// 전송된 파일명
				String savefilename = UUID.randomUUID() + "_" + orgfilename;// 저장할 파일명(중복되지 않는 이름으로 만들기)
				try {
					// 1. 파일 업로드하기
					InputStream is = file.getInputStream();
					FileOutputStream fos = new FileOutputStream(path + "//" + savefilename);
					FileCopyUtils.copy(is, fos);
					is.close();
					fos.close();
					// 2. 업로드된 파일정보 DB에 저장하기
					if(vo.getBfile1()==null) {
						vo.setBfile1(savefilename);
					}else if(vo.getBfile2()==null){
						vo.setBfile2(savefilename);
					}else if(vo.getBfile3()==null){
						vo.setBfile3(savefilename);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		boardService_phj.updateBoard(vo);
		return "redirect:/phj/home";
	}
	
	@GetMapping("hjy/board/all")
	public ModelAndView boardAll(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
			String field, String keyword,BoardVo_phj vo) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("field", field);
		map.put("keyword", keyword);
		map.put("bcate", "all");
		
		PageUtil pu = new PageUtil(pageNum, 10, 5, boardService.count(map));
		map.put("startRow", pu.getStartRow());
		map.put("endRow", pu.getEndRow());
		List<BoardVo> list = boardService.list(map);
		System.out.println(list);
		ModelAndView mv=new ModelAndView("user/hjy/board/board_all");
		mv.addObject("list", list);
		mv.addObject("pu", pu);
		mv.addObject("field", field);
		mv.addObject("keyword", keyword);
		mv.addObject("bcate","all");
		return mv;
	}
	@GetMapping("hjy/board/review")
	public ModelAndView boardReview(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
			String field, String keyword,BoardVo_phj vo) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("field", field);
		map.put("keyword", keyword);
		map.put("bcate", "review");
		
		PageUtil pu = new PageUtil(pageNum, 10, 5, boardService.count(map));
		map.put("startRow", pu.getStartRow());
		map.put("endRow", pu.getEndRow());
		List<BoardVo> list = boardService.list(map);
		System.out.println(list);
		ModelAndView mv=new ModelAndView("user/hjy/board/board_review");
		mv.addObject("list", list);
		mv.addObject("pu", pu);
		mv.addObject("field", field);
		mv.addObject("keyword", keyword);
		mv.addObject("bcate","review");
		return mv;
	}
	@GetMapping("hjy/board/matching")
	public ModelAndView boardMatching(@RequestParam(value = "pageNum", defaultValue = "1") int pageNum,
			String field, String keyword,BoardVo_phj vo) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("field", field);
		map.put("keyword", keyword);
		map.put("bcate", "matching");
		
		PageUtil pu = new PageUtil(pageNum, 10, 5, boardService.count(map));
		map.put("startRow", pu.getStartRow());
		map.put("endRow", pu.getEndRow());
		List<BoardVo> list = boardService.list(map);
		ModelAndView mv=new ModelAndView("user/hjy/board/board_matching");
		mv.addObject("list", list);
		mv.addObject("pu", pu);
		mv.addObject("field", field);
		mv.addObject("keyword", keyword);
		mv.addObject("bcate","matching");
		return mv;
	}
	
	@GetMapping("hjy/board/detail")
	public String boardDeatailForm(int bid, Model model,HttpSession session) {
		BoardVo_phj vo = boardService.detail(bid);
		List<CommentsVo> commList = commentsService.list(bid);
		BoardVo nextVo = boardService.nextDetail(bid);
		BoardVo prevVo =boardService.prevDetail(bid);
		Integer cnt = commentsService.commcnt(bid);
		if(cnt==null) {
			cnt=0;
		}
		if(session.getAttribute("mid").equals(vo.getMid())) {
			model.addAttribute("my", "my");
		}
		model.addAttribute("vo", vo);
		model.addAttribute("commList", commList);
		model.addAttribute("cnt", cnt);
		model.addAttribute("nextVo", nextVo);
		model.addAttribute("prevVo", prevVo);
		return "user/hjy/board/boardDetail";
	}
	
	@GetMapping("hjy/board/newPost")
	public ModelAndView newPost(HttpServletRequest req,String bcate) {
		HttpSession session=req.getSession();
		String mid=(String)session.getAttribute("mid");
		ModelAndView mv=new ModelAndView("user/hjy/board/boardinsert");
		mv.addObject("bcate",bcate);
		System.out.println("카테고리:"+bcate);
		mv.addObject("mid",mid);
		return mv;
	}
	@RequestMapping(value="phj/board/boardinsert",method = RequestMethod.POST)
	public String insertBoard(BoardVo_phj vo,String bcate, MultipartHttpServletRequest mtfRequest) {
		List<MultipartFile> fileList = mtfRequest.getFiles("file");
		String path = sc.getRealPath("/resources/images/board");
		for(MultipartFile file : fileList) {
			if(file.getOriginalFilename()!="") {
				String orgfilename = file.getOriginalFilename();// 전송된 파일명
				String savefilename = UUID.randomUUID() + "_" + orgfilename;// 저장할 파일명(중복되지 않는 이름으로 만들기)
				try {
					// 1. 파일 업로드하기
					InputStream is = file.getInputStream();
					FileOutputStream fos = new FileOutputStream(path + "//" + savefilename);
					FileCopyUtils.copy(is, fos);
					is.close();
					fos.close();
					// 2. 업로드된 파일정보 DB에 저장하기
					if(vo.getBfile1()==null) {
						vo.setBfile1(savefilename);
					}else if(vo.getBfile2()==null){
						vo.setBfile2(savefilename);
					}else if(vo.getBfile3()==null){
						vo.setBfile3(savefilename);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		boardService_phj.insertBoard(vo);
		String result = "";
		if(bcate.equals("all")) {
			result= "redirect:/hjy/board/all";
		}else if(bcate.equals("review")) {
			result= "redirect:/hjy/board/review";
		}else if(bcate.equals("matching")) {
			result= "redirect:/hjy/board/matching";
		}
		return result;
	}

	@GetMapping("phj/home")
	public ModelAndView mypageBoard(HttpServletRequest req,
			BoardVo_phj vo,String field, String keyword,
			@RequestParam(value = "pageNum", defaultValue = "1") int pageNum) {
		HttpSession session=req.getSession();
		String mid=(String)session.getAttribute("mid");
		System.out.println("mid:"+mid);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("field", field);
		map.put("keyword", keyword);
		map.put("mid", mid);
		
		PageUtil pu = new PageUtil(pageNum, 10, 5, boardService_phj.count_phj(map));
		map.put("startRow", pu.getStartRow());
		map.put("endRow", pu.getEndRow());
		List<BoardVo_phj> list = boardService_phj.selectBoardMine(map);
		ModelAndView mv=new ModelAndView("user/hjy/board/boardMain");
		mv.addObject("list", list);
		mv.addObject("pu", pu);
		mv.addObject("field", field);
		mv.addObject("keyword", keyword);
		mv.addObject("mid", mid);
		return mv;
	}
	@GetMapping("phj/mypage/all")
	public ModelAndView mypageBoardAll(HttpServletRequest req,
			BoardVo_phj vo,String field, String keyword,
			@RequestParam(value = "pageNum", defaultValue = "1") int pageNum) {
		HttpSession session=req.getSession();
		String mid=(String)session.getAttribute("mid");
		System.out.println("mid:"+mid);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("field", field);
		map.put("keyword", keyword);
		map.put("mid", mid);
		map.put("bcate", "all");
		PageUtil pu = new PageUtil(pageNum, 10, 5, boardService_phj.count_phj_cate(map));
		map.put("startRow", pu.getStartRow());
		map.put("endRow", pu.getEndRow());
		List<BoardVo_phj> list = boardService_phj.selectBoardcate(map);
		ModelAndView mv=new ModelAndView("user/hjy/board/mypage_all");
		mv.addObject("list", list);
		mv.addObject("pu", pu);
		mv.addObject("field", field);
		mv.addObject("keyword", keyword);
		mv.addObject("mid", mid);
		mv.addObject("bcate", "all");
		return mv;
	}
	@GetMapping("phj/mypage/review")
	public ModelAndView mypageBoardReview(HttpServletRequest req,
			BoardVo_phj vo,String field, String keyword,
			@RequestParam(value = "pageNum", defaultValue = "1") int pageNum) {
		HttpSession session=req.getSession();
		String mid=(String)session.getAttribute("mid");
		System.out.println("mid:"+mid);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("field", field);
		map.put("keyword", keyword);
		map.put("mid", mid);
		map.put("bcate", "review");
		PageUtil pu = new PageUtil(pageNum, 10, 5, boardService_phj.count_phj_cate(map));
		map.put("startRow", pu.getStartRow());
		map.put("endRow", pu.getEndRow());
		List<BoardVo_phj> list = boardService_phj.selectBoardcate(map);
		ModelAndView mv=new ModelAndView("user/hjy/board/mypage_review");
		mv.addObject("list", list);
		mv.addObject("pu", pu);
		mv.addObject("field", field);
		mv.addObject("keyword", keyword);
		mv.addObject("mid", mid);
		mv.addObject("bcate", "all");
		return mv;
	}
	@GetMapping("phj/mypage/matching")
	public ModelAndView mypageBoardMatching(HttpServletRequest req,
			BoardVo_phj vo,String field, String keyword,
			@RequestParam(value = "pageNum", defaultValue = "1") int pageNum) {
		HttpSession session=req.getSession();
		String mid=(String)session.getAttribute("mid");
		System.out.println("mid:"+mid);
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("field", field);
		map.put("keyword", keyword);
		map.put("mid", mid);
		map.put("bcate", "matching");
		PageUtil pu = new PageUtil(pageNum, 10, 5, boardService_phj.count_phj_cate(map));
		map.put("startRow", pu.getStartRow());
		map.put("endRow", pu.getEndRow());
		List<BoardVo_phj> list = boardService_phj.selectBoardcate(map);
		ModelAndView mv=new ModelAndView("user/hjy/board/mypage_matching");
		mv.addObject("list", list);
		mv.addObject("pu", pu);
		mv.addObject("field", field);
		mv.addObject("keyword", keyword);
		mv.addObject("mid", mid);
		mv.addObject("bcate", "all");
		return mv;
	}
}
