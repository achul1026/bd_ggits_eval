package com.neighbor21.ggits.evaluation.web.controller.common;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.neighbor21.ggits.evaluation.common.component.FileUploadComponent;
import com.neighbor21.ggits.evaluation.common.entity.CommonResponse;
import com.neighbor21.ggits.evaluation.common.entity.EvalFile;
import com.neighbor21.ggits.evaluation.common.entity.EvalRtr;
import com.neighbor21.ggits.evaluation.common.entity.EvalRtrList;
import com.neighbor21.ggits.evaluation.common.entity.EvalRtrSht;
import com.neighbor21.ggits.evaluation.common.entity.EvalSht;
import com.neighbor21.ggits.evaluation.common.entity.EvalShtInfo;
import com.neighbor21.ggits.evaluation.common.entity.Paging;
import com.neighbor21.ggits.evaluation.common.enums.FileTypeCd;
import com.neighbor21.ggits.evaluation.common.mapper.EvalFileMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalRtrMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalRtrShtMapper;
import com.neighbor21.ggits.evaluation.common.mapper.EvalShtMapper;
import com.neighbor21.ggits.evaluation.common.util.GgitsCommonUtils;
import com.neighbor21.ggits.evaluation.support.exception.CommonException;

@Controller
@RequestMapping("/common")
public class CommonController {
	

	@Autowired
	EvalRtrMapper evalRtrMapper;
	
	@Autowired
	EvalFileMapper evalFileMapper;
	
	@Autowired
	EvalShtMapper evalShtMapper;
	
	@Autowired
	EvalRtrShtMapper evalRtrShtMapper;
	
	@Autowired
	FileUploadComponent fileUploadComponent;
	
	/**
	 * @Method Name : modalRaterList
	 * @작성일 : 2023. 9. 5.
	 * @작성자 : NK.KIM
	 * @Method 설명 : 평가자 목록 조회 
	 * @return
	 */
	@GetMapping("/modal/rater/list.do")
	public String modalRaterList(Model model, EvalRtr evalRtr) {
		
		//전체목록 호출
		int pageSize = 5;
		int paramPageNo = evalRtr.getPageNo();
		int pageNo = (evalRtr.getPageNo() - 1) * pageSize;
		evalRtr.setPageNo(pageNo);
		
    	List<EvalRtr> evalRtrList = evalRtrMapper.findAll(evalRtr); 
    	int evalRtrTotalCnt = evalRtrMapper.countAll(evalRtr);

    	Paging modalPaging = new Paging();
    	modalPaging.setPageSize(pageSize);
    	modalPaging.setPageNo(paramPageNo);
    	modalPaging.setTotalCount(evalRtrTotalCnt);
    	
    	model.addAttribute("schRtrNm", evalRtr.getSchRtrNm());
    	model.addAttribute("evalRtrList", evalRtrList);
    	model.addAttribute("modalPaging", modalPaging);
    	model.addAttribute("rtrIdList", evalRtr.getRtrIdList());
    	
    	//모달 하단 등록된 평가자 목록 재호출
		EvalRtr evalRtrChk = new EvalRtr();
		evalRtrChk.setPageNo(null);
		evalRtrChk.setShtInfoId(evalRtr.getShtInfoId());
		List<EvalRtr> modalCheckedList = evalRtrMapper.findAll(evalRtrChk);
		model.addAttribute("modalCheckedList", modalCheckedList);
    	
		return "modal/common/modalRaterList";
	}

	/**
	 * @Method Name : modalSaveRaterList
	 * @작성일 : 2023. 9. 5.
	 * @작성자 : NK.KIM
	 * @Method 설명 : 평가자 목록 조회 
	 * @return
	 */
	@GetMapping("/modal/rater/save/list.do")
	public String modalRaterSaveList(Model model, EvalRtr evalRtr) {
		
		//전체목록 호출
		int pageSize = 5;
		int paramPageNo = evalRtr.getPageNo();
		int pageNo = (evalRtr.getPageNo() - 1) * pageSize;
		evalRtr.setPageNo(pageNo);
		
		List<EvalRtr> evalRtrList = evalRtrMapper.findAll(evalRtr); 
		int evalRtrTotalCnt = evalRtrMapper.countAll(evalRtr);
		
		Paging modalPaging = new Paging();
		modalPaging.setPageSize(pageSize);
		modalPaging.setPageNo(paramPageNo);
		modalPaging.setTotalCount(evalRtrTotalCnt);
		
		model.addAttribute("schRtrNm", evalRtr.getSchRtrNm());
		model.addAttribute("evalRtrList", evalRtrList);
		model.addAttribute("modalPaging", modalPaging);
		model.addAttribute("rtrIdList", evalRtr.getRtrIdList());
		
		//모달 하단 등록된 평가자 목록 재호출
		EvalRtr evalRtrChk = new EvalRtr();
		evalRtrChk.setPageNo(null);
		evalRtrChk.setShtInfoId(evalRtr.getShtInfoId());
		List<EvalRtr> modalCheckedList = evalRtrMapper.findAll(evalRtrChk);
		model.addAttribute("modalCheckedList", modalCheckedList);
		
		return "modal/common/modalRaterSaveList";
	}
	
	
	/**
	 * @Method Name : modalCodeAdd
	 * @작성일 : 2023. 9. 5.
	 * @작성자 : NK.KIM
	 * @Method 설명 : 등록된 평가자 목록 조회 
	 * @return
	 */
	@GetMapping("/modal/eval/{shtInfoId}/rater/list.do")
	public String modalEvalRaterList(Model model, 
									@PathVariable(value = "shtInfoId", required = true) String shtInfoId,
									EvalRtrList evalRtrListInfo) {
		String evalCmplt = "all";
		if(!GgitsCommonUtils.isNull(evalRtrListInfo.getEvalCmplt())) {
			evalCmplt = evalRtrListInfo.getEvalCmplt();
		}
		List<EvalRtr> evalRtrList = evalRtrMapper.findAllJoinEvalRtrList(evalRtrListInfo); 
		model.addAttribute("evalRtrList", evalRtrList);
		model.addAttribute("shtInfoId", shtInfoId);
		model.addAttribute("evalCmplt", evalCmplt);
		
		return "modal/common/modalEvalRaterList";
	}
	
