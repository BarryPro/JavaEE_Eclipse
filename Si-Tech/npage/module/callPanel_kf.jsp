<%String kf_longin_no=(String)session.getAttribute("kfWorkNo");

%>
<%@ page import="java.net.InetAddress"%>
<%@ include file="../../njs/csp/handle_event.js" %>
<script type="text/javascript" language="javascript" src="../../njs/csp/answer_event.js"></script>
<script type="text/javascript" language="javascript" src="../../njs/csp/k025.js"></script>
<!--�ͷ�(3) ȥ�� update by songjia 2010/08/20 begin-->
<script type="text/javascript" language="javascript" src="../../njs/si/base_kf.js"></script>
<script type="text/javascript" language="javascript" src="../../njs/si/ajax_kf.js"></script>
<!--�ͷ�(3) update by songjia 2010/08/20 begin-->

<%-- ԭ�е�OCX�ؼ� --%>
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
<%-- �¿�����OCX�ؼ� --%>
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

<%-- ��msn��ʾ����ʾ�¼������� --%>
<script language="javascript" type="text/javascript">
	
	/*add by yinzx ����Ȩ�޿��� ִ��Ч���д����� begin 0729*/
	  /*$(document).ready(
		function()
		{
			  
	      $("b").hide();

	      $("#bn_status_first_1").show(); 
	      $("#bn_status_second_1").show(); 
	      $("#bn_status_third_1").show();
	      //$("#K073").show();  
	      $("#K101").show();  
	     
	      
	      
	     var packet = new AJAXPacket("../login/getPanlePdom.jsp","���Ժ�...");
	  	 core.ajax.sendPacket(packet,doProcessPanPdom);//�첽
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
		/*add by yinzx ����Ȩ�޿��� end 0729*/

/**************************
//���������֤������Ϣ�����ϲ� by libin 2009-05-14
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
	var titleDivTxt=document.createTextNode("������");
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
	//������ʾʱ��
	setTimeout(function(){hiddenList(overDiv,120)},23000);
	//overDiv.parentNode.removeChild(overDiv);
}

//������֤ by libin 2009-05-14
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
	var titleDivTxt=document.createTextNode("������");
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
	Layer_lib = 0;//�ر���Ϊ0 by libin 2009-05-14 
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
//��Ϣ���� by libin 2009-05-15
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
	var titleDivTxt=msn_popmenu.oPopup.document.createTextNode("������");
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
*    ��Ϣֹͣ����  
*/
CLASS_MSN_MESSAGE.prototype.stopthis = function () {	
  
	 window.clearInterval(this.timer);
	 this.close = true;	
};
/*  
*    ��Ϣ��ʾ����  
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



//��̬������timer���
var h_adjustTimer;

//��һ����
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
   
   //tancf ����Ƶ�����
   try{
   //alert('k009= '+document.getElementById('K009').click);
   var ret=cCcommonTool.Adjustment();
   if(ret==0)
   {
   buttonType("K009");	
   /*----��̬������ʱ ��ʼ fangyuan 090308 ----*/
   resetStatusTimer();	
   showAdjustStatusTimesl();
  	
   h_adjustTimer = setTimeout(function(){endAdjust();},20*1000);
   //��������̬��2��timer
   clearAllAdjustTimer();
   /*----��̬������ʱ ���� fangyuan 090308 ----*/
   thisid.src="/nresources/default/images/ico_16/status_02.gif";
  }
  }
  catch(e){
		//alert("cc1");
		}
   //cCcommonTool.Adjustment();
   /*modify by fangyuan--start*/
   //setTimeout(function(){cCcommonTool.AdjustmentExit();resetStatusTimer();},20*1000);
   
   //�ָ�״̬���е���ϯ״̬,ref footpanel	
   //resetStatusTimer();	
   //showAdjustStatusTimesl();
   /*modify by fangyuan--end*/
  }else if(current_CurState==6) //����̬
  {
    thisid.src="/nresources/default/images/ico_16/status_01.gif";
    var ret=cCcommonTool.ExtenseAdjustment();
    if(ret==0)
    {
    		buttonType("K003");
    		//�ָ�״̬���е���ϯ״̬,ref footpanel
    		resetStatusTimer();	
    		clearTimeout(rotime); 
		    clearTimeout(intvar); 	
		    document.getElementById("extendTime").value="";
	      document.getElementById("beforeTime").value="";
    	}
  }else if(current_CurState==10)//����̬
  {
    thisid.src="/nresources/default/images/ico_16/status_01.gif";	
	 var ret = cCcommonTool.AdjustmentExit();
	 if(ret == 0){
	 		//�ָ�������ʱ��״̬
			    buttonType("K003");	
		     //�ָ�״̬���е���ϯ״̬,ref footpanel	
		     resetStatusTimer();	 	
		     clearTimeout(h_adjustTimer);
	 }
  }
  //
  current_CurState=parPhone.AgentInfoEx_CurState;
  agentStatus(current_CurState);
}
//��ڶ�����
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

