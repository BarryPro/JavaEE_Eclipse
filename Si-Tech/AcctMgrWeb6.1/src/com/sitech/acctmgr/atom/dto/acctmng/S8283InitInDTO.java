package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.common.domains.LoginPdomEntity;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;

import static com.sitech.acctmgr.common.AcctMgrError.getErrorCode;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class S8283InitInDTO extends CommonInDTO {

	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.CT001,type="long",len="18",desc="账号",memo="略")
	protected long contractNo;
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="服务号码",memo="略")
	protected String phoneNo;

	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		if(arg0.getObject(getPathByProperName("contractNo")) != null && !arg0.getObject(getPathByProperName("contractNo")).equals("")){
			setContractNo(Long.parseLong(arg0.getObject(getPathByProperName("contractNo")).toString()));
		}
	}


	public long getContractNo() {
		return contractNo;
	}


	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}


	public String getPhoneNo() {
		return phoneNo;
	}


	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}
	

}
