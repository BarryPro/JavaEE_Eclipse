package com.sitech.acctmgr.atom.domains.invoice;

import java.io.Serializable;
import java.util.Arrays;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;

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
public class PrintDataBlob implements Serializable{
	@JSONField(name="PRINT_DATA")
	@ParamDesc(path = "PRINT_DATA", cons = ConsType.QUES, type = "byte[]", len = "1", desc = "发票报文二进制数组", memo = "略")
	byte[] printContent;
	@JSONField(name="PRINT_SN")
	@ParamDesc(path = "PRINT_SN", cons = ConsType.QUES, type = "long", len = "20", desc = "打印流水", memo = "略")
	long printSn;
	@JSONField(name="YEAR_MONTH")
	@ParamDesc(path = "YEAR_MONTH", cons = ConsType.QUES, type = "int", len = "10", desc = "打印自然月", memo = "略")
	int yearMonth;
	@JSONField(name="SHOW_ORDER")
	@ParamDesc(path = "SHOW_ORDER", cons = ConsType.QUES, type = "int", len = "2", desc = "发票项序号", memo = "略")
	List<Integer> showOrder;

	public byte[] getPrintContent() {
		return printContent;
	}

	public void setPrintContent(byte[] printContent) {
		this.printContent = printContent;
	}
	public long getPrintSn() {
		return printSn;
	}
	public void setPrintSn(long printSn) {
		this.printSn = printSn;
	}
	public int getYearMonth() {
		return yearMonth;
	}
	public void setYearMonth(int yearMonth) {
		this.yearMonth = yearMonth;
	}


	public List<Integer> getShowOrder() {
		return showOrder;
	}

	public void setShowOrder(List<Integer> showOrder) {
		this.showOrder = showOrder;
	}

	@Override
	public String toString() {
		return "PrintDataBlob [printContent=" + Arrays.toString(printContent) + ", printSn=" + printSn + ", yearMonth=" + yearMonth + ", showOrder="
				+ showOrder + "]";
	}


}
