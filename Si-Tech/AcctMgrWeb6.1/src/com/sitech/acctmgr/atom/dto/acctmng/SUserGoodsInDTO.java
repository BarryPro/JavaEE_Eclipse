package com.sitech.acctmgr.atom.dto.acctmng;

import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

public class SUserGoodsInDTO extends CommonInDTO{
	
	private static final long serialVersionUID = 1L;
	
	@ParamDesc(path="BUSI_INFO.GOODSINS_ID",cons=ConsType.QUES,type="long",len="20",desc="订购实例ID",memo="略")
	private long goodsinsId;
	
	@ParamDesc(path="BUSI_INFO.ID_NO",cons=ConsType.QUES,type="long",len="18",desc="用户ID",memo="略")
	private long idNo;
	
	@ParamDesc(path="BUSI_INFO.PRC_ID",cons=ConsType.QUES,type="String",len="20",desc="资费ID",memo="略")
	private String prcId;
	
	@ParamDesc(path="BUSI_INFO.EFF_DATE",cons=ConsType.QUES,type="String",len="14",desc="生效时间",memo="略")
	private String effDate;
	
	@ParamDesc(path="BUSI_INFO.EXP_DATE",cons=ConsType.QUES,type="String",len="14",desc="失效时间",memo="略")
	private String expDate;
	
	@ParamDesc(path="BUSI_INFO.OP_TIME",cons=ConsType.QUES,type="String",len="14",desc="操作时间",memo="略")
	private String opTime;
	
	public void decode(MBean arg0){
		super.decode(arg0);
				
		setGoodsinsId(Long.parseLong(arg0.getStr(getPathByProperName("goodsinsId"))));	
		setIdNo(Long.parseLong(arg0.getStr(getPathByProperName("idNo"))));
		setPrcId(arg0.getStr(getPathByProperName("prcId")));
		setEffDate(arg0.getStr(getPathByProperName("effDate")));
		setExpDate(arg0.getStr(getPathByProperName("expDate")));
		setOpTime(arg0.getStr(getPathByProperName("opTime")));
	}

	public long getGoodsinsId() {
		return goodsinsId;
	}

	public void setGoodsinsId(long goodsinsId) {
		this.goodsinsId = goodsinsId;
	}

	public long getIdNo() {
		return idNo;
	}

	public void setIdNo(long idNo) {
		this.idNo = idNo;
	}

	public String getPrcId() {
		return prcId;
	}

	public void setPrcId(String prcId) {
		this.prcId = prcId;
	}

	public String getEffDate() {
		return effDate;
	}

	public void setEffDate(String effDate) {
		this.effDate = effDate;
	}

	public String getExpDate() {
		return expDate;
	}

	public void setExpDate(String expDate) {
		this.expDate = expDate;
	}

	public String getOpTime() {
		return opTime;
	}

	public void setOpTime(String opTime) {
		this.opTime = opTime;
	}
	
}
