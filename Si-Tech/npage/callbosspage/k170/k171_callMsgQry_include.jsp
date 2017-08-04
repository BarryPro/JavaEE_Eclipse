	<%@ include file="/npage/callbosspage/public/constants.jsp" %>
	  <%!
			/**
			 函数说明: 输入一个基本的sql.然后页面参数模式是  [排序号_=_字段名] 或  [排序号_like_字段名]
			 其中column为查询字段.第一位是排序号.排序号不能重复.重复多个将保存一个值.且必须是数字.大小不限如1,11,123.
			 */
	    public String returnSql(HttpServletRequest request){
	    StringBuffer buffer = new StringBuffer();
	   	
			Map map = request.getParameterMap();
			Object[] objNames = map.keySet().toArray();
			Map temp = new HashMap();
			String name="";
			String[] names= new String[0];
			String value="";
			//System.out.println("进入objNames.length=="+objNames.length);
			for (int i = 0; i < objNames.length; i++) {
				name = objNames[i] == null ? "" : objNames[i]
				.toString();
				names = name.split("_");
				//System.out.println("进入names.length=="+names.length);
				if (names.length >= 3) {
			
			value = request.getParameter(name);
			//System.out.println("进入value=="+value);
			if (value.trim().equals("")||value.trim().equals("NULL")) {
				
				continue;
			}
			Object[] objs = new Object[3];
			objs[0] = names[1];
			
			name = name.substring(name.indexOf("_") + 1);
			name = name.substring(name.indexOf("_") + 1);
			
			objs[1] = name;
			
			objs[2] = value;
			
			try {
				temp.put(Integer.valueOf(names[0]), objs);
				
			} catch (Exception e) {
	
			}
			
				}
			}
			Object[] objNos = temp.keySet().toArray();
			
			Arrays.sort(objNos);
			
			for (int i = 0; i < objNos.length; i++) {
				Object[] objs = null;
				objs = (Object[]) temp.get(objNos[i]);
				
				if (objs[0].toString().toLowerCase().equalsIgnoreCase(
				"like")) {
			buffer.append(" and " + objs[1] + " " + objs[0] + " '%%"
					+ objs[2].toString().trim() + "%%' ");
				}
				if (objs[0].toString().equalsIgnoreCase("=")) {
				  if(objs[1].toString().equalsIgnoreCase("acceptid")&&objs[2].toString().equalsIgnoreCase("7")){
	               buffer.append(" and op_code='K025' ");
				  }else{
			buffer.append(" and " + objs[1] + " " + objs[0] + " '"
					+ objs[2].toString().trim() + "' ");
					}
				}
	
				if (objs[0].toString().equalsIgnoreCase("!=")) {
				 if(objs[2].toString().equalsIgnoreCase("Y")){
				  buffer.append(" and " + objs[1] + " = '"
					+ objs[2].toString().trim() + "' ");
				  }else{
			      buffer.append(" and (" + objs[1] + " " + objs[0] + " 'Y' or "+objs[1]+" is null) ");
				  }
				 }
			}
	       
	        return buffer.toString();                
		}
	%>
  
  <%
  /*取当前登陆工号的角色ID，为逗号分割的字符串 hanjc add 20090423*/
	String  powerCode = (String)session.getAttribute("powerCodekf");
	if(powerCode == null) {
		powerCode = "";
	}
	String[]  powerCodeArr = powerCode.split(",");
  String isCommonLogin="N";	
  int powercodecount=0;
	/*
	 *是否是话务员 update by hanjc 20090719
        *01120O04为培训角色id,01120O0E为质检角色id,011202为客户电话营业厅，01120O02是普通座席
        *01120O02011202和01120201120O02是客户电话营业厅和普通座席两个角色的拼接
        *话务员只有客户电话营业厅和普通座席两个角色,即01120O02011202和01120201120O02，不包括小组长。
	 */
	 /* modify by yinzx 20090826 由于山西代码写的较乱，而且写死角色信息 所以改造，并运行时调整
      //add by hanjc 20090719 判断当前工号是否是话务员，检验听取录音权限
      if(powerCodeArr.length==2){
         String tempVal = powerCodeArr[0].trim()+powerCodeArr[1].trim();
         if("01120O02011202".equals(tempVal)||"01120201120O02".equals(tempVal)){
		       isCommonLogin="Y";	
         }
       }
   *//*add by yinzx 20090826*/
   for(int i = 0; i < powerCodeArr.length; i++){
			for(int j=0; j<HUAWUYUAN_ID.length; j++){
				if(HUAWUYUAN_ID[j].equals(powerCodeArr[i])) {
					isCommonLogin="Y";
				}
			}
		}   
  %>
  
   <script language="javascript">
		//选中行高亮显示
		var hisObj="";//保存上一个变色对象
		var hisColor=""; //保存上一个对象原始颜色
		/**
   *hisColor ：当前tr的className
   *obj       ：当前tr对象
   */
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
		 var formobj = parent.queryFrame.document.sitechform;
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
	   	formobj.page.value=<%=(curPage-1)%>;
	   }
	   else if(operateCode=="next")
	   {
	   	formobj.page.value=<%=(curPage+1)%>;
	   }
	   else if(operateCode=="last")
	   {
	   	formobj.page.value=<%=pageCount%>;
	   }	 
	   //zengzq 20100125 第二个参数1 表示为点击下一页，上一页等
	   //取条数
	   var rowCount = '<%=rowCount%>';
	    parent.queryFrame.submitMe(str,'1',rowCount);
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
		   		 parent.queryFrame.window.sitechform.page.value=parseInt(thePage);
		   		 doLoad('0');
		   	  }
		   }
		   else if(operateCode=="jumpToPage1")
		   {
		   	  var thePage=document.getElementById("thePage1").value;
		   	  if(trim(thePage)!=""){
		   		 parent.queryFrame.window.sitechform.page.value=parseInt(thePage);
		       doLoad('0');
		      }
		   }else if(trim(operateCode)!=""){
		   	 parent.queryFrame.window.sitechform.page.value=parseInt(operateCode);
		   	 doLoad('0');
		   }
		}
		//听取录音****************************begin**************/
		function checkCallListen(id,staffno){
				if(id==''){
				return;
				}
				
				var packet = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_checkIsListen_rpc.jsp","\u6b63\u5728\u5904\u7406,\u8bf7\u7a0d\u540e...");
 
			if(!checkRole(K171A_RolesArr)==true)	
			{
				  if ("<%=spopdmbutton %>"!="Y")
				  {  	  
				  
				  	 if( "<%=spopdmbuttonclass %>"=="Y"){
				    	packet.data.add("loginNo",'<%=loginNo%>');
				    	packet.data.add("staffno",staffno);
				  	}
				 	 else
				  	{
				  		if('<%=loginNo%>'!=staffno){
					   		 rdShowMessageDialog("您没有听取其他人录音的权限！");
					 		   return;					  
				 			 }
				  	}
				  }
			 }
			packet.data.add("contact_id",id);
			core.ajax.sendPacket(packet,doProcessGetPath,true);
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
			   }else if(flag=='X'){
			     rdShowMessageDialog("您没有听取其他班组人员录音的权限！");				 
			   }
			   else{
			   	 getCallListen(contact_id)	;
			   }		
			 }
			 /****************听取录音方法end********************/
			 
			 //显示通话详细信息
			function getCallDetail(contact_id,start_date){
				if(contact_id==''){
					return;
				}
				var path="<%=request.getContextPath()%>/npage/callbosspage/k170/k170_getCallDetail.jsp";
			  path = path + "?contact_id=" + contact_id;
			  path = path + "&start_date=" + start_date;
			  openWinMid(path,"信息详情",680,960);
				return true;
			}
			
			//保存录音
			function keepRec(id,staffno){
				 //modify by yinzx 在改造绑定变量测试时发现 改功能有错误 原来为kf_longin_no
			 if("Y"=="<%=isCommonLogin%>"){
					if('<%=loginNo%>'!=staffno){
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
				var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_checkIsHavePlan_rpc.jsp","正在进行计划校验，请稍候......");
				mypacket.data.add("serialnum",serialnum);
			  mypacket.data.add("start_date",parent.queryFrame.window.sitechform.start_date.value);
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
			  	planInQua(serialnum,staffno,flag);
			    //checkIsQc(serialnum,flag,staffno);
				}else{
					rdShowMessageDialog("您目前无该工号的质检计划！");
				}
			}
			
			//质检前判断是否已被质检过
			//flag 0:计划外质检 1:计划内质检
			function checkIsQc(serialnum,flag,staffno){
				var mypacket = new AJAXPacket(<%=request.getContextPath()%>"/npage/callbosspage/k170/k170_checkIsQc_rpc.jsp","正在进行已质检校验，请稍候......");
				mypacket.data.add("serialnum",serialnum);
			  mypacket.data.add("start_date",parent.queryFrame.window.sitechform.start_date.value);
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
			    planInQua(serialnum,staffno,flag);
				}else{
					rdShowMessageDialog("该流水已经进行过质检，不能重复进行！");
				}
			}
			
			/**
			  *
			  *弹出对流水进行质检窗口
			  *modify by zengzq 将start_date参数传入20091012
			  */
			function planInQua(serialnum,staffno,flag){
				var start_date = parent.queryFrame.window.sitechform.start_date.value;
				var  path = '/npage/callbosspage/checkWork/K217/K218_select_plan.jsp?serialnum=' + serialnum + '&staffno=' + staffno + '&flag=' + flag + '&start_date=' + start_date;
				//计划内质检tabid为流水加0，计划外质检为流水加1
				if(!parent.parent.document.getElementById(serialnum+0)){
				parent.parent.addTab(true,serialnum+0,'执行质检计划',path);
			  }
			}

