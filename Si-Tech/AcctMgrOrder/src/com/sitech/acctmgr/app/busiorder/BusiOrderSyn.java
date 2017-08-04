package com.sitech.acctmgr.app.busiorder;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.SQLException;

import com.sitech.acctmgr.app.busiorder.jsontrans.JsonTrans;
import com.sitech.acctmgr.app.common.InterBusiConst;
import com.sitech.acctmgr.app.common.JdbcConn;
import com.sitech.acctmgr.app.odrBlob.OdrLineContVO;
import com.sitech.acctmgr.app.odrBlob.OdrLineErrVO;
import com.sitech.jcf.core.datasource.DataSourceHelper;
import com.sitech.jcf.ijdbc.sql.SqlTypes;
import com.sitech.jcfx.dt.MBean;

public class BusiOrderSyn extends BusiOrderSynComm implements IBusiOrderSyn {

	private JsonTrans jsonTrans;
	
	/**
	 * Title 处理正常工单
	 */
	public boolean dealBusiOrderData(String inBusiOrder, String inBusiCode, String sMsgId) throws Exception {

		String sBusiCode = "";
		Map<String, Object> rstMap = new HashMap<String, Object>();
		
		//1.检查是否有数据，是否缺少必传参数,inOrderBean大小
		MBean mBusiOdr = checkBusiOrder(inBusiOrder);
		if (null == mBusiOdr) {
			log.debug("BUSI ORDER isnot right Json format, inBusiOdr="+inBusiOrder);
			return true;
		}
		
		//2.根据[BUSI_INFO.]BUSI_CODE，调用对应的 同步函数同步数据
		if (inBusiCode.equalsIgnoreCase("")) {
			sBusiCode = getBusiCode(mBusiOdr);
		} else {
			sBusiCode = inBusiCode;
		}
		if (sBusiCode.equals("")) {
			log.error("---busiodr--busi_code is null="+sBusiCode);
			return true;
		}

		rstMap = getFuncNameByOpCode(sBusiCode);
		if (rstMap == null || rstMap.size() == 0) {
			log.error("There isn't any CONFIG in DataBase of Table in_busiorder_cfg.please check!");
			
			//没有配置该同步工单模板（in_busiorder_cfg），记入ERR历史
			rstMap = new HashMap<String, Object>();
			rstMap.put("BUSI_CODE", sBusiCode);
			rstMap.put("ERR_CODE", "0001");
			rstMap.put("ERR_MSG", "There isn't any CONFIG.");
			inputBusiOdrErrForReDeal(mBusiOdr, rstMap);
			return false;
		}
		
		//对一些业务，重复接收同一条消息限制
		if(sBusiCode.equals("ASYWRTOFF")  //异步冲销
			&& (sMsgId != null) && (!(sMsgId.equals("")))){
			
			try{
				Connection conn = (Connection) baseDao.getConnection();
				rstMap.put("MSG_ID", sMsgId);
				rstMap.put("BUSI_CODE", sBusiCode);
				baseDao.insert("in_msgrcv_his.insertMsgRcvId", rstMap);
				conn.commit();
			}catch(Exception e){
				log.error("repeat receive msg,id=["+sMsgId+"]");
				rstMap.put("BUSI_CODE", sBusiCode);
				rstMap.put("ERR_CODE", "0009");
				rstMap.put("ERR_MSG", "repeat receive msg,id=["+sMsgId+"]");
				inputBusiOdrErrForReDeal(mBusiOdr, rstMap);
				return false;
			}
		}
		
		//3.转换工单mBusiOdr,Key转换为Boss系统Key
		jsonTrans.transJsonInter(sBusiCode, mBusiOdr);
		
		//4.调用接口类方法，处理业务工单
		boolean bResult = dealInvokeBusiOdr(mBusiOdr, rstMap);
		if (true == bResult || rstMap.get("RESULT").equals("SUCC")) {
			//5.根据rstMap返回KEY=RESULT值，=SUCC，入历史
			dealBusiOdrInHis(mBusiOdr, rstMap);
		} else {
			return false;
		}
		
		return true;
	}

