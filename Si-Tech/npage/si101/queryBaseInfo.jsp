<%@ page contentType= "text/html;charset=gb2312" %>
 <%@ page import="java.math.BigDecimal"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String loginPwd  = (String)session.getAttribute("password");//登陆密码
		String groupId  = (String)session.getAttribute("groupId");//diling add @2012/8/24
		String opCode = request.getParameter("opCode");
		String phone_type11 = request.getParameter("phone_type");
		String method = request.getParameter("method");
		String brand_code = request.getParameter("phone_brand");
		String type_code = request.getParameter("type_code");
		String sale_code = request.getParameter("sale_code");
		String mode_code = request.getParameter("mode_code");
%>
		<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
<%
	//通过手机品牌获得手机型号
	if(method != null && method != "" && method.equals("phone_typess")) {
     //lj. 绑定参数
  	 //String sql_select1 = "select unique a.type_code,trim(b.res_name), b.brand_code from dphoneSaleCode a,schnrescode_chnterm b  where a.region_code=:region_code and  a.type_code=b.res_code and a.brand_code=b.brand_code  and a.sale_type=:sale_type and a.valid_flag='Y' and b.brand_code=:brand_code";
	 	 //String srv_params1 = "region_code=" + regionCode + ",sale_type=" + sale_type + ",brand_code=" + brand_code;
	 	 String sql_select1 ="SELECT res_code,res_name FROM DBCHNTERM.SCHNRESCODE t WHERE  brand_code=:brand_codes AND product_type='Y' ";
	 	 String srv_params1 ="brand_codes=" + brand_code;
	 	 
	 	 System.out.println(sql_select1+"---"+srv_params1);
%>
		<wtc:service name="TlsPubSelCrm" outnum="3" retcode="retCode1" retmsg="retMsg1">
			<wtc:param value="<%=sql_select1%>"/>
			<wtc:param value="<%=srv_params1%>"/>
		</wtc:service>
		<wtc:array id="phone_type" scope="end" />

		var array = [];
<%
	  if(retCode1.equals("000000")) {
			//封装js数组
			for(int i=0;i<phone_type.length;i++) 
			{
		%>
					var type = {};
					type.value = '<%=phone_type[i][0]%>';
				  type.name = '<%=phone_type[i][1]%>';
				  array.push(type);
		<%
			}
	 }	
%>
		var response = new AJAXPacket();
		response.data.add("retcode","<%= retCode1 %>");
		response.data.add("retmsg","<%= retMsg1 %>");
		response.data.add("result",array);
		core.ajax.receivePacket(response);
<%
  }
	//通过营销方案
  else if(method != null && method != "" && method.equals("yingxiaoan")) {
    String sql_select3 = "SELECT sale_persent FROM DBCHNTERM.Dchnresnewsaleact WHERE RES_CODE = (SELECT DECODE(COUNT(*), 0, '00000000', '"+phone_type11+"')  FROM DBCHNTERM.Dchnresnewsaleact WHERE RES_CODE =:res_codes) ";
    String srv_params3 = "res_codes="+phone_type11;

%>
		<wtc:service name="TlsPubSelCrm" outnum="2" retcode="retCode2" retmsg="retMsg2">
			<wtc:param value="<%=sql_select3%>"/>
			<wtc:param value="<%=srv_params3%>"/>
		</wtc:service>
		<wtc:array id="sale_ways" scope="end" />
<% 	 
String youhuibili="";
	   if(retCode2.equals("000000") && sale_ways.length>0) {
         youhuibili = sale_ways[0][0];
			}
			System.out.println("youhuibili------------------------"+youhuibili);
%>
		var response = new AJAXPacket();
		response.data.add("retcode","<%= retCode2 %>");
		response.data.add("retmsg","<%= retMsg2 %>");
		response.data.add("youhuibili","<%=youhuibili%>");
		core.ajax.receivePacket(response);
<%
  }

  %>