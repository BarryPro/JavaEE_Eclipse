<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * 功能:兑换发票1321
   * 版本: 1.0
   * 日期: 2009/1/16
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.s5010.viewBean.*"%>
<%@ page import="com.sitech.boss.amd.viewbean.*"%>
<%
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


	String groupId = (String)session.getAttribute("groupId");
	String opCode = "1321";
	String opName = "收据兑换等额发票 ";
	String workno = (String)session.getAttribute("workNo");				//操作工号
	String workname = (String)session.getAttribute("workName");		
	String regionCode = (String)session.getAttribute("regCode"); 		//地市    							
	String i_contract_no = request.getParameter("contract_no");     	//账户号码							
  String i_login_accept = request.getParameter("login_accept");   	//缴费流水							
  String i_year_month = request.getParameter("year_month");       	//缴费月份		
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
  String year = dateStr.substring(0,4);
	String month = dateStr.substring(4,6);
	String day = dateStr.substring(6,8); 
	String nopass = (String)session.getAttribute("password");
		//xl add 根据组织节点查询营业厅名称
	String s_yyt_name="";
	String[] inParam_yyt = new String[2];
	inParam_yyt[0]="select group_name from dchngroupmsg where group_id=:s_group_id";
	inParam_yyt[1]="s_group_id="+groupId;
	//xl add 发票号码
	String check_seq = request.getParameter("check_seq");
	String s_flag = request.getParameter("s_flag");
	String bill_code = request.getParameter("bill_code");
%>

		<wtc:service name="TlsPubSelCrm"  outnum="1" >
		<wtc:param value="<%=inParam_yyt[0]%>"/>
		<wtc:param value="<%=inParam_yyt[1]%>"/>
		</wtc:service>
		<wtc:array id="yyt_name_arr" scope="end" />
			
			
	<wtc:sequence name="TlsPubSelBoss" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept"/>
<%

	if(yyt_name_arr!=null&&yyt_name_arr.length>0)
	{
		s_yyt_name = yyt_name_arr[0][0];
	}
	
	
  	
   String[]  inParas = new String[4];
    inParas[0] = i_contract_no;
    inParas[1] = i_login_accept;
		inParas[2] = i_year_month;
		inParas[3] = workno;
		
		boolean canPrint = false;											//能否打印
	
%>
	<wtc:service name="s1321Init" routerKey="region" routerValue="<%=regionCode%>" outnum="24" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
		<wtc:param value="<%=inParas[2]%>"/>
		<wtc:param value="<%=inParas[3]%>"/>
	 
	</wtc:service>
 
	<wtc:array id="result" scope="end" start="0"  length="11" />
	<wtc:array id="result_pos" scope="end" start="11"  length="13" />
<%
	
	String[] inParas1 = new String[6];
    inParas1[0] = workno;
		inParas1[1] = i_contract_no;
    inParas1[2] = i_login_accept;
		inParas1[3] = i_year_month;
    inParas1[4] = "1321";
    inParas1[5] = nopass;

%>
	<wtc:service name="s1321Cfm" routerKey="region" routerValue="<%=regionCode%>" outnum="1" retcode="retCode1" retmsg="retMsg1">
		<wtc:param value="<%=inParas1[0]%>"/>
		<wtc:param value="<%=inParas1[1]%>"/>
		<wtc:param value="<%=inParas1[2]%>"/>
		<wtc:param value="<%=inParas1[3]%>"/>
		<wtc:param value="<%=inParas1[4]%>"/>
		<wtc:param value="<%=inParas1[5]%>"/>
	 
	</wtc:service>
	<wtc:array id="result3" scope="end"/>
