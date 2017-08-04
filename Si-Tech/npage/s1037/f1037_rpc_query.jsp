<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%

	String workNo   = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	String ip_Addr  = (String)session.getAttribute("ipAddr");
	String nopass  = (String)session.getAttribute("password");
	
	Logger logger = Logger.getLogger("f1037_rpc_query.jsp");
	
	String verifyType = request.getParameter("verifyType");
	String accept_no = request.getParameter("accept_no");

 	String paraArr[] = new String[5];
	paraArr[0] = workNo;
	paraArr[1] = nopass;
	paraArr[2] = "1037";
	paraArr[3] = "";
	paraArr[4] = accept_no;


    int errCode=-1;
    String errMsg="";
	String  user_id="";
	String  group_id="";
	String  group_name="";
	String  srv_card_code      	="";
	String  srv_card    	   	="";
	String  grp_product_code   	="";
	String  grp_product    	   	="";
	String  srv_card_code_end   ="";
	String  srv_card_end    	="";
	String  grp_product_code_end="";
	String  grp_product_end    	="";
	String  srv_man="";
	String  op_time=""; 
	String  unit_id  ="";
	String  unit_code="";
	
	%>
    <wtc:service name="s1037Init" routerKey="region" routerValue="<%=regionCode%>" retcode="s1037InitCode" retmsg="s1037InitMsg" outnum="16" >
    	<wtc:param value="<%=paraArr[0]%>"/>
    	<wtc:param value="<%=paraArr[1]%>"/> 
        <wtc:param value="<%=paraArr[2]%>"/>
        <wtc:param value="<%=paraArr[3]%>"/>
        <wtc:param value="<%=paraArr[4]%>"/>
    </wtc:service>
    <wtc:array id="s1037InitArr" scope="end"/>
    <%
    
	errCode=Integer.parseInt(s1037InitCode);
	errMsg=s1037InitMsg;
       
	if(errCode == 0)
  	{
  		accept_no  		   	=s1037InitArr[0][0];   
		user_id    		   	=s1037InitArr[0][1]; 
  		group_id   		   	=s1037InitArr[0][2];   
		group_name 		   	=s1037InitArr[0][3]; 
		srv_card_code      	=s1037InitArr[0][4];   
		srv_card    	   	=s1037InitArr[0][5];
		grp_product_code   	=s1037InitArr[0][6];    
		grp_product    	   	=s1037InitArr[0][7];
		srv_card_code_end   =s1037InitArr[0][8];    
		srv_card_end    	=s1037InitArr[0][9];
		grp_product_code_end=s1037InitArr[0][10];   
		grp_product_end    	=s1037InitArr[0][11]; 
  		srv_man   		   	=s1037InitArr[0][12];   
		op_time 		   	=s1037InitArr[0][13]; 
		unit_id   		   	=s1037InitArr[0][14];   
		unit_code		   	=s1037InitArr[0][15];
    
     
%>              
var response = new AJAXPacket();
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("verifyType","<%=verifyType%>");
response.data.add("errorCode","<%=errCode%>");
response.data.add("errorMsg","<%=errMsg%>");
response.data.add("accept_no","<%=accept_no%>");
response.data.add("user_id","<%=user_id%>");
response.data.add("group_id","<%=group_id%>");
response.data.add("group_name","<%=group_name%>");
response.data.add("srv_card","<%=srv_card%>");
response.data.add("grp_product","<%=grp_product%>");
response.data.add("srv_card_end","<%=srv_card_end%>");
response.data.add("grp_product_end","<%=grp_product_end%>");
response.data.add("srv_man","<%=srv_man%>");
response.data.add("op_time","<%=op_time%>");
core.ajax.receivePacket(response);

<%
	}
  	else
  	{
%>        
var response = new AJAXPacket();
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("verifyType","<%=verifyType%>");
response.data.add("errorCode","<%=errCode%>");
response.data.add("errorMsg","<%=errMsg%>");
core.ajax.receivePacket(response);       
<%            
    }
    
%>
