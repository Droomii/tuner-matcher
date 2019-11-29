package poly.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.dto.DealDTO;
import poly.dto.MainDTO;
import poly.dto.ReqDTO;
import poly.service.IDealService;
import poly.service.IMainService;
import poly.service.IReqService;
import poly.service.IUserService;
import poly.util.SessionUtil;

@Controller
public class MainController {
	
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="UserService")
	private IUserService userService;
	
	@Resource(name = "MainService")
	IMainService mainService;
	
	@Resource(name = "ReqService")
	IReqService reqService;
	
	@Resource(name = "DealService")
	IDealService dealService;
	
	@RequestMapping(value="main")
	public String main(HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model, HttpSession session) throws Exception{
		
		if(SessionUtil.verify(session, model)!=null) {
			model = SessionUtil.verify(session, model);
			return "/redirect";
		}
		
		String user_seq = (String)session.getAttribute("user_seq");
		String user_type = (String)session.getAttribute("user_type");
		
		MainDTO mDTO = null;
		
		if(user_type.equals("1")) {
			int user_state = (int)session.getAttribute("user_state");
			
			if(user_state==2) {
				String reject_reason = userService.getTunerInfo(user_seq).getReject_reason();
				model.addAttribute("reject_reason", reject_reason);
			}else {
				mDTO = mainService.getTunerMain(user_seq);
				
				// 요청목록
				List<ReqDTO> rList = reqService.getNearReqList(user_seq);
				int nearRes = 0;
				if(rList!=null) {
					nearRes = rList.size();
				}
				mDTO.setNear_request(Integer.toString(nearRes));
					
				// 다가올 일정
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");  
			    Date date = new Date();  
			    String today = formatter.format(date);
			    
			    // 다가올 일정 날짜 받아오기
			    List<DealDTO> dList = dealService.getUpcomingDeals(user_seq, today);
			    
				if(dList==null) {
					dList = new ArrayList<>();
				}
				model.addAttribute("dList", dList);
			}

			
		}else if(user_type.equals("0")) {
			mDTO = mainService.getUserMain(user_seq);
			
			// 다가올 일정
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");  
		    Date date = new Date();  
		    String today = formatter.format(date);
		    
		    // 다가올 일정 날짜 받아오기
		    List<DealDTO> dList = dealService.getUserUpcomingDeals(user_seq, today);
		    
			if(dList==null) {
				dList = new ArrayList<>();
			}
			model.addAttribute("dList", dList);
			
		}
		
		model.addAttribute("mDTO", mDTO);
		
		return "/main";
	}
	
	@RequestMapping(value="index")
	public String index(HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model, HttpSession session) throws Exception{
		
		String url;
		
		String user_seq = (String)session.getAttribute("user_seq");
		if(user_seq==null) {
			url="/user/UserLogin";
		}else {
			String user_type = (String)session.getAttribute("user_type");
			
			
			MainDTO mDTO = null;
			
			if(user_type.equals("1")) {
				mDTO = mainService.getTunerMain(user_seq);
				
				// 요청목록
				List<ReqDTO> rList = reqService.getNearReqList(user_seq);
				int nearRes = 0;
				if(rList!=null) {
					nearRes = rList.size();
				}
				mDTO.setNear_request(Integer.toString(nearRes));
					
				// 다가올 일정
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");  
			    Date date = new Date();  
			    String today = formatter.format(date);
			    
			    // 다가올 일정 날짜 받아오기
			    List<DealDTO> dList = dealService.getUpcomingDeals(user_seq, today);
			    
				if(dList==null) {
					dList = new ArrayList<>();
				}
				model.addAttribute("dList", dList);

			}else if(user_type.equals("0")) {
				mDTO = mainService.getUserMain(user_seq);
				
				// 다가올 일정
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");  
			    Date date = new Date();  
			    String today = formatter.format(date);
			    
			    // 다가올 일정 날짜 받아오기
			    List<DealDTO> dList = dealService.getUserUpcomingDeals(user_seq, today);
			    
				if(dList==null) {
					dList = new ArrayList<>();
				}
				model.addAttribute("dList", dList);
				
			}
			
			model.addAttribute("mDTO", mDTO);
			
			
			url="/main";
		}
		session.removeAttribute("proc");
		return url;
	}
	
	@RequestMapping(value="home")
	public String home(HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model, HttpSession session) throws Exception{
		
		if(SessionUtil.verify(session, model)!=null) {
			model = SessionUtil.verify(session, model);
			return "/redirect";
		}
		
		String user_seq = (String)session.getAttribute("user_seq");
		String user_type = (String)session.getAttribute("user_type");
		
		MainDTO mDTO = null;
		
		if(user_type.equals("1")) {
			mDTO = mainService.getTunerMain(user_seq);
			
			// 요청목록
			List<ReqDTO> rList = reqService.getNearReqList(user_seq);
			int nearRes = 0;
			if(rList!=null) {
				nearRes = rList.size();
			}
			mDTO.setNear_request(Integer.toString(nearRes));
				
			// 다가올 일정
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");  
		    Date date = new Date();  
		    String today = formatter.format(date);
		    
		    // 다가올 일정 날짜 받아오기
		    List<DealDTO> dList = dealService.getUpcomingDeals(user_seq, today);
		    
			if(dList==null) {
				dList = new ArrayList<>();
			}
			model.addAttribute("dList", dList);

		}else if(user_type.equals("0")) {
			mDTO = mainService.getUserMain(user_seq);
			
			// 다가올 일정
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");  
		    Date date = new Date();  
		    String today = formatter.format(date);
		    
		    // 다가올 일정 날짜 받아오기
		    List<DealDTO> dList = dealService.getUserUpcomingDeals(user_seq, today);
		    
			if(dList==null) {
				dList = new ArrayList<>();
			}
			model.addAttribute("dList", dList);
			
		}
		
		model.addAttribute("mDTO", mDTO);
		
		return "/main";
	}
}
