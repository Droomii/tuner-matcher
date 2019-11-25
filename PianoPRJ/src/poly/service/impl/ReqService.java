package poly.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import poly.dto.ReqDTO;
import poly.dto.SggDTO;
import poly.dto.TunerDTO;
import poly.persistance.mapper.IReqMapper;
import poly.persistance.mapper.ISggMapper;
import poly.persistance.mapper.IUserMapper;
import poly.service.IReqService;
import poly.util.CmmUtil;

@Service("ReqService")
public class ReqService implements IReqService {

	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "ReqMapper")
	private IReqMapper reqMapper;

	@Resource(name = "ISggMapper")
	private ISggMapper sggMapper;

	@Resource(name = "UserMapper")
	private IUserMapper userMapper;

	@Override
	public int insertReq(ReqDTO rDTO) throws Exception {
		return reqMapper.insertReq(rDTO);
	}

	@Override
	public List<ReqDTO> getPublicReqList(String user_seq) throws Exception {
		return reqMapper.getPublicReqList(user_seq);
		
	}

	@Override
	public ReqDTO getReqDetail(String req_seq) throws Exception {
		ReqDTO rDTO =reqMapper.getReqDetail(req_seq);
		return rDTO;
	}

	@Override
	public Map<String, List<String>> parseDates(String pref_date) throws Exception {
		Map<String, List<String>> rMap = new LinkedHashMap<String, List<String>>();
		String[] prefDates = pref_date.split(",");
		String[] dateHour;
		List<String> hours = null;
		for(String s : prefDates) {
			dateHour = s.split("h");
			hours = rMap.getOrDefault(dateHour[0], new ArrayList<>());
			hours.add(dateHour[1]);
			rMap.put(dateHour[0], hours);
			hours = null;
		}
		return rMap;
	}

	@Override
	public int deleteReq(String req_seq) throws Exception {
		return reqMapper.deleteReq(req_seq);
	}

	@Override
	public List<ReqDTO> getNearReqList(String tuner_seq) throws Exception {
		List<SggDTO> sggList = sggMapper.getTunerSgg(tuner_seq);
		
		TunerDTO tDTO = userMapper.getTunerAddr(tuner_seq);
		
		List<ReqDTO> rList = new ArrayList<ReqDTO>();
		List<ReqDTO> tempReqList = null;
		for(SggDTO sDTO : sggList) {
			tempReqList = reqMapper.getNearReqList(sDTO.getSggCode() + "%");
			if(tempReqList!=null) {
				rList.addAll(tempReqList);
				tempReqList=null;
			}
			
		}
		double diffX, diffY, dist;
		double tunerX = Double.parseDouble(tDTO.getX_pos());
		double tunerY = Double.parseDouble(tDTO.getY_pos());
		for(ReqDTO rDTO2 : rList) {
			rDTO2.setAddr(CmmUtil.nvl(rDTO2.getAddr())
					.replaceAll("&#40;", "(")
					.replaceAll("&#41;", ")"));
			diffX = Double.parseDouble(rDTO2.getX_pos()) - tunerX;
			diffY = Double.parseDouble(rDTO2.getY_pos()) - tunerY;
			dist = Math.sqrt(Math.pow(diffX, 2) + Math.pow(diffY, 2));
			log.info("dist : " + dist);
			rDTO2.setDist(Double.toString(dist));
		}
		Collections.sort(rList);
		for(ReqDTO sortedDTO : rList) {
			log.info("sorted dist : " + sortedDTO.getDist());
		}
		return rList;
	}

	@Override
	public int updateReq(ReqDTO rDTO) throws Exception {
		return reqMapper.updateReq(rDTO);
	}

	@Override
	public void auctionOff(String req_seq) throws Exception {
		reqMapper.auctionOff(req_seq);
	}

	@Override
	public List<ReqDTO> getPrivateReqList(String user_seq) throws Exception {
		return reqMapper.getPrivateReqList(user_seq);
	}

	@Override
	public List<ReqDTO> getTunerPrivateReqList(String tuner_seq) throws Exception {
		return reqMapper.getTunerPrivateReqList(tuner_seq);
	}

	@Override
	public int declineReq(String req_seq, String tuner_seq) throws Exception {
		return reqMapper.declineReq(req_seq, tuner_seq);
	}

	@Override
	public int getReqCurrVal() throws Exception {
		return reqMapper.getReqCurrVal();
	}

}
