<%
   /*
   * 功能: 订单缓装查询(订单缓装)
　 * 版本: v1.0
　 * 日期: 2009/01/30
　 * 作者: jiangxl
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
  /*
 */
%>
	
<%@ page contentType="text/html;charset=GB2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.*" %>
<%

    ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
    String[][] baseInfoSession = (String[][])arrSession.get(0);
    String[][] otherInfoSession = (String[][])arrSession.get(2);
		String workNo = (String)session.getAttribute("workNo");
		String workName = (String)session.getAttribute("workName");
		String orgCode = (String)session.getAttribute("orgCode");
		//String ipaddr = otherInfoSession[0][2];
    String powerCode= otherInfoSession[0][4];
    String ip_Addr = request.getRemoteAddr();
    
    String regionCode = orgCode.substring(0,2);
    
    String dept = otherInfoSession[0][4]+otherInfoSession[0][5]+otherInfoSession[0][6];
    String GroupId = baseInfoSession[0][21];
    String ProvinceRun = baseInfoSession[0][22];
    String OrgId = baseInfoSession[0][23];

    int recordNum = 0;
    String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
    int iDate = Integer.parseInt(dateStr);
    String NowDay = Integer.toString(iDate+1);
		String currentYear=new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new Date());
		String quevalue=request.getParameter("quevalue");
		/*lijy add@20110823*/
	  String opCode=request.getParameter("opCode");
	  String opName=request.getParameter("opName");
	  String quetype=request.getParameter("quetype");
	  /*lijy add@20110823  end*/
		String checkType="radio";
		
		String password = (String)session.getAttribute("password");	
  	String work_no = (String)session.getAttribute("workNo");
%> 

<html>
<head>
<title><%=opName%></title>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../css/jl.css" rel="stylesheet" type="text/css">

