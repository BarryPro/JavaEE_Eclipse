



<%@ page contentType="text/html;charset=gb2312"%>


<script type="text/javascript" src="/njs/extend/jquery/jquery123_pack.js"></script>	
<script type="text/javascript" src="/njs/si/core_sitech_pack.js"></script>	
<script type="text/javascript" src="/njs/redialog/redialog.js"></script>
<script type="text/javascript" src="/njs/extend/jquery/block/jquery.blockUI.js"></script>
<script language="JavaScript" src="/njs/si/validate_pack.js"></script>
<link href="/nresources/default/css/FormText.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/default/css/font_color.css" rel="stylesheet" type="text/css"></link>
<link href="/nresources/default/css/ValidatorStyle.css" rel="stylesheet" type="text/css"></link>
<script type="text/javascript" src="/njs/extend/jquery/hotkey/jquery.hotkeys_jsa.js"></script>
<script type="text/javascript" src="/njs/redialog/redialog.js"></script>

<script language="javascript">
	$(document).ready(function() {
	
		
	//			document.oncontextmenu=new Function("event.returnValue=false");
		
					$.hotkeys.add('Ctrl+n', function(){
						rdShowMessageDialog("欢迎您使用黑龙江移动综合客户服务系统！");
						});
						
					$.hotkeys.add('Ctrl+r', function(){
						rdShowMessageDialog("欢迎您使用黑龙江移动综合客户服务系统！");
						});
				  $.hotkeys.add('f5', function(){
							rdShowMessageDialog("欢迎您使用黑龙江移动综合客户服务系统！");
							window.event.keyCode = 0;
							return;
						});

						$.hotkeys.add('f11', function(){
							rdShowMessageDialog("欢迎您使用黑龙江移动综合客户服务系统！");
							window.event.keyCode = 0;
							return;
						});
						
			$.hotkeys.add('Ctrl+s', function(){
						document.forms[0].submit();
					});	
		
      $.hotkeys.add('Ctrl+0', function(){
		      if((typeof parent.doCtrl)=="function")
					{
						parent.doCtrl("Ctrl+0");
					}else{
					  parent.parent.doCtrl("Ctrl+0");
					}
      	}); 	 
      	      
      $.hotkeys.add('Ctrl+1', function(){
			    if((typeof parent.doCtrl)=="function")
					{
						parent.doCtrl("Ctrl+1");
					}else{
					  parent.parent.doCtrl("Ctrl+1");
					}
      	}); 
      	
      $.hotkeys.add('Ctrl+2', function(){
		      if((typeof parent.doCtrl)=="function")
					{
						parent.doCtrl("Ctrl+2");
					}else{
					  parent.parent.doCtrl("Ctrl+2");
					}
      	}); 	 

      $.hotkeys.add('Ctrl+3', function(){
		      if((typeof parent.doCtrl)=="function")
					{
						parent.doCtrl("Ctrl+3");
					}else{
					  parent.parent.doCtrl("Ctrl+3");
					}
      	}); 	

      $.hotkeys.add('Ctrl+4', function(){
		      if((typeof parent.doCtrl)=="function")
					{
						parent.doCtrl("Ctrl+4");
					}else{
					  parent.parent.doCtrl("Ctrl+4");
					}
      	}); 	
      	
      $.hotkeys.add('Ctrl+5', function(){
		      if((typeof parent.doCtrl)=="function")
					{
						parent.doCtrl("Ctrl+5");
					}else{
					  parent.parent.doCtrl("Ctrl+5");
					}
      	}); 	
      	
      $.hotkeys.add('Ctrl+6', function(){
		      if((typeof parent.doCtrl)=="function")
					{
						parent.doCtrl("Ctrl+6");
					}else{
					  parent.parent.doCtrl("Ctrl+6");
					}
      	}); 	
      	
      $.hotkeys.add('Ctrl+7', function(){
		      if((typeof parent.doCtrl)=="function")
					{
						parent.doCtrl("Ctrl+7");
					}else{
					  parent.parent.doCtrl("Ctrl+7");
					}
      	}); 	
      	
      $.hotkeys.add('Ctrl+8', function(){
		      if((typeof parent.doCtrl)=="function")
					{
						parent.doCtrl("Ctrl+8");
					}else{
					  parent.parent.doCtrl("Ctrl+8");
					}
      	}); 	
      	
      $.hotkeys.add('Ctrl+9', function(){
		      if((typeof parent.doCtrl)=="function")
					{
						parent.doCtrl("Ctrl+9");
					}else{
					  parent.parent.doCtrl("Ctrl+9");
					}
      	}); 	
      	
     });
