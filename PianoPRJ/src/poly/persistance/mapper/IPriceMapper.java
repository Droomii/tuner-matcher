package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.PriceDTO;

@Mapper("PriceMapper")
public interface IPriceMapper {

	List<PriceDTO> getMarketPrice(String fromDate, String toDate) throws Exception;

}