<script language="JavaScript">
var recordPerPage = 50; 			//每页记录数50
var pageNumber = 1;					 //当前页数
var lastNumber = 0;					 //最后一页的记录数
var error_code="";
var error_msg="";
var backArrMsg2="";
var verifyType ="";
var result="";
//    core.loadUnit("debug");
//    core.loadUnit("rpccore");
    onload=function()
    {
//		core.rpc.onreceive = doProcess;
		//document.all.nowPage.value = pageNumber;
		//document.all.jump.value = pageNumber;
    }


    
    //---------1------RPC处理函数------------------
    function doProcess(packet){

        //使用RPC的时候,以下三个变量作为标准使用.
        self.status="";
		var retType ="";
        retType=packet.data.findValueByName("retType");
         
           backArrMsg =""; 
           error_code = packet.data.findValueByName("errorCode");
           error_msg =  packet.data.findValueByName("errorMsg");
		   		 backArrMsg = packet.data.findValueByName("backArrMsg");
		   
		   
        if(retType == "getTotalNum")
   {
       if(error_code == "000000")
       {
		var retInfo = packet.data.findValueByName("retInfo");
		if(retInfo != "")
		{
	              calPageNum( parseInt(retInfo));
         
		}
	}           
	else
	{
		error_msg = error_msg + "[errorCode2:" + error_code + "]";
		rdShowMessageDialog(error_msg,0);
		return false;
	}
   }
   //--------------------------------------------------
   
   
   	if(retType=="find")
	{

		
   //alert("ok1");
   var errorCode= packet.data.findValueByName("errorCode");
   if(errorCode.trim()!="000000"){
   	rdShowMessageDialog("没有符合的数据!");
   	return false;
  	}
		var backArrMsg = packet.data.findValueByName("backArrMsg");
		var backArrMsg2 = packet.data.findValueByName("backArrMsg2");
		var custname = packet.data.findValueByName("custname");
		var operater = packet.data.findValueByName("operater");
		var orderstat = packet.data.findValueByName("orderstat");
		var orderSelect = packet.data.findValueByName("orderSelect");
		document.frm.custName.value=custname;
		document.frm.optName.value=operater;
		document.frm.orderStatus.value=orderstat;

		//alert(backArrMsg);
		if(orderSelect.trim().length>0&&orderSelect!="orderSelect")
		{			
			var quevalue=document.frm.quevalue.value.trim();
			orderSelectorder(quevalue);
		}else if(backArrMsg.length>0&&backArrMsg!="backArrMsg")
		{ //alert("ok12");
				div_deleteAll();
				//alert(trdiv);
				var trdiv = document.getElementById("trdiv");
				for(var a=0; a<backArrMsg.length ; a++)
				{
					var info="info"+a;
					info=trdiv.insertRow();
					info.setAttribute("bgcolor","#EEEEEE",0);
					info.setAttribute("height","28",0);
					
					info.attachEvent("onmouseover",ab_m(info));    
					info.attachEvent("onmouseout",out_m(info));   
					
					var stateStr=backArrMsg[a][4];
 					var buttonvalue ="";
					if(backArrMsg[a][4].trim()=="0"){
						stateStr = "[待审批]";					 
						buttonvalue="查询";
					}
					else if(backArrMsg[a][4].trim()=="1"){
						stateStr = "<font color='green'>[已通过]</font>";
						buttonvalue="查询";
					}
					else//2
						{
							//stateStr = "<font color='red'>[打回]</font>";
							buttonvalue="处理";
							}							
					info.insertCell().innerHTML ="<tr><td nowrap><div align='center'>&nbsp;"+"<input class='text' type='checkbox' id='checkbox1' onclick='showInfo()' name='checkbox1'>"+"</a></div></td>";
					info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ backArrMsg[a][0] +"</a></div></td>";
					info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ backArrMsg[a][1] +"</a></div></td>";
					info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ backArrMsg[a][2] +"</a></div></td>";
					info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ backArrMsg[a][3] +"</a></div></td>";
					info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+stateStr+"</a></div></td>";
					info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ backArrMsg[a][5] +"</a></div></td>";
					info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ backArrMsg[a][6] +"</a></div></td></tr>";
					info.insertCell().innerHTML ="<td nowrap><div align='center'><input type='button' class='button' value='"+buttonvalue+"' onclick=detailInfo('"+backArrMsg[a][1]+"') /></td>";
					//"+ backArrMsg[a][7] +"</a></div></td></tr>";
				}

				if(backArrMsg2.length>0&&backArrMsg!="backArrMsg2")
		{ //alert("ok12");
				//div_deleteAll();
				//alert(trdiv);
				var trdiv = document.getElementById("trdiv2");
				for(var a=0; a<backArrMsg2.length ; a++)
				{
					var info="info"+a;
					info=trdiv.insertRow();
					info.setAttribute("bgcolor","#EEEEEE",0);
					info.setAttribute("height","28",0);
					
					info.attachEvent("onmouseover",ab_m(info));    
					info.attachEvent("onmouseout",out_m(info));   
					
					var stateStr="";
 					var buttonvalue ="受理详情";
					var buttonvalue2 ="费用详情";
					buttonvalue ="";
					buttonvalue2 ="";
					if(backArrMsg2[a][4].trim()=="0"){
						//stateStr = "[待审批]";					 
						//buttonvalue="查询";
					}
					else if(backArrMsg2[a][4].trim()=="1"){
						//stateStr = "<font color='green'>[已通过]</font>";
						//buttonvalue="查询";
					}
					else//2
						{
							//stateStr = "<font color='red'>[打回]</font>";
							buttonvalue="处理";
							}
					info.insertCell().innerHTML ="<tr><td nowrap><div align='center'>&nbsp;"+"<input class='text' type='checkbox' id='checkbox2' onclick='' name='checkbox2'>"+"</a></div></td>";
					info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ backArrMsg2[a][0] +"</a></div></td>";
					info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ backArrMsg2[a][1] +"</a></div></td>";
					info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ backArrMsg2[a][2] +"</a></div></td>";
					info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ backArrMsg2[a][3] +"</a></div></td>";
					info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ backArrMsg2[a][4] +"</a></div></td>";
					info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ backArrMsg2[a][5] +"</a></div></td>";
					info.insertCell().innerHTML ="<td nowrap><div align='center'>&nbsp;"+ backArrMsg2[a][6] +"</a></div></td></tr>";
					info.insertCell().innerHTML ="<td nowrap><div align='center'><input type='button' class='button' value='"+buttonvalue+"' onclick=detailInfo('"+backArrMsg2[a][1]+"') /></td>";
					//"+ backArrMsg2[a][7] +"</a></div></td></tr>";
				}
				
			}
				
			}
		else
			{
			 //alert("没有符合条件的数据");
				rdShowMessageDialog("没有符合条件的数据");
				div_deleteAll();
			}

	}
   //-----------------------------------------

    }
 //-----------------------------------为tr加上鼠标移入移出事件
     var out_m = function(info)    
{    
  return function()    
  {    
    outf(info);//该函数为外部定义的一个执行函数；    
  }    
} 

 function outf(info)
 {
 	info.style.color='black'; 	
 }

