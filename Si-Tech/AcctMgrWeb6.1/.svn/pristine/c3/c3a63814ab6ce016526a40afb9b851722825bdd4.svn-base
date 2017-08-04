package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class S8107QryBillInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 4076032478943349501L;
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="20",desc="服务号码",memo="可空")
	private String phoneNo = "";
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.CT001,type="long",len="18",desc="账号号码",memo="略")
	private long contractNo = 0;
	@ParamDesc(path="BUSI_INFO.ID_NO",cons=ConsType.QUES,type="long",len="18",desc="用户ID",memo="可空")
	private long idNo = 0;
	@ParamDesc(path="BUSI_INFO.USER_FLAG",cons=ConsType.QUES,type="int",len="5",desc="在离网标识",memo="0:在网(默认)  1:离网")
	private int userFlag = 0;
	@ParamDesc(path="BUSI_INFO.BEGIN_TIME",cons=ConsType.QUES,type="String",len="20",desc="开始时间",memo="可空")
	private int beginTime = 0;
	@ParamDesc(path="BUSI_INFO.END_TIME",cons=ConsType.QUES,type="String",len="20",desc="结束时间",memo="可空")
	private int endTime = 0;
	@ParamDesc(path="BUSI_INFO.IN_UUID",cons=ConsType.QUES,type="String",len="100",desc="唯一标识",memo="后台分页使用")
	private String inUuid = "";
	@ParamDesc(path="BUSI_INFO.PAGE_NUM",cons=ConsType.QUES,type="int",len="5",desc="页数",memo="略")
	private int pageNum = 0;
	
	

	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		contractNo = Long.valueOf(arg0.getStr(getPathByProperName("contractNo")));
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("phoneNo")))) {
			phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("idNo")))) {
			idNo = Long.valueOf(arg0.getStr(getPathByProperName("idNo")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("userFlag")))) {
			userFlag = Integer.valueOf(arg0.getStr(getPathByProperName("userFlag")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("beginTime")))) {
			beginTime = Integer.valueOf(arg0.getStr(getPathByProperName("beginTime")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("endTime")))) {
			endTime = Integer.valueOf(arg0.getStr(getPathByProperName("endTime")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("inUuid")))) {
			inUuid = arg0.getStr(getPathByProperName("inUuid"));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("pageNum")))) {
			pageNum = Integer.parseInt(arg0.getStr(getPathByProperName("pageNum")));
		}
	}



	/**
	 * @return the phoneNo
	 */
	public String getPhoneNo() {
		return phoneNo;
	}



	/**
	 * @param phoneNo the phoneNo to set
	 */
	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}



	/**
	 * @return the contractNo
	 */
	public long getContractNo() {
		return contractNo;
	}



	/**
	 * @param contractNo the contractNo to set
	 */
	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}



	/**
	 * @return the idNo
	 */
	public long getIdNo() {
		return idNo;
	}



	/**
	 * @param idNo the idNo to set
	 */
	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}



	/**
	 * @return the userFlag
	 */
	public int getUserFlag() {
		return userFlag;
	}



	/**
	 * @param userFlag the userFlag to set
	 */
	public void setUserFlag(int userFlag) {
		this.userFlag = userFlag;
	}



	/**
	 * @return the beginTime
	 */
	public int getBeginTime() {
		return beginTime;
	}



	/**
	 * @param beginTime the beginTime to set
	 */
	public void setBeginTime(int beginTime) {
		this.beginTime = beginTime;
	}



	/**
	 * @return the endTime
	 */
	public int getEndTime() {
		return endTime;
	}



	/**
	 * @param endTime the endTime to set
	 */
	public void setEndTime(int endTime) {
		this.endTime = endTime;
	}



	/**
	 * @return the inUuid
	 */
	public String getInUuid() {
		return inUuid;
	}



	/**
	 * @param inUuid the inUuid to set
	 */
	public void setInUuid(String inUuid) {
		this.inUuid = inUuid;
	}



	/**
	 * @return the pageNum
	 */
	public int getPageNum() {
		return pageNum;
	}



	/**
	 * @param pageNum the pageNum to set
	 */
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}

	
}
