<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-15 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>

<%
	String e007 = "e007";
	String opName="��ͨ�ɷѳ���";
	String kd_phoneNo = "";
	// xl add new ���ݹ̻������ѯ ��ˮ
	String phone_new = request.getParameter("phoneNo");
	
	
	
	
	
	
	String custPasswd = request.getParameter("password");
	String outNum = "6";
	String reqPass = request.getParameter("reqPass");
	String user_passwd ="";
	String checkflag = "";
	
	String[] inParas = new String[2];
	inParas[0]="select to_char(a.contract_no),a.bank_cust,d.type_name,e.pay_name,to_char(a.owe_fee), b.user_passwd from dConMsg a,dCustMsg b, dConUserMsg c,sAccountType d,sPayCode e where a.contract_no=c.contract_no and c.serial_no=0 and b.phone_no=:phone_No and substr(b.run_code,2,1) < 'a' and b.id_no = c.id_no and a.account_type=d.account_type and e.region_code=substr(a.belong_code,1,2) and e.pay_code=a.pay_code";
	inParas[1]="phone_No="+phone_new;
	String sqlStr = "";
	System.out.println("sqlStr==="+sqlStr);
%>
	<wtc:service name="TlsPubSelBoss" routerKey="phone" routerValue="<%=phone_new%>"  retcode="retCode1" retmsg="retMsg1" outnum="6">
	 <wtc:param value="<%=inParas[0]%>"/>
	 <wtc:param value="<%=inParas[0]%>"/>
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
 

<HTML><HEAD><TITLE>�ʺŲ�ѯ</TITLE>

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
			<div id="title_zi">�ʺ���ϸ</div>
		</div>
	
  <table cellspacing="0">
    <tr align="center"> 
      <th>&nbsp;</th>
      <th>�ʺ�</th>
      <th>�ʻ�����</th>
      <th>�ʻ�����</th>
		  <th>���ѷ�ʽ</th>
		  <th>Ƿ��</th> 
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
          <input class="b_foot" type="button" name="Button" value="ȷ��" onClick="selAccount()">
          <input class="b_foot" type="button" name="return" value="����" onClick="window.close()">
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
