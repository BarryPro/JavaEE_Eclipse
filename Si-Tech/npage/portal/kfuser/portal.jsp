<% //�޸��� xingzhan 20090225 ���һ���������ڰ�ť %>

<%
   /*
   * �޸���ʷ
   * �޸����� 2009-05-13     �޸���  libina     �޸�Ŀ��  �ı�ģ���˳��
   * �޸����� 2009-05-13     �޸���  libina     �޸�Ŀ��  ����Сģ����������SP�˶���ѯ�ͷ���ͨ�����õ�����
   * �޸����� 2009-05-29     �޸���  zhangwy    �޸�Ŀ��  ��ready����Ľ�ɨ�����ȥ����ֱ��д������ϡ�
 ��*/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
  String phoneNo = (String)session.getAttribute("activePhone");
%>
<html> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title>�û���ҳ</title>
     <script type="text/javascript" src="/njs/si/core_sitech_pack.js"></script>	
		 <script language="JavaScript" src="/njs/si/validate_pack.js"></script>
		 <script language="javascript" type="text/javascript" src="/njs/si/autocomplete.js"></script>
	   <script language="javascript" type="text/javascript" src="/njs/si/common.js"></script>
		 <link href="../../../nresources/default/css/portalet.css" rel="stylesheet" type="text/css">
		 <link href="../../../nresources/default/css/font_color.css" rel="stylesheet" type="text/css">
<style>
	html,
	body,
	iframe
	{
		_overflow-x:hidden;
	}
	
	.ctl{
	   table-layout:fixed
	}
	.ctl td{text-overflow:ellipsis;overflow:hidden;white-space:nowrap;padding:2px}
	
</style> 
</head>
<body>
<!--�̶������-->
<div class="Info">
   <div class="groupItem_no">
		 <div class="itemHeader">
		   <div id="zi">������Ϣ</div>
		   <DIV id="tu">
			   <DIV id="sub">
		     <DIV class="li"><img id="custDocMsg_reload" extend_attr="custDocMsg" onclick="func_reload(this);return false;" src="../../../nresources/default/images/f5.gif" title="ˢ��"  style='cursor:hand' ></DIV>    
			  </DIV>
			</DIV>
		 </div>
     <div id="blueBG">
       <div  id="custDocMsg">
       	<!--
			 	 <div id="wait1"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>
			 -->
			 <iframe id="custDocMsg_framer" name="custDocMsg_framer" scrolling="no" src="fcustMsg.jsp" width=100% height=310 frameBorder=0 marginheight=0 marginwidth=0 ></iframe>	
			 </div>
	   </div>
   </div>
</div>

<!--�����-->
<div id="sort1" class="groupWrapper">
  <div id="div13_show" class="groupItem">
	   <div class="itemHeader">
			<div id="zi">�ʻ���������</div>
			<DIV id="tu">
			   <div id="sub">
			   	<DIV class="li"><img id="KFConInfo_reload" extend_attr="KFConInfo" onclick="func_reload(this);return false;"src="../../../nresources/default/images/f5.gif" title="ˢ��"  style='cursor:hand' ></DIV>    
				 	<div class="li"><img id="KFConInfo_closeEl" extend_attr="KFConInfo" onclick="upAndDown(this);return false;" class="closeEl" src="../../../nresources/default/images/jia.gif" title="���" style='cursor:hand' width="15" height="15"></div>
				 	<div class="li"><img id="fKFConInfo" extend_attr="KFConInfo" onclick= "openBigPage(this);return false;" src="../../../nresources/default/images/CS.gif" style='cursor:hand' ></div>
				 	<!--
				 	<div class="li"><img id="KFConInfo_hideEl" extend_attr="KFConInfo"class="hideEl"  src="../../../nresources/default/images/cha.gif"   title="�ر�" style='cursor:hand' width="15" height="15"></div>			  	
			    -->
			   </div>
			</DIV>
			</div>
			<div class="KFConInfo_itemContent"style="display:none"  id="KFConInfo">
				<!--
			   <div id="wait13"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>	
	      -->
	      	<iframe id="KFConInfo_framer" name="KFConInfo_framer" scrolling=auto src="#" width=100% height=200 frameBorder=0 marginheight=0 marginwidth=0 ></iframe>	
			</div>
  </div>
  
