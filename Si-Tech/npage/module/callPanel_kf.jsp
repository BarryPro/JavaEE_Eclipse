<%String kf_longin_no=(String)session.getAttribute("kfWorkNo");

%>
<%@ page import="java.net.InetAddress"%>
<%@ include file="../../njs/csp/handle_event.js" %>
<script type="text/javascript" language="javascript" src="../../njs/csp/answer_event.js"></script>
<script type="text/javascript" language="javascript" src="../../njs/csp/k025.js"></script>
<!--客服(3) 去掉 update by songjia 2010/08/20 begin-->
<script type="text/javascript" language="javascript" src="../../njs/si/base_kf.js"></script>
<script type="text/javascript" language="javascript" src="../../njs/si/ajax_kf.js"></script>
<!--客服(3) update by songjia 2010/08/20 begin-->

<%-- 原有的OCX控件 --%>
<%-- 
<div style="display:none">
<OBJECT
      id="Phone"
	  classid="clsid:014D83A5-7E35-11D3-8AF9-00C0DF245E51"
	  width=20
	  height=20
	  align=center
	  hspace=0
	  vspace=0>
</OBJECT>

</div>
--%>
<%-- 新开发的OCX控件 --%>
<div style="display:none">
<OBJECT
      id="Phone"
	  classid="clsid:6BA9E1DC-3555-484C-A4AA-3B8C1AAFAC78"
	  codebase="/ocx/callocx.cab#version=1,1,0,9"
	  width=20
	  height=20
	  align=center
	  hspace=0
	  vspace=0>
</OBJECT>
</div>


<script language="JavaScript" src="<%= request.getContextPath() %>/njs/csp/CCcommonTool.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/njs/csp/relation.js"></script>
<script language="JavaScript" src="<%= request.getContextPath() %>/njs/csp/mutualArray.js"></script>
<script type="text/javascript" language="javascript" src="<%= request.getContextPath() %>/njs/csp/K005.js"></script>
<script type="text/javascript" language="javascript" src="<%= request.getContextPath() %>/njs/csp/K006.js"></script>
<script type="text/javascript" language="javascript" src="<%= request.getContextPath() %>/njs/csp/K012.js"></script>
<script type="text/javascript" language="javascript" src="<%= request.getContextPath() %>/njs/csp/K013.js"></script>
<script type="text/javascript" language="javascript" src="<%= request.getContextPath() %>/njs/csp/K016.js"></script>

<%-- 类msn提示框，显示事件处理结果 --%>
<script language="javascript" type="text/javascript">
	
	/*add by yinzx 接续权限控制 执行效率有待测试 begin 0729*/
	  /*$(document).ready(
		function()
		{
			  
	      $("b").hide();

	      $("#bn_status_first_1").show(); 
	      $("#bn_status_second_1").show(); 
	      $("#bn_status_third_1").show();
	      //$("#K073").show();  
	      $("#K101").show();  
	     
	      
	      
	     var packet = new AJAXPacket("../login/getPanlePdom.jsp","请稍后...");
	  	 core.ajax.sendPacket(packet,doProcessPanPdom);//异步
			 packet =null;
	      
	  }
	);*/
	
	
	function doProcessPanPdom(packet)
	{
		var panlebutton = packet.data.findValueByName("nodes");
		
		var xin=0;
	    $("b").each(function(i){
	    	
		 		       if (this.id==panlebutton[this.id])
		 		 		   {
		 		 		   	  
		 		 		   	  $(eval("\"#"+panlebutton[this.id]+"\"")).show();
		 		 		   	  xin=xin+1;
	             }
         
					 //modify by hucw,20100615 
					 if( xin >7 )
					 {
					 	    
					 			$(eval("\"#"+panlebutton[this.id]+"\"")).clone().appendTo( $("#more_btn")); 
					 			$(eval("\"#"+panlebutton[this.id]+"\"")).remove();
					 }
   					 
 				});   
 				
 				if (xin<=7)
 				{
 					  $("#moreCall").remove();  
 				} 
 				
 			$(eval("\"#K101\"")).clone().appendTo( $("#more_btn")); 
			$(eval("\"#K101\"")).remove();
 
	}	
		/*add by yinzx 接续权限控制 end 0729*/

