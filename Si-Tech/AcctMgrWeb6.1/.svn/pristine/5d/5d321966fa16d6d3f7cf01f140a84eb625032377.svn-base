package com.sitech.acctmgr.atom.busi.pay;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.pay.inter.IPayDoInter;
import com.sitech.acctmgr.atom.domains.pay.PayOutEntity;
import com.sitech.acctmgr.atom.dto.pay.S8000CfmInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8000CfmOutDTO;
import com.sitech.acctmgr.atom.dto.pay.S8056ForeignInDTO;
import com.sitech.acctmgr.atom.dto.pay.S8056ForeignOutDTO;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.acctmgr.inter.pay.I8000;
import com.sitech.acctmgr.inter.pay.I8056;
import com.sitech.common.utils.StringUtils;
import com.sitech.jcfx.dt.DataBus;
import com.sitech.jcfx.dt.DtKit;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;

/**
 * @Title:   []
 * @Description: 
 * @Date : 2015年4月9日下午7:16:00
 * @Company: SI-TECH
 * @author : LIJXD
 * @version : 1.0
 * @modify history
 *  <p>修改日期    修改人   修改目的<p> 	
 */
@SuppressWarnings("unchecked")
public class PayDoInter extends BaseBusi implements IPayDoInter {

	
	protected I8000 s8000;
	protected I8056 s8056;
 
	/**
	* 名称：MBean转换成DTO
	* @param MBean
	* @param DTO
	* 
	* @return DTO
	* @throws 
	*/
	protected InDTO parseInDTO(MBean in, Class<?> clazz)
	{
		InDTO inDTO = DtKit.toDTO(in, clazz);
/*		DataBus.setMBean(in);
		DataBus.setInDTO(inDTO);*/
		return inDTO;
	}
	
