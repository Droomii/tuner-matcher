package poly.persistance.mapper;

import org.apache.ibatis.annotations.Param;

import config.Mapper;
import poly.dto.TunerDTO;
import poly.dto.UserDTO;

@Mapper("UserMapper")
public interface UserMapper {

	int regTuner(@Param("u") UserDTO u, @Param("t") TunerDTO t) throws Exception;
}
