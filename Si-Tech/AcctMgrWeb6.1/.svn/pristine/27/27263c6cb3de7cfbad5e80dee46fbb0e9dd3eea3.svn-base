package com.sitech.acctmgr.atom.impl.detail;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.detail.DetailQryRecord;
import com.sitech.acctmgr.atom.dto.detail.S8426QryRecordQryInDTO;
import com.sitech.acctmgr.atom.dto.detail.S8426QryRecordQryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IRecord;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgr.inter.detail.I8426;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({
    @ParamType(c = S8426QryRecordQryInDTO.class, m = "qryRecordQry", oc = S8426QryRecordQryOutDTO.class)
})
public class S8426 extends AcctMgrBaseService implements I8426 {
	
	private IRecord record;
	
	@Override
	public OutDTO qryRecordQry(InDTO inParam) {
		
		S8426QryRecordQryInDTO inDto = (S8426QryRecordQryInDTO) inParam;
        log.debug("inDto=" + inDto.getMbean());
        
        int pageNum = inDto.getPageNum();
        
		Map<String, Object> inMap = new HashMap<String, Object>();
		if(inDto.getLoginNo()!=null &&!"".equals(inDto.getLoginNo())){
			inMap.put("LOGIN_NO", inDto.getLoginNo());
		}
		if(inDto.getBeginTime()!=null){
			inMap.put("BEGIN_TIME", inDto.getBeginTime());
		}
		if(inDto.getEndTime()!=null){
			inMap.put("END_TIME", inDto.getEndTime());
		}
		if(inDto.getBeginTime()!=null){
			inMap.put("BEGIN_MONTH", inDto.getBeginTime().substring(0, 6));
		}
		if(inDto.getEndTime()!=null){
			inMap.put("END_MONTH", inDto.getBeginTime().substring(0, 6));
		}
		inMap.put("OP_CODE", "8121");  //8121即为安保详单
		
		Map<String, Object> qryRecdMap = record.getDetailRecordMap(inMap, pageNum);
		
		List<DetailQryRecord> recordList = (List<DetailQryRecord>) qryRecdMap.get("RECORD_LIST");
		
		S8426QryRecordQryOutDTO outDto = new S8426QryRecordQryOutDTO();
		outDto.setQryRecordsList(recordList);
		outDto.setSum(ValueUtils.intValue(qryRecdMap.get("SUM")));
		
		log.debug("outDto=" + outDto.toJson());
		return outDto;
	}
	
	
	public IRecord getRecord() {
		return record;
	}
	public void setRecord(IRecord record) {
		this.record = record;
	}
	

}
