<%
/********************
 version v2.0
������: si-tech
********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
            //�õ��������
    String contractNo = WtcUtil.repStr(request.getParameter("contractNo")," ");
    String busy_type = WtcUtil.repStr(request.getParameter("busyType")," ");
   	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
    String retResult = "";   
    String sqlStr = "";
    String returnCode="";
		System.out.println("aaaaaaaaaaaaa"+contractNo);
		System.out.println("bbbbbbbbbbbbb"+busy_type);

    String Pwd0 = "";
	  String Pwd1 = "";
	  String Pwd2 = "";
	  String Pwd3 = "";
	
				
		System.out.println("eeeeeeeeeeeeeeeeeeeeeee"+busy_type);
		
		sqlStr = "select a.contract_passwd,substr(c.id_iccid,length(c.id_iccid)-3,4) from dConMsg a,dCustMsg b,dCustDoc c,dConUserMsg d where a.contract_no=d.contract_no and d.id_no=b.id_no and b.cust_id=c.cust_id and a.contract_no= ?";
%>

<wtc:pubselect name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="20">
	<wtc:sql><%=sqlStr%></wtc:sql>
  <wtc:param value="<%=contractNo%>"/>
</wtc:pubselect>
	<wtc:array id="result1" scope="end" />

<%
	     String cust_passwd="";
	     String iccid="";
	      
	      	if(result1!=null&&result1.length>0){
		        cust_passwd= (result1[0][0]).trim();
	            iccid = (result1[0][1]).trim();
	        
	
	      }else{
		     returnCode="999999";
		     retResult="û�д��û����������!";
	     }
	      
	      

			System.out.println("cccccccccccccc"+cust_passwd);

					
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
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("retResult",retResult);
core.ajax .receivePacket(response);
<%System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");%>


 
