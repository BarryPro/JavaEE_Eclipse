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
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	
	if(null==staffno){
			staffno="";
	}
	
	String[] sqlStrs   = new String[scores.length];
	StringBuffer sb = new StringBuffer();

	for(int i = 0; i < scores.length; i++){
			sb.append("insert into dqcinfodetail (serialnum,objectid,contentid,itemid,weight,orgvalue,score) ");
			sb.append("values(:v1, :v2,:v3,:v4,'0','0',:v5)&&"+serialnum+"^"+objectid+"^"+contentid+"^"+itemids[i]+"^"+scores[i]);
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
  String give_up_reason_texts = WtcUtil.repNull(request.getParameter("give_up_reason_texts"));  
  String handleTime = WtcUtil.repNull(request.getParameter("handleTime"));
  String listenTime = WtcUtil.repNull(request.getParameter("listenTime"));     
  String adjustTime = WtcUtil.repNull(request.getParameter("adjustTime"));
  String totalTime  = WtcUtil.repNull(request.getParameter("totalTime"));
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
						  " abortreasonid = :v15,abortreasondesc = :v16,errorleveldesc = :v17, errorclassdesc = :v18"+
						  " where serialnum = :v19";

	if("saveQcInfo".equals(retType)&&!"".equals(contact_id)){
		  String nowYYYYMM = contact_id.substring(0, 6);
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
  if(("saveQcInfo".equals(retType)&&!"".equals(completedCounts))||
  	 ("tempSaveQcInfo".equals(retType)&&!"".equals(completedCounts))||
  	 ("giveUpQcInfo".equals(retType)&&!"".equals(completedCounts))){
  	 String sqlUpdDqcplan="update dqcloginplan set current_times=:v1  where trim(plan_id)=:v2 and trim(object_id)=:v3 and trim(content_id)=:v4 and trim(login_no)=:v5";
%>
    <wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
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
	<wtc:param value="<%=give_up_reason_ids%>"/>
	<wtc:param value="<%=give_up_reason_texts%>"/>
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