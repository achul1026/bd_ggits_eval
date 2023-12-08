package com.neighbor21.ggits.evaluation.common.component;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.text.Normalizer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItem;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.neighbor21.ggits.evaluation.common.dto.EvalFileInfoDTO;
import com.neighbor21.ggits.evaluation.common.dto.EvalShtInfoDTO;
import com.neighbor21.ggits.evaluation.common.dto.EvalShtInfoDTO.EvalShtSctrInfo;
import com.neighbor21.ggits.evaluation.common.dto.EvalShtInfoDTO.EvalShtSctrInfo.EvalShtItemInfo;
import com.neighbor21.ggits.evaluation.common.entity.EvalFile;
import com.neighbor21.ggits.evaluation.common.entity.EvalShtQltScr;
import com.neighbor21.ggits.evaluation.common.entity.EvalShtQntScr;
import com.neighbor21.ggits.evaluation.common.enums.FileTypeCd;
import com.neighbor21.ggits.evaluation.common.mapper.EvalFileMapper;
import com.neighbor21.ggits.evaluation.common.util.BDDateFormatUtil;
import com.neighbor21.ggits.evaluation.common.util.GgitsCommonUtils;
import com.neighbor21.ggits.evaluation.support.exception.CommonException;
import com.neighbor21.ggits.evaluation.support.exception.ErrorCode;
import com.neighbor21.ggits.evaluation.web.service.evalmng.EvalMngService;

@Component
public class FileUploadComponent {
	
	@Value("#{commonProperties['file.upload.path']}")
	public String fileUploadPath;
	
	@Value("#{commonProperties['file.sample.download.path']}")
	public String fileSampleDownloadPath;
	
	@Autowired
	EvalFileMapper evalFileMapper;
	
	@Autowired
	EvalMngService evalMngService;
	/**
     * @Method Name : uploadFileList
     * @작성일 : 2023. 9. 11.
     * @작성자 : KC.KIM
     * @Method 설명 : 리스트 파일 업로드
     * @return
     */
	public void uploadEvalFileList(List<EvalFileInfoDTO> evalFileInfoDTOList) {
		for(EvalFileInfoDTO evalFileInfoDTO : evalFileInfoDTOList) {
			MultipartFile uploadFile = evalFileInfoDTO.getFile();
			if(uploadFile.isEmpty()) {
				continue;
			}
			uploadFile(uploadFile,evalFileInfoDTO.getEvalFile());
		}
	}
	
	/**
     * @Method Name : uploadFile
     * @작성일 : 2023. 9. 11.
     * @작성자 : KC.KIM
     * @Method 설명 : 단일 파일 업로드
     * @return
     */
	public void uploadFile(MultipartFile file,EvalFile evalFile) {
		
		String fileNm = evalFile.getFileNm();
		String uploadPath = evalFile.getFilePath() + File.separator + fileNm; 
		File uploadFile = new File(uploadPath);
		
		try {
			if(!file.isEmpty()) {
                FileOutputStream fo = new FileOutputStream(uploadFile);
                byte[] fileBytes = file.getBytes();
                fo.write(fileBytes);
                fo.close();
                
            }
		} catch (IOException e) {
			e.printStackTrace();
			throw new CommonException(ErrorCode.FILE_UPLOAD_FAIL);
		}
	}
	
	
    /**
     * @Method Name : chkFileExt
     * @작성일 : 2023. 9. 11.
     * @작성자 : KC.KIM
     * @Method 설명 : 파일 확장자 체크
     * @return
     */
	public boolean chkFileExt(String fileNm, String[] arrExt) {
		boolean isContatin = false;
		
		String ext = fileNm.substring(fileNm.lastIndexOf(".")+1, fileNm.length());
		
		isContatin = Arrays.asList(arrExt).contains(ext);
		
		return isContatin;
	}
	
    /**
     * @Method Name : generateFileNm
     * @작성일 : 2023. 9. 11.
     * @작성자 : KC.KIM
     * @Method 설명 : 저장 파일명 생성
     * @return
     */
	public String generateFileNm(String fileNm) {		
		String uuid = GgitsCommonUtils.getUuid();
		String ext = StringUtils.getFilenameExtension(fileNm);
		return uuid + "." + ext;
	}

