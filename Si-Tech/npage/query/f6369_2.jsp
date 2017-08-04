<%
    /********************
     version v2.0
     开发商: si-tech
     *
     *author:王志超@2010-03-22 新增 
     *
     ********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	System.out.println("--------------------f6369_2.jsp-------------------");
	String org_code = (String) session.getAttribute("orgCode");
	String region_code=org_code.substring(0,2);
	System.out.println("----------org_code-----------------"+org_code);
	String phone_no="";
	String begin_time="";
    String end_time="";
    String stype="";
    String return_code = "111111";
	String errMsg="";
	String strArray="var retAry;"; 
	
	phone_no=request.getParameter("phone_no");
	begin_time=request.getParameter("begin_time");
	end_time=request.getParameter("end_time");
	stype=request.getParameter("vartype");
	System.out.println(phone_no+"--"+begin_time+"--"+end_time+"--"+stype);
	String strPhoneNo =request.getParameter("phone_no");
	System.out.println("--------------------strPhoneNo-------------------"+strPhoneNo);
	System.out.println("strPhoneNo="+strPhoneNo);
%>
<%
	StringBuffer strSQL = new StringBuffer();
	strSQL.append("select id_no,phone_no,to_char(op_time,'YYYY-MM-DD HH24:MI:SS'),op_note,type,region_code from SYEARAUTORENFAILEMSG ");
	strSQL.append("where region_code ='"+region_code+"' ");
	if(!"".equals(stype)&&stype!=null)
	{
		strSQL.append("and type='"+stype+"' ");
	}
	
	strSQL.append("and op_time between to_date('"+begin_time+"','YYYY-MM-DD HH24:MI:SS') and to_date('"+end_time+"','YYYY-MM-DD HH24:MI:SS') ");
	if(!"".equals(phone_no)&&phone_no!=null)
	{
		strSQL.append("and phone_no='"+phone_no+"' ");
	}
	
	/*String sqlB=" select to_char(count(*))	from dBlakWhiteList a,dcustmsg b where a.id_no=b.id_no and b.phone_no=:phone and a.list_type='B'";*/
	/*String sqlB="select  to_char(count(*)) from product_offer_instance_attr a,product_offer_instance b,dcustmsg c where c.id_no=b.serv_id and a.serv_id=b.product_offer_instance_id and a.attr_id=5100 and a.attr_val=1 and c.phone_no=:phone";*/
	System.out.println("strSQL|"+strSQL);
	String [] paraIn1 = new String[4];
	
	paraIn1[0] = "region";
	paraIn1[1] = org_code.substring(0,2);
	paraIn1[2] = strSQL.toString();
	paraIn1[3] = "";
%>
	<wtc:service name="sPubSelectNew" routerKey="phone" routerValue="" outnum="6" >
		<wtc:param value="<%=paraIn1[0]%>"/>
		<wtc:param value="<%=paraIn1[1]%>"/>
		<wtc:param value="<%=paraIn1[2]%>"/>
		<wtc:param value="<%=paraIn1[3]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
	System.out.println("----------------retCode-----------------"+retCode);
	System.out.println("----------------retMsg-----------------"+retMsg);
	if(!retCode.equals("000000"))
	{
		return_code="999999";
		errMsg=retMsg;
		System.out.println("----------------errMsg-----------------"+errMsg);
%>
		<%=strArray%>
<%	
	}
	else
	{
		System.out.println("----------------result.length-----------------"+result.length);
		if(result!=null&&result.length>0)
		{
			strArray = WtcUtil.createArray("retAry",result.length);
%>
	       <%=strArray%>
<%	
			for(int i=0;i<result.length;i++)
			{
%>
				retAry[<%=i%>][0] = "<%=result[i][0]%>";
				retAry[<%=i%>][1] = "<%=result[i][1]%>";
				retAry[<%=i%>][2] = "<%=result[i][2]%>";
				retAry[<%=i%>][3] = "<%=result[i][3]%>";
				retAry[<%=i%>][4] = "<%=result[i][4]%>";
				retAry[<%=i%>][5] = "<%=result[i][5]%>";
				//alert(retAry[<%=i%>][0]);
				//alert(retAry[<%=i%>][1]);
				//alert(retAry[<%=i%>][2]);
				//alert(retAry[<%=i%>][3]);
				//alert(retAry[<%=i%>][4]);
				//alert(retAry[<%=i%>][5]);
<%
		     }
		     return_code="000000";
		}
		else
		{
%>
	       <%=strArray%>
<%	
		     return_code="111111";
		}
		
	}
%>		
	var response = new AJAXPacket();
	var return_code = "<%=return_code%>";
	var return_msg = "<%=errMsg%>";
	
	response.data.add("return_code",return_code);
	response.data.add("return_msg",return_msg);
	response.data.add("retAry",retAry);
	core.ajax.receivePacket(response);


 

