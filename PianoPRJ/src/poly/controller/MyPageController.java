package poly.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.dto.SggDTO;
import poly.dto.TunerDTO;
import poly.dto.UserDTO;
import poly.service.ISggService;
import poly.service.IUserService;

@Controller
@RequestMapping("/myPage")
public class MyPageController {

	@Resource(name="UserService")
	IUserService userService;
	
	@Resource(name="SggService")
	ISggService sggService;
	
	@RequestMapping(value="MyInfo")
	public String MyInfo(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception{
		String user_seq = (String)session.getAttribute("user_seq");
		String user_type = (String)session.getAttribute("user_type");
		
		UserDTO uDTO = userService.getUserInfo(user_seq);
		model.addAttribute("uDTO", uDTO);
		if(user_type.equals("1")) {
			
			TunerDTO tDTO = userService.getTunerInfo(user_seq);
			model.addAttribute("tDTO", tDTO);
			List<SggDTO> sggList = new ArrayList<>();
			Map<String, ArrayList<String>> sggGrouped = sggService.getTunerSgg(user_seq);
		}
		return "/myPage/MyInfo";
	}
}
