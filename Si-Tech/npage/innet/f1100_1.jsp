<%
/********************
 version v2.0
 开发商: si-tech
 update by liutong @ 2008.09.03
 update by qidp @ 2009-08-18 for 兼容端到端流程
********************/
%>
<%--baixf modify 20070815 客户类别根据登录工号是否有集团客户开户权限而显示集团、ec集团
    op_code:1993 集团客户开户
--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.text.SimpleDateFormat"%> <!--二代证-->
<%        
	//Logger logger = Logger.getLogger("f1100_1.jsp");
	//ArrayList retArray = new ArrayList();
	//String[][] result = new String[][]{};
	// S1100View callView = new S1100View(); 
	String printAccept = "";
	String IccIdAccept="";
%>
<%
		/**        
		ArrayList arr = (ArrayList)session.getAttribute("allArr");
		String[][] baseInfo = (String[][])arr.get(0);
		String[][] agentInfo = (String[][])arr.get(2);
		String workNo = baseInfo[0][2];
		String workName = baseInfo[0][3];
		String Role = baseInfo[0][5];
		String Department = baseInfo[0][16];
		String belongCode = Department.substring(0,7);
		String ip_Addr = agentInfo[0][2];
		String regionCode = Department.substring(0,2);
		String districtCode = Department.substring(2,4);
		String rowNum = "16";
		String getAcceptFlag = "";
		**/		
        				      				
		String opCode = "1100";
		String opName = "客户开户";
		String workNo =(String)session.getAttribute("workNo");
		String workName =(String)session.getAttribute("workName");
		String powerRight =(String)session.getAttribute("powerRight");
		String Role =(String)session.getAttribute("Role");
		String orgCode =(String)session.getAttribute("orgCode");
		String regionCode = orgCode.substring(0,2);
		String groupId =(String)session.getAttribute("groupId");
		String ip_Addr =(String)session.getAttribute("ip_Addr");
		String belongCode =orgCode.substring(0,7);
		String districtCode =orgCode.substring(2,4);
		String rowNum = "16";
		String getAcceptFlag = "";
%>
<%
   /**     //取得打印流水
        try
        {
                String sqlStr ="select sMaxSysAccept.nextval from dual";
                retArray = callView.view_spubqry32("1",sqlStr);
                result = (String[][])retArray.get(0);
                printAccept = (result[0][0]).trim();
        }catch(Exception e){
                out.println("rdShowMessageDialog('取系统操作流水失败！',0);");
                getAcceptFlag = "failed";
        }    
        **/
     String sqlStrl ="select sMaxSysAccept.nextval from dual";
    //取得打印流水(替换原ejb)   新页面改造 20080828
	%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCodel" retmsg="retMsgl" outnum="1">
		<wtc:sql><%=sqlStrl%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="resultl" scope="end" />
	<%
		if(retCodel.equals("000000")){
		  	printAccept = (resultl[0][0]).trim();
                	IccIdAccept = printAccept;/*wangdana add*/
		}else{
			getAcceptFlag = "failed";
		}               
	String sqlStrl0 ="SELECT count(*) FROM dChnGroupMsg a,dbChnAdn.sChnClassMsg b WHERE a.group_id='"+groupId+"' AND a.is_active='Y' AND a.class_code=b.class_code AND b.class_kind='2'";  
	%> 
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCodel0" retmsg="retMsgl0" outnum="1">
		<wtc:sql><%=sqlStrl0%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="resultl0" scope="end" />
	<%
	/* add by qidp @ 2009-08-12 for 兼容端到端流程 . */
	    String inputFlag = (String)request.getParameter("inputFlag");   //标示位，值为1时表示是从销售方面转入
	    /*
	    String cont_tp = "";
	    String group_name = "";
	    String cont_user = "";
	    String cont_mobile = "";
	    String cont_addr = "";
	    String cont_email = "";
	    String cont_zip = "";
	    */
	    System.out.println("# inputFlag = "+inputFlag);
	    
	    /*
	    if("1".equals(inputFlag)){
	        cont_tp = (String)request.getParameter("cont_tp");          //集团客户级别
    	    group_name = (String)request.getParameter("group_name");    //集团客户名称
    	    cont_user = (String)request.getParameter("cont_user");      //集团客户联系人
    	    cont_mobile = (String)request.getParameter("cont_mobile");  //集团客户联系电话
    	    cont_addr = (String)request.getParameter("cont_addr");      //集团客户联系地址
    	    cont_email = (String)request.getParameter("cont_email");    //集团客户联系邮箱
    	    cont_zip = (String)request.getParameter("cont_zip");        //集团客户联系邮编
	    }
	    */
	/* end by qidp @ 2009-08-12 for 兼容端到端流程 . */
	%>
<!------------------------------------------------------------->
<html>
<head>
<title>客户开户</title>
<meta content=no-cache http-equiv=Pragma>
<meta content=no-cache http-equiv=Cache-Control>
</head>
<!----------------------------------------------------------------->
<SCRIPT type=text/javascript>
var numStr="0123456789"; 
onload=function(){
    document.all.newCust.focus();
    document.all.pa_flag.value="1";	
    if(typeof(frm1100.oldCust)!="undefined")
    {   //判断是否是并老户
        if(frm1100.oldCust.checked == true)
        {	
            var obj="tbs"+9;           
            document.all(obj).style.display="";
        }
    } 
    if(typeof(frm1100.custId)!="undefined")
    {   
        if(frm1100.custId.value != "")      //恢复到提交前的客户ID按钮显示状态
        {       frm1100.custQuery.disabled = true;           }
    }
    if((typeof(frm1100.idType)!="undefined")&&(typeof(frm1100.idIccid)!="undefined"))
    {	change_idType();}  //还原到提交前的证件类型   
    
    change();//luxc 2008326 add 因为如果报错 返回页面不正确
    change_instigate();
    
    /*  add by qidp @ 2009-08-12 for 兼容端到端流程 .  */
    <% if("1".equals(inputFlag)){ %>
        document.all.ownerType[1].selected = true;
        change();
    <% } %>
    /* end by qidp @ 2009-08-12 for 兼容端到端流程 . */
}

function doProcess(packet)
{
   	//RPC处理函数findValueByName
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode"); 
    var retMessage = packet.data.findValueByName("retMessage"); 
    self.status="";
	if((retCode).trim()=="")
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
		 
			document.all.read_idCard_one.disabled=false;//二代证
			document.all.read_idCard_two.disabled=false;//二代证
			document.all.scan_idCard_two.disabled=false;//二代证
        }
        else
        {
			retMessage = retMessage + "[errorCode1:" + retCode + "]";
			rdShowMessageDialog(retMessage,0);
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
	    	rdShowMessageDialog("上级客户密码校验失败，请重新输入！",0);
	    	frm1100.parentPwd.value = "";
	    	frm1100.parentPwd.focus();
	    	frm1100.checkPwd_Flag.value = "false";	    	
	    	return false;	        	
	    }
		else
		{
			rdShowMessageDialog("上级客户密码校验成功！",2);
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
               //var recordNum = acket.data.findValueByName("recordNum"); 
               //showParentInfo(retInfo);       
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
			   rdShowMessageDialog("客户不存在！",0);  
			   return false;
			 }
         }           
         else
         {
             retMessage = retMessage + "[errorCode2:" + retCode + "]";
             rdShowMessageDialog(retMessage,0);
			 return false;
         }
     }
	 if(retType=="chkX")
	 {
    var retObj = packet.data.findValueByName("retObj");
		if(retCode == "000000"){
				rdShowMessageDialog("校验成功!",2);			
				document.all.print.disabled=false;
				document.all.uploadpic_b.disabled=false;//二代证
			}else if(retCode=="100001"){
				retMessage = retCode + "："+retMessage;	
				rdShowMessageDialog(retMessage);		 
				document.all.print.disabled=false;
				document.all.uploadpic_b.disabled=false;//二代证
				return true;
    	}else{
				retMessage = "错误" + retCode + "："+retMessage;			 
				rdShowMessageDialog(retMessage,0);
				document.all.print.disabled=true;
				document.all.uploadpic_b.disabled=true;//二代证
				document.all(retObj).focus();
				return false;
			 
		}
	 }
	 if(retType=="checkName")
	 {
			var flag = packet.data.findValueByName("flag");
			var custId = packet.data.findValueByName("custId");
			if(flag=="0"){
     		rdShowMessageDialog("该客户名称可以正常使用！",2);
     		document.all("idCheck").disabled=false;
			}
			else if(flag=="1"){
				
				rdShowMessageDialog("该客户名称已经存在！<BR>客户ID为"+custId+"！",0);
			}
		
	 }
  	if(retType=="iccIdCheck")
	 {
	 	if(retCode == "000000")
	 	{
	 		rdShowMessageDialog("校验通过！");
	 		document.all.get_Photo.disabled=false;
	 	}
	 	else
	 	{
	 		retMessage = retCode + "："+retMessage;	
			rdShowMessageDialog(retMessage);
			document.all.idIccid.value="";
	 	}
	 }
}

//dujl add at 20100415 for 身份证校验
function checkIccId()
{
	if(document.all.idType.value.split("|")[0] != "0")
	{
		rdShowMessageDialog("只有身份证可以校验！");
		return false;
	}
	if(document.all.custName.value.trim() == "")
	{
		rdShowMessageDialog("请先输入客户名称！");
		return false;
	}
	if(document.all.idIccid.value.trim() == "")
	{
		rdShowMessageDialog("请先输入证件号码！");
		return false;
	}
	if(document.all.ziyou_check.value != 0)
	{
		rdShowMessageDialog("非自有营业厅不可以查询！");
		return false;
	}
	document.all.iccIdCheck.disabled=true;
	var myPacket = new AJAXPacket("/npage/innet/fIccIdCheck.jsp","正在验证身份证信息，请稍候......");
	myPacket.data.add("retType","iccIdCheck");
	myPacket.data.add("idIccid",document.all.idIccid.value);
	myPacket.data.add("custName",document.all.custName.value);
	myPacket.data.add("IccIdAccept",document.all.IccIdAccept.value);
	myPacket.data.add("opCode",document.all.opCode.value);
	core.ajax.sendPacket(myPacket);
	myPacket=null;
	document.all.iccIdCheck.disabled=false;
}

//dujl add at 20100421 for 身份证校验
// 获取身份证照片
function getPhoto()
{
	window.open("fgetIccIdPhoto.jsp?idIccid="+document.all.idIccid.value,"","width="+(screen.availWidth*1-900)+",height="+(screen.availHeight*1-500) +",left=450,top=240,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no");
}

