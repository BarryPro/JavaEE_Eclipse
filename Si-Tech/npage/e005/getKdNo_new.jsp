<%
/********************
 version v2.0
������: si-tech
*******************
xl �����޸Ĳ���
���Ӷ����������� -->phone_no���ж� ����phone_no��Ӧ��contract_no���

*/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%
    int i_dp=0;
			 //�õ��������
    String contractNo= "";
    String phone_kd  = WtcUtil.repStr(request.getParameter("contractNo")," "); 
	
	String busy_type = WtcUtil.repStr(request.getParameter("busyType")," ");
   	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String sql_kd = "select a.phone_no,sm_code from dbroadbandmsg a,dcustmsg b where cfm_login = '?' and a.phone_no = b.phone_no ";
	String return_page = WtcUtil.repStr(request.getParameter("return_page")," ");
	System.out.println("TAAAAAAAAAAAAAAAAATTTTTTTTTTTTTTT sql_kd is "+sql_kd+" and phone_kd is "+phone_kd);
	String s_sm_code="";
%>
	<wtc:pubselect name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode12" retmsg="retMsg12" outnum="2">
	<wtc:sql><%=sql_kd%></wtc:sql>
	<wtc:param value="<%=phone_kd%>"/>
	</wtc:pubselect>
	<wtc:array id="result12" scope="end" />
<%
	String phone_new="";
	 
	      
	if(result12!=null&&result12.length>0){
		        phone_new= (result12[0][0]).trim();
				s_sm_code= (result12[0][1]).trim();
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
		System.out.println("aaaaaaaaaaaaacontractNo is "+contractNo+" and phone_new is "+phone_new);
		System.out.println("bbbbbbbbbbbbb"+busy_type);

    String Pwd0 = "";
	  String Pwd1 = "";
	  String Pwd2 = "";
	  String Pwd3 = "";
	
	  String phone_out = "";
	  String contract_out = "";
		System.out.println("eeeeeeeeeeeeeeeeeeeeeee"+busy_type+" and phone_new is "+phone_new);
		
		sqlStr = "select a.contract_passwd,substr(c.id_iccid,length(c.id_iccid)-3,4),to_char(a.contract_no) from dConMsg a,dCustMsg b,dCustDoc c,dConUserMsg d where a.contract_no=d.contract_no and d.id_no=b.id_no and b.cust_id=c.cust_id and  b.phone_no = '?' ";

	
		
%>
		
<wtc:pubselect name="TlsPubSelBoss"   retcode="retCode1" retmsg="retMsg1" outnum="3">
	<wtc:sql><%=sqlStr%></wtc:sql>
  <wtc:param value="<%=phone_new%>"/>
</wtc:pubselect>
	<wtc:array id="result1" scope="end" />

<%
	     System.out.println("TTTsqlStr is "+sqlStr);
		 String cust_passwd="";
	     String iccid="";
	      
	      	if(result1!=null&&result1.length>0){
		        cust_passwd= (result1[0][0]).trim();
	            iccid = (result1[0][1]).trim();
	            contract_out = (result1[0][2]).trim();

	      }else{
		     returnCode="999999";
		     retResult="1û�д��û����������!";
			 
	     }
	      
	      

			System.out.println("11111111111111cccccccccccccc iccid is "+iccid+" and contract_out is "+contract_out);

					
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
var i_dp = "<%=i_dp%>";
var retResult = "<%=retResult%>";
var phone_new = "<%=phone_new%>";
var s_sm_code =  "<%=s_sm_code%>";
var contract_out = "<%=contract_out%>";
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("retResult",retResult);
response.data.add("phone_new",phone_new);
response.data.add("contract_out",contract_out);
response.data.add("s_sm_code",s_sm_code);
 
core.ajax .receivePacket(response);
<%System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");%>


 
