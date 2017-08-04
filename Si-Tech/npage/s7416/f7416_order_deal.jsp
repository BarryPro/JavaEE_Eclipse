<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%String regionCode = (String)session.getAttribute("regCode");%>
<%@ page contentType="text/html;charset=GBK"%>
<%	
	String WorkNo         =	request.getParameter("sWorkNo");        //0 操作工号                         
	String PassWord       =	request.getParameter("sPassWord");      //1 工号密码                     
	String OpCode         =	request.getParameter("sOpCode");        //2 功能代码                              
	String PONumber       =	request.getParameter("sPONumber");      //3 订单编号            
	String UnitID         =	request.getParameter("sUnitID");        //4 客户ID                  
	String IDNo           =	request.getParameter("sIDNo");          //5 业务包用户ID                
	String TASK_SEQ       =	request.getParameter("sTASK_SEQ");     //6 工单编号            
	String TASK_TYPE_CODE =	request.getParameter("sTASK_TYPE_CODE");//7 工单类型
	String TASK_OPER      =	request.getParameter("sTASK_OPER");     //8 工单处理结果      
	String TASK_NOTE      =	request.getParameter("sTASK_NOTE");     //9 注释 
	System.out.println("0 操作工号    WorkNo        :"+WorkNo        );
	System.out.println("1 工号密码    PassWord      :"+PassWord      );
	System.out.println("2 功能代码    OpCode        :"+OpCode        );
	System.out.println("3 订单编号    PONumber      :"+PONumber      );
	System.out.println("4 客户ID      UnitID        :"+UnitID        );
	System.out.println("5 业务包用户  IDIDNo        :"+IDNo          ); 
	System.out.println("6 工单编号    TASK_SEQ      :"+TASK_SEQ      );
	System.out.println("7 工单类型    TASK_TYPE_CODE:"+TASK_TYPE_CODE);
	System.out.println("8 工单处理结果TASK_OPER     :"+TASK_OPER     );
	System.out.println("9 注释        TASK_NOTE     :"+TASK_NOTE     );
%>

<wtc:service name="s7416Cfm" outnum="3" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=WorkNo%>"/>
	<wtc:param value="<%=PassWord%>"/>
	<wtc:param value="<%=OpCode%>"/>
	<wtc:param value="<%=PONumber%>"/>
	<wtc:param value="<%=UnitID%>"/>
	<wtc:param value="<%=IDNo%>"/>
	<wtc:param value="<%=TASK_SEQ%>"/>
	<wtc:param value="<%=TASK_TYPE_CODE%>"/>
	<wtc:param value="<%=TASK_OPER%>"/>
	<wtc:param value="<%=TASK_NOTE%>"/>									
</wtc:service>
<wtc:array id="result" scope="end" start="0" length="3"/>
<%
	retCode="999999";
	retMsg="系统错误";
	String orderStatus="";
	if(result.length>0){
	  	retCode = result[0][0];
	  	retMsg = result[0][1].trim();
	  	orderStatus = result[0][2].trim();
	  	System.out.println("retCode:"+retCode);
	  	System.out.println("retMsg:"+retMsg);
	  	System.out.println("orderStatus:"+orderStatus);
	}
%>
var response = new AJAXPacket();
var retCode ='<%=retCode%>';
var retMsg ='<%=retMsg%>';
var orderStatus = '<%=orderStatus%>';
response.data.add("retCode",retCode);
response.data.add("retMsg",retMsg);
response.data.add("orderStatus",orderStatus);
core.ajax.receivePacket(response);
