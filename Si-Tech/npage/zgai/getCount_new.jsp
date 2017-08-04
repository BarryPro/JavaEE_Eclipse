<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<%@ page contentType="text/html;charset=GB2312"%>
<%@ page errorPage="/page/common/errorpage.jsp" %>
<%@ page import="com.sitech.boss.amd.viewbean.*" %>
<%@ page import="com.sitech.boss.pub.CallRemoteResultValue" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<%	
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
    response.setDateHeader("Expires", 0); 
%>
<%
	String phoneNo = request.getParameter("phoneNo");
	String custPasswd = request.getParameter("password");
	String outNum = "6";
	String reqPass = request.getParameter("reqPass");
	String user_passwd =""; 
	String checkflag = "";
	/*
	String inParas[] = {"select to_char(a.contract_no),a.bank_cust from dConMsg a,dCustMsg b, dConUserMsg c where a.contract_no=c.contract_no and c.serial_no=0 and b.phone_no='"+phoneNo+"' and substr(b.run_code,2,1) < 'a' and b.id_no = c.id_no" };
	*/
	//xl add 10648开头的需要转义
	String [] paraIn = new String[2];
	if(phoneNo.substring(0,4)=="1064" ||phoneNo.substring(0,4).equals("1064"))
	{
		System.out.println("ccccccccccccccccccccccccccccccccccccccccccc 10648 111111111111111111111111");
		paraIn[0]="select trim(to_char(new_phoneno)) from dbbillprg.s_rs_iot_phonenoswitch_info where old_phoneno=:s_no";
		paraIn[1]="s_no="+phoneNo;
		%>
		<wtc:service name="TlsPubSelBoss"   retcode="retCodett" retmsg="retMsgtt" outnum="1" >
			<wtc:param value="<%=paraIn[0]%>"/>
			<wtc:param value="<%=paraIn[1]%>"/> 
		</wtc:service>
		<wtc:array id="resulttt" scope="end"/>
		<%
		if(resulttt.length==0)
		{
			%><script language="javascript">
				alert("请输入正确的物联网号码！");
				//window.location="e329_1.jsp?opCode=e329&opName=铁通交费信息查询&crmActiveOpCode=e329";
			  </script><%
		}
		else
		{
			phoneNo=resulttt[0][0];
		}
	}
	String sqlStr = "select to_char(a.contract_no),a.bank_cust,d.type_name,e.pay_name,to_char(a.owe_fee), b.user_passwd,b.sm_code from dConMsg a,dCustMsg b, dConUserMsg c,sAccountType d,sPayCode e where a.contract_no=c.contract_no and c.serial_no=0 and b.phone_no='"+phoneNo+"' and substr(b.run_code,2,1) < 'a' and b.id_no = c.id_no and a.account_type=d.account_type and e.region_code=substr(a.belong_code,1,2) and e.pay_code=a.pay_code";

	
    String inParas[] = {sqlStr};
	System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA "+sqlStr);
	
 
    %>
	<wtc:service name="TlsPubSelBoss"   outnum="7">
			<wtc:param value="<%=sqlStr%>"/>
	</wtc:service >
	<wtc:array id="result33"   scope="end" />
	<%
 	List result = new ArrayList();
 	String result1[][] = new String[][]{};
	String row[] = null;
	
	result1 = result33;

	if( (result1 == null) || (result1.length == 0) )
	{
%>
		<SCRIPT LANGUAGE="JavaScript">
			window.returnValue="0";
			window.close();
		</SCRIPT>
<%
	}
	else  
	{
		for(int i=0; i < result1.length; i++)
		{
			if(  ("Y".equals(reqPass) || "y".equals(reqPass)) )
		    {
		    	if(0==Encrypt.checkpwd1(custPasswd,result1[i][5]) )
		    	{
%>  		
		<SCRIPT LANGUAGE="JavaScript">
					window.returnValue="0";
					window.close();
		</SCRIPT>
<% 
		    	}
		     	
		    else{
		     		result.add(result1[i]);
					}
				}
		    else 
		    	{
		    	result.add(result1[i]);
					}
		}

		if ( result.size() == 0 )
		{
%>  		
		<SCRIPT LANGUAGE="JavaScript">
			window.returnValue="0";
			window.close();
		</SCRIPT>
<%  		
		}
		else if ( result.size() == 1 )
		{
%>  		
		<SCRIPT LANGUAGE="JavaScript">
			//alert("test "+"<%=result1[0][0].trim()%>");
			window.returnValue="<%=result1[0][0].trim()%>,<%=result1[0][6].trim()%>,<%=phoneNo%>";
			//alert(window.returnValue);
			window.close(); 
		</SCRIPT>
<%  		
		}
		else
		{
%>
 

<HTML><HEAD><TITLE>黑龙江BOSS-帐号查询</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<link rel="stylesheet" href="/css/jl.css" type="text/css">

<script language="JavaScript">
window.returnValue='';
function selAccount()
{	
     
       for(i=0;i<document.frm.account.length;i++) 
	  {		    
		      if (document.frm.account[i].checked==true)
		     {
 					 window.returnValue=document.frm.account[i].value;     
					 break;
			  }
	   } 
 		window.close(); 
}
	
 

 </script>

</head>

<BODY leftmargin="0" topmargin="0" background="/images/jl_background_2.gif">
<form name="frm" method="post" action="">

      
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" bgcolor="#FFFFFF">
    <tr> 
          <td align="center" width="30%"> 
            <table width="400" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="42"><img src="/images/jl_ico_2.gif" width="42" height="41"></td>
                <td valign="bottom" width="400"> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td background="/images/jl_background_4.gif"><font color="FFCC00"><b>帐号查询</b></font></td>
                      <td><img src="/images/jl_ico_3.gif" width="250" height="30"></td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
          <td width="70%"> 
            <table border="0" cellspacing="0" cellpadding="1" align="center">
              <tr>
                <td><img src="/images/jl_ico_6.gif" width="60" height="50"></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>

  <table width="100%" border="0"  bgcolor="#FFFFFF" align="center">
    <tr bgcolor="#649ECC"> 
      <td height="25" width="5%"> 
        <div align="center"> </div>
      </td>
      <td height="25" width="20%"> 
        <div align="center">帐号</div>
      </td>
      <td height="25"> 
        <div align="center">帐户名称</div>
      </td>

      <td height="25"> 
        <div align="center">帐户类型</div>
      </td>

	  <td height="25"> 
        <div align="center">付费方式</div>
      </td>

	  <td height="25"> 
        <div align="center">欠费</div>
      </td> 
	  <td height="25"> 
        <div align="center">品牌</div>
      </td>	
	  <td height="25"> 
        <div align="center">手机号码</div>
      </td>
    </tr>
    <% for(int i=0; i < result.size(); i++)
	{
    if (i==0) {checkflag="checked";}
    else {checkflag="";}
    row = (String[])result.get(i);
		%>
			<tr bgcolor="#F5F5F5"> 
			  <td height="25"> 
				<div align="center"> 
				  <input type="radio" name="account" value="<%=row[0].trim()%>,<%=row[6].trim()%>,<%=phoneNo%>"  <%=checkflag%>>
				</div>
			  </td>
			  <td height="25"> 
				<div align="center"><%=row[0]%></div>
			  </td>
			  <td height="25"> 
				<div align="center"><%=row[1]%></div>
			  </td>
			   <td height="25"> 
				<div align="center"><%=row[2]%></div>
			  </td>
			   <td height="25"> 
				<div align="center"><%=row[3]%></div>
			  </td>
			   <td height="25"> 
				<div align="center"><%=row[4]%></div>
			  </td>
			  <td height="25"> 
				<div align="center"><%=row[6]%></div>
			  </td>
			  <td height="25"> 
				<div align="center"><%=phoneNo%></div>
			  </td>
			</tr>
    <%}%>
 
    <tr> 
      <td bgcolor="#EEEEEE" colspan="6"> 
        <div align="center"> 
          <input class="button" type="button" name="Button" value="确定" onClick="selAccount()">
          <input class="button" type="button" name="return" value="返回" onClick="window.close()">
        </div>
      </td>
    </tr>
  </table>
  <p>&nbsp;</p>
</form>
</body>
</html>

<%		}
	}
%>
