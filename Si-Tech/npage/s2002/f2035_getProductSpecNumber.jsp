<%
  /*���Ӷ��ƶ�400���ź�����ֻ����Ӻ���������
   * ����: ���ⷴ��
�� * �汾: v1.0
�� * ����: 2009��5��5��
�� * ����: rendi
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	
	String productId = request.getParameter("productId");
	String retType = request.getParameter("retType");
	String productSpecNum = "";
	int i=0;
	String sqlStr="select productspec_number from dproductorderdet "
				+"where Product_Id='"+productId+"'";

	System.out.println("getProductSpecNumber.jsp sqlStr="+sqlStr);
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
%>
<wtc:pubselect name="sPubSelect" outnum="1" routerKey="region" routerValue="<%=regionCode%>">
		    <wtc:sql><%=sqlStr%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result" scope="end"/>
<%
	if(retCode.equals("000000")){
  		if(result.length>0){
  			productSpecNum=result[0][0];
  			productSpecNum.trim();
  		}
  		System.out.println("length="+result.length+",productSpecNum="+productSpecNum);
  	}
%>
	var response = new AJAXPacket();
	
	var retType = "";
	var retCode = "";
	var retMessage = "";
	var productSpecNum = "";
	
	retType = "<%=retType%>";
	retCode = "<%=retCode%>";
	retMessage = "<%=retMsg%>";
	productSpecNum = "<%=productSpecNum%>";
	response.data.add("retType",retType);
	response.data.add("retCode",retCode);
	response.data.add("retMessage",retMessage);
	response.data.add("productSpecNum",productSpecNum);
	core.ajax.receivePacket(response);

