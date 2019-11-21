package poly.persistance.mapper;

import config.Mapper;
import poly.dto.RepuDTO;

@Mapper("RepuMapper")
public interface IRepuMapper {

	RepuDTO getRepu(String user_seq) throws Exception;


}
