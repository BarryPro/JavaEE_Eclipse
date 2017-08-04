package com.sitech.acctmgr.atom.dto.query;

import java.util.List;

import com.sitech.acctmgr.atom.domains.query.SubCardEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class ShareAccountQryOutDTO extends CommonOutDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
    @ParamDesc(path = "STATE_FLAG", cons = ConsType.QUES, desc = "主卡运行状态", len = "10", type = "string", memo = "")
    private String stateFlag;
    @ParamDesc(path = "FLAG1", cons = ConsType.QUES, desc = "", len = "10", type = "string", memo = "")
    private String flag1;
    @ParamDesc(path = "BILL_FEE", cons = ConsType.QUES, desc = "欠费", len = "10", type = "long", memo = "单位：分")
    private long billFee;
    @ParamDesc(path = "MAIN_NAME", cons = ConsType.QUES, desc = "主卡状态", len = "100", type = "String", memo = "")
    private String mainName;
    
	@ParamDesc(path = "RESULT_LIST", cons = ConsType.STAR, type = "compx", len = "1", desc = "副卡信息列表", memo = "")
	private List<SubCardEntity> resultList;
	
	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setBody(getPathByProperName("stateFlag"), stateFlag);
		result.setBody(getPathByProperName("flag1"), flag1);
		result.setBody(getPathByProperName("billFee"), billFee);
		result.setBody(getPathByProperName("mainName"), mainName);
		result.setBody(getPathByProperName("resultList"), resultList);
		return result;
	}

	/**
	 * @return the stateFlag
	 */
	public String getStateFlag() {
		return stateFlag;
	}

	/**
	 * @param stateFlag the stateFlag to set
	 */
	public void setStateFlag(String stateFlag) {
		this.stateFlag = stateFlag;
	}

	/**
	 * @return the flag1
	 */
	public String getFlag1() {
		return flag1;
	}

	/**
	 * @param flag1 the flag1 to set
	 */
	public void setFlag1(String flag1) {
		this.flag1 = flag1;
	}

	/**
	 * @return the mainName
	 */
	public String getMainName() {
		return mainName;
	}

	/**
	 * @param mainName the mainName to set
	 */
	public void setMainName(String mainName) {
		this.mainName = mainName;
	}

	/**
	 * @return the billFee
	 */
	public long getBillFee() {
		return billFee;
	}

	/**
	 * @param billFee the billFee to set
	 */
	public void setBillFee(long billFee) {
		this.billFee = billFee;
	}

	/**
	 * @return the resultList
	 */
	public List<SubCardEntity> getResultList() {
		return resultList;
	}

	/**
	 * @param resultList the resultList to set
	 */
	public void setResultList(List<SubCardEntity> resultList) {
		this.resultList = resultList;
	}
}