	/** (non-Javadoc)
	 * @see com.sitech.acctmgr.atom.busi.pay.inter.IPayDoInter#doPay8000Inter(java.util.Map)
	 * 缴费落地函数
	 */
	@Override
	public Map<String, Object> doS8000Cfm(Map<String, Object> inParam) {
		// TODO Auto-generated method stub
		Map<String, Object> outPayMap = new HashMap<String, Object>();
		int retCode=0;
		List<PayOutEntity> payOutList = null;
		String totalDate = null;
   
		/**调用缴费接口缴费*/
		//缴费入参
		try{
			MBean cfmIn = new MBean();
			if(StringUtils.isNotEmptyOrNull(inParam.get("Header"))){
				cfmIn.setHeader((Map<String, Object>) inParam.get("Header"));
			}
			
			if(StringUtils.isNotEmptyOrNull(inParam.get("GROUP_ID"))){
				cfmIn.addBody("OPR_INFO.GROUP_ID", inParam.get("GROUP_ID"));
			}
			cfmIn.addBody("OPR_INFO.LOGIN_NO", inParam.get("LOGIN_NO"));
			cfmIn.addBody("OPR_INFO.OP_CODE", inParam.get("OP_CODE"));
			if(StringUtils.isNotEmptyOrNull(inParam.get("PHONE_NO"))){
				cfmIn.addBody("BUSI_INFO.PHONE_NO", inParam.get("PHONE_NO"));
			}
			if(StringUtils.isNotEmptyOrNull(inParam.get("CONTRACT_NO"))){
				cfmIn.addBody("BUSI_INFO.CONTRACT_NO", inParam.get("CONTRACT_NO"));
			}
			cfmIn.addBody("BUSI_INFO.PAY_LIST", inParam.get("PAY_LIST"));
			cfmIn.addBody("BUSI_INFO.PAY_PATH", inParam.get("PAY_PATH"));
			cfmIn.addBody("BUSI_INFO.PAY_METHOD", inParam.get("PAY_METHOD"));
			
			if(StringUtils.isNotEmptyOrNull(inParam.get("CTRL_FLAG"))){
				cfmIn.addBody("BUSI_INFO.CTRL_FLAG", inParam.get("CTRL_FLAG"));
			}
			if(StringUtils.isNotEmptyOrNull(inParam.get("PAY_NOTE"))){
				cfmIn.addBody("BUSI_INFO.PAY_NOTE", inParam.get("PAY_NOTE"));
			}
			if(StringUtils.isNotEmptyOrNull(inParam.get("DELAY_RATE"))){
				cfmIn.addBody("BUSI_INFO.DELAY_RATE", inParam.get("DELAY_RATE"));
			}
			if(StringUtils.isNotEmptyOrNull(inParam.get("BANK_CODE"))){
				cfmIn.addBody("BUSI_INFO.BANK_CODE", inParam.get("BANK_CODE"));
			}
			if(StringUtils.isNotEmptyOrNull(inParam.get("CHECK_NO"))){
				cfmIn.addBody("BUSI_INFO.CHECK_NO", inParam.get("CHECK_NO"));
			}	
			if(StringUtils.isNotEmptyOrNull(inParam.get("FOREIGN_SN"))){
				cfmIn.addBody("BUSI_INFO.FOREIGN_SN", inParam.get("FOREIGN_SN"));
			}
			if(StringUtils.isNotEmptyOrNull(inParam.get("FOREIGN_TIME"))){
				cfmIn.addBody("BUSI_INFO.FOREIGN_TIME", inParam.get("FOREIGN_TIME"));
			}	
		
			log.info("------> 8000 调用缴费服入参信息:"+cfmIn);
		
			InDTO in = parseInDTO(cfmIn, S8000CfmInDTO.class);
			S8000CfmOutDTO outDto = null;
			outDto = (S8000CfmOutDTO)s8000.cfm(in);
			payOutList = outDto.getPaySnList();
			totalDate = outDto.getTotalDate();
			
			log.debug("-------> 8000 调用缴费服务出参:" + outDto.toJson());
			retCode = 0;//处理成功
		} catch(Exception e) {
			e.printStackTrace();
			/**出参根据 retCode，如果是1，手动回滚*/
			log.info("------> 8000调用缴费服务异常");
			retCode = 1; //处理失败
		}
		outPayMap.put("RET_CODE", retCode);
		outPayMap.put("TOTAL_DATE", totalDate);
		outPayMap.put("PAY_LIST", payOutList);	
		return outPayMap;
	}

	
	public Map<String, Object> doS8056Foreign(Map<String, Object> inParam) {
		// TODO Auto-generated method stub
		Map<String, Object> outBackMap = new HashMap<String, Object>();
		int retCode=0;  //0:调用服务成功，其他:调用服务失败
		List<PayOutEntity> paybackPaysn = null;  //缴费冲正流水
		String totalDate = null;   //冲正时间
		
		try{
			// 服务入参
			MBean inBack = new MBean();
			if(StringUtils.isNotEmptyOrNull(inParam.get("Header"))){
				inBack.setHeader((Map<String, Object>) inParam.get("Header"));
			}
			
			inBack.addBody("OPR_INFO.GROUP_ID",inParam.get("GROUP_ID"));
			inBack.addBody("OPR_INFO.LOGIN_NO",inParam.get("LOGIN_NO"));
			inBack.addBody("OPR_INFO.OP_CODE",inParam.get("OP_CODE"));
			inBack.addBody("BUSI_INFO.PHONE_NO", inParam.get("PHONE_NO"));
			inBack.addBody("BUSI_INFO.PAY_DATE", inParam.get("PAY_DATE"));
			inBack.addBody("BUSI_INFO.FOREIGN_SN", inParam.get("FOREIGN_SN"));
			inBack.addBody("BUSI_INFO.PAY_PATH", inParam.get("PAY_PATH"));
			if (StringUtils.isNotEmptyOrNull(inParam.get("PAY_NOTE"))) {
				inBack.addBody("BUSI_INFO.PAY_NOTE", inParam.get("PAY_NOTE"));
			}
			inBack.addBody("BUSI_INFO.PAY_METHOD", inParam.get("PAY_METHOD"));
			log.info("调用外部流水冲正服务入参:" + inBack);

			InDTO in = parseInDTO(inBack, S8056ForeignInDTO.class);
			S8056ForeignOutDTO outDto = null;
			outDto = (S8056ForeignOutDTO)s8056.foreign(in);
			paybackPaysn = outDto.getPaybackSnList(); 
			totalDate = outDto.getTotalDate();
			
			log.debug("8003 调用外部流水冲正服务出参:" + outDto.toJson());
			retCode = 0;//处理成功

		} catch(Exception e) {
			e.printStackTrace();
			/**出参根据 retCode，如果是1，手动回滚*/
			log.info("------> 8003调用冲正服务异常");
			retCode = 1; //处理失败
		}
		
		outBackMap.put("RET_CODE", retCode);
		outBackMap.put("TOTAL_DATE", totalDate);
		outBackMap.put("PAY_BACK_SN", paybackPaysn);
		
		return outBackMap;
	}
	
	
	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.atom.busi.pay.inter.IPayDoInter#commit()
	 */
	@Override
	public void commit() {
		try {
			baseDao.getConnection().commit();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	} 

	/* (non-Javadoc)
	 * @see com.sitech.acctmgr.atom.busi.pay.inter.IPayDoInter#rollback()
	 */
	@Override
	public void rollback() {
		try {
			baseDao.getConnection().rollback();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public I8000 getS8000() {
		return s8000;
	}

	public void setS8000(I8000 s8000) {
		this.s8000 = s8000;
	}

	public I8056 getS8056() {
		return s8056;
	}

	public void setS8056(I8056 s8056) {
		this.s8056 = s8056;
	}

}
