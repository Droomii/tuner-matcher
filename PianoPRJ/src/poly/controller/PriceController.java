package poly.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import poly.dto.PriceDTO;
import poly.service.IPriceService;

@RequestMapping("price/")
@Controller
public class PriceController {
	
	@Resource(name = "PriceService")
	IPriceService priceService;
	
	
	Logger log = Logger.getLogger(this.getClass());
	
	@ResponseBody
	@RequestMapping(value = "GetMarketPrice")
	public List<PriceDTO> GetMarketPrice(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(defaultValue = "day")String term)
			throws Exception {
		log.info(this.getClass().getName() + ".GetMarketPrice start");
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date today = new Date();
		Calendar c = Calendar.getInstance();
		c.setTime(today);
		
		c.add(Calendar.DAY_OF_MONTH, -1);
		String toDate = sdf.format(c.getTime());
		
		c.add(Calendar.DAY_OF_MONTH, -30);
		
		String fromDate = sdf.format(c.getTime());
		
		log.info("from : " + fromDate);
		log.info("to : " + toDate);
		
		List<PriceDTO> rList = priceService.getMarketPrice(fromDate, toDate);
		
		
		log.info(this.getClass().getName() + ".GetMarketPrice end");
		return rList;
	}
	
	@RequestMapping(value = "MarketPriceTest")
	public String MarketPriceTest(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".MarketPriceTest start");

		log.info(this.getClass().getName() + ".MarketPriceTest end");
		return "/price/MarketPriceTest";
	}
}
