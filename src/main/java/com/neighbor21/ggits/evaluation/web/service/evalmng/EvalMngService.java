package com.neighbor21.ggits.evaluation.web.service.evalmng;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.neighbor21.ggits.evaluation.common.component.FileUploadComponent;
import com.neighbor21.ggits.evaluation.common.dto.EvalBddCmpInfoSaveDTO;
import com.neighbor21.ggits.evaluation.common.dto.EvalFileInfoDTO;
import com.neighbor21.ggits.evaluation.common.dto.EvalResultDTO;
import com.neighbor21.ggits.evaluation.common.dto.EvalResultDTO.EvalResultHeaderInfo;
import com.neighbor21.ggits.evaluation.common.dto.EvalResultDTO.EvalResultRtrInfo;
import com.neighbor21.ggits.evaluation.common.dto.EvalShtInfoDTO;
import com.neighbor21.ggits.evaluation.common.dto.EvalShtInfoDTO.EvalShtSctrInfo;
import com.neighbor21.ggits.evaluation.common.dto.EvalShtInfoDTO.EvalShtSctrInfo.EvalShtItemInfo;
import com.neighbor21.ggits.evaluation.common.entity.EvalBddCmp;
import com.neighbor21.ggits.evaluation.common.entity.EvalFile;
import com.neighbor21.ggits.evaluation.common.entity.EvalRtrList;
import com.neighbor21.ggits.evaluation.common.entity.EvalRtrSht;
import com.neighbor21.ggits.evaluation.common.entity.EvalSht;
import com.neighbor21.ggits.evaluation.common.entity.EvalShtInfo;
import com.neighbor21.ggits.evaluation.common.entity.EvalShtItem;
import com.neighbor21.ggits.evaluation.common.entity.EvalShtQltScr;
import com.neighbor21.ggits.evaluation.common.entity.EvalShtQntScr;
import com.neighbor21.ggits.evaluation.common.entity.EvalShtSctr;
import com.neighbor21.ggits.evaluation.common.enums.EvalRtrShtSttsCd;
import com.neighbor21.ggits.evaluation.common.enums.EvalSttsCd;
import com.neighbor21.ggits.evaluation.common.enums.FileTypeCd;
import com.neighbor21.ggits.evaluation.common.mapper.EvalBddCmpMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalFileMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalRtrListMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalRtrShtMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalShtInfoMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalShtItemMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalShtMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalShtQltScrMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalShtQntScrMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalShtSctrMapper;
import com.neighbor21.ggits.evaluation.common.util.GgitsCommonUtils;
import com.neighbor21.ggits.evaluation.support.exception.CommonException;
import com.neighbor21.ggits.evaluation.support.exception.ErrorCode;

@Service
public class EvalMngService {
	
	@Autowired
	FileUploadComponent fileUploadComponent;
	
	@Autowired
	EvalShtInfoMapper evalShtInfoMapper;
	
	@Autowired
	EvalFileMapper evalFileMapper;
	
	@Autowired
	EvalBddCmpMapper evalBddCmpMapper;
	
	@Autowired
	EvalShtQntScrMapper evalShtQntScrMapper;
	
	@Autowired
	EvalShtQltScrMapper evalShtQltScrMapper;
	
	@Autowired
	EvalShtSctrMapper evalShtSctrMapper;
	
	@Autowired
	EvalShtMapper evalShtMapper;
	
	@Autowired
	EvalRtrListMapper evalRtrListMapper;
	
	@Autowired
	EvalRtrShtMapper evalRtrShtMapper;
	
	@Autowired
	EvalShtItemMapper evalShtItemMapper;
	
	/** 
	 * @Method Name : insertEvalShtInfo
	 * @작성일 : 2023. 10. 16
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가 정보 입력
	 * @return
	 */
	public String saveEvalShtInfo(EvalShtInfo evalShtInfo,List<MultipartFile> requestForProposalFileList,List<MultipartFile> attachmentFileList,List<MultipartFile> presentationFileList) {
		
		String shtInfoId = GgitsCommonUtils.getUuid();
		List<EvalFileInfoDTO> evalFileInfoDTOList = new ArrayList<EvalFileInfoDTO>();
		try {
			
			//평가지 정보 입력
			evalShtInfo.setShtInfoId(shtInfoId);
			evalShtInfo.setShtAllStts(EvalSttsCd.EVAL_INFO_WRITING.getCode());
			String accssCd = changeAccssCode(shtInfoId);
			evalShtInfo.setAccssCd(accssCd);
			evalShtInfoMapper.save(evalShtInfo);
			
			//제안요청서 파일 정보 저장 
			if(!requestForProposalFileList.isEmpty()) {
				for(MultipartFile requestForProposalFile : requestForProposalFileList) {
					if(requestForProposalFile.getSize() > 0) {
						EvalFileInfoDTO requestFileDTO = new EvalFileInfoDTO();
						
						EvalFile evalFile = fileUploadComponent.getEvalFileInfo(requestForProposalFile, shtInfoId, FileTypeCd.REQUEST_FOR_PROPOSAL,"");
						evalFileMapper.save(evalFile);
						
						requestFileDTO.setFile(requestForProposalFile);
						requestFileDTO.setEvalFile(evalFile);
						evalFileInfoDTOList.add(requestFileDTO);
					}
				}
			}
			
			//제안서 정보 저장
			if(!attachmentFileList.isEmpty()) {
				for(MultipartFile attachmentFile : attachmentFileList) {
					if(attachmentFile.getSize() > 0) {
						EvalFileInfoDTO attachmentFileDTO = new EvalFileInfoDTO();
						
						EvalFile evalFile = fileUploadComponent.getEvalFileInfo(attachmentFile, shtInfoId, FileTypeCd.PROPOSALS,"");
						
						evalFileMapper.save(evalFile);
						
						attachmentFileDTO.setFile(attachmentFile);
						attachmentFileDTO.setEvalFile(evalFile);
						evalFileInfoDTOList.add(attachmentFileDTO);
					}
				}
			}
			
			//발표자료 정보 저장
			if(!presentationFileList.isEmpty()) {
				for(MultipartFile presentationFile : presentationFileList) {
					EvalFileInfoDTO presentationFileDTO = new EvalFileInfoDTO();
					if(presentationFile.getSize() > 0) {
						EvalFile evalFile = fileUploadComponent.getEvalFileInfo(presentationFile, shtInfoId, FileTypeCd.PRESENTATION_DOC,"");
						evalFileMapper.save(evalFile);
						
						presentationFileDTO.setFile(presentationFile);
						presentationFileDTO.setEvalFile(evalFile);
						evalFileInfoDTOList.add(presentationFileDTO);
					}
				}
			}
		}catch (Exception e) {
			throw new CommonException(ErrorCode.ENTITY_SAVE_FAIL,"평가지 정보 등록에 실패했습니다.");
		}
		
		if(evalFileInfoDTOList != null && evalFileInfoDTOList.size() > 0) {
			fileUploadComponent.uploadEvalFileList(evalFileInfoDTOList);
		}
		
		return shtInfoId;
	}
	
