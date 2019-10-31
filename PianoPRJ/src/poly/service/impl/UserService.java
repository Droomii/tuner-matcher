package poly.service.impl;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import poly.dto.TunerDTO;
import poly.dto.UserDTO;
import poly.persistance.mapper.IUserMapper;
import poly.service.IUserService;

@Service("UserService")
public class UserService implements IUserService {

	Logger log = Logger.getLogger(this.getClass());
	
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

	@Override
	public void addTunerSgg(String user_seq, TunerDTO tDTO) throws Exception{
		log.info("addTunerSgg service start!!");
		log.info("user_seq : " +user_seq);
		log.info("sggcodes : " +tDTO.getSgg_code());
		String[] sggCodes = tDTO.getSgg_code().split(",");
		int result = 0;
		for(String sggCode : sggCodes) {
			result = userMapper.addTunerSgg(user_seq, sggCode);
		}
		log.info("added " + result + "sggcodes");
		
	}

	@Override
	public int regUser(UserDTO uDTO) throws Exception {
		
		return userMapper.regUser(uDTO);
	}
	
	
}
