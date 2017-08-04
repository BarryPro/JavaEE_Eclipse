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
public class SBalanceQryBackFeeJLInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4657905163305719355L;
	
	@ParamDesc(path="BUSI_INFO.QUERY_TYPE",cons=ConsType.CT001,type="int",len="2",desc="查询类型",memo="0:服务号码查询, 1:账户号码查询")
	private int queryType = 0;
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="20",desc="服务号码",memo="略")
	private String phoneNo = "";
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.QUES,type="long",len="20",desc="账户号码",memo="略")
	private long contractNo = 0;
	@ParamDesc(path="BUSI_INFO.FLAG",cons=ConsType.QUES,type="int",len="2",desc="开关",memo="0：只查询预存和押金(默认)  1：查询预存、押金和套餐费")
	private int flag = 0;
	
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		queryType = Integer.parseInt(arg0.getStr(getPathByProperName("queryType")));
		
		if(queryType == 0) {
			phoneNo = arg0.getStr(getPathByProperName("phoneNo"));
		} else {
			contractNo = Long.parseLong(arg0.getStr(getPathByProperName("contractNo")));
		}
		
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("flag")))) {
			flag = Integer.parseInt(arg0.getStr(getPathByProperName("flag")));
		}
	}

	/**
	 * @return the queryType
	 */
	public int getQueryType() {
		return queryType;
	}

	/**
	 * @param queryType the queryType to set
	 */
	public void setQueryType(int queryType) {
		this.queryType = queryType;
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

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}
	
}
