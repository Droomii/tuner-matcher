package poly.service;

import java.util.List;

import poly.dto.TunerDTO;
import poly.dto.UserDTO;

public interface IUserService {

	int regTuner(UserDTO u, TunerDTO t) throws Exception;

	UserDTO checkID(String id) throws Exception;

	UserDTO checkEmail(String email) throws Exception;

	UserDTO loginProc(UserDTO uDTO) throws Exception;

	String findUserID(String email) throws Exception;

	void addTunerSgg(String user_seq, TunerDTO tDTO) throws Exception;

	int regUser(UserDTO uDTO) throws Exception;

	UserDTO recoverPw(UserDTO uDTO) throws Exception;

	int recoverPwProc(String password, String code) throws Exception;

	UserDTO getUserInfo(String user_seq) throws Exception;

	TunerDTO getTunerInfo(String user_seq) throws Exception;

	UserDTO getUserEditInfo(UserDTO uDTO) throws Exception;

	int pwCheck(String user_seq, String password) throws Exception;

	TunerDTO getTunerEditInfo(String user_seq) throws Exception;

	UserDTO checkEditEmail(String email, String user_seq) throws Exception;

	int updateTuner(UserDTO uDTO, TunerDTO tDTO) throws Exception;

	void clearTunerSgg(String user_seq) throws Exception;

	int deleteUser(String user_seq) throws Exception;

	int updateUser(UserDTO uDTO) throws Exception;

	TunerDTO getTunerAddr(String tuner_seq) throws Exception;

	int getPendingTunerListCnt() throws Exception;

	List<TunerDTO> getPendingTunerList(int start, int end) throws Exception;

	int acceptTuner(String tuner_seq) throws Exception;


}
