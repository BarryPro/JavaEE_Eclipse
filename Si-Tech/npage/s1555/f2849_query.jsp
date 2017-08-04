<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
<%
  response.setDateHeader("Expires", 0);
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%		
  String opCode = "2849";
  String opName = "垃圾短信集团反馈结果信息查询";	
  String loginNo = (String)session.getAttribute("workNo");
  String loginName =(String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String ip_Addr = request.getRemoteAddr();  
  String strRegionCode = orgCode.substring(0,2);
  String loginNoPass = (String)session.getAttribute("password");
  String IccId = ""; 
  String mark = ""; 
  String cust_address = "";
  String shorttype = "";
  
%>
<%
  String retFlag="";
  String retMsg="";//用于判断页面刚进入时的正确性
  
  String strPhoneNo = request.getParameter("phone_no");
  String strProsDate = request.getParameter("pros_date");
  String strProsContent = request.getParameter("pros_content"); 
  
   //取用户基本信息
									
	String notestr="根据phone_no==["+strPhoneNo+"]进行查询";
	String strCustName = "";
	String strIdIccid = "";
	String strIdAddress = "";
%>
<wtc:service name="sUserCustInfo" routerKey="region" routerValue="<%=strRegionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="100" >
  <wtc:param value="0"/>
  <wtc:param value="01"/>
  <wtc:param value="<%=opCode%>"/>
  <wtc:param value="<%=loginNo%>"/>	
  <wtc:param value="<%=loginNoPass%>"/>		
  <wtc:param value="<%=strPhoneNo%>"/>	
  <wtc:param value=""/>
  <wtc:param value=""/>
  <wtc:param value="<%=notestr%>"/>
  <wtc:param value=""/>
  <wtc:param value=""/>
  <wtc:param value=""/>
  <wtc:param value=""/>
</wtc:service>
<wtc:array id="returnFlag" start="0" length="1" scope="end"/>
<wtc:array id="result1" start="1" length="40" scope="end"/>
<%					
  if("000000".equals(retCode1)){
    if(result1.length>0){
      if("00".equals(returnFlag[0][0])){
  	   	strCustName = (result1[0][4]).trim();
        strIdIccid = (result1[0][12]).trim();
        strIdAddress = (result1[0][13]).trim();
      }
    }
  }
  

  String bp_name = "";
  String passwordFromSer = "";

  
	//设置title
	String titlename = "垃圾短信集团反馈结果信息查询";  //窗体名称
	String op_code = "";  //op_code
	
 	int j=0;
  
 	String[] paraAray1 = new String[5];
  paraAray1[0] = loginNo; 			/* 操作工号   */
  paraAray1[1] = loginNoPass; 	/* 操作工号   */
  paraAray1[2] = strPhoneNo;		/* 手机号码   */ 
  paraAray1[3] = strProsDate;		
  paraAray1[4] = strProsContent;

  for(int i=0; i<paraAray1.length; i++)
  {		
		if( paraAray1[i] == null )
		{
	  	paraAray1[i] = "";
		}
  }
  System.out.println("123");
  //retList = impl.callFXService("sSMProsQry", paraAray1, "30","phone",strPhoneNo);
%>
           <wtc:service name="sSMProsQry" routerKey="regionCode" routerValue="<%=strRegionCode%>"  retcode="errCode" retmsg="errMsg"  outnum="30" >
			       <wtc:param value="<%=paraAray1[0]%>"/>
			       <wtc:param value="<%=paraAray1[1]%>"/>
			       <wtc:param value="<%=paraAray1[2]%>"/>
			       <wtc:param value="<%=paraAray1[3]%>"/>
			       <wtc:param value="<%=paraAray1[4]%>"/>
		</wtc:service>
		<wtc:array id="tmpresult1" start="3" length="1" scope="end" />
		<wtc:array id="tmpresult2" start="0" length="1" scope="end" />
		<wtc:array id="tmpresult3" start="26" length="1" scope="end" />
		<wtc:array id="tmpresult4" start="1" length="1" scope="end" />
		<wtc:array id="tmpresult5" start="4" length="1" scope="end" />
		<wtc:array id="tmpresult6" start="10" length="1" scope="end" />
		<wtc:array id="tmpresult7" start="17" length="1" scope="end" />
		<wtc:array id="tmpresult8" start="12" length="1" scope="end" />
		<wtc:array id="tmpresult9" start="14" length="1" scope="end" />
		<wtc:array id="tmpresult10" start="28" length="1" scope="end" />
<%
  if(tmpresult1 == null)
  {
		retFlag = "1";
	  retMsg = "s2266Init查询号码基本信息为空!<br>" + "errCode: " + errCode + "<br>errMsg: " +  errMsg;
  }else if(!(tmpresult1 == null))
  {
  	if (!errCode.equals("000000")){
	  	retFlag = "1";
	    retMsg = "s2266Init查询用户垃圾短信集团反馈结果信息失败!<br>" + "errCode: " + errCode + "<br>errMsg: " +  errMsg;
   	}		
  }
//********************得到营业员权限，核对密码，并设置优惠权限*****************************// 
   //优惠信息
  
   String handFee_Favourable = "readonly";        //a230  手续费
//begin add by diling for 对密码权限整改 @2011/11/1 
    boolean pwrf = false;
	String pubOpCode = opCode;
%>
	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<%
    System.out.println("==第三批======f2849_query.jsp==== pwrf = " + pwrf);
//end add by diling  
  
  String passTrans=WtcUtil.repNull(request.getParameter("cus_pass")); 
  if(!pwrf)
  {
    System.out.println("enter");

	    
	   String passFromPage=Encrypt.encrypt(passTrans);
	    
     if(0==Encrypt.checkpwd2(passwordFromSer.trim(),passFromPage))	
	   {
	    System.out.println("passFromPage="+passFromPage);
	    System.out.println("passwordFromSer="+passwordFromSer);

       retFlag = "1";
       retMsg = "密码错误!";
	  }
  }
  
if (pwrf){
System.out.println("2password is ture");
}else{
	System.out.println("2password is false");
} 
  
  /****得到打印流水****/
  String printAccept="";
  printAccept = getMaxAccept();
	

%>
<head>
<title><%=titlename%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript" src="<%=request.getContextPath()%>/npage/s1400/pub.js"></script>
 
<script language="JavaScript">
  <%if(retFlag.equals("1")){%>
    rdShowMessageDialog("<%=retMsg%>");
    history.go(-1);
  <%}%>
<!--
  //定义应用全局的变量
  var SUCC_CODE	= "0";   		//自己应用程序定义
  var ERROR_CODE  = "1";			//自己应用程序定义
  var YE_SUCC_CODE = "0000";	 	//根据营业系统定义而修改

 
//-->
</script>

</head>


<body>
<form name="frm" method="post"  >
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">垃圾短信集团反馈结果信息查询</div>
	</div>
      <table cellspacing="0">
		  <tr> 
            <td class="blue">举报号码</td>
            <td>
			    <input name="phoneNo" type="text" class="button" id="phoneNo" value="<%=strPhoneNo%>" readonly> 
            <td class="blue">客户名称</td>
            <td>
			  <input name="bp_name" type="text" class="button" id="bp_name" size="60" value="<%=strCustName%>" readonly> 
			</td>  
          </tr>
      </table>
     <table cellspacing="0">
		  <tr> 
     		<td class="blue">身份证号</td>
     		<td>
  			<input name="IccId" type="text" class="button" id="IccId" value="<%=strIdIccid%>" readonly> 
			</td>
			<td class="blue">客户地址</td>
      <td>
			  <input name="cust_address" type="text" class="button" id="cust_address" size="60" value="<%=strIdAddress%>" readonly> 
			</td>  
      </tr>
      </table>
 
	<TABLE cellspacing="0">
   	<TBODY> 
			<tr >
		  	<td colspan="10"></td>
		  </tr>
		  <tr>
			  <th  align=center>举报内容</th>
			  <th  align=center>举报时间</th>
			  <th align=center >举报途径</th>
			  <th  align=center>被举报号码</th>
			  <th align=center >处理意见</th>
			  <th align=center >举报内容分类</th>
			  <th  align=center>被举报CP简称</th>
			  <th align=center >被举报号码归属运营商</th>
			  <th align=center >归属地</th>
			  <th align=center >短信反馈</th>
		  </tr>
      <% 
			for(j=0;j<tmpresult1.length;j++){
		  %>
			<tr bgcolor="#F5F5F5" height="20">
				<TD ><%=tmpresult1[j][0]%></TD>
				<TD ><%=tmpresult2[j][0]%></TD>
				<TD ><%=tmpresult3[j][0]%></TD>
				<TD ><%=tmpresult4[j][0]%></TD>
				<TD ><%=tmpresult5[j][0]%></TD>
				<TD ><%=tmpresult6[j][0]%></TD>
				<TD ><%=tmpresult7[j][0]%></TD>
				<TD ><%=tmpresult8[j][0]%></TD>
				<TD ><%=tmpresult9[j][0]%></TD>
				<TD ><%=tmpresult10[j][0]%></TD>
			</tr>				
			<%}%>  		
 		</TBODY>
	</TABLE>			 
  <table cellspacing="0">

    <tr id="footer"> 
    	<td colspan="4"> 
				<div align="center"> 
				<input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="返回">
					&nbsp; 				
				</div>
			</td>
   	</tr>
	</TABLE>  
	  <%@ include file="/npage/include/footer.jsp" %>  
</form>
</body>
</html>