<div id="div9_show" class="groupItem" >
  <div class="itemHeader">
			<div id="zi">SP�˶���ѯ</div>
			<DIV id="tu">
			   <div id="sub"> 
			   <DIV class="li"><img id="spInfo_reload" extend_attr="spInfo" onclick="func_reload(this);return false;"src="../../../nresources/default/images/f5.gif" title="ˢ��"  style='cursor:hand' ></DIV>    
				 <div class="li"><img id="spInfo_closeEl" extend_attr="spInfo" onclick="upAndDown(this);return false;" class="closeEl" src="../../../nresources/default/images/jia.gif" title="���"  style='cursor:hand' width="15" height="15"></div>
				 <div class="li"><img id="fspInfo" extend_attr="spInfo" onclick= "openBigPage(this);" src="../../../nresources/default/images/CS.gif" style='cursor:hand' ></div>
				 <!--
				 <div class="li"><img id="spInfo_sel"extend_attr="spInfo"class="hideEl" src="../../../nresources/default/images/cha.gif"  title="�ر�"  style='cursor:hand' width="15" height="15"></div>		 
			   -->
			   </div>
			</DIV>
			</div>
			<div class="itemContent" style="display:none"  id="spInfo">
	      <!--
	       <div id="wait9" ><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>
			  -->
			   <iframe id="spInfo_framer" name="spInfo_framer" scrolling=auto src="#" width="100%" height="245" frameBorder=0 marginheight=0 marginwidth=0 ></iframe>			
			</div>	
</div>

<div id="div11_show" class="groupItem">
   <div class="itemHeader">
			<div id="zi">��ͻ�������Ϣ</div>
			<DIV id="tu">
			   <div id="sub">
			   <DIV class="li"><img id="bigQuery_reload" extend_attr="bigQuery" onclick="func_reload(this);return false;" src="../../../nresources/default/images/f5.gif" title="ˢ��"  style='cursor:hand' ></DIV>    
				 <div class="li"><img id="bigQuery_closeEl" extend_attr="bigQuery" onclick="upAndDown(this);return false;"class="closeEl" src="../../../nresources/default/images/jia.gif" title="���"  style='cursor:hand' width="15" height="15"></div>
				 <div class="li"><img id="fbigQuery" extend_attr="bigQuery" onclick= "openBigPage(this);" src="../../../nresources/default/images/CS.gif" style='cursor:hand' ></div>
				 <!--
				 <div class="li"><img id="bigQuery_hideEl" extend_attr="bigQuery"class="hideEl" src="../../../nresources/default/images/cha.gif"  title="�ر�"  style='cursor:hand' width="15" height="15"></div>
			   -->
			   </div>
			</DIV>
			</div>
			<div class="itemContent"  style="display:none" id="bigQuery">
				<!--
	       <div id="wait11"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>
			  -->
			  <iframe id="bigQuery_framer" name="bigQuery_framer" scrolling=auto src="#" width=100% height=200 frameBorder=0 marginheight=0 marginwidth=0 ></iframe>	
			</div>
		
</div>
	
 <div id="div14_show" class="groupItem" >
     <div class="itemHeader">
				<div id="zi">���Ѽ��</div>
				<DIV id="tu">
				   <div id="sub">
				   	 <div class="li"><img id="KF_AllFee_closeEl" extend_attr="KF_AllFee"onclick="upAndDown(this);return false;"class="closeEl" src="../../../nresources/default/images/jia.gif" title="���"  style='cursor:hand' width="15" height="15"></div>
						 <div class="li"><img id="fKF_AllFee" extend_attr="KF_AllFee"onclick= "openBigPage(this);" src="../../../nresources/default/images/CS.gif" style='cursor:hand' ></div>
						<!--
						 <div class="li"><img id="KF_AllFee_hideEl" extend_attr="KF_AllFee"class="hideEl" src="../../../nresources/default/images/cha.gif"  title="�ر�"  style='cursor:hand' width="15" height="15"></div>						
				    -->
				   </div>
				</DIV>
			</div>
			<div class="itemContent"  style="display:none" id="KF_AllFee">
				<!--
	       <div id="wait14"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>
			  -->
			  <iframe id="KF_AllFee_framer" name="KF_AllFee_framer" scrolling=auto src="#" width=100% height=200 frameBorder=0 marginheight=0 marginwidth=0 ></iframe>	
		
			</div>		
	</div>	
	
  
</div>

