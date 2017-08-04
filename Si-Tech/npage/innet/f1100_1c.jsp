<%
/********************
 version v2.0
开发商: si-tech
*
*update:zhanghonga@2008-08-22 页面改造,修改样式
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%        
		String opCode = "1104";
		String opName = "普通开户";
    String workNo = (String)session.getAttribute("workNo");
    String workName = (String)session.getAttribute("workName");
    String Department = (String)session.getAttribute("orgCode");
    String belongCode = Department.substring(0,7);
    String ip_Addr = (String)session.getAttribute("ipAddr");
    String regionCode = Department.substring(0,2);
		String rowNum = "16";
		String getAcceptFlag = "";
%>
<!------------------------------------------------------------->

<html>
<head>
<title>客户开户</title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
</head>

<SCRIPT type=text/javascript>
	var numStr="0123456789"; 
	onload=function(){
	  document.all.newCust.focus();
	  if(typeof(frm1100.oldCust)!="undefined"){   //判断是否是并老户
	    if(frm1100.oldCust.checked == true){	
	        var obj="tbs"+9;           
	        document.all(obj).style.display="";
	    }
	  } 
	
	  if((typeof(frm1100.idType)!="undefined")&&(typeof(frm1100.idIccid)!="undefined")){//还原到提交前的证件类型   	
	  	change_idType();	
	  }  
	}

function for0_9(obj) //判断字符是否由0－9个数字组成
{  
	
    if (!forString(obj)){
	  ltflag = 1;
	  obj.select();
	  obj.focus();
	  return false;
	}else{
	  if (obj.value.length == 0){
	    return true;
	  }
	}    
	if (!isMadeOf(obj.value,numStr)){
      flag = 1;
      rdShowMessageDialog("'" + obj.v_name + "'的值不正确！请输入数字！");
	  obj.select();
	  obj.focus();
	  return false;
    }	
	return true;	
}
function isMadeOf(val,str)
{

	var jj;
	var chr;
	for (jj=0;jj<val.length;++jj){
		chr=val.charAt(jj);
		if (str.indexOf(chr,0)==-1)
			return false;			
	}
	
	return true;
}

function doProcess(packet)
{
    //AJAX处理函数findValueByName
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode"); 
    var retMessage = packet.data.findValueByName("retMessage"); 
    self.status="";
		if(retCode.trim()=="")
		{
	     rdShowMessageDialog("调用"+retType+"服务时失败！");
	     return false;
		}
    //---------------------------------------    
    if(retType == "ClientId")
    {
            //得到新建客户ID
        var retnewId = packet.data.findValueByName("retnewId");
        if(retCode=="000000")
        {
            document.frm1100.custId.value = retnewId;
            document.frm1100.temp_custId.value = retnewId;
            document.frm1100.districtCode.focus();
						document.frm1100.districtCode.focus();
						document.all.read_idCard_one.disabled=false;//身份证扫描按钮 2009-8-13 17:05 hejwa增加
						document.all.read_idCard_two.disabled=false;
						document.all.scan_idCard_two.disabled=false;
		 
        }
        else
        {
        		retMessage = retMessage + "[errorCode1:" + retCode + "]";
            rdShowMessageDialog(retMessage);
						return false;
        }       
     }
    //-----------------------------------------
    if(retType == "checkPwd")
    {
        //进行密码校验
        var retResult = packet.data.findValueByName("retResult");
				frm1100.checkPwd_Flag.value = retResult; 
	    	if(frm1100.checkPwd_Flag.value == "false")
	    {
	    	rdShowMessageDialog("上级客户密码校验失败，请重新输入！");
	    	frm1100.parentPwd.value = "";
	    	frm1100.parentPwd.focus();
	    	frm1100.checkPwd_Flag.value = "false";	    	
	    	return false;	        	
	    }else{
				rdShowMessageDialog("上级客户密码校验成功！");
			}
			
		//为伊春简单密码做判断
		if("09" == "<%=regionCode%>"){
			if(document.frm1100.parentPwd.value == "000000"||document.frm1100.parentPwd.value == "111111"||document.frm1100.parentPwd.value == "222222"
		 	 ||document.frm1100.parentPwd.value == "333333"||document.frm1100.parentPwd.value == "444444"||document.frm1100.parentPwd.value == "555555"
		 	 ||document.frm1100.parentPwd.value == "666666"||document.frm1100.parentPwd.value == "777777"||document.frm1100.parentPwd.value == "888888"
		 	 ||document.frm1100.parentPwd.value == "999999"||document.frm1100.parentPwd.value == "123456")
	   		{
	   			rdShowMessageDialog("密码过于简单，请修改后再办理业务！");
	   			return false;
	   		}
	   	}	
     }        
    //----------------------------------------
    if(retType == "getInfo_withID")
    {
        clear_CustInfo();  
        if(retCode == "000000")
        {
           var retInfo = packet.data.findValueByName("retInfo");
           if(retInfo != "")
           {       
               for(i=0;i<7;i++)
               {           
                    var chPos = retInfo.indexOf("|");
                    valueStr = retInfo.substring(0,chPos);
                    retInfo = retInfo.substring(chPos+1);
                    var obj = "in" + i;
                    document.all(obj).value = valueStr;
                } 
             }
			 else
			 {
			   rdShowMessageDialog("客户不存在！");  
			   return false;
			 }
         }           
         else
         {
             retMessage = retMessage + "[errorCode2:" + retCode + "]";
             rdShowMessageDialog(retMessage);
			 			 return false;
         }
     }
	 
	 
	 if(retType=="chkX"){
	    var retObj = packet.data.findValueByName("retObj");
			if(retCode == "000000"){
					rdShowMessageDialog("验证通过!");			
          document.all.print.disabled=false;
          document.all.uploadpic_b.disabled=false;
		  }else if(retCode=="100001"){
         retMessage = "提示 ："+retMessage;
         rdShowMessageDialog(retMessage);
         document.all.uploadpic_b.disabled=false;
	 			 return true;
      }else{
				 retMessage = "错误" + retCode + "："+retMessage;			 
	       rdShowMessageDialog(retMessage);
			   document.all.print.disabled=true;
			   document.all.uploadpic_b.disabled=true;
				 document.all(retObj).focus();
				 return false;
		}
	}
   //=================================================================
}
//--------------------------------------------
//清空上级客户信息
function clear_CustInfo()
{
        for(i=0;i<6;i++)
        {          
                var obj = "in" + i;
                document.all(obj).value = "";
        }
}
//--------------------------------------------
function init(){
	if("09" == "<%=regionCode%>"){
		var divPassword = document.getElementById("divPassword");	
			divPassword.style.display="none";
	}
}

function check_newCust(){
	
	if("09" == "<%=regionCode%>"){
		var divPassword = document.getElementById("divPassword");	
			divPassword.style.display="none";
	} 
	
		if(document.all.idType.value=="0"){
			document.all("card_id_type").style.display=""; 
			} 
	  if(document.all.custQuery.disabled==true){document.all.custQuery.disabled=false}
     frm1100.parentId.v_type="";
	    document.all.Reset.click();
         //新建客户的相关域控制
        if(document.frm1100.newCust.checked == true){
        window.document.frm1100.oldCust.checked = false;
        var temp1="tbs"+9;           
            document.all(temp1).style.display = "none";
            window.document.frm1100.parentId.value = "";
            window.document.frm1100.parentPwd.value = "";
            window.document.frm1100.parentName.value = "";
            window.document.frm1100.parentAddr.value = "";
            window.document.frm1100.parentIdType.value = "";
            window.document.frm1100.parentIdidIccid.value = "";
        }
}
function check_oldCust(){
	if("09" == "<%=regionCode%>"){
		var divPassword = document.getElementById("divPassword");	
			divPassword.style.display="none";
	}
	
	document.all.Reset.click();
	document.all.oldCust.checked=true;
	document.all("card_id_type").style.display="none";  
         //并客户的相关域控制    
    if(document.frm1100.oldCust.checked == true)
    {
        window.document.frm1100.newCust.checked = false;
        var temp2="tbs"+9;           
            document.all(temp2).style.display="";
    }
}

function change(){      
        //对附加资料隐藏域的控制       
        var ic = document.frm1100.ownerType.options[document.frm1100.ownerType.selectedIndex].value;       
		if(ic=="01")
	    { 
          document.all("tb0").style.display="";   
		   document.all("tb1").style.display="none";      
		   document.all("td2").style.display="none";
		}
		else if(ic=="02")
	    {
         document.all("tb0").style.display="none";
		   document.all("tb1").style.display="none";
  		   document.all("td2").style.display="none";   
		}       
		else if(ic=="03")
		{
         document.all("tb0").style.display="none";
		   document.all("tb1").style.display="none";
  		   document.all("td2").style.display="";   		
		}
}

	function change_idType(){
	    var Str = document.frm1100.idType.value;
	    
	    var oldCustType = document.frm1100.oldCust.checked;
	    var newCustType = document.frm1100.newCust.checked;
	    
			if(oldCustType){	   
			document.all("card_id_type").style.display="none";  
			}else if(newCustType){
	    if(Str=="0")
	     { 
	     	document.all("card_id_type").style.display="";    
	    	document.frm1100.idIccid.v_type = "idcard";   
	    	}
	    else
	    { 
	    	document.all("card_id_type").style.display="none";  
	    	document.frm1100.idIccid.v_type = "string";   
	    	}
	    	
	    }
	}
function change_custPwd()
{
    check_HidPwd(frm1100.parentPwd.value,"show",frm1100.in1.value.trim(),"hid");
    /*
    if(frm1100.checkPwd_Flag.value != "true");
    {
    	rdShowMessageDialog("上级客户密码校验失败，请重新输入！");
    	frm1100.parentPwd.value = "";
    	frm1100.parentPwd.focus();
    	return false;	        	
    }
    frm1100.checkPwd_Flag.value = "false"; 
    */
}
//------------------------------------
function printCommit(){
	
				var obj = null;
		//先确认打印电子免填单，在打印发票
        if(frm1100.oldCust.checked == true)
        {	//并老户必输项判断
        	//parentId parentPwd parentIdidIccid parentName
        	
        	if(document.frm1100.parentIdidIccid.value.trim().len()==0){
        		rdShowMessageDialog("上级客户证件号码不能为空!");
        		return false;	
        	}
        	
        	if(document.frm1100.parentName.value.trim().len()==0){
        		rdShowMessageDialog("上级客户名称不能为空!");
        		return false;	
        	}

        	if(document.frm1100.parentId.value.trim().len()==0){
        		rdShowMessageDialog("上级客户ID不能为空!");
        		return false;	
        	}
       	
	        if(frm1100.parentId.value == "")
	        {	
	        	rdShowMessageDialog("选择并老户，客户ID不能为空！");
	        	frm1100.parentId.focus();
	        	return false;
	        }
	     
	        if(frm1100.parentIdidIccid.value == "")
	        {	
	        	rdShowMessageDialog("选择并老户，客户证件号码不能为空！");
	        	frm1100.parentIdidIccid.focus();
	        	return false;
	        }
	        if(frm1100.parentName.value == "")
	        {	
	        	rdShowMessageDialog("选择并老户，客户名称不能为空！");
	        	frm1100.parentName.focus();
	        	return false;
	        }
	        if(document.frm1100.parentName.value.trim().indexOf('~')>0)
			{
				rdShowMessageDialog("上级客户名称中有非法字符'~'，请修改！",0);
				return false;
			}	
			if(document.frm1100.parentAddr.value.trim().indexOf('~')>0)
			{
				rdShowMessageDialog("上级客户地址中有非法字符'~'，请修改！",0);
				return false;
			}		  
        }
        
        
        //不论是新建户,还是并老户,都要验证的部分
		    if(frm1100.newCust.checked ==true||frm1100.oldCust.checked==true){
					if(document.frm1100.custId.value.trim().len()==0){
						rdShowMessageDialog("客户ID不能为空!");
						return false;
					}
					
					if(document.frm1100.custName.value.trim().len()==0){
						rdShowMessageDialog("客户名称不能为空!");
						return false;
					}
					if(document.frm1100.custName.value.trim().indexOf('~')>0)
					{
						rdShowMessageDialog("客户名称中有非法字符'~'，请修改！",0);
						return false;
					}	
					if(document.frm1100.idIccid.value.trim().len()==0){
						rdShowMessageDialog("证件号码不能为空!");
						return false;
					}	
					
					if(document.frm1100.contactPerson.value.trim().indexOf('~')>0)
					{
						rdShowMessageDialog("联系人姓名中有非法字符'~'，请修改！",0);
						return false;
					}	
					if(document.frm1100.contactPhone.value.trim().indexOf('~')>0)
					{
						rdShowMessageDialog("联系人电话中有非法字符'~'，请修改！",0);
						return false;
			
					}
						
					if(document.frm1100.idAddr.value.trim().len()==0){
						rdShowMessageDialog("证件地址不能为空!");
						return false;
					}	
					if(document.frm1100.idAddr.value.trim().indexOf('~')>0)
					{
						rdShowMessageDialog("证件地址中有非法字符'~'，请修改！",0);
						return false;
					}	
					if(document.frm1100.contactPhone.value.trim().len()==0){
						rdShowMessageDialog("联系人电话不能为空!");
						return false;
					}			
		
					if(document.frm1100.contactAddr.value.trim().len()==0){
						rdShowMessageDialog("联系人地址不能为空!");
						return false;
					}	
					if(document.frm1100.contactAddr.value.trim().indexOf('~')>0)
					{
						rdShowMessageDialog("联系人地址中有非法字符'~'，请修改！",0);
						return false;
					}	
					if(document.frm1100.contactMAddr.value.trim().len()==0){
						rdShowMessageDialog("联系人通讯地址不能为空!");
						return false;
					}	
					if(document.frm1100.contactMAddr.value.trim().indexOf('~')>0)
					{
						rdShowMessageDialog("联系人通讯地址中有非法字符'~'，请修改！",0);
						return false;
					}						
				}
        
        
        if(frm1100.newCust.checked ==true){
					frm1100.parentId.v_type="";
				}
				
        change_idType();   //判断客户证件类型是否是身份证
         
        if(frm1100.contactMail.value.trim() == "")
        {
					frm1100.contactMail.value = "";       	
        }
        //判断生日、证件有效期有效性	birthDay	idValidDate
        obj = "tb" + 0;
        obj1 = "tb" + 1;
        if((typeof(frm1100.birthDay)!="undefined")&&
           (frm1100.birthDay.value != "")&&
           (document.all(obj).style.display == ""))
        {	
        	if(forDate(frm1100.birthDay) == false)
        	{	return false;		}
        }else if((typeof(frm1100.yzrq)!="undefined")&&
           (frm1100.yzrq.value != "")&&
           (document.all(obj1).style.display == ""))
        {	
        	if(forDate(frm1100.yzrq) == false)
        	{	return false;		}			
        }


 var upflag =document.all.up_flag.value;
if(upflag==3&&(document.all.but_flag.value =="1"))
{
	rdShowMessageDialog("请选择jpg类型图像文件");
	return false;
	}
if(upflag==4&&(document.all.but_flag.value =="1"))
{
	rdShowMessageDialog("请先扫描或读取证件信息");
	return false;
	}
	
	
if(upflag==5&&(document.all.but_flag.value =="1"))
{
	rdShowMessageDialog("请选择最后一次扫描或读取证件而生成的证件图像文件"+document.all.pic_name.value);
	return false;
	}
			
if((document.all.but_flag.value =="1")&&document.all.upbut_flag.value=="0"){
	rdShowMessageDialog("请先上传身份证照片",0);
	return false;
	}
			
				var d= (new Date().getFullYear().toString()+(((new Date().getMonth()+1).toString().length>=2)?(new Date().getMonth()+1).toString():("0"+(new Date().getMonth()+1)))+(((new Date().getDate()).toString().length>=2)?(new Date().getDate()):("0"+(new Date().getDate()))).toString());
		
				if(frm1100.idValidDate.value.trim().len()>0){		 
		       if(forDate(frm1100.idValidDate)==false) return false;
		
				   if(to_date(frm1100.idValidDate)<=d)
				   {
					  		rdShowMessageDialog("证件有效期不能早于当前时间，请重新输入！");
			          document.all.idValidDate.focus();
					  		document.all.idValidDate.select();
				      	return false;
				   }
				}

				if(document.all.ownerType.options[document.all.ownerType.selectedIndex].text=="个人")
				{
		             if(document.all.birthDay.value.trim().len()>0)
				     {
				       if(to_date(frm1100.birthDay)>=d)
				       {
					     		 rdShowMessageDialog("出生日期期不能晚于当前时间，请重新输入！");
			             document.all.birthDay.focus();
					         document.all.birthDay.select();
				           return false;
				       }
					 }
				}else{
						 document.all.birthDay.v_type="";
		         if(document.all.yzrq.value.trim().len()>0)
				     {
				       if(to_date(frm1100.yzrq)<=d)
				       {
					     			rdShowMessageDialog("营业执照有效期不能早于当前时间，请重新输入！");
			              document.all.yzrq.focus();
					     			document.all.yzrq.select();
				         		return false;
				       }
					 }
				}
				 
	     if(document.all.custPwd.value.trim().len()>0){
			     if(document.all.custPwd.value.length!=6){
		   				rdShowMessageDialog("客户密码长度有误！");
	            document.all.custPwd.focus();
		   				return false;
				 		}
			      if(checkPwd(document.frm1100.custPwd,document.frm1100.cfmPwd)==false){
				    	return false;
				  	}
		  	}
		  	
	      var t = null;
	      var i;
	      if(document.frm1100.newCust.checked == true){
	           document.frm1100.parentId.value = document.frm1100.custId.value;
	           sysNote = "新建户:" + document.frm1100.ownerType.value + ":客户ID[" + 
	           document.frm1100.custId.value + "]:上级客户[" + 
	           document.frm1100.custId.value + "]";
	      }else{
	      		 sysNote = "并老户:" + document.frm1100.ownerType.value + ":客户ID[" + 
	           document.frm1100.custId.value + "]:上级客户[" + 
	           document.frm1100.parentId.value + "]";
	      }
	      document.frm1100.sysNote.value = sysNote;
				if(document.all.opNote.value.trim().len()==0){
	         document.all.opNote.value="操作员<%=workNo%>"+"对客户"+document.all.custId.value.trim()+"("+document.all.ownerType.options[document.all.ownerType.selectedIndex].text+")进行客户开户业务。"
				}
	      showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");   
}

