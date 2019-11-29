package poly.persistance.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import config.Mapper;
import poly.dto.TunerDTO;
import poly.dto.UserDTO;

@Mapper("UserMapper")
public interface IUserMapper {

	int regTuner(@Param("u") UserDTO u, @Param("t") TunerDTO t) throws Exception;

	UserDTO checkID(String id) throws Exception;

	UserDTO checkEmail(String email) throws Exception;

	UserDTO loginProc(UserDTO uDTO) throws Exception;

	String findUserID(String email) throws Exception;

	int addTunerSgg(String user_seq, String sggCode) throws Exception;

	int regUser(UserDTO uDTO) throws Exception;

	UserDTO recoverPw(UserDTO uDTO) throws Exception;

	int recoverPwProc(String password, String code) throws Exception;

	void shufflePw(String accessCode, String id) throws Exception;

	UserDTO getUserInfo(String user_seq) throws Exception;

	TunerDTO getTunerInfo(String user_seq) throws Exception;

	UserDTO getUserEditInfo(UserDTO uDTO) throws Exception;

	int pwCheck(String user_seq, String password) throws Exception;

	TunerDTO getTunerEditInfo(String user_seq) throws Exception;

	UserDTO checkEditEmail(String email, String user_seq) throws Exception;

	int updateUser(UserDTO uDTO) throws Exception;

	int updateTuner(TunerDTO tDTO) throws Exception;

	void clearTunerSgg(String user_seq) throws Exception;

	int deleteUser(String user_seq) throws Exception;

	TunerDTO getTunerAddr(String tuner_seq) throws Exception;

	int getPendingTunerListCnt() throws Exception;

	List<TunerDTO> getPendingTunerList(@Param("start") int start, @Param("end") int end);

	int acceptTuner(String tuner_seq) throws Exception;

	int rejectTuner(TunerDTO tDTO) throws Exception;

	int updateRejectReason(TunerDTO tDTO) throws Exception;
	
	
}
