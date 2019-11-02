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

import poly.dto.MailDTO;
import poly.dto.SggDTO;
import poly.dto.TunerDTO;
import poly.dto.UserDTO;
import poly.service.IMailService;
import poly.service.ISggService;
import poly.service.IUserService;
import poly.util.CmmUtil;

@Controller
@RequestMapping(value = "user/")
public class UserController {

	private Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "UserService")
	private IUserService userService;

	@Resource(name = "SggService")
	private ISggService sggService;

	@Resource(name = "MailService")
	private IMailService mailService;

	// ------------------------ 로그인 관련 -------------------------------

	// 로그인창
	@RequestMapping(value = "UserLogin")
	public String UserLogin(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

		String error = CmmUtil.nvl(request.getParameter("error"));

		// error가 1이면 아이디 혹은 비밀번호 틀림
		log.info("error : " + error);
		if (error.equals("1")) {
			model.addAttribute("error", "1");
		}
		log.info(this.getClass());

		return "/user/UserLogin";
	}

	@ResponseBody
	@RequestMapping(value = "LoginTest", method = RequestMethod.POST)
	public String loginTest(HttpServletRequest request, HttpServletResponse response, ModelMap model,
			HttpSession session, @ModelAttribute UserDTO uDTO) throws Exception {
		log.info(this.getClass() + ".loginTest start");
		uDTO = userService.loginProc(uDTO);

		// 아이디 혹은 비번 틀렸을 경우
		if (uDTO == null) {
			return "0";
		}
		session.setAttribute("user_seq", uDTO.getUser_seq());
		session.setAttribute("user_type", uDTO.getUser_type());
		session.setAttribute("user_nick", uDTO.getUser_nick());
		return "1";
	}

	@RequestMapping(value = "logout")
	public String logout(HttpSession session, ModelMap model) {
		session.invalidate();
		model.addAttribute("msg", "로그아웃하였습니다.");
		model.addAttribute("url", "/index.do");
		return "/redirect";
	}

	// 회원가입
	@RequestMapping(value = "Register")
	public String Register() {
		log.info(this.getClass());

		return "/user/Register";
	}

	@RequestMapping(value = "TunerRegister")
	public String TunerRegister(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		log.info(this.getClass());

		List<SggDTO> sList = new ArrayList<>();
		sList = sggService.getSido();
		log.info("got sggservice");

		model.addAttribute("sList", sList);
		return "/user/TunerRegister";
	}

	@RequestMapping(value = "UserRegister")
	public String UserRegister(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		log.info(this.getClass());

		return "/user/UserRegister";
	}

	@RequestMapping(value = "TunerRegProc")
	public String TunerRegProc(HttpServletRequest request, HttpServletResponse response, ModelMap model,
			@ModelAttribute UserDTO uDTO, @ModelAttribute TunerDTO tDTO) throws Exception {

		// 지역 중첩 제거 코드
		String[] sggCodes = tDTO.getSgg_code().split(",");
		Set<String> sggSet = new LinkedHashSet<String>(Arrays.asList(sggCodes));
		String uniqueSgg;
		if (sggSet.contains("00")) {
			uniqueSgg = "00";
		} else {
			List<String> sidoCode = new ArrayList<>();
			List<String> sggCode = new ArrayList<>();

			Iterator<String> sggIter = sggSet.iterator();
			String sggTemp;
			while (sggIter.hasNext()) {
				sggTemp = sggIter.next();
				if (sggTemp.length() == 2) {
					sidoCode.add(sggTemp);
				} else {
					sggCode.add(sggTemp);
				}
			}

			for (String sido : sidoCode) {
				for (String sgg : sggCode) {
					if (sido.equals(sgg.substring(0, 2))) {
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

		String msg = "";
		String url = "/user/UserLogin.do";
		if (result == 0) {
			msg = "가입에 실패하였습니다.";
		} else {
			userService.addTunerSgg(uDTO.getUser_seq(), tDTO);
			msg = "가입이 완료되었습니다.";
		}

		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		log.info(this.getClass());

		return "/redirect";

	}

	@RequestMapping(value = "UserRegProc")
	public String userRegProc(HttpServletRequest request, HttpServletResponse response, ModelMap model,
			@ModelAttribute UserDTO uDTO) throws Exception {

		log.info(this.getClass().getName() + ".userRegProg start!!");

		// 조율사 초기설정
		uDTO.setUser_type("0");

		int result;

		result = userService.regUser(uDTO);

		String msg = "";
		String url = "/user/UserLogin.do";

		if (result == 0) {
			msg = "가입에 실패하였습니다.";
		} else {
			msg = "가입이 완료되었습니다.";
		}

		log.info(this.getClass().getName() + ".userRegProg end!!");
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		return "/redirect";

	}

	// 아이디 및 이메일 체크 코드
	@ResponseBody
	@RequestMapping(value = "DupCheck.do")
	public String DupCheck(HttpServletRequest request) throws Exception {
		log.info("DupCheck");

		String id = request.getParameter("id");
		String email = request.getParameter("email");

		log.info("id : " + id);
		log.info("email : " + email);

		int result = 0;

		UserDTO uDTO = null;

		// 아이디 중복확인인지 이메일 중복확인인지 체크
		if (id != null) {
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
	@RequestMapping(value = "Find")
	public String find() throws Exception {
		log.info(this.getClass());

		return "/user/Find";
	}

	// 아이디 찾기
	@RequestMapping(value = "FindID")
	public String findID() throws Exception {
		log.info(this.getClass());

		return "/user/FindID";
	}

	@RequestMapping(value = "FindUserIDProc")
	public String findUserIDProc(HttpServletRequest request, ModelMap model) throws Exception {
		log.info(this.getClass().getName() + ".findUserIDProc Start!!");

		String email = request.getParameter("email");
		String id = userService.findUserID(email);
		model.addAttribute("title", "아이디 찾기 결과");
		model.addAttribute("findType", "id");
		if (id == null) {
			model.addAttribute("msg", "해당 이메일로 가입된 아이디가 없습니다.");
			model.addAttribute("status", "1");
			return "/user/FindResult";

		} else {
			String censoredId = id.substring(0, 2);
			if (id.length() <= 6) {
				for (int i = 2; i < id.length(); i++) {
					censoredId += "*";
				}
			} else {
				for (int i = 2; i < id.length() - 2; i++) {
					censoredId += "*";
				}
				censoredId += id.substring(id.length() - 2, id.length());
				censoredId += id.substring(censoredId.length(), id.length());

			}

			model.addAttribute("msg", "해당 이메일로 가입된 아이디는<br>" + censoredId + "입니다.");
			model.addAttribute("status", "0");
			model.addAttribute("id");
			return "/user/FindResult";
		}

	}

	// 암호 초기화
	@RequestMapping(value = "RecoverPw")
	public String recoverPw() throws Exception {
		log.info(this.getClass());

		return "/user/RecoverPw";
	}

	@RequestMapping(value = "RecoverPwProc")
	public String recoverPwProc(HttpServletRequest request, ModelMap model) throws Exception {
		log.info(this.getClass().getName() + ".recoverPwProc start!!");

		UserDTO uDTO = new UserDTO();
		uDTO.setId(request.getParameter("id"));

		// uDTO에 암호화된 패스워드와 이메일 불러옴
		uDTO = userService.recoverPw(uDTO);

		model.addAttribute("title", "암호 초기화");
		model.addAttribute("findType", "pw");
		// 없을 경우
		if (uDTO == null) {
			model.addAttribute("msg", "해당 아이디는 존재하지 않습니다.");
			model.addAttribute("status", "1");
			return "/user/FindResult";

			// 있을 경우
		} else {
			MailDTO mDTO = new MailDTO();
			mDTO.setTitle("도와조율 암호 초기화 링크");
			mDTO.setToMail(uDTO.getEmail());
			StringBuilder content = new StringBuilder();
			content.append("아래 링크를 클릭하시면 암호 초기화 페이지로 이동합니다.\n");
			content.append("http://127.0.0.1:8080/user/RecoverPwForm.do?code=");
			content.append(uDTO.getPassword());
			mDTO.setContents(content.toString());
			int res = mailService.doSendMail(mDTO);
			if (res > 0) {
				String email = uDTO.getEmail();
				String[] splitEmail = email.split("@");
				String id = splitEmail[0];
				String domain = splitEmail[1];

				// 아이디 가리기
				String censoredId = id.substring(0, 2);
				if (id.length() <= 6) {
					for (int i = 2; i < id.length(); i++) {
						censoredId += "*";
					}
				} else {
					for (int i = 2; i < id.length() - 2; i++) {
						censoredId += "*";
					}
					censoredId += id.substring(id.length() - 2, id.length());
					censoredId += id.substring(censoredId.length(), id.length());

				}

				String censoredEmail = censoredId + "@" + domain;
				StringBuilder msg = new StringBuilder("아래 이메일로 초기화 링크를 보내드렸습니다:<br>");
				msg.append(censoredEmail);

				model.addAttribute("msg", msg.toString());
				model.addAttribute("status", "0");
			}

			return "/user/FindResult";
		}
	}

	@RequestMapping(value = "RecoverPwForm")
	public String recoverPwForm(HttpServletRequest request, ModelMap model) throws Exception {
		String code = request.getParameter("code");
		model.addAttribute("code", code);
		return "/user/RecoverPwForm";
	}

	@RequestMapping(value = "RecoverPwFormProc")
	public String recoverPwFormProc(HttpServletRequest request, ModelMap model) throws Exception {
		String code = request.getParameter("code");
		String password = request.getParameter("password");
		
		int result;
		// 히새 암호화된 암호를 찾아서 새 암호로 엎어씌움
		result = userService.recoverPwProc(password, code);
		
		model.addAttribute("title", "암호 초기화");
		model.addAttribute("findType", "pwProc");
		String msg;
		String status;
		if(result>0) {
			msg = "암호 초기화에 성공하였습니다.";
			status = "0";
		}else {
			msg = "암호 초기화에 실패하였습니다.";
			status = "1";
		}
		model.addAttribute("msg", msg);
		model.addAttribute("status", status);
		
		return "/user/FindResult";
	}

}
