<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%

	      	String regionCode= (String)session.getAttribute("regCode");
	      	String simtypesz="no";
	      	String phoneno = request.getParameter("phoneno");
	      	String seseq = request.getParameter("seseq");
	      	String returncode ="000000"; 
	      	String returnmsg ="查询成功";
 	
       
       	  String[] inParamsss = new String[2];
					inParamsss[0] = " select a.offer_id from product_offer_instance a,product_offer_attr b,dcustmsg c where a.serv_id=c.id_no and a.offer_id=b.offer_id and a.offer_id=b.offer_id and b.offer_attr_seq=:seseq and c.phone_no=:phonenos ";
					inParamsss[1] = "seseq="+seseq+",phonenos="+phoneno;
%>					
       	  <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1dd" retmsg="retMsg1dd" outnum="1">			
					<wtc:param value="<%=inParamsss[0]%>"/>
					<wtc:param value="<%=inParamsss[1]%>"/>	
					</wtc:service>	
       	   <wtc:array id="simstypes" scope="end" />
<%
System.out.println(seseq+"---"+phoneno+"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"+inParamsss[0]);
if(simstypes.length>0) {
	returncode="888888";
	returnmsg="尊敬的客户，您可自由退订该主资费中底线消费包含的数据业务，但自行退订后底线消费仍然正常收取，详询10086";
}
%>

var response = new AJAXPacket();
response.data.add("errorCode","000000");
response.data.add("errorMsg","成功");
response.data.add("returncode","<%=returncode%>");
response.data.add("returnmsg","<%=returnmsg%>");
core.ajax.receivePacket(response);