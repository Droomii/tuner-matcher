package poly.persistance.mapper;

import config.Mapper;
import poly.dto.DealDTO;

@Mapper("DealMapper")
public interface IDealMapper {

	int insertDeal(DealDTO dDTO) throws Exception;

}
