package poly.controller;

import java.awt.Color;
import java.io.File;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import net.coobird.thumbnailator.Thumbnails;
import net.coobird.thumbnailator.filters.Canvas;
import net.coobird.thumbnailator.geometry.Positions;
import poly.dto.PianoDTO;
import poly.service.IPianoService;
import poly.util.FileUtil;
import poly.util.SessionUtil;
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
	public String DoAddPiano(HttpServletRequest request, ModelMap model, HttpSession session, @ModelAttribute PianoDTO pDTO, @RequestParam(value = "piano_img") MultipartFile mf) throws Exception{
		String user_seq = (String)session.getAttribute("user_seq");
		pDTO.setOwner_seq(user_seq);
		
		int res;
		
		String msg = "";
		String url = "/piano/MyPianoList.do";
		
		if(!mf.isEmpty()) {
			if(!FileUtil.isImage(mf)) {
				msg = "이미지 파일이 아닙니다.";
				model.addAttribute("msg", msg);
				model.addAttribute("url", url);
				return "/redirect";
			}
		}
		
		res = pianoService.insertPiano(pDTO);
		
		if(!mf.isEmpty()) {
			try {
			log.info("save image file!!");
			String path = "c:/piano_prj/piano/" + pDTO.getPiano_seq() + "/";
			String ext = FileUtil.saveImage(mf, "image", path);
			Thumbnails.of(new File(path + "image." + ext))
			.size(800, 600)
			.addFilter(new Canvas(600, 450, Positions.CENTER, Color.WHITE))
			.toFile(path + "thumbnail." + ext);
			
			pDTO.setPiano_photo_dir(ext);
			}catch(Exception e) {
				msg = "이미지 파일 업로드에 실패했습니다.";
				model.addAttribute("msg", msg);
				model.addAttribute("url", url);
				return "/redirect";
			}
		}

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
		session.removeAttribute("proc");
		return "/piano/MyPianoList";
	}
	
	@RequestMapping(value="PianoDetail")
	public String PianoDetail(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		log.info(this.getClass().getName() + ".MyPianoList start");
		if (SessionUtil.verify(session, "0", model) != null) {
			model = SessionUtil.verify(session, "0", model);
			return "/redirect";
		}
		String user_seq = (String)session.getAttribute("user_seq");
		
		String piano_seq = request.getParameter("no");
		PianoDTO pDTO = pianoService.getPianoDetail(piano_seq, user_seq);
		if(pDTO==null) {
			model.addAttribute("msg", "비정상적인 접근입니다.");
			model.addAttribute("url", "/index.do");
			return "/redirect";
		}
		
		model.addAttribute("pDTO", pDTO);
		
		return "/piano/PianoDetail";
	
	
	}
	
	@RequestMapping(value="DeletePiano", method=RequestMethod.POST)
	public String DeletePiano(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		log.info(this.getClass().getName() + ".DeletePiano start");
		
		if (SessionUtil.verify(session, "0", model) != null) {
			model = SessionUtil.verify(session, "0", model);
			return "/redirect";
		}
		String user_seq = (String) session.getAttribute("user_seq");
		
		String piano_seq = request.getParameter("piano_seq");
		int res = pianoService.deletePiano(piano_seq, user_seq);
		
		String msg = "";
		
		if(res>0) {
			msg = "피아노 삭제에 성공했습니다";
		}else {
			model.addAttribute("msg", "비정상적인 접근입니다.");
			model.addAttribute("url", "/index.do");
			return "/redirect";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", "/piano/MyPianoList.do");
		
		return "/redirect";
	
	
	}
	
	@RequestMapping(value="EditPiano", method=RequestMethod.POST)
	public String EditPiano(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {
		log.info(this.getClass().getName() + ".EditPiano start");
		
		if (SessionUtil.verify(session, "0", model) != null) {
			model = SessionUtil.verify(session, "0", model);
			return "/redirect";
		}
		String user_seq = (String) session.getAttribute("user_seq");
		String piano_seq = request.getParameter("piano_seq");
		PianoDTO pDTO = pianoService.getPianoEditInfo(piano_seq, user_seq);
		
		if(pDTO==null) {
			model.addAttribute("msg", "비정상적인 접근입니다.");
			model.addAttribute("url", "/index.do");
			return "/redirect";
		}
		
		model.addAttribute("pDTO", pDTO);
		
		return "/piano/EditPiano";
	
	
	}
	
	@RequestMapping(value="DoEditPiano", method=RequestMethod.POST)
	public String DoEditPiano(HttpServletRequest request, ModelMap model, HttpSession session, @ModelAttribute PianoDTO pDTO, @RequestParam(value = "piano_img") MultipartFile mf) throws Exception {
		log.info(this.getClass().getName() + ".DoEditPiano start");
		
		if (SessionUtil.verify(session, "0", model) != null) {
			model = SessionUtil.verify(session, "0", model);
			return "/redirect";
		}
		
		String user_seq = (String)session.getAttribute("user_seq");
		if(pianoService.getPianoDetail(pDTO.getPiano_seq(), user_seq)==null) {
			model.addAttribute("msg", "비정상적인 접근입니다.");
			model.addAttribute("url", "/index.do");
			return "/redirect";
		}
		
		
		pDTO.setOwner_seq(user_seq);
		
		String msg = "";
		String url = "/piano/MyPianoList.do";
		if(!mf.isEmpty()) {
			
			try {
			log.info("save image file!!");
			String path = "c:/piano_prj/piano/" + pDTO.getPiano_seq() + "/";
			String ext = FileUtil.saveImage(mf, "image", path);
			Thumbnails.of(new File(path + "image." + ext))
					.size(800, 600)
					.addFilter(new Canvas(600, 450, Positions.CENTER, Color.WHITE))
					.toFile(path + "thumbnail." + ext);
			pDTO.setPiano_photo_dir(ext);
			}catch(Exception e) {
				msg = "이미지 파일 업로드에 실패했습니다.";
				model.addAttribute("msg", msg);
				model.addAttribute("url", url);
				return "/redirect";
			}
		}
		
		log.info("piano desc : " + pDTO.getPiano_desc());
		
		
		int res = pianoService.updatePiano(pDTO);
		if(res>0) {
			msg = "피아노 수정에 성공했습니다";
		}else {
			msg = "피아노 수정에 실패했습니다";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		return "/redirect";
	
	
	}
	
	
	
	
}
