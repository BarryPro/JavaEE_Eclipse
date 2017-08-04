<%@ page contentType="text/html; charset=gb2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	String opCode = request.getParameter("opCode");
	String v_phoneNo = request.getParameter("phoneNo");

	String workNo = (String)session.getAttribute("workNo");
	String workPwd = (String)session.getAttribute("password");
	String regCode=(String)session.getAttribute("regCode");

	String imeino = WtcUtil.repNull((String)request.getParameter("imeino"));
	String notes = workNo+"对号码"+v_phoneNo+"进行sim录入";
  
  String bandnames="";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regCode%>" id="printAccept"/>

  var array = [];

	<wtc:service name="sOfferQryByIMEI" routerKey="region" routerValue="<%=regCode%>" retcode="retCode3" retmsg="retMsg3" outnum="5" >
		<wtc:param value=""/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=workPwd%>"/>
		<wtc:param value="<%=v_phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=imeino%>"/>

	</wtc:service>

		<wtc:array id="result22" scope="end"  start="0"  length="3"/>
		<wtc:array id="result2ss" scope="end"  start="3"  length="2"/>
		
<%
	  if(retCode3.equals("000000")) {
			//封装js数组
			System.out.println("返回数组的长度------------"+result22.length);
			if(result2ss.length>0) {
				bandnames=result2ss[0][1];
			}
			for(int i=0;i<result22.length;i++) 
			{
System.out.println("result22["+i+"][0]="+result22[i][0]);	
System.out.println("result22["+i+"][1]="+result22[i][1]);	
System.out.println("result22["+i+"][2]="+result22[i][2]);	
	
		%>
					var type = {};
				  type.offerid = '<%=result22[i][0]%>';
				  type.offername= '<%=result22[i][1]%>';
				  type.offercomments= '<%=result22[i][2]%>';				  
				  array.push(type);
		<%
			}
	 }
%>		
	
	

var response = new AJAXPacket();
response.data.add("retCode","<%=retCode3%>");
response.data.add("retMsg","<%=retMsg3%>");
response.data.add("bandnames","<%=bandnames%>");
response.data.add("result",array);
core.ajax.receivePacket(response);