	/** 
	 * @Method Name : insertEvalShtInfo
	 * @작성일 : 2023. 10. 16
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가 정보 입력
	 * @return
	 */
	public String updateEvalShtInfo(EvalShtInfo evalShtInfo,List<MultipartFile> requestForProposalFileList,List<MultipartFile> attachmentFileList,List<MultipartFile> presentationFileList) {
		
		String shtInfoId = evalShtInfo.getShtInfoId();
		List<EvalFileInfoDTO> evalFileInfoDTOList = new ArrayList<EvalFileInfoDTO>();
		try {
			
			//평가지 정보 입력
			EvalShtInfo evalShtDBInfo = evalShtInfoMapper.findOneByShtInfoId(evalShtInfo.getShtInfoId());
			evalShtInfo.setShtAllStts(evalShtDBInfo.getShtAllStts());
			evalShtInfo.setAccssCd(evalShtDBInfo.getAccssCd());
			evalShtInfoMapper.update(evalShtInfo);
			//제안요청서 파일 정보 저장 
			if(!requestForProposalFileList.isEmpty()) {
				for(MultipartFile requestForProposalFile : requestForProposalFileList) {
					EvalFileInfoDTO requestFileDTO = new EvalFileInfoDTO();
					if(requestForProposalFile.getSize() > 0) {
						EvalFile evalFile = fileUploadComponent.getEvalFileInfo(requestForProposalFile, shtInfoId, FileTypeCd.REQUEST_FOR_PROPOSAL,"");
						evalFileMapper.save(evalFile);
						
						requestFileDTO.setFile(requestForProposalFile);
						requestFileDTO.setEvalFile(evalFile);
						evalFileInfoDTOList.add(requestFileDTO);
					}
				}
			}
			
			//제안서 정보 저장
			if(!attachmentFileList.isEmpty()) {
				for(MultipartFile attachmentFile : attachmentFileList) {
					EvalFileInfoDTO attachmentFileDTO = new EvalFileInfoDTO();
					if(attachmentFile.getSize() > 0) {
						EvalFile evalFile = fileUploadComponent.getEvalFileInfo(attachmentFile, shtInfoId, FileTypeCd.PROPOSALS,"");
						evalFileMapper.save(evalFile);
						
						attachmentFileDTO.setFile(attachmentFile);
						attachmentFileDTO.setEvalFile(evalFile);
						evalFileInfoDTOList.add(attachmentFileDTO);
					}
				}
			}
			
			//발표자료 정보 저장
			if(!presentationFileList.isEmpty()) {
				for(MultipartFile presentationFile : presentationFileList) {
					EvalFileInfoDTO presentationFileDTO = new EvalFileInfoDTO();
					if(presentationFile.getSize() > 0) {
						EvalFile evalFile = fileUploadComponent.getEvalFileInfo(presentationFile, shtInfoId, FileTypeCd.PRESENTATION_DOC,"");
						evalFileMapper.save(evalFile);
						
						presentationFileDTO.setFile(presentationFile);
						presentationFileDTO.setEvalFile(evalFile);
						evalFileInfoDTOList.add(presentationFileDTO);
					}
				}
			}
		}catch (Exception e) {
			throw new CommonException(ErrorCode.ENTITY_SAVE_FAIL,"평가지 정보 등록에 실패했습니다.");
		}
		
		if(evalFileInfoDTOList != null && evalFileInfoDTOList.size() > 0) {
			fileUploadComponent.uploadEvalFileList(evalFileInfoDTOList);
		}
		return shtInfoId;
	}
	
	/**
	  * @Method Name : saveEvalBddCmp
	  * @작성일 : 2023. 10. 18.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 평가 대상 등록
	  * @param evalBddCmp
	  */
	public String saveEvalBddCmp(List<EvalBddCmp> evalBddCmpList) {
		
		String shtInfoId = "";
		try {
			if(!evalBddCmpList.isEmpty()) {
				//평가 대상 업체 저장
				for(EvalBddCmp evalBddCmp : evalBddCmpList) {
					String bddCmpId = GgitsCommonUtils.getUuid();
					evalBddCmp.setBddCmpId(bddCmpId);
					evalBddCmpMapper.save(evalBddCmp);
				}
				shtInfoId = evalBddCmpList.get(0).getShtInfoId();
				//평가 정보 상태 변경
				EvalShtInfo evalShtInfo = evalShtInfoMapper.findOneByShtInfoId(shtInfoId);
				evalShtInfo.setShtAllStts(EvalSttsCd.EVAL_TARGER_WRITING.getCode());
				evalShtInfoMapper.update(evalShtInfo);
			}
		}catch (Exception e) {
			throw new CommonException(ErrorCode.ENTITY_SAVE_FAIL,"평가대상 정보 등록에 실패했습니다.");
		}
		
		return shtInfoId;
	}
	