<%
	System.out.print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"+retCode1);
	String return_code = retCode1;
	String return_msg  = retMsg1;

	if (return_code.equals("000000")||return_code.equals("0")) {
	    canPrint = true;
	}
		// canPrint = true;
	if (!canPrint) {%>
	   <script language="JavaScript">
	     rdShowMessageDialog("此用户无权限打印! ");
	     window.location="s1321_1.jsp";
	  </script>
	<% } else {%>

<SCRIPT language="JavaScript">

function ifprint(){

try {
<%
 System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
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

  out.println("printctrl.Print(13, 12, 9, 0,'"+"客户名称："+result[0][1]+"')");
  out.println("printctrl.Print(13, 13, 9, 0,'"+"业务类别：收据兑换等额发票')");
  out.println("printctrl.Print(125, 13, 9, 0,'客户品牌：')");
  
 
 
  out.println("printctrl.Print(13, 15, 9, 0,'用户号码："+result[0][2]+"')");	
  out.println("printctrl.Print(48, 15, 9, 0,'协议号码：')");	

  out.println("printctrl.Print(82, 15, 9, 0,'话费账期："+year+month+"')");
  out.println("printctrl.Print(115, 15, 9, 0,'合同号：')");
  out.println("printctrl.Print(115, 16, 9, 0,'支票号码：')");
 	out.println("printctrl.Print(115, 17, 9, 0,'集团统付号码:')");
  out.println("printctrl.Print(16, 18, 9, 0,'通信服务费合计：')");
        
  
  out.println("printctrl.Print(16, 19, 9, 0,'本次发票金额:(小写)￥"+result[0][6].trim()+"大写金额合计: "+result[0][5]+"')");
  out.println("printctrl.Print(16, 20, 9, 0,'')");
  out.println("printctrl.Print(13, 30, 9, 0,'流水号："+i_login_accept+"')");
  out.println("printctrl.Print(54, 30, 9, 0,'开票人："+workname+"')");
  out.println("printctrl.Print(85, 30, 9, 0,'工号："+workno+"')");
  out.println("printctrl.Print(110, 30, 9, 0,'营业厅："+s_yyt_name+"')");
  //new end

  
   System.out.println("bbbbbbbbbbbbbbbbbbbbbbbbbbb");
  out.println("printctrl.PageEnd()");
  out.println("printctrl.StopPrint()");
  
   System.out.println("ccccccccccccccccccccccccccccccccccc");
 %>
 		//alert("a");
		rdShowMessageDialog("打印成功!",2);
		document.location.replace("s1321_1.jsp");
} catch(e) {
} finally {
}

 

	
}


<%
    //发票电子化添加入库服务
		String[] inParas0 = new String[29];
		inParas0[0] =	i_login_accept;//流水
		inParas0[1] = "1321";//
		inParas0[2] = workno;
		inParas0[3] ="";//没有用
		inParas0[4] = result[0][2].trim();
		inParas0[5] = "0";//id_no 只是入表用 实在不行在程序里自己取一下
		inParas0[6] = i_contract_no;//contract_no
		 
		inParas0[7] = "";//支票号码
		//xl add 发票预占状态变更入参 begin
		//发票号码 发票金额 地市 group_id 备注 发票代码 
		inParas0[8] = check_seq;//发票号码;
		inParas0[9] = bill_code;//发票代码;
		inParas0[10] ="";//品牌
		inParas0[11] =result[0][6].trim();
		inParas0[12] =result[0][5].trim();
		inParas0[13] = "" ;
		
		//本次缴费金额 这个得看样张都有啥
		//xl add 发票预占状态变更入参 end


		inParas0[14] = "";//增值税的
		inParas0[15] = "0";//增值税的
		inParas0[16] = "0";//增值税的
		inParas0[17] = "0";//打印年月
		inParas0[18] = result[0][1].trim();//cust_name
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
					    document.location.replace("s1321_1.jsp");
					</script>
        <%			
			}
			
		}
		else if(RetResult == null || RetResult.length == 0){
%>
					<script language="JavaScript">
					    rdShowMessageDialog("电子发票入库失败,szg12InDB_pt服务返回结果为空.",0);
					    document.location.replace("s1321_1.jsp");
					</script>
<%			
		}	System.out.println("dddddddddddddddddddddddddddd");
%>			
		
</SCRIPT>
</SCRIPT>
<html>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<OBJECT
classid="clsid:0CBD5167-6DF3-45C4-AC69-852C6CB75D32"
codebase="/ocx/PrintEx.dll#version=1,1,0,5" style="display:none;"
id="printctrl"
VIEWASTEXT>
</OBJECT>
<body onload="ifprint()">

<form action="" name="form" method="post">
<input type="hidden" name="workno" value="<%=workno%>">
</form>
</body>
</html>
<% } %>