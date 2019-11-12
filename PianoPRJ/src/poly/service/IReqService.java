package poly.service;

import java.util.List;
import java.util.Map;

import poly.dto.ReqDTO;

public interface IReqService {

	int insertReq(ReqDTO rDTO) throws Exception;

	List<ReqDTO> getPublicReqList(String user_seq) throws Exception;

	ReqDTO getReqDetail(String req_seq) throws Exception;

	Map<String, List<String>> parseDates(String pref_date) throws Exception;

	int deleteReq(String req_seq) throws Exception;

	List<ReqDTO> getNearReqList(String tuner_seq) throws Exception;

	int updateReq(ReqDTO rDTO) throws Exception;

}
