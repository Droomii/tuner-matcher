package poly.service;

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


}
