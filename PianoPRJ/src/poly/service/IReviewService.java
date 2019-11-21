package poly.service;

import poly.dto.ReviewDTO;

public interface IReviewService {

	int insertReview(ReviewDTO revDTO) throws Exception;

}
