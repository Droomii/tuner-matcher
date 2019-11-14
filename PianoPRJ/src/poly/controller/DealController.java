package poly.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.dto.DealDTO;
import poly.dto.PianoDTO;
import poly.dto.ReqDTO;
import poly.service.IDealService;
import poly.service.IPianoService;
import poly.service.IReqService;
import poly.util.SessionUtil;

@Controller
@RequestMapping(value = "deal/")
public class DealController {
	
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "ReqService")
	private IReqService reqService;

	@Resource(name = "DealService")
	private IDealService dealService;
	
	@Resource(name = "PianoService")
	private IPianoService pianoService;
	
	@RequestMapping(value = "PlaceBid")
	public String PlaceBid(HttpServletRequest request, ModelMap model, HttpSession session, @ModelAttribute DealDTO dDTO) throws Exception {
		String user_seq = (String)session.getAttribute("user_seq");
		ReqDTO rDTO = reqService.getReqDetail(dDTO.getReq_seq());
		dDTO.setRequester_seq(rDTO.getUser_seq());
		dDTO.setDeal_state("0");
		dDTO.setTuner_seq(user_seq);
		
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
	
	@RequestMapping(value = "TunerBidList")
	public String TunerBidList(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception{
		String user_seq = (String)session.getAttribute("user_seq");
		String user_type = (String)session.getAttribute("user_type");
		
		if(SessionUtil.verify(user_seq, user_type, "1", model)!=null) {
			model = SessionUtil.verify(user_seq, user_type, "1", model);
			return "/redirect";
		}
		
		List<DealDTO> dList = dealService.getBiddingList(user_seq);
		if(dList==null) {
			dList = new ArrayList<>();
		}
		
		model.addAttribute("dList", dList);
		
		return "/deal/TunerBidList";
	}
	
	@RequestMapping(value="BidDetail")
	public String BidDetail(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception{
		String user_seq = (String)session.getAttribute("user_seq");
		String user_type = (String)session.getAttribute("user_type");
		
		if(SessionUtil.verify(user_seq, user_type, "1", model)!=null) {
			model = SessionUtil.verify(user_seq, user_type, "1", model);
			return "/redirect";
		}
		
		String deal_seq = request.getParameter("deal_seq");
		DealDTO dDTO = dealService.getDealDetail(deal_seq);
		ReqDTO rDTO = reqService.getReqDetail(dDTO.getReq_seq());
		PianoDTO pDTO = pianoService.getPianoDetail(rDTO.getPiano_seq());
		
		model.addAttribute("dDTO : ",dDTO);
		model.addAttribute("rDTO : ",rDTO);
		model.addAttribute("pDTO : ",pDTO);
		
		
	}
}