<div id="sort2" class="groupWrapper">
  <div id="div5_show" class="groupItem">
	   <div class="itemHeader">
			<div id="zi">��Ʒ��Ϣ</div>
			<DIV id="tu">
			   <div id="sub">
			   	      
			     <DIV class="li"><img id="product_reload" extend_attr="product" onclick="func_reload(this);return false;" src="../../../nresources/default/images/f5.gif" title="ˢ��"  style='cursor:hand' ></DIV>    
					 <div class="li"><img id="product_closeEl"extend_attr="product" onclick="upAndDown(this);return false;" class="closeEl" src="../../../nresources/default/images/jia.gif" title="���"  style='cursor:hand' width="15" height="15"></div>
					 <div class="li"><img id="fproduct_sel" extend_attr="product" onclick= "openBigPage(this);return false;" src="../../../nresources/default/images/CS.gif" style='cursor:hand' ></div>
					 <!--
					 <div class="li"><img class="product_hideEl"extend_attr="product"  src="../../../nresources/default/images/cha.gif"  title="�ر�"   style='cursor:hand' width="15" height="15"></div>				
					-->
					</div>
				</DIV>
		</div>
		<div class="product_itemContent" style="display:none"  id="product">
			<!--
		     <div id="wait5"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>	
		   -->
		  <iframe id="product_framer" name="product_framer" scrolling=auto src="#" width=100% height=200 frameBorder=0 marginheight=0 marginwidth=0 ></iframe> 
		</div>
	</div>
	
	 <div id="div1_show" class="groupItem">
			<div class="itemHeader">
				<div id="zi">����ͨ</div>
				<DIV id="tu">
				   <div id="sub"> 
				   	 <DIV class="li"><img id="serviceMsg_reload" extend_attr="serviceMsg" onclick="func_reload(this);return false;" src="../../../nresources/default/images/f5.gif" title="ˢ��"  style='cursor:hand' ></DIV>    
						 <div class="li"><img id="serviceMsg_closeEl" extend_attr="serviceMsg" onclick="upAndDown(this);return false;"class="closeEl" src="../../../nresources/default/images/jia.gif" title="���"  style='cursor:hand' width="15" height="15"></div>
						 <div class="li"><img id="fserviceMsg" extend_attr="serviceMsg" onclick= "openBigPage(this);" src="../../../nresources/default/images/CS.gif" style='cursor:hand' ></div>
						 <!--
						 <div class="li"><img id="serviceMsg_hideEl"extend_attr="serviceMsg"class="hideEl" src="../../../nresources/default/images/cha.gif"  title="�ر�"  style='cursor:hand' width="15" height="15"></div>
				  		-->
				   </div>
				</DIV>
			</div>
			<div class="itemContent" style="display:none" id="serviceMsg">
				<!--
				<div id="wait2"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>
			  -->
			  <iframe id="serviceMsg_framer" name="serviceMsg_framer" scrolling=auto src="#" width=100% height=245 frameBorder=0 marginheight=0 marginwidth=0 ></iframe> 
	
			</div>
  </div>
	
	<div id="div16_show" class="groupItem">
	   <div class="itemHeader">
				<div id="zi">Ͷ�߽���</div>
				<DIV id="tu">
				   <div id="sub"> 
						 <div class="li"><img id="comAdvice_closeEl" extend_attr="comAdvice" onclick="upAndDown(this);return false;"class="closeEl" src="../../../nresources/default/images/jia.gif" title="���"  style='cursor:hand' width="15" height="15"></div>
						 <div class="li"><img id="fcomAdvice" extend_attr="comAdvice" onclick= "openBigPage(this);" src="../../../nresources/default/images/CS.gif" style='cursor:hand' ></div>
						 <!--
						 <div class="li"><img id="comAdvice_hideEl"extend_attr="comAdvice" class="hideEl" src="../../../nresources/default/images/cha.gif"  title="�ر�"  style='cursor:hand' width="15" height="15"></div>				  
				     -->
				   </div>
				</DIV>
			</div>
			<div class="itemContent" style="display:none" id="comAdvice">
				<!--
				<div id="wait16"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>	
        -->
        <iframe id="comAdvice_framer" name="comAdvice_framer" scrolling=auto src="#" width=100% height=200 frameBorder=0 marginheight=0 marginwidth=0 ></iframe> 
      </div>		
	</div>
	
	<div id="div7_show" class="groupItem">
    <div class="itemHeader">
			<div id="zi">������������</div>
			<DIV id="tu">
			   <div id="sub"> 	
			   <DIV class="li"><img id="KFOrgInfo_reload" extend_attr="KFOrgInfo" onclick="func_reload(this);return false;"src="../../../nresources/default/images/f5.gif" title="ˢ��"  style='cursor:hand' ></DIV>    
				 <div class="li"><img id="KFOrgInfo_closeEl" extend_attr="KFOrgInfo" onclick="upAndDown(this);return false;"class="closeEl" src="../../../nresources/default/images/jia.gif" title="���" style='cursor:hand' width="15" height="15"></div>
				 <div class="li"><img id="fKFOrgInfo" extend_attr="KFOrgInfo" onclick= "openBigPage(this);" src="../../../nresources/default/images/CS.gif" style='cursor:hand' ></div>
				 <!--
				 <div class="li"><img id="KFOrgInfo_hideEl" extend_attr="KFOrgInfo"class="hideEl" src="../../../nresources/default/images/cha.gif"   title="�ر�" style='cursor:hand' width="15" height="15"></div>			  
			   -->
			   </div>
			</DIV>
			</div>
			<div class="itemContent" style="display:none"  id="KFOrgInfo">
				<!--
			   <div id="wait7"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30"></div>	
			  -->
			  <iframe id="KFOrgInfo_framer" name="KFOrgInfo_framer" scrolling=auto src="#" width=100% height=200 frameBorder=0 marginheight=0 marginwidth=0 ></iframe> 
     
			</div>
	</div>
	
	
