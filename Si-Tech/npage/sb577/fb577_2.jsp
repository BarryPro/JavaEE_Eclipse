<%
/********************
 version v2.0
开发商: si-tech
update:huangrong@2010-09-19
********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%
	String opCode = "b577";
	String opName = "预存话费赠黑莓终端申请";
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/include/header.jsp" %>

<%
String work_no = (String)session.getAttribute("workNo");
String orgCode = (String)session.getAttribute("orgCode");
String pass = (String)session.getAttribute("password");
String regionCode = orgCode.substring(0,2);
String ip_Addr = (String)session.getAttribute("ipAddr");	

String cust_name=request.getParameter("cust_name");/*用户姓名*/
String userpass=request.getParameter("userpass");/*用户密码*/
String phone_type = request.getParameter("phone_type");
String phone_no = request.getParameter("phone_no");
String login_accept= request.getParameter("login_accept");/*流水*/
String payTypeSelect= request.getParameter("payTypeSelect");/*缴费方式*/
String sale_type = request.getParameter("sale_type");
String op_code = request.getParameter("opcode");
String chuan = request.getParameter("chuan");
String opNote = request.getParameter("opNote");
String phone_typename = request.getParameter("phone_typename");
String sum_money = request.getParameter("sum_money");
String IMEINo = request.getParameter("IMEINo");
String chinaFee = "零";

/*zhangyan add b*/
String allowanceCost=request.getParameter("allowanceCost");
String prepayLimit =request.getParameter("prepayLimit");
String prepayGift =request.getParameter("prepayGift");
String modeCode =request.getParameter("modeCode");
String allGiftPrice=request.getParameter("allGiftPrice");
String activeTerm =request.getParameter("activeTerm");
 

System.out.println("zhangyan@page=[fb577_2.jsp]allowanceCost=["+allowanceCost+"]");
System.out.println("zhangyan@page=[fb577_2.jsp]allowanceCost=["+prepayLimit+"]");
System.out.println("zhangyan@page=[fb577_2.jsp]allowanceCost=["+prepayGift+"]");
System.out.println("zhangyan@page=[fb577_2.jsp]allowanceCost=["+modeCode+"]");
System.out.println("zhangyan@page=[fb577_2.jsp]allowanceCost=["+allGiftPrice+"]");
System.out.println("zhangyan@page=[fb577_2.jsp]allowanceCost=["+activeTerm+"]");


String paraAray[] = new String[18]; 
paraAray[0] = login_accept;
paraAray[1] = op_code;
paraAray[2] = work_no;
paraAray[3] = phone_no;
paraAray[4] = "01";
paraAray[5] = pass;
paraAray[6] = userpass;
paraAray[7] = chuan;      
paraAray[8] = opNote;       
paraAray[9] = ip_Addr;
paraAray[10] = payTypeSelect;     
paraAray[11] = sale_type;

paraAray[12] = allowanceCost;       
paraAray[13] = prepayLimit;
paraAray[14] = prepayGift;     
paraAray[15] = modeCode;
paraAray[16] = allGiftPrice;
paraAray[17] = activeTerm;

for ( int i=0;i<paraAray.length;i++ )
{
	System.out.println("zhangyan@page=[fb577_2.jsp]paraAray["+i+"]=["+paraAray[i]+"]");
}
%>
<wtc:service  name="sB577Cfm" routerKey="region" routerValue="<%=orgCode%>" 
	outnum="2"  retcode="errCode" retmsg="errMsg">
	<wtc:param  value="<%=paraAray[0]%>"/>
	<wtc:param  value="<%=paraAray[1]%>"/>
	<wtc:param  value="<%=paraAray[2]%>"/>
	<wtc:param  value="<%=paraAray[3]%>"/>
	<wtc:param  value="<%=paraAray[4]%>"/>
	<wtc:param  value="<%=paraAray[5]%>"/>
	<wtc:param  value="<%=paraAray[6]%>"/>
	<wtc:param  value="<%=paraAray[7]%>"/>
	<wtc:param  value="<%=paraAray[8]%>"/>
	<wtc:param  value="<%=paraAray[9]%>"/>
	<wtc:param  value="<%=paraAray[10]%>"/>
	<wtc:param  value="<%=paraAray[11]%>"/>	
	<wtc:param  value="<%=paraAray[12]%>"/>	
	<wtc:param  value="<%=paraAray[13]%>"/>	
	<wtc:param  value="<%=paraAray[14]%>"/>	
	<wtc:param  value="<%=paraAray[15]%>"/>	
	<wtc:param  value="<%=paraAray[16]%>"/>	
	<wtc:param  value="<%=paraAray[17]%>"/>	
</wtc:service>
<wtc:array id="ret" scope="end"/>
<%
	if (errCode.equals("0")||errCode.equals("000000"))
	{
		String ipf = WtcUtil.formatNumber(sum_money,2);
	  String outParaNums= "4";
%>

  	<wtc:service  name="sToChinaFee" routerKey="region" routerValue="<%=orgCode%>" outnum="<%=outParaNums%>"  retcode="retCode2" retmsg="retMessage2">
			<wtc:param  value="<%=ipf%>"/>
	  </wtc:service>
	  <wtc:array id="chinaFee1"  start="2"  length="1" scope="end"/>
<%
	chinaFee =chinaFee1[0][0];
%>

<script language="JavaScript">
   rdShowMessageDialog("提交成功! 打印发票!",2);
   var infoStr="";

   infoStr+="<%=work_no%>  <%=paraAray[0]%>"+"       预存话费赠黑莓终端"+"|";//工号	
   infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
   infoStr+='<%=cust_name%>'+"|";
   infoStr+="|";
   infoStr+='<%=paraAray[3]%>'+"|";
   infoStr+="|";
   infoStr+="手机型号: "+'<%=phone_typename%>'+"|";
   infoStr+="<%=chinaFee%>"+"|";//合计金额(大写)
   infoStr+="<%=WtcUtil.formatNumber(sum_money,2)%>"+"|";//小写
 
   var jkinfo="";
	 jkinfo+="缴费合计：<%=sum_money%>"+"元    含：预存话费: <%=sum_money%>"+"元"+"|";
	 infoStr+=jkinfo+"|"; 
	 infoStr+=" "+"|";
	 infoStr+="IMEI码："+'<%=IMEINo%>'+"|";
	 infoStr+=" "+"|";
   location="/npage/public/hljBillPrint.jsp?retInfo="+infoStr+"&dirtPage=/npage/sb577/fb577_login.jsp?activePhone=<%=phone_no%>%26opCode=<%=op_code%>";
</script>
<%
	}else{
%>
<script language="JavaScript">
	rdShowMessageDialog("预存话费赠黑莓终端申请失败!(<%=errMsg%>",0);
	window.location="fb577_login.jsp?activePhone=<%=phone_no%>&opCode=<%=op_code%>";
</script>
<%}%>