package poly.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.TunerDTO;
import poly.dto.UserDTO;
import poly.persistance.mapper.IUserMapper;
import poly.service.IUserService;

@Service("UserService")
public class UserService implements IUserService {

	@Resource(name="IUserMapper")
	private IUserMapper userMapper;

	@Override
	public int regTuner(UserDTO u, TunerDTO t) throws Exception {
		
		return userMapper.regTuner(u, t);
	}

	@Override
	public UserDTO checkID(String id) throws Exception {
		return userMapper.checkID(id);
	}

	@Override
	public UserDTO checkEmail(String email) throws Exception {
		return userMapper.checkEmail(email);
	}

	@Override
	public UserDTO loginProc(UserDTO uDTO) throws Exception {
		
		return userMapper.loginProc(uDTO);
	}

	@Override
	public String findUserID(String email) throws Exception {
		return userMapper.findUserID(email);
	}
	
	
}
