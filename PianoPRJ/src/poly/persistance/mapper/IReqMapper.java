package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.ReqDTO;

@Mapper("ReqMapper")
public interface IReqMapper {

	int insertReq(ReqDTO rDTO) throws Exception;

	List<ReqDTO> getPublicReqList(String user_seq) throws Exception;

	ReqDTO getReqDetail(String req_seq) throws Exception;

	int deleteReq(String req_seq) throws Exception;

	List<ReqDTO> getNearReqList(String tuner_seq) throws Exception;

	int updateReq(ReqDTO rDTO) throws Exception;
	
}
