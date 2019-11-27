package poly.controller;

import java.awt.Color;
import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.multipart.MultipartFile;

import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.filters.Canvas;
import net.coobird.thumbnailator.geometry.Positions;
import poly.dto.DealDTO;
import poly.dto.PianoDTO;
import poly.dto.RepuDTO;
import poly.dto.ReqDTO;
import poly.dto.ReviewDTO;
import poly.dto.TunerDTO;
import poly.dto.UserDTO;
import poly.service.IDealService;
import poly.service.IFollowService;
import poly.service.IPianoService;
import poly.service.IRepuService;
import poly.service.IReqService;
import poly.service.IReviewService;
import poly.service.ISggService;
import poly.service.IUserService;
import poly.util.CmmUtil;
import poly.util.FileUtil;
import poly.util.Pagination;
import poly.util.SessionUtil;

@RequestMapping(value = "req/")
@Controller
public class ReqController {
	
	@Resource(name="PianoService")
	private IPianoService pianoService;
	
	@Resource(name = "ReqService")
	private IReqService reqService;
	
	@Resource(name="UserService")
	private IUserService userService;
	
	@Resource(name="DealService")
	private IDealService dealService;
	
	@Resource(name = "FollowService")
	IFollowService followService;
	
	@Resource(name = "SggService")
	ISggService sggService;
	
	@Resource(name = "RepuService")
	IRepuService repuService;
	
	@Resource(name = "ReviewService")
	IReviewService reviewService;
	
	
	private Logger log = Logger.getLogger(this.getClass());
	
