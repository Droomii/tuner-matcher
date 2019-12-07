package poly.persistance.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import config.Mapper;
import poly.dto.FollowDTO;
import poly.dto.TunerDTO;
import poly.dto.UserDTO;

@Mapper("FollowMapper")
public interface IFollowMapper {

	void followTuner(String user_seq, String tuner_seq) throws Exception;

	List<TunerDTO> getFollowingList(String user_seq) throws Exception;

	int removeFollow(String user_seq, String tuner_seq) throws Exception;

	int verifyFollow(@Param("tuner_seq")String tuner_seq, @Param("user_seq")String user_seq);

	List<FollowDTO> getFollowerList(@Param("user_seq")String user_seq, @Param("start") int start, @Param("end") int end) throws Exception;

	int getFollowerListCnt(String user_seq) throws Exception;

}
