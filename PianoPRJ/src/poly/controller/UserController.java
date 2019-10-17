package poly.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import poly.dto.SggDTO;
import poly.dto.TunerDTO;
import poly.dto.UserDTO;
import poly.service.ISggService;
import poly.service.IUserService;
import poly.util.CmmUtil;

@Controller
public class UserController {

	private Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "UserService")
	private IUserService userService;

	@Resource(name = "SggService")
	private ISggService sggService;

	
	// ------------------------ 로그인 관련 -------------------------------
	
	// 로그인창
	@RequestMapping(value="user/UserLogin")
	public String UserLogin(HttpServletRequest request,
			HttpServletResponse response, ModelMap model) throws Exception{
		
		String error = CmmUtil.nvl(request.getParameter("error"));
		
		// error가 1이면 아이디 혹은 비밀번호 틀림
		log.info("error : " + error);
		if(error.equals("1")) {
			model.addAttribute("error", "1");
		}
		log.info(this.getClass());
		
		return "/user/UserLogin";
	}
	
	// 로그인 양식 제출
	@RequestMapping(value="user/LoginProc", method=RequestMethod.POST)
	public String loginProc(HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model, HttpSession session,
			 @ModelAttribute UserDTO uDTO)
			throws Exception{
		log.info(this.getClass());
		uDTO = userService.loginProc(uDTO);
		
		// 아이디 혹은 비번 틀렸을 경우
		if(uDTO==null) {
			model.addAttribute("url", "/user/UserLogin.do?error=1");
			return "/redirect";
		}
		
		session.setAttribute("user_seq", uDTO.getUser_seq());
		return "/success";
	}
	
	// 회원가입
	@RequestMapping(value = "user/Register")
	public String Register() {
		log.info(this.getClass());

		return "/user/Register";
	}

	@RequestMapping(value = "user/TunerRegister")
	public String TunerRegister(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		log.info(this.getClass());

		List<SggDTO> sList = new ArrayList<>();
		sList = sggService.getSido();
		log.info("got sggservice");

		model.addAttribute("sList", sList);
		return "/user/TunerRegister";
	}

	@RequestMapping(value="user/UserRegister")
	public String UserRegister(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		log.info(this.getClass());
		
		return "/user/UserRegister";
	}

	
	@RequestMapping(value = "user/TunerRegProc")
	public String TunerRegProc(HttpServletRequest request, HttpServletResponse response, ModelMap model, @ModelAttribute UserDTO uDTO, @ModelAttribute TunerDTO tDTO)
			throws Exception {

		
		// 지역 중첩 제거 코드
		String[] sggCodes = tDTO.getSgg_code().split(",");
		Set<String> sggSet = new LinkedHashSet<String>(Arrays.asList(sggCodes));
		String uniqueSgg;
		if(sggSet.contains("00")){
			uniqueSgg = "00";
		}else {
			List<String> sidoCode = new ArrayList<>();
			List<String> sggCode = new ArrayList<>();
			
			Iterator<String> sggIter = sggSet.iterator();
			String sggTemp;
			while(sggIter.hasNext()) {
				sggTemp = sggIter.next();
				if(sggTemp.length()==2) {
					sidoCode.add(sggTemp);
				}else {
					sggCode.add(sggTemp);
				}
			}
			
			for(String sido : sidoCode) {
				for(String sgg : sggCode) {
					if(sido.equals(sgg.substring(0, 2))) {
						sggSet.remove(sgg);
					}
				}
			}
			
			uniqueSgg = String.join(",", sggSet);
		}
		
		// 조율사 초기설정
		uDTO.setUser_type("1");
		
		
		// 중첩 지역 제거한 시군구코드
		tDTO.setSgg_code(uniqueSgg);
		
		// 더미
		tDTO.setId_photo_dir("dummy");
		tDTO.setCert_dir("dummy");
		int result;
		
		

		log.info("-------tunerDTO--------");
		log.info("addr : " + tDTO.getAddr());
		log.info("affiliation : " + tDTO.getAffiliation());
		log.info("sgg_code : " + tDTO.getSgg_code());
		log.info("x : " + tDTO.getX_pos());
		log.info("y : " + tDTO.getY_pos());
		log.info("sido : " + tDTO.getSido_name());
		log.info("sgg : " + tDTO.getSgg_name());
		log.info("li : " + tDTO.getLi_name());

		log.info(uniqueSgg);
		
		result = userService.regTuner(uDTO, tDTO);
		
		log.info(this.getClass());

		return null;

	}
	
	// 아이디 및 이메일 체크 코드
	@ResponseBody
	@RequestMapping(value="user/DupCheck.do")
	public String DupCheck(HttpServletRequest request) throws Exception {
		log.info("DupCheck");

		String id = request.getParameter("id");
		String email = request.getParameter("email");
	
		
		log.info("id : " + id);
		log.info("email : " + email);
		
		int result = 0;
		
		UserDTO uDTO = null;
		
		//아이디 중복확인인지 이메일 중복확인인지 체크
		if(id!=null) {
			uDTO = userService.checkID(id);
		} else {
			uDTO = userService.checkEmail(email);
		}
		
		if (uDTO != null) {
			result = 1;
		}
		return Integer.toString(result);
	}
	
	// 아이디/암호 찾기
	@RequestMapping(value="user/Find")
	public String find() throws Exception{
		log.info(this.getClass());
		
		return "/user/Find";
	}
	
	// 아이디 찾기
	@RequestMapping(value="user/FindID")
	public String findID() throws Exception{
		log.info(this.getClass());
		
		return "/user/FindID";
	}
	
	// 암호 초기화
		@RequestMapping(value="user/RecoverPw")
		public String recoverPw() throws Exception{
			log.info(this.getClass());
			
			return "/user/RecoverPw";
		}

}
