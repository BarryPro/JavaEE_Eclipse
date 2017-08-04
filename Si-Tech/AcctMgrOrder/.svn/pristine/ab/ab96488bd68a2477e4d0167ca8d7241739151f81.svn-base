package com.sitech.acctmgr.app.dataorder;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.app.busiorder.BusiOrderSyn;
import com.sitech.acctmgr.app.common.InterBusiConst;
import com.sitech.acctmgr.app.common.JdbcConn;
import com.sitech.acctmgr.app.dataorder.splicesql.ISpliceSql;
import com.sitech.acctmgr.app.odrBlob.OdrLineContDAO;
import com.sitech.acctmgr.app.odrBlob.OdrLineContVO;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.jcf.core.datasource.DataSourceHelper;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcf.ijdbc.SqlChange;
import com.sitech.jcf.ijdbc.sql.SqlTypes;
import com.sitech.jcfx.dt.MBean;
import com.sitech.jcfx.util.DateUtil;

public class DataOrderComm extends BaseBusi {

	/*DataBaseCache 数据库配置缓存*/
	OdrLineContDAO odrLineContDAO; /*BLOB字段定义*/
	ISpecDataSyn   iSpecDataSyn;   /*分省操作 接口变量*/
	ISpliceSql     iSpliceSql;     /*拼接语句*/
	
	//费用工单
	BusiOrderSyn   busiOrderSyn;   /*费用工单*/

	public BusiOrderSyn getBusiOrderSyn() {
		return busiOrderSyn;
	}
	public void setBusiOrderSyn(BusiOrderSyn busiOrderSyn) {
		this.busiOrderSyn = busiOrderSyn;
	}
	public OdrLineContDAO getOdrLineContDAO() {
		return odrLineContDAO;
	}
	public void setOdrLineContDAO(OdrLineContDAO odrLineContDAO) {
		this.odrLineContDAO = odrLineContDAO;
	}
	public ISpecDataSyn getiSpecDataSyn() {
		return iSpecDataSyn;
	}
	public void setiSpecDataSyn(ISpecDataSyn iSpecDataSyn) {
		this.iSpecDataSyn = iSpecDataSyn;
	}
	public ISpliceSql getiSpliceSql() {
		return iSpliceSql;
	}
	public void setiSpliceSql(ISpliceSql iSpliceSql) {
		this.iSpliceSql = iSpliceSql;
	}
	
	/**************The Implements Start****************/
	

	/**
	 * Title:获取同步Json报文的Header信息
	 * Description:供DataOrder使用
	 * @param inJsonMBean
	 * @return Map
	 */
	protected Map<String, Object> getHeaderMap(MBean inJsonMBean) {
		Map<String, Object> outMap = new HashMap<String, Object>();
		outMap = inJsonMBean.getHeader();		
		return outMap;
	}
	
	/**
	 * Title  处理同步数据接口
	 * Description 真正开始处理数据的接口
	 * @param inOpColsMap
	 * @param inListDest
	 * @return true/false
	 * @throws Exception 
	 */
	protected Map<String, Object> dealDataOrder(Map<String, Object> inOpColsMap, List<Map<String, Object>> inListDest) {
		
		int iProvFlag = 0;
		String sSrcTabName = "";
		
		log.debug("----dataodr---dealdataorer----inOpcolMap="+inOpColsMap);
		sSrcTabName = inOpColsMap.get("TABLE_NAME").toString();
		/*分省特殊操作*/
		iProvFlag = provSpecOpt(sSrcTabName, inOpColsMap);
		if (iProvFlag < 0) {
			log.error("--分省特殊操作失败，iProvFlag="+iProvFlag);
			return null;
		}
		
		/*正常拼SQL串操作,拼接同步表及小表SQL语句，并执行*/
		return buildDynaSqlData(inOpColsMap, inListDest);
		
	}
	
