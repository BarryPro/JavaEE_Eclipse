<%
/*
 * 功能: 省内携号 查询礼品信息
 * 版本: 1.0
 * 日期: 2012/4/25 14:19:13
 * 作者: yanpx
 * 版权: si-tech
 * update:
*/
%>
<div id="bizDiv">
	<div class="title">
		<div id="title_zi">礼品信息 </div>
	</div>
</div>	
<wtc:service name="s2266InitNew" routerKey="region" routerValue="<%=regCode%>" outnum="19" >
    <wtc:param value="<%=phoneNo%>"/>
    <wtc:param value="2266"/>
    <wtc:param value="<%=workNo%>"/>
    <wtc:param value="<%=password%>"/>
</wtc:service>
<wtc:array id="s2266InitNewArr" scope="end"/>
	
	
<wtc:service name="s6842Sel" routerKey="region" routerValue="<%=regCode%>" outnum="19" >
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value="6842"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=password%>"/>
</wtc:service>
<wtc:array id="s6842SelArr" scope="end"/>	
<%
	System.out.println("yanpx======"+phoneNo);
	System.out.println("yanpx======"+s2266InitNewArr.length);
	int giftCount = s2266InitNewArr.length+s6842SelArr.length;
%>
    <table>
          <tr align="center">
          		<th>营销案名称 </th>
              <th>数量 </th>
              <th>领取标志 </th>
              <th>中奖日期 </th>
              <th>实物礼品 </th>
              <th>奖品类别 </th>
              <th>营销等级名称 </th>
          </tr>
          <%
          	for(int i=0;i<s2266InitNewArr.length;i++){
          			String tbclass = i%2==0 ? "Grey" : "";
          %>
          	<tr>
          		  <td class="<%=tbclass%>"><%=s2266InitNewArr[i][2]%></td>
								<td class="<%=tbclass%>"><%=s2266InitNewArr[i][3]%></td>
								<td class="<%=tbclass%>"><%=s2266InitNewArr[i][5]%></td>
								<td class="<%=tbclass%>"><%=s2266InitNewArr[i][6]%></td>   
								<td class="<%=tbclass%>"><%=s2266InitNewArr[i][4]%> </td>  
								<td class="<%=tbclass%>"><%=s2266InitNewArr[i][1]%></td>   
								<td class="<%=tbclass%>"></td>    		
						</tr>
          <%
          	}
          	for(int j=0;j<s6842SelArr.length;j++){
          		String tbclass = j%2==0 ? "Grey" : "";
          %>
          	<tr>
              <td class="<%=tbclass%>"><%=s6842SelArr[j][7]%></td>
							<td class="<%=tbclass%>"><%=s6842SelArr[j][11]%></td>
              <td class="<%=tbclass%>"><font color="red"><%=("O".equals(s6842SelArr[j][4])?"到期未领取":"未领取")%></font></td>
              <td class="<%=tbclass%>"><%=s6842SelArr[j][5]%></td>
              <td class="<%=tbclass%>"><%=s6842SelArr[j][12]%></td>   
              <td class="<%=tbclass%>"></td>  
              <td class="<%=tbclass%>"><%=s6842SelArr[j][8]%></td>  
						</tr>                         		
          <%
          	}
          %>          
		</table> 
<script language="javascript">
	var giftCount = "<%=giftCount%>"; /*查询有需要领奖的营销案则为‘Y’，否则为‘N’，冲正时此字段为空*/
</script>	         	      