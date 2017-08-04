package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SCollectBankGraphyInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	@ParamDesc(path="BUSI_INFO.PAGE_NUM",cons=ConsType.QUES,type="int",len="3",desc="页数",memo="略")
	protected int pageNum;
	
	@ParamDesc(path="BUSI_INFO.PAGE_SIZE",cons=ConsType.QUES,type="int",len="3",desc="每页条数",memo="略")
	protected int pageSize;

	public int getPageNum() {
		return pageNum;
	}

	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}


	@Override
	public void decode(MBean arg0) {
		// TODO Auto-generated method stub
		super.decode(arg0);
		System.out.println("arg0="+arg0.toString());
		
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("pageNum")))){
			pageNum = ValueUtils.intValue(arg0.getStr(getPathByProperName("pageNum")));
			
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("pageSize"))))
		{
			pageSize = ValueUtils.intValue(arg0.getStr(getPathByProperName("pageSize")));
		}
		
	}
}