function chkValid()
{
     var d= (new Date().getFullYear().toString()+(((new Date().getMonth()+1).toString().length>=2)?(new Date().getMonth()+1).toString():("0"+(new Date().getMonth()+1)))+(((new Date().getDate()).toString().length>=2)?(new Date().getDate()):("0"+(new Date().getDate()))).toString());

	 if(frm1100.idValidDate.value.trim().len()>0)
	 {		 
        if(forDate(frm1100.idValidDate)==false) return false;

	    if(to_date(frm1100.idValidDate)<=d)
	    {
		  rdShowMessageDialog("证件有效期不能早于当前时间，请重新输入！");
	      document.all.idValidDate.focus();
		  	document.all.idValidDate.select();
	      return false;
	    }
	}
}

/*** dujl add at 20090806 for R_HLJMob_cuisr_CRM_PD3_2009_0314@关于规范客户开户过程中基本资料中非法字符校验的需求 ****/
function feifa(textName)
{
	if(textName.value != "")
	{
		if((textName.value.indexOf("~")) != -1 || (textName.value.indexOf("|")) != -1 || (textName.value.indexOf(";")) != -1)
		{
			rdShowMessageDialog("不允许输入非法字符，请重新输入！");
			textName.value = "";
 	  		return;
		}
	}
}

