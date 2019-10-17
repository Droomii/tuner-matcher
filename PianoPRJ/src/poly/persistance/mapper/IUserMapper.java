package poly.persistance.mapper;

import org.apache.ibatis.annotations.Param;

import config.Mapper;
import poly.dto.TunerDTO;
import poly.dto.UserDTO;

@Mapper("IUserMapper")
public interface IUserMapper {

	int regTuner(@Param("u") UserDTO u, @Param("t") TunerDTO t) throws Exception;

	UserDTO checkID(String id) throws Exception;

	UserDTO checkEmail(String email) throws Exception;

	UserDTO loginProc(UserDTO uDTO) throws Exception;
}
