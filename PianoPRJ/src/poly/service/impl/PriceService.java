package poly.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import poly.dto.PriceDTO;
import poly.persistance.mapper.IPriceMapper;
import poly.service.IPriceService;

@Service("PriceService")
public class PriceService implements IPriceService{

	
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name = "PriceMapper")
	IPriceMapper priceMapper;
	
	
	@Override
	public List<PriceDTO> getMarketPrice(String fromDate, String toDate) throws Exception {
		List<PriceDTO> pList = priceMapper.getMarketPrice(fromDate, toDate);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-M-dd");
		Date from = sdf.parse(fromDate);
		Date to = sdf.parse(toDate);
		
		Calendar fromCal = Calendar.getInstance();
		Calendar toCal = Calendar.getInstance();
		
		
		
		
		PriceDTO tempDTO = null;
		
		if(pList==null) {
			
			pList = new ArrayList<PriceDTO>();
			
			fromCal.setTime(from);
			toCal.setTime(to);
			
			for(;fromCal.compareTo(toCal)<=0; fromCal.add(Calendar.DATE, 1)) {
				tempDTO = new PriceDTO();
				tempDTO.setEmpty(sdf.format(fromCal.getTime()));
				pList.add(tempDTO);
				tempDTO = null;
			}
			return pList;
		}
		
		// 일별 시세 넣기
		Map<String, PriceDTO> rMap = new HashMap<>();
		List<String> dateList = new ArrayList<>();
		String tuningStart = null;
		String regulStart = null;
		String voicingStart = null;
		String transportStart = null;
		
		
		
		
		for(PriceDTO pDTO : pList) {
			dateList.add(pDTO.getDeal_date());
			rMap.put(pDTO.getDeal_date(), pDTO);
			tuningStart = tuningStart==null ? pDTO.getTuning_avg() : tuningStart;
			regulStart = regulStart==null ? pDTO.getRegul_avg() : regulStart;
			voicingStart = voicingStart==null ? pDTO.getVoicing_avg() : voicingStart;
			transportStart = transportStart==null ? pDTO.getTransport_avg() : transportStart;
			
		}
		tuningStart = tuningStart==null ? "0" : tuningStart;
		regulStart = regulStart==null ? "0" : regulStart;
		voicingStart = voicingStart==null ? "0" : voicingStart;
		transportStart = transportStart==null ? "0" : transportStart;
		
		String first = dateList.get(0);
		
		log.info("dateList : " + dateList);
		
		List<PriceDTO> finalList = new ArrayList<>();
		
		
		// 초기 값 설정
		tempDTO = new PriceDTO(fromDate);
		tempDTO.setTuning_avg(tuningStart);
		tempDTO.setRegul_avg(regulStart);
		tempDTO.setVoicing_avg(voicingStart);
		tempDTO.setTransport_avg(transportStart);
		finalList.add(tempDTO);
		fromCal.add(Calendar.DATE, 1);
		tempDTO = null;
			
		fromCal.setTime(from);
		toCal.setTime(to);

		// 빈자리 채우기
		for(int i = 0;fromCal.compareTo(toCal)<=0; fromCal.add(Calendar.DATE, 1)) {
			
			String tempDate = sdf.format(fromCal.getTime());
			
			if(dateList.contains(tempDate)) {
				tempDTO = rMap.get(tempDate);
			}else {
				tempDTO = new PriceDTO(tempDate);
			}
			
			tempDTO.copyPrices(finalList.get(i));
			log.info("date : " + tempDate);
			log.info("tuning price : " + tempDTO.getTuning_avg());
			log.info("regul price : " + tempDTO.getRegul_avg());
			log.info("voicing price : " + tempDTO.getVoicing_avg());
			log.info("transport price " + tempDTO.getTransport_avg());
			finalList.add(tempDTO);
			tempDTO = null;

			i++;
			log.info("-----------------------------------------");
		}
		
		
		return finalList;
	}

}
