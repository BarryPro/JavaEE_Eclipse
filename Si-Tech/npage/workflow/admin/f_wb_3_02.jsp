	<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>



	<%@ include file="pub/head_view_wf.jsp" %>

		<!--引入日期控件-->
	<script type="text/javascript" src="js/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="js/jquery.js"></script>

<div id="tabnav"> 
	<ul>     
 		<li><a id='tab1' href='#'>工单监控</a></li>  
		<%--<li><a id='tab1' href='#' onclick='changeTab(this.id);return false;' class='here'>未接收</a></li>     
		<li><a id='tab2' href='#' onclick='changeTab(this.id);return false;' >已接收</a></li>  
		<li><a id='tab3' href='#' onclick='changeTab(this.id);return false;' >发起的流程</a></li>   --%>
		</ul> 
</div> 

  

<SCRIPT LANGUAGE="JavaScript">
		var oldrow = -1;
	var nowrow = -1;
	var wono = -1;
	
	
function rowClick(objname,flag){

	var o = eval(objname);
	//var o = document.getElementById(objname);
	if(flag == 0)
		o.style.background = "#F5F5F5";
	else
		o.style.background = "#CBEEFC";
}


//返回值 -1--无效的页面导航 其他--有效的导航页面
	// obj 导航类型：first--首页 next--下页 before--上页 end-尾页
function checkpaging(obj,totalrec,totalpage,currpage)
{

	if(totalrec==0)
	{
		return -1;
	}
	
	if(obj=='first')
	{
		if(currpage==1)
		{
			return -1;
		}
		else
		{
			return 1;
		}
	}
	else if(obj=='next')
	{
		if(currpage<totalpage)
		{
			return currpage+1;
		}
		else
		return -1;
	}
		else if(obj=='before')
	{
		if(currpage>1)
		{
			return currpage-1;
		}
		else
		return -1;
	}
	else if(obj=='end')
	{
		if(currpage==totalpage)
		{
			return -1;
		}
		else
		{
			return totalpage;
		}
	}
	else
	{
		return -1;
	}
}

//提交操作
function loadWA1()
{
    if(nowrow==-1){
	alert("请选择...")
	}
	else{
		
		  var url = "f_wb_2_submit_1.jsp?wano="+nowrow;
	  	window.showModalDialog(url,window,"scroll:yes;status:no;resizable:yes;unadorne:yes;dialogWidth:750px");
	  	//更新响应div
	  	eval(getCurrentList()+'()');
	}
}

//修改操作
function upData1()
{
	if(nowrow==-1){
	alert("请选择...")
	}
	else{
		 var url="f_wb_2_update.jsp?wano="+nowrow;
		 //window.location=url;
		window.showModalDialog(url,window,"scroll:yes;status:no;resizable:yes;unadorne:yes;dialogWidth:750px");
		eval(getCurrentList()+'()');

	}
}

//接收处理操作
function recWA1()
{
	if(nowrow==-1){
	alert("请选择...")
	}
	else{

    	var url = "f_wb_3_03_01.jsp?wono="+wono+"&wano="+nowrow;
	  	window.showModalDialog(url,window,"scroll:yes;status:no;resizable:yes;unadorne:yes;dialogWidth:750px");
	  	//更新响应div
	  	eval(getCurrentList()+'()');
	  	//更新已接收列表
	  	//condquery2();
	}
}

//查看操作
function query1()
{
	if(nowrow==-1){
	alert("请选择...")
	}
	else{
    var url = "f_wb_2_06.jsp?wono="+wono+"&wano="+nowrow;
	  window.showModalDialog(url,window,"scroll:yes;status:no;resizable:yes;unadorne:yes;dialogWidth:750px");
	  //dialogHeight:210px;
	  //window.location=url;
	}
}

//转发操作
function transmit1()
{
	if(nowrow==-1){
	alert("请选择...")
	}
	else{
        var url = "f_wb_3_05.jsp?wano="+nowrow;
        window.location=url;
	  		//window.showModalDialog(url,window,"status:no;resizable:yes;unadorne:yes");
	  		//eval(getCurrentList()+'()');
	}
}

//回退操作
function rollBack1()
{
	if(nowrow==-1){
	alert("请选择...")
	}
	else{
	    var url = "f_wb_3_04_01.jsp?wono="+wono+"&wano="+nowrow;
	  	window.showModalDialog(url,window,"status:no;resizable:yes;unadorne:yes");
			eval(getCurrentList()+'()');
			//更新未提交的页面
			//condquery1();
	}
}

