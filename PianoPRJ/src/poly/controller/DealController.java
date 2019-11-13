package poly.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.dto.DealDTO;
import poly.dto.ReqDTO;
import poly.service.IDealService;
import poly.service.IReqService;

@Controller
@RequestMapping(value = "deal/")
public class DealController {
	
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "ReqService")
	private IReqService reqService;

	@Resource(name = "DealService")
	private IDealService dealService;
	
	@RequestMapping(value = "PlaceBid")
	public String PlaceBid(HttpServletRequest request, ModelMap model, HttpSession session, @ModelAttribute DealDTO dDTO) throws Exception {
		String user_seq = (String)session.getAttribute("user_seq");
		ReqDTO rDTO = reqService.getReqDetail(dDTO.getReq_seq());
		dDTO.setRequester_seq(rDTO.getUser_seq());
		dDTO.setDeal_state("0");
		dDTO.setTuner_seq(user_seq);
		
		
		log.info("Deal_seq : " + dDTO.getDeal_seq());
		log.info("Req_seq : " + dDTO.getReq_seq());
		log.info("Requester_seq : " + dDTO.getRequester_seq());
		log.info("Tuner_seq : " + dDTO.getTuner_seq());
		log.info("Possible_date : " + dDTO.getPossible_date());
		log.info("Diagnosis_content : " + dDTO.getDiagnosis_content());
		log.info("Tuning_price : " + dDTO.getTuning_price());
		log.info("Regul_price : " + dDTO.getRegul_price());
		log.info("Voicing_price : " + dDTO.getVoicing_price());
		log.info("Transport_price : " + dDTO.getTransport_price());
		log.info("Other_price : " + dDTO.getOther_price());
		log.info("Regdate : " + dDTO.getRegdate());
		log.info("Upddate : " + dDTO.getUpddate());
		log.info("Updater_seq : " + dDTO.getUpdater_seq());
		log.info("Deal_state : " + dDTO.getDeal_state());
		log.info("Deal_type : " + dDTO.getDeal_type());
		log.info("Tuning_ea : " + dDTO.getTuning_ea());
		log.info("Regul_ea : " + dDTO.getRegul_ea());
		log.info("Voicing_ea : " + dDTO.getVoicing_ea());
		
		int res = dealService.insertDeal(dDTO);
		
		String msg;
		if(res>0) {
			msg = "입찰하였습니다";
		}else {
			msg = "입찰에 실패했습니다";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", "/index.do");
		return "/redirect";
		
		
	}
	
	
}