function to_date(obj)
{
  var theTotalDate="";
  var one="";
  var flag="0123456789";
  for(i=0;i<obj.value.length;i++)
  { 
     one=obj.value.charAt(i);
     if(flag.indexOf(one)!=-1)
		 theTotalDate+=one;
  }
  return theTotalDate;
}
//-------------------------------------------------------
function printInfo(printType)
{
    var retInfo = "";
    if(printType == "Detail")
    {	//打印电子免填单
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="workno"  routerValue="<%=workNo%>" id="printAccept"/>    	
        var getAcceptFlag = "<%=getAcceptFlag%>";
        if(getAcceptFlag == "failed")
        {	return "failed";	}
	    //retInfo = retInfo + "10|2|0|0|打印流水:  " + "<%=printAccept%>" + "|";
		
		//打印电子免填单
        retInfo+=frm1100.custId.value+"|";
		retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		retInfo+= frm1100.custName.value+"|";
		//retInfo+=" |";
		retInfo+=frm1100.contactPhone.value+"|";
		retInfo+= frm1100.contactAddr.value+"|";
		retInfo+=frm1100.idIccid.value+"|";
		retInfo+=" "+"|";
		retInfo+= "客户开户。*|";

		retInfo+=document.all.sysNote.value+"|";
		retInfo+=document.all.opNote.value+"|";
        
		retInfo+=" |";

		//担保人信息(oneTok:12-15)
        retInfo+=document.all.assu_name.value+"|";
		retInfo+=document.all.assu_phone.value+"|";
		retInfo+=document.all.assu_idAddr.value+"|";
		retInfo+=document.all.assu_idIccid.value+"|";


	}  
    if(printType == "Bill")
    {	//打印发票
	}
	return retInfo;	
}
//-----------------------------------------------------------
function showPrtDlg(printType,DlgMessage,submitCfm)
{ 
   with(document.all)
   {	
			if(frm1100.idValidDate.value =="")
			{
				frm1100.idValidDate.value="20500101";
			}
			if(frm1100.birthDay.value =="")
			{
				frm1100.birthDay.value="19000101";
			}
			var i;
			var obj = null;
			for(i=0;i<frm1100.length;i++)
			{
				 obj = frm1100.elements[i];
				if(obj.value == "")
				{
					frm1100.elements[i].value="unknow";
				}
			}
		
		   window.opener.document.all.str1.value=custId.value+"~<%=regionCode%>"+districtCode.value+"999"+"~"+custName.value+"~"+custPwd.value+"~"+custStatus.value+"~"+"00"+"~"+ownerType.value+"~"+custAddr.value+"~";
		   window.opener.document.all.str2.value=idType.value+"~"+idIccid.value+"~"+idAddr.value+"~"+idValidDate.value+"~";
		   window.opener.document.all.str3.value=contactPerson.value+"~"+contactPhone.value+"~"+contactAddr.value+"~"+contactPost.value+"~"+contactMAddr.value+"~"+contactFax.value+"~"+contactMail.value+"~";
		   window.opener.document.all.str4.value="<%=Department%>"+"~"+parentId.value+"~"+custSex.value+"~"+birthDay.value+"~"+professionId.value+"~"+vudyXl.value+"~"+custAh.value+"~"+custXg.value+"~";
		   window.opener.document.all.str5.value="1104"+"~"+"<%=workNo%>"+"~"+sysNote.value+"~"+opNote.value+"~"+ip_Addr.value+"~"+oriGrpNo.value+"~";
	
		   window.opener.document.all.idIccid.value=document.all.idIccid.value;
	      window.opener.document.all.custName.value=document.all.custName.value;
		   window.opener.document.all.idType.value=document.all.idType.options[document.all.idType.selectedIndex].text;
		   window.opener.document.all.custId.value=document.all.custId.value;
		   window.opener.document.all.custAddr.value=document.all.custAddr.value;
	 
    }
	 window.close();
}
//--------------------------------------
function checkPwd(obj1,obj2)
{
        //密码一致性校验,明码校验
        var pwd1 = obj1.value;
        var pwd2 = obj2.value;
        if(pwd1 != pwd2)
        {
                var message = "'密码'和'效验密码'不一致，请重新输入！";
                rdShowMessageDialog(message);
                if(obj1.type != "hidden")
                {   obj1.value = "";    }
                if(obj2.type != "hidden")
                {   obj2.value = "";    }
                obj1.focus();
                return false;
        }
				var iccid = document.frm1100.idIccid.value;
				var len = document.frm1100.idIccid.value.length;
				var iccid1 = iccid.substr(len-4,4);
				var pass = "00"+iccid1;
			   	if("<%=regionCode%>"=="09"){
					if(pwd1 == "000000"||pwd1 == "111111"||pwd1 == "222222"
				 	 ||pwd1 == "333333"||pwd1 == "444444"||pwd1 == "555555"
					 ||pwd1 == "666666"||pwd1 == "777777"||pwd1 == "888888"
				 	 ||pwd1 == "999999"||pwd1 == "123456")
			  		 {
			           		rdShowMessageDialog("密码过于简单，请重新设置！");
					   		return false;
			   		 }
			   	}else{
			   	 	 if(pwd1 == "000000"||pwd1 == "001234"||pwd1 == pass)
			  		 {
			           		rdShowMessageDialog("密码过于简单，请及时修改！");
					   		return false;
			   		 }
			   	}
			   	 
		    return true;
}
//-----------------------------------
function check_HidPwd(Pwd1,Pwd1Type,Pwd2,Pwd2Type)
{
	/*
  		Pwd1,Pwd2:密码
  		wd1Type:密码1的类型；Pwd2Type：密码2的类型      show:明码；hid：密码
  	
	if(Pwd1.trim().len()==0)
	{
        rdShowMessageDialog("客户密码不能为空！");
        frm1100.custPwd.focus();
		return false;
	}
    else 
	{
	   if(Pwd2.trim().len()==0)
	   {
         rdShowMessageDialog("原始客户密码为空，请核对数据！");
         frm1100.custPwd.focus();
		 		 return false;
	   }
	}*/

    var checkPwd_Packet = new AJAXPacket("pubCheckPwd.jsp","正在进行密码校验，请稍候......");
    checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("Pwd1",Pwd1);
	checkPwd_Packet.data.add("Pwd1Type",Pwd1Type);
	checkPwd_Packet.data.add("Pwd2",Pwd2.trim());
	checkPwd_Packet.data.add("Pwd2Type",Pwd2Type);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet=null;
	
	if("<%=regionCode%>"=="09"){
		if(pwd1 == "000000"||pwd1 == "111111"||pwd1 == "222222"
		 ||pwd1 == "333333"||pwd1 == "444444"||pwd1 == "555555"
		 ||pwd1 == "666666"||pwd1 == "777777"||pwd1 == "888888"
		 ||pwd1 == "999999"||pwd1 == "123456")
		{
			rdShowMessageDialog("密码过于简单，请修改后再办理业务！");
			return false;
		}
	}
			
}
//-----------------------------------------------------------
function getId()
{
    //得到客户ID
        document.frm1100.custId.readonly = true;
        document.frm1100.custQuery.disabled = true;   
    	var getUserId_Packet = new AJAXPacket("f1100_getId.jsp","正在获得客户ID，请稍候......");
    	getUserId_Packet.data.add("retType","ClientId");
        getUserId_Packet.data.add("region_code","<%=regionCode%>");
        getUserId_Packet.data.add("idType","0");
        getUserId_Packet.data.add("oldId","0");
        core.ajax.sendPacket(getUserId_Packet);
        getUserId_Packet=null;
}
//-----------------------------------------
function choiceSelWay()
{	
 	//选择客户信息的查询方式
	if(frm1100.parentId.value != "")
	{	//按客户ID进行查询
		getInfo_withId();	
		return true;
	}
	if(frm1100.parentIdidIccid.value != "")
	{	
 		getInfo_IccId();
		return true;
	}
	if(frm1100.parentName.value != "")
	{	
		getInfo_withName();
		return true;
	}
 	rdShowMessageDialog("客户信息可以以ID、证件号码或名称进行查询，请输入其中任意项作为查询条件！");
}
//------------------------------------------------------------------------
function getInfo_withId()
{
    //根据客户ID得到相关信息
    if(document.frm1100.parentId.value == "")
    {
        rdShowMessageDialog("请输入客户ID！");
        return false;
    }
	/**
	else
	{
	  if(document.all.parentId.value.trim().len()!=10)
	  {
         rdShowMessageDialog("客户ID长度有误！");
         return false;
	  }
	}
	*/
    if(for0_9(frm1100.parentId) == false)
    {	
    	frm1100.parentId.value = "";
    	return false;	
    }
    var getIdPacket = new AJAXPacket("fpsb_rpc.jsp","正在获得上级客户信息，请稍候......");
        var parentId = document.frm1100.parentId.value;
        getIdPacket.data.add("retType","getInfo_withID");
        getIdPacket.data.add("fieldNum","6");
        getIdPacket.data.add("sqlStr",parentId);
        core.ajax.sendPacket(getIdPacket);
        delete(getIdPacket); 
}   

