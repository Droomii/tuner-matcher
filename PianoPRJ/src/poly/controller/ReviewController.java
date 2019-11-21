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
import poly.service.IReviewService;
import poly.util.SessionUtil;

@Controller
@RequestMapping(value = "/review")
public class ReviewController {

	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="ReviewService")
	private IReviewService reviewService;
	
	@Resource(name = "DealService")
	private IDealService dealService;
	
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
				msg = "리뷰를 등록했습니다.";
			}else {
				msg = "리뷰 등록에 실패했습니다.";
			}
		}catch(Exception e) {
			log.info(e.toString());
			msg = "리뷰 등록에 실패했습니다.";
			url = String.format("/deal/UserDealDetail.do?deal_seq=%s", revDTO.getDeal_seq());
		}finally {
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
		}
		
		log.info(this.getClass().getName() + ".ReviewSubmit end");
		return "/redirect";
	}
}
