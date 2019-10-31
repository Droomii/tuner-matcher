package poly.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.service.IUserService;

@Controller
public class MainController {
	
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="UserService")
	private IUserService userService;
	
	@RequestMapping(value="main")
	public String main(HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model, HttpSession session) throws Exception{
		
		String user_seq = (String) session.getAttribute("user_seq");
		String user_type = (String) session.getAttribute("user_type");
		
		
		
		return "/main";
	}
	
}