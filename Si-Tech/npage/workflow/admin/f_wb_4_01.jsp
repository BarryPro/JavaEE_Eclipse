	<%@ include file="/page/workflow/admin/pub/wb_include.jsp" %>

	<%@ include file="pub/head_view3.jsp" %>

	<!--引入日期控件-->
<link rel="stylesheet" type="text/css" media="all" href="js/cal/calendar-win2k-cold-2.css" title="win2k-cold-2" />
<script type="text/javascript" src="js/cal/calendar.js"></script>
<script type="text/javascript" src="js/cal/cal2.js"></script>
<script type="text/javascript" src="js/cal/lang/calendar-zh.js"></script>


 <DIV id=tabnav>
      <UL>
        <LI><A class=here id=tab1 onClick="changeTab(this.id);return false;" 
        href="#">未接收</A> 

        <LI><A id=tab2 onClick="changeTab(this.id);return false;" 
        href="#">已接收</A> 
        </LI></UL></DIV>


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
           //  window.location=url;  //测试环境可是查看源代码 
		// window.showModalDialog(url,window,"scroll:yes;status:no;resizable:yes;unadorne:yes;dialogWidth:750px"); //实际用这个
		window.open(url,'','toolbar=no, menubar=no, scrollbars=yes, resizable=yes,location=no, status=no');
		//eval(getCurrentList()+'()');//在commit中更新

	}
}

//接收处理操作
function recWA1()
{
	if(nowrow==-1){
	alert("请选择...")
	}
	else{

    	var url = "f_wb_2_accept_1.jsp?wano="+nowrow;
       //  window.location=url;  //测试环境可是查看源代码 
	  //	window.showModalDialog(url,window,"scroll:yes;status:no;resizable:yes;unadorne:yes;dialogWidth:750px");
	  window.open(url,'','toolbar=no, menubar=no, scrollbars=yes, resizable=yes,location=no, status=no');
	  	//更新响应div
	  	//eval(getCurrentList()+'()');
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
    var url = "f_wb_2_05.jsp?wono="+wono+"&wano="+nowrow;
	  window.showModalDialog(url,window,"scroll:yes;status:no;resizable:yes;unadorne:yes;dialogWidth:750px");
	  //dialogHeight:210px;
	  //window.location=url;
	}
}

//转发操作
function transmit1()
{
       window.open("f_wb_4_02.jsp");
}

//回退操作
function rollBack1()
{
	if(nowrow==-1){
	alert("请选择...")
	}
	else{
	    var url = "f_wb_2_rollback_1.jsp?wano="+nowrow;
	  	window.showModalDialog(url,window,"status:no;resizable:yes;unadorne:yes");
			eval(getCurrentList()+'()');
			//更新未提交的页面
			condquery1();
	}
}



//修改操作
function viewRec()
{
	if(nowrow==-1){
	alert("请选择...")
	}
	else{
		 var url="f_wb_2_update.jsp?_viewFlag=t&wano="+nowrow;
           //  window.location=url;  //测试环境可是查看源代码 
		// window.showModalDialog(url,window,"scroll:yes;status:no;resizable:yes;unadorne:yes;dialogWidth:750px"); //实际用这个
		window.open(url,'','toolbar=no, menubar=no, scrollbars=yes, resizable=yes,location=no, status=no');
		//eval(getCurrentList()+'()');//在commit中更新

	}
}

</script>
  <STYLE type=text/css>A {
	COLOR: #003499; TEXT-DECORATION: none
}
A:hover {
	COLOR: #000000; TEXT-DECORATION: underline
}
#tabnav {
	BACKGROUND: #d5d5d5; PADDING-BOTTOM: 3px; BORDER-BOTTOM: #333 1px solid
}
#tabnav UL {
	PADDING-RIGHT: 0px; PADDING-LEFT: 0px; BACKGROUND: #f1f1f1; PADDING-BOTTOM: 5px; MARGIN: 5px 0px; PADDING-TOP: 15px; BORDER-BOTTOM: #999 1px solid; LIST-STYLE-TYPE: none
}
#tabnav UL LI {
	DISPLAY: inline; MARGIN-LEFT: 1px
}
#tabnav UL LI A {
	BORDER-RIGHT: #999 1px solid; PADDING-RIGHT: 10px; BORDER-TOP: #999 1px solid; PADDING-LEFT: 10px; BACKGROUND: #fff; PADDING-BOTTOM: 5px; BORDER-LEFT: #999 1px solid; PADDING-TOP: 5px; BORDER-BOTTOM: #999 1px solid
}
#tabnav UL LI A:hover {
	BACKGROUND: #ccc
}
#tabnav UL LI A.here {
	BORDER-RIGHT: #999 1px solid; PADDING-RIGHT: 10px; BORDER-TOP: #999 1px solid; PADDING-LEFT: 10px; BACKGROUND: #d5d5d5; PADDING-BOTTOM: 5px; BORDER-LEFT: #999 1px solid; PADDING-TOP: 5px; BORDER-BOTTOM: #d5d5d5 1px solid
}
#tabnav UL LI A.here:hover {
	BACKGROUND: #d5d5d5
}
.paging {
	FONT-SIZE: 15px; TEXT-ALIGN: center
}
#paginglink:hover {
	COLOR: #eeeeee; TEXT-DECORATION: underline
}
</STYLE>

<div id='listdiv1' style="display:block" >
		<jsp:include page="f_wb_4_01_part1.jsp" flush="true" /> 
</div>

<div id='listdiv2' style="display:none" >
		<jsp:include page="f_wb_4_01_part2.jsp" flush="true" /> 
</div>



  <%@ include file="pub/foot_view.jsp" %>

<script>
	//当前tab
	var currTab = 'tab1';

	changeTab(currTab);

function changeTab(obj)
{
	currTab = obj;
	
	if(obj=='tab1')
	{
		
		var mode1 = document.getElementById('mode1');
		mode1.style.display='block';
		
		//var mode3 = document.getElementById('mode3');
		//mode3.style.display='none';
		
		var mode2 = document.getElementById('mode2');
		mode2.style.display='none';
		
		var tab1 = document.getElementById('tab1');
		tab1.className='here';
		var tab2 = document.getElementById('tab2');
		tab2.className=null;
		//var tab3 = document.getElementById('tab3');
		//tab3.className=null;
		
		var list1 = document.getElementById('listdiv1');
		list1.style.display='block';
		var list2 = document.getElementById('listdiv2');
		list2.style.display='none';
		
		//var list3 = document.getElementById('listdiv3');
		//list3.style.display='none';
	}
	else if(obj=='tab2')
	{
	
		var mode1 = document.getElementById('mode1');
		mode1.style.display='none';
		
		//var mode3 = document.getElementById('mode3');
		//mode3.style.display='none';
		
		var mode2 = document.getElementById('mode2');
		mode2.style.display='block';
		
		var tab2 = document.getElementById('tab2');
		tab2.className='here';
		var tab1 = document.getElementById('tab1');
		tab1.className=null;
		//var tab3 = document.getElementById('tab3');
		//tab3.className=null;
		
		var list1 = document.getElementById('listdiv1');
		list1.style.display='none';
		var list2 = document.getElementById('listdiv2');
		list2.style.display='block';
		//var list3 = document.getElementById('listdiv3');
		//list3.style.display='none';
	}
}

//获取当前更新操作
function getCurrentList()
{
	if(currTab=='tab1')
	{
		return 'condquery1'
	}else if(currTab=='tab2')
	{
		return 'condquery2'
	}
}

</script>