//   copy from common_util.js   页面改造   liutong@20080828
function rpc_chkX(x_type,x_no,chk_kind)
{
  var obj_type=document.all(x_type);
  var obj_no=document.all(x_no);
  var idname="";

  if(obj_type.type=="text")
  {
    idname=(obj_type.value).trim();
  }
  else if(obj_type.type=="select-one")
  {
    idname=(obj_type.options[obj_type.selectedIndex].text).trim();  
  }

  if((obj_no.value).trim().length>0)
  {
    if((obj_no.value).trim().length<5)
	{
      rdShowMessageDialog("证件号码长度有误（至少5位）！");
	  obj_no.focus();
  	  return false;
	}
	else
	{
      if(idname=="身份证")
	  {
        if(checkElement(obj_no)==false) return false;
	  }
	}
  }
  else 
	return;
  var myPacket = new AJAXPacket("/npage/innet/chkX.jsp","正在验证黑名单信息，请稍候......");
	  myPacket.data.add("retType","chkX");
	  myPacket.data.add("retObj",x_no);
	  myPacket.data.add("x_idType",getX_idno(idname));
	  myPacket.data.add("x_idNo",obj_no.value);
	  myPacket.data.add("x_chkKind",chk_kind);
	  core.ajax.sendPacket(myPacket);
	  myPacket=null;
  
}
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
function check_newCust(){ 
	    if(document.all.custQuery.disabled==true){document.all.custQuery.disabled=false}
	    document.all.Reset.click();
         //新建客户的相关域控制
        if(document.frm1100.newCust.checked == true){
        window.document.frm1100.oldCust.checked = false;
        var temp1="tbs"+9;           
            document.all(temp1).style.display = "none";
            document.all("card_id_type").style.display="";
            document.all("svcLvl").style.display="none";
      
            window.document.frm1100.parentId.value = "";
            window.document.frm1100.parentPwd.value = "";
            window.document.frm1100.parentName.value = "";
            window.document.frm1100.parentAddr.value = "";
            window.document.frm1100.parentIdType.value = "";
            window.document.frm1100.parentIdidIccid.value = "";
        }
}
function check_oldCust(){
	document.all.Reset.click();
	document.all("card_id_type").style.display="none";
	document.all.oldCust.checked=true;
	document.all("svcLvl").style.display="none";
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
	document.getElementById("preBox").style.checked=false;//wangzn 091203
	if(ic=="01")
	{ 
		document.all("tb0").style.display="";   
		document.all("tb1").style.display="none";      
		document.all("td2").style.display="none";
		document.all("td3").style.display="none";
		document.all("checkName").style.display="none";
		document.all("ownerType_Type").style.display="";/** tianyang add for custNameCheck **/
		document.all("idCheck").disabled=false;
		document.all("print").disabled=true;
		document.all.custPwd.value="";
		document.all.cfmPwd.value="";
		document.getElementById("preBox").style.display="none";//wangzn 091201
		document.getElementById("svcLvl").style.display="none";//zhangyan 2011-12-13 15:46:32		
	}
	else if(ic=="02")
	{
		document.all("tb0").style.display="none";
		document.all("tb1").style.display="none";
		document.all("td2").style.display="none";
		document.all("td3").style.display="";   
		document.all("checkName").style.display="";
		document.all("ownerType_Type").style.display="none";/** tianyang add for custNameCheck **/
		document.all("idCheck").disabled=true;
		document.all("print").disabled=true;
		document.all.custPwd.value="111111";
		document.all.cfmPwd.value="111111";
		document.getElementById("preBox").style.display="";//wangzn 091201
		document.getElementById("svcLvl").style.display="";//zhangyan 2011-12-13 15:46:32	
	}
	else if(ic=="03")
	{
		document.all("tb0").style.display="none";
		document.all("tb1").style.display="none";
		document.all("td2").style.display="";   	
		document.all("td3").style.display="none";
		document.all("checkName").style.display="none";
		document.all("ownerType_Type").style.display="none";/** tianyang add for custNameCheck **/
		document.all("idCheck").disabled=true;
		document.all("print").disabled=true;
		document.getElementById("preBox").style.display="none";//wangzn 091201
		document.getElementById("svcLvl").style.display="none";//zhangyan 2011-12-13 15:46:32	
	}
	else if(ic=="04")
	{
		document.all("tb0").style.display="none";
		document.all("tb1").style.display="none";
		document.all("td2").style.display="none";
		document.all("td3").style.display="";   
		document.all("checkName").style.display="";
		document.all("ownerType_Type").style.display="none";/** tianyang add for custNameCheck **/
		document.all("idCheck").disabled=true;
		document.all("print").disabled=true;
		document.all.custPwd.value="111111";
		document.all.cfmPwd.value="111111";
		document.getElementById("preBox").style.display="";//wangzn 091201
		document.getElementById("svcLvl").style.display="";//zhangyan 2011-12-13 15:46:32			
	}
	//dujl add at 20100421 for 身份证校验
	if(document.all.ownerType.value != "01")
	{
		document.all.iccIdCheck.disabled = true;
	}
	else
	{
		document.all.iccIdCheck.disabled = false;
	}
}

function change_instigate()
{
	if(document.all.instigate_flag.value=="Y")
	{
		document.all.getcontract_flag.disabled=false;
	}
	else
	{
		document.all.getcontract_flag.value="0";
		document.all.getcontract_flag.disabled=true;
	}
}

function change_idType()//二代证
{		

			
		if(document.all.idType.value=="0|身份证")
		{ 
			document.all.pa_flag.value="1";	
		document.all("card_id_type").style.display="";
		}
		else{
		document.all.pa_flag.value="0";
	 
		document.all("card_id_type").style.display="none";
	}
    var Str = document.frm1100.idType.value;
    if(Str.indexOf("身份证") > -1)
    {   document.frm1100.idIccid.v_type = "idcard";   }
    else
    {   document.frm1100.idIccid.v_type = "string";   }
    document.all.print.disabled=true;
}

function change_custPwd()
{   
    check_HidPwd(frm1100.parentPwd.value,"show",(frm1100.in1.value).trim(),"hid");
    /*
    if(frm1100.checkPwd_Flag.value != "true");
    {
    	rdShowMessageDialog("上级客户密码校验失败，请重新输入！",0);
    	frm1100.parentPwd.value = "";
    	frm1100.parentPwd.focus();
    	return false;	        	
    }
    frm1100.checkPwd_Flag.value = "false"; 
    */
}
//------------------------------------
function printCommit()
{       
    getAfterPrompt();
	if(frm1100.ownerType.value=="02"||frm1100.ownerType.value=="04")
	{
		if(frm1100.custPwd.value == "")
		{
			rdShowMessageDialog("集团开户密码不能为空!",0);
	    	//frm1100.parentPwd.focus();
	    	return false;
		}
		/*luxc 20080326 add*/
		
		if(document.all.instigate_flag.value=="0"||document.all.instigate_flag.value=="")
		{
			rdShowMessageDialog("请选择策反集团标志!",0);
			return false;
		}
		else if(document.all.instigate_flag.value=="Y" 
			&& (document.all.getcontract_flag.value=="0"||document.all.getcontract_flag.value==""))
		{
			rdShowMessageDialog("请选择 是否获得竞争对手协议!",0);
			return false;
		}
	}
		
		var obj = null;
		//先确认打印电子免填单，在打印发票
        if(frm1100.oldCust.checked == true)
        {	//并老户必输项判断
        	//parentId parentPwd parentIdidIccid parentName
	        if(frm1100.parentId.value == "")
	        {	
	        	rdShowMessageDialog("选择并老户，客户ID不能为空！",0);
	        	frm1100.parentId.focus();
	        	return false;
	        }
	        /*if(frm1100.parentPwd.value == "")
	        {	
	        	rdShowMessageDialog("选择并老户，客户密码不能为空！",0);
	        	frm1100.parentPwd.focus();
	        	return false;
	        }*/
	        if(frm1100.parentIdidIccid.value == "")
	        {	
	        	rdShowMessageDialog("选择并老户，客户证件号码不能为空！",0);
	        	frm1100.parentIdidIccid.focus();
	        	return false;
	        }
	        if(frm1100.parentName.value == "")
	        {	
	        	rdShowMessageDialog("选择并老户，客户名称不能为空！",0);
	        	frm1100.parentName.focus();
	        	return false;
	        }		
	        if(frm1100.parentName.value.trim().indexOf('~')>0)
			{
				rdShowMessageDialog("上级客户名称中有非法字符'~'，请修改！",0);
				return false;
			}	
			if(frm1100.parentAddr.value.trim().indexOf('~')>0)
			{
				rdShowMessageDialog("上级客户地址中有非法字符'~'，请修改！",0);
				return false;
			}		  	  
        }
        if(frm1100.custName.value.trim().indexOf('~')>0)
		{
			rdShowMessageDialog("客户名称中有非法字符'~'，请修改！",0);
			return false;
		}	
		if(frm1100.idAddr.value.trim().indexOf('~')>0)
		{
			rdShowMessageDialog("证件地址中有非法字符'~'，请修改！",0);
			return false;
		}	
		if(frm1100.contactAddr.value.trim().indexOf('~')>0)
		{
			rdShowMessageDialog("联系人地址中有非法字符'~'，请修改！",0);
			return false;
		}
		if(frm1100.contactPerson.value.trim().indexOf('~')>0)
		{
			rdShowMessageDialog("联系人姓名中有非法字符'~'，请修改！",0);
			return false;
		}
		if(frm1100.contactPhone.value.trim().indexOf('~')>0)
		{
			rdShowMessageDialog("联系人电话中有非法字符'~'，请修改！",0);
			return false;
			
		}
		if(document.frm1100.contactMAddr.value.trim().indexOf('~')>0)
		{
			rdShowMessageDialog("联系人通讯地址中有非法字符'~'，请修改！",0);
			return false;
		}
        change_idType();   //判断客户证件类型是否是身份证 
        if((frm1100.contactMail.value).trim() == "")
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
        	if(validDate(frm1100.birthDay) == false)
        	{	return false;		}
        }
        else if((typeof(frm1100.yzrq)!="undefined")&&
           (frm1100.yzrq.value != "")&&
           (document.all(obj1).style.display == ""))
        {	
        	if(validDate(frm1100.yzrq) == false)
        	{	return false;		}			
        }
		
	     if((document.all.but_flag.value =="1")&&document.all.upbut_flag.value=="0"){//二代证
	rdShowMessageDialog("请先上传身份证照片",0);
	return false;
	}
        
var upflag =document.all.up_flag.value;//二代证
if(upflag==3&&(document.all.but_flag.value =="1"))//二代证
{
	rdShowMessageDialog("请选择jpg类型图像文件");
	return false;
	}
