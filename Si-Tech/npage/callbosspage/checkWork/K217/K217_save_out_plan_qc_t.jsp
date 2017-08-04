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
  String contact_id   = WtcUtil.repNull(request.getParameter("contact_id"));//通话流水
	String completedCounts    = WtcUtil.repNull(request.getParameter("completedCounts"));		
	String contentinsum      = WtcUtil.repNull(request.getParameter("contentinsum"));
	String handleinfo        = WtcUtil.repNull(request.getParameter("handleinfo"));
	String improveadvice     = WtcUtil.repNull(request.getParameter("improveadvice"));
	String commentinfo       = WtcUtil.repNull(request.getParameter("commentinfo"));
	String isOutPlanflag       = WtcUtil.repNull(request.getParameter("isOutPlanflag"));

			isOutPlanflag = "1";

	
	//add for 中测 start 培训建议  在sql插入时增加此字段
	String tranSugg       = WtcUtil.repNull(request.getParameter("tranSugg"));
	String testWeight       = WtcUtil.repNull(request.getParameter("testWeight"));
	
	if(null==staffno){
			staffno="";
	}
	
	String[] sqlStrs   = new String[scores.length];
	StringBuffer sb = new StringBuffer();

	for(int i = 0; i < scores.length; i++){
	String sqlGetSerialNum = "select to_char(sysdate,'yyyyMMdd')||lpad(seq_qc_result.nextval,12,'0') from dual";
	//获得质检流水
  %>
	    <wtc:service name="s151Select" outnum="1">
	    <wtc:param value="<%=sqlGetSerialNum%>"/>
	    </wtc:service>
	    <wtc:array id="serialNum" scope="end"/>
  <%
	    String sqlInsertQcInfo = "insert into dqcinfo(serialnum, recordernum, starttime, flag, objectid, contentid, staffno, evterno,outplanflag,checkflag,score,contentlevelid) " +
	                         "values ('" + serialNum[0][0]  + "','', sysdate, '"+retType+"','','"+contact_id+"','"+staffno+"','"+evterno+"','"+isOutPlanflag+"','1','"+scores[i]+"','"+itemids[i]+"')";
			sqlStrs[i] = sqlInsertQcInfo;
	}

%>

<wtc:service name="sPubModify" outnum="3">
	<wtc:params value="<%=sqlStrs%>"/>
	<wtc:param value="dbcntt"/>
</wtc:service>


<wtc:row id="row" start="0" length="3">

var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%="000000"%>");
response.data.add("retMsg","<%="success"%>");
response.data.add("object_id","<%="aaa"%>");
core.ajax.receivePacket(response);
</wtc:row>