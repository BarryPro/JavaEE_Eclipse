 <%
   /******************************************
   * 功能: 校验产品包代码
　 * 版本: v1.0
　 * 日期: 2007/01/24
　 * 作者: liubo
　 * 版权: sitech
     * 修改历史
     * 修改日期      修改人      修改目的
     2009/11/09		 niuhr		 新版界面
   *****************************************/ 
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>

<%
	String param_code = request.getParameter("param_code") == null ? "" : request.getParameter("param_code"); 
	String rpcType = request.getParameter("rpcType") == null ? "" : request.getParameter("rpcType");    
	//System.out.println("***comb_code = "+comb_code);
	String str="select  count(*)  from sBizParamCode  where  param_code = '"+param_code.trim()+"' ";
%>

<%
	String srvname = "sPubSelect";
%>

<wtc:pubselect name="sPubSelect"  outnum="1">
		<wtc:sql><%=str%> </wtc:sql>
</wtc:pubselect>
<wtc:array id="rows" scope="end"/>
	
<%
     //System.out.println("rows.length="+rows.length);
     //System.out.println("rows.retCode="+retCode);
     //System.out.println("rows.retMsg="+retMsg);
	if(retCode.equals("000000"))
	{	 
		if(rows.length>0)
		{
				//System.out.println("rows.rows[0][0]="+rows[0][0]);
			if (!rows[0][0].equals("0"))
			{
		       //System.out.println("rows.rows[0][0]="+rows[0][0]);
		       retCode="111111";
		       retMsg="查询代码为已存在参数代码，请重新输入";
			}	 
		}   
	}else{
%>    
		<script language=javascript>	
			rdShowMessageDialog("系统错误，请重新校验!");
			window.close();
		</script>
<%
		}
%>

var response = new AJAXPacket();
response.data.add("errCode","<%=retCode%>");
response.data.add("errMsg","<%=retMsg%>");
response.data.add("rpcType","<%=rpcType%>");
core.ajax.receivePacket(response);