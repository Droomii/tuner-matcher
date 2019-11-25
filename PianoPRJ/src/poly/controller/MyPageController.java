package poly.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.dto.RepuDTO;
import poly.dto.ReviewDTO;
import poly.dto.SggDTO;
import poly.dto.TunerDTO;
import poly.dto.UserDTO;
import poly.service.IFollowService;
import poly.service.IRepuService;
import poly.service.IReviewService;
import poly.service.ISggService;
import poly.service.IUserService;
import poly.util.EncryptUtil;
import poly.util.SessionUtil;

@Controller
@RequestMapping("/myPage")
public class MyPageController {

	private Logger log = Logger.getLogger(this.getClass());
	@Resource(name="UserService")
	IUserService userService;
	
	@Resource(name="SggService")
	ISggService sggService;
	
	@Resource(name = "RepuService")
	IRepuService repuService;
	
	@Resource(name = "ReviewService")
	IReviewService reviewService;
	
	@Resource(name = "FollowService")
	IFollowService followService;
	
	@RequestMapping(value="MyInfo")
	public String MyInfo(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception{
		String user_seq = (String)session.getAttribute("user_seq");
		String user_type = (String)session.getAttribute("user_type");
		if(SessionUtil.verify(user_seq, model)!=null) {
			model = SessionUtil.verify(user_seq, model);
			return "/redirect";
		}
		
		
		UserDTO uDTO = userService.getUserInfo(user_seq);
		model.addAttribute("uDTO", uDTO);
		if(user_type.equals("1")) {
			
			TunerDTO tDTO = userService.getTunerInfo(user_seq);
			model.addAttribute("tDTO", tDTO);
//			List<SggDTO> sggList = new ArrayList<>();
			Map<String, ArrayList<String>> sggGrouped = sggService.getTunerSgg(user_seq);
			log.info("sggGrouped : " + sggGrouped);
			model.addAttribute("sggGrouped", sggGrouped);
		}
		return "/myPage/MyInfo";
	}
	
	@RequestMapping(value="MyInfoEdit")
	public String MyInfoEdit(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception{
		if(SessionUtil.verify(session, model)!=null) {
			model = SessionUtil.verify(session, model);
			return "/redirect";
		}
		
		String action = "/myPage/MyInfoEditForm.do";
		String back = "/myPage/MyInfoEdit.do";
		String forWhat = "update";
		model.addAttribute("action", action);
		model.addAttribute("back", back);
		model.addAttribute("forWhat", forWhat);
		
		return "/myPage/CheckPw";
	}
	
	@RequestMapping(value="DeleteAccount")
	public String DeleteAccount(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception{
		
		if(SessionUtil.verify(session, model)!=null) {
			model = SessionUtil.verify(session, model);
			return "/redirect";
		}
		
		String action = "/myPage/DeleteAccountProc.do";
		String back = "/myPage/DeleteAccount.do";
		String forWhat = "delete";
		model.addAttribute("action", action);
		model.addAttribute("back", back);
		model.addAttribute("forWhat", forWhat);
		
		return "/myPage/CheckPw";
		
	}
	
	@RequestMapping(value="DeleteAccountProc")
	public String DeleteAccountProc(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception{
		
		if(SessionUtil.verify(session, model)!=null) {
			model = SessionUtil.verify(session, model);
			return "/redirect";
		}
		
		String password = request.getParameter("password");
		String user_seq = (String)session.getAttribute("user_seq");
		password = EncryptUtil.encHashSHA256(password);
		int res = userService.pwCheck(user_seq, password);
		if(res==0) {
			model.addAttribute("msg", "암호가 올바르지 않습니다");
			model.addAttribute("url", "/myPage/DeleteAccount.do");
			return "/redirect";
		}else {
			int delRes = userService.deleteUser(user_seq);
			if(delRes>0) {
				model.addAttribute("msg", "회원 탈퇴에 성공했습니다.");
				model.addAttribute("url", "/index.do");
				session.invalidate();
				return "/redirect";
			}else {
				model.addAttribute("msg", "회원 탈퇴에 실패했습니다.");
				model.addAttribute("url", "/index.do");
				return "/redirect";
			}
			
		}
			
		}
		
		
		
		
		
	
	@RequestMapping(value="MyInfoEditForm")
	public String MyInfoEditForm(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception{
		
		if(SessionUtil.verify(session, model)!=null) {
			model = SessionUtil.verify(session, model);
			return "/redirect";
		}
		
		String password = request.getParameter("password");
		String user_seq = (String)session.getAttribute("user_seq");
		password = EncryptUtil.encHashSHA256(password);
		int res = userService.pwCheck(user_seq, password);
		if(res==0) {
			model.addAttribute("msg", "암호가 올바르지 않습니다");
			model.addAttribute("url", "/myPage/MyInfoEdit.do");
			return "/redirect";
		}
		
		UserDTO uDTO = new UserDTO();
		TunerDTO tDTO = null;
		uDTO.setUser_seq((String)session.getAttribute("user_seq"));
		uDTO = userService.getUserEditInfo(uDTO);
		model.addAttribute("uDTO", uDTO);
		
		String user_type = (String)session.getAttribute("user_type");
		if(user_type.equals("1")) {
			tDTO = userService.getTunerEditInfo(user_seq);
			model.addAttribute("tDTO", tDTO);
			List<SggDTO> sList = new ArrayList<>();
			sList = sggService.getSido();
			log.info("got sggservice");

			model.addAttribute("sList", sList);
			
			Map<String, ArrayList<String>> sggDTOList = sggService.getTunerSggCode(user_seq);
			model.addAttribute("sggDTOList", sggDTOList);
			return "/myPage/TunerInfoEdit";
		}
		
		return "/myPage/UserInfoEdit";
		
		
		
		
		
	}
	
	@RequestMapping(value = "MyRepu")
	public String MyRepu(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".MyRepu start");

		if (SessionUtil.verify(session, "1", model) != null) {
			model = SessionUtil.verify(session, "1", model);
			return "/redirect";
		}
		
		// 사용자 번호
		String user_seq = (String)session.getAttribute("user_seq");
		
		// 평판 가져옴
		RepuDTO rDTO = repuService.getRepu(user_seq);
		TunerDTO tDTO = userService.getTunerInfo(user_seq);
		model.addAttribute("tDTO", tDTO);
		model.addAttribute("rDTO", rDTO);
		
		// 리뷰 목록 가져옴
		List<ReviewDTO> revList = reviewService.getTunerReviewList(user_seq);
		if(revList==null) {
			revList = new ArrayList<ReviewDTO>();
		}
		model.addAttribute("revList", revList);
		
		log.info(this.getClass().getName() + ".MyRepu end");
		return "/myPage/MyRepu";
	}
	
	@RequestMapping(value = "FollowingList")
	public String FollowingList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".FollowingList start");
		
		if (SessionUtil.verify(session, "0", model) != null) {
			model = SessionUtil.verify(session, "0", model);
			return "/redirect";
		}
		
		String user_seq = (String)session.getAttribute("user_seq");
		List<TunerDTO> tList = followService.getFollowingList(user_seq); 
		if(tList==null) {
			tList = new ArrayList<TunerDTO>();
		}
		model.addAttribute("tList", tList);
		
		log.info(this.getClass().getName() + ".FollowingList end");
		return "/myPage/FollowingList";
	}
	
	@RequestMapping(value = "TunerSchedule")
	public String TunerSchedule(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".TunerSchedule start");
		
		if (SessionUtil.verify(session, "1", model) != null) {
			model = SessionUtil.verify(session, "1", model);
			return "/redirect";
		}

		log.info(this.getClass().getName() + ".TunerSchedule end");
		return "/myPage/TunerSchedule";
	}
	
}