/**************************
//添加密码验证弹出信息的最上层 by libin 2009-05-14
var Layer_lib = 0;
function similarMSNPop(msgContent){
	var imgClose=document.createElement("img");
	imgClose.src="<%= request.getContextPath() %>/nresources/default/images/callimage/icon_close_off.gif";
	imgClose.style.cursor="pointer";
	imgClose.onmouseover=function()
	{
		imgClose.src="<%= request.getContextPath() %>/nresources/default/images/callimage/icon_close_on.gif";
	}
	imgClose.onmouseout=function()
	{
		imgClose.src="<%= request.getContextPath() %>/nresources/default/images/callimage/icon_close_off.gif";
	}
	imgClose.onclick=function()
	{
		hiddenList(overDiv,120);
	}
	imgClose.setAttribute("id","msgImg");
	var titleDiv=document.createElement("div");
	titleDiv.setAttribute("id","msgTitle");
	var titleDivTxt=document.createTextNode("弹出框");
	var contentDiv=document.createElement("div");
	contentDiv.setAttribute("id","msgContent");
	contentDiv.innerHTML=msgContent;
	var overDiv = document.createElement("div");
	if(Layer_lib == 1){
		overDiv.setAttribute("id","msg1");
	}else{
		overDiv.setAttribute("id","msg");
	}
	overDiv.style.display="none";
	overDiv.style.overflow="hidden";
	titleDiv.appendChild(imgClose);
	titleDiv.appendChild(titleDivTxt);
	overDiv.appendChild(titleDiv);
	overDiv.appendChild(contentDiv);
	var bodyHtml=document.getElementsByTagName("body");
	bodyHtml[0].appendChild(overDiv);
	//contentDiv.innerHTML=msgContent;
	showList(overDiv,120); 
	if(document.getElementById("overDiv")) return false;
	//设置显示时间
	setTimeout(function(){hiddenList(overDiv,120)},23000);
	//overDiv.parentNode.removeChild(overDiv);
}

//密码验证 by libin 2009-05-14
function similarMSNPop_layer(msgContent){
	Layer_lib = 1;
	var imgClose=document.createElement("img");
	imgClose.src="<%= request.getContextPath() %>/nresources/default/images/callimage/icon_close_off.gif";
	imgClose.style.cursor="pointer";
	imgClose.onmouseover=function()
	{
		imgClose.src="<%= request.getContextPath() %>/nresources/default/images/callimage/icon_close_on.gif";
	}
	imgClose.onmouseout=function()
	{
		imgClose.src="<%= request.getContextPath() %>/nresources/default/images/callimage/icon_close_off.gif";
	}
	imgClose.onclick=function()
	{
		hiddenList(overDiv,120);
	}
	imgClose.setAttribute("id","msgImg");
	var titleDiv=document.createElement("div");
	titleDiv.setAttribute("id","msgTitle");
	var titleDivTxt=document.createTextNode("弹出框");
	var contentDiv=document.createElement("div");
	contentDiv.setAttribute("id","msgContent");
	contentDiv.innerHTML=msgContent;
	var overDiv = document.createElement("div");
	overDiv.setAttribute("id","msg");
	overDiv.style.display="none";
	overDiv.style.overflow="hidden";
	titleDiv.appendChild(imgClose);
	titleDiv.appendChild(titleDivTxt);
	overDiv.appendChild(titleDiv);
	overDiv.appendChild(contentDiv);
	var bodyHtml=document.getElementsByTagName("body");
	bodyHtml[0].appendChild(overDiv);
	
	showList(overDiv,120); 
	if(document.getElementById("overDiv")) return false;
	
	setTimeout(function(){hiddenList(overDiv,120)},23000);
}

function showList(objectId,mH)
{
	var h =0;
	var maxHeight = mH;
	var anim = function()
	{ 
		h += 5;
		if(h > maxHeight)
		{ 
			objectId.style.height = mH+"px";  
			if(tt){window.clearInterval(tt);}  
		} 
		else
		{ 	
			objectId.style.height = h + "px";
			objectId.style.display="block";

		}
	} 
	var tt = window.setInterval(anim,2);  
} 

function hiddenList(objectId,mH)
{
	Layer_lib = 0;//关闭置为0 by libin 2009-05-14 
	var h =mH; 
	var anim = function()
	{ 
		h -= 5;
		if(h <= 0)
		{ 
			objectId.style.display="none";
			if(tt){window.clearInterval(tt);}
			objectId.parentNode.removeChild(objectId);
		} 
		else
		{ 
			objectId.style.height = h + "px";
		} 
	} 
	var tt = window.setInterval(anim,2); 
} 

*******************************************/
//信息框层叠 by libin 2009-05-15
var msn_popmenu = null;
var msn_count = 0;

function similarMSNPop_local(msgContent){
    msn_count++;
	var imgClose=msn_popmenu.oPopup.document.createElement("img");
	imgClose.src="<%= request.getContextPath() %>/nresources/default/images/callimage/icon_close_off.gif";
	imgClose.style.cursor="pointer";
	imgClose.onmouseover=function()
	{
		imgClose.src="<%= request.getContextPath() %>/nresources/default/images/callimage/icon_close_on.gif";
	}
	imgClose.onmouseout=function()
	{
		imgClose.src="<%= request.getContextPath() %>/nresources/default/images/callimage/icon_close_off.gif";
	}
	imgClose.onclick=function()
	{
		//hiddenList(overDiv,120);
	}
	imgClose.setAttribute("id","msgImg");
	var titleDiv=msn_popmenu.oPopup.document.createElement("div");
	titleDiv.setAttribute("id","msgTitle");
	var titleDivTxt=msn_popmenu.oPopup.document.createTextNode("弹出框");
	var contentDiv=msn_popmenu.oPopup.document.createElement("div");
	contentDiv.setAttribute("id","msgContent");
	contentDiv.innerHTML=msgContent;
	var overDiv = msn_popmenu.oPopup.document.createElement("div");
	overDiv.setAttribute("id","msg");
	overDiv.style.display="none";
	overDiv.style.overflow="hidden";
	
	overDiv.onclick=function(){
		hiddenList(overDiv,120);
	}
	
	titleDiv.appendChild(imgClose);
	titleDiv.appendChild(titleDivTxt);
	overDiv.appendChild(titleDiv);
	overDiv.appendChild(contentDiv);
	
	var bodyHtml=msn_popmenu.oPopup.document.getElementsByTagName("body");
	bodyHtml[0].appendChild(overDiv);
	
	showList(overDiv,120); 
	if(msn_popmenu.oPopup.document.getElementById("overDiv")) return false;
	
	
	var hidett = setTimeout(function(){hiddenList(overDiv,120)},10000);
	overDiv.setAttribute("hidett",hidett);
	
}