//------------------------------------------------------------
function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    /*
    参数1(pageTitle)：查询页面标题
    参数2(fieldName)：列中文名称，以'|'分隔的串
    参数3(sqlStr)：sql语句
    参数4(selType)：类型'S' rediobutton 'M' checkbox
    参数5(retQuence)：返回域信息，返回域个数＋ 返回域标识，以'|'分隔，如"3|0|2|3"表示返回3个域0，2，3
    参数6(retToField))：返回值存放域的名称,以'|'分隔
    */
    var path = "pubGetCustInfo.jsp";  //密码不显示
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    /*
    var ret = window.open (path, "银行代码", 
                "height=400, width=500,left=200, top=200,toolbar=no,menubar=no, scrollbars=yes, resizable=no, location=no, status=yes"); 
        ret.opener.bankCode.value = "1111111111";
        */      
    retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:35;");
    clear_CustInfo();  
    if(typeof(retInfo)=="undefined")   
    {   return false;   }
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
//-----------------------------------------------------
function custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    /*
    参数1(pageTitle)：查询页面标题
    参数2(fieldName)：列中文名称，以'|'分隔的串
    参数3(sqlStr)：sql语句
    参数4(selType)：类型1 rediobutton 2 checkbox
    参数5(retQuence)：返回域信息，返回域个数＋ 返回域标识，以'|'分隔，如"3|0|2|3"表示返回3个域0，2，3
    参数6(retToField))：返回值存放域的名称,以'|'分隔
    */
    var path = "psbgetCustInfo.jsp";   //密码为*
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  

    var retInfo = window.showModalDialog(path,"","dialogWidth:70;dialogHeight:35;");
    if(typeof(retInfo) == "undefined")     
    {   return false;   }
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
	rpc_chkX("parentIdType","parentIdidIccid","A");
}
//--------------------add by baixf 20080221 需要039
function custInfoQueryJustSee(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    /*
    参数1(pageTitle)：查询页面标题
    参数2(fieldName)：列中文名称，以'|'分隔的串
    参数3(sqlStr)：sql语句
    参数4(selType)：类型1 rediobutton 2 checkbox
    参数5(retQuence)：返回域信息，返回域个数＋ 返回域标识，以'|'分隔，如"3|0|2|3"表示返回3个域0，2，3
    参数6(retToField))：返回值存放域的名称,以'|'分隔
    */
    var path = "psbgetCustInfo2.jsp";   //密码为*
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  

    var retInfo = window.showModalDialog(path,"","dialogWidth:60;dialogHeight:35;");
    if(typeof(retInfo) == "undefined")     
    {   return false;   }
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
	rpc_chkX("parentIdType","parentIdidIccid","A");
}
//-------------------------------------------------
function getInfo_withName()
{ 
        ////根据客户名称得到相关信息
    if(document.frm1100.parentName.value == "")
    {
        rdShowMessageDialog("请输入客户名称！");
        return false;
    }
    var pageTitle = "客户信息查询";
    var fieldName = "客户ID|客户名称|开户时间|证件类型|证件号码|客户地址|归属代码|客户密码|";
    var sqlStr = "CUST_NAME="+frm1100.parentName.value;
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "7|0|1|3|4|5|6|7|";
    var retToField = "in0|in4|in3|in2|in5|in6|in1|"; 
    custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)                           
}

