<%
  /*
   * 功能: 保存复核结果
　 * 版本: 1.0.0
　 * 日期: 2008/12/26
　 * 作者: hanjc
　 * 版权: sitech
   * update:
　 */
%>
<%
	//String opCode = "K219";
	//String opName = "保存复核结果";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String evterno     = (String)session.getAttribute("kfWorkNo");
	String retType     = WtcUtil.repNull(request.getParameter("retType"));
	String[] scores    = request.getParameterValues("scores");
	String[] itemids   = request.getParameterValues("itemIds");
	String serialnum   = WtcUtil.repNull(request.getParameter("serialnum"));
	String objectid          = WtcUtil.repNull(request.getParameter("objectid"));
	String contentid         = WtcUtil.repNull(request.getParameter("contentid"));
	String checkflag="0";
	String plan_id           = WtcUtil.repNull(request.getParameter("plan_id"));	
	String completedCounts   = WtcUtil.repNull(request.getParameter("completedCounts"));
	
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	
	if("saveQcInfo".equals(retType)){
	  checkflag="1";
	}
	
	String[] sqlStrs   = new String[scores.length];
	StringBuffer sb = new StringBuffer();

	for(int i = 0; i < scores.length; i++){
		System.out.println(scores[i]);
		/**sb.append("insert into dqcinfodetail (serialnum,objectid,contentid,itemid,weight,orgvalue,score) ");
		sb.append("values('"+ serialnum +"', '"+ objectid +"','"+ contentid +"','"+ itemids[i] +"','0','0','"+ scores[i] +"')");
		*/
		sb.append("insert into dqcinfodetail (serialnum,objectid,contentid,itemid,weight,orgvalue,score) ");
		sb.append("values( :v1,  :v2, :v3, :v4,'0','0', :v5)");
		sb.append("&&"+ serialnum +"^"+ objectid +"^"+ contentid +"^"+ itemids[i] +"^"+ scores[i] +"");
		System.out.println(sb.toString());
		sqlStrs[i] = sb.toString();
		sb.delete(0, sb.length());
	}

	String contentinsum      = WtcUtil.repNull(request.getParameter("contentinsum"));
	String handleinfo        = WtcUtil.repNull(request.getParameter("handleinfo"));
	String improveadvice     = WtcUtil.repNull(request.getParameter("improveadvice"));
	String commentinfo       = WtcUtil.repNull(request.getParameter("commentinfo"));
	String error_level_id    = WtcUtil.repNull(request.getParameter("error_level_id"));
	String error_class_ids   = WtcUtil.repNull(request.getParameter("error_class_ids"));
	String service_class_ids = WtcUtil.repNull(request.getParameter("service_class_ids"));
	String totalScore        = WtcUtil.repNull(request.getParameter("totalScore"));
	String flag              = WtcUtil.repNull(request.getParameter("flag"));
  String isOutPlanflag     = WtcUtil.repNull(request.getParameter("isOutPlanflag"));
  String service_class_texts = WtcUtil.repNull(request.getParameter("service_class_texts"));
  String error_level_text = WtcUtil.repNull(request.getParameter("error_level_text"));
  String error_class_texts = WtcUtil.repNull(request.getParameter("error_class_texts"));
  String give_up_reason_ids = WtcUtil.repNull(request.getParameter("give_up_reason_ids"));
  //String give_up_reason_texts = WtcUtil.repNull(request.getParameter("give_up_reason_texts"));
  //zengzq 增加评定原因 091016
  String check_reason_ids   = WtcUtil.repNull(request.getParameter("check_reason_ids"));
  //zengzq 增加评定原因 091016
  String check_reason_texts = WtcUtil.repNull(request.getParameter("check_reason_texts"));
  String handleTime = WtcUtil.repNull(request.getParameter("handleTime"));
  String listenTime = WtcUtil.repNull(request.getParameter("listenTime"));     
  String adjustTime = WtcUtil.repNull(request.getParameter("adjustTime"));
  String totalTime  = WtcUtil.repNull(request.getParameter("totalTime"));  