	/**
	  * @Method Name : evalInfoDelete
	  * @작성일 : 2023. 10. 19.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 평가지 작성 정보 삭제
	  * @param shtInfoId
	  * @return
	  */
	@GetMapping("/file/{fileId}/delete.ajax")
	public @ResponseBody CommonResponse<?> evalInfoDelete(@PathVariable(value = "fileId", required = true) String fileId){
		
		EvalFile evalFile = evalFileMapper.findOneByFileId(fileId);
		fileUploadComponent.deleteFile(evalFile);
		evalFileMapper.deleteByFileId(fileId);
		
		return CommonResponse.ResponseCodeAndMessage(HttpStatus.OK , "파일이 삭제되었습니다.");
	}
	
	/**
	 * @Method Name : evalInfoDelete
	 * @작성일 : 2023. 10. 19.
	 * @작성자 : NK.KIM
	 * @Method 설명 : 평가지 작성 정보 삭제
	 * @param shtInfoId
	 * @return
	 */
	@GetMapping("/file/{fileId}/view.ajax")
	public void evalInfoView(@PathVariable(value = "fileId", required = true) String fileId,HttpServletResponse response){
		
		EvalFile evalFile = evalFileMapper.findOneByFileId(fileId);
		String filePath = evalFile.getFilePath() + File.separator + evalFile.getFileNm();
		File evalFileInfo = new File(filePath);
		
		byte[] fileByte;
		
		try {
			fileByte = FileUtils.readFileToByteArray(evalFileInfo);
			response.setContentType("application/pdf");
			response.setContentLength(fileByte.length);
			String fileName = URLEncoder.encode(evalFile.getFileOgnNm(), "UTF-8");
			response.setHeader("Content-Disposition", "inline; fileName=\""+fileName+"\"");
			response.getOutputStream().write(fileByte);
			response.getOutputStream().flush();
			response.getOutputStream().close();
		} catch (IOException e) {
			
			e.printStackTrace();
		}
	}
	/**
	 * @Method Name : evalInfoDelete
	 * @작성일 : 2023. 10. 19.
	 * @작성자 : NK.KIM
	 * @Method 설명 : 평가지 작성 정보 삭제
	 * @param shtInfoId
	 * @return
	 */
	@GetMapping("/file/{fileId}/download.ajax")
	public void evalInfoDownload(@PathVariable(value = "fileId", required = true) String fileId,HttpServletResponse response){
		
		EvalFile evalFile = evalFileMapper.findOneByFileId(fileId);
		String filePath = evalFile.getFilePath() + File.separator + evalFile.getFileNm();
		File evalFileInfo = new File(filePath);
		
		byte[] fileByte;
		
		try {
			fileByte = FileUtils.readFileToByteArray(evalFileInfo);
			response.setContentType("application/pdf");
			response.setContentLength(fileByte.length);
			String fileName = URLEncoder.encode(evalFile.getFileOgnNm(), "UTF-8");
			response.setHeader("Content-Disposition", "attachment; fileName=\""+fileName+"\"");
			response.getOutputStream().write(fileByte);
			response.getOutputStream().flush();
			response.getOutputStream().close();
		} catch (IOException e) {
			
			e.printStackTrace();
		}
		
	}
	
	@GetMapping("/sample/file/download.ajax")
	public void sampleFileDownload(HttpServletResponse response,@RequestParam(name = "fileName", required = true) String fileName) throws IOException{
		fileUploadComponent.sampleFileDownload(response, fileName);
	}
	
