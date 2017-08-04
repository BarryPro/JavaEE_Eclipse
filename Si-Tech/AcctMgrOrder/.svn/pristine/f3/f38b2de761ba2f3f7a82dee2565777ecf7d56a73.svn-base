package com.sitech.acctmgr.app.dataorder.splicesql;

import java.sql.Connection;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.app.common.InterBusiConst;
import com.sitech.acctmgr.common.utils.ValueUtils;
import com.sitech.acctmgr.common.BaseBusi;
import com.sitech.jcf.ijdbc.SqlChange;
import com.sitech.jcf.ijdbc.SqlFind;
import com.sitech.jcf.ijdbc.sql.SqlParameter;
import com.sitech.jcf.ijdbc.sql.SqlTypes;
import com.sitech.jcfx.util.DateUtil;

public class SpliceSql extends BaseBusi implements ISpliceSql {
	
	@Override
	public Map<String, Object> spliceInsertSql(Map<String, Object> inDataMap,
			List<Map<String, Object>> inLstDest) {

		SqlChange outSqlChg = null;
		SqlChange outSqlChgChg = null;
		String sSyncTabName = "";
		String sChgTabName = "";
		int trigger_flag = -1;
		String inOdrLineId = "";
		String inCreateTime = "";
		StringBuffer sBufColsStr = new StringBuffer();
		StringBuffer sBufColsVal = new StringBuffer();
		StringBuffer outSqlDataBuf = new StringBuffer();
		StringBuffer outChgSqlBuf = null;
		StringBuffer tmpBufStr = null;
		StringBuffer tmpBufVal = null;
		List<Map<String, Object>> listChgSqlMaps = new ArrayList<Map<String,Object>>();
		Map<String, Object> chgMap = null;
		//返回Map
		Map<String, Object> outSqlMap = new HashMap<String, Object>();
		
		String sTableName = inDataMap.get("TABLE_NAME").toString();
		//String sSuffix = inDataMap.get("SUFFIX").toString();
		String sOpType = inDataMap.get("OP").toString();
		Map<String, Object> mapCols = (Map<String, Object>) inDataMap.get("COLS");

		outSqlMap = buildDynaSqlBuffer(inLstDest, null, mapCols, sOpType);
		if (outSqlMap == null) {
			log.error("buildDynaSqlBuffer DELETE error ,please check!");
			return null;
		}
		
		sSyncTabName = outSqlMap.get("DEST_TABLE").toString();
		//if (!(sSuffix.equals("SUFFIX") || sSuffix.equals("")))
		//	sSyncTabName = sSyncTabName + "_" + sSuffix;
		sChgTabName = outSqlMap.get("CHG_TABLE").toString();
		trigger_flag = Integer.parseInt(inLstDest.get(0).get("TRIGGER_FLAG").toString());
		sBufColsStr = (StringBuffer) outSqlMap.get("COL_NAME");
		sBufColsVal = (StringBuffer) outSqlMap.get("COL_VALUE");
		outSqlChg = (SqlChange) outSqlMap.get("SQL_CHANGE");
		
		/*完整同步表SQL串*/
		outSqlDataBuf.append("INSERT INTO ").append(sSyncTabName).append(" (");
		outSqlDataBuf.append(sBufColsStr).append(") VALUES (").append(sBufColsVal).append(")");

		/*拼接完整 小表语句;判断是否触发小表 且存在小表*/
		if (trigger_flag == InterBusiConst.DATAODR_TRIGGER 
				&& sChgTabName.equals("NONE") != true && sChgTabName.equals("") != true) {
			
			if (inDataMap.get(InterBusiConst.DATAODR_ODRLINEID) != null )
				inOdrLineId = inDataMap.get(InterBusiConst.DATAODR_ODRLINEID).toString();
			if (inDataMap.get(InterBusiConst.DATAODR_CREATTIME) != null )
				inCreateTime = inDataMap.get(InterBusiConst.DATAODR_CREATTIME).toString();
			/*---------20150415 同步多张小表处理 STT---------*/
			/*
			 * 1. CHG_TABLE中配置多帐小表，小表之间"#"隔开。如UR_USER_INT1#UR_USER_INT2
			 * 2. 循环从in_cbtable_chgsync_rel取对应小表自有字段配置
			 * 3. 生成List<Map>型存储各个小表落地数据。Map中Key有：SQLBUF/SQLCHG/TABLE
			 * 4. 最后返回Map(outSqlMap)中，List<Map>以Key=CHGTABS存入outSqlMap
			 */
			String[] sChgTabs = sChgTabName.split("#");
			for (String tmpChgTab:sChgTabs) {
				log.debug("----for circle----小表子:"+tmpChgTab);
				//继承 同步表 的参数值
				outSqlChgChg = new SqlChange();
				for (Object obj : outSqlChg.getParamList())
					outSqlChgChg.addParam(obj);

				tmpBufStr = new StringBuffer();
				tmpBufVal = new StringBuffer();
				tmpBufStr.append(sBufColsStr);
				tmpBufVal.append(sBufColsVal);
				
				if (false == buildChgOthrSql(tmpBufVal, tmpBufStr, outSqlChgChg, sOpType, tmpChgTab,
						inOdrLineId, inCreateTime)) {
					log.error("build the INSERT chg_table other column error,please check!");
					return null;
				}
				/*完整拼接小表语句*/
				outChgSqlBuf = new StringBuffer();
				outChgSqlBuf.append("INSERT INTO ").append(tmpChgTab).append(" (");
				outChgSqlBuf.append(tmpBufStr).append(") VALUES (").append(tmpBufVal).append(")");


				//放入List
				chgMap = new HashMap<String, Object>();
				chgMap.put("SQLBUF", outChgSqlBuf);
				chgMap.put("SQLCHG", outSqlChgChg);
				chgMap.put("TABLE", tmpChgTab);
				listChgSqlMaps.add(chgMap);

			}//for END
			/*---------20150415 同步多张小表处理 END---------*/
			
		}
		
		/*返回参数放入Map*/
		outSqlMap = new HashMap<String, Object>();
		outSqlMap.put("SYN_SQLBUF", outSqlDataBuf);
		outSqlMap.put("SYN_SQLCHG", outSqlChg);
		outSqlMap.put("CHGTABS", listChgSqlMaps);

		return outSqlMap;
	}