var ab_m = function(info)    
{    
  return function()    
  {    
    ab(info);//该函数为外部定义的一个执行函数；    
  }    
}    

 function ab(info)
 {
 	info.style.color='red';
 	
 	}
 	//-----------------------------------

    function div_deleteAll()
    {//alert(6666);
    	//alert("pppp"+document.all.trdiv2.rows.length);
        //清除增加表中的数据
        for(var a = document.all.trdiv.rows.length-1 ;a>0; a--)//删除从tr1开始，为第二行
        {
                document.all.trdiv.deleteRow(a);
        }
		 for(var a = document.all.trdiv2.rows.length-1 ;a>0; a--)//删除从tr1开始，为第二行
        {
                document.all.trdiv2.deleteRow(a);
        }
       
    }

    function queryAddAllRow()
    {//alert(5555);
		div_deleteAll();
		var tree;
		var trdiv = document.getElementById("trdiv");
	/*	var num=parseInt(recordPerPage);
		if(pageNumber==parseInt(document.frm.tatolPages.value))
		{
			num=parseInt(lastNumber);
		}else{
			num=parseInt(recordPerPage);
		}*/
		var start=(parseInt(pageNumber)-1)*recordPerPage;
		getResult(start+1,recordPerPage+start+1);
    }

 function queryAddAllRow2()
    {//alert(5555);
		div_deleteAll();
		var tree;
		var trdiv = document.getElementById("trdiv");
	/*	var num=parseInt(recordPerPage);
		if(pageNumber==parseInt(document.frm.tatolPages.value))
		{
			num=parseInt(lastNumber);
		}else{
			num=parseInt(recordPerPage);
		}*/
		//var start=(parseInt(pageNumber)-1)*recordPerPage;
		getResult2(1,1);
    }

function firstPage() //首页
{
 //alert(4444);
	if(pageNumber-1>0)
	{
		pageNumber = 1;
		document.all.nowPage.value = pageNumber;
		document.all.jump.value = pageNumber;
		queryAddAllRow();

	}
}
function pageUp()
{
 //alert(3333);
	if(pageNumber-1>0)
	{
		pageNumber =	pageNumber - 1;		
		document.all.nowPage.value = pageNumber;
		document.all.jump.value = pageNumber;
		queryAddAllRow(); 
	}
}

