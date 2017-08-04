<%
/********************
 version v1
开发商 si-tech
create zhangyan@2012-09-07 9:36:13
********************/
%>

<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  String errCode = "0";
  String errMsg = "";  
  String pay_pre = ""; 	
  //String sqlStr = "";
	String payAccept = request.getParameter("PayAccept");
	String idNo = request.getParameter("IdNo");
  String phoneNo = request.getParameter("PhoneNo");
  String regionCode=(String)session.getAttribute("regCode");
  
	System.out.println("idNo= "+idNo);
  String yearMonth = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(new java.util.Date()); 

	String sqlStr = "select count(*) from dawardphone where phone_no='"+phoneNo+"' and pay_accept="+payAccept;
	
	
			  String[] paramIn = new String[2]; 
    		paramIn[0] = "select count(*) from dawardphone where phone_no=:phoneNo and pay_accept=:payAccept ";
    		paramIn[1] = "phoneNo="+phoneNo+",payAccept="+payAccept;		
		System.out.println(sqlStr);
	%>




	  <wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramIn[0]%>" />
			<wtc:param value="<%=paramIn[1]%>" />
		</wtc:service>
		<wtc:array id="result" scope="end"/>
		
	<%	
    System.out.println(code1);
    
    if(!code1.equals("000000"))
      {
     
          errCode="126001";
          errMsg="该笔缴费参与抽奖活动，不允许办理!";
      }
  
  else
  {
	  sqlStr = "select nvl(sum(prepay_fee),0.00) from wPay"+yearMonth+" where login_accept="+payAccept+" and id_no='"+idNo+"' and back_flag='0'";
			
    		paramIn[0] = "select nvl(sum(prepay_fee),0.00) from wPay"+yearMonth+"  where login_accept=:payAccept and id_no=':idNo' and back_flag='0'";
    		paramIn[1] = "payAccept"+payAccept+",idNo"+idNo;
	  %>

			
			
     <wtc:pubselect name="TlsPubSelBoss" outnum="1" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 	<wtc:param value="<%=paraIn[0]%>"/>
        <wtc:param value="<%=paraIn[1]%>"/> 
     </wtc:service>
	 <wtc:array id="result1" scope="end"/>
			
			
	  <%
	  
	
			System.out.println("-----------errCode------------"+sqlStr);
    errCode = code2;
    errMsg = msg2;
	
	  if(code2.equals("0")||code2.equals("000000"))
	  {
	  	System.out.println("-----------errCode------------"+result1[0][0]);
      pay_pre=(result1[0][0]).trim();	  
	  }
}
	String rpcPage = "qryPayPrepay";
	
%>

var rpcPage="<%=rpcPage%>";
var pay_pre="<%=pay_pre%>";

var response = new AJAXPacket();
response.guid		= '<%= request.getParameter("guid") %>';

response.data.add("rpc_page",rpcPage); 
response.data.add("retCode","<%=errCode%>");
response.data.add("retMsg","<%=errMsg%>"); 

response.data.add("pay_pre",                     pay_pre             );

core.ajax.receivePacket(response);