	@Override
	public Map<String, Object> spliceDeleteSql(Map<String, Object> inDataMap,
			List<Map<String, Object>> inLstDest) {

		SqlChange outSqlChg = null;
		SqlChange outSqlChgChg = null;
		
		String sSyncTabName = "";
		String sChgTabName = "";
		int trigger_flag = -1;
		String inOdrLineId = "";
		String inCreateTime = "";
		
		StringBuffer sBufColsStr = new StringBuffer();
		StringBuffer sBufColsVal = new StringBuffer();
		StringBuffer outSqlDataBuf = new StringBuffer();
		
		StringBuffer outChgSqlBuf = null;
		StringBuffer tmpBufStr = null;
		StringBuffer tmpBufVal = null;
		
		//返回Map
		Map<String, Object> outSqlMap = new HashMap<String, Object>();
		Map<String, Object> chgMap = null;
		List<Map<String, Object>> listChgSqlMaps = new ArrayList<Map<String,Object>>();
		Map<String, Object> oper_info = new HashMap<String, Object>();

		String sTableName = inDataMap.get("TABLE_NAME").toString();
		//String sSuffix = inDataMap.get("SUFFIX").toString();
		String sOpType = inDataMap.get("OP").toString();
		Map<String, Object> mapCols = (Map<String, Object>) inDataMap.get("COLS");
		
		outSqlMap = buildDynaSqlBuffer(inLstDest, null, mapCols, sOpType);
		if (outSqlMap == null) {
			log.error("buildDynaSqlBuffer DELETE error ,please check!");
			return null;
		}
		sSyncTabName = outSqlMap.get("DEST_TABLE").toString();
		//if (!(sSuffix.equals("SUFFIX") || sSuffix.equals("")))
		//	sSyncTabName = sSyncTabName + "_" + sSuffix;
		sChgTabName = outSqlMap.get("CHG_TABLE").toString();
		trigger_flag = Integer.parseInt(inLstDest.get(0).get("TRIGGER_FLAG").toString());
		sBufColsStr = (StringBuffer) outSqlMap.get("COL_NAME");
		sBufColsVal = (StringBuffer) outSqlMap.get("COL_VALUE");
		outSqlChg = (SqlChange) outSqlMap.get("SQL_CHANGE");
		
		/*完整拼接SQL*/
		outSqlDataBuf.append("DELETE FROM ").append(sSyncTabName).append(" WHERE ");
		outSqlDataBuf.append(sBufColsVal);

		/*拼接完整 小表语句;判断是否触发小表 且存在小表*/
		if (trigger_flag == InterBusiConst.DATAODR_TRIGGER 
				&& sChgTabName.equals("NONE") != true && sChgTabName.equals("") != true) {
			
			/*小表特殊操作*/
			oper_info = (Map<String, Object>) outSqlMap.get("OPER_CHG_INFO");
						
			if (inDataMap.get(InterBusiConst.DATAODR_ODRLINEID) != null )
				inOdrLineId = inDataMap.get(InterBusiConst.DATAODR_ODRLINEID).toString();
			if (inDataMap.get(InterBusiConst.DATAODR_CREATTIME) != null )
				inCreateTime = inDataMap.get(InterBusiConst.DATAODR_CREATTIME).toString();
			/*---------20150415 同步多张小表处理 STT---------*/
			/*
			 * 1. CHG_TABLE中配置多帐小表，小表之间"#"隔开。如UR_USER_INT1#UR_USER_INT2
			 * 2. 循环从in_cbtable_chgsync_rel取对应小表自有字段配置
			 * 3. 生成List<Map>型存储各个小表落地数据。Map中Key有：SQLBUF/SQLCHG/TABLE
			 * 4. 最后返回Map(outSqlMap)中，List<Map>以Key=CHGTABS存入outSqlMap
			 */
			String[] sChgTabs = sChgTabName.split("#");
			for (String tmpChgTab:sChgTabs) {
				
				if (oper_info.get("CHG_DELE_FLAG").toString().equals("0")) {
					log.debug("--当前小表设置删除时，不处理--");
					break;
				}
				
				//继承 同步表 的参数值
				outSqlChgChg = new SqlChange();
				for (Object obj : outSqlChg.getParamList())
					outSqlChgChg.addParam(obj);
				
				tmpBufStr = new StringBuffer();
				tmpBufVal = new StringBuffer();
				tmpBufStr.append(sBufColsStr);
				tmpBufVal.append(sBufColsVal);
				
				if (false == buildChgOthrSql(tmpBufVal, tmpBufStr, outSqlChgChg, sOpType, tmpChgTab,
						inOdrLineId, inCreateTime)) {
					log.error("build the DELETE chg_table other column error,please check!");
					return null;
				}
				/*完整拼接小表语句*/
				outChgSqlBuf = new StringBuffer();
				if ("2".equals(oper_info.get("CHG_DELE_FLAG").toString())) {
					//删除不删除，做更新
					String chg_col_name = oper_info.get("CHG_DELE_COL").toString();
					String chg_col_type = oper_info.get("CHG_DELE_TYPE").toString();

					//取得失效时间=当前时间>生效时间？当前时间:生效时间
					//String chg_col_val = "2".equals(chg_col_type)?"sysdate":(DateUtil.format(new Date(),"yyyyMMddHHmmss").toString());
					String eff_date = "";
					if (inDataMap.get("EFF_DATE") != null)
						eff_date = inDataMap.get("EFF_DATE").toString();
					else if (inDataMap.get("BEGIN_TIME") != null)
						eff_date = inDataMap.get("BEGIN_TIME").toString();
					String cur_date = DateUtil.format(new Date(),"yyyyMMddHHmmss").toString();
					String chg_col_val = cur_date.compareTo(eff_date)>0 ? cur_date : eff_date;
					
					outChgSqlBuf.append("UPDATE ").append(tmpChgTab)
								.append(" SET ").append(chg_col_name).append(" = ").append(chg_col_val)
								.append(", ").append("OP_FLAG = ").append(3)   //目前仍置为删除操作
								.append(" WHERE ").append(tmpBufVal)
								.append(" AND ").append(oper_info.get("CHG_DELE_COL"))
								.append(" > ").append("sysdate");
					
				} else {
					outChgSqlBuf.append("DELETE FROM ").append(tmpChgTab).append(" WHERE ");
					outChgSqlBuf.append(tmpBufVal);
				}
				
				//放入List
				chgMap = new HashMap<String, Object>();
				chgMap.put("SQLBUF", outChgSqlBuf);
				chgMap.put("SQLCHG", outSqlChgChg);
				chgMap.put("TABLE", tmpChgTab);
				listChgSqlMaps.add(chgMap);
				
			}//for END
			/*---------20150415 同步多张小表处理 END---------*/
			
		}
		
		/*返回参数放入Map*/
		outSqlMap = new HashMap<String, Object>();
		outSqlMap.put("SYN_SQLBUF", outSqlDataBuf);
		outSqlMap.put("SYN_SQLCHG", outSqlChg);
		outSqlMap.put("CHGTABS", listChgSqlMaps);

		return outSqlMap;
	}

	@Override
	public Map<String, Object> spliceSpecialSql(Map<String, Object> inDataMap,
			List<Map<String, Object>> inLstDest) {
		
		SqlChange outSqlChg = null;
		SqlChange outSqlChgChg = null;
		String sSyncTabName = "";
		String sChgTabName = "";
		int trigger_flag = -1;
		String inOdrLineId = "";
		String inCreateTime = "";
		StringBuffer sBufColsStr = new StringBuffer();
		StringBuffer sBufColsVal = new StringBuffer();
		StringBuffer outSqlDataBuf = new StringBuffer();
		StringBuffer outChgSqlBuf = null;
		StringBuffer tmpBufStr = null;
		StringBuffer tmpBufVal = null;
		List<Map<String, Object>> listChgSqlMaps = new ArrayList<Map<String,Object>>();
		Map<String, Object> chgMap = null;
		List<String> lstPk = null;
		//返回Map
		Map<String, Object> outSqlMap = new HashMap<String, Object>();
		

		String sTableName = inDataMap.get("TABLE_NAME").toString();
		//String sSuffix = inDataMap.get("SUFFIX").toString();
		String sOpType = inDataMap.get("OP").toString();
		Map<String, Object> mapCols = (Map<String, Object>) inDataMap.get("COLS");
		
		if (null != inDataMap.get("PK"))
			lstPk = (List<String>) inDataMap.get("PK");
		
		outSqlMap = buildDynaSqlBuffer(inLstDest, lstPk, mapCols, sOpType);
		if (outSqlMap == null) {
			log.error("buildSqlBuffer SPECIAL error ,please check!");
			return null;
		}

		sSyncTabName = outSqlMap.get("DEST_TABLE").toString();
		//if (!(sSuffix.equals("SUFFIX") || sSuffix.equals("")))
		//	sSyncTabName = sSyncTabName + "_" + sSuffix;
		sChgTabName = outSqlMap.get("CHG_TABLE").toString();
		trigger_flag = Integer.parseInt(inLstDest.get(0).get("TRIGGER_FLAG").toString());
		sBufColsStr = (StringBuffer) outSqlMap.get("COL_NAME");
		sBufColsVal = (StringBuffer) outSqlMap.get("COL_VALUE");
		outSqlChg = (SqlChange) outSqlMap.get("SQL_CHANGE");
		
		/*完整拼接SQL*/
		outSqlDataBuf.append("UPDATE ").append(sSyncTabName).append(" SET ");
		outSqlDataBuf.append(sBufColsStr).append(" WHERE ").append(sBufColsVal);

		/*拼接完整 小表语句;判断是否触发小表 且存在小表*/
		if (trigger_flag == InterBusiConst.DATAODR_TRIGGER 
				&& sChgTabName.equals("NONE") != true && sChgTabName.equals("") != true) {
			
			if (inDataMap.get(InterBusiConst.DATAODR_ODRLINEID) != null )
				inOdrLineId = inDataMap.get(InterBusiConst.DATAODR_ODRLINEID).toString();
			if (inDataMap.get(InterBusiConst.DATAODR_CREATTIME) != null )
				inCreateTime = inDataMap.get(InterBusiConst.DATAODR_CREATTIME).toString();
			/*---------20150415 同步多张小表处理 STT---------*/
			/*
			 * 1. CHG_TABLE中配置多帐小表，小表之间"#"隔开。如UR_USER_INT1#UR_USER_INT2
			 * 2. 循环从in_cbtable_chgsync_rel取对应小表自有字段配置
			 * 3. 生成List<Map>型存储各个小表落地数据。Map中Key有：SQLBUF/SQLCHG/TABLE
			 * 4. 最后返回Map(outSqlMap)中，List<Map>以Key=CHGTABS存入outSqlMap
			 */
			String[] sChgTabs = sChgTabName.split("#");
			for (String tmpChgTab:sChgTabs) {
				//继承 同步表 的参数值
				outSqlChgChg = new SqlChange();
				for (Object obj : outSqlChg.getParamList())
					outSqlChgChg.addParam(obj);
				
				tmpBufStr = new StringBuffer();
				tmpBufVal = new StringBuffer();
				tmpBufStr.append(sBufColsStr);
				tmpBufVal.append(sBufColsVal);
				
				if (false == buildChgOthrSql(tmpBufVal, tmpBufStr, outSqlChgChg, sOpType, tmpChgTab,
						inOdrLineId, inCreateTime)) {
					log.error("build the UPDATE chg_table other column error,please check!");
					return null;
				}
				/*完整拼接小表语句*/
				outChgSqlBuf = new StringBuffer();
				outChgSqlBuf.append("UPDATE ").append(tmpChgTab).append(" SET ");
				outChgSqlBuf.append(tmpBufStr).append(" WHERE ").append(tmpBufVal);
				
				//放入List
				chgMap = new HashMap<String, Object>();
				chgMap.put("SQLBUF", outChgSqlBuf);
				chgMap.put("SQLCHG", outSqlChgChg);
				chgMap.put("TABLE", tmpChgTab);
				listChgSqlMaps.add(chgMap);
				
			}//for END
			/*---------20150415 同步多张小表处理 END---------*/
			
		}//if end
		
		/*返回参数放入Map*/
		outSqlMap = new HashMap<String, Object>();
		outSqlMap.put("SYN_SQLBUF", outSqlDataBuf);
		outSqlMap.put("SYN_SQLCHG", outSqlChg);
		outSqlMap.put("CHGTABS", listChgSqlMaps);
				
		return outSqlMap;
	}