function showList(objectId,mH)
{
	var h =0;
	var maxHeight = mH;
	var anim = function()
	{ 
		h += 5;
		if(h > maxHeight)
		{ 
			objectId.style.height = mH+"px";  
			if(tt){window.clearInterval(tt);}  
		} 
		else
		{ 	
			objectId.style.height = h + "px";
			objectId.style.display="block";

		}
	} 
	var tt = window.setInterval(anim,15);  
} 

function hiddenList(objectId,mH)
{ 
	var h =mH; 
	var anim = function()
	{ 
		h -= 5;
		if(h <= 0)
		{ 
			objectId.style.display="none";
			if(tt){window.clearInterval(tt);
			if(objectId.getAttribute("hidett")!=null)
			{
				window.clearInterval(objectId.getAttribute("hidett"));
				}
			if(h>=-5){
			msn_count--;
			if(msn_count<0)
			   msn_count = 0;
			if(msn_count==0){
				msn_popmenu.stopthis();
				msn_popmenu.hide();
			}
			}
			}
			objectId.parentNode.removeChild(objectId);
		} 
		else
		{ 
			objectId.style.height = h + "px";
		} 
	} 
	var tt = window.setInterval(anim,15); 
} 
	
function similarMSNPop(msgContent){
    if(msn_popmenu == null){
    	var MSG1 = new CLASS_MSN_MESSAGE(180, 120, "");
		msn_popmenu = MSG1;
		MSG1.show();
    }else{
    	msn_popmenu.reshow();
    	}	
	similarMSNPop_local(msgContent);	
}

function CLASS_MSN_MESSAGE(width, height, title) {
	this.title = title;
	this.width = width ? width : 180;
	this.height = height ? height : 120;
	this.timeout = 500;
	this.speed = 150;
	this.step = 5;
	this.right = screen.width - 1;
	this.bottom = screen.height;
	this.left = this.right - this.width;
	this.top = this.bottom - this.height;
	this.timer = 0;
	this.pause = false;
	this.close = false;
	this.autoHide = true;

	this.clickClose = false;
}

CLASS_MSN_MESSAGE.prototype.hide = function () {
	this.oPopup.hide();
};

CLASS_MSN_MESSAGE.prototype.onunload = function () {
	return true;
};

CLASS_MSN_MESSAGE.prototype.show = function () {	
    this.oPopup = window.createPopup();
	this.Pop = this.oPopup;
	var w = this.width;
	var h = this.height;
	var x = this.right-this.width;
	var y = this.bottom-this.height;
	var str = '';
	var me = this.Pop;
	this.oPopup.document.createStyleSheet().addImport('<%= request.getContextPath() %>/nresources/default/css/layer_ob.css');
	this.oPopup.document.body.innerHTML = str;
	var fun = function () {
	    if(msn_count!=0)
		me.show(x, y, w, h);
	}
	this.timer = window.setInterval(fun, this.speed);	
	this.close = false;
};
                                                                                                                  
/*  
*    消息停止方法  
*/
CLASS_MSN_MESSAGE.prototype.stopthis = function () {	
  
	 window.clearInterval(this.timer);
	 this.close = true;	
};
/*  
*    消息显示方法  
*/
CLASS_MSN_MESSAGE.prototype.reshow = function () {	
  if(this.close==false){
  		return;
  	}
	var w = this.width;
	var h = this.height;
	var x = this.right-this.width;
	var y = this.bottom-this.height;
	var me = this.Pop;
	
	var fun = function () {
	    if(msn_count!=0)
		me.show(x, y, w, h);
	}
	this.timer = window.setInterval(fun, this.speed);	
	this.close = false;	
};



//心态调整的timer句柄
var h_adjustTimer;

