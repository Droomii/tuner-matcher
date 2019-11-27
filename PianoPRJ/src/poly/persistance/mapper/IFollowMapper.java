package poly.persistance.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import config.Mapper;
import poly.dto.TunerDTO;

@Mapper("FollowMapper")
public interface IFollowMapper {

	void followTuner(String user_seq, String tuner_seq) throws Exception;

	List<TunerDTO> getFollowingList(String user_seq) throws Exception;

	int removeFollow(String user_seq, String tuner_seq) throws Exception;

	int verifyFollow(@Param("tuner_seq")String tuner_seq, @Param("user_seq")String user_seq);

}
