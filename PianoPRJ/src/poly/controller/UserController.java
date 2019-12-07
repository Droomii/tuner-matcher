package poly.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import poly.dto.MailDTO;
import poly.dto.RepuDTO;
import poly.dto.ReviewDTO;
import poly.dto.SggDTO;
import poly.dto.TunerDTO;
import poly.dto.UserDTO;
import poly.service.IFollowService;
import poly.service.IMailService;
import poly.service.IRepuService;
import poly.service.IReviewService;
import poly.service.ISggService;
import poly.service.IUserService;
import poly.util.CmmUtil;
import poly.util.EncryptUtil;
import poly.util.FileUtil;
import poly.util.Pagination;
import poly.util.SessionUtil;

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
	
	@Resource(name = "ReviewService")
	IReviewService reviewService;
	
	@Resource(name = "RepuService")
	IRepuService repuService;
	
	@Resource(name = "FollowService")
	IFollowService followService;

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
	@RequestMapping(value = "LoginTest", method = RequestMethod.POST, produces="application/text; charset=UTF8")
	public String loginTest(HttpServletRequest request, HttpServletResponse response, ModelMap model,
			HttpSession session, @ModelAttribute UserDTO uDTO) throws Exception {
		log.info(this.getClass() + ".loginTest start");
		uDTO = userService.loginProc(uDTO);

		// 아이디 혹은 비번 틀렸을 경우
		if (uDTO == null) {
			return "1";
		}
		
		if(uDTO.getUser_state()==3) {
			return CmmUtil.nvl(uDTO.getSuspend_reason(), true);
		}
		
		session.setAttribute("user_seq", uDTO.getUser_seq());
		session.setAttribute("user_type", uDTO.getUser_type());
		session.setAttribute("user_nick", uDTO.getUser_nick());
		session.setAttribute("user_state", uDTO.getUser_state());
		return "0";
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
			@ModelAttribute UserDTO uDTO, @ModelAttribute TunerDTO tDTO,
			@RequestParam(value = "profile_img") MultipartFile profile_img,
			@RequestParam(value = "cert_img") MultipartFile cert_img) throws Exception {

		
		
		
		// 지역 중첩 제거 코드
		Set<String> sggSet = null;
		
		try {
			String[] sggCodes = tDTO.getSgg_code().split(",");
			sggSet = new LinkedHashSet<String>(Arrays.asList(sggCodes));
		}catch(NullPointerException e) {
			String[] sggCodes = {"00"};
			sggSet = new LinkedHashSet<String>(Arrays.asList(sggCodes));
		}

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

		int result = 0;;

		log.info(uniqueSgg);
		
		if(!FileUtil.isImage(profile_img) || !FileUtil.isImage(cert_img)) {
			
			model.addAttribute("msg", "부적절한 파일 형식입니다.");
			model.addAttribute("url", "/user/TunerRegister.do");
			return "/redirect";
		}
		
		tDTO.setId_photo_dir(FileUtil.getExt(profile_img));
		tDTO.setCert_dir(FileUtil.getExt(cert_img));
		
		try {
		result = userService.regTuner(uDTO, tDTO);
		}catch(Exception e) {
			log.info(e.toString());
		}
		
		String msg = "";
		String url = "/user/UserLogin.do";
		
		
		
		try {
			log.info("save profile image file!!");
			String path = "c:/piano_prj/tuner/" + uDTO.getUser_seq() + "/";
			FileUtil.saveImage(profile_img, "profile", path);
		
		}catch(Exception e) {
			msg = "프로필 사진 업로드에 실패했습니다.";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return "/redirect";
		}
		
		try {
			log.info("save cert image file!!");
			String path = "c:/piano_prj/tuner/" + uDTO.getUser_seq() + "/";
			FileUtil.saveImage(cert_img, "cert", path);
			
		}catch(Exception e) {
			msg = "자격증 사진 업로드에 실패했습니다.";
			model.addAttribute("msg", msg);
			model.addAttribute("url", url);
			return "/redirect";
		}
		
		
		if (result == 0) {
			msg = "가입에 실패하였습니다.";
		} else {
			userService.addTunerSgg(uDTO.getUser_seq(), tDTO);
			msg = "가입에 성공했습니다.";		}

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

		int result = 0;

		try {
			result = userService.regUser(uDTO);
		}catch(Exception e) {
			log.info(e.toString());
		}

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
	
	// 회원정보 수정시 이메일 체크 코드
		@ResponseBody
		@RequestMapping(value = "EditDupCheck.do")
		public String EditDupCheck(HttpServletRequest request, HttpSession session) throws Exception {
			log.info("EditDupCheck");
			
			String email = request.getParameter("email");
			String user_seq = request.getParameter("user_seq");
			if(user_seq==null) {
				user_seq = (String)session.getAttribute("user_seq");
			}
			log.info("email : " + email);

			int result = 0;

			UserDTO uDTO = null;
			
			uDTO = userService.checkEditEmail(email, user_seq);
			
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
	
	@RequestMapping(value = "DoTunerInfoEdit")
	public String DoTunerInfoEdit(HttpSession session, HttpServletRequest request, HttpServletResponse response, ModelMap model,
			@ModelAttribute UserDTO uDTO, @ModelAttribute TunerDTO tDTO,
			@RequestParam(value = "profile_img") MultipartFile profile_img,
			@RequestParam(value = "cert_img") MultipartFile cert_img) throws Exception {

		
		String user_seq = (String)session.getAttribute("user_seq");
		
		if (!profile_img.isEmpty()) {
			if (!FileUtil.isImage(profile_img)) {

				model.addAttribute("msg", "프로필 이미지가 부적절한 파일 형식입니다.");
				model.addAttribute("url", "/myPage/MyInfo.do");
				return "/redirect";
			}
		}
		
		if (!cert_img.isEmpty()) {
			if (!FileUtil.isImage(cert_img)) {
				
				model.addAttribute("msg", "자격증 이미지가 부적절한 파일 형식입니다.");
				model.addAttribute("url", "/myPage/MyInfo.do");
				return "/redirect";
			}
		}
		
		
		if(!CmmUtil.nvl(uDTO.getPassword()).equals("")) {
			uDTO.setPassword(EncryptUtil.encHashSHA256(uDTO.getPassword()));
		}else {
			uDTO.setPassword(null);
		}
		
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
		// 중첩 지역 제거한 시군구코드
		tDTO.setSgg_code(uniqueSgg);

		

		String msg = "";
		String url = "/myPage/MyInfo.do";
		
		log.info(uniqueSgg);

		if(!profile_img.isEmpty()) {
			try {
			log.info("save image file!!");
			String path = "c:/piano_prj/tuner/" + user_seq + "/";
			String ext = FileUtil.saveImage(profile_img, "profile", path);
			tDTO.setId_photo_dir(ext);
			}catch(Exception e) {
				msg = "프로필 이미지 파일 업로드에 실패했습니다.";
				model.addAttribute("msg", msg);
				model.addAttribute("url", url);
				return "/redirect";
			}
			
			
		}
		
		if(!cert_img.isEmpty()) {
			try {
				log.info("save image file!!");
				String path = "c:/piano_prj/tuner/" + user_seq + "/";
				String ext = FileUtil.saveImage(cert_img, "cert", path);
				tDTO.setCert_dir(ext);
			}catch(Exception e) {
				msg = "자격증 이미지 파일 업로드에 실패했습니다.";
				model.addAttribute("msg", msg);
				model.addAttribute("url", url);
				return "/redirect";
			}
			
			
		}
		
		uDTO.setUser_seq(user_seq);
		tDTO.setTuner_seq(user_seq);
		
		int user_state = (int) session.getAttribute("user_state");
		log.info("user_state : " + user_state);
		if(user_state==2){
			uDTO.setUser_state(1);
			tDTO.setReject_reason("x");
		}
		
		int result = 0;
		try {
		result = userService.updateTuner(uDTO, tDTO);
		}catch(Exception e) {
			log.info(e.toString());
		}

		
		if (result == 0) {
			msg = "수정에 실패하였습니다.";
		} else {
			
			userService.clearTunerSgg(user_seq);
			userService.addTunerSgg(user_seq, tDTO);
			
			msg = "수정하였습니다.";
			if(user_state==2) {
				session.setAttribute("user_state", 0);
			}
			
		}

		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		log.info(this.getClass());

		return "/redirect";

	}
	
	@RequestMapping(value = "DoUserInfoEdit")
	public String DoUserInfoEdit(HttpSession session, HttpServletRequest request, HttpServletResponse response, ModelMap model,
			@ModelAttribute UserDTO uDTO) throws Exception {

		String user_seq = (String)session.getAttribute("user_seq");

		uDTO.setUser_seq(user_seq);
		
		if(!CmmUtil.nvl(uDTO.getPassword()).equals("")) {
			uDTO.setPassword(EncryptUtil.encHashSHA256(uDTO.getPassword()));
		}else {
			uDTO.setPassword(null);
		}
		
		int result = 0;
		try {
			result = userService.updateUser(uDTO);
			}catch(Exception e) {
				log.info(e.toString());
			}
		
		String msg = "";
		String url = "/myPage/MyInfo.do";
		if (result == 0) {
			msg = "수정에 실패하였습니다.";
		} else {
			msg = "수정에 성공했습니다.";
			session.setAttribute("user_nick", uDTO.getUser_nick());
		}

		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		
		log.info(this.getClass());

		return "/redirect";

	}
	
	// 조율사 정보 가져오기
	@RequestMapping(value = "TunerDetail")
	public String TunerDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".TunerDetail start");
		
		String user_type = (String) session.getAttribute("user_type");
		
		if (SessionUtil.verify(session, "0", model) != null && !CmmUtil.nvl(user_type).equals("2")) {
			model = SessionUtil.verify(session, "0", model);
			return "/redirect";
		}
		
		
		String tuner_seq = request.getParameter("tuner_seq");
		String user_seq = (String) session.getAttribute("user_seq");
		
		if(user_type.equals("0")) {
			int follow = followService.verifyFollow(tuner_seq, user_seq);
			if(follow==0) {
				model.addAttribute("msg", "자주 찾는 조율사가 아닙니다.");
				model.addAttribute("url", "/myPage/FollowingList.do");
				return "/redirect";
			}
		}
		
		
		
		// 기본 정보 가져오기
		
		UserDTO uDTO = userService.getUserInfo(tuner_seq);
		model.addAttribute("uDTO", uDTO);
		
		// 조율사 정보 가져오기
		TunerDTO tDTO = userService.getTunerInfo(tuner_seq);
		model.addAttribute("tDTO", tDTO);
		
		// 시군구 정보
		Map<String, ArrayList<String>> sggGrouped = sggService.getTunerSgg(tuner_seq);
		model.addAttribute("sggGrouped", sggGrouped);
		

		// 평판 가져옴
		RepuDTO rDTO = repuService.getRepu(tuner_seq);
		for(int rates : rDTO.getTechRates()) {
			log.info("rate : " + rates);
		}
		model.addAttribute("rDTO", rDTO);
		
		// 리뷰 목록 가져옴
		// 리뷰 페이징
		// 페이징
		int page = 1;
		int listCnt = reviewService.getTunerReviewListCnt(tuner_seq);
		Pagination pg = new Pagination(listCnt, page, 5);

		int start = pg.getStartIndex() + 1;
		int end = pg.getStartIndex() + pg.getPageSize();
		model.addAttribute("pg", pg);
		
		
		// 리뷰 목록 가져옴
		List<ReviewDTO> revList = reviewService.getTunerReviewList(tuner_seq, start, end);
		model.addAttribute("revList", revList);
		
		log.info(this.getClass().getName() + ".TunerDetail end");
		return "/user/TunerDetail";
	}
	
	@RequestMapping(value = "TunerList")
	public String TunerList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model,
			@RequestParam(defaultValue = "1")int page)
			throws Exception {
		log.info(this.getClass().getName() + ".TunerList start");
		
		if (SessionUtil.verify(session, "2", model) != null) {
			model = SessionUtil.verify(session, "2", model);
			return "/redirect";
		}
		// 페이징
		int listCnt = userService.getTunerListCnt();
		
		Pagination pg = new Pagination(listCnt, page, 5);

		int start = pg.getStartIndex() + 1;
		int end = pg.getStartIndex() + pg.getPageSize();
		model.addAttribute("pg", pg);
		
		List<TunerDTO> tList = userService.getTunerList(start, end);
		if(tList==null) {
			tList = new ArrayList<TunerDTO>();
		}
		log.info("tList size : " + tList.size());
		
		model.addAttribute("tList", tList);
		
		log.info(this.getClass().getName() + ".TunerList end");
		return "/user/TunerList";
	}
	
	// -------------------관리자 시작------------------------
	
	@RequestMapping(value = "PendingTunerList")
	public String PendingTunerList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model,
			@RequestParam(defaultValue = "1")int page)
			throws Exception {
		log.info(this.getClass().getName() + ".PendingTunerList start");
		
		if (SessionUtil.verify(session, "2", model) != null) {
			model = SessionUtil.verify(session, "2", model);
			return "/redirect";
		}
		// 페이징
		int listCnt = userService.getPendingTunerListCnt();
		
		Pagination pg = new Pagination(listCnt, page, 5);

		int start = pg.getStartIndex() + 1;
		int end = pg.getStartIndex() + pg.getPageSize();
		model.addAttribute("pg", pg);
		
		List<TunerDTO> tList = userService.getPendingTunerList(start, end);
		if(tList==null) {
			tList = new ArrayList<TunerDTO>();
		}
		log.info("tList size : " + tList.size());
		
		model.addAttribute("tList", tList);
		
		log.info(this.getClass().getName() + ".PendingTunerList end");
		return "/user/PendingTunerList";
	}

	@RequestMapping(value = "PendingTunerDetail")
	public String MyInfo(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {

		if (SessionUtil.verify(session, "2", model) != null) {
			model = SessionUtil.verify(session, "2", model);
			return "/redirect";
		}
		
		String user_seq = request.getParameter("tuner_seq");

		UserDTO uDTO = userService.getUserInfo(user_seq);
		model.addAttribute("uDTO", uDTO);

		TunerDTO tDTO = userService.getTunerInfo(user_seq);
		model.addAttribute("tDTO", tDTO);
		Map<String, ArrayList<String>> sggGrouped = sggService.getTunerSgg(user_seq);
		log.info("sggGrouped : " + sggGrouped);
		model.addAttribute("sggGrouped", sggGrouped);

		return "/user/PendingTunerDetail";
	}
	
	@RequestMapping(value = "AcceptTuner")
	public String AcceptTuner(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".AcceptTuner start");
		
		if (SessionUtil.verify(session, "2", model) != null) {
			model = SessionUtil.verify(session, "2", model);
			return "/redirect";
		}
		
		String tuner_seq = request.getParameter("tuner_seq");
		
		int res = 0;
		
		try {
			res = userService.acceptTuner(tuner_seq);
		}catch (Exception e) {
			log.info(e.toString());
		}
		String url = "/user/PendingTunerList.do";
		String msg = "";
		if (res == 0) {
			msg = "승인에 실패하였습니다.";
			url = "/user/PendingTunerDetail.do?tuner_seq=" + tuner_seq;
		} else {
			msg = "승인하였습니다.";
		}
		
		model.addAttribute("url", url);
		model.addAttribute("msg", msg);
		
		log.info(this.getClass().getName() + ".AcceptTuner end");
		return "/redirect";
	}
	
	@RequestMapping(value = "RejectTuner")
	public String RejectTuner(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model,
			@ModelAttribute TunerDTO tDTO)
			throws Exception {
		log.info(this.getClass().getName() + ".RejectTuner start");
		
		if (SessionUtil.verify(session, "2", model) != null) {
			model = SessionUtil.verify(session, "2", model);
			return "/redirect";
		}
		
		int res = 0;
		try {
			res = userService.rejectTuner(tDTO);
		} catch (Exception e) {
			 log.info(e.toString());
		}
		String msg = "반려하였습니다.";
		String url = "/user/PendingTunerList.do";
		
		if (res < 2) {
			msg = "반려에 실패했습니다";
			url = "/user/PendingTunerDetail.do?tuner_seq=" + tDTO.getTuner_seq();
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("url", url);
		
		log.info(this.getClass().getName() + ".RejectTuner end");
		return "/redirect";
	}
	
	// 회원 정지
	@RequestMapping(value = "UserSuspend")
	public String UserSuspend(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".UserSuspend start");
		
		if (SessionUtil.verify(session, "2", model) != null) {
			model = SessionUtil.verify(session, "2", model);
			return "/redirect";
		}
		
		String user_seq = request.getParameter("user_seq");
		String suspend_reason = request.getParameter("suspend_reason");
		log.info("reject reason : " + suspend_reason);
		String type = request.getParameter("type");
		int res = 0;
		
		try {
			res = userService.suspendUser(user_seq, suspend_reason);
		}catch (Exception e) {
			log.info(e.toString());
		}
		
		String url = "/user/UserDetail.do?user_seq=" + user_seq;
		if(CmmUtil.nvl(type).equals("tuner")) {
			url = "/user/TunerDetail.do?tuner_seq=" + user_seq;
		}
		String msg = "";
		if (res == 0) {
			msg = "회원 정지에 실패했습니다.";
			if(type.equals("tuner")) {
				
			}else {
				
			}
		} else {
			msg = "회원을 정지하였습니다.";
		}
		
		model.addAttribute("url", url);
		model.addAttribute("msg", msg);
		
		
		log.info(this.getClass().getName() + ".UserSuspend end");
		return "/redirect";
	}
	
	// 회원 복구
	@RequestMapping(value = "UserRecover")
	public String UserRecover(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".UserRecover start");
		
		if (SessionUtil.verify(session, "2", model) != null) {
			model = SessionUtil.verify(session, "2", model);
			return "/redirect";
		}
		
		String user_seq = request.getParameter("user_seq");
		String type = request.getParameter("type");
		int res = 0;
		
		try {
			res = userService.recoverUser(user_seq);
		}catch (Exception e) {
			log.info(e.toString());
		}
		
		String url = "/user/UserDetail.do?user_seq=" + user_seq;
		if(CmmUtil.nvl(type).equals("tuner")) {
			url = "/user/TunerDetail.do?tuner_seq=" + user_seq;
		}
		String msg = "";
		if (res == 0) {
			msg = "회원 복구에 실패했습니다.";
		} else {
			msg = "회원을 복구하였습니다.";
		}
		
		model.addAttribute("url", url);
		model.addAttribute("msg", msg);
		
		
		log.info(this.getClass().getName() + ".UserRecover end");
		return "/redirect";
	}
	
	@RequestMapping(value="AUserEdit")
	public String ATunerEdit(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception{
		
		if (SessionUtil.verify(session, "2", model) != null) {
			model = SessionUtil.verify(session, "2", model);
			return "/redirect";
		}
		
		String user_seq = request.getParameter("user_seq");
		
		UserDTO uDTO = new UserDTO();
		TunerDTO tDTO = null;
		uDTO.setUser_seq(user_seq);
		uDTO = userService.getUserEditInfo(uDTO);
		model.addAttribute("uDTO", uDTO);
		
		String user_type = uDTO.getUser_type();
		if(user_type.equals("1")) {
			tDTO = userService.getTunerEditInfo(user_seq);
			model.addAttribute("tDTO", tDTO);
			List<SggDTO> sList = new ArrayList<>();
			sList = sggService.getSido();
			log.info("got sggservice");

			model.addAttribute("sList", sList);
			
			Map<String, ArrayList<String>> sggDTOList = sggService.getTunerSggCode(user_seq);
			model.addAttribute("sggDTOList", sggDTOList);
			return "/user/TunerInfoEdit";
		}
		
		return "/user/UserInfoEdit";
		
	}
	
	@RequestMapping(value = "ADoTunerInfoEdit")
	public String ADoTunerInfoEdit(HttpSession session, HttpServletRequest request, HttpServletResponse response, ModelMap model,
			@ModelAttribute UserDTO uDTO, @ModelAttribute TunerDTO tDTO,
			@RequestParam(value = "profile_img") MultipartFile profile_img,
			@RequestParam(value = "profile_img") MultipartFile cert_img) throws Exception {

		log.info("admin tuner info edit process start!!");
		if (SessionUtil.verify(session, "2", model) != null) {
			model = SessionUtil.verify(session, "2", model);
			return "/redirect";
		}
		
		String user_seq = request.getParameter("user_seq");
		
		if (!profile_img.isEmpty()) {
			if (!FileUtil.isImage(profile_img)) {

				model.addAttribute("msg", "프로필 이미지가 부적절한 파일 형식입니다.");
				model.addAttribute("url", "/myPage/MyInfo.do");
				return "/redirect";
			}
		}
		
		if (!cert_img.isEmpty()) {
			if (!FileUtil.isImage(cert_img)) {
				
				model.addAttribute("msg", "자격증 이미지가 부적절한 파일 형식입니다.");
				model.addAttribute("url", "/myPage/MyInfo.do");
				return "/redirect";
			}
		}
		
		
		if(!CmmUtil.nvl(uDTO.getPassword()).equals("")) {
			uDTO.setPassword(EncryptUtil.encHashSHA256(uDTO.getPassword()));
		}else {
			uDTO.setPassword(null);
		}
		
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
		// 중첩 지역 제거한 시군구코드
		tDTO.setSgg_code(uniqueSgg);

		

		String msg = "";
		String url = "/user/TunerDetail.do?tuner_seq=" + user_seq;
		
		log.info(uniqueSgg);

		if(!profile_img.isEmpty()) {
			try {
			log.info("save image file!!");
			String path = "c:/piano_prj/tuner/" + user_seq + "/";
			String ext = FileUtil.saveImage(profile_img, "profile", path);
			tDTO.setId_photo_dir(ext);
			}catch(Exception e) {
				msg = "프로필 이미지 파일 업로드에 실패했습니다.";
				model.addAttribute("msg", msg);
				model.addAttribute("url", url);
				return "/redirect";
			}
			
			
		}
		
		if(!cert_img.isEmpty()) {
			try {
				log.info("save image file!!");
				String path = "c:/piano_prj/tuner/" + user_seq + "/";
				String ext = FileUtil.saveImage(cert_img, "cert", path);
				tDTO.setCert_dir(ext);
			}catch(Exception e) {
				msg = "자격증 이미지 파일 업로드에 실패했습니다.";
				model.addAttribute("msg", msg);
				model.addAttribute("url", url);
				return "/redirect";
			}
			
			
		}
		
		uDTO.setUser_seq(user_seq);
		tDTO.setTuner_seq(user_seq);
		
		int result = 0;
		try {
		result = userService.updateTuner(uDTO, tDTO);
		}catch(Exception e) {
			log.info(e.toString());
		}

		
		if (result == 0) {
			msg = "수정에 실패하였습니다.";
		} else {
			
			userService.clearTunerSgg(user_seq);
			userService.addTunerSgg(user_seq, tDTO);
			
			msg = "수정하였습니다.";
			
		}

		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		log.info(this.getClass());

		return "/redirect";

	}
	
	@RequestMapping(value = "ADoUserInfoEdit")
	public String ADoUserInfoEdit(HttpSession session, HttpServletRequest request, HttpServletResponse response, ModelMap model,
			@ModelAttribute UserDTO uDTO) throws Exception {

		if (SessionUtil.verify(session, "2", model) != null) {
			model = SessionUtil.verify(session, "2", model);
			return "/redirect";
		}
		
		String user_seq = request.getParameter("user_seq");
		
		uDTO.setUser_seq(user_seq);
		
		
		int result = 0;
		try {
			result = userService.updateUser(uDTO);
			}catch(Exception e) {
				log.info(e.toString());
			}
		
		String msg = "";
		String url = "/user/UserDetail.do?user_seq=" + user_seq;
		if (result == 0) {
			msg = "수정에 실패하였습니다.";
		} else {
			msg = "수정에 성공했습니다.";
		}

		model.addAttribute("msg", msg);
		model.addAttribute("url", url);

		
		log.info(this.getClass());

		return "/redirect";

	}
	
	//관리자 회원 목록
	@RequestMapping(value = "UserList")
	public String UserList(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model,
			@RequestParam(defaultValue = "1")int page)
			throws Exception {
		log.info(this.getClass().getName() + ".UserList start");
		if (SessionUtil.verify(session, "2", model) != null) {
			model = SessionUtil.verify(session, "2", model);
			return "/redirect";
		}
		
		// 페이징
		int listCnt = userService.getUserListCnt();

		Pagination pg = new Pagination(listCnt, page, 5);

		int start = pg.getStartIndex() + 1;
		int end = pg.getStartIndex() + pg.getPageSize();
		model.addAttribute("pg", pg);

		List<TunerDTO> uList = userService.getUserList(start, end);
		if (uList == null) {
			uList = new ArrayList<TunerDTO>();
		}
		log.info("uList size : " + uList.size());

		model.addAttribute("uList", uList);
		
		log.info(this.getClass().getName() + ".UserList end");
		return "/user/UserList";
	}
	
	@RequestMapping(value = "UserDetail")
	public String UserDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".UserDetail start");
		if (SessionUtil.verify(session, "2", model) != null) {
			model = SessionUtil.verify(session, "2", model);
			return "/redirect";
		}
		
		
		String user_seq = request.getParameter("user_seq");
		log.info("user_seq : " + user_seq);
		UserDTO uDTO = userService.getUserInfo(user_seq);
		if (uDTO == null) {
			model.addAttribute("msg", "존재하지 않는 회원입니다");
			model.addAttribute("url", "/user/UserList.do");
			return "/redirect";
		}
		
		model.addAttribute("uDTO", uDTO);
		
		
		log.info(this.getClass().getName() + ".UserDetail end");
		return "/user/UserDetail";
	}
	
	@RequestMapping(value = "GetUserDetail")
	public String GetUserDetail(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".GetUserDetail start");
		if (SessionUtil.verify(session, "2", model) != null) {
			return null;
		}
		
		
		String user_seq = request.getParameter("user_seq");
		log.info("user_seq : " + user_seq);
		UserDTO uDTO = userService.getUserInfo(user_seq);
		if (uDTO == null) {
			return null;
		}
		
		model.addAttribute("uDTO", uDTO);
		
		
		log.info(this.getClass().getName() + ".GetUserDetail end");
		return "/user/UserDetailModal";
	}
}
