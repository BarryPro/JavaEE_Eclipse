package com.sitech.acctmgr.atom.dto.pay;

import java.util.List;

import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.pay.GroupChargeEntity;
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author LIJXD
 * @version 1.0
 */
public class S8296InitRecdOutDTO extends CommonOutDTO{
  
	private static final long serialVersionUID = 560807093284068754L;
	
	//消费信息
	@JSONField(name="LIST_GRPCON")
	@ParamDesc(path="LIST_GRPCON",cons=ConsType.STAR,type="compx",len="1",desc="集团账户划拨列表",memo="略")
	protected List<GroupChargeEntity> listGrpCon;
	@JSONField(name="GRPCON_SIZE")
	@ParamDesc(path="GRPCON_SIZE",cons=ConsType.CT001,type="int",len="14",desc="集团账户划拨数",memo="略")
	protected int grpConSize = 0;
	
	@JSONField(name="GRP_CON")
	@ParamDesc(path="GRP_CON",cons=ConsType.CT001,type="int",len="14",desc="集团账户",memo="略")
	protected long grpCon = 0;
	@JSONField(name="GRP_PREPAY")
	@ParamDesc(path="GRP_PREPAY",cons=ConsType.CT001,type="int",len="14",desc="集团账户预存",memo="略")
	protected long grpPrepay = 0;
	@JSONField(name="GROUP_PRODUCT_NAME")
	@ParamDesc(path="GROUP_PRODUCT_NAME",cons=ConsType.CT001,type="string",len="120",desc="集团账户名称",memo="略")
	protected String groupProductName ;
	@ParamDesc(path="PAYED_SUM",cons=ConsType.CT001,type="int",len="14",desc="集团账户预存",memo="略")
	protected long payedSum = 0;
	
	@Override
	public MBean encode() {
		// TODO Auto-generated method stub
		MBean result=super.encode();
		result.setRoot(getPathByProperName("listGrpCon"), listGrpCon);
		result.setRoot(getPathByProperName("grpConSize"), grpConSize);
		result.setRoot(getPathByProperName("grpCon"), grpCon);
		result.setRoot(getPathByProperName("groupProductName"), groupProductName);
		result.setRoot(getPathByProperName("grpPrepay"), grpPrepay);
		result.setRoot(getPathByProperName("payedSum"), payedSum);
		return result;
	}

	/**
	 * @return the listGrpCon
	 */
	public List<GroupChargeEntity> getListGrpCon() {
		return listGrpCon;
	}

	/**
	 * @param listGrpCon the listGrpCon to set
	 */
	public void setListGrpCon(List<GroupChargeEntity> listGrpCon) {
		this.listGrpCon = listGrpCon;
	}

	/**
	 * @return the grpConSize
	 */
	public int getGrpConSize() {
		return grpConSize;
	}

	/**
	 * @param grpConSize the grpConSize to set
	 */
	public void setGrpConSize(int grpConSize) {
		this.grpConSize = grpConSize;
	}

	/**
	 * @return the grpCon
	 */
	public long getGrpCon() {
		return grpCon;
	}

	/**
	 * @param grpCon the grpCon to set
	 */
	public void setGrpCon(long grpCon) {
		this.grpCon = grpCon;
	}

	/**
	 * @return the grpPrepay
	 */
	public long getGrpPrepay() {
		return grpPrepay;
	}

	/**
	 * @param grpPrepay the grpPrepay to set
	 */
	public void setGrpPrepay(long grpPrepay) {
		this.grpPrepay = grpPrepay;
	}

	public String getGroupProductName() {
		return groupProductName;
	}

	public void setGroupProductName(String groupProductName) {
		this.groupProductName = groupProductName;
	}

	/**
	 * @return the payedSum
	 */
	public long getPayedSum() {
		return payedSum;
	}

	/**
	 * @param payedSum the payedSum to set
	 */
	public void setPayedSum(long payedSum) {
		this.payedSum = payedSum;
	}
 
 
}
