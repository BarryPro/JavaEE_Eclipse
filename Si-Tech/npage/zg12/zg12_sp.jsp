<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
 
<%
    String workno = (String)session.getAttribute("workNo");
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String groupId = (String)session.getAttribute("groupId");
	
	String phone_no= request.getParameter("phone_no");
	String tax_id= request.getParameter("tax_id");
	String begin_dt= request.getParameter("begin_dt");
	String end_dt= request.getParameter("end_dt");
 
	String[] inParam0 = new String[2];
	inParam0[0]="select to_char(count(*)) from DINVOICE_tax_sp where phone_no =:s_phone_no and tax_id = :s_tax_id  and( (begin_dt >= :s_begin_dt0 and end_dt <= :s_end_dt0) or (begin_dt >= :s_begin_dt1 and begin_dt <= :s_end_dt1) or (begin_dt <= :s_begin_dt2 and end_dt >= :s_end_dt2) )  ";
	inParam0[1]="s_phone_no="+phone_no+",s_tax_id="+tax_id+",s_begin_dt0="+begin_dt+",s_end_dt0="+end_dt+",s_begin_dt1="+begin_dt+",s_end_dt1="+end_dt+",s_begin_dt2="+begin_dt+",s_end_dt2="+end_dt;
	String s_count="0";//是否有记录 
	String s_flag="";
%>
 


	<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2"  outnum="1" >
		<wtc:param value="<%=inParam0[0]%>"/>
		<wtc:param value="<%=inParam0[1]%>"/>
	</wtc:service>
	<wtc:array id="bill_cancel" scope="end"/>
 
<%
	if(bill_cancel!=null&&bill_cancel.length>0)
	{
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaa bill_cancel[0][0] is "+bill_cancel[0][0]);
		if(retCode2=="000000" ||retCode2.equals("000000"))
		{
			s_flag="0";//调用成功
			s_count=bill_cancel[0][0];
		}
		else
		{
			s_flag="1";
	 
		}
		
	}
	else
	{
		s_flag="2";//sql运行异常
 
	}
	
 
%>
 
var response = new AJAXPacket();
var s_flag = "<%=s_flag%>";
var s_count = "<%=s_count%>";
response.data.add("s_count",s_count);  
response.data.add("s_flag",s_flag); 
core.ajax.receivePacket(response);

 

 
