<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%@ include file="/npage/workflow/admin/pub/wb_include.jsp" %>
<%
	String opCode = "7453";
	
%>
<%@ include file="/npage/include/header.jsp" %>	

		<!--引入日期控件-->
<link rel="stylesheet" type="text/css" media="all" href="js/cal/calendar-win2k-cold-2.css" title="win2k-cold-2" />
<script type="text/javascript" src="js/cal/calendar.js"></script>
<script type="text/javascript" src="js/cal/cal2.js"></script>
<script type="text/javascript" src="js/cal/lang/calendar-zh.js"></script>
<script >
	
</script>

<div id="tabnav"> 
	<ul>     
		<li id="li1" class="current"><a id='tab1' href='#' onclick='changeTab(this.id);return false;'><span>未接收</span></a></li>     
		<li id="li2"><a id='tab2' href='#' onclick='changeTab(this.id);return false;' ><span>已接收</span></a></li>
	</ul> 
</div> 

  

<SCRIPT LANGUAGE="JavaScript">
	var oldrow = -1;
	var nowrow = -1;
	var wono = -1;
	tabnav.style.display="none";
	
	
function rowClick(objname,flag){

	var o = eval(objname);
	//var o = document.getElementById(objname);
	if(flag == 0)
		o.style.color = "#003399";
	else
		o.style.color = "#ff0000";
	
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
	rdShowMessageDialog("请选择...")
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
openUrl2 = openUrl2.replace(/&/g,"@");
	if(nowrow==-1){
	rdShowMessageDialog("请选择...")
	}
	else{
		 var url="f_wb_2_update.jsp?wano="+nowrow+"&openUrl="+openUrl2;
//window.location=url;  //测试环境可是查看源代码 
//--window.open(url,'','toolbar=no, menubar=no, scrollbars=yes, resizable=yes,location=no, status=no');
		 //window.showModalDialog(url,window,"scroll:yes;status:no;resizable:yes;unadorne:yes;dialogWidth:750px"); //实际用这个
		eval(getCurrentList()+'()');
		document.all.hidden_frame.src=url;

	}
}

//接收处理操作
function recWA1()
{
openUrl2 = openUrl2.replace(/&/g,"@");
	if(nowrow==-1){
	rdShowMessageDialog("请选择...")
	}
	else{

    	var url = "f_wb_2_accept_1.jsp?wano="+nowrow+"&openUrl="+openUrl2;
      //更新响应div
	  	eval(getCurrentList()+'()');
	  	//更新已接收列表
	  	condquery2();
      document.all.hidden_frame.src=url;
	}
}

//查看操作
function query1()
{
	if(nowrow==-1){
	rdShowMessageDialog("请选择...")
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
	rdShowMessageDialog("请选择...")
	}
	else{
        var url = "f_wb_3_05.jsp?wano="+nowrow;
	  		window.showModalDialog(url,window,"status:no;resizable:yes;unadorne:yes");
	  		eval(getCurrentList()+'()');
	}
}

//回退操作
function rollBack1()
{
	if(nowrow==-1){
	rdShowMessageDialog("请选择...")
	}
	else{
	    var url = "f_wb_2_rollback_1.jsp?wano="+nowrow;
	  	//window.showModalDialog(url,window,"status:no;resizable:yes;unadorne:yes");
			eval(getCurrentList()+'()');
			//更新未提交的页面
			condquery1();
			document.all.hidden_frame.src=url;
	}
}

</script>
<!--这段css样式是用来设置切换标签的样式,,,如果有更好的切换标签来替换,,,请删除这段样式,不影响页面其他内容-->
	<style type="text/css">
	<!--

		
    #tabnav {
      /*float:left;*/
      width:100%;
      font-size:13px;
      line-height:normal;
	  border-bottom:2px solid #A6D2FF;     
	  
    }
    #tabnav ul {
      margin:0;
      padding:10px 10px 0 5px;
      list-style:none;
    }
    #tabnav li {
      display:inline;
      margin:0;
      padding:0;
    }
    #tabnav a {
      float:left;
      background:url("/nresources/default/images/tableftJm.gif") no-repeat left top;
      margin:0;
      padding:0 0 0 5px;
      text-decoration:none;
      cursor:hand;
    }
    #tabnav a span {
      float:left;
      display:block;
      background:url("/nresources/default/images/tabrightJm.gif") no-repeat right top;
      padding:5px 15px 4px 6px;
      color:#24618E;
    }
    /* Commented Backslash Hack hides rule from IE5-Mac \*/
    #tabnav a span {
    	float:none;
    }
    /* End IE5-Mac hack */
    #tabnav a:hover span {
      color:#FFF;
    }
    #tabnav a:hover {
      background-position:0% -42px;
    }
    #tabnav a:hover span {
      background-position:100% -42px;
    }

    #tabnav .current a {
      background-position:0% -42px;
    }
    #tabnav .current a span {
			font: bold;
      background-position:100% -42px;
      color:#FFF;
    }
	-->
	</style>

	 

<div id='listdiv1' style="display:block" >
		<jsp:include page="f_wb_2_02_part1.jsp" flush="true" /> 
</div>

<div id='listdiv2' style="display:none" >
		<jsp:include page="f_wb_2_02_part2.jsp" flush="true" /> 
</div>

<div id='listdiv3' style="display:none" >
		<jsp:include page="f_wb_2_02_part3.jsp" flush="true" /> 
</div>

<input type="hidden" id="ExportFlag" name="ExportFlag" value="0" />
  <%@ include file="/npage/include/footer.jsp" %>	

<script>
	//当前tab
	var currTab = 'tab1';

	changeTab(currTab);
	

function changeTab(obj)
{
	currTab = obj;
	if(obj=='tab1')
	{
		/*
		var mode1 = document.getElementById('mode1');
		mode1.style.display='block';
		
		var mode3 = document.getElementById('mode3');
		mode3.style.display='none';
		
		var mode2 = document.getElementById('mode2');
		mode2.style.display='none';
		*/
		var tab1 = document.getElementById('tab1');
		tab1.className='here';
		var tab2 = document.getElementById('tab2');
		tab2.className=null;
		
		var li1 = document.getElementById('li1');
		li1.className='current';
		var li2 = document.getElementById('li2');
		li2.className=null;
		
		
		var list1 = document.getElementById('listdiv1');
		list1.style.display='block';
		var list2 = document.getElementById('listdiv2');
		list2.style.display='none';
		
		var list3 = document.getElementById('listdiv3');
		list3.style.display='none';
	}
	else if(obj=='tab2')
	{
	    /*
		var mode1 = document.getElementById('mode1');
		mode1.style.display='none';
		
		var mode3 = document.getElementById('mode3');
		mode3.style.display='none';
		
		var mode2 = document.getElementById('mode2');
		mode2.style.display='block';
		*/
		var tab2 = document.getElementById('tab2');
		tab2.className='here';
		var tab1 = document.getElementById('tab1');
		tab1.className=null;
		
		var li1 = document.getElementById('li1');
		li1.className=null;
		var li2 = document.getElementById('li2');
		li2.className='current';
		
		var list1 = document.getElementById('listdiv1');
		list1.style.display='none';
		var list2 = document.getElementById('listdiv2');
		list2.style.display='block';
		var list3 = document.getElementById('listdiv3');
		list3.style.display='none';
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

tabnav.style.display="";
</script>
<iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>