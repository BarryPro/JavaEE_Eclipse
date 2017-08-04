
 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-15页面改造,修改样式
	********************/
%>

<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.*" %>

<%
	String regionCode = (String)session.getAttribute("regCode");
        //ArrayList retArray = new ArrayList();
        String ret_code  = "";				//错误代码 
        String ret_message  = "";      		//错误消息         
        String sysAccept = "000000";        
        String[][] result = new String[][]{};
 	//SPubCallSvrImpl callView = new SPubCallSvrImpl();	   
	    String retType = request.getParameter("retType");
        try
        {
                String sqlStr ="select to_char(sMaxSysAccept.nextval) from dual";
                //retArray = callView.sPubSelect("1",sqlStr);
                %>
                	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
				<wtc:sql><%=sqlStr%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result1" scope="end" />
                <%
                result=result1;
                //result = (String[][])retArray.get(0);
                if(result!=null&&result.length>0){
                	sysAccept = (result[0][0]).trim();
                }
		System.out.println("sysAccept="+sysAccept);
                ret_code = "000000";           
        }catch(Exception e){
            ret_code = "000001";
            ret_message = "取系统操作流水失败！";
        }
%>

var response = new AJAXPacket();
var retType = "";
var sysAccept = "";
retType = "<%=retType%>";
retCode = "<%=ret_code%>";
retMessage = "<%=ret_message%>";
sysAccept = "<%=sysAccept%>";
response.data.add("retType",retType);
response.data.add("retCode",retCode);
response.data.add("retMessage",retMessage);
response.data.add("sysAccept",sysAccept);
core.ajax.receivePacket(response);
