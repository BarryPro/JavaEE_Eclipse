package com.sitech.acctmgr.app.dataorder;

import java.sql.Connection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.app.common.AppProperties;
import com.sitech.acctmgr.app.common.InterBusiConst;
import com.sitech.acctmgr.app.common.JdbcConn;
import com.sitech.acctmgr.common.AcctMgrError;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcf.ijdbc.sql.SqlTypes;
import com.sitech.jcfx.util.DateUtil;

public class SpecDataSynJL extends BaseBusi implements ISpecDataSyn {

	/**
	 * Title 是否分省处理
	 * Description 部分业务为省个性化处理，单独封接口处理
	 * @return True:需要分省 False:不需要
	 */
	public boolean isPerProvBusi() {
		//判断是否分省逻辑,暂时不处理
		if (AppProperties.getConfigByMap("DATA_ISPERV").equals("true"))
			return true;
		else
			return false;
	}

	/**
	 * Title 私有接口：个性化更新用户数据
	 * @param inTabOpMap
	 * @return true or false
	 */
	public boolean updateCbUserStatus(Map<String, Object> inTabOpMap) {
		
		int iInstRows = 0;
		String sOpType = "";
		String sBossRunCode = "";
		//String sCrmRunCode = "";
		Map<String, Object> colmsMap = new HashMap<String, Object>();
		List<Map<String, Object>> list = null;
		Map<String, Object> tmpMap = null;
		
		sOpType = inTabOpMap.get("OP").toString();
		colmsMap.putAll((Map<String, Object>) inTabOpMap.get("COLS"));
		String id_no = colmsMap.get("ID_NO").toString();
		
		Map<String, Object> oprInfo = (Map<String, Object>) inTabOpMap.get("OPR_INFO");
		
		Connection conn = (Connection) inTabOpMap.get("CONN");
		JdbcConn jdbcConn = new JdbcConn(conn);
		
		/*1.新开户插入一条记录,不再做用户状态合成*/
		if (sOpType.equals(InterBusiConst.DATA_OPER_TYPE_INSERT)) {
			/*插入操作直接返回，后续拼串执行插入*/
			return true;
		}
		
		if (sOpType.equals(InterBusiConst.DATA_OPER_TYPE_DELETE)) {
			colmsMap.put("CRM_RUN_CODE", "a");
		}
		
		colmsMap.put("CRM_RUN_TIME", DateUtil.format(new Date(), "yyyyMMddHHmmss"));
		colmsMap.put("REMARK", "CRM--BOSS数据同步接口插入记录");
		colmsMap.put("OPT_SN", "-1");
		colmsMap.put("IN_LOGIN_NO", "c2b");
		colmsMap.put("IN_LOGIN_NO", "c2b");
		
		/*查询BOSSRUNCODE 和 合成新状态*/
		String sNewRunCode = "";
		//sBossRunCode = (String) baseDao.queryForObject("BK_ur_bosstocrmstate_info.qBossRunCodeByIdNo", colmsMap);
		jdbcConn.setSqlBuffer(InterBusiConst.DATAODR_QUERY_RUNCODE_BY_IDNO);
		jdbcConn.addParam("ID_NO", id_no, SqlTypes.JLONG);
		list = jdbcConn.select();
		if(list != null && (list.size() == 1)){
			tmpMap = list.get(0);
			sBossRunCode = tmpMap.get("BOSS_RUN_CODE").toString();	
		}
		else
		{
			log.error("query UR_BOSSTOCRMSTATE_INFO error,please check!");
			return false;
		}
		/*9状态全部变为A状态 ACTION_ID=12461,传入的CRM_RUN_CODE为A @20150905*/
		Map<String, Object> opr_info = (Map<String, Object>) inTabOpMap.get("OPR_INFO");
		if (opr_info.get("ACTION_ID") != null && opr_info.get("ACTION_ID").toString().equals("12461")) {
			colmsMap.put("CRM_RUN_CODE", "A");
			sBossRunCode = "A";
		}
		colmsMap.put("BOSS_RUN_CODE", sBossRunCode);
		
		//sNewRunCode = (String) baseDao.queryForObject("BK_cs_runcode_comprule_dict.qRunCodeByBossAndCrmRun", colmsMap);
		jdbcConn.setSqlBuffer(InterBusiConst.DATAODR_QUERY_RUNCODE);
		jdbcConn.addParam("CRM_RUN_CODE", colmsMap.get("CRM_RUN_CODE").toString());
		jdbcConn.addParam("BOSS_RUN_CODE", sBossRunCode);
		list = jdbcConn.select();
		if(list != null && (list.size() == 1)){
			tmpMap = list.get(0);
			sNewRunCode = (String) tmpMap.get("RUN_CODE");	
		}
		else
		{
			log.error("query CS_RUNCODE_COMPRULE_DICT error,please check!");
			return false;
		}
		
		if (null == sBossRunCode || null == sNewRunCode) {
			log.error("query ur_bosstocrmstate_info error,please check!");
			throw new BusiException(AcctMgrError.getErrorCode("0000","7005"), 
					"数据同步省分查询执行错误！sBossRunCode="+sBossRunCode);
		}
		colmsMap.put("RUN_CODE", sNewRunCode);
		
		/*入历史*/
		colmsMap.put("REMARK", "CRM--BOSS数据工单移入历史");
		//baseDao.insert("BK_ur_bosstocrmstate_his.iBossToCrmMmByIdNo", colmsMap);
		jdbcConn.setSqlBuffer(InterBusiConst.DATAODR_UPDT_BTC);
		jdbcConn.addParam("OPT_SN", "-1");
		jdbcConn.addParam("IN_LOGIN_NO", "c2b");
		jdbcConn.addParam("REMARK", "CRM--BOSS数据同步接口插入记录");
		jdbcConn.addParam("ID_NO", id_no, SqlTypes.JLONG);
		jdbcConn.execuse();
		
		/*将变更信息写入INT_BOSSTOCRMSTATE_CHG小表*/
		
		/*2.更新操作 或 删除操作*/
		if (sOpType.equals(InterBusiConst.DATA_OPER_TYPE_UPDATE) 
				|| sOpType.equals(InterBusiConst.DATA_OPER_TYPE_SPECIAL)) {
			/*更新CS_USERDETAIL_INFO表的RUN_CODE*/
			//baseDao.update("BK_cs_userdetail_info.uRunCodeByIdNo", colmsMap);
			jdbcConn.setSqlBuffer(InterBusiConst.DATAODR_UPDT_DTE);
			//UPDATE CS_USERDETAIL_INFO SET OLD_RUN=RUN_CODE, OP_TIME=sysdate, 
			//RUN_CODE=?, RUN_TIME=TO_DATE(?, 'YYYYMMDDHH24MISS'), OP_CODE=?, LOGIN_NO=? WHERE ID_NO=?
			jdbcConn.addParam("RUN_CODE", colmsMap.get("RUN_CODE").toString());
			jdbcConn.addParam("RUN_TIME", colmsMap.get("CRM_RUN_TIME").toString());
			jdbcConn.addParam("OP_CODE", colmsMap.get("OP_CODE").toString());
			jdbcConn.addParam("LOGIN_NO", colmsMap.get("IN_LOGIN_NO").toString());
			jdbcConn.addParam("ID_NO", id_no, SqlTypes.JLONG);
			jdbcConn.execuse();
			
			/*更新小表*/
			//取得流水
			String mmdd = DateUtil.format(new Date(), "MMdd").toString();
			tmpMap = new HashMap<String, Object>();		
			tmpMap.put("SEQ_NAME", "SEQ_INT_DEAL_FLAG");
			Map<String, Object> result = null;
			result = (Map<String, Object>) baseDao.queryForObject("BK_dual.qSequenceInter", tmpMap);
			String sIntSequenValue1 = result.get("NEXTVAL").toString()+mmdd;
			result = (Map<String, Object>) baseDao.queryForObject("BK_dual.qSequenceInter", tmpMap);
			String sIntSequenValue2 = result.get("NEXTVAL").toString()+mmdd;
			//更新ACCHG
			jdbcConn.setSqlBuffer(InterBusiConst.DATAODR_INST_DTE_ACCHG);
			jdbcConn.addParam("SEQ_NO", sIntSequenValue1, SqlTypes.JLONG);
			jdbcConn.addParam("OP_FLAG", "2", SqlTypes.JINT);//更新
			jdbcConn.addParam("ID_NO", id_no, SqlTypes.JLONG);
			jdbcConn.execuse();
			jdbcConn.setSqlBuffer(InterBusiConst.DATAODR_INST_DTE_BICHG);
			jdbcConn.addParam("SEQ_NO", sIntSequenValue2, SqlTypes.JLONG);
			jdbcConn.addParam("OP_FLAG", "2", SqlTypes.JINT);//更新
			jdbcConn.addParam("ID_NO", id_no, SqlTypes.JLONG);
			jdbcConn.execuse();
			
			Map<String, Object> out_data = (Map<String, Object>) 
					baseDao.queryForObject("BK_ur_user_info.qCoBrGrpbyIdNo", Long.parseLong(id_no));
			String order_line_id = oprInfo.get("ORDER_LINE_ID")!=null?oprInfo.get("ORDER_LINE_ID").toString():"";
			String login_no = colmsMap.get("LOGIN_NO")!=null?colmsMap.get("LOGIN_NO").toString():"";
			String op_code = colmsMap.get("OP_CODE")!=null?colmsMap.get("OP_CODE").toString():"";
			
			//更新入bal_userchg_recd @20150922 wangzhia信控确认
			String DATAODR_USERCHG_INST = "insert into bal_userchg_recd"
					+ " (COMMAND_ID, TOTAL_DATE, PAY_SN, ID_NO, CONTRACT_NO, GROUP_ID, BRAND_ID, PHONE_NO,"
					+ " OLD_RUN, RUN_CODE, OP_TIME, OP_CODE, LOGIN_NO, LOGIN_GROUP, REMARK) "
					+ "select SEQ_COMMON_ID.nextval, to_number(to_char(run_time, 'YYYYMMDD')), ?, ?, ?, ?, ?, ?,"
					+ " old_run, run_code, sysdate, ?, ?, ?, ? "
					+ "from cs_userdetail_info where id_no = ?";
			jdbcConn.setSqlBuffer(InterBusiConst.DATAODR_USERCHG_INST);
			jdbcConn.addParam("PAY_SN",      "0", SqlTypes.JLONG);
			jdbcConn.addParam("ID_NO",       id_no, SqlTypes.JLONG);
			jdbcConn.addParam("CONTRACT_NO", out_data.get("CONTRACT_NO").toString(), SqlTypes.JLONG);
			jdbcConn.addParam("GROUP_ID",    out_data.get("GROUP_ID").toString(), SqlTypes.JSTRING);
			jdbcConn.addParam("BRAND_ID",    out_data.get("BRAND_ID").toString(), SqlTypes.JSTRING);
			jdbcConn.addParam("PHONE_NO",    out_data.get("PHONE_NO").toString(), SqlTypes.JSTRING);
			jdbcConn.addParam("OP_CODE",     op_code, SqlTypes.JSTRING);
			jdbcConn.addParam("LOGIN_NO",    login_no, SqlTypes.JSTRING);
			jdbcConn.addParam("LOGIN_GROUP", "", SqlTypes.JSTRING);
			jdbcConn.addParam("REMARK",      "crm->bossDataSyn:"+order_line_id, SqlTypes.JSTRING);
			jdbcConn.addParam("ID_NO",       id_no, SqlTypes.JLONG);
			jdbcConn.execuse();
			
		}
		//设置修改的值，后边拼工单使用
		//inTabOpMap.put("COLS", colmsMap);
		
		return true;
	}

