package poly.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.service.IFollowService;
import poly.util.SessionUtil;

@Controller
@RequestMapping(value="follow/")
public class FollowController {

	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "FollowService")
	IFollowService followService;
	
	@RequestMapping(value = "FollowingRemove")
	public String FollowingRemove(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".FollowingRemove start");
		if (SessionUtil.verify(session, "0", model) != null) {
			model = SessionUtil.verify(session, "0", model);
			return "/redirect";
		}
		
		String user_seq = (String)session.getAttribute("user_seq");
		String tuner_seq = request.getParameter("tuner_seq");
		
		int res = 0;
		
		try {
			res = followService.removeFollow(user_seq, tuner_seq);
		} catch (Exception e) {
			log.info(e.toString());
		}
		
		String msg = "";
		String url = "/myPage/FollowingList.do";
		if(res>0) {
			msg = "자주 찾는 조율사 목록에서 제거했습니다";
		}else {
			msg = "자주 찾는 조율사 목록에서 제거하는 데 실패했습니다.";
			url = "/user/TunerDetail.do?tuner_seq=" + tuner_seq;
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		log.info(this.getClass().getName() + ".FollowingRemove end");
		return "/redirect";
	}
	
	
	@RequestMapping(value = "FollowerRemove")
	public String FollowerRemove(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".FollowerRemove start");
		if (SessionUtil.verify(session, "1", model) != null) {
			model = SessionUtil.verify(session, "1", model);
			return "/redirect";
		}
		
		String tuner_seq = (String)session.getAttribute("user_seq");
		String user_seq = request.getParameter("user_seq");
		
		int res = 0;

		try {
			res = followService.removeFollow(user_seq, tuner_seq);
		} catch (Exception e) {
			log.info(e.toString());
		}

		String msg = "";
		String url = "/myPage/FollowerList.do";
		if(res>0) {
			msg = "자주 찾는 조율사 목록에서 제거했습니다";
		}else {
			msg = "자주 찾는 조율사 목록에서 제거하는 데 실패했습니다.";
			url = "/myPage/FollowerDetail.do?user_seq=" + tuner_seq;
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		
		log.info(this.getClass().getName() + ".FollowerRemove end");
		return "/redirect";
	}
}
