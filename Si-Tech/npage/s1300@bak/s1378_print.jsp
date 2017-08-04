<%@ page contentType="text/html; charset=GB2312" %>
 
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="com.sitech.boss.pub.util.*"%>
<%@ page import="com.sitech.boss.amd.viewbean.*" %>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
<%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%

  //20100528 liuxmc 添加发票防伪码
		java.util.Random r = new java.util.Random();
		int ran = r.nextInt(9999);
		int ran1 = r.nextInt(10)*1000;
		if((ran+"").length()<4){
			ran = ran+ran1;
		}
		int key = 99999;
		int realKey = ran ^ key;
		System.out.println("realKey："+realKey);
		
		String bill_type = "2";

    ArrayList arr = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arr.get(0);
	String workno = baseInfo[0][2];
	String workname=baseInfo[0][3];
	String s_yyt_name="";
	MoneyUtil mon = new MoneyUtil();

	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    String year = dateStr.substring(0,4);
	String month = dateStr.substring(4,6);
	String day = dateStr.substring(6,8);
	String check_seq =  request.getParameter("check_seq");
    String owner_name = request.getParameter("owner_name");
	String phone_no = request.getParameter("phone_no");
	String owe_fee_pay = request.getParameter("owe_fee_pay");	
	String delay_fee_pay = request.getParameter("delay_fee_pay");
	String op_note = request.getParameter("op_note");
	String login_accept = request.getParameter("login_accept");
	String payAccept = request.getParameter("login_accept");
	String id_no = request.getParameter("id_no");
	String groupId = (String)session.getAttribute("groupId");
	String bill_code = request.getParameter("bill_code");
	String orgcode = (String)session.getAttribute("orgCode");
	String regionCode = orgcode.substring(0,2);
	String money=Double.toString(Double.parseDouble(owe_fee_pay) + Double.parseDouble(delay_fee_pay));
	//xl add 根据组织节点查询营业厅名称
	String[] inParam_yyt = new String[2];
	inParam_yyt[0]="select group_name from dchngroupmsg where group_id=:s_group_id";
	inParam_yyt[1]="s_group_id="+groupId;

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
%>	

<script language="JavaScript" src="/js/common/redialog/redialog.js"></script>
<SCRIPT language="JavaScript">

function ifprint(){

    try {
<%
  out.println("printctrl.Setup(0)");
  out.println("printctrl.StartPrint()");
  out.println("printctrl.PageStart()");
  %>
  var localPath = "C:/billLogo.jpg"; 
  printctrl.DrawImage(localPath,8,10,40,18);//左上右下
  <%

  //new begin out.println("printctrl.Print(20, 10, 9, 0,'"+year+month+day+"')");
  out.println("printctrl.Print(20, 10, 9, 0,'"+year+month+day+"')");   
  out.println("printctrl.Print(115, 10, 9, 0,'"+"本次发票代码："+check_seq+"')");

  out.println("printctrl.Print(13, 13, 9, 0,'"+"客户名称："+owner_name+"')");
  out.println("printctrl.Print(72, 13, 9, 0,'"+"业务类别：欠费催缴')");
  out.println("printctrl.Print(115, 13, 9, 0,'客户品牌：')");	
 
  out.println("printctrl.Print(13, 15, 9, 0,'用户号码："+phone_no+"')");	
  out.println("printctrl.Print(48, 15, 9, 0,'协议号码：')");	

  out.println("printctrl.Print(82, 15, 9, 0,'话费账期："+year+month+"')");
  out.println("printctrl.Print(115, 15, 9, 0,'合同号：')");
  out.println("printctrl.Print(115, 16, 9, 0,'支票号码：')");
 	out.println("printctrl.Print(115, 17, 9, 0,'集团统付号码:')");
  out.println("printctrl.Print(16, 18, 9, 0,'通信服务费合计：')");
        
  String l_bigMoney=mon.NumToRMBStr((double) Math.round((Double.parseDouble(owe_fee_pay) + Double.parseDouble(delay_fee_pay))*100)/100);
  out.println("printctrl.Print(16, 19, 9, 0,'本次发票金额:(小写)￥"+money+"大写金额合计: "+l_bigMoney.substring(1,l_bigMoney.length()-1)+"')");
  out.println("printctrl.Print(16, 20, 9, 0,'"+op_note+"')");
  out.println("printctrl.Print(13, 30, 9, 0,'流水号："+phone_no+"')");
  out.println("printctrl.Print(54, 30, 9, 0,'开票人："+workname+"')");
  out.println("printctrl.Print(85, 30, 9, 0,'工号："+workno+"')");
  out.println("printctrl.Print(110, 30, 9, 0,'营业厅："+s_yyt_name+"')");
  //new end

  
  
  out.println("printctrl.PageEnd()");
  out.println("printctrl.StopPrint()");
 %>
  rdShowMessageDialog("打印成功!");
  document.location.replace("s1378.jsp");
} catch(e) {
} finally {
}

 

	
}

