package poly.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.dto.SggDTO;
import poly.service.ISggService;

@Controller
public class AddrController {

	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="SggService")
	private ISggService sggService;
	
	@RequestMapping(value="addr/GetSgg")
	private String GetSgg(HttpServletRequest request, HttpServletResponse response, 
			ModelMap model) throws Exception {
		
		String sidoCode = request.getParameter("sidoCode");
		
		sidoCode += "___";
		
		List<SggDTO> sggList = new ArrayList<>();
		sggList = sggService.getSgg(sidoCode);
		
		for(SggDTO sDTO : sggList) {
			log.info("sggList : " + sDTO.getSggName());
		}
		model.addAttribute("sggList", sggList);
		model.addAttribute("sidoCode", sidoCode.replaceAll("_", ""));
		return "/addr/SggDetail";
	}
	
	@RequestMapping(value="addr/AddrInput")
	private String AddrInput() {
		return "/addr/AddrInput";
	}
	
	@RequestMapping(value="addr/AddrPopup")
	private String AddrPopup() {
		return "/addr/AddrPopup";
	}
}
