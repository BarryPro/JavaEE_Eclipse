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
	//String opCode = "K214";
	//String opName = "保存质检结果";
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  String evterno     = (String)session.getAttribute("kfWorkNo");
  String staffno     = (String)request.getParameter("staffno");//被检工号
	String retType     = WtcUtil.repNull(request.getParameter("retType"));
	String[] scores    = request.getParameterValues("scores");
	String[] itemids   = request.getParameterValues("itemIds");
	String serialnum   = WtcUtil.repNull(request.getParameter("serialnum"));
  String contact_id   = WtcUtil.repNull(request.getParameter("contact_id"));//通话流水
	String objectid          = WtcUtil.repNull(request.getParameter("objectid"));
	String contentid         = WtcUtil.repNull(request.getParameter("contentid"));
	String plan_id           = WtcUtil.repNull(request.getParameter("plan_id"));	
	String completedCounts    = WtcUtil.repNull(request.getParameter("completedCounts"));
	int scoresLength = 0;
	if(null != scores && !("".equals(scores))){	
			scoresLength = scores.length;
	}
	//String[] sqlStrs   = new String[scoresLength + 3];
	String[] sqlStrs   = new String[scoresLength];
	
	StringBuffer sb = new StringBuffer();
	
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
  String give_up_reason_texts = WtcUtil.repNull(request.getParameter("give_up_reason_texts"));  
  String handleTime = WtcUtil.repNull(request.getParameter("handleTime"));
  String listenTime = WtcUtil.repNull(request.getParameter("listenTime"));     
  String adjustTime = WtcUtil.repNull(request.getParameter("adjustTime"));
  String totalTime  = WtcUtil.repNull(request.getParameter("totalTime"));
  //zengzq 增加评定原因 091016
  String check_reason_ids   = WtcUtil.repNull(request.getParameter("check_reason_ids"));
  String check_reason_texts = WtcUtil.repNull(request.getParameter("check_reason_texts"));
  String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
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
	
	
		/*
		for(int i = 0; i < scoresLength; i++){
			System.out.println(scores[i]);
			sb.append("insert into dqcinfodetail (serialnum,objectid,contentid,itemid,weight,orgvalue,score) ");
			sb.append("values('" + serialnum + "', '" + objectid + "','" + contentid + "','"+ itemids[i] +"','0','0','"+ scores[i] +"')");
			System.out.println(sb.toString());
			sqlStrs[i] = sb.toString();
			sb.delete(0, sb.length());
		}
		*/
		//zengzq modify
	if(!("4".equals(flag.trim()))){
		for(int i = 0; i < scoresLength; i++){
			sb.append("update dqcinfodetail set weight='0',orgvalue='0',score=:v1 "+
			"where  serialnum =:v2 and  objectid =:v3 and  contentid =:v4 and itemid =:v5&&"+scores[i]+"^"+serialnum.trim()+"^"+objectid.trim()+"^"+contentid.trim()+"^"+itemids[i].trim());
			sqlStrs[i] = sb.toString();
			sb.delete(0, sb.length());
		}
	}
  if("4".equals(flag.trim())){
  	totalScore = "0";
  	handleTime = "0";
  	listenTime = "0";
  	adjustTime = "0";
  	totalTime  = "0";
  }

	String sqlUpdQcInfo = "update dqcinfo set endtime = sysdate, dealduration=:v1,lisduration=:v2,arrduration=:v3,evtduration=:v4, " +
						  " contentinsum = :v5, handleinfo = :v6, " +
						  " improveadvice = :v7, commentinfo = :v8, " +
						  " errorlevelid = :v9, errorclassid =:v10, qcserviceclassid=:v11, "  +
						  " score = :v12, flag = :v13,  serviceclassdesc=:v14,"+ 
       " CHECKREASONID=:v15, "  +
						  " CHECKREASONDESC=:v16,"+
       " abortreasonid = :v17,abortreasondesc = :v18,errorleveldesc = :v19, errorclassdesc = :v20"+						  
						  //updated by tangsong 20100528 客户级别、来电号码、被加分的考评项名称、被扣分的考评项名称
						  ",usertype=:v21,callerphone=:v22,addedScoreItem=:v23,lostScoreItem=:v24,satisfyName=:25" +
						  " where serialnum = :v26";
						  
	if("saveQcInfo".equals(retType)&&!"".equals(contact_id)){
	  String nowYYYYMM = contact_id.substring(4, 10);
    String tableName = "dcallcall" + nowYYYYMM;
    String sqlUpdDcallcall="update "+tableName+" set QC_LOGIN_NO=:v1,QC_FLAG='Y' where contact_id=:v2";
 %>
    <wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	   <wtc:param value="<%=sqlUpdDcallcall%>"/>
	   <wtc:param value="dbchange"/>
		 <wtc:param value="<%=evterno%>"/>
		 <wtc:param value="<%=contact_id%>"/>
    </wtc:service>
 <%
  }
 
  if("saveQcInfo".equals(retType)&&!"".equals(completedCounts)){
   String sqlUpdDqcplan="update dqcplan set current_times=:v1  where plan_id=:v2 and object_id=:v3 and content_id=:v4 ";
 %>
    <wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
	   <wtc:param value="<%=sqlUpdDqcplan%>"/>
	   <wtc:param value="dbchange"/>
		 <wtc:param value="<%=completedCounts%>"/>
		 <wtc:param value="<%=plan_id%>"/>
		 <wtc:param value="<%=objectid%>"/>
		 <wtc:param value="<%=contentid%>"/>
    </wtc:service>
 <%
  }

%>

<%
if(!("4".equals(flag.trim()))){
//jiangbing 20091118 批量服务替换
String orgCode_sqlMulKfCfm = (String)session.getAttribute("orgCode");
String regionCode_sqlMulKfCfm = orgCode_sqlMulKfCfm.substring(0,2); 
String sqlMulKfCfm="";
%>
<wtc:service name="sModifyMulKfCfm"  outnum="2" routerKey="region" routerValue="<%=regionCode_sqlMulKfCfm%>">
<wtc:param value="<%=sqlMulKfCfm%>"/>
<wtc:param value="dbchange"/>
<wtc:params value="<%=sqlStrs%>"/>
</wtc:service>
<%
}
%>
<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
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
	<wtc:param value="<%=error_level_id%>"/>
	<wtc:param value="<%=error_class_ids%>"/>
	<wtc:param value="<%=service_class_ids%>"/>
	<wtc:param value="<%=totalScore%>"/>
	<wtc:param value="<%=flag%>"/>
	<wtc:param value="<%=service_class_texts%>"/>
	<wtc:param value="<%=check_reason_ids%>"/>
	<wtc:param value="<%=check_reason_texts%>"/>
	<wtc:param value="<%=give_up_reason_ids%>"/>
	<wtc:param value="<%=give_up_reason_texts%>"/>
	<wtc:param value="<%=error_level_text%>"/>
	<wtc:param value="<%=error_class_texts%>"/>
	<wtc:param value="<%=usertype%>"/>
	<wtc:param value="<%=callerphone%>"/>
	<wtc:param value="<%=addedScoreItem%>"/>
	<wtc:param value="<%=lostScoreItem%>"/>
	<wtc:param value="<%=satisfyName%>"/>
	<wtc:param value="<%=serialnum%>"/>
</wtc:service>

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%="000000"%>");
response.data.add("retMsg","<%="success"%>");
response.data.add("object_id","<%="aaa"%>");
core.ajax.receivePacket(response);