<%
    //发票电子化添加入库服务
		String[] inParas0 = new String[29];
		inParas0[0] =	payAccept;//流水
		inParas0[1] = "1378";//
		inParas0[2] = workno;
		inParas0[3] ="";//没有用
		inParas0[4] = phone_no.trim();
		inParas0[5] = id_no;//id_no 只是入表用 实在不行在程序里自己取一下
		inParas0[6] = "0";//contract_no
		 
		inParas0[7] = "";//支票号码
		//xl add 发票预占状态变更入参 begin
		//发票号码 发票金额 地市 group_id 备注 发票代码 
		inParas0[8] = check_seq;//发票号码;
		inParas0[9] = bill_code;//发票代码;
		inParas0[10] ="";//品牌
		inParas0[11] =money;
		inParas0[12] = l_bigMoney.substring(1,l_bigMoney.length()-1);//大写金额
		inParas0[13] = "" ;
		
		//本次缴费金额 这个得看样张都有啥
		//xl add 发票预占状态变更入参 end


		inParas0[14] = "";//增值税的
		inParas0[15] = "0";//增值税的
		inParas0[16] = "0";//增值税的
		inParas0[17] = "0";//打印年月
		inParas0[18] = owner_name;//cust_name
		inParas0[19] = "";
		inParas0[20] = "";
		inParas0[21] = "";
		inParas0[22] = "";
		inParas0[23] = "";
		inParas0[24] = "";
		inParas0[25] = groupId; 
		inParas0[26] = "1";
		inParas0[27] ="0";//通用机打 
		 

		System.out.println("====执行 s1300PrintInDB 开始=======");
		String[][] result2 = new String[][]{};
		//打印的时候 按流水更新状态 预占的更新为已打印

%>
		<wtc:service name="sinvoiceInDB" routerKey="region" routerValue="<%=regionCode%>" outnum="2" >
			<wtc:param value="<%=inParas0[0]%>"/>
			<wtc:param value="<%=inParas0[1]%>"/>
			<wtc:param value="<%=inParas0[2]%>"/>
			<wtc:param value="<%=inParas0[3]%>"/>
			<wtc:param value="<%=inParas0[4]%>"/>
			<wtc:param value="<%=inParas0[5]%>"/>
			<wtc:param value="<%=inParas0[6]%>"/>
			<wtc:param value="<%=inParas0[7]%>"/>
			<wtc:param value="<%=inParas0[8]%>"/>
			<wtc:param value="<%=inParas0[9]%>"/>
			<wtc:param value="<%=inParas0[10]%>"/>
			<wtc:param value="<%=inParas0[11]%>"/>
			<wtc:param value="<%=inParas0[12]%>"/>
			<wtc:param value="<%=inParas0[13]%>"/>
			<wtc:param value="<%=inParas0[14]%>"/>
			<wtc:param value="<%=inParas0[15]%>"/>
			<wtc:param value="<%=inParas0[16]%>"/>
			<wtc:param value="<%=inParas0[17]%>"/>
			<wtc:param value="<%=inParas0[18]%>"/>
			<wtc:param value="<%=inParas0[19]%>"/>
			<wtc:param value="<%=inParas0[20]%>"/>
			<wtc:param value="<%=inParas0[21]%>"/>
			<wtc:param value="<%=inParas0[22]%>"/>
			<wtc:param value="<%=inParas0[23]%>"/>
			<wtc:param value="<%=inParas0[24]%>"/>
			<wtc:param value="<%=inParas0[25]%>"/>
			<wtc:param value="<%=inParas0[26]%>"/>
			<wtc:param value="<%=inParas0[27]%>"/>
		</wtc:service>
		<wtc:array id="RetResult" scope="end"/>
<%
			System.out.println("====执行 szg12InDB 结束=======");
		if(RetResult.length > 0)
		{
			result2 = RetResult;
			if((result2[0][0]!="000000")&&!result2[0][0].equals("000000"))
			{
				%>
					<script language="JavaScript">
					    rdShowMessageDialog("电子发票入库失败,错误代码"+"<%=result2[0][0]%>"+",错误原因:"+"<%=result2[0][1]%>".",0);
					    document.location.replace("s1378.jsp");
					</script>
        <%			
			}
			
		}
		else if(RetResult == null || RetResult.length == 0){
%>
					<script language="JavaScript">
					    rdShowMessageDialog("电子发票入库失败,szg12InDB_pt服务返回结果为空.",0);
					    document.location.replace("s1378.jsp");
					</script>
<%			
		}	
%>			
		
</SCRIPT>
<html>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<body onload="ifprint()">
<OBJECT
classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
codebase="/ocx/PrintEx.dll#version=1,1,0,5" style="display:none;"
id="printctrl"
VIEWASTEXT>
</OBJECT>

</body>
</html>