//��ϯ״̬
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
				//����ͼƬ
				bn_status_first.src="/nresources/default/images/ico_16/status_01.gif";
				bn_status_second.src="/nresources/default/images/ico_16/status_01.gif";
				bn_status_third.src="/nresources/default/images/ico_16/status_01.gif";
        //��Ť�û�
        bn_status_first_1.firstChild.className="img_grey";
				bn_status_second_1.firstChild.className="img_grey";
				bn_status_third_1.firstChild.className="img_grey";
				//����alt
				bn_status_first.alt="ǩ��";
				bn_status_second.alt="ǩ��";
				bn_status_third.alt="ǩ��";
        break;
    case 1: 
				//����ͼƬ
				bn_status_first.src="/nresources/default/images/ico_16/status_01.gif";
				bn_status_second.src="/nresources/default/images/ico_16/status_01.gif";
				bn_status_third.src="/nresources/default/images/ico_16/status_01.gif";
        //����alt
				bn_status_first.alt="������̬����";
				bn_status_second.alt="ʾæ";
				bn_status_third.alt="����״̬";
				
        break;
    case 2: 
				//����ͼƬ
				bn_status_first.src="/nresources/default/images/ico_16/status_02.gif";
				bn_status_second.src="/nresources/default/images/ico_16/status_01.gif";
				bn_status_third.src="/nresources/default/images/ico_16/status_01.gif";
				//by fangyuan 20090501
				handleAllBusyLight();
       	//����alt
				bn_status_first.alt="Ԥռ��״̬";
				bn_status_second.alt="Ԥռ��״̬";
				bn_status_third.alt="Ԥռ��״̬";
        break;
    case 3: 
				//����ͼƬ
				var recordStatus1 = cCcommonTool.RecordStatus();
				bn_status_first.src="/nresources/default/images/ico_16/lisening.gif";
				bn_status_second.src="/nresources/default/images/ico_16/status_01.gif";
				bn_status_third.src="/nresources/default/images/ico_16/status_01.gif";
				//by fangyuan 20090501
				handleAllBusyLight();
        //����alt
        			if(recordStatus1==2)
        			{
		        	bn_status_first.alt="����̬";
							bn_status_second.alt="����̬";
							bn_status_third.alt="����̬";
        			}
        			else
        			{
				bn_status_first.alt="ռ��״̬";
				bn_status_second.alt="ռ��״̬";
				bn_status_third.alt="ռ��״̬";
				}
        break;
    case 4: 
				//����ͼƬ
				bn_status_first.src="/nresources/default/images/ico_16/ringing.gif";
				bn_status_second.src="/nresources/default/images/ico_16/status_01.gif";
				bn_status_third.src="/nresources/default/images/ico_16/status_01.gif";
				//by fangyuan 20090501
				handleAllBusyLight();
        //����alt
				bn_status_first.alt="Ӧ��״̬";
				bn_status_second.alt="Ӧ��״̬";
				bn_status_third.alt="Ӧ��״̬";
        break;
    case 5: 
				//����ͼƬ
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
        //����alt
				bn_status_first.alt="ͨ��״̬";
				bn_status_second.alt="ͨ��״̬";
				bn_status_third.alt="ͨ��״̬";
        break;
    case 6: 
				//����ͼƬ
				bn_status_first.src="/nresources/default/images/ico_16/status_02.gif";
				bn_status_second.src="/nresources/default/images/ico_16/status_01.gif";
				bn_status_third.src="/nresources/default/images/ico_16/status_01.gif";
				//by fangyuan 20090501
				handleAllBusyLight();
        //����alt
				bn_status_first.alt="�л�������̬";
				bn_status_second.alt="����״̬";
				bn_status_third.alt="����״̬";
        break;
    case 7: 
				//����ͼƬ
				bn_status_first.src="/nresources/default/images/ico_16/status_01.gif";
				bn_status_second.src="/nresources/default/images/ico_16/status_02.gif";
				bn_status_third.src="/nresources/default/images/ico_16/status_01.gif";
        //����alt
        
				bn_status_first.alt="æ״̬";
				bn_status_second.alt="ʾ��";
				bn_status_third.alt="æ״̬";
        break;
    case 8: 
				//����ͼƬ
				bn_status_first.src="/nresources/default/images/ico_16/status_01.gif";
				bn_status_second.src="/nresources/default/images/ico_16/status_02.gif";
				bn_status_third.src="/nresources/default/images/ico_16/status_01.gif";
				
        //����alt
				bn_status_first.alt="�����Ϣ̬";
				bn_status_second.alt="�����Ϣ̬";
				bn_status_third.alt="�����Ϣ̬";
        break;
    case 9: 
				//����ͼƬ
				bn_status_first.src="/nresources/default/images/ico_16/status_02.gif";
				bn_status_second.src="/nresources/default/images/ico_16/status_01.gif";
				bn_status_third.src="/nresources/default/images/ico_16/status_01.gif";
        //����alt
				bn_status_first.alt="ѧϰ̬";
				bn_status_second.alt="ѧϰ̬";
				bn_status_third.alt="ѧϰ̬";
        break;
    case 10: 
				//����ͼƬ
				bn_status_first.src="/nresources/default/images/ico_16/status_02.gif";
				bn_status_second.src="/nresources/default/images/ico_16/status_01.gif";
				bn_status_third.src="/nresources/default/images/ico_16/status_01.gif";
				//by fangyuan 20090501
				handleAllBusyLight();
       //����alt
				bn_status_first.alt="����̬";
				bn_status_second.alt="����̬";
				bn_status_third.alt="����̬";
        break;
   }

}

