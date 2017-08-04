 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%                           
  /*
   * 功能: 
   * 版本: 
   * 日期: 2010-4-14 9:24
   * 作者: lijy
   * 版权: si-tech
   * update:
  */
%>
<%response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);
response.flushBuffer();%>
<%
String cccTime=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
String workNo = (String)session.getAttribute("workNo");
String workName = (String)session.getAttribute("workName");
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String ip_Addr = (String)session.getAttribute("ipAddr");
String password = (String)session.getAttribute("password");
String opCode = request.getParameter("opCode")==null?"4981":request.getParameter("opCode");
String opName = request.getParameter("opName")==null?"宽带移机":request.getParameter("opName");
String dateStr2 =  new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
activePhone= activePhone==null? "":activePhone;
String sqlStr1="select  a.region_name from sregioncode a where a.region_code='"+regionCode+"'";
String userRegionName="";
%>
<wtc:pubselect name="sPubSelect" outnum="1">
		<wtc:sql><%=sqlStr1%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result1" scope="end"/>	
<%
  if(retCode.equals("000000") && result1.length > 0){
      userRegionName=result1[0][0];
	}
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 	
<%
System.out.println("-----------------------sysAcceptl---------------------------"+sysAcceptl);
%>	
<HEAD><TITLE><%=opName%></TITLE>
<SCRIPT type=text/javascript>	
var flag="0";//查询到宽带用户信息的标志 0表示未查询到，1表示查到
$(document).ready(function () {
	buttonShow();
	});
	//宽带用户信息查询
function getUserInfo()
{
	var cfmLogin="";
	var phoneNo="";
	if(document.all.query_type[0].checked)
	{
		cfmLogin=document.all.query_content.value;
	}else if(document.all.query_type[1].checked){
		phoneNo=document.all.query_content.value;
	}
	var myPacket = new AJAXPacket("getKdUserInfo.jsp", "正在校验，请稍候......");
		   myPacket.data.add("loginAccept", document.all.sysAcceptl.value);
		   myPacket.data.add("opCode", <%=opCode%>);
		   myPacket.data.add("workNo",document.all.workNo.value );
		   myPacket.data.add("password",document.all.password.value );
		   myPacket.data.add("phoneNo",phoneNo);
		   myPacket.data.add("cfmLogin",cfmLogin);
		   core.ajax.sendPacket(myPacket,doGetUserInfo);
       myPacket = null;
}
function doGetUserInfo(packet)
{
   var retCode = packet.data.findValueByName("retCode");
   var retMessage = packet.data.findValueByName("retMessage");
   if(retCode=="000000"){ 
    		 document.all.phone_no.value= packet.data.findValueByName("Phoneno");  
    		 document.all.id_no.value=packet.data.findValueByName("id_no");  
    		 document.all.sm_name.value=packet.data.findValueByName("Sm_name");  
    		 document.all.sm_code.value=packet.data.findValueByName("Sm_code");  
    		 document.all.vModeName.value=packet.data.findValueByName("Modename");  
    		 document.all.vModeCode.value=packet.data.findValueByName("Modecode");    
    		 document.all.run_name.value=packet.data.findValueByName("Run_name");  
    		 document.all.run_code.value=packet.data.findValueByName("Run_code");  
    		 //document.all.vOweFee.value=packet.data.findValueByName("Owefee");  
    		 document.all.vAttrName.value=packet.data.findValueByName("Attname");  
    		 //document.all.vCustAttr.value=packet.data.findValueByName("Custattr");  
    		 document.all.areaNameOld.value=packet.data.findValueByName("Areaname");  
    		 document.all.areaCodeOld.value=packet.data.findValueByName("Areacode");  
    		 document.all.vOpenDate.value=packet.data.findValueByName("vOpenDate");  
    		 document.all.cfm_login.value=packet.data.findValueByName("Cfmlogin");  
    		 document.all.vCfmPwd.value=packet.data.findValueByName("Cfmpwd");   
    		 document.all.detailAddrOld.value=packet.data.findValueByName("Detailaddr");  
    		 document.all.BandWidthOld.value=packet.data.findValueByName("BandWidth");  
    		 //客户信息
    		 document.all.userName.value=packet.data.findValueByName("Cust_name");  
    		 document.all.Custaddress.value=packet.data.findValueByName("Cust_address");  
    		 document.all.Contractno.value=packet.data.findValueByName("Contractno");  
    		 document.all.RegionCode.value=packet.data.findValueByName("RegionCode");  
    		 document.all.RegionName.value=packet.data.findValueByName("RegionName");  
    		 //调用旧资源查询
    		 getOldResByCfmLogin();
   }else{
    			rdShowMessageDialog(retMessage,0);	
    			return;	
   }
 
     
}
//获取旧资源信息
function getOldResByCfmLogin( )
{
	var myPacket = new AJAXPacket("../se276/ajax_getOldResByCfmLogin1.jsp", "正在校验，请稍候......");
		   myPacket.data.add("cfmLogin", document.all.cfm_login.value);
		   core.ajax.sendPacket(myPacket,doGetOldResByCfmLogin);
                     myPacket = null;
}
function doGetOldResByCfmLogin(packet)
{
	var retCode = packet.data.findValueByName("retCode");
         var retMessage = packet.data.findValueByName("retMessage");
         var retContent=packet.data.findValueByName("retContent");
         if(retCode=="000000"){
           var fieldContent=retContent.split(",");
           var records=fieldContent[2].split("=");
           var record=records[1].split("%");
	            if(!(record[0]=="1") && !(record[0]=="2")){
			            document.all.deviceTypeOld.value= record[0];
			            document.all.deviceCodeOld.value=record[1];
			            document.all.modelOld.value= record[2];
			            document.all.factoryOld.value= record[3];
			            document.all.ipAddressOld.value= record[4];
			            document.all.deviceInAddressOld.value= record[5];
			            document.all.portCodeOld.value= record[6];
			            document.all.portTypeOld.value= record[7]; 
			            document.all.cctIdOld.value= record[8];
			             flag="1";          
	         }else{
	         	rdShowMessageDialog("查询旧资源信息失败",0);
	         	return false;
	        }
        } else{
        	rdShowMessageDialog(retMessage,0);
        	return false;
        }
}

