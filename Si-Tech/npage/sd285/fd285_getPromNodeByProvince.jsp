 <%
   /*
   * 功能: 提醒短信增加-查询区县代码
　 * 版本: v3.0
　 * 日期: 2011-3-28
　 * 作者: ningtn
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
		<%@ page contentType="text/html;charset=Gb2312"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>
<%
 		String opName = "提醒短信增加";
%>

<html>
	<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	<script language="javascript">
		<!--		
			/**复选框全部选中**/
			function doSelectAllNodes(){
				var regionChecks = document.getElementsByName("regionCheck");
				for(var i=0;i<regionChecks.length;i++){
					regionChecks[i].checked=true;
				}
				doChange();	
			}
			
			/**取消复选框全部选中**/
			function doCancelChooseAll(){
				var regionChecks = document.getElementsByName("regionCheck");
				for(var i=0;i<regionChecks.length;i++){
					regionChecks[i].checked=false;
				}
				doChange();				
			}
			
			/**复选框选中或者取消的主要事件**/
			function doChange(){
				var regionChecks = document.getElementsByName("regionCheck");	
				var impCodeStr = "";
				var impNameStr = "";
				var regionLength = 0;
				for(var i=0;i<regionChecks.length;i++){
					if(regionChecks[i].checked){
						var impValue = regionChecks[i].value;
						var impArr = impValue.split("|");
						if(regionLength==0){
							impCodeStr = impArr[0];
							impNameStr = impArr[0]+" "+impArr[1];
						}else{
							impCodeStr += (","+impArr[0]);
							impNameStr += (","+impArr[0]+" "+impArr[1]);	
						}
						regionLength++;
					}
				}
				
				impNameStr += (" -->"+"一共选择"+regionLength+"个区域");
						
				parent.document.all.sGroupInfo.value = impNameStr;
				parent.document.all.sGroupId.value = impCodeStr;
			}
		//-->
	</script>
</head>
<body>
	<div id="Operation_Table">
     <table cellspacing="0">
			<tr height=25 align="center">
				<th width="15%" nowrap>选择</td>
				<th nowrap>省级编号</td>
				<th nowrap>省级名称</td> 
			</tr> 
			<tr align="center">
				<td>
					<input type="checkbox" name="regionCheck" value="10014|黑龙江" onclick="doChange()">	
				</td>
				<td>10014&nbsp;</td>
				<td>黑龙江&nbsp;</td>
			</tr>
  </table>
	<table cellspacing="0">
	  <tr> 
	    <td id="footer"> 
	       <input type="button" name="allchoose" class="b_text" value="全部选择" style="cursor:hand;" onclick="doSelectAllNodes()" >&nbsp;
	       <input type="button" name="cancelAll" class="b_text" value="取消全选" style="cursor:hand;" onClick="doCancelChooseAll()" >&nbsp;
	    </td>
	  </tr>
 </table> 
</div> 
</body>
</html>    

