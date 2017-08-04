package com.sitech.acctmgr.atom.dto.pay;


import com.alibaba.fastjson.annotation.JSONField;
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
 * @author LIJXD
 * @version 1.0
 */
public class S8296InitErrInDTO extends CommonInDTO{

 

	/**
	 * 
	 */
	private static final long serialVersionUID = 5650956092587704509L;
	
	@JSONField(name="GROUP_CONTRACT_NO")
	@ParamDesc(path = "BUSI_INFO.GROUP_CONTRACT_NO", cons = ConsType.CT001, desc = "集团账户", len = "30", type = "string", memo = "")
	protected long groupContractNo;
	
	@JSONField(name="BEGIN_TIME")
	@ParamDesc(path = "BUSI_INFO.BEGIN_TIME", cons = ConsType.CT001, desc = "开始时间", len = "20", type = "string", memo = "")
	protected String beginTime;
	
	@JSONField(name="END_TIME")
	@ParamDesc(path = "BUSI_INFO.END_TIME", cons = ConsType.CT001, desc = "结束时间", len = "20", type = "string", memo = "")
	protected String endTime;
 
 
	@Override
	public void decode(MBean arg0) {

		super.decode(arg0);
		setGroupContractNo(Long.parseLong(arg0.getObject(getPathByProperName("groupContractNo")).toString()));
		setBeginTime(arg0.getStr(getPathByProperName("beginTime")));
		setEndTime(arg0.getStr(getPathByProperName("endTime")));
	
		if (StringUtils.isEmptyOrNull(arg0.getStr(getPathByProperName("opCode")))) {
			setOpCode("8296");
		}
		
	}

	/**
	 * @return the groupContractNo
	 */
	public long getGroupContractNo() {
		return groupContractNo;
	}


	/**
	 * @param groupContractNo the groupContractNo to set
	 */
	public void setGroupContractNo(long groupContractNo) {
		this.groupContractNo = groupContractNo;
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


 

 

}
