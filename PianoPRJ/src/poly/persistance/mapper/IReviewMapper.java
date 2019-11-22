package poly.persistance.mapper;

import java.util.List;

import config.Mapper;
import poly.dto.ReviewDTO;

@Mapper("ReviewMapper")
public interface IReviewMapper {

	int insertReview(ReviewDTO revDTO) throws Exception;

	ReviewDTO getDealReview(String deal_seq) throws Exception;

	int deleteReview(String deal_seq, String user_seq) throws Exception;

	ReviewDTO getReviewEditInfo(String deal_seq, String user_seq) throws Exception;

	int updateReview(ReviewDTO revDTO) throws Exception;

	List<ReviewDTO> getTunerReviewList(String user_seq);

}
