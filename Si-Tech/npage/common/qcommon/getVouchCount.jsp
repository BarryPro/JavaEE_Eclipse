<%
   /*
   * 功能: 获取该证件号码的已担保数量
　 * 版本: v1.0
　 * 日期: 2009/02/21
　 * 作者: wanglj
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>

<%@ page contentType= "text/html;charset=gb2312"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>	
<% 
	String returnCode = "";
	String returnMsg = "";
	String vouchCount = "";
	String vouchName ="";
	String vouchPhone ="";
	String vouchPost ="";
	String vouchAddr ="";
	String vouchNo = "";
	String retType = request.getParameter("retType");
	String idType = request.getParameter("idType");
	if(idType!=null){
		idType = idType.split("\\|")[0];	
	}else{
			idType = "Z";
	}
	String idIccid = request.getParameter("idIccid");
	String getvouchCountSql = "select assure_num,assure_name,assure_phone,assure_zip, assure_address,assure_no from dAssuMsg where id_type='"+idType+"' and assure_id ='"+idIccid+"'";
%>

	<wtc:pubselect name="sPubSelect" outnum="6">
		<wtc:sql><%=getvouchCountSql%></wtc:sql>
    </wtc:pubselect>
    <%if(!retCode.equals("000000"))
    {
    	returnCode=retCode;
    	returnMsg=retMsg;
    }
  else{%> 
	<wtc:array id="result" scope="end"/>
<%	
	if(result.length != 0)
	{
		returnCode = "000000";
		returnMsg = "查询成功";
		vouchCount = result[0][0];	
		vouchName = result[0][1];
		vouchPhone = result[0][2];
		vouchPost = result[0][3];
		vouchAddr = result[0][4];
		vouchNo = result[0][5]; 
	}
	else
	{
		returnCode = "111111";
		returnMsg = "查询该证件号码已开客户数量失败！";
	}

%>
	<%}%>
<%System.out.println("*****************"+returnCode+":"+returnMsg+":"+vouchCount+":"+vouchName+":"+vouchPhone+":"+vouchPost+":"+vouchAddr+":"+vouchNo);%>
var response = new AJAXPacket();
response.data.add("retType","<%=retType%>");
response.data.add("retCode","<%=returnCode%>");
response.data.add("vouchCount","<%=vouchCount%>");
response.data.add("vouchName","<%=vouchName%>");
response.data.add("vouchPhone","<%=vouchPhone%>");
response.data.add("vouchPost","<%=vouchPost%>");
response.data.add("vouchAddr","<%=vouchAddr%>");
response.data.add("vouchNo","<%=vouchNo%>");
response.data.add("retMessage","<%=returnMsg%>");
core.ajax.receivePacket(response);

