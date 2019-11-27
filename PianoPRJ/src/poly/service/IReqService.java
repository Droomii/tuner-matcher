package poly.service;

import java.util.List;
import java.util.Map;

import poly.dto.ReqDTO;

public interface IReqService {

	int insertReq(ReqDTO rDTO) throws Exception;

	List<ReqDTO> getPublicReqList(ReqDTO rDTO) throws Exception;

	ReqDTO getReqDetail(String req_seq) throws Exception;

	Map<String, List<String>> parseDates(String pref_date) throws Exception;

	int deleteReq(String req_seq) throws Exception;

	List<ReqDTO> getNearReqList(String tuner_seq) throws Exception;

	int updateReq(ReqDTO rDTO) throws Exception;

	void auctionOff(String req_seq) throws Exception;

	List<ReqDTO> getPrivateReqList(ReqDTO rDTO) throws Exception;

	List<ReqDTO> getTunerPrivateReqList(String tuner_seq, int start, int end) throws Exception;

	int declineReq(String req_seq, String tuner_seq) throws Exception;

	int getReqCurrVal() throws Exception;

	int getPublicReqListCnt(String user_seq) throws Exception;

	int getPrivateReqListCnt(String user_seq) throws Exception;

	int getTunerPrivateReqListCnt(String tuner_seq) throws Exception;

}
