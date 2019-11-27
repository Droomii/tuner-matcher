package poly.persistance.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import config.Mapper;
import poly.dto.ReqDTO;

@Mapper("ReqMapper")
public interface IReqMapper {

	int insertReq(ReqDTO rDTO) throws Exception;

	List<ReqDTO> getPublicReqList(ReqDTO rDTO) throws Exception;

	ReqDTO getReqDetail(String req_seq) throws Exception;

	int deleteReq(String req_seq) throws Exception;

	List<ReqDTO> getNearReqList(String tuner_seq) throws Exception;

	int updateReq(ReqDTO rDTO) throws Exception;

	void auctionOff(String req_seq) throws Exception;

	List<ReqDTO> getPrivateReqList(ReqDTO rDTO) throws Exception;

	List<ReqDTO> getTunerPrivateReqList(@Param("tuner_seq") String tuner_seq, @Param("start") int start, @Param("end") int end) throws Exception;

	int declineReq(String req_seq, String tuner_seq) throws Exception;

	int getReqCurrVal() throws Exception;

	int getPublicReqListCnt(String user_seq) throws Exception;

	int getPrivateReqListCnt(String user_seq) throws Exception;

	int getTunerPrivateReqListCnt(String tuner_seq) throws Exception;

}