	@Override
	public Map<String, Object> spliceUpdateSql(Map<String, Object> inDataMap,
			List<Map<String, Object>> inLstDest) {

		SqlChange outSqlChg = null;
		SqlChange outSqlChgChg = null;
		String sSyncTabName = "";
		String sChgTabName = "";
		int trigger_flag = -1;
		String inOdrLineId = "";
		String inCreateTime = "";
		StringBuffer sBufColsStr = new StringBuffer();
		StringBuffer sBufColsVal = new StringBuffer();
		StringBuffer outSqlDataBuf = new StringBuffer();
		StringBuffer outChgSqlBuf = null;
		StringBuffer tmpBufStr = null;
		StringBuffer tmpBufVal = null;
		List<Map<String, Object>> listChgSqlMaps = new ArrayList<Map<String,Object>>();
		Map<String, Object> chgMap = null;
		
		Map<String, Object> outSqlMap = new HashMap<String, Object>();

		String sTableName = inDataMap.get("TABLE_NAME").toString();
		//String sSuffix = inDataMap.get("SUFFIX").toString();
		String sOpType = inDataMap.get("OP").toString();
		Map<String, Object> mapCols = (Map<String, Object>) inDataMap.get("COLS");
		List<String> lstPk = (List<String>) inDataMap.get("PK");
		
		//sBufColsVal, sBufColsStr, sSyncTabName, sChgTabName, outSqlChg
		outSqlMap = buildDynaSqlBuffer(inLstDest, lstPk, mapCols, InterBusiConst.DATA_OPER_TYPE_UPDATE);
		if (outSqlMap == null) {
			log.error("buildDynaSqlBuffer UPDATE error ,please check!");
			return null;
		}
		sSyncTabName = outSqlMap.get("DEST_TABLE").toString();
		//if (!(sSuffix.equals("SUFFIX") || sSuffix.equals("")))
		//	sSyncTabName = sSyncTabName + "_" + sSuffix;
		sBufColsStr = (StringBuffer) outSqlMap.get("COL_NAME");
		sBufColsVal = (StringBuffer) outSqlMap.get("COL_VALUE");
		outSqlChg = (SqlChange) outSqlMap.get("SQL_CHANGE");

		/*完整拼接同步SQL*/
		outSqlDataBuf.append("UPDATE ").append(sSyncTabName).append(" SET ");
		outSqlDataBuf.append(sBufColsStr).append(" WHERE ").append(sBufColsVal);

		/*拼接完整 小表语句*/
		sChgTabName = outSqlMap.get("CHG_TABLE").toString();
		trigger_flag = Integer.parseInt(inLstDest.get(0).get("TRIGGER_FLAG").toString());
		/*拼接完整 小表语句;判断是否触发小表 且存在小表*/
		if (trigger_flag == InterBusiConst.DATAODR_TRIGGER 
				&& sChgTabName.equals("NONE") != true && sChgTabName.equals("") != true) {
			
			if (inDataMap.get(InterBusiConst.DATAODR_ODRLINEID) != null )
				inOdrLineId = inDataMap.get(InterBusiConst.DATAODR_ODRLINEID).toString();
			if (inDataMap.get(InterBusiConst.DATAODR_CREATTIME) != null )
				inCreateTime = inDataMap.get(InterBusiConst.DATAODR_CREATTIME).toString();
			/*---------20150415 同步多张小表处理 STT---------*/
			/*
			 * 1. CHG_TABLE中配置多帐小表，小表之间"#"隔开。如UR_USER_INT1#UR_USER_INT2
			 * 2. 循环从in_cbtable_chgsync_rel取对应小表自有字段配置
			 * 3. 生成List<Map>型存储各个小表落地数据。Map中Key有：SQLBUF/SQLCHG/TABLE
			 * 4. 最后返回Map(outSqlMap)中，List<Map>以Key=CHGTABS存入outSqlMap
			 */
			String[] sChgTabs = sChgTabName.split("#");
			for (String tmpChgTab:sChgTabs) {
				//继承 同步表 的参数值
				outSqlChgChg = new SqlChange();
				for (Object obj : outSqlChg.getParamList())
					outSqlChgChg.addParam(obj);
				
				tmpBufStr = new StringBuffer();
				tmpBufVal = new StringBuffer();
				tmpBufStr.append(sBufColsStr);
				tmpBufVal.append(sBufColsVal);
				
				if (false == buildChgOthrSql(tmpBufVal, tmpBufStr, outSqlChgChg, sOpType, tmpChgTab,
						inOdrLineId, inCreateTime)) {
					log.error("build the SPECIAL(UPDATE BY INDEX) chg_table other column error,please check!");
					return null;
				}
				/*完整拼接小表语句*/
				outChgSqlBuf = new StringBuffer();
				outChgSqlBuf.append("UPDATE ").append(tmpChgTab).append(" SET ");
				outChgSqlBuf.append(tmpBufStr).append(" WHERE ").append(tmpBufVal);
				
				//放入List
				chgMap = new HashMap<String, Object>();
				chgMap.put("SQLBUF", outChgSqlBuf);
				chgMap.put("SQLCHG", outSqlChgChg);
				chgMap.put("TABLE", tmpChgTab);
				listChgSqlMaps.add(chgMap);
				
			}//for END
			/*---------20150415 同步多张小表处理 END---------*/
			
		}//if end

		/*返回参数放入Map*/
		outSqlMap = new HashMap<String, Object>();
		outSqlMap.put("SYN_SQLBUF", outSqlDataBuf);
		outSqlMap.put("SYN_SQLCHG", outSqlChg);
		outSqlMap.put("CHGTABS", listChgSqlMaps);
				
		return outSqlMap;
	}

