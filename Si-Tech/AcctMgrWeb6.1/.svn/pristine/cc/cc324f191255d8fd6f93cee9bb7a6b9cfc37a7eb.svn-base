package com.sitech.acctmgr.atom.dto.pay;

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
 * <p>Title: 缴费查询入参DTO  </p>
 * <p>Description: 缴费查询入参DTO  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author zhangjp
 * @version 1.0
 */
public class S8000InitInDTO extends CommonInDTO {

	private static final long serialVersionUID = 1837434900978325210L;
	
	@ParamDesc(path="BUSI_INFO.PAY_PATH",cons=ConsType.CT001,type="String",len="5",desc="缴费渠道",
			memo="02:网上营业厅,06:IVR,04:短信营业厅,11:营业前台,05:自助终端,18:一级BOSS,19:银行,21:智能终端CRM,28:三卡合一")
	private String payPath;
	
	@ParamDesc(path="BUSI_INFO.CONTRACT_NO",cons=ConsType.QUES,type="long",len="18",desc="账号",memo="略")
	protected long contractNo;//可不传
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.QUES,type="String",len="40",desc="服务号码",memo="略")
	protected String phoneNo;
	
	@ParamDesc(path="BUSI_INFO.LOGIN_PDOM",cons=ConsType.QUES,type="complex",len="1",desc="工号特权",memo="跨地市缴费、跨区县缴费等，接口统一工号调用不需要传入")
	protected List<LoginPdomEntity> loginPdom = new ArrayList<LoginPdomEntity>();

	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		//setlContractNo(arg0.getLong(getPathByProperName("contractNo")));
		if(arg0.getObject(getPathByProperName("contractNo")) != null && !arg0.getObject(getPathByProperName("contractNo")).equals("")){
			setContractNo(Long.parseLong(arg0.getObject(getPathByProperName("contractNo")).toString()));
		}
		if (StringUtils.isEmptyOrNull(phoneNo) && StringUtils.isEmptyOrNull(contractNo)){
			throw new BusiException(getErrorCode(opCode, "01002"), "PHONE_NO不能为空和CONTRACT_NO不能同时为空");
		}
		if (StringUtils.isEmptyOrNull(opCode)){
			opCode = "8000";
		}
		setPayPath(arg0.getStr(getPathByProperName("payPath")));
		
		if(StringUtils.isEmptyOrNull(getPathByProperName("loginPdom"))){
			loginPdom = arg0.getList(getPathByProperName("loginPdom"), LoginPdomEntity.class);
		}
	}
	
	


	/**
	 * @return the loginPdom
	 */
	public List<LoginPdomEntity> getLoginPdom() {
		return loginPdom;
	}

	/**
	 * @param loginPdom the loginPdom to set
	 */
	public void setLoginPdom(List<LoginPdomEntity> loginPdom) {
		this.loginPdom = loginPdom;
	}

	/**
	 * @return the payPath
	 */
	public String getPayPath() {
		return payPath;
	}

	/**
	 * @param payPath the payPath to set
	 */
	public void setPayPath(String payPath) {
		this.payPath = payPath;
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
