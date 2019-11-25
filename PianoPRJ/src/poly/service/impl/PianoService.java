package poly.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.PianoDTO;
import poly.persistance.mapper.IPianoMapper;
import poly.service.IPianoService;

@Service("PianoService")
public class PianoService implements IPianoService{

	@Resource(name="PianoMapper")
	private IPianoMapper pianoMapper;
	
	@Override
	public int insertPiano(PianoDTO pDTO) throws Exception {
		return pianoMapper.insertPiano(pDTO);
	}

	@Override
	public List<PianoDTO> getMyPianoList(String user_seq) throws Exception {
		return pianoMapper.getMyPianoList(user_seq);
	}

	@Override
	public PianoDTO getPianoDetail(String piano_seq) throws Exception {
		return pianoMapper.getPianoDetail(piano_seq);
	}

	@Override
	public int deletePiano(String piano_seq) throws Exception {
		
		return pianoMapper.deletePiano(piano_seq);
	}

	@Override
	public int updatePiano(PianoDTO pDTO) throws Exception {
		return pianoMapper.updatePiano(pDTO);
		
	}

	@Override
	public PianoDTO getPianoEditInfo(String piano_seq) throws Exception {
		return pianoMapper.getPianoEditInfo(piano_seq);
	}

	@Override
	public int getPianoCurrVal() throws Exception {
		return pianoMapper.getPianoCurrVal();
	}


}