	/**
	 * Title 处理报错工单
	 */
	public boolean dealBusiOrderErr(String sFlag,String sCreateAccept) throws Exception {
		
		int iDataSize = 0;
		int iCount = 0;
		long lCreateAccept = 0L;
		HashMap<String, Object> mapDataTmp = null;
		HashMap<String, Object> inParaMap = null;
		
		//标志=1，提所有err_code=0000的工单，重发
		if(sFlag.equals("1") == true){
			//while(true){
				//1.查询待处理错误工单。即人工干预后，err_code='0000'的单子。每次最多取1000条
				inParaMap = new HashMap<String, Object>();
				inParaMap.put("TOPIC_ID", "T109BusiOdr");
				inParaMap.put("ERR_CODE", "0000");
				List<HashMap> listErrData = baseDao.queryForList("in_msgrcv_err.qErrData", inParaMap);
				if (listErrData.size() == 0) {
					log.debug("------There isnot any errOdr to deal.");
					return true;
				}
				
				//2.循环调用处理工单方法;插入历史表，并删除原err数据
				iDataSize = listErrData.size(); 
				for (int i = 0; i < iDataSize; i++) {
		
					//取数据，类型转换
					mapDataTmp = (HashMap<String, Object>)listErrData.get(i);
					log.info("----busiodr errdeal---当前列数据：["+mapDataTmp.toString()+"]-----");
					
					//调用处理接口				
					Blob blob = (Blob) mapDataTmp.get("CONTENT");
					String gbk_content = null;
					String sContent = null;
					try {
						gbk_content = new String(blob.getBytes((long) 1, (int)blob.length()), "GBK");
						sContent = new String(gbk_content.getBytes(InterBusiConst.MSGSND_CHARSET), InterBusiConst.MSGSND_CHARSET);
					} catch (Exception e) {e.printStackTrace();}
					
					log.info("----Content.BLOB报文内容：["+sContent+"]-----");
					try {
						dealBusiOrderData(sContent,"","");
						
						//使用JdbcConn接口自行处理入历史和err表
						JdbcConn jdbc = new JdbcConn(baseDao.getNewConnection());
						//入HIS
						jdbc.setSqlBuffer("insert into in_msgrcv_his (TOPIC_ID, CONTENT, LOGIN_ACCEPT, OP_TIME, OP_CODE, LOGIN_NO, CREATE_ACCEPT, DATA_SOURCE, BUSIID_TYPE, BUSIID_NO, RCV_TIME )" +
										"select TOPIC_ID, CONTENT, LOGIN_ACCEPT, OP_TIME, OP_CODE, LOGIN_NO, CREATE_ACCEPT, DATA_SOURCE, BUSIID_TYPE, BUSIID_NO, RCV_TIME " +
										"from in_msgrcv_err where CREATE_ACCEPT = ?");
						jdbc.addParam("CREATE_ACCEPT", mapDataTmp.get("CREATE_ACCEPT").toString(), SqlTypes.JSTRING);
						jdbc.execuse();
						//更新ERR表err_code=9999
						jdbc.setSqlBuffer("UPDATE IN_MSGRCV_ERR SET ERR_CODE= ? WHERE CREATE_ACCEPT= ?");
						jdbc.addParam("ERR_CODE", "9999");
						jdbc.addParam("CREATE_ACCEPT", mapDataTmp.get("CREATE_ACCEPT").toString(), SqlTypes.JSTRING);
						jdbc.execuse();
						//commit
						jdbc.commit();
						
						//更新Err接口记录 err_code = '9999'
						/*lCreateAccept = ((BigDecimal)mapDataTmp.get("CREATE_ACCEPT")).longValue();
						inParaMap = new HashMap<String, Object>();
						inParaMap.put("ERR_CODE", "9999");
						inParaMap.put("CREATE_ACCEPT", lCreateAccept);
						iCount = baseDao.update("in_msgrcv_err.uErrDataErrCode", inParaMap);*/
					} catch (Exception e) {
						e.printStackTrace();
						
						log.error("busiodr-失败继续执行其他ERR_CODE=0000的工单...");
						continue;
					}
				}
			//}
		}
		else {
			//其他模式暂不支持
		}
		return true;
			
	}	
	
	public JsonTrans getJsonTrans() {
		return jsonTrans;
	}

	public void setJsonTrans(JsonTrans jsonTrans) {
		this.jsonTrans = jsonTrans;
	}

	public String getBusiCode(MBean mb) {
		String busi_code = "";
		if (null != mb.getBodyStr("BUSI_INFO.BUSI_CODE"))
			busi_code = mb.getBodyStr("BUSI_INFO.BUSI_CODE");
		else if (null != mb.getBodyStr("BUSI_CODE"))
			busi_code = mb.getBodyStr("BUSI_CODE");
		if (busi_code.equals("")) {
			log.error("BUSI_CODE为空，请开发人员注意！该条工单过滤不处理。。。");
			return "";
		}
		return busi_code;
	}
	
	@Override
	public boolean inputBusiErr(MBean mb, Map<String, Object> errMap) {
		log.debug("----insertbusierr---errMap="+errMap.toString());
		long lCreateAccept = getInterCreateAccept(18);
		Map<String, Object> cfg = null;
		String seq_name = "";
		if (!errMap.get("BUSI_CODE").toString().equals("")) {
			cfg = getFuncNameByOpCode(errMap.get("BUSI_CODE").toString());
			seq_name = cfg.get("SEQ_NAME").toString();
		}
		Map<String, Object> opr_info = getLoginAccpet(mb, seq_name);
		String op_code = opr_info.get("OP_CODE")!=null?opr_info.get("OP_CODE").toString():"";
		String log_act = opr_info.get("ORDER_LINE_ID")!=null?opr_info.get("ORDER_LINE_ID").toString():"";
		String logn_no = opr_info.get("LOGIN_NO")!=null?opr_info.get("LOGIN_NO").toString():"";
		
		
		byte[] byte_cont = null;
		try {
			byte_cont = mb.toString().getBytes("GBK");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		Map<String, Object> busiInfo = getOdrInfo(mb);
		
		OdrLineErrVO odrLineErrVO = new OdrLineErrVO();
		odrLineErrVO.setGsTopicId("T109BusiOdr");
		odrLineErrVO.setGbContent(byte_cont);

		odrLineErrVO.setGsBusiidType(busiInfo.get("BUSIID_TYPE").toString());
		odrLineErrVO.setGsBusiidNo(busiInfo.get("BUSIID_NO").toString());
		odrLineErrVO.setGsDataSrc(errMap.get("BUSI_CODE").toString());
		odrLineErrVO.setGsOpCode(op_code);
		odrLineErrVO.setGsLoginNo(logn_no);
		
		odrLineErrVO.setGlCreatAct(lCreateAccept);
		odrLineErrVO.setGsLoginAct(log_act);
		odrLineErrVO.setGsErrCode(errMap.get("ERR_CODE").toString());
		odrLineErrVO.setGsErrMsg(errMap.get("ERR_MSG").toString());
		odrLineContDAO.insertOdrErrCont(odrLineErrVO);
		return false;
	}

}
