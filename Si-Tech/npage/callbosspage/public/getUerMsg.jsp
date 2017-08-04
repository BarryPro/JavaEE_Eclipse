<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ page import="java.net.InetAddress"%>
<%
   String callPhone = WtcUtil.repNull(request.getParameter("phone_no"));
   String contactId=WtcUtil.repNull(request.getParameter("contactId"));
		String cust_name       = "";
		String contact_address = "";
		String phone_no        = "";
		String card_name       = "";
		String product_name    = "";
		String town_name       = "";
		String run_name        = "";
		String prepay_fee      ="";
		String sm_name         = "";
		String prepay_fee_flag ="";
		String joinDate ="";
		String CurrContactId ="";
		String yue_1="";
		//add wangyong 20091021 新增服务参数
		String workNo = (String)session.getAttribute("workNo");
		String password = (String)session.getAttribute("password");
		String ip_Addr = (String)session.getAttribute("ipAddr");
    String params = "callPhone="+callPhone;
		String now_prepayFee = "";
		String spe_prepayFee="";
		String  pu_spe_prepayFee="";
		/*add by yinzx  2091104 begin*/
		 String strSql =" select accept_phone,cust_name,reason,b.bak2,c.bak1 from dcallspeciallist a, SCALLSPECIALLIST b,SCALLSPECIALLIST c where a.specialtype_id=b.funcid and a.bak1=c.funcid(+) and accept_phone=:callPhone  and begin_date  <sysdate and end_date>sysdate  and rownum=1";
		 String accept_phone="";
		 String spcust_name="";
		 String reason="";
		 String color="";
		 String bak1="";
	  /*add by yinzx  2091104 end*/	 
	  /*add by yinzx  20091211 begin*/ 
	  String group_no="" ; 
		String myparams="" ;
		String error_num="";
	  /*add by yinzx  20091211 begin*/ 	  
%>

<%
// 吉林代码开始 by fangyuan 20090801 | modify by yinzx 增加取group_no 09/12/11
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	//System.out.println("regionCode = "+regionCode);
	String sqlcustmsg="select to_char(id_no),group_id from dcustmsg where phone_no=:callPhone";
 // System.out.println("sqlcustmsg:="+sqlcustmsg);


	String return_code="";
	String return_message="";
%>

	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
		<wtc:param value="<%=sqlcustmsg%>"/>
		<wtc:param value="<%=params%>"/>
	</wtc:service>
	<wtc:array id="fee" scope="end"/>		

<%
if(fee.length>0){
String idNo  = fee[0][0];//ID号
group_no = fee[0][1];
%>


	<!--update by lipf 20120717 服务加固begin-->
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
		
	<wtc:service name="s1500Qry"  routerKey="region" routerValue="<%=regionCode%>" outnum="8"  >
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="1500"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=callPhone%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=idNo%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end" />

	<!--update by lipf 20120717 服务加固end-->

<%
System.out.println("lipf   getUerMsg.jsp  ======= ->printAccept->       "+printAccept+" ====== ->callPhone->       "+callPhone+" ======= ->idNo->       "+idNo);

	ArrayList  arlist = new ArrayList();    
	StringTokenizer resToken = null;
    int i = 0;
    for(int count = 0; count < 8; count++)
    {
			String value;
			for(resToken = new StringTokenizer(result[0][i], "|"); resToken.hasMoreElements(); arlist.add(value))
			{			
			  value = (String)resToken.nextElement();
			}
			i++;
    }
	
	return_code = (String)arlist.get(0);
	return_message = (String)arlist.get(1);




if (return_code.equals("000000")){

		cust_name      = (String)arlist.get(3)==null?"":(String)arlist.get(3);
		contact_address= (String)arlist.get(16)==null?"":(String)arlist.get(16);
	
		phone_no       = callPhone;
		card_name      = (String)arlist.get(7)==null?"":(String)arlist.get(7);
		product_name   = (String)arlist.get(37)==null?"":(String)arlist.get(37);
		town_name      = (String)arlist.get(4)==null?"":(String)arlist.get(4);
		run_name       = (String)arlist.get(33)==null?"":(String)arlist.get(33);		
		sm_name		     = (String)arlist.get(26)==null?"":(String)arlist.get(26);
		joinDate       = (String)arlist.get(28)==null?"":(String)arlist.get(28);
		String preFee = (String)arlist.get(49);
		if (  preFee.length()==3 && preFee.substring(0,1).equals(".") ) { preFee = "0"+preFee;  }
		prepay_fee     = preFee;
		
		prepay_fee_flag = (String)arlist.get(52)==null?"":(String)arlist.get(52);
		
		
}
    	
	  
%>
	<wtc:service name="sPhoneDefMsgVW"  retcode="feeRetCode1" retmsg="feeRetMsg1" outnum="16">
	<wtc:param value="<%=callPhone%>"/>
  </wtc:service>
	<wtc:array id="s1500FeeArr2" scope="end"/>	  
<%
   if(s1500FeeArr2.length>0){
   	spe_prepayFee = s1500FeeArr2[0][2];//专款
   	pu_spe_prepayFee=s1500FeeArr2[0][3];//普通
   now_prepayFee=String.valueOf(((Double.parseDouble(spe_prepayFee) + Double.parseDouble(pu_spe_prepayFee))*100)/100);//当前可用预存
    String temp_ye= s1500FeeArr2[0][15];//余额
    yue_1=temp_ye.trim();
    
    
   }  
}
//吉林代码结束
%>

<%
		//jingzhi add 20110701 
		String password_error_num_sql =" SELECT t.error_num FROM WCUSTPWDERROR t, dcustmsg tt WHERE t.id_no = tt.id_no and tt.phone_no =:callPhone and t.total_date = to_char(SYSDATE,'YYYYMMDD')";
		String error_num_params = "callPhone="+callPhone;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
		<wtc:param value="<%=password_error_num_sql%>"/>
		<wtc:param value="<%=error_num_params%>"/>
	</wtc:service>
	<wtc:array id="password_error_num" scope="end"/>	
<%
		if(password_error_num.length>0){
			error_num = password_error_num[0][0];//错误次数
			System.out.println("jingzhi_error_num"+error_num);
		}
%>
<%
    out.println((return_code+"~"+cust_name+"~"+contact_address+"~"+card_name+
    "~"+product_name+"~"+town_name+"~"+run_name+"~"+prepay_fee+
    "~"+sm_name+"~"+callPhone+"~"+contactId+"~"+joinDate+"~"+CurrContactId+"~"+accept_phone+"~"+spcust_name+"~"+reason+"~"+color+"~"+bak1+"~"+yue_1+"~"+now_prepayFee+"~"+error_num).trim());

%>

