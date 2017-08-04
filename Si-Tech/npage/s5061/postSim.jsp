   
<%
/********************
 version v2.0
 开发商 si-tech
 update hejw@2009-2-10
********************/
%>

<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>

<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.*;"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
System.out.println("----------------------here---------------postSim.jsp----------------");
String post_address = "";
String post_zip  = "";
String fax_no  = "";
String mail_address   = "";
String post_name   = "";
String cust_name   = "";
String id_iccid ="";
String id_address="";
String sm_name="";
String retCode = "000000";
String retMsg = "";
String opType = request.getParameter("r_cus");
String SqlStr1 = "";
String SqlStr2 = "";
String[][]psot = new String [][]{};
String phoneNo = request.getParameter("phoneNo");
String strPostFlag = request.getParameter("postFlag");
String password = WtcUtil.repNull(request.getParameter("pssword"));


	String[][] temfavStr=(String[][])session.getAttribute("favInfo");
	String regionCode = (String)session.getAttribute("regCode");
	
  String[] favStr=new String[temfavStr.length];
  
  for(int i=0;i<favStr.length;i++)
   	favStr[i]=temfavStr[i][0].trim();
  boolean pwrf=false;
  if(WtcUtil.haveStr(favStr,"a272"))
		pwrf=true;

	System.out.println("phoneNO ===: ["+ phoneNo+"]");
	System.out.println("password ==: ["+ password+"]");
	System.out.println("opType === : ["+ opType+"]");
	System.out.println("strPostFlag === : ["+ strPostFlag+"]");

	SqlStr1 = "select user_passwd from dcustmsg where phone_no = :phoneNo1 ";
	
	String [] paraIn = new String[2];
	paraIn[0] = SqlStr1;
	paraIn[1] = "phoneNo1="+phoneNo ;
%>

	<wtc:service name="TlsPubSelCrm" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=paraIn[0]%>"/>
		<wtc:param value="<%=paraIn[1]%>"/>
	</wtc:service>
	<wtc:array id="result_t1" scope="end"/>

<%  
	if(code1.equals("000000"))
	{
		psot = result_t1; 
		System.out.println("psot[0][0] ==: ["+ psot[0][0]+"]");
		if((0==Encrypt.checkpwd1(password,psot[0][0])) && !pwrf)
		{
			retCode = "100002";
			retMsg = "用户密码错误！";
		}
		else
		{
			if(!opType.equals("0"))
			{
				SqlStr2 = "select a.post_address,a.POST_CODE,a.fax_no,a.mail_address1,a.post_name,c.cust_name,c.id_iccid,c.id_address,d.sm_name from dCustPostPrtBill a, dcustmsg b, dCustDoc c ,ssmcode d where a.id_no = b.id_no and  b.cust_id = c.cust_id  and  b.phone_no =:phoneNo2  and substr(b.belong_code,1,2)=d.region_code and b.sm_code=d.sm_code and a.tran_type = '1' and a.post_type =:strPostFlag1";
			 	retMsg = "用户邮寄帐单资料不存在，请先登记!";
			 	retMsg = "用户邮寄帐单资料不存在，请先登记!";
				paraIn[0] = SqlStr2;
				paraIn[1] = "phoneNo2="+phoneNo+",strPostFlag1="+strPostFlag;
			}else
			{
			 	SqlStr2 = "select '','','','','',c.cust_name ,c.id_iccid ,c.id_address, d.sm_name" +
		                 "  from dcustmsg b, dCustDoc c ,ssmcode d where  b.cust_id = c.cust_id  and  b.phone_no =:phoneNo3 and substr(b.belong_code,1,2)=d.region_code and b.sm_code=d.sm_code";
			 	retMsg="用户资料不存在!";
				paraIn[0] = SqlStr2;
				paraIn[1] = "phoneNo3="+phoneNo;
			}
			System.out.println(SqlStr1);
			//arr1 = co1.spubqry32("9", SqlStr1);	
%>

		<wtc:service name="TlsPubSelCrm" outnum="9" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paraIn[0]%>"/>
			<wtc:param value="<%=paraIn[1]%>"/>
		</wtc:service>
		<wtc:array id="result_t2" scope="end"/>

<%			
			if(code2.equals("000000"))
			{
				psot = result_t2; 
			}
			
			if(psot.length == 1){
				post_address = psot[0][0];
				post_zip = psot[0][1];
				fax_no = psot[0][2];
				mail_address = psot[0][3];
				post_name = psot[0][4];
				cust_name = psot[0][5];
				id_iccid = psot[0][6];
				id_address = psot[0][7];
				sm_name = psot[0][8];
				System.out.println("----------post_address----------"+post_address);
				System.out.println("----------post_zip----------"+post_zip);
				System.out.println("----------fax_no----------"+fax_no);
				System.out.println("----------mail_address----------"+mail_address);
				System.out.println("----------post_name----------"+post_name);
				System.out.println("----------cust_name----------"+cust_name);
				System.out.println("----------id_iccid----------"+id_iccid);
				System.out.println("----------id_address----------"+id_address);
				System.out.println("----------sm_name----------"+sm_name);
				
			}else{
				retCode = "100001";
			}
		}
	}else
	{
		retCode = "100003";
		retMsg = "资料查询失败!";
	}

	System.out.println("----------------------OK--------------------");
String rpcPage = "postSim";

%>
var response = new AJAXPacket();

var retCode = "<%=retCode%>";
var retMsg = "<%=retMsg%>";
var post_address = "<%=post_address%>";
var post_zip = "<%=post_zip%>";
var fax_no = "<%=fax_no%>";
var mail_address = "<%=mail_address%>";
var post_name = "<%=post_name%>";
var cust_name = "<%=cust_name%>";
var id_iccid = "<%=id_iccid%>";
var id_address = "<%=id_address%>";
var sm_name = "<%=sm_name%>";

var rpcPage = "<%=rpcPage%>";

response.data.add("rpc_page",rpcPage); 
response.data.add("retCode",retCode); 
response.data.add("retMsg",retMsg); 
response.data.add("post_address",post_address); 
response.data.add("post_zip",post_zip); 
response.data.add("fax_no",fax_no); 
response.data.add("mail_address",mail_address); 
response.data.add("post_name",post_name); 
response.data.add("cust_name",cust_name); 
response.data.add("id_iccid",id_iccid); 
response.data.add("id_address",id_address); 
response.data.add("sm_name",sm_name); 
core.ajax.receivePacket(response);