//updated by tangsong 20100806
//added by liujied 20091016
function planOutCheckQua(serialnum,staffno,isCheck,tablename)
{
    if(isCheck == "已质检"){
        rdShowMessageDialog("该流水已经进行过质检，不能重复质检!");
        return false;
    } else {
    	var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/k170/k171_getQcFlag.jsp","正在查询数据,请稍候...");
    	packet.data.add("serialnum", serialnum);
    	packet.data.add("tablename", tablename);
    	core.ajax.sendPacket(packet, doGetQcFlag);
    	packet = null;
    }
		function doGetQcFlag(packet) {
			var qcFlag = packet.data.findValueByName("qcFlag");
			if (qcFlag == "Y") {
			  rdShowMessageDialog("该流水已经进行过质检，不能重复质检!");
			  return false;
			}
			planOutQua(serialnum,staffno,"0");
		}
}
			/*****************************end***********************/
			
			/**
			  *
			  *弹出计划外质检窗口
			  */
			function planOutQua(serialnum,staffno,group_flag){
				var path ='/npage/callbosspage/checkWork/K217/K217_select_check_content.jsp?serialnum=' + serialnum+'&staffno='+staffno+'&isOutPlanflag=0&group_flag='+group_flag;
				var param  = 'dialogWidth=900px;dialogHeight=300px';
				//window.showModalDialog('../checkWork/K217/K217_select_check_content.jsp?serialnum=' + serialnum+'&staffno='+staffno+'&isOutPlanflag=0','', param);
				//window.open(path,'', 'width=900px;height=300px');
				//alert(serialnum);
					if(!parent.parent.document.getElementById(serialnum+1)){
				   parent.parent.addTab(true,serialnum+1,'执行质检计划',path);
			    }
			}
			function keepRecToSer(){
				//rdShowMessageDialog("转存录音到服务器",2);
			}
			function getWorkInfo(){
				//rdShowMessageDialog("查看对应工单信息",2);
			}
			
			
			
			//页面缩放
			function showQuery(frameset){				
				if(parent.document.all(frameset).rows=="0,*"){					
					parent.document.all(frameset).rows="260,*";					
					
				}else{
					
					parent.document.all(frameset).rows="0,*";					
				}
			}
			
			//加载页面时将sql语句的where条件赋值给上面的sqlWhere隐藏域，以便导出操作
			function insertParentFrameValue(){
				try{
					if(parent.queryFrame.document.sitechform.sqlWhere!=undefined){
						
						parent.queryFrame.document.sitechform.sqlWhere.value = "<%=sqlFilter %>";
						
					}else{
						
						insertParentFrameValue();
					}
			  }catch(e){
			  	
			  }
			}
		</script>