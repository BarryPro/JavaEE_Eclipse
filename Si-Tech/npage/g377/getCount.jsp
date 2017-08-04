<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-15 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%
	String opCode = "1302";
	String opName="账号查询";
	String phoneNo = request.getParameter("phoneNo");
	String custPasswd = request.getParameter("password");
	String outNum = "6";
	String reqPass = request.getParameter("reqPass");
	String user_passwd ="";
	String checkflag = "";
	String[] inParas2 = new String[2];
	//inParas2[0]="select to_char(a.contract_no),a.bank_cust,d.type_name,b.user_passwd from dConMsg a,dCustMsg b, dConUserMsg c,sAccountType d where a.contract_no=c.contract_no and c.serial_no=0 and b.phone_no= :phone_no and b.id_no = c.id_no and a.account_type=d.account_type union all select to_char(a1.contract_no),a1.bank_cust,d1.type_name,b1.user_passwd from dConMsgdead a1,dCustMsgdead b1, sAccountType d1,dConUserMsgdead c1 where a1.contract_no=c1.contract_no and c1.serial_no=0 and b1.phone_no=:phone_no and b1.id_no = c1.id_no and a1.account_type = d1.account_type union all select to_char(a2.contract_no),a2.bank_cust,d2.type_name,b2.user_passwd from dConMsg a2,dCustMsgdead b2,sAccountType d2,dConUserMsgdead c2 where a2.contract_no = c2.contract_no and c2.serial_no=0 and b2.phone_no= :phone_no and b2.id_no=c2.id_no and a2.account_type=d2.account_type ";
	//inParas2[1]="phone_no="+phoneNo+",phone_no3="+phoneNo;
	//inParas2[1]=" phone_no="+phoneNo+",phone_no="+phoneNo+",phone_no="+phoneNo;
	inParas2[0]="select to_char(contract_no) from dagtbasemsg where agt_phone=:phone_No ";
	inParas2[1]="phone_No="+phoneNo;
	String sqlStr = "";
	System.out.println("AAAAAAAAAAAAAAAAAAAAAAAAAA inParas2[0]==="+inParas2[0]+" and inParas2[1] is "+inParas2[1]);
%>
	<wtc:service name="TlsPubSelBoss"  retcode="retCode1" retmsg="retMsg1" outnum="4">
	<wtc:param value="<%=inParas2[0]%>"/>
	<wtc:param value="<%=inParas2[1]%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
	String row[] = null;
	List result = new ArrayList(); 
	
	if( (result1 == null) || (result1.length == 0) )
	{
		
%>
		<SCRIPT LANGUAGE="JavaScript">
			window.returnValue="0";
			window.close();
		</SCRIPT>
<%
	return;
	}else{
		for(int i=0; i < result1.length; i++){
			if(  ("Y".equals(reqPass) || "y".equals(reqPass)) ){
		    if(0==Encrypt.checkpwd1(custPasswd,result1[i][5])){
%>  		
					<SCRIPT LANGUAGE="JavaScript">
						window.returnValue="0";
						window.close();
					</SCRIPT>
<% 
		    }else{
		     		result.add(result1[i]);
				}
			}else{
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
		}else if ( result.size() == 1 ){
%>  		
		<SCRIPT LANGUAGE="JavaScript">
			window.returnValue="<%=result1[0][0].trim()%>";
			window.close(); 
		</SCRIPT>
<%  		
		}else{
%>
 

<HTML><HEAD><TITLE>帐号查询</TITLE>

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

<BODY>
<form name="frm" method="post" action="">
	<%@ include file="/npage/include/header_pop.jsp" %>     	
		<div class="title">
			<div id="title_zi">帐号明细</div>
		</div>
	
  <table cellspacing="0">
    <tr align="center"> 
      <th>&nbsp;</th>
      <th>帐号</th>
      <th>帐户名称</th>
      <th>帐户类型</th>
	  <th>帐户密码</th>
    </tr>
  <% 
  	String tbClass="";
    for(int i=0; i < result.size(); i++)
	{
		if(i%2==0){
			tbClass="Grey";
		}else{
			tbClass="";
		}
    if (i==0) {checkflag="checked";}
    else {checkflag="";}
    row = (String[])result.get(i);
		%>
			<tr align="center"> 
			  <td class="<%=tbClass%>"> 
				<div align="center"> 
				  <input type="radio" name="account" value="<%=row[0].trim()%>"  <%=checkflag%>>
				</div>
			  </td>
			  <td class="<%=tbClass%>"> 
				<div align="center"><%=row[0]%></div>
			  </td>
			  <td class="<%=tbClass%>"> 
				<div align="center"><%=row[1]%></div>
			  </td>
			   <td class="<%=tbClass%>"> 
				<div align="center"><%=row[2]%></div>
			  </td>
			 <td class="<%=tbClass%>"> 
				<div align="center"><%=row[3]%></div>
			  </td>
			 
			</tr>
    <%}%>
 
    <tr> 
      <td colspan="6" id="footer"> 
          <input class="b_foot" type="button" name="Button" value="确定" onClick="selAccount()">
          <input class="b_foot" type="button" name="return" value="返回" onClick="window.close()">
      </td>
    </tr>
  </table>
  <%@ include file="/npage/include/footer_simple.jsp" %>
</form>
</body>
</html>

<%		
		}
	}
%>
