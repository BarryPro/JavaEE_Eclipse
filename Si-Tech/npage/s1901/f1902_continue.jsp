<%
   /*
   * 功能: 集团合同协议续签-修改
　 * 版本: v1.0
　 * 日期: 2006/08/14
　 * 作者: shibo
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>

<%@ page import="com.sitech.boss.spubcallsvr.viewBean.SPubCallSvrImpl" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=gb2312" %>

<%	
	//读取用户session信息
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfo = (String[][])arrSession.get(0);
	String workNo   = baseInfo[0][2];                 //工号
	String workName = baseInfo[0][3];               	//工号姓名
	String org_code = baseInfo[0][16];
	String ip_Addr  = request.getRemoteAddr();
	String[][] pass = (String[][])arrSession.get(4);   
	String nopass  = pass[0][0];                     //登陆密码
	String regionCode=org_code.substring(0,2);

	Logger logger = Logger.getLogger("f1902_continue.jsp");
	String agreeId = request.getParameter("agreeId");   //获得关系编号
	
  SPubCallSvrImpl impl = new SPubCallSvrImpl();
 	ArrayList acceptList = new ArrayList();


	//获取客户关系类型列表
 	ArrayList retList1 = new ArrayList();  
	String sqlStr1="";
 	sqlStr1 ="SELECT agree_status_code,agree_status_name  FROM sAgreeStatusCode";
 	retList1 = impl.sPubSelect("2",sqlStr1,"region",regionCode);
 	String[][] retListString1 = (String[][])retList1.get(0);
	
	
	
	//查看集团协议的具体内容
  	String paraArr[] = new String[5];
	paraArr[0] = workNo;
	paraArr[1] = nopass;
	paraArr[2] = "1902";
	paraArr[3] = "";
	paraArr[4] = agreeId;
						
	acceptList = impl.callFXService("s1902Qry",paraArr,"18");
	int errCode=impl.getErrCode();   
	String errMsg=impl.getErrMsg(); 
	
	String agree_id="";
	String agree_no="";
	String cust_id="";
	String id_no="";
	String agree_name="";
	String agree_status="";
	String item_manager="";
	String service_no="";
	String note="";
	String link_man="";
	String agree_status_desc="";
	String deal_address="";
	String deal_time="";
	String complete_time="";
	String input_date="";
	String logout_time="";
	String unit_name="";
	String link_phone="";

%>

<html>
<head>
<base target="_self">
<title>集团协议-续签</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/css/jl.css" rel="stylesheet" type="text/css">
<script language="JavaScript" src="../../js/common/redialog/redialog.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_single.js"></script>
<script language="JavaScript"> 

/*--------- 提交修改页面 -------------*/
function modSubmit()
{
	if(!checkElement("agreeNo"))
	{
		return;	
	}
	/*if(fucPWDchk(document.all.itemManager.value)==0)
	{
		rdShowMessageDialog("项目经理只请输入工号，只允许输入数字和字母！");
		return;	
	}*/
	var deal_time=document.all.dealTime.value;
	var input_date=document.all.inputDate.value;
	var complete_time=document.all.completeTime.value;
	var logout_time=document.all.logoutTime.value;
	if(jtrim(document.all.dealTime.value)!="")
	{
		if (!validDate(document.all.dealTime))
		{
				rdShowMessageDialog("签约日期格式错误，请重新输入后提交");
				document.all.dealTime.focus();
				return false;
		}
	}
	if(jtrim(document.all.inputDate.value)!="")
	{
		if (!validDate(document.all.inputDate))
		{
				rdShowMessageDialog("录入日期格式错误，请重新输入后提交");
				document.all.inputDate.focus();
				return false;
		} 
	}
	if(jtrim(document.all.completeTime.value)!="")
	{
		if (!validDate(document.all.completeTime))
		{
				rdShowMessageDialog("到期日期格式错误，请重新输入后提交");
				document.all.completeTime.focus();
				return false;
		}
	}
	if(jtrim(document.all.logoutTime.value)!="")
	{
		if (!validDate(document.all.logoutTime))
		{
				rdShowMessageDialog("注销日期格式错误，请重新输入后提交");
				document.all.logoutTime.focus();
				return false;
		}
	}
	if(deal_time!="" && complete_time!="")
	{
		if(deal_time>complete_time)
		{
			rdShowMessageDialog("签约日期不允许比到期日期晚");
			document.all.dealTime.focus();
			return false;
		}
	} 
	
	if(document.all.note.value==""){
		document.all.note.value="操作员"+"<%=workNo%>"+"对协议号"+"<%=agree_no%>"+"进行续签";
	}
	document.form1.action="f1902_submit_mod.jsp"; 
	document.form1.submit();	
}

