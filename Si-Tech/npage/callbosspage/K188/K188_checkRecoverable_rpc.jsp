<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="/npage/callbosspage/public/constants.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%

	String serialnum = WtcUtil.repNull(request.getParameter("serialnum"));
	String recordernum = WtcUtil.repNull(request.getParameter("recordernum"));
	String staffno = WtcUtil.repNull(request.getParameter("staffno"));
	String evterno = WtcUtil.repNull(request.getParameter("evterno"));
	String objectid = WtcUtil.repNull(request.getParameter("objectid"));
	String contentid = WtcUtil.repNull(request.getParameter("contentid"));
	String plan_id = WtcUtil.repNull(request.getParameter("plan_id"));	
	String group_flag = WtcUtil.repNull(request.getParameter("group_flag"));
	String strSql = null;
	String returnNum = "0";
	String tmpNum1 = "0";
	String tmpNum2 = "0";
	//该工号总计划次数减去当前已经执行次数，若结果小于1，则该流水不能被恢复
	String currTimesSql = "select plan_time - decode(current_times,null,0,current_times) from dqcloginplan where plan_id = '" + plan_id + "' and object_id = '" + objectid + "' and content_id = '" + contentid + "' and login_no = '"+ staffno + "'";
	if(group_flag!=null && "0".equals(group_flag)){
			strSql = "select count(1) from dqcinfo where RECORDERNUM = '"+ recordernum+ "' and EVTERNO = '"+ evterno + "'  and plan_id = '" + plan_id + "' and is_del = 'N' " + " and group_flag = '" + group_flag + "'";
	}else{
			strSql = "select count(1) from dqcinfo where RECORDERNUM = '"+ recordernum+ "' and EVTERNO = '"+ evterno + "'  and plan_id = '" + plan_id + "' and is_del = 'N' " + " and (group_flag is null or group_flag = '" + group_flag + "')";
	}
	System.out.println("==========================================================");
System.out.println(strSql);
System.out.println("==========================================================");
%>	

		<wtc:service name="s151Select" outnum="1">
		<wtc:param value="<%=currTimesSql%>"/>
			</wtc:service>
		<wtc:array id="currTemp" scope="end"/>
<%
    if(currTemp.length>0){
      tmpNum1 = currTemp[0][0];
    }
%>

	
	<wtc:service name="s151Select" outnum="1">
		<wtc:param value="<%=strSql%>"/>
	</wtc:service>
	<wtc:array id="temp" scope="end"/>
<%
    if(temp.length>0){
      tmpNum2 = temp[0][0];
    }
    if(Integer.parseInt(tmpNum1) < 1 || Integer.parseInt(tmpNum2)>0){
    		returnNum = "1";
    }
%>
      var response = new AJAXPacket();
      response.data.add("serialnum","<%=serialnum%>"); 
      response.data.add("recordernum","<%=recordernum%>");
      response.data.add("staffno","<%=staffno%>");
      response.data.add("evterno","<%=evterno%>");
      response.data.add("objectid","<%=objectid%>");
      response.data.add("contentid","<%=contentid%>");
      response.data.add("plan_id","<%=plan_id%>"); 
      response.data.add("returnNum","<%=returnNum%>");      
      core.ajax.receivePacket(response);