<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-18
********************/
%>
           

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*"%>
<%
	String regionCode = (String)session.getAttribute("regCode");
 
	String detail_type = request.getParameter("detail_type");     
	String rpcType = request.getParameter("rpcType");   
	String region_code = request.getParameter("region_code");  
	String sm_code = request.getParameter("sm_code");  
	String qryStr="";
	
  String sqlStr="";

  
 /*****����detail_type�����ͣ����������******/
 if( detail_type.equals("0") )//����
 {
	sqlStr = "select max(trim(rate_code)) from sBillRateCode where region_code='"+region_code+"'";
 } 
 else if(detail_type.equals("1")||detail_type.equals("9"))//����
 {
	sqlStr = "select max(trim(month_code)) from sBillMonthCode where region_code='"+region_code+"'";
 }
 else if(detail_type.equals("2")||detail_type.equals("b"))//����
 {
	sqlStr = "select max(trim(total_code)) from sBillTotCode where region_code='"+region_code+"'";
 }
 else if(detail_type.equals("3"))//ͨ�������Ż�
 {
	sqlStr = "select max(trim(favour_code)) from sBillFavCfg where region_code='"+region_code+"'";
 }
 else if(detail_type.equals("4"))//�ط��Ż�
 {
    sqlStr = "select max(trim(function_bill)) from sBillFuncFav where region_code='"+region_code+"' and sm_code='"+sm_code+"'";
 }

	//retList = impl.sPubSelect("1",sqlStr,"region",regionCode);
%>

		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>

<%	
	String[][] maxDetailCode = new String[][]{};
	if(result_t.length>0&&code.equals("000000"))
	 maxDetailCode = result_t;
	String maxR =maxDetailCode[0][0];
	int errCode=0;
	String errMsg="success";
	if (maxDetailCode != null)
	{
		if (maxDetailCode[0][0].equals("")) 
		{
			maxDetailCode =null;
			errCode =-1;
			errMsg="ȡ�Żݴ������";
		}
	}
	
	if (errCode == -1)
	{
 
		maxR =  "0000";
		

				errCode=0;
				errMsg="success";
	}
%>

var response = new AJAXPacket();
response.data.add("errCode","<%=errCode%>");
response.data.add("errMsg","<%=errMsg%>");
response.data.add("rpcType","<%=rpcType%>");
response.data.add("detailCode","<%=maxR%>");
core.ajax.receivePacket(response);