function pageDown()
{
 //alert(2222);
	if(pageNumber < document.frm.tatolPages.value*1)
	{
		pageNumber =	pageNumber + 1;
		
		document.all.nowPage.value = pageNumber;
		document.all.jump.value = pageNumber;
		queryAddAllRow(); 
		}
}
function lastPage()
{
 //alert(1111);
	if(pageNumber < document.frm.tatolPages.value*1)
	{
		pageNumber =	document.frm.tatolPages.value;
		
		document.all.nowPage.value = pageNumber;
		document.all.jump.value = pageNumber;
		queryAddAllRow();
	 	}
}
function query_jump()
{
 //alert(999);
	document.all.jump.value = document.all.jump.value.trim();
	if(document.all.jump.value.trim()=="")
	{
		document.all.jump.value = pageNumber;
		return false;
	}
	if(!forPosInt(document.all.jump))
	{
		document.all.jump.value = pageNumber;
		return false;
	}
	if(document.all.jump.value*1<1 || document.all.jump.value*1>document.all.tatolPages.value)
	{
		document.all.jump.value = pageNumber;
		return false;
	}
	if(document.all.jump.value != pageNumber)
	{
	pageNumber = document.all.jump.value;	
	document.all.nowPage.value = pageNumber;
	queryAddAllRow();
	}
}


    function judge_valid()
    {
		//alert(888);
		if(document.frm.start.value.trim().len()!=0 || document.frm.end.value.trim().len()!=0)
		{
			if(document.frm.start.value.trim().len()!=0 && document.frm.end.value.trim().len()!=0)
			{
		//		alert((document.frm.start.value-document.frm.end.value)>=0)
				if((document.frm.start.value-document.frm.end.value)>0)
				{
					rdShowMessageDialog("开始时间不能大于结束时间!!");
					document.frm.end.select();
					return false;
				}
				if((document.frm.start.value-document.frm.currentYear.value)>0)
				{
					rdShowMessageDialog("开始时间不能大于当前时间!!");
					document.frm.end.select();
					return false;
				}
				if((document.frm.end.value-document.frm.currentYear.value)>0)
				{
					//alert("document.frm.end.value"+document.frm.end.value);
					//alert("document.frm.currentYear.value"+document.frm.currentYear.value);
					rdShowMessageDialog("结束时间不能大于当前时间!!");
					document.frm.end.select();
					return false;
				}
			}else{
				rdShowMessageDialog("请填写时间间隔!!");
				return false;
			}
		}
        return false;
    }

 
    function resetJsp()
    {
		//alert(777);
		with(document.frm)
		{
			phoneNo.value="";
			phones.value="";
			start.value="";
			end.value="";
			//area.selectedIndex=0;
			//region.selectedIndex=0;
			stateFlag.selectedIndex=0;
			recodeNum.value="0";
			tatolPages.value="1";
			nowPage.value="1";
			jump.value="1";
		}
 
		pageNumber = 1; //当前页数
		lastNumber = 0; //最后一页的记录数
        div_deleteAll();
        
        del_over();
		  }


 function getResult(a,b)
 {
		var startTime = document.frm.start.value.trim();
		var endTime = document.frm.end.value.trim();
 		var stateFlag = document.frm.stateFlag[document.frm.stateFlag.selectedIndex].value;		
 //alert(666);
  ////alert(a);
  ////alert(b);
		var myPacket = new AJAXPacket("selectOrderNo9.jsp","正在查询，请稍候......");
		myPacket.data.add("retType","find");
		myPacket.data.add("phoneNo",document.frm.phoneNo.value.trim());
		myPacket.data.add("stateFlag",stateFlag);
		myPacket.data.add("startTime",startTime);
		myPacket.data.add("endTime",endTime);
		myPacket.data.add("startRow",a);
		myPacket.data.add("endRow",b);
    core.ajax.sendPacket(myPacket);
    myPacket=null;
 	}

 function getResult2(a,b)
 {		
		var startTime = document.frm.start.value.trim();
		var endTime = document.frm.end.value.trim();
 		var stateFlag = document.frm.stateFlag[document.frm.stateFlag.selectedIndex].value;	
		var quetype = document.frm.quetype.value;		
		var quevalue = document.frm.quevalue.value;

  ////alert(a);
  ////alert(b);
  		var myPacket = new AJAXPacket("selectOrderNo9.jsp","正在查询，请稍候......");
		myPacket.data.add("retType","find");
		myPacket.data.add("phoneNo",document.frm.phoneNo.value.trim());
		myPacket.data.add("stateFlag",stateFlag);
		myPacket.data.add("startTime",startTime);
		myPacket.data.add("endTime",endTime);
		myPacket.data.add("quetype",quetype);
		myPacket.data.add("quevalue",quevalue);
		myPacket.data.add("startRow",1);
		myPacket.data.add("endRow",3);
    core.ajax.sendPacket(myPacket);
    myPacket=null;
 	}

function document_onkeydown()
{//alert(555);

    if (window.event.srcElement.type!="button" && window.event.srcElement.type!="textarea")
    {

        if (window.event.keyCode == 13)
        {
            window.event.keyCode = 9;
        }
    }
}
 
 
 //-------------------------------
     function commitJsp()
    {
    	with(document.frm)
		{
			recodeNum.value="0";
			tatolPages.value="1";
			nowPage.value="1";
			jump.value="1";
		}
 		//alert(111);
		pageNumber = 1; //当前页数
		lastNumber = 0; //最后一页的记录数
        div_deleteAll();

        if( judge_valid()==false )
        {
            return false;
        } 

		var quetype=document.frm.quetype.value.trim();
		var quevalue=document.frm.quevalue.value.trim();

		var startTime = document.frm.start.value.trim();
		var endTime = document.frm.end.value.trim();
 		var stateFlag = document.frm.stateFlag[document.frm.stateFlag.selectedIndex].value;		
		queryAddAllRow2();
		
  	over();
 }

 //-------------------------------
     function commitJsp2()
    {
    	with(document.frm)
		{
			recodeNum.value="0";
			tatolPages.value="1";
			nowPage.value="1";
			jump.value="1";
		}
 		//alert(111);
		pageNumber = 1; //当前页数
		lastNumber = 0; //最后一页的记录数
        div_deleteAll();

        if( judge_valid()==false )
        {
            return false;
        } 

		var quetype=document.frm.quetype.value.trim();
		var quevalue=document.frm.quevalue.value.trim();

		var startTime = document.frm.start.value.trim();
		var endTime = document.frm.end.value.trim();
 		var stateFlag = document.frm.stateFlag[document.frm.stateFlag.selectedIndex].value;		
 
		var myPacket = new AJAXPacket("selectOrderNo7.jsp","正在获得记录总数，请稍候......");
		myPacket.data.add("retType","getTotalNum");
		myPacket.data.add("quetype",quetype);
		myPacket.data.add("quevalue",quevalue);

		myPacket.data.add("phoneNo",document.frm.phoneNo.value.trim());
		myPacket.data.add("stateFlag",stateFlag);
		myPacket.data.add("startTime",startTime);
		myPacket.data.add("endTime",endTime);
		core.ajax.sendPacket(myPacket);
		myPacket=null; 
  	over();
 }

