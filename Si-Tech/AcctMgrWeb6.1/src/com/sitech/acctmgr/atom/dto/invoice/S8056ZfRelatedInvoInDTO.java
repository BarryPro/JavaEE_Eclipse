package com.sitech.acctmgr.atom.dto.invoice;

import com.alibaba.fastjson.JSON;
import com.sitech.acctmgr.atom.domains.invoice.InvoInfoEntity;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
@SuppressWarnings("unchecked")
public class S8056ZfRelatedInvoInDTO extends CommonInDTO {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3173667478463355136L;
	
	@ParamDesc(path="BUSI_INFO.INV_LIST",cons=ConsType.PLUS,type="compx",len="1",desc="发票列表",memo="略")
	private List<InvoInfoEntity> invList;
	
	@ParamDesc(path="BUSI_INFO.ACROSS_FLAG",cons=ConsType.PLUS,type="int",len="2",desc="跨库标志",memo="0:不跨库，1：跨库操作")
	private int acrossFlag;
	@ParamDesc(path="BUSI_INFO.PAY_YEARMONTH",cons=ConsType.PLUS,type="int",len="10",desc="缴费年月",memo="略")
	protected int payYm;
	@ParamDesc(path="BUSI_INFO.QRY_TYPE",cons=ConsType.CT001,type="int",len="3",desc="查询方式",memo="0:按用户查询，1:按账户查询，2:按集团虚拟号，不传按账户类型决定")
	protected int qryType;
	
	protected String dbid;
	
	
	public int getQryType() {
		return qryType;
	}

	public void setQryType(int qryType) {
		this.qryType = qryType;
	}

	/**
	 * @return the payYm
	 */
	public int getPayYm() {
		return payYm;
	}

	/**
	 * @param payYm the payYm to set
	 */
	public void setPayYm(int payYm) {
		this.payYm = payYm;
	}

	/**
	 * @return the dbid
	 */
	public String getDbid() {
		return dbid;
	}

	/**
	 * @param dbid the dbid to set
	 */
	public void setDbid(String dbid) {
		this.dbid = dbid;
	}

	/**
	 * @return the acrossFlag
	 */
	public int getAcrossFlag() {
		return acrossFlag;
	}

	/**
	 * @param acrossFlag the acrossFlag to set
	 */
	public void setAcrossFlag(int acrossFlag) {
		this.acrossFlag = acrossFlag;
	}

	/**
	 * @return the invList
	 */
	public List<InvoInfoEntity> getInvList() {
		return invList;
	}

	/**
	 * @param invList the invList to set
	 */
	public void setInvList(List<InvoInfoEntity> invList) {
		this.invList = invList;
	}
	
	
	@Override
	public void decode(MBean arg0) {
		// TODO Auto-generated method stub
		super.decode(arg0);
		log.debug("arg0="+arg0.toString());
		if(arg0.getList(getPathByProperName("invList"))!=null){
			System.out.println("333333");
			invList = new ArrayList<InvoInfoEntity>();
			for(Map<String,Object> invMap:arg0.getList(getPathByProperName("invList"),Map.class)){
				System.out.println("444444");
				String onlineFlagStr = StringUtils.castToString(invMap.get("ONLINE_FLAG"))==null?"":StringUtils.castToString(invMap.get("ONLINE_FLAG"));
				int onlineFlag = onlineFlagStr.equals("")?0:ValueUtils.intValue(invMap.get("ONLINE_FLAG"));
				System.out.println("555555"+onlineFlag);
				if(onlineFlag==-1){
					System.out.println("666666");
					InvoInfoEntity invEntiy = new InvoInfoEntity();
					invEntiy.setBillCycleStr(invMap.get("BILLCYCLE_STR").toString());
					invEntiy.setInvType(invMap.get("INV_TYPE").toString());
					invEntiy.setOnlineFlag(ValueUtils.intValue(invMap.get("ONLINE_FLAG")));
					invEntiy.setPrintArray(ValueUtils.intValue(invMap.get("PRINT_ARRAY")));
					System.out.println("11111"+invMap.get("PRINT_SN").toString());
					invEntiy.setPrintSnStr(invMap.get("PRINT_SN").toString());
					invEntiy.setPrintSn(ValueUtils.longValue(invMap.get("PRINT_SN").toString()));
					invList.add(invEntiy);
				}else{
					String jsonStr = JSON.toJSONString(invMap);
					InvoInfoEntity invEntiy = JSON.parseObject(jsonStr,InvoInfoEntity.class);
					invList.add(invEntiy);
				}
				
			}
		}
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("acrossFlag"))))
		{
			acrossFlag = ValueUtils.intValue(arg0.getStr(getPathByProperName("acrossFlag")));
		}
		
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("payYm")))){
			payYm = ValueUtils.intValue(arg0.getStr(getPathByProperName("payYm")));
		}
		
		if(StringUtils.isNotEmptyOrNull(arg0.getStr(getPathByProperName("qryType")))){
			qryType = ValueUtils.intValue(arg0.getStr(getPathByProperName("qryType")));
		}
		
		
		dbid = arg0.getHeaderStr("DB_ID");
		log.debug("invList="+invList);
	}
	
	
}