	/**
	 * Title 操作成功入历史
	 * @param mbInParam
	 * @return
	 */
	protected boolean inJsonParamHis(MBean mbInParam, Map<String, Object> opr_info) {
		
		if (mbInParam.isEmpty())
			return true;
		
		int iIstNum = 0;
		String sGbId = mbInParam.getHeaderStr("DB_ID");
		Long lCrtAct = 0L;
		if (mbInParam.getHeaderLong("CREATE_ACCEPT") != null)
			lCrtAct = mbInParam.getHeaderLong("CREATE_ACCEPT");
		else 
			lCrtAct = getInterCreateAccept(17);
		
		byte[] byte_cont = null;
		try {
			byte_cont = mbInParam.toString().getBytes("GBK");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		OdrLineContVO odrLineContVO = new OdrLineContVO();
		odrLineContVO.setGsTopicId(InterBusiConst.DATAODR_TOPIC);
		odrLineContVO.setGbContent(byte_cont);
		odrLineContVO.setGsLoginAct((opr_info.get("ORDER_LINE_ID")!=null)?opr_info.get("ORDER_LINE_ID").toString():"");
		odrLineContVO.setGsOpCode((opr_info.get("OP_CODE")!=null)?opr_info.get("OP_CODE").toString().trim():"");
		odrLineContVO.setGsLoginNo((opr_info.get("LOGIN_NO")!=null)?opr_info.get("LOGIN_NO").toString():"");
		odrLineContVO.setGlCreatAct(lCrtAct);
		odrLineContVO.setGsDataSrc(sGbId);
		odrLineContVO.setGsBusiidNo("0");
		odrLineContVO.setGsBusiidType("4");
		iIstNum = odrLineContDAO.insertRcvOdrCont(odrLineContVO);
		/*if (0 == iIstNum) {
			//System.out.println("数据同步插入历史错误！插入数据["+iIstNum+"]条！");
			//throw new BusiException(AcctMgrError.getErrorCode("0000","10001"), "数据同步插入历史错误！插入数据["+iIstNum+"]条！");
		}*/
		
		return true;
	}
	
	/**
	 * Title 私有接口：调用省份接口处理特殊操作
	 * Description:会判断是否需要省分处理
	 * @param inTabName
	 * @return
	 */
	private int provSpecOpt(String inTabName, Map<String, Object> inOpColsMap) {
		
		int iProvDealFlag = 0;
		log.debug("----provseecopt====inOpColsMap="+inOpColsMap.toString());
		//判断是否省分处理
		if (iSpecDataSyn.isPerProvBusi()) {
			iProvDealFlag = 1;
			
			if (inTabName.equalsIgnoreCase("CS_CRMTOBOSSSTATE_INFO")) {
				if (iSpecDataSyn.updateCbUserStatus(inOpColsMap) == false) {
					iProvDealFlag = -1;
					log.error("updateCbUserStatus error,please check!");
					return iProvDealFlag;
					//throw new BusiException(AcctMgrError.getErrorCode("0000","10002"), "数据同步省分特殊操作执行错误！UR_BOSSTOCRMSTATE_INFO.");
				}
			} else if (inTabName.equalsIgnoreCase("CS_CONUSERREL_INFO")) {
				if (iSpecDataSyn.inConUserRelDead(inOpColsMap) == false) {
					iProvDealFlag = -3;
					log.error("inConUserRelDead error,please check!");
					return iProvDealFlag;
					//throw new BusiException(AcctMgrError.getErrorCode("0000","10003"), "数据同步省分特殊操作执行错误！PD_USERFAV_INFO.");
				}
			} else if (inTabName.equalsIgnoreCase("UR_USER_INFO") && inOpColsMap.get("OP").toString().equals("D")) {
				//删除UR_USER_INFO时，插入UR_USER_SYNC
				if (iSpecDataSyn.insertUserSync(inOpColsMap) == false) {
					iProvDealFlag = -2;
					log.error("insert ur_user_sync error,please check!");
					return iProvDealFlag;
					//throw new BusiException(AcctMgrError.getErrorCode("0000","10003"), "数据同步省分特殊操作执行错误！PD_USERFAV_INFO.");
				}
			}
		}
		
		return iProvDealFlag;
	}
	
	/**
	 * Title  私有接口：创建动态SQL语句并执行
	 * @param inDataMap
	 * @param inLstDest
	 * @return -1 0 1
	 * @throws Exception 
	 */
	private Map<String, Object> buildDynaSqlData(Map<String, Object> inDataMap, List<Map<String, Object>> inLstDest) {
		log.debug("---buildDynaSqlData stt--");
		
		String sOpType = "";
		/*开始拼接动态SQL语句,设置数据库参数*/
		Map<String, Object> outSqlMap = null;
		
		/*处理BOSS自有字段，特殊处理等*/
		log.debug("---boss自有字段 stt--inDataMap="+inDataMap.toString());
		Map<String, Object> outSpecData = new HashMap<String, Object>();
		try {
			outSpecData = iSpecDataSyn.getProvSpecOptData(inDataMap, inLstDest);
		} catch (Exception e) {
			throw new BusiException(AcctMgrError.getErrorCode("0000","10026"), "getProvSpecOptData error!");
		}
		if (outSpecData != null && outSpecData.size() != 0) {
			outSqlMap = new HashMap<String, Object>();
			outSqlMap = (Map<String, Object>) inDataMap.get("COLS");
			outSqlMap.putAll(outSpecData);
			
			inDataMap.put("COLS", outSqlMap);
		}
		log.debug("---dataordercomom--indatamap="+inDataMap.toString());
		outSqlMap = new HashMap<String, Object>();
		
		/*拼接完整同步表语句*/
		sOpType = inDataMap.get("OP").toString();
		if (sOpType.equals(InterBusiConst.DATA_OPER_TYPE_INSERT)) {
			outSqlMap = iSpliceSql.spliceInsertSql(inDataMap, inLstDest);
			if (null == outSqlMap) {
				log.error("----Splice the INSERT SQL error,please check!!!!");
				throw new BusiException(AcctMgrError.getErrorCode("0000","10022"), "Splice the INSERT SQL error!"); 
			}
		} else if (sOpType.equals(InterBusiConst.DATA_OPER_TYPE_DELETE)
				|| sOpType.equals(InterBusiConst.DATA_OPER_TYPE_SPECIAL)
				|| sOpType.equals(InterBusiConst.DATA_OPER_TYPE_UPDATE)) {
			outSqlMap = iSpliceSql.spliceInstSqlToChg(inDataMap, inLstDest, (Connection)inDataMap.get("CONN"));
			if (null == outSqlMap) {
				log.error("----Splice the INSERT CHG SQL error,please check!!!!");
				throw new BusiException(AcctMgrError.getErrorCode("0000","10023"), "Splice the DELETE SQL error!"); 
			}	
		} else {
			log.error("buildDynaSqlData error,please check! OP_TYPE=" + sOpType);
			return null;
		}
		
		String sChgTabName = "";
		SqlChange outSqlChg = null;
		SqlChange outSqlChgChg = null;
		StringBuffer sSqlDataBuf = new StringBuffer();
		StringBuffer sChgSqlBuf = new StringBuffer();

		Connection conn = (Connection) inDataMap.get("CONN");
		Connection conn_other = (Connection) inDataMap.get("CONN_OTHER");
		String     both_flag = (String) inDataMap.get("BOTH_SYNC_FLAG");
		int retOper = 0;
		
		/*取得Sql语句SqlChange变量*/
		sSqlDataBuf = (StringBuffer) outSqlMap.get("SYN_SQLBUF");
		outSqlChg = (SqlChange) outSqlMap.get("SYN_SQLCHG");
		
		retOper = operJdbcSqlState(sSqlDataBuf, outSqlChg, conn);
		if (retOper < 1) {
			throw new BusiException(AcctMgrError.getErrorCode("0000","10027"),
					"数据异常， "+retOper+"条数据被操作! sql="+sSqlDataBuf.toString());
		}
		
		/*---------20150415 同步多张小表处理 STT---------*/
		/*
		 * 1. CHG_TABLE中配置多帐小表，小表之间"#"隔开。如UR_USER_INT1#UR_USER_INT2
		 * 2. 循环从in_cbtable_chgsync_rel取对应小表自有字段配置
		 * 3. 生成List<Map>型存储各个小表落地数据。Map中Key有：SQLBUF/SQLCHG/TABLE
		 * 4. 最后返回Map(outSqlMap)中，List<Map>以Key=CHGTABS存入outSqlMap
		 */
		/*JDBC执行拼接完成的同步表、小表语句*/
		if (outSqlMap.get("CHGTABS") != null) {
			
			List<Map<String, Object>> chgTabMaps = (List<Map<String, Object>>) outSqlMap.get("CHGTABS");
			for (Map<String, Object> tmpChgTab:chgTabMaps) {
				sChgTabName = tmpChgTab.get("TABLE").toString();
				log.debug("----小表同步落地0415---sChgTabName="+sChgTabName);
				sChgSqlBuf = (StringBuffer) tmpChgTab.get("SQLBUF");
				outSqlChgChg = (SqlChange) tmpChgTab.get("SQLCHG");
				retOper = operJdbcSqlState(sChgSqlBuf, outSqlChgChg, conn);
				if (retOper < 1) {
					throw new BusiException(AcctMgrError.getErrorCode("0000","10028"),
							"数据异常， "+retOper+"条数据被操作! sql="+sChgSqlBuf.toString());
				}
				
			}//for end
		}//if end
		
		return outSqlMap;
	}
	
	/**
	 * Title  执行拼装的Sql语句
	 * Description 执行拼装好的Sql语句，同步数据
	 * @param inSqlBuf
	 * @param inSqlChg
	 * @param inChgSqlBuf
	 * @param inChgTabName
	 * @param inSqlChgChg
	 * @return
	 */
	public int operJdbcSqlState(StringBuffer inSqlBuf, SqlChange inSqlChg, Connection conn) {
		int exec_rows = 0;
		try {
			/*执行 sSqlDataBuf 处理数据*/
			/*获得DB_ID和配置数据源的映射关系*/
			exec_rows = inSqlChg.execute(conn, inSqlBuf.toString());
			log.debug("----EXEC SUCCESS----Oper data rows="+exec_rows);
			
			//提交,外部提交
		} catch(SQLException e){
			log.error("--data--execute the sqlbuffer error,please check!----");
			//执行语句若报错，为联调问题，暂不记录异常
			
			e.printStackTrace();
			//DataSourceHelper.rollback(conn);
			return -1;
		}
		
		return exec_rows;
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
	
	/**
	 * 跨库同步方法
	 * @param inSqlMap
	 * @param inDataMap
	 * @return
	 */
	protected boolean bothSyncExec(Map<String, Object> inSqlChg, Map<String, Object> inDataMap, String in_both_chgsync) {
		String sChgTabName = "";
		SqlChange outSqlChg = null;
		SqlChange outSqlChgChg = null;
		StringBuffer sSqlDataBuf = new StringBuffer();
		StringBuffer sChgSqlBuf = new StringBuffer();

		Connection conn_other = (Connection) inDataMap.get("CONN_OTHER");
		int retOper = 0;
		log.debug("跨库操作数据连接:"+conn_other);
		
		/*取得Sql语句SqlChange变量*/
		sSqlDataBuf = (StringBuffer) inSqlChg.get("SYN_SQLBUF");
		outSqlChg = (SqlChange) inSqlChg.get("SYN_SQLCHG");
		
		retOper = operJdbcSqlState(sSqlDataBuf, outSqlChg, conn_other);
		if (retOper < 1) {
			throw new BusiException(AcctMgrError.getErrorCode("0000","10030"),
					"跨库数据异常， "+retOper+"条数据被操作! sql="+sSqlDataBuf.toString());
		}
		
		/*---------20150415 同步多张小表处理 STT---------*/
		/*
		 * 1. CHG_TABLE中配置多帐小表，小表之间"#"隔开。如UR_USER_INT1#UR_USER_INT2
		 * 2. 循环从in_cbtable_chgsync_rel取对应小表自有字段配置
		 * 3. 生成List<Map>型存储各个小表落地数据。Map中Key有：SQLBUF/SQLCHG/TABLE
		 * 4. 最后返回Map(outSqlMap)中，List<Map>以Key=CHGTABS存入outSqlMap
		 */
		/*JDBC执行拼接完成的同步表、小表语句；且跨库时，小表不需要同步（in_both_chgsync=Y，则同步）*/
		if (inSqlChg.get("CHGTABS") != null && in_both_chgsync.equals("Y")) {
			
			List<Map<String, Object>> chgTabMaps = (List<Map<String, Object>>) inSqlChg.get("CHGTABS");
			for (Map<String, Object> tmpChgTab:chgTabMaps) {
				sChgTabName = tmpChgTab.get("TABLE").toString();
				log.debug("----小表同步落地0415---sChgTabName="+sChgTabName);
				sChgSqlBuf = (StringBuffer) tmpChgTab.get("SQLBUF");
				outSqlChgChg = (SqlChange) tmpChgTab.get("SQLCHG");
				retOper = operJdbcSqlState(sChgSqlBuf, outSqlChgChg, conn_other);
				if (retOper < 1) {
					throw new BusiException(AcctMgrError.getErrorCode("0000","10031"),
							"跨库小表数据异常， "+retOper+"条数据被操作! sql="+sChgSqlBuf.toString());
				}
				
			}
		}
		
		return true;
	}
	
	/**
	 * Title 操作成功入历史
	 * @param inPutBothSyncHis(mInParam, opr_info, both_err_count)
	 * @return
	 */
	protected boolean inPutHisOrErr(MBean mbInParam, Map<String, Object> opr_info
			, int err_count, Connection conn_other, String err_code, String err_msg) {
		
		if (err_count > 0) {
			//回退已提交数据
			DataSourceHelper.rollback(conn_other);
		}
		
		if (mbInParam.isEmpty())
			return true;
		
		String db_id = mbInParam.getHeaderStr("DB_ID");
		String login_accept = (opr_info.get("ORDER_LINE_ID")!=null)?opr_info.get("ORDER_LINE_ID").toString():"";
		String create_accept = null;
		
		JdbcConn jdbcConn = new JdbcConn(conn_other);
		if (0 == err_count) {
			//不入跨库历史
			//jdbcConn.setSqlBuffer(InterBusiConst.DATAODR_INPUT_HIS);
		} else if (0 < err_count) {
			//取流水
			JdbcConn jc = new JdbcConn(conn_other);
			jc.setSqlBuffer("select to_char(sysdate, 'YYMMDDHH24MISS')||SEQ_INTERFACE_SN.Nextval SEQ_NO from dual");
			List<Map<String, Object>> list = jc.select();
			create_accept = list.get(0).get("SEQ_NO").toString();
			
			//入错误表
			jdbcConn.setSqlBuffer(InterBusiConst.DATAODR_INPUT_ERR);
			jdbcConn.addParam("CREATE_ACCEPT", create_accept);
		
			jdbcConn.addParam("DATA_SOURCE", db_id);
			jdbcConn.addParam("BUSIID_NO", "0");
			jdbcConn.addParam("BUSIID_TYPE", "4");
			jdbcConn.addParam("TOPIC_ID", InterBusiConst.DATAODR_TOPIC);
			//JCF框架不支持，入EMPTY_BLOB()空报文//jdbcConn.addParam("CONTENT", mbInParam.toString(), SqlTypes.BLOB);
			jdbcConn.addParam("LOGIN_ACCEPT", login_accept);
			jdbcConn.addParam("OP_CODE", (opr_info.get("OP_CODE")!=null)?opr_info.get("OP_CODE").toString().trim():"");
			jdbcConn.addParam("LOGIN_NO", (opr_info.get("LOGIN_NO")!=null)?opr_info.get("LOGIN_NO").toString():"");

			jdbcConn.addParam("ERR_CODE", err_code);
			jdbcConn.addParam("ERR_MSG", "跨库报错:"+err_msg);
			log.debug("跨库记录err_count="+err_count+"errmsg="+err_msg);
			//执行入库操作
			jdbcConn.execuse();
			
			//若入ERR表，更新BLOB字段
			byte[] byte_cont = null;
			try {
				byte_cont = mbInParam.toString().getBytes("GBK");
			} catch (UnsupportedEncodingException e) {e.printStackTrace();}
			
			//参数组
			int[] para_types = {0} ;
			String[] para_vals = {""};
			para_types[0] = SqlTypes.JSTRING;
			para_vals[0] = create_accept;
			//更新BLOB字段
			int ret = jdbcConn.updateBlob(InterBusiConst.DATAODR_UPDTERR_BLOB, byte_cont, para_vals, para_types);
			log.debug("更新BLOB字段返回:"+ret);
			if (ret != 0) {
				log.error("更新BLOB字段失败，mbInParam="+mbInParam.toString());
				//不返回报错
			}
		}
		
		return true;
	}
	
}
