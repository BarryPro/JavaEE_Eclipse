package com.sitech.acctmgr.atom.dto.invoice;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.sitech.acctmgr.atom.domains.invoice.InvCondEntity;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 * 
 * <p>
 * Title:
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2014
 * </p>
 * <p>
 * Company: SI-TECH
 * </p>
 * 
 * @author
 * @version 1.0
 */
@SuppressWarnings("unchecked")
public class S8248SubConInvcCompInDTO extends CommonInDTO {

	private static final long serialVersionUID = -4378751170604446023L;

	@ParamDesc(path = "BUSI_INFO.BEGIN_MON", cons = ConsType.CT001, type = "int", len = "10", desc = "开始年月", memo = "略")
	private int beginMon;

	@ParamDesc(path = "BUSI_INFO.END_MON", cons = ConsType.CT001, type = "int", len = "10", desc = "结束年月", memo = "略")
	private int endMon;

	@ParamDesc(path = "BUSI_INFO.ACCT_LIST", cons = ConsType.PLUS, type = "compx", len = "1", desc = "账户列表", memo = "略")
	private List<InvCondEntity> invCondList;
	@ParamDesc(path = "BUSI_INFO.CONINFO_FLAG", cons = ConsType.QUES, type = "int", len = "1", desc = "查询主账户信息标示", memo = "0：查询，1：不查询")
	private int conInfoFlag;
	@ParamDesc(path = "BUSI_INFO.CONTRACT_NO", cons = ConsType.CT001, type = "long", len = "20", desc = "账号", memo = "略")
	private long contractNo;

	@ParamDesc(path = "BUSI_INFO.ACROSS_FLAG", cons = ConsType.CT001, type = "int", len = "1", desc = "跨库标志", memo = "略")
	private long acrossFlag = 0;

	public long getAcrossFlag() {
		return acrossFlag;
	}

	public void setAcrossFlag(long acrossFlag) {
		this.acrossFlag = acrossFlag;
	}

	public int getBeginMon() {
		return beginMon;
	}

	public void setBeginMon(int beginMon) {
		this.beginMon = beginMon;
	}

	public int getEndMon() {
		return endMon;
	}

	public void setEndMon(int endMon) {
		this.endMon = endMon;
	}

	public List<InvCondEntity> getInvCondList() {
		return invCondList;
	}

	public void setInvCondList(List<InvCondEntity> invCondList) {
		this.invCondList = invCondList;
	}

	public int getConInfoFlag() {
		return conInfoFlag;
	}

	public void setConInfoFlag(int conInfoFlag) {
		this.conInfoFlag = conInfoFlag;
	}

	public long getContractNo() {
		return contractNo;
	}

	public void setContractNo(long contractNo) {
		this.contractNo = contractNo;
	}

	/* (non-Javadoc)
	 * 
	 * @see com.sitech.acctmgr.common.dto.CommonInDTO#decode(com.sitech.jcfx.dt.MBean ) */
	@Override
	public void decode(MBean arg0) {
		// TODO Auto-generated method stub
		super.decode(arg0);

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("contractNo")))) {
			contractNo = ValueUtils.longValue(arg0.getStr(getPathByProperName("contractNo")));
		} else {
			throw new BusiException(AcctMgrError.getErrorCode("8248", "01002"), "入参帐户不能为空！");
		}

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("conInfoFlag")))) {
			conInfoFlag = ValueUtils.intValue(arg0.getStr(getPathByProperName("conInfoFlag")));
		}

		if (StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("acrossFlag")))) {
			acrossFlag = ValueUtils.longValue(arg0.getStr(getPathByProperName("acrossFlag")));
		}

		if (arg0.getList(getPathByProperName("invCondList")) != null && arg0.getList(getPathByProperName("invCondList")).size() > 0) {
			invCondList = new ArrayList<InvCondEntity>();
			for (Map<String, Object> invConMap : arg0.getList(getPathByProperName("invCondList"), Map.class)) {

				String jsonStr = JSON.toJSONString(invConMap);
				invCondList.add(JSON.parseObject(jsonStr, InvCondEntity.class));
			}
		} else {
			throw new BusiException(AcctMgrError.getErrorCode("8248", "01003"), "发票账号集合不能为空！");
		}

		if (StringUtils.isNotEmptyOrNull(getPathByProperName("beginMon"))) {
			this.setBeginMon(Integer.parseInt(arg0.getStr(getPathByProperName("beginMon"))));
		} else {
			throw new BusiException(AcctMgrError.getErrorCode("8248", "01001"), "开始月份不能为空！");
		}

		if (StringUtils.isNotEmptyOrNull(getPathByProperName("endMon"))) {
			this.setEndMon(Integer.parseInt(arg0.getStr(getPathByProperName("endMon"))));
		} else {
			throw new BusiException(AcctMgrError.getErrorCode("8248", "01002"), "结束月份不能为空！");
		}

	}

}