	/**
	 * @title 源表U/D/S操作，拼接小表的插入语句
	 * @param inDataMap
	 * @param inLstDest
	 * @return
	 */
	public Map<String, Object> spliceInstSqlToChg(Map<String, Object> inDataMap,
			List<Map<String, Object>> inLstDest, Connection conn) {

		SqlChange outSqlChg = null;
		SqlChange outSqlChgChg = null;
		
		String sSyncTabName = "";
		String sChgTabName = "";
		int trigger_flag = -1;
		String inOdrLineId = "";
		String inCreateTime = "";
		
		StringBuffer sBufColsStr = new StringBuffer();
		StringBuffer sBufColsVal = new StringBuffer();
		StringBuffer outSqlDataBuf = new StringBuffer();
		
		StringBuffer outChgSqlBuf = null;
		StringBuffer tmpBufStr = null;
		StringBuffer tmpBufVal = null;
		
		List<Map<String, Object>> listChgSqlMaps = new ArrayList<Map<String,Object>>();
		Map<String, Object> oper_info = new HashMap<String, Object>();
		Map<String, Object> chgMap = null;
		List<String> lstPk = null;

		//返回Map
		Map<String, Object> outSqlMap = new HashMap<String, Object>();
		
		String sTableName = inDataMap.get("TABLE_NAME").toString();
		//String sSuffix = inDataMap.get("SUFFIX").toString();
		String sOpType = inDataMap.get("OP").toString();
		Map<String, Object> mapCols = (Map<String, Object>) inDataMap.get("COLS");
		if (null != inDataMap.get("PK"))
			lstPk = (List<String>) inDataMap.get("PK");
		
		//取得相关信息
		outSqlMap = buildDynaSqlBuffer(inLstDest, lstPk, mapCols, sOpType);
		if (outSqlMap == null) {
			log.error("buildDynaSqlBuffer Chg insert to U/D error ,please check!");
			return null;
		}
		sSyncTabName = outSqlMap.get("DEST_TABLE").toString();

		sChgTabName = outSqlMap.get("CHG_TABLE").toString();
		trigger_flag = Integer.parseInt(inLstDest.get(0).get("TRIGGER_FLAG").toString());
		sBufColsStr = (StringBuffer) outSqlMap.get("COL_NAME");
		sBufColsVal = (StringBuffer) outSqlMap.get("COL_VALUE");
		outSqlChg = (SqlChange) outSqlMap.get("SQL_CHANGE");
		
		/*完整拼接物理库大表SQL*/
		if (InterBusiConst.DATA_OPER_TYPE_DELETE.equals(sOpType)) {
			
			outSqlDataBuf.append("DELETE FROM ").append(sSyncTabName)
						.append(" WHERE ").append(sBufColsVal);
			
		} else if (InterBusiConst.DATA_OPER_TYPE_SPECIAL.equals(sOpType)
				 || InterBusiConst.DATA_OPER_TYPE_UPDATE.equals(sOpType)) {
			outSqlDataBuf.append("UPDATE ").append(sSyncTabName).append(" SET ")
						.append(sBufColsStr).append(" WHERE ").append(sBufColsVal);
		} else if (InterBusiConst.DATA_OPER_TYPE_INSERT.equals(sOpType)) {
			outSqlDataBuf.append("INSERT INTO ").append(sSyncTabName).append(" (").append(sBufColsStr)
						.append(") VALUES (").append(sBufColsVal).append(")");
		}
		
		/*-------------------开始拼接小表------------------*/
		/*拼接完整 小表语句;判断是否触发小表 且存在小表*/
		if (trigger_flag == InterBusiConst.DATAODR_TRIGGER
				&& sChgTabName.equals("NONE") != true && sChgTabName.equals("") != true) {
			/*小表特殊操作*/
			oper_info = (Map<String, Object>) outSqlMap.get("OPER_CHG_INFO");

			//字段值1：mapCols
			//字段值2：mapAllColVals
			StringBuffer columns = (StringBuffer) outSqlMap.get("OPER_CHG_COLS");
			Map<String, Object> cols_map = (Map<String, Object>) outSqlMap.get("OPER_CHG_COLMAP");
			StringBuffer and_conds = (StringBuffer) outSqlMap.get("OPER_CHG_ANDS");
			
			//改为JDBC直连数据库取数据
			Map<String, Object> mapAllColVals = new HashMap<String, Object>();
			mapAllColVals.putAll(mapCols);
			if ("".equals(columns.toString())) {
				mapAllColVals.putAll(cols_map);
				log.debug("---columns.size=["+columns.length()+"]-mapAllColVals="+mapAllColVals);
			} else {
				/*Map<String, Object> in_selct_map = new HashMap<String, Object>();
				in_selct_map.put("COLUMNS", columns);
				in_selct_map.put("TABLE_NAME", sSyncTabName);
				in_selct_map.put("AND_CONDITION", and_conds);
				log.debug("--in_selct_map--=="+in_selct_map.toString());
				Map<String, Object> mapAllColVals = (Map<String, Object>) baseDao.queryForObject("BK_pubic.qAllInfo", in_selct_map);*/
				
				//20151027 修改
				SqlFind sqlFind = (SqlFind) outSqlMap.get("OPER_CHG_SQLFIND");//new SqlFind();
				sqlFind.setListElementAsMap(true);

				String sql_select_chg = "select "+columns+" from "+sSyncTabName+" where "+and_conds;
				List<Map<String, Object>> sslist = sqlFind.findList(conn, sql_select_chg);
				Map<String, Object> tmp_map = sslist.get(0);
				log.debug("--in_selct_map-sslist.size="+sslist.size()+"-tmp_map="+mapAllColVals);
				mapAllColVals.putAll(tmp_map);
				log.debug("--in_selct_map-2-mapAllColVals="+mapAllColVals);
			}
			
			//拼接小表和大表共有的基本字段部分
			Map<String, Object> outChgInsert = buildDynaChgInsertSql(inLstDest, null, mapAllColVals
					, InterBusiConst.DATA_OPER_TYPE_INSERT, oper_info);
			
			
			if (inDataMap.get(InterBusiConst.DATAODR_ODRLINEID) != null )
				inOdrLineId = inDataMap.get(InterBusiConst.DATAODR_ODRLINEID).toString();
			if (inDataMap.get(InterBusiConst.DATAODR_CREATTIME) != null )
				inCreateTime = inDataMap.get(InterBusiConst.DATAODR_CREATTIME).toString();
			/*---------20150415 同步多张小表处理 STT---------*/
			/*
			 * 1. CHG_TABLE中配置多帐小表，小表之间"#"隔开。如UR_USER_INT1#UR_USER_INT2
			 * 2. 循环从in_cbtable_chgsync_rel取对应小表自有字段配置
			 * 3. 生成List<Map>型存储各个小表落地数据。Map中Key有：SQLBUF/SQLCHG/TABLE
			 * 4. 最后返回Map(outSqlMap)中，List<Map>以Key=CHGTABS存入outSqlMap
			 */
			
			SqlChange outSqlBasePart = new SqlChange();
			outSqlBasePart = (SqlChange) outChgInsert.get("SQL_CHANGE");
			
			String[] sChgTabs = sChgTabName.split("#");
			for (String tmpChgTab:sChgTabs) {
				
				/*if (oper_info.get("CHG_DELE_FLAG") != null 
						&& oper_info.get("CHG_DELE_FLAG").toString().equals("2")) {
					log.info("--当前小表设置删除不删除只更新时，不处理--");
					break;
				}*/
				
				//继承 同步表 的参数值
				outSqlChgChg = new SqlChange();
				for (Object obj : outSqlBasePart.getParamList())
					outSqlChgChg.addParam(obj);
				
				tmpBufStr = new StringBuffer();
				tmpBufVal = new StringBuffer();
				tmpBufStr.append(outChgInsert.get("COL_NAME"));
				tmpBufVal.append(outChgInsert.get("COL_VALUE"));
				
				if (false == buildChgOthrSql(tmpBufVal, tmpBufStr, outSqlChgChg, 
						sOpType, tmpChgTab,
						inOdrLineId, inCreateTime)) {
					log.error("build the DELETE chg_table other column error,please check!");
					return null;
				}
				/*完整拼接小表语句*/
				outChgSqlBuf = new StringBuffer();
				outChgSqlBuf.append("INSERT INTO ").append(tmpChgTab).append(" (").append(tmpBufStr)
							.append(") VALUES (").append(tmpBufVal).append(")");
				
				//放入List
				chgMap = new HashMap<String, Object>();
				chgMap.put("SQLBUF", outChgSqlBuf);
				chgMap.put("SQLCHG", outSqlChgChg);
				chgMap.put("TABLE", tmpChgTab);
				listChgSqlMaps.add(chgMap);
				
			}//for END
			/*---------20150415 同步多张小表处理 END---------*/
			
		}
		
		/*返回参数放入Map*/
		outSqlMap = new HashMap<String, Object>();
		outSqlMap.put("SYN_SQLBUF", outSqlDataBuf);
		outSqlMap.put("SYN_SQLCHG", outSqlChg);
		outSqlMap.put("CHGTABS", listChgSqlMaps);

		return outSqlMap;
	}
	
