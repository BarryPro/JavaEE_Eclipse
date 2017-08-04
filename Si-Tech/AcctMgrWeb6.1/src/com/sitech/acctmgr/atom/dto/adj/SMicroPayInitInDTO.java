package com.sitech.acctmgr.atom.dto.adj;

import org.apache.hadoop.hdfs.server.namenode.snapshot.Snapshot.Root;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
* @Description: 手机钱包查询 入参DTO
* @Date :2016年10月21日
* @Company: SI-TECH
* @author : liuyc_billing
* @version : 1.0
* @modify history
*  <p>修改日期    修改人   修改目的<p>
*/
public class SMicroPayInitInDTO extends CommonInDTO{

	/**
	 * 
	 */
	private static final long serialVersionUID = 5487457941483560073L;
	
	@ParamDesc(path="BUSI_INFO.PHONE_NO",cons=ConsType.CT001,type="String",len="40",desc="电话号码",memo="略")
	private String inPhoneNo;
	
	@Override
	public void decode(MBean arg0){
		super.decode(arg0);
		setInPhoneNo(arg0.getStr(getPathByProperName("inPhoneNo")));
		/*设置默认opcode*/
		if (StringUtils.isEmptyOrNull(opCode)){
			opCode = "7004";
		}
	}
	
	public String getInPhoneNo() {
		return inPhoneNo;
	}


	public void setInPhoneNo(String inPhoneNo) {
		this.inPhoneNo = inPhoneNo;
	}
}