// by fangyuan 20090501 �еȴ���ʱ���ڶ����Ʋ�����(��ָʾ����̬)
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
<!--�ͷ�(2) update by songjia 2010/08/20 begin-->
<!--<div id="callSearch">-->
<div id="callSearch" style='display:none;'>
<!--�ͷ�(2) update by songjia 2010/08/20 end-->
	<b id="K005"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k005.gif" alt="ǩ��" />ǩ��</b>
	<b id="K006"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k006.gif" alt="ǩ��" />ǩ��</b>
	<b id="K025"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k025.gif" alt="����" />����</b>
	<b id="K016"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k016.gif" alt="��������" />��������</b>
	<b id="K013"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k013.gif" alt="�һ��ͷ�" />�һ��ͷ�</b>
	<b id="K026"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k026.gif" alt="ͨ������" />ͨ������</b>
	<b id="K004"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k004.gif" alt="ʾæ" />ʾæ</b>
	<b id="K019"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k019.gif" alt="������֤" />������֤</b>
	<b id="K054"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k054.gif" alt="����ԭ��" />����ԭ��</b>
	<b id="K029"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k029.gif" alt="����ת��" />����ת��</b>
	<b id="K017"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k017.gif" alt="����" />����</b>
	<b id="K018"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k018.gif" alt="ȡ������" />ȡ������</b>
	<b id="K030"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k030.gif" alt="�ڲ�����" />�ڲ�����</b>		 
	<b id="M001"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k055.gif" alt="֪ͨ����" />֪ͨ����</b>
	<b id="K007"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k007.gif" alt="ѧϰ" />ѧϰ</b>
	<b id="K008"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k008.gif" alt="����ѧϰ" />����ѧϰ</b>	
	<b id="K011"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k011.gif" alt="����̬�ӳ�" />����̬�ӳ�</b>
	<b id="K020"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k020.gif" alt="���β���" />���β���</b>
	<b id="K010"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k010.gif" alt="��������̬" />��������̬</b>	 
	<b id="K014"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k014.gif" alt="�ڲ�����" />�ڲ�����</b>
	<b id="K102"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k025.gif" alt="ת��" />ת��</b>
	<b id="K009"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k009.gif" alt="��̬����" />��̬����</b>
	<b id="K021"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k021.gif" alt="����Ӧ��" />����Ӧ��</b>
	<b id="K012"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k012.gif" alt="���" />���</b>
	<b id="K024"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k024.gif" alt="��ͨ����" />��ͨ����</b>
	<b id="K039"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k039.gif" alt="����CCS" />����CCS</b>
	<!--<b id="K027"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k027.gif" alt="ȡ����" />ȡ����</b>-->
	<!--<b id="K028"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k028.gif" alt="ҹ������" />ҹ������</b>-->
	<b id="K047"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k047.gif" alt="����" />����</b>
	<b id="K048"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k048.gif" alt="����" />����</b>
	<b id="K049"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k049.gif" alt="����" />����</b>
	<b id="K050"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k050.gif" alt="ǿ��ʾ��" />ǿ��ʾ��</b>
	<b id="K051"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k051.gif" alt="ǿ��ʾæ" />ǿ��ʾæ</b>
	<b id="K052"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k052.gif" alt="ǿ��ǩ��" />ǿ��ǩ��</b>
		<b id="K001"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k001.gif" alt="��Ϣ" />��Ϣ</b>
	<b id="K002"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k002.gif" alt="������Ϣ" />������Ϣ</b>	
	<b id="K055"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k055.gif" alt="�û���Ϣ" />�û���Ϣ</b>
	<!--<b id="K086"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k019.gif" alt="������֤" />������֤</b>-->
	<!--<b id="K073"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k010.gif" alt="���й켣" />���й켣</b>-->
	<b id="K101">
	<img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k019.gif" alt="��־����" />��־����</b>
	<b id="K100"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k055.gif" alt="��ʱ�뿪" />��ʱ�뿪</b>
	<b id="K086"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k019.gif" alt="�����ͻ��Ӵ�" />�����ͻ��Ӵ�</b>
	<!--
	<b id="K056"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k056.gif" alt="����" />����</b>
	-->
	<span id="moreCall" onclick="btn_More()"> ����>> </span>
	
	<div class="more_btn" style="dispaly:block" id="more_btn" onmouseleave="btn_More();"></div>
	<div class="more_btn"  style="dispaly:block;z-index:-1;padding:0px 0px 0px 0px;" id="more_btn2">
	<iframe id="more_btn2iframe" border="0" style="margin:0px 0px 0px 0px;" src=''></iframe>
	</div>
	
	<div class="clr"></div>
	<div class="line">
		<!--yhy ��Ӳ��Կ�ʼ-->
		<!--�ͷ�(1) update by songjia 2010/08/20 begin-->
		<!--<span id="just_a_test" style="cursor:hand">-->
		<!--�ͷ�(1) update by songjia 2010/08/20 end-->
		
		<span id="K065" style="cursor:hand">�˵�</span>
		<!--<span id="K036" style="cursor:hand">�Դ�</span>-->
		<span id="K037" style="cursor:hand">����</span>
		<!----><span id="K062" style="cursor:hand">����</span>
		<b id="bn_status_first_1"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/status_01.gif" alt="����"  id="bn_status_first" onclick="firstLight(this)" /></b>
		<b id="bn_status_second_1"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/status_01.gif" alt="����"  id="bn_status_second" onclick="secondLight(this)"/></b>
		<b id="bn_status_third_1"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/status_01.gif"  alt="����"  id="bn_status_third" /></b>
		<span id="contactingMsg"></span>
		<b id="K042"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k042.gif" alt="����" /></b>
		<b id="K043"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k043.gif" alt="ֹͣ����" /></b>
		<b id="K044"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k044.gif" alt="��ͣ����" /></b>
		<b id="K064"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k064.gif" alt="��������" /></b>
		<b id="K045"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k045.gif" alt="���" /></b>
		<b id="K046"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k046.gif" alt="����" /></b>
		<!--<b id="K057"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k057.gif" alt="��Ƶ����" class="grey"  /></b>
		<b id="K058"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k058.gif" alt="��Ƶֹͣ"  class="grey"  /></b>
		<b id="K059"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k059.gif" alt="��Ƶ��ͣ����"  class="grey"  /></b>
		<b id="K060"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k060.gif" alt="��Ƶ���"  class="grey"  /></b>
		<b id="K061"><img src="<%=request.getContextPath()%>/nresources/default/images/ico_16/img_k061.gif" alt="��Ƶ����"  class="grey"  /></b>-->
	</div>
		<!-- ocx��ʼ������ -->
		<!-- ǩ���ֻ����� -->
		<input type="hidden" id="sign_phone_no" name="sign_phone_no" value="<%=request.getParameter("sign_phone_no")%>"/>
		<!-- �ͷ�������IP��ַ -->
		<input type="hidden" id="mainCCSIp" name="mainCCSIp" value="<%=request.getParameter("mainCCSIp")%>"/>
		<!-- CALLCS mainCCSIp2-BackCcsIP by zwy 20090303-->
		<input type="hidden" id="BackCcsIP" name="BackCcsIP" value="<%=request.getParameter("mainCCSIp2")%>"/>
		
		
		<!-- ��ϯ���� -->
		<input type="hidden" id="agentType" name="agentType" value="<%=request.getParameter("agentType")%>"/>
		
		
		<!-- Ϊ����ͨ����ת����ϯ���غ� -->
		<input type="hidden" id="threePerson" name="threePerson" value=""/>
		<!-- ����ID -->
		<input type="hidden" id="CCSId" name="CCSId" value="<%=request.getParameter("CCSId")%>"/>
		<!-- <input type="hidden" id="CCSId" name="CCSId" value="22"/>-->
		<!-- �ͷ����ű��� kf_longin_no -->
		<!--
		<input type="hidden" id="WorkNo" name="WorkNo" value="<%=request.getParameter("WorkNo")%>"/>
		-->
		<input type="hidden" id="WorkNo" name="WorkNo" value="<%=kf_longin_no%>"/>
		<!-- boss���ű��� -->
		<input type="hidden" id="loginNo" name="loginNo" value="<%=workNo%>"/>
		
		
		<!--�ͷ�(4) �޸�PasswordΪPassword_kf ����boss��ͻ��update by songjia 2010/08/20 begin-->
		<!-- �ͷ����� -->
		<input type="hidden" id="Password_kf" name="Password_kf" value="<%=request.getParameter("p")%>" />
		<!--�ͷ�(4) ȥ�� update by songjia 2010/08/20 begin-->
		
		
		<!-- ��½�ͻ�������IP��ַ -->
		<input type="hidden" id="ipAddress" name="ipAddress" value="<%=request.getRemoteAddr()%>"/>	
		<!-- �Ӵ���ˮ����ÿ�νӴ���ʼʱ���ɣ���һ�νӴ�ֻ����һ����������Ӧ�𡢺���������ת��ʱ����ת�ӷ������ɴ��ݸ����շ��� -->
		<input type="hidden" id="contactId" name="contactId" value=""/>
		<input type="hidden" id="transagent" name="transagent" value=""/>
		<input type="hidden" id="called_no_agent" name="called_no_agent" value=""/>
		<!-- �Ӵ�����ʱ�����£�dcallcallYYYYMM���´洢��Ϊ������½Ӵ�������ܸ�����ȷ�ĽӴ���¼���衣�ڸ���dcallcallYYYYMM���ʱ��YYYYMMӦ��ȡ��ֵ������Ӧ��ȡ����ʱ��ϵͳʱ�� -->
		<input type="hidden" id="contactMonth" name="contactMonth" value=""/>
		<input type="hidden" id="recordfile" name="recordfile" value=""/>
		<!-- �ϴ������ͻ��ֻ����룬���ڱ�������ʱ�ر��ϴ������û���ϸ��Ϣ��Tabҳ -->
		<input type="hidden" id="last_caller_phone" name="last_caller_phone" value=""/>
		<!-- ͨ��������ˮ��ȡ���ָ��±��ּ�¼�Ľ���ʱ��֮�� -->
		<input type="hidden" id="hold_call_id" name="hold_call_id" value=""/>
		<!-- boss���Ź�����֯���� -->
		<input type="hidden" id="orgCode" name="orgCode" value="<%=orgCode %>"/>
		<!-- boss���Ź������б��� -->
		<input type="hidden" id="regionCode" name="regionCode" value="<%=regionCode %>"/>
		<!-- �����־��ˮ -->
		<input type="hidden" id="restId" name="restId" value=""/>
		<!-- �����ж��Ƿ����������¼����������ڲ����������Ļ��ǲ���Ҫ¼���ģ��ڻ�ýӴ���ˮ��ͬʱ���øñ�־ -->
		<input type="hidden" id="recordFlag" name="restId" value="Y"/>
		<!--�ǲ���ѧϰ̬-->
		<input type="hidden" id="loginStatus" name="loginStatus" value="<%=request.getParameter("loginStatus")%>"/>
		
		<input type="hidden" id="recordFileGet" name="recordFileGet" value=""/>
		<!--input type="button" onclick="getContactIdTest()" value="test"/-->	
		<!--��Ǹ�״̬��ˮ��-->
		<input type="hidden" id="oprId" name="oprId" value=""/>
		<!--��ѯ״̬����û�з�������������-->
		<input type="hidden" id="num" name="num" value=""/>
		<!--�����������ݵ�״̬-->
		<input type="hidden" id="oprType" name="oprType" value=""/>
		<!--��¼Ŀ�깤��-->
		<input type="hidden" id="oprObject" name="oprObject" value=""/>
		<!--��¼���ݿ��д洢�ı�����-->
		<input type="hidden" id="staffNoList" name="staffNoList" value=""/>
		<!--��¼������contactId-->
		<input type="hidden" id="lisenContactId" name="lisenContactId" value=""/>
		<!--������IP-->
		<input type="hidden" id="localIp" name="localIp" value="<%=request.getParameter("localIp")%>"/>
		<!--�ʼ�tabҳ���id-----add by hanjc 20090116-->
		<input type="hidden" id="qcTabId" name="qcTabId" value=""/>
		<!--�ͻ�����-----add by lijin 090221-->
		<input type="hidden" id="custName" name="custName" value=""/>	
		<!--��ʱ����֪ͨ���ͽ��-----add by hanjc 20090222-->
		<input type="hidden" id="msgContent" name="msgContent" value=""/>	
		<!--�Ƿ�һ����Ƿ��������̬�ı�ʶ-----add by fangyuan 20090227-->
		<input type="hidden" id="isNeedAdjust" name="isNeedAdjust" value=""/>	
		<input type="hidden" id="extendTime" name="extendTime" value=""/>
		<input type="hidden" id="beforeTime" name="beforeTime" value=""/>	
		<!--��¼�������-----add by fangyuan 20090326-->
		<input type="hidden" id="acceptPhoneNo" name="acceptPhoneNo" value=""/>
		<!--�����м�¼ǰһ��contactId-----add by lijin 20090418-->
		<input type="hidden" id="beforeContactId" name="beforeContactId" value=""/>
		<!--��������userClass-->
		<input type="hidden" id="huaWeiUserClass" name="huaWeiUserClass" value=""/>
		<!--��ǰ����¼���ļ���-----add by tangsong 20100507-->
		<input type="hidden" id="recordFileName" name="recordFileName" value=""/>
		<!--�����������ʡ��-->
		<input type="hidden" id="provice" name="provice" value=""/>			
		<!--�������ı�ʶ-->
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
cCcommonTool.DebugLog("����IP��<%=InetAddress.getLocalHost().getHostAddress()%>");
function getContactIdTest(){
	getContactId();
	callCauseTree();
}

