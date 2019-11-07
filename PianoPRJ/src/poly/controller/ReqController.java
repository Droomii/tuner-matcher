package poly.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.dto.PianoDTO;
import poly.service.IPianoService;

@RequestMapping(value = "req/")
@Controller
public class ReqController {
	
	@Resource(name="PianoService")
	private IPianoService pianoService;
	
	
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
	public String publicReqSubmit(HttpServletRequest request, ModelMap model) throws Exception{
		
	}
}
