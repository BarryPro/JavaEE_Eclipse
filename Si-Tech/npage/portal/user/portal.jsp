<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/common/portalInclude.jsp" %>

<%
String activePhone = request.getParameter("activePhone");
//防止快捷键过快 冲掉了正确的session的activePhone
if(activePhone==null||activePhone.equals(""))
{
	out.println("手机号码信息不正确,请重新输入");
	return;
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>用户首页</title>
		 <script type="text/javascript" src="../../../njs/extend/jquery/portalet/jquery114_pack.js"></script>
		 <script type="text/javascript" src="../../../njs/extend/jquery/portalet/interface_pack.js"></script>
		 <script type="text/javascript" src="/njs/si/core_sitech_pack.js"></script>	
	   <script language="JavaScript" src="/njs/si/validate_pack.js"></script>
		 <script type="text/javascript" src="/njs/extend/jquery/jquery.form.js"></script>
		 <script language="javascript" type="text/javascript" src="/njs/si/autocomplete.js"></script>
	   <script language="javascript" type="text/javascript" src="/njs/si/common.js"></script>
		 <link href="../../../nresources/default/css/portalet.css" rel="stylesheet" type="text/css">
		 <link href="../../../nresources/default/css/font_color.css" rel="stylesheet" type="text/css">
<%@ include file="/npage/include/public_hotkey.jsp" %>
	<style>
	html,
	body
	{
		_overflow-x:hidden;
	}
	</style>

</head>
<body>
<!--浮动菜单-->
<div class="menu" id=floater onFocus=this.blur()>
<ul>
	<li class="white"><a href="#this">选择面板内容<!--[if IE 7]><!--></a><!--<![endif]-->
		<table>
			<tr>
				<td>
					<ul>
						<li><a><input class="set" type="checkbox" style='cursor:hand' checked id="div1" >服务开通</a></li>
						<li><a><input class="set" type="checkbox" style='cursor:hand' checked id="div2" >常用功能</a></li>
						<li><a><input class="set" type="checkbox" style='cursor:hand' checked id="div3" >业务推荐</a></li>
						<li><a><input class="set" type="checkbox" style='cursor:hand' checked id="div4" >资源占用</a></li>
						<li><a class="last"><input class="set" type="checkbox" style='cursor:hand' checked id="div5" >产品信息</a></li>
					</ul>
				</td>
			</tr>
		</table>
	<!--[if lte IE 6]></a><![endif]-->
	</li>
</ul>
</div>
<br>

<!--固定主面板-->
<div class="Info">
   <div class="groupItem_no">
		 <div class="itemHeader">
		   <div id="zi">基本信息</div>
		 </div>
     <div id="blueBG">
       <div  id="custDocMsg">
			 	 <div id="wait1"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>
			 </div>
	   </div>
   </div>
</div>

<!--营销管理面板展示-->
<div class="Info">
   <div class="groupItem_no">
		 <div class="itemHeader">
		   <div id="zi">营销活动推荐</div>
		 </div>
     <div id="blueBG">
       <div id="introduceMsg">
					<div id="wait1"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>	
			 </div>
	   </div>
   </div>
</div>

<!--主面板-->
<div id="sort1" class="groupWrapper">

		<div id="div1_show" class="groupItem">
			<div class="itemHeader">
				<div id="zi">特服开通</div>
				<DIV id="tu">
				   <div id="sub">
						 <div class="li"><img id="div1_switch" class="closeEl" src="../../../nresources/default/images/jia.gif" style='cursor:hand' width="15" height="15"></div>
						 <div class="li"><img class="hideEl" src="../../../nresources/default/images/cha.gif"   style='cursor:hand' width="15" height="15"></div>
				   </div>
				</DIV>
			</div>
			<div class="itemContent" id="serviceMsg">
				<div id="wait2"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>
			</div>
	  </div>


		<div id="div2_show" class="groupItem">
			<div class="itemHeader">
				<div id="zi">常用功能</div>
					<DIV id="tu">
					   <div id="sub">
							 <div class="li"><img id="div2_switch" class="closeEl" src="../../../nresources/default/images/jia.gif" style='cursor:hand' width="15" height="15"></div>
							 <div class="li"><img class="hideEl" src="../../../nresources/default/images/cha.gif"   style='cursor:hand' width="15" height="15"></div>
					   </div>
					</DIV>
				</div>
			<div class="itemContent"   id="funSel">
			   <div id="wait3"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>	
		  </div>
	  </div>
	  
		
		<div id="div3_show" class="groupItem">
			<div class="itemHeader">
				<div id="zi">业务推荐</div>
					<DIV id="tu">
					   <div id="sub">
							 <div class="li"><img id="div5_switch" class="closeEl" src="../../../nresources/default/images/jia.gif" style='cursor:hand' width="15" height="15"></div>
							 <div class="li"><img class="hideEl" src="../../../nresources/default/images/cha.gif"   style='cursor:hand' width="15" height="15"></div>
					   </div>
					</DIV>
				</div>
				<div class="itemContent" id="introduce">
					
				</div>
		</div>
	
	
</div>

<div id="sort2" class="groupWrapper">
	
	
	<div id="div4_show" class="groupItem">
		<div class="itemHeader">
			<div id="zi">资源占用</div>
			<DIV id="tu">
			   <div id="sub">
				 <div class="li"><img id="div3_switch" class="closeEl" src="../../../nresources/default/images/jia.gif" style='cursor:hand' width="15" height="15"></div>
				 <div class="li"><img class="hideEl" src="../../../nresources/default/images/cha.gif"   style='cursor:hand' width="15" height="15"></div>
			   </div>
			</DIV>
			</div>
			<div class="itemContent"  id="source">
			   <div id="wait4"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>	
			</div>
	</div>
	

	<div id="div5_show" class="groupItem">
		<div class="itemHeader">
			<div id="zi">资费信息</div>
			<DIV id="tu">
			   <div id="sub">
					 <div class="li"><img id="div4_switch" class="closeEl" src="../../../nresources/default/images/jia.gif" style='cursor:hand' width="15" height="15"></div>
					 <div class="li"><img class="hideEl" src="../../../nresources/default/images/cha.gif"   style='cursor:hand' width="15" height="15"></div>
					</div>
				</DIV>
		</div>
		<div class="itemContent"  id="product">
		     <div id="wait5"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>	
		</div>
	</div>

	</div>	
<p></p>


<script type="text/javascript">
	
	var _jspPage = 
	{"div1_switch":["serviceMsg","fserviceMsg.jsp?activePhone=<%=activePhone%>","f"]
	,"div2_switch":["funSel","ffunc_sel.jsp?activePhone=<%=activePhone%>","f"]
	,"div3_switch":["source","fsource_sel.jsp?activePhone=<%=activePhone%>","f"]
	,"div4_switch":["product","fproduct_sel.jsp?activePhone=<%=activePhone%>","f"]
	,"div5_switch":["introduce","","f"]
	};
	
	function hiddenSpider()
	{
		document.getElementById("serviceMsg").style.display='none';
		document.getElementById("funSel").style.display='none';
		document.getElementById("source").style.display='none';
		document.getElementById("product").style.display='none';
		document.getElementById("introduce").style.display='none';
	}


$(document).ready(function (){
		
		hiddenSpider();
		
		$('.set').bind('click',hiden);
		
		$('img.closeEl').bind('click', toggleContent);

		$('img.hideEl').bind('click', hideContent);
		
		$('div.groupWrapper').Sortable(
			{
				accept: 'groupItem',
				helperclass: 'sortHelper',
				activeclass : 	'sortableactive',
				hoverclass : 	'sortablehover',
				handle: 'div.itemHeader',
				opacity: 0.7,
				tolerance: 'intersect',
				onChange : function(ser)
				{
				},
				onStart : function()
				{
					$.iAutoscroller.start(this, document.getElementsByTagName('body'));
				},
				onStop : function()
				{
					$.iAutoscroller.stop();
				}
			}
		);
		
	});

var hiden = function()
{
	//被选中
	if(this.checked)
	{
		if(this.id=="div1")
		{
			$("#div1_show").show();
		}else if(this.id=="div2")
		{
			$("#div2_show").show();
		}else if(this.id=="div3")
		{
			$("#div3_show").show();
		}else if(this.id=="div4")
		{
			$("#div4_show").show();
		}else if(this.id=="div5")
		{
			$("#div5_show").show();
		}
	}
	else//取消选中
	{
		if(this.id=="div1")
		{
			$("#div1_show").hide();
		}if(this.id=="div2")
		{
			$("#div2_show").hide();
		}else if(this.id=="div3")
		{
			$("#div3_show").hide();
		}else if(this.id=="div4")
		{
			$("#div4_show").hide();
		}else if(this.id=="div5")
		{
			$("#div5_show").hide();
		}
	}
};

var hideContent = function(e)
{
	var targetContent = $(this.parentNode.parentNode.parentNode.parentNode.parentNode);
	targetContent.hide();
	
	var div_id = $(this.parentNode.parentNode.parentNode.parentNode.parentNode).attr('id');
	
	if(div_id=="div1_show")
	{
		$("#div1").attr({checked:false});
	}else if(div_id=="div2_show")
	{
		$("#div2").attr({checked:false});
	}else if(div_id=="div3_show")
	{
		$("#div3").attr({checked:false});
	}else if(div_id=="div4_show")
	{
		$("#div4").attr({checked:false});
	}else if(div_id=="div5_show")
	{
		$("#div5").attr({checked:false});
	}
	
};

var toggleContent = function(e)
{
	var targetContent = $('DIV.itemContent', this.parentNode.parentNode.parentNode.parentNode.parentNode);
	if (targetContent.css('display') == 'none') {
		targetContent.slideDown(300);
		$(this).attr({ src: "../../../nresources/default/images/jian.gif"}); 
		//调用服务
		try{
			var tmp = $(this).attr('id');
			var tmp2 = eval("_jspPage."+tmp);
			//alert(tmp2[2]);
			if(tmp2[2]=="f"&&tmp2[1]!=''&&tmp2[1]!=undefined)
			{
				$("#"+tmp2[0]).load(tmp2[1]);
				tmp2[2]="t";
			}
		}catch(e)
		{
		}
		
	} else {
		targetContent.slideUp(300);
		$(this).attr({ src: "../../../nresources/default/images/jia.gif"}); 
	}
	return false;
};
  
  $("#custDocMsg").load("fcustMsg.jsp?activePhone=<%=activePhone%>");
  $("#introduceMsg").load("fsale_sel.jsp?activePhone=<%=activePhone%>");
 
</script>
</body>
</html>

