package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.DealDTO;

@Mapper("DealMapper")
public interface IDealMapper {

	int insertDeal(DealDTO dDTO) throws Exception;

	List<DealDTO> getBiddingList(String user_seq) throws Exception;

	DealDTO getDealDetail(String deal_seq) throws Exception;

	int bidCancel(String deal_seq) throws Exception;

	List<DealDTO> getPastDeals(String user_seq) throws Exception;

	List<DealDTO> getReqBid(String req_seq) throws Exception;

	int auctionOff(String deal_seq, String req_seq, String user_seq) throws Exception;

}
