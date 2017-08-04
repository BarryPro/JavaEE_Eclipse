<%
   /*
   * 功能: 查询配置地市信息
　 * 版本: v3.0
　 * 日期: 2011-7-12
　 * 作者: huangrong
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
		<%@ page contentType="text/html;charset=Gb2312"%>
		<%@ include file="/npage/include/public_title_name.jsp" %>
		<%@ page import="java.util.ArrayList" %>
<%
 		String opCode = "e016";
 		String opName = "勋章兑换礼品配置新增";

		String groupId = (String)session.getAttribute("groupId");
		String orgCode = (String)session.getAttribute("orgCode");
		String regionCode = (String)session.getAttribute("regCode");
		String regionCodeSql="";
		String [] paraIn = new String[2];
	  
	  
		String getAuditLoginSql = "";
		if(groupId.equals("10014"))
    {
			regionCodeSql = "select region_code,region_name,group_id from sregionCode where use_flag=:use_flag order by region_code";
			paraIn[1]="use_flag=Y";
		}else
		{
		 	regionCodeSql = "select region_code,region_name,group_id from sregionCode  where region_code=:regionCode";
		 	paraIn[1]="regionCode="+regionCode;
		}	
		paraIn[0] = regionCodeSql;
		%>
			<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="3">
			<wtc:param value="<%=paraIn[0]%>"/>
			<wtc:param value="<%=paraIn[1]%>"/>
			</wtc:service>
			<wtc:array id="regionCodeStr" scope="end" />
<%		
		int totalNum = regionCodeStr.length;
%>

<html>
	<head>
	<title><%=opName%></title>
	<meta content=no-cache http-equiv=Pragma>
	<meta content=no-cache http-equiv=Cache-Control>
	<script language="javascript">
		<!--
			function select_groupId(regionCode,row)
			{
				var path = "groupTree.jsp?regionCode="+regionCode+"&row="+row;
			  window.open(path,'_blank','height=600,width=300,scrollbars=yes');
			}	
			//查看已选营业厅
			function query_groupId(row)
			{
				var groupIds=document.getElementById("groupId"+row).value;
				var groupNames=document.getElementById("groupName"+row).value;
				if(groupIds=="" || groupIds==null)
				{
					rdShowMessageDialog("请先选择领取营业厅，然后查看信息!");
					return false;					
				}
				var group_ids=groupIds.split(",");
				if(group_ids.length>50)
				{
					rdShowMessageDialog("兑换营业厅的个数太多超过50个，不可以查看，但可以校验并继续执行兑换操作！");
					return false;				
				}
				var path = "fe016_queryInfo.jsp?groupIds="+groupIds+"&groupNames="+groupNames;
				window.open(path,'_blank','height=550,width=550,scrollbars=yes');
			
			}	
			
			function check_groupId(row)
			{
				var groupIds=document.getElementById("groupId"+row).value;
				if(groupIds=="" || groupIds==null)
				{
					rdShowMessageDialog("请先选择领取营业厅，然后校验选择的是否是营业厅级！");
					return false;					
				}
        isSaleHall(groupIds,row);
			}	
			
			
	 	 function isSaleHall(groupId,row)
	 	 {
				var myPacket = new AJAXPacket("fe016_isSaleHall.jsp","正在提交，请稍候......");
				myPacket.data.add("groupId",groupId);
				myPacket.data.add("row",row);
				core.ajax.sendPacket(myPacket,doIsSaleHall);
				myPacket=null; 	 	
	 	 } 
	
	
	 	 function doIsSaleHall(packet){
					var isSaleHall = packet.data.findValueByName("isSaleHall");
					var row = packet.data.findValueByName("row");
			 		if(isSaleHall=="1")
			 		{
						//document.getElementById("auditRegionCode"+row).disabled=true;
					  rdShowMessageDialog("验证通过，选择的均为营业厅级！",2);						
						document.getElementById("addButton"+row).disabled=true;
						document.getElementById("queryButton"+row).disabled=true;
						document.getElementById("checkButton"+row).disabled=true;
						var groupIds=document.getElementById("groupId"+row).value;
						
						
						
      			var checkButtons = document.getElementsByName("checkButton");	
						var impCodeStr = "";
						var regionLength = 0;
						for(var i=0;i<checkButtons.length;i++){
							if(checkButtons[i].disabled){
								/*
								var tr=document.getElementById("groupId"+i).parentNode.parentNode;
								var tds=tr.childNodes;
								var region_code=tds[0].innerHTML;
								var impValue =document.getElementById("groupId"+i).value;//遍历所有的地市和营业厅表格，如果校验按钮变灰，则获取当前的group_id
						    if(impCodeStr=="")
							  {
							  	impCodeStr=region_code+"~"+impValue;
							  }else
							  {
							  	impCodeStr=impCodeStr+"/"+region_code+"~"+impValue;
							  }
							  */
							  var impValue =document.getElementById("groupId"+i).value;//遍历所有的地市和营业厅表格，如果校验按钮变灰，则获取当前的group_id
							  var region_code =document.getElementById("group_id"+i).value;//获取地市对应的groupId
						    if(impCodeStr=="")
							  {
							  	impCodeStr=region_code+"~"+impValue;
							  }else
							  {
							  	impCodeStr=impCodeStr+"/"+region_code+"~"+impValue;
							  }							  
							}
						}
						//向父页面传值
						parent.document.all.reginonCodes.value ="";//清空上一页面地市代码的值
						parent.document.all.reginonCodes.value = impCodeStr;
						
			 			
			 		}else
			 		{
						rdShowMessageDialog("领取营业厅必须选择营业厅级，请重新选择!");
						return false;		 			
			 		}		
	 	}									
		//-->
	</script>
