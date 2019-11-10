package poly.service;

import java.util.List;

import poly.dto.ReqDTO;

public interface IReqService {

	int insertReq(ReqDTO rDTO) throws Exception;

	List<ReqDTO> getPublicReqList(String user_seq) throws Exception;

}
