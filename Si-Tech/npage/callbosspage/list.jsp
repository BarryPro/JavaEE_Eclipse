



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
						rdShowMessageDialog("��ӭ��ʹ�ú������ƶ��ۺϿͻ�����ϵͳ��");
						});
						
					$.hotkeys.add('Ctrl+r', function(){
						rdShowMessageDialog("��ӭ��ʹ�ú������ƶ��ۺϿͻ�����ϵͳ��");
						});
				  $.hotkeys.add('f5', function(){
							rdShowMessageDialog("��ӭ��ʹ�ú������ƶ��ۺϿͻ�����ϵͳ��");
							window.event.keyCode = 0;
							return;
						});

						$.hotkeys.add('f11', function(){
							rdShowMessageDialog("��ӭ��ʹ�ú������ƶ��ۺϿͻ�����ϵͳ��");
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
        
    //�����ύ�ȴ�Ч��
		var formNum = document.forms.length;
		for(i=0;i<formNum;i++){
			var oldSubmit;
			var form=document.forms[i];
			if(form != null && form != 'undefined'){
				//����submit����
				form.oldSubmit = form.submit;
				//����submit������ʵ������
				form.submit = function (){
		            //�����ύЧ��
		            loading();
		            //��ԭ�������ύ
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

<!--add by hanjc20090731 ���ڴ��ж�ȡ����ͨ���Ľ�����¼---begin--->


<!--add by hanjc20090731 ���ڴ��ж�ȡ����ͨ���Ľ�����¼---end--->






	




	





<html>
	<head>
			







<script language="javascript">
   //ѡ���и�����ʾ
		var hisObj="";//������һ����ɫ����
		var hisColor=""; //������һ������ԭʼ��ɫ
		/**
   *hisColor ����ǰtr��className
   *obj       ����ǰtr����
   */
   
   //�޸�����ԭ�򣬱����ڴ���������������
   var xmlHelper = window.top.xmlHelper;
	 var xmlSeach  = window.top.xmlSeach;

		function changeColor(color,obj){
		  //�ָ�ԭ��һ�е���ʽ
		  if(hisObj != ""){
			 for(var i=0;i<hisObj.cells.length;i++){
				var tempTd=hisObj.cells.item(i);
				//tempTd.className=hisColor; ��ԭ�ֵ���ɫ
				tempTd.style.backgroundColor = '#F7F7F7';		//��ԭ�б�����ɫ
			 }
			}
				hisObj   = obj;
				hisColor = color;
		  //���õ�ǰ�е���ʽ
			for(var i=0;i<obj.cells.length;i++){
				var tempTd=obj.cells.item(i);
				//tempTd.className='green'; �ı��ֵ���ɫ
				tempTd.style.backgroundColor='#00BFFF';	//�ı��б�����ɫ
			}
		}
	/*****************��ҳ���� begin******************/
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
	/***************��ҳ��������**************/
	
	//���д򿪴���
		function openWinMid(url,name,iHeight,iWidth)
		{
		  //var url; //ת����ҳ�ĵ�ַ;
		  //var name; //��ҳ���ƣ���Ϊ��;
		  //var iWidth; //�������ڵĿ��;
		  //var iHeight; //�������ڵĸ߶�;
		  var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
		  var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
		  window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',toolbar=no,menubar=no,scrollbars=yes,resizeable=no,location=no,status=no');
		}
	  //ȥ��ո�;
		function ltrim(s){
		  return s.replace( /^\s*/, "");
		}
		//ȥ�ҿո�;
		function rtrim(s){
		return s.replace( /\s*$/, "");
		}
		//ȥ���ҿո�;
		function trim(s){
		return rtrim(ltrim(s));
		}
		//��ת��ָ��ҳ��
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
		
		//��ȡ¼��****************************begin**************/
		function checkCallListen(id,staffno){
				if(id==''){
				return;
				}
				if("Y"=="N"){
					if('2146'!=staffno){
					  rdShowMessageDialog("��û����ȡ��¼����Ȩ�ޣ�");
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
						var packet = new AJAXPacket("../../../npage/callbosspage/K042/lisenRecord.jsp","���ڴ���,���Ժ�...");
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
				openWinMid("k170_getCallListen.jsp?flag_id="+id,'¼����ȡ',650,850);
			}
			
			function doProcessNavcomring(packet)
			 {
			    var retType = packet.data.findValueByName("retType");
			    var retCode = packet.data.findValueByName("retCode");
			    var retMsg = packet.data.findValueByName("retMsg");
			    if(retType=="chkExample"){
			    	if(retCode=="000000"){
			    		//alert("����ɹ�!");
			    	}else{
			    		//alert("����ʧ��!");
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
			 /****************��ȡ¼������end********************/
			 
			 //��ʾͨ����ϸ��Ϣ
			function getCallDetail(contact_id,start_date){
				if(contact_id==''){
					return;
				}
				var path="/npage/callbosspage/k170/k170_getCallDetail.jsp";
			  path = path + "?contact_id=" + contact_id;
			  path = path + "&start_date=" + start_date;
			  openWinMid(path,"��Ϣ����",680,960);
				return true;
			}
			
			//����¼��
			function keepRec(id,staffno){
			 if("Y"=="N"){
					if('2146'!=staffno){
					  rdShowMessageDialog("��û����ȡ��¼����Ȩ�ޣ�");
					  return;
				  }
			 }
			 if(id==''){
					return;
			 }
			 openWinMid("k170_download.jsp?flag_id="+id,'���¼��������',450,850);
			}
			
			//��ʾ���й켣
			function showCallLoc(){
				//rdShowMessageDialog("��ʾ���й켣",2);
				//openWinMid("k170_showCallLoc.jsp",'��ʾ���й켣',480,640);
			}
			
			//�жϵ�ǰ�����Ƿ��и���ˮ���ŵ��ʼ�ƻ�******************begin******/
			function checkIsHavePlan(serialnum,flag,staffno){
				var mypacket = new AJAXPacket("/npage/callbosspage/k170/k170_checkIsHavePlan_rpc.jsp","���ڽ��мƻ�У�飬���Ժ�......");
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
					rdShowMessageDialog("��Ŀǰ�޸ù��ŵ��ʼ�ƻ���");
				}
			}
			
			//�ʼ�ǰ�ж��Ƿ��ѱ��ʼ��
			//flag 0:�ƻ����ʼ� 1:�ƻ����ʼ�
			function checkIsQc(serialnum,flag,staffno){
				var mypacket = new AJAXPacket("/npage/callbosspage/k170/k170_checkIsQc_rpc.jsp","���ڽ������ʼ�У�飬���Ժ�......");
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
					rdShowMessageDialog("����ˮ�Ѿ����й��ʼ죬�����ظ����У�");
				}
			}
			
			/**
			  *
			  *��������ˮ�����ʼ촰��
			  */
			function planInQua(serialnum,staffno){
				var  path = '/npage/callbosspage/checkWork/K217/K218_select_plan.jsp?serialnum=' + serialnum+'&staffno='+staffno;
				//�ƻ����ʼ�tabidΪ��ˮ��0���ƻ����ʼ�Ϊ��ˮ��1
				if(!parent.parent.document.getElementById(serialnum+0)){
				parent.parent.addTab(true,serialnum+0,'ִ���ʼ�ƻ�',path);
			  }
			}
			/*****************************end***********************/
			
			/**
			  *
			  *�����ƻ����ʼ촰��
			  */
			function planOutQua(serialnum,staffno){
				var path ='/npage/callbosspage/checkWork/K217/K217_select_check_content.jsp?serialnum=' + serialnum+'&staffno='+staffno+'&isOutPlanflag=0';
				var param  = 'dialogWidth=900px;dialogHeight=300px';
				//window.showModalDialog('../checkWork/K217/K217_select_check_content.jsp?serialnum=' + serialnum+'&staffno='+staffno+'&isOutPlanflag=0','', param);
				//window.open(path,'', 'width=900px;height=300px');
				//alert(serialnum);
					if(!parent.parent.document.getElementById(serialnum+1)){
				   parent.parent.addTab(true,serialnum+1,'ִ���ʼ�ƻ�',path);
			    }
			}
			
			
			//����ҳ��ʱ��sql����where������ֵ�������sqlWhere�������Ա㵼������
			function insertParentFrameValue(){
				
				parent.queryFrame.document.sitechform.sqlWhere.value = "200910  where begin_date >= to_date('20091004 00:00:00','yyyyMMdd hh24:mi:ss') and begin_date <= to_date('20091004 23:59:59','yyyyMMdd hh24:mi:ss') and accept_login_no = 'kf8400' order by begin_date desc";
			}
			
			//ҳ������
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
			    window.open(path,'����ԭ���춯�޸�','scrollbars=yes,height=600, width=500');
			  
				/*
				  var path="/npage/callbosspage/k170/k172_modifyCallCauseTree.jsp";
			    path = path + "?contact_id=" + contact_id;
			    path = path + "&contactMonth=" + start_date;
			    path = path + "&strnodeid="+ strNode_Id;
			   // alert(path);
			    window.open(path,'����ԭ���춯�޸�','scrollbars=yes,height=600, width=500');
			  */
			}
			
			//�жϵ�ǰ�����Ƿ��и���ˮ���ŵ��ʼ�ƻ�
			function checkIsHavePlan(serialnum,flag,staffno){
				var mypacket = new AJAXPacket("/npage/callbosspage/k170/k170_checkIsHavePlan_rpc.jsp","���ڽ��мƻ�У�飬���Ժ�......");
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
					rdShowMessageDialog("��Ŀǰ�޸ù��ŵ��ʼ�ƻ���");
				}
			}
			
			//ҳ�����˳�����������ؼ���result_cause.jspҳ��ʱ��sql����where������ֵ�������sqlWhere�������Ա㵼������
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
				rdShowMessageDialog("��ʱ���޸���Ч!");
			}
</script>
	</head>
	<body onLoad="insertParentFrameValue();">
		<div id="Operation_Table">
			<input type="button" class="b_foot" value = "չ��/����" onClick="showQuery('frameset120');" >
      <input type="button" class="b_foot" value = "ˢ��" onClick="parent.queryFrame2.submitInputCheck();">
			<table cellspacing="0">
				<tr>
					<td class="blue" align="left" colspan="24">
						
						��
						1
						ҳ ��
						1
						ҳ ��
						1
						��
						
						
						
						
						
						
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
      		document.write('<th align="center" class="blue" width="15%" nowrap > ���� </th>');	
      		tempBool='true';
      	}
        </script>
					<th align="center" class="blue" width="8%" nowrap >
						��ˮ��
					</th>
					<th align="center" class="blue" width="9%" nowrap >
						����ʱ��
					</th>
					<th align="center" class="blue" width="8%" nowrap >
						����ԭ��
					</th>
					<th align="center" class="blue" width="8%" nowrap >
						���к���
					</th>
					<th align="center" class="blue" width="9%" nowrap >
						�ͻ�����
					</th>
					<th align="center" class="blue" width="8%" nowrap >
						�ͻ�����
					</th>
					<th align="center" class="blue" width="5%" nowrap >
						�ͻ������
					</th>
					<th align="center" class="blue" width="5%" nowrap >
						�������
					</th>
					<th align="center" class="blue" width="5%" nowrap >
						������
					</th>
					<th align="center" class="blue" width="4%" nowrap >
						ͨ��ʱ��
					</th>
					<th align="center" class="blue" width="5%" nowrap >
						����ʽ
					</th>
					<th align="center" class="blue" width="5%" nowrap >
						�Ƿ�������֤
					</th>
					<th align="center" class="blue" width="5%" nowrap >
						�Ƿ�������֤
					</th>	
					<th align="center" class="blue" width="4%" nowrap >
						�����ˮ��
					</th>
					<th align="center" class="blue" width="5%" nowrap >
						��ע
					</th>									
				</tr>
          
				<tr onClick="changeColor('blue',this);">

					<script>
        if(tempBool=='true'){
      		document.write('<td align="center" class="blue" >');
      	}
      	if(checkRole(K172A_RolesArr)==true){	
      		document.write('<img style="cursor:hand" onclick="checkCallListen(\'2009100409393742146vU\',\'2146\');return false;" alt="��ȡ����" src="/nresources/default/images/callimage/operImage/1.gif" width="16" height="16" align="absmiddle">&nbsp;');	
      	}
        if(checkRole(K172B_RolesArr)==true){	
      		document.write('<img style="cursor:hand" onclick="getCallDetail(\'2009100409393742146vU\',\'20091004\');return false;" alt="��ʾ��ͨ������ϸ���" src="/nresources/default/images/callimage/operImage/4.gif"  width="16" height="16" align="absmiddle">&nbsp;');	
      	}
      	if(checkRole(K172C_RolesArr)==true){	
          
            document.write('<img style="cursor:hand" onclick="modifyCallCauseTree(\'\',\'2009100409393742146vU\',\'20091004\');return false;" alt="�޸�����ԭ��" src="/nresources/default/images/callimage/operImage/2.gif" width="16" height="16" align="absmiddle">&nbsp;');
         
      	}<!-- dataRows[i][14] ��Ϊ dataRows[i][8]-->
      	if(checkRole(K172D_RolesArr)==true){	
      		document.write('<img style="cursor:hand" onclick="checkIsHavePlan(\'2009100409393742146vU\',1,\'kf8400\')" alt="�ƻ����ʼ쿼��" src="/nresources/default/images/callimage/operImage/5.gif" width="16" height="16" align="absmiddle">&nbsp;');	
      	}
      	if(checkRole(K172E_RolesArr)==true){	
      		document.write('<img style="cursor:hand" onclick="planOutQua(\'2009100409393742146vU\',\'kf8400\')" alt="�ƻ����ʼ쿼��" src="/nresources/default/images/callimage/operImage/9.gif" width="16" height="16" align="absmiddle">&nbsp;');	
      	}
      	if(checkRole(K172F_RolesArr)==true){	
      		document.write('<img style="cursor:hand" onclick="keepRec(\'2009100409393742146vU\',\'kf8400\')" alt="���¼��������" src="/nresources/default/images/callimage/operImage/3.gif" width="16" height="16" align="absmiddle">');	
      	}
        if(tempBool=='true'){
      		document.write('</td>');
      	}      	
      </script>
					<!--      	
       <img onclick="checkCallListen('2009100409393742146vU');return false;" alt="��ȡ����" src="/nresources/default/images/callimage/operImage/1.gif" width="16" height="16" align="absmiddle">
       <img onclick="getCallDetail('2009100409393742146vU','20091004');return false;" alt="��ʾ��ͨ������ϸ���" src="/nresources/default/images/callimage/operImage/4.gif" width="16" height="16" align="absmiddle">
       -->
					<!--

       <img onclick="modifyCallCauseTree('','2009100409393742146vU','20091004');return false;" alt="�޸�����ԭ��" src="/nresources/default/images/callimage/operImage/2.gif" width="16" height="16" align="absmiddle">
s
       -->
					<!--
       <img onclick="checkIsHavePlan('2009100409393742146vU',0)" alt="�ƻ����ʼ쿼��" src="/nresources/default/images/callimage/operImage/5.gif" width="16" height="16" align="absmiddle">
       <img onclick="checkIsQc('2009100409393742146vU',1)" alt="�ƻ����ʼ쿼��" src="/nresources/default/images/callimage/operImage/9.gif" width="16" height="16" align="absmiddle">
       <img onclick="keepRec()" alt="���¼��������" src="/nresources/default/images/callimage/operImage/3.gif" width="16" height="16" align="absmiddle">
       -->
					<td align="center" class="blue" nowrap >
						2009100409393742146vU
					</td>
					<td align="center" class="blue" nowrap >
						2009-10-04 09:39:54
					</td>
					<td align="center" class="blue" nowrap >
						<span id=035001001004 ><����->��ѯ��->���Ѳ�ѯ��->�ײ�ʹ������ѯ><br></span>
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
						δ����
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
						�ڲ�����
					</td>
					<td align="center" class="blue" nowrap >
						��
					</td>	
					<td align="center" class="blue" nowrap >
						��
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
						
						��
						1
						ҳ ��
						1
						ҳ ��
						1
						��
						
						
						
						
						
						
					</td>
				</tr>
			</table>
		</div>
		<!--input id='show_content_btn' type='button' onclick='showContent()'  value='show'/>
		<input id='hide_content_btn' type='button' onclick='hideContent()'  value='hide'/-->
		<a id='show_content_btn' href="#" onclick="showContent()">����>></a>
		<a id='hide_content_btn' href="#" onclick="hideContent()">����<<</a>
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
