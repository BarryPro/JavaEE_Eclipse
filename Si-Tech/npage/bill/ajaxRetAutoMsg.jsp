<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *author:王志超@2010-03-19 新增 在1259续签时 提示该用户是否具有自动续签属性
     *
     ********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	System.out.println("--------------------ajaxRetAutoMsg.jsp-------------------");
	String org_code = (String) session.getAttribute("orgCode");
	
	String return_code = "111111";
	String errMsg="";
	String strPhoneNo =request.getParameter("phone_no");
	System.out.println("--------------------strPhoneNo-------------------"+strPhoneNo);
	System.out.println("strPhoneNo="+strPhoneNo);
%>
<%
	
	/*String sqlB=" select to_char(count(*))	from dBlakWhiteList a,dcustmsg b where a.id_no=b.id_no and b.phone_no=:phone and a.list_type='B'";*/
	String sqlB="select  to_char(count(*)) from product_offer_instance_attr a,product_offer_instance b,dcustmsg c where c.id_no=b.serv_id and a.serv_id=b.product_offer_instance_id and a.attr_id=5100 and a.attr_val=1 and c.phone_no=:phone";
	System.out.println("sqlB|"+sqlB);
	String [] paraIn1 = new String[4];
	String liststr="";
	paraIn1[0] = "region";
	paraIn1[1] = org_code.substring(0,2);
	paraIn1[2] = sqlB;
	paraIn1[3] = "phone="+strPhoneNo;
%>
	<wtc:service name="sPubSelectNew" routerKey="phone" routerValue="<%=strPhoneNo%>" outnum="1" >
		<wtc:param value="<%=paraIn1[0]%>"/>
		<wtc:param value="<%=paraIn1[1]%>"/>
		<wtc:param value="<%=paraIn1[2]%>"/>
		<wtc:param value="<%=paraIn1[3]%>"/>
	</wtc:service>
	<wtc:array id="offnodataArray" scope="end"/>
<%
	System.out.println("----------------retCode-----------------"+retCode);
	if(!retCode.equals("000000"))
	{
		return_code="999999";
		errMsg="查询用户自动续签属性出错";
		System.out.println("----------------errMsg-----------------"+errMsg);
	}
	System.out.println("----------------offnodataArray.length-----------------"+offnodataArray.length);
	if(offnodataArray!=null&&offnodataArray.length>0&&!offnodataArray[0][0].equals("0"))
	{
		System.out.println("----------------offnodataArray[0][0]-----------------"+offnodataArray[0][0]);
		liststr="此用户具有自动续签属性!";
		return_code="000000";
		
	}
	else
	{
	    return_code="111111";
	}	
%>		
	var response = new AJAXPacket();
	var return_code = "<%=return_code%>";
	var return_msg = "<%=errMsg%>";
	response.data.add("return_code",return_code);
	response.data.add("return_msg",return_msg);
	
	core.ajax.receivePacket(response);


 
