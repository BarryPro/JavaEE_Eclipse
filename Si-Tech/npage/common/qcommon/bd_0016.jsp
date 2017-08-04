 
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%
    String bd0016_orgCode = (String)session.getAttribute("orgCode");
		String bd0016_regionCode = (String)session.getAttribute("cityId");
		String branchNo="";  //局站编号；
		String branchName_bd0016="";  //局站编号；
		String proSvcId="";	 //主服务ID；
		String mastSvcType=""; //主服务类型；
		String addr_0016 = "";//装机地址；
		String bd_0016_flag = "true";
		
%>
<!--用户基本信息-->
<wtc:utype name="sQUserBaseInfo" id="retCustBaseInfo" scope="end"  routerKey="region" routerValue="<%=bd0016_regionCode%>">
     <wtc:uparam value="<%=idNo%>" type="LONG"/>
     <wtc:uparam value="<%=bd0016_regionCode%>" type="STRING"/>
</wtc:utype>
<%     
      String bd0016_retCode =retCustBaseInfo.getValue(0);
      String bd0016_retMsg  =retCustBaseInfo.getValue(1);  
      System.out.println("bd0016_retCode="+bd0016_retCode);
      System.out.println("bd0016_retMsg="+bd0016_retMsg);
     if(bd0016_retCode.equals("0")){
     proSvcId=retCustBaseInfo.getValue("2.9");
     //branchNo="0"+retCustBaseInfo.getValue("2.10");
     branchNo=retCustBaseInfo.getValue("2.10");
     mastSvcType=retCustBaseInfo.getValue("2.13");
     addr_0016 = retCustBaseInfo.getValue("2.5");
     branchName_bd0016=retCustBaseInfo.getValue("2.6");
     
      System.out.println("proSvcId="+proSvcId);
      System.out.println("branchNo="+branchNo);
      System.out.println("mastSvcType="+mastSvcType);
%>
  	<div class="input">
     	<table cellspacing="0">
     		<tr>
     			<th>服务号码：</th>
     			<td><%=retCustBaseInfo.getValue("2.0")%></td>
     			<th>状态：</th>
     			<td><%=retCustBaseInfo.getValue("2.1")%></td>
     			<th>信用等级：</th>
     			<td ><%=retCustBaseInfo.getValue("2.2")%></td>
     		</tr>
     		<tr>
     			<th>信用度：</th>
     			<td><%=retCustBaseInfo.getValue("2.3")%></td>
     			<th>催停标志：</th>
     			<td><%=retCustBaseInfo.getValue("2.4")%></td>
     			<th>品牌：</th>
     			<td><%=retCustBaseInfo.getValue("2.7")%></td>    
     		</tr>
     		<tr>
     			<th>就近电话：</th>
     			<td > </td>
     			<th>其它相关信息：</th>
     			<td> </td>
     			<%if (!"0".equals(mastSvcType)){%>
     			<th>所在局站：</th>
     			<td><%=branchName_bd0016%></td>
     		</tr>
     		<tr>
     			<th>装机地址：</th>
     			<td colspan="5"><%=retCustBaseInfo.getValue("2.5")%></td>	
     			<%}else{
     				out.println("<th></th><td></td>")	;
     			}%>		 
     		</tr>
     		<input type="hidden" name="addr_id" value="<%=retCustBaseInfo.getValue("2.8")%>" > 
     		<input type="hidden" name="addr_0016" value="<%=addr_0016%>" >    
     		<input type="hidden" name="status_runcode" value="<%=retCustBaseInfo.getValue("2.12")%>" >  		
		</table>
	</div>
<%}else{
			bd_0016_flag = "false";
	%>
     		<input type="hidden" name="branchNo" value="<%=branchNo%>" >   
     		<input type="hidden" name="branchName_bd0016" value="<%=branchName_bd0016%>" >  
	<script>
		rdShowMessageDialog("该用户没有局站信息！",0)	;
	</script>
<%}%>