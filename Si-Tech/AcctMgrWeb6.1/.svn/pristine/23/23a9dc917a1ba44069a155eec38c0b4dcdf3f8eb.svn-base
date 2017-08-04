package com.sitech.acctmgr.atom.impl.adj;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.domains.adj.BalCustRefundEntity;
import com.sitech.acctmgr.atom.domains.detail.ChannelDetail;
import com.sitech.acctmgr.atom.domains.detail.QueryTypeEntity;
import com.sitech.acctmgr.atom.dto.adj.S8084CfmInDTO;
import com.sitech.acctmgr.atom.dto.adj.S8084CfmOutDTO;
import com.sitech.acctmgr.atom.dto.adj.S8084GetBackBusiInDTO;
import com.sitech.acctmgr.atom.dto.adj.S8084GetBackBusiOutDTO;
import com.sitech.acctmgr.atom.dto.adj.S8084ListSPInfoInDTO;
import com.sitech.acctmgr.atom.dto.adj.S8084ListSPInfoOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IAdj;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.adj.I8084;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.service.client.ServiceUtil;


@ParamTypes({ @ParamType(m = "getBackBusi", c = S8084GetBackBusiInDTO.class, oc = S8084GetBackBusiOutDTO.class),
	@ParamType(m = "listSPInfo", c = S8084ListSPInfoInDTO.class, oc = S8084ListSPInfoOutDTO.class),
	@ParamType(m = "cfm", c = S8084CfmInDTO.class, oc = S8084CfmOutDTO.class)})
public class S8084 extends AcctMgrBaseService implements I8084{
	
	private IAdj adj;

	@Override
	public OutDTO getBackBusi(InDTO inParam) {
		// TODO Auto-generated method stub
		S8084GetBackBusiInDTO inDto = (S8084GetBackBusiInDTO)inParam;
		String detailType = inDto.getDetailType();
		log.debug("入参getBackBusi inDto-------->"+inDto.getMbean()+detailType);
		
		String interfaceName = "com_sitech_acctmgr_inter_query_IGetDetailTypeSvc_query";
		MBean mbean = new MBean(inDto.getMbean().toString());
		mbean.setBody("BUSI_INFO.DETAIL_TYPE", detailType);
		mbean.setHeader(inDto.getHeader());
		log.debug("调用查询业务种类接口开始"+mbean.toString());
		String outString = ServiceUtil.callService(interfaceName, mbean.toString());
		log.debug("调用查询业务种类接口结束" + outString);
		MBean outBean = new MBean(outString);
		List<QueryTypeEntity> detailTypeList = new ArrayList<QueryTypeEntity>();
		detailTypeList = (List<QueryTypeEntity>) outBean.getBodyList("OUT_DATA.DETAILTYPE_LIST");
		
		S8084GetBackBusiOutDTO outDto = new S8084GetBackBusiOutDTO();
		outDto.setDetailTypeList(detailTypeList);
		
		log.debug("出参getBackBusi outDto-------->"+outDto.toString());
		return outDto;
	}