	/**
	 * @Method Name : updateEvalBddCmp
	 * @작성일 : 2023. 10. 18.
	 * @작성자 : NK.KIM
	 * @Method 설명 : 평가 대상 수정
	 * @param evalBddCmp
	 */
	public String updateEvalBddCmp(EvalBddCmpInfoSaveDTO evalBddCmpInfoSaveDTO) {
		
		String shtInfoId = "";
		try {
			if(!evalBddCmpInfoSaveDTO.getEvalBddCmpList().isEmpty()) {
				shtInfoId = evalBddCmpInfoSaveDTO.getEvalBddCmpList().get(0).getShtInfoId();
				//평가 대상 업체 저장
				for(EvalBddCmp evalBddCmp : evalBddCmpInfoSaveDTO.getEvalBddCmpList()) {
					String bddCmpId = evalBddCmp.getBddCmpId();
					if(GgitsCommonUtils.isNull(bddCmpId)) {
						bddCmpId = GgitsCommonUtils.getUuid();
						evalBddCmp.setBddCmpId(bddCmpId);
						evalBddCmpMapper.save(evalBddCmp);
						
						//작성자 시트 테이블 save
						EvalRtrSht evalRtrSht = new EvalRtrSht();
						List<EvalSht> evalShtList = evalShtMapper.findAllByShtInfoId(shtInfoId);
						for(EvalSht evalSht : evalShtList) {
							String shtId = evalSht.getShtId();
							
							evalRtrSht.setBddCmpId(bddCmpId);
							evalRtrSht.setShtId(shtId);
							
							List<Map<String,Object>> evalRtrList = evalRtrListMapper.findAllByShtInfoId(shtInfoId);
							
							for(Map<String,Object> evalRtrShtMap : evalRtrList) {
								//작성자 시트 DB SAVE
								String rtrShtId = GgitsCommonUtils.getUuid();
								String rtrId = (String)evalRtrShtMap.get("rtrId");
								
								evalRtrSht.setRtrShtId(rtrShtId);
								evalRtrSht.setRtrId(rtrId);
								evalRtrSht.setShtStts(EvalRtrShtSttsCd.EVAL_WAITING.getCode());
								
								evalRtrShtMapper.save(evalRtrSht);
							}
						}
					}else {
						EvalBddCmp evalBddCmpDBInfo = evalBddCmpMapper.findOneByBddCmpId(bddCmpId);
						if(evalBddCmpDBInfo.getBddCmpNbr() != evalBddCmp.getBddCmpNbr()) {
							evalBddCmpMapper.update(evalBddCmp);
						}
					}
				}

			}
			if(!evalBddCmpInfoSaveDTO.getDelBddCmpIdList().isEmpty()) {
				for(String bddCmpId : evalBddCmpInfoSaveDTO.getDelBddCmpIdList()) {
					evalBddCmpMapper.deleteByBddCmpId(bddCmpId);
					//작성자 평가지 테이블 삭제
					evalRtrShtMapper.deleteByBddCmpId(bddCmpId);
				}
			}
		}catch (Exception e) {
			throw new CommonException(ErrorCode.ENTITY_SAVE_FAIL,"평가대상 정보 수정에 실패했습니다.");
		}
		
		return shtInfoId;
	}
	
	/**
	  * @Method Name : findAllEvalShtInfoList
	  * @작성일 : 2023. 10. 18.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 평가지 목록 조회
	  * @param evalShtInfo
	  * @return
	  */
	public List<EvalShtInfo> findAllEvalShtInfoList(EvalShtInfo evalShtInfo){
		
		return evalShtInfoMapper.findAll(evalShtInfo);
	}
	/**
	 * @Method Name : countAllEvalShtInfoList
	 * @작성일 : 2023. 10. 18.
	 * @작성자 : NK.KIM
	 * @Method 설명 : 평가지 목록 개수 조회
	 * @param evalShtInfo
	 * @return
	 */
	public int countAllEvalShtInfoList(EvalShtInfo evalShtInfo){
		
		return evalShtInfoMapper.countAll(evalShtInfo);
	}
	
