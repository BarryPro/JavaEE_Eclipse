<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-01-07
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>


<%	
        response.setHeader("Pragma","No-Cache"); 
	    response.setHeader("Cache-Control","No-Cache");
        response.setDateHeader("Expires", 0); 
%>
<%
    String opCode = "e329";
    String opName = "铁通交费信息查询";
	String phoneNo_tt = request.getParameter("phoneNo");
	String phoneNo="";
	String outNum = "5";
    
	//String inParas[] = {"select to_char(a.contract_no),a.bank_cust,d.type_name,e.pay_name,a.owe_fee from dConMsg a,dCustMsg b, dConUserMsg c,sAccountType d,sPayCode e where a.contract_no=c.contract_no and c.serial_no=0 and b.phone_no='"+phoneNo+"' and substr(b.run_code,2,1) < 'a' and b.id_no = c.id_no and a.account_type=d.account_type and e.region_code=substr(a.belong_code,1,2) and e.pay_code=a.pay_code"};

	//ScallSvrViewBean viewBean = new ScallSvrViewBean();//实例化viewBean
 	//CallRemoteResultValue value=  viewBean.callService("0",null,"sPubSelect",outNum, inParas); 
	//xl add for 铁通 begin

	String phone_trans="select phone_no from dbroadbandmsg where cfm_login='"+phoneNo_tt+"'  ";
	%>
	<wtc:service name="TlsPubSelCrm"   retcode="retCodett" retmsg="retMsgtt" outnum="1" >
    	<wtc:param value="<%=phone_trans%>"/>
    	 
    </wtc:service>
    <wtc:array id="resulttt" scope="end"/>
	<%
	if(resulttt.length==0)
	{
		%><script language="javascript">
			alert("此号码没有找到对应的帐号！");
			//window.location="e329_1.jsp?opCode=e329&opName=铁通交费信息查询&crmActiveOpCode=e329";
			</script><%
	}
	else
	{
		phoneNo=resulttt[0][0];
	}
	//xl add for 铁通 end
	 
    String sql = "select to_char(a.contract_no),a.bank_cust,d.type_name,e.pay_name,a.owe_fee from dConMsg a,dCustMsg b, dConUserMsg c,sAccountType d,sPayCode e where a.contract_no=c.contract_no and c.serial_no=0 and b.phone_no=:phoneNo and substr(b.run_code,2,1) < 'a' and b.id_no = c.id_no and a.account_type=d.account_type and e.region_code=substr(a.belong_code,1,2) and e.pay_code=a.pay_code";	
 	String [] paraIn = new String[2];
    paraIn[0] = sql;    
    paraIn[1]="phoneNo="+phoneNo;
%>
    <wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode" retmsg="retMsg" outnum="5" >
    	<wtc:param value="<%=paraIn[0]%>"/>
    	<wtc:param value="<%=paraIn[1]%>"/> 
    </wtc:service>
    <wtc:array id="result" scope="end"/>
<%
 	//String result[][]  = value.getData();
    
	//String inParas1[] = {"select to_char(a.contract_no),f.cust_name,d.type_name,e.pay_name,a.owe_fee from dConMsgDead a,dCustMsgDead b, dConUserMsgDead c,sAccountType d,sPayCode e,dcustdoc f where a.contract_no=c.contract_no and a.contract_no = f.cust_id and c.serial_no=0 and b.phone_no='"+phoneNo+"' and b.id_no = c.id_no and a.account_type=d.account_type and e.region_code=substr(a.belong_code,1,2) and e.pay_code=a.pay_code"};

	//value=  viewBean.callService("0",null,"sPubSelect",outNum, inParas1); 
	
    sql = "select to_char(a.contract_no),f.cust_name,d.type_name,e.pay_name,a.owe_fee from dConMsgDead a,dCustMsgDead b, dConUserMsgDead c,sAccountType d,sPayCode e,dcustdoc f where a.contract_no=c.contract_no and a.contract_no = f.cust_id and c.serial_no=0 and b.phone_no=:phoneNo and b.id_no = c.id_no and a.account_type=d.account_type and e.region_code=substr(a.belong_code,1,2) and e.pay_code=a.pay_code";	
    paraIn[0] = sql;    
    paraIn[1]="phoneNo="+phoneNo;
