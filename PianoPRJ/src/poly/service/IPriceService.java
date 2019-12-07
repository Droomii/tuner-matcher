package poly.service;

import java.util.List;

import poly.dto.PriceDTO;

public interface IPriceService {

	List<PriceDTO> getMarketPrice(String fromDate, String toDate) throws Exception;

}