	public void deleteEvalShtInfo(String shtInfoId) {
		List<EvalFile> evalFileList = new ArrayList<EvalFile>();
		try {
			
			//평가지 정보 조회
			List<EvalSht> evalShtList = evalShtMapper.findAllByShtInfoId(shtInfoId);
			if(evalShtList.size() > 0) {
				for(EvalSht evalSht : evalShtList) {
					//평가 내용부문 정보 조회
					deleteEvalSctrInfo(evalSht.getShtId(),"all");
				}
				//평가지 테이블
				evalShtMapper.deleteByShtInfoId(shtInfoId);
			}
			
			
			//입찰 기업 테이블
			evalBddCmpMapper.deleteByShtInfoId(shtInfoId);
			//파일 정보 조회 / 삭제 / 경로 list담아서 전체 테이블 삭제 후 실제 파일 삭제
			evalFileList = evalFileMapper.findAllByShtInfoId(shtInfoId);
			evalFileMapper.deleteByShtInfoId(shtInfoId);
			//평가지 정보 삭제
			evalShtInfoMapper.deleteByShtInfoId(shtInfoId);
		}catch (Exception e) {
			throw new CommonException(ErrorCode.ENTITY_SAVE_FAIL,"평가지 삭제를 실패했습니다.");
		}
		
		try {
			// 실제 파일 삭제
			if(evalFileList.size() > 0) {
				fileUploadComponent.deleteFileList(evalFileList);
			}
		} catch (Exception e) {
			throw new CommonException(ErrorCode.FILE_DATA_NOT_EXISTS,"삭제할 첨부 파일을 찾지 못했습니다.");
		}
	}
	
	
	public Map<String,Object> saveEvalShtList(EvalShtInfoDTO evalShtInfoDTO) {
		Map<String,Object> resultMap = new HashMap<String, Object>();
		String resultMessage = "평가지 상태 정보 수정 실패했습니다.";
		String evalSttsCode = "9999";
		
		try {
			EvalSht evalSht = new EvalSht();
			String shtInfoId = evalShtInfoDTO.getShtInfoId();
			String shtType = evalShtInfoDTO.getShtType();
			String shtId = evalShtInfoDTO.getShtId();
			if(GgitsCommonUtils.isNull(shtId)) {
				shtId = GgitsCommonUtils.getUuid();
				
				evalSht.setShtInfoId(shtInfoId);
				evalSht.setShtId(shtId);
				evalSht.setShtType(shtType);
				//eval_sht insert
				evalShtMapper.save(evalSht);
			}
			
			for(EvalShtSctrInfo evalShtSctrInfo : evalShtInfoDTO.getEvalShtSctrList()) {
				
				//평가부문 저장
				EvalShtSctr evalShtSctr = new EvalShtSctr();
				String shtSctrId = GgitsCommonUtils.getUuid();
				evalShtSctr.setShtSctrId(shtSctrId);
				evalShtSctr.setShtId(shtId);
				
				String fldSctr = evalShtSctrInfo.getFldSctr();
				//fldSctr null check
				if(GgitsCommonUtils.isNull(fldSctr)) {
					throw new CommonException(ErrorCode.ENTITY_UPDATE_FAIL,"평가지 정보 등록 실패했습니다.");
				}
				if(fldSctr.length() > 255) {
					throw new CommonException(ErrorCode.ENTITY_UPDATE_FAIL,"평가지 정보 등록 실패했습니다.");
				}
				
				evalShtSctr.setFldSctr(fldSctr);
				evalShtSctr.setFldOrdr(evalShtSctrInfo.getFldOrdr());
				evalShtSctrMapper.save(evalShtSctr);
				
				
				//평가부문 항목 저장
				for(EvalShtItemInfo evalShtItemInfo : evalShtSctrInfo.getEvalShtItemList()) {
					
					EvalShtItem evalShtItem = new EvalShtItem();
					
					String shtItmId = GgitsCommonUtils.getUuid();
					evalShtItem.setShtItmId(shtItmId);
					evalShtItem.setShtSctrId(shtSctrId);
					evalShtItem.setItmNm(evalShtItemInfo.getItmNm());
					evalShtItem.setItmElmnt(evalShtItemInfo.getItmElmnt());
					evalShtItem.setItemOrdr(evalShtItemInfo.getItemOrdr());
					
					evalShtItemMapper.save(evalShtItem);
					
					//배점 정보 저장
					//정량적인 경우
					if("qnt".equals(shtType)) {
						EvalShtQntScr evalShtQntScr = evalShtItemInfo.getEvalShtQntScrInfo();
						//정량 배점 null check
						int fldScr = evalShtQntScr.getFldScr(); // 점수
						
						if(fldScr > 99) {
							throw new CommonException(ErrorCode.ENTITY_UPDATE_FAIL,"평가지 정보 등록 실패했습니다.");
						}
						String qntScrId = GgitsCommonUtils.getUuid();
						evalShtQntScr.setQntScrId(qntScrId);
						evalShtQntScr.setShtItmId(shtItmId);
						
						evalShtQntScrMapper.save(evalShtQntScr);
					}else {
						//정성적인 경우
						for(EvalShtQltScr evalShtQltScr : evalShtItemInfo.getEvalShtQltScrList()) {
							int scr = evalShtQltScr.getScr(); //점수
							String scrNm = evalShtQltScr.getScrNm(); //배점명
							
							if(scr > 99) {
								throw new CommonException(ErrorCode.ENTITY_UPDATE_FAIL,"평가지 정보 등록 실패했습니다.");
							}
							if(GgitsCommonUtils.isNull(scrNm)) {
								throw new CommonException(ErrorCode.ENTITY_UPDATE_FAIL,"평가지 정보 등록 실패했습니다.");
							}
							if(scrNm.length() > 10) {
								throw new CommonException(ErrorCode.ENTITY_UPDATE_FAIL,"평가지 정보 등록 실패했습니다.");
							}
							String qltScrId = GgitsCommonUtils.getUuid();
							evalShtQltScr.setQltScrId(qltScrId);
							evalShtQltScr.setShtItmId(shtItmId);
							
							evalShtQltScrMapper.save(evalShtQltScr);
						}
						//정성 배점 null check
						
					}
				}
			}
			
			//평가지 상태 코드 체크 후 평가지 상태 정보 수정
			//정량 : qnt , 정성:qlt
			//정량 평가지 등록 하므로 정성 type으로 DB 조회후 존재하면 평가대기 / 존재하지 않으면 평가지 작성중 상태로 업데이트
			EvalShtInfo evalShtInfo = evalShtInfoMapper.findOneByShtInfoId(shtInfoId);
			//저장버튼 클릭시
			String chkShtType = "qlt";
			String evalShtName = "정량적";
			//정량적 DEFALUT
			evalSttsCode = EvalSttsCd.EVAL_QNT_FORM_WRITING.getCode();
			if("qlt".equals(shtType)) {
				chkShtType = "qnt";
				evalShtName = "정성적";
				evalSttsCode = EvalSttsCd.EVAL_QLT_FORM_WRITING.getCode(); //정성적 평가지 작성중
			}
			if("save".equals(evalShtInfoDTO.getSaveType())) {
				EvalSht evalShtSttsChk = new EvalSht();
				evalShtSttsChk.setShtInfoId(shtInfoId);
				evalShtSttsChk.setShtType(chkShtType);
				int evalShtChkCnt = evalShtMapper.countByShtInfoIdAndShtType(evalShtSttsChk);
				if(evalShtChkCnt == 0) {
					//평가 정보 상태 변경
					resultMessage = evalShtName+" 평가지 작성이 저장되었습니다. 작성하지 않은 평가지 선택 후 작성을 진행세요.";
				}else if(evalShtChkCnt == 1) {
					evalSttsCode = EvalSttsCd.EVAL_WAITING.getCode();
					resultMessage = "평가지 작성이 저장되었습니다.";
				}else {
					throw new CommonException(ErrorCode.ENTITY_UPDATE_FAIL,"평가지 상태 정보 수정 실패했습니다.");
				}
			}else {
				//임시저장 버튼 클릭 시
				resultMessage = evalShtName+" 평가지가 임시저장되었습니다.";
			}
			evalShtInfo.setShtAllStts(evalSttsCode);
			evalShtInfoMapper.update(evalShtInfo);
			
			resultMap.put("shtInfoId", shtInfoId);
			resultMap.put("evalSttsCode", evalSttsCode);
			resultMap.put("resultMessage", resultMessage);
				
		}catch (Exception e) {
			throw new CommonException(ErrorCode.ENTITY_SAVE_FAIL,"평가지 정보 등록 실패했습니다.");
		}
		
		return resultMap;
	}
	
