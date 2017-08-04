<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
   String phone_no = WtcUtil.repStr(request.getParameter("phone_no")," ");
   String busy_type = WtcUtil.repStr(request.getParameter("busy_type")," ");
   String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);      
	 String retResult = "";
	 String returnCode="";
	 String sqlStr = "";
	 String strIdNo = "";
	 String strSzxFlag = "";
	 String strIsMarketingFlag ="";
	
	/*王良 2006年8月29日 增加标准神州行判定*/	
//	String strSqlText = "";
	String s_sm_code="";
	String[] strSqlText = new String[2];
	strSqlText[0]="select a.id_no,sm_code from dCustMsg a where a.phone_no=:s_no ";
	strSqlText[1]="s_no="+phone_no;
	//strSqlText = "select a.id_no,sm_code from dCustMsg a where a.phone_no='" + phone_no + "'";
%>
	<wtc:service name="TlsPubSelBoss" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:param value="<%=strSqlText[0]%>"/>
		<wtc:param value="<%=strSqlText[1]%>"/>
	</wtc:service>
	<wtc:array id="strReturnArray" scope="end" />
<%
	if(strReturnArray!=null&&strReturnArray.length>0){//防止有的号码因为数据不全而没有id_no
		strIdNo = (strReturnArray[0][0]).trim();
		s_sm_code= (strReturnArray[0][1]).trim();
  System.out.println("id_no="+strIdNo);
  
  //strSqlText = "";
  //strSqlText = "SELECT count(*) FROM dBillCustDetail"+strIdNo.substring(strIdNo.length()-1,strIdNo.length())+" WHERE id_no="+strIdNo+" AND begin_time<=sysdate AND end_time>sysdate AND mode_flag='0' AND mode_time='Y' and mode_code='0007p700'";
  //strSqlText = "SELECT count(*) FROM product_offer_instance a, product_offer b WHERE a.offer_id = b.offer_id and SYSDATE BETWEEN a.eff_date AND a.exp_date  and b.offer_type = '10' and a.state = 'A' and substr(offer_code,3,8)='0007p700' and a.serv_id ="+strIdNo+"";
  String[] strSqlText2 = new String[2];
  strSqlText2[0]="SELECT count(*) FROM product_offer_instance a, product_offer b WHERE a.offer_id = b.offer_id and SYSDATE BETWEEN a.eff_date AND a.exp_date  and b.offer_type = '10' and a.state = 'A' and substr(offer_code,3,8)='0007p700' and a.serv_id =:s_no";
  strSqlText2[1]="s_no="+strIdNo;
 // System.out.println("strSqlText0="+strSqlText);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
		<wtc:param value="<%=strSqlText2[0]%>"/>
		<wtc:param value="<%=strSqlText2[1]%>"/>
	</wtc:service>
	<wtc:array id="strReturnArray2" scope="end" />
<%
	if(strReturnArray2!=null&&strReturnArray2.length>0){
		strSzxFlag = (strReturnArray2[0][0]).trim();
	}
  	System.out.println("strSzxFlag="+strSzxFlag);
  
  //strSqlText="";
 /* strSqlText = "select count(a.phone_no) from dmarketcustmsg a,dmarketmsg b where a.marketing_id=b.marketing_id " +
               " and a.marketing_group=b.marketing_group and a.phone_no='"+phone_no + "'" +
               " and a.contact_counts<b.max_counts " +
               " and floor(sysdate - to_date(substr(a.last_contract_time,1,8),'yyyymmdd'))>to_number(b.interval_cycle)" +
               " AND a.marketing_group not in (Select marketing_group from dmarketreturnmsg " +
               " WHERE record_date=to_char(sysdate,'yyyymmdd') AND phone_no='"+phone_no +"'  AND accepted_degree  in ('2','3'))";
			   */
	String[] strSqlText3 = new String[2];
	strSqlText3[0]="select count(a.phone_no) from dmarketcustmsg a,dmarketmsg b where a.marketing_id=b.marketing_id   and a.marketing_group=b.marketing_group and a.phone_no=:s_no1   and a.contact_counts<b.max_counts   and floor(sysdate - to_date(substr(a.last_contract_time,1,8),'yyyymmdd'))>to_number(b.interval_cycle)   AND a.marketing_group not in (Select marketing_group from dmarketreturnmsg  WHERE  record_date=to_char(sysdate,'yyyymmdd') AND phone_no= :s_no2  AND accepted_degree  in ('2','3'))";
	strSqlText3[1]="s_no1="+phone_no+",s_no2="+phone_no;
	//System.out.println("strSqlText1="+strSqlText);
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="1">
		<wtc:param value="<%=strSqlText3[0]%>"/>
		<wtc:param value="<%=strSqlText3[1]%>"/>
	</wtc:service>
	<wtc:array id="strReturnArray3" scope="end" />
<%
	if(strReturnArray3!=null&&strReturnArray3.length>0){
		strIsMarketingFlag = (strReturnArray3[0][0]).trim();
	}
	
	System.out.println("strIsMarketingFlag="+strIsMarketingFlag);
	
	}else{//如果id_no不存在
		returnCode="999999";
		retResult="没有此用户的相关资料!";
	}
%>


var response = new AJAXPacket();
var retResult = "<%=retResult%>";
var SzxFlag = "<%=strSzxFlag%>";
var returnCode="<%=returnCode%>";
var s_sm_code = "<%=s_sm_code%>";
var IsMarketing="<%=strIsMarketingFlag%>";
response.data.add("retResult",retResult);
response.data.add("SzxFlag",SzxFlag);
response.data.add("returnCode",returnCode);
response.data.add("s_sm_code",s_sm_code);
response.data.add("IsMarketing",IsMarketing);
core.ajax.receivePacket(response);



 
