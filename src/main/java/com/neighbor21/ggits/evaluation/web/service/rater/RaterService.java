package com.neighbor21.ggits.evaluation.web.service.rater;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.neighbor21.ggits.evaluation.common.dto.EvalBddCmpEvalListDto;
import com.neighbor21.ggits.evaluation.common.entity.EvalBddCmp;
import com.neighbor21.ggits.evaluation.common.entity.EvalRtr;
import com.neighbor21.ggits.evaluation.common.entity.EvalRtrItemScr;
import com.neighbor21.ggits.evaluation.common.entity.EvalRtrList;
import com.neighbor21.ggits.evaluation.common.entity.EvalRtrSht;
import com.neighbor21.ggits.evaluation.common.entity.EvalShtInfo;
import com.neighbor21.ggits.evaluation.common.enums.EvalRtrShtSttsCd;
import com.neighbor21.ggits.evaluation.common.enums.EvalSttsCd;
import com.neighbor21.ggits.evaluation.common.mapper.EvalBddCmpMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalFileMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalRtrMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalRtrItemScrMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalRtrListMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalRtrShtMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalShtInfoMapper;
import com.neighbor21.ggits.evaluation.common.util.GgitsCommonUtils;

@Service
public class RaterService {
	
	@Autowired
	EvalShtInfoMapper evalShtInfoMapper;
	
	@Autowired
	EvalRtrMapper evalRtrMapper;
	
	@Autowired
	EvalFileMapper evalFileMapper;
	
	@Autowired
	EvalBddCmpMapper evalBddCmpMapper;
	
	@Autowired
	EvalRtrShtMapper evalRtrShtMapper;
	
	@Autowired
	EvalRtrItemScrMapper evalRtrItemScrMapper;
	
	@Autowired
	EvalRtrListMapper evalRtrListMapper;
	
	/**
	  * @Method Name : findOneEvalShtInfoIdByAccssCd
	  * @작성일 : 2023. 10. 19.
	  * @작성자 : IK.MOON
	  * @Method 설명 : 평가 참여코드 확인
	  * @param accssCd
	  * @return
	  */
	public EvalShtInfo findOneEvalShtInfoIdByAccssCd(String accssCd){
		EvalShtInfo evalShtInfo = evalShtInfoMapper.findOneShtInfoByAccssCd(accssCd);
		return evalShtInfo;
	}
	
	/**
	  * @Method Name : findAllEvalRtrByShtInfoId
	  * @작성일 : 2023. 10. 19.
	  * @작성자 : IK.MOON
	  * @Method 설명 : 평가자 리스트 조회
	  * @param accssCd
	  * @return
	  */
	public List<EvalRtr> findAllEvalRtrByShtInfoId(String shtInfoId){
		List<EvalRtr> evalRtrList = evalRtrMapper.findAllRtrByShtInfoId(shtInfoId);
		return evalRtrList;
	}
	
	/**
	  * @Method Name : findOneEvalShtInfoByBirtDt
	  * @작성일 : 2023. 10. 19.
	  * @작성자 : IK.MOON
	  * @Method 설명 : 평가자 생년월일 일치 확인
	  * @param accssCd
	  * @return
	  */
	public EvalRtr findOneEvalShtInfoByBirtDt(EvalRtr evalRtrCheck) {
		EvalRtr evalRtr = evalRtrMapper.findOneRtrByBirtDtAndShtInfoId(evalRtrCheck);
		return evalRtr;
	}
	
	/**
	 * @Method Name : findOneEvalShtInfoByShtInfoId
	 * @작성일 : 2023. 10. 19.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가 공고정보 확인
	 * @param accssCd
	 * @return
	 */
	public EvalShtInfo findOneEvalShtInfoByShtInfoId(String shtInfoId) {
		EvalShtInfo evalShtInfo = evalShtInfoMapper.findOneShtInfoByShtInfoId(shtInfoId);
		return evalShtInfo;
	}
	
