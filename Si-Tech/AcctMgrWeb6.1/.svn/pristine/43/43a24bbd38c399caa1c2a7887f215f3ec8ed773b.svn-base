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
public class S8107QryPayInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3064819685111992328L;
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.CT001,type="long",len="18",desc="账户号码",memo="略")	
	private long contractNo = 0;
	@ParamDesc(path="BUSI_INFO.BEGIN_TIME",cons=ConsType.CT001,type="int",len="14",desc="开始时间",memo="略")
	private int beginTime = 0;
	@ParamDesc(path="BUSI_INFO.END_TIME",cons=ConsType.CT001,type="int",len="14",desc="结束时间",memo="略")
	private int endTime = 0;
	@ParamDesc(path="BUSI_INFO.USER_FLAG",cons=ConsType.QUES,type="int",len="1",desc="在离网标示",memo="略")
	private int userFlag = 0;
	@ParamDesc(path="BUSI_INFO.TATOL_SHOW",cons=ConsType.QUES,type="int",len="1",desc="是否显示总预存标识",memo="1：显示（默认）；2：不显示")
	private int tatolShow = 0;
	@ParamDesc(path="BUSI_INFO.PHONE_CONTRACT",cons=ConsType.QUES,type="int",len="1",desc="使用服务号码查询or账户查询",memo="1：服务号码；2：账户")
	private int phoneContract = 0;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		contractNo = Long.valueOf(arg0.getStr(getPathByProperName("contractNo")));
		beginTime = Integer.valueOf(arg0.getStr(getPathByProperName("beginTime")));
		endTime = Integer.valueOf(arg0.getStr(getPathByProperName("endTime")));
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("tatolShow")))) {
			tatolShow = Integer.valueOf(arg0.getStr(getPathByProperName("tatolShow")));
		}else{
			tatolShow = 1;
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("phoneContract")))) {
			phoneContract = Integer.valueOf(arg0.getStr(getPathByProperName("phoneContract")));
		}else{
			phoneContract = 1;
		}
		
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("userFlag")))) {
			userFlag = Integer.parseInt(arg0.getStr(getPathByProperName("userFlag")));
		}
	}

	
	
	public int getPhoneContract() {
		return phoneContract;
	}



	public void setPhoneContract(int phoneContract) {
		this.phoneContract = phoneContract;
	}



	public int getTatolShow() {
		return tatolShow;
	}

	public void setTatolShow(int tatolShow) {
		this.tatolShow = tatolShow;
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

	public int getUserFlag() {
		return userFlag;
	}

	public void setUserFlag(int userFlag) {
		this.userFlag = userFlag;
	}

	
}
