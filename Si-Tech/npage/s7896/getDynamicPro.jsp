<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-14
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>


<%

 
  String regionCode = (String)session.getAttribute("regCode");
    
	String iccid = request.getParameter("iccid");
	System.out.println("-----------------iccid-------------------------"+iccid);
	String sm_code = request.getParameter("sm_code");
	System.out.println("-----------------sm_code-------------------------"+sm_code);
	String cust_id = request.getParameter("cust_id");
	System.out.println("-----------------cust_id-------------------------"+cust_id);
	String unit_id = request.getParameter("unit_id");
	System.out.println("-----------------unit_id-------------------------"+unit_id);
	String id_no = request.getParameter("id_no");
	System.out.println("-----------------id_no-------------------------"+id_no);
	
	String strArray ="var prodCompInfo;";	
		
    String returnCode = "000000";
    String retMessage = "查询成功！";
 
		 String getDyProSql = "select a.field_code,a.field_name,a.field_purpose,a.field_type,a.field_length,b.field_grp_no,c.field_grp_name,c.max_rows,c.min_rows,b.ctrl_info "+
		  										"from sUserFieldCode a, sUserTypeFieldRela b, sUserTypeGroup c "+
		 											"where a.busi_type = b.busi_type   and a.field_code = b.field_code and b.user_type = 'BY00'   and a.busi_type = c.busi_type   and b.user_type = c.user_type   and b.field_grp_no = c.field_grp_no "+
		  										"order by b.field_grp_no, b.field_order ";
		  										
  										
   System.out.println("getDyProSql|"+getDyProSql)  										;

%>   
		<wtc:pubselect name="sPubSelect" outnum="10" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=getDyProSql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_DyPro" scope="end"/>
	 	
<%

for(int iii=0;iii<result_DyPro.length;iii++){
				for(int jjj=0;jjj<result_DyPro[iii].length;jjj++){
					System.out.println("---------------------result_DyPro["+iii+"]["+jjj+"]=-----------------"+result_DyPro[iii][jjj]);
				}
		}

%>	 	
var result = "<%=iccid%>"+"<%=sm_code%>"+"<%=cust_id%>"+"<%=unit_id%>"+"<%=id_no%>";
prodCompInfo = new Array();
<% 
for(int iii=0;iii<result_DyPro.length;iii++){
%>
prodCompInfo[<%=iii%>] = new Array();
<%
				for(int jjj=0;jjj<result_DyPro[iii].length;jjj++){
%>		
			prodCompInfo[<%=iii%>][<%=jjj%>] = "<%=result_DyPro[iii][jjj]%>";	 
<%
		}
	}
%>

var response = new AJAXPacket();
response.data.add("returnCode","<%=returnCode%>");
response.data.add("retMessage","<%=retMessage%>");
response.data.add("prodCompInfo",prodCompInfo);

core.ajax.receivePacket(response);

