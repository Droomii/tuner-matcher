package poly.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import poly.dto.NoticeDTO;
import poly.service.INoticeService;
import poly.util.CmmUtil;

/*
 * Controller 선언해야만 Spring 프레임워크에서 Controller인지 인식 가능
 * 자바 서블릿 역할 수행
 * */
@RequestMapping(value = "notice/")
@Controller
public class NoticeController {
	private Logger log = Logger.getLogger(this.getClass());

	/*
	 * 비즈니스 로직(중요 로직을 수행하기 위해 사용되는 서비스를 메모리에 적재(싱글톤패턴 적용됨)
	 */
	@Resource(name = "NoticeService")
	private INoticeService noticeService;

	/*
	 * 함수명 위의 value="notice/NoticeList" => /notice/NoticeList.do로 호출되는 url은 무조건 이
	 * 함수가 실행된다. method=RequestMethod.GET => 폼 전송방법을 지정하는 것으로 get방식은 GET, post방식은
	 * POST이다. method => 기입안하면 GET, POST 모두 가능하나, 가급적 적어주는 것이 좋다.
	 */

	/**
	 * 게시판 리스트 보여주기
	 */
	@RequestMapping(value = "NoticeList")
	public String NoticeList(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {

		// 로그 찍기(추후 찍은 로그를 통해 이 함수에 접근했는지 파악하기 용이하다.)
		log.info(this.getClass().getName() + ".NoticeList start!");

		// 공지사항 리스트 가져오기
		List<NoticeDTO> rList = noticeService.getNoticeList();
		List<NoticeDTO> topList = noticeService.getTopNoticeList();

		if (rList == null) {
			rList = new ArrayList<NoticeDTO>();

		}
		for (NoticeDTO rDTO : rList) {
			rDTO.setNotice_title(CmmUtil.revertXSS(rDTO.getNotice_title()));
		}
		// 조회된 리스트 결과값 넣어주기
		model.addAttribute("rList", rList);
		model.addAttribute("topList", topList);

		// 변수 초기화(메모리 효율화 시키기 위해 사용함)
		rList = null;

		// 로그 찍기(추후 찍은 로그를 통해 이 함수 호출이 끝났는지 파악하기 용이하다.)
		log.info(this.getClass().getName() + ".NoticeList end!");

		// 함수 처리가 끝나고 보여줄 JSP 파일명(/WEB-INF/view/notice/NoticeList.jsp)
		return "/notice/NoticeList";
	}

	/**
	 * 게시판 작성 페이지 이동
	 * 
	 * 이 함수는 게시판 작성 페이지로 접근하기 위해 만듬. WEB-INF 밑에 존재하는 JSP는 직접 호출할 수 없음 따라서 WEB-INF 밑에
	 * 존재하는 JSP를 호출하기 위해서는 반드시 Controller 등록해야함
	 */
	@RequestMapping(value = "NoticeReg", method = RequestMethod.GET)
	public String NoticeReg(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

		log.info(this.getClass().getName() + ".NoticeReg start!");

		log.info(this.getClass().getName() + ".NoticeReg end!");

		return "/notice/NoticeReg";
	}

	/**
	 * 게시판 글 등록
	 */
	@RequestMapping(value = "NoticeInsert", method = RequestMethod.POST)
	public String NoticeInsert(HttpSession session, HttpServletRequest request, HttpServletResponse response,
			ModelMap model, @ModelAttribute NoticeDTO nDTO) throws Exception {

		log.info(this.getClass().getName() + ".NoticeInsert start!");
		String user_seq = (String) session.getAttribute("user_seq");
		nDTO.setWriter_seq(user_seq);

		if(nDTO.getTop()==null) {
			nDTO.setTop("N");
		}
		
		log.info("title : " + nDTO.getNotice_title());
		log.info("content : " + nDTO.getNotice_content());
		log.info("writer_seq : " + nDTO.getWriter_seq());

		String msg = "공지를 등록하였습니다.";

		try {
			noticeService.insertNoticeInfo(nDTO);
		} catch (Exception e) {

			// 저장이 실패되면 사용자에게 보여줄 메시지
			msg = "실패하였습니다. : " + e.toString();
			log.info(e.toString());
			e.printStackTrace();

		} finally {
			log.info(this.getClass().getName() + ".NoticeInsert end!");

			// 결과 메시지 전달하기
			model.addAttribute("msg", msg);
			model.addAttribute("url", "/notice/NoticeList.do");

		}

		return "/redirect";
	}

	/**
	 * 게시판 상세보기
	 */
	@RequestMapping(value = "NoticeInfo", method = RequestMethod.GET)
	public String NoticeInfo(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {

		log.info(this.getClass().getName() + ".NoticeInfo start!");

		/*
		 * 게시판 글 등록되기 위해 사용되는 form객체의 하위 input 객체 등을 받아오기 위해 사용함
		 */
		String nSeq = CmmUtil.nvl(request.getParameter("notice_seq")); // 공지글번호(PK)

		/*
		 * ####################################################### 반드시, 값을 받았으면, 꼭 로그를
		 * 찍어서 값이 제대로 들어오는지 파악해야함 반드시 작성할 것
		 * #######################################################
		 */
		log.info("nSeq : " + nSeq);

		/*
		 * 값 전달은 반드시 DTO 객체를 이용해서 처리함 전달 받은 값을 DTO 객체에 넣는다.
		 */
		NoticeDTO pDTO = new NoticeDTO();

		pDTO.setNotice_seq(nSeq);
		;

		// 공지사항 글 조회수 증가
		noticeService.updateNoticeReadCnt(pDTO);

		log.info("read_cnt update success!!!");

		// 공지사항 상세정보 가져오기
		NoticeDTO rDTO = noticeService.getNoticeInfo(pDTO);

		if (rDTO == null) {
			rDTO = new NoticeDTO();

		}

		log.info("getNoticeInfo success!!!");
		log.info("title before revertXSS : " + rDTO.getNotice_title());
		rDTO.setNotice_content(CmmUtil.revertXSS(rDTO.getNotice_content()));
		rDTO.setNotice_title(CmmUtil.revertXSS(rDTO.getNotice_title()));
		log.info("title before revertXSS : " + rDTO.getNotice_title());
		// 조회된 리스트 결과값 넣어주기
		model.addAttribute("rDTO", rDTO);

		// 변수 초기화(메모리 효율화 시키기 위해 사용함)
		rDTO = null;
		pDTO = null;

		log.info(this.getClass().getName() + ".NoticeInfo end!");

		return "/notice/NoticeInfo";
	}

	/**
	 * 게시판 수정 보기
	 */
	@RequestMapping(value = "NoticeEditInfo")
	public String NoticeEditInfo(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {

		String notice_seq = request.getParameter("notice_seq");
		NoticeDTO pDTO = new NoticeDTO();
		pDTO.setNotice_seq(notice_seq);
		
		NoticeDTO rDTO = noticeService.getNoticeInfo(pDTO);
		/*
		 * ####################################################### 공지사항 수정정보 가져오기(상세보기
		 * 쿼리와 동일하여, 같은 서비스 쿼리 사용함)
		 * #######################################################
		 */

		if (rDTO == null) {
			rDTO = new NoticeDTO();

		}

		log.info(rDTO.getNotice_content());
		log.info(rDTO.getNotice_seq());
		log.info(rDTO.getNotice_title());
		log.info(rDTO.getTop());
		
		// 조회된 리스트 결과값 넣어주기
		model.addAttribute("rDTO", rDTO);

		// 변수 초기화(메모리 효율화 시키기 위해 사용함)
		rDTO = null;
		pDTO = null;

		log.info(this.getClass().getName() + ".NoticeEditInfo end!");

		return "/notice/NoticeEditInfo";
	}

	/**
	 * 게시판 글 수정
	 */
	@RequestMapping(value = "NoticeUpdate", method = RequestMethod.POST)
	public String NoticeUpdate(HttpSession session, HttpServletRequest request, HttpServletResponse response,
			ModelMap model, @ModelAttribute NoticeDTO pDTO) throws Exception {

		if(pDTO.getTop()==null) {
			pDTO.setTop("N");
		}
		pDTO.setUpdater_seq((String)session.getAttribute("user_seq"));
		
		log.info(this.getClass().getName() + ".NoticeUpdate start!");

		String msg = "";

		try {

			// 게시글 수정하기 DB
			noticeService.updateNoticeInfo(pDTO);

			msg = "수정되었습니다.";

			// 변수 초기화(메모리 효율화 시키기 위해 사용함)
			pDTO = null;

		} catch (Exception e) {
			msg = "실패하였습니다. : " + e.toString();
			log.info(e.toString());
			e.printStackTrace();

		} finally {
			log.info(this.getClass().getName() + ".NoticeUpdate end!");

			// 결과 메시지 전달하기
			model.addAttribute("msg", msg);
			model.addAttribute("url", "/notice/NoticeList.do");

		}

		return "/redirect";
	}

	/**
	 * 게시판 글 삭제
	 */
	@RequestMapping(value = "NoticeDelete", method = RequestMethod.POST)
	public String NoticeDelete(HttpSession session, HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception {

		log.info(this.getClass().getName() + ".NoticeDelete start!");

		
		String msg = "";

		try {

			String nSeq = CmmUtil.nvl(request.getParameter("notice_seq")); // 글번호(PK)

			log.info("nSeq : " + nSeq);

			NoticeDTO pDTO = new NoticeDTO();

			pDTO.setNotice_seq(nSeq);
			;

			// 게시글 삭제하기 DB
			noticeService.deleteNoticeInfo(pDTO);
			;

			msg = "삭제되었습니다.";

			// 변수 초기화(메모리 효율화 시키기 위해 사용함)
			pDTO = null;
			model.addAttribute("url", "/notice/NoticeList.do");
		} catch (Exception e) {
			msg = "실패하였습니다. : " + e.toString();
			log.info(e.toString());
			e.printStackTrace();

		} finally {
			log.info(this.getClass().getName() + ".NoticeDelete end!");

			// 결과 메시지 전달하기
			model.addAttribute("msg", msg);

		}

		return "/redirect";
	}

}
