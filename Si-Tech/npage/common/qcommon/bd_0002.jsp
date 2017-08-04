<%
   /*
   *客户基本信息公共页面,gCustId等变量要在要引用的页面先定义
   *
   */
%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<!--取客户基本信息-->
<%
	String bd0002_orgCode = (String)session.getAttribute("orgCode");
	String bd0002_regionCode = bd0002_orgCode.substring(0,2);
%>
<wtc:utype name="sQBasicInfo" id="retBd0002" scope="end"  routerKey="region" routerValue="<%=bd0002_regionCode%>">
     <wtc:uparam value="<%=gCustId%>" type="LONG"/>
</wtc:utype>
<%
String bd0002_retCode =retBd0002.getValue(0);
String bd0002_retMsg  =retBd0002.getValue(1);

String custName="";//客户名称
String belongCity="";//归属市县
String custLevel="";//客户级别
String linkmanName="";//联系人姓名
String bd0002_status="";//稽核状态
String nationName = ""; //民族
String agent_idType="";//证件类型
String agent_idNo="";//证件号码
String agent_phone="";//联系电话
String ba0002_black="";//黑名单
String ZSCustName="";
String lianxiren="";

if(bd0002_retCode.equals("0"))
{
	custName   =retBd0002.getValue("2.0");
	belongCity =retBd0002.getValue("2.1") == null ? "" : retBd0002.getValue("2.1");
	custLevel  =retBd0002.getValue("2.2");
	linkmanName=retBd0002.getValue("2.3");
	bd0002_status=retBd0002.getValue("2.4") == null ? "" : retBd0002.getValue("2.4");
	nationName =retBd0002.getValue("2.5");
	agent_idType =retBd0002.getValue("2.6");
	agent_idNo =retBd0002.getValue("2.7");
	agent_phone =retBd0002.getValue("2.8");
	ba0002_black =retBd0002.getValue("2.9");
	

	if(!("").equals(custName)) {
	
			if(custName.length() == 2 ){
				ZSCustName = custName.substring(0,1)+"*";
			}
			if(custName.length() == 3 ){
				ZSCustName = custName.substring(0,1)+"**";
			}
			if(custName.length() == 4){
				ZSCustName = custName.substring(0,2)+"**";
			}
			if(custName.length() > 4){
				ZSCustName = custName.substring(0,2)+"******";
			}
		}

	if(!("").equals(linkmanName)) {
	
			if(linkmanName.length() == 2 ){
				lianxiren = linkmanName.substring(0,1)+"*";
			}
			if(linkmanName.length() == 3 ){
				lianxiren = linkmanName.substring(0,1)+"**";
			}
			if(linkmanName.length() == 4){
				lianxiren = linkmanName.substring(0,2)+"**";
			}
			if(linkmanName.length() > 4){
				lianxiren = linkmanName.substring(0,2)+"******";
			}
		}		

		
	
	
}
%>


<div class="input">
   	<table cellspacing="0">
   		<tr>
   			<td class=blue>客户名称 </td>
   			<td>
   				<span><%=ZSCustName%></span>
   				<input type="hidden" name="custNameforsQ046" value="<%=custName%>">
   				<%
   				if(ba0002_black.equals("N"))
   				{
   					//out.println("(非黑名单)");
   				}else
   				{
   					out.println("(黑名单)");
				%>
					<script>
						rdShowMessageDialog("该客户属于黑名单客户");
					</script>
				<%
   				}
   				%>
   			</td>
   			<td  class=blue>民族</td>
   			<td><%=nationName%></td> 
   			<td  class=blue>联系人 </td>
   			<td><%=lianxiren%></td>
   		</tr>
   	  <tr>
   			<td  class=blue>客户级别 </td>
   			<td ><%=custLevel%></td> 
   	  	<td  class=blue>稽核状态</td>
   			<td><%=bd0002_status%></td>   
   	    <td  class=blue>归属渠道 </td>
   			<td><%=belongCity%></td>
   	  </tr>
   	  	<input type="hidden" name="idType_0002" value="<%=agent_idType%>"/>
   	  	<input type="hidden" name="agentIdNoHide" id="agentIdNoHide" value="<%=agent_idNo%>"/>
   	  </tr>
	</table>
</div>
 