	@Override
	public OutDTO listSPInfo(InDTO inParam) {
		// TODO Auto-generated method stub
		S8084ListSPInfoInDTO inDto = (S8084ListSPInfoInDTO)inParam;
		String phoneNo = inDto.getPhoneNo();
		long yearMonth = inDto.getYearMonth();
		String queryType = inDto.getQueryType();
		String loginNo = inDto.getLoginNo();
		log.debug("listSPInfo inDto-------->"+inDto.getMbean());
		
		//查询bal_custrefund_info中的SP信息
		Map<String,Object> inSPMap = new HashMap<String,Object>();
		inSPMap.put("PHONE_NO", phoneNo);
		inSPMap.put("QUERY_TYPE", queryType);
		inSPMap.put("YEAR_MONTH",yearMonth);
		List<BalCustRefundEntity> listSP = new ArrayList<BalCustRefundEntity>();
		listSP = adj.listSPInfo(inSPMap);
		
		long indexNo = 0L;
		
		//如果bal_custrefund_info没数据，则从详单接口进行查询入库
		if(listSP.size()==0){
			String interfaceName = "com_sitech_acctmgr_inter_detail_IDetailSvc_spQuery";
			MBean mbean = new MBean();
			mbean.setBody("BUSI_INFO.PHONE_NO", phoneNo);
			mbean.setBody("BUSI_INFO.YEAR_MONTH", String.valueOf(yearMonth));
			mbean.setBody("BUSI_INFO.QUERY_TYPE", queryType);
			mbean.setBody("BUSI_INFO.QUERY_FLAG", "1");
			mbean.setBody("OPR_INFO.LOGIN_NO", inDto.getLoginNo());
			mbean.setBody("OPR_INFO.GROUP_ID", inDto.getGroupId());
			mbean.setBody("OPR_INFO.OP_CODE", inDto.getOpCode());
			mbean.setHeader(inDto.getHeader());
			log.debug("调用SP详单接口开始");
			String outString = ServiceUtil.callService(interfaceName, mbean.toString());
			log.debug("调用SP详单接口结束" + outString);
			MBean outBean = new MBean(outString);
			List<String> detailStrList = new ArrayList<String>();
			List<ChannelDetail> channelDetailList = outBean.getBodyList("OUT_DATA.DETAIL_INFO",ChannelDetail.class);
	
			//进行入表
			List<Map<String,Object>> iList = new ArrayList<Map<String,Object>>();
			
			if(channelDetailList != null && channelDetailList.size() > 0) {
				for (ChannelDetail channelDetail : channelDetailList) {
					detailStrList = channelDetail.getDetailLines();
					for(String lineStr:detailStrList){
						 String[] fileds = StringUtils.splitByWholeSeparatorPreserveAllTokens(lineStr, "|");
						 String time = fileds[0];
						 String useType = fileds[1];
						 String operName = fileds[2];
						 String operCode = fileds[3];
						 String spName = fileds[4];
						 String spCode = fileds[5];
						 String feeTypeName = fileds[6];
						 String fee = fileds[7];
						 
						 //此处的time格式为2017/04/14 11:30:18 ，为了插入数据库转换日期格式
						 SimpleDateFormat sf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
						 SimpleDateFormat sf2 = new SimpleDateFormat("yyyyMMddHHmmss");
						 Calendar cal = Calendar.getInstance();
						 try {
						 	 Date y = new Date();
							 cal.setTime(sf.parse(time));
						 } catch (Exception e) {
							 // TODO Auto-generated catch block
							 e.printStackTrace();
						 }
						 
						 
						 BalCustRefundEntity balCustEnt = new BalCustRefundEntity();
						 //balCustEnt.setBackFlag(backFlag);
						 balCustEnt.setIndexNo(++indexNo);
						 balCustEnt.setFeeType(feeTypeName);
						 balCustEnt.setFeeValue(fee);
						 balCustEnt.setOperName(operName);
						 balCustEnt.setOperCode(operCode);
						 balCustEnt.setPhoneNo(phoneNo);
						 balCustEnt.setQueryType(queryType);
						 balCustEnt.setSpCode(spCode);
						 balCustEnt.setSpName(spName);
						 balCustEnt.setUserTime(sf2.format(cal.getTime()).toString());
						 balCustEnt.setUseType(useType);
						 balCustEnt.setYearMonth(String.valueOf(yearMonth));
						 listSP.add(balCustEnt);
						 
						 
						
						 
						 
						 Map<String,Object> iMap = new HashMap<String,Object>();
						 iMap.put("PHONE_NO", phoneNo);
						 iMap.put("QUERY_TYPE", queryType);
						 iMap.put("USE_TYPE", useType);
						 iMap.put("USE_TIME", sf2.format(cal.getTime()).toString());
						 iMap.put("OPER_NAME", operName);
						 iMap.put("OPER_CODE", operCode);
						 iMap.put("SP_NAME", spName);
						 iMap.put("SP_CODE", spCode);
						 iMap.put("FEE_TYPE", feeTypeName);
						 iMap.put("FEE_VALUE", fee);
						 //iMap.put("BACK_FLAG", );
						 iMap.put("YEAR_MONTH", yearMonth);	
						 iList.add(iMap);
						 log.error(iList.toString()+"000000000000000000");
						 
					}
						
				}
			}
			adj.insertSPInfo(iList);
			 
		}
		
		S8084ListSPInfoOutDTO outDto = new S8084ListSPInfoOutDTO();
		outDto.setBalCustRefundList(listSP);
		outDto.setLenBalCustRefund(listSP.size());
		log.debug("listSPInfo outDto-------->"+outDto.toJson());
		return outDto;
	}
	
