package com.sitech.acctmgr.atom.dto.pay;

import com.alibaba.fastjson.JSON;
import com.sitech.acctmgr.atom.domains.pay.FieldEntity;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 *
 * <p>Title: 第三方缴费签约关系设置签约入参DTO  </p>
 * <p>Description: 		  </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author qiaolin
 * @version 1.0
 */
public class S8297TerminationInDTO extends CommonInDTO {
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	private String phoneNo;
	
	@ParamDesc(path="BUSI_INFO.PHONE_PASSWORD",cons=ConsType.CT001,type="String",len="40",desc="服务密码",memo="略")
	private String phonePassword;
	
	@ParamDesc(path="BUSI_INFO.BUSI_TYPE",cons=ConsType.CT001,type="String",len="5",desc="业务类型",
			    memo="业务类型：1001:手机支付自动缴话费签约关系. 1002:银行卡自动缴话费签约关系(联动优势).1003:支付宝签约关系"
			    		+ "ZFBJY")
	private String busiType;
	
	@ParamDesc(path="BUSI_INFO.SIGN_FIELD",cons=ConsType.PLUS,type="complex",len="1",desc="签约属性",memo="不同签约类型传入不容的属性编码和属性值")
	private	List<FieldEntity> signFieldList = new ArrayList<FieldEntity>();

	@ParamDesc(path="BUSI_INFO.OP_NOTE",cons=ConsType.QUES,type="String",len="100",desc="备注",memo="略")
	private String opNote;
	
	
	
	/* (non-Javadoc)
	 * @see com.sitech.jcfx.dt.in.InDTO#decode(com.sitech.jcfx.dt.MBean)
	 */
	@Override
	public void decode(MBean arg0) {
		super.decode(arg0);
		setPhoneNo(arg0.getStr(getPathByProperName("phoneNo")));
		setPhonePassword(arg0.getStr(getPathByProperName("phonePassword")));
		setBusiType(arg0.getStr(getPathByProperName("busiType")));
		
		if(StringUtils.isNotEmptyOrNull(arg0.getList(getPathByProperName("signFieldList")))){
			
			List<Map<String, Object>> signFieldList = (List<Map<String, Object>>)arg0.getList(getPathByProperName("signFieldList"));
			for(Map<String, Object> payTmp : signFieldList){
	    		String jsonStr = JSON.toJSONString(payTmp);
	    		this.signFieldList.add(JSON.parseObject(jsonStr, FieldEntity.class));
			}
		}
		
		setOpNote(arg0.getStr(getPathByProperName("opNote")));
		if(StringUtils.isEmptyOrNull(this.opNote)){
			this.opNote = "第三方自动缴费签约关系解约";
		}
	}

	
	public String getPhoneNo() {
		return phoneNo;
	}

	public void setPhoneNo(String phoneNo) {
		this.phoneNo = phoneNo;
	}

	public String getPhonePassword() {
		return phonePassword;
	}

	public void setPhonePassword(String phonePassword) {
		this.phonePassword = phonePassword;
	}

	public String getBusiType() {
		return busiType;
	}

	public void setBusiType(String busiType) {
		this.busiType = busiType;
	}

	public List<FieldEntity> getSignFieldList() {
		return signFieldList;
	}

	public void setSignFieldList(List<FieldEntity> signFieldList) {
		this.signFieldList = signFieldList;
	}

	public String getOpNote() {
		return opNote;
	}

	public void setOpNote(String opNote) {
		this.opNote = opNote;
	}

}
