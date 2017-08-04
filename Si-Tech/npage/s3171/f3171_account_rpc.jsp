
<%
/********************
 version v2.0
开发商: si-tech
update:anln@2009-02-18 页面改造,修改样式
********************/
%>
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String regionCode= (String)session.getAttribute("regCode");
	String contractPay = request.getParameter("contractPay");	
	String num="";	
    	//SPubCallSvrImpl impl = new SPubCallSvrImpl();   	
	String[] paramsIn = new String[1];	
	paramsIn[0] = contractPay;  					
	ArrayList retArray = null;
	String sqlStr = "select count(*) from dconmsg where contract_no='" + contractPay+"' and account_type='A'";
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1" scope="end" />
<%	
	//retArray = impl.sPubSelect("1",sqlStr);
	
	
	String errCode=retCode1;
	String errMsg=retMsg1;
	System.out.println("sqlStr:"+sqlStr);			
	if(errCode.equals("000000"))
	{
		//String[][] result1 = (String[][])retArray.get(0);
		if(result1!=null&&result1.length>0){
			num = result1[0][0];
		}
		
	}
		
			
%>    
	var response = new AJAXPacket();	
	response.data.add("retFlag","1");
	response.data.add("num","<%=num%>");
	response.data.add("errCode","<%=errCode%>");
	response.data.add("errMsg","<%=errMsg%>");
	core.ajax.receivePacket(response);