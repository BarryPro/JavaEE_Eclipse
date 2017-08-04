

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


<%
	String opCode="zgb5";
	String opName="退预存款(非实名)";
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
  	response.setDateHeader("Expires", 0); 
	String phoneNo = request.getParameter("phoneNo");
	String regionCode = (String)session.getAttribute("regCode");
	Map map = (Map)session.getAttribute("contactInfoMap");
	ContactInfo contactInfo = (ContactInfo) map.get(phoneNo);
	String custPasswd = request.getParameter("password");
	String reqPass = request.getParameter("reqPass");
	
	String[] inParam = new String[2];
	inParam[0]="select to_char(a.contract_no),a.bank_cust,to_char(b.open_time,'yyyymm'),b.user_passwd,to_char(b.id_no) from dConMsgDead a,dCustMsgDead b where a.contract_no=b.contract_no and b.phone_no=:s_phone_no order by b.open_time desc ";
	inParam[1]="s_phone_no="+phoneNo;
	String s_id_no="";
	
	List result = new ArrayList();
	String row[] = null;
	
//	String result1[][] = new String[][]{};
	String user_passwd = "";
//	ArrayList arlist = new ArrayList();
	String checkflag ="";
	String[] inParam_smz = new String[2];
%>
	<wtc:service name="TlsPubSelBoss"  routerKey="region" routerValue="<%=regionCode%>" outnum="5">
		<wtc:param value="<%=inParam[0]%>"/>
		<wtc:param value="<%=inParam[1]%>"/>
	</wtc:service>
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
		<script language="javascript">	
			window.returnValue="0";
			window.close();
		</script>
<%
	}
	else
	{
		//判断实名制信息
		//判断密码
		for(int i=0; i < result1.length; i++)
		{
			result.add(result1[i]);
		}
		//System.out.println("ffffffffffffffffff?????????? zgb5 result.size() is "+result.size());
		if ( result.size() == 0 )
		{
%>	
			<script language="javascript">
				window.returnValue="0";
				window.close();
			</script>
<%
		}
		else if ( result.size() == 1 )
		{
%>
			<script language="javascript">
				window.returnValue="<%=result1[0][0].trim()%>,<%=result1[0][3].trim()%>,<%=result1[0][4].trim()%>,<%=result1[0][2].trim()%>,<%=result1[0][1].trim()%>";
				window.close(); 
			</script>
<%
		}
	}
%>
    
 

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
					// alert("radio window.returnValue is "+window.returnValue);	
               }
			   }
		window.close(); 
	}

	function quit(){
		window.returnValue="0,0,0";
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
			<input type="radio" name="radio1" value="<%=row[0].trim()%>,<%=row[3].trim()%>,<%=row[4].trim()%>,<%=row[2].trim()%>,<%=row[1].trim()%>"  <%=checkflag%>>&nbsp;
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

