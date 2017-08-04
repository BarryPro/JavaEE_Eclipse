package com.sitech.acctmgr.atom.domains.query;

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
public class ExcelHeadEntity implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -5929913907691824453L;

	@JSONField(name="VALUE")
	@ParamDesc(path="VALUE",cons= ConsType.CT001,type="string",len="100",desc="表头字段值",memo="略")
	private String value;
	
	@JSONField(name="COLS")
	@ParamDesc(path="COLS",cons= ConsType.CT001,type="string",len="5",desc="表头字段占用列数",memo="略")
	private String cols;

	/**
	 * @return the value
	 */
	public String getValue() {
		return value;
	}

	/**
	 * @param value the value to set
	 */
	public void setValue(String value) {
		this.value = value;
	}

	/**
	 * @return the cols
	 */
	public String getCols() {
		return cols;
	}

	/**
	 * @param cols the cols to set
	 */
	public void setCols(String cols) {
		this.cols = cols;
	}
	
	@Override
	public String toString() {
		return "[value:" + value + ",cols:"+ cols + "]";
	}
	
	
}