//-------------------------------------------------
function getInfo_IccId()
{ 
    //根据客户证件号码得到相关信息
    if(document.frm1100.parentIdidIccid.value.trim().len() == 0)
    {
        rdShowMessageDialog("请输入客户证件号码！");
        return false;
    }
	else if(document.frm1100.parentIdidIccid.value.trim().len() < 5)
	{
        rdShowMessageDialog("证件号码长度有误（最少五位）！");
        return false;
	}

    var pageTitle = "客户信息查询";
    var fieldName = "客户ID|客户名称|开户时间|证件类型|证件号码|客户地址|归属代码|客户密码|";
    var sqlStr = "ID_ICCID="+document.frm1100.parentIdidIccid.value; 
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "7|0|1|3|4|5|6|7|";
    var retToField = "in0|in4|in3|in2|in5|in6|in1|";
    custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);                    
}
//---------------add by baixf 20080221 需求039 新增客户时可以查询录入的身份证在系统中的使用信息。
function getInfo_IccId_JustSee()
{ 

		if(document.all.idType.options[document.all.idType.selectedIndex].text.trim()=="身份证"){
			if(!forIdCard(document.all.idIccid)){
		   				return false;
			}
		}else{
			hiddenTip(document.all.idIccid);
		}
		
    //根据客户证件号码得到相关信息
    if(document.frm1100.idIccid.value.trim().len() == 0)
    {
        rdShowMessageDialog("请输入客户证件号码！");
        return false;
    }else if(document.frm1100.idIccid.value.trim().len() < 5){
        rdShowMessageDialog("证件号码长度有误（最少五位）！");
        return false;
	  }

    var pageTitle = "客户信息查询";
    var fieldName = "服务号码|开户时间|证件类型|证件号码|归属地|状态|";
    var sqlStr = "ID_ICCID="+document.frm1100.idIccid.value; 
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "7|0|1|3|4|5|6|7|";
    var retToField = "in0|in4|in3|in2|in5|in6|in1|";
    custInfoQueryJustSee(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);                    
}

function get_inPara()
{
    //组织传人的参数
    var inPara_Str = "";    
        inPara_Str = inPara_Str + document.frm1100.temp_custId.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.regionCode.value + "|" + document.frm1100.districtCode.value + "|";
        inPara_Str = inPara_Str + document.frm1100.custName.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.custPwd.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.custStatus.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.custGrade.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.ownerType.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.custAddr.value + "|";
        var tempStr = document.frm1100.idType.value; 
        inPara_Str = inPara_Str + tempStr.substring(0,tempStr.indexOf("|")) + "|"; 
        inPara_Str = inPara_Str + document.frm1100.idIccid.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.idAddr.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.idValidDate.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.contactPerson.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.contactPhone.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.contactAddr.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.contactPost.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.contactMAddr.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.contactFax.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.contactMail.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.unitCode.value + "|"; //机构代码
        inPara_Str = inPara_Str + document.frm1100.parentId.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.custSex.value + "|";  //客户性别
        inPara_Str = inPara_Str + document.frm1100.birthDay.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.professionId.value + "|"; 
        inPara_Str = inPara_Str + document.frm1100.vudyXl.value + "|"; //学历
        inPara_Str = inPara_Str + document.frm1100.custAh.value + "|"; //客户爱好 
        inPara_Str = inPara_Str + document.frm1100.custXg.value + "|"; //客户习惯
        inPara_Str = inPara_Str + document.frm1100.unitXz.value + "|"; //单位性质
        inPara_Str = inPara_Str + document.frm1100.yzlx.value + "|"; //执照类型
        inPara_Str = inPara_Str + document.frm1100.yzhm.value + "|"; //执照号码
        inPara_Str = inPara_Str + document.frm1100.yzrq.value + "|"; //执照有效期
        inPara_Str = inPara_Str + document.frm1100.frdm.value + "|"; //法人代码
        inPara_Str = inPara_Str + document.frm1100.groupCharacter.value + "|";//群组信息
        inPara_Str = inPara_Str + "1100" + "|";
        inPara_Str = inPara_Str + document.frm1100.workno.value + "|";  
        inPara_Str = inPara_Str + document.frm1100.sysNote.value + "|";
        inPara_Str = inPara_Str + document.frm1100.opNote.value + "|";  
        document.frm1100.inParaStr.value = inPara_Str;
}

//---------------------------------------------------
function jspReset()
{
    //页面控件初始化    
    var obj = null;
    var t = null;
        var i;
    for (i=0;i<document.frm1100.length;i++)
    {    
                obj = document.frm1100.elements[i];                                              
                packUp(obj); 
            obj.disabled = false;
    }
    document.frm1100.commit.disabled = "none"; 
} 
//----------------------------------------------------       
function jspCommit()
{
         //页面提交
         document.frm1100.commit.disabled = "none";
         action="f1100_2.jsp"
         frm1100.submit();   //将参数串的输入框提交
}
//------------------------------------------------
function change_ConPerson()
{   //联系人姓名随客户名称改名而改变
	frm1100.contactPerson.value = frm1100.custName.value;
}
function change_ConAddr()
{   //联系人姓名随客户名称改名而改变
	frm1100.contactAddr.value = frm1100.custAddr.value;
	frm1100.contactMAddr.value = frm1100.custAddr.value;
}
//------------------------------------------------


