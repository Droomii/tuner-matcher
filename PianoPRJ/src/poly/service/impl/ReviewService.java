package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.ReviewDTO;
import poly.persistance.mapper.IReviewMapper;
import poly.service.IReviewService;

@Service("ReviewService")
public class ReviewService implements IReviewService{

	@Resource(name="ReviewMapper")
	private IReviewMapper reviewMapper;
	
	@Override
	public int insertReview(ReviewDTO revDTO) throws Exception {
		return reviewMapper.insertReview(revDTO);
	}

	@Override
	public ReviewDTO getDealReview(String deal_seq) throws Exception {
		return reviewMapper.getDealReview(deal_seq);
	}

	@Override
	public int deleteReview(String deal_seq, String user_seq) throws Exception {
		return reviewMapper.deleteReview(deal_seq, user_seq);
	}

	@Override
	public ReviewDTO getReviewEditInfo(String deal_seq, String user_seq) throws Exception {
		return reviewMapper.getReviewEditInfo(deal_seq, user_seq);
	}

	@Override
	public int updateReview(ReviewDTO revDTO) throws Exception {
		return reviewMapper.updateReview(revDTO);
	}

	@Override
	public List<ReviewDTO> getTunerReviewList(String user_seq) throws Exception {
		return reviewMapper.getTunerReviewList(user_seq);
	}

}
