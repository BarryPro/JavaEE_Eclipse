package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.util.DateUtil;

import java.util.Date;

/**
 *
 * <p>Title: 根据帐户信息去查询流水信息入参DTO  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class SgetPaySnInDTO extends CommonInDTO {

	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.CT001,type="long",len="18",desc="账号",memo="略")
	protected	long contractNo;
	
	@ParamDesc(path="BUSI_INFO.PAY_MONTH",cons=ConsType.QUES,type="String",len="6",desc="缴费年月",memo="略")
	protected	String payMonth;
	
	//缴费冲正JFCZ，空中充值冲正 KZCZCZ, 退费冲正TFCZ，集团产品转账冲正JTCPZZCZ
	@ParamDesc(path="BUSI_INFO.OP_TYPE",cons=ConsType.QUES,type="String",len="6",desc="业务类型",
			memo="缴费冲正JFCZ ，空中充值冲正 KZCZCZ")
	protected	String opType;

	@ParamDesc(path="BUSI_INFO.BEGIN_TIME",cons=ConsType.QUES,type="String",len="8",desc="开始日期",memo="格式：yyyymmdd")
	protected	String beginTime;

	@ParamDesc(path="BUSI_INFO.END_TIME",cons=ConsType.QUES,type="String",len="8",desc="结束日期",memo="格式：yyyymmdd")
	protected	String endTime;

	

	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode (MBean arg0){
		super.decode(arg0);
		setContractNo(Long.parseLong(arg0.getObject(getPathByProperName("contractNo")).toString()));
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("payMonth")))){
			setPayMonth(arg0.getStr(getPathByProperName("payMonth")));
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("opType")))){
			opType = arg0.getStr(getPathByProperName("opType"));
		}
		
		/*取当前年月和当前时间*/
		String sCurTime = DateUtil.format(new Date(), "yyyyMMddHHmmss");
		String sCurYm = sCurTime.substring(0, 6);
		String sTotalDate = sCurTime.substring(0, 8);
		
		if (StringUtils.isNotEmptyOrNull(arg0
				.getStr(getPathByProperName("beginTime")))
				&& StringUtils.isNotEmptyOrNull(arg0
						.getStr(getPathByProperName("endTime")))) {

			beginTime = arg0.getStr(getPathByProperName("beginTime"));
			endTime = arg0.getStr(getPathByProperName("endTime"));

			payMonth = sCurYm;
		} else {

			payMonth = sCurYm;
		}
		
	}



	/**
	 * @return the beginTime
	 */
	public String getBeginTime() {
		return beginTime;
	}

	/**
	 * @param beginTime the beginTime to set
	 */
	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	/**
	 * @return the endTime
	 */
	public String getEndTime() {
		return endTime;
	}

	/**
	 * @param endTime the endTime to set
	 */
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	/**
	 * @return the opType
	 */
	public String getOpType() {
		return opType;
	}

	/**
	 * @param opType the opType to set
	 */
	public void setOpType(String opType) {
		this.opType = opType;
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
	 * @return the payMonth
	 */
	public String getPayMonth() {
		return payMonth;
	}

	/**
	 * @param payMonth the payMonth to set
	 */
	public void setPayMonth(String payMonth) {
		this.payMonth = payMonth;
	}
	 
}