</script>      	




	
<script language="javascript">

/*
	$(document).ready(function() {
        
    //增加提交等待效果
		var formNum = document.forms.length;
		for(i=0;i<formNum;i++){
			var oldSubmit;
			var form=document.forms[i];
			if(form != null && form != 'undefined'){
				//备份submit函数
				form.oldSubmit = form.submit;
				//覆盖submit函数以实现拦截
				form.submit = function (){
		            //增加提交效果
		            loading();
		            //调原函数来提交
			    	form.oldSubmit();
				} 
			}
		}
		      	      	      	      	      	      	        
    });
   
   */
</script>



<script type="text/javascript" src="/njs/csp/funcRoleRel.js"></script>
<script>
function checkRole(pArr){
	var temp='011006,';
	lArr=temp.split(',');
	var flag=false;
	if(pArr.length>0){
		for(var i=0;i<pArr.length;i++){
			for(var j=0;j<lArr.length;j++){
				if(lArr[j]==pArr[i]){
					flag=true;
					break;
				}
			}
		}
}
	return flag;
}	

	
</script>	

<!--add by hanjc20090731 从内存中读取正在通话的接续记录---begin--->


<!--add by hanjc20090731 从内存中读取正在通话的接续记录---end--->






	




	





<html>
	<head>
			







