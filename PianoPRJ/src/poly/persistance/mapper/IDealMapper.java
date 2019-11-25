package poly.persistance.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import config.Mapper;
import poly.dto.DealDTO;
import poly.dto.RescheduleDTO;

@Mapper("DealMapper")
public interface IDealMapper {

	int insertDeal(DealDTO dDTO) throws Exception;

	List<DealDTO> getBiddingList(String user_seq) throws Exception;

	DealDTO getDealDetail(String deal_seq) throws Exception;

	int bidCancel(String deal_seq) throws Exception;

	List<DealDTO> getPastDeals(String user_seq) throws Exception;

	List<DealDTO> getReqBid(String req_seq) throws Exception;

	int auctionOff(String deal_seq, String req_seq, String user_seq) throws Exception;

	List<DealDTO> getUserDealList(String user_seq) throws Exception;

	int dealCancel(String deal_seq, String user_seq, @Param("user_type") int user_type) throws Exception;

	int dealConfirm(String deal_seq, String user_seq, @Param("user_type") int user_type) throws Exception;

	DealDTO getPrivateEstimate(String req_seq) throws Exception;

	int declineDeal(String deal_seq, String req_seq, String user_seq) throws Exception;

	List<DealDTO> getTunerDealList(String user_seq) throws Exception;

	int insertReschedule(RescheduleDTO rDTO) throws Exception;

	List<String> getUpcomingDeals(@Param("tuner_seq") String tuner_seq, @Param("today") String today) throws Exception;

}
