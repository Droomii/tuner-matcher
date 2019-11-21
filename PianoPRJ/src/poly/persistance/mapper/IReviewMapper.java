package poly.persistance.mapper;

import config.Mapper;
import poly.dto.ReviewDTO;

@Mapper("ReviewMapper")
public interface IReviewMapper {

	int insertReview(ReviewDTO revDTO) throws Exception;

}
