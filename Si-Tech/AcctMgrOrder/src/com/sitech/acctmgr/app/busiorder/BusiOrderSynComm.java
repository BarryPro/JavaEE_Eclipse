package com.sitech.acctmgr.app.busiorder;

import java.io.UnsupportedEncodingException;
import java.lang.Thread.UncaughtExceptionHandler;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javassist.expr.Instanceof;

import org.springframework.aop.framework.AopProxyUtils;
import org.springframework.context.i18n.LocaleContext;

import com.sitech.acctmgr.app.busiorder.cachecfg.BusiOdrCfgCache;
import com.sitech.acctmgr.app.common.InterBusiConst;
import com.sitech.acctmgr.app.odrBlob.OdrLineContDAO;
import com.sitech.acctmgr.app.odrBlob.OdrLineContVO;
import com.sitech.acctmgr.app.odrBlob.OdrLineErrVO;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.jcf.context.LocalContextFactory;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.context.JCFContext;
import com.sitech.jcfx.dt.DtKit;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;
import com.sitech.jcfx.util.DateUtil;
import com.thoughtworks.xstream.mapper.Mapper.Null;

public class BusiOrderSynComm extends BaseBusi {
	
	OdrLineContDAO odrLineContDAO;
	
	public OdrLineContDAO getOdrLineContDAO() {
		return odrLineContDAO;
	}

	public void setOdrLineContDAO(OdrLineContDAO odrLineContDAO) {
		this.odrLineContDAO = odrLineContDAO;
	}

	/*public BusiOrderSynComm() {
		Thread.setDefaultUncaughtExceptionHandler(new BusiOdrExceptionHandler());
	}*/
	
	protected MBean checkBusiOrder(String inBusiOdr) {
		MBean mBusiOdr = null;
		mBusiOdr = new MBean(inBusiOdr);
		if (null == mBusiOdr.getHeader())
			return null;
		if (null == mBusiOdr.getBody())
			return null;
		return mBusiOdr;
	}
	
	protected Map<String, Object> getFuncNameByOpCode(String inOpCode) {
		
		Map<String, Object> retMap = new HashMap<String, Object>();
		retMap = BusiOdrCfgCache.getConfigMapByCode(inOpCode);
		if (retMap != null && retMap.size() == 0)
			return null;
		
		return retMap;
	}
	
	protected boolean dealInvokeBusiOdr(MBean mBusiOdr, Map<String, Object> inRstMap) throws Exception {
		
		boolean out_result = true;

		// Java反射机制调用配置中接口方法
		//调用InDTO方法，反射失败调用MBean方法。否则入ERR表
		invokeByInDto(mBusiOdr, inRstMap);
		
		//返回Map中置RESULT=SUCC
		if (null == inRstMap.get("RESULT"))
			inRstMap.put("RESULT", "SUCC");
		
		return out_result;
	}
	
