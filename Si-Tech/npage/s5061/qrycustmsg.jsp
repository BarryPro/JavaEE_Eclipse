<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.util.*;"%>
<%

String phoneNo = WtcUtil.repNull(request.getParameter("Phoneno"));
System.out.println("ssssssssssssss1ssssssssss phoneNo "+phoneNo);
String regionCode = (String)session.getAttribute("regCode");
String sq="select chinasim_flag from shlrcode where phoneno_head= substr('"+phoneNo+"',1,7)";
String sql="select op_time from dconremsg a,dcustmsg b where a.id_no=b.id_no and  b.phone_no='"+phoneNo+"'";
String sq2="select b.cust_id,b.cust_name,a.sm_code,b.id_iccid,b.cust_address from dcustmsg a,dcustdoc b  where a.phone_no='"+phoneNo+"' and                  a.cust_id=b.cust_id";
String sq3="select b.sm_name from dcustmsg a,ssmcode b  where a.phone_no='"+phoneNo+"' and a.sm_code=b.sm_code and substr(a.belong_code,1,2)=b.region_code";
%>

	<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sq%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="cussidArr" scope="end"/>
	 	
	<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="num" scope="end"/>

	<wtc:pubselect name="sPubSelect" outnum="5" retmsg="msg3" retcode="code3" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sq2%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="num1" scope="end"/>
	 	
	 <wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg4" retcode="code4" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sq3%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="num2" scope="end"/>
<%

//SPubCallSvrImpl co = new SPubCallSvrImpl();
//ArrayList cussidArr=co.sPubSelect("1",sq);
String cussidStr="";
if(cussidArr.length>0)
  cussidStr=cussidArr[0][0];
  System.out.println("aaaaaaaaaaaaa2aaaaaaaaa cussidStr "+cussidStr);


//SPubCallSvrImpl col = new SPubCallSvrImpl();
//ArrayList num = col.sPubSelect("1",sql);
String custnum = "";
if(num.length>0)
   custnum = num[0][0];
   System.out.println("aaaaaaaaaa3aaaaaaaaaaaa custnum "+custnum);


//SPubCallSvrImpl co2 = new SPubCallSvrImpl();
//ArrayList num1 = co2.sPubSelect("5",sq2);
String idno = "";
String custname="";
String smcode=""; 
String iccid = "";
String custaddress="";


if(num1.length>0)
   idno = num1[0][0];
   custname = num1[0][1];
   smcode = num1[0][2];
   iccid = num1[0][3];
   custaddress = num1[0][4];
   
   //System.out.println("aaaaaaaaaaaa7aaaaaaaaaa idno "+idno);
   //System.out.println("aaaaaaaaaaaa8aaaaaaaaaa custname "+custname);
  //System.out.println("aaaaaaaaaaaa4aaaaaaaaaa iccid "+iccid);
	//System.out.println("\naaaaaaaaa5aaaaaaaaaaaaa custaddress ="+custaddress);
	//System.out.println("\naaaaaaaaaa6aaaaaaaaaaaa smcode "+smcode);


//SPubCallSvrImpl co3 = new SPubCallSvrImpl();
//ArrayList num2 = co3.sPubSelect("1",sq3);
String smname=""; 
if(num2.length>0)
   smname = num2[0][0];
  System.out.println("\nbbbbbbbbb9bbbbbbbbb smname "+smname);
  
  System.out.println("----------------OK----------------");
%>

var response = new AJAXPacket();
var cussid = "<%=cussidStr%>";
var custnumber = "<%=custnum%>";
var idno = "<%=idno%>";
var custname = "<%=custname%>";
var smcode = "<%=smcode%>";
var smname = "<%=smname%>";
response.data.add("cussid",cussid); 
response.data.add("custnumber",custnumber); 
response.data.add("idno",idno);
response.data.add("custname",custname);
response.data.add("smcode",smcode);
response.data.add("smname",smname);
response.data.add("iccid","<%=iccid%>");
response.data.add("custaddress","<%=custaddress%>");
core.ajax.receivePacket(response);			