//by hanjc 
//var scan = setInterval("scanNewMsg()",1*5*1000);	                         
 //setInterval("cCcommonTool.getCurrentIEMemUsed()",2000);      
	//��ȡ��֪ͨ
/*function scanNewMsg(){
  var msgContentTemp=document.getElementById("msgContent");
  var msgContent='';
  if(msgContentTemp!=null&&msgContentTemp!=''){
     msgContent=msgContentTemp.value;
  }
  var mypacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_scan_rpc.jsp","ɨ����֪ͨ�����Ժ�......");
  //mypacket.data.add("send_login_no",document.sitechform.send_login_no.value);
  mypacket.data.add("msgContent",msgContent);	
  core.ajax.sendPacket(mypacket,showMsg,true);
	mypacket=null;
}*/

//��ʾ��֪ͨ
/*function showMsg(packet){
	var hasNew = packet.data.findValueByName("hasNew");
	var contentList = packet.data.findValueByName("contentList");
	var last_send_login_no = packet.data.findValueByName("last_send_login_no");
	contentList = contentList.replace(/\+/g,"%2B");
	var msgContent = packet.data.findValueByName("msgContent");	
	//alert(hasNew);
	if(parseInt(hasNew)>0&&trim(contentList).length>2){
	 //if(rdShowConfirmDialog("����"+hasNew+"����֪ͨ����Ҫ�鿴��")=="1"){
	  //openWinMid("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_showNewMsg.jsp?contentList="+contentList,"��֪ͨ",240, 480);
	  
	  var receive_login_no = '';
	  if(showMsg_temp!=''&&!showMsg_temp.closed){
	  	similarMSNPop("����"+hasNew+"����֪ͨ");
	  	showMsg_temp.setContentVal2(contentList);
	  }else{
	  	showMsg_temp=openWinMid("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_commNoteRecSend.jsp?msgContent="+msgContent+"&last_send_login_no="+last_send_login_no,"��֪ͨ",480, 640);
	  }
	  if(showMsg_temp!=""){
	    updateCfm();
	    //showMsg_temp="";
	  }
	 //}
	}
}*/