//验证是否是黑名单
function rpc_chkX(x_type,x_no,chk_kind)
{
  var obj_type=document.all(x_type);
  var obj_no=document.all(x_no);
  var idname="";

  if(obj_type.type=="text")
  {
    idname=obj_type.value.trim();
  }else if(obj_type.type=="select-one"){
    idname=obj_type.options[obj_type.selectedIndex].text.trim();  
  }

  if(obj_no.value.trim().len()>0){
    if(obj_no.value.trim().len()<5){
      rdShowMessageDialog("证件号码长度有误（至少5位）！");
	  	obj_no.focus();
  	  return false;
		}else{
	      if(idname=="身份证"){
			      if(!forIdCard(obj_no)){
		   				return false;
						}
		   }else{
		   		hiddenTip(obj_no);
		   }
		}
  }else{
  	return;
  } 

  var x_idType = getX_idno(idname);
  var myPacket = new AJAXPacket("../../npage/innet/chkX.jsp","正在验证黑名单信息，请稍候......");
  myPacket.data.add("retType","chkX");
  myPacket.data.add("retObj",x_no);
  myPacket.data.add("x_idType",x_idType);
  myPacket.data.add("x_idNo",obj_no.value);
  myPacket.data.add("x_chkKind",chk_kind);
  core.ajax.sendPacket(myPacket);
  myPacket=null;
}

//根据证件名称返回适当的数据
function getX_idno(xx)
{
  if(xx==null) return "0";
  
  if(xx=="身份证") return "0";
  else if(xx=="军官证") return "1";
  else if(xx=="驾驶证") return "2";
  else if(xx=="警官证") return "4";
  else if(xx=="学生证") return "5";
  else if(xx=="单位") return "6";
  else if(xx=="校园") return "7";
  else if(xx=="营业执照") return "8";
  else return "0";
}
 
		
function chcek_pic()
{
	
var pic_path = document.all.filep.value;
	
var d_num = pic_path.indexOf("\.");
var file_type = pic_path.substring(d_num+1,pic_path.length);
//判断是否为jpg类型 //厂家设备生成图片固定为jpg类型
if(file_type.toUpperCase()!="JPG")
{ 
		rdShowMessageDialog("请选择jpg类型图像文件");
		document.all.up_flag.value=3;
		document.all.print.disabled=true;
		resetfilp();
	return ;
	}

	var pic_path_flag= document.all.pic_name.value;
	
	if(pic_path_flag=="")
	{
	rdShowMessageDialog("请先扫描或读取证件信息");
	document.all.up_flag.value=4;
	document.all.print.disabled=true;
	resetfilp();
	return;
}
	else
		{
			if(pic_path!=pic_path_flag)
			{
			rdShowMessageDialog("请选择最后一次扫描或读取证件而生成的证件图像文件"+pic_path_flag);
			document.all.up_flag.value=5;
			document.all.print.disabled=true;
			resetfilp();
		return;
		}
		else{
			document.all.up_flag.value=2;
			}
			}
			
	}
	
	
	function uploadpic(){
	if(document.all.filep.value==""){
		rdShowMessageDialog("请选择要上传的图片",0);
		return;
		}
	if(document.all.but_flag.value=="0"){
		rdShowMessageDialog("请先扫描或读取图片",0);
		return;
		}
	frm1100.target="upload_frame"; 
	
	var actionstr ="f1100_1upp.jsp?custId="+document.frm1100.custId.value+
									"&regionCode="+document.frm1100.regionCode.value+
									"&filep_j="+document.frm1100.filep.value+
									"&card_flag="+document.all.card_flag.value+ 
									"&but_flag="+document.all.but_flag.value+
									"&idSexH="+document.all.idSexH.value+
									"&custName="+document.all.custName.value+
									"&idAddrH="+document.all.idAddrH.value+
									"&birthDayH="+document.all.birthDayH.value+
									"&custId="+document.all.custId.value+
									"&idIccid="+document.all.idIccid.value+
									"&workno="+document.all.workno.value+
									"&upflag=1";
									
									
	frm1100.action = actionstr; 
	document.all.upbut_flag.value="1";
	frm1100.submit()
	resetfilp();
	}
	
	function resetfilp(){
		document.getElementById("filep").outerHTML = document.getElementById("filep").outerHTML;
		}	
		
function changeCardAddr(obj){
	if(document.all.ownerType.value=="01"){
		document.all.custAddr.value=obj.value;
		document.all.contactAddr.value=obj.value;
		document.all.contactMAddr.value=obj.value;
	}
}
</SCRIPT>


