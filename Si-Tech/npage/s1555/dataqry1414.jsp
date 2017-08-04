   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-23
********************/
%>
      
<%@ page contentType= "text/html;charset=gb2312" %>
<%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
            //得到输入参数
String phoneNo =request.getParameter("phoneNo");
            String type = request.getParameter("type");
          
            
			System.out.println("---------------phoneNo------------------"+phoneNo);
			System.out.println("---------------type---------------------"+type);

            String[][] result1 = new String[][]{};
            
			String retResult = "";
            String sqlStr = "";
            String Pwd0 = "";		
			String regionCode = (String)session.getAttribute("regCode");
			sqlStr = "select id_iccid,id_address,cust_name from dCustDoc a,dcustmsg b  where a.cust_id=b.cust_id and  phone_no='" + phoneNo + "'";
            //retArray1 = callView1.sPubSelect("3",sqlStr);
					%>
					
		<wtc:pubselect name="sPubSelect" outnum="3" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>					
					
					<%
            result1 = result_t;
            String id_iccid = (result1[0][0]).trim();
			String id_address = (result1[0][1]).trim();
			String cust_name = (result1[0][2]).trim();
           
				    
%>
var response = new AJAXPacket();
var retResult = "<%=retResult%>";
var type = "<%=type%>";
var id_iccid = "<%=id_iccid%>";
var id_address = "<%=id_address%>";
var cust_name = "<%=cust_name%>";
response.data.add("id_iccid",id_iccid);
response.data.add("id_address",id_address);
response.data.add("cust_name",cust_name);
response.data.add("type",type);
response.data.add("retResult",retResult);
core.ajax.receivePacket(response);
<%System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");%>


 