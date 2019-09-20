package poly.service;

import poly.dto.TunerDTO;
import poly.dto.UserDTO;

public interface IUserService {

	int regTuner(UserDTO u, TunerDTO t) throws Exception;

}