	/**
	 * Title 私有接口：更新用户数据
	 * @param inSynTabMap
	 * @return
	 */
	public boolean updateCbUserFav(Map<String, Object> inTabOpMap) {
		String sOpType = "";
		String sFavNum = "";
		Map<String, Object> outTmpMap = new HashMap<String, Object>();
		outTmpMap.putAll(inTabOpMap);
		
		sOpType = outTmpMap.get("OP").toString();
		if (sOpType.equals(InterBusiConst.DATA_OPER_TYPE_DELETE) 
			 || sOpType.equals(InterBusiConst.DATA_OPER_TYPE_UPDATE)) {
			sFavNum = (String) baseDao.queryForObject("pd_userfav_info.qOrderCodeByIdNoColId", outTmpMap);
		} else if (sOpType.equals(InterBusiConst.DATA_OPER_TYPE_INSERT)) {
			Map<String, String> inMap = new HashMap<String, String>();
			inMap.put("SEQ_NAME", "BILL_IDX_USERFAV_SEQUENCE");//从四川取过来BILL_IDX_USERFAV_SEQUENCE
			Map<String, String> rstMap = new HashMap<String, String>();
			rstMap = (Map<String, String>) baseDao.queryForObject("BK_dual.qSequenceInter" ,inMap);
			sFavNum = rstMap.get("NEXTVAL").toString();
		}
		outTmpMap.put("PD_FAVNUM", sFavNum);
		inTabOpMap.clear();
		inTabOpMap.putAll(outTmpMap);
		
		return true;
	}
	