</div>
<form name="par_form">
</form>	
<script>
  var loadHash = new Object();
  loadHash["#custDocMsg"] = "fcustMsg.jsp";
  loadHash["#serviceMsg"] = "fserviceMsg.jsp";
  loadHash["#funSel"] = "ffunc_sel.jsp";
  loadHash["#source"] = "fsource_sel.jsp";
  loadHash["#product"] = "fproduct_sel.jsp";
  loadHash["#accuGetEvInfo"] = "fgetEvInfo.jsp";
  loadHash["#accuSellCust"] = "faccuSellCust.jsp";
  loadHash["#accuGetImei"] = "faccuGetImei.jsp";
  loadHash["#bigQuery"] = "fbigQuery.jsp";
  loadHash["#KFConInfo"] = "fKFConInfo.jsp";
  loadHash["#KF_AllFee"] = "fKF_AllFee.jsp";
  loadHash["#PayInfo"] = "fPayInfo.jsp";
  loadHash["#comAdvice"] = "fcomAdvice.jsp";
  loadHash["#complainInfo"] = "fcomplainInfo.jsp";
  loadHash["#KFOrgInfo"] = "fKFOrgInfo.jsp";
  loadHash["#spInfo"] = "fspInfo.jsp";
  //����
  function upAndDown(ob){
  	
  	var ext_id=ob.getAttribute("extend_attr");
  	var par_ob=document.getElementById(ext_id);
  	if(par_ob.style.display=='none'){
  		ob.src="../../../nresources/default/images/jian.gif";
  		par_ob.style.display="block";
  		document.forms[0].action=loadHash['#'+ext_id]
  		document.getElementById(ext_id+'_framer').style.display="block"
  		document.forms[0].target=ext_id+'_framer'
  		document.forms[0].submit();
  	}else{
  		ob.src="../../../nresources/default/images/jia.gif";
  		par_ob.style.display="none";
    }	
  }
  
  /*���ٽɷ�*/

function loading(){
}

function unLoading(){
}
	//by xingzhan 20090225 �����󴰿ڣ���Ϣ��ͬһ���󴰿�����ʾ
	var big_Opener;
	function openBigPage(value){
		
		var big_Url = "allbigpage.jsp";
		var id = value.id;
		//alert(id);
		//alert(big_Opener);
		if(big_Opener==null){
				//alert("1");
				
				big_Opener = window.open(big_Url+"?id="+id,'','scrollbars=yes, resizable=yes,location=no, status=yes' );
		}else{
				//alert("2");
				try{
						big_Opener.document.body.focus();
						//alert("3");
						big_Opener.location.href(big_Url+"?id="+id);
			  }catch(e){
			  		//alert("4");
			  		big_Opener = window.open(big_Url+"?id="+id,'','scrollbars=yes, resizable=yes,location=no, status=yes' );
			  }
				
		}
	}
function showPageInfo(tagUrl)
{
	// xingzhan 20090220 ; ��Ϊ���Ը��Ĵ��ڴ�С;
	window.open(tagUrl,'','scrollbars=yes, resizable=yes,location=no, status=yes' );
}
function func_reload(ob){
	  var ext_id=ob.getAttribute("extend_attr");
	  var par_ob=document.getElementById(ext_id);
  	if(par_ob.style.display!='none'){
  	 document.forms[0].action=loadHash['#'+ext_id]
  	 document.forms[0].target=ext_id+'_framer'
  	 document.forms[0].submit();
    }
}	
</script>
</body>
</html>