	/**
	 * @Method Name : findAllBddCmpByShtInfoIdOrderByCmpNbr
	 * @작성일 : 2023. 10. 23.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 업체명 목록 조회
	 * @param accssCd
	 * @return
	 */
	public List<EvalBddCmpEvalListDto> findAllBddCmpByShtInfoIdOrderByCmpNbr(EvalShtInfo evalShtInfo, String rtrId, String shtType) {
		List<EvalBddCmpEvalListDto> result = new ArrayList<EvalBddCmpEvalListDto>();
		
		List<EvalBddCmp> evalBddCmpList = evalBddCmpMapper.findAllBddCmpByShtInfoIdOrderByCmpNbr(evalShtInfo); 
		for(EvalBddCmp evalBddCmpOut : evalBddCmpList) {
			EvalBddCmpEvalListDto evalBddCmpEvalListDto = new EvalBddCmpEvalListDto();

			evalBddCmpEvalListDto.setBddCmpId(evalBddCmpOut.getBddCmpId());
			evalBddCmpEvalListDto.setBddCmpNm(evalBddCmpOut.getBddCmpNm());
			evalBddCmpEvalListDto.setBddCmpNbr(evalBddCmpOut.getBddCmpNbr());
			List<EvalRtrSht> evalRtrShtList = evalRtrShtMapper.findAllRtrShtByRtrIdAndBddCmpId(rtrId, evalBddCmpOut.getBddCmpId(), shtType);
			
			EvalRtrSht evalRtrSht = evalRtrShtList.get(0);

			if(!GgitsCommonUtils.isNull(evalRtrSht.getShtSvDt())) {
				evalRtrShtList.get(0).setTotalScr(evalRtrItemScrMapper.findTotalScrByRtrShtId(evalRtrSht.getRtrShtId()));
			}
			evalBddCmpEvalListDto.setEvalRtrSht(evalRtrShtList);
			
			result.add(evalBddCmpEvalListDto);
		}
		return result;
	}
	
	/**
	 * @Method Name : countAllEvalShtInfoList
	 * @작성일 : 2023. 10. 23.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가할 기업 목록 개수 조회
	 * @param accssCd
	 * @return
	 */
	public int countAllEvalShtInfoList(String shtInfoId) {
		
		return evalBddCmpMapper.countAllBddCmpByShtInfoId(shtInfoId);
	}
	
	/**
	 * @Method Name : findAllRtrItemScrJoinRtrShtByRtrShtId
	 * @작성일 : 2023. 10. 23.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가할 기업 목록 개수 조회
	 * @param rtrShtId
	 * @return
	 */
	public List<EvalRtrItemScr> findAllRtrItemScrJoinRtrShtByRtrShtId(String rtrShtId) {
		
		return evalRtrItemScrMapper.findAllRtrItemScrJoinRtrShtByRtrShtId(rtrShtId);
	}
	
	public List<EvalRtrItemScr> findAllRtrItemScrJoinRtrShtAndEvalShtByRtrIdAndShtInfoId(String shtInfoId, String rtrId, String shtType) {
		
		return evalRtrItemScrMapper.findAllRtrItemScrJoinRtrShtAndEvalShtByRtrIdAndShtInfoId(shtInfoId, rtrId, shtType);
	}
	
	/**
	 * @Method Name : saveRtrScr
	 * @작성일 : 2023. 10. 23.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가할 기업 목록 개수 조회
	 * @param rtrShtId
	 * @return
	 */
	public void saveRtrScr(List<EvalRtrItemScr> evaltrItemScrs) {
		String rtrShtId = "";
		for(EvalRtrItemScr evalRtrItemScr : evaltrItemScrs) {
			evalRtrItemScr.setRtrSctrScrId(GgitsCommonUtils.getUuid());
			evalRtrItemScrMapper.save(evalRtrItemScr);
			if(rtrShtId.equals("")) {
				rtrShtId = evalRtrItemScr.getRtrShtId();
				
				EvalRtrSht evalRtrSht = new EvalRtrSht();
				evalRtrSht.setShtStts(EvalRtrShtSttsCd.EVAL_COMPLETE.getCode());
				evalRtrSht.setRtrShtId(rtrShtId);
				
				evalRtrShtMapper.updateShtSttsByRtrShtId(evalRtrSht);
			}
		}
	}
	
	/**
	 * @Method Name : updateRtrScr
	 * @작성일 : 2023. 10. 23.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가할 기업 목록 개수 조회
	 * @param rtrShtId
	 * @return
	 */
	public void updateRtrScr(List<EvalRtrItemScr> evaltrItemScrs) {
		String rtrShtId = "";
		for(EvalRtrItemScr evalRtrItemScr : evaltrItemScrs) {
			evalRtrItemScrMapper.update(evalRtrItemScr);
			if(rtrShtId.equals("")) {
				rtrShtId = evalRtrItemScr.getRtrShtId();
				
				EvalRtrSht evalRtrSht = new EvalRtrSht();
				evalRtrSht.setShtStts(EvalRtrShtSttsCd.EVAL_COMPLETE.getCode());
				evalRtrSht.setRtrShtId(rtrShtId);
				
				evalRtrShtMapper.updateShtSttsByRtrShtId(evalRtrSht);
			}
		}
	}
	