</script>
</head>
<%

	
	if(errCode==0){
	
		String[][] tmpresult0=(String[][])acceptList.get(0);
		String[][] tmpresult1=(String[][])acceptList.get(1);
		String[][] tmpresult2=(String[][])acceptList.get(2);
		String[][] tmpresult3=(String[][])acceptList.get(3);
		String[][] tmpresult4=(String[][])acceptList.get(4);
		String[][] tmpresult5=(String[][])acceptList.get(5);
		String[][] tmpresult6=(String[][])acceptList.get(6);
		String[][] tmpresult7=(String[][])acceptList.get(7);	
		String[][] tmpresult8=(String[][])acceptList.get(8);	
		String[][] tmpresult9=(String[][])acceptList.get(9);
		String[][] tmpresult10=(String[][])acceptList.get(10);
		String[][] tmpresult11=(String[][])acceptList.get(11);
		String[][] tmpresult12=(String[][])acceptList.get(12);
		String[][] tmpresult13=(String[][])acceptList.get(13);
		String[][] tmpresult14=(String[][])acceptList.get(14);
		String[][] tmpresult15=(String[][])acceptList.get(15);
		String[][] tmpresult16=(String[][])acceptList.get(16);
		String[][] tmpresult17=(String[][])acceptList.get(17);

		agree_id=tmpresult0[0][0].trim();
		agree_no=tmpresult1[0][0].trim();
		cust_id=tmpresult2[0][0].trim();
		id_no=tmpresult3[0][0].trim();
		agree_name=tmpresult4[0][0].trim();
		agree_status=tmpresult5[0][0].trim();
		item_manager=tmpresult6[0][0].trim();
		service_no=tmpresult7[0][0].trim();
		note=tmpresult8[0][0].trim();
		link_man=tmpresult9[0][0].trim();
		agree_status_desc=tmpresult10[0][0].trim();
		deal_address=tmpresult11[0][0].trim();
		deal_time=tmpresult12[0][0].trim().equals("")==true?"":tmpresult12[0][0].trim().substring(0,8);
		complete_time=tmpresult13[0][0].trim().equals("")==true?"":tmpresult13[0][0].trim().substring(0,8);
		input_date=tmpresult14[0][0].trim().equals("")==true?"":tmpresult14[0][0].trim().substring(0,8);
		logout_time=tmpresult15[0][0].trim().equals("")==true?"":tmpresult15[0][0].trim().substring(0,8);
		unit_name=tmpresult16[0][0].trim();
		link_phone=tmpresult17[0][0].trim();
		}
	else{
%>
		<script language="javascript" >
			rdShowMessageDialog("错误代码：<%=errCode%>,错误信息：<%=errMsg%>");
		</script>
<%
}
%>	
		

<body bgcolor="#FFFFFF" text="#000000" background="/images/jl_background_2.gif" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  >

