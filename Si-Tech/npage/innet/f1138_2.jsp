

<% request.setCharacterEncoding("GB2312");%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page contentType= "text/html;charset=gb2312" %>



<%
/*
   输入参数：开户流水 机构编码 操作工号 操作代码
   输出参数：错误代码 错误消息
*/
	//Logger logger = Logger.getLogger("f1138_2.jsp");

    ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
        String sIn_Login_no = (String)session.getAttribute("workNo");
        String sIn_Org_code = (String)session.getAttribute("orgCode");
        String regionCode= (String)session.getAttribute("regCode");
    String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
 
	String sIn_Open_Accept = request.getParameter("sysAccept");       /* 开户流水      */
	String sIn_Op_code = "1138";                                       /* 操作代码      */    

    String ret_code = "";      
    String retMessage = "";	
 	try              
 	{    
 	%>
 	     <wtc:service name="sInvoiceInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="s1223CfmCode" retmsg="s1223CfmMsg" outnum="21" >               
        <wtc:param value="<%=sIn_Open_Accept%>"/>
        <wtc:param value="<%=sIn_Org_code%>"/>
        <wtc:param value="<%=sIn_Login_no%>"/>
        <wtc:param value="<%=sIn_Op_code%>"/>
    </wtc:service>
    <wtc:array id="result" scope="end" />
 	<%                   		

    		ret_code =s1223CfmCode;      
    		retMessage =s1223CfmMsg;
     	}catch(Exception e){
       		//logger.error("Call sunView(sInvoiceInfo) is Failed!");
     	}

        
		if((ret_code.trim()).compareTo("000000") == 0)
		{
%>
            <script language='jscript'>
                rdShowMessageDialog("发票补打成功！",2);
                location = "f1138_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
            </script>            
<%		}else
        {
%>
            <script language='jscript'>
                rdShowMessageDialog("<%=retMessage%>" + "[" + "<%=ret_code%>" + "]" ,0);
                history.go(-1);
            </script>
<%        
        }
%>