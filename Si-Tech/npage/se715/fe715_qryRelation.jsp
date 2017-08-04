<%
   /*名称：新旧代码对应关系查询
　 * 版本: v1.0
　 * 日期: 2012/3/18
　 * 作者: liuweih
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*" %>
<%@ page import="java.text.*"%>

<%

	ArrayList retArray = new ArrayList();
	String[][] colNameArr1 = new String[][]{};
	String[][] colNameArr2 = new String[][]{};
	 
	String opName = "新旧代码对应关系查询";
	 
	String regCode = (String)session.getAttribute("regCode");
	String workNo = (String)session.getAttribute("workNo");
	String workPwd = (String)session.getAttribute("password");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);	
	String strDate = new SimpleDateFormat("yyyyMMdd").format(new Date());

	String ecsiid = request.getParameter("ecsiid");
	String BaseServCodeProp = request.getParameter("BaseServCodeProp");


	%>
	 
	<wtc:service name="se715QryRela" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="9" >
              <wtc:param value="<%=ecsiid%>"/>
              <wtc:param value="<%=BaseServCodeProp%>"/>
   </wtc:service>
   <wtc:array id="colNameArrTemp1" scope="end" start="0" length="4" />
   	
   	 
	<wtc:service name="se715QryRela" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="9" >
              <wtc:param value="<%=ecsiid%>"/>
              <wtc:param value="<%=BaseServCodeProp%>"/>
   </wtc:service>
   <wtc:array id="colNameArrTemp2" scope="end" start="4" length="5" />
	<%
	colNameArr1 = colNameArrTemp1;
	colNameArr2 = colNameArrTemp2;
	
	 System.out.println("colNameArr1.length="+colNameArr1.length);
	 System.out.println("colNameArr2.length="+colNameArr2.length);
    
   
  if((colNameArr1.length==0)&&(colNameArr2.length==0))
 	{
%>
			<script language='jscript'>
				rdShowMessageDialog("没有查到相关记录！",0);			
				window.parent.document.all.reset.onclick();
			</script>
<%  
	}else
    {
%>       
	


<html >
<head>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
</head>

<script language="javascript">

    function doProcess(packet)
	{
		var errCode    = packet.data.findValueByName("errCode");
		var retMessage = packet.data.findValueByName("errMsg");//声明返回的信息
		var retFlag    = packet.data.findValueByName("retFlag");

		if (errCode==0)
		{  
			if(retFlag=="queryMod")
			{			
				rdShowMessageDialog("操作成功！",2);
				window.parent.document.all.confirm.onclick();
			}
		}else{
			rdShowMessageDialog(retMessage,0);	
		}
	}
	
		//变更
	function  queryMod(itype,OprCode,servcode)
	{		
		var oldcode="";
		var newcode="";		
		var ecid=document.all.ecsiid.value;
		var codeprop=document.all.BaseServCodeProp.value;
		if(itype=="old"){
			oldcode=servcode;
		}else{
			newcode=servcode;
		}
		var otype="";
		if(OprCode=="E"){
			otype="终止";
		}else if(OprCode=="H"){
			otype="恢复";
		}else if(OprCode=="Z"){
			otype="暂停";
		}
		confirmFlag = rdShowConfirmDialog("确认对接入号"+servcode+"进行"+otype+"操作？");
		if (confirmFlag==1) {
		var myPacket = new AJAXPacket("fe715_modCfm.jsp?ecid="+ecid+"&codeprop=" +codeprop+"&oldcode=" +oldcode+ "&newcode="+newcode+ "&OprCode="+OprCode,"正在获得信息，请稍候......");
		core.ajax.sendPacket(myPacket);
		myPacket = null;
		}
	}
	  
	function doclear()
	{
 		parent.location="fe715.jsp";
 	}
	

</script>


<body>

<form name="form1" method="post" action="">	
	<input type="hidden" name="ecsiid" value="<%=ecsiid%>">
	<input type="hidden" name="BaseServCodeProp" value="<%=BaseServCodeProp%>">
<div id="Operation_Table">

<TABLE id="tablostcode" cellSpacing="0"> 
			<TR><td colspan="4" class="blue" ><strong>失效对应关系：</strong></td>	 </TR>	
		<TR>				
			<th align="center"><div>失效时间</div></th>
			<th align="center"><div>旧基本接入号</div></th>
			<th align="center"><div>新基本接入号</div></th>
			<th align="center"><div>接入号属性</div></th>
		</TR>		
		<%	
		int len1 = colNameArr1.length;	
		for(int i = 0; i < len1; i++)
		{		  
		 if(colNameArr1[i][0]!=null){
	%>			
			<tr id="tr<%=i+1%>">
				
				<td align='center'><%=colNameArr1[i][0].trim()%></td>
				<td align='center'><%=colNameArr1[i][1].trim()%></td>
				<td align='center'><%=colNameArr1[i][2].trim()%></td>		
				<% if("01".equals(colNameArr1[i][3].trim()))
        {
%>
        <td align='center'>短信</td>
<%      }
        else if("02".equals(colNameArr1[i][3].trim()))
        {
%>
				<td align='center'>彩信</td>
<%      }
   			else  {
%>
				<td align='center'>WAPPush</td>
<%      }  
  %>   
			</tr>
	<%
			}
		}
	%>	
			</TABLE>
		<TABLE id="tabusecode"  cellSpacing="0"> 	
		<TR><td colspan="8" class="blue" ><strong>生效对应关系：</strong></td>	 </TR>	
		<TR>				
			<th align="center"><div>基本接入号属性</div></th>
			<th align="center"><div>旧基本接入号</div></th>
			<th align="center"><div>当前状态</div></th>
			<th align="center"><div>操作</div></th>
			<th align="center"> </th>
			<th align="center"><div>新基本接入号</div></th>
			<th align="center"><div>当前状态</div></th>
			<th align="center"><div>操作</div></th>
		</TR>	
		
	<%	
		int len2 = colNameArr2.length;	
		for(int i = 0; i < len2; i++)
		{		  
		 if(colNameArr2[i][0]!=null){
	%>			
			<tr id="tr<%=i+1%>">	
				<% if("01".equals(colNameArr2[i][0].trim()))
        {
%>
        <td align='center'>短信</td>
<%      }
        else if("02".equals(colNameArr2[i][0].trim()))
        {
%>
				<td align='center'>彩信</td>
<%      }
   			else  {
%>
				<td align='center'>WAPPush</td>
<%      }  
%>   			
				<td align='center'><%=colNameArr2[i][1].trim()%></td>	
<%     if("1".equals(colNameArr2[i][2].trim()))
        {
%>
        <td align='center'>正常</td>
<%      } 
   			else  {
%>
				<td align='center'>暂停</td>
<%      }  
  %>   
		
				<td align='center'>
			<%
			String stopFlag="";  
			String resumeFlag="";
			if("3".equals(colNameArr2[i][2].trim()))
			{
				stopFlag="disabled";
			}
			if("1".equals(colNameArr2[i][2].trim()))
			{
				resumeFlag="disabled";
			}
			%>
					<input name="operator<%=i+1%>" <%=stopFlag%> style="cursor:hand" type="button" value="暂停" class="b_text" onclick="queryMod('old','Z',<%=colNameArr2[i][1]%>)">&nbsp;&nbsp;	
					<input name="operator<%=i+1%>" <%=resumeFlag%> style="cursor:hand" type="button" value="恢复" class="b_text" onclick="queryMod('old','H',<%=colNameArr2[i][1]%>)">		
					<input name="operator<%=i+1%>" style="cursor:hand" type="button" value="终止" class="b_text" onclick="queryMod('old','E',<%=colNameArr2[i][1]%>)">		
				</td> 
				<td></td>
				<td align='center'><%=colNameArr2[i][3].trim()%></td>	
<%     if("1".equals(colNameArr2[i][4].trim()))
        {
%>
        <td align='center'>正常</td>
<%      } 
   			else  {
%>
				<td align='center'>暂停</td>
<%      }  
  %>   
	
				<td align='center'>
			<%
			String stpFlag="";  
			String resFlag="";
			if("3".equals(colNameArr2[i][4].trim()))
			{
				stpFlag="disabled";
			}
			if("1".equals(colNameArr2[i][4].trim()))
			{
				resFlag="disabled";
			}
			%>
					<input name="operator<%=i+1%>" <%=stpFlag%> style="cursor:hand" type="button" value="暂停" class="b_text" onclick="queryMod('new','Z',<%=colNameArr2[i][3]%>)">&nbsp;&nbsp;	
					<input name="operator<%=i+1%>" <%=resFlag%> style="cursor:hand" type="button" value="恢复" class="b_text" onclick="queryMod('new','H',<%=colNameArr2[i][3]%>)">		
					<input name="operator<%=i+1%>" style="cursor:hand" type="button" value="终止" class="b_text" onclick="queryMod('new','E',<%=colNameArr2[i][3]%>)">		
				</td> 
			</tr>
	<%
			}
		}
	%>		
		</TABLE>
	<TABLE cellSpacing="0" id="commbutton" name="commbutton">
						<TR>
							<TD align="center">								
								<INPUT  class="b_foot" type="Button" name="reset" value="返回"  onclick="doclear()" >								
							</TD>
						</TR>
					</TABLE>
</div>   
</form>
</body>
</html>
<%}%>		

           