	@Override
	public OutDTO cfm(InDTO inParam) {
		// TODO Auto-generated method stub
		S8084CfmInDTO   inDto = (S8084CfmInDTO)inParam;
		long sumFee = inDto.getSumFee();
		
		
		
		log.debug("cfm inDto-------->"+inDto.getMbean());
		List<BalCustRefundEntity> inList = inDto.getBalCustRefundList();
		
		
		String interfaceName = "com_sitech_acctmgr_inter_adj_I8041Svc_cfm";
		MBean mbean = new MBean();
		mbean.setHeader(inDto.getHeader());
		mbean.setBody("OPR_INFO.OP_CODE", inDto.getOpCode());
		mbean.setBody("OPR_INFO.GROUP_ID", inDto.getGroupId());
		mbean.setBody("OPR_INFO.LOGIN_NO", inDto.getLoginNo());
		
		
		for(BalCustRefundEntity balCust:inList){
			
			
			String indexNo = String.valueOf(balCust.getIndexNo());
			
			//即使不选择任何SP复选框，动态表单也会默认传一个空的进来，所以进行一次过滤
			if(StringUtils.isEmptyOrNull(indexNo) || balCust.getIndexNo()==0 || "0".equals(indexNo)){
				continue;
			}
			mbean.setBody("BUSI_INFO.PHONE_NO", balCust.getPhoneNo());
			mbean.setBody("BUSI_INFO.BACK_MONEY", Long.parseLong(balCust.getFeeValue()));
			
			if(inDto.getDoubleFlag().equals("2")){
				mbean.setBody("BUSI_INFO.COMP_MONEY", Long.parseLong(balCust.getFeeValue())*2);
			}else{
				mbean.setBody("BUSI_INFO.COMP_MONEY", Long.parseLong(balCust.getFeeValue()));
			}
			//退预存
			mbean.setBody("BUSI_INFO.RETURN_TYPE", "1");
			mbean.setBody("BUSI_INFO.BACK_TYPE", inDto.getDoubleFlag());
			mbean.setBody("BUSI_INFO.ERR_SERIAL", inDto.getErrSerial());
			mbean.setBody("BUSI_INFO.SP_DETAIL_EMP", balCust.getSpCode());
			mbean.setBody("BUSI_INFO.SP_DETAIL_BUS", balCust.getOperCode());
			mbean.setBody("BUSI_INFO.SP_DETAIL_EMP_NAME", balCust.getSpName());
			mbean.setBody("BUSI_INFO.SP_DETAIL_BUS_NAME", balCust.getOperName());
			mbean.setBody("BUSI_INFO.SUB_TYPE",inDto.getSubType());
			mbean.setBody("BUSI_INFO.BILL_TYPE", inDto.getBillType());
			mbean.setBody("BUSI_INFO.IVR_FLAG", "5");
			//1是非SP，2是SP
			mbean.setBody("BUSI_INFO.SP_FLAG", "2");
			mbean.setBody("BUSI_INFO.CHECK_TIME",inDto.getSubTime());
			
			 //此处的time格式为2017/04/14 11:30:18 ，为了插入数据库转换日期格式
			 SimpleDateFormat sf = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
			 SimpleDateFormat sf2 = new SimpleDateFormat("yyyyMMddHHmmss");
			 Calendar cal = Calendar.getInstance();
			 try {
			 	 Date y = new Date();
				 cal.setTime(sf.parse(balCust.getUserTime()));
			 } catch (Exception e) {
				 // TODO Auto-generated catch block
				 e.printStackTrace();
			 }
			
			mbean.setBody("BUSI_INFO.LAST_TIME", sf2.format(cal.getTime()).toString());
			
			
			mbean.setBody("BUSI_INFO.ADJ_REASON", "1003|1006|"+inDto.getBackBusi());
			mbean.setBody("BUSI_INFO.UNIT_PRICE", String.valueOf(balCust.getFeeValue()));
			
			mbean.setBody("BUSI_INFO.PAGE_FLAG","3");
			mbean.setBody("BUSI_INFO.REMARK",inDto.getRemark());
			//mbean.setBody("BUSI_INFO.QUANTITY", "1");
			log.debug("调用退费接口开始");
			log.error("SP退费入参------------>"+mbean.toString());
			String outString = ServiceUtil.callService(interfaceName, mbean.toString());
			log.debug("调用退费接口结束" + outString);	
		}
		
		//判断是否进行补充退费
		String payFee = String.valueOf(inDto.getPayFee());
		if(StringUtils.isNotEmptyOrNull(String.valueOf(inDto.getPayFee()))){
			mbean.setBody("BUSI_INFO.PHONE_NO",inDto.getPhoneNo());
			mbean.setBody("BUSI_INFO.BACK_MONEY", inDto.getPayFee());
			
			if(inDto.getDoubleFlag().equals("2")){
				mbean.setBody("BUSI_INFO.COMP_MONEY", inDto.getPayFee()*2);
			}else{
				mbean.setBody("BUSI_INFO.COMP_MONEY", inDto.getPayFee());
			}
			
			
			//退预存
			mbean.setBody("BUSI_INFO.RETURN_TYPE", "1");
			mbean.setBody("BUSI_INFO.BACK_TYPE", inDto.getDoubleFlag());
			mbean.setBody("BUSI_INFO.ERR_SERIAL", inDto.getErrSerial());
			mbean.setBody("BUSI_INFO.SUB_TYPE",inDto.getSubType());
			mbean.setBody("BUSI_INFO.BILL_TYPE", inDto.getBillType());
			//1是非SP，2是SP
			mbean.setBody("BUSI_INFO.SP_FLAG", "1");
			mbean.setBody("BUSI_INFO.CHECK_TIME",inDto.getSubTime());
			
			
			mbean.setBody("BUSI_INFO.ADJ_REASON", "1003|1006|"+inDto.getBackBusi());
			mbean.setBody("BUSI_INFO.UNIT_PRICE", payFee);
			mbean.setBody("BUSI_INFO.IVR_FLAG", "5");
			mbean.setBody("BUSI_INFO.PAGE_FLAG","3");
			mbean.setBody("BUSI_INFO.REMARK", inDto.getRemark());
			mbean.setBody("BUSI_INFO.QUANTITY", "1");
			log.debug("调用退费接口开始");
			log.error("补充退费入参------------>"+mbean.toString());
			String outString = ServiceUtil.callService(interfaceName, mbean.toString());
			log.debug("调用退费接口结束" + outString);	
		}
		
		
		S8084CfmOutDTO outDto = new S8084CfmOutDTO();
		log.debug("cfm outDto-------->"+outDto.toString());
		return outDto;
	}
	

	public IAdj getAdj() {
		return adj;
	}

	public void setAdj(IAdj adj) {
		this.adj = adj;
	}
	
}