	public Map<String,Object> updateEvalShtList(EvalShtInfoDTO evalShtInfoDTO) {
		Map<String,Object> resultMap = new HashMap<String, Object>();
		
		try {
			String shtId = evalShtInfoDTO.getShtId();
			String shtType = evalShtInfoDTO.getShtType();
			if(evalShtInfoDTO.getEvalShtSctrList().size() > 0) {
				//평가 부문 수정
				for(EvalShtSctrInfo evalShtSctrInfo : evalShtInfoDTO.getEvalShtSctrList()) {
					
					EvalShtSctr evalShtSctr = new EvalShtSctr();
					String shtSctrId = evalShtSctrInfo.getShtSctrId();
					String fldSctr = evalShtSctrInfo.getFldSctr();
					int fldOrdr = evalShtSctrInfo.getFldOrdr();
					
					evalShtSctr.setShtId(shtId);
					evalShtSctr.setShtSctrId(shtSctrId);
					evalShtSctr.setFldSctr(fldSctr);
					evalShtSctr.setFldOrdr(fldOrdr);
					
					//fldSctr null check
					if(GgitsCommonUtils.isNull(fldSctr)) {
						throw new CommonException(ErrorCode.ENTITY_UPDATE_FAIL,"평가지 정보 등록 실패했습니다.");
					}
					if(fldSctr.length() > 255) {
						throw new CommonException(ErrorCode.ENTITY_UPDATE_FAIL,"평가지 정보 등록 실패했습니다.");
					}
					
					//새로 추가된 평가부문
					if(GgitsCommonUtils.isNull(shtSctrId)) {
						shtSctrId = GgitsCommonUtils.getUuid();
						evalShtSctr.setShtSctrId(shtSctrId);
						evalShtSctrMapper.save(evalShtSctr);
					}else {
						//기존에 존재하는 평가부문
						evalShtSctr.setShtSctrId(shtSctrId);
						evalShtSctrMapper.update(evalShtSctr);
					}

					for(EvalShtItemInfo evalShtItemInfo : evalShtSctrInfo.getEvalShtItemList()) {
						
						EvalShtItem evalShtItem = new EvalShtItem();
						
						evalShtItem.setShtSctrId(shtSctrId);
						evalShtItem.setItmNm(evalShtItemInfo.getItmNm());
						evalShtItem.setItmElmnt(evalShtItemInfo.getItmElmnt());
						evalShtItem.setItemOrdr(evalShtItemInfo.getItemOrdr());
						String shtItmId = evalShtItemInfo.getShtItmId();
						
						//저장
						if(GgitsCommonUtils.isNull(shtItmId)) {
							shtItmId = GgitsCommonUtils.getUuid();
							evalShtItem.setShtItmId(shtItmId);
							evalShtItemMapper.save(evalShtItem);
						}else {
							//기존 배점 삭제
							evalShtQltScrMapper.deleteByShtItmId(shtItmId);
							
							evalShtItem.setShtItmId(shtItmId);
							evalShtItemMapper.update(evalShtItem);
						}
						
						//정량적인 경우
						if("qnt".equals(shtType)) {
							EvalShtQntScr evalShtQntScr = evalShtItemInfo.getEvalShtQntScrInfo();
							//정량 배점 null check
							int fldScr = evalShtQntScr.getFldScr(); // 점수
							if(fldScr > 99) {
								throw new CommonException(ErrorCode.ENTITY_UPDATE_FAIL,"평가지 정보 등록 실패했습니다.");
							}
							String qntScrId = evalShtQntScr.getQntScrId();
							evalShtQntScr.setShtItmId(shtItmId);
							
							//정성적 배점 pk가 없으면 insert
							if(GgitsCommonUtils.isNull(qntScrId)) {
								qntScrId = GgitsCommonUtils.getUuid();
								evalShtQntScr.setQntScrId(qntScrId);
								evalShtQntScrMapper.save(evalShtQntScr);
							}else {
								//정성적 배점 pk가 없으면 update
								evalShtQntScr.setQntScrId(qntScrId);
 								evalShtQntScrMapper.update(evalShtQntScr);
							}
								
							
						}else {
							//정성적 인경우
//							EvalShtQltScr evalShtQltScrInfo = evalShtItemInfo.getEvalShtQltScrInfo();
							for(EvalShtQltScr evalShtQltScrInfo : evalShtItemInfo.getEvalShtQltScrList()) {
								int scr = evalShtQltScrInfo.getScr(); //점수
								String scrNm = evalShtQltScrInfo.getScrNm(); //배점명
								
								if(scr > 99) {
									throw new CommonException(ErrorCode.ENTITY_UPDATE_FAIL,"평가지 정보 등록 실패했습니다.");
								}
								if(GgitsCommonUtils.isNull(scrNm)) {
									throw new CommonException(ErrorCode.ENTITY_UPDATE_FAIL,"평가지 정보 등록 실패했습니다.");
								}
								if(scrNm.length() > 10) {
									throw new CommonException(ErrorCode.ENTITY_UPDATE_FAIL,"평가지 정보 등록 실패했습니다.");
								}
								
								String qltScrId = GgitsCommonUtils.getUuid();
								evalShtQltScrInfo.setQltScrId(qltScrId);
								evalShtQltScrInfo.setShtItmId(shtItmId);
								

								evalShtQltScrMapper.save(evalShtQltScrInfo);
							}
						}
					}
					
				}
			}
			
			//평가부문, 항목, 배점 삭제 
			if(evalShtInfoDTO.getDelShtSctrIdArray().size() > 0) {
				for(String shtSctrId : evalShtInfoDTO.getDelShtSctrIdArray()) {
					EvalShtSctr delEvalShtSctr = new EvalShtSctr();
					
					List<String> shtItmIdList = evalShtItemMapper.findAllByShtSctrId(shtSctrId)
																.stream()
																.map(x -> x.getShtItmId())
																.collect(Collectors.toCollection(ArrayList::new));
					deleteEvalItmList(shtItmIdList, shtType);
					
					delEvalShtSctr.setShtSctrId(shtSctrId);
					evalShtSctrMapper.deleteByShtSctrId(shtSctrId);
				}
			} 
			//평가 항목 배점 삭제 (부문은 삭제하지 않는 경우)
			if(evalShtInfoDTO.getDelShtItmIdArray().size() > 0) {
				deleteEvalItmList(evalShtInfoDTO.getDelShtItmIdArray(), shtType);
			}
			EvalShtInfo evalShtInfo = evalShtInfoMapper.findOneByShtInfoId(evalShtInfoDTO.getShtInfoId());
			
			resultMap.put("evalSttsCode", evalShtInfo.getShtAllStts());
			resultMap.put("resultMessage", "평가지 정보가 수정되었습니다.");
			
		}catch (Exception e) {
			throw new CommonException(ErrorCode.ENTITY_SAVE_FAIL,"평가지 정보 수정 실패했습니다.");
		}
		
		return resultMap;
	}
	
	
	public void saveRtrList(List<EvalRtrList> requestEvalRtrList) {

		String shtInfoId = requestEvalRtrList.get(0).getShtInfoId();
		try {
			// 기존 평가자 리스트 조회
			List<Map<String,Object>> existingRtrList = evalRtrListMapper.findAllByShtInfoId(shtInfoId);
			
			if(existingRtrList.size() < 1) {
				// 기존 평가자 리스트 없음.
				for(EvalRtrList evalRtrInfo : requestEvalRtrList) {
					String rtrLstId = GgitsCommonUtils.getUuid();
					String evalCmplt = "N";
					
					evalRtrInfo.setRtrLstId(rtrLstId);
					evalRtrInfo.setEvalCmplt(evalCmplt);
					
					evalRtrListMapper.save(evalRtrInfo);
					
					List<Map<String,Object>> evalBddCmpList = evalBddCmpMapper.findAllJoinEvalShtByShtInfoId(evalRtrInfo.getShtInfoId());
					if(evalBddCmpList.size() > 0) {
						for(Map<String,Object> evalBddCmp : evalBddCmpList) {
							EvalRtrSht evalRtrSht = new EvalRtrSht();
							
							String rtrShtId = GgitsCommonUtils.getUuid();
							String bddCmpId = (String)evalBddCmp.get("bddCmpId");
							String shtId = (String)evalBddCmp.get("shtId");
							
							evalRtrSht.setRtrShtId(rtrShtId);
							evalRtrSht.setBddCmpId(bddCmpId);
							evalRtrSht.setShtId(shtId);
							evalRtrSht.setRtrId(evalRtrInfo.getRtrId());
							evalRtrSht.setShtStts(EvalRtrShtSttsCd.EVAL_WAITING.getCode());
							
							evalRtrShtMapper.save(evalRtrSht);
						}
					}
				}	
			} else {
				// 기존 평가자 리스트 있음.
				List<String> matchedRtrIdList = new ArrayList<String>();
				
				for(Map<String,Object> existingRtr : existingRtrList) {
					String rtrId = (String)existingRtr.get("rtrId");
					for(EvalRtrList requestedRtr : requestEvalRtrList) {
						if(rtrId.equals(requestedRtr.getRtrId())) {
							matchedRtrIdList.add(rtrId);
						} 
					}
				} // 기존-요청 일치 리스트 찾기
			
				if(matchedRtrIdList.size() > 0) {
					for(String matchedRtrId : matchedRtrIdList) {
						for(Map<String,Object> existingRtr : existingRtrList) {
							String rtrId = (String)existingRtr.get("rtrId");
							if(rtrId.equals(matchedRtrId)) {
								existingRtrList.remove(existingRtr);
								break;
							}
						} // 삭제 할 평가자 리스트
						
						for(EvalRtrList evalRtr : requestEvalRtrList) {
							String rtrId = evalRtr.getRtrId();
							if(rtrId.equals(matchedRtrId)) {
								requestEvalRtrList.remove(evalRtr);
								break;
							}
						} // 추가 할 평가자 리스트
					}
				} // 일치 리스트가 있는 경우
				
				if(existingRtrList.size() > 0) {
					for(Map<String,Object> rtrToDelete : existingRtrList) {
						// 삭제 - 평가자 리스트에서
						String rtrListIdToDelete = (String)rtrToDelete.get("rtrListId");
						String rtrIdToDelete = (String)rtrToDelete.get("rtrId");
						evalRtrListMapper.deleteByRtrListId(rtrListIdToDelete);
						
						// 삭제 - 평가자 작성 평가지
						List<EvalRtrSht> rtrShtToDeleteList = evalRtrShtMapper.findAllJoinEvalShtByRtrIdAndShtInfoId(rtrIdToDelete, shtInfoId);
						for(EvalRtrSht rtrShtToDelete : rtrShtToDeleteList) {
							evalRtrShtMapper.deleteByRtrShtId(rtrShtToDelete);
						}
					}
				} // 삭제 할 평가자가 있다면 실행 
				
				if(requestEvalRtrList.size() > 0) {
					// 추가
					for(EvalRtrList evalRtrInfo : requestEvalRtrList) {
						String rtrLstId = GgitsCommonUtils.getUuid();
						String evalCmplt = "N";
						
						evalRtrInfo.setRtrLstId(rtrLstId);
						evalRtrInfo.setEvalCmplt(evalCmplt);
						
						evalRtrListMapper.save(evalRtrInfo);
						
						List<Map<String,Object>> evalBddCmpList = evalBddCmpMapper.findAllJoinEvalShtByShtInfoId(evalRtrInfo.getShtInfoId());
						if(evalBddCmpList.size() > 0) {
							for(Map<String,Object> evalBddCmp : evalBddCmpList) {
								EvalRtrSht evalRtrSht = new EvalRtrSht();
								
								String rtrShtId = GgitsCommonUtils.getUuid();
								String bddCmpId = (String)evalBddCmp.get("bddCmpId");
								String shtId = (String)evalBddCmp.get("shtId");
								
								evalRtrSht.setRtrShtId(rtrShtId);
								evalRtrSht.setBddCmpId(bddCmpId);
								evalRtrSht.setShtId(shtId);
								evalRtrSht.setRtrId(evalRtrInfo.getRtrId());
								evalRtrSht.setShtStts(EvalRtrShtSttsCd.EVAL_WAITING.getCode());
								
								evalRtrShtMapper.save(evalRtrSht);
							} // for
						} // if
					} // for
				} // if 추가 할 평가자가 있다면 실행
			}
		}catch (Exception e) {
			throw new CommonException(ErrorCode.ENTITY_SAVE_FAIL,"평가자 정보 등록 실패했습니다.");
		}
	}
	
	
	public EvalShtInfoDTO findAllEvalScrInfo(String shtInfoId,String type) {
		EvalShtInfoDTO result = new EvalShtInfoDTO();
		EvalSht evalSht = new EvalSht();
		
		evalSht.setShtInfoId(shtInfoId);
		evalSht.setShtType(type);
		
		EvalSht evalShtInfo = evalShtMapper.findOneByShtInfoIdAndShtType(evalSht);
		if(evalShtInfo != null) {
			result.setShtId(evalShtInfo.getShtId());
			result.setSaveType("update");
			result.setShtType(evalShtInfo.getShtType());
			
			List<EvalShtSctr> evalShtSctrDBList = evalShtSctrMapper.findAllByShtId(evalShtInfo.getShtId());
			if(evalShtSctrDBList.size() > 0) {
				
				List<EvalShtSctrInfo> evalShtSctrList = new ArrayList<EvalShtInfoDTO.EvalShtSctrInfo>();
				for(EvalShtSctr evalShtSctr : evalShtSctrDBList) {
					
					//평가 부문 정보
					EvalShtSctrInfo evalShtSctrInfo = new EvalShtSctrInfo();
					evalShtSctrInfo.setShtId(evalShtSctr.getShtId());
					evalShtSctrInfo.setShtSctrId(evalShtSctr.getShtSctrId());
					evalShtSctrInfo.setFldOrdr(evalShtSctr.getFldOrdr());
					evalShtSctrInfo.setFldSctr(evalShtSctr.getFldSctr());
					
					//평가 항목 정보
					List<EvalShtItemInfo> evalShtItemList = new ArrayList<EvalShtInfoDTO.EvalShtSctrInfo.EvalShtItemInfo>();
					List<EvalShtItem> evalShtItemDbList = evalShtItemMapper.findAllByShtSctrId(evalShtSctr.getShtSctrId());
					if(evalShtItemDbList.size() > 0) {
						int itemIdx = 0;
						for(EvalShtItem evalShtItem : evalShtItemDbList) {
							EvalShtItemInfo evalShtItemInfo = new EvalShtItemInfo();
							
							String shtItmId = evalShtItem.getShtItmId();
							
							evalShtItemInfo.setShtItmId(shtItmId);
							evalShtItemInfo.setShtSctrId(evalShtItem.getShtSctrId());
							evalShtItemInfo.setItmNm(evalShtItem.getItmNm());
							evalShtItemInfo.setItmElmnt(evalShtItem.getItmElmnt());
							evalShtItemInfo.setItemOrdr(evalShtItem.getItemOrdr());
							
							
							//배점 정보
							if("qlt".equals(type)) {
								List<EvalShtQltScr> evalShtQltScrList = evalShtQltScrMapper.findAllByShtItmId(shtItmId);
								int qltScrSize = evalShtQltScrList.size(); 
								if(qltScrSize > 0) {
									if(itemIdx == 0) {
										result.setSelectQntScrSize(qltScrSize);
										evalShtSctrInfo.setQntScrListSize(qltScrSize);
									}
									evalShtItemInfo.setEvalShtQltScrList(evalShtQltScrList);
								}
							}
							if("qnt".equals(type)) {
								EvalShtQntScr evalShtQltScr = evalShtQntScrMapper.findOneByShtItmId(shtItmId);
								evalShtItemInfo.setEvalShtQntScrInfo(evalShtQltScr);
							}
							//항목/배점 정보 저장
							evalShtItemList.add(evalShtItemInfo);
							itemIdx++;
						}
						evalShtSctrInfo.setEvalShtItemList(evalShtItemList);
					}
					
					//평가부문 정보 저장
					evalShtSctrList.add(evalShtSctrInfo);
				}
				
				result.setEvalShtSctrList(evalShtSctrList);
			}
		}else {
			result.setSaveType("save");
		}
		
		result.setShtInfoId(shtInfoId);
		
		return result;
	}
	