<script language="javascript">
   //选中行高亮显示
		var hisObj="";//保存上一个变色对象
		var hisColor=""; //保存上一个对象原始颜色
		/**
   *hisColor ：当前tr的className
   *obj       ：当前tr对象
   */
   
   //修改来电原因，必须在此申明这两个变量
   var xmlHelper = window.top.xmlHelper;
	 var xmlSeach  = window.top.xmlSeach;

		function changeColor(color,obj){
		  //恢复原来一行的样式
		  if(hisObj != ""){
			 for(var i=0;i<hisObj.cells.length;i++){
				var tempTd=hisObj.cells.item(i);
				//tempTd.className=hisColor; 还原字的颜色
				tempTd.style.backgroundColor = '#F7F7F7';		//还原行背景颜色
			 }
			}
				hisObj   = obj;
				hisColor = color;
		  //设置当前行的样式
			for(var i=0;i<obj.cells.length;i++){
				var tempTd=obj.cells.item(i);
				//tempTd.className='green'; 改变字的颜色
				tempTd.style.backgroundColor='#00BFFF';	//改变行背景颜色
			}
		}
	/*****************分页方法 begin******************/
	function doLoad(operateCode){
		var formobj = parent.queryFrame2.document.sitechform;
		 var str='1';
	   if(operateCode=="load")
	   {
	   	formobj.page.value="";
	   	str='0';
	   }
	   else if(operateCode=="first")
	   {
	   	formobj.page.value=1;
	   }
	   else if(operateCode=="pre")
	   {
	   	formobj.page.value=0;
	   }
	   else if(operateCode=="next")
	   {
	   	formobj.page.value=2;
	   }
	   else if(operateCode=="last")
	   {
	   	formobj.page.value=1;
	   }
	   parent.queryFrame2.submitMe(str); 
	}
	/***************分页方法结束**************/
	
	//居中打开窗口
		function openWinMid(url,name,iHeight,iWidth)
		{
		  //var url; //转向网页的地址;
		  //var name; //网页名称，可为空;
		  //var iWidth; //弹出窗口的宽度;
		  //var iHeight; //弹出窗口的高度;
		  var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
		  var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
		  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
		}
	  //去左空格;
		function ltrim(s){
		  return s.replace( /^\s*/, "");
		}
		//去右空格;
		function rtrim(s){
		return s.replace( /\s*$/, "");
		}
		//去左右空格;
		function trim(s){
		return rtrim(ltrim(s));
		}
		//跳转到指定页面
		function jumpToPage(operateCode){
			
			 if(operateCode=="jumpToPage")
		   {
		   	  var thePage = document.getElementById("thePage").value;
		   	  if(trim(thePage)!=""){
		   		 parent.queryFrame2.window.sitechform.page.value=parseInt(thePage);
		   		 doLoad('0');
		   	  }
		   }
		   else if(operateCode=="jumpToPage1")
		   {
		   	  var thePage=document.getElementById("thePage1").value;
		   	  if(trim(thePage)!=""){
		   		 parent.queryFrame2.window.sitechform.page.value=parseInt(thePage);
		       doLoad('0');
		      }
		   }else if(trim(operateCode)!=""){
		   	 parent.queryFrame2.window.sitechform.page.value=parseInt(operateCode);
		   	 doLoad('0');
		   }
		}
		
		//听取录音****************************begin**************/
		function checkCallListen(id,staffno){
				if(id==''){
				return;
				}
				if("Y"=="N"){
					if('2146'!=staffno){
					  rdShowMessageDialog("您没有听取该录音的权限！");
					  return;
				  }
				}
			var packet = new AJAXPacket("/npage/callbosspage/k170/k170_checkIsListen_rpc.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
			packet.data.add("contact_id",id);
			core.ajax.sendPacket(packet,doProcessGetPath,false);
			packet=null;
		}
		
		 function doLisenRecord(filepath,contact_id)
			{
					   window.top.document.getElementById("recordfile").value=filepath;
					   window.top.document.getElementById("lisenContactId").value=contact_id;
					   window.top.document.getElementById("K042").click();
						var packet = new AJAXPacket("../../../npage/callbosspage/K042/lisenRecord.jsp","正在处理,请稍后...");
				     packet.data.add("retType" ,  "chkExample");
				     packet.data.add("filepath" ,  filepath);
				     packet.data.add("liscontactId" ,contact_id);
				    core.ajax.sendPacket(packet,doProcessNavcomring,true);
						packet =null;
			}
			function getCallListen(id){
				if(id==''){
						return;
				}			
				openWinMid("k170_getCallListen.jsp?flag_id="+id,'录音听取',650,850);
			}
			
			function doProcessNavcomring(packet)
			 {
			    var retType = packet.data.findValueByName("retType");
			    var retCode = packet.data.findValueByName("retCode");
			    var retMsg = packet.data.findValueByName("retMsg");
			    if(retType=="chkExample"){
			    	if(retCode=="000000"){
			    		//alert("处理成功!");
			    	}else{
			    		//alert("处理失败!");
			    		return false;
			    	}
			    }
			 }
			 
			 function doProcessGetPath(packet){
			   var file_path = packet.data.findValueByName("file_path");
			   var flag = packet.data.findValueByName("flag");
			   var contact_id = packet.data.findValueByName("contact_id");
			   if(flag=='Y'){
			   	doLisenRecord(file_path,contact_id);
			   }else{
			   	getCallListen(contact_id)	;
			   }		
			 }
			 /****************听取录音方法end********************/
			 
			 //显示通话详细信息
			function getCallDetail(contact_id,start_date){
				if(contact_id==''){
					return;
				}
				var path="/npage/callbosspage/k170/k170_getCallDetail.jsp";
			  path = path + "?contact_id=" + contact_id;
			  path = path + "&start_date=" + start_date;
			  openWinMid(path,"信息详情",680,960);
				return true;
			}
			
			//保存录音
			function keepRec(id,staffno){
			 if("Y"=="N"){
					if('2146'!=staffno){
					  rdShowMessageDialog("您没有听取该录音的权限！");
					  return;
				  }
			 }
			 if(id==''){
					return;
			 }
			 openWinMid("k170_download.jsp?flag_id="+id,'另存录音到本地',450,850);
			}
			
			//显示呼叫轨迹
			function showCallLoc(){
				//rdShowMessageDialog("显示呼叫轨迹",2);
				//openWinMid("k170_showCallLoc.jsp",'显示呼叫轨迹',480,640);
			}
			
			//判断当前工号是否有该流水工号的质检计划******************begin******/
			function checkIsHavePlan(serialnum,flag,staffno){
				var mypacket = new AJAXPacket("/npage/callbosspage/k170/k170_checkIsHavePlan_rpc.jsp","正在进行计划校验，请稍候......");
				mypacket.data.add("serialnum",serialnum);
			  mypacket.data.add("start_date",parent.queryFrame2.window.sitechform.start_date.value);
			  mypacket.data.add("flag",flag);
			  mypacket.data.add("staffno",staffno);
			  core.ajax.sendPacket(mypacket,doProcessIsHavePlan,true);
				mypacket=null;
			}
			
			function doProcessIsHavePlan(packet){
				var serialnum = packet.data.findValueByName("serialnum");
				var planCounts = packet.data.findValueByName("planCounts");
				var flag = packet.data.findValueByName("flag");
			  var staffno = packet.data.findValueByName("staffno");
				
			  if(parseInt(planCounts)>0){
			    checkIsQc(serialnum,flag,staffno);
				}else{
					rdShowMessageDialog("您目前无该工号的质检计划！");
				}
			}
			
			//质检前判断是否已被质检过
			//flag 0:计划外质检 1:计划内质检
			function checkIsQc(serialnum,flag,staffno){
				var mypacket = new AJAXPacket("/npage/callbosspage/k170/k170_checkIsQc_rpc.jsp","正在进行已质检校验，请稍候......");
				mypacket.data.add("serialnum",serialnum);
			  mypacket.data.add("start_date",parent.queryFrame2.window.sitechform.start_date.value);
			  mypacket.data.add("flag",flag);
			  mypacket.data.add("staffno",staffno);
			  core.ajax.sendPacket(mypacket,doProcess,true);
				mypacket=null;
			}
			
			function doProcess(packet){
				var serialnum = packet.data.findValueByName("serialnum");
				var checkList = packet.data.findValueByName("checkList");
				var isOutPlanflag = packet.data.findValueByName("flag");
			  var staffno = packet.data.findValueByName("staffno");
				
			  if(parseInt(checkList)<1){
			    planInQua(serialnum,staffno);
				}else{
					rdShowMessageDialog("该流水已经进行过质检，不能重复进行！");
				}
			}
			
			/**
			  *
			  *弹出对流水进行质检窗口
			  */
			function planInQua(serialnum,staffno){
				var  path = '/npage/callbosspage/checkWork/K217/K218_select_plan.jsp?serialnum=' + serialnum+'&staffno='+staffno;
				//计划内质检tabid为流水加0，计划外质检为流水加1
				if(!parent.parent.document.getElementById(serialnum+0)){
				parent.parent.addTab(true,serialnum+0,'执行质检计划',path);
			  }
			}
			/*****************************end***********************/
			
			/**
			  *
			  *弹出计划外质检窗口
			  */
			function planOutQua(serialnum,staffno){
				var path ='/npage/callbosspage/checkWork/K217/K217_select_check_content.jsp?serialnum=' + serialnum+'&staffno='+staffno+'&isOutPlanflag=0';
				var param  = 'dialogWidth=900px;dialogHeight=300px';
				//window.showModalDialog('../checkWork/K217/K217_select_check_content.jsp?serialnum=' + serialnum+'&staffno='+staffno+'&isOutPlanflag=0','', param);
				//window.open(path,'', 'width=900px;height=300px');
				//alert(serialnum);
					if(!parent.parent.document.getElementById(serialnum+1)){
				   parent.parent.addTab(true,serialnum+1,'执行质检计划',path);
			    }
			}
			
			
			//加载页面时将sql语句的where条件赋值给上面的sqlWhere隐藏域，以便导出操作
			function insertParentFrameValue(){
				
				parent.queryFrame.document.sitechform.sqlWhere.value = "200910  where begin_date >= to_date('20091004 00:00:00','yyyyMMdd hh24:mi:ss') and begin_date <= to_date('20091004 23:59:59','yyyyMMdd hh24:mi:ss') and accept_login_no = 'kf8400' order by begin_date desc";
			}
			
			//页面缩放
			function showQuery(frameset){				
				if(parent.document.all(frameset).rows=="0,*"){					
					parent.document.all(frameset).rows="180,*";					
					
				}else{
					
					parent.document.all(frameset).rows="0,*";					
				}
			}
			function modifyCallCauseTree(strNode_Id,contact_id,start_date){
			
				 var path="/npage/callbosspage/k170/callreason.jsp";
			    path = path + "?contactId=" + contact_id;
			    path = path + "&contactMonth=" + start_date.substr(0,6);
			    //path = path + "&strnodeid="+ strNode_Id;
			    //alert(path);
			   	//alert(xmlHelper);
			    window.open(path,'来电原因异动修改','scrollbars=yes,height=600, width=500');
			  
				/*
				  var path="/npage/callbosspage/k170/k172_modifyCallCauseTree.jsp";
			    path = path + "?contact_id=" + contact_id;
			    path = path + "&contactMonth=" + start_date;
			    path = path + "&strnodeid="+ strNode_Id;
			   // alert(path);
			    window.open(path,'来电原因异动修改','scrollbars=yes,height=600, width=500');
			  */
			}
			
			//判断当前工号是否有该流水工号的质检计划
			function checkIsHavePlan(serialnum,flag,staffno){
				var mypacket = new AJAXPacket("/npage/callbosspage/k170/k170_checkIsHavePlan_rpc.jsp","正在进行计划校验，请稍候......");
				mypacket.data.add("serialnum",serialnum);
			  mypacket.data.add("start_date",parent.queryFrame2.window.sitechform.start_date.value);
			  mypacket.data.add("flag",flag);
			  mypacket.data.add("staffno",staffno);  
			  core.ajax.sendPacket(mypacket,doProcessIsHavePlan,true);
				mypacket=null;
			}
			
			function doProcessIsHavePlan(packet){
				var serialnum = packet.data.findValueByName("serialnum");
				var planCounts = packet.data.findValueByName("planCounts");
				var flag = packet.data.findValueByName("flag");
			  var staffno = packet.data.findValueByName("staffno");	
				//alert(parseInt(checkList)+parseInt(checkMutList));
			  if(parseInt(planCounts)>0){
			    checkIsQc(serialnum,flag,staffno);
				}else{
					rdShowMessageDialog("您目前无该工号的质检计划！");
				}
			}
			
			//页面加载顺序故由这里加载加载result_cause.jsp页面时将sql语句的where条件赋值给上面的sqlWhere隐藏域，以便导出操作
			function insertParentFrameValue(){				
				try{
					if(parent.queryFrame2.document.sitechform.sqlWhere!=undefined){
						
						parent.queryFrame2.document.sitechform.sqlWhere.value = "200910  where begin_date >= to_date('20091004 00:00:00','yyyyMMdd hh24:mi:ss') and begin_date <= to_date('20091004 23:59:59','yyyyMMdd hh24:mi:ss') and accept_login_no = 'kf8400' order by begin_date desc";
						
					}else{
						
						insertParentFrameValue();
					}
			  }catch(e){
			  	
			  }						
			}
			
			function canNotModify()
			{
				rdShowMessageDialog("超时，修改无效!");
			}
</script>
	</head>
	<body onLoad="insertParentFrameValue();">
		<div id="Operation_Table">
			<input type="button" class="b_foot" value = "展开/收起" onClick="showQuery('frameset120');" >
      <input type="button" class="b_foot" value = "刷新" onClick="parent.queryFrame2.submitInputCheck();">
			<table cellspacing="0">
				<tr>
					<td class="blue" align="left" colspan="24">
						
						第
						1
						页 共
						1
						页 共
						1
						条
						
						
						
						
						
						
					</td>
				</tr>

				<input type="hidden" name="chkBoxNum" value="1">
				<input type="hidden" name="page" value="">
				<input type="hidden" name="myaction" value="">
				<input type="hidden" name="sqlFilter" value="">
				<input type="hidden" name="sqlWhere" value="">
				<tr>
					<script>
       	var tempBool ='flase';
      	if(checkRole(K171A_RolesArr)==true||checkRole(K171B_RolesArr)==true||checkRole(K171C_RolesArr)==true||checkRole(K171D_RolesArr)==true||checkRole(K171E_RolesArr)==true||checkRole(K171F_RolesArr)==true||checkRole(K171G_RolesArr)==true||checkRole(K171H_RolesArr)==true){	
      		document.write('<th align="center" class="blue" width="15%" nowrap > 操作 </th>');	
      		tempBool='true';
      	}
        </script>
					<th align="center" class="blue" width="8%" nowrap >
						流水号
					</th>
					<th align="center" class="blue" width="9%" nowrap >
						受理时间
					</th>
					<th align="center" class="blue" width="8%" nowrap >
						来电原因
					</th>
					<th align="center" class="blue" width="8%" nowrap >
						主叫号码
					</th>
					<th align="center" class="blue" width="9%" nowrap >
						客户名称
					</th>
					<th align="center" class="blue" width="8%" nowrap >
						客户地市
					</th>
					<th align="center" class="blue" width="5%" nowrap >
						客户满意度
					</th>
					<th align="center" class="blue" width="5%" nowrap >
						受理号码
					</th>
					<th align="center" class="blue" width="5%" nowrap >
						受理工号
					</th>
					<th align="center" class="blue" width="4%" nowrap >
						通话时长
					</th>
					<th align="center" class="blue" width="5%" nowrap >
						受理方式
					</th>
					<th align="center" class="blue" width="5%" nowrap >
						是否密码验证
					</th>
					<th align="center" class="blue" width="5%" nowrap >
						是否他机验证
					</th>	
					<th align="center" class="blue" width="4%" nowrap >
						外呼流水号
					</th>
					<th align="center" class="blue" width="5%" nowrap >
						备注
					</th>									
				</tr>
          
				<tr onClick="changeColor('blue',this);">

					<script>
        if(tempBool=='true'){
      		document.write('<td align="center" class="blue" >');
      	}
      	if(checkRole(K172A_RolesArr)==true){	
      		document.write('<img style="cursor:hand" onclick="checkCallListen(\'2009100409393742146vU\',\'2146\');return false;" alt="听取语音" src="/nresources/default/images/callimage/operImage/1.gif" width="16" height="16" align="absmiddle">&nbsp;');	
      	}
        if(checkRole(K172B_RolesArr)==true){	
      		document.write('<img style="cursor:hand" onclick="getCallDetail(\'2009100409393742146vU\',\'20091004\');return false;" alt="显示该通话的详细情况" src="/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">&nbsp;');	
      	}
      	if(checkRole(K172C_RolesArr)==true){	
          
            document.write('<img style="cursor:hand" onclick="modifyCallCauseTree(\'\',\'2009100409393742146vU\',\'20091004\');return false;" alt="修改来电原因" src="/nresources/default/images/callimage/operImage/2.gif" width="16" height="16" align="absmiddle">&nbsp;');
         
      	}<!-- dataRows[i][14] 改为 dataRows[i][8]-->
      	if(checkRole(K172D_RolesArr)==true){	
      		document.write('<img style="cursor:hand" onclick="checkIsHavePlan(\'2009100409393742146vU\',1,\'kf8400\')" alt="计划内质检考评" src="/nresources/default/images/callimage/operImage/5.gif" width="16" height="16" align="absmiddle">&nbsp;');	
      	}
      	if(checkRole(K172E_RolesArr)==true){	
      		document.write('<img style="cursor:hand" onclick="planOutQua(\'2009100409393742146vU\',\'kf8400\')" alt="计划外质检考评" src="/nresources/default/images/callimage/operImage/9.gif" width="16" height="16" align="absmiddle">&nbsp;');	
      	}
      	if(checkRole(K172F_RolesArr)==true){	
      		document.write('<img style="cursor:hand" onclick="keepRec(\'2009100409393742146vU\',\'kf8400\')" alt="另存录音到本地" src="/nresources/default/images/callimage/operImage/3.gif" width="16" height="16" align="absmiddle">');	
      	}
        if(tempBool=='true'){
      		document.write('</td>');
      	}      	
      </script>
					<!--      	
       <img onclick="checkCallListen('2009100409393742146vU');return false;" alt="听取语音" src="/nresources/default/images/callimage/operImage/1.gif" width="16" height="16" align="absmiddle">
       <img onclick="getCallDetail('2009100409393742146vU','20091004');return false;" alt="显示该通话的详细情况" src="/nresources/default/images/callimage/operImage/4.gif" width="16" height="16" align="absmiddle">
       -->
					<!--

       <img onclick="modifyCallCauseTree('','2009100409393742146vU','20091004');return false;" alt="修改来电原因" src="/nresources/default/images/callimage/operImage/2.gif" width="16" height="16" align="absmiddle">
s
       -->
					<!--
       <img onclick="checkIsHavePlan('2009100409393742146vU',0)" alt="计划内质检考评" src="/nresources/default/images/callimage/operImage/5.gif" width="16" height="16" align="absmiddle">
       <img onclick="checkIsQc('2009100409393742146vU',1)" alt="计划外质检考评" src="/nresources/default/images/callimage/operImage/9.gif" width="16" height="16" align="absmiddle">
       <img onclick="keepRec()" alt="另存录音到本地" src="/nresources/default/images/callimage/operImage/3.gif" width="16" height="16" align="absmiddle">
       -->
					<td align="center" class="blue" nowrap >
						2009100409393742146vU
					</td>
					<td align="center" class="blue" nowrap >
						2009-10-04 09:39:54
					</td>
					<td align="center" class="blue" nowrap >
						<span id=035001001004 ><长春->查询类->话费查询类->套餐使用量查询><br></span>
					</td>
					<td align="center" class="blue" nowrap >
						2120
					</td>
					<td align="center" class="blue" nowrap >
						&nbsp;
					</td>
					<td align="center" class="blue" nowrap >
						&nbsp;
					</td>
					<td align="center" class="blue" nowrap >
						未处理
					</td>
					<td align="center" class="blue" nowrap >
						2120
					</td>
					<td align="center" class="blue" nowrap >
						kf8400
					</td>
					<td align="center" class="blue" nowrap >
						36
					</td>
					<td align="center" class="blue" nowrap >
						内部求助
					</td>
					<td align="center" class="blue" nowrap >
						否
					</td>	
					<td align="center" class="blue" nowrap >
						否
					</td>						
					<td align="center" class="blue" nowrap >
						&nbsp;
					</td>
					<td align="center" class="blue" nowrap >
						&nbsp;
					</td>								
				</tr>
				

				<tr>
					<td class="blue"  align="right" colspan="24">
						
						第
						1
						页 共
						1
						页 共
						1
						条
						
						
						
						
						
						
					</td>
				</tr>
			</table>
		</div>
		<!--input id='show_content_btn' type='button' onclick='showContent()'  value='show'/>
		<input id='hide_content_btn' type='button' onclick='hideContent()'  value='hide'/-->
		<a id='show_content_btn' href="#" onclick="showContent()">更多>></a>
		<a id='hide_content_btn' href="#" onclick="hideContent()">更多<<</a>
		<div id='test' >
			<table bordercolor="#EEBBFF" border="2" bgcolor="#EFefef">
				<tr><td>111111</td></tr>
		</table>
			</div>
		<div id='test1' >
			<table bordercolor="#EEBBFF" border="2" bgcolor="#EFefef">
				<tr><td>222222</td></tr>
		</table>
			</div>
	</body>
</html>

<script>
	
	function hideContent(){
	    //$('#show_content_btn').style.display='block';
		//$('#hide_content_btn').style.display='none';
		document.getElementById('show_content_btn').style.display='block';
		document.getElementById('hide_content_btn').style.display='none';
		$("#test").slideUp("fast"); 
		//$("#test").fadeOut("slow"); 
		
	}
	function showContent(){
		//$('#show_content_btn').style.display='none';
		//$('#hide_content_btn').style.display='block';
		document.getElementById('show_content_btn').style.display='none';
		document.getElementById('hide_content_btn').style.display='block';
		$("#test").slideDown("fast"); 
		//$("#test").fadeIn("slow"); 
		
	}
	
	//alert($("test"));
	
</script>
