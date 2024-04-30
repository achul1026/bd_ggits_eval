package com.neighbor21.ggits.evaluation.web.controller.evalmng;

import java.io.UnsupportedEncodingException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.neighbor21.ggits.evaluation.common.component.FileUploadComponent;
import com.neighbor21.ggits.evaluation.common.component.validate.ValidateBuilder;
import com.neighbor21.ggits.evaluation.common.component.validate.ValidateChecker;
import com.neighbor21.ggits.evaluation.common.component.validate.ValidateResult;
import com.neighbor21.ggits.evaluation.common.dto.EvalBddCmpEvalListDto;
import com.neighbor21.ggits.evaluation.common.dto.EvalBddCmpInfoSaveDTO;
import com.neighbor21.ggits.evaluation.common.dto.EvalRaterScrDTO;
import com.neighbor21.ggits.evaluation.common.dto.EvalResultDTO;
import com.neighbor21.ggits.evaluation.common.dto.EvalShtInfoDTO;
import com.neighbor21.ggits.evaluation.common.dto.EvalShtInfoDTO.EvalShtSctrInfo;
import com.neighbor21.ggits.evaluation.common.dto.EvalShtInfoDTO.EvalShtSctrInfo.EvalShtItemInfo;
import com.neighbor21.ggits.evaluation.common.dto.EvalShtListInfoDTO;
import com.neighbor21.ggits.evaluation.common.dto.EvalResultDTO.EvalResultRtrInfo;
import com.neighbor21.ggits.evaluation.common.entity.CommonResponse;
import com.neighbor21.ggits.evaluation.common.entity.EvalBddCmp;
import com.neighbor21.ggits.evaluation.common.entity.EvalFile;
import com.neighbor21.ggits.evaluation.common.entity.EvalRtr;
import com.neighbor21.ggits.evaluation.common.entity.EvalRtrItemScr;
import com.neighbor21.ggits.evaluation.common.entity.EvalRtrList;
import com.neighbor21.ggits.evaluation.common.entity.EvalRtrSht;
import com.neighbor21.ggits.evaluation.common.entity.EvalShtInfo;
import com.neighbor21.ggits.evaluation.common.entity.EvalShtQntScr;
import com.neighbor21.ggits.evaluation.common.entity.Paging;
import com.neighbor21.ggits.evaluation.common.enums.EvalRtrShtSttsCd;
import com.neighbor21.ggits.evaluation.common.enums.EvalSttsCd;
import com.neighbor21.ggits.evaluation.common.enums.FileTypeCd;
import com.neighbor21.ggits.evaluation.common.mapper.EvalBddCmpMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalFileMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalRtrListMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalRtrMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalRtrShtMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalShtInfoMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalShtMapper;
import com.neighbor21.ggits.evaluation.common.util.GgitsCommonUtils;
import com.neighbor21.ggits.evaluation.support.exception.CommonException;
import com.neighbor21.ggits.evaluation.support.exception.ErrorCode;
import com.neighbor21.ggits.evaluation.web.service.evalmng.EvalMngService;
import com.neighbor21.ggits.evaluation.web.service.rater.RaterService;

@Controller
@RequestMapping("/evaluation/management")
public class EvalMngContoller {
	
	@Autowired
	FileUploadComponent fileUploadComponent;
	
	@Autowired
	EvalMngService evalMngService;
	
	@Autowired
	RaterService raterService;
	
	@Autowired
	EvalShtMapper evalShtMapper;
	
	@Autowired
	EvalShtInfoMapper evalShtInfoMapper;
	
	@Autowired
	EvalFileMapper evalFileMapper;
	
	@Autowired
	EvalBddCmpMapper evalBddCmpMapper;
	
	@Autowired
	EvalRtrListMapper evalRtrListMapper;
	
	@Autowired
	EvalRtrMapper evalRtrMapper;
	
	@Autowired
	EvalRtrShtMapper evalRtrShtMapper;
	
	
	/**
	 * @Method Name : getEvalList
	 * @작성일 : 2023. 9. 20.
	 * @작성자 : KY.LEE
	 * @Method 설명 : 평가지 목록 조회 화면
	 * @return
	 */
	@GetMapping("/list.do")
	public String getEvalList(Model model,EvalShtInfo evalShtInfo) {
		
		int pageSize = 3;
		int paramPageNo = evalShtInfo.getPageNo();
		int pageNo = (evalShtInfo.getPageNo() - 1) * pageSize;
		evalShtInfo.setPageNo(pageNo);
		
		List<EvalShtInfo> evalShtInfoList = evalMngService.findAllEvalShtInfoList(evalShtInfo);
		int totalCnt = evalMngService.countAllEvalShtInfoList(evalShtInfo);
		
		Map<String,Object> countInfo = evalShtInfoMapper.countAllForShtAllStts();
		
		Paging paging = new Paging();
		paging.setPageSize(pageSize);
		paging.setPageNo(paramPageNo);
    	paging.setTotalCount(totalCnt);
    	
    	model.addAttribute("evalShtInfoList", evalShtInfoList);
    	model.addAttribute("paging", paging);
    	model.addAttribute("countInfo", countInfo);
    	model.addAttribute("schSchStts", evalShtInfo.getSchSchStts());
    	model.addAttribute("schShtNm", evalShtInfo.getSchShtNm());
    	
		return "view/evalMng/evalMngList";
	}

