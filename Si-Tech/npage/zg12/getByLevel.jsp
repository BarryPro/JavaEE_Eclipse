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
	String opCode = "zg12";
	String opName="纳税人信息查询";
	String phoneNo ="";
	String cust_id = request.getParameter("cust_id");
	String checkflag = "";
	String qry_flag= request.getParameter("qry_flag");
	String tax_no = request.getParameter("tax_no");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode = org_code.substring(0,2);
	String[] inParas2 = new String[2];
  System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa sTaxpayerRelQry cust_id is "+cust_id+" and qry_flag is "+qry_flag);
%>
	<wtc:service name="sTaxpayerRelQry" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="11">
			<wtc:param value="<%=cust_id%>"/>
			<wtc:param value="<%=qry_flag%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end"/>
 
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
			result.add(result1[i]);
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
			//alert("here is wrong 0 1 4 5 6 7 8");
			window.returnValue="<%=result1[0][0].trim()%>,<%=result1[0][1].trim()%>,<%=result1[0][4].trim()%>,<%=result1[0][5].trim()%>,<%=result1[0][6].trim()%>,<%=result1[0][7].trim()%>,<%=result1[0][8].trim()%>";
			window.close(); 
		</SCRIPT>
<%  		
		}else{
%>
 

<HTML><HEAD><TITLE>纳税人信息查询</TITLE>

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
			<div id="title_zi">纳税人信息明细</div>
		</div>
	
  <table cellspacing="0">
    <tr align="center"> 
      <th>&nbsp;</th>
      <th>客户标识</th>
      <th>纳税人识别号</th>
	  <th>公司名称</th>
	  <th>公司地址</th>
	  <th>联系电话</th>
	  <th>开户行</th>
	  <th>开户行帐号</th>
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
				  <input type="radio" name="account" value="<%=row[0].trim()%>,<%=row[1].trim()%>,<%=row[4].trim()%>,<%=row[5].trim()%>,<%=row[6].trim()%>,<%=row[7].trim()%>,<%=row[8].trim()%>,"  <%=checkflag%>>
				</div>
			  </td>
			  <td class="<%=tbClass%>"> 
				<div align="center"><%=row[0]%></div>
			  </td>
			  <td class="<%=tbClass%>"> 
				<div align="center"><%=row[1]%></div>
			  </td>
			   <td class="<%=tbClass%>"> 
				<div align="center"><%=row[4]%></div>
			  </td>
			   <td class="<%=tbClass%>"> 
				<div align="center"><%=row[5]%></div>
			  </td>
			   <td class="<%=tbClass%>"> 
				<div align="center"><%=row[6]%></div>
			  </td>
			  <td class="<%=tbClass%>"> 
				<div align="center"><%=row[7]%></div>
			  </td>
			  <td class="<%=tbClass%>"> 
				<div align="center"><%=row[8]%></div>
			  </td>
			</tr>
    <%}%>
 
    <tr> 
      <td colspan="8" id="footer"> 
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