	/**
	 * Title: 私有接口：拼接动态SQL语句</p>
	 * Description:使用jdbc拼接动态SQL,根据OP_TYPE操作不同，拼接INSERT\UPDATE\DELETE等SQL语句</p>
	 * @param outBufColVal
	 * @param outBufColStr
	 * @param inListMapTabCol
	 * @param inListPk
	 * @param inMapCols
	 * @param inOpType
	 * @return true or false
	 */
	private Map<String, Object> buildDynaSqlBuffer(List<Map<String, Object>> inListMapTabCol, List<String> inListPk,
			Map<String, Object> inMapCols, String inOpType) {
		log.debug("------buildsqlbuffer--stt--"+inMapCols.toString());
		String sStrTmp = "";
		String sDotSplit = "";
		String sAndSplit = "";
		String sColsName = "";
		String sSrcsName = "";
		String sColsValue = "";
		String sIndexFlag = "";
		
		int iFstFlag = 0;
		int iPkFlag = 0;
		int iPkCount = 0;
		int iDataType = 0;
		
		//OPER_FLAG操作
		String sOperFlag = "";
		Map<String, Object> oper_map = new HashMap<String, Object>();

		Map<String, Object> tmpMap = null;
		Map<String, Object> inPkMap = new HashMap<String, Object>();
		List<Map<String, Object>> lstUpdate = new ArrayList<Map<String, Object>>();

		/*output param */
		Map<String, Object> outParaMap = new HashMap<String, Object>(); 
		SqlChange outSqlChg = new SqlChange();
		StringBuffer outBufColVal = new StringBuffer();
		StringBuffer outBufColStr = new StringBuffer();
		String soutDestTable = "";
		String soutChgTable = "";
		
		/*小表同步时，取源数据的字段序列，如A,B,C*/
		boolean bFstCol = true;  //初始为真
		StringBuffer outSelctColumns = new StringBuffer();
		StringBuffer outSelctAndCond = new StringBuffer();
		Map<String, Object> outDiffColMap = new HashMap<String, Object>(); 
		
		//20151027 修改
		//String tmp_selct_cond = "";
		SqlFind outchg_sqlFind = new SqlFind();
		SqlParameter sql_para = null;
				
		
		/*循环取出配置表中，boss库对应的数据表字段的配置信息*/
		for (Map<String, Object> mColumnDest : inListMapTabCol) {
			iPkFlag = 0;
			//log.debug("---mColumnDest--cfg--="+mColumnDest.toString());
			
			if (soutDestTable.equals("")) {
				soutDestTable = mColumnDest.get("DEST_TABLE").toString();
				soutChgTable = mColumnDest.get("CHG_TABLE").toString();
			}
			sColsName = mColumnDest.get("DEST_COLUMN").toString();
			sSrcsName = mColumnDest.get("SOURCE_COLUMN").toString();
			
			/*根据SqlTypes数据类型，调用switchDataType 赋值sColsValue*/
			iDataType = Integer.valueOf(mColumnDest.get("DATA_TYPE").toString());
			
			/******************************小表处理开始 STT******************************/
			/*20150602 小表特殊处理配置收集 OPER_FLAG*/
			sOperFlag = mColumnDest.get("OPER_FLAG").toString();
			if (!sOperFlag.equals("111") && !soutChgTable.equals("NONE")) {
				if (sOperFlag.charAt(0) != '1') {
					oper_map.put("CHG_INST_FLAG", sOperFlag.charAt(0));
					oper_map.put("CHG_INST_COL", sColsName);
					oper_map.put("CHG_INST_TYPE", iDataType);
				}
				if (sOperFlag.charAt(1) != '1') {
					oper_map.put("CHG_UPDT_FLAG", sOperFlag.charAt(1));
					oper_map.put("CHG_UPDT_COL", sColsName);
					oper_map.put("CHG_UPDT_TYPE", iDataType);
				}
				if (sOperFlag.charAt(2) != '1') {
					oper_map.put("CHG_DELE_FLAG", sOperFlag.charAt(2));
					oper_map.put("CHG_DELE_COL", sColsName);
					oper_map.put("CHG_DELE_TYPE", iDataType);
				}
			}
			
			//小表取数据源表的序列.
			if (inMapCols.get(sColsName) == null) {
				//列名不同的字段返回map
				if (inMapCols.get(sSrcsName) != null) {
					outDiffColMap.put(sColsName, inMapCols.get(sSrcsName));
				} else {
					if (bFstCol == false)
						outSelctColumns.append(",");
					bFstCol = false;
					
					//工单中未提供的字段
					if (InterBusiConst.DATA_TYPE_DATE == iDataType) {
						outSelctColumns.append("TO_CHAR(").append(sColsName).append(",'YYYYMMDDHH24MISS')")
							.append(" ").append(sColsName);//别名
					} else {
						outSelctColumns.append(sColsName);
					}

				}
			}
			/******************************小表处理结束 END******************************/
			
			//crm库字段名,大表boss自有字段
			if (sSrcsName.equals("NONE") || sSrcsName.equals(""))
				sSrcsName = sColsName;
			
			/*无对应字段值，过滤该字段。注意：现在还在在配置for循环中呢*/
            if (null == inMapCols.get(sSrcsName)) {
                    if ('2' == sOperFlag.charAt(2)) {
                            sStrTmp = inMapCols.get("EXP_DATE").toString();
                    } else {
                            continue;
                    }
            } else {
                    //字段值
                    sStrTmp = inMapCols.get(sSrcsName).toString();
            }
            log.debug("--SRCcolumn="+sSrcsName+"--scolval="+sStrTmp);
			
			/*拼接部分分隔符*/
			if (0 == iFstFlag) {
				sDotSplit = "";
				sAndSplit = "";
			} else if (1 == iFstFlag) {
				sDotSplit = ",";
				sAndSplit = " AND ";
			}
			/*赋值一次，>2时相同*/
			iFstFlag++;
			
			/*插入、更新、删除、特殊操作分类拼入串*/
			if (inOpType.equals(InterBusiConst.DATA_OPER_TYPE_INSERT)) {
				/*根据数据类型插入字段值*/
				tmpMap = switchDataType(iDataType, sColsName, sStrTmp, outSqlChg);
				sColsValue = tmpMap.get("COL_VALUE").toString();
				if (null == sColsValue) {
					log.error("根据数据类型插入字段值 INSERT deal the datatype failed,please check!");
					return null;
				}
				/*INSERT INTO TABLE TABLE_NAME (outBufColStr=拼接部分1)*/
				outBufColStr.append(sDotSplit).append(sColsName);
				/*VALUES (outBufColVal=拼接部分2);*/
				outBufColVal.append(sDotSplit).append(sColsValue);
				
			} else if (inOpType.equals(InterBusiConst.DATA_OPER_TYPE_DELETE)) {
				/*根据数据类型插入字段值*/
				tmpMap = switchDataType(iDataType, sColsName, sStrTmp, outSqlChg);
				sColsValue = tmpMap.get("COL_VALUE").toString();
				sql_para = (SqlParameter) tmpMap.get("CHG_COND");
				if (null == sql_para) {
					log.error("根据数据类型插入字段值DELETE deal the datatype failed,please check!");
					return null;
				}
				/*DELETE FROM TABLE_NAME WHERE outBufColVal=拼接部分;*/
				outBufColVal.append(sAndSplit).append(sColsName).append("=").append(sColsValue);
				//小表条件 20151027 修改
				outchg_sqlFind.addParam(sql_para);
				outSelctAndCond.append(sAndSplit).append(sColsName).append("=").append(sColsValue);

			} else if (inOpType.equals(InterBusiConst.DATA_OPER_TYPE_SPECIAL)) {
				
				iPkFlag = 0;
				if (null != inListPk) {
					for (String sPk : inListPk) {
						if (sColsName.equalsIgnoreCase(sPk)) {
							iPkFlag = 1; 
							iPkCount++; //default value = 0
							break;
						}
					}
				} else {
					sIndexFlag = mColumnDest.get("INDEX_FLAG").toString();
					if (sIndexFlag.equalsIgnoreCase("Y")) {
							iPkFlag = 1; 
							iPkCount++; //default value = 0
					}
				}
				
				if (1 == iPkFlag) {
					/*根据数据类型插入字段值*/
					//记录主键入List
					//log.info("--pk--column="+sColsName+"--scolval="+sStrTmp);
					inPkMap = new HashMap<String, Object>();
					inPkMap.put("COL_NAME", sColsName);
					inPkMap.put("COL_VAL", sStrTmp);
					inPkMap.put("COL_TYPE", iDataType);
					lstUpdate.add(inPkMap);
					
					sColsValue = switchDataTypeUpdatePk(iDataType, inOpType, sColsName, sStrTmp);
					if (null == sColsValue) {
						log.error("根据数据类型插入字段值 UPDATE deal the datatype failed,please check!");
						return null;
					}
					
					/*条件、主键部分*/ /*WHERE outBufColVal=拼接部分2*/
					if (1 == iPkCount) /*第一个主键，分隔符为空*/
						outBufColVal.append("").append(sColsName).append("=").append(sColsValue);
					else
						outBufColVal.append(sAndSplit).append(sColsName).append("=").append(sColsValue);
				} else {
					/*根据数据类型插入字段值*/
					tmpMap = switchDataType(iDataType, sColsName, sStrTmp, outSqlChg);
					sColsValue = tmpMap.get("COL_VALUE").toString();
					//此处非条件，不接受 out_sql_para = tmpMap.get("CHG_COND");
					if (null == sColsValue) {
						log.error("根据数据类型插入字段值 UPDATE not PK, deal the datatype failed,please check!");
						return null;
					}

					/*赋值部分*/ /*UPDATE SET TABLE_NAME SET outBufColStr=拼接部分1 WHERE ...*/
					if (1 == iFstFlag - iPkCount) /*第一个赋值字段，分隔符为空*/
						outBufColStr.append("").append(sColsName).append("=").append(sColsValue);
					else
						outBufColStr.append(sDotSplit).append(sColsName).append("=").append(sColsValue);
				}
				
			} else if (inOpType.equals(InterBusiConst.DATA_OPER_TYPE_UPDATE)) {
				
				iPkFlag = 0;
				for (String sPk : inListPk) {
					if (sColsName.equalsIgnoreCase(sPk)) {
						iPkFlag = 1; 
						iPkCount++; //default value = 0
						break;
					}
				}
				if (1 == iPkFlag) {
					/*根据数据类型插入字段值*/
					//记录主键入List
					inPkMap = new HashMap<String, Object>();
					inPkMap.put("COL_NAME", sColsName);
					inPkMap.put("COL_VAL", sStrTmp);
					inPkMap.put("COL_TYPE", iDataType);
					//lstUpdate.add(iPkCount-1, inPkMap);

					lstUpdate.add(inPkMap);
					
					sColsValue = switchDataTypeUpdatePk(iDataType, inOpType, sColsName, sStrTmp);
					if (null == sColsValue) {
						log.error("根据数据类型插入字段值 UPDATE deal the datatype failed,please check!");
						return null;
					}
					
					/*条件、主键部分*/ /*WHERE outBufColVal=拼接部分2*/
					if (1 == iPkCount) { /*第一个主键，分隔符为空*/
						outBufColVal.append("").append(sColsName).append("=").append(sColsValue);
					} else {
						outBufColVal.append(sAndSplit).append(sColsName).append("=").append(sColsValue);
					}
				} else {
					/*根据数据类型插入字段值*/
					tmpMap = switchDataType(iDataType, sColsName, sStrTmp, outSqlChg);
					sColsValue = tmpMap.get("COL_VALUE").toString();
					//此处非条件，不接受sql_para=tmpMap.get("CHG_COND");
					if (null == sColsValue) {
						log.error("根据数据类型插入字段值 UPDATE not PK, deal the datatype failed,please check!");
						return null;
					}

					/*赋值部分*/ /*UPDATE SET TABLE_NAME SET outBufColStr=拼接部分1 WHERE ...*/
					if (1 == iFstFlag - iPkCount){ /*第一个赋值字段，分隔符为空*/
						outBufColStr.append("").append(sColsName).append("=").append(sColsValue);
					} else {
						outBufColStr.append(sDotSplit).append(sColsName).append("=").append(sColsValue);
					}
				}
				
			} else {
				log.error("OP_TYPE="+inOpType+" is error ,please check!");
				return null;
			}
			
		}/*for inListMapTabCol END*/

		//更新操作时的条件，设置入参；小表取源数据入参
		boolean first_flag = true;
		String outAndCond = null;
		if (inOpType.equals(InterBusiConst.DATA_OPER_TYPE_SPECIAL)
				|| inOpType.equals(InterBusiConst.DATA_OPER_TYPE_UPDATE)) {
			for (Map<String, Object> mapColData : lstUpdate) {
				log.debug("--mapColData=="+mapColData.toString());
				// --mapColData=={COL_TYPE=2, COL_VAL=20150715223204, COL_NAME=BEGIN_TIME}
				outAndCond = new String();
				if (dealListPkInputSqlChange(mapColData, outSqlChg, outAndCond) == false) {
					log.error("dealListPkInputSqlChange error,please check!");
					return null;
				}
				if (true == first_flag) {
					first_flag = false;
					outSelctAndCond.append(" ");
				} else {
					outSelctAndCond.append(" AND ");
				}
				
				//20151027 修改
				String op_type = mapColData.get("COL_TYPE").toString();
				String col_name = mapColData.get("COL_NAME").toString();
				String col_value = mapColData.get("COL_VAL").toString();
				if ("0".equals(op_type)) {
					outSelctAndCond.append(col_name).append("= ? ");
					outchg_sqlFind.addParam(new SqlParameter(col_name, SqlTypes.JSTRING, col_value));
				} else if ("1".equals(op_type)) {
					outSelctAndCond.append(col_name).append("= ? ");
					outchg_sqlFind.addParam(new SqlParameter(col_name, SqlTypes.JLONG, Long.valueOf(col_value)));
				} else if ("2".equals(op_type)) {
					outSelctAndCond.append(col_name).append("=to_date(? ,'YYYYMMDDHH24MISS')");//yyyyMMddHHmmss
					outchg_sqlFind.addParam(new SqlParameter(col_name, SqlTypes.JSTRING, col_value));
				} else {
					outSelctAndCond.append(col_name).append("= ? ");
					outchg_sqlFind.addParam(new SqlParameter(col_name, SqlTypes.JSTRING, col_value));
				}
				
			}
		}
		log.debug("--outSelctAndCond--"+outSelctAndCond.toString());
		
		/*出参入MAP*/
		outParaMap.put("SQL_CHANGE", outSqlChg);
		outParaMap.put("DEST_TABLE", soutDestTable);
		outParaMap.put("CHG_TABLE", soutChgTable);
		outParaMap.put("COL_VALUE", outBufColVal);
		outParaMap.put("COL_NAME", outBufColStr);
		//20150602 小表特殊操作
		outParaMap.put("OPER_CHG_INFO", oper_map);
		outParaMap.put("OPER_CHG_COLS", outSelctColumns);
		outParaMap.put("OPER_CHG_COLMAP", outDiffColMap);
		outParaMap.put("OPER_CHG_ANDS", outSelctAndCond);
		outParaMap.put("OPER_CHG_SQLFIND", outchg_sqlFind);
			
		return outParaMap;
	}
	
