<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="com.sitech.crmpd.kf.ejb.client.KFEjbClient, java.util.*"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%
	String phone_no = request.getParameter("phone_no");
	
	String cust_name = "";
	String city_code = "";
	String region_code = "";
%>
<wtc:service name="sKFComering" outnum="7">
	<wtc:param value="<%=phone_no%>"/>
</wtc:service>
<wtc:array id="rows" scope="end"/>
<%
  if(retCode.equals("000000"))
  {
		cust_name = rows[0][0];
		region_code = rows[0][5];
  }
  
	String[][] city_to_code ={
		{"01","0451"},
		{"02","0467"},
		{"03","0464"},
		{"04","0469"},
		{"05","0468"},
		{"06","0454"},
		{"07","0453"},
		{"08","0452"},
		{"09","0457"},
		{"10","0455"},
		{"11","0456"},
		{"12","0458"},
		{"13","0459"},
		{"15","888"},
		{"","00"}
		};
		for(int i=0;i<city_to_code.length;i++){
			if(city_to_code[i][0].equals(region_code)){
					city_code = city_to_code[i][1];
					break;
			}
		}
%>
	var response = new AJAXPacket();
	response.data.add("cust_name","<%=cust_name%>");
	response.data.add("city_code","<%=city_code%>");
	core.ajax.receivePacket(response);