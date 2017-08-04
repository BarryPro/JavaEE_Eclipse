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
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
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
	System.out.println("phone_no----------------------------------------------------------------:"+phone_no);
	/*王良 2006年8月29日 增加标准神州行判定*/	
	String strSqlText = "";
	
  strSqlText = "select a.id_no from dCustMsg a where a.phone_no='" + phone_no + "'";
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode11" retmsg="retMsg11" outnum="1">
	<wtc:sql><%=strSqlText%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="strReturnArray" scope="end" />
<%
	if(strReturnArray!=null&&strReturnArray.length>0){//防止有的号码因为数据不全而没有id_no
		strIdNo = (strReturnArray[0][0]).trim();
	
  System.out.println("id_no="+strIdNo);
  
  strSqlText = "";
  //strSqlText = "SELECT count(*) FROM dBillCustDetail"+strIdNo.substring(strIdNo.length()-1,strIdNo.length())+" WHERE id_no="+strIdNo+" AND begin_time<=sysdate AND end_time>sysdate AND mode_flag='0' AND mode_time='Y' and mode_code='0007p700'";
  strSqlText = "SELECT count(*) FROM product_offer_instance a, product_offer b WHERE a.offer_id = b.offer_id and SYSDATE BETWEEN a.eff_date AND a.exp_date  and b.offer_type = '10' and a.state = 'A' and substr(offer_code,3,8)='0007p700' and a.serv_id ="+strIdNo+"";
  System.out.println("strSqlText0="+strSqlText);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
	<wtc:sql><%=strSqlText%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="strReturnArray2" scope="end" />
<%
	if(strReturnArray2!=null&&strReturnArray2.length>0){
		strSzxFlag = (strReturnArray2[0][0]).trim();
	}
  	System.out.println("strSzxFlag="+strSzxFlag);
  
  strSqlText="";
  strSqlText = "select count(a.phone_no) from dmarketcustmsg a,dmarketmsg b where a.marketing_id=b.marketing_id " +
               " and a.marketing_group=b.marketing_group and a.phone_no='"+phone_no + "'" +
               " and a.contact_counts<b.max_counts " +
               " and floor(sysdate - to_date(substr(a.last_contract_time,1,8),'yyyymmdd'))>to_number(b.interval_cycle)" +
               " AND a.marketing_group not in (Select marketing_group from dmarketreturnmsg " +
               " WHERE record_date=to_char(sysdate,'yyyymmdd') AND phone_no='"+phone_no +"'  AND accepted_degree  in ('2','3'))";
 System.out.println("strSqlText1="+strSqlText);
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="1">
	<wtc:sql><%=strSqlText%></wtc:sql>
	</wtc:pubselect>
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
<%
	//密码校验
	System.out.println("=zhangyan==14=pubCheckPwd.jsp====wanghfa=检查密码是否正确===========");

	String accountType = (String)session.getAttribute("accountType"); 		//yanpx 添加 为判断是否为客服工号
	String custType = WtcUtil.repStr(request.getParameter("custType"),"");	//01:用户密码校验 02 客户密码校验 03帐户密码校验
		System.out.println("=zhangyan==18=pubCheckPwd.jsp====wanghfa=检查密码是否正确===========");

	String phoneNo = WtcUtil.repStr(request.getParameter("phoneNo"),"");	//移动号码,客户id,帐户id
		System.out.println("=zhangyan==21=pubCheckPwd.jsp====wanghfa=检查密码是否正确===========");

	String custPaswd = WtcUtil.repStr(request.getParameter("custPaswd"),"");//用户/客户/帐户密码
	custPaswd = Encrypt.encrypt(custPaswd);
	String idType = WtcUtil.repStr(request.getParameter("idType"),"");		//en 密码为密文，其它情况 密码为明文
	String idNum = WtcUtil.repStr(request.getParameter("idNum"),"");		//传空
	String loginNo = WtcUtil.repStr(request.getParameter("loginNo"),"");	//工号
	
	//loginNo="aa0101";
	String retCode1 = new String();
	String retMsg1 = new String();
	System.out.println("=zhangyan===pubCheckPwd.jsp====wanghfa=检查密码是否正确===========");
	System.out.println("=zhangyan==========wanghfa============ custType = " + custType);
	System.out.println("=zhangyan==========wanghfa============ phoneNo = " + phoneNo);
	System.out.println("=zhangyan==========wanghfa============ custPaswd = " + custPaswd);
	System.out.println("=zhangyan==========wanghfa============ idType = " + idType);
	System.out.println("=zhangyan==========wanghfa============ idNum = " + idNum);
	System.out.println("=zhangyan==========wanghfa============ loginNo = " + loginNo);

/*yanpx 添加 客服工号不进行密码验证 直接通过20100907 开始 */
if( accountType.equals("2") ){
	retCode1 = "000000";
	retMsg1  = "密码验证通过";
} else {
%>
<wtc:service name="sPubCustCheck" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode" retmsg="retMsg" outnum="5">
	<wtc:param value="<%=custType%>"/>
	<wtc:param value="<%=phoneNo%>"/>
	<wtc:param value="<%=custPaswd%>"/>
	<wtc:param value="<%=idType%>"/>
	<wtc:param value="<%=idNum%>"/>
	<wtc:param value="<%=loginNo%>"/>
</wtc:service>
<wtc:array id="result" scope="end"/>
<%
	System.out.println("=zhangyan==========wanghfa============retCode=" + retCode);
	System.out.println("=zhangyan==========wanghfa============retMsg=" + retMsg);
	retCode1 = retCode;
	retMsg1  = retMsg;

	if ("000000".equals(retCode)) {
		for (int i = 0; i < result.length; i ++ ) {
			for (int j = 0; j < result[i].length; j ++) {
				System.out.println("==zhangyan=======wanghfa==========result[" + i + "][" + j + "]" + result[i][j]);
			}
		}
	}

}
%>
/*yanpx 添加 结束*/


<%
   //身份证号码校验
   //String phone_no = WtcUtil.repStr(request.getParameter("phone_no")," ");
   //String busy_type = WtcUtil.repStr(request.getParameter("busy_type")," ");
   //String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);      
	
   String id_card = request.getParameter("id_card");	
   String[] inParas2 = new String[2];
   int i_count=0;
   inParas2[0]="select to_char(count (*))  from (select b.phone_no from dcustdoc a,dcustmsg b,dconusermsg c where a.cust_id = b.cust_id and b.contract_no=c.contract_no and c.id_no=b.id_no and c.bill_order='99999999' and c.contract_no=:contract_no and trim(a.id_iccid)=:id_card )  ";
   inParas2[1]="contract_no="+phoneNo+",id_card="+id_card;	
   String s_flag="";
   String s_count="";
 
%>
	<wtc:service name="TlsPubSelBoss" retcode="retCode13" retmsg="retMsg13" outnum="1">
		<wtc:param value="<%=inParas2[0]%>"/>
		<wtc:param value="<%=inParas2[1]%>"/>
	</wtc:service>
	<wtc:array id="strReturnArray" scope="end" />
<%
	if(strReturnArray!=null&&strReturnArray.length>0)
	{
		s_flag="0";//sql通过
		s_count=strReturnArray[0][0];
		
	}
	else
	{
		s_flag="1";//sql运行异常
	}
	

%>
var response = new AJAXPacket();
var retResult = "<%=retResult%>";
var SzxFlag = "<%=strSzxFlag%>";
var returnCode="<%=returnCode%>";
var IsMarketing="<%=strIsMarketingFlag%>";
var retResult_mm = "<%=retCode1%>";
var msg = "<%=retMsg1%>";
var s_flag = "<%=s_flag%>";
var s_count = "<%=s_count%>";


response.data.add("retResult",retResult);
response.data.add("SzxFlag",SzxFlag);
response.data.add("returnCode",returnCode);
response.data.add("IsMarketing",IsMarketing);
response.data.add("retResult_mm",retResult_mm);
response.data.add("msg",msg);
response.data.add("s_flag",s_flag);
response.data.add("s_count",s_count);

core.ajax.receivePacket(response);



 