<table width="767" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr>
    <td width="764" height="224" background="/images/jl_background_1.gif"> 
	  <table align="center" width="98%"  bgcolor="#ffffff">
        <tr>
          <td align="right" width="73%">
            <table width="535" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="42"><img src="/images/jl_ico_2.gif" width="42" height="41"></td>
                <td valign="bottom" width="493">
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr>
                      <td background="/images/jl_background_4.gif"><font color="FFCC00"><strong>集团协议-续签</strong></font></td>
                      <td><img src="/images/jl_ico_3.gif" width="240" height="30"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
          <td width="27%">
            <table border="0" cellspacing="0" cellpadding="4" align="right">
              <tr>

                <td><img src="/images/jl_ico_4.gif" width="60" height="50"></td>
                <td><img src="/images/jl_ico_5.gif" width="60" height="50"></td>
                <td><img src="/images/jl_ico_6.gif" width="60" height="50"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>

	<TABLE width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
	<form name="form1"  method="post">
		<input type="hidden" name="agreeId" value="<%=agree_id%>">
		<input type="hidden" name="custId" value="<%=cust_id%>">
		<input type="hidden" name="idNo" value="<%=id_no%>">
		<input type="hidden" class="button" v_type="date" v_must="1" v_name="注销日期" name="logoutTime" maxlength="8" value="<%=logout_time%>" >	
		<TR>
			<TD>
			  <TABLE width="100%" align="center" id="mainOne" bgcolor="#FFFFFF" cellspacing="1" border="0">
	          <TBODY>
	            <TR bgcolor="#F5F5F5"> 
					<TD width="15%">协议号：</TD>
	            	<TD width="35%">
		              	<input type="text" class="button" name="agreeNo"  value="<%=agree_no%>"　v_type="0_9" v_name="协议号" id="agreeNo" maxlength="30" readonly>		            	
	            	</TD>
	            	<TD width="15%">协议名称：</TD>
	            	<TD width="35%">
		              	<input type="text" class="button" name="agreeName"  value="<%=agree_name%>" maxlength="100" readonly>		            	
	            	</TD>
	            </TR>
	            <TR bgcolor="#F5F5F5"> 			
				   	<TD>协议状态：</TD>
		            <TD>
		              	<select name="agreeStatus">
		              	<%
							for(int i=0;i < retListString1.length;i ++){
						%>
              				<option value='<%=retListString1[i][0]%>'><%=retListString1[i][1]%></option>
						<%
							}
						%>
		              	</select>
		            </TD> 	              
					<TD>集团名称：</TD>
	            	<TD>
		              	<input type="text" class="button" name="unitName" value="<%=unit_name%>"  size="30" readonly>		            	
	            	</TD> 
	            </TR>
	            <TR bgcolor="#F5F5F5"> 			
				   	<TD>项目经理：</TD>
		            <TD>
		              	<input type="text" class="button" name="itemManager" value="<%=item_manager%>" v_type="string" v_name="项目经理" id="itemManager" maxlength="20">
		            </TD> 	              
					<TD>服务经理：</TD>
	            	<TD>
		              	<input type="text" class="button" name="serviceNo" value="<%=service_no%>" readonly>		            	
	            	</TD> 
	            </TR>
	            <TR bgcolor="#F5F5F5"> 
				    <TD>联系人：</TD>
		            <TD>
		              	<input type="text" class="button" name="linkMan" value="<%=link_man%>" >
		            </TD>
		            <TD>联系人电话：</TD>
		            <TD>
		              	<input type="text" class="button" name="linkPhone" v_type="phone" v_name="联系人电话" maxlength="15" value="<%=link_phone%>">
		            </TD>
		        </TR>
	            <TR bgcolor="#F5F5F5">  
		            <TD>处理地址：</TD>
		            <TD colspan="3">
		              	<input type="text" class="button" name="dealAddress" value="<%=deal_address%>" size="60">
		            </TD> 
		        </TR>
	            <TR bgcolor="#F5F5F5">
	                <TD>签约日期：</TD>
	            	<TD>
		              	<input type="text" class="button" v_type="date" v_must="1" v_name="签约日期" name="dealTime" maxlength="8" value="<%=deal_time%>" readonly>	
		              	<font color="#FF0000">*&nbsp;格式：yyyymmdd</font>	            	
	            	</TD>
	            	<TD>录入日期：</TD>
	            	<TD>
		              	<input type="text" class="button" v_type="date" v_must="1" v_name="录入日期" name="inputDate" maxlength="8" value="<%=input_date%>" readonly>	
		              	<font color="#FF0000">*&nbsp;格式：yyyymmdd</font>	            	
	            	</TD>
				</TR>
				<TR bgcolor="#F5F5F5">
	                <TD>到期日期：</TD>
	            	<TD colspan="3">
		              	<input type="text" class="button" v_type="date" v_must="1" v_name="到期日期" name="completeTime" maxlength="8" value="<%=complete_time%>" >	
		              	<font color="#FF0000">*&nbsp;格式：yyyymmdd</font>	            	
	            	</TD> 
					<!--TD>注销日期：</TD>
	            	<TD>
		              	<input type="text" class="button" v_type="date" v_must="1" v_name="注销日期" name="logoutTime" maxlength="8" value="<%=logout_time%>" >	
		              	<font color="#FF0000">*&nbsp;格式：yyyymmdd</font>	            	
	            	</TD--> 
				</TR>
				<TR bgcolor="#F5F5F5"> 	              
					<TD>协议状态描述：</TD>
	            	<TD colspan="3">
		              	<input type="text" class="button" name="agreeStatusDesc" value="<%=agree_status_desc%>" >		            	
	            	</TD> 
	            </TR>
	            <TR bgcolor="#F5F5F5">
					<TD>备注：</TD>
	            	<TD colspan="3">
		              	<input type="text" class="button" v_type="string" v_must=0 v_name="备注" name="note" maxlength="60" size="60" value="<%=note%>">		            	
	            	</TD>
	            </TR>
	          </TBODY>
	        </TABLE> 
	        <TABLE width="100%" border=0 align="center" cellSpacing=1 bgcolor="#FFFFFF">
				<TR bgcolor="#F5F5F5">
				    <TD height="30" align="center"> 
				         <input name="queryButton" type="button" class="button" value="提交" onClick="if(check(form1)) modSubmit()"　>
				         &nbsp; 
				         <input name="addButton" type="button" class="button" value="取消" onClick="window.close()" >
				         &nbsp; 		         	   
					</TD>
				</TR>
		   	</TABLE>
					<BR>
					<BR>		
			</TD>
		</TR>
	</form>
	</TABLE>

</body>
</html>
<script language='javascript'>
	document.all.agreeStatus.value="03";
</script>
