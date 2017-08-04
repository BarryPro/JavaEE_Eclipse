<%
   /*名称：集团客户项目申请 - 查询dParterOperation
　 * 版本: v1.0
　 * 日期: 2007/2/7
　 * 作者: wuln
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<%
/********************
 version v2.0
 开发商: si-tech
 update zhaohaitao at 2009.02.10
 模块：合作伙伴业务申请
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=gbk"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%

	String regCode = (String)session.getAttribute("regCode");
	String workNo = (String)session.getAttribute("workNo");
	String workPwd = (String)session.getAttribute("password");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);	
	String strDate = new SimpleDateFormat("yyyyMMdd").format(new Date());

	String parterId = request.getParameter("parterId");
	String queryType = request.getParameter("oTypeCode");
	String parterName = request.getParameter("parterName");
	String grpParamSet="";
	String grpParamSetName="";
	String sqlStr ="";
	String Basetype ="";
	String biztype ="";
	String[] inParams = new String[2];

%>
	 
	<wtc:service name="s2889QryServMsg" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="6" >
            	<wtc:param value=""/>
            	<wtc:param value=""/>
              <wtc:param value="2889"/>
              <wtc:param value="<%=workNo%>"/>
              <wtc:param value="<%=workPwd%>"/>
              <wtc:param value=""/>
              <wtc:param value=""/>
              <wtc:param value="<%=queryType%>"/>
              <wtc:param value="<%=parterId%>"/>
   </wtc:service>
   <wtc:array id="colNameArrTemp" scope="end" />
	<%
	String[][] colNameArr = colNameArrTemp;
	
	if (colNameArr.length==0)
	{
		colNameArr = null;
	}	 

 sqlStr = "select net_attr,net_name from sNetAttr";
	 
%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
	<wtc:sql><%=sqlStr%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="netArrTemp" scope="end" />
<%
	 String[][] netArr = netArrTemp;
	 
	 if (netArr.length==0)
	 {
		 netArr = null;
	 }	 
	 
	 String bizLabel = "";
	 if("1".equals(queryType)){
	 	 bizLabel = "MAS";
	 }else{
	 	 bizLabel = "";
	 }
	 inParams[0] = "select parter_type from dpartermsg where parter_id=:parter_id";
	 inParams[1] = "parter_id="+parterId;		
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1"> 
	<wtc:param value="<%=inParams[0]%>"/>
	<wtc:param value="<%=inParams[1]%>"/> 
	</wtc:service> 
	<wtc:array id="bizLabelArr" scope="end" />
<%
    if("000000".equals(retCode1) && bizLabelArr.length>0){
        String bizLabelTemp = bizLabelArr[0][0];
        System.out.println("bizLabelTemp = " + bizLabelTemp);
        /* 
         * 02 26 : ADC
         * 25 27 : MAS
         */
        /*if("25".equals(bizLabelTemp) || "27".equals(bizLabelTemp)){
            bizLabel = "MAS";
        }else */
        if("02".equals(bizLabelTemp) || "26".equals(bizLabelTemp)){
            bizLabel = "ADC";
        }
    }
%>

<html>
<head>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
</head>

