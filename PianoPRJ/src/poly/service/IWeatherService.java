package poly.service;

import java.util.Map;

public interface IWeatherService {
	Map<String, String> getWeather(String sgg_code) throws Exception;
}
