/**   
 * File：CollBillStatusGroup.java   
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
* @Description: 按状态统计托收单清单
* @author:  wangyla
* @version:
* @createTime:  2015-3-13 下午5:42:39
*/
public class CollBillStatusGroupEntity implements Serializable {	    
	private static final long serialVersionUID = -8089247866354392189L;
	@JSONField(name="RETURN_CODE")
	 @ParamDesc(path="RETURN_CODE",cons= ConsType.CT001,len="4",desc="托收返回代码",type="long",memo="略")
	 String returnCode;
	 @JSONField(name="COLL_NAME")
	 @ParamDesc(path="COLL_NAME",cons= ConsType.CT001,len="20",desc="托收状态",type="string",memo="略")
	 String collName;
	 @JSONField(name="CON_NUMS")
	 @ParamDesc(path="CON_NUMS",cons= ConsType.CT001,len="4",desc="托收帐户数",type="int",memo="略")
	 int conNums;
	 @JSONField(name="SUM_PAY_FEE")
	 @ParamDesc(path="SUM_PAY_FEE",cons= ConsType.CT001,len="",desc="托收金额",type="long",memo="略")
	 long sumPayFee;
	 
	public String getReturnCode() {
		return returnCode;
	}
	public void setReturnCode(String returnCode) {
		this.returnCode = returnCode;
	}
	public String getCollName() {
		return collName;
	}
	public void setCollName(String collName) {
		this.collName = collName;
	}
	public int getConNums() {
		return conNums;
	}
	public void setConNums(int conNums) {
		this.conNums = conNums;
	}
	public long getSumPayFee() {
		return sumPayFee;
	}
	public void setSumPayFee(long sumPayFee) {
		this.sumPayFee = sumPayFee;
	}
	
	 
	 
}
