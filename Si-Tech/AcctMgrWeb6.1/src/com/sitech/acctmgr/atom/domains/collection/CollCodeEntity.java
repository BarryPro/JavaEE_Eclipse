/**   
 * File：CollCodeEntity.java   
 *   
 * Version：   
 * Date：2015-3-13     
 * Copyright Clarify:   
 *   
 */
package com.sitech.acctmgr.atom.domains.collection;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**   
 * @Description: 托收返回状态
 * @author:  wangyla
 * @version:
 * @createTime:  2015-3-13 下午2:14:43
 */
public class CollCodeEntity implements Serializable {

	private static final long serialVersionUID = 7842589762496571213L;
	
	@JSONField(name="CODE_ID")
	@ParamDesc(path="CODE_ID",cons= ConsType.CT001,len="4",desc="托收返回代码",type="String",memo="略")
	String codeId;
	@JSONField(name="CODE_VALUE")
	@ParamDesc(path="CODE_VALUE",cons= ConsType.CT001,len="20",desc="返回代码名称",type="String",memo="略")
	String codeValue;
	@JSONField(name="STATUS")
	@ParamDesc(path="STATUS",cons= ConsType.CT001,len="1",desc="返回代码名称",type="String",memo="略")
	String status;
	@JSONField(name="CODE_NAME")
	@ParamDesc(path="CODE_NAME",cons= ConsType.CT001,len="40",desc="代码-->返回名称",type="String",memo="略")
	String codeName;
	
	public String getCodeId() {
		return codeId;
	}
	public void setCodeId(String codeId) {
		this.codeId = codeId;
	}
	public String getCodeValue() {
		return codeValue;
	}
	public void setCodeValue(String codeValue) {
		this.codeValue = codeValue;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCodeName() {
		return codeName;
	}
	public void setCodeName(String codeName) {
		this.codeName = codeName;
	}
}
