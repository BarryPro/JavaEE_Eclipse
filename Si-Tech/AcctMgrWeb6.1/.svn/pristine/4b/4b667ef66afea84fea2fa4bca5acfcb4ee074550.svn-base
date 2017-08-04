package com.sitech.acctmgr.atom.domains.user;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

/**
*
* <p>Title: 家庭业务查询输出节点  </p>
* <p>Description:  								<br/>
	 * 				PHONE_NO					    <br/>
	 * 				CONTRACT_NO						<br/>
	 * 				CONTRACT_NAME					<br/>
	 * 				CONTRACTTYPE_NAME				<br/>
	 * 				MEMBER_TYPE		: 0 关键人     1  成员 	<br/> </p>
* <p>Copyright: Copyright (c) 2014</p>
* <p>Company: SI-TECH </p>
* @author qiaolin
* @version 1.0
*/
public class FamilyEntity {

	@JSONField(name = "PHONE_NO")
	@ParamDesc(path="PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="服务号码",memo="略")
	private String phoneNo;
	
	@JSONField(name = "CONTRACT_NO")
	@ParamDesc(path="CONTRACT_NO",cons=ConsType.CT001,type="long",len="18",desc="账号",memo="略")
	private long contractNo;
	
	@JSONField(name = "CONTRACT_NAME")
	@ParamDesc(path="CONTRACT_NAME",cons=ConsType.CT001,type="String",len="100",desc="账户名称",memo="略")
	private String contractName;
	
	@JSONField(name="CONTRACTTYPE_NAME")
	@ParamDesc(path="CONTRACTTYPE_NAME",cons=ConsType.CT001,type="String",len="18",desc="账户类型名称",memo="略")
	private String contracttypeName;
	
	
	@JSONField(name="MEMBER_TYPE")
	@ParamDesc(path="MEMBER_TYPE",cons=ConsType.CT001,type="String",len="1",desc="家庭成员类型",memo="0 关键人   1  成员")
	private String memberTypeFlag;


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
	 * @return the contractName
	 */
	public String getContractName() {
		return contractName;
	}


	/**
	 * @param contractName the contractName to set
	 */
	public void setContractName(String contractName) {
		this.contractName = contractName;
	}

	/**
	 * @return the contracttypeName
	 */
	public String getContracttypeName() {
		return contracttypeName;
	}
	/**
	 * @param contracttypeName the contracttypeName to set
	 */
	public void setContracttypeName(String contracttypeName) {
		this.contracttypeName = contracttypeName;
	}
	/**
	 * @return the memberTypeFlag
	 */
	public String getMemberTypeFlag() {
		return memberTypeFlag;
	}
	/**
	 * @param memberTypeFlag the memberTypeFlag to set
	 */
	public void setMemberTypeFlag(String memberTypeFlag) {
		this.memberTypeFlag = memberTypeFlag;
	}

	@Override
	public String toString() {
		return "FamilyEntity{" +
				"phoneNo='" + phoneNo + '\'' +
				", contractNo=" + contractNo +
				", contractName='" + contractName + '\'' +
				", contracttypeName='" + contracttypeName + '\'' +
				", memberTypeFlag='" + memberTypeFlag + '\'' +
				'}';
	}
}
