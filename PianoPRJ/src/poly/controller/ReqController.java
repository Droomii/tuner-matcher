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

import poly.dto.PianoDTO;
import poly.dto.ReqDTO;
import poly.service.IPianoService;
import poly.service.IReqService;

@RequestMapping(value = "req/")
@Controller
public class ReqController {
	
	@Resource(name="PianoService")
	private IPianoService pianoService;
	
	@Resource(name = "ReqService")
	private IReqService reqService;
	
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
		model.addAttribute("url", "/index.do");
		
		return "/redirect";
		
		
	}
}
