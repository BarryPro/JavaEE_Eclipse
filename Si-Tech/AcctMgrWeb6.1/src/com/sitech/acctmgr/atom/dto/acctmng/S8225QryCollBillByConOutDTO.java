package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.atom.domains.query.ExcelDataEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.List;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class S8225QryCollBillByConOutDTO extends CommonOutDTO {

	private static final long serialVersionUID = -6143180828036219981L;

	@ParamDesc(path="DF_EX_NODENAME",cons= ConsType.CT001,type="String",len="100",desc="接点路径",memo="略")
	private String dfExNodeName;
	@ParamDesc(path="ATTR_LIST.EXCEL_NAME",cons= ConsType.CT001,type="String",len="100",desc="导出excel的文件名",memo="略")
	private String attrExcelName;
	@ParamDesc(path="ATTR_LIST.EXCEL_DATA",cons= ConsType.QUES,type="compx",len="",desc="excel中表格数据",memo="略")
	private List<ExcelDataEntity> excelList;

	@Override
	public MBean encode() {
		MBean result = new MBean();
		result.setRoot(getPathByProperName("dfExNodeName"), dfExNodeName);
		result.setRoot(getPathByProperName("attrExcelName"), attrExcelName);
		result.setRoot(getPathByProperName("excelList"), excelList);
		return result;
	}



	/**
	 * @return the dfExNodeName
	 */
	public String getDfExNodeName() {
		return dfExNodeName;
	}



	/**
	 * @param dfExNodeName the dfExNodeName to set
	 */
	public void setDfExNodeName(String dfExNodeName) {
		this.dfExNodeName = dfExNodeName;
	}



	/**
	 * @return the attrExcelName
	 */
	public String getAttrExcelName() {
		return attrExcelName;
	}



	/**
	 * @param attrExcelName the attrExcelName to set
	 */
	public void setAttrExcelName(String attrExcelName) {
		this.attrExcelName = attrExcelName;
	}



	/**
	 * @return the excelList
	 */
	public List<ExcelDataEntity> getExcelList() {
		return excelList;
	}



	/**
	 * @param excelList the excelList to set
	 */
	public void setExcelList(List<ExcelDataEntity> excelList) {
		this.excelList = excelList;
	}


}
