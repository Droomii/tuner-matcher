package poly.persistance.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import config.Mapper;
import poly.dto.DealDTO;
import poly.dto.RescheduleDTO;

@Mapper("DealMapper")
public interface IDealMapper {

	int insertDeal(DealDTO dDTO) throws Exception;

	List<DealDTO> getBiddingList(@Param("user_seq") String user_seq, @Param("start") int start, @Param("end") int end) throws Exception;

	DealDTO getDealDetail(String deal_seq) throws Exception;

	int bidCancel(String deal_seq) throws Exception;

	List<DealDTO> getPastDeals(@Param("tuner_seq")String tuner_seq, @Param("start") int start, @Param("end") int end) throws Exception;

	List<DealDTO> getReqBid(@Param("req_seq") String req_seq, @Param("start") int start, @Param("end") int end) throws Exception;

	int auctionOff(String deal_seq, String req_seq, String user_seq) throws Exception;

	List<DealDTO> getUserDealList(DealDTO dDTO) throws Exception;

	int dealCancel(String deal_seq, String user_seq, @Param("user_type") int user_type) throws Exception;

	int dealConfirm(String deal_seq, String user_seq, @Param("user_type") int user_type) throws Exception;

	DealDTO getPrivateEstimate(String req_seq) throws Exception;

	int declineDeal(String deal_seq, String req_seq, String user_seq) throws Exception;

	List<DealDTO> getTunerDealList(@Param("user_seq")String user_seq, @Param("start") int start, @Param("end") int end) throws Exception;

	int insertReschedule(RescheduleDTO rDTO) throws Exception;

	List<DealDTO> getUpcomingDeals(@Param("tuner_seq") String tuner_seq, @Param("today") String today) throws Exception;

	List<DealDTO> getDealByDay(String tuner_seq, String today) throws Exception;

	List<String> getUpcomingDealDates(@Param("tuner_seq") String tuner_seq, @Param("today") String today) throws Exception;

	List<Integer> getBidPlacedReqs(String tuner_seq) throws Exception;

	int getUserDealListCnt(String user_seq) throws Exception;

	int getTunerDealListCnt(String user_seq) throws Exception;

	int getBiddingListCnt(String user_seq) throws Exception;

	int getPastDealsCnt(String tuner_seq) throws Exception;

	int getReqBidCnt(String req_seq) throws Exception;

	List<DealDTO> getUserUpcomingDeals(@Param("user_seq")String user_seq, @Param("today")String today) throws Exception;

	int getDealListCnt() throws Exception;

	List<DealDTO> getDealList(@Param("start") int start, @Param("end") int end) throws Exception;

	int updateDate(RescheduleDTO rDTO) throws Exception;

	int setDealState(String deal_seq, String string) throws Exception;

	RescheduleDTO getRescheduleInfo(String deal_seq) throws Exception;

	int rescheduleRespond(String reschedule_seq, String resp) throws Exception;

}
