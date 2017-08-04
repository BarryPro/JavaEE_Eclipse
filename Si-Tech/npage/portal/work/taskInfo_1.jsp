<%@ page contentType= "text/html;charset=GBK" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
String workNo = (String)session.getAttribute("workNo");
String regionCode = (String)session.getAttribute("regCode");
String flag = (String)request.getParameter("flag");
String searchTime = (String)request.getParameter("searchTime");
String finished = "1";
String toWork = "0"; 

%>

<wtc:service name="sTaskOutput" outnum="7" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=workNo%>" />
  	<wtc:param value="<%=flag%>" />
  	<wtc:param value="<%=searchTime%>" />
</wtc:service>
<wtc:array id="tasks" scope="end"/>	
<%
System.out.println("*******************************************retCode "+retCode);
System.out.println("*******************************************tasks.length "+tasks.length);
if(!retCode.equals("000000"))
{
	out.println("");
	return;
}

String toDoCount = "0";

if(tasks.length != 0){
        toDoCount = tasks[0][6];
}

%>
<script language=javascript>
        /*
        var html = "待办任务&nbsp;<span style='color:white'>(<%=toDoCount%>)</span>";
        $("#task_title_top").html(html);
        */
</script>
				<table id="taskList"  cellpadding="0" cellspacing="0" border="1">
					<tr>
						<th>&nbsp;&nbsp;任务标题
							<div class="task_option">
								<ul>
									<li class="edit" onclick="getTodayTask();cancel();" title="今天"></li>
									<li class="add" onclick="getAllTask(''); temp_cal_date = '';cancel();" title="全部"></li>
									<li class="new" onclick="showNew();cancel();" title="未完成"></li>
									<li class="over" onclick="showFinished();cancel();" title="已完成"></li>
								</ul>
							</div>
						</th>
						<th class="stime" >&nbsp;&nbsp;开始时间</th>
						<th class="etime">&nbsp;&nbsp;结束时间</th>
					</tr>
					<tr>
						<td >
							<input saveFlag="blank" class="caption-in" id="task_title" maxlength=127 name="Text1" value="点击添加新任务" type="text" onfocus="$(this).val('');$('#cal').hide();$('.task-right').show();" />
						</td>
						<td>
							<input class="stime-in task_date" id="task_startTime" name="Text2" type="text" task_date />
						</td>
						<td>
							<input class="etime-in task_date" id="task_endTime" name="Text3" type="text" />
						</td>
					</tr>
					<%
					int tasksSize = tasks.length;
					for(int i=0 ; i<tasksSize ; i++){
						StringBuffer taskListBuffer = new StringBuffer();
						taskListBuffer.append("<tr onclick='showTask(this)' oncontextmenu='javascript:showmenu(this);return false;' onmouseover='this.style.cursor=\"hand\"' tr_content='"+tasks[i][1]+"'  login_accep='"+tasks[i][2]+"'><td><div class='current'></div>");
						if(finished.equals(tasks[i][5])){
							taskListBuffer.append("<span class='over floatleft'></span>");
						}else{
							taskListBuffer.append("<span class='new floatleft'></span>");	
						}
						taskListBuffer.append("<span class='text'>"+tasks[i][0]+"</span></td><td id=td_sTime> "+tasks[i][3]+"</td><td id=td_eTime>"+tasks[i][4]+"</td></tr>");
						out.println(taskListBuffer.toString());
					}
					%>
				</table>
<script type="text/javascript">
	showAll();
	$('#work-portal #cal').datepicker(	{
	dateFormat:"y/mm/dd",
	 onSelect: function(cdate) { 
		       	 //alert("The chosen date is " + date); 
						 temp_cal_date = cdate;
		       	 getAllTask(cdate);
		    	} 
	});	 
	$('#work-portal .task_date').datepicker({beforeShow: customRange,duration: "",dateFormat:"y/mm/dd"});
	$('#taskList tr:gt(1)').mouseover(function(){
			$("#taskList").find(".current").removeClass('on');
			//alert($(this).find(".current").html());
			$(this).children().children(".current").addClass('on');
		})

	//检查结束时间是否大于开始时间
	 function customRange(input) { 
	    return {minDate: (input.id == "task_endTime" ? $("#task_startTime").datepicker("getDate") : null), 
	        maxDate: (input.id == "task_startTime" ? $("#task_endTime").datepicker("getDate") : null)}; 
	}

	 
