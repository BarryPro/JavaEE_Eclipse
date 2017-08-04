<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
/*
 *黑名单次数查询 
 *
 *版权：si-tech
 *
 *update:fengcj 2014-11-5
 *
 *content:
 */
%>

<%
	String opCode = "m291";
	String opName = "黑名单查询";
	String workNo = (String) session.getAttribute("workNo");
	String nopass = (String) session.getAttribute("password");
	String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = orgCode.substring(0,2);
	String phone_no =  request.getParameter("phone_no");	
%>

<HTML>
	<HEAD>
		<TITLE><%=opName%></TITLE>
		<META content=no-cache http-equiv=Pragma>
		<META content=no-cache http-equiv=Cache-Control>
		<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
	</HEAD>
	<script language="javascript">

		
		function comm()
		{
		
		   if($.trim($("#phone_no").val()) == "")
		   {
		   	rdShowMessageDialog("服务号码不能为空！");
			  return false;
		   }
		   
		   document.fr192.action = "fr192_2.jsp?phone_no="+$("#phone_no").val();
		   document.forms[0].submit();
		
		}
		
		

		</script>
	<body >
		<form method=post name="fr192" action="" >
			<input type=hidden id=workNo name=workNo value=<%=workNo%>>
			
			<%@ include file="/npage/include/header.jsp"%>
			<div class="title"><div id="title_zi"><%=opName%></div></div>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
          	<td width="20%" class="Blue">手机号码</td>
          	<td width="30%">
							<input type="text" value="<%=phone_no%>" name="phone_no"  id="phone_no" v_must=0 v_minlength=1 v_maxlength=40 v_type="string" onblur="checkElement(this)">
         	 	</td>
          	<td width="20%" class="Blue">&nbsp;</td>
          	<td width="30%">
             &nbsp;
          	</td>
        </tr>   
        <TR>
        	<TD align="middle"  colspan="4" id="footer">
						<input  name="selectbutton" index="3" type="button"
								class="b_foot" value="查询" onclick="comm();">
							&nbsp;&nbsp;	
						<input class="b_foot" name="back" type="button"
								value="清除" onclick="window.location='fr192_1.jsp'">

					</TD>
				</TR>
		</table>
		
		    <br>
				 <div id="div1"> 
				 <div class="title"><div id="title_zi">查询结果</div></div> 
				 		<table cellspacing="0">   
                <tr>						
                  <th>手机号码</th>
                  <th>当前黑名单次数</th>
                  <th>最大黑名单次数</th>                 
                </tr>
                
    <wtc:service name="sBlackNumQry" routerKey="phone" routerValue="<%=phone_no%>"  retcode="Code" retmsg="Msg"  outnum="3">                
        <wtc:param value="<%=phone_no%>" />
        <wtc:param value="" />
        <wtc:param value="<%=workNo%>" />
		</wtc:service>
		<wtc:array id="result" scope="end" />	
<%
	String errCode =Code;   
	String	errMsg=Msg;

	if(errCode.equals("000000"))
	{	
		int len = result.length;
		if(len!=0){
		
			for(int i=0;i<len;i++){
			
			%>
				 <tr>
     
							  <td>
									<%=phone_no%>
								</td>
								<td>
									  <%=result[i][1]%>&nbsp;
								</td>
					      <td>
									<%=result[i][2]%>&nbsp;
								</td>
					    </tr>
			<%
		}
	}else{
		%>    
			<script language=javascript>	
				rdShowMessageDialog("未查询到数据！");
				document.location.replace("fr192_1.jsp");
			</script>
	<%
		}
	}else{
		%>    
			<script language=javascript>	
				rdShowMessageDialog("查询错误![<%=errCode%>]<%=errMsg%>");
				document.location.replace("fr192_1.jsp");
			</script>
	<%
	}
		%> 
			</table> 
       
		</form>
		<%@ include file="/npage/include/footer.jsp" %> 
	</BODY>
</HTML>
