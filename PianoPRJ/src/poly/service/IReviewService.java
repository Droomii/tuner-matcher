package poly.service;

import java.util.List;

import poly.dto.ReviewDTO;

public interface IReviewService {

	int insertReview(ReviewDTO revDTO) throws Exception;

	ReviewDTO getDealReview(String deal_seq) throws Exception;

	int deleteReview(String deal_seq, String user_seq) throws Exception;

	ReviewDTO getReviewEditInfo(String deal_seq, String user_seq) throws Exception;

	int updateReview(ReviewDTO revDTO) throws Exception;

	List<ReviewDTO> getTunerReviewList(String user_seq, int start, int end) throws Exception;

	int getTunerReviewListCnt(String tuner_seq) throws Exception;

	int getReviewListCnt() throws Exception;

	List<ReviewDTO> getReviewList(int start, int end) throws Exception;

}