	/**
     * @Method Name : getUploadPath
     * @작성일 : 2023. 9. 11.
     * @작성자 : KC.KIM
     * @Method 설명 : 업로드 경로
     * @return
     */
	public String getUploadPath(MultipartFile file,String filePath, String shtInfoId) {
		
		String today = BDDateFormatUtil.isNowStr("yyyyMMdd").toString();
		//날짜 / 평가지 정보 ID / fileType(사인/제안요청서/첨부파일)
		String fullPath = fileUploadPath + File.separator + today + File.separator + shtInfoId + File.separator +filePath;
		
		return makeDirectory(fullPath);
	}
	
	/**
     * @Method Name : makeDirectory
     * @작성일 : 2023. 9. 11.
     * @작성자 : KC.KIM
     * @Method 설명 : 파일 경로 생성
     * @return
     */
	private String makeDirectory(String path) {
		File dir = new File(path);
		if(!dir.exists()) {
			dir.mkdirs();
		}
		return dir.getPath();
	}
	
	public EvalFile getEvalFileInfo(MultipartFile file, String shtInfoId, FileTypeCd fileType,String fileName) {
		
		EvalFile evalFile = new EvalFile();
		
		String fileId = GgitsCommonUtils.getUuid();
		String encodingFileName = "";
		try {
			if(GgitsCommonUtils.isNull(fileName)) {
				encodingFileName = new String(file.getOriginalFilename().getBytes("8859_1"),"utf-8");
			}else {
				encodingFileName = fileName;
			}
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		String fileOgnNm = Normalizer.normalize(encodingFileName, Normalizer.Form.NFC);
		String fileExtnsn = FilenameUtils.getExtension(fileOgnNm);
		String fileNm = generateFileNm(fileOgnNm);
		String filePath = getUploadPath(file, fileType.getFilePath(), shtInfoId);
		long fileSize = file.getSize();
		
		evalFile.setFileId(fileId);
		evalFile.setShtInfoId(shtInfoId);
		evalFile.setFileType(fileType.getFileCode());
		evalFile.setFileNm(fileNm);
		evalFile.setFileSize(fileSize);
		evalFile.setFileExtnsn(fileExtnsn);
		evalFile.setFileOgnNm(fileOgnNm);
		evalFile.setFilePath(filePath);
		
		return evalFile;
	}
	
	/**
	  * @Method Name : deleteFileList
	  * @작성일 : 2023. 10. 19.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 파일 삭제
	  * @param fileList
	  */
	public void deleteFileList(List<EvalFile> fileList) {
		for(EvalFile evalFile : fileList) {
			deleteFile(evalFile);
		}
	}
	
	/**
	  * @Method Name : deleteFile
	  * @작성일 : 2023. 10. 25.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 파일삭제
	  * @param evalFile
	  */
	public void deleteFile(EvalFile evalFile) {
		
		String filePath = evalFile.getFilePath();
		String fileNm = evalFile.getFileNm();
		if(GgitsCommonUtils.isNull(filePath) || GgitsCommonUtils.isNull(fileNm)) {
			throw new CommonException(ErrorCode.FILE_DELETE_FAIL);
		}
		String fileFullPath = filePath + File.separator + fileNm;
		File file = new File(fileFullPath);
		if(file.exists()) {
			file.delete();
		}else {
			throw new CommonException(ErrorCode.FILE_NOT_EXISTS);
		}
	}
	
	public void sampleFileDownload(HttpServletResponse response,String fileName) {
        
        try {
        	String filePath = fileSampleDownloadPath+fileName;
        	ClassPathResource resource = new ClassPathResource(filePath);
        	File file = new File(resource.getURL().getPath());
            // 파일 길이를 가져온다.
            int fSize = (int) file.length();
            // 파일이 존재
            if (fSize > 0) {
                String encodedFilename = "attachment; filename*=" + "UTF-8" + "''" + URLEncoder.encode(fileName, "UTF-8");
                response.setContentType("text/csv; charset=UTF-8");
                response.setHeader("Content-Disposition", encodedFilename);
                response.setContentLengthLong(fSize);

                BufferedInputStream in = null;
                BufferedOutputStream out = null;

                in = new BufferedInputStream(new FileInputStream(file));

                out = new BufferedOutputStream(response.getOutputStream());

                try {
                    byte[] buffer = new byte[4096];
                    int bytesRead = 0;
                    while ((bytesRead = in .read(buffer)) != -1) {
                        out.write(buffer, 0, bytesRead);
                    }
                    out.flush();
                } finally {
                    in.close();
                    out.close();
                }
            } else {
                throw new FileNotFoundException("파일이 없습니다.");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
	}
	
	public void saveCsvFileInfo(MultipartFile uploadFile,String shtInfoId,String shtId,String shtType) {
		List<List<String>> list = new ArrayList<List<String>>();
		if(!uploadFile.isEmpty()) {
			BufferedReader br = null;
			try {
				String fileNm = new String(uploadFile.getOriginalFilename().getBytes("8859_1"),"utf-8");
				File csvFile = new File(fileNm);
				uploadFile.transferTo(csvFile);
				FileInputStream fis =new FileInputStream(csvFile);
				InputStreamReader isr =new InputStreamReader(fis,"CP949");
				br = new BufferedReader(isr);
				String line = "";
				
				while((line=br.readLine()) != null) {
					String[] token = line.split(",");
					List<String> tempList = new ArrayList<String>(Arrays.asList(token));
					list.add(tempList);
				}
				
			} catch (FileNotFoundException e) {
				throw new CommonException(ErrorCode.FILE_NOT_EXISTS,"파일이 존재하지 않습니다.");
			} catch (IOException e) {
				throw new CommonException(ErrorCode.FILE_UPLOAD_FAIL,"CSV 파일 변환 실패했습니다.");
			} finally {
				try {
					if(br != null) {br.close();}
				} catch (IOException e) {
					throw new CommonException(ErrorCode.FILE_UPLOAD_FAIL,"CSV 파일 변환 실패했습니다.");
				}
			}
		}else {
			throw new CommonException(ErrorCode.FILE_NOT_EXISTS,"파일이 존재하지 않습니다.");
		}
		if(list.size() > 2) {
			//평가부문 /항목 /배점 정보 삭제
			evalMngService.deleteEvalSctrInfo(shtId, shtType);
			getCsvFileInfoToEvalInfo(list,shtInfoId,shtId,shtType);
		}else {
			throw new CommonException(ErrorCode.FILE_DATA_NOT_EXISTS,"CSV 파일 입력 정보를 확인해주세요.");
		}
		
	}
	
	
	private void getCsvFileInfoToEvalInfo(List<List<String>> csvFileInfolist,String shtInfoId,String shtId,String shtType) {
		
		int csvListIdx = 0; //csv 파일 행 개수
		int headerSize = 0; //header 개수
		int fldOrdr = 0; 	//평가부문 idx
		int itemOrdr = 0;	//항목 idx
		
		//평가부문명 중복 Map
		Map<String,String> shtSctrDupleChk = new HashMap<String, String>();
		
		//save Dto
		EvalShtInfoDTO evalShtInfoDTO = new EvalShtInfoDTO();
		evalShtInfoDTO.setShtInfoId(shtInfoId);
		evalShtInfoDTO.setShtId(shtId);
		evalShtInfoDTO.setShtType(shtType);
		evalShtInfoDTO.setSaveType("save");
		
		//항목 list
		List<EvalShtItemInfo> evalShtItemList = new ArrayList<EvalShtInfoDTO.EvalShtSctrInfo.EvalShtItemInfo>();
		//배점 list
		List<EvalShtSctrInfo> evalShtSctrList = new ArrayList<EvalShtInfoDTO.EvalShtSctrInfo>();
		
		for(List<String> csvFileInfoRowList : csvFileInfolist) {
			//HEADER 사이즈 체크
			if(csvListIdx == 1) {
				headerSize = csvFileInfoRowList.size();
			}
			//설명/HEADER 부문 다음 행부터 조회
			if(csvListIdx > 1) {
				
				//정량적 평가지 인경우 배점 정보 HEADER 체크
				if("qlt".equals(shtType)) {
					//평가부문명 / 항목 / 요소 / 등급,배점 3점 / 5점 
					if(headerSize != 9 && headerSize != 13) {
						throw new CommonException(ErrorCode.DATA_MATCH_FAIL,"정량적 CSV 파일 입력 정보를 확인해주세요.");
					}
				}else {
					//평가부문 / 항목 /요소 / 배점
					if(headerSize != 4) {
						throw new CommonException(ErrorCode.DATA_MATCH_FAIL,"정성적 CSV 파일 입력 정보를 확인해주세요.");
					}
				}
//				if("qnt".equals(shtType)) {
//					//평가부문명 / 항목 / 요소 / 등급,배점 3점 / 5점 
//					if(csvFileInfoRowList.size() != 7 && csvFileInfoRowList.size() != 11) {
//						throw new CommonException(ErrorCode.DATA_MATCH_FAIL,"CSV 파일 입력 정보 개수가 부족합니다. 입력정보를 확인해주세요.");
//					}
//				}else {
//					//평가부문 / 항목 / 배점
//					if(csvFileInfoRowList.size() != 2) {
//						throw new CommonException(ErrorCode.DATA_MATCH_FAIL,"CSV 파일 입력 정보 개수가 부족합니다. 입력정보를 확인해주세요.");
//					}
//				}
				
				int csvInfoIdx = 0;
				 
				String shtSctrId = "";
				
				//평가부문 DTO
				EvalShtSctrInfo evalShtSctrInfo = new EvalShtSctrInfo();
				 
				//정량적 순석
				int qntScrOrdr = 0;
				int lastIdx = csvFileInfoRowList.size()-1;
				
				List<EvalShtQltScr> evalShtQltScrList = new ArrayList<EvalShtQltScr>();
				//정성 평가지인 경우
				EvalShtQltScr evalShtQltScr = new EvalShtQltScr(); 
				
				//정량 평가지 인경우 
				EvalShtQntScr evalShtQntScr = new EvalShtQntScr();
				//항목 정보
				EvalShtItemInfo evalShtItemInfo = new EvalShtItemInfo();
				
				String fldSctr = "";
				for(String csvFileInfo : csvFileInfoRowList) {
					
					//평가 부문이 동일 할 시 해당 평가부문의 항목으로 
					//0번째 = > 평가부문 명 
					if(csvInfoIdx == 0) {
						if(!shtSctrDupleChk.containsKey(csvFileInfo)) {
							fldSctr = csvFileInfo; 
							if(GgitsCommonUtils.isNull(fldSctr)) {
								//평가부문 없음
								throw new CommonException(ErrorCode.DATA_MATCH_FAIL,"평가부문 정보를 확인해주세요.");
							}
							shtSctrId = GgitsCommonUtils.getUuid();
							shtSctrDupleChk.put(csvFileInfo, shtSctrId);

							//평가부문 저장
							evalShtSctrInfo.setShtSctrId(shtSctrId);
							evalShtSctrInfo.setShtId(shtId);
							evalShtSctrInfo.setFldOrdr(fldOrdr);
							evalShtSctrInfo.setFldSctr(fldSctr);
							//평가부문명이 중복되지 않았다면 평가 부문 순서 +1
							fldOrdr++;
							itemOrdr = 0;
						}else {
							//평가부문명이 중복되었으면 항목 순서 +1 
							itemOrdr++;
						}
					}
					//항목이 초기화 되는 시점에 항목 목록 초기화
					if(itemOrdr == 0) {
						evalShtItemList = new ArrayList<EvalShtInfoDTO.EvalShtSctrInfo.EvalShtItemInfo>();
					}
					//평가항목 저장
					//1,2번째 = > 항목명 / 요소
					if(csvInfoIdx == 1 || csvInfoIdx == 2) {
						if(csvInfoIdx == 1) {
							evalShtItemInfo.setItmNm(csvFileInfo);
						}else {
							evalShtItemInfo.setItmElmnt(csvFileInfo);
							evalShtItemInfo.setItemOrdr(itemOrdr);
						}
					}
					
					//평가 항목
					//3~13 번째 배점정보 저장
					if("qnt".equals(shtType)) {
						if(csvInfoIdx == 3) {
							if(GgitsCommonUtils.isNull(csvFileInfo)) {
								//배점 없음
								throw new CommonException(ErrorCode.DATA_MATCH_FAIL,"CSV 파일 입력하신 정보를 확인해주세요.");
							}
							int fldScr = Integer.parseInt(csvFileInfo);
							evalShtQntScr.setFldScr(fldScr);
						}
					}else {
						//정성
						if(csvInfoIdx > 2 && csvInfoIdx < 13) {
							if(GgitsCommonUtils.isNull(csvFileInfo)) {
								//배점 없음
								throw new CommonException(ErrorCode.DATA_MATCH_FAIL,"배점 정보를 확인해주세요.");
							}
							//3,5,7,9,11 배점 등급
							if(csvInfoIdx%2 == 1) {
								evalShtQltScr.setScrNm(csvFileInfo);
							}else {
								//4,6,8,10,12 배점
								int scr = Integer.parseInt(csvFileInfo);
								evalShtQltScr.setScr(scr);
								evalShtQltScr.setScrOrdr(qntScrOrdr);
								//배점인 경우 List Add
								evalShtQltScrList.add(evalShtQltScr);
								qntScrOrdr++;
								//정량적 배점 평가 초기화
								evalShtQntScr = new EvalShtQntScr();
							}
						}
					}
				
					
					//마지막 idx 에서 DTO Save
					if(lastIdx == csvInfoIdx) {
						
						//정량 배점 목록 
						if("qlt".equals(shtType)) {
							evalShtItemInfo.setEvalShtQltScrList(evalShtQltScrList);
						}else {
							//정성 배점 목록 
							evalShtItemInfo.setEvalShtQntScrInfo(evalShtQntScr);
						}
						//항목목록에 항목 정보 저장
						evalShtItemList.add(evalShtItemInfo);
						//평가부문에 항목 목록 저장
						evalShtSctrInfo.setEvalShtItemList(evalShtItemList);
						
						//평가부문명이 포함 되어있는 경우 평가부문 목록에 평가부문 정보 저장
						if(shtSctrDupleChk.containsKey(fldSctr)) {
							evalShtSctrList.add(evalShtSctrInfo);
						}
					}
					//CSV 데이터 INDEX 
					csvInfoIdx++;
				}
				//DTO에 평가 부문 목록 저장
				evalShtInfoDTO.setEvalShtSctrList(evalShtSctrList);
			}
			//CSV ROW 행 개수 
			csvListIdx++;
		}
		
		if(evalShtInfoDTO.getEvalShtSctrList() != null &&
				evalShtInfoDTO.getEvalShtSctrList().size() > 0) {
			//DTO 저장
			evalMngService.saveEvalShtList(evalShtInfoDTO);
		}
		
	}
	
	
	public void signImgView(HttpServletResponse response,String fileId) {
		EvalFile evalFile = evalFileMapper.findOneByFileId(fileId);
		
		if(evalFile == null) {
			throw new CommonException(ErrorCode.ENTITY_DATA_NULL,"파일 정보가 없습니다.");
		}
		
		String filePath =  evalFile.getFilePath() + File.separator + evalFile.getFileNm();  
		ServletOutputStream out = null;
        FileInputStream f = null;
        int length;
        try {
        	try {
        		out = response.getOutputStream();
        		f = new FileInputStream(filePath);
        		byte[] buffer = new byte[10];
        		while((length=f.read(buffer)) != -1){
        			out.write(buffer,0,length);
        		}
        	}finally {
        		f.close();
        		out.close();
        	}
        }catch (IOException e) {
        	e.printStackTrace();
		}
	}
	
	
	public MultipartFile getMultipartFile(EvalFile evalFile) {
		File file = new File(evalFile.getFilePath() + File.separator + evalFile.getFileNm());
		
		FileItem fileItem = null;
		try {
			fileItem = new DiskFileItem("file"
			        , Files.probeContentType(file.toPath())
			        , false, evalFile.getFileOgnNm()
			        , (int) file.length(),
			        file.getParentFile());
			InputStream is = new FileInputStream(file);
            OutputStream os = fileItem.getOutputStream();
            IOUtils.copy(is, os);
		} catch (IOException e1) {
			e1.printStackTrace();
		}

        return new CommonsMultipartFile(fileItem);
	}
}
