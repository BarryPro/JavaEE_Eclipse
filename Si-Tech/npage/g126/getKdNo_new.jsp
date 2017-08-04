<%
/********************
 version v2.0
开发商: si-tech
*******************
xl 新增修改操作
增加对输入宽带号码 -->phone_no的判断 并将phone_no对应的contract_no输出

*/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
            //得到输入参数
    String contractNo= "";
    String phone_kd  = WtcUtil.repStr(request.getParameter("contractNo")," "); 
	
	String busy_type = WtcUtil.repStr(request.getParameter("busyType")," ");
   	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String sql_kd = "select phone_no from dbroadbandmsg where cfm_login = '?' ";
	String return_page = WtcUtil.repStr(request.getParameter("return_page")," ");
%>
	<wtc:pubselect name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode12" retmsg="retMsg12" outnum="1">
	<wtc:sql><%=sql_kd%></wtc:sql>
	<wtc:param value="<%=phone_kd%>"/>
	</wtc:pubselect>
	<wtc:array id="result12" scope="end" />
<%
	String phone_new="";
	 
	      
	if(result12!=null&&result12.length>0){
		        phone_new= (result12[0][0]).trim();
	 }else{
		      
	     %>
				 
					window.location.href="<%=return_page%>"; 
				 
		 <%
		 }

%>	
<%

    String retResult = "";   
    String sqlStr = "";
    String returnCode="";
		System.out.println("AAAAAAAAAAAAAAAAAaaaaaaaaaaaaa phone_kd is "+phone_kd+" and phone_new is "+phone_new);
		System.out.println("bbbbbbbbbbbbb"+busy_type);

	  String Pwd0 = "";
	  String Pwd1 = "";
	  String Pwd2 = "";
	  String Pwd3 = "";
	
	  String phone_out = "";
	  String contract_out = "";
		System.out.println("eeeeeeeeeeeeeeeeeeeeeee"+busy_type);
		
		//sqlStr = "select a.contract_passwd,substr(c.id_iccid,length(c.id_iccid)-3,4),to_char(a.contract_no) from dConMsg a,dCustMsg b,dCustDoc c,dConUserMsg d where a.contract_no=d.contract_no and d.id_no=b.id_no and b.cust_id=c.cust_id and  b.phone_no = '?' ";
		sqlStr = "select a.contract_passwd,substr(c.id_iccid,length(c.id_iccid)-3,4),to_char(b.id_no) from dConMsg a,dCustMsg b,dCustDoc c,dConUserMsg d where a.contract_no=d.contract_no and d.id_no=b.id_no and b.cust_id=c.cust_id and  b.phone_no = '?' ";
%>
 
<wtc:pubselect name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="20">
	<wtc:sql><%=sqlStr%></wtc:sql>
  <wtc:param value="<%=phone_new%>"/>
</wtc:pubselect>
	<wtc:array id="result1" scope="end" />

<%
	     String cust_passwd="";
	     String iccid="";
	      
	      	if(result1!=null&&result1.length>0){
		        cust_passwd= (result1[0][0]).trim();
	            iccid = (result1[0][1]).trim();
	            contract_out = (result1[0][2]).trim();
	      }else{
		     returnCode="999999";
		     retResult="没有此用户的相关资料!";
			 
	     }
	      
	      

			System.out.println("11111111111111cccccccccccccciccid is "+iccid);

					
			Pwd0 = cust_passwd;
			Pwd1 = "000000";
			Pwd2 = "001234";
			Pwd3 = "00"+iccid ;
			System.out.println("cccccccccccccc"+Pwd1);
			System.out.println("cccccccccccccc"+Pwd2);
			System.out.println("cccccccccccccc"+Pwd3);
 
		  if(1==Encrypt.checkpwd1(Pwd1,cust_passwd) || 1==Encrypt.checkpwd1(Pwd2,cust_passwd) || 1==Encrypt.checkpwd1(Pwd3,cust_passwd))
		  {
			retResult = "false" ;				
		  }else
		  {
		   retResult = "true" ;
  		  }
 

%>
var response = new AJAXPacket  ();
var retResult = "<%=retResult%>";
var phone_new = "<%=phone_new%>";
var contract_out = "<%=contract_out%>";
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("retResult",retResult);
response.data.add("phone_new",phone_new);
response.data.add("contract_out",contract_out);
core.ajax .receivePacket(response);
<%System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");%>


 