function oneTok(str,tok,loc)
{
   var temStr=str;
	 var temLoc;
	 var temLen;
   for(ii=0;ii<loc-1;ii++)
	{
       temLen=temStr.length;
       temLoc=temStr.indexOf(tok);
       temStr=temStr.substring(temLoc+1,temLen);
 	}
	if(temStr.indexOf(tok)==-1)
	  return temStr;
	else
    return temStr.substring(0,temStr.indexOf(tok));
}	
function buttonShow()
{
	if(document.all.isYzResource.value=="0")
	{	
    if(document.all.isGetAreaResource.value=="1")
		{
			document.all.yz_resource.disabled=false;
		}else if (document.all.isDoNoResource.value=="1")
		{
			document.all.yz_resource.disabled=true;
		}else if ((document.all.isDoNoResource.value !="1") && (document.all.isGetAreaResource.value!="1") )
		{
			document.all.query_res.disabled=false;
			document.all.yz_resource.disabled=true;
		}
			
	}
	else{
			document.all.query_res.disabled=true;
	}
}
function idleResInfo()
{
	document.all.area_nameh.value=  "";
	document.all.area_codeh.value=  "";
	document.all.areaAddr.value=  "";	
	//document.all.bandWidth.value="";
	document.all.enter_type.value=  "";
	document.all.standardCode.value="";
	document.all.standardContent.value="";
	
	document.all.deviceType.value="";
	document.all.deviceCode.value="";
	document.all.model.value="";
	document.all.factory.value="";
  document.all.ipAddress.value="";
  document.all.deviceInAddress.value="";
  document.all.portType.value="";
  document.all.portCode.value="";
  document.all.cctId.value="";
  document.all.cctName.value="";
}
/*宽带小区查询*/
function queryResource()
{ 
	 idleResInfo();
   if(document.all.isYzResource.value!="1"){
		      var path ="../se276/queryResource1.jsp?opCode="+"<%=opCode%>";
		      window.open(path,'小区资源查询','width=840px,height=600px,left=100,top=50,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no');
    }else{	 
    		yzResource();//释放资源 	
    }
} 
function returnResBack(retInfo)
{   
	var resPre=retInfo.substr(0,2);
	var resContent=retInfo.substr(2,retInfo.length-1);
  if (resPre =="3%"){//有设备无端口
  }else if (resPre =="4%"){//有设备有端口
  		document.all.area_nameh.value=  oneTok(resContent, "|", 1);
			document.all.area_codeh.value=  oneTok(resContent, "|", 2);
			document.all.areaAddr.value=  oneTok(resContent, "|", 3);	
			//document.all.bandWidth.value=oneTok(resContent, "|", 4);
			document.all.enter_type.value=  oneTok(resContent, "|", 5);
			document.all.standardCode.value=oneTok(resContent, "|", 6);
			document.all.standardContent.value=oneTok(resContent, "|",7);
			
			document.all.deviceType.value=oneTok(resContent, "|", 8);
		  document.all.deviceCode.value=oneTok(resContent, "|", 9);
		  document.all.model.value=oneTok(resContent, "|", 10);
		  document.all.factory.value=oneTok(resContent, "|", 11);
    	document.all.ipAddress.value=oneTok(resContent, "|", 12);
    	document.all.deviceInAddress.value=oneTok(resContent, "|", 13);
    	document.all.portType.value=oneTok(resContent, "|", 14);
    	document.all.portCode.value=oneTok(resContent, "|", 15);
    	document.all.cctId.value=oneTok(resContent, "|", 16);
    	//document.all.cctId.value="001";
    	/*if(document.all.cctId.value != ""){
			    var packet = new AJAXPacket("ajaxGetCctName.jsp","请稍后...");
					packet.data.add("cctId",document.all.cctId.value);
					core.ajax.sendPacket(packet,doAjaxGetCctName);
					packet = null;
    	}*/
    	document.all.isGetAreaResource.value="1";
    	buttonShow();
  }
     
}
function doAjaxGetCctName(packet)
{
	var retCode = packet.data.findValueByName("retCode");
  var retMsg = packet.data.findValueByName("retMsg");
  var cctName = packet.data.findValueByName("cctName");
  if(retCode == "000000")
  {
  	document.all.cctName.value=cctName;	
  }
  else
  {
  	rdShowMessageDialog(retMsg,0);
  }
}
//资源预占
function yzResource( )
{
	if(flag=="1"){
		if(document.all.isGetAreaResource.value=="0"){
		       rdShowMessageDialog("没有选择资源，请选择资源");
		       return false;
		}else if(document.all.contactPhone.value==null || document.all.contactPhone.value=="" || document.all.contactPhone.value=="0"){
		  	rdShowMessageDialog("联系号码不可以为空，请输入");
		  	document.all.contactPhone.focus();
		  	return false;
		 }else if(document.all.contactCustName.value==null || document.all.contactCustName.value=="" || document.all.contactCustName.value=="0"){
		  	rdShowMessageDialog("联系人不可以为空，请输入");
		  	document.all.contactCustName.focus();
		  	return false;
		 }
		 else if(document.all.enter_addr.value==null || document.all.enter_addr.value==""){
			rdShowMessageDialog("安装地址不可以为空，请输入");
			document.all.enter_addr.focus();
			return false;
		 }
		if(document.all.isYzResource.value=="1")
		{
			rdShowMessageDialog("该用户已预占资源,如果要重新预占，确定要释放原先资源？",1);
		  var myPacket = new AJAXPacket("../se276/ajax_yzResource1.jsp", "正在校验，请稍候......");
				myPacket.data.add("serviceOrder","40007" );
				myPacket.data.add("type", "2" );
				myPacket.data.add("businessCity",  "<%=userRegionName%> ");
				myPacket.data.add("businessArea","");/*业务所属区域*/
				myPacket.data.add("businessDemand","");/*业务需求描述*/
				myPacket.data.add("productApplyUses","宽带移机资源释放");/*用途*/
				
				myPacket.data.add("loginNo", "<%=workNo%>");
				myPacket.data.add("applyId","");/*申请系统主工单号*/
				
				myPacket.data.add("productName", "");
				myPacket.data.add("productCode", document.all.cfm_login.value);
				myPacket.data.add("productType","12");/*产品类型*/
				myPacket.data.add("productState","");/*产品业务状态*/
				myPacket.data.add("validateTime","");/*拟生效时间*/
				myPacket.data.add("relatedProductCode","");/*关联产品*/
				
				myPacket.data.add("account", document.all.cfm_login.value);
				myPacket.data.add("password","null");/*密码*/
				myPacket.data.add("customerName", document.all.userName.value);
				myPacket.data.add("customerAddress", document.all.detailAddrOld.value);
				myPacket.data.add("customerGrade","");/*用户级别*/
				myPacket.data.add("customerLinkMan","");/*用户联系人*/
				myPacket.data.add("customerPhone", "");
				myPacket.data.add("customerMail","");/*联系邮箱*/
				myPacket.data.add("customerCode",document.all.cfm_login.value);/*用户编号*/
				myPacket.data.add("newCustomerName",document.all.userName.value);/*新用户名称名称*/
				myPacket.data.add("newCustomerAddress",document.all.enter_addr.value);/*新用户地址*/
				myPacket.data.add("newCustomerPhone",document.all.contactPhone.value);/*新联系电话*/
				myPacket.data.add("stdAddress",document.all.standardContent.value);/*用户标准地址*/
				myPacket.data.add("newRate","");/*新宽带速率*/
				myPacket.data.add("oldRate","");/*旧宽带速率*/
				
				myPacket.data.add("serviceType","17");/*服务类型*/	
				myPacket.data.add("deviceName", document.all.deviceType.value );
				myPacket.data.add("deviceId", document.all.deviceCode.value );
				myPacket.data.add("portName", document.all.portType.value);
				myPacket.data.add("portId", document.all.portCode.value);
	
				myPacket.data.add("collType","");/*合作类型*/
				myPacket.data.add("broadBandObject","");/*宽带对象*/
				myPacket.data.add("opNote", "资源释放");/*备注*/
						
				myPacket.data.add("opCode", "<%=opCode%>");
				core.ajax.sendPacket(myPacket,doYzResource);
				myPacket = null;
		                                                               
		}else if(document.all.isYzResource.value=="0"){
			var myPacket = new AJAXPacket("../se276/ajax_yzResource1.jsp", "正在校验，请稍候......");  
				myPacket.data.add("serviceOrder","40007"  );
				myPacket.data.add("type", "0" );
				myPacket.data.add("businessCity",  "<%=userRegionName%> ");
				myPacket.data.add("businessArea","");/*业务所属区域*/
				myPacket.data.add("businessDemand","");/*业务需求描述*/
				myPacket.data.add("productApplyUses","宽带开户资源预占");/*用途*/
				
				myPacket.data.add("loginNo", "<%=workNo%>");
				myPacket.data.add("applyId","");/*申请系统主工单号*/
				
				myPacket.data.add("productName", "");
				myPacket.data.add("productCode", document.all.cfm_login.value);
				myPacket.data.add("productType","12");/*产品类型*/
				myPacket.data.add("productState","");/*产品业务状态*/
				myPacket.data.add("validateTime","");/*拟生效时间*/
				myPacket.data.add("relatedProductCode","");/*关联产品*/
				
				myPacket.data.add("account", document.all.cfm_login.value);
				myPacket.data.add("password","null");/*密码*/
				myPacket.data.add("customerName", document.all.userName.value);
				myPacket.data.add("customerAddress", document.all.detailAddrOld.value);
				myPacket.data.add("customerGrade","");/*用户级别*/
				myPacket.data.add("customerLinkMan","");/*用户联系人*/
				myPacket.data.add("customerPhone","");
				myPacket.data.add("customerMail","");/*联系邮箱*/
				myPacket.data.add("customerCode",document.all.cfm_login.value);/*用户编号*/
				myPacket.data.add("newCustomerName",document.all.userName.value);/*新用户名称*/
				myPacket.data.add("newCustomerAddress",document.all.enter_addr.value);/*新用户地址*/
				myPacket.data.add("newCustomerPhone",document.all.contactPhone.value);/*新联系电话*/
				myPacket.data.add("stdAddress",document.all.standardContent.value);/*用户标准地址*/
				myPacket.data.add("newRate","");/*新宽带速率*/
				myPacket.data.add("oldRate","");/*旧宽带速率*/
				
				myPacket.data.add("serviceType","17");/*服务类型*/	
				myPacket.data.add("deviceName", document.all.deviceType.value );
				myPacket.data.add("deviceId", document.all.deviceCode.value );
				myPacket.data.add("portName", document.all.portType.value);
				myPacket.data.add("portId", document.all.portCode.value);
	
				myPacket.data.add("collType","");/*合作类型*/
				myPacket.data.add("broadBandObject","");/*宽带对象*/
				myPacket.data.add("opNote", "资源预占");/*备注*/
						
				myPacket.data.add("opCode", "<%=opCode%>");
				core.ajax.sendPacket(myPacket,doYzResource);
				myPacket = null;	                                                             
		}
	}else if(flag=="0"){
		rdShowMessageDialog("没有查询到宽带用户,旧资源信息，不可以预占资源");
	}	
} 
function doYzResource(packet)
{
	var retCode = packet.data.findValueByName("retCode");
	var retMsg = packet.data.findValueByName("retMsg");
	var retContent = packet.data.findValueByName("retContent");
	var iType = packet.data.findValueByName("iType");
     if(iType=="0"){          
          if(retCode=="000000" ){	
          	var retValue=retContent.split(",");
            var retContent=retValue[2].split("=");
            
            if(retContent[1]=="0"){//判断是否预占成功
				       	//有些输入框不可编辑
				       	document.all.contactCustName.readOnly=true;
				       	document.all.contactPhone.readOnly=true;
				       	document.all.enter_addr.readOnly=true;
				       	//有些按钮不能用
				       	document.all.isYzResource.value="1";  
				       	rdShowMessageDialog("资源预占成功",2);
				       	buttonShow();
			       }else{
			      			rdShowMessageDialog("资源预占失败",0);
			      	}     
			     }else {                                       
			       	 rdShowMessageDialog(retMsg,0); 
			       	 document.all.isYzResource.value="0"; 
			     }
     }else if(iType=="2"){
	     if(retCode=="000000"  ){	
		     	var retValue=retContent.split(",");
		      var retContent=retValue[2].split("=");
		      if(retContent[1]=="0"){ 
             idleResInfo();
			    	  //有些输入框可以输入	
			    	 document.all.contactCustName.readOnly=false;	    	  
				     document.all.contactPhone.readOnly=false;
				     document.all.enter_addr.readOnly=false;
			    	 //有些按钮不可以使用
			    	 document.all.isYzResource.value="0"; 
			    	 document.all.isGetAreaResource.value="0";
			    	 rdShowMessageDialog("资源释放成功",1);
			   	 	 buttonShow();
			   	
		      }else{
		       rdShowMessageDialog("资源释放失败",0); 
		       return false;
		      } 
	     }else{
		     	rdShowMessageDialog(retMsg,0);  
		     	document.all.isYzResource.value="1"; 
	     }
	   }
}	
/*提交服务*/
function commitJsp(){
    if(f4981.contactPhone.value.trim().length == 0){
            rdShowMessageDialog("联系电话不能为空！");
            document.all.contactPhone.focus();
            return false;
       }
    if(f4981.enter_addr.value.trim().length == 0){
            rdShowMessageDialog("现详细安装地址不能为空！");
            document.all.enter_addr.focus();
            return false;
       }
      if(f4981.construct_request.value.trim().length == 0){
            document.all.construct_request.value="无";
       }
      if(f4981.appointvTime.value.trim().length == 0){
            rdShowMessageDialog("预约上门时间不能为空！");
            document.all.appointvTime.focus();
            return false;
       }
       if((document.all.isYzResource.value!="1") && (document.all.isDoNoResource.value !="1")){
						rdShowMessageDialog("没有预占资源或不允许不预占资源办理!");
						return false;  
			 }
			 if(forDate(document.all.appointvTime)){
	  		rdShowMessageDialog("预约上门时间格式不正确！");
	      document.all.appointvTime.focus();
	      return false;
	     }
			 if(!forDate(document.all.appointvTime)){
			  	if($(document.getElementById("appointvTime")).val() < "<%=dateStr2%>")
			  	{
			  		rdShowMessageDialog("预约上门时间不能小于当前时间！");
			  		return false;
			    }
			 }else if(!check(f4981)){
				    return false;
			 }
			
			    
       // showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
			if(rdShowConfirmDialog('确认要提交<%=opName%>信息吗？')==1)
			{
					document.all.vSystemNote.value="操作员<%=workNo%>对用户<%=activePhone%>"+"进行<%=opName%>操作";
					var vOpNote=document.all.vOpNote.value.trim();
					if(vOpNote.length==0){
						  document.all.vOpNote.value=document.all.vSystemNote.value;
			    }
			      conf();
			}
}
function conf()
{
	document.f4981.action="s4981_Cfm.jsp"; 
	f4981.submit();
}
//电子免填单打印
function showPrtDlg(printType,DlgMessage,submitCfm)
{  
   var h=198;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var pType="subprint";
   var billType="1";
   var sysAccept = "<%=sysAcceptl%>";
   var phone_no	= $("input[name='phone_no']").val();
   
   var mode_code = document.all.vModeCode.value;
   mode_code = mode_code.replace(/,/ig,"~");
   
   
   var fav_code = null;
   var area_code = null;
   var printStr = printInfo(printType);

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
   var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+""+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   window.showModalDialog(path,printStr,prop);
}
//打印信息
function printInfo(printType)
{
   var retInfo = "";
   var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 
		
    cust_info+="客户姓名：	"+document.all.userName.value+"|";
    cust_info+="手机号码：	"+$("input[name='phone_no']").val().trim()+"|";
    cust_info+="客户地址：	"+document.all.Custaddress.value+"|";
		
		var cTime = "<%=cccTime%>";	
		opr_info+="业务受理时间："+cTime+"  "+"用户品牌:"+"宽带"+"|";
     
		opr_info+="办理业务：宽带移机"+"  "+"操作流水："+document.all.sysAcceptl.value+"|";			
	
   note_info1+="备注："+document.all.vOpNote.value+"|";
 
	retInfo = strcat(cust_info,opr_info,note_info1);
         retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
 	return retInfo;	
}
function closeWindow()
{
	clearWindow();
  parent.removeTab(<%=opCode%>);
}
function clearWindow()
{
	 if(document.all.isYzResource.value=="1"){
		 yzResource();
   }
   $("#f4981").find("input[type='text']").val("");
   buttonShow();    
}