	private void deleteEvalItmList(List<String> shtItmIdList,String shtType) {
		for(String shtItmId : shtItmIdList) {
			//정량적
			if("qnt".equals(shtType)) {
				evalShtQntScrMapper.deleteByShtItmId(shtItmId);
			}else {
			//정성적
				evalShtQltScrMapper.deleteByShtItmId(shtItmId);
			}
			
			//항목 삭제
			evalShtItemMapper.deleteByShtItmId(shtItmId);
		}
	}
	
	
	public void deleteEvalSctrInfo(String shtId,String shtType) {
		try {
			
			//평가 내용부문 정보 조회
			List<EvalShtSctr> evalShtSctrList = evalShtSctrMapper.findAllByShtId(shtId);
			
			if(evalShtSctrList.size() > 0) {
				for(EvalShtSctr evalShtSctr : evalShtSctrList) {
					String shtSctrId = evalShtSctr.getShtSctrId();
					
					//평가 항목부문 정보 조회
					List<EvalShtItem> evalShtItemList = evalShtItemMapper.findAllByShtSctrId(shtSctrId);
					
					if(evalShtItemList.size() > 0) {
						for(EvalShtItem evalShtItem : evalShtItemList) {
							
							String shtItemId = evalShtItem.getShtItmId();
							
							if("qnt".equals(shtType)) {
								//정량적 평가지 배점 삭제
								evalShtQntScrMapper.deleteByShtItmId(shtItemId);
							}else if("qlt".equals(shtType)) {
								evalShtQltScrMapper.deleteByShtItmId(shtItemId);
							}else {
								evalShtQntScrMapper.deleteByShtItmId(shtItemId);
								evalShtQltScrMapper.deleteByShtItmId(shtItemId);
							}
							evalShtItemMapper.deleteByShtItmId(shtItemId);
						}
					}
					//평가 내용 부문 테이블
					evalShtSctrMapper.deleteByShtSctrId(shtSctrId);
				}
			}
		}catch (Exception e) {
			 throw new CommonException(ErrorCode.ENTITY_DELETE_FAIL,"평가지 정보 삭제 실패했습니다.");
		}
	}
	