</head>
<body>
	<FORM method=post name="form1">
		<div id="Operation_Table">
     <table cellspacing="0" id="tab">
			<tr align="center">
			<!--	<th width="10%" nowrap>选择<input type="checkbox" name="checkAll" onclick="checkAll(this)"></td>-->
				<th width="20%" nowrap>地市代码</td>
				<th width="20%" nowrap>地市名称</td> 
				<th width="50%" nowrap>领取营业厅操作</td> 
			</tr> 
	<%
			if(totalNum==0){
				out.println("<tr height='25' align='center'><td colspan='3'>");
				out.println("没有任何记录！");
				out.println("</td></tr>");
			}else if(totalNum>0){
				String tbclass = "";
				for(int i=0;i<totalNum;i++){
					tbclass = (i%2==0)?"Grey":"";
	%>
						<tr align="center">
							<td class="<%=tbclass%>"><%=regionCodeStr[i][0]%></td>
							<td class="<%=tbclass%>"><%=regionCodeStr[i][1]%></td>
							<input type="hidden" id="group_id<%=i%>" value="<%=regionCodeStr[i][2]%>">
							
							<input type="hidden" id="groupName<%=i%>" v_must="1"  v_type="string" maxlength="60" class="button" readonly>
							<input type="hidden" id="groupId<%=i%>">
							<td class="<%=tbclass%>">
								<input name="addButton" id="addButton<%=i%>" class="b_text" type="button" value="选择" onClick="select_groupId('<%=regionCodeStr[i][0]%>','<%=i%>')" >
                <input name="queryButton" id="queryButton<%=i%>" class="b_text" type="button" value="查看已选营业厅" onClick="query_groupId('<%=i%>')" >			
                 <input name="checkButton" id="checkButton<%=i%>" class="b_text" type="button" value="校验是否是营业厅" onClick="check_groupId('<%=i%>')" >																	
							</td>
						</tr>
	<%				
				}
			}
	%>
  </table>
 <table  cellspacing="0">
 	<tbody> 
    <tr height="20"> 
    	<td colspan="3">操作说明：<font color="red">只有选择的地市与营业厅当前记录变灰，该操作有效</font><br>
			  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">1、点击选择按钮，选择地市对应的营业厅</font><br>
			  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">2、点击查看已选营业厅按钮，查看地市对应选择的营业厅明细&nbsp	</font><br>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font color="red">3、点击校验是否是营业厅按钮，校验地市对应选择营业厅操作选择的是否是营业厅级别</font><br>
      </td>
    </tr>
  </tbody> 
</table>  
</div>
</FORM>
</body>
</html>    

