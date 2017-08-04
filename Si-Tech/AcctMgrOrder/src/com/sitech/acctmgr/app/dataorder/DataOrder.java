package com.sitech.acctmgr.app.dataorder;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.math.BigDecimal;
import java.sql.Blob;
import javax.sql.DataSource;
import static org.apache.commons.collections.MapUtils.safeAddToMap;
import com.sitech.acctmgr.app.common.InterBusiConst;
import com.sitech.acctmgr.app.dataorder.configcache.DataBaseCache;
import com.sitech.acctmgr.app.odrBlob.OdrLineErrVO;
import com.sitech.jcf.context.LocalContextFactory;
import com.sitech.jcf.core.SessionContext;
import com.sitech.jcf.core.datasource.DataSourceHelper;
import com.sitech.jcfx.dt.MBean;

public class DataOrder extends DataOrderComm implements IDataOrder {
	
	/**
	 * Title: Crm To Boss 数据同步接口实现
	 * Description 数据同步提供外部使用接口
	 * @param sInParamJson
	 * @param both_sync_flag 跨库标识:Y-跨库 N-不跨库
	 * @return boolean
	 * @throws Exception 
	 */
	@Override
	public boolean dataOrderSyn(MBean mInParam, String in_sync_flag) {
		
		boolean bRet = false;
		String sDbid = "";
		String sOthrDbid = "";
		String sTableName = "";
		//String sSuffix = "";
		String both_sync_flag = "";
		String both_chgsync_flag = "";
		String both_sync_errmsg = "";
		int both_err_count = 0;
		String in_id_no = "";
		
		/*取Header*/
		Map<String, Object> mHeader = new HashMap<String, Object>();
		mHeader = getHeaderMap(mInParam);
		log.debug("mbean=["+mInParam+"]");
		Map<String, Object> opr_info = getOrderAccept(mInParam);

		//20151106 双库同步
		sDbid = mInParam.getHeaderStr(InterBusiConst.DATAODR_DBID);
		if (sDbid != null && !sDbid.equals("")) {
			sOthrDbid = ((sDbid.substring(0, 1).equals("A"))?("B"):("A")) + sDbid.substring(1);
		} else {
			//没传取ROUTE_KEY ROUTE_VALUE
			String route_key = mInParam.getHeaderStr("ROUTING.ROUTE_KEY");
			String route_val = mInParam.getHeaderStr("ROUTING.ROUTE_VALUE");
			//没有ROUTE信息则插入错表
			if (null == route_val || route_val.equals("")) {
				log.error("DB_ID and ROUTE key's Value is NULL, Please Check.mInParam="+mInParam.toString());
				inputErrOrderDeal(mInParam, opr_info, "DB_ID and ROUTE key's Value is NULL");
				return false;
			}
			
			Map<String, Object> inMap = new HashMap<String, Object>();
			if (route_key.equals("10"))
				inMap.put("PHONE_HEAD", route_val.substring(0, 7));
			else if (route_key.equals("11") || route_key.equals("12") || route_key.equals("15"))
				inMap.put("REGION_CODE", route_val.substring(0, 4));
			Map<String, Object> db_map = (Map<String, Object>) baseDao.queryForObject("BK_pubic.qDbIdByRoute", inMap);
			if (null != db_map) {
				sDbid = db_map.get("DB_CODE").toString();
				sOthrDbid = db_map.get("DB_RE_CODE").toString();
				//设置DB_ID
				mInParam.setDbId(sDbid);
			}
		}
		
		//取AB数据库连接
		Connection conn = null;
		Connection conn_other = null;
		try {
			conn = ((DataSource)LocalContextFactory.getInstance()
					.getBean("dataSource"+sDbid, DataSource.class)).getConnection();
			conn_other = ((DataSource)LocalContextFactory.getInstance()
					.getBean("dataSource"+sOthrDbid, DataSource.class)).getConnection();
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		log.info("本库:"+sDbid+conn);
		log.info("跨库:"+sOthrDbid+conn_other);
		
		/*循环Body中TABLES列表处理*/
		List<Map> listTables = mInParam.getBodyList(InterBusiConst.DATAODR_TABLES,
				Map.class);//"TABLES"
		if (null == listTables)
			listTables = mInParam.getBodyList("OUT_DATA.TABLES", Map.class);
		if (listTables != null && listTables.size() != 0) {

			for (Map<String, Object> mapTable : listTables) {
				//初始化参数
				sTableName = "";
				//跨库同步
				both_sync_flag = "";
				both_chgsync_flag = "";
				both_sync_errmsg = "";
				both_err_count = 0;
				
				sTableName = mapTable.get(InterBusiConst.DATAODR_TABNAME).toString();//"TABLENAME"
				if (null == sTableName) {
					log.debug("There is no table Name,continue..");
					continue;
				}
				
				//sSuffix = mapTable.get(InterBusiConst.DATAODR_SUFFIX).toString();
				/*取得缓存配置信息*/
				List<Map<String, Object>> lstTableRel = new ArrayList<Map<String,Object>>();
				lstTableRel = DataBaseCache.getTabConfigData(sTableName);
				if (lstTableRel == null || lstTableRel.size() == 0) {
					log.debug("There is no table of "+sTableName+" Config,continue...");
					continue;
				}
				//取得跨库配置 20151106
				Map<String, Object> both_map = DataBaseCache.getBothSyncFlag(sTableName);
				both_sync_flag = both_map.get("SYNC_FLAG").toString();
				both_chgsync_flag = both_map.get("CHG_BOTH_FLAG").toString();
				log.debug("both_sync_flag="+both_sync_flag+"--both_chgsync_flag="+both_chgsync_flag);
	
				/*取得同步数据DATARECORDS 记录*/
				List<Map<String, Object>> listDataRecds = (List<Map<String, Object>>) 
						mapTable.get(InterBusiConst.DATAODR_DATARCDS);//"DATARECORDS"
				for (Map<String, Object> tmpOpCol : listDataRecds) {

					Map<String, Object> mapOpCols = new HashMap<String, Object>();
	
					/*配置数据，为一对一关系，即一层循环*/
					/*mapOpCols.put(InterBusiConst.DATAODR_CREATACPT,
							  mHeader.get(InterBusiConst.DATAODR_CREATACPT));//"CREATE_ACCEPT"
					mapOpCols.put(InterBusiConst.DATAODR_ODRLINEID,
							  mHeader.get(InterBusiConst.DATAODR_ODRLINEID));//"ORDER_LINE_ID"
					mapOpCols.put(InterBusiConst.DATAODR_CREATTIME,
							  mHeader.get(InterBusiConst.DATAODR_CREATTIME));//"CREATE_TIME"
					*/
					
					//放入数据库连接
					safeAddToMap(mapOpCols, "COLS", tmpOpCol.get("COLS"));
					safeAddToMap(mapOpCols, "OP", tmpOpCol.get("OP"));
					
					/**** add by zhangleij 20170223 取数据库时间 begin ****/
					Map<String, Object> dbTimeTmp = new HashMap<String, Object>();
					dbTimeTmp = (Map<String, Object>) baseDao.queryForObject("BK_dual.qSysdatebyDual");
					String dbTimeStr = dbTimeTmp.get("CUR_TIME").toString();
					log.debug("dbTimeStr="+dbTimeStr);
					safeAddToMap(mapOpCols, "CREATE_TIME", dbTimeStr);
					/**** add by zhangleij 20170223 取数据库时间 end ****/
					
					if (null != tmpOpCol.get("PK"))
						safeAddToMap(mapOpCols, "PK", tmpOpCol.get("PK"));	
					safeAddToMap(mapOpCols, "TABLE_NAME", sTableName);
					safeAddToMap(mapOpCols, "OPR_INFO", opr_info);
					safeAddToMap(mapOpCols, "CONN", conn);
					//放入跨库配置
					safeAddToMap(mapOpCols, "CONN_OTHER", conn_other);
					safeAddToMap(mapOpCols, "BOTH_SYNC_FLAG", both_sync_flag);

					Map<String, Object> outSqlChg = null;
					try {
						outSqlChg = dealDataOrder(mapOpCols, lstTableRel);
						if (null == outSqlChg) {
							log.error("dealDataOrder deal error,please check.bRet="+bRet);
							//回退数据，关闭连接
							rollBackAndClose(conn);
							//关闭跨库连接
							rollBackAndClose(conn_other);
							//插入错误历史表
							inputErrOrderDeal(mInParam, opr_info, "dealDataOrder deal error,please check.bRet="+bRet);					
							return bRet;
						}
						
					} catch (Exception e) {
						log.error(e.getMessage());
			            StackTraceElement[] error = e.getStackTrace();
			            for (StackTraceElement stackTraceElement : error){
			                log.error(stackTraceElement.toString());
			            }
			            
						//回退数据，关闭连接
						rollBackAndClose(conn);
						//关闭跨库连接
						rollBackAndClose(conn_other);
						//插入错误历史表
						inputErrOrderDeal(mInParam, opr_info, e.getMessage());					
						//退出循环
						return false;
					}
					
					//跨库同步:判断是否可做跨库同步（in_sync_flag！=N）；且当前表是否做跨库同步。 @20151106
					log.debug("--in_sync_flag="+in_sync_flag+"--both_sync_flag="+both_sync_flag);
					if (!in_sync_flag.equals("N") && both_sync_flag.equals("Y")) {
						try {
							//循环中报错后，不再跨库处理
							if (0 == both_err_count)
								bothSyncExec(outSqlChg, mapOpCols, both_chgsync_flag);
							
						} catch (Exception e) {
				            //记报错标识，自增1
				            both_err_count ++;
				            
				            both_sync_errmsg = e.getMessage();
				            log.error("跨库["+sOthrDbid+"]报错getmsg："+e.getMessage()+"etostr="+e.toString());
//				            StackTraceElement[] error = e.getStackTrace();
//				            for (StackTraceElement stackTraceElement : error){
//				                log.error("跨库报错：" + stackTraceElement.toString());
//				            }
						}
					}
					
					//取得crm订单行号
					/*if ("".equals(in_order_line_id)) {
						Map<String, Object> colMap = (Map<String, Object>) mapOpCols.get(InterBusiConst.DATAODR_COLS);
						if (colMap.get("LOGIN_ACCEPT") != null)
							in_order_line_id = colMap.get("LOGIN_ACCEPT").toString();
						else if (colMap.get("ID_NO") != null)
							in_id_no = colMap.get("ID_NO").toString();
					}*/
				}/*for DATARECORDS END*/
			}/*for TABLES END*/

			/*记入历史,若没有数据工单（只有费用工单），则不计入历史*/
			inJsonParamHis(mInParam, opr_info);
			
			/*记入跨库历史/错误表    @20151106*/
			if (!in_sync_flag.equals("N")) {
				
				MBean bothBean = new MBean();
				bothBean.setHeader(mInParam.getHeader());
				//同时需转换报文中DB_ID为报错库的DB_ID；去掉BUSI_INFO业务工单
				bothBean.setDbId(sOthrDbid);
				
				Map<String, Object> body = new HashMap<String, Object>();
				body.putAll(mInParam.getBody()); body.remove(InterBusiConst.DATAODR_FEEINFO);
				bothBean.setBody(body);
				log.info("跨库记录报文bothBean:"+bothBean.toString());
				//暂不记录，，，
				inPutHisOrErr(bothBean, opr_info, both_err_count, conn_other,
						"5555", both_sync_errmsg);//成功入HIS不记录；失败记录。
			}
		}/*if != null*/
		else 
		{
			log.info("[DataSyn]:There is not any TABLES info in BODY.");
		}
		//注意：必须提交！！！！因为提交之后才能够继续处理业务工单。
		//commit提交并关闭连接
		CommitAndCloseConn(conn);
		//commit提交跨库数据操作，并关闭连接
		CommitAndCloseConn(conn_other);
		
		log.info("-数据工单结束,开始处理费用工单......opr_info:"+opr_info.toString());
		
		//处理存在的费用工单
		if (mInParam.getBodyObject(InterBusiConst.DATAODR_FEEINFO) != null) {
				
			if (mInParam.getBodyObject(InterBusiConst.DATAODR_TABLES) != null)
				mInParam.remove(InterBusiConst.DATAODR_TABLES);
			log.debug("--dealFeeInfo--mInParam=["+mInParam.toString()+"]");
			
			Map<String, Object> oprInfo = 
					(Map<String, Object>) mInParam.getBodyObject(InterBusiConst.DATAODR_OPRINFO);
			List<Map<String, Object>> listBusiInfo = 
					(List<Map<String, Object>>) mInParam.getBodyList(InterBusiConst.DATAODR_FEEINFO);
			
			MBean opBean = null;
			for (Map<String, Object> tmpMap:listBusiInfo) {
				opBean = new MBean();
				opBean.setHeader(mInParam.getHeader());
				opBean.addBody(InterBusiConst.DATAODR_FEEINFO, tmpMap);
				opBean.addBody(InterBusiConst.DATAODR_OPRINFO, oprInfo);

				log.debug("---for--BUSI_CODE=["+tmpMap.get("BUSI_CODE").toString()
						+ "]-busiinfo=["+opBean.toString()+"]");
				String busi_code = "";
				try {
					busi_code = busiOrderSyn.getBusiCode(opBean);
					//设置A,B库
		            SessionContext.setDbLabel(sDbid);
					busiOrderSyn.dealBusiOrderData(opBean.toString(), busi_code, "");
				} catch (Exception e) {
					DataSourceHelper.rollback(baseDao.getConnection());
					e.printStackTrace();
					//设置A,B库
		            String sDbLabel = opBean.getHeaderStr(InterBusiConst.DATAODR_DBID);
		            SessionContext.setDbLabel(sDbLabel);
		            
					Map<String, Object> err_map = new HashMap<String, Object>();
					err_map.put("ERR_CODE", "0001");
					err_map.put("ERR_MSG", "-dataBusiOrder-errmsg="+e.toString());
					err_map.put("BUSI_CODE", busi_code);
					busiOrderSyn.inputBusiErr(opBean, err_map);
				}
			}
			//调用业务工单接口处理
			log.debug("----feeinfo over, END---");
		}
		
		return true;
	}

	@Override
	public boolean inputErrOrderDeal(MBean mbean, Map<String, Object> opr_info, String inErrMsg) {

		log.info("----------deal dataodr err,input errtable--stt----------");

		long lCreateAccept = 0L;
		lCreateAccept = getInterCreateAccept(17);
		
		byte[] byte_cont = null;
		try {
			byte_cont = mbean.toString().getBytes("GBK");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
		OdrLineErrVO odrLineErrVO = new OdrLineErrVO();
		odrLineErrVO.setGsTopicId(InterBusiConst.DATAODR_TOPIC);
		odrLineErrVO.setGbContent(byte_cont);
		odrLineErrVO.setGsBusiidType(InterBusiConst.BUSIID_TYPE_OTHER);
		odrLineErrVO.setGsBusiidNo("0");
		odrLineErrVO.setGsDataSrc(mbean.getHeaderStr("DB_ID"));
		odrLineErrVO.setGsOpCode((opr_info.get("OP_CODE")!=null)?opr_info.get("OP_CODE").toString().trim():"");
		odrLineErrVO.setGsLoginNo((opr_info.get("LOGIN_NO")!=null)?opr_info.get("LOGIN_NO").toString().trim():"");
		odrLineErrVO.setGlCreatAct(lCreateAccept);
		odrLineErrVO.setGsLoginAct((opr_info.get("ORDER_LINE_ID")!=null)?opr_info.get("ORDER_LINE_ID").toString().trim():"");
		odrLineErrVO.setGsErrCode("0010");
		odrLineErrVO.setGsErrMsg(inErrMsg);
		odrLineContDAO.insertOdrErrCont(odrLineErrVO);
		log.info("----------deal dataodr err,input errtable--end----------");
		
		return false;
	}

	private void rollBackAndClose(Connection conn) {
		DataSourceHelper.rollback(conn);
		DataSourceHelper.closeConnection(conn);
	}

	private void CommitAndCloseConn(Connection conn) {
		DataSourceHelper.commit(conn);
		DataSourceHelper.closeConnection(conn);
	}
	
	@Override
	public Map<String, Object> getOrderAccept(MBean mInParam) {

		
		String out_serv_odr_id = "";
		String out_login_act = "";
		String out_id_no = "";
		String out_op_code = "";
		
		if (mInParam.getBodyObject("OPR_INFO") != null)
			return (Map<String, Object>) mInParam.getBodyObject("OPR_INFO");
		else {
			
			/*循环Body中TABLES列表处理*/
			List<Map> listTables = mInParam.getBodyList(InterBusiConst.DATAODR_TABLES
					, Map.class);//"OUT_DATA.TABLES"
			if (listTables != null && listTables.size() != 0) {
				
				for (Map<String, Object> mapTable : listTables) {
					/*取得同步数据DATARECORDS 记录*/
					List<Map<String, Object>> listDataRecds = (List<Map<String, Object>>) mapTable.get(InterBusiConst.DATAODR_DATARCDS);//"DATARECORDS"
					for (Map<String, Object> mapOpCols : listDataRecds) {
	
						Map<String, Object> colMap = (Map<String, Object>) 
								mapOpCols.get(InterBusiConst.DATAODR_COLS);
						
						//取得SERV_ORDER_ID
						if ("".equals(out_serv_odr_id) || "-1".equals(out_serv_odr_id)) {
							if (colMap.get("SERV_ORDER_ID") != null) {
								out_serv_odr_id = colMap.get("SERV_ORDER_ID").toString();
								
							}
						}
						//取得LOGIN_ACCEPT
						if ("".equals(out_login_act) || "-1".equals(out_login_act)) {
							if (colMap.get("LOGIN_ACCEPT") != null) {
								out_login_act = colMap.get("LOGIN_ACCEPT").toString();
								
							}
						}
						//取得ID_NO
						if ("".equals(out_id_no)) {
							if (colMap.get("ID_NO") != null)
								out_id_no = colMap.get("ID_NO").toString();
						}
						//取得OP_CODE
						if ("".equals(out_op_code)) {
							if (colMap.get("OP_CODE") != null)
								out_op_code = colMap.get("OP_CODE").toString();
						}
					}
				}
			}
		}
		Map<String, Object> opr_info = new HashMap<String, Object>();
		if (!out_serv_odr_id.equals(""))
			opr_info.put("ORDER_LINE_ID", out_serv_odr_id);
		else if (!out_serv_odr_id.equals(""))
			opr_info.put("ORDER_LINE_ID", out_login_act);
		else if (!out_id_no.equals(""))
			opr_info.put("ORDER_LINE_ID", out_id_no);
		//OP_CODE
		if (!out_op_code.equals(""))
			opr_info.put("OP_CODE", out_op_code);
		
		//未取得LOGIN_ACCEPT则取ID_NO返回
		return opr_info;
	}
	
	public boolean dealDataOrderErr(String both_syn_flag) {
		
		int iDataSize = 0;
		int iCount = 0;
		long lCreateAccept = 0L;
		String err_code = "";
		HashMap<String, Object> mapDataTmp = null;
		HashMap<String, Object> inParaMap = null;
		
//		while(true)
//		{
			//1.查询待处理错误工单。即人工干预后，err_code='0000'的单子。每次最多取1000条
			inParaMap = new HashMap<String, Object>();
			inParaMap.put("TOPIC_ID", "T101DataSyn");
			inParaMap.put("ERR_CODE_0", "0000");
			inParaMap.put("ERR_CODE_1", "1111");
			List<HashMap> listErrData = baseDao.queryForList("in_msgrcv_err.qErrData", inParaMap);
			if (listErrData.size() == 0) {
				log.debug("------There isnot any errOdr to deal.");
				return true;
			}
			
			//2.循环调用处理工单方法;插入历史表，并删除原err数据
			iDataSize = listErrData.size(); 
			for (int i = 0; i < iDataSize; i++) {
				err_code = "";
				//取数据，类型转换
				mapDataTmp = (HashMap<String, Object>)listErrData.get(i);
				log.info("----busiodr errdeal---当前列数据：["+mapDataTmp.toString()+"]-----");
				err_code = mapDataTmp.get("ERR_CODE").toString();
				
				//调用处理接口
				Blob blob = (Blob) mapDataTmp.get("CONTENT");
				String gbk_content = null;
				String sContent = null;
	
				try {
					gbk_content = new String(blob.getBytes((long) 1, (int)blob.length()), "GBK");
					sContent = new String(gbk_content.getBytes(InterBusiConst.MSGSND_CHARSET), InterBusiConst.MSGSND_CHARSET);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				log.info("----Content.BLOB报文内容：["+sContent+"]-----");
				log.info("----错误标识err_code(0000:Y 双库同步；1111:N 单库同步)="+err_code);
			
				try {
					MBean inBean = new MBean(sContent);
					//处理inBean。。。
					if (err_code.equals("0000"))
						errOrderSyn(inBean, both_syn_flag);
					else if (err_code.equals("1111"))
						dataOrderSyn(inBean, "N");
						
					//更新Err接口记录 err_code = '9999'
					lCreateAccept = ((BigDecimal)mapDataTmp.get("CREATE_ACCEPT")).longValue();
					inParaMap = new HashMap<String, Object>();
					inParaMap.put("ERR_CODE", "9999");
					inParaMap.put("CREATE_ACCEPT", lCreateAccept);
					iCount = baseDao.update("in_msgrcv_err.uErrDataErrCode", inParaMap);
				} catch (Exception e) {
					e.printStackTrace();
					
					log.debug("错误数据工单，处理失败，继续处理其他工单...");
				}
			}
		//}
		return true;
	}

	/*
	//取得DB_ID,确认同步哪个库？
	DataSource dataSrc = null;
	JCFContext.junitInit();
	sDbid = mInParam.getHeaderStr(InterBusiConst.DATAODR_DBID);
	if (sDbid != null && !sDbid.equals("")) {
		if (sDbid.equals("A")) {
			dataSrc = (DataSource) JCFContext.getBean("dataSourceA");//db.xml中配置的数据源
			conn = DataSourceUtils.getConnection(dataSrc);				
		} else if (sDbid.equals("B2")) {
			dataSrc = (DataSource) JCFContext.getBean("dataSourceB2");//db.xml中配置的数据源
			conn = DataSourceUtils.getConnection(dataSrc);								
		} else {
			//插入错误表
			String err_info = "数据库标识异常"+sDbid;
			inputErrOrderDeal(inJsonStr, opr_info, err_info);			
			//退出
			return false;
		}
	} else {
		//取默认库连接
		dataSrc = (DataSource) JCFContext.getBean("dataSourceA");//db.xml中配置的数据源
		conn = DataSourceUtils.getConnection(dataSrc);
		//conn = baseDao.getConnection();//下面会控制关闭连接，不建议使用框架连接
	}*/
	
	/**
	 * 错单处理程序
	 * @param mInParam
	 * @param in_sync_flag 
	 * 		Y:跨库同步数据工单；处理业务工单 
	 * 		N:只同步当前库数据工单；不处理业务工单
	 * @return
	 */
	public boolean errOrderSyn(MBean mInParam, String in_sync_flag) {
		
		boolean bRet = false;
		String sDbid = "";
		String sOthrDbid = "";
		String sTableName = "";
		String both_sync_flag = "";
		String both_chgsync_flag = "";
		String both_sync_errmsg = "";
		int both_err_count = 0;
		
		log.debug("mbean=["+mInParam+"]");
		Map<String, Object> opr_info = getOrderAccept(mInParam);

		//20151106 双库同步
		sDbid = mInParam.getHeaderStr(InterBusiConst.DATAODR_DBID);
		if (sDbid != null && !sDbid.equals("")) {
			sOthrDbid = ((sDbid.substring(0, 1).equals("A"))?("B"):("A")) + sDbid.substring(1);
		} else {
			//没传取ROUTE_KEY ROUTE_VALUE
			String route_key = mInParam.getHeaderStr("ROUTING.ROUTE_KEY");
			String route_val = mInParam.getHeaderStr("ROUTING.ROUTE_VALUE");
			//没有ROUTE信息则插入错表
			if (null == route_val || route_val.equals("")) {
				log.error("DB_ID and ROUTE key's Value is NULL, Please Check.mInParam="+mInParam.toString());
				inputErrOrderDeal(mInParam, opr_info, "DB_ID and ROUTE key's Value is NULL");
				return false;
			}
			
			Map<String, Object> inMap = new HashMap<String, Object>();
			if (route_key.equals("10"))
				inMap.put("PHONE_HEAD", route_val.substring(0, 7));
			else if (route_key.equals("11") || route_key.equals("12") || route_key.equals("15"))
				inMap.put("REGION_CODE", route_val.substring(0, 4));
			Map<String, Object> db_map = (Map<String, Object>) baseDao.queryForObject("BK_pubic.qDbIdByRoute", inMap);
			if (null != db_map) {
				sDbid = db_map.get("DB_CODE").toString();
				sOthrDbid = db_map.get("DB_RE_CODE").toString();
				//设置DB_ID
				mInParam.setDbId(sDbid);
			}
		}
		
		//取AB数据库连接
		Connection conn = null;
		Connection conn_other = null;
		try {
			conn = ((DataSource)LocalContextFactory.getInstance()
					.getBean("dataSource"+sDbid, DataSource.class)).getConnection();
			conn_other = ((DataSource)LocalContextFactory.getInstance()
					.getBean("dataSource"+sOthrDbid, DataSource.class)).getConnection();
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		log.debug("本库:"+sDbid+conn);
		log.debug("跨库:"+sOthrDbid+conn_other);
		
		/*循环Body中TABLES列表处理*/
		List<Map> listTables = mInParam.getBodyList(InterBusiConst.DATAODR_TABLES,
				Map.class);//"TABLES"
		if (null == listTables)
			listTables = mInParam.getBodyList("OUT_DATA.TABLES", Map.class);
		if (listTables != null && listTables.size() != 0) {

			for (Map<String, Object> mapTable : listTables) {
				//初始化参数
				sTableName = "";
				//跨库同步
				both_sync_flag = "";
				both_chgsync_flag = "";
				both_sync_errmsg = "";
				both_err_count = 0;
				
				sTableName = mapTable.get(InterBusiConst.DATAODR_TABNAME).toString();//"TABLENAME"
				if (null == sTableName) {
					log.debug("There is no table Name,continue..");
					continue;
				}
				
				/*取得缓存配置信息*/
				List<Map<String, Object>> lstTableRel = new ArrayList<Map<String,Object>>();
				lstTableRel = DataBaseCache.getTabConfigData(sTableName);
				if (lstTableRel == null || lstTableRel.size() == 0) {
					log.debug("There is no table of "+sTableName+" Config,continue...");
					continue;
				}
				//取得跨库配置 20151106
				Map<String, Object> both_map = DataBaseCache.getBothSyncFlag(sTableName);
				both_sync_flag = both_map.get("SYNC_FLAG").toString();
				both_chgsync_flag = both_map.get("CHG_BOTH_FLAG").toString();
				log.debug("both_sync_flag="+both_sync_flag+"--both_chgsync_flag="+both_chgsync_flag);
	
				/*取得同步数据DATARECORDS 记录*/
				List<Map<String, Object>> listDataRecds = (List<Map<String, Object>>) 
						mapTable.get(InterBusiConst.DATAODR_DATARCDS);//"DATARECORDS"
				for (Map<String, Object> tmpOpCol : listDataRecds) {

					Map<String, Object> mapOpCols = new HashMap<String, Object>();
					
					//放入数据库连接
					safeAddToMap(mapOpCols, "COLS", tmpOpCol.get("COLS"));
					safeAddToMap(mapOpCols, "OP", tmpOpCol.get("OP"));
					
					/**** add by zhangleij 20170223 取数据库时间 begin ****/
					Map<String, Object> dbTimeTmp = new HashMap<String, Object>();
					dbTimeTmp = (Map<String, Object>) baseDao.queryForObject("BK_dual.qSysdatebyDual");
					String dbTimeStr = dbTimeTmp.get("CUR_TIME").toString();
					log.debug("dbTimeStr="+dbTimeStr);
					safeAddToMap(mapOpCols, "CREATE_TIME", dbTimeStr);
					/**** add by zhangleij 20170223 取数据库时间 end ****/
					
					if (null != tmpOpCol.get("PK"))
						safeAddToMap(mapOpCols, "PK", tmpOpCol.get("PK"));	
					safeAddToMap(mapOpCols, "TABLE_NAME", sTableName);
					safeAddToMap(mapOpCols, "OPR_INFO", opr_info);
					safeAddToMap(mapOpCols, "CONN", conn);
					//放入跨库配置
					safeAddToMap(mapOpCols, "CONN_OTHER", conn_other);
					safeAddToMap(mapOpCols, "BOTH_SYNC_FLAG", both_sync_flag);

					//同步判断：跨库标识Y,则同步; 跨库标识等于N,且表配置跨库标识为Y,则同步
					if (in_sync_flag.equals("Y") 
							|| (in_sync_flag.equals("N") && both_sync_flag.equals("Y")) ) {
						Map<String, Object> outSqlChg = null;
						try {
							outSqlChg = dealDataOrder(mapOpCols, lstTableRel);
							if (null == outSqlChg) {
								log.error("dealDataOrder deal error,please check.bRet="+bRet);
								//回退数据，关闭连接
								rollBackAndClose(conn);
								//关闭跨库连接
								rollBackAndClose(conn_other);
								//插入错误历史表
								inputErrOrderDeal(mInParam, opr_info, "dealDataOrder deal error,please check.bRet="+bRet);					
								return bRet;
							}
							
						} catch (Exception e) {
							log.error(e.getMessage());
				            StackTraceElement[] error = e.getStackTrace();
				            for (StackTraceElement stackTraceElement : error){
				                log.error(stackTraceElement.toString());
				            }
				            
							//回退数据，关闭连接
							rollBackAndClose(conn);
							//关闭跨库连接
							rollBackAndClose(conn_other);
							//插入错误历史表
							inputErrOrderDeal(mInParam, opr_info, e.getMessage());					
							//退出循环
							return false;
						}
					
						//跨库同步:判断是否可做跨库同步（in_sync_flag！=N）；且当前表是否做跨库同步。 @20151106
						log.debug("--in_sync_flag="+in_sync_flag+"--both_sync_flag="+both_sync_flag);
						if (!in_sync_flag.equals("N") && both_sync_flag.equals("Y")) {
							try {
								//循环中报错后，不再跨库处理
								if (0 == both_err_count)
									bothSyncExec(outSqlChg, mapOpCols, both_chgsync_flag);
								
							} catch (Exception e) {
					            //记报错标识，自增1
					            both_err_count ++;
					            
					            both_sync_errmsg = e.getMessage();
					            log.error("跨库["+sOthrDbid+"]报错getmsg："+e.getMessage()+"etostr="+e.toString());
							}
						}
					}//跨库同步判断END

				}/*for DATARECORDS END*/
			}/*for TABLES END*/

			/*记入历史,若没有数据工单（只有费用工单），则不计入历史*/
			inJsonParamHis(mInParam, opr_info);
			
			/*记入跨库历史/错误表    @20151106*/
			if (!in_sync_flag.equals("N") && both_sync_flag.equals("Y")) {
				
				MBean bothBean = new MBean();
				bothBean.setHeader(mInParam.getHeader());
				//同时需转换报文中DB_ID为报错库的DB_ID；去掉BUSI_INFO业务工单
				bothBean.setDbId(sOthrDbid);
				
				Map<String, Object> body = new HashMap<String, Object>();
				body.putAll(mInParam.getBody()); body.remove(InterBusiConst.DATAODR_FEEINFO);
				bothBean.setBody(body);
				log.info("跨库记录报文bothBean:"+bothBean.toString());
				//暂不记录，，，
				inPutHisOrErr(bothBean, opr_info, both_err_count, conn_other,
						"5555", both_sync_errmsg);//成功入HIS不记录；失败记录。
			}
		}/*if != null*/
		else 
		{
			log.info("[DataSyn]:There is not any TABLES info in BODY.");
		}
		//注意：必须提交！！！！因为提交之后才能够继续处理业务工单。
		//commit提交并关闭连接
		CommitAndCloseConn(conn);
		//commit提交跨库数据操作，并关闭连接
		CommitAndCloseConn(conn_other);
		
		log.info("-数据工单结束,开始处理费用工单......opr_info:"+opr_info.toString());
		
		//判断跨库标识(!=N);处理存在的费用工单
		if (!in_sync_flag.equals("N") 
				&& mInParam.getBodyObject(InterBusiConst.DATAODR_FEEINFO) != null) {
				
			if (mInParam.getBodyObject(InterBusiConst.DATAODR_TABLES) != null)
				mInParam.remove(InterBusiConst.DATAODR_TABLES);
			log.debug("--dealFeeInfo--mInParam=["+mInParam.toString()+"]");
			
			Map<String, Object> oprInfo = 
					(Map<String, Object>) mInParam.getBodyObject(InterBusiConst.DATAODR_OPRINFO);
			List<Map<String, Object>> listBusiInfo = 
					(List<Map<String, Object>>) mInParam.getBodyList(InterBusiConst.DATAODR_FEEINFO);
			
			MBean opBean = null;
			for (Map<String, Object> tmpMap:listBusiInfo) {
				opBean = new MBean();
				opBean.setHeader(mInParam.getHeader());
				opBean.addBody(InterBusiConst.DATAODR_FEEINFO, tmpMap);
				opBean.addBody(InterBusiConst.DATAODR_OPRINFO, oprInfo);

				log.debug("---for--BUSI_CODE=["+tmpMap.get("BUSI_CODE").toString()
						+ "]-busiinfo=["+opBean.toString()+"]");
				String busi_code = "";
				try {
					busi_code = busiOrderSyn.getBusiCode(opBean);
					//设置A,B库
		            SessionContext.setDbLabel(sDbid);
		            
					busiOrderSyn.dealBusiOrderData(opBean.toString(), busi_code, "");
				} catch (Exception e) {
					DataSourceHelper.rollback(baseDao.getConnection());
					e.printStackTrace();
					
					//设置A,B库
		            SessionContext.setDbLabel(sDbid);
		            
					Map<String, Object> err_map = new HashMap<String, Object>();
					err_map.put("ERR_CODE", "0001");
					err_map.put("ERR_MSG", "-dataBusiOrder-errmsg="+e.toString());
					err_map.put("BUSI_CODE", busi_code);
					busiOrderSyn.inputBusiErr(opBean, err_map);
				}
			}
			//调用业务工单接口处理
			log.debug("----feeinfo over, END---");
		}
		
		return true;
	}
}