%>
    <wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode" retmsg="retMsg" outnum="5" >
    	<wtc:param value="<%=paraIn[0]%>"/>
    	<wtc:param value="<%=paraIn[1]%>"/> 
    </wtc:service>
    <wtc:array id="resultdead" scope="end"/>
<%
 	//String resultdead[][]  = value.getData();
%>

 
<%  if ((result.length + resultdead.length)==1 ) { %>      
 	<SCRIPT LANGUAGE="JavaScript">
        window.returnValue='';
        <%if (result.length == 1) {%>
            var temp = new Array();
            temp[0] = '<%=result[0][0].trim()%>';
	        temp[1] = '0';
	    
		    window.returnValue = temp;
			window.close();		    
		<%} else {%>
			var temp = new Array();
            temp[0] = '<%=resultdead[0][0].trim()%>';
	        temp[1] = '1';
	    
		    window.returnValue = temp;
			window.close();
       <%}%>
 	</SCRIPT>
<%  } else { %>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>黑龙江BOSS-帐号查询</TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<script language="JavaScript">
window.returnValue='';
function selAccount() {
	if(typeof(document.frm.account)!="undefined"){
	   for(i=0;i<document.frm.account.length;i++) {    
		  if (document.frm.account[i].checked==true) {
	 	    var temp = new Array();
	        temp[0] = document.frm.account[i].value;
		    temp[1] = document.frm.userType.value;
		    
			window.returnValue = temp;
	        break;
		  }
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
	<div id="title_zi">客户信息</div>
</div>
<input type="hidden" name="userType" value="">
      
  
  <table cellSpacing=0>
    <tr> 
      <th> 
        <div align="center">&nbsp;</div>
      </th>
      <th> 
        <div align="center">帐号</div>
      </th>
      <th> 
        <div align="center">帐户名称</div>
      </th>

      <th> 
        <div align="center">帐户类型</div>
      </th>

	  <th> 
        <div align="center">付费方式</div>
      </th>

	  <th> 
        <div align="center">欠费</div>
      </th> 

    </tr>
    <% for(int i=0; i < result.length  ; i++)
	{
		%>
			<tr> 
			  <td > 
				<div align="center"> 
				  <input type="radio" name="account" value="<%=result[i][0].trim()%>" onClick="JavaScript:document.frm.userType.value='0'">
				</div>
			  </td>
			  <td > 
				<div align="center"><%=result[i][0]%></div>
			  </td>
			  <td > 
				<div align="center"><%=result[i][1]%></div>
			  </td>
			   <td > 
				<div align="center"><%=result[i][2]%></div>
			  </td>
			   <td > 
				<div align="center"><%=result[i][3]%></div>
			  </td>
			   <td > 
				<div align="center"><%=result[i][4]%></div>
			  </td>
			</tr>
    <%}%>

	<% for(int i=0; i < resultdead.length  ; i++)
	{
		%>
			<tr> 
			  <td > 
				<div align="center"> 
				  <input type="radio" name="account" value="<%=resultdead[i][0].trim()%>" onClick="JavaScript:document.frm.userType.value='1'">
				</div>
			  </td>
			  <td> 
				<div align="center"><%=resultdead[i][0]%></div>
			  </td>
			  <td> 
				<div align="center"><%=resultdead[i][1]%></div>
			  </td>
			   <td > 
				<div align="center"><%=resultdead[i][2]%></div>
			  </td>
			   <td> 
				<div align="center"><%=resultdead[i][3]%></div>
			  </td>
			   <td > 
				<div align="center"><%=resultdead[i][4]%></div>
			  </td>
			</tr>
    <%}%>
 
    <tr> 
      <td id="footer" colspan="6"> 
          <input class="b_foot" type="button" name="Button" value="确定" onClick="selAccount()">
          <input class="b_foot" type="button" name="return" value="返回" onClick="window.close()">
      </td>
    </tr>
  </table>
  <%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>
<%}%>

