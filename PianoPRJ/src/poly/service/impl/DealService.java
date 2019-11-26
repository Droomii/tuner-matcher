package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.DealDTO;
import poly.dto.RescheduleDTO;
import poly.persistance.mapper.IDealMapper;
import poly.service.IDealService;

@Service("DealService")
public class DealService implements IDealService{

	@Resource(name="DealMapper")
	IDealMapper dealMapper;
	
	@Override
	public int insertDeal(DealDTO dDTO) throws Exception {
		return dealMapper.insertDeal(dDTO);
	}

	@Override
	public List<DealDTO> getBiddingList(String user_seq) throws Exception {
		return dealMapper.getBiddingList(user_seq);
	}

	@Override
	public DealDTO getDealDetail(String deal_seq) throws Exception {
		return dealMapper.getDealDetail(deal_seq);
	}

	@Override
	public int bidCancel(String deal_seq) throws Exception {
		return dealMapper.bidCancel(deal_seq);
	}

	@Override
	public List<DealDTO> getPastDeals(String user_seq) throws Exception {
		return dealMapper.getPastDeals(user_seq);
	}

	@Override
	public List<DealDTO> getReqBid(String req_seq) throws Exception {
		return dealMapper.getReqBid(req_seq);
	}

	@Override
	public int auctionOff(String deal_seq, String req_seq, String user_seq) throws Exception {
		return dealMapper.auctionOff(deal_seq, req_seq, user_seq);
	}

	@Override
	public List<DealDTO> getUserDealList(String user_seq) throws Exception {
		return dealMapper.getUserDealList(user_seq);
	}

	@Override
	public int dealCancel(String deal_seq, String user_seq, int user_type) throws Exception {
		return dealMapper.dealCancel(deal_seq, user_seq, user_type);
	}

	@Override
	public int dealConfirm(String deal_seq, String user_seq, int user_type) throws Exception {
		return dealMapper.dealConfirm(deal_seq, user_seq, user_type);
	}

	@Override
	public DealDTO getPrivateEstimate(String req_seq) throws Exception {
		return dealMapper.getPrivateEstimate(req_seq);
	}

	@Override
	public int declineDeal(String deal_seq, String req_seq, String user_seq) throws Exception {
		return dealMapper.declineDeal(deal_seq, req_seq, user_seq);
	}

	@Override
	public List<DealDTO> getTunerDealList(String user_seq) throws Exception {
		return dealMapper.getTunerDealList(user_seq);
	}

	@Override
	public int insertReschedule(RescheduleDTO rDTO) throws Exception {
		return dealMapper.insertReschedule(rDTO);
	}

	@Override
	public List<DealDTO> getUpcomingDeals(String tuner_seq, String today) throws Exception {
		return dealMapper.getUpcomingDeals(tuner_seq, today);
	}

	@Override
	public List<DealDTO> getDealByDay(String tuner_seq, String today) throws Exception {
		return dealMapper.getDealByDay(tuner_seq, today);
	}

	@Override
	public List<String> getUpcomingDealDates(String tuner_seq, String today) throws Exception {
		return dealMapper.getUpcomingDealDates(tuner_seq, today);
	}

	@Override
	public List<Integer> getBidPlacedReqs(String tuner_seq) throws Exception {
		return dealMapper.getBidPlacedReqs(tuner_seq);
	}

}
