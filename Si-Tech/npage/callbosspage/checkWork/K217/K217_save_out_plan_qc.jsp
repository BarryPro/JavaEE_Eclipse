<%
  /*
   * 功能: 保存质检结果
　 * 版本: 1.0.0
　 * 日期: 2008/11/14
　 * 作者: mixh
　 * 版权: sitech
   * update:
　 */
%>
<%
	//String opCode = "K217";
	//String opName = "保存质检结果";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String evterno             = (String)session.getAttribute("kfWorkNo");
	String workNo             = (String)session.getAttribute("workNo");
  String staffno             = WtcUtil.repNull(request.getParameter("staffno"));//被检工号
	String retType             = WtcUtil.repNull(request.getParameter("retType"));
	String[] scores            = request.getParameterValues("scores");
	String[] itemids           = request.getParameterValues("itemIds");
	String serialnum           = WtcUtil.repNull(request.getParameter("serialnum"));
  String contact_id          = WtcUtil.repNull(request.getParameter("contact_id"));//通话流水
	String objectid            = WtcUtil.repNull(request.getParameter("objectid"));
	String contentid           = WtcUtil.repNull(request.getParameter("contentid"));
	String plan_id             = WtcUtil.repNull(request.getParameter("plan_id"));
	String completedCounts     = WtcUtil.repNull(request.getParameter("completedCounts"));
	String contentinsum        = WtcUtil.repNull(request.getParameter("contentinsum"));
	String handleinfo          = WtcUtil.repNull(request.getParameter("handleinfo"));
	String improveadvice       = WtcUtil.repNull(request.getParameter("improveadvice"));
	String commentinfo         = WtcUtil.repNull(request.getParameter("commentinfo"));
	String error_level_id      = WtcUtil.repNull(request.getParameter("error_level_id"));
	String error_class_ids     = WtcUtil.repNull(request.getParameter("error_class_ids"));
	String service_class_ids   = WtcUtil.repNull(request.getParameter("service_class_ids"));
	//zengzq 增加评定原因 091016
	String check_reason_ids   = WtcUtil.repNull(request.getParameter("check_reason_ids"));
	String totalScore          = WtcUtil.repNull(request.getParameter("totalScore"));
	String flag                = WtcUtil.repNull(request.getParameter("flag"));
	String isOutPlanflag       = WtcUtil.repNull(request.getParameter("isOutPlanflag"));
	String service_class_texts = WtcUtil.repNull(request.getParameter("service_class_texts"));
	//zengzq 增加评定原因 091016
	String check_reason_texts = WtcUtil.repNull(request.getParameter("check_reason_texts"));
	String error_level_text    = WtcUtil.repNull(request.getParameter("error_level_text"));
	String error_class_texts   = WtcUtil.repNull(request.getParameter("error_class_texts"));
	String give_up_reason_ids  = WtcUtil.repNull(request.getParameter("give_up_reason_ids"));
	String give_up_reason_texts = WtcUtil.repNull(request.getParameter("give_up_reason_texts"));
	String handleTime = WtcUtil.repNull(request.getParameter("handleTime"));
	String listenTime = WtcUtil.repNull(request.getParameter("listenTime"));
	String adjustTime = WtcUtil.repNull(request.getParameter("adjustTime"));
	String totalTime  = WtcUtil.repNull(request.getParameter("totalTime"));
	String remarkFlag  = WtcUtil.repNull(request.getParameter("idremarkFlag"));	//案例添加
	
	//added by tangsong 20100528 客户级别、来电号码、被加分的考评项名称、被扣分的考评项名称
	String usertype = WtcUtil.repNull(request.getParameter("usertype"));
	String callerphone = WtcUtil.repNull(request.getParameter("callerphone"));
	//客户满意度
	String satisfyName = WtcUtil.repNull(request.getParameter("satisfyName"));
	String addedScoreItem = WtcUtil.repNull(request.getParameter("addedScoreItem"));
	String lostScoreItem = WtcUtil.repNull(request.getParameter("lostScoreItem"));
	//add by hucw 20100530 典型案例
	String remark_class_texts  = WtcUtil.repNull(request.getParameter("remark_class_texts"));
	String remark_class_ids  = WtcUtil.repNull(request.getParameter("remark_class_ids"));
	String remark_class_names  = WtcUtil.repNull(request.getParameter("remark_class_names"));
	int scoresLength = 0;
	if(null != scores && !("".equals(scores))){	
			scoresLength = scores.length;
	}
	String[] sqlStrs = new String[]{};
	List sqlList = new ArrayList();
	//String[] sqlStrs   = new String[scoresLength + 1];
	
	//自动考评
	String haveNum  = WtcUtil.repNull(request.getParameter("haveNum"));
	int hNum = 0;
	if(haveNum!=null && !("".equals(haveNum))){
			hNum = Integer.parseInt(haveNum);
	}
	String out_returnVal  = WtcUtil.repNull(request.getParameter("out_returnVal"));
	if(out_returnVal!=null && !("".equals(out_returnVal))){
			String[] tmpVal   = out_returnVal.split("_");
			String[] tmpVal1 = null;
			String sqlUpdTmpStatus = null;
			String nowMM = contact_id.substring(0, 6);
			String TName = "dcallcall" + nowMM;	
			for(int i=0; i<tmpVal.length;i++){
					tmpVal1 =  tmpVal[i].split("-");
					/**old sql :sqlUpdTmpStatus="update " + TName + " set QC_FLAG = '" + tmpVal1[2] + "' where contact_id='" + tmpVal1[0] + "'";
					*/
					String orgCode = (String)session.getAttribute("orgCode");
					String regionCode = orgCode.substring(0,2);
					sqlUpdTmpStatus="update " + TName + " set QC_FLAG =  :v1  where contact_id= :v2 ";
			%>
			<wtc:service name="sPubModifyKfCfm" outnum="3" routerKey="region" routerValue="<%=regionCode%>">
				<wtc:param value="<%=sqlUpdTmpStatus%>"/>
				<wtc:param value="dbchange"/>
				<wtc:param value="<%=tmpVal1[2]%>"/>
				<wtc:param value="<%=tmpVal1[0]%>"/>
			</wtc:service>
			<%
			}
			
	}
	
	//如果是计划外质检，plan_id为null
	plan_id = (null == plan_id) ? "":plan_id.trim();

	System.out.println("texts="+remark_class_texts+";ids="+remark_class_ids);
	String sqlUpdQcInfo = "update dqcinfo set endtime = sysdate, dealduration=:v1,lisduration=:v2,arrduration=:v3,evtduration=:v4, " +
						  " contentinsum = :v5, handleinfo = :v6, " +
						  " improveadvice = :v7, commentinfo = :v8, " +
						  " errorlevelid = :v9, errorclassid = :v10, qcserviceclassid=:v11, "  +
						  " CHECKREASONID=:v12, "  +
						  " CHECKREASONDESC=:v13, "  +
						  " score = :v14, flag = :v15,serviceclassdesc=:v16,"+
						  " abortreasonid = :v17,abortreasondesc = :v18,errorleveldesc = :v19, errorclassdesc = :v20,ISREMARKFLAG = :v21" +
						  //updated by tangsong 20100528 客户级别、来电号码、典型案例分类、典型案例描述、被加分的考评项名称、被扣分的考评项名称
						  ",usertype=:v22,callerphone=:v23,addedScoreItem=:v24,lostScoreItem=:v25,remarkClassId=:v26,remarkClassName=:v27,remarkDesc=:v28,satisfyName=:29" +
						  " where serialnum = :v30&&"+handleTime+"^"+listenTime+"^"+adjustTime+"^"+totalTime+"^"+contentinsum+"^"+handleinfo+"^"
						  +improveadvice+"^"+commentinfo+"^"+error_level_id+"^"+error_class_ids+"^"+service_class_ids+"^"+check_reason_ids+"^"+check_reason_texts+"^"+totalScore+"^"+flag+"^"+service_class_texts+"^"
						  +give_up_reason_ids+"^"+give_up_reason_texts+"^"+error_level_text+"^"+error_class_texts+"^"+remarkFlag+"^"+usertype+"^"+callerphone+"^"+addedScoreItem+"^"+lostScoreItem+"^"
						  +remark_class_ids+"^"+remark_class_names+"^"+remark_class_texts+"^"+satisfyName+"^"+serialnum ;
	

	StringBuffer sb = new StringBuffer();
	for(int i = 0; i < scoresLength; i++){
			String tmpSql = "update dqcinfodetail set weight= 0,orgvalue= 0,score= :v1 where serialnum= :v2 and objectid= :v3 and contentid= :v4 and itemid= :v5&&"+scores[i]+"^"+serialnum+"^"+objectid+"^"+contentid+"^"+itemids[i];
			sqlList.add(tmpSql);
	}
	sqlList.add(sqlUpdQcInfo);
	//sqlStrs[scoresLength] = sqlUpdQcInfo;
	//如果放弃该质检计划
	if("4".equals(flag.trim())){
	  	totalScore = "0";
	  	handleTime = "0";
	  	listenTime = "0";
	  	adjustTime = "0";
	  	totalTime  = "0";
	}
	
	//质检完毕，更新来电信息表
	if("saveQcInfo".equals(retType)&&!"".equals(contact_id)){
		String nowYYYYMM = contact_id.substring(0, 6);
		String tableName = "dcallcall" + nowYYYYMM;
		String sqlUpdDcallcall="UPDATE " + tableName + " SET qc_login_no=:v1, qc_flag = 'Y' " +
		                       "WHERE contact_id='"+contact_id+"'&&"+workNo;
		//sqlStrs[scoresLength + 1] = sqlUpdDcallcall;
		sqlList.add(sqlUpdDcallcall);
  	}
  	
	//更新质检计划次数
	if(("saveQcInfo".equals(retType)&&!"".equals(completedCounts))||
	("tempSaveQcInfo".equals(retType)&&!"".equals(completedCounts))||
	("giveUpQcInfo".equals(retType)&&!"".equals(completedCounts))){
		String sqlUpdDqcplan="update dqcloginplan set current_times = :v1  where trim(plan_id) = :v2 and trim(object_id) = :v3 and trim(content_id) = :v4 and trim(login_no) = :v5&&"+completedCounts+"^"+plan_id+"^"+objectid.trim()+"^"+contentid.trim()+"^"+staffno.trim();
		//sqlStrs[scoresLength + 2] = sqlUpdDqcplan;
		sqlList.add(sqlUpdDqcplan);
	}
	//jiangbing 20091118 批量服务替换
String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2); 
String sqlMulKfCfm="";
sqlStrs = (String[])sqlList.toArray(new String[0]);
	%>
<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
<wtc:param value="<%=sqlMulKfCfm%>"/>
<wtc:param value="dbchange"/>
<wtc:params value="<%=sqlStrs%>"/>
</wtc:service>
	
		var response = new AJAXPacket();
		response.data.add("retType","<%=retType%>");
		response.data.add("retCode","<%="000000"%>");
		response.data.add("retMsg","<%="success"%>");
		response.data.add("object_id","<%="aaa"%>");
		core.ajax.receivePacket(response);