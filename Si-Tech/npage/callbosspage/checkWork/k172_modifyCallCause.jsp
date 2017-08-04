<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%

//来电原因异动修改 保存操作页面
//获取参数
String workNo = (String)session.getAttribute("workNo");
String strPreNodeId=request.getParameter("strPreNodeId");
String strPreNodeName=request.getParameter("strPreNodeName");
String strNodeId=request.getParameter("strNodeId");
String strNodeName=request.getParameter("strNodeName");
String strContactId=request.getParameter("strContactId");
String strContactMonth= request.getParameter("contactMonth");
	System.out.println("strContactId222222222:\t"+strContactId);
String strUpdSql="update dcallcall"+strContactMonth+" t set t.call_cause_id='"+strNodeId+"',";
       strUpdSql+="t.callcausedescs='"+strNodeName+"' where t.contact_id='"+strContactId+"'";
       
String strInsert="insert into DLOGCALLCAUSEHIS t (t.serial_no,t.login_no,t.oper_date,t.pre_call_cause_id,t.pre_call_cause_des,t.last_call_cause_id,t.last_call_cause_des,t.contact_id) ";
       strInsert+="values(SEQ_CALLCAUSELOG.NEXTVAL,'"+workNo+"',sysdate,'"+strPreNodeId+"','"+strPreNodeName+"','"+strNodeId+"',";
       strInsert+="'"+strNodeName+"','"+strContactId+"')";
       System.out.println("strInsert:\tt___________"+strInsert);       
List sqlList=new ArrayList();
System.out.println("########################"+strUpdSql);
String[] sqlArr = new String[]{};
		     sqlList.add(strUpdSql);
		     sqlList.add(strInsert);
		     sqlArr = (String[])sqlList.toArray(new String[0]);
String outnum = String.valueOf(sqlArr.length + 1);   
%>
<wtc:service name="sKFModify"  outnum="<%=outnum%>">
<wtc:params value="<%=sqlArr%>"/>
</wtc:service>
<wtc:array id="retRows"  scope="end"/>	

var response = new AJAXPacket();
response.data.add("retCode",<%=retCode%>);
core.ajax.receivePacket(response);