	@RequestMapping(value = "NewPublicReq")
	public String NewPublicReq(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception{
		log.info(this.getClass().getName() + ".MyPianoList start");
		String user_seq = (String)session.getAttribute("user_seq");
		
		List<PianoDTO> pList = pianoService.getMyPianoList(user_seq);
		if(pList==null) {
			log.info("plist is null!!");
			pList = new ArrayList<>();
		}
		model.addAttribute("pList", pList);
		session.setAttribute("proc", "public");
		
		return "/piano/MyPianoList";
	
	}
	
	@RequestMapping(value = "GetHour")
	public String GetHour(HttpServletRequest request, ModelMap model) throws Exception{
		String date = request.getParameter("date");
		log.info("date : " + date);
		model.addAttribute("date", date);
		return "/req/GetHours";
	}
	
	@RequestMapping(value = "publicReqSubmit")
	public String publicReqSubmit(HttpSession session, HttpServletRequest request, ModelMap model, @ModelAttribute ReqDTO rDTO,
			@RequestParam(value = "req_img") MultipartFile mf) throws Exception{

		
		if (SessionUtil.verify(session, "0", model) != null) {
			model = SessionUtil.verify(session, "0", model);
			return "/redirect";
		}
		String user_seq = (String)session.getAttribute("user_seq");
		rDTO.setUser_seq(user_seq);
		String msg = "";
		String url = "/req/UserPublicReqList.do";
		
		if(!mf.isEmpty()) {
			if(!FileUtil.isImage(mf)) {
				msg = "이미지 파일이 아닙니다.";
				model.addAttribute("msg", msg);
				model.addAttribute("url", url);
				return "/redirect";
			}
			rDTO.setPhoto_dir(FileUtil.getExt(mf));
		}
		
		int res = reqService.insertReq(rDTO);
		
		if(!mf.isEmpty()) {
			try {
			log.info("save image file!!");
			String path = "c:/piano_prj/req/" + rDTO.getReq_seq() + "/";
			String ext = FileUtil.saveImage(mf, "image", path);
			rDTO.setPhoto_dir(ext);
			}catch(Exception e) {
				msg = "이미지 파일 업로드에 실패했습니다.";
				model.addAttribute("msg", msg);
				model.addAttribute("url", url);
				return "/redirect";
			}
		}
		if(res>0) {
			msg = "요청서 등록에 성공했습니다";
		}else {
			msg = "요청서 등록에 실패했습니다";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "/redirect";
	}
	
	@RequestMapping(value = "UserPublicReqList")
	public String UserPublicReqList(HttpSession session, HttpServletRequest request, ModelMap model, @RequestParam(defaultValue = "1") int page) throws Exception{
		if (SessionUtil.verify(session, "0", model) != null) {
			model = SessionUtil.verify(session, "0", model);
			return "/redirect";
		}
		
		String user_seq = CmmUtil.nvl((String)session.getAttribute("user_seq"));
		
		// 페이징
		int listCnt =  reqService.getPublicReqListCnt(user_seq);
		Pagination pg = new Pagination(listCnt, page);
		model.addAttribute("pg", pg);
		
		ReqDTO rDTO = new ReqDTO();
		rDTO.setStartIndex(pg.getStartIndex());
		rDTO.setCntPerPage(pg.getPageSize());
		rDTO.setUser_seq(user_seq);
		
		List<ReqDTO> reqList = reqService.getPublicReqList(rDTO);
		
		
		if(reqList==null)
			reqList = new ArrayList<ReqDTO>();
		session.setAttribute("proc", "public");
		model.addAttribute("reqList", reqList);
		return "/req/MyReqList";
		
	}
	
	@RequestMapping(value = "ReqDetail")
	public String Detail(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		if (SessionUtil.verify(session, model) != null) {
			model = SessionUtil.verify(session, model);
			return "/redirect";
		}
		
		log.info(this.getClass().getName() + ".MyPianoList start");
		String user_type=(String)session.getAttribute("user_type");
		
		String req_seq = request.getParameter("req_seq");
		ReqDTO rDTO = reqService.getReqDetail(req_seq);
		
		
		if(user_type.equals("0")) {
			List<DealDTO> dList = dealService.getReqBid(req_seq);
			log.info("dList size : " + dList.size());
			model.addAttribute("dList", dList);
		}
		Map<String, List<String>> prefDates = reqService.parseDates(rDTO.getPref_date());
		log.info(prefDates);
		PianoDTO pDTO = pianoService.getPianoDetail(rDTO.getPiano_seq());
		model.addAttribute("pDTO", pDTO);
		model.addAttribute("rDTO", rDTO);
		model.addAttribute("prefDates", prefDates);
		
		return "/req/ReqDetail";
	
	}
	
	@RequestMapping(value = "ReqBidDetail")
	public String ReqBidDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".ReqBidDetail start");

		if (SessionUtil.verify(session, "0", model) != null) {
			model = SessionUtil.verify(session, "0", model);
			return "/redirect";
		}
		
		String deal_seq = request.getParameter("deal_seq");
		DealDTO dDTO = dealService.getDealDetail(deal_seq);
		ReqDTO rDTO = reqService.getReqDetail(dDTO.getReq_seq());
		PianoDTO pDTO = pianoService.getPianoDetail(rDTO.getPiano_seq());
		UserDTO uDTO = userService.getUserInfo(dDTO.getTuner_seq());
		String back = "/req/ReqDetail.do?req_seq=" + dDTO.getReq_seq();
		
		model.addAttribute("uDTO", uDTO);
		model.addAttribute("dDTO", dDTO);
		model.addAttribute("rDTO", rDTO);
		model.addAttribute("pDTO", pDTO);
		model.addAttribute("back", back);
		
		log.info(this.getClass().getName() + ".ReqBidDetail end");
		return "/req/ReqBidDetail";
	}
	
