package poly.service.impl;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import poly.dto.ReqDTO;
import poly.persistance.mapper.IReqMapper;
import poly.service.IReqService;

@Service("ReqService")
public class ReqService implements IReqService {

	@Resource(name = "ReqMapper")
	private IReqMapper reqMapper;

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

}