	/**
	 * Title 通过反射调用参数为InDto的方法
	 * desc:反射报错则调用MBean方法
	 * @param mbOdr
	 * @param inRstMap
	 * @return
	 */
	protected boolean invokeByInDto(MBean mbOdr, Map<String, Object> inRstMap) throws Exception {
		
		Method mt = null;
		Object beanObject = LocalContextFactory.getInstance().getBean(inRstMap.get("BEAN").toString());
		String sFuncName =inRstMap.get("FUNC").toString();
		
		try {
			log.debug("------业务工单调用bean接口 stt----"+beanObject.toString()+"mBUsiodr="+mbOdr.toString());
			//转换MBean为InDTO类型
			InDTO inDTO = null;
			try {
				inDTO = transMBeanToInDTO(mbOdr, sFuncName, beanObject);
				mt = beanObject.getClass().getMethod(sFuncName, InDTO.class);
			} catch (Exception e) {
				log.error("调用DTO服务实例报错,尝试MBean方法："+e.toString());
				StackTraceElement[] error = e.getStackTrace();
	            for (StackTraceElement stackTraceElement : error){
	                log.error(stackTraceElement.toString());
	            }
				mt = beanObject.getClass().getMethod(sFuncName, MBean.class);
				//没报错,调用MBean方法
				invokeByMBean(mt, beanObject, mbOdr, inRstMap);
				return true;
			}
			
			//反射调用接口
			OutDTO outdto = (OutDTO) mt.invoke(beanObject, inDTO);
			log.debug("------业务工单调用bean接口 结束----"+outdto.toString()+mt.getReturnType().toString());
			if (!outdto.getReturnCode().equals("0")) {
				//记录ERR表
				inRstMap.put("RESULT", "FAIL");
				inRstMap.put("ERR_CODE", "0003");
				inRstMap.put("ERR_MSG", "deal busiodr return false.");
				inputBusiOdrErrForReDeal(mbOdr, inRstMap);
			}
		} catch (InvocationTargetException e) {
            log.error("反射调用服务实例报错："+e.getTargetException());
            StackTraceElement[] error = e.getStackTrace();
            for (StackTraceElement stackTraceElement : error){
                log.error(stackTraceElement.toString());
            }
			throw new BusiException(AcctMgrError.getErrorCode("0010","10051"), "INDTO业务数据异常:"+e.getTargetException());
		} catch (Exception e) {			
			//报错
			log.error("调用服务实例报错："+e.toString());
            StackTraceElement[] error = e.getStackTrace();
            for (StackTraceElement stackTraceElement : error){
                log.error(stackTraceElement.toString());
            }
			throw new BusiException(AcctMgrError.getErrorCode("0010","10052"), "INDTO业务数据异常:"+e.toString());
		}
		return true;
	}
	