//第一个灯
function firstLight(thisid)
{
  var workNo=cCcommonTool.getWorkNo();
  var current_CurState;
  if(parPhone.QueryAgentStatusEx(workNo)==0){
    current_CurState=parPhone.AgentInfoEx_CurState;
    //similarMSNPop("current_CurState"+current_CurState);
  }
  if(current_CurState==1)
  {
   
   //tancf 解决灯的问题
   try{
   //alert('k009= '+document.getElementById('K009').click);
   var ret=cCcommonTool.Adjustment();
   if(ret==0)
   {
   buttonType("K009");	
   /*----心态调整计时 开始 fangyuan 090308 ----*/
   resetStatusTimer();	
   showAdjustStatusTimesl();
  	
   h_adjustTimer = setTimeout(function(){endAdjust();},20*1000);
   //结束整理态的2个timer
   clearAllAdjustTimer();
   /*----心态调整计时 结束 fangyuan 090308 ----*/
   thisid.src="/nresources/default/images/ico_16/status_02.gif";
  }
  }
  catch(e){
		//alert("cc1");
		}
   //cCcommonTool.Adjustment();
   /*modify by fangyuan--start*/
   //setTimeout(function(){cCcommonTool.AdjustmentExit();resetStatusTimer();},20*1000);
   
   //恢复状态栏中的座席状态,ref footpanel	
   //resetStatusTimer();	
   //showAdjustStatusTimesl();
   /*modify by fangyuan--end*/
  }else if(current_CurState==6) //整理态
  {
    thisid.src="/nresources/default/images/ico_16/status_01.gif";
    var ret=cCcommonTool.ExtenseAdjustment();
    if(ret==0)
    {
    		buttonType("K003");
    		//恢复状态栏中的座席状态,ref footpanel
    		resetStatusTimer();	
    		clearTimeout(rotime); 
		    clearTimeout(intvar); 	
		    document.getElementById("extendTime").value="";
	      document.getElementById("beforeTime").value="";
    	}
  }else if(current_CurState==10)//调整态
  {
    thisid.src="/nresources/default/images/ico_16/status_01.gif";	
	 var ret = cCcommonTool.AdjustmentExit();
	 if(ret == 0){
	 		//恢复到空闲时的状态
			    buttonType("K003");	
		     //恢复状态栏中的座席状态,ref footpanel	
		     resetStatusTimer();	 	
		     clearTimeout(h_adjustTimer);
	 }
  }
  //
  current_CurState=parPhone.AgentInfoEx_CurState;
  agentStatus(current_CurState);
}
//点第二个灯
function secondLight(thisid)
{
var workNo=cCcommonTool.getWorkNo();
var current_CurState;
if(parPhone.QueryAgentStatusEx(workNo)==0){
current_CurState=parPhone.AgentInfoEx_CurState;
//similarMSNPop("current_CurState"+current_CurState);
}
//alert("current_CurState"+current_CurState);
if(current_CurState==1)
{
	try{
var ret=cCcommonTool.SayBusy();
if(ret==0)
{
thisid.src="/nresources/default/images/ico_16/status_02.gif";

}
}
catch(e){}

}
else if(current_CurState==7)
{
	try
	{
var ret=cCcommonTool.SayFree();
if(ret==0)
{
thisid.src="/nresources/default/images/ico_16/status_01.gif";

}
}
catch(e){}
}
}
function show()
{
 
}

//坐席状态
function agentStatus(current_CurState)
{ 
changeLight(current_CurState);

} 
function changeLight(current_CurState)
{       
				var bn_status_first=document.getElementById("bn_status_first");
				var bn_status_second=document.getElementById("bn_status_second");
				var bn_status_third=document.getElementById("bn_status_third");
				var bn_status_first_1=document.getElementById("bn_status_first_1");
				var bn_status_second_1=document.getElementById("bn_status_second_1");
				var bn_status_third_1=document.getElementById("bn_status_third_1");
				var contactingMsg= document.getElementById("contactingMsg");
			//	alert("current_CurState"+current_CurState);
 switch(current_CurState)
   {
    case 0: 
				//设置图片
				bn_status_first.src="/nresources/default/images/ico_16/status_01.gif";
				bn_status_second.src="/nresources/default/images/ico_16/status_01.gif";
				bn_status_third.src="/nresources/default/images/ico_16/status_01.gif";
        //按扭置灰
        bn_status_first_1.firstChild.className="img_grey";
				bn_status_second_1.firstChild.className="img_grey";
				bn_status_third_1.firstChild.className="img_grey";
				//设置alt
				bn_status_first.alt="签出";
				bn_status_second.alt="签出";
				bn_status_third.alt="签出";
        break;
    case 1: 
				//设置图片
				bn_status_first.src="/nresources/default/images/ico_16/status_01.gif";
				bn_status_second.src="/nresources/default/images/ico_16/status_01.gif";
				bn_status_third.src="/nresources/default/images/ico_16/status_01.gif";
        //设置alt
				bn_status_first.alt="进入心态调整";
				bn_status_second.alt="示忙";
				bn_status_third.alt="空闲状态";
				
        break;
    case 2: 
				//设置图片
				bn_status_first.src="/nresources/default/images/ico_16/status_02.gif";
				bn_status_second.src="/nresources/default/images/ico_16/status_01.gif";
				bn_status_third.src="/nresources/default/images/ico_16/status_01.gif";
				//by fangyuan 20090501
				handleAllBusyLight();
       	//设置alt
				bn_status_first.alt="预占用状态";
				bn_status_second.alt="预占用状态";
				bn_status_third.alt="预占用状态";
        break;
    case 3: 
				//设置图片
				var recordStatus1 = cCcommonTool.RecordStatus();
				bn_status_first.src="/nresources/default/images/ico_16/lisening.gif";
				bn_status_second.src="/nresources/default/images/ico_16/status_01.gif";
				bn_status_third.src="/nresources/default/images/ico_16/status_01.gif";
				//by fangyuan 20090501
				handleAllBusyLight();
        //设置alt
        			if(recordStatus1==2)
        			{
		        	bn_status_first.alt="放音态";
							bn_status_second.alt="放音态";
							bn_status_third.alt="放音态";
        			}
        			else
        			{
				bn_status_first.alt="占用状态";
				bn_status_second.alt="占用状态";
				bn_status_third.alt="占用状态";
				}
        break;
    case 4: 
				//设置图片
				bn_status_first.src="/nresources/default/images/ico_16/ringing.gif";
				bn_status_second.src="/nresources/default/images/ico_16/status_01.gif";
				bn_status_third.src="/nresources/default/images/ico_16/status_01.gif";
				//by fangyuan 20090501
				handleAllBusyLight();
        //设置alt
				bn_status_first.alt="应答状态";
				bn_status_second.alt="应答状态";
				bn_status_third.alt="应答状态";
        break;
    case 5: 
				//设置图片
				var acdNum;
				bn_status_first.src="/nresources/default/images/ico_16/ringing.gif";
				/*
				var acdsNum=cCcommonTool.getAcdsNum();
				if(acdNum>0)
				{
				bn_status_second.src="/nresources/default/images/ico_16/status_02.gif";
				}
				else
				{
				bn_status_second.src="/nresources/default/images/ico_16/status_01.gif";
				}
				*/
				bn_status_third.src="/nresources/default/images/ico_16/status_01.gif";
				//by fangyuan 20090501
				handleAllBusyLight();
        //设置alt
				bn_status_first.alt="通话状态";
				bn_status_second.alt="通话状态";
				bn_status_third.alt="通话状态";
        break;
    case 6: 
				//设置图片
				bn_status_first.src="/nresources/default/images/ico_16/status_02.gif";
				bn_status_second.src="/nresources/default/images/ico_16/status_01.gif";
				bn_status_third.src="/nresources/default/images/ico_16/status_01.gif";
				//by fangyuan 20090501
				handleAllBusyLight();
        //设置alt
				bn_status_first.alt="切换到空闲态";
				bn_status_second.alt="工作状态";
				bn_status_third.alt="工作状态";
        break;
    case 7: 
				//设置图片
				bn_status_first.src="/nresources/default/images/ico_16/status_01.gif";
				bn_status_second.src="/nresources/default/images/ico_16/status_02.gif";
				bn_status_third.src="/nresources/default/images/ico_16/status_01.gif";
        //设置alt
        
				bn_status_first.alt="忙状态";
				bn_status_second.alt="示闲";
				bn_status_third.alt="忙状态";
        break;
    case 8: 
				//设置图片
				bn_status_first.src="/nresources/default/images/ico_16/status_01.gif";
				bn_status_second.src="/nresources/default/images/ico_16/status_02.gif";
				bn_status_third.src="/nresources/default/images/ico_16/status_01.gif";
				
        //设置alt
				bn_status_first.alt="请假休息态";
				bn_status_second.alt="请假休息态";
				bn_status_third.alt="请假休息态";
        break;
    case 9: 
				//设置图片
				bn_status_first.src="/nresources/default/images/ico_16/status_02.gif";
				bn_status_second.src="/nresources/default/images/ico_16/status_01.gif";
				bn_status_third.src="/nresources/default/images/ico_16/status_01.gif";
        //设置alt
				bn_status_first.alt="学习态";
				bn_status_second.alt="学习态";
				bn_status_third.alt="学习态";
        break;
    case 10: 
				//设置图片
				bn_status_first.src="/nresources/default/images/ico_16/status_02.gif";
				bn_status_second.src="/nresources/default/images/ico_16/status_01.gif";
				bn_status_third.src="/nresources/default/images/ico_16/status_01.gif";
				//by fangyuan 20090501
				handleAllBusyLight();
       //设置alt
				bn_status_first.alt="调整态";
				bn_status_second.alt="调整态";
				bn_status_third.alt="调整态";
        break;
   }

}

