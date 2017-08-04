<%
    /********************
     * @ OpCode    :  8564
     * @ OpName    :  拆包资费查询
     * @ Services  :  s8564ModeQry,
     * @ Pages     :  s8564/f8564.jsp,
     * @ CopyRight :  si-tech
     * @ Author    :  huangrong
     * @ Date      :  2011-03-23
     * @ Update    :  
     ********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
  String opCode = "8564";
  String opName = "IMEI拆包查询";
	String workNo = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");	
	String op_name = "拆包资费查询";
	String regionCode = (String)session.getAttribute("regCode");
	String orgCode = (String)session.getAttribute("rogCode");
	String password  = (String)session.getAttribute("password");
	String phoneNo  = request.getParameter("phoneNo");
	String time  = request.getParameter("time"); 
  String[] paraAray1 = new String[9];  
  paraAray1[0] = "";	    /* 操作流水   */
  paraAray1[1] = "01";	    /* 渠道代码   */  
  paraAray1[2] = opCode; 	    /* 操作代码   */
  paraAray1[3] = workNo;	    /* 操作工号   */  
  paraAray1[4] = password;	    /* 工号密码   */  
  paraAray1[5] = phoneNo;		/* 手机号码   */ 
  paraAray1[6] = "";		/* 用户密码   */ 
  paraAray1[7] = "";	    /* 备注   */
  paraAray1[8] = time;	    /* 时间   */
 	  System.out.println("-----------------  paraAray1[8] -------------------------"+paraAray1[8] ); 
  
  
  for(int i=0; i<paraAray1.length; i++){		
		if( paraAray1[i] == null ){
		  paraAray1[i] = "";
		}
  }
 %>
		<wtc:service name="s8564ModeQry" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="11" >
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
		<wtc:param value="<%=paraAray1[3]%>"/>
		<wtc:param value="<%=paraAray1[4]%>"/>
		<wtc:param value="<%=paraAray1[5]%>"/>
		<wtc:param value="<%=paraAray1[6]%>"/>
		<wtc:param value="<%=paraAray1[7]%>"/>			
		<wtc:param value="<%=paraAray1[8]%>"/>					
		</wtc:service>
		<wtc:array id="s8564ModeQryArr1"  start="0" length="2" scope="end"/>
		<wtc:array id="s8564ModeQryArr2"  start="2" length="2" scope="end"/>	
		<wtc:array id="s8564ModeQryArr3"  start="4" length="7" scope="end"/>					
<%
	  String errCode = retCode1;
	  String errMsg = retMsg1;
	  System.out.println("-----------------errCode-------------------------"+errCode);
	  	  System.out.println("-----------------s8564ModeQryArr2.length -------------------------"+s8564ModeQryArr2.length );
  	if(!errCode.equals("000000")){
 %>
		<script language="JavaScript">
			<!--
	  		rdShowMessageDialog("错误代码：<%=errCode%>错误信息：<%=errMsg%>");
	  	 	history.go(-1);
	  	//-->
	  </script>
<%
  		return;
  	}
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=op_name%></title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<script language="JavaScript">
<!--

-->
</script>
</head>
<body>
<form name="frm" method="POST" action="">
<%@ include file="/npage/include/header.jsp"%>

<div class="title">
	<div id="title_zi">拆包资费查询</div>
</div>
<% if(s8564ModeQryArr2.length > 0){ %>
<table cellSpacing="0">
			<tr> 			    
			    <td align='center' class="Grey"><div><b><font color="blue">手机号码</font></b></div></td>  
			    <td align='center' class="Grey"><div><b><font color="blue">当前资费</font></b></div></td>   
			    <td align='center' class="Grey"><div><b><font color="blue">当前绑定的IMEI码</font></b></div></td>   
			    <td align='center' class="Grey"><div><b><font color="blue">是否是TD终端</font></b></div></td>   
			    <td align='center' class="Grey"><div><b><font color="blue">是否拆包</font></b></div></td>   
			    <td align='center' class="Grey"><div><b><font color="blue">用户拆包时间</font></b></div></td>   
			    <td align='center' class="Grey"><div><b><font color="blue">本月是否进行主动资费变更</font></b></div></td>   
			    <td align='center' class="Grey"><div><b><font color="blue">变更后资费</font></b></div></td>   
			    <td align='center' class="Grey"><div><b><font color="blue">本月申请变更时间</font></b></div></td>     
      </tr>
      <%  
         for(int i=0;i<s8564ModeQryArr2.length;i++){   
         String tdClass = "";            
         if (i%2==0){
             tdClass = "Grey";
         }
      %>
        <tr>
        	<td class="<%=tdClass%>" align="center" height="20"><%=phoneNo%>&nbsp;</td>
        	<td class="<%=tdClass%>" align="center" height="20"><%=s8564ModeQryArr1[0][1]%>&nbsp;</td>
        	<td class="<%=tdClass%>" align="center" height="20"><%=s8564ModeQryArr2[i][0]%>&nbsp;</td>
        	<td class="<%=tdClass%>" align="center" height="20"><%=s8564ModeQryArr2[i][1]%>&nbsp;</td>
        	<td class="<%=tdClass%>" align="center" height="20"><%=s8564ModeQryArr3[0][0]%>&nbsp;</td>
        	<td class="<%=tdClass%>" align="center" height="20"><%=s8564ModeQryArr3[0][1]%>&nbsp;</td>
        	<td class="<%=tdClass%>" align="center" height="20"><%=s8564ModeQryArr3[0][2]%>&nbsp;</td>
        	<td class="<%=tdClass%>" align="center" height="20"><%=s8564ModeQryArr3[0][4]%>&nbsp;</td>
        	<td class="<%=tdClass%>" align="center" height="20"><%=s8564ModeQryArr3[0][5]%>&nbsp;</td>
       </tr> 
<%
			}}else{ %>
			<tr>
			    <td colspan="6" style="color:red;text-align:center;">没有符合条件的数据!</td>
			</tr>
<% } %>
		</table>	
		
<table cellSpacing="0"> 
			<tr>
				<td id="footer">
					<div align="center">
						<input type="button" name="goback" value="返回" class="b_foot" onClick="location='f8564.jsp?activePhone=<%=phoneNo%>'"/>
						<input type="button" name="close" value="关闭" class="b_foot" onclick="removeCurrentTab()"/>
					</div>
				</td>
			</tr>
		</table>
	</form>
		<%@ include file="/npage/include/footer.jsp"%>
</body>
</html>

