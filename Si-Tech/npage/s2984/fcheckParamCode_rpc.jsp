 <%
   /******************************************
   * ����: У���Ʒ������
�� * �汾: v1.0
�� * ����: 2007/01/24
�� * ����: liubo
�� * ��Ȩ: sitech
     * �޸���ʷ
     * �޸�����      �޸���      �޸�Ŀ��
     2009/11/09		 niuhr		 �°����
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
		       retMsg="��ѯ����Ϊ�Ѵ��ڲ������룬����������";
			}	 
		}   
	}else{
%>    
		<script language=javascript>	
			rdShowMessageDialog("ϵͳ����������У��!");
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