//显示当天的任务

function getTodayTask(){
	
	if($(".ui-datepicker-current-day")){
		$('#cal .ui-datepicker-current-day').removeClass("ui-datepicker-current-day");	
	}
	_date = new Date();
	var month = _date.getMonth()+1;
	var year = _date.getYear() + "/";
	str  = year.substring(2,5) + month+ "/" + _date.getDate();
	temp_cal_date = str;
	$(".task-left").load("taskInfo_1.jsp?flag=3&searchTime="+str);
}
	 //重置文本框
	 function cancel(){
	 	var defaul = "";
	 	$('#task_title').attr("saveFlag","blank");
	 	$('#task_title').val(defaul);
	 	$('#task_content').val(defaul);
	 	$('#task_startTime').val(defaul);
	 	$('#task_endTime').val(defaul);
	 	$('.task-right').hide();
	 	$('#cal').show();
	 	if($("#task_title").val()==""){$("#task_title").val("点击添加新任务");}
	 }
	 //添加、修改 保存
	 function save(id){
	 	if(id != "blank"){
	 		if($('#task_content').val().length>127 || $('#task_content').val().trim().length == 0)
			{
				rdShowMessageDialog('任务内容不能为空且最多127个字！');
				return false;
			}
	 		operateTask(id,'u',$('#task_title').val(),$('#task_content').val(),$('#task_startTime').val(),$('#task_endTime').val());
	 		var oldTr = $("#taskList").find("tr[login_accep='"+id+"']");
	 		$(oldTr).attr("tr_content",$('#task_content').val());
	 		$(oldTr).find("span").html($('#task_title').val());
	 		$(oldTr).children("td[id='td_sTime']").html($('#task_startTime').val());
	 		$(oldTr).children("td[id='td_eTime']").html($('#task_endTime').val());
	 		cancel();
	 	}else{
	 		addTask($('#task_title').val(),$('#task_content').val(),$('#task_startTime').val(),$('#task_endTime').val());	 		
	 	}
	 }
	 

	//展示一个任务的详细信息 
	function showTask(obj,icon){
		if(icon == "icon"){
			rightClickCount = 0;
		}else{
			if(rightClickCount >0){
			rightClickCount = 0;
			hidemenu();
			return;
		}
		}

		$('#task_title').attr("saveFlag",$(obj).attr("login_accep"));
		$('#task_title').val($(obj).find("span[class='text']").html());
		$('#task_startTime').val($(obj).children("td[id='td_sTime']").html());
		$('#task_endTime').val($(obj).children("td[id='td_eTime']").html());
		$('#task_content').val($(obj).attr("tr_content"));
		$('#cal').hide();
		$('.task-right').show()
		 hidemenu();
	}
	//删除一个任务

	function del(obj){
		/*
		alert($(obj).attr("login_accep"));
		alert($(obj).find("span").html());
		alert($(obj).attr("tr_content"));
		alert($(obj).children("td[id='td_sTime']").html());
		alert($(obj).children("td[id='td_eTime']").html());
		*/
		operateTask($(obj).attr("login_accep"),'d',$(obj).find("span").html(),$(obj).attr("tr_content"),$(obj).children("td[id='td_sTime']").html(),$(obj).children("td[id='td_eTime']").html());

		$(obj).remove();
		showAll();
		 hidemenu();
		 cancel();
	}

	//包括删除、修改操作
	function operateTask(id,flag,title,content,startTime,endTime){
		//alert(id+" "+flag+" "+title+" "+content+" "+startTime+" "+endTime);
		var packet = new AJAXPacket("operateTask_cfm.jsp");
		packet.data.add("id" , id);
		packet.data.add("flag" , flag);
		packet.data.add("title",encodeURI(title));
		packet.data.add("content",encodeURI(content));
		packet.data.add("startTime",startTime);
		packet.data.add("endTime",endTime);
		core.ajax.sendPacket(packet,doOperateTask,true);
		packet =null;
		/*	
		var sendop_code = {};
		sendop_code["id"] = id;
		sendop_code["flag"] = flag;
		sendop_code["title"] = title;
		sendop_code["content"] = content;
		sendop_code["startTime"] = startTime;
		sendop_code["endTime"] = endTime;
		$.ajax({
		   url: 'operateTask_cfm.jsp',
		   type: 'POST',
		   data: sendop_code,
		   success: function(retCode){
			  if(retCode.trim()=="000000"){
			  	 rdShowMessageDialog("操作成功",2);
			   }else{
			   	 rdShowMessageDialog("操作失败",0);
			   } 	
		   }
		});
		sendop_code=null; 
		*/
		}
		function doOperateTask(packet){
		    var retCode = packet.data.findValueByName("retCode");
				if(retCode.trim()=="000000"){
			  	 rdShowMessageDialog("操作成功",2);
			   }else{
			   	 rdShowMessageDialog("操作失败",0);
			   } 	
			   getTodayTask();
		}

	 //加入待办任务
	function addTask(title,content,startTime,endTime)
    {
		if(title.trim() == '' || startTime.trim() == '' || endTime.trim() == ''){
			rdShowMessageDialog("任务标题、开始结束时间不能为空",0);
			return;
		}
		if(content.length>127 || content.trim().length == 0 )
		{
			rdShowMessageDialog('任务内容不能为空且最多127个字！');
			return false;
		}
		//alert(title+" "+content+" "+startTime+" "+endTime);
		var packet = new AJAXPacket("addTask_cfm.jsp","请稍后...");
		packet.data.add("title", encodeURI(title));
		packet.data.add("content", encodeURI(content));
		packet.data.add("startTime",startTime);
		packet.data.add("endTime",endTime);
		core.ajax.sendPacket(packet,doAddTask,true);
		packet = null;
	}

	function doAddTask(packet){
		    var retCode = packet.data.findValueByName("retCode");
				if(retCode.trim()=="000000"){
			  	 rdShowMessageDialog("加入任务成功",2);
			  	getAllTask(temp_cal_date);
			   }else if(retCode.trim()=="000001"){
				 	 rdShowMessageDialog("取操作流水号不成功，请重新确认!",1);
			   }else{
			   	 rdShowMessageDialog("加入失败",0);
			   } 	
			   $("#task_content").val("");
			   $('.task-right').hide();
			   $('#cal').show();
			   getTodayTask();
		}

	//重新刷新列表并当列表小于5时填充列表并对列表着色
	function showAll(){
		$('#taskList .null').parent().parent().remove();
		$('#taskList tr:gt(1)').show();
		addTr();
		setColor();
	}

	//只显示待办事项
	function showNew(){
		showAll();
		var trArr = $('#taskList tr:gt(1) span.over').parent().parent();
		$(trArr).hide();
		addTr();
		setColor();
	}

	//只显示已完成事项
	function showFinished(){
		showAll();
		var trArr = $('#taskList tr:gt(1) span.new').parent().parent();
		$(trArr).hide();
		addTr();
		setColor();
	}

	//当任务数少于5个 系统自动增加到5个 以满足界面显示
	function addTr(){
		var trArr = $('#taskList tr:gt(1):not(:hidden)');
		var size = $(trArr).size();
		if( size <5){
			for(i=0 ; i<5-size ; i++){
				$("<tr onclick='hidemenu()'><td><div  class='current null'></div><span>&nbsp</span></td><td>&nbsp</td><td>&nbsp</td></tr>").appendTo("#taskList");
			}
		}
	}

	//对列表隔行着色
	function setColor(){
		$('#taskList tr:gt(1)').removeClass("bg-EFFBFF");
		$('#taskList tr:gt(1):not(:hidden):even').addClass("bg-EFFBFF"); 
	}

	//将任务设置为已完成
	function setTaskFinish(obj){
		operateTask($(obj).attr("login_accep"),'f','','','','');
		getAllTask(temp_cal_date);
		 hidemenu(); 
		 cancel();
	}

	//将列表设置为待办
	function setTaskToDo(obj){
		operateTask($(obj).attr("login_accep"),'t','','','','');
		getAllTask(temp_cal_date);
		 hidemenu();
		cancel();
	}
	
	/*隐藏任务列表右键菜单*/
    document.onclick = function(){
		hidemenu();
	}
</script>
