<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-16
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
	
	Logger logger = Logger.getLogger("f3521_rpc_query.jsp");
	
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();	
	
	//获取输入的信息
	String verifyType = request.getParameter("verifyType");
	String accept_no = request.getParameter("accept_no");

 	String paraArr[] = new String[5];
	paraArr[0] = workNo;
	paraArr[1] = nopass;
	paraArr[2] = "3521";
	paraArr[3] = "";
	paraArr[4] = accept_no;


    int errCode=-1;
    String errMsg="";
  
	//ArrayList acceptList = new ArrayList();				
	//acceptList = impl.callFXService("s3521Init",paraArr,"16");
	
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
    <wtc:service name="s3521Init" routerKey="region" routerValue="<%=regionCode%>" retcode="s3521InitCode" retmsg="s3521InitMsg" outnum="16" >
    	<wtc:param value="<%=paraArr[0]%>"/>
    	<wtc:param value="<%=paraArr[1]%>"/> 
        <wtc:param value="<%=paraArr[2]%>"/>
        <wtc:param value="<%=paraArr[3]%>"/>
        <wtc:param value="<%=paraArr[4]%>"/>
    </wtc:service>
    <wtc:array id="s3521InitArr" scope="end"/>
    <%
    
	errCode=Integer.parseInt(s3521InitCode);
	errMsg=s3521InitMsg;
	
	//String[][] tmpresult0=(String[][])acceptList.get(0);
	//String[][] tmpresult1=(String[][])acceptList.get(1);
	//String[][] tmpresult2=(String[][])acceptList.get(2);
	//String[][] tmpresult3=(String[][])acceptList.get(3);
	//String[][] tmpresult4=(String[][])acceptList.get(4);
	//String[][] tmpresult5=(String[][])acceptList.get(5);
	//String[][] tmpresult6=(String[][])acceptList.get(6);
	//String[][] tmpresult7=(String[][])acceptList.get(7);
	//String[][] tmpresult8=(String[][])acceptList.get(8);
	//String[][] tmpresult9=(String[][])acceptList.get(9);
	//String[][] tmpresult10=(String[][])acceptList.get(10);
	//String[][] tmpresult11=(String[][])acceptList.get(11);
	//String[][] tmpresult12=(String[][])acceptList.get(12);
	//String[][] tmpresult13=(String[][])acceptList.get(13);
	//String[][] tmpresult14=(String[][])acceptList.get(14);
	//String[][] tmpresult15=(String[][])acceptList.get(15);  
		 
	
       
	if(errCode == 0)
  	{
  		accept_no  		   	=s3521InitArr[0][0];   
		user_id    		   	=s3521InitArr[0][1]; 
  		group_id   		   	=s3521InitArr[0][2];   
		group_name 		   	=s3521InitArr[0][3]; 
		srv_card_code      	=s3521InitArr[0][4];   
		srv_card    	   	=s3521InitArr[0][5];
		grp_product_code   	=s3521InitArr[0][6];    
		grp_product    	   	=s3521InitArr[0][7];
		srv_card_code_end   =s3521InitArr[0][8];    
		srv_card_end    	=s3521InitArr[0][9];
		grp_product_code_end=s3521InitArr[0][10];   
		grp_product_end    	=s3521InitArr[0][11]; 
  		srv_man   		   	=s3521InitArr[0][12];   
		op_time 		   	=s3521InitArr[0][13]; 
		unit_id   		   	=s3521InitArr[0][14];   
		unit_code		   	=s3521InitArr[0][15];
    
     
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
