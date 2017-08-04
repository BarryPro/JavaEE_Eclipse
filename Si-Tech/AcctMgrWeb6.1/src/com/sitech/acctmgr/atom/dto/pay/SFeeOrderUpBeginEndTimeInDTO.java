package com.sitech.acctmgr.atom.dto.pay;


import static com.sitech.acctmgr.common.AcctMgrError.getErrorCode;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.annotation.JSONField;
import com.sitech.acctmgr.atom.domains.pay.OriginEntity;
import com.sitech.acctmgr.atom.domains.pay.PayInfoEntity;
import com.sitech.acctmgr.common.dto.CommonInDTO;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;

/**
 *
 * <p>Title:   </p>
 * <p>Description:   </p>
 * <p>Copyright: Copyright (c) 2014</p>
 * <p>Company: SI-TECH </p>
 * @author 
 * @version 1.0
 */
public class SFeeOrderUpBeginEndTimeInDTO extends CommonInDTO{

	private static final long serialVersionUID = -3682083701969326333L;

	@ParamDesc(path="OPR_INFO.ORDER_LINE_ID",cons=ConsType.QUES,type="String",len="40",desc="外部流水",memo="略")
	private String foreignSn;
	
	@ParamDesc(path="OPR_INFO.OP_TIME",cons=ConsType.QUES,type="String",len="14",desc="外部时间",memo="外部缴费时间，可空，格式为YYYYMMDDHHMISS")
	private String foreignTime;//外部缴费时间，可空，格式为YYYYMMDDHHMISS
	
	@ParamDesc(path="BUSI_INFO.ENTITY_LIST",cons=ConsType.PLUS,type="complex",len="1",desc="要更新的数据列表",memo="略")
	private	List<OriginEntity>	originList = new ArrayList<OriginEntity>();

	
	
	public void decode(MBean arg0){
		
		super.decode(arg0);
		
		foreignSn = arg0.getStr(getPathByProperName("foreignSn"));
		foreignTime = arg0.getStr(getPathByProperName("foreignTime"));
		
		List<Map<String, Object>> originListTmp = (List<Map<String, Object>>)arg0.getList(getPathByProperName("originList"));
		for(Map<String, Object> entityTmp : originListTmp){
    		String jsonStr = JSON.toJSONString(entityTmp);
    		log.debug("json: " + jsonStr);
    		this.originList.add(JSON.parseObject(jsonStr, OriginEntity.class));
		}
	}



	


}