	/**
	 * @Method Name : getEvalListAjax
	 * @작성일 : 2023.12. 01.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가지 목록 조회 화면 (비동기)
	 * @return
	 */
	@PostMapping("/list.ajax")
	public @ResponseBody EvalShtListInfoDTO getEvalListAjax(@RequestBody EvalShtInfo evalShtInfo) {
		EvalShtListInfoDTO evalShtListInfoDTO = new EvalShtListInfoDTO();
		int pageSize = 3;
		int pageNo = (evalShtInfo.getPageNo() - 1) * pageSize;
		evalShtInfo.setPageNo(pageNo);
		
		List<EvalShtInfo> evalShtInfoList = evalMngService.findAllEvalShtInfoList(evalShtInfo);
		Map<String,Object> countInfo = evalShtInfoMapper.countAllForShtAllStts();
		
		evalShtListInfoDTO.setEvalShtInfoList(evalShtInfoList);
		evalShtListInfoDTO.setCountInfo(countInfo);
		
		return evalShtListInfoDTO;
	}
	
	/**
	 * @Method Name : getEvalSave
	 * @작성일 : 2023. 9. 20.
	 * @작성자 : KY.LEE
	 * @Method 설명 : 평가지 생성 화면
	 * @return
	 */
	@GetMapping("/save.do")
	public String getEvalSave(@RequestParam(value = "shtInfoId", required = false) String shtInfoId, Model model) {
		if(!GgitsCommonUtils.isNull(shtInfoId)) {
			EvalShtInfo evalShtInfo = evalShtInfoMapper.findOneByShtInfoId(shtInfoId);
			
			EvalFile evalFile = new EvalFile();
			evalFile.setShtInfoId(shtInfoId);
			
			evalFile.setFileType(FileTypeCd.REQUEST_FOR_PROPOSAL.getFileCode());
			List<EvalFile> requestFileList = evalFileMapper.findAllByShtInfoIdAndFileType(evalFile);
			
			evalFile.setFileType(FileTypeCd.PROPOSALS.getFileCode());
			List<EvalFile> attachmentFileList = evalFileMapper.findAllByShtInfoIdAndFileType(evalFile);
			
			evalFile.setFileType(FileTypeCd.PRESENTATION_DOC.getFileCode());
			List<EvalFile> presentationFileList = evalFileMapper.findAllByShtInfoIdAndFileType(evalFile);
			
			model.addAttribute("evalShtInfo",evalShtInfo);
			model.addAttribute("requestFileList",requestFileList);
			model.addAttribute("attachmentFileList",attachmentFileList);
			model.addAttribute("presentationFileList",presentationFileList);
			model.addAttribute("shtInfoId",shtInfoId);
		}
		return "view/evalMng/evalMngSave";
	}
	
	/**
	 * @Method Name : getEvalSave
	 * @작성일 : 2023. 9. 20.
	 * @작성자 : KY.LEE
	 * @Method 설명 : 평가지 생성 화면
	 * @return
	 */
	@GetMapping("/saved.do")
	public String getEvalMngList() {
		return "view/evalMng/evalMngList";
	}

	/**
	 * @Method Name : saveEvalMng
	 * @작성일 : 2023. 9. 20.
	 * @작성자 : KY.LEE
	 * @Method 설명 : 평가지 생성 Ajax
	 * @return : CommonResponse
	 */
	@PostMapping("/save.ajax")
	public @ResponseBody CommonResponse<?> saveEvalMng(
														EvalShtInfo evalShtInfo
														,@RequestParam(name = "requestForProposalFile") List<MultipartFile> requestForProposalFileList, 
														@RequestParam(name = "presentationFile") List<MultipartFile> presentationFileList, 
														@RequestParam(name = "attachmentFile") List<MultipartFile> attachmentFileList 
														) {
		
		Map<String,Object> resultMap = new HashMap<String, Object>();
		String shtNm = "";
		try {
			shtNm = new String(evalShtInfo.getShtNm().getBytes("8859_1"),"utf-8");
			
			evalShtInfo.setShtNm(shtNm);
			
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		
		ValidateBuilder dtoValidator = new ValidateBuilder(evalShtInfo);
		dtoValidator
			.addRule("shtNm", new ValidateChecker().setRequired("평가지명은 필수 입력 값입니다.").setMaxLength(100, "100자 이하로 입력해 주세요."));
		
		ValidateResult dtoValidateResult = dtoValidator.isValid();
		
		if(!dtoValidateResult.isSuccess()) {
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST, dtoValidateResult.getMessage());
		}
		
		String shtInfoId = evalMngService.saveEvalShtInfo(evalShtInfo,requestForProposalFileList,attachmentFileList,presentationFileList);
		resultMap.put("shtInfoId", shtInfoId);
		
		return CommonResponse.successToData(resultMap, "정상적으로 입력되었습니다.");
	}
	