	@RequestMapping(value = "EditReq")
	public String EditReq(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception{
		if (SessionUtil.verify(session, "0", model) != null) {
			model = SessionUtil.verify(session, "0", model);
			return "/redirect";
		}
		
		log.info(this.getClass().getName() + ".EditReq start");
		String req_seq = request.getParameter("req_seq");
		ReqDTO rDTO = reqService.getReqDetail(req_seq);
		Map<String, List<String>> prefDates = reqService.parseDates(rDTO.getPref_date());
		log.info(prefDates);
		PianoDTO pDTO = pianoService.getPianoDetail(rDTO.getPiano_seq());
		model.addAttribute("proc", "Public");
		model.addAttribute("pDTO", pDTO);
		model.addAttribute("rDTO", rDTO);
		model.addAttribute("prefDates", prefDates);
		
		return "/req/EditReq";
	}
	
	@RequestMapping(value = "DoEditReq")
	public String DoEditReq(HttpServletRequest request, ModelMap model, HttpSession session, @ModelAttribute ReqDTO rDTO,
			@RequestParam(value="req_img") MultipartFile mf) throws Exception{
		if (SessionUtil.verify(session, "0", model) != null) {
			model = SessionUtil.verify(session, "0", model);
			return "/redirect";
		}
		
		log.info(this.getClass().getName() + ".DoEditReq start");
		String current_user = (String)session.getAttribute("user_seq");
		String back = request.getParameter("back");
		rDTO.setUpdater_seq(current_user);

		
		String msg;
		
		if(!mf.isEmpty()) {
			if(!FileUtil.isImage(mf)) {
				msg = "이미지 파일이 아닙니다.";
				model.addAttribute("msg", msg);
				model.addAttribute("url", back + ".do");
				return "/redirect";
			}
			rDTO.setPhoto_dir(FileUtil.getExt(mf));
		}
		
		int res = reqService.updateReq(rDTO);
		
		if(!mf.isEmpty()) {
			try {
			log.info("save image file!!");
			String path = "c:/piano_prj/req/" + rDTO.getReq_seq() + "/";
			String ext = FileUtil.saveImage(mf, "image", path);
			rDTO.setPhoto_dir(ext);
			}catch(Exception e) {
				msg = "이미지 파일 업로드에 실패했습니다.";
				model.addAttribute("msg", msg);
				model.addAttribute("url", back + ".do");
				return "/redirect";
			}
		}
		
		
		
		
		
		if(res>0) {
			msg = "요청서 수정에 성공했습니다";
		}else {
			msg = "요청서 수정에 실패했습니다";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", back + ".do");
		return "/redirect";
	}
	
	@RequestMapping(value="DeleteReq", method=RequestMethod.POST)
	public String DeleteReq(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		if (SessionUtil.verify(session, "0", model) != null) {
			model = SessionUtil.verify(session, "0", model);
			return "/redirect";
		}
		
		log.info(this.getClass().getName() + ".DeleteReq start");
		String msg = "";
		if(session.getAttribute("user_seq")==null) {
			msg = "세션이 만료되었습니다. 다시 로그인 해주세요";
			model.addAttribute("msg", msg);
			model.addAttribute("url", "/index.do");
		}else {
			String req_seq = request.getParameter("req_seq");
			String private_seq = request.getParameter("private_seq");
			int res = reqService.deleteReq(req_seq);
			
			
			
			if(res>0) {
				msg = "요청서 삭제에 성공했습니다";
			}else {
				msg = "요청서 삭제에 실패했습니다";
			}
			String type = private_seq==null ? "Public" : "Private";
			model.addAttribute("msg", msg);
			model.addAttribute("url", "/req/User" + type + "ReqList.do");
		}
		
		
		return "/redirect";
	
	
	}
	
	// ------------------------------1:1 요청---------------------------------------
	
	//1:1 요청 목록
	@RequestMapping(value = "UserPrivateReqList")
	public String UserPrivateReqList(HttpSession session, HttpServletRequest request, ModelMap model, @RequestParam(defaultValue = "1") int page) throws Exception{
		if (SessionUtil.verify(session, "0", model) != null) {
			model = SessionUtil.verify(session, "0", model);
			return "/redirect";
		}
		
		String user_seq = CmmUtil.nvl((String)session.getAttribute("user_seq"));
		
		// 페이징
		int listCnt =  reqService.getPrivateReqListCnt(user_seq);
		Pagination pg = new Pagination(listCnt, page);
		model.addAttribute("pg", pg);
		
		ReqDTO rDTO = new ReqDTO();
		rDTO.setStartIndex(pg.getStartIndex());
		rDTO.setCntPerPage(pg.getPageSize());
		rDTO.setUser_seq(user_seq);
		
		
		
		List<ReqDTO> reqList = reqService.getPrivateReqList(rDTO);
		
		if(reqList==null)
			reqList = new ArrayList<ReqDTO>();
		session.setAttribute("proc", "public");
		model.addAttribute("reqList", reqList);
		return "/req/UserPrivateReqList";
		
	}
	
	
	//1:1 요청 상세
	@RequestMapping(value = "PrivateReqDetail")
	public String PrivateReqDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".ReqBidDetail start");

		if (SessionUtil.verify(session, model) != null) {
			model = SessionUtil.verify(session, model);
			return "/redirect";
		}
		String user_type=(String)session.getAttribute("user_type");
		String req_seq = request.getParameter("req_seq");
		
		ReqDTO rDTO = reqService.getReqDetail(req_seq);
		DealDTO dDTO = dealService.getPrivateEstimate(req_seq);
		if(dDTO==null) {
			log.info("dDTO is null");
		}
		PianoDTO pDTO = pianoService.getPianoDetail(rDTO.getPiano_seq());
		UserDTO uDTO = userService.getUserInfo(rDTO.getPrivate_seq());
		String back;
		if(user_type.equals("0")) {
			back = "/req/UserPrivateReqList.do";
		}else {
			back = "/req/TunerPrivateReqList.do";
		}
		Map<String, List<String>> prefDates = reqService.parseDates(rDTO.getPref_date());
		
		model.addAttribute("uDTO", uDTO);
		model.addAttribute("dDTO", dDTO);
		model.addAttribute("rDTO", rDTO);
		model.addAttribute("pDTO", pDTO);
		model.addAttribute("back", back);
		model.addAttribute("prefDates", prefDates);
		
		
		log.info(this.getClass().getName() + ".ReqBidDetail end");
		return "/req/PrivateReqDetail";
	}
	
