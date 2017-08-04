<%
  /*
   * 功能: 预存有礼赠亲朋 d519 校验和获取用户信息
   * 版本: 1.8.2
   * 日期: 2011/4/25
   * 作者: huangrong
   * 版权: si-tech
   * update:
  */
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="import com.sitech.boss.pub.util.*"%>
<%
    String workNo = (String)session.getAttribute("workNo");
    String orgCode = (String) session.getAttribute("orgCode");
    String regionCode = orgCode.substring(0, 2);
		String loginPwd= (String)session.getAttribute("password");	
		String op_code = request.getParameter("op_code");		
		String login_accept = request.getParameter("login_accept");				
		String phoneNo = request.getParameter("phoneNo");
		String bindNo = request.getParameter("bindNo");

    String errCode = "";
    String errMsg = "";		
		String iChnSource="01";
		String retFee="";
		String retTerm="";
		String cust_name="";
		
		String cust_address="";
		String id_iccid="";
		String sm_code="";		
		String sm_name="";				
		String prepay_fee="";				
		String sqlStr1="select count(*) from dcustmsg a,dcustmsg b where substr(a.belong_code,1,2)=substr(b.belong_code,1,2) and a.phone_no='"+phoneNo+"'  and b.phone_no='"+bindNo+"'";
%>

		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="1" retcode="retCode1" retmsg="retMsg1">
		   <wtc:sql><%=sqlStr1%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="resultStr" scope="end"/>

<%
		errCode = retCode1;
		errMsg = retMsg1;
		if(errCode.equals("000000"))
	  {
	  		System.out.println("==================errCode==================="+errCode);
	  			System.out.println("==================resultStr.length==================="+resultStr.length);
	  	if(resultStr!=null && resultStr.length>0)
	  	{
	  			System.out.println("==================ddddddddddddddddddddddddddddddd==================="+resultStr[0][0]);
				if(resultStr[0][0].equals("0"))
				{	
					errCode="x";
					errMsg="新入网号码和输入的统一预存赠礼(包括预约)或赠送预存款营销案号码必须是同一个地市";
				}else
				{
%>
					<wtc:service name="sd519Qry" outnum="8" retmsg="retMsg2" retcode="retCode2" routerKey="region" routerValue="<%=regionCode%>">
						<wtc:param value="<%=login_accept%>" />
						<wtc:param value="<%=iChnSource%>" />	
						<wtc:param value="<%=op_code%>" />		
						<wtc:param value="<%=workNo%>" />			
						<wtc:param value="<%=loginPwd%>" />				
						<wtc:param value="<%=phoneNo%>" />					
						<wtc:param value="" />						
						<wtc:param value="<%=bindNo%>" />														
					</wtc:service>
					<wtc:array id="resultStr2" scope="end" />
<%
				  errCode = retCode2;
				  errMsg = retMsg2;
				  if(errCode.equals("000000"))
				  {
				  	if(resultStr2!=null && resultStr2.length>0)
				  	{
				  		  			System.out.println("==================ddddddddddddddddddddddddddddddd==================="+resultStr2.length);
				  		retFee=resultStr2[0][0];
				  		retTerm=resultStr2[0][1];
				  		cust_name=resultStr2[0][2];
				  		cust_address=resultStr2[0][3];
				  		id_iccid=resultStr2[0][4];
				  		sm_code=resultStr2[0][5];
				  		sm_name=resultStr2[0][6];
				  		prepay_fee=resultStr2[0][7];
				  						  		  			System.out.println("==================ddddddddddddddddddddddddddddddd==================="+retFee+"========================="+retTerm);
						}
					}
				}
			}
		}	
			  		System.out.println("==================errCode==================="+errCode);		
%>
			
var retFee="<%=retFee%>";
var retTerm="<%=retTerm%>";
var cust_name="<%=cust_name%>";
var cust_address="<%=cust_address%>";
var id_iccid="<%=id_iccid%>";
var sm_code="<%=sm_code%>";
var sm_name="<%=sm_name%>";
var prepay_fee="<%=prepay_fee%>";

var response = new AJAXPacket();
response.data.add("retFee","<%=retFee%>");
response.data.add("retTerm","<%=retTerm%>");
response.data.add("cust_name","<%=cust_name%>");
response.data.add("cust_address","<%=cust_address%>");
response.data.add("id_iccid","<%=id_iccid%>");
response.data.add("sm_code","<%=sm_code%>");
response.data.add("sm_name","<%=sm_name%>");
response.data.add("prepay_fee","<%=prepay_fee%>");

response.data.add("retCode","<%=errCode%>");
response.data.add("retMsg","<%=errMsg%>");
core.ajax.receivePacket(response);




