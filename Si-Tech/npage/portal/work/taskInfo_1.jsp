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
        var html = "��������&nbsp;<span style='color:white'>(<%=toDoCount%>)</span>";
        $("#task_title_top").html(html);
        */
</script>
				<table id="taskList"  cellpadding="0" cellspacing="0" border="1">
					<tr>
						<th>&nbsp;&nbsp;�������
							<div class="task_option">
								<ul>
									<li class="edit" onclick="getTodayTask();cancel();" title="����"></li>
									<li class="add" onclick="getAllTask(''); temp_cal_date = '';cancel();" title="ȫ��"></li>
									<li class="new" onclick="showNew();cancel();" title="δ���"></li>
									<li class="over" onclick="showFinished();cancel();" title="�����"></li>
								</ul>
							</div>
						</th>
						<th class="stime" >&nbsp;&nbsp;��ʼʱ��</th>
						<th class="etime">&nbsp;&nbsp;����ʱ��</th>
					</tr>
					<tr>
						<td >
							<input saveFlag="blank" class="caption-in" id="task_title" maxlength=127 name="Text1" value="������������" type="text" onfocus="$(this).val('');$('#cal').hide();$('.task-right').show();" />
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

	//������ʱ���Ƿ���ڿ�ʼʱ��
	 function customRange(input) { 
	    return {minDate: (input.id == "task_endTime" ? $("#task_startTime").datepicker("getDate") : null), 
	        maxDate: (input.id == "task_startTime" ? $("#task_endTime").datepicker("getDate") : null)}; 
	}

	 
//��ʾ���������

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
	 //�����ı���
	 function cancel(){
	 	var defaul = "";
	 	$('#task_title').attr("saveFlag","blank");
	 	$('#task_title').val(defaul);
	 	$('#task_content').val(defaul);
	 	$('#task_startTime').val(defaul);
	 	$('#task_endTime').val(defaul);
	 	$('.task-right').hide();
	 	$('#cal').show();
	 	if($("#task_title").val()==""){$("#task_title").val("������������");}
	 }
	 //��ӡ��޸� ����
	 function save(id){
	 	if(id != "blank"){
	 		if($('#task_content').val().length>127 || $('#task_content').val().trim().length == 0)
			{
				rdShowMessageDialog('�������ݲ���Ϊ�������127���֣�');
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
	 

	//չʾһ���������ϸ��Ϣ 
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
	//ɾ��һ������

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

	//����ɾ�����޸Ĳ���
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
			  	 rdShowMessageDialog("�����ɹ�",2);
			   }else{
			   	 rdShowMessageDialog("����ʧ��",0);
			   } 	
		   }
		});
		sendop_code=null; 
		*/
		}
		function doOperateTask(packet){
		    var retCode = packet.data.findValueByName("retCode");
				if(retCode.trim()=="000000"){
			  	 rdShowMessageDialog("�����ɹ�",2);
			   }else{
			   	 rdShowMessageDialog("����ʧ��",0);
			   } 	
			   getTodayTask();
		}

	 //�����������
	function addTask(title,content,startTime,endTime)
    {
		if(title.trim() == '' || startTime.trim() == '' || endTime.trim() == ''){
			rdShowMessageDialog("������⡢��ʼ����ʱ�䲻��Ϊ��",0);
			return;
		}
		if(content.length>127 || content.trim().length == 0 )
		{
			rdShowMessageDialog('�������ݲ���Ϊ�������127���֣�');
			return false;
		}
		//alert(title+" "+content+" "+startTime+" "+endTime);
		var packet = new AJAXPacket("addTask_cfm.jsp","���Ժ�...");
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
			  	 rdShowMessageDialog("��������ɹ�",2);
			  	getAllTask(temp_cal_date);
			   }else if(retCode.trim()=="000001"){
				 	 rdShowMessageDialog("ȡ������ˮ�Ų��ɹ���������ȷ��!",1);
			   }else{
			   	 rdShowMessageDialog("����ʧ��",0);
			   } 	
			   $("#task_content").val("");
			   $('.task-right').hide();
			   $('#cal').show();
			   getTodayTask();
		}

	//����ˢ���б����б�С��5ʱ����б����б���ɫ
	function showAll(){
		$('#taskList .null').parent().parent().remove();
		$('#taskList tr:gt(1)').show();
		addTr();
		setColor();
	}

	//ֻ��ʾ��������
	function showNew(){
		showAll();
		var trArr = $('#taskList tr:gt(1) span.over').parent().parent();
		$(trArr).hide();
		addTr();
		setColor();
	}

	//ֻ��ʾ���������
	function showFinished(){
		showAll();
		var trArr = $('#taskList tr:gt(1) span.new').parent().parent();
		$(trArr).hide();
		addTr();
		setColor();
	}

	//������������5�� ϵͳ�Զ����ӵ�5�� �����������ʾ
	function addTr(){
		var trArr = $('#taskList tr:gt(1):not(:hidden)');
		var size = $(trArr).size();
		if( size <5){
			for(i=0 ; i<5-size ; i++){
				$("<tr onclick='hidemenu()'><td><div  class='current null'></div><span>&nbsp</span></td><td>&nbsp</td><td>&nbsp</td></tr>").appendTo("#taskList");
			}
		}
	}

	//���б������ɫ
	function setColor(){
		$('#taskList tr:gt(1)').removeClass("bg-EFFBFF");
		$('#taskList tr:gt(1):not(:hidden):even').addClass("bg-EFFBFF"); 
	}

	//����������Ϊ�����
	function setTaskFinish(obj){
		operateTask($(obj).attr("login_accep"),'f','','','','');
		getAllTask(temp_cal_date);
		 hidemenu(); 
		 cancel();
	}

	//���б�����Ϊ����
	function setTaskToDo(obj){
		operateTask($(obj).attr("login_accep"),'t','','','','');
		getAllTask(temp_cal_date);
		 hidemenu();
		cancel();
	}
	
	/*���������б��Ҽ��˵�*/
    document.onclick = function(){
		hidemenu();
	}
</script>
