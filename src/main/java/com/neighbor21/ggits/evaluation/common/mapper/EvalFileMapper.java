package com.neighbor21.ggits.evaluation.common.mapper;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.mapper.Mapper;

import com.neighbor21.ggits.evaluation.common.entity.EvalFile;

@Mapper
public interface EvalFileMapper {
	
	/**
	  * @Method Name : save
	  * @작성일 : 2023. 10. 17.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 파일정보 저장
	  * @param evalFile
	  */
	public void save(EvalFile evalFile);
	
	/**
	  * @Method Name : findAllByShtInfoId
	  * @작성일 : 2023. 10. 19.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 전체 목록 조회
	  * @param shtInfoId
	  * @return
	  */
	public List<EvalFile>findAllByShtInfoId(String shtInfoId);
	
	/**
	  * @Method Name : findAllByShtInfoIdAndRequestFileAndAttachmentFile
	  * @작성일 : 2023. 10. 30.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 파일 목록 조회 (제안요청서 / 첨부파일)
	  * @param shtInfoId
	  * @return
	  */
	public List<EvalFile>findAllByShtInfoIdAndRequestFileAndAttachmentFile(String shtInfoId);
	
	/**
	  * @Method Name : deleteByShtInfoId
	  * @작성일 : 2023. 10. 19.
	  * @작성자 : NK.KIM
	  * @Method 설명 : 삭제
	  * @param shtInfoId
	  */
	public void deleteByShtInfoId(String shtInfoId);
	
	/**
	 * @Method Name : deleteByFileId
	 * @작성일 : 2023. 10. 19.
	 * @작성자 : NK.KIM
	 * @Method 설명 : 삭제
	 * @param shtInfoId
	 */
	public void deleteByFileId(String shtInfoId);
	
	/**
	 * @Method Name : findAllByShtInfoIdAndFileType
	 * @작성일 : 2023. 10. 19.
	 * @작성자 : NK.KIM
	 * @Method 설명 : 전체 목록 조회
	 * @param evalFile
	 * @return
	 */
	public List<EvalFile>findAllByShtInfoIdAndFileType(EvalFile evalFile);
	
	/**
	 * @Method Name : findOneByFileId
	 * @작성일 : 2023. 10. 19.
	 * @작성자 : NK.KIM
	 * @Method 설명 : 파일 정보 조회
	 * @param evalFile
	 * @return
	 */
	public EvalFile findOneByFileId(String fileId);
}
