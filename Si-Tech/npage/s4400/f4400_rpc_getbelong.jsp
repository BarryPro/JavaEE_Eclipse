<%
/********************
 * version v2.0
 * 功能：获取新主资费 对应的备注和主资费名称
 * 开发商: si-tech
 * update by huangrong @ 2011-03-09
 ********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="import com.sitech.boss.pub.util.*"%>
<%
	String errCode = "";
	String errMsg = "";  
	String attr_code = "";
	String run_code = "";
	String result_long ="";
	String orgCode = (String) session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0, 2);
	String phoneNo = request.getParameter("phoneNo");
	String sqlStr2 = " select substr(t.attr_code,3,2),substr(t.run_code,2,1) "
		+" from dcustmsg t,dgrpbigusermsg t1 , dcustdoc t2 "
		+" where t.cust_id = t2.cust_id and t.phone_no=t1.phone_no and  t.phone_no='"+phoneNo+"'";
		
/*	
	string card_type=request.getParameter("card_type");
	string cardID=request.getParameter("cardID");

00>>	身份证
01>>VIP卡
	if ( card_type.equals("00") )
	{
		sqlStr2+=" and card_no ";
	}
	*/
%>
    <wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="2" >
    	<wtc:param value="<%=sqlStr2%>"/>
    </wtc:service>
    <wtc:array id="resultStr" scope="end"/>
<%
  errCode = retCode;
  errMsg = retMsg;
  System.out.println("~~~~resultStr.length=="+resultStr.length);
  if(errCode.equals("000000"))
  {
  	if(resultStr!=null && resultStr.length>0)
  	{
  	  	attr_code=resultStr[0][0];
    	run_code=resultStr[0][1];
    	result_long=resultStr.length+"";
  	}
  	else 
  	{
    	/*本省号段判断    	*/
		String sqlhlr="select count(*)  "
			+	"from shlrcode "
			+	"where phoneno_head = substr('"+phoneNo+"',1,7) ";
		%>	
	    <wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" 
	    	retcode="retCode1" retmsg="retMsg1" outnum="2" >
	    	<wtc:param value="<%=sqlhlr%>"/>
	    </wtc:service>
	    <wtc:array id="resultStr1" scope="end"/>    	
    	<%
		errCode = retCode1;
		errMsg = retMsg1;
    	if ( resultStr1!=null && resultStr1.length>0 )
    	{
    		result_long=resultStr1[0][0];
    	}
  	}
  }
%>

var attr_code="<%=attr_code%>";
var run_code="<%=run_code%>";
var result_long="<%=result_long%>";

var response = new AJAXPacket();
response.data.add("retCode","<%=errCode%>");
response.data.add("retMsg","<%=errMsg%>"); 
response.data.add("attr_code",attr_code);
response.data.add("run_code",run_code);
response.data.add("result_long",result_long);
core.ajax.receivePacket(response);