/*function updateCfm(){
	//if(rdShowConfirmDialog("�´β�����ʾ��֪ͨ��")=="1"){
	  var mypacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/K084/K084_update_msgIsRead_rpc.jsp","���ڸ���֪ͨ�����Ժ�......");
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

/*function openWinMid(url,name,iHeight,iWidth)
{
  //var url; //ת����ҳ�ĵ�ַ;
  //var name; //��ҳ���ƣ���Ϊ��;
  //var iWidth; //�������ڵĿ��;
  //var iHeight; //�������ڵĸ߶�;
  var iTop = (window.screen.availHeight-30-iHeight)/2; //��ô��ڵĴ�ֱλ��;
  var iLeft = (window.screen.availWidth-10-iWidth)/2; //��ô��ڵ�ˮƽλ��;
  return window.open(url,name,'height='+iHeight+',innerHeight='+iHeight+',width='+iWidth+',innerWidth='+iWidth+',top='+iTop+',left='+iLeft+',scrollbars=auto, resizable=no,location=no, status=yes');
}	*/
//ͨѶ��⹦�� by zwy
function scanCom(){
 var mypacket = new AJAXPacket("<%=request.getContextPath()%>/npage/callbosspage/config/K101_scan_rpc.jsp?login_no=<%=workNo%>","ͨѶɨ�裬���Ժ�......");
  core.ajax.sendPacket(mypacket,retScanCom,true);
	mypacket=null;
}
function retScanCom(){

}

var intervalScanCom = setInterval("scanCom()",60000);	

-->
</script>