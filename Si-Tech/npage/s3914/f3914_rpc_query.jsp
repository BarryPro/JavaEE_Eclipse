<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-15
 ********************/
%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%
	//读取用户session信息
	String workNo   = (String)session.getAttribute("workNo");              //工号
	String workName = (String)session.getAttribute("workName");            //工号姓名
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	String ip_Addr  = (String)session.getAttribute("ipAddr");
	String nopass  = (String)session.getAttribute("password");             //登陆密码
	
	Logger logger = Logger.getLogger("f3914_rpc_query.jsp");
	
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();	
	
	//获取输入的信息
	String verifyType = request.getParameter("verifyType");
	String accept_no = request.getParameter("accept_no");
	String user_id = request.getParameter("user_id");

 	String paraArr[] = new String[6];
	paraArr[0] = workNo;
	paraArr[1] = nopass;
	paraArr[2] = "3914";
	paraArr[3] = "";
	paraArr[4] = accept_no;
	paraArr[5] = user_id;


    int errCode=-1;
    String errMsg="";
  
	//ArrayList acceptList = new ArrayList();				
	//acceptList = impl.callFXService("s3914Init",paraArr,"8");
	
	String  group_id="";
	String  group_name="";
	String  srv_card="";
	String  grp_product="";
	String  srv_man="";
	String  op_time="";
	
	%>
    <wtc:service name="s3914Init" routerKey="region" routerValue="<%=regionCode%>" retcode="s3914InitCode" retmsg="s3914InitMsg" outnum="12" >
    	<wtc:param value="<%=paraArr[0]%>"/>
    	<wtc:param value="<%=paraArr[1]%>"/> 
        <wtc:param value="<%=paraArr[2]%>"/>
        <wtc:param value="<%=paraArr[3]%>"/>
        <wtc:param value="<%=paraArr[4]%>"/>
        <wtc:param value="<%=paraArr[5]%>"/>
    </wtc:service>
    <wtc:array id="s3914InitArr" scope="end"/>
    <%
    
	errCode=Integer.parseInt(s3914InitCode);
	errMsg=s3914InitMsg;
	//String[][] tmpresult0=(String[][])acceptList.get(0);
	//String[][] tmpresult1=(String[][])acceptList.get(1);
	//String[][] tmpresult2=(String[][])acceptList.get(2);
	//String[][] tmpresult3=(String[][])acceptList.get(3);
	//String[][] tmpresult4=(String[][])acceptList.get(4);
	//String[][] tmpresult5=(String[][])acceptList.get(5);
	//String[][] tmpresult6=(String[][])acceptList.get(6);
	//String[][] tmpresult7=(String[][])acceptList.get(7);   
       System.out.println("+++++++++++++++++++++++++++++=errCode = "+errCode);
	if(errCode == 0)
  	{
  		accept_no  =s3914InitArr[0][0];   
		user_id    =s3914InitArr[0][1]; 
  		group_id   =s3914InitArr[0][2];   
		group_name =s3914InitArr[0][3]; 
		srv_card   =s3914InitArr[0][4];   
		grp_product=s3914InitArr[0][5];
		srv_man    =s3914InitArr[0][6];    
		op_time    =s3914InitArr[0][7];    
     
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