// by fangyuan 20090501 有等待数时，第二个灯不变绿(不指示空闲态)
function handleAllBusyLight(){
		var bn_status_second=document.getElementById("bn_status_second");
		var acdsNum=cCcommonTool.getAcdsNum();
		if(acdsNum>0){
				bn_status_second.src="/nresources/default/images/ico_16/status4.gif";
		}
}

</script>

<style>
#msg{
width:180px;
height:120px;
position:absolute;
right:0px;
bottom:0px;
z-index:2;
border:1px solid #555;
background:url(<%= request.getContextPath() %>/nresources/default/images/callimage/msg_bj.gif) repeat-x 0 0;
font-size:12px;
}
#msgTitle{
height:16px;
padding:8px 0px 0px 10px;
border-bottom:2px solid #b3f9ff;
position:relative;
}
#msgContent{
padding:10px;
height:1%;
color:#555;
}
#msgImg{
position:absolute;
right:5px;
top:5px;
z-index:10;
width:10px;
height:10px;
}
</style>
<!--客服(2) update by songjia 2010/08/20 begin-->
<!--<div id="callSearch">-->
<div id="callSearch" style='display:none;'>
<!--客服(2) update by songjia 2010/08/20 end-->
	<b id="K005"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k005.gif" alt="签入" />签入</b>
	<b id="K006"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k006.gif" alt="签出" />签出</b>
	<b id="K025"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k025.gif" alt="呼出" />呼出</b>
	<b id="K016"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k016.gif" alt="请求来话" />请求来话</b>
	<b id="K013"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k013.gif" alt="挂机释放" />挂机释放</b>
	<b id="K026"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k026.gif" alt="通话保持" />通话保持</b>
	<b id="K004"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k004.gif" alt="示忙" />示忙</b>
	<b id="K019"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k019.gif" alt="密码验证" />密码验证</b>
	<b id="K054"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k054.gif" alt="来电原因" />来电原因</b>
	<b id="K029"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k029.gif" alt="呼叫转移" />呼叫转移</b>
	<b id="K017"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k017.gif" alt="静音" />静音</b>
	<b id="K018"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k018.gif" alt="取消静音" />取消静音</b>
	<b id="K030"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k030.gif" alt="内部呼叫" />内部呼叫</b>		 
	<b id="M001"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k055.gif" alt="通知发送" />通知发送</b>
	<b id="K007"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k007.gif" alt="学习" />学习</b>
	<b id="K008"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k008.gif" alt="结束学习" />结束学习</b>	
	<b id="K011"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k011.gif" alt="整理态延迟" />整理态延迟</b>
	<b id="K020"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k020.gif" alt="二次拨号" />二次拨号</b>
	<b id="K010"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k010.gif" alt="进入整理态" />进入整理态</b>	 
	<b id="K014"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k014.gif" alt="内部求助" />内部求助</b>
	<b id="K102"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k025.gif" alt="转出" />转出</b>
	<b id="K009"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k009.gif" alt="心态调整" />心态调整</b>
	<b id="K021"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k021.gif" alt="来话应答" />来话应答</b>
	<b id="K012"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k012.gif" alt="请假" />请假</b>
	<b id="K024"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k024.gif" alt="接通三方" />接通三方</b>
	<b id="K039"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k039.gif" alt="重连CCS" />重连CCS</b>
	<!--<b id="K027"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k027.gif" alt="取保持" />取保持</b>-->
	<!--<b id="K028"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k028.gif" alt="夜班抢答" />夜班抢答</b>-->
	<b id="K047"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k047.gif" alt="旁听" />旁听</b>
	<b id="K048"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k048.gif" alt="插入" />插入</b>
	<b id="K049"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k049.gif" alt="拦截" />拦截</b>
	<b id="K050"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k050.gif" alt="强制示闲" />强制示闲</b>
	<b id="K051"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k051.gif" alt="强制示忙" />强制示忙</b>
	<b id="K052"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k052.gif" alt="强制签出" />强制签出</b>
		<b id="K001"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k001.gif" alt="休息" />休息</b>
	<b id="K002"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k002.gif" alt="结束休息" />结束休息</b>	
	<b id="K055"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k055.gif" alt="用户信息" />用户信息</b>
	<!--<b id="K086"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k019.gif" alt="他机验证" />他机验证</b>-->
	<!--<b id="K073"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k010.gif" alt="呼叫轨迹" />呼叫轨迹</b>-->
	<b id="K101">
	<img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k019.gif" alt="日志生成" />日志生成</b>
	<b id="K100"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k055.gif" alt="暂时离开" />暂时离开</b>
	<b id="K086"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k019.gif" alt="新增客户接触" />新增客户接触</b>
	<!--
	<b id="K056"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k056.gif" alt="换班" />换班</b>
	-->
	<span id="moreCall" onclick="btn_More()"> 更多>> </span>
	
	<div class="more_btn" style="dispaly:block" id="more_btn" onmouseleave="btn_More();"></div>
	<div class="more_btn"  style="dispaly:block;z-index:-1;padding:0px 0px 0px 0px;" id="more_btn2">
	<iframe id="more_btn2iframe" border="0" style="margin:0px 0px 0px 0px;" src=''></iframe>
	</div>
	
	<div class="clr"></div>
	<div class="line">
		<!--yhy 添加测试开始-->
		<!--客服(1) update by songjia 2010/08/20 begin-->
		<!--<span id="just_a_test" style="cursor:hand">-->
		<!--客服(1) update by songjia 2010/08/20 end-->
		
		<span id="K065" style="cursor:hand">人调</span>
		<!--<span id="K036" style="cursor:hand">自答</span>-->
		<span id="K037" style="cursor:hand">无铃</span>
		<!----><span id="K062" style="cursor:hand">自释</span>
		<b id="bn_status_first_1"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/status_01.gif" alt="空闲"  id="bn_status_first" onclick="firstLight(this)" /></b>
		<b id="bn_status_second_1"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/status_01.gif" alt="空闲"  id="bn_status_second" onclick="secondLight(this)"/></b>
		<b id="bn_status_third_1"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/status_01.gif"  alt="空闲"  id="bn_status_third" /></b>
		<span id="contactingMsg"></span>
		<b id="K042"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k042.gif" alt="放音" /></b>
		<b id="K043"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k043.gif" alt="停止放音" /></b>
		<b id="K044"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k044.gif" alt="暂停放音" /></b>
		<b id="K064"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k064.gif" alt="继续放音" /></b>
		<b id="K045"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k045.gif" alt="快进" /></b>
		<b id="K046"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k046.gif" alt="快退" /></b>
		<!--<b id="K057"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k057.gif" alt="视频播放" class="grey"  /></b>
		<b id="K058"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k058.gif" alt="视频停止"  class="grey"  /></b>
		<b id="K059"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k059.gif" alt="视频暂停播放"  class="grey"  /></b>
		<b id="K060"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k060.gif" alt="视频快进"  class="grey"  /></b>
		<b id="K061"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k061.gif" alt="视频快退"  class="grey"  /></b>-->
	</div>
		<!-- ocx初始化参数 -->
		<!-- 签入手机号码 -->
		<input type="hidden" id="sign_phone_no" name="sign_phone_no" value="<%=request.getParameter("sign_phone_no")%>"/>
		<!-- 客服服务器IP地址 -->
		<input type="hidden" id="mainCCSIp" name="mainCCSIp" value="<%=request.getParameter("mainCCSIp")%>"/>
		<!-- CALLCS mainCCSIp2-BackCcsIP by zwy 20090303-->
		<input type="hidden" id="BackCcsIP" name="BackCcsIP" value="<%=request.getParameter("mainCCSIp2")%>"/>
		
		
		<!-- 座席类型 -->
		<input type="hidden" id="agentType" name="agentType" value="<%=request.getParameter("agentType")%>"/>
		
		
		<!-- 为三方通话设转移座席拦截号 -->
		<input type="hidden" id="threePerson" name="threePerson" value=""/>
		<!-- 进程ID -->
		<input type="hidden" id="CCSId" name="CCSId" value="<%=request.getParameter("CCSId")%>"/>
		<!-- <input type="hidden" id="CCSId" name="CCSId" value="22"/>-->
		<!-- 客服工号编码 kf_longin_no -->
		<!--
		<input type="hidden" id="WorkNo" name="WorkNo" value="<%=request.getParameter("WorkNo")%>"/>
		-->
		<input type="hidden" id="WorkNo" name="WorkNo" value="<%=kf_longin_no%>"/>
		<!-- boss工号编码 -->
		<input type="hidden" id="loginNo" name="loginNo" value="<%=workNo%>"/>
		
		
		<!--客服(4) 修改Password为Password_kf ，与boss冲突。update by songjia 2010/08/20 begin-->
		<!-- 客服密码 -->
		<input type="hidden" id="Password_kf" name="Password_kf" value="<%=request.getParameter("p")%>" />
		<!--客服(4) 去掉 update by songjia 2010/08/20 begin-->
		
		
		<!-- 登陆客户端主机IP地址 -->
		<input type="hidden" id="ipAddress" name="ipAddress" value="<%=request.getRemoteAddr()%>"/>	
		<!-- 接触流水，在每次接触开始时生成，且一次接触只产生一个，如来话应答、呼出；来话转接时，由转接发起方生成传递给接收方。 -->
		<input type="hidden" id="contactId" name="contactId" value=""/>
		<input type="hidden" id="transagent" name="transagent" value=""/>
		<input type="hidden" id="called_no_agent" name="called_no_agent" value=""/>
		<!-- 接触发生时的年月，dcallcallYYYYMM表按月存储，为避免跨月接触情况不能更新正确的接触记录而设。在更新dcallcallYYYYMM表的时候YYYYMM应该取此值，而不应该取更新时的系统时间 -->
		<input type="hidden" id="contactMonth" name="contactMonth" value=""/>
		<input type="hidden" id="recordfile" name="recordfile" value=""/>
		<!-- 上次来话客户手机号码，用于本次来话时关闭上次来话用户详细信息的Tab页 -->
		<input type="hidden" id="last_caller_phone" name="last_caller_phone" value=""/>
		<!-- 通话保持流水，取保持更新保持记录的结束时间之用 -->
		<input type="hidden" id="hold_call_id" name="hold_call_id" value=""/>
		<!-- boss工号归属组织编码 -->
		<input type="hidden" id="orgCode" name="orgCode" value="<%=orgCode %>"/>
		<!-- boss工号归属地市编码 -->
		<input type="hidden" id="regionCode" name="regionCode" value="<%=regionCode %>"/>
		<!-- 请假日志流水 -->
		<input type="hidden" id="restId" name="restId" value=""/>
		<!-- 用于判断是否对来话进行录音，如果是内部呼叫来话的话是不需要录音的，在获得接触流水的同时设置该标志 -->
		<input type="hidden" id="recordFlag" name="restId" value="Y"/>
		<!--是不是学习态-->
		<input type="hidden" id="loginStatus" name="loginStatus" value="<%=request.getParameter("loginStatus")%>"/>
		
		<input type="hidden" id="recordFileGet" name="recordFileGet" value=""/>
		<!--input type="button" onclick="getContactIdTest()" value="test"/-->	
		<!--标记各状态流水号-->
		<input type="hidden" id="oprId" name="oprId" value=""/>
		<!--查询状态中有没有符合条件得数据-->
		<input type="hidden" id="num" name="num" value=""/>
		<!--符合条件数据得状态-->
		<input type="hidden" id="oprType" name="oprType" value=""/>
		<!--记录目标工号-->
		<input type="hidden" id="oprObject" name="oprObject" value=""/>
		<!--记录数据库中存储的本工号-->
		<input type="hidden" id="staffNoList" name="staffNoList" value=""/>
		<!--记录听音的contactId-->
		<input type="hidden" id="lisenContactId" name="lisenContactId" value=""/>
		<!--本机的IP-->
		<input type="hidden" id="localIp" name="localIp" value="<%=request.getParameter("localIp")%>"/>
		<!--质检tab页面的id-----add by hanjc 20090116-->
		<input type="hidden" id="qcTabId" name="qcTabId" value=""/>
		<!--客户姓名-----add by lijin 090221-->
		<input type="hidden" id="custName" name="custName" value=""/>	
		<!--临时保存通知发送结果-----add by hanjc 20090222-->
		<input type="hidden" id="msgContent" name="msgContent" value=""/>	
		<!--是否挂机后是否进入整理态的标识-----add by fangyuan 20090227-->
		<input type="hidden" id="isNeedAdjust" name="isNeedAdjust" value=""/>	
		<input type="hidden" id="extendTime" name="extendTime" value=""/>
		<input type="hidden" id="beforeTime" name="beforeTime" value=""/>	
		<!--记录受理号码-----add by fangyuan 20090326-->
		<input type="hidden" id="acceptPhoneNo" name="acceptPhoneNo" value=""/>
		<!--三方中记录前一个contactId-----add by lijin 20090418-->
		<input type="hidden" id="beforeContactId" name="beforeContactId" value=""/>
		<!--受理号码的userClass-->
		<input type="hidden" id="huaWeiUserClass" name="huaWeiUserClass" value=""/>
		<!--当前呼叫录音文件名-----add by tangsong 20100507-->
		<input type="hidden" id="recordFileName" name="recordFileName" value=""/>
		<!--受理号码所属省份-->
		<input type="hidden" id="provice" name="provice" value=""/>			
		<!--呼叫中心标识-->
		<input type="hidden" id="ccno" name="ccno" value="<%=request.getParameter("ccno")%>"/>	
		<input type="hidden" id="CurrContactId" name="CurrContactId" value=""/>		
