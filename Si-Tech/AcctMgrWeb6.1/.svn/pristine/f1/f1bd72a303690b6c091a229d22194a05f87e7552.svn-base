package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title: 家庭业务缴费用户信息查询入参DTO  </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class S8000FamilyQueryInDTO extends CommonInDTO{

	private static final long serialVersionUID = -3505007486912877345L;
	
	@ParamDesc(path="BUSI_INFO.FLAG",cons=ConsType.CT001,type="String",len="1",desc="查询方式",memo="0按服务号码，1按帐户号码， 2按家庭编号")
	protected String flag;
	
	@ParamDesc(path="BUSI_INFO.IN_NO",cons=ConsType.CT001,type="String",len="18",desc="号码",memo="服务号码/账户号码/家庭编码")
	protected String inNo;

	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setFlag(arg0.getStr(getPathByProperName("flag")));
		setInNo(arg0.getStr(getPathByProperName("inNo")));
		if (StringUtils.isEmptyOrNull(opCode)){
			opCode = "8000";
		}
	}

	
	/**
	 * @return the flag
	 */
	public String getFlag() {
		return flag;
	}

	/**
	 * @param flag the flag to set
	 */
	public void setFlag(String flag) {
		this.flag = flag;
	}

	/**
	 * @return the inNo
	 */
	public String getInNo() {
		return inNo;
	}

	/**
	 * @param inNo the inNo to set
	 */
	public void setInNo(String inNo) {
		this.inNo = inNo;
	}
	
}
