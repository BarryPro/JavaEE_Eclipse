<%
   /*
   * 功能: 问题反馈
　 * 版本: v1.0
　 * 日期: 2008年10月25日
　 * 作者: piaoyi
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd>
<HTML xmlns="http://www.w3.org/1999/xhtml">
<%@ taglib uri="weblogic-tags.tld" prefix="wl" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
  response.setDateHeader("Expires", 0);
  String opCode="";
  String opName="集团客户扩展信息";
  String sqlStr="";
%>
<HTML>
<HEAD>
<link href="<%=request.getContextPath()%>/css/jl.css" rel="stylesheet" type="text/css">
<link href="s2002.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY>
<div id="Main">
<DIV id="Operation_Table">
 <div class="title"><div id="title_zi">扩展信息</div></div> 
 <input type="hidden" id="p_CustomerProvinceNumber" value="">
 <input type="hidden" id=p_Action value="">
 <!--取流水 页面为新增时使用 页面若为更新,用传入数据覆盖-->
 <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="01"  id="seq"/>
 <input type="hidden" id="p_ExtInfoAcceptID" value="<%=seq%>">
 <table>
  <tr>
   <td>
     IT部门名称
   </td>
   <td>
    <input id="p_ITDeptName" type="string" size="20" maxlength="20"><font class="orange">*</font>
   </td>
   <td>
   是否有IT部门
   </td>
   <td>
     <select align="left" id="p_HasITDept" width=50>
         <%sqlStr ="select detail_code, detail_name from sbbossListCode where list_code = 'FlagYN' order by detail_order ";%>
         <wtc:qoption name="sPubSelect" outnum="2">
         <wtc:sql><%=sqlStr%></wtc:sql>
         </wtc:qoption>
     </select>
   </td>
 	</tr>
  <tr>
   <td>
     是否有专属资费方案
   </td>
   <td>
     <select align="left" id="p_FeeCase" width=50>
         <%sqlStr ="select detail_code, detail_name from sbbossListCode where list_code = 'FlagYN' order by detail_order ";%>
         <wtc:qoption name="sPubSelect" outnum="2">
         <wtc:sql><%=sqlStr%></wtc:sql>
         </wtc:qoption>
     </select>
   </td>
  	<td>
   	资费套餐内容
   </td>
   <td>
 	  <input id="p_FeeCaseInfo" type="string" size="20" maxlength="20">
   </td>
 	</tr>
 	<tr>
   	<td>
     	平均收入
     </td>
     <td>
       <input id="p_ARPU" type="0_9" size="20" maxlength="10">
     </td>
   	<td>
     	平均数据业务收入
     </td>
     <td>
       <input id="p_DataARPU" type="0_9" size="20" maxlength="10">
     </td>
 	</tr>
 	<tr >
   	<td>
     	员工月平均话费
     </td>
     <td>
       <input id="p_AvgFee" type="0_9" size="20" maxlength="10">
     </td>
   	<td>
     	话费月报销额度
     </td>
     <td>
       <input id="p_Quota" type="0_9" size="20" maxlength="10">
     </td>
 	</tr>
 	<tr >
   	<td>
     	话费报销方式
     </td>
     <td>
         <select align="left" id="p_RewardType" width=50>
             <%sqlStr ="select detail_code, detail_name from sbbossListCode where list_code = 'RewardType' order by detail_order ";%>
             <wtc:qoption name="sPubSelect" outnum="2">
             <wtc:sql><%=sqlStr%></wtc:sql>
             </wtc:qoption>
         </select>
     </td>
   	<td>
     	是否使用联通话音业务
     </td>
     <td>
         <select align="left" id="p_UnicomTone" width=50>
             <%sqlStr ="select detail_code, detail_name from sbbossListCode where list_code = 'FlagYN' order by detail_order ";%>
             <wtc:qoption name="sPubSelect" outnum="2">
             <wtc:sql><%=sqlStr%></wtc:sql>
             </wtc:qoption>
         </select>
     </td>
 	</tr>
 	<tr >
   	<td>
     	是否使用联通数据业务
     </td>
     <td>
         <select align="left" id="p_UnicomData" width=50>
             <%sqlStr ="select detail_code, detail_name from sbbossListCode where list_code = 'FlagYN' order by detail_order ";%>
             <wtc:qoption name="sPubSelect" outnum="2">
             <wtc:sql><%=sqlStr%></wtc:sql>
             </wtc:qoption>
         </select>
     </td>
   	<td>
     	未来变化趋势
     </td>
     <td>
       <input id="p_Trends" type="string" size="20" maxlength="128">
     </td>
 	</tr>
 	<tr >
   	<td>
     	中国移动手机数
     </td>
     <td>
       <input id="p_MobileUser" type="0_9" size="20" maxlength="8">
     </td>
   	<td>
     	中国移动手机用户比例
     </td>
     <td>
       <input id="p_MobileRate" type="string" size="20" maxlength="4">
     </td>
 	</tr>
 	<tr >
   	<td>
     	对信息化的需求程度
     </td>
     <td>
       <input id="p_Informationize" type="string" size="20" maxlength="128">
     </td>
   	<td>
     	对信息化集成的需求程度
     </td>
     <td>
       <input id="p_Intergration" type="string" size="20" maxlength="128">
     </td>
 	</tr>
 	<tr >
   	<td>
     	对行业终端定制的需求程度
     </td>
     <td>
       <input id="p_Terminal" type="string" size="20" maxlength="128">
     </td>
   	<td>
     	对跨省一体化实施能力的需求
     </td>
     <td>
       <input id="p_TransProv" type="string" size="20" maxlength="128">
     </td>
 	</tr>
 	<tr >
   	<td>
     	对一点账单结算的需求
     </td>
     <td>
       <input id="p_SinglePay" type="string" size="20" maxlength="128">
     </td>
   	<td>
     	对MAS的需求程度
     </td>
     <td>
       <input id="p_Mas" type="string" size="20" maxlength="128">
     </td>
 	</tr>
 </table>
 <br>
 <DIV id="div1_show"   class="groupItem">
   <DIV class="title">
     <DIV id="zi"><img id="div1_switch" class="closeEl" src="../../../nresources/default/images/jia.gif" style='cursor:hand' width="15" height="15"></DIV>
   	 <DIV id="zi0">中国移动信息化产品</DIV>
   </DIV>
   <DIV class="itemContent" id="mydiv1">
	 	  <DIV id="wait1"><img src="/nresources/default/images/protalloading.gif"  width="150" height="30">
	 	  </DIV>
   </DIV>
</DIV>
<table>
  <tr>
    <td align="center" id="footer" colspan="4">
			 <input class="b_foot" id="confirm" type=button value="确认" onClick="">

    </td>
  </tr>
</table>
</div>
</div>
<script type="text/javascript">
	var retArray = new Array(2);
	var deleteArray;
	var extInfo;//传递参数数组(可以被列表页面访问)
	//var CMCCPrdListCheck;//列表是否被加载(全局)
	
	var CMCCPrdListArray;//列表数据数组(可以被列表页面访问)	
	var _jspPage =
	{"div1_switch":["mydiv1","f2002_CMCCPrd_list.jsp","f"]
	};                   //列表页面
  
	function hiddenSpider()
	{
		document.getElementById("mydiv1").style.display='none';
	}
	
	

  $(document).ready(function () {
  		//隐藏进度条  		
  		hiddenSpider();    					
  	  extInfo=window.dialogArguments;  	        
      $("#p_HasITDept").val(extInfo[0]);                                                          
      $("#p_ITDeptName").val(extInfo[1]);
      $("#p_FeeCase").val(extInfo[2]);
      $("#p_FeeCaseInfo").val(extInfo[3]);
      $("#p_ARPU").val(extInfo[4]);
      $("#p_DataARPU").val(extInfo[5]);
      $("#p_AvgFee").val(extInfo[6]);
      $("#p_Quota").val(extInfo[7]);
      $("#p_RewardType").val(extInfo[8]);
      $("#p_UnicomTone").val(extInfo[9]);
      $("#p_UnicomData").val(extInfo[10]);
      $("#p_Trends").val(extInfo[11]);
      $("#p_MobileUser").val(extInfo[12]);
      $("#p_MobileRate").val(extInfo[13]);
      $("#p_Informationize").val(extInfo[14]);
      $("#p_Intergration").val(extInfo[15]);
      $("#p_Terminal").val(extInfo[16]);
      $("#p_TransProv").val(extInfo[17]);
      $("#p_SinglePay").val(extInfo[18]);
      $("#p_Mas").val(extInfo[19]);
      $("#p_CustomerProvinceNumber").val(extInfo[20]);
      $("#p_Action").val(extInfo[25]);
     
      CMCCPrdListArray=extInfo[23]; 
      if($("#p_Action").val()=="2")
      {
      	document.all.p_HasITDept.disabled=false;
      	document.all.p_ITDeptName.readOnly=false;
      	document.all.p_FeeCase.disabled=false;
      	document.all.p_FeeCaseInfo.readOnly=false;
      	document.all.p_ARPU.readOnly=false;
      	document.all.p_DataARPU.readOnly=false;
      	document.all.p_AvgFee.readOnly=false;
      	document.all.p_Quota.readOnly=false;
      	document.all.p_RewardType.disabled=false;
      	document.all.p_UnicomTone.disabled=false;
      	document.all.p_UnicomData.disabled=false;
      	document.all.p_Trends.readOnly=false;
      	document.all.p_MobileUser.readOnly=false;
      	document.all.p_MobileRate.readOnly=false;
      	document.all.p_Informationize.readOnly=false;
      	document.all.p_Intergration.readOnly=false;
      	document.all.p_Terminal.readOnly=false;
      	document.all.p_TransProv.readOnly=false;
      	document.all.p_SinglePay.readOnly=false;
      	document.all.p_Mas.readOnly=false;
      	
      }
      if($("#p_Action").val()=="1")
      {
      	document.all.p_HasITDept.disabled=false;
      	document.all.p_ITDeptName.readOnly=false;
      	document.all.p_FeeCase.disabled=false;
      	document.all.p_FeeCaseInfo.readOnly=false;
      	document.all.p_ARPU.readOnly=false;
      	document.all.p_DataARPU.readOnly=false;
      	document.all.p_AvgFee.readOnly=false;
      	document.all.p_Quota.readOnly=false;
      	document.all.p_RewardType.disabled=false;
      	document.all.p_UnicomTone.disabled=false;
      	document.all.p_UnicomData.disabled=false;
      	document.all.p_Trends.readOnly=false;
      	document.all.p_MobileUser.readOnly=false;
      	document.all.p_MobileRate.readOnly=false;
      	document.all.p_Informationize.readOnly=false;
      	document.all.p_Intergration.readOnly=false;
      	document.all.p_Terminal.readOnly=false;
      	document.all.p_TransProv.readOnly=false;
      	document.all.p_SinglePay.readOnly=false;
      	document.all.p_Mas.readOnly=false;
      	
      }    
      if($("#p_Action").val()=="3")
      {
      	document.all.p_HasITDept.disabled=true;
      	document.all.p_ITDeptName.readOnly=true;
      	document.all.p_FeeCase.disabled=true;
      	document.all.p_FeeCaseInfo.readOnly=true;
      	document.all.p_ARPU.readOnly=true;
      	document.all.p_DataARPU.readOnly=true;
      	document.all.p_AvgFee.readOnly=true;
      	document.all.p_Quota.readOnly=true;
      	document.all.p_RewardType.disabled=true;
      	document.all.p_UnicomTone.disabled=true;
      	document.all.p_UnicomData.disabled=true;
      	document.all.p_Trends.readOnly=true;
      	document.all.p_MobileUser.readOnly=true;
      	document.all.p_MobileRate.readOnly=true;
      	document.all.p_Informationize.readOnly=true;
      	document.all.p_Intergration.readOnly=true;
      	document.all.p_Terminal.readOnly=true;
      	document.all.p_TransProv.readOnly=true;
      	document.all.p_SinglePay.readOnly=true;
      	document.all.p_Mas.readOnly=true;
      	
      }       
      if(extInfo[21]!="0")//判断页面作为新增还是更新来使用
      {       	
      	$("#p_ExtInfoAcceptID").val(extInfo[21]);      	
      }
      
      $('img.closeEl').bind('click', toggleContent);
      //注册确认
      $('#confirm').click(function(){
  	     ExtInfoConfirm();
  	  });
  	  /*2015/01/07 8:49:41 gaopeng 默认点击*/
  	  $('img.closeEl').click();
  	  

  	}
  );
 
  function ExtInfoConfirm(){

		if($("#p_ITDeptName").val().trim()=="") {
				rdShowMessageDialog("请填写IT部门名称！");
				return false;
		}
    extInfo[0] = $("#p_HasITDept").val();
    extInfo[1] = $("#p_ITDeptName").val();
    extInfo[2] = $("#p_FeeCase").val();
    extInfo[3] = $("#p_FeeCaseInfo").val();
    extInfo[4] = $("#p_ARPU").val();
    extInfo[5] = $("#p_DataARPU").val();
    extInfo[6] = $("#p_AvgFee").val();
    extInfo[7] = $("#p_Quota").val();
    extInfo[8] = $("#p_RewardType").val();
    extInfo[9] = $("#p_UnicomTone").val();
    extInfo[10]= $("#p_UnicomData").val();
    extInfo[11]= $("#p_Trends").val();
    extInfo[12]= $("#p_MobileUser").val();
    extInfo[13]= $("#p_MobileRate").val();
    extInfo[14]= $("#p_Informationize").val();
    extInfo[15]= $("#p_Intergration").val();
    extInfo[16]= $("#p_Terminal").val();
    extInfo[17]= $("#p_TransProv").val();
    extInfo[18]= $("#p_SinglePay").val();
    extInfo[19]= $("#p_Mas").val();
    extInfo[20]= $("#p_CustomerProvinceNumber").val();
    extInfo[21]= $("#p_ExtInfoAcceptID").val();  
    /*赋值确认按钮点击*/
    extInfo[27]=extInfo[26]+"true";
    CMCCPrdListArray = new Array($(".cmcc_contenttr").size());//列表数组初始化    
    //列表数组赋值    
    $(".cmcc_contenttr").each(function(i)
    {    	
    	var CMCCPrdArray = new Array(5);//列表每行数据数组
    	CMCCPrdArray[0]=$(this).attr("a_CMCCPrd");
    	CMCCPrdArray[1]=$(this).attr("a_CustomerProvinceNumber");
    	CMCCPrdArray[2]=$(this).attr("a_ExtInfoAcceptID");
    	CMCCPrdArray[3]=$(this).attr("a_CMCCPrdAcceptID");
    	CMCCPrdArray[4]=$(this).attr("a_OperType");       		      
      CMCCPrdListArray[i]=CMCCPrdArray;      	      
    });        
    //extInfo[22]=CMCCPrdListCheck;//压入列表点击表识
    extInfo[23]=CMCCPrdListArray;//压入列表数组    
    retArray[0]="Y";    
    retArray[1]=deleteArray; 
    window.returnValue = retArray;    
    window.close();
  }


  var toggleContent = function(e)
  {
  	
  	var targetContent = $( 'DIV.itemContent',this.parentNode.parentNode.parentNode);
  	if (targetContent.css('display') == 'none') {
  		targetContent.slideDown(300);
  		$(this).attr({ src: "../../../nresources/default/images/jian.gif"});
  		//调用服务
  		try{
  			var tmp = $(this).attr('id');
  			var tmp2 = eval("_jspPage."+tmp);  			  			
  			if(tmp2[2]=="f"&&tmp2[1]!=''&&tmp2[1]!=undefined)
  			{
  				$("#"+tmp2[0]).load(tmp2[1],
  				                            {checkflag:extInfo[22]
  					                          ,sCustomerProvinceNumber:$("#p_CustomerProvinceNumber").val()
  					                          ,sExtInfoAcceptID:$("#p_ExtInfoAcceptID").val()
  					                          ,sp_Action:$("#p_Action").val()
  					                          }
  					                  );
  				//tmp2[2]="t";
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

</script>
</BODY>
</HTML>