	/**
	 * @Method Name : updateEvalMng
	 * @작성일 : 2023. 9. 20.
	 * @작성자 : KY.LEE
	 * @Method 설명 : 평가지 생성 Ajax
	 * @return : CommonResponse
	 */
	@PostMapping("/update.ajax")
	public @ResponseBody CommonResponse<?> updateEvalMng(
			EvalShtInfo evalShtInfo,
			@RequestParam(name = "requestForProposalFile") List<MultipartFile> requestForProposalFileList, 
			@RequestParam(name = "presentationFile") List<MultipartFile> presentationFileList,
			@RequestParam(name = "attachmentFile") List<MultipartFile> attachmentFileList 
			) {
		
		Map<String,Object> resultMap = new HashMap<String, Object>();
		String shtNm = "";
		try {
			shtNm = new String(evalShtInfo.getShtNm().getBytes("8859_1"),"utf-8");
			
			evalShtInfo.setShtNm(shtNm);
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		
		ValidateBuilder dtoValidator = new ValidateBuilder(evalShtInfo);
		dtoValidator
		.addRule("shtNm", new ValidateChecker().setRequired("평가지명은 필수 입력 값입니다.").setMaxLength(100, "100자 이하로 입력해 주세요."));
		
		ValidateResult dtoValidateResult = dtoValidator.isValid();
		
		if(!dtoValidateResult.isSuccess()) {
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST, dtoValidateResult.getMessage());
		}
		
		String shtInfoId = evalMngService.updateEvalShtInfo(evalShtInfo,requestForProposalFileList,attachmentFileList,presentationFileList);
		resultMap.put("shtInfoId", shtInfoId);
		
		return CommonResponse.successToData(resultMap, "정상적으로 입력되었습니다.");
	}
	
	/**
	  * @Method Name : evalInfoDelete
	  * @작성일 : 2023. 10. 19.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 평가지 작성 정보 삭제
	  * @param shtInfoId
	  * @return
	  */
	@GetMapping("/{shtInfoId}/delete.ajax")
	public @ResponseBody CommonResponse<?> evalInfoDelete(@PathVariable(value = "shtInfoId", required = true) String shtInfoId){
		try {
			
			evalMngService.deleteEvalShtInfo(shtInfoId);
			
		} catch (CommonException ce) {
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST , ce.getMessage());
		}
		
