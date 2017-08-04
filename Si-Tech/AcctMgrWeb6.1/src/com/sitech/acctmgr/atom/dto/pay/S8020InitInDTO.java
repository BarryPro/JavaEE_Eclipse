package com.sitech.acctmgr.atom.dto.pay;

import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

 
/**
* @Title:   []
* @Description: 一点支付缴费根据证件获取账户 入参DTO 
* @Date :2015年2月4日
* @Company: SI-TECH
* @author : LIJXD
* @version : 1.0
* @modify history
*  <p>修改日期    修改人   修改目的<p>
 */
public class S8020InitInDTO extends CommonInDTO{
 
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.CT001,type="long",len="18",desc="账号",memo="略")
	protected long  contractNo;
	
	@Override
	public void decode(MBean arg0) {
		log.info("arg0="+arg0.toString());
		super.decode(arg0);
		setContractNo(Long.parseLong(arg0.getObject(getPathByProperName("contractNo")).toString()));
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

}

