package poly.service;

import poly.dto.ReviewDTO;

public interface IReviewService {

	int insertReview(ReviewDTO revDTO) throws Exception;

	ReviewDTO getDealReview(String deal_seq) throws Exception;

	int deleteReview(String deal_seq, String user_seq) throws Exception;

	ReviewDTO getReviewEditInfo(String deal_seq, String user_seq) throws Exception;

	int updateReview(ReviewDTO revDTO) throws Exception;

}
