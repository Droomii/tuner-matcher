package poly.controller;

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

import poly.dto.DealDTO;
import poly.dto.ReviewDTO;
import poly.service.IDealService;
import poly.service.IFollowService;
import poly.service.IReviewService;
import poly.service.impl.FollowService;
import poly.util.CmmUtil;
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
		if (SessionUtil.verify(session, "0", model) != null) {
			model = SessionUtil.verify(session, "0", model);
			return "/redirect";
		}
		String msg = "";
		String deal_seq = request.getParameter("deal_seq");
		
		String user_seq = (String)session.getAttribute("user_seq");
		try {
			int res = reviewService.deleteReview(deal_seq, user_seq);
			if(res > 0 ) {
				msg = "리뷰 삭제에 성공했습니다";
			}else{
				msg = "리뷰 삭제에 실패했습니다";
			}
		}catch(Exception e) {
			msg = "잘못된 접근입니다.";
		}
		String url = String.format("/deal/UserDealDetail.do?deal_seq=%s", deal_seq);
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		
		
		log.info(this.getClass().getName() + ".ReviewDelete end");
		return "/redirect";
	}
	
	@RequestMapping(value = "ReviewEdit")
	public String ReviewEdit(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".ReviewEdit start");
		
		if (SessionUtil.verify(session, "0", model) != null) {
			model = SessionUtil.verify(session, "0", model);
			log.info("걸림");
			return null;
		}
		
		String deal_seq = request.getParameter("deal_seq");
		String user_seq = (String)session.getAttribute("user_seq");
		ReviewDTO revDTO = reviewService.getReviewEditInfo(deal_seq, user_seq);
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

		if (SessionUtil.verify(session, "0", model) != null) {
			model = SessionUtil.verify(session, "0", model);
			return "/redirect";
		}
		
		String msg = "";
		String url ="";
		String user_seq = (String)session.getAttribute("user_seq");
		DealDTO dDTO = dealService.getDealDetail(revDTO.getDeal_seq());
		
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
			int res = reviewService.updateReview(revDTO);
			
			if(res > 0) {
				msg = "리뷰 수정에 등록했습니다.";
			}else {
				msg = "리뷰 수정에 실패했습니다.";
			}
		}catch(Exception e) {
			log.info(e.toString());
			msg = "리뷰 수정에 실패했습니다.";
		}finally {
			url = String.format("/deal/UserDealDetail.do?deal_seq=%s", revDTO.getDeal_seq());
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
		}
		
		log.info(this.getClass().getName() + ".ReviewEditProc end");
		return "/redirect";
	}

}