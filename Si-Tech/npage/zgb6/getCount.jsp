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
	String opCode = "zgb6";
	String opName="账号查询";
	String phoneNo = request.getParameter("phoneNo");
	String custPasswd = request.getParameter("password");
	String outNum = "6";
	String reqPass = request.getParameter("reqPass");
	String user_passwd ="";
	String checkflag = "";
	//判断本地 实名制 在网
	String[] inParas2_smz = new String[2];
	String regionCode = (String)session.getAttribute("regCode");
	inParas2_smz[0]="select to_char(substr(belong_code,0,2)),to_char(id_no) from dcustmsg where phone_no=:s_no";
	inParas2_smz[1]="s_no="+phoneNo;
	String s_id_no="";
	String s_belong_code="";
	String[] inParas2_zw = new String[2];
	String s_true_code="";//判断实名制
	%>
	<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
		<wtc:param value="<%=inParas2_smz[0]%>"/>
		<wtc:param value="<%=inParas2_smz[1]%>"/>
	</wtc:service>
	<wtc:array id="result2" scope="end" />
	<%
	if(result2.length>0)
	{
		s_belong_code=result2[0][0];
		s_id_no=result2[0][1];
		if(s_belong_code==regionCode ||s_belong_code.equals(regionCode))
		{
			inParas2_zw[0]="select to_char(true_code)  from dtruenamemsg where id_no=:s_id_no";
			inParas2_zw[1]="s_id_no="+s_id_no;
			%>
			<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode3" retmsg="retMsg3" outnum="1">
				<wtc:param value="<%=inParas2_zw[0]%>"/>
				<wtc:param value="<%=inParas2_zw[1]%>"/>
			</wtc:service>
			<wtc:array id="result3" scope="end" />
			<%
			if(result3.length>0)
			{
				s_true_code=result3[0][0];
			}
			else if(result3.length==0)
			{
				s_true_code="1";
			}
			else
			{
			}
		}
	}
	//end of 实名制判断
	if(s_true_code=="1" ||s_true_code.equals("1"))
	{
		String[] inParas2 = new String[2];
	inParas2[0]="select to_char(a.contract_no),a.bank_cust,d.type_name,e.pay_name,to_char(a.owe_fee), b.user_passwd from dConMsg a,dCustMsg b, dConUserMsg c,sAccountType d,sPayCode e where a.contract_no=c.contract_no and c.serial_no=0 and b.phone_no=:phone_no and substr(b.run_code,2,1) < 'a' and b.id_no = c.id_no and a.account_type=d.account_type and e.region_code=substr(a.belong_code,1,2) and e.pay_code=a.pay_code";
	inParas2[1]="phone_no="+phoneNo;
	String sqlStr = "";
	System.out.println("sqlStr==="+sqlStr);
%>
	<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="<%=phoneNo%>"  retcode="retCode1" retmsg="retMsg1" outnum="6">
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
		  <th>付费方式</th>
		  <th>欠费</th> 
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
			   <td class="<%=tbClass%>"> 
				<div align="center"><%=row[4]%></div>
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
 
	}
	else
	{
		%>
		<script language="javascript">
			rdShowMessageDialog("用户非实名制用户或非本地号码!");
			window.close();
		</script>
		<%
	}
	%>
