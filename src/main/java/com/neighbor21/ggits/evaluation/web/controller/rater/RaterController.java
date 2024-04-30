package com.neighbor21.ggits.evaluation.web.controller.rater;

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

import com.neighbor21.ggits.evaluation.common.component.validate.ValidateBuilder;
import com.neighbor21.ggits.evaluation.common.component.validate.ValidateChecker;
import com.neighbor21.ggits.evaluation.common.component.validate.ValidateResult;
import com.neighbor21.ggits.evaluation.common.dto.EvalBddCmpEvalListDto;
import com.neighbor21.ggits.evaluation.common.dto.EvalRaterScrDTO;
import com.neighbor21.ggits.evaluation.common.dto.EvalShtInfoDTO;
import com.neighbor21.ggits.evaluation.common.dto.EvalShtInfoDTO.EvalShtSctrInfo;
import com.neighbor21.ggits.evaluation.common.dto.EvalShtInfoDTO.EvalShtSctrInfo.EvalShtItemInfo;
import com.neighbor21.ggits.evaluation.common.entity.CommonResponse;
import com.neighbor21.ggits.evaluation.common.entity.EvalFile;
import com.neighbor21.ggits.evaluation.common.entity.EvalRtr;
import com.neighbor21.ggits.evaluation.common.entity.EvalRtrItemScr;
import com.neighbor21.ggits.evaluation.common.entity.EvalRtrSht;
import com.neighbor21.ggits.evaluation.common.entity.EvalShtInfo;
import com.neighbor21.ggits.evaluation.common.entity.Paging;
import com.neighbor21.ggits.evaluation.common.enums.EvalRtrShtSttsCd;
import com.neighbor21.ggits.evaluation.common.enums.EvalSttsCd;
import com.neighbor21.ggits.evaluation.common.enums.FileTypeCd;
import com.neighbor21.ggits.evaluation.common.mapper.EvalFileMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalRtrListMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalRtrShtMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalShtInfoMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalShtItemMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalShtMapper;
import com.neighbor21.ggits.evaluation.common.util.GgitsCommonUtils;
import com.neighbor21.ggits.evaluation.web.service.evalmng.EvalMngService;
import com.neighbor21.ggits.evaluation.web.service.rater.RaterService;

@Controller
@RequestMapping("rater")
public class RaterController {

	@Autowired
	RaterService raterService;

	@Autowired
	EvalMngService evalMngService;

	@Autowired
	EvalFileMapper evalFileMapper;

	@Autowired
	EvalRtrShtMapper evalRtrShtMapper;
	
	@Autowired
	EvalRtrListMapper evalRtrListMapper;
	
	@Autowired
	EvalShtInfoMapper evalShtInfoMapper;
	
	@Autowired
	EvalShtMapper evalShtMapper;
	
	@Autowired
	EvalShtItemMapper evalShtItemMapper;

	/**
	 * @Method Name : entercodeCheck
	 * @작성일 : 2023. 9. 20.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 참여코드 입력 화면
	 * @return
	 */
	@GetMapping("/code/check.do")
	public String entercodeCheck(HttpSession session) {
		return "view/rater/accssCd";
	}

	/**
	 * @Method Name : entercodeCheckAjax
	 * @작성일 : 2023. 9. 20.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 참여코드 입력 체크 비동기 호출
	 * @return : CommonResponse
	 */
	@PostMapping("/code/check.ajax")
	public @ResponseBody CommonResponse<?> entercodeCheckAjax(EvalShtInfo evalShtInfoCheck, HttpSession session) {

		ValidateBuilder dtoValidator = new ValidateBuilder(evalShtInfoCheck);
		dtoValidator.addRule("accssCd", new ValidateChecker().setRequired());
		ValidateResult dtoValidatorResult = dtoValidator.isValid();

		if (!dtoValidatorResult.isSuccess()) {
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST, dtoValidatorResult.getMessage());
		}