<body onload="init()">
<FORM method=post name="frm1100" action="f1100_2.jsp"  onKeyUp="chgFocus(frm1100)"   ENCTYPE="multipart/form-data" >

			<%@ include file="/npage/include/header_pop.jsp" %>     	
							<div class="title">
								<div id="title_zi">请选择操作类型</div>
							</div>
              <table cellspacing="0">
                <tbody> 
                <tr> 
                  <td width="16%" class="blue">操作类型</td>
                  <td class="blue"> 
                    <input name="newCust" onClick="check_newCust()" type="radio" value="new" checked index="2">
                    新建户 
                    <input type="radio" name="oldCust" onClick="check_oldCust()" value="old" index="3">
                    并老户 </td>
                </tr>
                </tbody> 
              </table>                                
              <table id=tbs9 cellspacing="0" style="display:none">
                <tbody> 
                <tr> 
                  <td width="16%" class="blue">上级客户证件号码</td>
                  <td width="34%"> 
                    <input id=in2 name=parentIdidIccid maxlength="20" onKeyUp="if(event.keyCode==13)getInfo_IccId();" index="4">
                    <font class="orange">*</font> 
                    <input name=IDQuery type=button class="b_text" style="cursor:hand" onClick="choiceSelWay()" id="custIdQuery" value=信息查询>
                  </td>
                  <td width="16%" align="left" class="blue">上级客户密码</td>
                  <td width="34%"> 
					    			<jsp:include page="/npage/common/pwd_1.jsp">
		                <jsp:param name="width1" value="16%"  />
		                <jsp:param name="width2" value="34%"  />
		                <jsp:param name="pname" value="parentPwd"  />
		                <jsp:param name="pwd" value="12345"  />
	 	                </jsp:include>
                    <input name=custQuery2 type=button class="b_text" onClick="change_custPwd();" style="cursor:hand" id="accountIdQuery" value=校验>
                  </td>
                </tr>
                <tr> 
                  <td class="blue">上级客户名称</td>
                  <td> 
                    <input id=in4 name=parentName onKeyUp="if(event.keyCode==13)getInfo_withName();" size=35  maxlength="60">
                    <font class="orange">*</font> 
                  </td>
                  <td class="blue">上级客户证件类型</td>
                  <td> 
                    <input id=in3 name=parentIdType readonly>
                  </td>
                </tr>
                <tr> 
                  <td height="17" class="blue">上级客户ID</td>
                  <td height="17"> 
                    <input id="in0" name="parentId" v_type="0_9" v_must=1 v_minlength=10 v_maxlength=14  maxlength="14" onKeyUp="if(event.keyCode==13)getInfo_withId();" onblur="checkElement(this)">
                    <font class="orange">*</font> 
                  </td>
                  <td height="17" class="blue">上级客户地址</td>
                  <td height="17"> 
                    <input id=in5 size=35 name=parentAddr   readonly maxlength="60">
                  </td>
                </tr>
                </tbody> 
              </table>
              <table cellSpacing="0">
                <tbody> 
                <tr> 
                  <td width=16% class="blue">客户类别</td>
                  <td width=34%> 
                    <select align="left" name=ownerType onchange="change()" width=50 index="6">
			       <%
			                String sqlStr ="select TYPE_CODE,TYPE_NAME from sCustTypeCode Order By TYPE_CODE";
			       %>
			       					<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
											<wtc:sql><%=sqlStr%></wtc:sql>
											</wtc:pubselect>
											<wtc:array id="sVerifyTypeArr" scope="end" />
			       <%
											 for(int i=0;i<sVerifyTypeArr.length;i++){
								         if("02".equals(sVerifyTypeArr[i][0])||"04".equals(sVerifyTypeArr[i][0])) {
								            continue;
								         }
								         out.println("<option class='button' value='" + sVerifyTypeArr[i][0] + "'>" + sVerifyTypeArr[i][1] + "</option>");
											 }
							%>
                    </select>
                  </td>
                  <td width=16% class="blue">客户ID</td>
                  <td width="34%"> 
                    <input name=custId v_type="0_9" v_must=1 v_name="客户ID" maxlength="12" readonly>
                    <font class="orange">*</font> 
                    <input name=custQuery type=button class="b_text" onmouseup="getId();" onkeyup="if(event.keyCode==13)getId();" style="cursor:hand" id="accountIdQuery" value=获得 index="7">
                  </td>
                </tr>
                <tr> 
                  <td class="blue">客户归属市县</td>
                  <td> 
                    <select align="left" name=districtCode width=50 index="8">
                    	<wtc:qoption name="sPubSelect" outnum="2">
											<wtc:sql>select trim(DISTRICT_CODE),DISTRICT_NAME from  SDISCODE Where region_code='<%=regionCode%>' order by DISTRICT_CODE</wtc:sql>
											</wtc:qoption>
                    </select>
                  </td>
                  <td class="blue">客户名称</td>
                  <td> 
                    <input name=custName v_must=1 v_maxlength=60 v_type="string" v_name="客户名称" onchange="change_ConPerson()"  maxlength="60" size=30 index="9" onkeyup="feifa(this);" onblur="checkElement(this)">
                    <font class="orange">*</font> 
                  </td>
                </tr>
                <tr> 
                  <td width=16% class="blue">证件类型</td>
                  <td width=34%> 
                    <select align="left" name=idType onChange="change_idType()" width=50 index="10">
                    	<wtc:qoption name="sPubSelect" outnum="2">
											<wtc:sql>select trim(ID_TYPE), ID_NAME from sIdType order by id_type</wtc:sql>
											</wtc:qoption>
                    </select>
                  </td>
                  <td width=16% class="blue">证件号码</td>
                  <td width=34%> 
                    <input name=idIccid v_must=1 v_minlength=5 v_maxlength=20 v_type="string" v_name="证件号码" onChange="change_idType()" maxlength="18"  index="11" onblur="if(checkElement(this));feifa(this);{rpc_chkX('idType','idIccid','A')}" >
                    <font class="orange">*</font> 
                    <input name=IDQueryJustSee type=button class="b_text" style="cursor:hand" onClick="getInfo_IccId_JustSee()" id="custIdQueryJustSee" value=信息查询 >
                  </td>
                </tr>
                
	 <TR id="card_id_type"><!-- hejwa增加身份证扫描、读取 2009-8-13 15:06-->
	    
      <td colspan=2 align=center>
  			<input type="button" name="read_idCard_one" class="b_text"   value="扫描一代身份证" onClick="RecogNewIDOnly_one()" disabled>
				<input type="button" name="read_idCard_two" class="b_text"   value="扫描二代身份证" onClick="RecogNewIDOnly_two()"disabled>
				<input type="button" name="scan_idCard_two" class="b_text"   value="读卡" onClick="Idcard()" disabled>
  			
				</td>
  <td  class="blue">
      	证件照片上传
      </td>
      <td>
      	
				 <input type="file" name="filep" id="filep" onchange="chcek_pic();" >    &nbsp;
				 
				 <iframe name="upload_frame" id="upload_frame" style="display:none"></iframe>
				
				<input type="hidden" name="idSexH" value="1">
  			<input type="hidden" name="birthDayH" value="20090625">
  			<input type="hidden" name="idAddrH" value="哈尔滨">
  			
				 <input type="button" name="uploadpic_b" class="b_text"   value="上传照片" onClick="uploadpic()"  disabled>
      	
      	</td>
     </tr>
                <tr> 
                  <td class="blue">证件地址</td>
                  <td> 
                    <input name=idAddr v_must=1 v_type="string" maxlength="60" v_maxlength=60 size=35 index="12" onblur="if(checkElement(this)){document.all.custAddr.value=this.value;document.all.contactAddr.value=this.value;document.all.contactMAddr.value=this.value;}">
                    <font class="orange">*</font> </td>
                  <td class="blue">证件有效期</td>
                  <td> 
                    <input name=idValidDate v_must=0 v_maxlength=8 v_type="date"  maxlength=8 size="8" index="13" onblur="if(checkElement(this)){chkValid();}"> 
                  </td>
                </tr>
								<tr id ="divPassword" style="display:;"> 
								   	<jsp:include page="/npage/common/pwd_3.jsp">
									  <jsp:param name="width1" value="16%"  />
									  <jsp:param name="width2" value="34%"  />
									  <jsp:param name="pname" value="custPwd"  />
									  <jsp:param name="pcname" value="cfmPwd"  />
								   	</jsp:include>
			    		</div>
                <tr> 
                  <td class="blue">客户状态</td>
                  <td colspan="3"> 
                    <select align="left" name=custStatus width=50 index="16">
	                    	<wtc:qoption name="sPubSelect" outnum="2">
												<wtc:sql>select trim(STATUS_CODE),STATUS_NAME from sCustStatusCode order by STATUS_CODE</wtc:sql>
												</wtc:qoption>
                    </select>
                    <select  align="left" name=custGrade width=50 index="17" style="display:none">
	                    	<wtc:qoption name="sPubSelect" outnum="2">
												<wtc:sql>select trim(OWNER_CODE), TYPE_NAME from sCustGradeCode where REGION_CODE ='<%=regionCode%>' order by OWNER_CODE</wtc:sql>
												</wtc:qoption>
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="blue">客户地址</td>
                  <td colspan="3"> 
                    <input name=custAddr v_type="string" v_must=0 v_maxlength=60  onchange="change_ConAddr()" maxlength="60" size=35 index="18">
                  </td>
                </tr>
                <tr> 
                  <td class="blue">联系人姓名</td>
                  <td> 
                    <input name=contactPerson v_must=0 v_type="string"  maxlength="20" size=20 index="19" v_maxlength="20">                    
                  </td>
                  <td class="blue">联系人电话</td>
                  <td> 
                    <input name=contactPhone v_must=1 v_type="phone"  maxlength="20"  index="20" size="20" onblur="checkElement(this)">
                    <font class="orange">*</font> 
                  </td>
                </tr>
                <tr> 
                  <td class="blue">联系人地址</td>
                  <td> 
                    <input name=contactAddr  v_must=1 v_type="string" maxlength="60" v_maxlength=60 size=35 index="21" onblur="if(checkElement(this)){document.all.contactMAddr.value=this.value;}">
                    <font class="orange">*</font> </td>
                  <td class="blue">联系人邮编</td>
                  <td> 
                    <input name=contactPost v_must=0 v_type="zip"  maxlength="6"  index="22" size="20" onblur="checkElement(this)">                    
                  </td>
                </tr>
                <tr> 
                  <td class="blue">联系人传真</td>
                  <td> 
                    <input name=contactFax v_must=0 v_type="phone"  maxlength="20"  index="23" size="20" onblur="checkElement(this)">
                  </td>
                  <td class="blue">联系人E_MAIL</td>
                  <td> 
                    <input name=contactMail v_must=0 v_type="email" maxlength="30" size=30 index="24" onblur="checkElement(this)">
                  </td>
                </tr>
                <tr> 
                  <td class="blue">联系人通讯地址</td>
                  <td colspan="3"> 
                    <input name=contactMAddr v_must=1 v_maxlenth=60 v_type="string"  maxlength="60" size=35 index="25" onblur="checkElement(this)">
                    <font class="orange">*</font> 
                  </td>
                </tr>
                </tbody> 
              </table> 
                                        
              <table id=tb0 cellSpacing="0">
                <tbody> 
                <tr> 
                  <td width=16% class="blue">客户性别</td>
                  <td width=34%> 
                    <select align="left" name=custSex width=50 index="26">
	                    	<wtc:qoption name="sPubSelect" outnum="2">
												<wtc:sql>select trim(SEX_CODE), SEX_NAME from ssexcode order by SEX_CODE</wtc:sql>
												</wtc:qoption>                    	
                    </select>
                  </td>
                  <td width=16% class="blue">出生日期</td>
                  <td width="34%"> 
                    <input name=birthDay maxlength=8 index="27"  v_must=0 v_maxlength=8 v_type="date"  size="8" onblur="checkElement(this)"> 
                  </td>
                </tr>
                <tr> 
                  <td class="blue">职业类别</td>
                  <td> 
                    <select align="left" name=professionId width=50 index="28">
                    	<wtc:qoption name="sPubSelect" outnum="2">
											<wtc:sql>select trim(PROFESSION_ID), PROFESSION_NAME from sprofessionid order by PROFESSION_ID DESC</wtc:sql>
											</wtc:qoption>                    	
                    </select>
                  </td>
                  <td class="blue">学历</td>
                  <td> 
                    <select align="left" name=vudyXl width=50 index="29">
                    	<wtc:qoption name="sPubSelect" outnum="2">
											<wtc:sql>select trim(WORK_CODE), TYPE_NAME from SWORKCODE Where region_code ='<%=regionCode%>' order by work_code DESC</wtc:sql>
											</wtc:qoption>                     	
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="blue">客户爱好</td>
                  <td> 
                    <input name=custAh v_must=0 maxlength="20"  index="30" size="20">
                  </td>
                  <td class="blue">客户习惯</td>
                  <td> 
                    <input name=custXg v_must=0 maxlength="20"  index="31">
                  </td>
                </tr>
                </tbody> 
              </table>                                
        
              <table id=tb1 cellSpacing="0" style="display:none">
                <tbody> 
                <tr> 
                  <td width=16% class="blue">单位性质</td>
                  <td width=34%> 
                    <select align="left" name=unitXz width=50 index="32">
                    	<wtc:qoption name="sPubSelect" outnum="2">
											<wtc:sql>select trim(TYPE_CODE), TYPE_NAME from sunittype order by TYPE_CODE</wtc:sql>
											</wtc:qoption>                    	
                    </select>
                  </td>
                  <td width=16% class="blue">营业执照类型</td>
                  <td width=34%> 
                    <select align="left" name=yzlx width=50 index="33">
                    	<wtc:qoption name="sPubSelect" outnum="2">
											<wtc:sql>select trim(LINCENT_TYPE), TYPE_NAME from slicencetype order by LINCENT_TYPE</wtc:sql>
											</wtc:qoption> 
                    </select>
                  </td>
                </tr>
                <tr> 
                  <td class="blue">营业执照号码</td>
                  <td> 
                    <input name=yzhm maxlength="20"  index="34">
                  </td>
                  <td class="blue">营业执照有效期</td>
                  <td> 
                    <input name=yzrq  index="35" v_must=0 v_maxlength=8 v_type="date" maxlength=8 size="8" onblur="checkElement(this)">
                  </td>
                </tr>
                <tr> 
                  <td class="blue">法人代表</td>
                  <td COLSPAN="3"> 
                    <input name=frdm maxlength="20"  index="36">
                  </td>
                </tr>
                </tbody> 
              </table>
			     		<table cellspacing="0" style="display:none">
                <tr> 
							     <td width=16% class="blue">原集团号</td>
			             <td width=84%>
			             		<input name=oriGrpNo maxlength="10"  index="37" v_must=0 v_maxlength=10 v_type=0_9 v_name="原集团号">
								   </td>
							   </tr>				
							  </table>
              <table cellSpacing="0">
                <tbody> 
                <tr style="display:none"> 
                  <td width=16% class="blue">系统备注</td>
                  <td> 
                    <input name=sysNote size=60 readonly maxlength="30">
                  </td>
                </tr>
                <tr> 
                  <td width="16%" class="blue">用户备注</td>
                  <td> 
                    <input name=opNote size=60 maxlength="30" index="38"  v_must=0 v_maxlength=60 v_type="string" onblur="checkElement(this)">
                  </td>
                </tr>
                </tbody> 
              </table>   
                           
			        <table cellspacing="0">
			          <tbody>
			            <tr> 
				            <td id="footer"> 
				              <input class="b_foot" name=print  onmouseup="printCommit()" onkeyup="if(event.keyCode==13)printCommit()"  type=button value=确定  index="39" >
							        <input class="b_foot" name=reset type=button  onclick="frm1100.action='f1100_1c.jsp';frm1100.submit();" value=清除 index="40">
							        <input class="b_foot" name=back type=button onclick="window.close()" value=关闭 index="41">
				              <input class="b_foot" type="reset" name="Reset" value="Reset" style="display:none">
				            </td>
			            </tr>
			          </tbody>
			        </table>
 					<%@ include file="/npage/include/footer_pop.jsp" %>
