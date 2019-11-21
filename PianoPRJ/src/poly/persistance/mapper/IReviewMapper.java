package poly.persistance.mapper;

import config.Mapper;
import poly.dto.ReviewDTO;

@Mapper("ReviewMapper")
public interface IReviewMapper {

	int insertReview(ReviewDTO revDTO) throws Exception;

	ReviewDTO getDealReview(String deal_seq) throws Exception;

	int deleteReview(String deal_seq, String user_seq) throws Exception;

}