		return CommonResponse.ResponseCodeAndMessage(HttpStatus.OK , "평가지 정보가 삭제되었습니다.");
	}
	
	/**
	 * @Method Name : evalInfoDelete
	 * @작성일 : 2023. 10. 19.
	 * @작성자 : NK.KIM
	 * @Method 설명 : 평가지 작성 정보 삭제
	 * @param shtInfoId
	 * @return
	 */
	@GetMapping("/{shtInfoId}/copy.ajax")
	public @ResponseBody CommonResponse<?> evalInfoCopy(@PathVariable(value = "shtInfoId", required = true) String shtInfoId){
		try {
			evalMngService.copyEvalShtInfo(shtInfoId);
			
		} catch (CommonException ce) {
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST , ce.getMessage());
		}
		
		return CommonResponse.ResponseCodeAndMessage(HttpStatus.OK , "평가지 정보가 복사되었습니다.");
	}
	
	@GetMapping("/{shtInfoId}/status/update.ajax")
	public @ResponseBody CommonResponse<?> evalInfoStatusUpdate(@PathVariable(value = "shtInfoId", required = true) String shtInfoId,
																@RequestParam(value = "sttsType", required = true) String sttsType){
		try {
			EvalShtInfo evalShtInfo = evalShtInfoMapper.findOneByShtInfoId(shtInfoId);
			String evalSttsCd = EvalSttsCd.EVAL_SCORE_GRADING.getCode(); // 기본값 채점 진행중
			if("cmplt".equals(sttsType)) evalSttsCd = EvalSttsCd.EVAL_SOCRE_COMPLETE.getCode();
			evalShtInfo.setShtAllStts(evalSttsCd);
			evalShtInfoMapper.updateShtAllSttsByshtInfoId(evalShtInfo);
		} catch (CommonException ce) {
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST , ce.getMessage());
		}
		
		return CommonResponse.ResponseCodeAndMessage(HttpStatus.OK , "평가지 상태 값이 변경되었습니다.");
	}
	
	/**
	 * @Method Name : accssCodeChange
	 * @작성일 : 2023. 10. 19.
	 * @작성자 : NK.KIM
	 * @Method 설명 : 참여코드 수정
	 * @param shtInfoId
	 * @return
	 */
	@GetMapping("/{shtInfoId}/accss/code/change.ajax")
	public @ResponseBody CommonResponse<?> accssCodeChange(@PathVariable(value = "shtInfoId", required = true) String shtInfoId){
		
		evalMngService.updateAccssCode(shtInfoId);
		return CommonResponse.ResponseCodeAndMessage(HttpStatus.OK , "참여 코드가 수정되었습니다.");
	}
	
	/**
	 * @Method Name : getEvalCmpSave
	 * @작성일 : 2023. 10. 16.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가 대상 등록 화면
	 * @return
	 */
	@GetMapping("/cmp/{shtInfoId}/save.do")
	public String getEvalCmpSave(@PathVariable String shtInfoId, Model model) {
		
		List<EvalBddCmp> evalBddCmpList =  evalBddCmpMapper.findAllByShtInfoId(shtInfoId);
		if(evalBddCmpList.size() > 0) {
			model.addAttribute("evalBddCmpList",evalBddCmpList);
		}
		model.addAttribute("shtInfoId",shtInfoId);
		
		return "view/evalMng/evalMngCmpSave";
	}
	
	/**
	 * @Method Name : evalCmpSaveAjax
	 * @작성일 : 2023. 10. 16.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가 대상 등록 화면
	 * @return
	 */
	@PostMapping("/cmp/save.ajax")
	public @ResponseBody CommonResponse<?> evalCmpSaveAjax(
															@RequestBody EvalBddCmpInfoSaveDTO evalBddCmpInfoSaveDTO
														) {
		Map<String,Object> resultMap = new HashMap<String, Object>();
		
		if(evalBddCmpInfoSaveDTO.getEvalBddCmpList().size() < 1) {
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST, "평가 대상을 하나 이상 입력해 주세요.");
		}
		
		String shtInfoId = evalMngService.saveEvalBddCmp(evalBddCmpInfoSaveDTO.getEvalBddCmpList());
		
		resultMap.put("shtInfoId", shtInfoId);
		
		return CommonResponse.successToData(resultMap, "정상적으로 입력되었습니다.");
	}
	
	/**
	  * @Method Name : evalCmpInfoSaveAjax
	  * @작성일 : 2023. 12. 5.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 회사 정보 저장
	  * @param evalBddCmpInfoSaveDTO
	  * @return
	  */
	@PostMapping("/cmp/{shtInfoId}/save.ajax")
	public @ResponseBody CommonResponse<?> evalCmpInfoSaveAjax(
			
			) {
		
		return CommonResponse.successToData(null, "정상적으로 입력되었습니다.");
	}
	
	/**
	 * @Method Name : evalCmpUdpateAjax
	 * @작성일 : 2023. 10. 16.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가 대상 수정
	 * @return
	 */
	@PostMapping("/cmp/update.ajax")
	public @ResponseBody CommonResponse<?> evalCmpUpdateAjax(
			@RequestBody EvalBddCmpInfoSaveDTO evalBddCmpInfoSaveDTO
			) {
		Map<String,Object> resultMap = new HashMap<String, Object>();

		if(evalBddCmpInfoSaveDTO.getEvalBddCmpList().size() < 1) {
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST, "평가 대상을 하나 이상 입력해 주세요.");
		}
		
		String shtInfoId = evalMngService.updateEvalBddCmp(evalBddCmpInfoSaveDTO);
		
		resultMap.put("shtInfoId", shtInfoId);
		
		return CommonResponse.successToData(resultMap, "정상적으로 입력되었습니다.");
	}
	
	/**
	 * @Method Name : getEvalCmpSave
	 * @작성일 : 2023. 10. 16.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가지 타입 선택 화면
	 * @return
	 */
	@GetMapping("/type/{shtInfoId}/save.do")
	public String getEvalSelectType(@PathVariable String shtInfoId, Model model,@RequestParam(value = "type", required = false) String type) {
		
		if(GgitsCommonUtils.isNull(type)) {
			type = "save";
		}
		//평가지 타입 체크(존재하지 않으면 : BOTH_EMPTY, 정량적 평가지 존재하면 : QLT_EMPTY(정상적 비어있음), 정상적 평가지 존재하면 : QNT_EMPTY(정량적 비어있음), 앞 조건에 해당하지않으면 :BOTH_EXIST)
		Map<String,Object> shtExistCheckMap = evalShtMapper.findOneShtExistCheck(shtInfoId);
		String shtExistCheck = GgitsCommonUtils.isNull(shtExistCheckMap.get("shtExistCheck")) ? "BOTH_EMPTY" : (String) shtExistCheckMap.get("shtExistCheck");
		//조건에 해당하지 않으면 목록으로
		if("save".equals(type) &&"BOTH_EXIST".equals(shtExistCheck)) {
			return "redirect:/evaluation/management/list.do";
		}
		
		model.addAttribute("type",type);
		model.addAttribute("shtExistCheck",shtExistCheck);
		model.addAttribute("shtInfoId",shtInfoId);
		
		//
		return "view/evalMng/evalMngSelectType";
	}

	/**
	 * @Method Name : getEvalQlt
	 * @작성일 : 2023. 10. 06.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 정성적 평가지 작성 화면
	 * @return
	 */
	@GetMapping("/qlt/{shtInfoId}/save.do")
	public String getEvalQlt(@PathVariable String shtInfoId, Model model) {
		
		EvalShtInfoDTO evalQltInfo = evalMngService.findAllEvalScrInfo(shtInfoId,"qlt");
		String shtNm = evalShtInfoMapper.findOneByShtInfoId(shtInfoId).getShtNm();
		
		model.addAttribute("shtNm",shtNm);
		model.addAttribute("evalQltInfo",evalQltInfo);
		
//		model.addAttribute("shtInfoId",shtInfoId);
		return "view/evalMng/evalMngQltSave";
	}
	
	/**
	 * @Method Name : getEvalMngDetailInfo
	 * @작성일 : 2023. 10. 06.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 정량적 평가지 작성 화면
	 * @return
	 */
	@GetMapping("/detailinfo/{shtInfoId}/detail.do")
	public String getEvalMngDetailInfo(@PathVariable String shtInfoId, Model model) {
		EvalShtInfo evalShtInfo = evalShtInfoMapper.findOneByShtInfoId(shtInfoId); 
		
		if(evalShtInfo == null) {
			throw new CommonException(ErrorCode.ENTITY_DATA_NULL,"유저 정보가 존재하지 않습니다.");	
		}
		
		int rtrTotalCnt = evalRtrListMapper.countAllByShtInfoId(shtInfoId);
		
		EvalFile evalFile = new EvalFile();
		evalFile.setShtInfoId(shtInfoId);
		
		evalFile.setFileType(FileTypeCd.REQUEST_FOR_PROPOSAL.getFileCode());
		List<EvalFile> requestFileList = evalFileMapper.findAllByShtInfoIdAndFileType(evalFile);
		
		evalFile.setFileType(FileTypeCd.PROPOSALS.getFileCode());
		List<EvalFile> attachmentFileList = evalFileMapper.findAllByShtInfoIdAndFileType(evalFile);
		
		evalFile.setFileType(FileTypeCd.PRESENTATION_DOC.getFileCode());
		List<EvalFile> presentationFileList = evalFileMapper.findAllByShtInfoIdAndFileType(evalFile);
		
		EvalBddCmp evalBddCmp = evalBddCmpMapper.findOneBddCmpByShtInfoIdOrderByCmpNbrGroupByBddCmpNm(shtInfoId);
		
		model.addAttribute("evalBddCmp", evalBddCmp);
		model.addAttribute("requestFileList", requestFileList);
		model.addAttribute("attachmentFileList", attachmentFileList);
		model.addAttribute("presentationFileList", presentationFileList);
		model.addAttribute("shtAllStts", evalShtInfo.getShtAllStts());
		model.addAttribute("evalShtInfo", evalShtInfo);
		model.addAttribute("rtrTotalCnt", rtrTotalCnt);
		
		return "view/evalMng/evalMngDetailInfo";
	}
	
	/**
	 * @Method Name : evalRsult
	 * @작성일 : 2023. 10. 06.
	 * @작성자 : NK.KIM
	 * @Method 설명 : 평가 결과 화면
	 * @return
	 */
	@GetMapping("/{shtInfoId}/result.do")
	public String evalRsult(@PathVariable String shtInfoId, Model model,@RequestParam(name = "shtType" ,required = false) String shtType) {
		//defalut 정성적 평가지 결과
		if(GgitsCommonUtils.isNull(shtType)) {
			shtType = "all";
		}
		
		EvalResultDTO evalResultInfo = evalMngService.findAllEvalResultInfo(shtInfoId,shtType);
		
		model.addAttribute("evalResultInfo",evalResultInfo);
		model.addAttribute("shtInfoId",shtInfoId);
		model.addAttribute("shtType",shtType);
		
		if (shtType.equals("qlt")) {
			return "view/evalMng/evalMngResultQlt";
		} else if (shtType.equals("qnt")) {
			// 평가지 문항, 배점 정보
			EvalShtInfoDTO evalShtInfoDTO = evalMngService.findAllEvalScrInfo(shtInfoId, shtType);
			
			// 평가자 정보
			List<EvalRtr> raterList = evalRtrMapper.findAllRtrByShtInfoId(shtInfoId);
			String rtrId = raterList.get(0).getRtrId();
			
			// 평가 점수 정보
			List<EvalRtrItemScr> evalRtrSctrScrs = raterService.findAllRtrItemScrJoinRtrShtAndEvalShtByRtrIdAndShtInfoId(shtInfoId, rtrId, "qnt");
			
			
			model.addAttribute("evalShtInfoDTO", evalShtInfoDTO);
			model.addAttribute("evalRtrSctrScrs", evalRtrSctrScrs);
			return "view/evalMng/evalMngResultQnt";
		}
		return "view/evalMng/evalMngResult";
	}
	
	/**
	 * @Method Name : evalIndvRsult
	 * @작성일 : 2023. 10. 06.
	 * @작성자 : NK.KIM
	 * @Method 설명 : 평가 결과 화면
	 * @return
	 */
	@GetMapping("/{shtInfoId}/indv/result.do")
	public String evalIndvRsult(@PathVariable String shtInfoId, Model model,
			@RequestParam(name = "rtrId" ,required = false) String rtrId,
			@RequestParam(name = "bddCmpId" ,required = false) String bddCmpId,
			EvalRtr evalRtr, EvalBddCmp evalBddCmp
			) {
		EvalShtInfo evalShtInfo = evalShtInfoMapper.findOneByShtInfoId(shtInfoId);
		// 평가자 정보
		List<EvalRtr> raterList = evalRtrMapper.findAllRtrByShtInfoId(shtInfoId);
		if(GgitsCommonUtils.isNull(rtrId)) {
			rtrId = raterList.get(0).getRtrId();
		} 
		
		// 기업 정보
		List<EvalBddCmp> bddCmpList = evalBddCmpMapper.findAllByShtInfoId(shtInfoId);
		
		//평가자 정보 조회
		Map<String,Object> paramMap = new HashMap<String, Object>();
		paramMap.put("shtInfoId", shtInfoId);
		paramMap.put("rtrId", rtrId);
		
		List<EvalResultRtrInfo> evalResultRtrInfoList = evalShtMapper.findAllRsultRtrScrInfoByShtInfoIdAndShtIdAndRtrId(paramMap);
		
		//평가지 정보
		EvalShtInfoDTO evalShtInfoDTO = evalMngService.findAllEvalScrInfo(shtInfoId, "qlt");
		
		// 평가자 평가 점수
		List<EvalRtrItemScr> evalRtrSctrScrs = raterService.findAllRtrItemScrJoinRtrShtAndEvalShtByRtrIdAndShtInfoId(shtInfoId, rtrId, "qlt");
		
		model.addAttribute("rtrId", rtrId);
		model.addAttribute("rtrAgncy", evalRtrMapper.findOneRtrAgncyByRtrId(rtrId));
		model.addAttribute("signFileId", evalRtrShtMapper.findOneFileId(shtInfoId, rtrId));
		
		model.addAttribute("evalShtInfoDTO", evalShtInfoDTO);
		model.addAttribute("evalRtrSctrScrs", evalRtrSctrScrs);
		
		
		model.addAttribute("bddCmpId", bddCmpId);
		model.addAttribute("shtInfoId", shtInfoId);
		model.addAttribute("raterList", raterList);
		model.addAttribute("bddCmpList", bddCmpList);
		model.addAttribute("evalShtInfo", evalShtInfo);
		model.addAttribute("evalResultRtrInfoList", evalResultRtrInfoList);
		
		return "view/evalMng/evalMngIndvResult";
	}
	
	/**
	 * @Method Name : getEvalQnt
	 * @작성일 : 2023. 10. 06.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 정량적 평가지 작성 화면
	 * @return
	 */
	@GetMapping("/qnt/{shtInfoId}/save.do")
	public String getEvalQnt(@PathVariable String shtInfoId, Model model) {
		EvalShtInfoDTO evalQntInfo = evalMngService.findAllEvalScrInfo(shtInfoId,"qnt");
		String shtNm = evalShtInfoMapper.findOneByShtInfoId(shtInfoId).getShtNm();
		
		model.addAttribute("shtNm",shtNm);
		model.addAttribute("evalQntInfo",evalQntInfo);
		
		return "view/evalMng/evalMngQntSave";
	}

	/**
	 * @Method Name : shtScrSaveAjax
	 * @작성일 : 2023. 10. 06.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가지 저장 Ajax
	 * @return : CommonResponse
	 */
	@PostMapping("/sht/scr/save.ajax")
	public @ResponseBody CommonResponse<?> shtScrSaveAjax(@RequestBody EvalShtInfoDTO evalShtInfoSaveDTO) {
		
		Map<String,Object> resultMap = new HashMap<String, Object>();
		String resultMsg = "평가지 등록에 실패했습니다.";
		try {
			resultMap = evalMngService.saveEvalShtList(evalShtInfoSaveDTO);
		}catch (CommonException e) {
			resultMsg = e.getMessage();
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST, resultMsg);
		}
		
		if(!resultMap.isEmpty()) {
			resultMsg = (String)resultMap.get("resultMessage");
		}
		
		return CommonResponse.successToData(resultMap, resultMsg);
	}
	
	/**
	 * @Method Name : shtScrUpdateAjax
	 * @작성일 : 2023. 10. 06.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가지 저장 Ajax
	 * @return : CommonResponse
	 */
	@PostMapping("/sht/scr/update.ajax")
	public @ResponseBody CommonResponse<?> shtScrUpdateAjax(@RequestBody EvalShtInfoDTO evalShtInfoSaveDTO) {
		
		Map<String,Object> resultMap = new HashMap<String, Object>();
		String resultMsg = "평가지 등록에 실패했습니다.";
		try {
			resultMap = evalMngService.updateEvalShtList(evalShtInfoSaveDTO);
		}catch (CommonException e) {
			resultMsg = e.getMessage();
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST, resultMsg);
		}
		
		if(!resultMap.isEmpty()) {
			resultMsg = (String)resultMap.get("resultMessage");
		}
		
		return CommonResponse.successToData(resultMap, resultMsg);
	}
	
	/**
	  * @Method Name : evalCmpSaveAjax
	  * @작성일 : 2023. 10. 20.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 팝업 평가자 목록 저장
	  * @param evalBddCmpList
	  * @return
	  */
	@PostMapping("/rtr/save.ajax")
	public @ResponseBody CommonResponse<?> evalRtrSaveAjax(
															@RequestBody List<EvalRtrList> evalRtrList
														) {
		
		if(evalRtrList.size() == 0) {
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST, "평가자가 한 명도 선택되지 않았습니다.");
		} else if(evalRtrList.size() < 3) {
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST, "최소 3명을 선택해야 합니다.");
		} else if(evalRtrList.size() > 10) {
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST, "최대 10명까지 선택 가능합니다.");
		}
		
		evalMngService.saveRtrList(evalRtrList);
		
		return CommonResponse.ResponseCodeAndMessage(HttpStatus.OK, "평가 대상자 정보가 저장되었습니다.");
	}
	
	/**
	  * @Method Name : raterDelete
	  * @작성일 : 2023. 12. 5.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 평가자 정보 삭제
	  * @param rtrId
	  * @return
	  */
	@GetMapping("/rater/{rtrId}/delete.ajax")
	public @ResponseBody CommonResponse<?> raterDelete(@PathVariable(value = "rtrId", required = true) String rtrId){
		try {
			
		} catch (CommonException ce) {
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST , ce.getMessage());
		}
		
		return CommonResponse.ResponseCodeAndMessage(HttpStatus.OK , "평가자 정보가 삭제되었습니다.");
	}
	
	/**
	  * @Method Name : raterSave
	  * @작성일 : 2023. 12. 5.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 평가자 정보 등록
	  * @param evalShtInfo
	  * @return
	  */
	@PostMapping("/rater/save.ajax")
	public @ResponseBody CommonResponse<?> raterSave(EvalRtr evalRtr) {
		
		ValidateBuilder dtoValidator = new ValidateBuilder(evalRtr);
		dtoValidator.addRule("rtrNm", new ValidateChecker().setRequired())
					.addRule("rtrBrthDt", new ValidateChecker().setRequired().setDate("날짜 입력값이 올바르지 않습니다."))
					.addRule("rtrAgncy", new ValidateChecker().setRequired())
					.addRule("rtrTel", new ValidateChecker().setRequired().setPhone())
					;
		
		ValidateResult dtoValidatorResult = dtoValidator.isValid();
		
		if(!dtoValidatorResult.isSuccess()) {
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST , dtoValidatorResult.getMessage());
		}
		
		try {
			String rtrId = GgitsCommonUtils.getUuid();
			evalRtr.setRtrId(rtrId);
			int dupleChk = evalRtrMapper.findOneEvalRtrDuplChk(evalRtr); 
			if(dupleChk > 0 ) {
				return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST , "중복된 평가자 정보가 존재합니다. 평가자 정보를 확인해 주세요.");
			}
			evalRtrMapper.save(evalRtr);
		} catch (CommonException ce) {
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST , ce.getMessage());
		}
		
		return CommonResponse.ResponseCodeAndMessage(HttpStatus.OK , "평가자 정보가 저장되었습니다.");
	}
	
	@GetMapping("/rater/{rtrId}/update.ajax")
	public @ResponseBody CommonResponse<?> raterUpdate(@PathVariable(value = "rtrId", required = true) String rtrId,EvalRtr evalRtr) {
		
		ValidateBuilder dtoValidator = new ValidateBuilder(evalRtr);
		dtoValidator.addRule("rtrId", new ValidateChecker().setRequired())
					.addRule("rtrNm", new ValidateChecker().setRequired())
					.addRule("rtrBrthDt", new ValidateChecker().setRequired().setDate("날짜 입력값이 올바르지 않습니다."))
					.addRule("rtrAgncy", new ValidateChecker().setRequired())
					.addRule("rtrTel", new ValidateChecker().setRequired().setPhone())
					;
		
		ValidateResult dtoValidatorResult = dtoValidator.isValid();
		
		if(!dtoValidatorResult.isSuccess()) {
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST , dtoValidatorResult.getMessage());
		}
		
		try {
			evalRtr.setRtrId(rtrId);
			int dupleChk = evalRtrMapper.findOneEvalRtrDuplChk(evalRtr); 
			if(dupleChk > 0 ) {
				return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST , "중복된 평가자 정보가 존재합니다. 평가자 정보를 확인해 주세요.");
			}
			evalRtrMapper.update(evalRtr);
		} catch (CommonException ce) {
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST , ce.getMessage());
		}
		
		return CommonResponse.ResponseCodeAndMessage(HttpStatus.OK , "평가자 정보가 수정되었습니다.");
	}
	
	/**
	 * @Method Name : checkRaterList
	 * @작성일 : 2023. 12. 07.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가자 등록 확인 비동기 처리
	 * @param : esPk
	 * @return
	 */
	@GetMapping("/eval/rater/{shtInfoId}/check.ajax")
	public @ResponseBody CommonResponse<?> checkRaterList(@PathVariable(name = "shtInfoId", required = true) String shtInfoId){
		List<Map<String,Object>> evalRtrList = evalRtrListMapper.findAllByShtInfoId(shtInfoId);
		if(evalRtrList.size() == 0) {
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST , "평가자를 먼저 등록해 주세요.");
		}
		return CommonResponse.ResponseCodeAndMessage(HttpStatus.OK , "");
	}
	
	/**
	 * @Method Name : evaluationList
	 * @작성일 : 2023. 9. 20.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가 목록 화면
	 * @param : esPk
	 * @return
	 */
	@GetMapping("/eval/list.do")
	public String evaluationList(Model model, HttpSession session, EvalShtInfo evalShtInfo,
			@RequestParam(name = "shtInfoId", required = true) String shtInfoId,
			@RequestParam(name = "shtNm", required = true) String shtNm
			) {
		
		List<Map<String,Object>> evalRtrList = evalRtrListMapper.findAllByShtInfoId(shtInfoId);
		String rtrId = (String) evalRtrList.get(0).get("rtrId");
		
		String shtType = "qnt";
		
		evalShtInfo.setShtInfoId(shtInfoId);
		
		int pageSize = 3;
		int pageNo = evalShtInfo.getPageNo();
		int offset = (pageNo - 1) * pageSize;
		evalShtInfo.setPageNo(offset);

	
		List<EvalBddCmpEvalListDto> evalBddCmpList = raterService.findAllBddCmpByShtInfoIdOrderByCmpNbr(evalShtInfo,
				rtrId, shtType);
		
		int totalCnt = raterService.countAllEvalShtInfoList(shtInfoId);

		Paging paging = new Paging();
		paging.setPageSize(pageSize);
		paging.setPageNo(pageNo);
		paging.setTotalCount(totalCnt);

		model.addAttribute("finishCnt", evalRtrShtMapper.counAllByshtTypeAndShtInfoIdAndRtrIdAndShtStts(shtType,
				shtInfoId, rtrId, EvalRtrShtSttsCd.EVAL_COMPLETE.getCode()));
		model.addAttribute("evalBddCmpList", evalBddCmpList);
		model.addAttribute("paging", paging);
		model.addAttribute("shtInfoId", shtInfoId);
		model.addAttribute("shtNm", shtNm);
		model.addAttribute("qntMaxScr", evalShtMapper.findOneMaxQntScrByShtInfoId(shtInfoId));

		session.setAttribute("shtInfoSession", evalShtInfo);
		
		return "view/evalMng/evaluationList";
	}
	
	/**
	 * @Method Name : getEvalQlt
	 * @작성일 : 2023. 10. 26.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 정성적 / 정량적 평가지 작성 화면
	 * @return
	 */
	@GetMapping("/admin/{shtInfoId}/save.do")
	public String getEvalSht(@PathVariable(value = "shtInfoId", required = true) String shtInfoId,
			EvalBddCmp evalBddCmp,
							Model model, HttpSession session) {


		// 평가지 정보
		EvalShtInfoDTO evalShtInfoDTO = evalMngService.findAllEvalScrInfo(shtInfoId, "qnt");
		
		evalShtInfoDTO.setSaveType("save");
		int totalScr = 0;
		int totalScrCount = 0;
		
		for (EvalShtSctrInfo evalShtSctrInfo : evalShtInfoDTO.getEvalShtSctrList()) {
			for (EvalShtItemInfo evalShtItemInfo : evalShtSctrInfo.getEvalShtItemList()) {
				totalScrCount++;
				EvalShtQntScr evalShtQntScr = evalShtItemInfo.getEvalShtQntScrInfo();
				totalScr += evalShtQntScr.getFldScr();
			}
		}
		
		model.addAttribute("totalScr", totalScr);
		model.addAttribute("totalScrCount", totalScrCount);
		
		// 정량적 평가지
		model.addAttribute("evalBddCmp", evalBddCmp);
		model.addAttribute("evalQntInfo", evalShtInfoDTO);
		return "view/evalMng/evaluationQntSave";
	}
	
	/**
	 * @Method Name : evaluationSaveAjax
	 * @작성일 : 2023. 9. 22.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가점수 저장 비동기 처리
	 * @return
	 */
	@PostMapping("/eval/{shtInfoId}/save.ajax")
	public @ResponseBody CommonResponse<?> evaluationSaveAjax(@RequestBody EvalRaterScrDTO evalRaterScrDTO,
			@PathVariable(value = "shtInfoId", required = true) String shtInfoId,
			@RequestParam(name = "bddCmpId", required = true) String bddCmpId,
			Model model,
			HttpSession session) {
		
		for (EvalRtrItemScr evalRtrItemScr : evalRaterScrDTO.getEvalRtrItemScrList()) {

			ValidateBuilder dtoValidator = new ValidateBuilder(evalRtrItemScr);
			dtoValidator.addRule("shtItmId", new ValidateChecker().setRequired()).addRule("scr",
					new ValidateChecker().setRequired());
			ValidateResult dtoValidatorResult = dtoValidator.isValid();

			if (!dtoValidatorResult.isSuccess()) {
				return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST, dtoValidatorResult.getMessage());
			}
		}
		
		EvalShtInfo evalShtInfo = new EvalShtInfo();
		evalShtInfo.setShtInfoId(shtInfoId);
		
		// 모든 평가자 리스트
		List<Map<String,Object>> evalRtrList = evalRtrListMapper.findAllByShtInfoId(shtInfoId);
		
		// 모든 평가지 리스트
		List<EvalRtrSht> evalRtrShtList = evalRtrShtMapper.findAllJoinEvalShtByShtTypeAndBddCmpIdAndShtInfoId("qnt", bddCmpId, shtInfoId);
		
		String saveType = evalRaterScrDTO.getSaveType();

		// 저장할 평가 점수
		List<EvalRtrItemScr> evalRtrItemScrs  = evalRaterScrDTO.getEvalRtrItemScrList();
		
		// 점수 저장 및 평가지 상태 코드 변경
		if (saveType.equals("update")) {
//
//			// 점수 저장
//			for(EvalRtrSht evalRtrSht : evalRtrShtList) {
//				String rtrShtId = evalRtrSht.getRtrShtId();
//				for(int i = 0; i < evalRtrItemScrs.size(); i++) {
//					evalRtrItemScrs.get(i).setRtrShtId(rtrShtId);
//				}
//				raterService.updateRtrScr(evalRtrItemScrs);
//			}
//			
//			// 평가 상태 코드 변경
//			for(Map<String,Object> evalRtr : evalRtrList) {
//				raterService.updateAllStts(shtInfoId, (String)evalRtr.get("rtrId"));
//			}
//			session.removeAttribute("shtInfoSession");
//			return CommonResponse.ResponseCodeAndMessage(HttpStatus.OK, "평가가 완료되었습니다.");

		} else if (saveType.equals("save")) {
				
			// 점수 저장
			for(EvalRtrSht evalRtrSht : evalRtrShtList) {
				String rtrShtId = evalRtrSht.getRtrShtId();
				for(int i = 0; i < evalRtrItemScrs.size(); i++) {
					evalRtrItemScrs.get(i).setRtrShtId(rtrShtId);
				}
				raterService.saveRtrScr(evalRtrItemScrs);
			}
			
			// 평가 상태 코드 변경
			for(Map<String,Object> evalRtr : evalRtrList) {
				raterService.updateAllStts(shtInfoId, (String)evalRtr.get("rtrId"));
			}
			
			session.removeAttribute("shtInfoSession");
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.OK, "평가가 완료되었습니다.");

		} else if (saveType.equals("tmp")) {
//			// 점수 저장
//			for(EvalRtrSht evalRtrSht : evalRtrShtList) {
//				String rtrShtId = evalRtrSht.getRtrShtId();
//				for(int i = 0; i < evalRtrItemScrs.size(); i++) {
//					evalRtrItemScrs.get(i).setRtrShtId(rtrShtId);
//				}
//				raterService.saveRtrScrTmp(evalRtrItemScrs);
//			}
//			
//			// 평가 상태 코드 변경
//			for(Map<String,Object> evalRtr : evalRtrList) {
//				raterService.updateAllStts(shtInfoId, (String)evalRtr.get("rtrId"));
//			}
//			
//			return CommonResponse.ResponseCodeAndMessage(HttpStatus.OK, "임시 저장되었습니다.");
		}

		return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST, "잘못된 접근 입니다.");
	}
	
}