/**old sql :String sqlUpdQcInfo = "update dqcinfo set endtime = sysdate, dealduration='"+handleTime+"',lisduration='"+listenTime+"',arrduration='"+adjustTime+"',evtduration='"+totalTime+"', " +
						  " contentinsum = '" + contentinsum +"', handleinfo = '" + handleinfo + "', " +
						  " improveadvice = '" + improveadvice + "', commentinfo = '" + commentinfo + "', checkflag='"+checkflag+"', " +
						  " errorlevelid = '" + error_level_id + "', errorclassid = '" + error_class_ids + "', qcserviceclassid='" + service_class_ids + "', "  +
						  " score = '" + totalScore + "', flag = '" + flag +"',serviceclassdesc='"+service_class_texts+"',"+                                                                 " CHECKREASONID='" + check_reason_ids + "', "  +
						  " CHECKREASONDESC='" + check_reason_texts + "', "  +
						  " abortreasonid = '" + give_up_reason_ids + "',errorleveldesc = '" + error_level_text + "', errorclassdesc = '" + error_class_texts + "'"+						  
						  " where serialnum = '" + serialnum + "'";
*/
String sqlUpdQcInfo = "update dqcinfo set endtime = sysdate, dealduration= :v1 ,lisduration= :v2 ,arrduration= :v3 ,evtduration= :v4 , " +
						  " contentinsum = :v5 , handleinfo = :v6 , " +
						  " improveadvice = :v7 , commentinfo = :v8 , checkflag= :v9 , " +
						  " errorlevelid = :v10 , errorclassid = :v11 , qcserviceclassid= :v12 , "  +
						  " score = :v13 , flag = :v14 ,serviceclassdesc= :v15 ,"+
						  " CHECKREASONID= :v16 , "  +
						  " CHECKREASONDESC= :v17 , "  +
						  " abortreasonid = :v18 ,errorleveldesc = :v19 , errorclassdesc = :v20 "+						  
						  " where serialnum = :v21 ";
  
  if(("saveQcInfo".equals(retType)&&!"".equals(completedCounts))||
  	 ("tempSaveQcInfo".equals(retType)&&!"".equals(completedCounts))||
  	 ("giveUpQcInfo".equals(retType)&&!"".equals(completedCounts))){
/**String sqlUpdDqcplan="update dqcloginplan set current_times='"+completedCounts+"'  where trim(plan_id)='"+plan_id.trim()+"' and trim(object_id)='"+objectid.trim()+"' and trim(content_id)='"+contentid.trim()+"' and trim(login_no)='"+staffno.trim()+"'";
*/

String sqlUpdDqcplan="update dqcloginplan set current_times= :v1   where trim(plan_id)= :v2  and trim(object_id)= :v3  and trim(content_id)= :v4  and trim(login_no)= :v5 ";

 %>
<wtc:service name="sPubModifyKfCfm" outnum="3" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sqlUpdDqcplan%>"/>
	<wtc:param value="dbchange"/>
	<wtc:param value="<%=completedCounts%>"/>
	<wtc:param value="<%=plan_id.trim()%>"/>
	<wtc:param value="<%=objectid.trim()%>"/>
	<wtc:param value="<%=contentid.trim()%>"/>
	<wtc:param value="<%=staffno.trim()%>"/>
    </wtc:service>
 <%
  }

%>
<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode%>">
    <wtc:param value=""/>
    <wtc:param value="dbchange"/>
    <wtc:params value="<%=sqlStrs%>"/>
</wtc:service>

<wtc:service name="sPubModifyKfCfm" outnum="3" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=sqlUpdQcInfo%>"/>
	<wtc:param value="dbchange"/>
	<wtc:param value="<%=handleTime%>"/>
	<wtc:param value="<%=listenTime%>"/>
	<wtc:param value="<%=adjustTime%>"/>
	<wtc:param value="<%=totalTime%>"/>
	<wtc:param value="<%=contentinsum%>"/>
	<wtc:param value="<%=handleinfo%>"/>
	<wtc:param value="<%=improveadvice%>"/>
	<wtc:param value="<%=commentinfo%>"/>
	<wtc:param value="<%=checkflag%>"/>
	<wtc:param value="<%=error_level_id%>"/>
	<wtc:param value="<%=error_class_ids%>"/>
	<wtc:param value="<%=service_class_ids%>"/>
	<wtc:param value="<%=totalScore%>"/>
	<wtc:param value="<%=flag%>"/>
	<wtc:param value="<%=service_class_texts%>"/>
	<wtc:param value="<%=check_reason_ids%>"/>
	<wtc:param value="<%=check_reason_texts%>"/>
	<wtc:param value="<%=give_up_reason_ids%>"/>
	<wtc:param value="<%=error_level_text%>"/>
	<wtc:param value="<%=error_class_texts%>"/>
	<wtc:param value="<%=serialnum%>"/>
</wtc:service>

<wtc:row id="row" start="0" length="3">
var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%="000000"%>");
response.data.add("retMsg","<%="success"%>");
response.data.add("object_id","<%="aaa"%>");
core.ajax.receivePacket(response);
</wtc:row>