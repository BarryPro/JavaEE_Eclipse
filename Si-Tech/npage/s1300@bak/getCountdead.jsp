

<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * 功能: 账号查询
   * 版本: 1.0
   * 日期: 2008/12/22
   * 作者: leimd
   * 版权: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>

<script language="JavaScript">
<%
	String opCode="1362";
	String opName="退预存款";
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
  	response.setDateHeader("Expires", 0); 
	String phoneNo = request.getParameter("phoneNo");
	String regionCode = (String)session.getAttribute("regCode");
	Map map = (Map)session.getAttribute("contactInfoMap");
	ContactInfo contactInfo = (ContactInfo) map.get(phoneNo);
	String custPasswd = request.getParameter("password");
	String reqPass = request.getParameter("reqPass");
	String colNum = "4";
	String sqlStr = "select to_char(a.contract_no),a.bank_cust,to_char(b.open_time,'yyyy-mm-dd hh24:mi:ss'),b.user_passwd from dConMsgDead a,dCustMsgDead b where a.contract_no=b.contract_no and b.phone_no='?'";
	sqlStr += " order by b.open_time desc";
	System.out.println(sqlStr);
//	s1310Impl viewBean = new s1310Impl();//实例化viewBean
	
	List result = new ArrayList();
	String row[] = null;
	
//	String result1[][] = new String[][]{};
	String user_passwd = "";
//	ArrayList arlist = new ArrayList();
	String checkflag ="";
	
//	arlist = viewBean.s1330Query(colNum,sqlStr); 
%>
	<wtc:pubselect name="TlsPubSelBoss"  routerKey="region" routerValue="<%=regionCode%>" outnum="4">
   		<wtc:sql><%=sqlStr%></wtc:sql>
    <wtc:param value="<%=phoneNo%>"/>
    </wtc:pubselect>
    <wtc:array id="result1" scope="end" />
<%
	
//	int retval=Integer.parseInt((String)arlist.get(0));
	int retval= result1.length;
	System.out.println("retval==========="+retval);
//	System.out.println("tempArr==========="+tempArr[0][0]);
//	System.out.println("tempArr[0]==========="+tempArr.length);
//	System.out.println("tempArr==========="+tempArr[0][1]);
	if ( retval == 0 )
	{
%>
		
		window.returnValue="0";
		window.close();
<%
	}
	else
	{
	//	result1 = (String[][])arlist.get(1);
		//判断密码
		for(int i=0; i < result1.length; i++)
		{
			System.out.println("result1==========="+result1[0][0]);
			if(  ("Y".equals(reqPass) || "y".equals(reqPass)) )
			{
				if(0==Encrypt.checkpwd1(custPasswd,result1[i][3]) )
				{
         
%>  		
	
					window.returnValue="0";
					window.close();
		
<% 
				}
			else
					{
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
			window.returnValue="0";
			window.close();
<%
		}
		else if ( result.size() == 1 )
		{
%>
			window.returnValue="<%=result1[0][0].trim()%>";
			window.close(); 
<%
		}
	}
%>
    
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE><%=opName%></TITLE>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<script language="JavaScript">
	
function save_to(){	

      for(i=0;i<document.frm.elements.length;i++) 
		      if (document.frm.elements[i].name=="radio1"){
				   if (document.frm.elements[i].checked==true){
					 window.returnValue=document.frm.elements[i].value;     
               }
			   }
		window.close(); 
	}

	function quit(){
		window.close(); 
	}
</script>

</head>

<BODY>
<form name="frm" method="post" action="">
	<%@ include file="/npage/include/header_pop.jsp" %>
	<div class="title">
		<div id="title_zi">账号明细</div>
	</div>
<table cellspacing="0">
	<tr> 
		<th height="25" width="5%"> 
			<div align="center">&nbsp;</div>
		</th>
		<th>帐号</th> 
		<th>帐户名称</th> 
		<th>开户时间</th>
	</tr>
    <% 
    	String tbclass="";
    	for(int i=0; i < result.size(); i++){
		    if (i==0) {checkflag="checked";}
		    else {checkflag="";}
		    	row = (String[])result.get(i);
		    tbclass = (i%2==0)?"Grey":"";
    %>
	<tr> 
		<td align="center" class="<%=tbclass%>"> 
			<input type="radio" name="radio1" value="<%=row[0].trim()%>"  <%=checkflag%>>&nbsp;
		</td>
		<td align="center" class="<%=tbclass%>"><%=row[0]%>&nbsp;</td>
		<td align="center" class="<%=tbclass%>"><%=row[1]%>&nbsp;</td>
		<td align="center" class="<%=tbclass%>"><%=row[2]%>&nbsp;</td> 
	</tr>
    <%}
    %>
	<tr> 
		<td colspan="4" id="footer" align="center"> 
			<input class="b_foot" type="button" name="Button" value="确定" onClick="save_to()">
			<input class="b_foot" type="button" name="return" value="返回" onClick="quit()">
		</td>
	</tr>
</table>
  <%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>

