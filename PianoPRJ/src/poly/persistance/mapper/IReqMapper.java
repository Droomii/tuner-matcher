package poly.persistance.mapper;

import config.Mapper;
import poly.dto.ReqDTO;

@Mapper("ReqMapper")
public interface IReqMapper {

	int insertReq(ReqDTO rDTO) throws Exception;
	
}