<script language="javascript">
	
	function accessNumberChg(){

		 if((document.all.queryType.value=="2")&&(document.form1.BaseServCodeProp.value!="02")&&(document.form1.biztype.value=="1"))
		 {
		 	document.getElementById("accessNumber").setAttribute("readOnly", false);

		 	}else{
		 	document.getElementById("accessNumber").setAttribute("readOnly", true);
		 	}
}
	
	//显示增加业务信息表格
	function showAddBusiInfo()
	{	
		tabBusiAdd.style.display="";
		tabAddBtn.style.display="none";
		tabAddSubmitBtn.style.display="";
		if(document.all.queryType.value=="2")
		{
			
			document.getElementById("YYYY").style.display="none";
		  document.getElementById("XXXX").style.display="none";
		  document.getElementById("cylx1").style.display="none";

		 }
		

	}
	
	function changeCF()
{
	var rBList = document.form1.rBList.value;
	if(rBList=="4")
	{
			var ln=document.form1.CreateFlag.options.length;
      while(ln--)
      {
        	document.form1.CreateFlag.options[ln] = null;
	   	}
	   	var option =new Option("--请选择--","*");  
	   	document.form1.CreateFlag.add(option); 
	   	var option =new Option("B-C/P类","0");  
	   	document.form1.CreateFlag.add(option); 
	   	var option =new Option("B-E/M类","1");  
	   	document.form1.CreateFlag.add(option); 
	}
else//黑白名单
	{
      var ln=document.form1.CreateFlag.options.length;
      while(ln--)
      {
        	document.form1.CreateFlag.options[ln] = null;
	   	}
	    var option =new Option("B-E/M类","1");  
	   	document.form1.CreateFlag.add(option); 
		}
	
}

	//选择EC/SI基本接入号
	function getBaseCode()
	{
		var accModel= document.form1.accessModel.value;
		window.open("f2889_querydBaseCodeMsg.jsp?&queryInfo="+<%=parterId%>+"&queryType="+<%=queryType%>+"&accModel="+accModel,"","height=500,width=400,scrollbars=yes");
	}
	
	//重置页面
	function resetPage()
	{
		if(document.all.queryType.value=="1")
		{
			document.all.biztype.value="0";
			document.all.biztype.disabled=true;
		}
		else
		{
			document.all.biztype.disabled=false;
			document.all.biztype.value="0";
			tabAddinfo.style.display="none";
		}
	}
	
	//初始化页面元素
	function init()
	{
		document.all.TextSignEn.value="";
		document.all.TextSignZh.value="";
		document.all.MaxItemPerDay.value="";
		document.all.MaxItemPerMon.value="";
		if("<%=bizLabel%>"!="MAS"){
			document.all.LimitAmount.value="";
		}
		document.all.InvalidTimeSpanList.value="";
		document.all.MOList.value="";
		document.all.StartTime.value="";
		document.all.EndTime.value="";
		document.all.MOCode.value="";
		document.all.CodeMathMode.value="";
		document.all.MOType.value="";
		document.all.DestServCode.value="";
		document.all.ServCodeMathMode.value="";

		
	}
	
	//设置不允许下发时间段列表
	function setTime()
	{
		window.open('f2889_setTime.jsp','','height=500,width=1000,left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
		
	}
	//设置上行业务指令
	function setMO()
	{
		window.open('f2889_setMo.jsp','','height=600,width=1000,left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
	}
	
	/************************ 增加业务信息 ***********************/
	function addCfm()
	{
		
		if(!checkElement(document.all.accessNumber)){
			return false;
		}
		
		var iaccNum=document.form1.accNum.value;	
		if($.trim(iaccNum).length == 0){
			rdShowMessageDialog("请选择基本接入号！");
			return false;	
		}
		var iaccessNumber=document.form1.accessNumber.value;	
		var iaccess=iaccessNumber.substring(0,iaccNum.length);
		if(iaccNum!=iaccess)
		{
			rdShowMessageDialog("基本接入号的修改只能在原接入号基础上进行扩充添加");
			return false;	
		}
		
		if((document.all.queryType.value=="1")||(document.all.bizType.value=="1")){
		if(document.form1.rBList.value=="*")
		{
			rdShowMessageDialog("业务属性不能为空");
			return false;	
		}
		}
		//alert(document.form1.biztype.value);
		
		document.form1.bizType.value=document.form1.biztype.value;
		
		//alert(document.form1.bizType.value);
		
		/****************** 通用校验  begin ********************/		
		if(!check(form1)) return false;	
		//武星燕添加移动OA考核版提示信息！20081106
		if(document.form1.bussId.value.substring(6,8)=="21")
		{
			rdShowMessageDialog("该业务为移动OA考核版，如需要设置BBOSS侧业务代码对应关系，请到[业务代码和服务代码对应关系维护]中设置！");
		}
		
		var vBizLabel = "<%=bizLabel%>";
		var vBussId = $("#bussId").val();
	    vBussId=vBussId.substring(0,1);



		var vBizTypeL = $("#bizTypeL").val();
		var vBizTypeS = $("#bizTypeS").val();
		
		if(vBizTypeL == ""){
		    rdShowMessageDialog("请选择业务大类!",0);
		    $("#bizTypeL").focus();
		    return false;
		}
		
		if(vBizTypeS == ""){
		    rdShowMessageDialog("请选择业务小类!",0);
		    $("#bizTypeS").focus();
		    return false;
		}

		if(document.form1.netAttr.value=="*")
		{
			rdShowMessageDialog("网络属性不能为空");
			return false;
		}				

		if(document.form1.oprEffTime.value == "")
		{
			rdShowMessageDialog("请输入“操作生效时间”！");
			return false;
		}
		if(document.form1.grpParamSet.value == "")
		{
			rdShowMessageDialog("参数类型不能为空");
			return false;
		}

		if(!validDate(document.all.oprEffTime))	return false;

		if(parseInt(document.all.oprEffTime.value) < parseInt("<%=strDate%>"))
		{
			rdShowMessageDialog("“操作生效时间”不能小于系统当天时间！");
			return false;
		}

			if(document.form1.provURL.value != "" && document.form1.provURL.value.substr(0,7)!="http://")
			{
				rdShowMessageDialog("URL请以http://开头！");
				document.form1.provURL.select();
				return false;
			}
		
			if(chkwww(document.form1.provURL.value)==0)
			{
				rdShowMessageDialog("URL非法！");
				document.form1.provURL.select();
				return false;
			}


   if(document.form1.introURL.value != "" && document.form1.introURL.value.substr(0,7)!="http://")
			{
				rdShowMessageDialog("URL请以http://开头！");
				document.form1.introURL.select();
				return false;
			}

			if(chkwww(document.form1.introURL.value)==0)
			{
				rdShowMessageDialog("URL非法！");
				document.form1.introURL.select();
				return false;
			}

		
		if(document.all.queryType.value=="0"&&document.all.biztype.value=="1")
		{
			//SI发布个人业务,需要对必填项进行校验
			if(document.all.MaxItemPerDay.value=="")
			{
				rdShowMessageDialog("请输入每日下发的最大条数！");
			    return false;
			}
			if(isNaN(document.all.MaxItemPerDay.value)==true)
			{
				rdShowMessageDialog("每日下发的最大条数只能输入数字！");
			    return false;
			}
			
			if(document.all.MaxItemPerMon.value=="")
			{
				rdShowMessageDialog("请输入每月下发的最大条数！");
			    return false;
			}
			
			if(isNaN(document.all.MaxItemPerMon.value)==true)
			{
				rdShowMessageDialog("每月下发的最大条数只能输入数字！");
			    return false;
			}	
				
			if(document.all.TextSignEn.value=="")
			{
				rdShowMessageDialog("请输入英文正文签名！");
			    return false;
			}
			if(document.all.TextSignZh.value=="")
			{
				rdShowMessageDialog("请输入中文正文签名！");
			    return false;
			}
			if((document.form1.rBList.value=="3")||(document.form1.rBList.value=="4"))
			{
				if(vBizLabel != "MAS"){
					if(document.all.LimitAmount.value=="")
			    {
					rdShowMessageDialog("请输入限制下发次数！");
			    	return false;
			    }
				}
			}
			
			if(!forInt(document.all.MaxItemPerDay)) return false;
			if(!forInt(document.all.MaxItemPerMon)) return false;
			if(vBizLabel != "MAS"){
				if(!forInt(document.all.LimitAmount)) return false;
			}
		
			
		}
		
		if((document.all.queryType.value=="1")&&((document.form1.rBList.value=="3")||(document.form1.rBList.value=="4")))
			{	
				if(vBizLabel != "MAS"){
					if(document.all.LimitAmount.value=="")
			    {
					rdShowMessageDialog("请输入限制下发次数！");
			    	return false;
			    }
				}
			}
		if((document.all.queryType.value=="1")||(document.all.bizType.value=="1")){
		if(document.form1.billingType.value == "00"&&document.form1.price.value != "0")
		{
			rdShowMessageDialog("计费类型为免费时，单价只能填0！");
			return false;
		}
		}
		document.all.accessModel.disabled=false;
		
		//alert ("end");
		
		/****************** 通用校验  end ********************/		
		
		
		/*2015/05/04 16:02:06 gaopeng 关于下发省行业网关云MAS业务支撑实施方案的通知 
			2889·合作伙伴业务申请
			查询类型：集团编码  测试集团： 4510224035 
			查询集团客户信息后，点击“查询业务信息”和“增加业务信息” 页面会显示各种新增业务信息
			其中如果输入的“基本接入号“ 1065097 ”开头，则“访问模式”必须为“01-SMS”，“业务属性”必须为“黑名单”
			
			其中如果输入的“基本接入号“ 1065096 ”开头，则“访问模式”可以选“01-SMS”和“02-MMS”，“业务属性”必须为“限制次数白名单”
			accessNumber
			
			accessModel
			
			rBList
			var option =new Option("黑名单","2");  
	   	document.form1.rBList.add(option); 
	   	var option =new Option("限制次数白名单","3");  
	   	
	   	bizTypeL
	   	bizTypeS
			
		*/
		
		var accessModelVal = $("select[name='accessModel']").find("option:selected").val();
		var rBListVal = $("select[name='rBList']").find("option:selected").val();
		
		var bizTypeLVal = $("select[name='bizTypeL']").find("option:selected").val();
		var bizTypeSVal = $("select[name='bizTypeS']").find("option:selected").val();
		
		var accessNumberVal = $.trim($("#accessNumber").val());
		if(accessNumberVal >= 7){
			var subAccessNumber = accessNumberVal.substring(0,7);
			if(subAccessNumber == "1065097"){
				if(accessModelVal != "01"){
					rdShowMessageDialog("基本接入号以“1065097”开头时，访问模式只能选择“SMS”！");
					return false;
				}
				if(rBListVal != "2"){
					rdShowMessageDialog("基本接入号以“1065097”开头时，业务属性只能选择“黑名单”！");
					return false;
				}
				if(bizTypeLVal != "04" && bizTypeSVal != "03"){
					rdShowMessageDialog("基本接入号以“1065096”或“1065097”开头时，业务大类只能选择“04-全网业务”，业务小类只能选择“03-省行业网关短流程云MAS”！");
					return false;
				}
			}
			if(subAccessNumber == "1065096"){
				if(accessModelVal != "01" && accessModelVal != "02"){
					rdShowMessageDialog("基本接入号以“1065097”开头时，访问模式只能选择“SMS”或“MMS”！");
					return false;
				}
				if(rBListVal != "3"){
					rdShowMessageDialog("基本接入号以“1065097”开头时，业务属性只能选择“限制次数白名单”！");
					return false;
				}
				if(bizTypeLVal != "04" && bizTypeSVal != "03"){
					rdShowMessageDialog("基本接入号以“1065096”或“1065097”开头时，业务大类只能选择“04-全网业务”，业务小类只能选择“03-省行业网关短流程云MAS”！");
					return false;
				}
			}
			
		}

		document.form1.action="f2889_modCfm.jsp?OprCode=01";
		document.form1.submit();					
	}
	
function validDate(obj)
{
  var theDate="";
  var one="";
  var flag="0123456789";
  for(i=0;i<obj.value.length;i++)
  { 
     one=obj.value.charAt(i);
     if(flag.indexOf(one)!=-1)
		 theDate+=one;
  }
  if(theDate.length!=8)
  {
	rdShowMessageDialog("日期格式有误，正确格式为“年年年年月月日日”，请重新输入！");
	//obj.value="";
	obj.select();
 	obj.focus();
	return false;
  }
  else
  {
     var year=theDate.substring(0,4);
	 var month=theDate.substring(4,6);
	 var day=theDate.substring(6,8);
	 if(myParseInt(year)<1900 || myParseInt(year)>3000)
	 {
       rdShowMessageDialog("年的格式有误，有效年份应介于1900-3000之间，请重新输入！");
	   //obj.value="";
	   obj.select();
	   obj.focus();
	   return false;
	 }
     if(myParseInt(month)<1 || myParseInt(month)>12)
	 {
       rdShowMessageDialog("月的格式有误，有效月份应介于01-12之间，请重新输入！");
  	   //obj.value="";
	   obj.select();
	   obj.focus();
	   return false;
	 }
     if(myParseInt(day)<1 || myParseInt(day)>31)
	 {
       rdShowMessageDialog("日的格式有误，有效日期应介于01-31之间，请重新输入！");
	   //obj.value="";
	   obj.select();
       obj.focus();
	   return false;
	 }

     if (month == "04" || month == "06" || month == "09" || month == "11")  	         
	 {
         if(myParseInt(day)>30)
         {
	 	     rdShowMessageDialog("该月份最多30天,没有31号！");
 	         //obj.value="";
			 obj.select();
	         obj.focus();
             return false;
         }
      }                 
       
      if (month=="02")
      {
         if(myParseInt(year)%4==0 && myParseInt(year)%100!=0 || (myParseInt(year)%4==0 && myParseInt(year)%400==0))
		 {
           if(myParseInt(day)>29)
		   {
 		     rdShowMessageDialog("闰年二月份最多29天！");
      	     //obj.value="";
			 obj.select();
	         obj.focus();
             return false;
		   }
		 }
		 else
		 {
           if(myParseInt(day)>28)
		   {
 		     rdShowMessageDialog("非闰年二月份最多28天！");
      	     //obj.value="";
			 obj.select();
	         obj.focus();
             return false;
		   }
		 }
      }
  }
  return true;
}	
	
	
	
function changeRBList()
{
	var billingType = document.form1.billingType.value;
	if(billingType=="00"||billingType=="02")//免费或按次
	{
			var ln=document.form1.rBList.options.length;
      while(ln--)
      {
        	document.form1.rBList.options[ln] = null;
	   	}
	   	var option =new Option("--请选择--","*");  
	   	document.form1.rBList.add(option); 
	    var option =new Option("永久性白名单","1");  
	   	document.form1.rBList.add(option); 
	   	var option =new Option("黑名单","2");  
	   	document.form1.rBList.add(option); 
	   	var option =new Option("限制次数白名单","3");  
	   	document.form1.rBList.add(option); 
	   	//var option =new Option("点播业务","4");  
	   	//document.form1.rBList.add(option); 
	}
else//包月
	{
			var ln=document.form1.rBList.options.length;
      while(ln--)
      {
        	document.form1.rBList.options[ln] = null;
	   	}
	   	var option =new Option("--请选择--","*");  
	   	document.form1.rBList.add(option); 
	   	var option =new Option("永久性白名单","1");  
	   	document.form1.rBList.add(option); 
	   	
	}
	
}	
function changeCreateFlag()
{
	var rbiztype = document.form1.biztype.value;
	
		if(rbiztype=="1")// 面向个人
	{
		tabAddinfo.style.display="";
		document.getElementById("YYYY").style.display="";
		document.getElementById("XXXX").style.display="";
		document.getElementById("cylx1").style.display="none";

		accessNumberChg();
	}
	else{
		tabAddinfo.style.display="none";
		document.getElementById("YYYY").style.display="none";
		document.getElementById("XXXX").style.display="none";
		document.getElementById("cylx1").style.display="none";


	}
	
}


function getAccessModel()
{
	var j_bussId = $("#bussId").val();
	if(j_bussId.length!=10){
		rdShowMessageDialog("业务代码格式不正确");
		$("#bussId").val("");
	}else{
		var yelx_sub = j_bussId.substring(6,8);
		if(yelx_sub!="51"&&yelx_sub!="52"&&yelx_sub!="53"&&yelx_sub!="54"){
			rdShowMessageDialog("业务类型不正确");
			$("#bussId").val("");
		}else{
			 $("#yelx").val(yelx_sub);
		}
		
		var hybm_sub = j_bussId.substring(3,5);
		
		if($("#bizhybm_list").val().indexOf(hybm_sub)==-1){
			rdShowMessageDialog("行业编码不正确");
			$("#bussId").val("");
		}
		
	}
	
	
	document.all.accessModel.disabled=false;

changeBizCode();	
}

function changeBizCode(){
    var vBussId = document.form1.bussId.value;
	  vBussId=vBussId.substring(0,1);
    
    var packet = new AJAXPacket("fgetBizTypeL.jsp","请稍后...");
    packet.data.add("bizMode" ,vBussId);
    core.ajax.sendPacket(packet,doChangeBizCode,false);
    packet = null;
}

function doChangeBizCode(packet){
    var retCode = packet.data.findValueByName("retCode");
    var retMessage=packet.data.findValueByName("retMessage");
    self.status="";
    
    if(retCode == "000000")
    {
		var backString = packet.data.findValueByName("backString");
     	var temLength = backString.length+1;
		var arr = new Array(temLength);
		arr[0] = "<option value=''>--- 请选择 ---</option>";
		for(var i = 0 ; i < temLength-1 ; i ++)
		{
			arr[i+1] = "<OPTION value="+backString[i][0]+">" +backString[i][1] + "</OPTION>";
		}
		$("#bizTypeL").empty();
      	$(arr.join()).appendTo("#bizTypeL");
      	
      	$("#bizTypeS").empty();
      	$("<option value=''>--- 请选择 ---</option>").appendTo("#bizTypeS");
	}
    else
    {
        rdShowMessageDialog("获取业务大类失败[错误代码："+retCode+",错误信息："+retMessage+"]",0);
		return false;
    }   
    
}

function changeBizTypeL(){
    var vBizTypeL = $("#bizTypeL").val();

    if(vBizTypeL == ""){
        $("#bizTypeS").empty();
      	$("<option value=''>--- 请选择 ---</option>").appendTo("#bizTypeS");
      	return;
    }
    var vBussId = document.form1.bussId.value;
	vBussId=vBussId.substring(0,1);
    
    var packet = new AJAXPacket("fgetBizTypeS.jsp","请稍后...");
    packet.data.add("bizMode" ,vBussId);
    packet.data.add("bizTypeL" ,vBizTypeL);
    core.ajax.sendPacket(packet,doChangeBizTypeL,false);
    packet = null;
}

function doChangeBizTypeL(packet){
    var retCode = packet.data.findValueByName("retCode");
    var retMessage=packet.data.findValueByName("retMessage");
    self.status="";
    
    if(retCode == "000000")
    {
		var backString = packet.data.findValueByName("backString");
     	var temLength = backString.length;
		var arr = new Array(temLength);
		for(var i = 0 ; i < temLength ; i ++)
		{
			arr[i] = "<OPTION value="+backString[i][0]+">" +backString[i][1] + "</OPTION>";
		}
		$("#bizTypeS").empty();
      	$(arr.join()).appendTo("#bizTypeS");
	}
    else
    {
        rdShowMessageDialog("获取业务小类失败[错误代码："+retCode+",错误信息："+retMessage+"]",0);
		return false;
    }
}

function getBizType(bizTypeL,bizTypeS,bizYelx,bizhybm_list){
    //$("#trBizType").css("display","");
    $("#bizTypeL").empty();
    $("#bizTypeS").empty();
    $("<option value='"+bizTypeL.value+"'>"+bizTypeL.text+"</option>").appendTo("#bizTypeL");
    $("<option value='"+bizTypeS.value+"'>"+bizTypeS.text+"</option>").appendTo("#bizTypeS");
    
     $("#yelx").val(bizYelx);
     $("#bizhybm_list").val(bizhybm_list);
}
		//变更
	function  queryMod(v_id)
	{				
			var str = "?operId=" + document.form1["operId" +v_id].value +  "&parterId=" +document.form1["parterId" +v_id].value+ "&trId=" + document.all.queryType.value+ "&parterName=" + document.all.spBizName.value;
			var url="f2889_mod.jsp" + str;
			window.open(url,'','width='+(screen.availWidth*1-10)+',height='+(screen.availHeight*1-76) +',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
	}
	
	//显示某条业务信息
	function showInfo(v_id)
	{  
        var str = "?operId=" + document.form1["operId" +v_id].value +  "&parterId=" +document.form1["parterId" +v_id].value+ "&trId=" + document.all.queryType.value+ "&parterName=" + document.all.spBizName.value;
        var path="f2889_showInfo.jsp" + str;
		window.open(path,'','width='+(screen.availWidth*1-10)+',height='+(screen.availHeight*1-76) +',left=0,top=0,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
	}

//终止
function  queryModEnd(OprCode,v_id)
	{	
		var myPacket = new AJAXPacket("f2889_modEnd.jsp?OprCode="+OprCode+"&operId=" + document.form1["operId" +v_id].value +  "&parterId=" +document.form1["parterId" +v_id].value+ "&trId=" + v_id,"正在获得信息，请稍候......");
		core.ajax.sendPacket(myPacket);
		myPacket = null;
	}
  function doProcess(packet)
	{
		var errCode    = packet.data.findValueByName("errCode");
		var retMessage = packet.data.findValueByName("errMsg");//声明返回的信息
		var retFlag    = packet.data.findValueByName("retFlag");

		if (errCode==0)
		{  
			if(retFlag=="queryModEnd")
			{			
				rdShowMessageDialog("操作成功！",2);
				window.parent.document.all.queryBusiBtn.onclick();
			}
		}else{
			rdShowMessageDialog(retMessage,0);	
		}
	}

//第三个动态表
var addflag3 = 1;
function dynAdd3()
{
					var tr1=dyntb3.insertRow();
					tr1.bgcolor="F5F5F5";
	        tr1.id="tr";
	       	tr1.align="center";
	       
	 				tr1.insertCell().innerHTML = '<td><input type="text" name="tb3_col1"  v_type="string" v_must="1" v_minlength="1" v_maxlength="32" v_name="开通参数名称" maxlength="32" value="" ></td>';
	 				tr1.insertCell().innerHTML = '<td><input type="text" name="tb3_col2"  v_type="string" v_must="1" v_minlength="1" v_maxlength="32" v_name="显示名称" maxlength="32" value="" ></td>';
	 				tr1.insertCell().innerHTML = '<td><input name="delbutton" class="button"  type=button value="删除" onclick="dynDel3(this)" style="cursor:hand"></td>';
	addflag3++;
}

function dynDel3()
{
			var args=dynDel3.arguments[0];
			var objTD =args.parentElement;
			var objTR =objTD.parentElement;
			var currRowIndex = objTR.rowIndex;
			dyntb3.deleteRow(currRowIndex);  
			addflag3--;
}

function getBizCode()
{
	var accModel= document.form1.accessModel.value;
	window.open("getBizCode.jsp?biz_label=<%=bizLabel%>&accModel="+accModel,"","height=600,width=600,scrollbars=yes");
}

function chkwww(a)
{ 	  
	 var i=a.length;
   if(i>0)
   { 
		  var temp = a.indexOf('.');
		  var tempd = a.indexOf('.');
		  if (temp >= 1) {
		   if ((i-temp) > 3){
					if ((i-tempd)>1){
					  return 1;
					}
		   }
		  }
		       return 0;
		}
	return 1;
}

function getParamSet(flag)
{
    var pageTitle = "业务参数选择";
    var fieldName = "参数代码|参数名称|";
    var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|0|1|";
    var retToField = "";
    if (flag==1) {  
     	retToField="grpParamSet|grpParamSetName|";
    } 
    
    PubSimpSelParam_Set(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,flag);
}
function PubSimpSelParam_Set(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,flag)
{

 var path = "fqueryParamSet.jsp";
  path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
  path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
  path = path + "&selType=" + selType + "&retToField=" + retToField+ "&flag=" + flag;
    
  retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

  return true;
}

function PubSimpSelParam_Check()
{
	if(document.form1.bizCode.value.substring(6,8)=="21")
	{
		rdShowMessageDialog("wuxy");
	}
}

function getValueParamSet(retInfo,flag)
{
  if(retInfo ==undefined)      
    {   return false;   }
    
    if(flag==1)
      {  
     	retToField="grpParamSet|grpParamSetName|";
      }
   
     
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");        
    }
}

function changeAccModel(){
	document.form1.accessNumber.value="";
}
</script>


<body>

<form name="form1" method="post" action="">	
		<input type="hidden" name"OprCode" value="01" >
		<input type="hidden" name="queryType" value="<%=queryType.trim()%>">
		<input type="hidden" name="StartTime" value="">
		<input type="hidden" name="EndTime" value="">
		<input type="hidden" name="MOCode" value="">
		<input type="hidden" name="CodeMathMode" value="">
		<input type="hidden" name="MOType" value="">
		<input type="hidden" name="BaseServCodeProp" value="">
		<input type="hidden" name="ServCodeMathMode" value="">
		<input type="hidden" name="DestServCode" value="">
		<input type="hidden" name="bizType" value="">
		<input type="hidden" name="bizLabel" value="<%=bizLabel%>">
		<input type="hidden" name="accNum" value="">
		<input type="hidden" name="biztype" id="biztype" value="0" />
		<input type="hidden" name="bizhybm_list" id="bizhybm_list" value="" />
		
	<div id="Operation_Table">	
		
	<%
	if(colNameArr!=null)
 	{	
	%>
		<TABLE id="tabList" cellSpacing="0">			
	      	<TR id="line_1"> 
				<TD colspan="6" class="blue"><strong>业务信息</strong></TD>	            						    		            	              
	         </TR> 	
			<tr>				
				<th nowrap align='center'><div>业务编码</div></th>
				<th nowrap align='center'><div>EC/SI编码</div></th>
				<th nowrap align='center'><div>业务名称</div></th>
				<th nowrap align='center'><div>业务状态</div></th>
				<th nowrap align='center'><div>操作方式</div></th>
			</tr>
	<%	
		int len = colNameArr.length;			

			for(int i = 0; i < len; i++)
			{		  
	
	%>			
			<tr id="tr<%=i+1%>">
				<input type="hidden" name="operId<%=i+1%>" value="<%=colNameArr[i][0].trim()%>">
				<input type="hidden" name="parterId<%=i+1%>" value="<%=colNameArr[i][1].trim()%>">

							
				<td nowrap align='center'><a style="CURSOR: hand; TEXT-DECORATION: none" href="javascript:showInfo(<%=i+1%>)"><%=colNameArr[i][0].trim()%></a></td>
				<td nowrap align='center'><%=colNameArr[i][1].trim()%></td>
				<td nowrap align='center'><%=colNameArr[i][2].trim()%></td>
				<td nowrap align='center'><%=colNameArr[i][3].trim()%></td>
				<td nowrap align='center'>
					<%
						String modend="";  		
						if("2".equals(queryType))
						{
							modend="disabled";
						}
						
					%>
					<input name="operator<%=i+1%>" style="cursor:hand" type="button" value="变更" class="b_text" onclick="queryMod(<%=i+1%>)">	
					<input name="operator<%=i+1%>" <%=modend%> style="cursor:hand" type="button" value="终止" class="b_text" onclick="queryModEnd('02',<%=i+1%>)" >	
				</td> 
			</tr>
	<%
		}
	%>
		</TABLE>
<%}%>		
     		
		<TABLE id="tabBusiAdd" style="display:none" cellSpacing="0"> 
			<TR id="line_1"> 
				<TD colspan="5" class="blue"><strong>新建业务信息</strong></TD>	            						    		            	              
	         </TR> 	         
             <TR id="line_1">
	            	<input type="hidden" name="svrCode" maxlength="4" value="ADXX" v_type="string" v_must="1" v_minlength="4" v_maxlength="4" v_name="服务代码" >
	              	<input type="hidden" name="spId" readonly v_type="string" v_must="1" v_minlength="1" v_maxlength="6" v_name="企业代码" maxlength="6" value="<%=parterId%>" >
				    <input type="hidden"  name="spBizName" v_type="string" v_must="1" v_minlength="1" v_maxlength="256" v_name="企业名称" maxlength="256" value="<%=parterName%>" >
				  
				<TD class="blue" >业务代码</TD>
	            <TD>
	            	<input type="text" name="bussId" id="bussId" v_type="string" v_must="1" v_minlength="1" v_maxlength="10"  maxlength="10"  onChange='getAccessModel()'><font color="orange">*</font>
	              	<input type="hidden" name="bizCode" readonly v_type="string" v_must="0" v_minlength="0" v_maxlength="18" maxlength="18" value="" >
	                <input name="bizCodeButton" style="cursor:hand" type="button" class="b_text" value="定制" onClick="getBizCode()">
	            </TD> 	
	            <TD colspan="2" class="blue" >业务名称</TD>
	            <TD>
	              	<input type="text" name="bizName"  v_type="string" v_must="1" v_minlength="1" v_maxlength="256"  maxlength="256" value="" >&nbsp;<font color="orange">*</font>	
	            </TD>	
	                    								    		            	              
	         </TR>
	          <TR id="trBizType" style="display:">
							<TD class="blue" >业务大类</TD>
						    <TD>
						        <select id="bizTypeL" name="bizTypeL" onChange="changeBizTypeL()">
						            <option value=''>---请选择---</option>
						        </select>
						    </TD> 	
						    <TD class="blue" colspan="2">业务小类</TD>
						    <TD>
						        <select id="bizTypeS" name="bizTypeS">
						            <option value=''>---请选择---</option>
						        </select>
						    </TD>	         								    		            	              
						 </TR>
 
	         <TR id="line_1"> 
	         	 
				<TD class="blue" >访问模式</TD>
	            <TD>
	           		 <select id="accessModel" name="accessModel" onChange="changeAccModel()">
      					<option value='01'>SMS</option>
      					<option value='02'>MMS</option>
      					<option value='03'>WAP</option>
      					<option value='04'>其他</option>
	              	</select>	             
	            </TD>	
	            <TD class="blue" colspan="2">基本接入号 </TD>
	            <TD>
	            		
	              	<input type="text" id="accessNumber" name="accessNumber"  v_type="string" v_must="1"  maxlength="21" v_name="基本接入号"  value=""  readOnly>
	              	<input type="button" name="checkFatherBtn1" value="选择" class="b_text" onClick="getBaseCode()" >&nbsp;<font color="#FF0000">*</font>
									
	            </TD>        		            	              
	         </TR>
	         
	         <TR id="YYYY" name="YYYY" class="YYYY">
					<TD class="blue" >计费类型</TD>
	            <TD>
	            	<select name="billingType"  onchange="changeRBList()">
          					<option value='00'>免费</option>
          					<option value='01'>包月</option>
          					<%/*%>
          					<option value='02'>按次</option>
          					<%*/%>
	              	</select>&nbsp;<font color="orange">*</font>
	            </TD>
				<TD class="blue" colspan="2">单价 </TD>
	            <TD>
	              	<input type="text" name="price" v_type="0_9" v_must="1" v_minlength="1" v_maxlength="9" maxlength="9" value="0" >&nbsp;<font color="orange">*</font>	
	            (元)
	            </TD>	         								    		            	              
	         </TR>
	         
	         
	         <TR id="line_1">
	         	
	         	<TD class="blue" >生效时间</TD>
	            <TD>
	              	<input type="text" name="oprEffTime" v_type="date" value="<%=strDate%>" >&nbsp;<font color="orange">*</font>
	            </TD>	
	            <TD class="blue" colspan="2">网络属性 </TD>
	            <TD>
	            	<select name="netAttr">
	            		<option value='*'>--请选择--</option>
	            		<%
	            		
	            		if(netArr!=null) {
		            		for(int i = 0; i < netArr.length; i++)
										{		  
		            		%>
          					<option value="<%=netArr[i][0]%>"><%=netArr[i][1]%></option>
          			<%	}
          			}else
          				{
          				%>
          				<option ></option>
          				<%
          				}
          			%>	
	              	</select>&nbsp;<font color="orange">*</font>
	            </TD>	  			         								    		            	              
	         </TR>

	         <TR id="line_1"> 
				
	    				<!--
	          	<TD class="blue" >业务开放类别 </TD>
	            <TD >
	            <select id="biztype" style="width:133px;"  onchange="changeCreateFlag()" >
          			<%
	            if("2".equals(queryType)){
	              %>
	              
          					<option value='0'>面向EC</option>
          					<option value='1'>面向个人</option>
          			<%
	              }
	            else{
	              %>
	              <option value='0'>面向EC</option>
	              <%
	               }
	              %>

          			
	            </TD> 
	            -->
	         	<TD class="blue" >业务状态</TD>
	            <TD >
	            	<select name="bizStatus">
	  					<option value='A'>正常商用</option>
	  					<option value='S'>内部测试</option>
	  					<option value='T'>测试待审</option>
	  					<option value='R'>试商用</option>
	              	</select>&nbsp;<font color="orange">*</font>
	            </TD>
						 
							
							 <TD class="blue" colspan="2">业务类型 </TD>
	            <TD>
	            	<select name="yelx" id="yelx">
					   				<option value="51" >内部管理类</option>
					   				<option value="52" >外部服务类</option>
					   				<option value="53" >营销推广类</option>
					   				<option value="54" >公共类</option>
								</select>
								<font color="orange">*</font>						
	            </TD>	  			    
	         </TR>
	         <TR id="XXXX" name="XXXX" class="XXXX"> 	         	
						<TD class="blue" >业务属性 </TD>
		            <TD  <%if("MAS".equals(bizLabel)){%>colspan="4"<%}%>>
		            	<select name="rBList"  onchange="changeCF()">
	      					<option value='1'>永久性白名单</option>
	          			<option value='2'>黑名单</option>
	          			<option value='3'>限制次数白名单</option>
	          			<% /* <option value='4'>点播业务</option> */ %>
		              	</select>&nbsp;<font color="orange">*</font>
		            </TD>
		          <%if(!"MAS".equals(bizLabel)){%>
		          		<TD class="blue" >限制下发次数</TD>
			            <TD colspan="2">
			           		<input type="text" name="LimitAmount" v_name="限制下发次数" v_type="0_9"   >
			            </TD> 
		          <%}%>
	         </TR>
			     <TR>
			     	<TD class="blue" >参数类型 </TD>
	          	<TD  <%if("ADC".equals(bizLabel)){%>colspan="4"<%}%>>
					<input name="grpParamSet" type="hidden" value="<%=grpParamSet%>" size="16" maxlength=8 readonly v_type="string">
					<input name="grpParamSetName" type="text" value="<%=grpParamSetName%>" size="16" v_must="1" class="InputGrey" maxlength=8 readonly v_type="string">
					<input type="button" class="b_text" name="checkFatherBtn1" value="查询" onClick="getParamSet(1)" >&nbsp;<font color="orange">*</font>
	        </TD>	
	        <%if(!"ADC".equals(bizLabel)){%>
	          <TD class="blue">业务优先级</TD>
	            <TD colspan="2">
	              	<select name="bizPRI">
	           		 	<option value='00'>00</option>
	      					<option value='01'>01</option>
	      					<option value='02'>02</option>
	      					<option value='03'>03</option>
	      					<option value='04'>04</option>
	      					<option value='05'>05</option>
	      					<option value='06'>06</option>
	      					<option value='07'>07</option>
	      					<option value='08'>08</option>
	      					<option value='09'>09</option>
	              	</select>&nbsp;<font color="orange">*</font>
	            </TD>	  	
	         <%}%>
         </TR>
         <TR id="cylx1" name="cylx1" >
         	<TD class="blue"  >成员类型 </TD>
		            <TD  colspan="4">
		           		 <select name="CreateFlag">
	           		 		<option value='*'>--请选择--</option>
	      					<option value='0'>B-C/P类</option>
	      					<option value='1'>B-E/M类</option>
		              	</select>&nbsp;<font color="orange">*</font>
		            </TD>	 
         
	        </TR> 
	         <TR id="line_1">	         	
				<TD class="blue" >SIProvision的URL</TD>
	            <TD colspan="4">
	              	<input type="text" name="provURL" maxlength="128" value="http://" size="60">&nbsp;&nbsp;(限120个字符)
	            </TD>	         								    		            	              
	         </TR>
	         
	         <TR id="line_1">
	         	<TD class="blue" >使用方法描述</TD>
	            <TD colspan="4">
	              	<input type="text" name="usageDesc" v_type="string"  v_minlength="1" v_maxlength="512"  maxlength="512" value="" size="60">&nbsp;&nbsp;(限500个字符)	
	            </TD> 					         								    		            	              
	         </TR>
	         
	         <TR id="line_1">	         	 
				<TD class="blue" >业务介绍网址</TD>
	            <TD colspan="4" >
	              	<input type="text" name="introURL" maxlength="128" value="http://" size="60">&nbsp;&nbsp;(限120个字符)
	            </TD>	         								    		            	              
	         </TR>
	         

	         
		</TABLE>	      
 

	        <TABLE id="tabAddinfo" style="display:none" width="100%" border=0 align="center" cellSpacing=0 bgcolor="#EEEEEE"> 
	         	<TR bgcolor="#F5F5F5" id="line_1">
	         		<TD class="blue" >是否预付费业务：</TD>
	            <TD >
	           		 <select name="isPrepay" style="width:133px;">
          					<option value='0'>否</option>
          					<option value='1'>是</option>
	              	</select>
	            </TD>
	            <TD class="blue" >缺省签名语言：</TD>
	            <TD >
	           		 <select name="defaultSign" style="width:133px;">
          					<option value='1'>中文</option>
          					<option value='2'>英文</option>
	              	</select>
	            </TD>
	            
	            </TR>
	         	<TR bgcolor="#F5F5F5" id="line_1">
	         		<TD class="blue" >英文正文签名：</TD>
	            <TD >
	           		<input type="text" name="TextSignEn" v_type="string"  ><font color="#FF0000">*</font>
	            </TD>
	            <TD class="blue" >中文正文签名：</TD>
	            <TD >
	           		 <input type="text" name="TextSignZh" v_type="string"  ><font color="#FF0000">*</font>
	            </TD>
	              </TR>	
	            <TR bgcolor="#F5F5F5" id="line_1">
	         		<TD class="blue" >是否支持正文签名：</TD>
	            <TD >
	           		 <select name="ISTextSign" style="width:133px;">
          					<option value='0'>不支持</option>
          					<option value='1'>支持</option>
	              	</select>
	            </TD>
	            <TD class="blue" >业务接入号鉴权方式：</TD>
	            <TD >
	           		 <select name="AuthMode" style="width:133px;">
          					<option value='0'>精确匹配</option>
          					<option value='1'>模糊匹配</option>
	              	</select>
	            </TD>	
	         	</TR>	
	         	<TR bgcolor="#F5F5F5" id="line_1">
	         		<TD class="blue" >每日下发的最大条数：</TD>
	            <TD >
	           		<input type="text" name="MaxItemPerDay" v_name="每日下发的最大条数" v_type="0_9"  ><font color="#FF0000">*</font>
	            </TD>
	            <TD class="blue" >每月下发的最大条数：</TD>
	            <TD >
	           		 <input type="text" name="MaxItemPerMon" v_name="每月下发的最大条数" v_type="0_9"  ><font color="#FF0000">*</font>
	            </TD>
	              </TR>	

	             <TR bgcolor="#F5F5F5" id="line_1">	         	 
				   <TD class="blue"  >不允许下发时间段列表：</TD>
	              <TD colspan="3" >
	              	<input type="text" name="InvalidTimeSpanList" maxlength="128" value="" size="60" readOnly>&nbsp;
	              	<input type="button" class="b_text" name="setTimeBtn1" value="设置" onClick="setTime()" >&nbsp;
	                </TD>	
	                        								    		            	              
	         </TR>
	         <TR bgcolor="#F5F5F5" id="line_1">	         	 
				   <TD class="blue" >上行业务指令：</TD>
	              <TD colspan="3" >
	              	<input type="text" name="MOList" maxlength="128" value="" size="60" readOnly>&nbsp;
	              	<input type="button" class="b_text"  name="setMOBtn1" value="设置" onClick="setMO()" >&nbsp;
	                </TD>	
	                       								    		            	              
	         </TR>
	         </TABLE>	 
 
		<TABLE id="tabAddBtn" style="display:''" cellSpacing="0">
			 <TR> 
	         	<TD align="center"> 		         	    
	         	    <input name="addBtn" style="cursor:hand" type="button" class="b_text" value="增加业务信息" onClick="showAddBusiInfo()">
	         	    &nbsp;
			 	</TD>
	       </TR>
	    </TABLE>
	    
	    <TABLE id="tabAddSubmitBtn" style="display:none" cellSpacing="0">
			 <TR> 
	         	<TD id="footer" align="center"> 		         	    
	         	    <input name="addSubmitBtn" style="cursor:hand" type="button" class="b_foot" value="增 加" onClick="addCfm()">
	         	    &nbsp;
					<input type="reset" name="reset" value="重 置"  style="cursor:hand" class="b_foot" onClick="resetPage()" >
			 	</TD>			 	
	       </TR>
	    </TABLE>
	    <script>
	     changeRBList();
	    </script>
	 	   	
	</div>   
</form>
</body>
</html>

