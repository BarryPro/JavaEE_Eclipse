<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String mail_address1   = "";
	String mail_address2   = "";
	String mail_address3   = "";
	String cust_iccid   = "";
	String cust_name   = "";
	String has_paper_bill = "";
	String retCode = "";
	String retMsg = "";
	String opType = request.getParameter("r_cus");
	String[][]psot = new String [][]{};
	String phoneNo = request.getParameter("phoneNo");
	String regionCode = (String)session.getAttribute("regCode");
	System.out.println("phoneNO ===: "+ phoneNo);
	System.out.println("opType ===: "+ opType);
	
	String SqlStr1 = "select b.cust_name,b.ID_ICCID,nvl(c.mail_ADDRESS1,''),nvl(c.mail_ADDRESS2,''),nvl(c.mail_address3,'') FROM dcustmsg a, dCustDoc b, dCustPostPrtBill c WHERE b.cust_id = a.cust_id and a.id_no = c.id_no(+)" +
	          " and a.phone_no ='"+phoneNo+"' and c.tran_type(+) ='1'and c.post_type(+) = '2'";
	retMsg = "用户邮寄帐单资料不存在，请先登记!";

	System.out.println(SqlStr1);
	//ArrayList arr1 = co1.spubqry32("5", SqlStr1);	
	%>
	
		<wtc:pubselect name="sPubSelect" outnum="5" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=SqlStr1%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>	
	
	<%
	if(result_t.length>0)
	{
		psot = result_t; 
	}
	System.out.println("00000");
	if(psot.length == 1){
	retCode = "000000";
		cust_name = psot[0][0];
		cust_iccid = psot[0][1];
		mail_address1 = psot[0][2];
		mail_address2 = psot[0][3];
		mail_address3 = psot[0][4];
	}else{
		retCode = "100001";
	}

	/*判断用户是否受理邮寄帐单*/	

	String SqlStr2 = "select count(*) FROM dcustmsg a, dCustPostPrtBill c WHERE a.id_no = c.id_no " +
	          " and a.phone_no ='"+phoneNo+"' and c.tran_type ='1'and c.post_type = '1'";
	System.out.println(SqlStr1);
	//arr1 = co1.spubqry32("1", SqlStr1);	
	%>
	
		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=SqlStr2%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t1" scope="end"/>	
	
	<%
	if(result_t1.length> 0)
	{
		psot = result_t1; 
	}
	System.out.println("00000");
	if(psot.length == 1){
		has_paper_bill = psot[0][0];
	}else{
		retCode = "100001";
	}
	
	System.out.println("has_paper_bill="+has_paper_bill);
	String rpcPage = "postSim";

%>
var response = new AJAXPacket();

var retCode = "<%=retCode%>";
var retMsg = "<%=retMsg%>";
var mail_address1 = "<%=mail_address1%>";
var mail_address2 = "<%=mail_address2%>";
var mail_address3 = "<%=mail_address3%>";
var cust_iccid = "<%=cust_iccid%>";
var cust_name = "<%=cust_name%>";
var has_paper_bill = "<%=has_paper_bill%>";

var rpcPage = "<%=rpcPage%>";

response.data.add("rpc_page",rpcPage); 
response.data.add("retCode",retCode); 
response.data.add("retMsg",retMsg); 
response.data.add("cust_name",cust_name);
response.data.add("cust_iccid",cust_iccid); 
response.data.add("mail_address1",mail_address1);
response.data.add("mail_address2",mail_address2);
response.data.add("mail_address3",mail_address3);
response.data.add("has_paper_bill",has_paper_bill);
core.ajax.receivePacket(response);
