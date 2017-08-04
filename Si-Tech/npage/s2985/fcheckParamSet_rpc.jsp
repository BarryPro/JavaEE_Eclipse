 <%

   /******************************************

   * 功能: 校验产品包代码

　 * 版本: v1.0

　 * 日期: 2007/01/24

　 * 作者: liubo

　 * 版权: sitech

     * 修改历史

     * 修改日期:2009/05/14      修改人:leimd      修改目的:适应新需求

   *****************************************/

%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>

<%

	String param_set = request.getParameter("param_set") == null ? "" : request.getParameter("param_set"); 

	String rpcType = request.getParameter("rpcType") == null ? "" : request.getParameter("rpcType");    

	String str="select  count(*)  from sBizParamSet  where  param_set = '"+param_set.trim()+"' ";
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
%>



<%

	String srvname = "sPubSelect";

%>

<wtc:pubselect name="sPubSelect"  outnum="1" routerKey="region" routerValue="<%=regionCode%>">

	<wtc:sql><%=str%> </wtc:sql>

</wtc:pubselect>

<wtc:array id="rows" scope="end"/>

	

<%

     //System.out.println("rows.length="+rows.length);

     //System.out.println("rows.retCode="+retCode);

     //System.out.println("rows.retMsg="+retMsg);

	if(retCode.equals("000000"))

	{	 

	   if(rows.length>0){

	          //System.out.println("rows.rows[0][0]="+rows[0][0]);

		 if (!rows[0][0].equals("0")){

		       //System.out.println("rows.rows[0][0]="+rows[0][0]);

		       retCode="111111";

		       retMsg="该参数集代码已经存在，请重新输入";

	            }	 

	      }   

     }else{

%>    

		<script language=javascript>	

			rdShowMessageDialog("系统错误，请重新校验!",0);

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
