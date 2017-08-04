<%
/********************
 version v2.0
 开发商 si-tech
 create hejwa 2011-7-26
********************/
%>
              
<%
	String opCode = request.getParameter("opCode");
    String opName = request.getParameter("opName");
    
    
    String flag = request.getParameter("flag")==null?"":request.getParameter("flag");
	String ishelper = request.getParameter("ishelper")==null?"":request.getParameter("ishelper");
	String funcName = request.getParameter("funcName")==null?"showInWeek":request.getParameter("funcName");
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%
		String regionCode  = (String)session.getAttribute("regCode");
		String selectDate  = (String)request.getParameter("selectDate");
		String selDate     = selectDate.replaceAll("-","");
		String cuTime      = new java.text.SimpleDateFormat("HH:mm:ss").format(new java.util.Date());
		String cuDate      = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
		selectDate = selectDate+" "+cuTime;
%>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<script language="javascript" type="text/javascript">
	var windowShow = window.dialogArguments; 
  
function saveTsk(){
	var promptContentLen = document.all("promptContent").value.length;
	if(promptContentLen>2000){
		rdShowMessageDialog("内容长度不能超过2000个字符");
		return;
	}
	
	var title     = document.all.promptTitle.value.trim();
	var content   = document.all("promptContent").value.trim();
	var startTime = document.all.promptTime.value.trim();
	var endTime   = document.all.promptTimend.value.trim();
	var tskRank   = document.all.tskRank.value;
	//alert("title|"+title+"\ncontent|"+content+"\nstartTime|"+startTime+"\nendTime|"+endTime+"\ntskRank|"+tskRank);
	
	if(title==""){
		rdShowMessageDialog("任务标题不能为空");
		document.all.promptTitle.focus();
		return;
	}
	
	if(content==""){
		rdShowMessageDialog("任务内容不能为空");
		document.all("promptContent").focus();
		return;
	}
	
	if(startTime==""){
		rdShowMessageDialog("任务开始时间不能为空");
		document.all.promptTime.focus();
		return;
	}
	
	
	if(parseInt("<%=cuDate%>")>parseInt(startTime)){
		rdShowMessageDialog("开始时间应该不小于当前时间");
		document.all.promptTime.value="";
		document.all.promptTime.focus();
		return;
	}
	
	
	if(endTime==""){
		rdShowMessageDialog("任务结束时间不能为空");
		document.all.promptTimend.focus();
		return;
	}
	
	if(parseInt(startTime)>parseInt(endTime)){
		rdShowMessageDialog("任务结束时间应该大于任务开始时间");
		document.all.promptTime.value="";
		document.all.promptTimend.value="";
		document.all.promptTimend.focus();
		return;
	}
	
	var mm = /<|>|\\|\"|#|&/;
	
	if(mm.test(title)){
		rdShowMessageDialog("任务标题不能有特殊符号 < > \\ \" # &amp;");
		document.all.promptTitle.value="";
		document.all.promptTitle.focus();
		return;
	}
	
	if(mm.test(content)){
		rdShowMessageDialog("任务内容不能有特殊符号 < > \\ \" # &amp;");
		document.all.promptContent.value="";
		document.all.promptContent.focus();
		return;
	}
		
	var tskPacket = new AJAXPacket("addTask_cfm.jsp","正在执行,请稍后...");
		tskPacket.data.add("title",     title);
		tskPacket.data.add("content",   content);
		tskPacket.data.add("startTime", startTime);
		tskPacket.data.add("endTime",   endTime);
		tskPacket.data.add("tskRank",   tskRank);
		tskPacket.data.add("selectDate",   "<%=selectDate%>");
		core.ajax.sendPacket(tskPacket,doSaveTsk);
		tskPacket = null; 
	
}
function doSaveTsk(packet){
	 var retCode = packet.data.findValueByName("retCode"); 
	 
	 if(retCode=="000000"){
	 	rdShowMessageDialog("任务添加成功",2);
	 }else{
	 	rdShowMessageDialog("任务添加失败",0);
	 }
	 //windowShow.showPrompt();//父窗口查询任务
<%	if("more".equals(flag)){
		 if("helper".equals(ishelper)){
%>			window.opener.opener.frames["ifram"].$("#mydiv8").load("taskInfo.jsp?funcName=<%=funcName%>");
  			window.opener.location.reload();
  			window.opener.opener.frames["ifram"].showPrompt();
<%	
	}else{
%>
			window.opener.opener.$("#mydiv8").load("taskInfo.jsp?funcName=<%=funcName%>");
			window.opener.location.reload();
			window.opener.opener.showPrompt();
<%
		}
	}else{
%>
	window.opener.$("#mydiv8").load("taskInfo.jsp?funcName=<%=funcName%>");
	window.opener.showPrompt();
<%
	}
%>
	 window.close();
}
	
</script>
<title>新增待办任务</title>
</head>

<body onload="" style="overflow-y:auto; overflow-x:hidden;">
			<form id="layer6_form" method="post" action="">
				<%@ include file="/npage/include/header_pop.jsp" %>
				<div class="title"><div id="title_zi">增加新任务</div></div>
				<table width=90% >
					<tr >
			 			<td class="blue">
            	标&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;题：
            </td>
						<td >
							<INPUT type="text" id="promptTitle" name="promptTitle" size="21" maxlength="50"/>
						</td>
					</tr>
						<tr >
			 			<td class="blue">
            	任务级别
            </td>
						<td >
							<select id="tskRank" name="tskRank">
								<option value="0">一般任务</option>
								<option value="1">重要任务</option>
							</select>
						</td>
					</tr>
			 		<tr >
			 			<td class="blue">
            	任务开始日期：
            </td>
						<td >
							<INPUT type="text" id="promptTime" name="promptTime" value="<%=selDate%>" size="21" onclick="WdatePicker({dateFmt:'yyyyMMdd',autoPickDate:true,onpicked:function(){}})"  readOnly />
						</td>
					</tr>
					<tr >
			 			<td class="blue">
            	任务结束日期：
            </td>
						<td >
							<INPUT type="text" id="promptTimend" name="promptTimend"  value="<%=selDate%>" size="21" onclick="WdatePicker({dateFmt:'yyyyMMdd',autoPickDate:true,onpicked:function(){}})" readOnly />
						</td>
					</tr>
					
        		<td class="blue">
            	任务内容：
            </td>
            <td>
		          <textarea name="promptContent"  rows=10 cols= 40  ></textarea>
            </td>
			 		</tr>
					<tr >
						<td id="footer" colspan=2>
								<input  type="button" id=save66 name="submit" class="b_foot" value="确认" onclick="saveTsk()">
								&nbsp;
								<input  type="button" id=cls name="cls" class="b_foot" value="关闭" onclick="window.close()">
						</td>
					</tr>
				</table>
<%@ include file="/npage/include/footer_pop.jsp" %>
		</form>
	</body>
</html>
 
 
 