	@PostMapping("/csv/file/upload.ajax")
	public @ResponseBody CommonResponse<?> csvFileUpload(@RequestParam(name = "file" ,required = true) MultipartFile uploadFile
														 ,@RequestParam(name="shtInfoId" ,required = true) String shtInfoId
														 ,@RequestParam(name="shtId" ,required = true) String shtId
														 ,@RequestParam(name="shtType" ,required = true) String shtType) {
		
		Map<String,Object> resultMap = new HashMap<String, Object>();
		try {
			fileUploadComponent.saveCsvFileInfo(uploadFile,shtInfoId,shtId,shtType);
			resultMap.put("message", "입력하신 파일 정보가 정상적으로 업로드 되었습니다.");
		}catch (CommonException e) {
			resultMap.put("message", e.getMessage());
			resultMap.put("code", e.getErrorCode());
		}
		return CommonResponse.successToData(resultMap, "정상적으로 입력 되었습니다.");
	}
	
	@PostMapping("/sign/upload.ajax")
	public @ResponseBody CommonResponse<?> signFileUpload(
															@RequestParam(name = "file" ,required = true) MultipartFile uploadFile,
															@RequestParam(name = "shtInfoId" ,required = true) String shtInfoId,
															@RequestParam(name = "rtrShtId" ,required = true) String rtrShtId
															) {
		
		Map<String,Object> resultMap = new HashMap<>();
		String message = "서명 완료 되었습니다.";
		try {
			EvalFile evalFile = fileUploadComponent.getEvalFileInfo(uploadFile, shtInfoId, FileTypeCd.RATER_SIGN,"");
			fileUploadComponent.uploadFile(uploadFile, evalFile);
			evalFileMapper.save(evalFile);
			
			//eval_rtr_sht file 정보 update
			EvalRtrSht evalRtrSht = new EvalRtrSht();
			evalRtrSht.setFileId(evalFile.getFileId());
			evalRtrSht.setRtrShtId(rtrShtId);
			evalRtrShtMapper.updateFileIdByRtrShtId(evalRtrSht);
			
			resultMap.put("fileId", evalFile.getFileId());
			resultMap.put("code", HttpStatus.OK);
		}catch (CommonException e) {
			message = e.getMessage();
			resultMap.put("message", e.getMessage());
			resultMap.put("code", e.getErrorCode());
		}
		return CommonResponse.successToData(resultMap, message);
	}
	
	/**
	  * @Method Name : signFileView
	  * @작성일 : 2023. 10. 30.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 서명 이미지 호출
	  * @param response
	  * @param filePath
	  * @param fileNm
	  */
	@GetMapping("/sign/image/view.do")
	public void signFileView(HttpServletResponse response,
			@RequestParam(name = "fileId" ,required = true) String fileId
			)   {
		fileUploadComponent.signImgView(response, fileId);
	}
	
	/**
	 * @Method Name : modalShtSelectList
	 * @작성일 : 2023. 10. 25.
	 * @작성자 : IK.MOON
	 * @Method 설명 : 평가자 > 정령/정성 선택 화면 모달
	 * @param shtInfoId
	 * @return
	 */
	@GetMapping("/modal/{bddCmpId}/list.do")
	public String modalShtSelectList(@RequestParam(name = "bddCmpNm", required = true) String bddCmpNm,
												EvalRtrSht evalRtrSht, Model model, HttpSession session){
		String shtInfoId = ((EvalShtInfo) session.getAttribute("shtInfoSession")).getShtInfoId();
		String rtrId = ((EvalRtr) session.getAttribute("rtrInfoSession")).getRtrId();
		
		evalRtrSht.setRtrId(rtrId);
		List<EvalSht> evalShtList = evalShtMapper.findAllJoinEvalShtInfoByShtInfoId(shtInfoId);
		List<EvalRtrSht> evalRtrShtList = evalRtrShtMapper.findAllJoinEvalShtByBddCmpIdAndRtrId(evalRtrSht);
		
		model.addAttribute("bddCmpNm", bddCmpNm);
		model.addAttribute("evalShtList", evalShtList);
		model.addAttribute("evalRtrShtList", evalRtrShtList);
		
		return "modal/common/modalShtSelectList";
	}
	
	/**
	 * @Method Name : modalPdfView
	 * @작성일 : 2023. 11. 02.
	 * @작성자 : IK.MOON
	 * @Method 설명 : pdf 뷰어 모달
	 * @param fileId
	 * @return
	 */
	@GetMapping("/modal/pdf/view.do")
	public String modalPdfView(Model model,
			@RequestParam(name = "fileId", required = true) String fileId,
			@RequestParam(name = "fileOgnNm", required = true) String fileOgnNm
			){
		model.addAttribute("fileId", fileId);
		model.addAttribute("fileOgnNm", fileOgnNm);
		return "modal/common/modalPdfViewer";
	}
	
	
//	/**
//	 * @Method Name : modalCmpSave
//	 * @작성일 : 2023. 10. 25.
//	 * @작성자 : IK.MOON
//	 * @Method 설명 : 평가 기업 입력 모달
//	 * @param shtInfoId
//	 * @return
//	 */
//	@GetMapping("/modal/cmp/save.do")
//	public String modalCmpSave(){
//		
//		return "modal/common/modalCmpSave";
//	}
}
