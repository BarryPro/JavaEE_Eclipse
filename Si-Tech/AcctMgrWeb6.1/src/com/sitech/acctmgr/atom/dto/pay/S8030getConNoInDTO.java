package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import static com.sitech.acctmgr.common.AcctMgrError.getErrorCode;

/**
 *
 * <p>Title: 托收缴费查询托收账户入参DTO   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class S8030getConNoInDTO extends CommonInDTO  {
	
	private static final long serialVersionUID = 4781721974438440390L;
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="14",desc="服务号码",memo="略")
	protected String phoneNo;

	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		if (StringUtils.isEmptyOrNull(phoneNo)){
			throw new BusiException(getErrorCode(opCode, "01001"), "PHONE_NO不能为空");
		}
		if (StringUtils.isEmptyOrNull(opCode)){
			opCode = "8030";
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
	
}