	/**
	 * @Method Name : saveRtrScrTmp
	 * @작성일 : 2023. 10. 23.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가 점수 임시 저장 insert
	 * @param rtrShtId
	 * @return
	 */
	public void saveRtrScrTmp(List<EvalRtrItemScr> evaltrItemScrs) {
		String rtrShtId = evaltrItemScrs.get(0).getRtrShtId();
		int savedItemScrCount = evalRtrItemScrMapper.findAllRtrItemScrJoinRtrShtByRtrShtId(rtrShtId).size();
		if(savedItemScrCount < 1) {
			for(EvalRtrItemScr evalRtrItemScr : evaltrItemScrs) {
				evalRtrItemScr.setRtrSctrScrId(GgitsCommonUtils.getUuid());
				evalRtrItemScrMapper.save(evalRtrItemScr);
			}
		} else {
			for(EvalRtrItemScr evalRtrItemScr : evaltrItemScrs) {
				evalRtrItemScrMapper.update(evalRtrItemScr);
			}
		}
	}
	
	/**
	 * @Method Name : updateRtrScrTmp
	 * @작성일 : 2023. 10. 23.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가 점수 임시 저장 update
	 * @param rtrShtId
	 * @return
	 */
	public void updateRtrScrTmp(List<EvalRtrItemScr> evaltrItemScrs) {
		for(EvalRtrItemScr evalRtrItemScr : evaltrItemScrs) {
			evalRtrItemScrMapper.update(evalRtrItemScr);
		}
	}
	
	public void updateAllStts(String shtInfoId, String rtrId) {
		
		EvalShtInfo evalShtInfo = new EvalShtInfo();
		evalShtInfo.setShtInfoId(shtInfoId);
		
		EvalRtrList evalRtrList = new EvalRtrList();
		evalRtrList.setRtrId(rtrId);
		evalRtrList.setShtInfoId(shtInfoId);
		
		// (EvalShtInfo)평가 대기 -> 진행중 상태 변경
		evalShtInfo.setShtAllStts(EvalSttsCd.EVAL_WAITING.getCode());
		if(evalShtInfoMapper.countAllByShtInfoIdAndShtAllStts(evalShtInfo) > 0) {
			evalShtInfo.setShtAllStts(EvalSttsCd.EVAL_PROGRESS.getCode());
			evalShtInfoMapper.updateShtAllSttsByshtInfoId(evalShtInfo);
		}
		
		// (EvalRtrList)평가자 평가지 모두 작성: 평가완료 상태 N -> Y 
		String shtStts = EvalRtrShtSttsCd.EVAL_WAITING.getCode();
		if (evalRtrShtMapper.countAllByRtrIdAndShtInfoIdAndShtStts(shtInfoId, rtrId, shtStts) < 1) {
			evalRtrListMapper.updateEvalCmpltByRtrIdAndShtInfoId(evalRtrList);
			
			// (EvalShtInfo)전체 평가자 평가: 평가완료 상태 변경
			if (evalRtrListMapper.countAllByShtInfoIdAndEvalCmplt(evalRtrList) < 1) {
				evalShtInfo.setShtAllStts(EvalSttsCd.EVAL_COMPLETE.getCode());
				evalShtInfoMapper.updateShtAllSttsByshtInfoId(evalShtInfo);
			}
		}
		
	}
	
	/**
	 * @Method Name : getShtCount
	 * @작성일 : 2023. 11. 03.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가지 상태값으로 카운트 조회
	 * @param String shtInfoId, String rtrId
	 * @return int
	 */
//	public int getShtCount(EvalShtInfo evalShtInfo,String rtrId, String shtType) {
//		Map<String,Object> paramMap = new HashMap<String,Object>();
//
//		//평가자 회사 ID목록 조회
////		List<String> bddCmpIdList = evalBddCmpMapper.findAllCmpInfoByShtInfoId(evalShtInfo.getShtInfoId());
//
////		paramMap.put("bddCmpIdList", bddCmpIdList);
////		paramMap.put("rtrId", rtrId);
////		paramMap.put("shtStts", "ERSSC000");
//		
//		return evalRtrShtMapper.countByShtSttsCdAndBddCmpIdList(paramMap);
//	}
}