	/**
	 * Title 私有接口：删除时入dead表
	 * @date 2015/03/30
	 * @param inSynTabMap
	 * @return
	 */
	public boolean inConUserRelDead(Map<String, Object> inTabOpMap) {

		Map<String, Object> tmpMap = (Map<String, Object>) inTabOpMap.get("COLS");
		Connection conn = (Connection) inTabOpMap.get("CONN");
		JdbcConn jdbcConn = new JdbcConn(conn);
		
		String sOpType = inTabOpMap.get("OP").toString();
		if (sOpType.equals(InterBusiConst.DATA_OPER_TYPE_DELETE)) {
			jdbcConn.setSqlBuffer(InterBusiConst.DATAODR_INST_DEAD_CONUSER);
			jdbcConn.addParam("OP_CODE", "ctb");
			jdbcConn.addParam("LOGIN_NO", "ctb");
			jdbcConn.addParam("LOGIN_ACCEPT", "-1");
			jdbcConn.addParam("REMARK", "crmToBoss数据同步");
			jdbcConn.addParam("SERV_ACCT_ID", tmpMap.get("SERV_ACCT_ID").toString(), SqlTypes.JLONG);
			jdbcConn.execuse();
			
		}
		
		return true;
	}
	
	/**
	 * Title 表字段不同，boss侧自有字段，单独处理
	 */
	public Map<String, Object> getProvSpecOptData(Map<String, Object> inDataMap
			, List<Map<String, Object>> inLstDest) {
		
		int iDealNum = 0;
		int iUserFavFlag = 0;
		int iCycleFlag = 0;
		String sEffDate = "";
		String sCurFlag = "";
		String sExpDate = "";
		String sCycleBegin = "";
		String sCycleEnd = "";
		String sBeginDay = "";
		String sCurTime = "";
		Map<String, Object> inMap = null;
		Map<String, Object> outTmpMap = new HashMap<String, Object>();
		Map<String, Object> mapCols = new HashMap<String, Object>();
		
		String sTableName = inDataMap.get("TABLE_NAME").toString();
		String sOpType = inDataMap.get("OP").toString();
		mapCols = (Map<String, Object>) inDataMap.get("COLS");
		log.debug("----sTableName="+sTableName+"soptype="+sOpType+mapCols.toString());
		
		/*是否省份个性业务*/
		if (isPerProvBusi()) {
			String sPhoneNo = "";
			String sXhPhoneNo = "";
			String sIdNo = "";
			String sSyncFlag = "";
			
			iDealNum = 1;
			
			if (sTableName.equalsIgnoreCase("PD_USERFAV_INFO")) {
				iUserFavFlag = 1;
				/*返回结果*/
				outTmpMap.put("USERFAV_FLAG", iUserFavFlag);
			}
			
			if (sTableName.equalsIgnoreCase("UR_BILLDAY_INFO") 
					|| sTableName.equalsIgnoreCase("UR_BILLDAYDEAD_INFO")) {
				log.debug("---stablename==="+sTableName);
				iCycleFlag = 1;
				if (mapCols.get("DUR_FLAG") != null 
						&& mapCols.get("EFF_DATE") != null
						&& mapCols.get("EXP_DATE") != null)
				{
					log.debug("---------iCycleFlag="+iCycleFlag);
					sCurFlag = mapCols.get("DUR_FLAG").toString();
					sEffDate = mapCols.get("EFF_DATE").toString();
					sExpDate = mapCols.get("EXP_DATE").toString();
					log.debug("---------sCurFlag="+sCurFlag+" sEffDate="+sEffDate+" sExpDate="+sExpDate);
					
					sCycleBegin = sEffDate.substring(0, 6);
					if (sCurFlag.equals("1")) {
						log.debug("----CurFlag="+sCurFlag);
						sCycleEnd = DateUtil.toStringPlusMonths(sExpDate, -1, "yyyyMMddHHmmss").substring(0, 6);
						log.debug("---------------sCycleEnd="+sCycleEnd+" sExpDate="+sExpDate);
					} else if (sCurFlag.equals("4")) {
						sCycleEnd = sCycleBegin.substring(0, 6);
					} else {
						sCycleEnd = sExpDate.substring(0, 6);
					}
					log.debug("---------sCycleBegin="+sCycleBegin+" sCycleEnd="+sCycleEnd);
	
					if (sCurFlag.equals("0") || sCurFlag.equals("3")) {
						sBeginDay = "01";
					} else {
						sBeginDay= sEffDate.substring(6, 8);
					}
					log.debug("---------sBeginDay="+sBeginDay);
					
					/*返回结果*/
					outTmpMap.put("END_CYCLE", sCycleEnd);
					outTmpMap.put("BEGIN_DAY", sBeginDay);
					outTmpMap.put("BEGIN_CYCLE", sCycleBegin);
				}
			}

			//syncFlag=3,删除操作不删除，只做Special操作(根据主键更新该条数据)
			//syncFlag=4,预约删除正常删除，非预约的不删除，修改结束时间
			sSyncFlag = getValueListDest("SYNC_FLAG", inLstDest);
			inDataMap.put("SYNC_FLAG", sSyncFlag);
			log.debug("---ssyncflaga="+sSyncFlag+mapCols);
			sCurTime = DateUtil.format(new Date(),"yyyyMMddHHmmss").toString();
			if (sOpType.equals(InterBusiConst.DATA_OPER_TYPE_DELETE) 
					&& (sSyncFlag.equals("3") || sSyncFlag.equals("4"))) {
				if (mapCols.get("EFF_DATE") != null || mapCols.get("END_TIME") != null) {
					if (mapCols.get("EFF_DATE") != null)
						sEffDate = mapCols.get("EFF_DATE").toString();
					else if (mapCols.get("END_TIME") != null)
						sEffDate = mapCols.get("END_TIME").toString();
					if (sEffDate.compareTo(sCurTime) > 0 && sSyncFlag.equals("4")) {
						sOpType = InterBusiConst.DATA_OPER_TYPE_DELETE;//"D"
					} else {
						sOpType = InterBusiConst.DATA_OPER_TYPE_SPECIAL;//"X"
						outTmpMap.put("EXP_DATE", sCurTime);
						outTmpMap.put("END_TIME", sCurTime);
						
					}
				} else {
					sOpType = InterBusiConst.DATA_OPER_TYPE_SPECIAL;//"X"
					outTmpMap.put("EXP_DATE", sCurTime);
					outTmpMap.put("END_TIME", sCurTime);
					
				}
				/*返回结果*/
				inDataMap.put("OP", sOpType);
			}
		}/*isPerProvBusi end*/
		outTmpMap.put("DEAL_NUM", iDealNum);

		return outTmpMap;
	}
	
	
	/**
	 * 私有接口：循环list,查询特定参数值
	 * @param sColName
	 * @param inLstDest
	 * @return
	 */
	private String getValueListDest(String sColName, List<Map<String, Object>> inLstDest) {
		String sColValue = "";
		String sColumName = "";		

		if (inLstDest.size() != 0)
			for (Map<String, Object> mapCols : inLstDest) {
				Iterator iterator = mapCols.entrySet().iterator();
				while (iterator.hasNext()) {
					sColumName = "";
					sColValue = "";
					Map.Entry<String, Object> entry = (Map.Entry<String, Object>) iterator.next();
					sColumName = entry.getKey().toString();
					if (sColumName.equalsIgnoreCase(sColName)) {
						sColValue = entry.getValue().toString();
						return sColValue;
					}
				}
			}
		
		return sColValue;
	}


	@Override
	public boolean insertUserSync(Map<String, Object> mapCols) {
		
		log.debug("---usersyncstt--mapCols="+mapCols.toString());
		/*当删除操作时，需要将用户数据插入ur_user_sync 表中*/
		if (mapCols.get("COLS") != null)
		{
			log.debug("---usersyncstt--mapCols="+mapCols.get("COLS"));
			//baseDao.insert("BK_bal_user_sync.iUserSyncByCols", (Map<String, Object>)mapCols.get("COLS"));
			Map<String, Object> colMap = (Map<String, Object>)mapCols.get("COLS");
			Connection conn = (Connection) mapCols.get("CONN");
			JdbcConn jdbcConn = new JdbcConn(conn);
			jdbcConn.setSqlBuffer(InterBusiConst.DATAODR_USERSYNC_INST);
			jdbcConn.addParam("ID_NO", colMap.get("ID_NO").toString(), SqlTypes.JLONG);
			jdbcConn.execuse();
			log.debug("---usersyncstt-end-colMap="+colMap.toString());
		}
		return true;
	}
	
}
