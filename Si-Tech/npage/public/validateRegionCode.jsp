<%
  /*
   * ����: �жϹ��źͰ�������Ƿ���ͬһ����
   * �汾: 2.0
   * ����: 2010/09/01
   * ����: weigp
   * ��Ȩ: si-tech
   * update:
   */
%>

<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String inPhone = request.getParameter("inPhone");
	String regioncode = (String)session.getAttribute("regCode");
	String sqlstr = "select substr(belong_code,0,2) from dcustmsg where phone_no = '"+inPhone+"'";
	String flag = "false";	//false ʱΪû�в�ѯ����¼ �����źͺ��벻��ͬһ����  true ��ѯ����¼ ˵�����źͺ�����ͬһ����
%>
	<wtc:pubselect name="sPubSelect" outnum="1">
			<wtc:sql><%=sqlstr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1" scope="end" />
<%
		if(result1.length > 0){
			String regCode = result1[0][0];
			if(regCode != null && !"".equals(regCode) && regioncode.equals(regCode)){
				flag = "true";
			}
		}
%>
var response = new AJAXPacket();
response.data.add("flag","<%=flag%>");
core.ajax.receivePacket(response);

