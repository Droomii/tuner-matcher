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

import poly.dto.DealDTO;
import poly.dto.PianoDTO;
import poly.dto.ReqDTO;
import poly.dto.ReviewDTO;
import poly.dto.UserDTO;
import poly.service.IDealService;
import poly.service.IPianoService;
import poly.service.IReqService;
import poly.service.IReviewService;
import poly.service.IUserService;
import poly.util.SessionUtil;

@Controller
@RequestMapping(value = "deal/")
public class DealController {
	
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "ReqService")
	private IReqService reqService;

	@Resource(name="UserService")
	private IUserService userService;
	
	@Resource(name = "DealService")
	private IDealService dealService;
	
	@Resource(name = "PianoService")
	private IPianoService pianoService;
	
	@Resource(name="ReviewService")
	private IReviewService reviewService;
	
	@RequestMapping(value = "PlaceBid")
	public String PlaceBid(HttpServletRequest request, ModelMap model, HttpSession session, @ModelAttribute DealDTO dDTO) throws Exception {
		String user_seq = (String)session.getAttribute("user_seq");
		
		if(SessionUtil.verify(session, "1", model)!=null) {
			model = SessionUtil.verify(session, "1", model);
			return "/redirect";
		}
		
		String deal_type = request.getParameter("deal_type");
		
		ReqDTO rDTO = reqService.getReqDetail(dDTO.getReq_seq());
		dDTO.setRequester_seq(rDTO.getUser_seq());
		dDTO.setDeal_state("0");
		dDTO.setTuner_seq(user_seq);
		
		int res = dealService.insertDeal(dDTO);
		String type = "";
		String url = "";
		if(deal_type.equals("0")) {
			type = "입찰";
			url = "/deal/TunerBidList.do";
		}else {
			type = "견적 등록";
			url = "/req/PrivateReqDetail.do?req_seq="+dDTO.getReq_seq();
		}
		
		String msg;
		if(res>0) {
			msg = type + "에 성공하였습니다";
		}else {
			msg = type + "에 실패했습니다";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "/redirect";
		
		
	}
	
	//-----------조율사입찰---------------
	
	@RequestMapping(value = "TunerBidList")
	public String TunerBidList(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception{
		String user_seq = (String)session.getAttribute("user_seq");

		if(SessionUtil.verify(session, "1", model)!=null) {
			model = SessionUtil.verify(session, "1", model);
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
		
		if(SessionUtil.verify(session, "1", model)!=null) {
			model = SessionUtil.verify(session, "1", model);
			return "/redirect";
		}
		
		String back = request.getParameter("back");
		if(back!=null) {
			model.addAttribute("back", "/deal/TunerPastDeals.do");
		}
		String deal_seq = request.getParameter("deal_seq");
		DealDTO dDTO = dealService.getDealDetail(deal_seq);
		ReqDTO rDTO = reqService.getReqDetail(dDTO.getReq_seq());
		PianoDTO pDTO = pianoService.getPianoEditInfo(rDTO.getPiano_seq());
		model.addAttribute("dDTO",dDTO);
		model.addAttribute("rDTO",rDTO);
		model.addAttribute("pDTO",pDTO);
		
		return "/deal/BidDetail";
		
	}

	@RequestMapping(value="BidCancel")
	public String BidCancel(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model) throws Exception{
		if(SessionUtil.verify(session, "0", model)==null) {
			model.addAttribute("msg", "비정상적인 접근입니다.");
			model.addAttribute("url", "/index.do");
			return "/redirect";
		}
		String deal_seq = request.getParameter("deal_seq");
		String req_seq = request.getParameter("req_seq");
		int res = dealService.bidCancel(deal_seq);
		String msg = "";
		String url = "";
		String what = "입찰 취소";
		if(req_seq!=null) {
			url = "/req/PrivateReqDetail.do?req_seq=" + req_seq;
			what = "견적 삭제";
		}else {
			url =  "/deal/TunerBidList.do";
		}
		
		if(res>0) {
			msg = what + "에 성공했습니다";
		}else {
			msg = what + "에 실패했습니다";
		}
		model.addAttribute("msg", msg);
		String user_type = (String)session.getAttribute("user_type");
		
		model.addAttribute("url", url);
		
		return "/redirect";
	}
	
	// 조율사 조율현황
	@RequestMapping(value = "TunerDealList")
	public String TunerDealList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".TunerDealList start");
		
		if (SessionUtil.verify(session, "1", model) != null) {
			model = SessionUtil.verify(session, "1", model);
			return "/redirect";
		}
		String user_seq = (String)session.getAttribute("user_seq");
		
		List<DealDTO> dList = dealService.getTunerDealList(user_seq);
		if(dList==null) {
			dList = new ArrayList<DealDTO>();
		}
		model.addAttribute("dList", dList);
		
		log.info(this.getClass().getName() + ".TunerDealList end");
		return "/deal/TunerDealList";
	}
	
	
	//-------------조율사 과거내역------------
	
	@RequestMapping(value="TunerPastDeals")
	public String TunerPastDeals(HttpServletRequest request, HttpServletResponse response
	, HttpSession session, ModelMap model) throws Exception{
		if(SessionUtil.verify(session, "1", model)!=null) {
			model = SessionUtil.verify(session, "1", model);
			return "/redirect";
		}
		
		String user_seq = (String)session.getAttribute("user_seq");
		List<DealDTO> dList = dealService.getPastDeals(user_seq);
		if(dList==null) {
			dList = new ArrayList<DealDTO>();
		}
		
		model.addAttribute("dList", dList);
		
		return "/deal/TunerPastDeals";
		
	}
	

	@RequestMapping(value = "TunerDealDetail")
	public String TunerDealDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".TunerDealDetail start");

		if (SessionUtil.verify(session, "1", model) != null) {
			model = SessionUtil.verify(session, "1", model);
			return "/redirect";
		}
		
		String back = request.getParameter("back");
		log.info("back : " + back);
		String deal_seq = request.getParameter("deal_seq");
		DealDTO dDTO = dealService.getDealDetail(deal_seq);
		ReqDTO rDTO = reqService.getReqDetail(dDTO.getReq_seq());
		PianoDTO pDTO = pianoService.getPianoDetail(rDTO.getPiano_seq());
		UserDTO uDTO = userService.getUserInfo(dDTO.getTuner_seq());
		ReviewDTO revDTO = reviewService.getDealReview(deal_seq);
		
		if(back!=null) {
			log.info("back is not null");
			model.addAttribute("back", "/deal/TunerPastDeals.do");
		}
		
		model.addAttribute("revDTO", revDTO);
		model.addAttribute("uDTO", uDTO);
		model.addAttribute("dDTO", dDTO);
		model.addAttribute("rDTO", rDTO);
		model.addAttribute("pDTO", pDTO);
		
		
		log.info(this.getClass().getName() + ".TunerDealDetail end");
		return "/deal/TunerDealDetail";
	}
	
	//----------------사용자---------------------
	
	//사용자 입찰
	@RequestMapping(value = "AuctionOff")
	public String AuctionOff(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".AuctionOff start");
		if (SessionUtil.verify(session, "0", model) != null) {
			model = SessionUtil.verify(session, "0", model);
			return "/redirect";
		}
		
		String user_seq = (String)session.getAttribute("user_seq");
		String deal_seq = request.getParameter("deal_seq");
		String req_seq = dealService.getDealDetail(deal_seq).getReq_seq();
		// 세션 사용자와 요청자 번호의 일치 여부 확인
		int res = 0;
		res = dealService.auctionOff(deal_seq, req_seq, user_seq);
		String url = "";
		String msg = "";
		if(res>0) {
			reqService.auctionOff(req_seq);
			msg = "채택에 성공했습니다";
			url="/deal/UserDealList.do";
		}else {
			msg = "채택에 실패했습니다";
			url="/deal/ReqBidDetail.do?deal_seq=" + deal_seq;
		}
		log.info(this.getClass().getName() + ".AuctionOff end");
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "/redirect";
	}
	
	@RequestMapping(value = "UserDealList")
	public String UserDealList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".UserDealList start");
		
		if (SessionUtil.verify(session, "0", model) != null) {
			model = SessionUtil.verify(session, "0", model);
			return "/redirect";
		}
		String user_seq = (String)session.getAttribute("user_seq");
		
		List<DealDTO> dList = dealService.getUserDealList(user_seq);
		if(dList==null) {
			dList = new ArrayList<DealDTO>();
		}
		model.addAttribute("dList", dList);
		
		log.info(this.getClass().getName() + ".UserDealList end");
		return "/deal/UserDealList";
	}
	
	@RequestMapping(value = "UserDealDetail")
	public String UserDealDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".UserDealDetail start");

		if (SessionUtil.verify(session, "0", model) != null) {
			model = SessionUtil.verify(session, "0", model);
			return "/redirect";
		}
		
		String deal_seq = request.getParameter("deal_seq");
		DealDTO dDTO = dealService.getDealDetail(deal_seq);
		ReqDTO rDTO = reqService.getReqDetail(dDTO.getReq_seq());
		PianoDTO pDTO = pianoService.getPianoDetail(rDTO.getPiano_seq());
		UserDTO uDTO = userService.getUserInfo(dDTO.getTuner_seq());
		ReviewDTO revDTO = reviewService.getDealReview(deal_seq);
		
		model.addAttribute("revDTO", revDTO);
		model.addAttribute("uDTO", uDTO);
		model.addAttribute("dDTO", dDTO);
		model.addAttribute("rDTO", rDTO);
		model.addAttribute("pDTO", pDTO);
		
		
		log.info(this.getClass().getName() + ".UserDealDetail end");
		return "/deal/UserDealDetail";
	}
	
	@RequestMapping(value = "UserDealCancel")
	public String UserDealCancel(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".UserDealCancel start");
		if (SessionUtil.verify(session, "0", model) != null) {
			model = SessionUtil.verify(session, "0", model);
			return "/redirect";
		}
		
		String user_seq = (String)session.getAttribute("user_seq");
		String deal_seq = request.getParameter("deal_seq");
		int user_type = 0;
		
		int res = dealService.dealCancel(deal_seq, user_seq, user_type);
		String url = "";
		String msg = "";
		if(res>0) {
			msg = "거래를 취소하였습니다";
			url="/deal/UserDealList.do";
		}else {
			msg = "거래 취소에 실패했습니다";
			url="/deal/UserDealDetail.do?deal_seq=" + deal_seq;
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		log.info(this.getClass().getName() + ".UserDealCancel end");
		return "/redirect";
	}
	
	@RequestMapping(value = "UserDealConfirm")
	public String UserDealConfirm(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".UserDealConfirm start");
		if (SessionUtil.verify(session, "0", model) != null) {
			model = SessionUtil.verify(session, "0", model);
			return "/redirect";
		}
		
		String user_seq = (String)session.getAttribute("user_seq");
		String deal_seq = request.getParameter("deal_seq");
		int user_type = 0;
		
		int res = dealService.dealConfirm(deal_seq, user_seq, user_type);
		String url = "";
		String msg = "";
		if(res>0) {
			msg = "거래를 완료하였습니다";
			url="/deal/UserDealList.do";
		}else {
			msg = "거래 완료에 실패했습니다";
			url="/deal/UserDealDetail.do?deal_seq=" + deal_seq;
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		log.info(this.getClass().getName() + ".UserDealConfirm end");
		return "/redirect";
	}
	
	// ----------------------------1:1---------------------------------
	
	// 견적 거절
	@RequestMapping(value = "DeclineDeal")
	public String DeclineDeal(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".DeclineDeal start");
		if (SessionUtil.verify(session, "0", model) != null) {
			model = SessionUtil.verify(session, "0", model);
			return "/redirect";
		}
		
		String user_seq = (String)session.getAttribute("user_seq");
		String deal_seq = request.getParameter("deal_seq");
		String req_seq = dealService.getDealDetail(deal_seq).getReq_seq();
		// 세션 사용자와 요청자 번호의 일치 여부 확인
		int res = 0;
		res = dealService.declineDeal(deal_seq, req_seq, user_seq);
		String url = "";
		String msg = "";
		if(res>0) {
			reqService.auctionOff(req_seq);
			msg = "거절하였습니다";
			url="/deal/UserDealList.do";
		}else {
			msg = "거절에 실패했습니다";
			url="/req/PrivateReqDetail.do?req_seq=" + req_seq;
		}
		log.info(this.getClass().getName() + ".DeclineDeal end");
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		return "/redirect";
	}
}
