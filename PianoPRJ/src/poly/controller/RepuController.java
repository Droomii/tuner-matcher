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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import poly.dto.RepuDTO;
import poly.dto.ReviewDTO;
import poly.dto.TunerDTO;
import poly.service.IRepuService;
import poly.service.IReviewService;
import poly.service.IUserService;
import poly.util.Pagination;

@Controller
@RequestMapping("/repu")
public class RepuController {

	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "RepuService")
	IRepuService repuService;
	
	@Resource(name = "ReviewService")
	IReviewService reviewService;
	
	@Resource(name = "UserService")
	IUserService userService;
	
	@RequestMapping(value = "GetTunerRepu")
	public String MyRepu(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".GetTunerRepu start");
		
		// 사용자 번호
		String tuner_seq = request.getParameter("tuner_seq");
		
		// 평판 가져옴
		RepuDTO rDTO = repuService.getRepu(tuner_seq);
		for(int rates : rDTO.getTechRates()) {
			log.info("rate : " + rates);
		}
		
		TunerDTO tDTO = userService.getTunerInfo(tuner_seq);
		model.addAttribute("tDTO", tDTO);
		model.addAttribute("rDTO", rDTO);
		
		// 리뷰 페이징
		// 페이징
		int page = 1;
		int listCnt = reviewService.getTunerReviewListCnt(tuner_seq);
		Pagination pg = new Pagination(listCnt, page, 5);

		int start = pg.getStartIndex() + 1;
		int end = pg.getStartIndex() + pg.getPageSize();
		model.addAttribute("pg", pg);
		
		
		// 리뷰 목록 가져옴
		List<ReviewDTO> revList = reviewService.getTunerReviewList(tuner_seq, start, end);
		if(revList==null) {
			revList = new ArrayList<ReviewDTO>();
		}
		model.addAttribute("revList", revList);
		
		log.info(this.getClass().getName() + ".GetTunerRepu end");
		return "/repu/RepuModal";
	}
	
	@RequestMapping(value = "RepuReviewList")
	public String GetTunerReviewList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model,
			@RequestParam(defaultValue = "1")int page)
			throws Exception {
		log.info(this.getClass().getName() + ".GetTunerReviewList start");
		
		String tuner_seq = request.getParameter("tuner_seq");
		int listCnt = reviewService.getTunerReviewListCnt(tuner_seq);
		Pagination pg = new Pagination(listCnt, page, 5);

		int start = pg.getStartIndex() + 1;
		int end = pg.getStartIndex() + pg.getPageSize();
		model.addAttribute("pg", pg);
		
		
		// 리뷰 목록 가져옴
		List<ReviewDTO> revList = reviewService.getTunerReviewList(tuner_seq, start, end);
		if(revList==null) {
			revList = new ArrayList<ReviewDTO>();
		}
		model.addAttribute("revList", revList);
		log.info(this.getClass().getName() + ".GetTunerReviewList end");
		return "/repu/RepuReviewList";
	}
	
}
