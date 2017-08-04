package com.sitech.acctmgr.atom.domains.invoice;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

import java.io.Serializable;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
@SuppressWarnings("serial")
public class PrtXmlEntity implements Serializable {

	/**
	 * 
	 */
	public PrtXmlEntity() {
		// TODO Auto-generated constructor stub
	}
	@JSONField(name="PRINT_XML")
	@ParamDesc(path="PRINT_XML",cons=ConsType.CT001,type="String",len="5048",desc="发票打印模板",memo="略")
	private String prtXml;
	public String getPrtXml() {
		return prtXml;
	}
	public void setPrtXml(String prtXml) {
		this.prtXml = prtXml;
	}
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return "[prtXml:" + prtXml + "]";
	}
	
	
}