</SCRIPT>		
</HEAD>
<body>
<form method=post name="f4981" id="f4981">
<%@ include file="/npage/include/header.jsp" %>

<div class="title">
 <div id="title_zi">用户信息</div>	  
</div>
<table  cellSpacing="0">
	<tr>
  	<td class="Blue">查询条件</td>
    <td>
    	<input type="radio" id="query_type" name="query_type" value="0" >宽带登陆账号
      <input type="radio" id="query_type" name="query_type" value="1"  checked>用户号码
    </td>
    <td>
    	<input type="text" id="query_content" name="query_content" value="<%=activePhone%>"/>
    </td>
    <td colspan="3">
    	<input type="button" class="b_text" value="查询" onclick="getUserInfo()"/>
    </td> 
  </tr>
  <tr>    	         
	  <td  class="Blue"> 服务号码</td>																																					
	  <td>																																					
	   <input type="text"  name="phone_no" readonly> 																																					
	  </td>	
    <td class="Blue"> 宽带登陆账号</td>
    <td>     	
    	<input type="text" value="" name="cfm_login" size=25 readonly>
   	  <input type="hidden" value="" name="vCfmPwd" readonly>
    </td>
    <td   class="Blue">用户状态</td> 	
    <td>	
     <input type="text" value="" name="run_name" readonly>
     <input type="hidden" value="" name="run_code" readonly>
    </td>	
  </tr>	
  <tr>																																	
	  <td   class="Blue">业务类型</td>																																					
	  <td>																																					
	    <input type="text" value="" name="sm_name"  id="sm_name" readonly>																																					
	    <input type="hidden" value="" name="sm_code"  id="sm_code" readonly>																																					
	  </td>																																					
	  <td  class="Blue">资费名称</td>																																					
	  <td>																																					
	  	<input type="text" value="" name="vModeName"  id="vModeName" readonly>																																					
	  	<input type="hidden" value="" name="vModeCode"  id="vModeCode" readonly>																																					
	  </td>	
	  <td  class="Blue">开始时间 </td>  
    <td>      
      <input type="text" name="vOpenDate"  value="" readonly>
    </td> 																																				
  </tr>
	<tr>
   <td class="Blue" > 原安装地址</td>
	 <td  colspan=5>
	 	<input  id="Text2" type="text" readonly value="" size="80" name="detailAddrOld"  v_maxlength="60"  v_type="string" maxlength="60" onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');" index="9" onblur="checkElement(this)">
   </td>
  </tr>	
