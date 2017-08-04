 <%
	/********************
	 version v2.0
	开发商: si-tech
	update:anln@2009-02-04 页面改造,修改样式
	********************/
%>  
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>



<%
	//读取session信息	
	 String regionCode = (String)session.getAttribute("regCode");     
	//错误信息，错误代码
	String errCode = "0";
	String errMsg = "";

	String agentPhone = request.getParameter("agentPhone");
	String type = request.getParameter("type");

	//SPubCallSvrImpl impl = new SPubCallSvrImpl();

	//------------------------------------查询手机号信息---------------------------------------

	//ArrayList retList = new ArrayList();
	String sqlStr = "select a.cust_id  from dcustmsg a where a.phone_no = '" + agentPhone + "'";
	//retList = impl.sPubSelect("1",sqlStr,"region",regionCode);
	%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:sql><%=sqlStr%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="result1" scope="end" />
	<%
	
		
		errCode=retCode1; //错误代码
		System.out.println("errCode222222:"+errCode);		
		errMsg=retMsg1;//错误信息
		System.out.println("errMsg22222222:"+errMsg);
	
	String[][] retListString = null;
%>
	var cust_id = new Array();
<%
	if(errCode.equals("000000")){
		
			//retListString = (String[][])retList.get(0);
			retListString=result1;	
			if(retListString!=null)	{
			for(int i = 0;i < retListString.length;i++){
	%>
				cust_id[<%=i%>] = '<%=retListString[i][0]%>';
	<%
			}	
			}	
	}
	
	//ArrayList retList1 = new ArrayList();
	String sqlStr1 = "select count(*) from dagtbasemsg where agt_phone='" + agentPhone + "' ";
	//retList1 = impl.sPubSelect("1",sqlStr1,"region",regionCode);
	%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
		<wtc:sql><%=sqlStr1%></wtc:sql>
		</wtc:pubselect>
	<wtc:array id="result2" scope="end" />
	<%
				
				//errCode = impl.getErrCode(); //错误代码
				errCode=retCode2;
				System.out.println("errCode33333333:"+errCode);
				//errMsg = impl.getErrMsg(); //错误信息
				errMsg=retMsg2;
				System.out.println("errMsg333333333:"+errMsg);
			
	
		String[][] retListString1 = null;
%>
	var phone_num="";

<%
	if(errCode.equals("000000")){
		
			//retListString1 = (String[][])retList1.get(0);
			retListString1=result2;	
			if(retListString1!=null){		
			for(int i = 0;i < retListString1.length;i++){
				System.out.println("retListString1[0][0]:"+retListString1[0][0]);
				System.out.println("retListString1.length:"+retListString1.length);
	%>
	
				phone_num = '<%=retListString1[0][0]%>';
	
	<%
			}	
			}	
	}
	%>

var response = new AJAXPacket();
response.data.add("cust_id",cust_id);
response.data.add("phone_num",phone_num);
response.data.add("type","<%=type%>");
response.data.add("errCode","<%=errCode%>");
response.data.add("errMsg","<%=errMsg%>");
core.ajax.receivePacket(response);