if(upflag==4&&(document.all.but_flag.value =="1"))//二代证
{
	rdShowMessageDialog("请先扫描或读取证件信息");
	return false;
	}
	
	
if(upflag==5&&(document.all.but_flag.value =="1"))//二代证
{
	rdShowMessageDialog("请选择最后一次扫描或读取证件而生成的证件图像文件"+document.all.pic_name.value);
	return false;
	}
			
if((document.all.but_flag.value =="1")&&document.all.upbut_flag.value=="0"){//二代证
	rdShowMessageDialog("请先上传身份证照片",0);
	return false;
	}
		var d= (new Date().getFullYear().toString()+(((new Date().getMonth()+1).toString().length>=2)?(new Date().getMonth()+1).toString():("0"+(new Date().getMonth()+1)))+(((new Date().getDate()).toString().length>=2)?(new Date().getDate()):("0"+(new Date().getDate()))).toString());

		if((frm1100.idValidDate.value).trim().length>0)
	    {		 
           if(validDate(frm1100.idValidDate)==false) return false;

		   if(to_date(frm1100.idValidDate)<=d)
		   {
			  rdShowMessageDialog("证件有效期不能早于当前时间，请重新输入！");
	          document.all.idValidDate.focus();
			  document.all.idValidDate.select();
		      return false;
		   }
		}

		if(document.all.ownerType.options[document.all.ownerType.selectedIndex].text=="普通")
		{
             if((document.all.birthDay.value).trim().length>0)
		     {
		       if(to_date(frm1100.birthDay)>=d)
		       {
			     rdShowMessageDialog("出生日期期不能晚于当前时间，请重新输入！");
	             document.all.birthDay.focus();
			     document.all.birthDay.select();
		         return false;
		       }
			 }
		}
		else
		{
             if((document.all.yzrq.value).trim().length>0)
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

		/*if(document.all("td2").style.display=="")
	    {
			if(jtrim(document.all.oriGrpNo.value).length==0)
			{
              rdShowMessageDialog("请输入原集团号！");
              document.all.oriGrpNo.focus();
			  return false;
			}
		}*/
				
        //--------------------------             
        if(check(frm1100))
        { 
 		     if((document.all.custPwd.value).trim().length>0)
			  {
			     if(document.all.custPwd.value.length!=6)
				 {
				   rdShowMessageDialog("客户密码长度有误！");
    	           document.all.custPwd.focus();
				   return false;
				 }
			     if(checkPwd(document.frm1100.custPwd,document.frm1100.cfmPwd)==false)
				    return false;
			  }
	        var t = null;
	        var i;
	        if(document.frm1100.newCust.checked == true)
	        {
	            document.frm1100.parentId.value = document.frm1100.custId.value;
	            sysNote = "新建户:客户ID[" + 
	                 document.frm1100.custId.value + "]";
	        } 
	        else
	        {
	            sysNote = "并老户:客户ID[" + 
	                 document.frm1100.custId.value + "]:上级客户ID[" + 
	                 document.frm1100.parentId.value + "]";
	        }
	        document.frm1100.sysNote.value = sysNote;
			if((document.all.opNote.value).trim().length==0)
			{//luxc20061218修改备注字段 防止太长插不近wchg表
              document.all.opNote.value="<%=workName%>"+"对["+(document.all.custName.value).trim().substring(0,14)+"]"+document.all.ownerType.options[document.all.ownerType.selectedIndex].text+"客户开户";
			}
			if((document.all.opNote.value).trim().length>60)
			{
				rdShowMessageDialog("用户备注的值不正确，长度有错误！");
				document.all.opNote.focus();
				return false;
			}
			//wangzn 091202
			 if(document.frm1100.isPre.checked){
					if(!document.frm1100.preUnitId.readOnly){
						rdShowMessageDialog("请选择潜在集团编号！");
						return false;
					}
		   }
			
	       if(!check(frm1100)){
	 			return false;
	 		}else
	 		{
				checkPwdEasy(document.frm1100.custPwd.value);	//2010-8-30 17:28 wanghfa添加 客户密码限制需求
			}
			// dujl at 20100324 for R_HLJMob_liubq_CRM_PD3_2010_0117@关于优化BOSS系统开户及过户功能的需求 封闭
//	        showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
    	}else{
    		return false;
    		}    
}

//2010-8-30 17:29 wanghfa添加 验证密码过于简单 start
function checkPwdEasy(pwd) {
	var checkPwd_Packet = new AJAXPacket("../public/pubCheckPwdEasy.jsp","正在验证密码是否过于简单，请稍候......");
	checkPwd_Packet.data.add("password", pwd);
	checkPwd_Packet.data.add("phoneNo", "");
	checkPwd_Packet.data.add("idNo", document.all.idIccid.value);
	checkPwd_Packet.data.add("opCode", "1100");
	core.ajax.sendPacket(checkPwd_Packet, doCheckPwdEasy);
	checkPwd_Packet=null;
}

