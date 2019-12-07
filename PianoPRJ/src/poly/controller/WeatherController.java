package poly.controller;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import poly.service.IWeatherService;

@RequestMapping("weather")
@Controller
public class WeatherController {
	
	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "WeatherService")
	IWeatherService weatherService;
	
	@RequestMapping(value = "GetWeather")
	public String GetWeather(HttpServletRequest request, HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		log.info(this.getClass().getName() + ".GetWeather start");
		String sgg_code = request.getParameter("sgg_code");
		Map<String, String> rMap = weatherService.getWeather(sgg_code);
		log.info("rMap : " + rMap);
		log.info(this.getClass().getName() + ".GetWeather end");
		return null;
	}
	
	
}
