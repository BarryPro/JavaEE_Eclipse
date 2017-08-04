<%
/********************
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟(hejwa) 2015-4-22 16:25:30-------------------
 
 -------------------------后台人员：haoyy--------------------------------------------
********************/
%>

<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
	var retArray = new Array();//定义返回数组
<%

	String id_no     = WtcUtil.repNull(request.getParameter("bizcode"));
	String phone_no    = WtcUtil.repNull(request.getParameter("phoneNo"));
 
  String regionCode = (String)session.getAttribute("regCode");
  
	String retCode    = "";
	String retMsg     = "";
	
 String sql = " SELECT count(*) FROM dgrpnomebmsg a,dgrpusermsg b "+
							"	where a.id_no=b.id_no "+
							"	and b.sm_code='JT' "+
							"	and a.member_no='"+phone_no+"' "+
						  "      AND b.id_no=to_number('"+id_no+"')";
						  
	String param1 = "phone_no_in="+phone_no;
	String param2 = "id_no_in="+id_no;
	String count_result = "";
	
	
	String sq2 = " SELECT c.offer_id,c.offer_name,c.offer_comments FROM dgrpnomebmsg a,dgrpusermsg b,product_offer c "+
								" where a.id_no=b.id_no "+
								" and b.sm_code='JT' "+
				        " AND a.mode_code=c.offer_id "+
								" and a.member_no='"+phone_no+"' "+
				        " AND b.id_no='"+id_no+"' ";
				        
	String q_offer_id = "";
	String q_offer_name = "";
	String q_offer_comments = "";
	
System.out.println("----hejwa-------------sql------------------>"+sql);	
System.out.println("----hejwa-------------sq2------------------>"+sq2);	

System.out.println("----hejwa-------------param1------------------>"+param1);	
System.out.println("----hejwa-------------param2------------------>"+param2);	

					        
try{
%>
  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sql%>" />
	</wtc:service>
	<wtc:array id="result_t" scope="end"/>
		
		
	<wtc:service name="TlsPubSelCrm" outnum="3" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=sq2%>" />
	</wtc:service>
	<wtc:array id="result_t1" scope="end"/>	
		
		
<%
	retCode = code;
	retMsg = msg;
	
	if(result_t.length>0){
		count_result = result_t[0][0];
	}
	System.out.println("----hejwa-------------count_result------------------>"+count_result);	
	
	if(result_t1.length>0){
			q_offer_id = result_t1[0][0];
			q_offer_name = result_t1[0][1];
			q_offer_comments = result_t1[0][2];
	}
 
	System.out.println("----hejwa-------------q_offer_id------------------------>"+q_offer_id);	
	System.out.println("----hejwa-------------q_offer_name---------------------->"+q_offer_name);	
	System.out.println("----hejwa-------------q_offer_comments------------------>"+q_offer_comments);	
	
}catch(Exception ex){
	retCode = "404040";
	retMsg = "调用服务TlsPubSelCrm出错，请联系管理员";
}

%> 	
var response = new AJAXPacket();
response.data.add("code","<%=retCode%>");
response.data.add("msg","<%=retMsg%>");
response.data.add("count_result","<%=count_result%>");

response.data.add("q_offer_id","<%=q_offer_id%>");
response.data.add("q_offer_name","<%=q_offer_name%>");
response.data.add("q_offer_comments","<%=q_offer_comments%>");

core.ajax.receivePacket(response);
