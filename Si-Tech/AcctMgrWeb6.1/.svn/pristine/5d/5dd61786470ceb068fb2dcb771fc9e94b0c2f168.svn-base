package com.sitech.acctmgr.atom.dto.acctmng;

import java.util.ArrayList;
import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.query.ClassifyPreEntity;
import com.sitech.acctmgr.atom.domains.query.VitualErrEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class S8293BatchOutDTO extends CommonOutDTO{
	
	@JSONField(name="FILE_NO")
	@ParamDesc(path="FILE_NO",cons=ConsType.CT001,type="long",len="18",desc="文件导入行数",memo="略")
	protected long fileNo;
	@ParamDesc(path="SUCCESS_NO",cons=ConsType.CT001,type="long",len="18",desc="成功条数",memo="略")
	protected long successNo;
	@ParamDesc(path="LOSE_NO",cons=ConsType.CT001,type="long",len="18",desc="失败条数",memo="略")
	protected long loseNo;
	@ParamDesc(path="ERR_LIST",cons=ConsType.STAR,type="compx",len="1",desc="错误信息列表",memo="略")
	protected List<VitualErrEntity> errList = new ArrayList<VitualErrEntity>();
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("fileNo"), fileNo);
		result.setRoot(getPathByProperName("successNo"), successNo);
		result.setRoot(getPathByProperName("loseNo"), loseNo);
		result.setRoot(getPathByProperName("errList"), errList);
		return result;
	}

	/**
	 * @return the fileNo
	 */
	public long getFileNo() {
		return fileNo;
	}

	/**
	 * @param fileNo the fileNo to set
	 */
	public void setFileNo(long fileNo) {
		this.fileNo = fileNo;
	}

	/**
	 * @return the successNo
	 */
	public long getSuccessNo() {
		return successNo;
	}

	/**
	 * @param successNo the successNo to set
	 */
	public void setSuccessNo(long successNo) {
		this.successNo = successNo;
	}

	/**
	 * @return the loseNo
	 */
	public long getLoseNo() {
		return loseNo;
	}

	/**
	 * @param loseNo the loseNo to set
	 */
	public void setLoseNo(long loseNo) {
		this.loseNo = loseNo;
	}

	/**
	 * @return the errList
	 */
	public List<VitualErrEntity> getErrList() {
		return errList;
	}

	/**
	 * @param errList the errList to set
	 */
	public void setErrList(List<VitualErrEntity> errList) {
		this.errList = errList;
	}
	

}
