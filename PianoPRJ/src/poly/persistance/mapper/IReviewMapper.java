package poly.persistance.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import config.Mapper;
import poly.dto.ReviewDTO;

@Mapper("ReviewMapper")
public interface IReviewMapper {

	int insertReview(ReviewDTO revDTO) throws Exception;

	ReviewDTO getDealReview(String deal_seq) throws Exception;

	int deleteReview(@Param("deal_seq") String deal_seq, @Param("user_seq")String user_seq) throws Exception;

	ReviewDTO getReviewEditInfo(String deal_seq, String user_seq) throws Exception;

	int updateReview(ReviewDTO revDTO) throws Exception;

	List<ReviewDTO> getTunerReviewList(@Param("user_seq")String user_seq, @Param("start")int start, @Param("end")int end);

	int getTunerReviewListCnt(@Param("user_seq") String tuner_seq) throws Exception;

	int getReviewListCnt() throws Exception;

	List<ReviewDTO> getReviewList(@Param("start") int start, @Param("end") int end) throws Exception;

}
