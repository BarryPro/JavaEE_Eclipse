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
   int i_dp=0;
			//得到输入参数
    String contractNo= "";
    String phone_kd  = WtcUtil.repStr(request.getParameter("contractNo")," "); 
	
	String busy_type = WtcUtil.repStr(request.getParameter("busyType")," ");
   	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAA busy_type is "+busy_type);
	String sql_kd="";
	String s_sm_code="";
	if(busy_type.equals("1"))
	{
		//sql_kd= "select phone_no from dbroadbandmsg where cfm_login = '?' ";
		sql_kd = "select a.phone_no,sm_code from dbroadbandmsg a,dcustmsg b where cfm_login = '?' and a.phone_no = b.phone_no ";
		System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAA 在网");
	}
	if(busy_type.equals("2"))
	{
		//sql_kd = "select phone_no from dbroadbandmsghis where cfm_login = '?' ";
		/*
		select to_char(a.contract_no),a.bank_cust,to_char(b.open_time,'yyyy-mm-dd hh24:mi:ss'),b.user_passwd,to_char(b.phone_no) from dConMsgDead a,dCustMsgDead b,dbroadbandmsghis c where a.contract_no=b.contract_no and b.phone_no=c.phone_no and c.cfm_login='"+cfm_lg+"'
		*/
		sql_kd = "select to_char(b.phone_no),sm_code from dConMsgDead a,dCustMsgDead b,dbroadbandmsghis c where a.contract_no=b.contract_no and b.phone_no=c.phone_no and c.cfm_login='?' ";
		System.out.println("BBBBBBBBBBBBBBBBBBBBBBB 离网");
	}
	//String sql_kd = "select phone_no from dbroadbandmsg where cfm_login = '?' ";
	String return_page = WtcUtil.repStr(request.getParameter("return_page")," ");
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
		System.out.println("AAAAAAAAAAAAAAAAAaaaaaaaaaaaa and phone_new is "+phone_new);
	//	System.out.println("bbbbbbbbbbbbb"+busy_type);

	  String Pwd0 = "";
	  String Pwd1 = "";
	  String Pwd2 = "";
	  String Pwd3 = "";
	
	  String phone_out = "";
	  String contract_out = "";
		System.out.println("eeeeeeeeeeeeeeeeeeeeeee"+busy_type);
		
		if(busy_type.equals("1"))
		{
			sqlStr = "select a.contract_passwd,substr(c.id_iccid,length(c.id_iccid)-3,4),to_char(a.contract_no) from dConMsg a,dCustMsg b,dCustDoc c,dConUserMsg d where a.contract_no=d.contract_no and d.id_no=b.id_no and b.cust_id=c.cust_id and  b.phone_no = '?' ";
		}
		if(busy_type.equals("2"))
		{
			sqlStr = "select a.contract_passwd,substr(c.id_iccid,length(c.id_iccid)-3,4),to_char(a.contract_no) from dConMsgdead a,dCustMsgdead b,dCustDoc c,dConUserMsgdead d where a.contract_no=d.contract_no and d.id_no=b.id_no and b.cust_id=c.cust_id and  b.phone_no = '?' ";
		}
		
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
	      
	      

		//	System.out.println("11111111111111cccccccccccccciccid is "+iccid);

					
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
var s_sm_code = "<%=s_sm_code%>";  
var contract_out = "<%=contract_out%>";
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("retResult",retResult);
response.data.add("phone_new",phone_new);
response.data.add("contract_out",contract_out);
response.data.add("s_sm_code",s_sm_code); 
core.ajax .receivePacket(response);
<%System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");%>


 