	private Map<String, Object> buildDynaChgInsertSql(List<Map<String, Object>> inListMapTabCol, List<String> inListPk,
			Map<String, Object> inMapCols, String inOpType, Map<String, Object> operMap) {

		String sStrTmp = "";
		String sDotSplit = "";
		String sAndSplit = "";
		String sColsName = "";
		String sSrcsName = "";
		String sColsValue = "";
		String sIndexFlag = "";
		
		int iFstFlag = 0;
		int iPkFlag = 0;
		int iPkCount = 0;
		int iDataType = 0;
		
		Map<String, Object> tmpMap = null;

		/*output param */
		Map<String, Object> outParaMap = new HashMap<String, Object>(); 
		SqlChange outSqlChg = new SqlChange();
		StringBuffer outBufColVal = new StringBuffer();
		StringBuffer outBufColStr = new StringBuffer();
		String soutDestTable = "";
		
		//20151027 修改
		SqlParameter out_inst_para = null;
		
		//小表特殊字段exp_time置为当前时间
		String chg_col_name = "";
		String chg_col_type = "";
		String chg_col_val = "";
		
		/*循环取出配置表中，boss库对应的数据表字段的配置信息*/
		for (Map<String, Object> mColumnDest : inListMapTabCol) {
			iPkFlag = 0;
			
			sColsName = mColumnDest.get("DEST_COLUMN").toString();
			/*根据SqlTypes数据类型，调用switchDataType 赋值sColsValue*/
			iDataType = Integer.valueOf(mColumnDest.get("DATA_TYPE").toString());
			
			/*拼接部分分隔符*/
			if (0 == iFstFlag) {
				sDotSplit = "";
				sAndSplit = "";
			} else if (1 == iFstFlag) {
				sDotSplit = ",";
				sAndSplit = " AND ";
			}
			/*赋值一次，>2时相同*/
			iFstFlag++;
			
			//crm库字段名
			sSrcsName = mColumnDest.get("SOURCE_COLUMN").toString();
			if (sSrcsName.equals("NONE") || sSrcsName.equals(""))
				sSrcsName = sColsName;
			/*无对应字段值，置空*/
			if (null == inMapCols.get(sSrcsName))
				sStrTmp = "";
			else
				sStrTmp = inMapCols.get(sSrcsName).toString();
			log.debug("--SRCcolumn="+sSrcsName+"--scolval="+sStrTmp);
			
			/*插入、更新、删除、特殊操作分类拼入串*/
			if (inOpType.equals(InterBusiConst.DATA_OPER_TYPE_INSERT)) {
				/*根据数据类型插入字段值*/
				tmpMap = switchDataType(iDataType, sColsName, sStrTmp, outSqlChg);//COL_VALUE
				sColsValue = tmpMap.get("COL_VALUE").toString();
				if (null == sColsValue) {
					log.error("根据数据类型插入字段值 INSERT deal the datatype failed,please check!");
					return null;
				}
				/*INSERT INTO TABLE TABLE_NAME (outBufColStr=拼接部分1)*/
				outBufColStr.append(sDotSplit).append(sColsName);
				/*VALUES (outBufColVal=拼接部分2);*/
				outBufColVal.append(sDotSplit).append(sColsValue);
				
			} else {
				log.error("This is Chg table splice function just INSERT, OP_TYPE="+inOpType+" is error ,please check!");
				return null;
			}
			
		}/*for inListMapTabCol END*/

		/*出参入MAP*/
		outParaMap.put("SQL_CHANGE", outSqlChg);
		outParaMap.put("COL_VALUE", outBufColVal);
		outParaMap.put("COL_NAME", outBufColStr);
		
		return outParaMap;
	}
	
	/**
	 * Title 处理update时的主键值入SqlChange参数
	 * @param inPkColName
	 * @param inMapColVal
	 * @param outSqlChange
	 * @return
	 */
	private boolean dealListPkInputSqlChange(Map<String, Object> inMapColData
			, SqlChange outSqlChange, String outAndCond) {

		String sColName = "";
		String sColValue = "";
		int iDataType = 0;
		sColName = inMapColData.get("COL_NAME").toString();
		sColValue = inMapColData.get("COL_VAL").toString();
		iDataType = (Integer) inMapColData.get("COL_TYPE");
		//log.info("----------name="+sColName+"----value="+sColValue+"----type="+iDataType);
		switch (iDataType) {
		/*时间格式*/
		case InterBusiConst.DATA_TYPE_STRING:
			outSqlChange.addParam(new SqlParameter(sColName, SqlTypes.VARCHAR, sColValue));
			outAndCond = "'"+sColValue+"'";
			break;
		case InterBusiConst.DATA_TYPE_LONG:
			if (null == sColValue || sColValue.equals("")) sColValue = "0";
			outSqlChange.addParam(new SqlParameter(sColName, SqlTypes.JLONG, ValueUtils.longValue(sColValue)));
			outAndCond = sColValue;
			break;
		case InterBusiConst.DATA_TYPE_DATE:
			//20150415 确认不加1s
			outSqlChange.addParam(new SqlParameter(sColName, SqlTypes.VARCHAR, sColValue));//addSecBySplit(sStrTmp, +1)
			//小表取数据条件
			outAndCond = "TO_DATE('"+sColValue+"', 'yyyyMMddHH24miss')";
			break;
		case InterBusiConst.DATA_TYPE_INTEGER:
			if (null == sColValue) sColValue = "0";
			outSqlChange.addParam(new SqlParameter(sColName, SqlTypes.INTEGER, Integer.valueOf(sColValue)));
			//小表取数据条件
			outAndCond = sColValue;
			break;
		case InterBusiConst.DATA_TYPE_DOUBLE:
			if (null == sColValue) sColValue = "0";
			outSqlChange.addParam(new SqlParameter(sColName, SqlTypes.JDOUBLE, Double.valueOf(sColValue)));
			//小表取数据条件
			outAndCond = sColValue;
			break;
		case InterBusiConst.DATA_TYPE_TIMESTAMP:
			outSqlChange.addParam(new SqlParameter(sColName, SqlTypes.TIMESTAMP, sColValue));//addSecBySplit(sStrTmp, +1)
			//小表取数据条件
			outAndCond = "TO_DATE('"+sColValue+"', 'yyyyMMddHH24miss')";
			break;
		case InterBusiConst.DATA_TYPE_TIME:
			outSqlChange.addParam(new SqlParameter(sColName, SqlTypes.TIME, sColValue));//addSecBySplit(sStrTmp, +1)
			//小表取数据条件
			outAndCond = "TO_DATE('"+sColValue+"', 'yyyyMMddHH24miss')";
			break;
		default:
			log.error("dealListPkInputSqlChange error DataType,please check!");
			return false;
		}
		
		return true;
	}
	