	/**
	  * @Method Name : changeAccssCode
	  * @작성일 : 2023. 10. 26.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 참여코드 중복 체크
	  * @param shtInfoId
	  * @return
	  */
	public String changeAccssCode(String shtInfoId) {
		
		String accssCd = "";
		while(true) {
			accssCd = GgitsCommonUtils.getRandomKey(6);
			int accssCode = evalShtInfoMapper.countByAccssCode(accssCd);
			if(accssCode == 0) {
				break;
			}
		}
		
		return accssCd;
	}
	
	/**
	  * @Method Name : updateAccssCode
	  * @작성일 : 2023. 10. 26.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 참여코드 수정
	  * @param shtInfoId
	  */
	public void updateAccssCode(String shtInfoId) {
		
		try {
			EvalShtInfo evalShtInfo = evalShtInfoMapper.findOneByShtInfoId(shtInfoId);
			String accssCd = changeAccssCode(shtInfoId);
			evalShtInfo.setAccssCd(accssCd);
			evalShtInfoMapper.update(evalShtInfo);
		}catch (Exception e) {
			throw new CommonException(ErrorCode.ENTITY_UPDATE_FAIL,"참여코드가 수정되지 않았습니다.");
		}

	}
	
	
	public void copyEvalShtInfo(String shtInfoId) {
		
		List<EvalFileInfoDTO> evalFileInfoDTOList = new ArrayList<EvalFileInfoDTO>();
		String copyShtInfoId = GgitsCommonUtils.getUuid();
		try {
			
			//평가지 정보 
			EvalShtInfo evalShtInfo = evalShtInfoMapper.findOneByShtInfoId(shtInfoId);
//			String copyShtInfoId = GgitsCommonUtils.getUuid();
			evalShtInfo.setShtInfoId(copyShtInfoId);
			String accssCd = changeAccssCode(shtInfoId);
			evalShtInfo.setAccssCd(accssCd);
			evalShtInfo.setShtAllStts(EvalSttsCd.EVAL_WAITING.getCode());
			evalShtInfoMapper.save(evalShtInfo);
			
			
			//회사정보
			List<EvalBddCmp> evalBddCmpList = evalBddCmpMapper.findAllByShtInfoId(shtInfoId);
			for(EvalBddCmp evalBddCmp : evalBddCmpList) {
				String copyBddCmpId = GgitsCommonUtils.getUuid();
				evalBddCmp.setBddCmpId(copyBddCmpId);
				evalBddCmp.setShtInfoId(copyShtInfoId);
				evalBddCmpMapper.save(evalBddCmp);
			}
			//시트정보 
			List<EvalSht> evalShtList = evalShtMapper.findAllByShtInfoId(shtInfoId);
			for(EvalSht evalSht : evalShtList) {
				String shtId = evalSht.getShtId();
				String copyShtId = GgitsCommonUtils.getUuid();
				evalSht.setShtId(copyShtId);
				evalSht.setShtInfoId(copyShtInfoId);
				evalShtMapper.save(evalSht);
				
				//평가부문 정보
				List<EvalShtSctr> evalShtSctrList = evalShtSctrMapper.findAllByShtId(shtId);
				if(evalShtSctrList.size() > 0) {
					for(EvalShtSctr evalShtSctr : evalShtSctrList) {
						String shtSctrId = evalShtSctr.getShtSctrId();
						String copyShtSctrId = GgitsCommonUtils.getUuid();
						evalShtSctr.setShtSctrId(copyShtSctrId);
						evalShtSctr.setShtId(copyShtId);
						evalShtSctrMapper.save(evalShtSctr);
						//평가항목 정보
						List<EvalShtItem> evalShtItemList = evalShtItemMapper.findAllByShtSctrId(shtSctrId);
						if(evalShtItemList.size() > 0) {
							for(EvalShtItem evalShtItem : evalShtItemList) {
								String shtItmId = evalShtItem.getShtItmId();
								String copyShtItmId = GgitsCommonUtils.getUuid();
								evalShtItem.setShtItmId(copyShtItmId);
								evalShtItem.setShtSctrId(copyShtSctrId);
								evalShtItemMapper.save(evalShtItem);
								//평가배점 정보
								//정성적
								List<EvalShtQltScr> evalShtQltScrList = evalShtQltScrMapper.findAllByShtItmId(shtItmId);
								if(evalShtQltScrList.size() > 0) {
									for(EvalShtQltScr evalShtQltScr : evalShtQltScrList) {
										String copyQltScrId = GgitsCommonUtils.getUuid();
										evalShtQltScr.setQltScrId(copyQltScrId);
										evalShtQltScr.setShtItmId(copyShtItmId);
										evalShtQltScrMapper.save(evalShtQltScr);
									}
								}
								//정량적
								EvalShtQntScr evalShtQntScr = evalShtQntScrMapper.findOneByShtItmId(shtItmId);
								if(evalShtQntScr != null) {
									String copyQntScrId = GgitsCommonUtils.getUuid();
									evalShtQntScr.setQntScrId(copyQntScrId);
									evalShtQntScr.setShtItmId(copyShtItmId);
									evalShtQntScrMapper.save(evalShtQntScr);
								}
							}
						}
					}
				}
			}
			
			
		}catch (Exception e) {
			throw new CommonException(ErrorCode.ENTITY_UPDATE_FAIL,"재사용할 평가지 정보를 가져오는데 실패했습니다.");
		}
		
		try {
			//파일정보
			List<EvalFile> evalFileList = evalFileMapper.findAllByShtInfoIdAndRequestFileAndAttachmentFile(shtInfoId);
			for(EvalFile evalFile : evalFileList) {
				EvalFileInfoDTO evalFileInfoDTO = new  EvalFileInfoDTO();
				
				MultipartFile multipartFile = fileUploadComponent.getMultipartFile(evalFile);
				
				EvalFile copyEvalFile = fileUploadComponent.getEvalFileInfo(multipartFile, copyShtInfoId, FileTypeCd.getEnum(evalFile.getFileType()),multipartFile.getOriginalFilename());
				evalFileMapper.save(copyEvalFile);
				
				evalFileInfoDTO.setEvalFile(copyEvalFile);
				evalFileInfoDTO.setFile(multipartFile);
				evalFileInfoDTOList.add(evalFileInfoDTO);
			}
			
			//실제 파일 copy
			if(evalFileInfoDTOList != null && evalFileInfoDTOList.size() > 0) {
				fileUploadComponent.uploadEvalFileList(evalFileInfoDTOList);
			}
			
		} catch (Exception e) {
			throw new CommonException(ErrorCode.FILE_NOT_EXISTS,"재사용할 첨부파일을 가져오지 못했습니다.");
		}
	}
	
	
	public EvalResultDTO findAllEvalResultInfo(String shtInfoId,String shtType) {
		EvalResultDTO evalResultDTO = new EvalResultDTO();
		EvalShtInfo evalShtInfo = evalShtInfoMapper.findOneByShtInfoId(shtInfoId);
		
		if(evalShtInfo == null) {
			throw new CommonException(ErrorCode.ENTITY_DATA_NULL,"평가지 정보가 존재하지 않습니다.");
		}
		evalResultDTO.setShtNm(evalShtInfo.getShtNm());
		
		EvalSht evalSht = new EvalSht();
		evalSht.setShtInfoId(shtInfoId);
		
		evalSht.setShtType(shtType);
		
		String shtName = "정성적";
		if("qnt".equals(shtType)) {
			shtName = "정량적";
		}else if("all".equals(shtType)) {
			shtName = "총";
		}
		
		Map<String,Object> paramMap = new HashMap<String, Object>();
		
		if(!"all".equals(shtType)) {
			evalSht = evalShtMapper.findOneByShtInfoIdAndShtType(evalSht);
			paramMap.put("shtId", evalSht.getShtId());
			
			if(GgitsCommonUtils.isNull(evalSht.getShtId())) {
				throw new CommonException(ErrorCode.ENTITY_DATA_NULL, shtName+ "평가지가 존재하지 않습니다.");
			}
		}
		
		paramMap.put("shtInfoId", shtInfoId);
		paramMap.put("shtType", shtType);
		
		//header , 평균 , 합계 , 최고 점수 / 최저 점수 목록 setting
		EvalResultHeaderInfo headerInfo = evalShtMapper.findOneRsultHeaderInfoByShtInfoIdAndShtId(paramMap); 
		if(headerInfo == null) {
			throw new CommonException(ErrorCode.ENTITY_DATA_NULL, shtName+ "평가지 정보가 존재하지 않습니다.");
		}
		evalResultDTO.setEvalResultHeaderInfo(headerInfo);
		
		//평가자 정보 조회 
		List<EvalResultRtrInfo> evalResultRtrInfoList = evalShtMapper.findAllRsultRtrScrInfoByShtInfoIdAndShtId(paramMap); 
		if(evalResultRtrInfoList == null) {
			throw new CommonException(ErrorCode.ENTITY_DATA_NULL, shtName+ "평가지 평가자 정보가 존재하지 않습니다.");
		}
		evalResultDTO.setEvalResultRtrInfoList(evalResultRtrInfoList);
		
		return evalResultDTO;
	}
}
