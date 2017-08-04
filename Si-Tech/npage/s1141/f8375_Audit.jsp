<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
   /*
   * 功能: 赠送预存款审批人员查询
　 * 版本: 
　 * 日期: 20100603
　 * 作者: sunaj
 　*/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
/**需要清楚缓存.如果是新页面,可删除**/
response.setHeader("Pragma","No-Cache"); 
response.setHeader("Cache-Control","No-Cache");
response.setDateHeader("Expires", 0); 

    String[][] result = new String[][]{};
	String orgCode = (String)session.getAttribute("orgCode");
  	String regionCode = orgCode.substring(0,2);
	String opFlag = request.getParameter("opflag");
	String memCode="";
	String[] inParas = new String[2];
	
	if(opFlag.equals("one"))
	{
		memCode="8376";	     //第一组组员	  
	}else
	{
		memCode="8378";      //第二组组员
	}
	inParas[0] = "select a.login_no,a.login_name  from dloginmsg a,shighlogin b    "+
		    	  "where a.login_no=b.login_no and b.op_code=:memcode ";	
	inParas[1] = "memcode="+memCode;
	
%>				  	
<wtc:service name="TlsPubSelCrm" outnum="2" retmsg="Retmsg2" retcode="Retcode2" routerKey="region" routerValue="<%=regionCode%>">
		<wtc:param value="<%=inParas[0]%>"/>
		<wtc:param value="<%=inParas[1]%>"/>
</wtc:service>
<wtc:array id="memresult" scope="end"/>	
<%
	String[][] memarr= new String[][]{};
	if(Retcode2.equals("0") || Retcode2.equals("000000"))
	{
		memarr = memresult;
 	}
%>		  
<html>
<head>
<meta content=no-cache http-equiv=Pragma>
<meta content=no-cache http-equiv=Cache-Control>
<script language="javascript">

function f8375Init(obj)
{
 	parent.document.all.work_men.value = obj.vLoginNo;
 	parent.document.all.work_menname.value = obj.vLoginName;
}

</script>
</head>
<body>
<form name="frm" method="POST" >
	<div id="Operation_Table">
	
		<table cellspacing="0" id="tabList" width="50%">
			<tr align="center">
				<th class="blue" nowrap>请选择</th>
				<th nowrap>审批人工号</th>
				<th nowrap>审批人姓名</th>
			</tr> 
	<%
			if(memarr.length==0)
			{
				out.println("<tr height='25' align='center'><td colspan='11'>");
				out.println("<font class='orange'>没有任何记录！</font>");
				out.println("</td></tr>");
				
			}else if(memarr.length>0)
			{
				String tbclass = "";
				for(int i=0;i<memarr.length;i++)
				{
					tbclass = (i%2==0)?"Grey":"";
	%>
				<tr align="center">

				<td class="Grey" align=center>
				<input type="radio" name="radio" vLoginNo="<%=memarr[i][0]%>" vLoginName="<%=memarr[i][1]%>" onclick="f8375Init(this)">
				</td>		
						<td class="<%=tbclass%>"><%=memarr[i][0]%>&nbsp;</td>
						<td class="<%=tbclass%>"><%=memarr[i][1]%>&nbsp;</td>
				</tr>
<%				
				}
			}
%>
 	</table>
</div>
  	
</body>
</html>    