	/**
	 * Title 私有接口：增加若干秒方法
	 * Description 可以修改增加日、月
	 * @param inDateStr
	 * @param inNum
	 * @return inDateStr + inNum
	 */
	private String addSecBySplit(String inDateStr, int inNum) {
		if (null == inDateStr)
			return "";
		SimpleDateFormat simDateFmt = new SimpleDateFormat("yyyyMMddHH24miss");
		Calendar cal = Calendar.getInstance();
		cal.setTime(simDateFmt.parse(inDateStr, new ParsePosition(0)));
		cal.add(Calendar.SECOND, inNum);
		return simDateFmt.format(cal.getTime());
	}
	
	/**
	 * Title 正表：根据数据类型插入字段值
	 * Description 注意入参outSqlChg本身里面可能有其他字段值了，此处插入当前字段值后外围继续插入
	 * @param iInDataType
	 * @param inOpType
	 * @param sColsName
	 * @param sStrTmp
	 * @param sColsValue
	 * @return COL_VALUE/CHG_COND
	 */
	private Map<String, Object> switchDataType(int iInDataType, String sColsName, String sStrTmp,
			SqlChange outSqlChg) {
		
		Map<String, Object> outMap = new HashMap<String, Object>();
		String soutColsValue = "";
		
		//20151027 修改
		//String outChgCond = "";
		SqlParameter out_chg_para = null;
		
		switch (iInDataType) {
			/*时间格式*/
		case InterBusiConst.DATA_TYPE_STRING:
			soutColsValue = "?";
			outSqlChg.addParam(new SqlParameter(sColsName, SqlTypes.VARCHAR, sStrTmp));
			//小表取数据条件
			out_chg_para = new SqlParameter(sColsName, SqlTypes.VARCHAR, sStrTmp);//outChgCond = "'"+sStrTmp+"'";
			break;
		case InterBusiConst.DATA_TYPE_LONG:
			soutColsValue = "?";
			if (null == sStrTmp || sStrTmp.equals("")) sStrTmp = "0";
			outSqlChg.addParam(new SqlParameter(sColsName, SqlTypes.JLONG, ValueUtils.longValue(sStrTmp)));
			//小表取数据条件
			out_chg_para = new SqlParameter(sColsName, SqlTypes.JLONG, ValueUtils.longValue(sStrTmp));//outChgCond = sStrTmp;
			break;
		case InterBusiConst.DATA_TYPE_DATE:
			if (sStrTmp.equalsIgnoreCase("sysdate")) {
				soutColsValue = sStrTmp;
				//小表取数据条件
				//outChgCond = sStrTmp;
			} else {
				//确认下，是否需要加1秒？？？？已经加了1秒
				//soutColsValue = "?";
				soutColsValue = "TO_DATE(?, 'yyyyMMddHH24miss')";
				outSqlChg.addParam(new SqlParameter(sColsName, SqlTypes.VARCHAR, sStrTmp));//addSecBySplit(sStrTmp, +1)
				//小表取数据条件
				out_chg_para = new SqlParameter(sColsName, SqlTypes.VARCHAR, sStrTmp);//outChgCond = "TO_DATE('"+sStrTmp+"', 'yyyyMMddHH24miss')";
			}
			break;
		case InterBusiConst.DATA_TYPE_INTEGER:
			soutColsValue = "?";
			if (null == sStrTmp) sStrTmp = "0";
			outSqlChg.addParam(new SqlParameter(sColsName, SqlTypes.INTEGER, Integer.valueOf(sStrTmp)));
			//小表取数据条件
			out_chg_para = new SqlParameter(sColsName, SqlTypes.INTEGER, Integer.valueOf(sStrTmp));//outChgCond = sStrTmp;
			break;
		case InterBusiConst.DATA_TYPE_DOUBLE:
			soutColsValue = "?";
			if (null == sStrTmp) sStrTmp = "0";
			outSqlChg.addParam(new SqlParameter(sColsName, SqlTypes.JDOUBLE, Double.valueOf(sStrTmp)));
			//小表取数据条件
			out_chg_para = new SqlParameter(sColsName, SqlTypes.JDOUBLE, Double.valueOf(sStrTmp));//outChgCond = sStrTmp;
			break;
		case InterBusiConst.DATA_TYPE_TIMESTAMP:
			if (sStrTmp.equalsIgnoreCase("sysdate")) {
				soutColsValue = sStrTmp;
				//小表取数据条件
				//outChgCond = sStrTmp;
			} else {
				//确认下，是否需要加1秒？？？？已经加了1秒
				//soutColsValue = "?";
				soutColsValue = "TO_DATE(?, 'yyyyMMddHH24miss')";
				outSqlChg.addParam(new SqlParameter(sColsName, SqlTypes.TIMESTAMP, sStrTmp));//addSecBySplit(sStrTmp, +1)
				//小表取数据条件
				out_chg_para = new SqlParameter(sColsName, SqlTypes.TIMESTAMP, sStrTmp);//outChgCond = "TO_DATE('"+sStrTmp+"', 'yyyyMMddHH24miss')";
			}
			break;
		case InterBusiConst.DATA_TYPE_TIME:
			if (sStrTmp.equalsIgnoreCase("sysdate")) {
				soutColsValue = sStrTmp;
				//小表取数据条件
				//outChgCond = sStrTmp;
			} else {
				//确认下，是否需要加1秒？？已经加了1秒
				//soutColsValue = "?";
				soutColsValue = "TO_DATE(?, 'yyyyMMddHH24miss')";
				outSqlChg.addParam(new SqlParameter(sColsName, SqlTypes.TIME, sStrTmp));//addSecBySplit(sStrTmp, +1)
				//小表取数据条件
				out_chg_para = new SqlParameter(sColsName, SqlTypes.TIME, sStrTmp);//outChgCond = "TO_DATE('"+sStrTmp+"', 'yyyyMMddHH24miss')";
			}
			break;
		default:
			log.error("builddynasqlbuffer error DataType,please check!");
			return null;
		}
		
		outMap.put("COL_VALUE", soutColsValue);
		outMap.put("CHG_COND", out_chg_para);
		
		return outMap;
	}
	
	/**
	 * Title 小表：INSERT时根据数据类型插入字段值
	 * Description 注意入参outSqlChg本身里面可能有其他字段值了，此处插入当前字段值后外围继续插入
	 * @param iInDataType
	 * @param inOpType
	 * @param sColsName
	 * @param sStrTmp
	 * @param sColsValue
	 * @return soutColsValue
	 */
	private String switchCHGDataType(int iInDataType, String sColsName, String sStrTmp,
			SqlChange outSqlChg) {
		
		String soutColsValue = "";
		//log.debug("----CHGDATATYPE----sColsname="+sColsName+"----value="+sStrTmp);
		switch (iInDataType) {
			/*时间格式*/
		case InterBusiConst.DATA_TYPE_STRING:
			soutColsValue = "?";
			outSqlChg.addParam(new SqlParameter(sColsName, SqlTypes.VARCHAR, sStrTmp));
			break;
		case InterBusiConst.DATA_TYPE_LONG:
			soutColsValue = "?";
			if (null == sStrTmp || sStrTmp.equals("")) sStrTmp = "0";
			outSqlChg.addParam(new SqlParameter(sColsName, SqlTypes.JLONG, ValueUtils.longValue(sStrTmp)));
			break;
		case InterBusiConst.DATA_TYPE_DATE:
			if (sStrTmp.equalsIgnoreCase("sysdate"))
				soutColsValue = sStrTmp;
			else {
				//确认下，是否需要加1秒？？？？已经加了1秒
				//soutColsValue = "?";
				soutColsValue = "TO_DATE(?, 'yyyyMMddHH24miss')";
				outSqlChg.addParam(new SqlParameter(sColsName, SqlTypes.VARCHAR, sStrTmp));//addSecBySplit(sStrTmp, +1)
			}
			break;
		case InterBusiConst.DATA_TYPE_INTEGER:
			soutColsValue = "?";
			if (null == sStrTmp) sStrTmp = "0";
			outSqlChg.addParam(new SqlParameter(sColsName, SqlTypes.INTEGER, Integer.valueOf(sStrTmp)));
			break;
		case InterBusiConst.DATA_TYPE_DOUBLE:
			soutColsValue = "?";
			if (null == sStrTmp) sStrTmp = "0";
			outSqlChg.addParam(new SqlParameter(sColsName, SqlTypes.JDOUBLE, Double.valueOf(sStrTmp)));
			break;
		case InterBusiConst.DATA_TYPE_TIMESTAMP:
			if (sStrTmp.equalsIgnoreCase("sysdate"))
				soutColsValue = sStrTmp;
			else {
				//确认下，是否需要加1秒？？？？已经加了1秒
				//soutColsValue = "?";
				soutColsValue = "TO_DATE(?, 'yyyyMMddHH24miss')";
				outSqlChg.addParam(new SqlParameter(sColsName, SqlTypes.TIMESTAMP, sStrTmp));//addSecBySplit(sStrTmp, +1)
			}
			break;
		case InterBusiConst.DATA_TYPE_TIME:
			if (sStrTmp.equalsIgnoreCase("sysdate"))
				soutColsValue = sStrTmp;
			else {
				//确认下，是否需要加1秒？？已经加了1秒
				//soutColsValue = "?";
				soutColsValue = "TO_DATE(?, 'yyyyMMddHH24miss')";
				outSqlChg.addParam(new SqlParameter(sColsName, SqlTypes.TIME, sStrTmp));//addSecBySplit(sStrTmp, +1)
			}
			break;
		default:
			log.error("builddynasqlbuffer error DataType,please check!");
			return null;
		}
		
		return soutColsValue;
	}
	