</table>


<div class="title">
 <div id="title_zi">旧资源信息</div>	  
</div>
<table cellSpacing="0">
	<tr>
  	<td  class="Blue">设备类型</td>
    <td >
	  	<input id="deviceTypeOld" name="deviceTypeOld" readonly>
    </td>
    <td  class="Blue">端口类型</td>
   <td>
		 <input id="portTypeOld" name="portTypeOld" readonly>
   </td>
   <td  class="Blue">设备安装地址</td>  
   <td> 
   	<input id="deviceInAddressOld" name="deviceInAddressOld" size=50 readonly> 
   </td>
	</tr>  
</table>



<div class="title">
 <div id="title_zi">新资源信息</div>	  
</div>
<table cellspacing="0" >  
   <tr >    
   	  <td colspan='6' align='center'> 
				 <input type="button" class="b_text" name="query_res" value="小区资源查询" onClick="queryResource()" >
				 <input type="button" class="b_text" name="yz_resource" value="资源预占" onClick="yzResource()">
      </td>
   </tr>
   <tr>
		<td class="Blue" width="10%">联系人</td>  
    <td>
        <input id="contactCustName" name="contactCustName" ><font class="orange">*</font>
    </td> 
    <td class="Blue" >联系电话</td>  
    <td> 
        <input id="contactPhone" name="contactPhone" onKeyPress="return isKeyNumberdot(0)" ><font class="orange">*</font>
    </td> 
    <td class="Blue">小区名称</td>  
    <td> 
        <input type="text"    id="area_nameh" name="area_nameh" readonly> 
        <input type="hidden"  name="area_codeh"  readOnly>  
    </td> 
   </tr>  
   <tr>
   	<td class="Blue" >新详细安装地址</td>
	  <td colspan='6'>
			<input  id="Text2" type="text" size="80" name="enter_addr"  v_type="string"  onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');" index="9"  ><font class="orange">*</font>
	  </td>
  </tr>    
   <tr>
      <td  class="Blue">电信局名称</td>
      <td>
         <input type="text"  id="cctName" name="cctName"  readOnly>
      </td>
      <td  class="Blue">标准地址</td>
      <td>
         <input type="text"  id="standardContent" name="standardContent" size=50 readOnly>
      </td>
      <td  class="Blue"> 接入方式</td>
	    <td> 
	         <input id="enter_type" name="enter_type"  readonly>
	    </td> 
   </tr>
   <tr>
	   <td  class="Blue"> 设备类型</td>
     <td>
	        <input id="deviceType" name="deviceType" readonly>
     </td>
     <td class="Blue">  设备安装地址</td>  
     <td> 
        <input id="deviceInAddress" name="deviceInAddress"  size=50 readonly> 
     </td> 
     <td  class="Blue"> 端口类型</TD>
     <td>
	        <input id="portType" name="portType" readonly>
     </td>
   </tr>   
   <tr>
   	<td class="Blue">施工要求</td>
    <td colspan=3>
    	<input type="text" name="construct_request"  size=60>
    </td>
    <td class="Blue">预约上门时间</td>
	  <td>
	  	<input type="text" name="appointvTime" id="appointvTime" ><font class="orange">(*格式YYYYMMDD)</font>
		</td>	
   </tr>	  