<!--/wl:cache-->
  <input type="hidden" name="ReqPageName" value="f1100_1">
  <input type="hidden" name="workno" value=<%=workNo%>>
  <input type="hidden" name="regionCode" value=<%=regionCode%>> 
  <input type="hidden" name="unitCode" value=<%=Department%>>
  <input type="hidden" id=in6 name="belongCode" value=<%=belongCode%>>  
  <input type="hidden" id=in1 name="hidPwd" v_name="原始密码">
  <input type="hidden" name="hidCustPwd">  			<!--加密后的客户密码-->
  <input type="hidden" name="temp_custId">
  <input type="hidden" name="ip_Addr" value=<%=ip_Addr%>>
  <input type="hidden" name="inParaStr" >
  <input type="hidden" name="checkPwd_Flag" value="false">		<!--密码校验标志-->
  
  <input type="hidden" name="regionCodeFlg" value=<%=regionCode%>>
  <input type="hidden" name="assu_name" value="">
  <input type="hidden" name="assu_phone" value="">
  <input type="hidden" name="assu_idAddr" value="">
  <input type="hidden" name="assu_idIccid" value="">
  <input type="hidden" name="assu_conAddr" value="">
  <input type="hidden" name="assu_idType" value="">
  <input type="hidden" name="card_flag" value="">  <!--身份证几代标志-->
  <input type="hidden" name="pa_flag" value="">  <!--证件标志-->
  <input type="hidden" name="m_flag" value="">   <!--扫描或者读取标志，用于确定上传图片时候的图片名-->
  <input type="hidden" name="sf_flag" value="">   <!--扫描是否成功标志-->
  <input type="hidden" name="pic_name" value="">   <!--标识上传文件的名称-->
	<input type="hidden" name="up_flag" value="0">
	<input type="hidden" name="but_flag" value="0"> <!--按钮点击标志-->
	<input type="hidden" name="upbut_flag" value="0"> <!--上传按钮点击标志-->
   <jsp:include page="/npage/common/pwd_comm.jsp"/>
</form>
</body>
<%@ include file="interface_providerc.jsp" %>   
</html>
