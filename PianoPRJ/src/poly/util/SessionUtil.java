package poly.util;

import org.springframework.ui.ModelMap;

public class SessionUtil {
	public static ModelMap sessionExpired(String user_seq, ModelMap model) {
		if(user_seq==null) {
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("url", "/index.do");
			return model;
		}
		return null;
	}
	
	public static ModelMap invalidUserType(String user_type, String rightType, ModelMap model) {
		if(!CmmUtil.nvl(user_type).equals(rightType)) {
			model.addAttribute("msg", "비정상적인 접근입니다");
			model.addAttribute("url", "/index.do");
			return model;
		}
		
		return null;
	}
	
	public static ModelMap verifySession(String user_seq, String user_type, String rightType, ModelMap model) {
		if(user_seq==null) {
			model.addAttribute("msg", "세션이 만료되었습니다.");
			model.addAttribute("url", "/index.do");
			return model;
		}
		if(!CmmUtil.nvl(user_type).equals(rightType)) {
			model.addAttribute("msg", "비정상적인 접근입니다");
			model.addAttribute("url", "/index.do");
			return model;
		}
		
		return null;
	}
}