		EvalShtInfo evalShtInfo = raterService.findOneEvalShtInfoIdByAccssCd(evalShtInfoCheck.getAccssCd());
		if (GgitsCommonUtils.isNull(evalShtInfo)) {
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST, "일치하는 참여 코드가 없습니다.");
		}
		
		if(evalRtrListMapper.countAllByShtInfoId(evalShtInfo.getShtInfoId()) < 1) {
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST, "등록된 평가자가 없습니다.");
		}
		
		String shtAllStts = evalShtInfo.getShtAllStts();

		if (GgitsCommonUtils.isNull(evalShtInfo.getShtInfoId())) {
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST, "일치하는 참여 코드가 없습니다.");
		} else if (
				!(shtAllStts.equals(EvalSttsCd.EVAL_WAITING.getCode())
				|| shtAllStts.equals(EvalSttsCd.EVAL_PROGRESS.getCode())
				|| shtAllStts.equals(EvalSttsCd.EVAL_COMPLETE.getCode())
				|| shtAllStts.equals(EvalSttsCd.EVAL_SCORE_GRADING.getCode())
				)) {
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST, "평가 가능한 평가지가 아닙니다.");
		}

		session.setAttribute("shtInfoSession", evalShtInfo);
		// 세션 유지 시간 최대 30분
		session.setMaxInactiveInterval(1800);

		return CommonResponse.ResponseCodeAndMessage(HttpStatus.OK, "평가 참여 코드가 확인되었습니다.");
	}

	/**
	 * @Method Name : infoSave
	 * @작성일 : 2023. 9. 20.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가자 정보 확인 화면
	 * @return
	 */
	@GetMapping("/info/save.do")
	public String infoSave(Model model) {
		return "view/rater/selectRater";
	}

	/**
	 * @Method Name : infoCheckAjax
	 * @작성일 : 2023. 9. 20.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가자정보 입력값 확인 비동기 호출
	 * @return : CommonResponse
	 */
	@PostMapping("/info/check.ajax")
	public @ResponseBody CommonResponse<?> infoCheckAjax(EvalRtr evalRtrCheck, HttpSession session) {
		
		ValidateBuilder dtoValidator = new ValidateBuilder(evalRtrCheck);
		dtoValidator.addRule("rtrNm", new ValidateChecker().setRequired())
					.addRule("rtrBrthDt", new ValidateChecker().setRequired());
		ValidateResult dtoValidatorResult = dtoValidator.isValid();
		
		if (!dtoValidatorResult.isSuccess()) {
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST, dtoValidatorResult.getMessage());
		}
		
		try {
			String shtInfoId = ((EvalShtInfo) session.getAttribute("shtInfoSession")).getShtInfoId();
			evalRtrCheck.setShtInfoId(shtInfoId);
			
			EvalRtr evalRtrInfo = raterService.findOneEvalShtInfoByBirtDt(evalRtrCheck);

			if (GgitsCommonUtils.isNull(evalRtrInfo)) {
				return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST, "평가자 이름, 생년월일 정보가 일치하지 않습니다.");
			}

			session.setAttribute("rtrInfoSession", evalRtrInfo);
			// 세션 유지 시간 최대 30분
			session.setMaxInactiveInterval(1800);

		} catch (Exception e) {
			return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST, "생년월일 형식에 맞춰서 입력해 주세요.");
		}

		return CommonResponse.ResponseCodeAndMessage(HttpStatus.OK, "생년월일이 확인되었습니다.");

	}

	/**
	 * @Method Name : announcementDetail
	 * @작성일 : 2023. 9. 20.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가자 정보 최종 확인 및 공고 정보 확인 화면
	 * @return
	 */
	@GetMapping("/announcement/detail.do")
	public String announcementDetail(Model model, HttpSession session) {

		String shtInfoId = ((EvalShtInfo) session.getAttribute("shtInfoSession")).getShtInfoId();
		EvalShtInfo evalShtInfoDetail = raterService.findOneEvalShtInfoByShtInfoId(shtInfoId);

		EvalFile evalFile = new EvalFile();
		evalFile.setShtInfoId(shtInfoId);

		evalFile.setFileType(FileTypeCd.REQUEST_FOR_PROPOSAL.getFileCode());
		List<EvalFile> requestFileList = evalFileMapper.findAllByShtInfoIdAndFileType(evalFile);

		evalFile.setFileType(FileTypeCd.PROPOSALS.getFileCode());
		List<EvalFile> proposalFileList = evalFileMapper.findAllByShtInfoIdAndFileType(evalFile);
		
		evalFile.setFileType(FileTypeCd.PRESENTATION_DOC.getFileCode());
		List<EvalFile> presentationDocFileList = evalFileMapper.findAllByShtInfoIdAndFileType(evalFile);

		model.addAttribute("evalShtInfoDetail", evalShtInfoDetail);
		model.addAttribute("requestFileList", requestFileList);
		model.addAttribute("proposalFileList", proposalFileList);
		model.addAttribute("presentationDocFileList", presentationDocFileList);

		return "view/rater/checkEvalInfo";
	}

	/**
	 * @Method Name : evaluationList
	 * @작성일 : 2023. 9. 20.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가 목록 화면
	 * @param : esPk
	 * @return
	 */
	@GetMapping("/evaluation/list.do")
	public String evaluationList(Model model, HttpSession session, EvalShtInfo evalShtInfo) {

		String shtInfoId = ((EvalShtInfo) session.getAttribute("shtInfoSession")).getShtInfoId();
		String rtrId = ((EvalRtr) session.getAttribute("rtrInfoSession")).getRtrId();
		String shtType = "qlt";
		
		evalShtInfo.setShtInfoId(shtInfoId);
		
		String shtAllStts = evalShtInfoMapper.findOneByShtInfoId(shtInfoId).getShtAllStts();
		
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
//		model.addAttribute("qltMaxScr", evalShtMapper.findOneMaxQntScrByShtInfoId(shtInfoId));
		model.addAttribute("qltMaxScr", evalShtMapper.findOneMaxQltScrByShtInfoId(shtInfoId));
		model.addAttribute("shtAllStts", shtAllStts);

		return "view/rater/evaluationList";
	}

	/**
	 * @Method Name : getEvalQlt
	 * @작성일 : 2023. 10. 26.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 정성적 / 정량적 평가지 작성 화면
	 * @return
	 */
	@GetMapping("/evaluation/{shtType}/save.do")
	public String getEvalSht(@RequestParam(name = "rtrShtId", required = true) String rtrShtId,
							@RequestParam(name = "bddCmpNm", required = true) String bddCmpNm, 
							@PathVariable String shtType,
							Model model, HttpSession session) {
		// 평가지 정보
		String shtInfoId = ((EvalShtInfo) session.getAttribute("shtInfoSession")).getShtInfoId();
		String shtAllStts = evalShtInfoMapper.findOneByShtInfoId(shtInfoId).getShtAllStts();
		
		// 평가지 문항, 배점 정보
		EvalShtInfoDTO evalShtInfoDTO = evalMngService.findAllEvalScrInfo(shtInfoId, shtType);

		// 평가자 점수 DB에 존재 하는지 확인
		List<EvalRtrItemScr> evalRtrSctrScrs = raterService.findAllRtrItemScrJoinRtrShtByRtrShtId(rtrShtId);

		List<EvalRtrSht> evalRtrShtList = evalRtrShtMapper.findAllRtrShtByRtrShtId(rtrShtId);
		String signFileId = evalRtrShtList.get(0).getFileId();
		model.addAttribute("signFileId", signFileId);
		
		// 파일 조회
		EvalFile evalFile = new EvalFile();
		evalFile.setShtInfoId(shtInfoId);
		
		evalFile.setFileType(FileTypeCd.REQUEST_FOR_PROPOSAL.getFileCode());
		List<EvalFile> requestFileList = evalFileMapper.findAllByShtInfoIdAndFileType(evalFile);
		
		// 해당 기업 파일 조회
		evalFile.setFileOgnNm(bddCmpNm + "_%");
		evalFile.setFileType(FileTypeCd.PROPOSALS.getFileCode());
		List<EvalFile> proposalFileList = evalFileMapper.findAllByShtInfoIdAndFileType(evalFile);
		
		evalFile.setFileType(FileTypeCd.PRESENTATION_DOC.getFileCode());
		List<EvalFile> presentationDocFileList = evalFileMapper.findAllByShtInfoIdAndFileType(evalFile);
		// 평가 완료인 경우 - 평가 점수 확인 페이지 삭제로 주석
//		if (evalRtrSctrScrs.size() > 0) {
//			String shtStts = evalRtrShtList.get(0).getShtStts();
			
//			if (shtStts.equals(EvalRtrShtSttsCd.EVAL_COMPLETE.getCode())) {
//				Boolean isEvalComplete = true;
//				EvalRaterScrDTO evalRaterScrDTO = new EvalRaterScrDTO();
//				List<ConfirmScrInfo> confirmScrInfoList = new ArrayList<>();
//				List<EvalShtInfoDTO.EvalShtSctrInfo> evalShtSctrList = evalShtInfoDTO.getEvalShtSctrList();
//				int totalMaxScr = 0;
//				int totalScr = 0;
//				for (int i = 0; i < evalShtSctrList.size(); i++) {
//					
//					EvalShtInfoDTO.EvalShtSctrInfo evalShtSctrInfo = evalShtSctrList.get(i);
//					EvalRaterScrDTO.ConfirmScrInfo confirmScrInfo = new ConfirmScrInfo();
//					String fldSctr = ""; //평가지 부문 이름
//					int scr = 0; 
//					int maxScr = 0; // 평가지 부문 최대 배점
//					fldSctr = evalShtSctrInfo.getFldSctr();
//
//					if (shtType.equals("qnt")) {
//						for(EvalShtItemInfo evalShtItemList : evalShtSctrInfo.getEvalShtItemList()) {
//							// 부문 총점
//							maxScr += evalShtItemList.getEvalShtQntScrList().get(0).getScr();
//							String shtItmId = evalShtItemList.getShtItmId();
//							for(EvalRtrItemScr evalRtrItemScr: evalRtrSctrScrs) {
//								// 평가자 배점
//								if(shtItmId.equals(evalRtrItemScr.getShtItmId())) {
//									scr += evalRtrItemScr.getScr();
//								}
//							}
//						}
//					} else if (shtType.equals("qlt")) {
//						for (EvalShtItemInfo evalShtItemList : evalShtSctrInfo.getEvalShtItemList()) {
//							// 부문 총점
//							maxScr += evalShtItemList.getEvalShtQltScrInfo().getFldScr();
//							String shtItmId = evalShtItemList.getEvalShtQltScrInfo().getShtItmId();
//							for(EvalRtrItemScr evalRtrItemScr: evalRtrSctrScrs) {
//								// 평가자 배점
//								if(shtItmId.equals(evalRtrItemScr.getShtItmId())) {
//									scr += evalRtrItemScr.getScr();
//								}
//							}
//						}
//					}
//					totalMaxScr += maxScr;
//					totalScr += scr;
//					confirmScrInfo.setFldSctr(fldSctr);
//					confirmScrInfo.setScr(scr);
//					confirmScrInfo.setMaxScr(maxScr);
//					confirmScrInfoList.add(confirmScrInfo);
//				}
//				evalRaterScrDTO.setTotalScr(totalScr);
//				evalRaterScrDTO.setTotalMaxScr(totalMaxScr);
//				evalRaterScrDTO.setConfirmScrInfoList(confirmScrInfoList);
//
//				model.addAttribute("bddCmpNm", bddCmpNm);
//				model.addAttribute("isEvalComplete", isEvalComplete);
//				session.setAttribute("evalRaterScrDTOSession", evalRaterScrDTO);
//				return "view/rater/evaluationConfirm";
//			}
//		}

		if (evalRtrSctrScrs.size() < 1) {
			evalShtInfoDTO.setSaveType("save");
		}

		model.addAttribute("rtrShtId", rtrShtId);
		model.addAttribute("bddCmpNm", bddCmpNm);
		model.addAttribute("evalRtrSctrScrs", evalRtrSctrScrs);

		if (shtType.equals("qnt")) {
			// 정량적 평가지
			model.addAttribute("evalQntInfo", evalShtInfoDTO);
			return "view/rater/evaluationQntSave";
		} else {
			// 정성적 평가지
			int totalScr = 0;
			int totalScrCount = 0;

			for (EvalShtSctrInfo evalShtSctrInfo : evalShtInfoDTO.getEvalShtSctrList()) {
				for (EvalShtItemInfo evalShtItemInfo : evalShtSctrInfo.getEvalShtItemList()) {
					totalScrCount++;
//					for(EvalShtQltScr evalShtQltScr : evalShtItemInfo.getEvalShtQltScrList()) {
//						totalScr += evalShtQltScr.getScr(); 
//					}
					totalScr += evalShtItemInfo.getEvalShtQltScrList().get(0).getScr();
				}
			}

			model.addAttribute("totalScr", totalScr);
			model.addAttribute("totalScrCount", totalScrCount);
			model.addAttribute("shtAllStts", shtAllStts);
			model.addAttribute("evalQltInfo", evalShtInfoDTO);
			
			model.addAttribute("requestFileList", requestFileList);
			model.addAttribute("proposalFileList", proposalFileList);
			model.addAttribute("presentationDocFileList", presentationDocFileList);
			return "view/rater/evaluationQltSave";
		}

	}

	/**
	 * @Method Name : evaluationCheckAjax
	 * @작성일 : 2023. 9. 22.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가점수 입력 값 Validation check 비동기 호출
	 * @return
	 */
	@PostMapping("/evaluation/check.ajax")
	public @ResponseBody CommonResponse<?> evaluationCheckAjax(@RequestBody EvalRaterScrDTO evalRaterScrDTO,
			Model model, HttpSession session) {

		for (EvalRtrItemScr evalRtrItemScr : evalRaterScrDTO.getEvalRtrItemScrList()) {

			ValidateBuilder dtoValidator = new ValidateBuilder(evalRtrItemScr);
			dtoValidator.addRule("shtItmId", new ValidateChecker()
						.setRequired()).addRule("scr", new ValidateChecker().setRequired())
						;
			ValidateResult dtoValidatorResult = dtoValidator.isValid();

			if (!dtoValidatorResult.isSuccess()) {
				return CommonResponse.ResponseCodeAndMessage(HttpStatus.BAD_REQUEST, dtoValidatorResult.getMessage());
			}
		}

		session.setAttribute("rtrItemScrsSession", evalRaterScrDTO.getEvalRtrItemScrList());

		session.setAttribute("evalRaterScrDTOSession", evalRaterScrDTO);

		return CommonResponse.ResponseCodeAndMessage(HttpStatus.OK, "평가 점수가 정상적으로 입력되었습니다.");
	}

	/**
	 * @Method Name : evaluationConfirm
	 * @작성일 : 2023. 9. 22.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가점수 최종 확인 화면
	 * @return
	 */
	@GetMapping("/evaluation/{saveType}/confirm.do")
	public String evaluationConfirm(@RequestParam(name = "bddCmpNbr", required = true) String bddCmpNbr, Model model,
			HttpSession session, @PathVariable String saveType) {
		model.addAttribute("saveType", saveType);
		model.addAttribute("bddCmpNbr", bddCmpNbr);

		return "view/rater/evaluationConfirm";
	}

	/**
	 * @Method Name : evaluationSaveAjax
	 * @작성일 : 2023. 9. 22.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가점수 저장 비동기 처리
	 * @return
	 */
	@PostMapping("/evaluation/save.ajax")
	public @ResponseBody CommonResponse<?> evaluationSaveAjax(@RequestBody EvalRaterScrDTO evalRaterScrDTO, Model model,
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
		
		Map<String,Object> resultMap = new HashMap<>();
		boolean isEvalCmplt = false;
		String message = "평가가 완료되었습니다.";
		
		String shtInfoId = ((EvalShtInfo) session.getAttribute("shtInfoSession")).getShtInfoId();
		String rtrId = ((EvalRtr) session.getAttribute("rtrInfoSession")).getRtrId();
		String saveType = evalRaterScrDTO.getSaveType();

		List<EvalRtrItemScr> evaltrItemScrs  = evalRaterScrDTO.getEvalRtrItemScrList();
		// 점수 저장 및 평가지 상태 코드 변경
		if (saveType.equals("update")) {
			raterService.updateRtrScr(evaltrItemScrs);
			
			EvalShtInfo evalShtInfo = evalShtInfoMapper.findOneByShtInfoId(shtInfoId);
			
			if(!(evalShtInfo.getShtAllStts().equals(EvalSttsCd.EVAL_SCORE_GRADING.getCode()))) {
				// 평가 상태 코드 변경
				raterService.updateAllStts(shtInfoId, rtrId);
				session.removeAttribute("rtrItemScrsSession");
				session.removeAttribute("evalRaterScrDTOSession");
				
				// 모든 평가 완료 확인
				if(evalRtrShtMapper.counAllByshtTypeAndShtInfoIdAndRtrIdAndShtStts("qlt",
						shtInfoId, rtrId, EvalRtrShtSttsCd.EVAL_WAITING.getCode()) == 0) {
					isEvalCmplt = true;
					message = "모든 평가가 완료되었습니다.";
				}
				
			}
			
			resultMap.put("isEvalCmplt", isEvalCmplt);
			resultMap.put("shtInfoId", shtInfoId);
			resultMap.put("rtrId", rtrId);
			resultMap.put("resultCode", HttpStatus.OK);
			
			return CommonResponse.successToData(resultMap, message);

		} else if (saveType.equals("save")) {
			raterService.saveRtrScr(evaltrItemScrs);

			// 평가 상태 변경
			raterService.updateAllStts(shtInfoId, rtrId);
			session.removeAttribute("rtrItemScrsSession");
			session.removeAttribute("evalRaterScrDTOSession");
			
			// 모든 평가 완료 확인
			if(evalRtrShtMapper.counAllByshtTypeAndShtInfoIdAndRtrIdAndShtStts("qlt",
					shtInfoId, rtrId, EvalRtrShtSttsCd.EVAL_WAITING.getCode()) == 0) {
				isEvalCmplt = true;
				message = "모든 평가가 완료되었습니다.";
			}

			resultMap.put("isEvalCmplt", isEvalCmplt);
			resultMap.put("shtInfoId", shtInfoId);
			resultMap.put("rtrId", rtrId);
			resultMap.put("resultCode", HttpStatus.OK);
			
			return CommonResponse.successToData(resultMap, message);
			
		} else if (saveType.equals("tmp")) {
			raterService.saveRtrScrTmp(evaltrItemScrs);
			raterService.updateAllStts(shtInfoId, rtrId);
			
			resultMap.put("isEvalCmplt", isEvalCmplt);
			resultMap.put("resultCode", HttpStatus.OK);
			
			message = "임시저장되었습니다.";
			return CommonResponse.successToData(resultMap, message);
		}

		message = "잘못된 접근 입니다.";
		resultMap.put("resultCode", HttpStatus.BAD_REQUEST);
		return CommonResponse.successToData(resultMap, message);
	}
	
	/**
	 * @Method Name : evaluationResult
	 * @작성일 : 2024.01. 05.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가 완료페이지 이동
	 * @return
	 */
	@GetMapping("/evaluation/result.do")
	String evaluationResult(@RequestParam(name = "rtrId", required = true) String rtrId,
			@RequestParam(name = "shtInfoId", required = true) String shtInfoId,
			Model model, HttpSession session) {
		List<Map<String,Object>> totalScrList = evalRtrShtMapper.findAllTotalScr(rtrId, shtInfoId, "qlt");
		int totalMaxScr = evalShtItemMapper.findTotalMaxScrByShtInfoIdAndShtType(shtInfoId, "qlt");
		
		session.invalidate();
		model.addAttribute("totalScrList", totalScrList);
		model.addAttribute("totalMaxScr", totalMaxScr);
		return "view/rater/evaluationResult";
	}

}