</table>

<!--备注-->
<table cellspacing="0" >
	<tr>
     <td class="Blue" width="15%"> 系统备注</td>
		 <td>
		 	 <input  id="Text2" type="text" size="60" name="vSystemNote"  v_maxlength="60"  v_type="string" maxlength="60" onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');" index="9" onblur="checkElement(this)" readonly>
     </td>
  </tr>		  
  <tr>
  	<td class="Blue" width="15%">用户备注</td>
		<td width="89%">
		  	<input  id="Text2" type="text" size="60" name="vOpNote"  v_maxlength="60"  v_type="string" maxlength="60" onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');" index="9" onblur="checkElement(this)">
		</td>
	</tr>      
</table>

<table  cellSpacing="0">
	<tr> 
		<td id="footer" align=center>
		  <input class="b_foot" name="button_1"  onmouseup="commitJsp()" onKeyUp="if(event.keyCode==13)commitJsp()" type=button value="确认"  >
		  <input class="b_foot" name=clearwindow onClick="clearWindow()" type=button value="清除" >
		  <input class="b_foot" name=back onClick="closeWindow()" type=button value="关闭" >
		</td>
  </tr>
</table> 	

<input type="hidden"  id="workNo" name="workNo"  value="<%=workNo%>" >
<input type="hidden"  id="password" name="password"  value="<%=password%>" > 
<input type="hidden"  id="opCode" name="opCode"  value="<%=opCode%>" >
<input type="hidden"  id="ipAddr" name="ipAddr"  value="<%=ip_Addr%>" >			    
<input type="hidden" name="sysAcceptl" id="sysAcceptl" value="<%=sysAcceptl%>" /> <!--流水-->

