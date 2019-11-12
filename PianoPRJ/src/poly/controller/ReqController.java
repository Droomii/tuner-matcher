package poly.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import poly.dto.PianoDTO;
import poly.dto.ReqDTO;
import poly.dto.TunerDTO;
import poly.service.IPianoService;
import poly.service.IReqService;
import poly.service.IUserService;
import poly.util.CmmUtil;

@RequestMapping(value = "req/")
@Controller
public class ReqController {
	
	@Resource(name="PianoService")
	private IPianoService pianoService;
	
	@Resource(name = "ReqService")
	private IReqService reqService;
	
	@Resource(name="UserService")
	private IUserService userService;
	
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
	public String publicReqSubmit(HttpSession session, HttpServletRequest request, ModelMap model, @ModelAttribute ReqDTO rDTO) throws Exception{
		
		String user_seq = (String)session.getAttribute("user_seq");
		rDTO.setUser_seq(user_seq);
		rDTO.setPhoto_dir("dummy");
		log.info("REQ_SEQ : " + rDTO.getReq_seq());
		log.info("USER_SEQ : " + rDTO.getUser_seq());
		log.info("PIANO_SEQ : " + rDTO.getPiano_seq());
		log.info("REQ_CONTENT : " + rDTO.getReq_content());
		log.info("PHOTO_DIR : " + rDTO.getPhoto_dir());
		log.info("PREF_DATE : " + rDTO.getPref_date());
		log.info("REGDATE : " + rDTO.getRegdate());
		log.info("UPDDATE : " + rDTO.getUpddate());
		log.info("UPDATER_SEQ : " + rDTO.getUpdater_seq());
		log.info("REQ_TITLE : " + rDTO.getReq_title());
		String msg = "";
		int res = reqService.insertReq(rDTO);
		
		if(res>0) {
			msg = "요청서 등록에 성공했습니다";
		}else {
			msg = "요청서 등록에 실패했습니다";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", "/req/UserPublicReqList.do");
		
		return "/redirect";
		
		
	}
	
	@RequestMapping(value = "UserPublicReqList")
	public String UserPublicReqList(HttpSession session, HttpServletRequest request, ModelMap model) throws Exception{
		String user_seq = CmmUtil.nvl((String)session.getAttribute("user_seq"));
		List<ReqDTO> reqList = reqService.getPublicReqList(user_seq);
		
		
		if(reqList==null)
			reqList = new ArrayList<ReqDTO>();
		session.setAttribute("proc", "public");
		model.addAttribute("reqList", reqList);
		return "/req/MyReqList";
		
	}
	
	@RequestMapping(value = "ReqDetail")
	public String Detail(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		log.info(this.getClass().getName() + ".MyPianoList start");
		String req_seq = request.getParameter("req_seq");
		ReqDTO rDTO = reqService.getReqDetail(req_seq);
		Map<String, List<String>> prefDates = reqService.parseDates(rDTO.getPref_date());
		log.info(prefDates);
		PianoDTO pDTO = pianoService.getPianoDetail(rDTO.getPiano_seq());
		model.addAttribute("pDTO", pDTO);
		model.addAttribute("rDTO", rDTO);
		model.addAttribute("prefDates", prefDates);
		
		return "/req/ReqDetail";
	
	
	}
	
	@RequestMapping(value = "EditReq")
	public String EditReq(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception{
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
	public String DoEditReq(HttpServletRequest request, ModelMap model, HttpSession session, @ModelAttribute ReqDTO rDTO) throws Exception{
		log.info(this.getClass().getName() + ".DoEditReq start");
		String current_user = (String)session.getAttribute("user_seq");
		String back = request.getParameter("back");
		rDTO.setUpdater_seq(current_user);

		int res = reqService.updateReq(rDTO);
		String msg;
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
		log.info(this.getClass().getName() + ".DeleteReq start");
		String msg = "";
		if(session.getAttribute("user_seq")==null) {
			msg = "세션이 만료되었습니다. 다시 로그인 해주세요";
			model.addAttribute("msg", msg);
			model.addAttribute("url", "/index.do");
		}else {
			String req_seq = request.getParameter("req_seq");
			String req_type = request.getParameter("req_type");
			int res = reqService.deleteReq(req_seq);
			
			
			
			if(res>0) {
				msg = "요청서 삭제에 성공했습니다";
			}else {
				msg = "요청서 삭제에 실패했습니다";
			}
			String type = req_type.equals("0") ? "Public" : "Private";
			model.addAttribute("msg", msg);
			model.addAttribute("url", "/req/User" + type + "ReqList.do");
		}
		
		
		return "/redirect";
	
	
	}
	
	
	// ----------------------조율사-------------------------
	// 내 주변에서 찾기
	@RequestMapping(value = "TunerPublicReqList")
	public String NearReqList(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		session.setAttribute("proc", "public");
		log.info(this.getClass().getName() + ".NearReqList start");
		String tuner_seq = (String)session.getAttribute("user_seq");
		if(tuner_seq==null) {
			model.addAttribute("msg", "세션이 만료되었습니다. 다시 로그인해주세요.");
			model.addAttribute("url", "/index.do");
			return "/redirect";
		}
		log.info("tuner_seq : "+tuner_seq);
		TunerDTO tDTO = userService.getTunerAddr(tuner_seq);
		log.info("Addr : " + tDTO.getAddr());
		log.info("X_pos : " + tDTO.getX_pos());
		log.info("Y_pos : " + tDTO.getY_pos());
		model.addAttribute("tDTO", tDTO);
		
		// 요청목록
		List<ReqDTO> rList = reqService.getNearReqList(tuner_seq);
		model.addAttribute("rList", rList);
		return "/req/TunerPublicReqList";
	}
	
	@RequestMapping(value = "PlaceBid")
	public String PlaceBid(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		String req_seq = request.getAttribute("req_seq");
		String req_type = request.getAttribute("req_type");
		
	}
	
}