</div>


<script language="JavaScript" src="<%= request.getContextPath() %>/njs/csp/sitechcallcenter.js"></script>
<script type="text/javascript">

<!--
//cCcommonTool.setSign_phone_no('<%= request.getParameter("sign_phone_no") %>');
//cCcommonTool.setMainCcsIp('<%= request.getParameter("mainCCSIp") %>');
//cCcommonTool.setAgentType('<%= request.getParameter("agentType") %>');
//cCcommonTool.setCcsID('<%= request.getParameter("CCSId") %>');
//alert(cCcommonTool.sign_phone_no);
//alert(cCcommonTool.mainCcsIp);
//alert(cCcommonTool.agentType);
//alert(cCcommonTool.ccsID);
cCcommonTool.DebugLog("主机IP：<%=InetAddress.getLocalHost().getHostAddress()%>");
function getContactIdTest(){
	getContactId();
	callCauseTree();
}

//by hanjc 
//var scan = setInterval("scanNewMsg()",1*5*1000);	                         
 //setInterval("cCcommonTool.getCurrentIEMemUsed()",2000);      
	//提取新通知
/*function scanNewMsg(){
  var msgContentTemp=document.getElementById("msgContent");
  var msgContent='';
  if(msgContentTemp!=null&&msgContentTemp!=''){
     msgContent=msgContentTemp.value;
  }
  var mypacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_scan_rpc.jsp","扫描新通知，请稍候......");
  //mypacket.data.add("send_login_no",document.sitechform.send_login_no.value);
  mypacket.data.add("msgContent",msgContent);	
  core.ajax.sendPacket(mypacket,showMsg,true);
	mypacket=null;
}*/