<!--资源查询标识-->
<input type="hidden"  id="isDoNoResource" name="isDoNoResource"  value="0" >
<input type="hidden"  id="isGetAreaResource" name="isGetAreaResource"  value="0" >
<input type="hidden"  id="isYzResource" name="isYzResource"  value="0" >
<!--用户信息-->
<input type="hidden"  id="id_no" name="id_no"  value="" >
<input type="hidden"  id="userName" name="userName"  value="0" >   
<input type="hidden"  id="Custaddress" name="Cust_address"  value="0" > 
<input type="hidden"  id="Contractno" name="Contractno"  value="0" >
<input type="hidden"  id="RegionCode" name="RegionCode"  value="0" >
<input type="hidden"  id="RegionName" name="RegionName"  value="0" >
<input type="hidden"  id="vAttrName" name="vAttrName"  value="0" >

<!--资源信息-->
<input type="hidden" value="" id="areaNameOld" name="areaNameOld"  >
<input type="hidden" value="" id="areaCodeOld" name="areaCodeOld"   >
<input type="hidden"  id="areaAddr" name="areaAddr"  ><!--小区地址-->
<input type="hidden"  id="standardCode" name="standardCode"  ><!--标准地址编码-->
<input type="hidden"  id="bandWidth" name="bandWidth"  >
<input type="hidden"  id="BandWidthOld" name="BandWidthOld"  >
<input type="hidden" id="ipAddress" name="ipAddress"  >
<input type="hidden" id="ipAddressOld" name="ipAddressOld"  >
<input type="hidden" id="deviceCode" name="deviceCode" > 
<input type="hidden" id="deviceCodeOld" name="deviceCodeOld"  > 
<input type="hidden" id="portCode" name="portCode"  > 
<input type="hidden" id="portCodeOld" name="portCodeOld"  > 
<input type="hidden" id="model" name="model"  >
<input type="hidden" id="modelOld" name="modelOld"  >
<input type="hidden" id="factory" name="factory"  > 
<input type="hidden"id="factoryOld" name="factoryOld"  > 
<input type="hidden"id="cctId" name="cctId"  > 
<input type="hidden"id="cctIdOld" name="cctIdOld"  > 
<%@ include file="/npage/include/footer.jsp" %> 
</form>
</body>
</html>	
