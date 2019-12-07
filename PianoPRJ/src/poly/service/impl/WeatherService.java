package poly.service.impl;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import poly.service.IWeatherService;
import poly.util.XMLUtil;

@Service("WeatherService")
public class WeatherService implements IWeatherService{
	
	private Logger log = Logger.getLogger(this.getClass());
	
	public Map<String, String> getWeather(String sgg_code)
			throws Exception {
		log.info(this.getClass().getName() + ".getWeather start");
		
		String url = "http://www.kma.go.kr/wid/queryDFSRSS.jsp?zone=" + sgg_code.substring(0, 5) + "00000";

		DocumentBuilderFactory dbFactoty = DocumentBuilderFactory.newInstance();
		DocumentBuilder dBuilder = dbFactoty.newDocumentBuilder();
		Document doc = dBuilder.parse(url);

		// root tag 
		doc.getDocumentElement().normalize();
		log.info("Root element: " + doc.getDocumentElement().getNodeName()); // Root element: result
		NodeList data = doc.getElementsByTagName("data");
		
		Element header = (Element)doc.getElementsByTagName("header").item(0);
		String tm = XMLUtil.getTagValue("tm", header);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmm");
		Date tmDate = sdf.parse(tm);
		SimpleDateFormat sdfShow = new SimpleDateFormat("yyyy-MM-dd'h'HH");
		Calendar c = null;
		
		
		log.info("tm : " + tmDate.toString());
		
		Map<String, String> rMap = new LinkedHashMap<>();
		
		for (int i = 0; i < data.getLength(); i++) {
			Node n = data.item(i);
			if(n.getNodeType()==Node.ELEMENT_NODE) {
				Element e = (Element)n;
				c = Calendar.getInstance();
				c.setTime(tmDate);
				c.add(Calendar.DATE, Integer.parseInt(XMLUtil.getTagValue("day", e)));
				c.set(Calendar.HOUR_OF_DAY, Integer.parseInt(XMLUtil.getTagValue("hour", e))-3);
				
				log.info("time : " + sdfShow.format(c.getTime()));
				log.info("rain prob : " + XMLUtil.getTagValue("pop", e));
				
				for(int k = 0 ; k < 3; k++) {
					rMap.put(sdfShow.format(c.getTime()), XMLUtil.getTagValue("pop", e));
					c.add(Calendar.HOUR_OF_DAY, 1);
				}
				
				
			}
			

		}
		
		log.info(this.getClass().getName() + ".getWeather end");
		return rMap;
	}
}