//显示新通知
/*function showMsg(packet){
	var hasNew = packet.data.findValueByName("hasNew");
	var contentList = packet.data.findValueByName("contentList");
	var last_send_login_no = packet.data.findValueByName("last_send_login_no");
	contentList = contentList.replace(/\+/g,"%2B");
	var msgContent = packet.data.findValueByName("msgContent");	
	//alert(hasNew);
	if(parseInt(hasNew)>0&&trim(contentList).length>2){
	 //if(rdShowConfirmDialog("你有"+hasNew+"条新通知，需要查看吗？")=="1"){
	  //openWinMid("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_showNewMsg.jsp?contentList="+contentList,"新通知",240, 480);
	  
	  var receive_login_no = '';
	  if(showMsg_temp!=''&&!showMsg_temp.closed){
	  	similarMSNPop("你有"+hasNew+"条新通知");
	  	showMsg_temp.setContentVal2(contentList);
	  }else{
	  	showMsg_temp=openWinMid("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_commNoteRecSend.jsp?msgContent="+msgContent+"&last_send_login_no="+last_send_login_no,"新通知",480, 640);
	  }
	  if(showMsg_temp!=""){
	    updateCfm();
	    //showMsg_temp="";
	  }
	 //}
	}
}*/

/*function updateCfm(){
	//if(rdShowConfirmDialog("下次不在显示该通知？")=="1"){
	  var mypacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_update_msgIsRead_rpc.jsp","正在更新通知，请稍候......");
    core.ajax.sendPacket(mypacket,doProcess,true);
    mypacket=null;
 // }
}*/

/*function doProcess(packet){
	//var retCode = packet.data.findValueByName("retCode");
	//if(retCode!="000000"){
	//  updateCfm();
	//}
}*/


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

/*function openWinMid(url,name,iHeight,iWidth)
{
  //var url; //转向网页的地址;
  //var name; //网页名称，可为空;
  //var iWidth; //弹出窗口的宽度;
  //var iHeight; //弹出窗口的高度;
  var iTop = (window.screen.availHeight-30-iHeight)/2; //获得窗口的垂直位置;
  var iLeft = (window.screen.availWidth-10-iWidth)/2; //获得窗口的水平位置;
  return window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',scrollbars=auto, resizable=no,location=no, status=yes');
}	*/
//通讯检测功能 by zwy
function scanCom(){
 var mypacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/config/K101_scan_rpc.jsp?login_no=<%=workNo%>","通讯扫描，请稍候......");
  core.ajax.sendPacket(mypacket,retScanCom,true);
	mypacket=null;
}
function retScanCom(){

}

var intervalScanCom = setInterval("scanCom()",60000);	

-->
</script>