	protected boolean inputBusiOdrErrForReDeal(MBean inOrderBean, Map<String, Object> rstMap) {
		
		//String sDealRst = "";
		long lCreateAccept = getInterCreateAccept(18);

		Map<String, Object> opr_info = getLoginAccpet(inOrderBean, rstMap.get("SEQ_NAME").toString());
		log.debug("----------opr_info="+opr_info.toString());
		String op_code = opr_info!=null?opr_info.get("OP_CODE").toString():"";
		String log_act = opr_info!=null?opr_info.get("ORDER_LINE_ID").toString():"";
		String logn_no = opr_info!=null?opr_info.get("LOGIN_NO").toString():"";
		
		
		byte[] byte_cont = null;
		try {
			byte_cont = inOrderBean.toString().getBytes("GBK");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		Map<String, Object> busiInfo = getOdrInfo(inOrderBean);
		
		OdrLineErrVO odrLineErrVO = new OdrLineErrVO();
		odrLineErrVO.setGsTopicId("T109BusiOdr");
		odrLineErrVO.setGbContent(byte_cont);

		odrLineErrVO.setGsBusiidType(busiInfo.get("BUSIID_TYPE").toString());
		odrLineErrVO.setGsBusiidNo(busiInfo.get("BUSIID_NO").toString());
		odrLineErrVO.setGsDataSrc(rstMap.get("BUSI_CODE").toString());
		odrLineErrVO.setGsOpCode(op_code);
		odrLineErrVO.setGsLoginNo(logn_no);
		
		odrLineErrVO.setGlCreatAct(lCreateAccept);
		odrLineErrVO.setGsLoginAct(log_act);
		odrLineErrVO.setGsErrCode(rstMap.get("ERR_CODE").toString());
		odrLineErrVO.setGsErrMsg(rstMap.get("ERR_MSG").toString());
		odrLineContDAO.insertOdrErrCont(odrLineErrVO);
		
		return true;
	}
	
	protected boolean dealBusiOdrInHis(MBean inOrderBean, Map<String, Object> rstMap) {
		
		Long lCreateAccept = 0L;
		if (rstMap.get("RESULT") == null)
			return false;
		if (rstMap.get("RESULT").equals("FAIL"))
			return true;
		
		lCreateAccept = getInterCreateAccept(18);
		Map<String, Object> opr_info = getLoginAccpet(inOrderBean, rstMap.get("SEQ_NAME").toString());
		log.debug("opr_info="+opr_info.toString());
		String op_code = opr_info.get("OP_CODE")!=null?opr_info.get("OP_CODE").toString():"";
		String log_act = opr_info.get("ORDER_LINE_ID")!=null?opr_info.get("ORDER_LINE_ID").toString():"";
		String logn_no = opr_info.get("LOGIN_NO")!=null?opr_info.get("LOGIN_NO").toString():"";
		
		byte[] byte_cont = null;
		try {
			byte_cont = inOrderBean.toString().getBytes("GBK");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		Map<String, Object> busiInfo = getOdrInfo(inOrderBean);
		
		OdrLineContVO odrLineContVO = new OdrLineContVO();
		//odrLineContVO.setGsTableSuffix("");
		odrLineContVO.setGsTopicId("T109BusiOdr");
		odrLineContVO.setGbContent(byte_cont);
		odrLineContVO.setGsBusiidType(busiInfo.get("BUSIID_TYPE").toString());
		odrLineContVO.setGsBusiidNo(busiInfo.get("BUSIID_NO").toString());
		odrLineContVO.setGsDataSrc(rstMap.get("BUSI_CODE").toString());
		odrLineContVO.setGsOpCode(op_code);
		odrLineContVO.setGsLoginNo(logn_no);
		odrLineContVO.setGlCreatAct(lCreateAccept);
		odrLineContVO.setGsLoginAct(log_act);
		odrLineContDAO.insertRcvOdrCont(odrLineContVO);
		
		return false;
	}
	
	public Map<String, Object> getOdrInfo(MBean inBean) {

		String head = "";
		Object obj = null;
		if (inBean.getBodyObject("BUSI_INFO") != null) {
			head = "BUSI_INFO.";
			obj = inBean.getBodyObject("BUSI_INFO");
		}

		Map<String, Object> out_info = new HashMap<String, Object>();
		if (obj instanceof Map) {
			if (inBean.getBodyObject(head+"ID_NO") != null) {
				out_info.put("BUSIID_NO", inBean.getBodyObject(head+"ID_NO"));
				out_info.put("BUSIID_TYPE", "1");
			} else if (inBean.getBodyObject(head+"PHONE_NO") != null) {
				out_info.put("BUSIID_NO", inBean.getBodyObject(head+"PHONE_NO"));
				out_info.put("BUSIID_TYPE", "0");
			} else if (inBean.getBodyObject(head+"CONTRACT_NO") != null) {
				out_info.put("BUSIID_NO", inBean.getBodyObject(head+"CONTRACT_NO"));
				out_info.put("BUSIID_TYPE", "2");
			} else {
				out_info.put("BUSIID_NO", "0");
				out_info.put("BUSIID_TYPE", "3");
			}
		} else {
			out_info.put("BUSIID_NO", "0");
			out_info.put("BUSIID_TYPE", "3");
		}
		return out_info;
	}
	
	public long getInterCreateAccept(int inLength) {
		
		Long outParamAccept = 0L;
		String sCbAcceptDate = "";
		String sCbSequenValue = "";
		
		sCbAcceptDate = DateUtil.format(new Date(),"yyyyMMddHHmmss");
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("SEQ_NAME", "SEQ_INTERFACE_SN");
		Map<String, Object> result = new HashMap<String, Object>();
		result = (Map<String, Object>)baseDao.queryForObject("BK_dual.qSequenceInter", inMap);
		sCbSequenValue = result.get("NEXTVAL").toString();
		
		String tail = "";
		tail = sCbSequenValue.substring(sCbSequenValue.length()-(inLength-sCbAcceptDate.length()));
		outParamAccept = Long.valueOf(sCbAcceptDate + tail);

		return outParamAccept;
	}
	
	public Map<String, Object> getLoginAccpet(MBean inBean, String seq_name) {
		log.debug("----inBean--"+inBean.toString()+"seq_name="+seq_name);
		Map<String, Object> oprMap = new HashMap<String, Object>();
		String busi_code = "";
		if (inBean.getBodyObject("OPR_INFO") == null) {
			oprMap.put("OP_CODE", "");
			oprMap.put("LOGIN_NO", "");
		} else {
			oprMap.putAll((Map<String, Object>) inBean.getBodyObject("OPR_INFO"));
		}
		if (!seq_name.equals("") 
				&& (oprMap.get("ORDER_LINE_ID") == null || oprMap.get("ORDER_LINE_ID").toString().equals("")))
			oprMap.put("ORDER_LINE_ID", inBean.getBodyObject(seq_name));
		
		return oprMap;
	}
	
	protected Map<String, Object> switchVoToMap(OdrLineContVO odrContVo) {

		Map<String, Object> outMap = new HashMap<String, Object>();
		/* CREATE_ACCEPT, DATA_SOURCE, BUSIID_NO, BUSIID_TYPE, TOPIC_ID,
           CONTENT, LOGIN_ACCEPT, OP_CODE, LOGIN_NO, SUFFIX */
		outMap.put("CREATE_ACCEPT", odrContVo.getGlCreatAct());
		outMap.put("DATA_SOURCE",   odrContVo.getGsDataSrc());
		outMap.put("BUSIID_NO",     odrContVo.getGsBusiidNo());
		outMap.put("BUSIID_TYPE",   odrContVo.getGsBusiidType());
		outMap.put("TOPIC_ID",      odrContVo.getGsTopicId());
		outMap.put("CONTENT",       new String(odrContVo.getGbContent()));
		outMap.put("LOGIN_ACCEPT",  odrContVo.getGsLoginAct());
		outMap.put("OP_CODE",       odrContVo.getGsOpCode());
		outMap.put("LOGIN_NO",      odrContVo.getGsLoginNo());
		//outMap.put("SUFFIX",        odrContVo.getGsTableSuffix());
		
		if (outMap.isEmpty())
			return null;
		else 
			return outMap;
	}

	/**
	 * Title 通过反射调用参数为MBean的方法
	 * @param mbOdr
	 * @param inRstMap
	 * @return
	 */
	protected boolean invokeByMBean(Method mt, Object beanObject, MBean mbOdr, Map<String, Object> inRstMap) throws Exception {
		
//		try {
			log.debug("------业务工单调用bean接口 stt----beanObject="+beanObject.toString()
					+" mBUsiodr="+mbOdr.toString());

			//反射调用接口
			Object obj = mt.invoke(beanObject, mbOdr);
			log.debug("------业务工单调用bean接口 结束----"+obj.toString()+mt.getReturnType().toString());
			if ((Boolean) obj == false) {
				//记录ERR表
				inRstMap.put("RESULT", "FAIL");
				inRstMap.put("ERR_CODE", "0003");
				inRstMap.put("ERR_MSG", "mbean deal busiodr return false.");
				inputBusiOdrErrForReDeal(mbOdr, inRstMap);
			}
//		} catch (Exception e) {
//			//报错
//			e.printStackTrace();
//			throw new BusiException(AcctMgrError.getErrorCode("0010","10050"),
//					"MBEAN业务数据异常， "+e.toString().substring(0, 1023));
//		}
		return true;
	}
	
	/**
	 * TITLE 转换MBean为InDTO类型
	 * @param inmbean
	 * @param sMethodName
	 * @param beanObj JCFContext获取到的Object类型bean
	 * @return InDTO
	 */
	public InDTO transMBeanToInDTO(MBean inmbean,String sMethodName, Object beanObj) {
		Class indtoClass = null;
		Class serviceClass = AopProxyUtils.ultimateTargetClass(beanObj);
		//转换MBean为InDTO类型
		ParamTypes pts = (ParamTypes) serviceClass.getAnnotation(ParamTypes.class); 
		if (null != pts) {
			for (ParamType pt : pts.value()) {
				log.debug("sMethodName=["+sMethodName+"],pt.m()=["+pt.m()+"],length="+pts.value().length);
				if (sMethodName.equals(pt.m())) {
					indtoClass = pt.c();
					break;
				}
			}
		}
		//InDTO inDTO = DtKit.toDTO(inmbean, indtoClass);
		return DtKit.toDTO(inmbean, indtoClass);
	}
	
}