function orderSelectorder(quevalue)
{
		var h=400;
		var w=500;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
		var ret=window.showModalDialog("fq0351.jsp?quevalue="+quevalue.trim(),"",prop);
		
		if(typeof(ret)!="undefined")
		{
			 document.all.newPhone.value=ret;
			 document.all.confirm.disabled=false;//设置确认按钮可以使用
		}
		
		else
		{
			rdShowMessageDialog("请选择客户订单号!");
			document.all.newPhone.value = "";
			document.all.newPhone.select();
		}
		}

function calPageNum(totalNum)
{//alert(444);
	////alert(totalNum);
	////alert(recordPerPage);
 
				document.all.recodeNum.value = totalNum;
				document.all.nowPage.value= 1;
				
				pageNumber=1;
				if(totalNum%recordPerPage==0){
					////alert(totalNum/recordPerPage);
					
					document.frm.tatolPages.value=totalNum/recordPerPage;
					
					lastNumber=recordPerPage;
				}else{
						////alert(totalNum/recordPerPage);
						
					document.frm.tatolPages.value=parseInt(totalNum/recordPerPage)+1;
					//lastNumber=totalNum%recordPerPage;
				/*	if(document.frm.tatolPages.value=="1")
					{
						recordPerPage=lastNumber;
					}else{
						recordPerPage=recordPerPage;
					}*/
				}
				queryAddAllRow();
				}

 function over()
{//alert(333);
del_over();
var div = document.createElement("<div name='on_f' class='trans' oncontextmenu='return false;'>");
var iframe = document.createElement("<iframe  name='on_f' class='trans' style='z-index:98;'>");
document.getElementById("hiddenTable").appendChild(iframe);
document.getElementById("hiddenTable").appendChild(div);  
 
}

function del_over()
{
	var hiddentable=document.getElementById("hiddenTable");
	var oChild=hiddentable.children;

	 for(var i=oChild.length;i>0;i--)
	 {
	 	if(oChild[i-1].name=="on_f")
		hiddentable.removeChild(oChild[i-1]);
		}

}

function detailInfo(useId)
{//alert(222);
	var path = "f1123_check_detail.jsp";
	path = path + "?useId=" + useId;
	//var retInfo = window.showModalDialog(path,"","dialogWidth:1000px;dialogHeight:800px;status:no;help:no");
	window.open (path ,"","height=650, width=850,left=50, top=0,toolbar=no,menubar=no, scrollbars=yes, resizable=no, location=no, status=yes"); 
}

function ret_value(){	
				var retValue="";  
				if(typeof(document.getElementsByName("retCheckBox")) == "undefined")
				{
					rdShowMessageDialog("没有数据，请改变查询条件");
					return false;
				}
				else if(typeof(document.getElementsByName("retCheckBox").length) == "undefined")
				{
					if(document.getElementsByName("retCheckBox").checked == true)
					{
						retValue = document.getElementsByName("retCheckBox").value;
					}
				}
				else
				{	
				
  				for(i=0;i<document.getElementsByName("retCheckBox").length;i++)
          { 
						
    				   if (document.getElementsByName("retCheckBox")[i].checked==true)
    				   {      
        			          if(retValue=="") 
        			            retValue = retValue +document.getElementsByName("retCheckBox")[i].value;
        			   }
                                                            
        					     
          }
        }
					   
        //alert(retValue);  
        if(retValue != ""){						   
       	 window.returnValue= retValue ; 					   
				}
       window.close();   		    
}

function showInfo(ch){
			if(true){
				document.getElementById("trdiv2").style.display = "";	 
			}else{
				document.getElementById("trdiv2").style.display = "none";
			}
	}

