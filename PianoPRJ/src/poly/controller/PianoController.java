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
import org.springframework.web.bind.annotation.RequestMethod;

import poly.dto.PianoDTO;
import poly.service.IPianoService;
import poly.util.CmmUtil;
@RequestMapping(value="piano/")

@Controller
public class PianoController {

	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="PianoService")
	private IPianoService pianoService;
	
	
	@RequestMapping(value="AddPiano")
	public String AddPiano(HttpServletRequest request, ModelMap model, HttpSession session) {
		
		return "/piano/AddPiano";
	}
	
	@RequestMapping(value="DoAddPiano")
	public String DoAddPiano(HttpServletRequest request, ModelMap model, HttpSession session, @ModelAttribute PianoDTO pDTO) throws Exception{
		pDTO.setPiano_photo_dir("dummy");
		String user_seq = (String)session.getAttribute("user_seq");
		pDTO.setOwner_seq(user_seq);
		
		int res;
		res = pianoService.insertPiano(pDTO);
		String msg = "";
		String url = "/piano/MyPianoList.do";
		if(res>0) {
			msg = "피아노 등록에 성공했습니다";
		}else {
			msg = "피아노 등록에 실패했습니다";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "/redirect";
		
		
	}
	
	@RequestMapping(value="MyPianoList")
	public String MyPianoList(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		log.info(this.getClass().getName() + ".MyPianoList start");
		String user_seq = (String)session.getAttribute("user_seq");
		
		List<PianoDTO> pList = pianoService.getMyPianoList(user_seq);
		if(pList==null) {
			log.info("plist is null!!");
			pList = new ArrayList<>();
		}
		model.addAttribute("pList", pList);

		return "/piano/MyPianoList";
	}
	
	@RequestMapping(value="PianoDetail")
	public String PianoDetail(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		log.info(this.getClass().getName() + ".MyPianoList start");
		String piano_seq = request.getParameter("no");
		PianoDTO pDTO = pianoService.getPianoDetail(piano_seq);
		model.addAttribute("pDTO", pDTO);
		
		return "/piano/PianoDetail";
	
	
	}
	
	@RequestMapping(value="DeletePiano", method=RequestMethod.POST)
	public String DeletePiano(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		log.info(this.getClass().getName() + ".DeletePiano start");
		String piano_seq = request.getParameter("piano_seq");
		int res = pianoService.deletePiano(piano_seq);
		
		String msg = "";
		
		if(res>0) {
			msg = "피아노 삭제에 성공했습니다";
		}else {
			msg = "피아노 삭제에 실패했습니다";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", "/piano/MyPianoList.do");
		
		return "/redirect";
	
	
	}
	
	@RequestMapping(value="EditPiano", method=RequestMethod.POST)
	public String EditPiano(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		log.info(this.getClass().getName() + ".EditPiano start");
		String piano_seq = request.getParameter("piano_seq");
		PianoDTO pDTO = pianoService.getPianoEditInfo(piano_seq);
		model.addAttribute("pDTO", pDTO);
		
		return "/piano/EditPiano";
	
	
	}
	
	@RequestMapping(value="DoEditPiano", method=RequestMethod.POST)
	public String DoEditPiano(HttpServletRequest request, ModelMap model, HttpSession session, @ModelAttribute PianoDTO pDTO) throws Exception {
		log.info(this.getClass().getName() + ".DoEditPiano start");
		String user_seq = (String)session.getAttribute("user_seq");
		pDTO.setOwner_seq(user_seq);
		String msg = "";
		int res = pianoService.updatePiano(pDTO);
		if(res>0) {
			msg = "피아노 수정에 성공했습니다";
		}else {
			msg = "피아노 수정에 실패했습니다";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", "/piano/MyPianoList.do");
		
		return "/redirect";
	
	
	}
	
	
}
