<%
  /*
   * ����: ȫ��ͨVIP�򳵷���
   * �汾: 2.0
   * ����: 2010/11/17
   * ����: weigp
   * ��Ȩ: si-tech
   * update:
   */
%>

<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String provinceVal = request.getParameter("provinceVal");
	String getCitySql = "select CITY_CODE,DEST_NAME from dbcustadm.SVIPDestCode where PROV_CODE = "+provinceVal;
	//String getCitySql = "select login_no,login_name from dloginmsg where rownum < 10";
	StringBuffer strBuffer = new java.lang.StringBuffer("{'citys':[");
	
%>

	<wtc:pubselect name="sPubSelect" outnum="2">
			<wtc:sql><%=getCitySql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result1" scope="end" />
<%
		if(result1.length > 0){
			for(int i=0;i<result1.length;i++){
				strBuffer.append("{'cityCode':'"+result1[i][0]+"','cityName':'"+result1[i][1]+"'},");
			}
		}
		if(strBuffer.toString().endsWith(",")){
			strBuffer.deleteCharAt(strBuffer.toString().length()-1);
		}
		strBuffer.append("]}");
%>
var response = new AJAXPacket();
response.data.add("str","<%=strBuffer%>");
core.ajax.receivePacket(response);