</script>
<!--
<style>
*{margin:0; padding:0;}
body{height:100%;} .trans{width:100%;background:ccc;position:absolute;left:0right:0;top:0;bottom:0;-moz-opacity:0.5;filter:alpha(opacity=50);z-index:99;height:100%;}
</style>
-->
</head>
<body onMouseDown="return  hideEvent()" onKeyDown="return hideEvent()">
<div id="operation">
<form name="frm" method="post" action="" onKeyDown="document_onkeydown()">
<%@ include file="/npage/include/header.jsp" %>
	<div id="operation_table">
		<div id="input"></div>
	</div>
	<div id="operation_button">
  	<input name="confirm" type="button" class="b_foot" value="确定" onClick="ret_value()">
    &nbsp;
    <input name="back" onClick="window.close()" type="button" class="b_foot" value="关闭">
  </div>
	<div id="operation_table">
  	<div id="list">
    	<table id="trdiv">
      	<tr class="selectBar">				 
	      	<th>选择</th>
	      	<!--lijy change@20110823 original is
	      	<th>客户订单子项编号</th>
	        <th>订单子项名称</th>	  
	      	 -->
	        <th>客户订单编号</th>
	        <th>服务号码</th>	  
	        <!--lijy change end-->                			  
        </tr>
				
				<%			  
				if(quevalue!=null&&!quevalue.equals("")){
				%>
					<wtc:utype name="sGetCustServNo" id="retVal" scope="end" >
						 <wtc:uparam value="<%=quetype %>" type="STRING"/><%/*lijy c@20110823*/%>
						 <wtc:uparam value="<%=quevalue %>" type="STRING"/> 
						 <wtc:uparam value="<%=opCode %>" type="STRING"/> 
						 <wtc:uparam value="<%=work_no %>" type="STRING"/> 
						 <wtc:uparam value="<%=password %>" type="STRING"/> 							 
					</wtc:utype>
					<%
					if(retVal.getValue(0)!=null&&retVal.getValue(0).equals("0")&&retVal.getUtype(2)!=null&&retVal.getSize(2)>1){	
		
						String rtv="";	
						for(int i=0;i<retVal.getSize(2);i++){
							String oid=retVal.getUtype("2").getUtype(i).getValue(0);
							%><%if (i%2==0){%>
		              <tr bgcolor="F5F5F5" height="20">
							<%} else{%>
						   <tr bgcolor="E8E8E8" height="20">
							<%}%>
							<%
							if(retVal.getUtype("2").getUtype(i).getValue(0) == null || retVal.getUtype("2").getUtype(i).getValue(0).trim().equals("")){
								//result[i][j] = "";
								rtv="";					
							}else{
									rtv=retVal.getUtype("2").getUtype(i).getValue(0).trim();			

							}
							%>
							<td width="10%"><input type="<%=checkType%>" name="retCheckBox"    value="<%=rtv %>" /></td>	  
							<%
							for(int j = 0 ; j <retVal.getSize("2."+i) ; j ++){
								if(retVal.getUtype("2").getUtype(i).getValue(j) == null || retVal.getUtype("2").getUtype(i).getValue(j).trim().equals("")){
									//result[i][j] = "";
									rtv="";					
								}else{
									rtv=retVal.getUtype("2").getUtype(i).getValue(j).trim();			
				
								}
							%>
								<td width="45%"><%=rtv %></td>	  			
							<%	
					
							}
					%></tr>
	        <%
						}

          %>
        <%
					}
				}
        %>
			</table>
		</div>
		 	 
    <input type="hidden" name="workNo" id="workNo" value="<%=workNo%>">
    <input type="hidden" name="workName" id="workName" value="">
    <input type="hidden" name="opCode" id="opCode" value="">
    <input type="hidden" name="orgCode" id="orgCode" value="<%=orgCode%>">
    <input type="hidden" name="regionCode" id="regionCode" value="<%=regionCode%>">
    <input type="hidden" name="IpAddr" id="IpAddr" value="<%=ip_Addr%>">
	  <input type="hidden" name="phones" id="phones" value="">
	  <input type="hidden" name="backFlag_type" id="backFlag_type" value="0">
	  <input type="hidden" name="funtype" id="funtype" value="0">
    <input type="hidden" name="currentYear" class="yyyyMMdd" id="currentYear" value="<%=currentYear%>"  v_name="当前时间">
	</div>
</div>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</div>
</body>
</html>
