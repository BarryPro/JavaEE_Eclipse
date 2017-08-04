	<%@ include file="/npage/callbosspage/public/constants.jsp" %>
	  <%!
			/**
			 函数说明: 输入一个基本的sql.然后页面参数模式是  [排序号_=_字段名] 或  [排序号_like_字段名]
			 其中column为查询字段.第一位是排序号.排序号不能重复.重复多个将保存一个值.且必须是数字.大小不限如1,11,123.
			 */
	   public String[]  returnSql(HttpServletRequest request){
        StringBuffer buffer = new StringBuffer();
        StringBuffer bufferPara = new StringBuffer();
 
		   //输入语句.
		Map map = request.getParameterMap();
		Object[] objNames = map.keySet().toArray();
		Map temp = new HashMap();
		String name="";
		String[] names= new String[0];
    String[] bingd= {"",""};
		String value="";
		//将结果保存在这里.key是数字.对数字进行排序.value里面放置object数组存值.
		for (int i = 0; i < objNames.length; i++) {
			name = objNames[i] == null ? "" : objNames[i]
			.toString();
			//String name
			names = name.split("_");
			//将name按照'_'分成3个数组.
			if (names.length >= 3) {
		//如果不能分说明名字不合法.太少区分不了.
		    value = request.getParameter(name);
		//按照名字得到value
		if (value.trim().equals("")) {
			//如果value是""跳过.
			continue;
		}
		Object[] objs = new Object[3];
		objs[0] = names[1];
		//保持 第一个字符串.是like 或是 =
		name = name.substring(name.indexOf("_") + 1);
		name = name.substring(name.indexOf("_") + 1);
		//这地方做数据库的字段处理.第三个'_'以后的都是数据库字段了.
		objs[1] = name;
		//第二个字符串.查询名字.
		objs[2] = value;
		//第三个.查询的值.
		try {
			temp.put(Integer.valueOf(names[0]), objs);
			//这个地方是将字符串转换成数字.然后进行排序.比如19要在2之后.
		} catch (Exception e) {

		}
		//将排序号码放在key里面,ojbs数组放到value里面.
			}
		}
		Object[] objNos = temp.keySet().toArray();
		//得到一个倒序的数组.
		Arrays.sort(objNos);
		//对数字进行排序.
		for (int i = 0; i < objNos.length; i++) {
			Object[] objs = null;
			objs = (Object[]) temp.get(objNos[i]);
			//下面对like 和 = 分别处理.
			if (objs[0].toString().toLowerCase().equalsIgnoreCase(
			"like")) {
		buffer.append(" and " + objs[1] + " " + objs[0] + " '%%'||:v"
				+ objs[1].toString().replace('.','a') + "||'%%' ");
			bufferPara.append(",v"+objs[1].toString().replace('.','a')+"="+objs[2].toString().trim());
			}
			if (objs[0].toString().equalsIgnoreCase("=")) {
		buffer.append(" and " + objs[1] + " " + objs[0] + " :v"
				+ objs[1].toString().replace('.','a') + "  ");
 
			bufferPara.append(",v"+objs[1].toString().replace('.','a')+"="+objs[2].toString().trim());
			}
		}
     bingd[0]=buffer.toString();
     bingd[1]=bufferPara.toString();
        return bingd;
}
	%>
  
  <%
  /*取当前登陆工号的角色ID，为逗号分割的字符串 hanjc add 20090423*/
	String  powerCode = (String)session.getAttribute("powerCodekf");
	//有的用户登录时，由于未在session中取到powerCodekf，页面会出错 
	//所以加上这句避免页面出错
	//add by tangsong 20100330
	if (powerCode == null) {
		powerCode = "";
	}
	String[]  powerCodeArr = powerCode.split(",");
  String isCommonLogin="N";	
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
	    parent.queryFrame.submitMe(str);
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
		  function checkAll(a) {
    var el = document.getElementsByTagName('input');
    var ck_all = document.getElementsByName('ck_all');
    var len = el.length;
    //alert(len);
   
    
 if(a.checked==false)
 {   for (var i = 1; i < len; i++) {
        if ((el[i].type == "checkbox") ) {
            el[i].checked = false;
        }
    }
 
 }
 else if(a.checked==true)
 { 
 	  
 	for (var i = 1; i < len; i++) {
        if ((el[i].type == "checkbox") ) {
            el[i].checked = true;
        }
    }
   
 }
}			 


	function modifysceTrans(){
			 
				if($("input:checked").length !=1)
				{
						rdShowMessageDialog("请选择一条数据进行修改操作",0);
						return;
				} 
				
				  if($(":checkbox").length==2 )
				 {
				 	  
			    		openWinMid('k197_modifysceTrans.jsp?sceid='+document.all.sceid.value.trim(),'修改结点',650,800);
			   }else
			   {
			   	   
			  	    openWinMid('k197_modifysceTrans.jsp?sceid='+document.all.sceid[$("input:checked")[0].value ].value.trim(),'修改结点',650,800);
			   }
			  //alert(document.all.sceid[$("input:checked")[0].value ].value.trim());
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
			
			function delsceTrans(){
			 
				var checkval="";
				if($("input:checked").length ==0)
				{
						rdShowMessageDialog("请选择一条或多条数据进行删除操作",0);
						return;
				} 
			
			if(rdShowConfirmDialog("你确定删除此记录么？")=='1'){	 
				for(var i=0;i<$("input:checked").length;i++)
				{
					 
          if($("input:checked")[i].name!='ck_all')
         {   if($(":checkbox").length==2)
					{
						 checkval=document.all.sceid.value.trim();
					}else{
						 
					  if (i==($("input:checked").length -1))
					  {
								checkval+=document.all.sceid[$("input:checked")[i].value].value.trim();
						}else
						{
							  checkval+=document.all.sceid[$("input:checked")[i].value].value.trim()+",";
					  }
					}
				 }
				}
          
				var packet = new AJAXPacket("k197_delsceTrans_rpc.jsp","...");
				packet.data.add("retType","delsceTrans");
				packet.data.add("checkval" ,checkval);
			
				core.ajax.sendPacket(packet,doProcessdelsceTrans,true);
				packet=null;
			}
			}
			
			
				/**
  *返回处理函数
  */
function doProcessdelsceTrans(packet) {
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");

	if (retCode == "000000") {
 
		rdShowMessageDialog("删除特殊名单数据成功！",1);	
		 // window.sitechform.action="result.jsp" ;
			//window.sitechform.submit(); 
		  document.location.replace("result.jsp");	
    window.close();
   
	} else {
		rdShowMessageDialog("删除特殊名单数据失败！",2);

	}
}
		</script>