	// 새 1:1 요청
	@RequestMapping(value = "NewPrivateReq")
	public String NewPrivateReq(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".NewPrivateReq start");
		if (SessionUtil.verify(session, "0", model) != null) {
			model = SessionUtil.verify(session, "0", model);
			return "/redirect";
		}
		
		String user_seq = (String)session.getAttribute("user_seq");
		String tuner_seq = request.getParameter("tuner_seq");
		
		
		// 조율사 이미 선택했을 경우
		if(tuner_seq!=null) {
			
			List<PianoDTO> pList = pianoService.getMyPianoList(user_seq);
			if(pList==null) {
				log.info("plist is null!!");
				pList = new ArrayList<>();
			}
			
			model.addAttribute("pList", pList);
			model.addAttribute("tuner_seq", tuner_seq);
			return "/req/PrivateSelectPiano";
		}
		
		// 조율사 선택 안했을 경우
		List<TunerDTO> tList = followService.getFollowingList(user_seq); 
		if(tList==null) {
			tList = new ArrayList<TunerDTO>();
		}
		model.addAttribute("tList", tList);
		
		log.info(this.getClass().getName() + ".NewPrivateReq end");
		return "/req/PrivateSelectTuner";
		
	}
	
	// 조율사 정보 가져오기
		@RequestMapping(value = "PrivateTunerDetail")
		public String PrivateTunerDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
				throws Exception {
			log.info(this.getClass().getName() + ".TunerDetail start");
			
			if (SessionUtil.verify(session, model) != null) {
				model = SessionUtil.verify(session, model);
				return "/redirect";
			}
			
			// 기본 정보 가져오기
			String tuner_seq = request.getParameter("tuner_seq");
			UserDTO uDTO = userService.getUserInfo(tuner_seq);
			model.addAttribute("uDTO", uDTO);
			
			// 조율사 정보 가져오기
			TunerDTO tDTO = userService.getTunerInfo(tuner_seq);
			model.addAttribute("tDTO", tDTO);
			
			// 시군구 정보
			Map<String, ArrayList<String>> sggGrouped = sggService.getTunerSgg(tuner_seq);
			model.addAttribute("sggGrouped", sggGrouped);
			

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
			
			log.info(this.getClass().getName() + ".TunerDetail end");
			return "/req/PrivateTunerDetail";
		}
	
	
	@RequestMapping(value = "PrivatePianoDetail")
	public String PrivatePianoDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".PrivatePianoDetail start");
		if (SessionUtil.verify(session, "0", model) != null) {
			model = SessionUtil.verify(session, "0", model);
			return "/redirect";
		}
		String piano_seq = request.getParameter("no");
		PianoDTO pDTO = pianoService.getPianoDetail(piano_seq);
		model.addAttribute("pDTO", pDTO);
		
		// 조율사 이미 선택했는지 확인
		String tuner_seq = request.getParameter("tuner_seq");

		model.addAttribute("tuner_seq", tuner_seq);
		
		
		
		log.info(this.getClass().getName() + ".PrivatePianoDetail end");
		return "/req/PrivatePianoDetail";
	}
	
	@RequestMapping(value = "PrivateReqSubmit")
	public String PrivateReqSubmit(HttpSession session, HttpServletRequest request, ModelMap model, @ModelAttribute ReqDTO rDTO,
			@RequestParam(value="req_img") MultipartFile mf) throws Exception{
		if (SessionUtil.verify(session, "0", model) != null) {
			model = SessionUtil.verify(session, "0", model);
			return "/redirect";
		}
		
		
		String user_seq = (String)session.getAttribute("user_seq");
		rDTO.setUser_seq(user_seq);
		String msg = "";
		String url = "/req/UserPrivateReqList.do";
		
		if(!mf.isEmpty()) {
			if(!FileUtil.isImage(mf)) {
				msg = "이미지 파일이 아닙니다.";
				model.addAttribute("msg", msg);
				model.addAttribute("url", url);
				return "/redirect";
			}
			rDTO.setPhoto_dir(FileUtil.getExt(mf));
		}
		
		int res = reqService.insertReq(rDTO);
		
		if(!mf.isEmpty()) {
			try {
			log.info("save image file!!");
			String path = "c:/piano_prj/req/" + rDTO.getReq_seq() + "/";
			String ext = FileUtil.saveImage(mf, "image", path);
			rDTO.setPhoto_dir(ext);
			}catch(Exception e) {
				msg = "이미지 파일 업로드에 실패했습니다.";
				model.addAttribute("msg", msg);
				model.addAttribute("url", url);
				return "/redirect";
			}
		}
		if(res>0) {
			msg = "1:1 요청에 성공했습니다";
		}else {
			msg = "1:1 요청에 실패했습니다";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "/redirect";
	}
	
	
	
	// ----------------------조율사-------------------------
	// 내 주변에서 찾기
	@RequestMapping(value = "TunerPublicReqList")
	public String NearReqList(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		session.setAttribute("proc", "public");
		log.info(this.getClass().getName() + ".NearReqList start");
		if (SessionUtil.verify(session, "1", model) != null) {
			model = SessionUtil.verify(session, "1", model);
			return "/redirect";
		}
		
		String tuner_seq = (String)session.getAttribute("user_seq");
		log.info("tuner_seq : "+tuner_seq);
		TunerDTO tDTO = userService.getTunerAddr(tuner_seq);
		log.info("Addr : " + tDTO.getAddr());
		log.info("X_pos : " + tDTO.getX_pos());
		log.info("Y_pos : " + tDTO.getY_pos());
		model.addAttribute("tDTO", tDTO);
		
		// 요청목록
		List<ReqDTO> rList = reqService.getNearReqList(tuner_seq);
		List<Integer> dList = dealService.getBidPlacedReqs(tuner_seq);
		log.info("dList : " + dList);
		if(rList == null) {
			rList = new ArrayList<>();
		}
		
		model.addAttribute("rList", rList);
		model.addAttribute("dList", dList);
		return "/req/TunerPublicReqList";
	}
	
	//1:1 요청서
	@RequestMapping(value = "TunerPrivateReqList")
	public String TunerPrivateReqList(HttpServletRequest request, ModelMap model, HttpSession session,
			@RequestParam(defaultValue = "1") int page) throws Exception {
		log.info(this.getClass().getName() + ".TunerPrivateReqList start");
		if (SessionUtil.verify(session, "1", model) != null) {
			model = SessionUtil.verify(session, "1", model);
			return "/redirect";
		}
		
		String tuner_seq = (String)session.getAttribute("user_seq");
		log.info("tuner_seq : "+tuner_seq);
		
		// 페이징
		int listCnt = reqService.getTunerPrivateReqListCnt(tuner_seq);
		Pagination pg = new Pagination(listCnt, page);

		int start = pg.getStartIndex() + 1;
		int end = pg.getStartIndex() + pg.getPageSize();
		model.addAttribute("pg", pg);
		
		// 요청목록
		List<ReqDTO> rList = reqService.getTunerPrivateReqList(tuner_seq, start, end);
		model.addAttribute("rList", rList);
		return "/req/TunerPrivateReqList";
	}
	
	
	// 1:1 요청서 거절
	@RequestMapping(value = "DeclineReq")
	public String DeclineReq(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".DeclineReq start");
		if (SessionUtil.verify(session, "1", model) != null) {
			model = SessionUtil.verify(session, "1", model);
			return "/redirect";
		}
		
		String tuner_seq = (String)session.getAttribute("user_seq");
		String req_seq = request.getParameter("req_seq");
		int res = reqService.declineReq(req_seq, tuner_seq);
		
		String msg = "";
		
		if(res>0) {
			msg = "요청을 거절했습니다";
		}else {
			msg = "요청 거절에 실패했습니다";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", "/req/TunerPrivateReqList.do");
		
		
		
		log.info(this.getClass().getName() + ".DeclineReq end");
		return "/redirect";
	}
	
	
	//------------------------조율사 끝 --------------------------
	
}
