<%
   /*
   * 功能: 集团产品变更历史查询 第2页
　 * 日期: 2007-12-24
　 * 作者: 芦学琛
 　*/
 %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@page contentType="text/html;charset=GBK" %>
<%
	//读取用户session信息
	String workNo   = WtcUtil.repNull((String)session.getAttribute("workNo"));                 //工号
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));              	//工号姓名
	String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String ip_Addr  = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
			
	//错误信息，错误代码
	int errCode = 0;
	String errMsg = "";
	
	String grp_id = request.getParameter("grp_id");
	String begin_time = request.getParameter("begin_time");
	String end_time = request.getParameter("end_time");
	
	String oProductCodeNow = "";
	String oProductNameNow = "";
	String oBeginTimeNow = "";
	String oEndTimeNow = "";
	
System.out.println("luxc:grp_id:"+grp_id+",begin_time:"+begin_time+",end_time:"+end_time);

	ArrayList retList2 = new ArrayList();  
	
	//retList2 = impl.sPubSelect("8",sqlstr,"region",regionCode);
	String[][] retListString2 = new String[][]{};
    %>
    <wtc:service name="s3103CmtEXC" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="12" >
        <wtc:param value="3103"/>
        <wtc:param value="<%=workNo%>"/>
        <wtc:param value="<%=grp_id%>"/> 
        <wtc:param value="<%=begin_time%>"/> 
        <wtc:param value="<%=end_time%>"/> 
    </wtc:service>
    <wtc:array id="retArr1" start="0" length="8" scope="end"/>
    <wtc:array id="retArr2" start="8" length="4" scope="end"/>
            <%
            
            
    if("000000".equals(retCode1) && retArr1.length>0){
        retListString2 = retArr1;
        oProductCodeNow = retArr2[0][0];
    	oProductNameNow = retArr2[0][1];
    	oBeginTimeNow = retArr2[0][2];
    	oEndTimeNow = retArr2[0][3];
    }
	//String[][] retListString2 = (String[][])retList2.get(0);
	
	//errCode=impl.getErrCode();   
	//errMsg=impl.getErrMsg(); 
	errCode = Integer.parseInt(retCode1);
	errMsg = retMsg1;
	System.out.println("errCode:"+errCode);
	System.out.println("errMsg:"+errMsg);
%>

	var id_no= new Array(); 
	var product_code= new Array();
	var product_name= new Array(); 
	var begin_time= new Array();  
	var end_time= new Array(); 
	var login_no= new Array(); 
	var op_code= new Array(); 
	var function_name= new Array(); 
    var vProductCodeNow = "<%=oProductCodeNow%>";
    var vProductNameNow = "<%=oProductNameNow%>";
    var vBeginTimeNow   = "<%=oBeginTimeNow%>";
    var vEndTimeNow     = "<%=oEndTimeNow%>";

	var response = new AJAXPacket();
	//response.guid = '<%= request.getParameter("guid") %>';
<%
	if(errCode==0)
	{
		for(int i=0;i<retListString2.length;i++)
		{
		System.out.println("luxc:i="+i);
%>
			
			id_no[<%=i%>]     		= "<%=retListString2[i][0]%>";
			product_code[<%=i%>]   	= "<%=retListString2[i][1]%>";
			product_name[<%=i%>]  	= "<%=retListString2[i][2]%>";
			begin_time[<%=i%>] 		= "<%=retListString2[i][3]%>";
			end_time[<%=i%>]		= "<%=retListString2[i][4]%>";
			login_no[<%=i%>] 		= "<%=retListString2[i][5]%>";
			op_code[<%=i%>]	 		= "<%=retListString2[i][6]%>";
			function_name[<%=i%>] 	= "<%=retListString2[i][7]%>";
			
<%
		}
%>
		response.data.add("id_no",id_no);
		response.data.add("product_code",product_code);
		response.data.add("product_name",product_name);
		response.data.add("begin_time",begin_time);
		response.data.add("end_time",end_time);
		response.data.add("login_no",login_no);
		response.data.add("op_code",op_code);
		response.data.add("function_name",function_name);
		
		response.data.add("productCodeNow",vProductCodeNow);
		response.data.add("productNameNow",vProductNameNow);
		response.data.add("beginTimeNow",vBeginTimeNow);
		response.data.add("endTimeNow",vEndTimeNow);
		
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
