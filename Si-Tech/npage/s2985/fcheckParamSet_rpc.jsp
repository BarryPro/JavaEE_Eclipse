 <%

   /******************************************

   * ����: У���Ʒ������

�� * �汾: v1.0

�� * ����: 2007/01/24

�� * ����: liubo

�� * ��Ȩ: sitech

     * �޸���ʷ

     * �޸�����:2009/05/14      �޸���:leimd      �޸�Ŀ��:��Ӧ������

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

		       retMsg="�ò����������Ѿ����ڣ�����������";

	            }	 

	      }   

     }else{

%>    

		<script language=javascript>	

			rdShowMessageDialog("ϵͳ����������У��!",0);

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
