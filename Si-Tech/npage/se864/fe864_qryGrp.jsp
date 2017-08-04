<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%/*------根据集团名称模糊查询出集团名称和集团ID*/
   response.setHeader("Pragma","No-cache");
   response.setHeader("Cache-Control","no-cache");
   response.setDateHeader("Expires", 0);
		String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String smzflag ="";
	  String groupId = (String)session.getAttribute("groupId");
	  String opCode = request.getParameter("opCode");
		String grp_name = request.getParameter("grp_name");
		String num = request.getParameter("num");

System.out.println("wanghyd----"+grp_name);
System.out.println("wanghyd----"+num);
System.out.println("wanghyd----"+opCode);

%>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="printAccept"/>
		 
     <wtc:service name="sQryUnitInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="5">
        <wtc:param value="<%=printAccept%>"/>
        <wtc:param value="01"/>
        <wtc:param value="<%=opCode%>"/>
        <wtc:param value="<%=workNo%>"/>
        <wtc:param value="<%=password%>"/>
        <wtc:param value=""/>
        <wtc:param value=""/>
        <wtc:param value="<%=groupId%>"/>
        <wtc:param value="<%=grp_name%>"/>
        </wtc:service>
        <wtc:array id="dcust2" scope="end" />
<%
/*System.out.println("--wanghyd"+dcust2.length);*/
%>
<head>


</head>
<body>
			<form name="frm11" method="POST" action="">
				
	  <div id="Main">
		<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">查询信息</div>
			</div>

							<table >
									<tr >
									<th></th>	
									<th>调入集团名称</th>	
									<th>调入集团编号</th>	
								<th>客户经理名称</th>						
								<th>客户经理工号</th>
							<th>客户经理电话</th>
							</tr>
							<%if(retCode2.equals("000000")) {
							   if(dcust2.length>0) {
							   for(int i=0;i<dcust2.length; i++) {
							%>
							<tr> 
								<td width="7%"><input type="radio" name="grtradio" value="<%=dcust2[i][0]%>|<%=dcust2[i][1]%>" ></td>
								<td width="20%"><%=dcust2[i][0]%></td>
								<td width="14%"><%=dcust2[i][1]%></td>
								<td width="14%"><%=dcust2[i][2]%></td>
								<td width="14%"><%=dcust2[i][3]%></td>
								<td width="14%"><%=dcust2[i][4]%></td>

						  </tr>

						  		<%
		    }
		 %>
		 						

		 <%   
		    }
		  else {
		%>
		<tr height='25' align='center'><td colspan='7'>查询信息为空！</td></tr>
<%}}else {
			%>
			<script language="JavaScript">
					    rdShowMessageDialog("<%=retCode2%>"+"<%=retMsg2%>",0);	
					</script>
					<%
	}%>
			  </table>		
			  						<table>
		<tr > 
			<td id="footer"> <div align="center"> 
			<input name="confirm" id="confirm" type="button" class="b_foot" 
			 value="提交" onClick="confirmSs()" />
			</div>
			</td>
		</tr>
	</table>	
					</div>
				</div>
				
			
</form>
</body>
</html>
<script language="javascript" type="text/javascript">
    function returnValue()
    {

     
    }
    
    	function confirmSs() {
		var radio1 = document.getElementsByName("grtradio");
				var opValert="";
				var sm= new Array();
				var unit_name="";
				var unit_id="";
				var schecks=0;

				   for(var i=0;i<radio1.length;i++)
				  {
					    if(radio1[i].checked)
						{
						schecks++;
						sm = radio1[i].value.split("|");;
						unit_name=sm[0];
						unit_id=sm[1];
						}
						}
			if(schecks==0) {
						 rdShowMessageDialog("请选择要调入的集团！");
		         return false;				
				}
			window.opener.document.getElementById("grpName<%=num%>").value = unit_name;
			window.opener.document.getElementById("grpID<%=num%>").value = unit_id;
			window.close();
			}
  </script>