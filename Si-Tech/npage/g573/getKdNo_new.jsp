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
    String s_run_code="";
    String contractNo= "";
    String phone_kd  = WtcUtil.repStr(request.getParameter("contractNo")," "); 
	
	String busy_type = WtcUtil.repStr(request.getParameter("busyType")," ");
   	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String sql_kd = "select trim(to_char(new_phoneno)) from dbbillprg.s_rs_iot_phonenoswitch_info where old_phoneno = '?' ";
	String return_page = WtcUtil.repStr(request.getParameter("return_page")," ");
	System.out.println("TAAAAAAAAAAAAAAAAATTTTTTTTTTTTTTT sql_kd is "+sql_kd+" and phone_kd is "+phone_kd);
	//lidsa 进行转换 通过phone_kd进行转换；
	/*
		10648开头号码将以205开头形式存在dcustres等相关号码表中，用来将13位号码转换成11位号码。 例如：物联网号码：1064801234567 ---》  20501234567
		147开头号码将以206开头形式存在dcustres等相关号码表中，用来和已有147号码进行区分。 例如：物联网号码：14701234567 ---》  20601234567
	*/
	String[] inParas1 = new String[2];
	inParas1[0]="select trim(to_char(new_phoneno)) from dbbillprg.s_rs_iot_phonenoswitch_info where old_phoneno =:s_no";
	inParas1[1]="s_no="+phone_kd;
%>
	<wtc:service  name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode12" retmsg="retMsg12" outnum="1">
	 		<wtc:param value="<%=inParas1[0]%>"/>
			<wtc:param value="<%=inParas1[1]%>"/>
	</wtc:service>
	<wtc:array id="result12" scope="end" />
<%
	String phone_new="";
	 
	      
	if(result12!=null&&result12.length>0){
		        phone_new= (result12[0][0]).trim();
				
				
				%>
					//alert("q");
				<%
	 }else{
		      
	     %>
				    //alert("2");
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
	
	  String[] inParas2 = new String[2];	
	  inParas2[0]="select a.contract_passwd,substr(c.id_iccid,length(c.id_iccid)-3,4),to_char(a.contract_no),b.sm_code,substr(run_code,2,1) from dConMsg a,dCustMsg b,dCustDoc c,dConUserMsg d where a.contract_no=d.contract_no and d.id_no=b.id_no and b.cust_id=c.cust_id and  b.phone_no = :s_no1";
	  inParas2[1]="s_no1="+phone_new;
	  sqlStr = "select a.contract_passwd,substr(c.id_iccid,length(c.id_iccid)-3,4),to_char(a.contract_no),b.sm_code,substr(run_code,2,1) from dConMsg a,dCustMsg b,dCustDoc c,dConUserMsg d where a.contract_no=d.contract_no and d.id_no=b.id_no and b.cust_id=c.cust_id and  b.phone_no = '?' ";
%>
 
<wtc:service name="TlsPubSelBoss"    retcode="retCode1" retmsg="retMsg1" outnum="5">
	<wtc:param value="<%=inParas2[0]%>"/>
    <wtc:param value="<%=inParas2[1]%>"/>
</wtc:service>
	<wtc:array id="result1" scope="end" />

<%
	     System.out.println("TTTsqlStr is "+sqlStr);
		 String cust_passwd="";
	     String iccid="";
	     String s_sm_code=""; 
	      	if(result1!=null&&result1.length>0){
		        cust_passwd= (result1[0][0]).trim();
	            iccid = (result1[0][1]).trim();
	            contract_out = (result1[0][2]).trim();
				s_sm_code= (result1[0][3]).trim();
				s_run_code=(result1[0][4]).trim();
	      }else{
		     returnCode="999999";
		     retResult="没有此用户的相关资料!";
			 
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
var s_run_code = "<%=s_run_code%>"; 
var retResult = "<%=retResult%>";
var phone_new = "<%=phone_new%>";
var s_sm_code = "<%=s_sm_code%>"; 
var contract_out = "<%=contract_out%>";
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("retResult",retResult);
response.data.add("phone_new",phone_new);
response.data.add("contract_out",contract_out);
response.data.add("s_sm_code",s_sm_code);
response.data.add("s_run_code",s_run_code);
core.ajax .receivePacket(response);
<%System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");%>


 
