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
import org.springframework.web.bind.annotation.RequestParam;

import poly.dto.DealDTO;
import poly.dto.ReviewDTO;
import poly.service.IDealService;
import poly.service.IFollowService;
import poly.service.IReviewService;
import poly.service.impl.FollowService;
import poly.util.CmmUtil;
import poly.util.Pagination;
import poly.util.SessionUtil;

@Controller
@RequestMapping(value = "/review")
public class ReviewController {

	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="ReviewService")
	private IReviewService reviewService;
	
	@Resource(name = "DealService")
	private IDealService dealService;
	
	@Resource(name="FollowService")
	private IFollowService followService;
	
	@RequestMapping(value = "ReviewSubmit", method = RequestMethod.POST)
	public String ReviewSubmit(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model,
			@ModelAttribute ReviewDTO revDTO)
			throws Exception {
		log.info(this.getClass().getName() + ".ReviewSubmit start");
		
		// 세션 확인
		if (SessionUtil.verify(session, "0", model) != null) {
			model = SessionUtil.verify(session, "0", model);
			return "/redirect";
		}
		String user_seq = (String)session.getAttribute("user_seq");
		DealDTO dDTO = dealService.getDealDetail(revDTO.getDeal_seq());
		
		String fav = CmmUtil.nvl(request.getParameter("fav"));
		
		String msg = "";
		String url ="";
		if(!user_seq.equals(dDTO.getRequester_seq())) {
			msg = "비정상적인 접근입니다.";
			url = "/index.do";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return "/redirect";
		}
		revDTO.setWriter_seq(user_seq);
		revDTO.setTuner_seq(dDTO.getTuner_seq());
		try {
			int res = reviewService.insertReview(revDTO);
			
			if(res > 0) {
				msg = "리뷰 등록에 등록했습니다.";
				if(fav.equals("1")) {
					try {
					followService.followTuner(user_seq, dDTO.getTuner_seq());
					}catch(Exception e) {
						
					}finally {
						msg = "리뷰 및 자주 찾는 조율사 등록에 성공했습니다.";
					}
					
				}
				
			}else {
				msg = "리뷰 등록에 실패했습니다.";
			}
		}catch(Exception e) {
			log.info(e.toString());
			msg = "리뷰 등록에 실패했습니다.";
		}finally {
			url = String.format("/deal/UserDealDetail.do?deal_seq=%s", revDTO.getDeal_seq());
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
		}
		
		log.info(this.getClass().getName() + ".ReviewSubmit end");
		return "/redirect";
	}
	
	@RequestMapping(value = "ReviewDelete")
	public String ReviewDelete(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".ReviewDelete start");
		String user_type = (String) session.getAttribute("user_type");
		if (SessionUtil.verify(session, "[02]", model) != null) {
			model = SessionUtil.verify(session, "[02]", model);
			return "/redirect";
		}
		
		String userTypeEng = user_type.equals("0") ? "User" : "Admin";
		String msg = "";
		String deal_seq = request.getParameter("deal_seq");
		
		String user_seq = (String)session.getAttribute("user_seq");
		try {
			int res;
			
			if(user_type.equals("2"))
				res = reviewService.deleteReview(deal_seq, "admin");
			else
				res = reviewService.deleteReview(deal_seq, user_seq);
			if(res > 0 ) {
				msg = "리뷰 삭제에 성공했습니다";
			}else{
				msg = "리뷰 삭제에 실패했습니다";
			}
		}catch(Exception e) {
			log.info(e.toString());
			msg = "잘못된 접근입니다.";
		}
		String url = String.format("/deal/%sDealDetail.do?deal_seq=%s", userTypeEng, deal_seq);
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		
		
		log.info(this.getClass().getName() + ".ReviewDelete end");
		return "/redirect";
	}
	
	@RequestMapping(value = "ReviewEdit")
	public String ReviewEdit(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".ReviewEdit start");
		String user_type = (String) session.getAttribute("user_type");
		if (SessionUtil.verify(session, "[02]", model) != null) {
			model = SessionUtil.verify(session, "[02]", model);
			log.info("걸림");
			return null;
		}
		
		String deal_seq = request.getParameter("deal_seq");
		String user_seq = (String)session.getAttribute("user_seq");
		ReviewDTO revDTO = null;
		if(user_type.equals("2")) {
			revDTO = reviewService.getReviewEditInfo(deal_seq, "admin");
		}else {
			revDTO = reviewService.getReviewEditInfo(deal_seq, user_seq);
		}
		revDTO.setDeal_seq(deal_seq);
		model.addAttribute("revDTO", revDTO);
		log.info(this.getClass().getName() + ".ReviewEdit end");
		return "/review/ReviewEditForm";
	}
	
	@RequestMapping(value = "ReviewEditProc")
	public String ReviewEditProc(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model,
			@ModelAttribute ReviewDTO revDTO)
			throws Exception {
		log.info(this.getClass().getName() + ".ReviewEditProc start");
		String user_type = (String) session.getAttribute("user_type");
		if (SessionUtil.verify(session, "[02]", model) != null) {
			model = SessionUtil.verify(session, "[02]", model);
			return "/redirect";
		}
		
		String msg = "";
		String url ="";
		String user_seq = (String)session.getAttribute("user_seq");
		DealDTO dDTO = dealService.getDealDetail(revDTO.getDeal_seq());
		
		if(!user_seq.equals(dDTO.getRequester_seq()) && !user_type.equals("2")) {
			msg = "비정상적인 접근입니다.";
			url = "/index.do";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return "/redirect";
		}
		if(!user_type.equals("2"))
			revDTO.setWriter_seq(user_seq);
		else
			revDTO.setWriter_seq(null);
		revDTO.setUpdater_seq(user_seq);
		revDTO.setTuner_seq(dDTO.getTuner_seq());
		log.info("revDTO.getWriter_seq() : " + revDTO.getWriter_seq());
		log.info("revDTO.getDeal_seq() : " + revDTO.getDeal_seq());
		try {
			int res = reviewService.updateReview(revDTO);
			
			if(res > 0) {
				msg = "리뷰를 수정하였습니다.";
			}else {
				msg = "리뷰 수정에 실패했습니다.";
			}
		}catch(Exception e) {
			log.info(e.toString());
			msg = "리뷰 수정에 실패했습니다.";
		}finally {
			String redirectUrl = user_type.equals("2") ? "/deal/AdminDealDetail.do?deal_seq=%s":"/deal/UserDealDetail.do?deal_seq=%s";
			url = String.format(redirectUrl, revDTO.getDeal_seq());
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
		}
		
		log.info(this.getClass().getName() + ".ReviewEditProc end");
		return "/redirect";
	}
	
	@RequestMapping(value = "ReviewList")
	public String GetTunerReviewList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model,
			@RequestParam(defaultValue = "1")int page)
			throws Exception {
		log.info(this.getClass().getName() + ".ReviewList start");
		if (SessionUtil.verify(session, "2", model) != null) {
			model = SessionUtil.verify(session, "2", model);
			return "/redirect";
		}
		
		int listCnt = reviewService.getReviewListCnt();
		Pagination pg = new Pagination(listCnt, page, 5);

		int start = pg.getStartIndex() + 1;
		int end = pg.getStartIndex() + pg.getPageSize();
		model.addAttribute("pg", pg);
		
		
		// 리뷰 목록 가져옴
		List<ReviewDTO> revList = reviewService.getReviewList(start, end);
		if(revList==null) {
			revList = new ArrayList<ReviewDTO>();
		}
		model.addAttribute("revList", revList);
		log.info(this.getClass().getName() + ".ReviewList end");
		return "/review/ReviewList";
	}

}