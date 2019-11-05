package poly.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import poly.dto.SggDTO;
import poly.persistance.mapper.ISggMapper;
import poly.service.ISggService;

@Service("SggService")
public class SggService implements ISggService{

	private Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="ISggMapper")
	private ISggMapper sggMapper;

	public List<SggDTO> getSido() throws Exception{
		return sggMapper.getSido();
	}

	@Override
	public List<SggDTO> getSgg(String sidoCode) throws Exception {
		return sggMapper.getSgg(sidoCode);
	}

	@Override
	public Map<String, ArrayList<String>> getTunerSgg(String user_seq) throws Exception {
		List<SggDTO> sggList = new ArrayList<>();
		List<SggDTO> sidoList = new ArrayList<>();
		sidoList = sggMapper.getSido();
		
		Map<String, ArrayList<String>> sggGrouped = new HashMap<>();
		// 키에 시도코드, 값에 시도 이름
		Map<String, String> sidoMap = new HashMap<>();
		
		
		for(SggDTO sido : sidoList) {
			sidoMap.put(sido.getSggCode(), sido.getSggName());
		}
		
		sggList = sggMapper.getTunerSgg(user_seq);
		if(sggList.get(0).getSggCode().equals("00")) {
			sggGrouped.put("전국", null);
			return sggGrouped;
		}
		
		
		
		
		String sidoCode;
		String sidoName;
		ArrayList<String> tempList = null;
		for(SggDTO sgg : sggList) {
			sidoCode = sgg.getSggCode().substring(0,2);
			log.info("sidoMap : " + sidoMap);
			sidoName = sidoMap.get(sidoCode);
			log.info("sidoCode : " + sidoCode);
			log.info("sidoName : " + sidoName);
			
			
			tempList = sggGrouped.getOrDefault(sidoName, new ArrayList<>());
			
			if(sidoName.equals(sgg.getSggName())) {
				tempList.add("전체");
			}else {
				tempList.add(sgg.getSggName());
			}
			sggGrouped.put(sidoName, tempList);
			tempList = null;
		}
		
		return sggGrouped;
		
	}

}
