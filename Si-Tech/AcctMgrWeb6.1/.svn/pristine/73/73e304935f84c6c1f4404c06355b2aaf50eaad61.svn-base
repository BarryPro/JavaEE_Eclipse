package com.sitech.acctmgr.atom.dto.pay;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
* @Description: 飞豆充值验证 入参DTO
* @Date :2015年5月14日
* @Company: SI-TECH
* @author : chenyha
* @version : 1.0
* @modify history
*  <p>修改日期    修改人   修改目的<p>
*/
public class SFeiDouPayCfmInDTO extends CommonInDTO {

    /**
	 * 
	*/
	private static final long serialVersionUID = 8108351473283993199L;

	@ParamDesc(path="BUSI_INFO.OPT_SEQ",cons=ConsType.CT001,type="String",len="32",desc="操作流水",memo="略")
    private String optSeq;

    @ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="用户号码",memo="略")
    private String phoneNo;

/*    @ParamDesc(path="OPR_INFO.LOGIN_NO",cons=ConsType.CT001,type="String",len="20",desc="操作工号",memo="略")
    private String loginNo;
    */
    @ParamDesc(path="BUSI_INFO.SMS_CONTENT",cons=ConsType.CT001,type="String",len="20",desc="短信回复内容",memo="略")
    private String smsContent;

	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);

		setOptSeq(arg0.getStr(getPathByProperName("optSeq")));
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		//setLoginNo(arg0.getStr(getPathByProperName("loginNo")));
		setSmsContent(arg0.getStr(getPathByProperName("smsContent")));

		/*设置默认opcode*/
		if (StringUtils.isEmptyOrNull(opCode)){
			opCode = "8073";
		}

	}

	public String getOptSeq() {
		return optSeq;
	}

	public void setOptSeq(String optSeq) {
		this.optSeq = optSeq;
	}

	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

/*	public String getLoginNo() {
		return loginNo;
	}

	public void setLoginNo(String loginNo) {
		this.loginNo = loginNo;
	}
*/
	public String getSmsContent() {
		return smsContent;
	}

	public void setSmsContent(String smsContent) {
		this.smsContent = smsContent;
	}

}