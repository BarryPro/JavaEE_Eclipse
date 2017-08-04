<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>

<%
	//读取用户session信息
	String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));              //工号
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));       	//工号姓名
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String ip_Addr  = WtcUtil.repNull((String)session.getAttribute("ipAttr"));
	String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
			
	//错误信息，错误代码
	int errCode = 0;
	String errMsg = "";
	
	String unit_id = (request.getParameter("unit_id")==null)?"":(request.getParameter("unit_id"));
	String begin_time = (request.getParameter("begin_time")==null)?"":(request.getParameter("begin_time"));
	String end_time = (request.getParameter("end_time")==null)?"":(request.getParameter("end_time"));
	
System.out.println("luxc:unit_id:"+unit_id+",begin_time:"+begin_time+",end_time:"+end_time);

	String[][] retListString2 = new String[][]{};
	%>
        <wtc:service name="s3101EXC" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="9">			
        	<wtc:param value="3101"/>	
        	<wtc:param value="<%=workNo%>"/>	
        	<wtc:param value="<%=unit_id%>"/>	
        	<wtc:param value="<%=begin_time%>"/>	
        	<wtc:param value="<%=end_time%>"/>	
    	</wtc:service>	
        <wtc:array id="retArr1" scope="end"/>
    <%
    if("000000".equals(retCode1) && retArr1.length>0){
        retListString2 = retArr1;
    }
	//String[][] retListString2 = (String[][])retList2.get(0);
	
	//errCode=impl.getErrCode();   
	//errMsg=impl.getErrMsg(); 
	errCode = Integer.parseInt(retCode1);
	errMsg = retMsg1;
	System.out.println("errCode:"+errCode);
	System.out.println("errMsg:"+errMsg);
%>

	var unit_id= new Array(); 
	var unit_name= new Array();
	var service_no= new Array(); 
	var update_time= new Array();  
	var update_login= new Array(); 
	var update_code= new Array(); 
	var update_name= new Array(); 
	var update_type= new Array(); 
	var new_service_no = new Array(); 

	var response = new AJAXPacket();
<%
	if(errCode==0)
	{
		for(int i=0;i<retListString2.length;i++)
		{
		System.out.println("luxc:i="+i);
%>
			
			unit_id[<%=i%>]     = "<%=retListString2[i][0]%>";
			unit_name[<%=i%>]   = "<%=retListString2[i][1]%>";
			service_no[<%=i%>]  = "<%=retListString2[i][2]%>";
			update_time[<%=i%>] = "<%=retListString2[i][3]%>";
			update_login[<%=i%>]= "<%=retListString2[i][4]%>";
			update_code[<%=i%>] = "<%=retListString2[i][5]%>";
			update_name[<%=i%>] = "<%=retListString2[i][6]%>";
			update_type[<%=i%>] = "<%=retListString2[i][7]%>";
		 new_service_no[<%=i%>] = "<%=retListString2[i][8]%>";			
			
<%
		}
%>
    		response.data.add("unit_id",unit_id);
    		response.data.add("unit_name",unit_name);
    		response.data.add("service_no",service_no);
    		response.data.add("update_time",update_time);
    		response.data.add("update_login",update_login);
    		response.data.add("update_code",update_code);
    		response.data.add("update_name",update_name);
    		response.data.add("update_type",update_type);
    		response.data.add("new_service_no",new_service_no);		
    		
    		response.data.add("num","<%=retListString2.length%>");
    		response.data.add("errCode","<%=errCode%>");
    		response.data.add("errMsg","<%=errMsg%>");
    		core.ajax.receivePacket(response);
<%
	
	}
	else
	{
	System.out.println("return erro");
%>
    		response.data.add("errCode","<%=errCode%>");
    		response.data.add("errMsg","<%=errMsg%>");
    		core.ajax.receivePacket(response);
<%	
	}
%>
