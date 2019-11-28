package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import poly.dto.TunerDTO;
import poly.dto.UserDTO;
import poly.persistance.mapper.IUserMapper;
import poly.service.IUserService;
import poly.util.CmmUtil;
import poly.util.EncryptUtil;

@Service("UserService")
public class UserService implements IUserService {

	Logger log = Logger.getLogger(this.getClass());

	@Resource(name = "UserMapper")
	private IUserMapper userMapper;

	@Override
	public int regTuner(UserDTO u, TunerDTO t) throws Exception {
		String password = u.getPassword();
		password = EncryptUtil.encHashSHA256(password);
		u.setPassword(password);

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
		String password = uDTO.getPassword();
		password = EncryptUtil.encHashSHA256(password);
		uDTO.setPassword(password);
		return userMapper.loginProc(uDTO);
	}

	@Override
	public String findUserID(String email) throws Exception {
		return userMapper.findUserID(email);
	}

	@Override
	public void addTunerSgg(String user_seq, TunerDTO tDTO) throws Exception {
		log.info("addTunerSgg service start!!");
		log.info("user_seq : " + user_seq);
		log.info("sggcodes : " + tDTO.getSgg_code());
		String[] sggCodes = tDTO.getSgg_code().split(",");
		int result = 0;
		for (String sggCode : sggCodes) {
			result = userMapper.addTunerSgg(user_seq, sggCode);
		}
		log.info("added " + result + "sggcodes");

	}

	@Override
	public int regUser(UserDTO uDTO) throws Exception {
		String password = uDTO.getPassword();
		password = EncryptUtil.encHashSHA256(password);
		uDTO.setPassword(password);
		return userMapper.regUser(uDTO);
	}

	@Override
	public UserDTO recoverPw(UserDTO uDTO) throws Exception {
		UserDTO rDTO = new UserDTO();
		
		//암호화된 암호와 이메일을 불러옴
		rDTO = userMapper.recoverPw(uDTO);
		if (rDTO == null) {
			return null;
		} else {
			String id = uDTO.getId();
			
			// 암호화된 암호와 아이디를 섞어서 해시 코드 생성
			String code = rDTO.getPassword();
			String accessCode = EncryptUtil.encHashSHA256(id + code);
			
			// 앞서 만든 코드를 데이터베이스 암호란에 업데이트
			userMapper.shufflePw(accessCode, id);
			rDTO.setPassword(accessCode);
			return rDTO;
		}

	}

	@Override
	public int recoverPwProc(String password, String code) throws Exception {
		password = EncryptUtil.encHashSHA256(password);
		return userMapper.recoverPwProc(password, code);
	}

	@Override
	public UserDTO getUserInfo(String user_seq) throws Exception {
		
		return userMapper.getUserInfo(user_seq);
	}

	@Override
	public TunerDTO getTunerInfo(String user_seq) throws Exception {
		return userMapper.getTunerInfo(user_seq);
	}

	@Override
	public UserDTO getUserEditInfo(UserDTO uDTO) throws Exception {
		return userMapper.getUserEditInfo(uDTO);
	}

	@Override
	public int pwCheck(String user_seq, String password) throws Exception {
		return userMapper.pwCheck(user_seq, password);
	}

	@Override
	public TunerDTO getTunerEditInfo(String user_seq) throws Exception {
		return userMapper.getTunerEditInfo(user_seq);
	}

	@Override
	public UserDTO checkEditEmail(String email, String user_seq) throws Exception {
		return userMapper.checkEditEmail(email, user_seq);
	}

	@Override
	public int updateTuner(UserDTO uDTO, TunerDTO tDTO) throws Exception {
		int resUser = userMapper.updateUser(uDTO);
		int resTuner= userMapper.updateTuner(tDTO);
		return resUser+resTuner;
	}

	@Override
	public void clearTunerSgg(String user_seq) throws Exception {
		userMapper.clearTunerSgg(user_seq);
		
	}

	@Override
	public int deleteUser(String user_seq) throws Exception {
		return userMapper.deleteUser(user_seq);
	}

	@Override
	public int updateUser(UserDTO uDTO) throws Exception {
		return userMapper.updateUser(uDTO);
	}

	@Override
	public TunerDTO getTunerAddr(String tuner_seq) throws Exception {
		TunerDTO tDTO = userMapper.getTunerAddr(tuner_seq);
		tDTO.setAddr(CmmUtil.nvl(tDTO.getAddr())
				.replaceAll("&#40;", "(")
				.replaceAll("&#41;", ")")
				);
		return tDTO;
	}

	@Override
	public int getPendingTunerListCnt() throws Exception {
		return userMapper.getPendingTunerListCnt();
	}

	@Override
	public List<TunerDTO> getPendingTunerList(int start, int end) throws Exception {
		return userMapper.getPendingTunerList(start, end);
	}

	@Override
	public int acceptTuner(String tuner_seq) throws Exception {
		return userMapper.acceptTuner(tuner_seq);
	}

}