</script>
<style type="text/css">  
	a {     
		color: #003499;      
		text-decoration: none; 
	}  
	a:hover {     
		color: #000000;      
		text-decoration: underline; 
	}  
	#tabnav {    
		 background:#d5d5d5;     
		 border-bottom:1px solid #333;     
		 padding-bottom:3px; 
		 }  
	#tabnav ul {     
		 padding:15px 0px 5px 0px;     
		 margin:5px 0px 5px 0px;     
		 list-style:none;     
		 background:#f1f1f1;     
		 border-bottom:1px solid #999;

	 }  
	 #tabnav ul li {     
		 display:inline;     
		 margin-left:1px;
		}  
	#tabnav ul li a {     
		 background:#fff;         
		 padding:5px 10px 5px 10px;     
		 border:1px solid #999; 
	 }  
	 #tabnav ul li a:hover {     
	 	background:#ccc;     
	 }  
	 #tabnav ul li a.here {     
		 background:#d5d5d5;     
		 padding:5px 10px 5px 10px;     
		 border-top:1px solid #999;     
		 border-left:1px solid #999;     
		 border-right:1px solid #999;     
		 border-bottom:1px solid #d5d5d5; 
	 }  
	 #tabnav ul li a.here:hover {     
	 	background:#d5d5d5; 
	 }      
	 
	 .paging{
	 text-align:center;
	 font-size:15px;
	 }
	 </style>  
	 

<div id='listdiv1' style="display:block" >
		<jsp:include page="f_wb_3_02_part1.jsp" flush="true" /> 
</div>

    
  <%@ include file="pub/foot_view.jsp" %>

<script>
	//当前tab
	var currTab = 'tab1';

//	changeTab(currTab);

//function changeTab(obj)
//{
//	currTab = obj;
//	
//	if(obj=='tab1')
//	{
//		
//		var mode1 = document.getElementById('mode1');
//		mode1.style.display='block';
//		
//		var mode3 = document.getElementById('mode3');
//		mode3.style.display='none';
//		
//		var mode2 = document.getElementById('mode2');
//		mode2.style.display='none';
//		
//		var tab1 = document.getElementById('tab1');
//		tab1.className='here';
//		var tab2 = document.getElementById('tab2');
//		tab2.className=null;
//		var tab3 = document.getElementById('tab3');
//		tab3.className=null;
//		
//		var list1 = document.getElementById('listdiv1');
//		list1.style.display='block';
//		var list2 = document.getElementById('listdiv2');
//		list2.style.display='none';
//		
//		var list3 = document.getElementById('listdiv3');
//		list3.style.display='none';
//	}
//	else if(obj=='tab2')
//	{
//	
//		var mode1 = document.getElementById('mode1');
//		mode1.style.display='none';
//		
//		var mode3 = document.getElementById('mode3');
//		mode3.style.display='none';
//		
//		var mode2 = document.getElementById('mode2');
//		mode2.style.display='block';
//		
//		var tab2 = document.getElementById('tab2');
//		tab2.className='here';
//		var tab1 = document.getElementById('tab1');
//		tab1.className=null;
//		var tab3 = document.getElementById('tab3');
//		tab3.className=null;
//		
//		var list1 = document.getElementById('listdiv1');
//		list1.style.display='none';
//		var list2 = document.getElementById('listdiv2');
//		list2.style.display='block';
//		var list3 = document.getElementById('listdiv3');
//		list3.style.display='none';
//	}
//	else if(obj=='tab3')
//	{
//		
//		var mode1 = document.getElementById('mode1');
//		mode1.style.display='none';
//		
//		var mode3 = document.getElementById('mode3');
//		mode3.style.display='block';
//		
//		var mode2 = document.getElementById('mode2');
//		mode2.style.display='none';
//		
//		var query3div = document.getElementById("query3div");
//		query3div.style.display='none';
//	
//		var tab3 = document.getElementById('tab3');
//		tab3.className='here';
//		var tab2 = document.getElementById('tab2');
//		tab2.className=null;
//		var tab1 = document.getElementById('tab1');
//		tab1.className=null;
//		
//		var list1 = document.getElementById('listdiv1');
//		list1.style.display='none';
//		var list2 = document.getElementById('listdiv2');
//		list2.style.display='none';
//		var list3 = document.getElementById('listdiv3');
//		list3.style.display='block';
//	}
//}

//获取当前更新操作
function getCurrentList()
{
	if(currTab=='tab1')
	{
		return 'condquery1'
	}
}

</script>