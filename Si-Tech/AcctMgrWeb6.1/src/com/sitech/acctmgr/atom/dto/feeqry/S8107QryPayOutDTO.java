package com.sitech.acctmgr.atom.dto.feeqry;

import com.sitech.acctmgr.atom.domains.query.Pay8107Entity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class S8107QryPayOutDTO extends CommonOutDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4141692937896915768L;
	
	@ParamDesc(path="CNT",cons=ConsType.CT001,type="int",len="10",desc="条数",memo="略")
	protected int cnt = 0;
	@ParamDesc(path="PAY_LIST",cons=ConsType.STAR,type="compx",len="1",desc="缴费列表",memo="略")
	protected List<Pay8107Entity> outParamList = new ArrayList<Pay8107Entity>();

	/**
	 * @return the cnt
	 */
	public int getCnt() {
		return cnt;
	}

	/**
	 * @param cnt the cnt to set
	 */
	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	

	/**
	 * @return the outParamList
	 */
	public List<Pay8107Entity> getOutParamList() {
		return outParamList;
	}

	/**
	 * @param outParamList the outParamList to set
	 */
	public void setOutParamList(List<Pay8107Entity> outParamList) {
		this.outParamList = outParamList;
	}

	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("cnt"), cnt);
		result.setRoot(getPathByProperName("outParamList"), outParamList);
		return result;
	}
	
}
