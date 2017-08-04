<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by zhangshuaia @ 2009-08-05
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.util.MoneyUtil"%>
<%	
    String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);				   
 
	String opCode = "1322";
	String opName = "集团发票打印";  
	MoneyUtil mon = new MoneyUtil();
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());       
	String loginName = (String)session.getAttribute("workName");   
	String pass = (String)session.getAttribute("password");
	
 
	
	String u_id = request.getParameter("u_id");
	String u_name = request.getParameter("u_name");
	String invoice_number = request.getParameter("invoice_number");
	String invoice_code = request.getParameter("invoice_code");
	String work_no = (String)session.getAttribute("workNo");
	 
	String grp_phone_no="";
	String grp_contract_no="";
	String s_money="";
	String s_sum1 = request.getParameter("s_sum1");
	String items = request.getParameter("items");

	String login_accept = request.getParameter("login_accept");
	String begin_ym = request.getParameter("begin_ym");
	String end_ym = request.getParameter("end_ym");
    
 
	//xl add 根据组织节点查询营业厅名称
	String groupId = (String)session.getAttribute("groupId");
	String[] inParam_yyt = new String[2];
	inParam_yyt[0]="select group_name from dchngroupmsg where group_id=:s_group_id";
	inParam_yyt[1]="s_group_id="+groupId;
	String s_yyt_name="";

 
%>
	<wtc:service name="TlsPubSelCrm"  outnum="1" >
		<wtc:param value="<%=inParam_yyt[0]%>"/>
		<wtc:param value="<%=inParam_yyt[1]%>"/>
	</wtc:service>
	<wtc:array id="yyt_name_arr" scope="end" />
<%
	if(yyt_name_arr!=null&&yyt_name_arr.length>0)
	{
		s_yyt_name = yyt_name_arr[0][0];
	}

	System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaatesteeeeeeeeeeeeeeeeeeeeeee grp_phone_no is "+grp_phone_no);
%>
<!--接口应该是电子化入库的接口吧?-->
<wtc:service name="s1322InDB_all" routerKey="region" routerValue="<%=regionCode%>" retcode="sCodes" retmsg="sMsgs" outnum="3" >
    <wtc:param value="<%=u_id%>"/>
    <wtc:param value="<%=u_name%>"/> 
	<wtc:param value="<%=work_no%>"/> 
 
	<wtc:param value="<%=opCode%>"/>
	<wtc:param value="<%=invoice_number%>"/>
	<wtc:param value="<%=invoice_code%>"/>
	<wtc:param value="<%=items%>"/>
	<wtc:param value=""/>
	<wtc:param value="<%=begin_ym%>"/>
	<wtc:param value="<%=end_ym%>"/>
 
	<wtc:param value="<%=s_sum1%>"/>
	<wtc:param value="<%=groupId%>"/>
	<wtc:param value="<%=login_accept%>"/>
	<wtc:param value="<%=regionCode%>"/>
	
</wtc:service>
<wtc:array id="sArr" scope="end"/>

 
<%
 
	
	String retCode1= sCodes;
	String retMsg1 = sMsgs;
    if ( sCodes.equals("000000")  )
	{
 
%>
<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<SCRIPT language="JavaScript">
    
    function printInvoice()
    {
        var localPath = "C:/billLogo.jpg";
		//alert(2);
        printctrl.Setup(0);
        printctrl.StartPrint();
        printctrl.PageStart();
		var rowInit = 7;
		var fontSizeInit = 9;//字体大小
		var fontType = "宋体";//字体
		var fontStrongInit = 0;//字体粗细
		var vR = 0;
		var lineSpace = 0;
        printctrl.DrawImage(localPath,8,10,40,18);//左上右下
        printctrl.Print(20, 10, 9, 0, "开票日期: <%=dateStr.substring(0,4)%>年<%=dateStr.substring(4,6)%>月<%=dateStr.substring(6,8)%>日");
		printctrl.Print(115, 10, 9, 0, "本次发票号码: <%=invoice_number%>"); 
  
		printctrl.Print(13, 12, 9, 0, "客户名称: <%=u_name%>");
		printctrl.Print(13, 13, 9, 0, "业务类别: 集团发票开具");
		printctrl.Print(125, 13, 9, 0, "客户品牌: ");

		printctrl.Print(13, 15, 9, 0, "用户号码： ");	
		printctrl.Print(48, 15, 9, 0, "协议号码： ");
		printctrl.Print(82, 15, 9, 0, "话费账期: ");
		printctrl.Print(115, 15, 9, 0, "合同号:");

		printctrl.Print(115, 16, 9, 0, "支票号: ");
		printctrl.Print(115, 17, 9, 0, "集团统付号码: <%=u_id%>");//虚拟帐号
		printctrl.Print(16, 18, 9, 0, "开票项目:<%=items%>");
		printctrl.Print(16, 19, 9, 0, "本次发票金额:(小写)￥<%=s_sum1.trim()%> 大写金额合计:<%=mon.NumToRMBStr(Double.parseDouble(s_sum1))%>");
			
		printctrl.Print(16, 21, 9, 0, "");//备注 
		printctrl.Print(16, 22, 9, 0, "");//备注 
		printctrl.Print(16, 23, 9, 0, "");//备注 

		 
		
		//xl add 开票：                    收款：                     复核：
		printctrl.Print(13, 30, 9, 0, "流水号：<%=sArr[0][2]%> ");
		printctrl.Print(54, 30, 9, 0, "开票人：<%=loginName%> ");
		printctrl.Print(85, 30, 9, 0, "工号：<%=work_no%> ");
		printctrl.Print(110, 30, 9, 0, "营业厅：<%=s_yyt_name%> ");
		//alert(4);
        printctrl.PageEnd();
        printctrl.StopPrint();
        //alert(5);
		 
    }

    function ifprint()
    {
      //alert(1);
        printInvoice();
		rdShowMessageDialog("发票打印成功!");
		window.location="s1322.jsp?opCode=zg27&opName=增值税红字发票开具申请";
    }
</SCRIPT>

<body onload="ifprint()">
<OBJECT
classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
codebase="/ocx/PrintEx.dll#version=1,1,0,5" style="display:none;"
id="printctrl"
VIEWASTEXT>
</OBJECT>
 
</body>     
</html>
<%
	}else{

	%>   
	<script language="JavaScript">
		rdShowMessageDialog("集团发票开具失败: <%=retMsg1%>,<%=retCode1%>",0);
		window.location="s1322.jsp?opCode=zg27&opName=增值税红字发票开具申请";
		</script>
	<%
	 
}
%>

