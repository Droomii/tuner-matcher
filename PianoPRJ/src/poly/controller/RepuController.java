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

import poly.dto.RepuDTO;
import poly.dto.ReviewDTO;
import poly.service.IRepuService;
import poly.service.IReviewService;

@Controller
@RequestMapping("/repu")
public class RepuController {

	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "RepuService")
	IRepuService repuService;
	
	@Resource(name = "ReviewService")
	IReviewService reviewService;
	
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
		model.addAttribute("rDTO", rDTO);
		
		// 리뷰 목록 가져옴
		List<ReviewDTO> revList = reviewService.getTunerReviewList(tuner_seq);
		if(revList==null) {
			revList = new ArrayList<ReviewDTO>();
		}
		model.addAttribute("revList", revList);
		
		log.info(this.getClass().getName() + ".GetTunerRepu end");
		return "/repu/RepuModal";
	}
	
	
}
