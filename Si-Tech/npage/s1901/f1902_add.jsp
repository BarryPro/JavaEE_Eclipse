<%
   /*
   * 功能: 集团协议录入
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
<script language="JavaScript" src="../../js/common/redialog/redialog.js"></script>
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

	Logger logger = Logger.getLogger("f1902_addjsp");
	
	String idNo = request.getParameter("idNo");   //获得关系编号
	String product_id = request.getParameter("product_id");   //获得关系编号
	
  	SPubCallSvrImpl impl = new SPubCallSvrImpl();
 	ArrayList acceptList = new ArrayList();
	String cust_id="";
	String id_no="";
	String unit_id="";
	String user_no="";
	String service_no="";
	String unit_name="";
	String sm_code="";
	String sm_name="";
	
	//获取协议状态类型列表
 	ArrayList retList2 = new ArrayList();  
	String sqlStr2="";
 	sqlStr2 ="SELECT agree_status_code,agree_status_name  FROM sAgreeStatusCode";
 	retList2 = impl.sPubSelect("2",sqlStr2,"region",regionCode);
 	String[][] retListString21 = (String[][])retList2.get(0);

	//获取集团信息
 	ArrayList retList1 = new ArrayList();  
	String sqlStr1="";
 	sqlStr1 ="SELECT a.cust_id,b.id_no,a.unit_id,b.user_no,service_no,a.unit_name,c.sm_code,c.sm_name FROM dGrpcustmsg a,dGrpusermsg b,ssmcode c WHERE a.cust_id = b.cust_id AND b.id_no = '"+idNo+"' AND b.sm_code=c.sm_code AND b.region_code=c.region_code";
 	retList1 = impl.sPubSelect("8",sqlStr1,"region",regionCode);
 	int errCode=impl.getErrCode();   
	String errMsg=impl.getErrMsg();
	
	try
	{
 		if(errCode==0)
 		{
 				String[][] retListString1 = (String[][])retList1.get(0);
 				cust_id=retListString1[0][0];
				id_no=retListString1[0][1];
				unit_id=retListString1[0][2];
				user_no=retListString1[0][3];
				service_no=retListString1[0][4];
				unit_name=retListString1[0][5];
				sm_code=retListString1[0][6];
				sm_name=retListString1[0][7];
		}
		else
		{		
%>  	
			 <script language='jscript'>
		          rdShowMessageDialog("错误代码：<%=errCode%>；错误信息：<%=errMsg%>");
		          history.go(-1);
		   	</script>
<%		}
	}
	catch(Exception e)
	{
		e.printStackTrace();
		logger.error("Call s1902AgrCfm is Failed!");
%>  	
		<script language='jscript'>
			rdShowMessageDialog("没有查询到集团信息");
			window.close();
		</script>
<%	
	}
%>
<html>
<head>
<base target="_self">
<title>集团协议-录入</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="/css/jl.css" rel="stylesheet" type="text/css">

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
	var deal_time=document.all.dealTime.value;
	//var input_date=document.all.inputDate.value;
	var complete_time=document.all.completeTime.value;
	//var logout_time=document.all.logoutTime.value;
	if(jtrim(document.all.dealTime.value)!="")
	{
		if (!validDate(document.all.dealTime))
		{
				rdShowMessageDialog("签约日期格式错误，请重新输入后提交");
				document.all.dealTime.focus();
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
		document.all.note.value="操作员<%=workNo%>对协议号："+document.all.agreeNo.value+"进行协议录入";
	}
	document.form1.action="f1902_submit_add.jsp"; 
	document.form1.submit();	
}

</script>
</head>
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
                      <td background="/images/jl_background_4.gif"><font color="FFCC00"><strong>集团协议-录入</strong></font></td>
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
		<input type="hidden" name="custId" value="<%=cust_id%>">
		<input type="hidden" name="idNo" value="<%=id_no%>">
		<input type="hidden" name="productId" value="<%=product_id%>">
		<TR>
			<TD>
			  <TABLE width="100%" align="center" id="mainOne" bgcolor="#FFFFFF" cellspacing="1" border="0">
	          <TBODY>
	          	 <TR bgcolor="#F5F5F5"> 			
				   	<TD>集团编号：</TD>
		            <TD>
		            	<input type="text" class="button" name="unitId" value="<%=unit_id%>" readonly>
		            </TD> 	              
					<TD>集团名称：</TD>
	            	<TD>
		              	<input type="text" class="button" name="unitName" value="<%=unit_name%>" size="30" readonly>		            	
	            	</TD> 
	            </TR>
	            <TR bgcolor="#F5F5F5"> 
					<TD width="15%">协议号：</TD>
	            	<TD width="35%">
		              	<input type="text" class="button" name="agreeNo" v_type="string" v_name="协议号" id="agreeNo" v_must="1" maxlength="30">		            	
	            		<font color="#FF0000">*</font>
	            	</TD>
	            	<TD width="15%">协议名称：</TD>
	            	<TD width="35%">
		              	<input type="text" class="button" name="agreeName" maxlength="100">		            	
	            	</TD>
	            </TR>
	            <TR bgcolor="#F5F5F5">
				   	<TD>协议状态：</TD>
		            <TD>
		              	<select name="agreeStatus" >
		              	<%
							for(int i=0;i < retListString21.length;i ++){
						%>
              				<option value='<%=retListString21[i][0]%>'><%=retListString21[i][1]%></option>
						<%
							}
						%>
		              	</select>
		            </TD>
		            <TD>产品名称：</TD>
		            <TD>
		            	
		              	<input type="text" class="button" name="productName" value="<%=sm_name%>" readonly>
		            </TD>
	            </TR>
	            <TR bgcolor="#F5F5F5"> 			
				   	<TD>项目经理：</TD>
		            <TD>
		              	<input type="text" class="button" name="itemManager" v_type="string" v_name="项目经理" id="itemManager" maxlength="6">
		            </TD> 	
		            <TD>联系人：</TD>
		            <TD>
		              	<input type="text" class="button" name="linkMan" >
		            </TD> 
	            </TR>
	            <TR bgcolor="#F5F5F5">
	            	<TD>联系人电话：</TD>
		            <TD colspan="3">
		              	<input type="text" class="button" name="linkPhone" v_type="phone" v_name="联系人电话" maxlength="15" >
		            </TD> 
	            </TR> 
	            <TR bgcolor="#F5F5F5"> 
				    
		            <TD>处理地址：</TD>
		            <TD colspan="3">
		              	<input type="text" class="button" name="dealAddress" size="60">
		            </TD> 
		        </TR>
	            <TR bgcolor="#F5F5F5">
	                <TD>签约日期：</TD>
	            	<TD>
		              	<input type="text" class="button" v_type="date" v_must="0" v_name="签约日期" name="dealTime" maxlength="8" >	
	            		<font color="#FF0000">*&nbsp;格式：yyyymmdd</font>
	            	</TD>
	            	<!--TD>录入日期：</TD>
	            	<TD>
		              	<input type="text" class="button" v_type="date" v_must="0" v_name="录入日期" name="inputDate" maxlength="8" >	
	            		<font color="#FF0000">*&nbsp;格式：yyyymmdd</font>
	            	</TD-->
					 <TD>到期日期：</TD>
	            	<TD>
		              	<input type="text" class="button" v_type="date" v_must="0" v_name="到期日期" name="completeTime" maxlength="8" >	
	            		<font color="#FF0000">*&nbsp;格式：yyyymmdd</font>
	            	</TD>
				</TR>
				<!--TR bgcolor="#F5F5F5">
					<TD>注销日期：</TD>
	            	<TD colspan="3">
		              	<input type="text" class="button" v_type="date" v_must="0" v_name="注销日期" name="logoutTime" maxlength="8" >	
	            		<font color="#FF0000">*&nbsp;格式：yyyymmdd</font>
	            	</TD> 
				</TR-->
				<TR bgcolor="#F5F5F5"> 	              
					<TD>协议状态描述：</TD>
	            	<TD colspan="3">
		              	<input type="text" class="button" name="agreeStatusDesc" value="" size="60" maxlength="100" >		            	
	            	</TD> 
	            </TR>
	            <TR bgcolor="#F5F5F5">
					<TD>备注：</TD>
	            	<TD colspan="3">
		              	<input type="text" class="button" v_type="string" v_must=0 v_name="备注" name="note" maxlength="60" size="60" >		            	
	            	</TD>
	            </TR>
	          </TBODY>
	        </TABLE> 
	        <TABLE width="100%" border=0 align="center" cellSpacing=1 bgcolor="#FFFFFF">
				<TR bgcolor="#F5F5F5">
				    <TD height="30" align="center"> 
				         <input name="queryButton" type="button" class="button" value="提交" onClick="if(check(form1)) modSubmit()">
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