	/**
	 * Title UPDATE时，若是主键，根据数据类型，将字段名称放入List
	 * Description 注意入参outSqlChg本身里面可能有其他字段值了，此处插入当前字段值后外围继续插入
	 * @param iInDataType
	 * @param inOpType
	 * @param sColsName
	 * @param sStrTmp
	 * @param sColsValue
	 * @return soutColsValue
	 */
	private String switchDataTypeUpdatePk(int iInDataType, String inOpType, String sColsName, String sStrTmp) {

		String soutColsValue = "";
		switch (iInDataType) {
			/*时间格式*/
		case InterBusiConst.DATA_TYPE_STRING:
			soutColsValue = "?";
			break;
		case InterBusiConst.DATA_TYPE_LONG:
			soutColsValue = "?";
			if (null == sStrTmp || sStrTmp.equals("")) sStrTmp = "0";
			break;
		case InterBusiConst.DATA_TYPE_DATE:
			if (sStrTmp.equalsIgnoreCase("sysdate"))
				soutColsValue = sStrTmp;
			else {
				//确认下，是否需要加1秒？？？？已经加了1秒
				//soutColsValue = "?";
				soutColsValue = "TO_DATE(?, 'yyyyMMddHH24miss')";

			}
			break;
		case InterBusiConst.DATA_TYPE_INTEGER:
			soutColsValue = "?";
			if (null == sStrTmp) sStrTmp = "0";
			break;
		case InterBusiConst.DATA_TYPE_DOUBLE:
			soutColsValue = "?";
			if (null == sStrTmp) sStrTmp = "0";
			break;
		case InterBusiConst.DATA_TYPE_TIMESTAMP:
			if (sStrTmp.equalsIgnoreCase("sysdate"))
				soutColsValue = sStrTmp;
			else {
				//确认下，是否需要加1秒？？？？已经加了1秒
				//soutColsValue = "?";
				soutColsValue = "TO_DATE(?, 'yyyyMMddHH24miss')";
			}
			break;
		case InterBusiConst.DATA_TYPE_TIME:
			if (sStrTmp.equalsIgnoreCase("sysdate"))
				soutColsValue = sStrTmp;
			else {
				//确认下，是否需要加1秒？？？？已经加了1秒
				//soutColsValue = "?";
				soutColsValue = "TO_DATE(?, 'yyyyMMddHH24miss')";
			}
			break;
		default:
			log.error("builddynasqlbuffer error DataType,please check!");
			return null;
		}
		
		return soutColsValue;
	}
	
	/**
	 * Title 私有接口：处理小表同步时，其他多余字段拼接
	 * @param outValBuf
	 * @param outNameBuf
	 * @param outSqlChg
	 * @param inListPk
	 * @param inOpType
	 * @param inChgName
	 * @param inCreateTime 
	 * @param inOdrLineId 
	 * @return
	 */
	private boolean buildChgOthrSql(StringBuffer outValBuf, StringBuffer outNameBuf, SqlChange outSqlChg,
			  String inOpType, String inChgName, String inOdrLineId, String inCreateTime) {
		
		String sStrTmp = ""; /*小表特殊字段取值*/
		String sDotSplit = "";
		String sAndSplit = "";
		String sColsName = "";
		String sColsValue = "";
		String sDefauValue = "";
		int iFstFlag = 0;
		int iPkFlag = 0;
		int iDataType = 0;
		int iTrigFlag = 0;
		Map<String, Object> inMap = new HashMap<String, Object>();
		inMap.put("CHG_TABLE", inChgName);
		//log.debug("----buildChgOthrSql----小表子:"+inChgName);
		
		List<Map<String, String>> lstChg = new ArrayList<Map<String,String>>();
		lstChg = baseDao.queryForList("in_cbtable_chgsync_rel.qChgOthrDataByChgTab", inMap);
		
		if (lstChg == null || lstChg.size() == 0)
			return true;
		/*小表自有字段*/
		for (Map<String, String> mapChgCol : lstChg) {
			/*拼接部分分隔符,小表部分直接追加*/
			sDotSplit = ",";
			sAndSplit = " AND ";
			
			sColsName = mapChgCol.get("CHG_COLUMN").toString();
			log.debug("boss小表自有字段名sColsName="+sColsName);

			/*小表自有字段取值*/
			if (null != mapChgCol.get("DEFAULT_VALUE"))
				sDefauValue = mapChgCol.get("DEFAULT_VALUE").toString();
			if (sDefauValue.equalsIgnoreCase("")) {
				/**** update by zhangleij 20170223 数据工单小表同步新增时间字段 begin ****/
				if (sColsName.equalsIgnoreCase("GET_TYPE"))
					sStrTmp = switchChgOptype(inOpType);
				else if (sColsName.equalsIgnoreCase("GET_NO")) {
					inMap = new HashMap<String, Object>();
					Map<String, Object> inTmp = new HashMap<String, Object>();
					inMap.put("SEQ_NAME", "SEQ_INT_DEAL_FLAG");
					inTmp = (Map<String, Object>) baseDao.queryForObject("BK_dual.qSequenceInter", inMap);
					sStrTmp = inTmp.get("NEXTVAL").toString()+DateUtil.format(new Date(), "MMdd").toString();
				}
				/*else if (sColsName.equalsIgnoreCase("ORDER_ID"))
					sStrTmp = inOdrLineId;
				else if (sColsName.equalsIgnoreCase("INSERT_TIME"))
					sStrTmp = DateUtil.format(new Date(), "MMdd").toString();
				*/
				else if (sColsName.equalsIgnoreCase("GET_TIME"))
					sStrTmp = inCreateTime;
				/**** update by zhangleij 20170223 数据工单小表同步新增时间字段 end ****/
			} else {
				sStrTmp = sDefauValue;
			}
			log.debug("boss小表子自有字段值sStrTmp="+sStrTmp);
			
			/*根据SqlTypes数据类型，赋值sColsValue*/
			iDataType = Integer.valueOf(mapChgCol.get("DATA_TYPE").toString());
			sColsValue = switchCHGDataType(iDataType, sColsName, sStrTmp, outSqlChg);

			/*小表插入拼入串*/
			/*INSERT INTO TABLE TABLE_NAME (outBufColStr=拼接部分1)*/
			outNameBuf.append(sDotSplit).append(sColsName);
			/*VALUES (outBufColVal=拼接部分2);*/
			outValBuf.append(sDotSplit).append(sColsValue);
		}

		return true;
	}
	
	/**
	 * Title 转换为内存库小表中的操作类型
	 * @param inOpType
	 * @return
	 */
	private String switchChgOptype(String inOpType) {
		
		String outChgOp = "";
		if (inOpType.equals(InterBusiConst.DATA_OPER_TYPE_INSERT))
			outChgOp = InterBusiConst.CHG_OPER_TYPE_INSERT;
		else if (inOpType.equals(InterBusiConst.DATA_OPER_TYPE_UPDATE))
			outChgOp = InterBusiConst.CHG_OPER_TYPE_UPDATE;
		else if (inOpType.equals(InterBusiConst.DATA_OPER_TYPE_DELETE))
			outChgOp = InterBusiConst.CHG_OPER_TYPE_DELETE;
		else if (inOpType.equals(InterBusiConst.DATA_OPER_TYPE_SPECIAL))
			outChgOp = InterBusiConst.CHG_OPER_TYPE_SPECIAL;
		
		return outChgOp;
	}

	
}
