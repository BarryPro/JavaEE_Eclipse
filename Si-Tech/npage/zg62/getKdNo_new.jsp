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
	
	String return_page = WtcUtil.repStr(request.getParameter("return_page")," ");
	 
	String s_sm_code="";
	String[] inParam2 = new String[2];
	inParam2[0]="select a.phone_no,sm_code,to_char(sMaxPayAccept.nextval) from dbroadbandmsg a,dcustmsg b where cfm_login = :cfm_login and a.phone_no = b.phone_no";
	inParam2[1]="cfm_login="+phone_kd;
	String s_accept="";
	String phone_new="";
	int i_dp=0;
	
%>
	<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode12" retmsg="retMsg12" outnum="3">
		<wtc:param value="<%=inParam2[0]%>"/>
		<wtc:param value="<%=inParam2[1]%>"/>
	</wtc:service>
	<wtc:array id="result12" scope="end" />
<%
	
	 
	      
	if(result12!=null&&result12.length>0){
		        phone_new= (result12[0][0]).trim();
				s_sm_code= (result12[0][1]).trim();
				s_accept=  (result12[0][2]).trim();
	    //xl add for 判断是单品
		String[] inParam_ym = new String[2];
		String s_ym="";
		String[] inParam_dp = new String[2];
		//xl add for xuxza 20150320 修改的脚本 通过生效时间来判断
		inParam_ym[0]="select begin_time,end_time from (select begin_time,end_time from ttkd_account_msg where trim(phone_no)=:s_phone_no order by begin_time desc) where rownum<2 ";
		inParam_ym[1]="s_phone_no="+phone_new;
		%>
		<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1_ym" retmsg="retMsg1_ym" outnum="1">
			<wtc:param value="<%=inParam_ym[0]%>"/>
			<wtc:param value="<%=inParam_ym[1]%>"/>
		</wtc:service>
		<wtc:array id="result_ym" scope="end" />
		<%
		if(result_ym!=null&&result_ym.length>0)
		{
			s_ym=result_ym[0][0];
			inParam_dp[0]="SELECT to_char(COUNT(*)) FROM (SELECT COUNT(*) AS i_count FROM DBBILLADM.TTKD_ACCOUNT_MSG a, PRODUCT_OFFER_INSTANCE b  WHERE trim(a.phone_no) = :s_phone_no  AND a.id_no = b.serv_id  AND a.acc_flag = '1'  and a.bill_flag = '0'  and a.begin_time=:s_begin_time  union  SELECT COUNT(*) AS i_count  FROM DBBILLADM.TTKD_ACCOUNT_MSG a, PRODUCT_OFFER_INSTANCE b  WHERE trim(a.phone_no) = :s_phone_no1  AND a.id_no = b.serv_id AND a.acc_flag = '1'  and a.bill_flag != '0'  AND a.accflag_time > to_char(sysdate, 'YYYYMMDDHH24MISS')  and a.begin_time=:s_begin_time1  AND b.eff_date > sysdate  AND b.exp_date > sysdate  and a.begin_time > to_char(sysdate, 'yyyymmddhh24miss'))  WHERE i_count > 0 ";
			inParam_dp[1]="s_phone_no="+phone_new+",s_begin_time="+s_ym+",s_phone_no1="+phone_new+",s_begin_time1="+s_ym;
		
		%>
			<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1_dp" retmsg="retMsg1_dp" outnum="1">
				<wtc:param value="<%=inParam_dp[0]%>"/>
				<wtc:param value="<%=inParam_dp[1]%>"/>
			</wtc:service>
			<wtc:array id="result_dp" scope="end" />
		<%
			if(result_dp!=null&&result_dp.length>0)
			{
				i_dp=Integer.parseInt(result_dp[0][0]);
			}
			else
		    {
				i_dp=0;
			}
		}
		else
		{
			%>
				 
					window.location.href="<%=return_page%>"; 
				 
			<%
		}
		
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
		     retResult="1没有此用户的相关资料!";
			 
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
var retResult = "<%=retResult%>";
var phone_new = "<%=phone_new%>";
var s_sm_code =  "<%=s_sm_code%>";
var contract_out = "<%=contract_out%>";
var s_accept="<%=s_accept%>";
var i_dp = "<%=i_dp%>";
response.guid = '<%= request.getParameter("guid") %>';
response.data.add("retResult",retResult);
response.data.add("phone_new",phone_new);
response.data.add("contract_out",contract_out);
response.data.add("s_sm_code",s_sm_code);
response.data.add("s_accept",s_accept);
response.data.add("i_dp",i_dp);
core.ajax .receivePacket(response);
<%System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");%>


 