function doCheckPwdEasy(packet) {
	var retResult = packet.data.findValueByName("retResult");

	if (retResult == "1") {
		rdShowMessageDialog("尊敬的客户，您本次设置的密码为相同数字类密码，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
		return;
	} else if (retResult == "2") {
		rdShowMessageDialog("尊敬的客户，您本次设置的密码为连号类密码，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
		return;
	} else if (retResult == "3") {
		rdShowMessageDialog("尊敬的客户，您本次设置的密码为手机号码中的连续数字，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
		return;
	} else if (retResult == "4") {
		rdShowMessageDialog("尊敬的客户，您本次设置的密码为证件中的连续数字，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
		return;
	} else if (retResult == "0") {
		if(rdShowConfirmDialog("确认要提交客户开户信息吗？")==1) {
			<% if("1".equals(inputFlag)) { %>
				document.frm1100.target="hidden_frame";
			<% }else{ %>
			//二代证
				frm1100.target=""; 
			<% } %>
			//wangzn 20091202
			var isPre = "0";
			if(document.frm1100.isPre.checked) {
				isPre="1";
			}
			frm1100.action="f1100_2.jsp?inputFlag="+document.frm1100.inputFlag.value+"&custId="+document.frm1100.custId.value+"&regionCode="+document.frm1100.regionCode.value+"&districtCode="+document.frm1100.districtCode.value+"&custName="+document.frm1100.custName.value+"&custPwd="+document.frm1100.custPwd.value+"&custStatus="+document.frm1100.custStatus.value+"&custGrade="+document.frm1100.custGrade.value+"&ownerType="+document.frm1100.ownerType.value+"&custAddr="+document.frm1100.custAddr.value+"&idType="+document.frm1100.idType.value+"&idIccid="+document.frm1100.idIccid.value+"&idAddr="+document.frm1100.idAddr.value+"&idValidDate="+document.frm1100.idValidDate.value+"&contactPerson="+document.frm1100.contactPerson.value+"&contactPhone="+document.frm1100.contactPhone.value+"&contactAddr="+document.frm1100.contactAddr.value+"&contactPost="+document.frm1100.contactPost.value+"&contactMAddr="+document.frm1100.contactMAddr.value+"&contactFax="+document.frm1100.contactFax.value+"&contactMail="+document.frm1100.contactMail.value+"&unitCode="+document.frm1100.unitCode.value+"&parentId="+document.frm1100.parentId.value+"&custSex="+document.frm1100.custSex.value+"&birthDay="+document.frm1100.birthDay.value+"&professionId="+document.frm1100.professionId.value+"&vudyXl="+document.frm1100.vudyXl.value+"&custAh="+document.frm1100.custAh.value+"&custXg="+document.frm1100.custXg.value+"&unitXz="+document.frm1100.unitXz.value+"&yzlx="+document.frm1100.yzlx.value+"&yzhm="+document.frm1100.yzhm.value+"&yzrq="+document.frm1100.yzrq.value+"&frdm="+document.frm1100.frdm.value+"&groupCharacter=''"+"&workno="+document.frm1100.workno.value+"&sysNote="+document.frm1100.sysNote.value+"&opNote="+document.frm1100.opNote.value+"&opNote="+document.frm1100.opNote.value+"&ip_Addr="+document.frm1100.ip_Addr.value+"&oriGrpNo="+document.frm1100.oriGrpNo.value+"&instigate_flag="+document.frm1100.instigate_flag.value+"&getcontract_flag="+document.frm1100.getcontract_flag.value+"&filep="+document.frm1100.filep.value+"&card_flag="+document.frm1100.card_flag.value+"&m_flag="+document.frm1100.m_flag.value+"&sf_flag="+document.frm1100.sf_flag.value+"&idType="+document.frm1100.idType.value+"&pic_name="+document.all.pic_name.value+"&but_flag="+document.all.but_flag.value+"&isPre="+isPre+"&preUnitId="+document.all.preUnitId.value+"&IccIdAccept="+document.all.IccIdAccept.value+"&selSvcLvl="+document.all.selSvcLvl.value;
			frm1100.submit();
		}
	}
}
//2010-8-30 17:29 wanghfa添加 验证密码过于简单 end








function chkValid()
{
     var d= (new Date().getFullYear().toString()+(((new Date().getMonth()+1).toString().length>=2)?(new Date().getMonth()+1).toString():("0"+(new Date().getMonth()+1)))+(((new Date().getDate()).toString().length>=2)?(new Date().getDate()):("0"+(new Date().getDate()))).toString());

	 if((frm1100.idValidDate.value).trim().length>0)
	 {		 
        if(validDate(frm1100.idValidDate)==false) return false;

	    if(to_date(frm1100.idValidDate)<=d)
	    {
		  rdShowMessageDialog("证件有效期不能早于当前时间，请重新输入！");
	      document.all.idValidDate.focus();
		  document.all.idValidDate.select();
	      return false;
	    }
	}
}
/// begin    add by liutong 20080909
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

function myParseInt(nu)
{
  var ret=0;
  if(nu.length>0)
  {
    if(nu.substring(0,1)=="0")
	{
       ret=parseInt(nu.substring(1,nu.length));
	}
	else
	{
       ret=parseInt(nu);
	}
  }
  return ret;
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
/// end    add by liutong 20080909
function printInfo(printType)
{
	var retInfo = "";
	var cust_info=""; //客户信息
	var opr_info=""; //操作信息
	var note_info1=""; //备注1
	var note_info2=""; //备注2
	var note_info3=""; //备注3
	var note_info4=""; //备注4
	var retInfo = "";  //打印内容

    if(printType == "Detail")
    {	//打印电子免填单
    	
        var getAcceptFlag = "<%=getAcceptFlag%>";
        if(getAcceptFlag == "failed")
        {	return "failed";	}
	    /*retInfo = retInfo + "10|2|0|0|打印流水:  " + "<%=printAccept%>" + "|"; */
		
		//打印电子免填单
        //retInfo+=frm1100.custId.value+"|";
		/*retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime())%>'+"|"; */
		//retInfo+= frm1100.workName.value+"|";
		cust_info+= "客户姓名：     "+frm1100.custName.value+"|";
		//retInfo+= "证件类型：   "+frm1100.idType.value+"|";
		cust_info+= "证件号码：     "+frm1100.idIccid.value+"|";
		cust_info+= "客户地址：     "+frm1100.idAddr.value+"|";
		//retInfo+=" |";
		cust_info+= "联系人姓名：   "+frm1100.contactPerson.value+"|";
		cust_info+= "联系人电话：   "+frm1100.contactPhone.value+"|";
		cust_info+= "联系人地址：   "+frm1100.contactAddr.value+"|";
		
		opr_info+= "打印流水:     " + "<%=printAccept%>" + "|";
		opr_info+=" "+"|";
		opr_info+= "客户开户。*|";

		note_info1+=document.all.sysNote.value+"|";
		note_info1+=document.all.opNote.value+"|";
		note_info1+=" |";

		//担保人信息(oneTok:12-15)
		note_info2+=document.all.assu_name.value+"|";
		note_info2+=document.all.assu_phone.value+"|";
		note_info2+=document.all.assu_idAddr.value+"|";
		note_info2+=document.all.assu_idIccid.value+"|";
		
		//retInfo=cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	}
	  
    if(printType == "Bill")
    {
      //打印发票
	}
	return retInfo;	
}


function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框 
   var h=185;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var printStr = printInfo(printType);
   if(printStr == "failed")
   {	return false;	}
   
	var pType="print";                   // 打印类型：print 打印 subprint 合并打印
	var billType="1";                    //  票价类型：1电子免填单、2发票、3收据
	var sysAccept="<%=printAccept%>";    // 流水号
	var printStr = printInfo(printType); //调用printinfo()返回的打印内容
	var mode_code=null;                      //资费代码
	var fav_code=null;                       //特服代码
	var area_code=null;                  //小区代码
	var opCode="1100" ;                         //操作代码
	var phoneNo=null;                         //客户电话

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
   //var path = "gdPrint_1100.jsp?DlgMsg=" + DlgMessage;
   //var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
   //var ret=window.showModalDialog(path,"",prop);
  var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);

   //if(typeof(ret)!="undefined")
   //{
     //if((ret=="confirm")&&(submitCfm == "Yes"))
     //{
	 if(!check(frm1100)){
	 	return false;
	 }else{
			if(rdShowConfirmDialog("确认要提交客户开户信息吗？")==1)
			{
				<% if("1".equals(inputFlag)){ %>
               document.frm1100.target="hidden_frame";
               <% }else{ %>
				//二代证
				frm1100.target=""; 
				<% } %>
				//wuxy alter 20090917 因为instigate_flag 后面没有接= 导致该值没有获取到
				
				//wangzn 20091202
				var isPre = "0";
				if(document.frm1100.isPre.checked){
					isPre="1";
				}
			  frm1100.action="f1100_2.jsp?inputFlag="+document.frm1100.inputFlag.value+"&custId="+document.frm1100.custId.value+"&regionCode="+document.frm1100.regionCode.value+"&districtCode="+document.frm1100.districtCode.value+"&custName="+document.frm1100.custName.value+"&custPwd="+document.frm1100.custPwd.value+"&custStatus="+document.frm1100.custStatus.value+"&custGrade="+document.frm1100.custGrade.value+"&ownerType="+document.frm1100.ownerType.value+"&custAddr="+document.frm1100.custAddr.value+"&idType="+document.frm1100.idType.value+"&idIccid="+document.frm1100.idIccid.value+"&idAddr="+document.frm1100.idAddr.value+"&idValidDate="+document.frm1100.idValidDate.value+"&contactPerson="+document.frm1100.contactPerson.value+"&contactPhone="+document.frm1100.contactPhone.value+"&contactAddr="+document.frm1100.contactAddr.value+"&contactPost="+document.frm1100.contactPost.value+"&contactMAddr="+document.frm1100.contactMAddr.value+"&contactFax="+document.frm1100.contactFax.value+"&contactMail="+document.frm1100.contactMail.value+"&unitCode="+document.frm1100.unitCode.value+"&parentId="+document.frm1100.parentId.value+"&custSex="+document.frm1100.custSex.value+"&birthDay="+document.frm1100.birthDay.value+"&professionId="+document.frm1100.professionId.value+"&vudyXl="+document.frm1100.vudyXl.value+"&custAh="+document.frm1100.custAh.value+"&custXg="+document.frm1100.custXg.value+"&unitXz="+document.frm1100.unitXz.value+"&yzlx="+document.frm1100.yzlx.value+"&yzhm="+document.frm1100.yzhm.value+"&yzrq="+document.frm1100.yzrq.value+"&frdm="+document.frm1100.frdm.value+"&groupCharacter=''"+"&workno="+document.frm1100.workno.value+"&sysNote="+document.frm1100.sysNote.value+"&opNote="+document.frm1100.opNote.value+"&opNote="+document.frm1100.opNote.value+"&ip_Addr="+document.frm1100.ip_Addr.value+"&oriGrpNo="+document.frm1100.oriGrpNo.value+"&instigate_flag="+document.frm1100.instigate_flag.value+"&getcontract_flag="+document.frm1100.getcontract_flag.value+"&filep="+document.frm1100.filep.value+"&card_flag="+document.frm1100.card_flag.value+"&m_flag="+document.frm1100.m_flag.value+"&sf_flag="+document.frm1100.sf_flag.value+"&idType="+document.frm1100.idType.value+"&pic_name="+document.all.pic_name.value+"&but_flag="+document.all.but_flag.value+"&isPre="+isPre+"&preUnitId="+document.all.preUnitId.value+"&selSvcLvl="+document.all.selSvcLvl.value;
			  frm1100.submit();
			}
	   }
     //}
   //}
}

function checkPwd(obj1,obj2)
{
        //密码一致性校验,明码校验
        var pwd1 = obj1.value;
        var pwd2 = obj2.value;
        if(pwd1 != pwd2)
        {
                var message = "用户密码和确认用户密码不一致，请重新输入！";
                rdShowMessageDialog(message,0);
                if(obj1.type != "hidden")
                {   obj1.value = "";    }
                if(obj2.type != "hidden")
                {   obj2.value = "";    }
                obj1.focus();
                return false;
        }
        return true;
}

function check_HidPwd(Pwd1,Pwd1Type,Pwd2,Pwd2Type)
{
	/*
  		Pwd1,Pwd2:密码
  		wd1Type:密码1的类型；Pwd2Type：密码2的类型      show:明码；hid：密码
  	
	if((Pwd1).trim().length==0)
	{
        rdShowMessageDialog("客户密码不能为空！",0);
        frm1100.custPwd.focus();
		return false;
	}
    else 
	{
	   if((Pwd2).trim().length==0)
	   {
         rdShowMessageDialog("原始客户密码为空，请核对数据！",0);
         frm1100.custPwd.focus();
		 return false;
	   }
	}*/
	var checkPwd_Packet = new AJAXPacket("pubCheckPwd.jsp","正在进行密码校验，请稍候......");
	checkPwd_Packet.data.add("retType","checkPwd"); 
	checkPwd_Packet.data.add("Pwd1",Pwd1);
	checkPwd_Packet.data.add("Pwd1Type",Pwd1Type);
	checkPwd_Packet.data.add("Pwd2",(Pwd2).trim());
	checkPwd_Packet.data.add("Pwd2Type",Pwd2Type);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet=null;		
}

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

function choiceSelWay()
{	
    //选择客户信息的查询方式
	if(frm1100.parentId.value != "")
	{	//按客户ID进行查询
		getInfo_withId();	
		return true;
	}
	if(frm1100.parentIdidIccid.value != "")
	{	//客户证件号码
 		getInfo_IccId();
		return true;
	}
	if(frm1100.parentName.value != "")
	{	//客户名称
		getInfo_withName();
		return true;
	}
 	rdShowMessageDialog("客户信息可以以ID、证件号码或名称进行查询，请输入其中任意项作为查询条件！",0);
}

function getInfo_withId()
{
    //根据客户ID得到相关信息
    if(document.frm1100.parentId.value == "")
    {
        rdShowMessageDialog("请输入客户ID！",0);
        return false;
    }
	else
	{
	  if((document.all.parentId.value).trim().length>14)
	  {
         rdShowMessageDialog("客户ID长度有误！",0);
         return false;
	  }
	}
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
        getIdPacket=null; 
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
	rpc_chkX("parentIdType","parentIdidIccid","B");
}

function getInfo_withName()
{ 
        ////根据客户名称得到相关信息
    if(document.frm1100.parentName.value == "")
    {
        rdShowMessageDialog("请输入客户名称！",0);
        return false;
    }
    var pageTitle = "客户信息查询";
    var fieldName = "客户ID|客户名称|开户时间|证件类型|证件号码|客户地址|归属代码|客户密码|";
    var sqlStr = "CUST_NAME="+ frm1100.parentName.value ;
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "7|0|1|3|4|5|6|7|";
    var retToField = "in0|in4|in3|in2|in5|in6|in1|"; 
    custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)                           
    //PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,50,800,600);
    rpc_chkX("parentIdType","parentIdidIccid","B");
}


function getInfo_IccId()
{ 
    //根据客户证件号码得到相关信息
    if((document.frm1100.parentIdidIccid.value).trim().length == 0)
    {
        rdShowMessageDialog("请输入客户证件号码！",0);
        return false;
    }
	else if((document.frm1100.parentIdidIccid.value).trim().length < 5)
	{
        rdShowMessageDialog("证件号码长度有误（最少五位）！",0);
        return false;
	}

    var pageTitle = "客户信息查询";
    var fieldName = "客户ID|客户名称|开户时间|证件类型|证件号码|客户地址|归属代码|客户密码|";
    var sqlStr = "ID_ICCID="+document.frm1100.parentIdidIccid.value; 
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "7|0|1|3|4|5|6|7|";
    var retToField = "in0|in4|in3|in2|in5|in6|in1|";
     custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);                    
     //PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,50,800,600);
     //rpc_chkX("parentIdType","parentIdidIccid","B");
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
 
function jspCommit()
{
         //页面提交
         document.frm1100.commit.disabled = "none";
         action="f1100_2.jsp"
         frm1100.submit();   //将参数串的输入框提交
}

function change_ConPerson()
{   //联系人姓名随客户名称改名而改变
	if(document.all.ownerType.value=="02"){
		frm1100.contactPerson.value = frm1100.custName.value;
		document.all.idCheck.disabled=true;
		document.all.print.disabled=true;
	}
}
function change_ConAddr()
{   //联系人姓名随客户名称改名而改变
	frm1100.contactAddr.value = frm1100.custAddr.value;
	frm1100.contactMAddr.value = frm1100.custAddr.value;
}

function checkName(){
	if(!forString(document.all.custName)){
		return false;
	}
	var custName=document.all.custName.value;
	var checkPwd_Packet = new AJAXPacket("f1100_checkName.jsp?custName="+custName,"正在进行客户名称校验，请稍候......");
  checkPwd_Packet.data.add("retType","checkName");
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet=null;
}

function changeCardAddr(obj){
	if(document.all.ownerType.value=="01"){
		document.all.custAddr.value=obj.value;
		document.all.contactAddr.value=obj.value;
		document.all.contactMAddr.value=obj.value;
	}
}

function chcek_pic()//二代证
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

/**** tianyang add for 中文字符限制 start ****/	
/*function feifaCustName(textName)
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
}*/
function feifaCustName(textName)
{
	if(textName.value != "")
	{
		if(document.all.ownerType.value=="01"&&document.all.isJSX.value=="0"){
			var m = /^[\u0391-\uFFE5]+$/;
			var flag = m.test(textName.value);
			if(!flag){
				rdShowMessageDialog("只允许输入中文，个人开户分类请选择介绍信开户！");
				reSetCustName();
			}
			if(textName.value.length > 6){
				rdShowMessageDialog("只允许输入6个汉字，请重新输入！");
				reSetCustName();
			}
		}else{
			if((textName.value.indexOf("~")) != -1 || (textName.value.indexOf("|")) != -1 || (textName.value.indexOf(";")) != -1)
			{
				rdShowMessageDialog("不允许输入非法字符，个人开户分类请选择介绍信开户！");
				textName.value = "";
	 	  		return;
			}
		}
	}
}
function reSetCustName(){/*重置客户名称*/
	document.all.custName.value="";
	document.all.contactPerson.value="";
}
/**** tianyang add for 中文字符限制 end ****/
	
	
	
	
	
	
	
	
function uploadpic(){//二代证
	
	if(document.all.filep.value==""){
		rdShowMessageDialog("请选择要上传的图片",0);
		return;
		}
	if(document.all.but_flag.value=="0"){
		rdShowMessageDialog("请先扫描或读取图片",0);
		return;
		}
	frm1100.target="upload_frame"; 
	var actionstr ="f1100_2.jsp?custId="+document.frm1100.custId.value+
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
									"&IccIdAccept="+document.all.IccIdAccept.value+
									"&upflag=1";
									
	frm1100.action = actionstr; 
	document.all.upbut_flag.value="1";
	frm1100.submit()
	resetfilp();
	}
	
	function resetfilp(){//二代证
		document.getElementById("filep").outerHTML = document.getElementById("filep").outerHTML;
		}
		
		
	
	function preGrpQuery(){//wangzn add 091201 for 潜在集团升签约
		
		if(!checkElement(document.getElementById('preUnitId')))
		{
			return false;
		}
		if(document.getElementById('preUnitId').value.length==0)
		{
			rdShowMessageDialog("请输入潜在集团编号，再点击查询！",0);
			return;
		}
		
		var preUnitId = document.getElementById("preUnitId").value;
		//var sqlStr = "SELECT Unit_Id,Unit_Name,unit_addr,contact_person,contact_phone,unit_zip,fax FROM dbvipadm.dgrppremsg where Unit_Id like '%25"+preUnitId+"%25' and add_flag <> 'F' and substr(boss_org_code,1,2)='<%=regionCode % >' ";
		
		
		var sqlStr = "50";
		var params = "preUnitId=%"+preUnitId+"%,regionCode="+<%=regionCode%>;
		var wtcOutNum = "7";	
		
		var selType = "S";    //'S'单选；'M'多选
		var retQuence = "2|3|4|5|6|0|1|";//返回字段 zhangyan mod 增加集团名称
		var fieldName = "集团编号|集团名称|集团地址|联系人姓名|联系人电话|联系人邮编|联系人传真|";//弹出窗口显示的列、列名
		var pageTitle = "潜在集团信息查询";
		var path = "fPubSimpSel.jsp";
		path = path + "?sqlStr=" + sqlStr +"&params=" + params +"&wtcOutNum=" + wtcOutNum + "&retQuence=" + retQuence ;
		path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
		path = path + "&selType=" + selType;
		var retInfo = window.showModalDialog(path,"","dialogWidth:70;dialogHeight:35;");
		if(retInfo ==undefined)
		{
			return;
		}
  		var retToField="contactAddr|contactPerson|contactPhone|contactPost|contactFax|preUnitId|custName|";/*zhangyan 增加潜在集团名称*/
  
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
  		document.getElementById("preUnitId").readOnly = true;
	}
	
		
		function preTrShow(preBox){//wangzn add 091201 for 潜在集团升签约
			document.all("preTr").style.display="none";
			document.all("preUnitId").value="";
			document.all("preUnitId").readOnly=false;
			if(preBox.checked){
				document.all("preTr").style.display="";
			}
			
		}
</SCRIPT>
<body onMouseDown="hideEvent()" onKeyDown="hideEvent()">
	<!--二代证-->
<FORM method=post name="frm1100"   onKeyUp="chgFocus(frm1100)"   ENCTYPE="multipart/form-data"  ><!--二代证-->
       
       <%@ include file="/npage/include/header.jsp" %>   
       <div class="title">
			<div id="title_zi">客户开户</div>
		</div>

	<!------------------------------------------------------------------------>
              <TABLE cellspacing="0">
                <TBODY> 
                <TR> 
                  <TD width="16%" class="blue" > 
                    <div align="left">操作类型</div>
                  </TD>
                  <TD> 
                    <input name="newCust" onClick="check_newCust()" type="radio" value="new" checked index="2">
                    新建户 
                    <input type="radio" name="oldCust" onClick="check_oldCust()" value="old" index="3">
                    并老户 
				  </TD>
                </TR>
                </TBODY> 
              </TABLE>                                
              <TABLE id=tbs9 width=100%  cellSpacing="0" style="display:none">
                <TBODY> 
                <TR> 
                  <TD width="16%" class="blue" > 
                    <div align="left">上级客户证件号码</div>
                  </TD>
                  <TD width="34%"> <font class=orange> 
                    <input id=in2 name=parentIdidIccid class="button" maxlength="20" onKeyUp="if(event.keyCode==13)getInfo_IccId();" index="4">
                    *</font> 
                    <input name=IDQuery type=button style="cursor:hand" onClick="choiceSelWay()" class="b_text" id="custIdQuery" value=信息查询>
                  </TD>
                  <TD width="16%" align="left"   class="blue" > 
                    <div align="left">上级客户密码</div>
                  </TD>
                  <TD width="34%">
				    <jsp:include page="/npage/common/pwd_1.jsp">
	                <jsp:param name="width1" value="16%"  />
	                <jsp:param name="width2" value="34%"  />
	                <jsp:param name="pname" value="parentPwd"  />
	                <jsp:param name="pwd" value="12345"  />
 	                </jsp:include> 
				<!--
                    <input class="button" id=in6 type="password" name=parentPwd  onkeyUp="if(event.keyCode==13)change_custPwd();" maxlength="6" index="5" value="">
				-->
                    <input name=custQuery2 type=button class="b_text" onClick="change_custPwd();" style="cursor:hand" id="accountIdQuery" value=校验>
                  </TD>
                </TR>
                <TR> 
                  <TD class="blue" > 
                    <div align="left">上级客户名称</div>
                  </TD>
                  <TD>  
                    <input class="button" id=in4 name=parentName onKeyUp="if(event.keyCode==13)getInfo_withName();feifaCustName(this);" size=20   maxlength="60">
                    <font class=orange>*</font>
                    <!--<font class=orange>*&nbsp;(上级客户名称为汉字且不得超过六个)</font>-->
                  </TD>
                  <TD class="blue" > 
                    <div align="left">上级客户证件类型</div>
                  </TD>
                  <TD> 
                    <input class="button" id=in3 name=parentIdType readonly>
                  </TD>
                </TR>
                <TR> 
                  <TD class="blue" >
                    <div align="left">上级客户ID</div>
                  </TD>
                  <TD> <font class=orange> 
                    <input class="button" id=in0 name=parentId  maxlength="22" onKeyUp="if(event.keyCode==13)getInfo_withId();"  v_type="0_9" v_must=0 v_maxlength=14 >
                    *</font> </TD>
                  <TD class="blue" > 
                    <div align="left">上级客户地址</div>
                  </TD>
                  <TD> 
                    <input class="button" id=in5 size=35 name=parentAddr   readonly maxlength="60">
                  </TD>
                </TR>
                </TBODY> 
              </TABLE>
              <TABLE cellSpacing="0" >
                <TBODY> 
                <TR> 
                  <TD width=16% class="blue"> 
                    <div align="left">客户类别</div>
                  </TD>
                  <TD width=34% class="blue"> 
                    <select align="left" name=ownerType onChange="change()" width=50 index="6">
					<%
					//得到输入参数
					String sqlStrt ="select TYPE_CODE,TYPE_NAME from sCustTypeCode Order By TYPE_CODE";
					//retArray = callView.view_spubqry32("2",sqlStr);
					//int recordNum = Integer.parseInt((String)retArray.get(0));
					//result = (String[][])retArray.get(1);
					// result = (String[][])retArray.get(0);	
					%>
					<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCodet" retmsg="retMsgt" outnum="2">
					<wtc:sql><%=sqlStrt%></wtc:sql>
					</wtc:pubselect>
					<wtc:array id="resultt" scope="end" />
					<%	
					int recordNum=0;
					if(retCodet.equals("000000")){
						System.out.println("服务sPubSelect调用成功");
						recordNum = resultt.length;  
						System.out.println("recordNum  _________________________________________________________"+recordNum);
					}		
					//根据登录工号到sfuncpower 中查看是否有集团客户开户权限
					/*
					sqlStr="select count(*) from sfuncpower where function_code='1993' and power_code in (select power_code from dloginmsg where login_no='" +workNo+ "')";
					retArray = callView.view_spubqry32("1",sqlStr);
					int recordNum1 = Integer.parseInt(((String[][])retArray.get(0))[0][0]);
					System.out.println("sqlStr="+sqlStr);
					System.out.println("recordNum="+recordNum1 );
					*/
					//sunwt 修改 20080429
					String paramsIn[] = new String[2];
					paramsIn[0] = workNo;       //工号
					paramsIn[1] = "1993";        //操作代码
					
					//SPubCallSvrImpl callViewCheck = new SPubCallSvrImpl();
					//ArrayList acceptList = new ArrayList();
					/**	try
					{
					acceptList = callViewCheck.callFXService("sFuncCheck", paramsIn, "1","region", regionCode);	
					errCode = callViewCheck.getErrCode();
					errMsg = callViewCheck.getErrMsg();
					}
					catch(Exception e)
					{
					e.printStackTrace();
					logger.error("Call sFuncCheck is Failed!");
					}
					**/
					%>
					<wtc:service name="sFuncCheck" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg"  outnum="1" >
					<wtc:param value="sFuncCheck"/>
					<wtc:params value="<%=paramsIn%>"/>
					<wtc:param value="1"/>
					<wtc:param value="region"/>
					<wtc:param value="<%=regionCode%>"/>
					</wtc:service>
					<wtc:array id="resultr" scope="end" />					
					<%
						System.out.println("_________________________________________________________________________");
						for(int i=0;i<resultr.length;i++){
							for(int j=0;j<resultr[i].length;j++){
								System.out.println("resultr["+i+"]["+j+"]"+"   "+resultr[i][j]);
	                        }
                  		}
				System.out.println("_________________________________________________________________________");

			if(retCode.equals("000000")){
					System.out.println("***************************************************************************");
					System.out.println("调用sFuncCheck成功"+"___retCode :"+retCode+"  retMsg: "+retMsg);
					int recordNum1 =  resultr.length;       //把count(*)取出
					System.out.println("recordNum1________________________________"+recordNum1);
					for(int i=0;i<recordNum;i++){
					if(!"01".equals(resultt[i][0]) && 0==recordNum1) {
						continue;
					}
						out.println("<option class='button' value='" + resultt[i][0] + "'>" + resultt[i][1] + "</option>");
					}
			}else{
					System.out.println("***************************************************************************");
					System.out.println("调用sFuncCheck失败"+"___retCode :"+retCode+"  retMsg: "+retMsg);
			}

			%>
                    </select>
                  <!--wangzn add 091201 潜在集团升签约 b-->
  <span id="preBox" style="display:none" value='1'>&nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    &nbsp;&nbsp;&nbsp;&nbsp;
                  潜在集团升签约<input type="checkbox" id="isPre" name="isPre" onClick="preTrShow(this)" /></span>
                  <!--wangzn add 091201 潜在集团升签约 e-->
                  </TD>
                  <TD width=16% class="blue" > 
                  	
                    <div align="left">客户ID</div>
                  </TD>
                  <TD width="34%" class="blue" > 
                    <input name=custId v_type="0_9" class="button" v_must=1 v_name="客户ID" maxlength="14" readonly>
                    <font class=orange>*</font> 
                    <input name=custQuery type=button class="b_text" onmouseup="getId();" onkeyup="if(event.keyCode==13)getId();" style="cursor:hand" id="accountIdQuery" value=获得 index="7">
                  </TD>
                </TR>
                
                <!-- tianyang add for custNameCheck start -->
                <tr id="ownerType_Type">
                	<TD width=16% class="blue" > 
                    <div align="left">个人开户分类</div>
                  </TD>
                  <TD colspan="3" width="34%" class="blue" >
                  	<select align="left" name="isJSX" onChange="reSetCustName()" width=50 index="6">
                  		<option class="button" value="0">非介绍信开户</option>
                  		<option class="button" value="1">介绍信开户</option>                  		
                  	<select align="left" name=isJSX onChange="" width=50 index="6">
                  </TD>
                </tr>
                <!-- tianyang add for custNameCheck end -->
                <!--zhangyan add 客户服务等级 b-->
                <tr id="svcLvl"  style="display:none">
                	<TD width=16% class="blue" > 
                    	<div align="left">客户服务等级</div>
                 	</TD>
                  	<TD colspan="3" width="34%" class="blue" >
						<select align="left"  name = "selSvcLvl" id = "selSvcLvl" >
							<option class="button"  value="00" >00—>标准级服务</option>
							<option class="button"  value="01" >01—>金牌级服务</option>
							<option class="button"  value="02" >02—>银牌级服务</option>
							<option class="button"  value="03" >03—>铜牌级服务</option>
						</select>
                  	</TD>
                </tr> 
                <!--zhangyan add 客户服务等级 e-->            
              
                
                
                <TR> 
                  <TD> 
                    <div align="left" class="blue" >客户归属市县</div>
                  </TD>
                  <TD> 
                    <select align="left" name=districtCode width=50 index="8">
                      <%
        //得到输入参数
                String sqlStr2 ="select trim(DISTRICT_CODE),DISTRICT_NAME from  SDISCODE Where region_code='" + regionCode + "' order by DISTRICT_CODE";                     
               // retArray = callView.view_spubqry32("2",sqlStr);
                
			%>
			<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
			<wtc:sql><%=sqlStr2%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result2" scope="end" />
			<%


 if(retCode2.equals("000000")){
     
      System.out.println("调用服务成功！");
              int recordNum2 = result2.length;
                for(int i=0;i<recordNum2;i++){
                	if(result2[i][0].trim().equals(districtCode)){
                  	out.println("<option class='button' value='" + result2[i][0] + "'  selected >" + result2[i][1] + "</option>");
                  }
                	else{
                		out.println("<option class='button' value='" + result2[i][0] + "' >" + result2[i][1] + "</option>");
                	}
                }
      
       }else{
    	 System.out.println("***********************************************************************");
         System.out.println("调用服务失败！");
    	   
    	}         
               
               
%>
                    </select>
                  </TD>
                  <TD class="blue" > 
                    <div align="left">客户名称</div>
                  </TD>
                  <TD> 
                    <input name=custName id="custName"   v_must=1 v_maxlength=60 v_type="string" onkeyup="feifaCustName(this);"  onchange="change_ConPerson()"  maxlength="60" size=20 index="9" onblur="if(checkElement(this)){change_ConPerson()}">
                    <div id="checkName" style="display:none"><input type="button" class="b_text" value="验证" onclick="checkName()"></div>
                    <font class=orange>*</font>
                    <!--<font class=orange>*&nbsp;(客户名称为汉字且不得超过六个)</font>-->
                    </TD>
                </TR>
                <tr> 
                  <td width=16% class="blue" > 
                    <div align="left">证件类型</div>
                  </td>
                  <td width=34%> 
                    <select align="left" name=idType onChange="change_idType()" width=50 index="10">
                      <%
                      
        //得到输入参数
         String sqlStr3 ="select trim(ID_TYPE), ID_NAME,ID_NAME from sIdType order by id_type";           
 %>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode3" retmsg="retMsg3" outnum="3">
<wtc:sql><%=sqlStr3%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result3" scope="end" /> 
 <%
      if(retCode3.equals("000000")){
     
      System.out.println("调用服务成功！");
              int recordNum3 = result3.length;                  
                for(int i=0;i<recordNum3;i++){
                        out.println("<option class='button' value='" + result3[i][0] + "|" + result3[i][2] + "'>" + result3[i][1] + "</option>");
                }
      
       }else{
    	 System.out.println("***********************************************************************");
         System.out.println("调用服务失败！");
    	   
    	}              
               
           
%>
                    </select>
                  </td>
                  <td width=16% class="blue" > 
                    <div align="left">证件号码</div>
                  </td>
                  <td width=34%> 
                    <input name="idIccid"  id="idIccid"     v_minlength=5 v_maxlength=20 v_type="string" onChange="change_idType()" maxlength="18"  index="11" value="" onBlur="feifa(this);">
                    <input type="button" name="idCheck" class="b_text" value="验证" onclick="rpc_chkX('idType','idIccid','A')" >
                    <input type="button" name="iccIdCheck" class="b_text" value="校验" onclick="checkIccId()" >
		    <input type="hidden" name="IccIdAccept" value="<%=IccIdAccept%>">
                    <font class=orange>*</font> </td>
                </tr>
                
<TR id="card_id_type">
	    
      <td colspan=2 align=center>
  			<input type="button" name="read_idCard_one" class="b_text"   value="扫描一代身份证" onClick="RecogNewIDOnly_one()" disabled>
				<input type="button" name="read_idCard_two" class="b_text"   value="扫描二代身份证" onClick="RecogNewIDOnly_two()"disabled>
				<input type="button" name="scan_idCard_two" class="b_text"   value="读卡" onClick="Idcard()" disabled>
				<input type="button" name="get_Photo" class="b_text"   value="显示照片" onClick="getPhoto()" disabled>
  			
				</td>
  <td  class="blue">
      	证件照片上传
      </td>
      <td>
      	
				 <input type="file" name="filep" id="filep"  onchange="chcek_pic();" >    &nbsp;
				 
				 <iframe name="upload_frame" id="upload_frame" style="display:none"></iframe>
				
				<input type="hidden" name="idSexH" value="1">
  			<input type="hidden" name="birthDayH" value="20090625">
  			<input type="hidden" name="idAddrH" value="哈尔滨">
  			
				 <input type="button" name="uploadpic_b" class="b_text"   value="上传照片" onClick="uploadpic()"  disabled>
      	
      	</td>
     </tr>
                <tr> 
                  <td class="blue" > 
                    <div align="left">证件地址</div>
                  </td>
                  <td> 
                    <input name=idAddr  id="idAddr"    v_must=1 v_type="string"  maxlength="60" v_maxlength=60 size=30 index="12" onblur="if(checkElement(this)){changeCardAddr(this)}">
                    <font class=orange>*</font> </td>
                  <td class="blue" > 
                    <div align="left">证件有效期</div>
                  </td>
                  <td> 
                    <input class="button" name=idValidDate v_must=0 v_maxlength=8 v_type="date"  maxlength=8 size="8" index="13" onblur="if(checkElement(this)){chkValid();}">
                    <!--
                    <img src="../../js/common/date/button.gif" style="cursor:hand"  onclick="fPopUpCalendarDlg(idValidDate);return false" alt=弹出日历下拉菜单 align=absMiddle readonly>
                     -->
                  </td>
                </tr>
				
				
			 <TR>      
			
				   <jsp:include page="f1100_pwd.jsp">
					  <jsp:param name="width1" value="16%"  />
					  <jsp:param name="width2" value="34%"  />
					  <jsp:param name="pname" value="custPwd"  />
					  <jsp:param name="pcname" value="cfmPwd"  />
			 			<jsp:param name="pvalue" value="" />
				   </jsp:include>
			  </TR>
                <!--TR bgcolor="#EEEEEE"> 
                  <TD> 
                    <div align="left">客户密码：</div>
                  </TD>
                  <TD bgcolor="#EEEEEE"> 
                    <input name=custPwd type="password" v_type="0_9" class="button" v_must=0 v_maxlength=6 v_name="客户密码" maxlength="6" id=passwd1 index="14">
                  </TD>
                  <TD> 
                    <div align="left">校验客户密码：</div>
                  </TD>
                  <TD> 
                    <input name=cfmPwd type="password" class="button" v_type="0_9" v_must=0 v_maxlength=6 v_name="校验客户密码" maxlength="6"  index="15">
                  </TD>
                </TR-->
                <TR> 
                  <TD class="blue" > 
                    <div align="left">客户状态</div>
                  </TD>
                  <TD colspan="3"> 
                    <select align="left" name=custStatus width=50 index="16">
                      <%
        //得到输入参数
       
                String sqlStr4 ="select trim(STATUS_CODE),STATUS_NAME from sCustStatusCode order by STATUS_CODE";                      
               // retArray = callView.view_spubqry32("2",sqlStr4);
                //int recordNum = Integer.parseInt((String)retArray.get(0));
                //result = (String[][])retArray.get(1);
               // result = (String[][])retArray.get(0);
               
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode4" retmsg="retMsg4" outnum="2">
<wtc:sql><%=sqlStr4%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result4" scope="end" /> 
<%
         
          if(retCode4.equals("000000")){
     
      System.out.println("调用服务成功！");
              
                int recordNum4 = result4.length;                  
                for(int i=0;i<recordNum4;i++){
                        out.println("<option class='button' value='" + result4[i][0] + "'>" + result4[i][1] + "</option>");
                }
      
       }else{
    	 System.out.println("***********************************************************************");
         System.out.println("调用服务失败！");
    	   
    	}      
%>


<%             
%>
                    </select>
                    <select  align="left" name=custGrade width=50 index="17" style="display:none" >
                      <%
        //得到输入参数
          String sqlStr5 ="select trim(OWNER_CODE), TYPE_NAME from sCustGradeCode " + 
                   " where REGION_CODE ='" + regionCode + "' order by OWNER_CODE";                  
                //retArray = callView.view_spubqry32("2",sqlStr5);
                //int recordNum = Integer.parseInt((String)retArray.get(0));
                //result = (String[][])retArray.get(1);
                //result = (String[][])retArray.get(0);
               
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode5" retmsg="retMsg5" outnum="2">
<wtc:sql><%=sqlStr5%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result5" scope="end" /> 

<%    
    if(retCode5.equals("000000")){
     
      System.out.println("调用服务成功！");
              
               int recordNum5 = result5.length;                  
                for(int i=0;i<recordNum;i++){
                        out.println("<option class='button' value='" + result5[i][0] + "'>" + result5[i][1] + "</option>");
                }
      
       }else{
    	 System.out.println("***********************************************************************");
         System.out.println("调用服务失败！");
    	   
    	}      

               
%>
                    </select>
                  </TD>
                </TR>
                <TR> 
                  <TD class="blue" > 
                    <div align="left">客户地址</div>
                  </TD>
                  <TD colspan="3"> 
                    <input name=custAddr class="button" v_type="string" v_must=1 v_maxlength=60  onchange="change_ConAddr()" maxlength="60" size=35 index="18" onblur="checkElement(this);">
                  	<font class=orange>*</font> 
                  </TD>
                  </TD>
                </TR>
                <!--wangzn add 091201 for潜在集团升签约 b-->
                <tr id="preTr" style="display:none"> 
                	<td class="blue" >潜在集团编号</td>
                	<td colspan="3"><input name="preUnitId" id="preUnitId" class="button"  maxlength="20" size=20 v_type=0_9 v_must=0 v_minlength=10 ><font class=orange>*</font>
                  <input name=preUnitIdQuery type=button class="b_text" onmouseup="preGrpQuery()" onkeyup="if(event.keyCode==13)preGrpQuery();" style="cursor:hand" id="preUnitIdQuery" value=查询 >
                </tr>
                 <!--wangzn add 091201 for潜在集团升签约 e-->
                <TR> 
                  <TD class="blue" > 
                    <div align="left">联系人姓名</div>
                  </TD>
                  <TD>                  		
                  	<input name=contactPerson class="button" value="" v_type="string" onkeyup="feifaCustName(this);" maxlength="60" size=20 index="19" v_must=1 v_maxlength=20 onblur="checkElement(this);">
                  	<font class=orange>*</font>
                  	<!--<font class=orange>*&nbsp;(联系人姓名为汉字且不得超过六个)</font>-->
                  </TD>
                  <TD class="blue" > 
                    <div align="left">联系人电话</div>
                  </TD>
                  <TD> 
                    <input name=contactPhone class="button" v_must=1 v_type="phone" maxlength="20"  index="20" size="20" onblur="checkElement(this);">
                    <font class=orange>*</font> </TD>
                </TR>
                <TR> 
                  <TD class="blue" > 
                    <div align="left">联系人地址</div>
                  </TD>
                  <TD> 
                    <input name=contactAddr  class="button" v_must=1 v_type="string"  maxlength="60" v_maxlength=60 size=30 index="21"  onpropertychange="document.all.contactMAddr.value=this.value;" onblur="if(checkElement(this)){document.all.contactMAddr.value=this.value;}">
                    <font class=orange>*</font> </TD>
                  <TD class="blue" > 
                    <div align="left">联系人邮编</div>
                  </TD>
                  <TD> 
                    <input name=contactPost class="button" v_type="zip" v_name="联系人邮编" maxlength="6"  index="22" size="20">
                  </TD>
                </TR>
                <TR> 
                  <TD class="blue" > 
                    <div align="left">联系人传真</div>
                  </TD>
                  <TD> 
                    <input name=contactFax class="button" v_must=0 v_type="phone" v_name="联系人传真" maxlength="20"  index="23" size="20">
                  </TD>
                  <TD class="blue" > 
                    <div align="left">联系人E_MAIL</div>
                  </TD>
                  <TD> 
                    <input name=contactMail class="button" v_must=0 v_type="email" v_name="联系人E_MAIL" maxlength="30" size=30 index="24">
                  </TD>
                </TR>
                <TR> 
                  <TD class="blue" > 
                    <div align="left">联系人通讯地址</div>
                  </TD>
                  <TD colspan="3"> 
                    <input name=contactMAddr class="button" v_must=1 v_maxlength=60 v_type="string"  maxlength="60" size=30 index="25" onblur="checkElement(this);">
                    <font class=orange>*</font></TD>
                </TR>
                </TBODY> 
              </TABLE> 
                                        
              <TABLE id=tb0 cellSpacing="0" >
                <TBODY> 
                <TR> 
                  <TD width=16% class="blue" > 
                    <div align="left">客户性别</div>
                  </TD>
                  <TD width=34%> 
                    <select align="left" name=custSex width=50 index="26">
                      <%
        //得到输入参数
            String sqlStr6 ="select trim(SEX_CODE), SEX_NAME from ssexcode order by SEX_CODE";                 
                //retArray = callView.view_spubqry32("2",sqlStr6);
                //int recordNum = Integer.parseInt((String)retArray.get(0));
                //result = (String[][])retArray.get(1);
                //result = (String[][])retArray.get(0);
              
 %>
 <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode6" retmsg="retMsg6" outnum="2">
<wtc:sql><%=sqlStr6%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result6" scope="end" /> 

<%    
    if(retCode6.equals("000000")){
     
      System.out.println("调用服务成功！");
              
                int recordNum6 = result6.length;                  
                for(int i=0;i<recordNum6;i++){
                        out.println("<option class='button' value='" + result6[i][0] + "'>" + result6[i][1] + "</option>");
                }
      
       }else{
    	 System.out.println("***********************************************************************");
         System.out.println("调用服务失败！");
    	   
    	}            
%>
                    </select>
                  </TD>
                  <TD width=16%  class="blue" > 
                    <div align="left">出生日期</div>
                  </TD>
                  <TD width="34%"> 
                    <input  name=birthDay id="birthDay"   maxlength=8 index="27"  v_must=0 v_maxlength=8 v_type="date" size="8" onblur="checkElement(this);">
                    <!--
                    <img src="../../js/common/date/button.gif" style="cursor:hand"  onclick="fPopUpCalendarDlg(birthDay);return false" alt=弹出日历下拉菜单 align=absMiddle >
                -->
                  </TD>
                </TR>
                <TR> 
                  <TD class="blue" > 
                    <div align="left">职业类别</div>
                  </TD>
                  <TD> 
                    <select align="left" name=professionId width=50 index="28">
                      <%
        //得到输入参数
      
                String sqlStr7 ="select trim(PROFESSION_ID), PROFESSION_NAME from sprofessionid order by PROFESSION_ID DESC";                      
              //  retArray = callView.view_spubqry32("2",sqlStr7);
                //int recordNum = Integer.parseInt((String)retArray.get(0));
                //result = (String[][])retArray.get(1);
               // result = (String[][])retArray.get(0);
               
%>
 <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode7" retmsg="retMsg7" outnum="2">
<wtc:sql><%=sqlStr7%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result7" scope="end" /> 

<%    
    if(retCode7.equals("000000")){
     
      System.out.println("调用服务成功！");
              
               int recordNum7 = result7.length;                  
                for(int i=0;i<recordNum7;i++){
                        out.println("<option class='button' value='" + result7[i][0] + "'>" + result7[i][1] + "</option>");
                }
      
       }else{
    	 System.out.println("***********************************************************************");
         System.out.println("调用服务失败！");
    	   
    	}            
%>
                    </select>
                  </TD>
                  <TD class="blue" > 
                    <div align="left">学历</div>
                  </TD>
                  <TD> 
                    <select align="left" name=vudyXl width=50 index="29">
                      <%
        //得到输入参数
           String sqlStr8 ="select trim(WORK_CODE), TYPE_NAME from SWORKCODE Where region_code ='" + regionCode + "' order by work_code DESC";                    
              //  retArray = callView.view_spubqry32("2",sqlStr8);
                //int recordNum = Integer.parseInt((String)retArray.get(0));
                //result = (String[][])retArray.get(1);
                //result = (String[][])retArray.get(0);
               
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode8" retmsg="retMsg8" outnum="2">
<wtc:sql><%=sqlStr8%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result8" scope="end" /> 

<%    
    if(retCode8.equals("000000")){
     
      System.out.println("调用服务成功！");
              
             int recordNum8 = result8.length;                  
                for(int i=0;i<recordNum8;i++){
                        out.println("<option class='button' value='" + result8[i][0] + "'>" + result8[i][1] + "</option>");
                }
      
       }else{
    	 System.out.println("***********************************************************************");
         System.out.println("调用服务失败！");
    	   
    	}    
  %>
                    </select>
                  </TD>
                </TR>
                <TR> 
                  <TD class="blue" > 
                    <div align="left">客户爱好</div>
                  </TD>
                  <TD> 
                    <input name=custAh class="button" maxlength="20"  index="30" size="20">
                  </TD>
                  <TD class="blue" > 
                    <div align="left">客户习惯</div>
                  </TD>
                  <TD> 
                    <input name=custXg class="button" maxlength="20"  index="31">
                  </TD>
                </TR>
                </TBODY> 
              </TABLE>                                
        
              <TABLE id=tb1 cellSpacing="0" style="display:none">
                <TBODY> 

                <TR> 
                  <TD width=16% class="blue" > 
                    <div align="left">单位性质</div>
                  </TD>
                  <TD width=34%> 
                    <select align="left" name=unitXz1 width=50 index="32">
                      <%
                      //得到输入参数
               
                String sqlStr9 ="select trim(TYPE_CODE), TYPE_NAME from sunittype order by TYPE_CODE";                    
                //retArray = callView.view_spubqry32("2",sqlStr9);
                //int recordNum = Integer.parseInt((String)retArray.get(0));
                //result = (String[][])retArray.get(1);
                //result = (String[][])retArray.get(0);
                
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode9" retmsg="retMsg9" outnum="2">
<wtc:sql><%=sqlStr9%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result9" scope="end" /> 

<%    
    if(retCode9.equals("000000")){
     
      System.out.println("调用服务成功！");
              
            int recordNum9 = result9.length;                  
                for(int i=0;i<recordNum9;i++){
                        out.println("<option class='button' value='" + result9[i][0] + "'>" + result9[i][1] + "</option>");
                }
      
       }else{
    	 System.out.println("***********************************************************************");
         System.out.println("调用服务失败！");
    	   
    	}          
%>
                    </select>
                  </TD>
                  <TD width=16% class="blue" > 
                    <div align="left">营业执照类型</div>
                  </TD>
                  <TD width=34%> 
                    <select align="left" name=yzlx width=50 index="33">
                      <%
        //得到输入参数
        
                String sqlStr10 ="select trim(LINCENT_TYPE), TYPE_NAME from slicencetype order by LINCENT_TYPE";                
               // retArray = callView.view_spubqry32("2",sqlStr10);
                //int recordNum = Integer.parseInt((String)retArray.get(0));
                //result = (String[][])retArray.get(1);
               // result = (String[][])retArray.get(0);
              
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode10" retmsg="retMsg10" outnum="2">
<wtc:sql><%=sqlStr10%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result10" scope="end" /> 
<%    
    if(retCode10.equals("000000")){
     
      System.out.println("调用服务成功！");
              
           int recordNum10 = result10.length;                  
                for(int i=0;i<recordNum10;i++){
                        out.println("<option class='button' value='" + result10[i][0] + "'>" + result10[i][1] + "</option>");
                }
      
       }else{
    	 System.out.println("***********************************************************************");
         System.out.println("调用服务失败！");
    	   
    	}                       
%>
                    </select>
                  </TD>
                </TR>
                
                
                <TR> 
                  <TD class="blue" > 
                    <div align="left">营业执照号码</div>
                  </TD>
                  <TD> 
                    <input name=yzhm class="button" maxlength="20"  index="34">
                  </TD>
                  <TD class="blue" > 
                    <div align="left">营业执照有效期</div>
                  </TD>
                  <TD> 
                    <input name=yzrq class="button"  index="35" v_must=0 v_maxlength=8 v_type="date" v_name="营业执照有效期" maxlength=8 size="8">
                  </TD>
                </TR>
                <TR> 
                  <TD class="blue" > 
                    <div align="left">法人代表</div>
                  </TD>
                  <TD COLSPAN="3"> 
                    <input name=frdm class="button" maxlength="20"  index="36">
                  </TD>
                </TR>
                </TBODY> 
              </TABLE>
              
              
			     <TABLE width=100% id=td2 cellSpacing="0" style="display:none">
            
                <TR> 
				     
                  <TD width=16% class="blue" > 
                    <div align="left">原集团号</div>
                  </TD>
                  <TD width=84%> 
         			  <div align="left"><input name=oriGrpNo class="button" maxlength="10"  index="37" v_must=0 v_maxlength=10 v_type=0_9 v_name="原集团号"></div>
					   </td>
				   </tr>
				   
				   
				 <TABLE id=td3  cellSpacing="0" style="display:none">
				 	<TBODY> 
               <TR> 
         <TD width=16% class="blue" > 
                    <div align="left">集团等级</div>
                  </TD>
                  <TD width=34% colspan="3"> 
                    <select align="left" name=unitXz width=50 index="32">
<%
                //得到输入参数
           
                String sqlStr11 ="select trim(owner_code), owner_NAME from dbvipadm.sGrpOwnerCode  where owner_code in ('C1','C2','C3')";                    
               // retArray = callView.view_spubqry32("2",sqlStr11);
                //int recordNum = Integer.parseInt((String)retArray.get(0));
                //result = (String[][])retArray.get(1);
              //  result = (String[][])retArray.get(0);
              
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode11" retmsg="retMsg11" outnum="2">
<wtc:sql><%=sqlStr11%></wtc:sql>
</wtc:pubselect>
<wtc:array id="result11" scope="end" /> 

<%    
    if(retCode11.equals("000000")){
     
      System.out.println("调用服务成功！");
              
            int recordNum11 = result11.length;                  
                for(int i=0;i<recordNum11;i++){
                        out.println("<option class='button' value='" + result11[i][0] + "'>" + result11[i][1] + "</option>");
                }
      
       }else{
    	 System.out.println("***********************************************************************");
         System.out.println("调用服务失败！");
    	   
    	}            


      
%>
                   </select>
                  </TD>
                </TR>
    <!--luxc 20080326 add-->
    <tr>
    	<td width=16% class="blue" >是否是策反集团</td>
    	<td width=34%>
    		<select align="left" name="instigate_flag" onChange="change_instigate()" width=50 index="42">
    			<option class="button" value="0">...请选择...</option>
    			<option class="button" value="Y">是->Y</option>
    			<option class="button" value="N">否->N</option>
    		</select>
    		<font class=orange>*</font>
    	</td>
    	<td width=17% class="blue" >是否获得竞争对手协议</td>
    		
    	<td width=33%>
    		<select align="left" name="getcontract_flag" width=50 index="42" disabled >
    			<option class="button" value="0">...请选择...</option>
    			<option class="button" value="Y">是->Y</option>
    			<option class="button" value="N">否->N</option>
    		</select>
    	</td>
	</tr>  
	<!--luxc 20080326 add end-->
	
	   </TBODY> 
	  </TABLE>			  
  <TABLE cellSpacing="0">
    <TBODY> 
    <TR style="display:none"> 
      <TD width=16% class="blue" > 
        <div align="left">系统备注</div>
      </TD>
      <TD> 
        <input class="button" name=sysNote size=60 readonly maxlength="60">
      </TD>
    </TR>
    <TR> 
      <TD width="16%" class="blue" > 
        <div align="left">用户备注</div>
      </TD>
      <TD> 
        <input name=opNote class="button" size=60 maxlength="60" index="38"  v_must=0 v_maxlength=60 v_type="string" v_name="用户备注">
      </TD>
    </TR>
    </TBODY> 
  </TABLE>                           
<TABLE cellSpacing="0">
  <TBODY>
    <TR> 
          <TD align=center id="footer"> 
            <input class="b_foot_long" name=print  onclick="printCommit()" onkeyup="if(event.keyCode==13)printCommit()"  type=button value=确认  index="39" disabled>
	        <input class="b_foot" name=reset1 type=button  onclick=" window.location.href='f1100_1.jsp';" value=清除 index="40">
	        <input class="b_foot" name=back type=button onclick="
	        <% 
                if("1".equals(inputFlag)){ 
                    out.print(" window.close() ");
                }else{
                    out.print(" removeCurrentTab() ");
                } 
            %>
	        " value=关闭 index="41">
            <input type="reset" name="Reset" value="Reset" style="display:none">
          </TD>
    </TR>
  </TBODY>
</TABLE>
  <input type="hidden" name="ReqPageName" value="f1100_1">
  <input type="hidden" name="workno" value=<%=workNo%>>
  <input type="hidden" name="regionCode" value=<%=regionCode%>> 
  <input type="hidden" name="unitCode" value=<%=orgCode%>>
  <input type="hidden" id=in6 name="belongCode" value=<%=belongCode%>>  
  <input type="hidden" id=in1 name="hidPwd" v_name="原始密码">
  <input type="hidden" name="hidCustPwd">  			<!--加密后的客户密码-->
  <input type="hidden" name="temp_custId">
  <input type="hidden" name="ip_Addr" value=<%=ip_Addr%>>
  <input type="hidden" name="inParaStr" >
  <input type="hidden" name="checkPwd_Flag" value="false">		<!--密码校验标志-->
  <input type="hidden" name="workName" value=<%=workName%> >
  <input type="hidden" name="opCode" value="<%=opCode%>">
  
  <input type="hidden" name="assu_name" value="">
  <input type="hidden" name="assu_phone" value="">
  <input type="hidden" name="assu_idAddr" value="">
  <input type="hidden" name="assu_idIccid" value="">
  <input type="hidden" name="assu_conAddr" value="">
  <input type="hidden" name="assu_idType" value="">
  <input type="hidden" name="inputFlag" value="<%=inputFlag%>">
  <iframe name='hidden_frame' id="hidden_frame" style='display:none'></iframe>
  <input type="hidden" name="card_flag" value="">  <!--身份证几代标志-->
  <input type="hidden" name="pa_flag" value="">  <!--证件标志-->
  <input type="hidden" name="m_flag" value="">   <!--扫描或者读取标志，用于确定上传图片时候的图片名-->
  <input type="hidden" name="sf_flag" value="">   <!--扫描是否成功标志-->
  <input type="hidden" name="pic_name" value="">   <!--标识上传文件的名称-->
	<input type="hidden" name="up_flag" value="0">
	<input type="hidden" name="but_flag" value="0"> <!--按钮点击标志-->
	<input type="hidden" name="upbut_flag" value="0"> <!--上传按钮点击标志-->
	<input type="hidden" name="ziyou_check" value="<%=resultl0[0][0]%>">
  <%@ include file="/npage/include/footer.jsp" %> 
<jsp:include page="/npage/common/pwd_comm.jsp"/>
</form>
</body>
<%@ include file="interface_provider.jsp" %>   
</html>
