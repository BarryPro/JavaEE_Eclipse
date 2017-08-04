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
  response.setHeader("Pragma","No-cache");
  response.setHeader("Cache-Control","no-cache"); 
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
    
    // zhouby add for 开户优惠权限
    String[][] temfavStr = (String[][])session.getAttribute("favInfo");
    String[] favStr = new String[temfavStr.length];
    boolean openFav = false;
    for(int i = 0; i < favStr.length; i ++) {
    	favStr[i] = temfavStr[i][0].trim();
    }
    if (WtcUtil.haveStr(favStr, "a386")) {
    	openFav = true;
    }
    
    String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
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
    String input_accept = WtcUtil.repNull((String)request.getParameter("input_accept"));
    String retforwardflag = WtcUtil.repNull((String)request.getParameter("retforwardflag"));
    
    /*关于落实打击黑卡工作的BOSS优化补充需求地市配置表start*/
    String sql_appregionset1 = "select count(*) from sOrderCheck where group_id=:groupids and flag='Y' ";
    String sql_appregionset2 = "groupids="+groupId;
    String appregionflag="0";//==0只能进行工单查询，>0可以进行工单查询或者读卡
 %>
 		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCodeappregion" retmsg="retMsgappregion" outnum="1"> 
			<wtc:param value="<%=sql_appregionset1%>"/>
			<wtc:param value="<%=sql_appregionset2%>"/>
		</wtc:service>  
		<wtc:array id="appregionarry"  scope="end"/>
<%
			if("000000".equals(retCodeappregion)){
				if(appregionarry.length > 0){
					appregionflag = appregionarry[0][0]; 
				}
		}
		/*关于落实打击黑卡工作的BOSS优化补充需求地市配置表end*/
    String accountType =  (String)session.getAttribute("accountType")==null?"":(String)session.getAttribute("accountType");//1 为营业工号 2 为客服工号
		String sql_sendListOpenFlag = "select count(*) from shighlogin where login_no='K' and op_code='m194'";
		String sendListOpenFlag = "0"; //下发工单开关 0：关，>0：开
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1"> 
			<wtc:param value="<%=sql_sendListOpenFlag%>"/>
		</wtc:service>  
		<wtc:array id="ret1"  scope="end"/>
<%
		if("000000".equals(retCode1)){
			if(ret1.length > 0){
				sendListOpenFlag = ret1[0][0]; 
			}
		}
		
		String sql_regionCodeFlag [] = new String[2];
	  sql_regionCodeFlag[0] = "select count(*) from shighlogin where op_code ='m195' and login_no=:regincode";
	  sql_regionCodeFlag[1] = "regincode="+regionCode;
		String regionCodeFlag = "N"; //地市是否可见 下发工单按钮 Y可见，N不可见
%>
		<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode12" retmsg="retMsg12" outnum="1"> 
			<wtc:param value="<%=sql_regionCodeFlag[0]%>"/>
			<wtc:param value="<%=sql_regionCodeFlag[1]%>"/>
		</wtc:service>  
		<wtc:array id="ret2"  scope="end"/>
<%
		if("000000".equals(retCode12)){
			if(ret2.length > 0){
				if(Integer.parseInt(ret2[0][0]) > 0){
					regionCodeFlag = "Y"; 
				}
			}
		}

String passwd = ( String )session.getAttribute( "password" );
String workChnFlag = "0" ;
%>
<wtc:service name="s1100Check" outnum="30"
	routerKey="region" routerValue="<%=regionCode%>" retcode="rc" retmsg="rm" >
	<wtc:param value = ""/>
	<wtc:param value = "01"/>
	<wtc:param value = "<%=opCode%>"/>
	<wtc:param value = "<%=workNo%>"/>
	<wtc:param value = "<%=passwd%>"/>
		
	<wtc:param value = ""/>
	<wtc:param value = ""/>
</wtc:service>
<wtc:array id="rst" scope="end" />
<%
if ( rc.equals("000000") )
{
	if ( rst.length!=0 )
	{
		workChnFlag = rst[0][0];
	}
	else
	{
	%>
		<script>
			rdShowMessageDialog( "服务s1100Check没有返回结果!" );
			removeCurrentTab();
		</script>
	<%	
	}
}
else
{
%>
	<script>
		rdShowMessageDialog( "<%=rc%>:<%=rm%>" );
		removeCurrentTab();
	</script>
<%
}
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
      System.out.println("# inputFlag = "+inputFlag);
      String cont_tp = "";
      String group_name = "";
      String cont_user = "";
      String cont_mobile = "";
      String cont_addr = "";
      String cont_email = "";
      String cont_zip = "";
      
      if("1".equals(inputFlag)){
          cont_tp = (String)request.getParameter("cont_tp");          //集团客户级别
          group_name = (String)request.getParameter("group_name");    //集团客户名称
          cont_user = (String)request.getParameter("cont_user");      //集团客户联系人
          cont_mobile = (String)request.getParameter("cont_mobile");  //集团客户联系电话
          cont_addr = (String)request.getParameter("cont_addr");      //集团客户联系地址
          cont_email = (String)request.getParameter("cont_email");    //集团客户联系邮箱
          cont_zip = (String)request.getParameter("cont_zip");        //集团客户联系邮编
      }
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
var phonesimstatus="0";

var v_groupId = "<%=groupId%>";
var v_printAccept = "<%=printAccept%>";
var v_workNo = "<%=workNo%>";
var phone_no = "";
onload=function(){
  /**
  if("09" == "<%=regionCode%>"){
    var divPassword = document.getElementById("divPassword"); 
      divPassword.style.display="none";
  }
  */
  /*2013/11/07 21:15:23 gaopeng 获取证件类型方法*/		
  if("<%=opCode%>" == "1993"){
  	$("#gestoresInfo1").show();
  	$("#gestoresInfo2").show();
  	$("#isDirectManageCustTr1").show();
  	$("#isDirectManageCustTr2").show();
  	/*经办人姓名*/
  	document.all.gestoresName.v_must = "1";
  	/*经办人地址*/
  	document.all.gestoresAddr.v_must = "1";
  	/*经办人证件号码*/
  	document.all.gestoresIccId.v_must = "1";
  	var checkIdType = $("select[name='gestoresIdType']").find("option:selected").val();
  	/*身份证加入校验方法*/
  	if(checkIdType.indexOf("身份证") != -1){
  		document.frm1100.gestoresIccId.v_type = "idcard";
  		//$("#scan_idCard_two3").css("display","");
  	}else{
  		document.frm1100.gestoresIccId.v_type = "string";
  		//$("#scan_idCard_two3").css("display","none");
  	}
  	
  	
  	//责任人信息
  	$("#responsibleInfo1").show();
  	$("#responsibleInfo2").show();

  	/*责任人人姓名*/
  	document.all.responsibleName.v_must = "1";
  	/*责任人人地址*/
  	document.all.responsibleAddr.v_must = "1";
  	/*经责任人人证件号码*/
  	document.all.responsibleIccId.v_must = "1";
  	var checkIdType22 = $("select[name='responsibleType']").find("option:selected").val();
  	/*身份证加入校验方法*/
  	if(checkIdType22.indexOf("身份证") != -1){
  		document.frm1100.responsibleIccId.v_type = "idcard";
  	}else{
  		document.frm1100.responsibleIccId.v_type = "string";
  	}	
  	
  	
  	
  	
  }
  	
  getIdTypes();
  /* begin add 如 1100+普通开户+身份证+社会渠道工号+开关+开展地市，则显示“下发工单”按钮 for 关于电话用户实名登记近期重点工作的通知 @2014/11/19 */
  if("<%=opCode%>" == "1100"){
  	var checkVal = $("select[name='isJSX']").find("option:selected").val();//个人开户分类 普通客户：0
		var idTypeSelect = $("#idTypeSelect option[@selected]").val();//证件类型：身份证
		if(idTypeSelect.indexOf("|") != -1){
			var v_idTypeSelect = idTypeSelect.split("|")[0];
			if(checkVal == "0" && v_idTypeSelect == "0" && "<%=workChnFlag%>" == "1" && (parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y" ){
				$("#sendProjectList").show();
				$("#sendProjectPhones").show();
				$("#sendProjectPhonesbiaozhi").show();				
				$("#qryListResultBut").show();
			}
			/* begin update for 关于开发智能终端CRM模式APP的函 - 第二批@2015/3/10 */
			if(v_idTypeSelect == "0"){ //身份证
				if("<%=workChnFlag%>" != "1"){ //自有营业厅
					//$("#idIccid").attr("class","InputGrey");
					//$("#idIccid").attr("readonly","readonly");
					//$("#custName").attr("class","InputGrey");
					//$("#custName").attr("readonly","readonly");
					//$("#idAddr").attr("class","InputGrey");
					//$("#idAddr").attr("readonly","readonly");
					//$("#idValidDate").attr("class","InputGrey");
					//$("#idValidDate").attr("readonly","readonly");
					$("#idIccid").val("");
					$("#custName").val("");
					$("#idAddr").val("");
					$("#idValidDate").val("");
				}else{ //社会渠道
					if((parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y"){ //集团公司查验开关为“开”+地市开关为“开”时
						//$("#idIccid").attr("class","InputGrey");
						//$("#idIccid").attr("readonly","readonly");
						//$("#custName").attr("class","InputGrey");
						//$("#custName").attr("readonly","readonly");
						//$("#idAddr").attr("class","InputGrey");
						//$("#idAddr").attr("readonly","readonly");
						//$("#idValidDate").attr("class","InputGrey");
						//$("#idValidDate").attr("readonly","readonly");
						$("#idIccid").val("");
						$("#custName").val("");
						$("#idAddr").val("");
						$("#idValidDate").val("");
					}
				}
			}
			/* end update for 关于开发智能终端CRM模式APP的函 - 第二批@2015/3/10 */
		}
  }
  /* end add for 关于电话用户实名登记近期重点工作的通知 @2014/11/19 */
  check_newCust();
  
    document.all.pa_flag.value="1";
    if(typeof(frm1100.custId)!="undefined")
    {   
        if(frm1100.custId.value != "")      //恢复到提交前的客户ID按钮显示状态
        {       frm1100.custQuery.disabled = true;           }
    }
    if((typeof(frm1100.idType)!="undefined")&&(typeof(frm1100.idIccid)!="undefined"))
    { change_idType('1');}  //还原到提交前的证件类型   
    change();//luxc 2008326 add 因为如果报错 返回页面不正确
    change_instigate();
    
    /*  add by qidp @ 2009-08-12 for 兼容端到端流程 .  */
    <% if("1".equals(inputFlag)){ %>
        document.all.ownerType[1].selected = true;
        change();
        
        document.all.unitXz.value = "<%=cont_tp%>";
        document.all.custName.value = "<%=group_name%>";
        document.all.contactPerson.value = "<%=cont_user%>";
        document.all.contactPhone.value = "<%=cont_mobile%>";
        document.all.custAddr.value = "<%=cont_addr%>";
        document.all.contactAddr.value = "<%=cont_addr%>";
        document.all.contactMAddr.value = "<%=cont_addr%>";
        document.all.contactMail.value = "<%=cont_email%>";
        document.all.contactPost.value = "<%=cont_zip%>";
    <% } %>
    /* end by qidp @ 2009-08-12 for 兼容端到端流程 . */
    if("1"=="<%=retforwardflag%>"){
		$("#isse276_100").val("1");
	}
	$("#isse276",window.parent.document).val("0");
}
/*2013/11/07 21:14:36 gaopeng 关于实名制工作需求整合的函*/
function getIdTypes(){
	 var checkVal = $("select[name='isJSX']").find("option:selected").val();
   var getdataPacket = new AJAXPacket("fq100GetIdTypes.jsp","正在获得数据，请稍候......");
			
			getdataPacket.data.add("checkVal",checkVal);
			getdataPacket.data.add("opCode","<%=opCode%>");
			getdataPacket.data.add("opName","<%=opName%>");
			getdataPacket.data.add("workChnFlag","<%=workChnFlag%>");
			core.ajax.sendPacketHtml(getdataPacket,resIdTypes);
			getdataPacket = null;
	
}
function resIdTypes(data){
				//alert(data);
			//找到添加的select
				var markDiv=$("#tdappendSome"); 
				//清空原有表格
				markDiv.empty();
				markDiv.append(data);
				var idTypeSelect = $("#idTypeSelect option[@selected]").val();
				/*2014/12/02 9:23:07 gaopeng 电子工单三期-开户增加高拍仪二代证识别功能 身份证的时候 
				显示高拍仪按钮*/
				if(idTypeSelect == "0|身份证"){
					$("input[name='highView']").show();
				}else{
					$("input[name='highView']").hide();
				}
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
      document.all.scan_idCard_two222.disabled=false;//二代证
      $("#scan_idCard_two222").attr("disabled",false);
      
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
    //为伊春,齐齐哈尔简单密码做判断 sunaj 20100126
    if("09" == "<%=regionCode%>")
    {
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
        //rdShowMessageDialog("校验成功111!",2);     
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
        /*document.all.print.disabled=true;*/
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
      //document.all.print.disabled=false;
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
  var Str = document.all.idType.value;
  
    if(Str.indexOf("身份证") > -1){
      if($("#idIccid").val().length<18){
        rdShowMessageDialog("身份证号码必须是18位！");
        document.all.idIccid.focus();
        return false;
      }
    }
  
  //document.all.iccIdCheck.disabled=true;
  var myPacket = new AJAXPacket("/npage/innet/fIccIdCheck.jsp","正在验证身份证信息，请稍候......");
  myPacket.data.add("retType","iccIdCheck");
  myPacket.data.add("idIccid",document.all.idIccid.value);
  myPacket.data.add("custName",document.all.custName.value);
  myPacket.data.add("IccIdAccept",document.all.IccIdAccept.value);
  myPacket.data.add("opCode",document.all.opCode.value);
  core.ajax.sendPacket(myPacket);
  myPacket=null;
  //document.all.iccIdCheck.disabled=false;
}

//dujl add at 20100421 for 身份证校验
// 获取身份证照片
function getPhoto()
{
  window.open("../innet/fgetIccIdPhoto.jsp?idIccid="+document.all.idIccid.value,"","width="+(screen.availWidth*1-900)+",height="+(screen.availHeight*1-500) +",left=450,top=240,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no");
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
  	
   
      if(idname=="身份证")
    {
        if(checkElement(obj_no)==false) return false;
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
/** if("09" == "<%=regionCode%>")
  {
    var divPassword = document.getElementById("divPassword"); 
      divPassword.style.display="none";
  }*/ 
  
      if(document.all.custQuery.disabled==true){document.all.custQuery.disabled=false}
      document.all.Reset.click();
         //新建客户的相关域控制
         document.getElementById("svcLvl").style.display="none";
         document.getElementById("trU00020003").style.display="none";
        if(document.frm1100.newCust.checked == true){
        window.document.frm1100.oldCust.checked = false;
        var temp1="tbs"+9;           
            document.all(temp1).style.display = "none";
            document.all("card_id_type").style.display="";
            window.document.frm1100.parentId.value = "";
            window.document.frm1100.parentPwd.value = "";
            window.document.frm1100.parentName.value = "";
            window.document.frm1100.parentAddr.value = "";
            window.document.frm1100.parentIdType.value = "";
            window.document.frm1100.parentIdidIccid.value = "";
        }
}
function check_oldCust(){
  /**
  if("09" == "<%=regionCode%>")
  {
    var divPassword = document.getElementById("divPassword"); 
      divPassword.style.display="none";
  }*/
  document.getElementById("svcLvl").style.display="none";
  document.getElementById("trU00020003").style.display="none";
  document.all.Reset.click();
  document.all("card_id_type").style.display="none";
  document.all.oldCust.checked=true;
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
        document.all("print").disabled=true;
        //document.all.custPwd.value="123456";
        //document.all.cfmPwd.value="123456";
       document.getElementById("preBox").style.display="none";//wangzn 091201
          document.getElementById("svcLvl").style.display="none";//zhangyan 2011-12-13 15:46:32 
          document.getElementById("trU00020003").style.display="none";//zhangyan 2011-12-13 15:46:32  
    }
    else if(ic=="02")
    {
         document.all("tb0").style.display="none";
         document.all("tb1").style.display="none";
         document.all("td2").style.display="none";
         document.all("td3").style.display="";   
         document.all("checkName").style.display="inline";
         document.all("ownerType_Type").style.display="none";/** tianyang add for custNameCheck **/
         document.all("print").disabled=true;
         //document.all.custPwd.value="111111";
       //document.all.cfmPwd.value="111111";
         document.getElementById("preBox").style.display="";//wangzn 091201
            document.getElementById("svcLvl").style.display="";//zhangyan 2011-12-13 15:46:32
            document.getElementById("trU00020003").style.display="";//zhangyan 2011-12-13 15:46:32
    }
    else if(ic=="03")
    {
         document.all("tb0").style.display="none";
         document.all("tb1").style.display="none";
         document.all("td2").style.display="";    
         document.all("td3").style.display="none";
         document.all("checkName").style.display="none";
         document.all("ownerType_Type").style.display="none";/** tianyang add for custNameCheck **/
         document.all("print").disabled=true;
           document.getElementById("preBox").style.display="none";//wangzn 091201
      document.getElementById("svcLvl").style.display="none";//zhangyan 2011-12-13 15:46:32 
      document.getElementById("trU00020003").style.display="none";//zhangyan 2011-12-13 15:46:32  
    }
    else if(ic=="04")
    {
       document.all("tb0").style.display="none";
       document.all("tb1").style.display="none";
         document.all("td2").style.display="none";
         document.all("td3").style.display="";   
         document.all("checkName").style.display="inline";
         document.all("ownerType_Type").style.display="none";/** tianyang add for custNameCheck **/
         document.all("print").disabled=true;
         document.getElementById("preBox").style.display="";//wangzn 091201
         //document.all.custPwd.value="111111";
       //document.all.cfmPwd.value="111111";
    document.getElementById("svcLvl").style.display="";//zhangyan 2011-12-13 15:46:32 
    document.getElementById("trU00020003").style.display="";//zhangyan 2011-12-13 15:46:32  
    }
    
  //dujl add at 20100421 for 身份证校验
  if(document.all.ownerType.value != "01")
  {
    //document.all.iccIdCheck.disabled = true;
  }
  else
  {
    //document.all.iccIdCheck.disabled = false;
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

function change_idType(chgFlag)//二代证
{   
     var Str = document.all.idType.value;
	  /* begin diling update for 关于增加开户界面客户登记信息验证功能的函@2013/9/22 */
   
      checkCustNameFunc16New(document.all.custName,0,1); //校验客户名称是否符合
      if(Str.indexOf("军官证") > -1){
  	    $("#idAddrDiv").text("证件地址(部别)");
  	  }else{
  	    $("#idAddrDiv").text("证件地址");
  	  }
    
	  /* end diling update@2013/9/22 */
    if(document.all.idType.value=="0|身份证"||document.all.idType.value=="D|军人身份证")
    {
      document.all.pa_flag.value="1"; 
	    document.all("card_id_type").style.display="";
	    $("#iccidShowFlag").show();
	    
	    /* begin add 如 1100+普通开户+身份证+社会渠道工号+开关+开展地市，则显示“下发工单”按钮 for 关于电话用户实名登记近期重点工作的通知 @2014/11/4 */
			var checkVal = document.all.isJSX.value;//个人开户分类 普通客户：0
			if(checkVal == "0" && "<%=workChnFlag%>" == "1" && "<%=opCode%>" == "1100" && (parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y"){
				$("#sendProjectList").show();
				$("#sendProjectPhones").show();
				$("#sendProjectPhonesbiaozhi").show();
				$("#qryListResultBut").show();
			}else{
				$("#sendProjectList").hide();
				$("#sendProjectPhones").hide();
				$("#sendProjectPhonesbiaozhi").hide();
				$("#qryListResultBut").hide();
			}
			/* end add for 关于电话用户实名登记近期重点工作的通知 @2014/11/4 */
			
			/* begin update for 关于开发智能终端CRM模式APP的函 - 第二批@2015/3/10 */
			if("<%=workChnFlag%>" != "1"){ //自有营业厅
				$("#idIccid").attr("class","InputGrey");
				$("#idIccid").attr("readonly","readonly");
				$("#custName").attr("class","InputGrey");
				$("#custName").attr("readonly","readonly");
				$("#idAddr").attr("class","InputGrey");
				$("#idAddr").attr("readonly","readonly");
				$("#idValidDate").attr("class","InputGrey");
				$("#idValidDate").attr("readonly","readonly");
				if(chgFlag == "1"){
					$("#idIccid").val("");
					$("#custName").val("");
					$("#idAddr").val("");
					$("#idValidDate").val("");
				}
			}else{ //社会渠道
				if((parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y"){ //集团公司查验开关为“开”+地市开关为“开”时
					$("#idIccid").attr("class","InputGrey");
					$("#idIccid").attr("readonly","readonly");
					$("#custName").attr("class","InputGrey");
					$("#custName").attr("readonly","readonly");
					$("#idAddr").attr("class","InputGrey");
					$("#idAddr").attr("readonly","readonly");
					$("#idValidDate").attr("class","InputGrey");
					$("#idValidDate").attr("readonly","readonly");
					if(chgFlag == "1"){
						$("#idIccid").val("");
						$("#custName").val("");
						$("#idAddr").val("");
						$("#idValidDate").val("");
					}
				}
			}
			/* end update for 关于开发智能终端CRM模式APP的函 - 第二批@2015/3/10 */			
    }
    else{
      $("#iccidShowFlag").hide();
	    document.all.pa_flag.value="0";
	    document.all("card_id_type").style.display="none";
	    $("#sendProjectList").hide();
	    $("#sendProjectPhones").hide();
	    $("#sendProjectPhonesbiaozhi").hide();
			$("#qryListResultBut").hide();
			/* begin update for 关于开发智能终端CRM模式APP的函 - 第二批@2015/3/10 */
			if("<%=workChnFlag%>" != "1"){ //自有营业厅
				$("#idIccid").removeAttr("class");
				$("#idIccid").removeAttr("readonly");
				$("#custName").removeAttr("class");
				$("#custName").removeAttr("readonly");
				$("#idAddr").removeAttr("class");
				$("#idAddr").removeAttr("readonly");
				$("#idValidDate").removeAttr("class");
				$("#idValidDate").removeAttr("readonly");
			}else{ //社会渠道
				if((parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y"){ //集团公司查验开关为“开”+地市开关为“开”时
					$("#idIccid").removeAttr("class");
					$("#idIccid").removeAttr("readonly");
					$("#custName").removeAttr("class");
					$("#custName").removeAttr("readonly");
					$("#idAddr").removeAttr("class");
					$("#idAddr").removeAttr("readonly");
					$("#idValidDate").removeAttr("class");
					$("#idValidDate").removeAttr("readonly");
				}
			}
			/* end update for 关于开发智能终端CRM模式APP的函 - 第二批@2015/3/10 */		
  	}
    var Str = document.frm1100.idType.value;
    if(Str.indexOf("身份证") > -1)
    {   document.frm1100.idIccid.v_type = "idcard";   }
    else
    {   document.frm1100.idIccid.v_type = "string";   }
    /*document.all.print.disabled=true;*/
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
	/* begin add 如 没有进行“工单结果查询”,则不能进行提交 for 关于电话用户实名登记近期重点工作的通知 @2014/11/4 */
	if("<%=opCode%>" == "1100"){
  	var checkVal = document.all.isJSX.value;//个人开户分类 普通客户：0
		var idTypeSelect = $("#idTypeSelect option[@selected]").val();//证件类型：身份证
		if(idTypeSelect.indexOf("|") != -1){
			var v_idTypeSelect = idTypeSelect.split("|")[0];
			if(checkVal == "0" && v_idTypeSelect == "0" && "<%=workChnFlag%>" == "1" && "<%=regionCodeFlag%>" == "Y"){ 
				if("<%=appregionflag%>"=="0") {//如果不在app配置表里则只能进行工单查询。
				if(($("#isQryListResultFlag").val() == "N") && (parseInt($("#sendListOpenFlag").val()) > 0)){ //已查询工单列表，并下发工单开关为开，则进行校验
					rdShowMessageDialog("请先进行工单结果查询，再进行开户!");
			    return false;		
					}
				}
			}
		}
  }
	/* end add for 关于电话用户实名登记近期重点工作的通知 @2014/11/4 */

	if(!checkElement(document.all.custId)){
		return false;
	}
	/*2013/11/18 15:09:28 gaopeng 加入提交之前的校验 关于进一步提升省级支撑系统实名登记功能的通知 start*/
	/*重新校验*/
    		/*客户名称*/
    		if(!checkCustNameFunc16New(document.all.custName,0,1)){
    			return false;
    		}
    		/*联系人姓名*/
    		if(!checkCustNameFunc(document.all.contactPerson,1,1)){
					return false;
				}
				/*证件地址*/
				if(!checkAddrFunc(document.all.idAddr,0,1)){
					return false;
				}
				/*客户地址*/
				if(!checkAddrFunc(document.all.custAddr,1,1)){
					return false;
				}
				/*联系人地址*/
				if(!checkAddrFunc(document.all.contactAddr,2,1)){
					return false;
				}
				/*联系人通讯地址*/
				if(!checkAddrFunc(document.all.contactMAddr,3,1)){
					return false;
				}
				/*证件号码*/
				if(!checkIccIdFunc16New(document.all.idIccid,0,1)){
					return false;
				}
				else{
					rpc_chkX('idType','idIccid','A');
				}
				/*gaopeng 20131216 2013/12/16 19:50:11 关于在BOSS入网界面增加单位客户经办人信息的函 加入经办人信息确认服务前校验 start*/
					/*经办人姓名*/
					if(!checkCustNameFunc16New(document.all.gestoresName,1,1)){
						return false;
					}
					/*经办人联系地址*/
					if(!checkAddrFunc(document.all.gestoresAddr,4,1)){
						return false;
					}
					/*经办人证件号码*/
					if(!checkIccIdFunc16New(document.all.gestoresIccId,1,1)){
						return false;
					}
					else{
						rpc_chkX('idType','idIccid','A');
					}
				/*gaopeng 20131216 2013/12/16 19:50:11 关于在BOSS入网界面增加单位客户经办人信息的函 加入经办人信息确认服务前校验 start*/
				
					/*经办人姓名*/
					if(!checkElement(document.all.gestoresName)){
						return false;
					}
					/*经办人联系地址*/
					if(!checkElement(document.all.gestoresAddr)){
						return false;
					}
					/*经办人证件号码*/
					if(!checkElement(document.all.gestoresIccId)){
						return false;
					}
	/*2013/11/18 15:09:28 gaopeng 加入提交之前的校验 关于进一步提升省级支撑系统实名登记功能的通知 end*/
	
		/*责任人姓名*/
	if(!checkElement(document.all.responsibleName)){
		return false;
	}
	/*责任人联系地址*/
	if(!checkElement(document.all.responsibleAddr)){
		return false;
	}
	/*责任人证件号码*/
	if(!checkElement(document.all.responsibleIccId)){
		return false;
	}
	

	if(!checkCustNameFunc16New(document.all.responsibleName,2,1)){
		return false;
	}

	if(!checkAddrFunc(document.all.responsibleAddr,5,1)){
				return false;
	}

	if(!checkIccIdFunc16New(document.all.responsibleIccId,2,1)){
						return false;
	}
	else{
		rpc_chkX('idType','idIccid','A');
	}
	
	
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
        { //并老户必输项判断
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
        change_idType('2');   //判断客户证件类型是否是身份证 
        if((frm1100.contactMail.value).trim() == "")
        {
      frm1100.contactMail.value = "";         
        }
        //判断生日、证件有效期有效性 birthDay  idValidDate
        obj = "tb" + 0;
        obj1 = "tb" + 1;
        if((typeof(frm1100.birthDay)!="undefined")&&
           (frm1100.birthDay.value != "")&&
           (document.all(obj).style.display == ""))
        { 
          if(validDate(frm1100.birthDay) == false)
          { return false;   }
        }
        else if((typeof(frm1100.yzrq)!="undefined")&&
           (frm1100.yzrq.value != "")&&
           (document.all(obj1).style.display == ""))
        { 
          if(validDate(frm1100.yzrq) == false)
          { return false;   }     
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
        //alert(2);      
     if(check(frm1100))
          {
           //alert(1);
              if(document.all.custPwd.value == "" || document.frm1100.cfmPwd.value == ""){
                rdShowMessageDialog("必须输入客户密码！");
                return false;
              } 
            
            
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
      }else{
      if(rdShowConfirmDialog("确认要提交客户开户信息吗？")==1) {
        <% if("1".equals(inputFlag)){ %>
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
        //alert(document.frm1100.custAddr.value);
        //alert(document.frm1100.custAddr.value.replace(new RegExp("#","gm"),"%23"));
        //return false;
        

        var param_s1100Cfm_49 = $("#input_accept").val();
        
        if($("#cust_M_workNO").attr("readyOnly")=="readyOnly"){
        	//输入了客户经理工号，并且校验成功之后才是只读，
        	//服务s1100Cfm最后一个入参下标49位。原来传的是产品部过来的流水，现在需要把原来的参数“流水”和新增入参“客户经理工号”
        	//进行拼串处理   xxxx|xxxxx的格式，最为新下标49的入参格式。注：下标49应只涉及1993页面的调整。原1100功能应该不涉及。
        		param_s1100Cfm_49 = $("#input_accept").val()+"|"+$("#cust_M_workNO").val();
        }
        var xsjbrxx="0";
        if($("#gestoresInfo1").css("display")=="none"){
        	xsjbrxx="0";
        }
        else{
        	xsjbrxx="1";
        }
        frm1100.action="sq100_2.jsp?inputFlag="+document.frm1100.inputFlag.value+"&custId="+document.frm1100.custId.value+"&regionCode="+document.frm1100.regionCode.value+"&districtCode="+document.frm1100.districtCode.value+"&custName="+document.frm1100.custName.value+"&custPwd="+document.frm1100.custPwd.value+"&custStatus="+document.frm1100.custStatus.value+"&custGrade="+document.frm1100.custGrade.value+"&ownerType="+document.frm1100.ownerType.value+"&custAddr="+document.frm1100.custAddr.value.replace(new RegExp("#","gm"),"%23")+"&idType="+document.frm1100.idType.value+"&idIccid="+document.frm1100.idIccid.value+"&idAddr="+document.frm1100.idAddr.value.replace(new RegExp("#","gm"),"%23")+"&idValidDate="+document.frm1100.idValidDate.value+"&contactPerson="+document.frm1100.contactPerson.value+"&contactPhone="+document.frm1100.contactPhone.value+"&contactAddr="+document.frm1100.contactAddr.value.replace(new RegExp("#","gm"),"%23")+"&contactPost="+document.frm1100.contactPost.value+"&contactMAddr="+document.frm1100.contactMAddr.value.replace(new RegExp("#","gm"),"%23")+"&contactFax="+document.frm1100.contactFax.value+"&contactMail="+document.frm1100.contactMail.value+"&unitCode="+document.frm1100.unitCode.value+"&parentId="+document.frm1100.parentId.value+"&custSex="+document.frm1100.custSex.value+"&birthDay="+document.frm1100.birthDay.value+"&professionId="+document.frm1100.professionId.value+"&vudyXl="+document.frm1100.vudyXl.value+"&custAh="+document.frm1100.custAh.value+"&custXg="+document.frm1100.custXg.value+"&unitXz="+document.frm1100.unitXz.value+"&yzlx="+document.frm1100.yzlx.value+"&yzhm="+document.frm1100.yzhm.value+"&yzrq="+document.frm1100.yzrq.value+"&frdm="+document.frm1100.frdm.value+"&groupCharacter=''"+"&workno="+document.frm1100.workno.value+"&sysNote="+document.frm1100.sysNote.value+"&opNote="+document.frm1100.opNote.value+"&opNote="+document.frm1100.opNote.value+"&ip_Addr="+document.frm1100.ip_Addr.value+"&oriGrpNo="+document.frm1100.oriGrpNo.value+"&instigate_flag"+document.frm1100.instigate_flag.value+"&getcontract_flag="+document.frm1100.getcontract_flag.value+"&isceshijt_flag="+document.frm1100.isceshijt_flag.value+"&filep="+document.frm1100.filep.value+"&card_flag="+document.frm1100.card_flag.value+"&m_flag="+document.frm1100.m_flag.value+"&sf_flag="+document.frm1100.sf_flag.value+"&idType="+document.frm1100.idType.value+"&pic_name="+document.all.pic_name.value+"&but_flag="+document.all.but_flag.value+"&isPre="+isPre+"&preUnitId="+document.all.preUnitId.value+"&IccIdAccept="+document.all.IccIdAccept.value
          +"&opCode=<%=opCode%>"
          +"&selU0002="+document.all.selU0002.value
          +"&selU0003="+document.all.selU0003.value
	  			+"&selSvcLvl="+document.all.selSvcLvl.value
          +"&isJSX="+document.all.isJSX.value
          +"&gestoresName="+document.all.gestoresName.value
          +"&gestoresAddr="+document.all.gestoresAddr.value.replace(new RegExp("#","gm"),"%23")
          +"&gestoresIdType="+document.all.gestoresIdType.value
          +"&gestoresIccId="+document.all.gestoresIccId.value
          +"&responsibleName="+document.all.responsibleName.value
          +"&responsibleAddr="+document.all.responsibleAddr.value.replace(new RegExp("#","gm"),"%23")
          +"&responsibleType="+document.all.responsibleType.value
          +"&responsibleIccId="+document.all.responsibleIccId.value          
        	+"&isDirectManageCust="+$("#isDirectManageCust").val()
        	+"&directManageCustNo="+$("#directManageCustNo").val()
        	+"&groupNo="+$("#groupNo").val()+"&input_accept="+param_s1100Cfm_49+"&xsjbrxx="+xsjbrxx;
          if($("#isse276_100").val()=="1"&&"1"=="<%=retforwardflag%>"){
          	$("#isse276",window.parent.document).val("1");
          }
        frm1100.submit();
      }
      
    }
        // dujl at 20100324 for R_HLJMob_liubq_CRM_PD3_2010_0117@关于优化BOSS系统开户及过户功能的需求 封闭
  //          showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
  }else{
      return false;
  }
}


/*2010-8-9 8:43 wanghfa添加 验证密码过于简单 start*/
function checkPwdEasy(pwd) {
  
  if(pwd == ""){
    rdShowMessageDialog("请先输入密码！");
    return ;
  }
  
  var checkPwd_Packet = new AJAXPacket("../public/pubCheckPwdEasy.jsp","正在验证密码是否过于简单，请稍候......");
  checkPwd_Packet.data.add("password", pwd);
  checkPwd_Packet.data.add("phoneNo", "00000000000");
  checkPwd_Packet.data.add("idNo", frm1100.idIccid.value);
  checkPwd_Packet.data.add("opCode", "1100");
  checkPwd_Packet.data.add("custId", "");

  core.ajax.sendPacket(checkPwd_Packet, doCheckPwdEasy);
  checkPwd_Packet=null;
}

function doCheckPwdEasy(packet) {
  var retResult = packet.data.findValueByName("retResult");
  if (retResult == "1") {
    rdShowMessageDialog("尊敬的客户，您本次设置的密码为相同数字类密码，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
    document.all.custPwd.value="";
    document.all.cfmPwd.value="";
    return;
  } else if (retResult == "2") {
    rdShowMessageDialog("尊敬的客户，您本次设置的密码为连号类密码，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
    document.all.custPwd.value="";
    document.all.cfmPwd.value="";
    return;
  } else if (retResult == "3") {
    rdShowMessageDialog("尊敬的客户，您本次设置的密码为手机号码中的连续数字，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
    document.all.custPwd.value="";
    document.all.cfmPwd.value="";
    return;
  } else if (retResult == "4") {
    rdShowMessageDialog("尊敬的客户，您本次设置的密码为证件中的连续数字，安全性较低，为了更好地保护您的信息安全，请您设置安全性更高的密码。");
    document.all.custPwd.value="";
    document.all.cfmPwd.value="";
    return;
  } else if (retResult == "0") {
   
  } 
}


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
     
     obj.select();
     obj.focus();
     return false;
   }
     if(myParseInt(month)<1 || myParseInt(month)>12)
   {
       rdShowMessageDialog("月的格式有误，有效月份应介于01-12之间，请重新输入！");
       
     obj.select();
     obj.focus();
     return false;
   }
     if(myParseInt(day)<1 || myParseInt(day)>31)
   {
       rdShowMessageDialog("日的格式有误，有效日期应介于01-31之间，请重新输入！");
    
     obj.select();
       obj.focus();
     return false;
   }

     if (month == "04" || month == "06" || month == "09" || month == "11")             
   {
         if(myParseInt(day)>30)
         {
         rdShowMessageDialog("该月份最多30天,没有31号！");
         
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
    { 
      
        var getAcceptFlag = "<%=getAcceptFlag%>";
        if(getAcceptFlag == "failed")
        { return "failed";  }
      /*retInfo = retInfo + "10|2|0|0|打印流水:  " + "<%=printAccept%>" + "|"; */
    
   
    /*retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(Calendar.getInstance().getTime())%>'+"|"; */
    
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

    
    note_info2+=document.all.assu_name.value+"|";
    note_info2+=document.all.assu_phone.value+"|";
    note_info2+=document.all.assu_idAddr.value+"|";
    note_info2+=document.all.assu_idIccid.value+"|";
    
   
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  }
    
    if(printType == "Bill")
    {
     
  }
  return retInfo; 
}


function showPrtDlg(printType,DlgMessage,submitCfm)
{  
   var h=185;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var printStr = printInfo(printType);
   if(printStr == "failed")
   {  return false; }
   
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
  
  var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
  var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
  var ret=window.showModalDialog(path,printStr,prop);

   
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
        
        frm1100.action="sq100_2.jsp?inputFlag="+document.frm1100.inputFlag.value+"&custId="+document.frm1100.custId.value+"&regionCode="+document.frm1100.regionCode.value+"&districtCode="+document.frm1100.districtCode.value+"&custName="+document.frm1100.custName.value+"&custPwd="+document.frm1100.custPwd.value+"&custStatus="+document.frm1100.custStatus.value+"&custGrade="+document.frm1100.custGrade.value+"&ownerType="+document.frm1100.ownerType.value+"&custAddr="+document.frm1100.custAddr.value+"&idType="+document.frm1100.idType.value+"&idIccid="+document.frm1100.idIccid.value+"&idAddr="+document.frm1100.idAddr.value+"&idValidDate="+document.frm1100.idValidDate.value+"&contactPerson="+document.frm1100.contactPerson.value+"&contactPhone="+document.frm1100.contactPhone.value+"&contactAddr="+document.frm1100.contactAddr.value+"&contactPost="+document.frm1100.contactPost.value+"&contactMAddr="+document.frm1100.contactMAddr.value+"&contactFax="+document.frm1100.contactFax.value+"&contactMail="+document.frm1100.contactMail.value+"&unitCode="+document.frm1100.unitCode.value+"&parentId="+document.frm1100.parentId.value+"&custSex="+document.frm1100.custSex.value+"&birthDay="+document.frm1100.birthDay.value+"&professionId="+document.frm1100.professionId.value+"&vudyXl="+document.frm1100.vudyXl.value+"&custAh="+document.frm1100.custAh.value+"&custXg="+document.frm1100.custXg.value+"&unitXz="+document.frm1100.unitXz.value+"&yzlx="+document.frm1100.yzlx.value+"&yzhm="+document.frm1100.yzhm.value+"&yzrq="+document.frm1100.yzrq.value+"&frdm="+document.frm1100.frdm.value+"&groupCharacter=''"+"&workno="+document.frm1100.workno.value+"&sysNote="+document.frm1100.sysNote.value+"&opNote="+document.frm1100.opNote.value+"&opNote="+document.frm1100.opNote.value+"&ip_Addr="+document.frm1100.ip_Addr.value+"&oriGrpNo="+document.frm1100.oriGrpNo.value+"&instigate_flag"+document.frm1100.instigate_flag.value+"&getcontract_flag="+document.frm1100.getcontract_flag.value+"&isceshijt_flag="+document.frm1100.isceshijt_flag.value+"&filep="+document.frm1100.filep.value+"&card_flag="+document.frm1100.card_flag.value+"&m_flag="+document.frm1100.m_flag.value+"&sf_flag="+document.frm1100.sf_flag.value+"&idType="+document.frm1100.idType.value+"&pic_name="+document.all.pic_name.value+"&but_flag="+document.all.but_flag.value+"&isPre="+isPre+"&preUnitId="+document.all.preUnitId.value
          +"&opCode=<%=opCode%>"
          +"&selU0002="+document.all.selU0002.value
          +"&selU0003="+document.all.selU0003.value
          +"&selSvcLvl="+document.all.selSvcLvl.value
          +"&isJSX="+document.all.isJSX.value
          +"&gestoresName="+document.all.gestoresName.value
          +"&gestoresAddr="+document.all.gestoresAddr.value
          +"&gestoresIdType="+document.all.gestoresIdType.value
          +"&gestoresIccId="+document.all.gestoresIccId.value;
          +"&responsibleName="+document.all.responsibleName.value
          +"&responsibleAddr="+document.all.responsibleAddr.value.replace(new RegExp("#","gm"),"%23")
          +"&responsibleType="+document.all.responsibleType.value
          +"&responsibleIccId="+document.all.responsibleIccId.value                
         frm1100.submit();
      }
     }
   
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

function getId()
{
    /*得到客户ID*/
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
function getInfo_IccId_JustSee()
{ 
    var Str = document.all.idType.value;
   
      if(Str.indexOf("身份证") > -1){
        if($("#idIccid").val().length<18){
          rdShowMessageDialog("身份证号码必须是18位！");
          document.all.idIccid.focus();
          return false;
        }
      }
    
 
    /*根据客户证件号码得到相关信息*/
    if(document.frm1100.idIccid.value.trim().len() == 0)
    {
        rdShowMessageDialog("请输入客户证件号码！");
        return false;
    }
  /*liujian 2013-5-15 9:24:11 修改新建客户和过户界面,身份证号码只能输入18位的证件号码,如果输入15位的,请报错*/
  var item = $("#idTypeSelect option[@selected]").text();
  if(item == '身份证' && document.frm1100.idIccid.value.trim().len() != 18) {
        rdShowMessageDialog("身份证证件号码长度必须是18位！");
        return false;
  }
  
    var pageTitle = "客户信息查询";
    var fieldName = "服务号码|开户时间|证件类型|证件号码|归属地|状态|";
    /**
    var sqlStr = "select c.phone_no,
    to_char(a.CREATE_TIME,'YYYY-MM-DD HH24:MI:SS'),
    b.ID_NAME,
    a.ID_ICCID," +
    " trim(e.REGION_NAME)||'-->'||trim(f.DISTRICT_NAME)," + 
    " d.run_name
                      from DCUSTDOC a,SIDTYPE b ,DCustMsg c ,sRuncode d ,sregioncode e,sdiscode f where a.region_code=d.region_code and substr(c.run_code,2,1)=d.run_code and  a.cust_id=c.cust_id and b.ID_TYPE = a.ID_TYPE " +
                     " and a.region_code=e.region_code and a.region_code=f.region_code and
                      a.district_code=f.district_code and  a.ID_ICCID = '" + 
                      document.frm1100.idIccid.value + "' and substr(c.run_code,2,1)<'a'
                        and rownum<500 order by a.cust_name asc,a.create_time desc "; 
    */
    var selType = "S";    /*'S'单选；'M'多选*/
    var retQuence = "7|0|1|3|4|5|6|7|";
    var retToField = "in0|in4|in3|in2|in5|in6|in1|";
    
    custInfoQueryJustSee(document.frm1100.idIccid.value);                    
}
function custInfoQueryJustSee(idIccid)
{
	if("<%=opCode%>" == "1100"){
		
		var custnamess=document.frm1100.custName.value.trim();
		var idTypesss="";
		var idTypeSelect = $("#idTypeSelect option[@selected]").val();//证件类型
		if(idTypeSelect.indexOf("|") != -1){
			  idTypesss = idTypeSelect.split("|")[0];
			  if(idTypesss=="0") {//身份证
				    if(custnamess.len() == 0)
				    {
				        //rdShowMessageDialog("请输入客户名称后再进行信息查询！");
				        //return false;
				    }
			   }   
    }

    var path = "getPhoneNumInner.jsp";
    path = path + "?idIccid=" + idIccid.trim()+"&idtype="+idTypesss+"&custnames="+custnamess+"&opcode=1100";
    window.showModalDialog(path,"","dialogWidth:30;dialogHeight:15;");
   }else {
    var path = "getCustInfo.jsp";
    path = path + "?idIccid=" + idIccid;
    window.showModalDialog(path,"","dialogWidth:60;dialogHeight:35;");   
   }
}

function choiceSelWay()
{ 
  if(frm1100.parentIdidIccid.value != "")
  { /*客户证件号码*/
    getInfo_IccId();
    return true;
  }
  if(frm1100.parentName.value != "")
  { /*客户名称*/
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
    var getIdPacket = new AJAXPacket("f1100_rpc.jsp","正在获得上级客户信息，请稍候......");
        var parentId = document.frm1100.parentId.value;
        getIdPacket.data.add("retType","getInfo_withID");
        getIdPacket.data.add("fieldNum","6");
        getIdPacket.data.add("sqlStr","");
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
    /*var path = "../../page/public/fPubSimpSel.jsp";  密码显示*/
    var path = "pubGetCustInfo.jsp";   //密码为*
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    /*
    var ret = window.open (path, "银行代码", 
          "height=400, width=600,left=200, top=200,toolbar=no,menubar=no, scrollbars=yes, resizable=no, location=no, status=yes"); 
  ret.opener.bankCode.value = "1111111111";
  */
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
        /*根据客户名称得到相关信息*/
    if(document.frm1100.parentName.value == "")
    {
        rdShowMessageDialog("请输入客户名称！",0);
        return false;
    }
    var pageTitle = "客户信息查询";
    var fieldName = "客户ID|客户名称|开户时间|证件类型|证件号码|客户地址|归属代码|客户密码|";
    var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "7|0|1|3|4|5|6|7|";
    var retToField = "in0|in4|in3|in2|in5|in6|in1|"; 
    custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)                           
    
    rpc_chkX("parentIdType","parentIdidIccid","B");
}


function getInfo_IccId()
{ 
    /*根据客户证件号码得到相关信息*/
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
    var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "7|0|1|3|4|5|6|7|";
    var retToField = "in0|in4|in3|in2|in5|in6|in1|";
     custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);                    
     
}

function get_inPara()
{
    /*组织传人的参数*/
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
    /*页面控件初始化 */   
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
         /*页面提交*/
         document.frm1100.commit.disabled = "none";
         action="sq100_2.jsp?opCode=<%=opCode%>"
         frm1100.submit();   /*将参数串的输入框提交*/
}

function change_ConPerson()
{   
  /*联系人姓名随客户名称改名而改变*/
  if(document.all.ownerType.value=="02"){
    frm1100.contactPerson.value = frm1100.custName.value;
    /*document.all.print.disabled=true;*/
  }
}
function change_ConAddr(obj)
{   /*联系人姓名随客户名称改名而改变*/
	
  
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
  var Str = document.all.idType.value;
  
    if((Str.indexOf("身份证") > -1)||(Str.indexOf("户口簿") > -1)){
      if(obj.value.length<8){
        rdShowMessageDialog("要求8个及以上汉字！请重新输入！");
        obj.focus();
  			return false;
      }
    }
  
  if(document.all.ownerType.value=="01"){
    document.all.custAddr.value=obj.value;
    document.all.contactAddr.value=obj.value;
    document.all.contactMAddr.value=obj.value;
  }
}

function chcek_pic()/*二代证*/
{
  
var pic_path = document.all.filep.value;
  
var d_num = pic_path.indexOf("\.");
var file_type = pic_path.substring(d_num+1,pic_path.length);
/*判断是否为jpg类型 //厂家设备生成图片固定为jpg类型*/
if(file_type.toUpperCase()!="JPG")
{ 
    rdShowMessageDialog("请选择jpg类型图像文件");
    document.all.up_flag.value=3;
    /*document.all.print.disabled=true;*/
    resetfilp();
  return ;
  }

  var pic_path_flag= document.all.pic_name.value;
  
  if(pic_path_flag=="")
  {
  rdShowMessageDialog("请先扫描或读取证件信息");
  document.all.up_flag.value=4;
  /*document.all.print.disabled=true;*/
  resetfilp();
  return;
}
  else
    {
      if(pic_path!=pic_path_flag)
      {
      rdShowMessageDialog("请选择最后一次扫描或读取证件而生成的证件图像文件"+pic_path_flag);
      document.all.up_flag.value=5;
      /*document.all.print.disabled=true;*/
      resetfilp();
    return;
    }
    else{
      document.all.up_flag.value=2;
      }
      }
      
  }
  
/*** dujl add at 20090806 for R_HLJMob_cuisr_CRM_PD3_2009_0314@关于规范客户开户过程中基本资料中非法字符校验的需求 ****/


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
        rdShowMessageDialog("只允许输入中文！");
        reSetCustName();
      }
      if(textName.value.length > 6){
        rdShowMessageDialog("只允许输入6个汉字！");
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
function forKuoHao(obj){ //允许输入括号·.． 这几种副号
	var m = /^(\(?\)?\（?\）?)\·|\.|\．+$/;
  	var flag = m.test(obj);
  	if(!flag){
  		return false;
  	}else{
  		return true;
  	}
}
function forEnKuoHao(obj){
	var m = /^(\(?\)?)+$/;
  	var flag = m.test(obj);
  	if(!flag){
  		return false;
  	}else{
  		return true;
  	}
}
function forHanZi1(obj)
  {
  	var m = /^[\u0391-\uFFE5]+$/;
  	var flag = m.test(obj);
  	if(!flag){
  		//showTip(obj,"必须输入汉字！");
  		return false;
  	}
  		if (!isLengthOf(obj,obj.v_minlength*2,obj.v_maxlength*2)){
  		//showTip(obj,"长度有错误！");
  		return false;
  	}
  	return true;
  }
  
  //匹配由26个英文字母组成的字符串
  function forA2sssz1(obj)
  {
  	var patrn = /^[A-Za-z]+$/;
  	var sInput = obj;
  	if(sInput.search(patrn)==-1){
  		//showTip(obj,"必须为字母！");
  		return false;
  	}
  	if (!isLengthOf(obj,obj.v_minlength,obj.v_maxlength)){
  		//showTip(obj,"长度有错误！");
  		return false;
  	}
  
  	return true;
  }
  
/*
	2013/11/15 15:33:56 gaopeng 关于进一步提升省级支撑系统实名登记功能的通知  
	注意：只针对个人客户 start
*/  

/*1、客户名称、联系人姓名 校验方法 objType 0 代表客户名称校验 1代表联系人姓名校验  ifConnect 代表是否联动赋值(点击确认按钮时，不进行联动赋值)*/
function checkCustNameFunc(obj,objType,ifConnect){
	var nextFlag = true;
	var objName = "";
	var idTypeVal = "";
	if(objType == 0){
		objName = "客户名称";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 1){
		objName = "联系人姓名";
		idTypeVal = document.all.idType.value;
	}
	/*2013/12/16 11:24:47 gaopeng 关于在BOSS入网界面增加单位客户经办人信息的函 加入经办人姓名*/
	if(objType == 2){
		objName = "经办人姓名";
		/*规则按照经办人证件类型*/
		idTypeVal = document.all.gestoresIdType.value;
	}
	
	if(objType == 3){
		objName = "责任人姓名";
		/*规则按照经办人证件类型*/
		idTypeVal = document.all.responsibleType.value;
	}	
	
	idTypeVal = $.trim(idTypeVal);
	
	/*只针对个人客户*/
	var opCode = "<%=opCode%>";
	/*获取输入框的值*/
	var objValue = obj.value;
	objValue = $.trim(objValue);
	/*获取输入的值的长度*/
	var objValueLength = objValue.length;
	if(objValue != ""){
		/* 获取所选择的证件类型 
		0|身份证 1|军官证 2|户口簿 3|港澳通行证 
		4|警官证 5|台湾通行证 6|外国公民护照 7|其它 
		8|营业执照 9|护照 A|组织机构代码 B|单位法人证书 C|介绍信 
		*/
		/*获取证件类型主键 */
		var idTypeText = idTypeVal.split("|")[0];
		
		/*有临时、代办字样的都不行*/
		if(objValue.indexOf("临时") != -1 || objValue.indexOf("代办") != -1){
					rdShowMessageDialog(objName+"不能带有‘临时’或‘代办’字样！");
					
					nextFlag = false;
					return false;
			
		}
		
		/*客户名称、联系人姓名均要求“大于等于2个中文汉字”，外国公民护照除外（外国公民护照客户名称必须大于3个字符，不全为阿拉伯数字)*/
		
		/*如果不是外国公民护照*/
		if(idTypeText != "6"){
			/*原有的业务逻辑校验 只允许是英文、汉字、俄文、法文、日文、韩文其中一种语言！*/
			
			/*2014/08/27 16:14:22 gaopeng 哈分公司申请优化开户名称限制的请示 要求单位客户时，客户名称可以填写英文大小写组合 目前先搞成跟 idTypeText == "3" || idTypeText == "9" 一样的逻辑 后续问问可不可以*/
			if(idTypeText == "3" || idTypeText == "9" || idTypeText == "8" || idTypeText == "A" || idTypeText == "B" || idTypeText == "C"){
				if(objValueLength < 2){
					rdShowMessageDialog(objName+"必须大于等于2个汉字！");
					nextFlag = false;
					return false;
				}
				 var KH_length = 0;
		     var EH_length = 0;
		     var RU_length = 0;
		     var FH_length = 0;
		     var JP_length = 0;
		     var KR_length = 0;
		     var CH_length = 0;
         
         for (var i = 0; i < objValue.length; i ++){
            var code = objValue.charAt(i);//分别获取输入内容
            var key = checkNameStr(code); //校验
            if(key == undefined){
              rdShowMessageDialog("只允许是英文、汉字、俄文、法文、日文、韩文或其与‘括号’组合其中一种语言！请重新输入！");
              obj.value = "";
              
              nextFlag = false;
              return false;
            }
            if(key == "KH"){
            	KH_length++;
            }
            if(key == "EH"){
            	EH_length++;
            }
            if(key == "RU"){
            	RU_length++;
            }
            if(key == "FH"){
            	FH_length++;
            }
            if(key == "JP"){
            	JP_length++;
            }
            if(key == "KR"){
            	KR_length++;
            }
            if(key == "CH"){
            	CH_length++;
            }
         
         }	
            var machEH = KH_length + EH_length;
            var machRU = KH_length + RU_length;
            var machFH = KH_length + FH_length;
            var machJP = KH_length + JP_length;
            var machKR = KH_length + KR_length;
            var machCH = KH_length + CH_length;
            
            
            if((objValueLength != machEH 
            && objValueLength != machRU
            && objValueLength != machFH
            && objValueLength != machJP
            && objValueLength != machKR
            && objValueLength != machCH ) || objValueLength == KH_length){
            		rdShowMessageDialog("只允许是英文、汉字、俄文、法文、日文、韩文或其与‘括号’组合其中一种语言！请重新输入！");
                obj.value = "";
              	nextFlag = false;
                return false;
            }
       }
       else{
					
					/*获取含有中文汉字的个数以及'()（）'的个数*/
					var m = /^[\u0391-\uFFE5]*$/;
					var mm = /^·|\.|\．*$/;
					var chinaLength = 0;
					var kuohaoLength = 0;
					var zhongjiandianLength=0;
					for (var i = 0; i < objValue.length; i ++){
								
			          var code = objValue.charAt(i);//分别获取输入内容
			          var flag22=mm.test(code);
			          var flag = m.test(code);
			          /*先校验括号*/
			          if(forKuoHao(code)){
			          	kuohaoLength ++;
			          }else if(flag){
			          	chinaLength ++;
			          }else if(flag22){
			          	zhongjiandianLength++;
			          }
			          
			    }
			    var machLength = chinaLength + kuohaoLength+zhongjiandianLength;
					/*括号的数量+汉字的数量 != 总数量时 提示错误信息(这里需要注意一点，中文括号也是中文。。。所以这里只进行英文括号的匹配个数，否则会匹配多个)*/
					if(objValueLength != machLength || chinaLength == 0){
						rdShowMessageDialog(objName+"必须输入中文或中文与括号的组合(括号可以为中文或英文括号“()（）”)！");
						/*赋值为空*/
						obj.value = "";
						
						nextFlag = false;
						return false;
					}else if(objValueLength == machLength && chinaLength != 0){
						if(objValueLength < 2){
							rdShowMessageDialog(objName+"必须大于等于2个中文汉字！");
							
							nextFlag = false;
							return false;
						}
					}
					/*原有逻辑
					if(idTypeText == "0" || idTypeText == "2"){
						if(objValueLength > 6){
							rdShowMessageDialog(objName+"最多输入6个汉字！");
							
							nextFlag = false;
							return false;
						}
				}
				*/
			}
       
		}
		/*如果是外国公民护照 校验 外国公民护照客户名称(后续添加了联系人姓名也同理(sunaj已确定))必须大于3个字符，不全为阿拉伯数字*/
		if(idTypeText == "6"){
			/*如果校验客户名称*/
				if(objValue % 2 == 0 || objValue % 2 == 1){
						rdShowMessageDialog(objName+"不能全为阿拉伯数字!");
						/*赋值为空*/
						obj.value = "";
						
						nextFlag = false;
						return false;
				}
				if(objValueLength <= 3){
						rdShowMessageDialog(objName+"必须大于三个字符!");
						
						nextFlag = false;
						return false;
				}
				var KH_length = 0;
		     var EH_length = 0;
		     var RU_length = 0;
		     var FH_length = 0;
		     var JP_length = 0;
		     var KR_length = 0;
		     var CH_length = 0;
         
         for (var i = 0; i < objValue.length; i ++){
            var code = objValue.charAt(i);//分别获取输入内容
            var key = checkNameStr(code); //校验
            if(key == undefined){
              rdShowMessageDialog("只允许是英文、汉字、俄文、法文、日文、韩文或其与‘括号’组合其中一种语言！请重新输入！");
              obj.value = "";
              
              nextFlag = false;
              return false;
            }
            if(key == "KH"){
            	KH_length++;
            }
            if(key == "EH"){
            	EH_length++;
            }
            if(key == "RU"){
            	RU_length++;
            }
            if(key == "FH"){
            	FH_length++;
            }
            if(key == "JP"){
            	JP_length++;
            }
            if(key == "KR"){
            	KR_length++;
            }
            if(key == "CH"){
            	CH_length++;
            }
         
         }	
            var machEH = KH_length + EH_length;
            var machRU = KH_length + RU_length;
            var machFH = KH_length + FH_length;
            var machJP = KH_length + JP_length;
            var machKR = KH_length + KR_length;
            var machCH = KH_length + CH_length;
            
            
            if((objValueLength != machEH 
            && objValueLength != machRU
            && objValueLength != machFH
            && objValueLength != machJP
            && objValueLength != machKR
            && objValueLength != machCH ) || objValueLength == KH_length){
            		rdShowMessageDialog("只允许是英文、汉字、俄文、法文、日文、韩文或其与‘括号’组合其中一种语言！请重新输入！");
                obj.value = "";
              	nextFlag = false;
                return false;
            }
				
		}
		
		
		if(ifConnect == 0){
		if(nextFlag){
		 if(objType == 0){
		 	/*联系人姓名随客户名称改名而改变*/
			  if(document.all.ownerType.value=="02"){
			    document.frm1100.contactPerson.value = frm1100.custName.value;
			    /*document.all.print.disabled=true;*/
			  }
		 	}	
		}
		}
		
	}	
	return nextFlag;
}


/*
	2013/11/18 11:15:44
	gaopeng
	客户地址、证件地址、联系人地址校验方法
	“客户地址”、“证件地址”和“联系人地址”均需“大于等于8个中文汉字”
	（外国公民护照和台湾通行证除外，外国公民护照要求大于2个汉字，台湾通行证要求大于3个汉字）
*/

function checkAddrFunc(obj,objType,ifConnect){
	var nextFlag = true;
	var objName = "";
	var idTypeVal = ""
	if(objType == 0){
		objName = "证件地址";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 1){
		objName = "客户地址";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 2){
		objName = "联系人地址";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 3){
		objName = "联系人通讯地址";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 4){
		objName = "经办人联系地址";
		idTypeVal = document.all.gestoresIdType.value;
	}
	if(objType == 5){
		objName = "责任人联系地址";
		idTypeVal = document.all.responsibleType.value;
	}	
	idTypeVal = $.trim(idTypeVal);
	/*只针对个人客户*/
	var opCode = "<%=opCode%>";
	/*获取输入框的值*/
	var objValue = obj.value;
	objValue = $.trim(objValue);
	/*获取输入的值的长度*/
	var objValueLength = objValue.length;
	
	if(objValue != ""){
		/* 获取所选择的证件类型 
		0|身份证 1|军官证 2|户口簿 3|港澳通行证 
		4|警官证 5|台湾通行证 6|外国公民护照 7|其它 
		8|营业执照 9|护照 A|组织机构代码 B|单位法人证书 C|介绍信 
		*/
		
		/*获取证件类型主键 */
		var idTypeText = idTypeVal.split("|")[0];
		
		/*获取含有中文汉字的个数*/
		var m = /^[\u0391-\uFFE5]*$/;
		var chinaLength = 0;
		for (var i = 0; i < objValue.length; i ++){
          var code = objValue.charAt(i);//分别获取输入内容
          var flag = m.test(code);
          if(flag){
          	chinaLength ++;
          }
    }
      
		/*如果既不是外国公民护照 也不是台湾通行证 */
		if(idTypeText != "6" && idTypeText != "5"){
			/*含有至少8个中文汉字*/
			if(chinaLength < 8){
				rdShowMessageDialog(objName+"必须含有至少8个中文汉字！");
				/*赋值为空*/
				obj.value = "";
				
				nextFlag = false;
				return false;
			}
		
	}
	/*外国公民护照 大于2个汉字*/
	if(idTypeText == "6"){
		/*大于2个中文汉字*/
			if(chinaLength <= 2){
				rdShowMessageDialog(objName+"必须含有大于2个中文汉字！");
				
				nextFlag = false;
				return false;
			}
	}
	/*台湾通行证 大于3个汉字*/
	if(idTypeText == "5"){
		/*含有至少3个文汉字*/
			if(chinaLength <= 3){
				rdShowMessageDialog(objName+"必须含有大于3个中文汉字！");
				
				nextFlag = false;
				return false;
			}
	}
	/*联动赋值 ifConnect 传0时才赋值，否则不赋值*/
	if(ifConnect == 0){
		if(nextFlag){
			/*证件地址改变时，赋值其他地址*/
			if(objType == 0){
				if(document.all.ownerType.value=="01"){
					
			    document.all.custAddr.value=objValue;
			    document.all.contactAddr.value=objValue;
			    document.all.contactMAddr.value=objValue;
			  }
			}
			/*客户地址改变时，赋值联系人地址和联系人通讯地址*/
			if(objType == 1){
				frm1100.contactAddr.value = objValue;
	  		frm1100.contactMAddr.value = objValue;
			}
			/*联系人地址改变时，赋值联系人通讯地址，2013/12/16 15:20:17 20131216 gaopeng 赋值经办人联系地址联动*/
			if(objType == 2){
				document.all.contactMAddr.value=objValue;
				document.all.gestoresAddr.value=objValue;
				document.all.responsibleAddr.value=objValue;
			}
		}
	}
	
	
}
return nextFlag;
}

/*
	2013/11/18 14:01:09
	gaopeng
	证件类型变更时，证件号码的校验方法
*/

function checkIccIdFunc(obj,objType,ifConnect){
	
	var nextFlag = true;
	var idTypeVal = "";
	if(objType == 0){
		var objName = "证件号码";
		idTypeVal = document.all.idType.value;
	}
	if(objType == 1){
		objName = "经办人证件号码";
		idTypeVal = document.all.gestoresIdType.value;
	}
	if(objType == 2){
		objName = "责任人证件号码";
		idTypeVal = document.all.responsibleType.value;
	}	
	
	/*只针对个人客户*/
	var opCode = "<%=opCode%>";
	/*获取输入框的值*/
	var objValue = obj.value;
	objValue = $.trim(objValue);
	/*获取输入的值的长度*/
	var objValueLength = objValue.length;
	
	if(objValue != ""){
		/* 获取所选择的证件类型 
		0|身份证 1|军官证 2|户口簿 3|港澳通行证 
		4|警官证 5|台湾通行证 6|外国公民护照 7|其它 
		8|营业执照 9|护照 A|组织机构代码 B|单位法人证书 C|介绍信 
		*/
		
		/*获取证件类型主键 */
		var idTypeText = idTypeVal.split("|")[0];
		
		/*1、身份证及户口薄时，证件号码长度为18位*/
		if(idTypeText == "0" || idTypeText == "2"){
			if(objValueLength != 18){
					rdShowMessageDialog(objName+"必须是18位！");
					
					nextFlag = false;
					return false;
			}
		}
		/*军官证 警官证 外国公民护照时 证件号码大于等于6位字符*/
		if(idTypeText == "1" || idTypeText == "4" || idTypeText == "6"){
			if(objValueLength < 6){
					rdShowMessageDialog(objName+"必须大于等于六位字符！");
					
					nextFlag = false;
					return false;
			}
		}
		/*证件类型为港澳通行证的，证件号码为9位或11位，并且首位为英文字母“H”或“M”(只可以是大写)，其余位均为阿拉伯数字。*/
		if(idTypeText == "3"){
			if(objValueLength != 9 && objValueLength != 11){
					rdShowMessageDialog(objName+"必须是9位或11位！");
					
					nextFlag = false;
					return false;
			}
			/*获取首字母*/
			var valHead = objValue.substring(0,1);
			if(valHead != "H" && valHead != "M"){
					rdShowMessageDialog(objName+"首字母必须是‘H’或‘M’！");
					
					nextFlag = false;
					return false;
			}
			/*获取首字母之后的所有信息*/
			var varWithOutHead = objValue.substring(1,objValue.length);
			if(varWithOutHead % 2 != 0 && varWithOutHead % 2 != 1){
					rdShowMessageDialog(objName+"除首字母之外，其余位必须是阿拉伯数字！");
					
					nextFlag = false;
					return false;
			}
		}
		
		/*证件类型为
			台湾通行证 
			证件号码只能是8位或11位
			证件号码为11位时前10位为阿拉伯数字，
			最后一位为校验码(英文字母或阿拉伯数字）；
			证件号码为8位时，均为阿拉伯数字
		*/
		if(idTypeText == "5"){
			if(objValueLength != 8 && objValueLength != 11){
					rdShowMessageDialog(objName+"必须为8位或11位！");
					
					nextFlag = false;
					return false;
			}
			/*8位时，均为阿拉伯数字*/
			if(objValueLength == 8){
				if(objValue % 2 != 0 && objValue % 2 != 1){
					rdShowMessageDialog(objName+"必须为阿拉伯数字");
					
					nextFlag = false;
					return false;
				}
			}
			/*11位时，最后一位可以是英文字母或阿拉伯数字，前10位必须是阿拉伯数字*/
			if(objValueLength == 11){
				var objValue10 = objValue.substring(0,10);
				if(objValue10 % 2 != 0 && objValue10 % 2 != 1){
					rdShowMessageDialog(objName+"前十位必须为阿拉伯数字");
					
					nextFlag = false;
					return false;
				}
				var objValue11 = objValue.substring(10,11);
  			var m = /^[A-Za-z]+$/;
				var flag = m.test(objValue11);
				
				if(!flag && objValue11 % 2 != 0 && objValue11 % 2 != 1){
					rdShowMessageDialog(objName+"第11位必须为阿拉伯数字或英文字母！");
					
					nextFlag = false;
					return false;
				}
			}
			
		}
		/*组织机构代 证件号码大于等于9位，为数字、“-”或大写拉丁字母*/
		if(idTypeText == "A"){
		 if(objValueLength != 10){
					rdShowMessageDialog(objName+"必须是10位！");				
					nextFlag = false;
					return false;
			}
			if(objValue.substr(objValueLength-2,1)!="-" && objValue.substr(objValueLength-2,1)!="－") {
					rdShowMessageDialog(objName+"倒数第二位必须是“-”！");				
					nextFlag = false;
					return false;			
			}
		}
		/*营业执照 证件号码号码大于等于4位数字，出现其他如汉字等字符也合规*/
		if(idTypeText == "8"){
		
		 if(objValueLength != 13 && objValueLength != 15 && objValueLength != 18 && objValueLength != 20){
					rdShowMessageDialog(objName+"必须是13位或15位或18位或20位！");				
					nextFlag = false;
					return false;
			}
				    
			var m = /^[\u0391-\uFFE5]*$/;
			var numSum = 0;
			for (var i = 0; i < objValue.length; i ++){
          var code = objValue.charAt(i);//分别获取输入内容
          var flag = m.test(code);
          if(flag){
          	numSum ++;
          }
    	}
			if(numSum > 0){
					rdShowMessageDialog(objName+"不允许录入汉字！");				
					nextFlag = false;
					return false;
			}

		}
		/*法人证书 证件号码大于等于4位字符*/
		if(idTypeText == "B"){
		 if(objValueLength != 12){
					rdShowMessageDialog(objName+"必须是12位！");				
					nextFlag = false;
					return false;
			}
				    
			var m = /^[\u0391-\uFFE5]*$/;
			var numSum = 0;
			for (var i = 0; i < objValue.length; i ++){
          var code = objValue.charAt(i);//分别获取输入内容
          var flag = m.test(code);
          if(flag){
          	numSum ++;
          }
    	}
			if(numSum > 0){
					rdShowMessageDialog(objName+"不允许录入汉字！");				
					nextFlag = false;
					return false;
			}
			
		}
		/*调用原有逻辑*/
		rpc_chkX('idType','idIccid','A');
	}else if(opCode == "1993"){
		rpc_chkX('idType','idIccid','A');
	}
	return nextFlag;
}


/*
	2013/11/15 15:33:56 gaopeng 关于进一步提升省级支撑系统实名登记功能的通知  
	注意：只针对个人客户 end
*/ 

/*2013/12/16 15:41:14 gaopeng 经办人证件类型下拉表单改变函数*/
function validateGesIdTypes(idtypeVal){
		if(idtypeVal.indexOf("身份证") != -1){
  		document.all.gestoresIccId.v_type = "idcard";
  		if("<%=opCode%>" != "1993"){
  			$("#scan_idCard_two3").css("display","");
  			$("#scan_idCard_two31").css("display","");
	  		$("input[name='gestoresName']").attr("class","InputGrey");
	  		$("input[name='gestoresName']").attr("readonly","readonly");
	  		$("input[name='gestoresAddr']").attr("class","InputGrey");
	  		$("input[name='gestoresAddr']").attr("readonly","readonly");
	  		$("input[name='gestoresIccId']").attr("class","InputGrey");
	  		$("input[name='gestoresIccId']").attr("readonly","readonly");
	  		$("input[name='gestoresName']").val("");
	  		$("input[name='gestoresAddr']").val("");
	  		$("input[name='gestoresIccId']").val("");
  		}
  	}else{
  		document.all.gestoresIccId.v_type = "string";
  		if("<%=opCode%>" != "1993"){
  			$("#scan_idCard_two3").css("display","none");
  			$("#scan_idCard_two31").css("display","none");
	  		$("input[name='gestoresName']").removeAttr("class");
	  		$("input[name='gestoresName']").removeAttr("readonly");
	  		$("input[name='gestoresAddr']").removeAttr("class");
	  		$("input[name='gestoresAddr']").removeAttr("readonly");
	  		$("input[name='gestoresIccId']").removeAttr("class");
	  		$("input[name='gestoresIccId']").removeAttr("readonly");
  		}
  	}
}


function validateresponIdTypes(idtypeVal){
		if(idtypeVal.indexOf("身份证") != -1){
  		document.all.responsibleIccId.v_type = "idcard";
  		if("<%=opCode%>" != "1993"){
  			$("#scan_idCard_two3zrr").css("display","");
  			$("#scan_idCard_two57zrr").css("display","");
	  		$("input[name='responsibleName']").attr("class","InputGrey");
	  		$("input[name='responsibleName']").attr("readonly","readonly");
	  		$("input[name='responsibleAddr']").attr("class","InputGrey");
	  		$("input[name='responsibleAddr']").attr("readonly","readonly");
	  		$("input[name='responsibleIccId']").attr("class","InputGrey");
	  		$("input[name='responsibleIccId']").attr("readonly","readonly");
	  		$("input[name='responsibleName']").val("");
	  		$("input[name='responsibleAddr']").val("");
	  		$("input[name='responsibleIccId']").val("");
  		}
  	}else{
  		document.all.responsibleIccId.v_type = "string";
  		if("<%=opCode%>" != "1993"){
  			$("#scan_idCard_two3zrr").css("display","none");
  			$("#scan_idCard_two57zrr").css("display","none");
	  		$("input[name='responsibleName']").removeAttr("class");
	  		$("input[name='responsibleName']").removeAttr("readonly");
	  		$("input[name='responsibleAddr']").removeAttr("class");
	  		$("input[name='responsibleAddr']").removeAttr("readonly");
	  		$("input[name='responsibleIccId']").removeAttr("class");
	  		$("input[name='responsibleIccId']").removeAttr("readonly");
  		}
  	}
}


function checkNameStr(code){
			/* gaopeng 2014/01/17 9:50:35 优先匹配括号 因为括号可能是中文也可能是英文，优先返回KH 保证逻辑不失误*/
				if(forKuoHao(code)) return "KH";//括号
		    if(forA2sssz1(code)) return "EH"; //英语
		    var re2 =new RegExp("[\u0400-\u052f]");
		    if(re2.test(code)) return "RU"; //俄文
		    var re3 =new RegExp("[\u00C0-\u00FF]");
		    if(re3.test(code)) return "FH"; //法文
		    var re4 = new RegExp("[\u3040-\u30FF]");
		    var re5 = new RegExp("[\u31F0-\u31FF]");
		    if(re4.test(code)||re5.test(code)) return "JP"; //日文
		    var re6 = new RegExp("[\u1100-\u31FF]");
		    var re7 = new RegExp("[\u1100-\u31FF]");
		    var re8 = new RegExp("[\uAC00-\uD7AF]");
		    if(re6.test(code)||re7.test(code)||re8.test(code)) return "KR"; //韩国
		    if(forHanZi1(code)) return "CH"; //汉字
    
   }

function reSetCustName(){/*重置客户名称*/
  document.all.custName.value="";
  document.all.contactPerson.value="";
  
  /*20131216 gaopeng 2013/12/16 15:11:05 当选择单位开户时，展示经办人信息并将其信息设计为必填选项 start*/
  var checkVal = $("select[name='isJSX']").find("option:selected").val();
  if(checkVal == 1){ //单位客户
  	$("#gestoresInfo1").show();
  	$("#gestoresInfo2").show();
		$("#sendProjectList").hide(); //下发工单按钮
		$("#sendProjectPhones").hide();
		$("#sendProjectPhonesbiaozhi").hide();
		$("#qryListResultBut").hide(); //工单结果查询按钮
  	/*经办人姓名*/
  	document.all.gestoresName.v_must = "1";
  	/*经办人地址*/
  	document.all.gestoresAddr.v_must = "1";
  	/*经办人证件号码*/
  	document.all.gestoresIccId.v_must = "1";
  	var checkIdType = $("select[name='gestoresIdType']").find("option:selected").val();
  	/*身份证加入校验方法*/
  	if(checkIdType.indexOf("身份证") != -1){
  		document.frm1100.gestoresIccId.v_type = "idcard";
  		$("#scan_idCard_two3").css("display","");
  		$("#scan_idCard_two31").css("display","");
  		$("input[name='gestoresName']").attr("class","InputGrey");
  		$("input[name='gestoresName']").attr("readonly","readonly");
  		$("input[name='gestoresAddr']").attr("class","InputGrey");
  		$("input[name='gestoresAddr']").attr("readonly","readonly");
  		$("input[name='gestoresIccId']").attr("class","InputGrey");
  		$("input[name='gestoresIccId']").attr("readonly","readonly");
  	}else{
  		document.frm1100.gestoresIccId.v_type = "string";
  		$("#scan_idCard_two3").css("display","none");
  		$("#scan_idCard_two31").css("display","none");
  		$("input[name='gestoresName']").removeAttr("class");
  		$("input[name='gestoresName']").removeAttr("readonly");
  		$("input[name='gestoresAddr']").removeAttr("class");
  		$("input[name='gestoresAddr']").removeAttr("readonly");
  		$("input[name='gestoresIccId']").removeAttr("class");
  		$("input[name='gestoresIccId']").removeAttr("readonly");
  	}
  	
  	//责任人信息
  	$("#responsibleInfo1").show();
  	$("#responsibleInfo2").show();

  	/*责任人人姓名*/
  	document.all.responsibleName.v_must = "1";
  	/*责任人人地址*/
  	document.all.responsibleAddr.v_must = "1";
  	/*经责任人人证件号码*/
  	document.all.responsibleIccId.v_must = "1";
  	var checkIdType22 = $("select[name='responsibleType']").find("option:selected").val();
  	/*身份证加入校验方法*/
  	if(checkIdType22.indexOf("身份证") != -1){
  		document.frm1100.responsibleIccId.v_type = "idcard";
  		$("#scan_idCard_two3zrr").css("display","");
  		$("#scan_idCard_two57zrr").css("display","");
  		$("input[name='responsibleName']").attr("class","InputGrey");
  		$("input[name='responsibleName']").attr("readonly","readonly");
  		$("input[name='responsibleAddr']").attr("class","InputGrey");
  		$("input[name='responsibleAddr']").attr("readonly","readonly");
  		$("input[name='responsibleIccId']").attr("class","InputGrey");
  		$("input[name='responsibleIccId']").attr("readonly","readonly");  		
  		
  	}else{
  		document.frm1100.responsibleIccId.v_type = "string";
  		$("#scan_idCard_two3zrr").css("display","none");
  		$("#scan_idCard_two57zrr").css("display","none");
  		$("input[name='responsibleName']").removeAttr("class");
  		$("input[name='responsibleName']").removeAttr("readonly");
  		$("input[name='responsibleAddr']").removeAttr("class");
  		$("input[name='responsibleAddr']").removeAttr("readonly");
  		$("input[name='responsibleIccId']").removeAttr("class");
  		$("input[name='responsibleIccId']").removeAttr("readonly");  		
  		
  	}	
  	
  	
  }
  /*没选择单位客户的时候，均不展示并设置为不需要必填选项*/
  else{
  	$("#gestoresInfo1").hide();
  	$("#gestoresInfo2").hide();
  	/*经办人姓名*/
  	document.all.gestoresName.v_must = "0";
  	/*经办人地址*/
  	document.all.gestoresAddr.v_must = "0";
  	/*经办人证件号码*/
  	document.all.gestoresIccId.v_must = "0";
  	
  	//责任人信息
  	$("#responsibleInfo1").hide();
  	$("#responsibleInfo2").hide();

  	/*责任人人姓名*/
  	document.all.responsibleName.v_must = "0";
  	/*责任人人地址*/
  	document.all.responsibleAddr.v_must = "0";
  	/*经责任人人证件号码*/
  	document.all.responsibleIccId.v_must = "0";  	
  	
  }
  /*20131216 gaopeng 2013/12/16 15:11:05 当选择单位开户时，展示经办人信息并将其信息设计为必填选项 end*/
  
  getIdTypes();
  /* begin add 如 1100+普通开户+身份证+社会渠道工号+开关+开展地市，则显示“下发工单”按钮 for 关于电话用户实名登记近期重点工作的通知 @2014/11/4 */
  var idTypeSelect = $("#idTypeSelect option[@selected]").val();//证件类型：身份证
  if(checkVal == 0){
		if(idTypeSelect.indexOf("|") != -1){
			var v_idTypeSelect = idTypeSelect.split("|")[0];
			if(v_idTypeSelect == "0" && "<%=workChnFlag%>" == "1" && "<%=opCode%>" == "1100" && (parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y"){
				$("#sendProjectList").show();
				$("#sendProjectPhones").show();
				$("#sendProjectPhonesbiaozhi").show();
				$("#qryListResultBut").show();
			}else{
				$("#sendProjectList").hide();
				$("#sendProjectPhones").hide();
				$("#sendProjectPhonesbiaozhi").hide();
				$("#qryListResultBut").hide();
			}
		}
  }
  /* end add for 关于电话用户实名登记近期重点工作的通知 @2014/11/4 */
  /* begin update for 关于开发智能终端CRM模式APP的函 - 第二批@2015/3/10 */
  if(idTypeSelect.indexOf("|") != -1){
  	var v_idTypeSelect1 = idTypeSelect.split("|")[0];
		if(v_idTypeSelect1 == "0"){ //身份证
			if("<%=workChnFlag%>" != "1"){ //自有营业厅
				$("#idIccid").attr("class","InputGrey");
				$("#idIccid").attr("readonly","readonly");
				$("#custName").attr("class","InputGrey");
				$("#custName").attr("readonly","readonly");
				$("#idAddr").attr("class","InputGrey");
				$("#idAddr").attr("readonly","readonly");
				$("#idValidDate").attr("class","InputGrey");
				$("#idValidDate").attr("readonly","readonly");
				$("#idIccid").val("");
				$("#custName").val("");
				$("#idAddr").val("");
				$("#idValidDate").val("");
			}else{ //社会渠道
				if((parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y"){ //集团公司查验开关为“开”+地市开关为“开”时
					$("#idIccid").attr("class","InputGrey");
					$("#idIccid").attr("readonly","readonly");
					$("#custName").attr("class","InputGrey");
					$("#custName").attr("readonly","readonly");
					$("#idAddr").attr("class","InputGrey");
					$("#idAddr").attr("readonly","readonly");
					$("#idValidDate").attr("class","InputGrey");
					$("#idValidDate").attr("readonly","readonly");
					$("#idIccid").val("");
					$("#custName").val("");
					$("#idAddr").val("");
					$("#idValidDate").val("");
				}
			}
		}else{
			if("<%=workChnFlag%>" != "1"){ //自有营业厅
				$("#idIccid").removeAttr("class");
				$("#idIccid").removeAttr("readonly");
				$("#custName").removeAttr("class");
				$("#custName").removeAttr("readonly");
				$("#idAddr").removeAttr("class");
				$("#idAddr").removeAttr("readonly");
				$("#idValidDate").removeAttr("class");
				$("#idValidDate").removeAttr("readonly");
			}else{ //社会渠道
				if((parseInt($("#sendListOpenFlag").val()) > 0) && "<%=regionCodeFlag%>" == "Y"){ //集团公司查验开关为“开”+地市开关为“开”时
					$("#idIccid").removeAttr("class");
					$("#idIccid").removeAttr("readonly");
					$("#custName").removeAttr("class");
					$("#custName").removeAttr("readonly");
					$("#idAddr").removeAttr("class");
					$("#idAddr").removeAttr("readonly");
					$("#idValidDate").removeAttr("class");
					$("#idValidDate").removeAttr("readonly");
				}
			}
		}
  }
  /* end update for 关于开发智能终端CRM模式APP的函 - 第二批@2015/3/10 */	
}
/**** tianyang add for 中文字符限制 end ****/


function feifa1(textName)
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
  
  var Str = document.all.idType.value;
 
    if(Str.indexOf("身份证") > -1){
      if($("#idIccid").val().length<18){
        rdShowMessageDialog("身份证号码必须是18位！");
        document.all.idIccid.focus();
        return false;
      }
    }
  
  
  rpc_chkX('idType','idIccid','A');
}
  
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
  var actionstr ="sq100_2.jsp?custId="+document.frm1100.custId.value+
                  "&regionCode="+document.frm1100.regionCode.value+
                  "&filep_j="+document.frm1100.filep.value+
                  "&card_flag="+document.all.card_flag.value+ 
                  "&but_flag="+document.all.but_flag.value+
                  "&idSexH="+document.all.idSexH.value+
                  "&custName="+document.all.custName.value+
                  "&idAddrH="+document.all.idAddrH.value.replace(new RegExp("#","gm"),"%23")+
                  "&birthDayH="+document.all.birthDayH.value+
                  "&custId="+document.all.custId.value+
                  "&idIccid="+document.all.idIccid.value+
                  "&workno="+document.all.workno.value+
                  "&zhengjianyxq="+document.all.idValidDate.value+
                  "&opCode=<%=opCode%>"+
                  "&upflag=1"
                   +"&isJSX="+document.all.isJSX.value;
                  
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
    var sqlStr = "90000016";
    var params = preUnitId + "|<%=regionCode%>|";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|3|4|5|6|0|1|";//返回字段 zhangyan mod 增加集团名称
    var fieldName = "集团编号|集团名称|集团地址|联系人姓名|联系人电话|联系人邮编|联系人传真|";//弹出窗口显示的列、列名
    var pageTitle = "潜在集团信息查询";
    var path = "fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    path = path + "&params=" + params;
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
  
  //下发工单
  function sendProLists(){
  	var phonenos=document.all.sendProjectPhones.value.trim();
  	if(phonenos=="") {
			rdShowMessageDialog("开户号码不能为空！");
			document.all.sendProjectPhones.focus();
			return false;
		}
  	if(!checkElement(document.all.sendProjectPhones)){
      return false;
      }else{	
      
      if(phonenos.substring(0,3)=="209") {
       if(phonenos.length!=14) {
      rdShowMessageDialog("209开头的开户号码要求输入209+11位手机号码，请重新输入！");
			document.all.sendProjectPhones.focus();
			return false;
       }
       
       phonesimstatus=0;
      
      }else {
      
      	var myPacketsd = new AJAXPacket("checkPhoneStatus.jsp","正在验证新SIM类型，请稍候......");
				myPacketsd.data.add("phoneNo",phonenos);
				core.ajax.sendPacket(myPacketsd,checkphonestatus);
				myPacketsd=null;
	
      }
      
      if(phonesimstatus!=0) {      
       return false;
      }
      
      
		var packet = new AJAXPacket("fq100_ajax_sendProLists.jsp","正在获得数据，请稍候......");
		packet.data.add("opCode","<%=opCode%>");
		packet.data.add("phoneNo",phonenos);
		core.ajax.sendPacket(packet,doSendProLists);
		packet = null;
		
			}

  } 
  
   function checkphonestatus(packet) {
    var simtypesz = packet.data.findValueByName("simtypesz");

 		if(simtypesz=="0") {
 		rdShowMessageDialog("该号码的状态不是允许开户的状态，请重新输入！");
 		phonesimstatus="1";
 		document.all.sendProjectPhones.focus();
 		document.all.sendProjectPhones.select();
 		
 		}
 		else {
 		phonesimstatus="0";
 		}
 }
  
  function doSendProLists(packet){
  	var retCode = packet.data.findValueByName("retCode");
		var retMsg =  packet.data.findValueByName("retMsg");
		if(retCode != "000000"){
			rdShowMessageDialog( "下发工单失败!<br>错误代码："+retCode+"<br>错误信息："+retMsg,0 );
			//记录为没点击
			$("#isSendListFlag").val("N");
		}else{
			rdShowMessageDialog( "下发工单成功!",2 );
			//记录为点击
			$("#isSendListFlag").val("Y");
		}
  }
  
  //工单结果查询
	function qryListResults(){
		var h=450;
		var w=800;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px;dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;status:no;help:no";
		var ret=window.showModalDialog("f1100_qryListResults.jsp?opCode=<%=opCode%>&opName=<%=opName%>&accp="+Math.random(),"",prop);
		if(typeof(ret) == "undefined"){
			rdShowMessageDialog("如果没有工单查询结果，请先进行下发工单操作！");
			$("#isQryListResultFlag").val("N");//选择了工单查询结果
		}else if(ret!=null && ret!=""){
			$("#isQryListResultFlag").val("Y");//选择了工单查询结果
			$("#custName").val(ret.split("~")[0]); //客户姓名
			$("#idIccid").val(ret.split("~")[1]); //证件号码
			if($("#idIccid").val() != ""){
				checkIccIdFunc16New(document.all.idIccid,0,0);rpc_chkX('idType','idIccid','A');
			}
			$("#idAddr").val(ret.split("~")[2]);  //证件地址
			$("input[name='custAddr']").val(ret.split("~")[2]); //客户地址
			$("input[name='contactAddr']").val(ret.split("~")[2]); //联系人地址
			$("input[name='contactMAddr']").val(ret.split("~")[2]); //联系人通讯地址
			$("#idValidDate").val(ret.split("~")[3]); //证件有效期
			$("#idIccid").attr("class","InputGrey");
  		$("#idIccid").attr("readonly","readonly");
  		$("#custName").attr("class","InputGrey");
  		$("#custName").attr("readonly","readonly");
  		$("#idAddr").attr("class","InputGrey");
  		$("#idAddr").attr("readonly","readonly");	
  		$("#idValidDate").attr("class","InputGrey");
  		$("#idValidDate").attr("readonly","readonly");			
		}
	}  
	
	//只需要将table增加一个vColorTr='set' 属性就可以隔行变色
	$("table[vColorTr='set']").each(function(){
		$(this).find("tr").each(function(i,n){
			$(this).bind("mouseover",function(){
				$(this).addClass("even_hig");
			});
		
			$(this).bind("mouseout",function(){
				$(this).removeClass("even_hig");
			});
		
			if(i%2==0){
				$(this).addClass("even");
			}
		});
	});
  
  //获取直管客户信息
  function qryDirectManageCustInfo1(obj){
  	var custName = $("#custName").val();
		if(obj.value == "1"){ //是
			var h=450;
			var w=800;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var prop="dialogHeight:"+h+"px;dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;status:no;help:no";
			var ret=window.showModalDialog("f1993_qryDirectManageCustInfo.jsp?custName=" + custName+"&opCode=<%=opCode%>","",prop);
			if(typeof(ret) == "undefined"){
				$("#isDirectManageCust").val("0");
				$("#directManageCustNo").val("");
				//$("#groupNo").val("");
			}else if(ret!=null && ret!=""){
				$("#directManageCustNo").val(ret.split("~")[0]);
				$("#groupNo").val(ret.split("~")[2]);
			}
		}else{
			$("#directManageCustNo").val("");
			$("#groupNo").val("");
		}
  }
  
  function qryDirectManageCustInfo2(obj){
  	if($("#isDirectManageCust").val() == "0"){ //否 不是直管客户 
  		if(obj.value != "" && obj.value != null){ //组织机构代码 有值
  			var isDirectManageCust = $("#isDirectManageCust").val();
		  	if(isDirectManageCust == "0"){ //否
		  		var packet = new AJAXPacket("f1993_ajax_qryDirectManageCustInfo2.jsp","正在获得数据，请稍候......");
			    	packet.data.add("directManageCustNo","");
			    	packet.data.add("groupNo",obj.value);
			    	packet.data.add("institutionName","");
			    	packet.data.add("directManageCustName","");
			    	packet.data.add("opCode","<%=opCode%>");
			    	core.ajax.sendPacket(packet,doQryDirectManageCustInfo2);
			    	packet = null;
		  	}
  		}
  	}
  }
  
  function doQryDirectManageCustInfo2(packet){
		var retCode = packet.data.findValueByName("retCode");
		var retMsg =  packet.data.findValueByName("retMsg");
		var v_directManageCustNo =  packet.data.findValueByName("v_directManageCustNo");
		var v_groupNo =  packet.data.findValueByName("v_groupNo");
		if(v_directManageCustNo.length > 0 && v_directManageCustNo != ""){
			var confirmFlag = rdShowConfirmDialog("该集团客户为直管客户，是否将本集团修改为直管客户？");
			if(confirmFlag == 1){
				$("#isDirectManageCust").val("1");
				$("#directManageCustNo").val(v_directManageCustNo);
				$("#groupNo").val(v_groupNo);
			}else{
				//$("#directManageCustNo").val("");
				//$("#groupNo").val("");
			}
		}
  }
  
  function getCuTime(){
	 var curr_time = new Date(); 
	 with(curr_time) 
	 { 
	 var strDate = getYear()+"-"; 
	 strDate +=getMonth()+1+"-"; 
	 strDate +=getDate()+" "; //取当前日期，后加中文“日”字标识 
	 strDate +=getHours()+"-"; //取当前小时 
	 strDate +=getMinutes()+"-"; //取当前分钟 
	 strDate +=getSeconds(); //取当前秒数 
	 return strDate; //结果输出 
	 } 
	}
  
  function Idcard_realUser(flag){
		//读取二代身份证
		//document.all.card_flag.value ="2";
		
		var picName = getCuTime();
		var fso = new ActiveXObject("Scripting.FileSystemObject");  //取系统文件对象
		var tmpFolder = fso.GetSpecialFolder(0); //取得系统安装目录
		var strtemp= tmpFolder+"";
		var filep1 = strtemp.substring(0,1)//取得系统目录盘符
		var cre_dir = filep1+":\\custID";//创建目录
		//判断文件夹是否存在，不存在则创建目录
		if(!fso.FolderExists(cre_dir)) {
			var newFolderName = fso.CreateFolder(cre_dir);  
		}
		var picpath_n = cre_dir +"\\"+picName+"_"+ document.all.custId.value +".jpg";
		
		var result;
		var result2;
		var result3;
	
		result=IdrControl1.InitComm("1001");
		if (result==1)
		{
			result2=IdrControl1.Authenticate();
			if ( result2>0)
			{              
				result3=IdrControl1.ReadBaseMsgP(picpath_n); 
				if (result3>0)           
				{     
			  var name = IdrControl1.GetName();
				var code =  IdrControl1.GetCode();
				var sex = IdrControl1.GetSex();
				var bir_day = IdrControl1.GetBirthYear() + "" + IdrControl1.GetBirthMonth() + "" + IdrControl1.GetBirthDay();
				var IDaddress  =  IdrControl1.GetAddress();
				var idValidDate_obj = IdrControl1.GetValid();
		
				if(flag == "manage"){  //经办人
					document.all.gestoresName.value =name;//姓名
					document.all.gestoresIccId.value =code;//身份证号
					//document.all.gestoresAddr.value =IDaddress;//身份证地址
				}
				
				if(flag == "zerenren"){  //责任人
					document.all.responsibleName.value =name;//姓名
					document.all.responsibleIccId.value =code;//身份证号
					//document.all.gestoresAddr.value =IDaddress;//身份证地址
				}
				
				
				
				subStrAddrLength(flag,IDaddress);//校验身份证地址，如果超过60个字符，则自动截取前30个字
				}
				else
				{
					rdShowMessageDialog(result3); 
					IdrControl1.CloseComm();
				}
			}
			else
			{
				IdrControl1.CloseComm();
				rdShowMessageDialog("请重新将卡片放到读卡器上");
			}
		}
		else
		{
			IdrControl1.CloseComm();
			rdShowMessageDialog("端口初始化不成功",0);
		}
		IdrControl1.CloseComm();
	}
  
  function Idcard2(str){
			//扫描二代身份证
		var fso = new ActiveXObject("Scripting.FileSystemObject");  //取系统文件对象
		tmpFolder = fso.GetSpecialFolder(0); //取得系统安装目录
		var strtemp= tmpFolder+"";
		var filep1 = strtemp.substring(0,1)//取得系统目录盘符
		var cre_dir = filep1+":\\custID";//创建目录
		if(!fso.FolderExists(cre_dir)) {
			var newFolderName = fso.CreateFolder(cre_dir);
		}
	var ret_open=CardReader_CMCC.MutiIdCardOpenDevice(1000);
	if(ret_open!=0){
		ret_open=CardReader_CMCC.MutiIdCardOpenDevice(1001);
	}	
	var cardType ="11";
	if(ret_open==0){
		//alert(v_printAccept+"--"+str);
			//多功能设备RFID读取
			var ret_getImageMsg=CardReader_CMCC.MutiIdCardGetImageMsg(cardType,"c:\\custID\\cert_head_"+v_printAccept+str+".jpg");
			if(str=="1"){
				try{
					document.all.pic_name.value = "C:\\custID\\cert_head_"+v_printAccept+str+".jpg";
					document.all.but_flag.value="1";
					document.all.card_flag.value ="2";
				}catch(e){
						
				}
			}
			//alert(ret_getImageMsg);
			//ret_getImageMsg = "0";
			if(ret_getImageMsg==0){
				//二代证正反面合成
				var xm =CardReader_CMCC.MutiIdCardName;					
				var xb =CardReader_CMCC.MutiIdCardSex;
				var mz =CardReader_CMCC.MutiIdCardPeople;
				var cs =CardReader_CMCC.MutiIdCardBirthday;
				var yx =CardReader_CMCC.MutiIdCardSigndate+"-"+CardReader_CMCC.MutiIdCardValidterm;
				var yxqx = CardReader_CMCC.MutiIdCardValidterm;//证件有效期
				var zz =CardReader_CMCC.MutiIdCardAddress; //住址
				var qfjg =CardReader_CMCC.MutiIdCardOrgans; //签发机关
				var zjhm =CardReader_CMCC.MutiIdCardNumber; //证件号码
				var base64 =CardReader_CMCC.MutiIdCardPhoto;
				var v_validDates = "";
				if(yxqx.indexOf("\.") != -1){
					yxqx = yxqx.split(".");
					if(yxqx.length >= 3){
						v_validDates = yxqx[0]+yxqx[1]+yxqx[2]; 
					}else{
						v_validDates = "21000101";
					}
				}else{
					v_validDates = "21000101";
				}
				
				if(str == "1"){ //读取客户基本信息
					//证件号码、证件名称、证件地址、有效期
					document.all.custName.value =xm;//姓名
					document.all.idIccid.value =zjhm;//身份证号
					//document.all.idAddr.value =zz;//身份证地址
					document.all.idValidDate.value =v_validDates;//证件有效期
					document.all.birthDay.value =cs;//生日
					document.all.birthDayH.value =cs;//生日
					document.all.custSex.value=xb;//性别
		  		document.all.idSexH.value=xb;//性别
					$("#idIccid").attr("class","InputGrey");
		  		$("#idIccid").attr("readonly","readonly");
		  		$("#custName").attr("class","InputGrey");
		  		$("#custName").attr("readonly","readonly");
		  		$("#idAddr").attr("class","InputGrey");
		  		$("#idAddr").attr("readonly","readonly");
		  		$("#idValidDate").attr("class","InputGrey");
		  		$("#idValidDate").attr("readonly","readonly");
		  		checkIccIdFunc16New(document.all.idIccid,0,0);rpc_chkX('idType','idIccid','A');
		  		checkCustNameFunc16New(document.all.custName,0,0);
		  		pubM032Cfm();
				}else if(str == "31"){ //经办人
					document.all.gestoresName.value =xm;//姓名
					document.all.gestoresIccId.value =zjhm;//身份证号
					//document.all.gestoresAddr.value =zz;//身份证地址
				}else if(str == "57"){ //责任人
					document.all.responsibleName.value =xm;//姓名
					document.all.responsibleIccId.value =zjhm;//身份证号
					//document.all.gestoresAddr.value =zz;//身份证地址
				}
				
				subStrAddrLength(str,zz);//校验身份证地址，如果超过60个字符，则自动截取前30个字
				
				
				
			}else{
					rdShowMessageDialog("获取信息失败");
					return ;
			}
	}else{
					rdShowMessageDialog("打开设备失败");
					return ;
	}
	//关闭设备
	var ret_close=CardReader_CMCC.MutiIdCardCloseDevice();
	if(ret_close!=0){
		rdShowMessageDialog("关闭设备失败");
		return ;
	}
	
}

function pubM032Cfm(){
	/*2015/8/19 16:12:01 gaopeng 关于修改BOSS系统实名判断条件及在经分系统中增加全省实名补登记日报表的函-补充需求
					在这里调用服务 sM032Cfm 
				*/
				
				var myPacket = new AJAXPacket("/npage/public/pubM032Cfm.jsp","正在查询信息，请稍候......");
			  myPacket.data.add("idSexH",document.all.idSexH.value);
			  myPacket.data.add("custName",document.all.custName.value);
			  myPacket.data.add("idAddrH",document.all.idAddrH.value.replace(new RegExp("#","gm"),"%23"));
			  myPacket.data.add("birthDayH",document.all.birthDayH.value);
			  myPacket.data.add("custId",document.all.custId.value);
			  myPacket.data.add("idIccid",document.all.idIccid.value);
			  myPacket.data.add("zhengjianyxq",document.all.idValidDate.value);
			  myPacket.data.add("opCode","<%=opCode%>");
			  
			  core.ajax.sendPacket(myPacket,function(packet){
			  	var retCode=packet.data.findValueByName("retCode");
				  var retMsg=packet.data.findValueByName("retMsg");
				  
				  if(retCode == "000000"){
				  	//document.all.uploadpic_b.disabled=false;
				 	}else{
				 		//rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,0);
				 		//document.all.uploadpic_b.disabled=true;
						//return  false;
				 	}
		 		});
				myPacket = null;
}

function subStrAddrLength(str,idAddr){
	var packet = new AJAXPacket("/npage/sq100/fq100_ajax_subStrAddrLength.jsp","正在获得数据，请稍候......");
	packet.data.add("str",str);
	packet.data.add("idAddr",idAddr);
	core.ajax.sendPacket(packet,doSubStrAddrLength);
	packet = null;
}

function doSubStrAddrLength(packet){
	var str = packet.data.findValueByName("str");
	var idAddr = packet.data.findValueByName("idAddr");
	if(str == "1"){ //读取客户基本信息
		document.all.idAddr.value =idAddr;//身份证地址
		document.all.idAddrH.value =idAddr;//身份证地址
		checkAddrFunc(document.all.idAddr,0,0);
	}else if(str == "31"){ //经办人
		document.all.gestoresAddr.value =idAddr;//身份证地址
	}else if(str == "manage"){ //经办人 旧版
		document.all.gestoresAddr.value =idAddr;//身份证地址
	}else if(str == "j1"){ //读取客户基本信息 旧版
		document.all.idAddr.value =idAddr;//身份证地址
		document.all.idAddrH.value =idAddr;//身份证地址
	}else if(str == "zerenren"){ //责任人 旧版
		document.all.responsibleAddr.value =idAddr;//身份证地址
	}else if(str == "57"){ //责任人 
		document.all.responsibleAddr.value =idAddr;//身份证地址
	}
	
}

function go_getCust_M_workName(){
	if($("#cust_M_workNO").val().trim()==""){
		rdShowMessageDialog("请输入客户经理工号");
		return;
	}
		var packet = new AJAXPacket("ajax_getCust_M_workName.jsp","正在获得数据，请稍候......");
				packet.data.add("cust_M_workNO",$("#cust_M_workNO").val());
				core.ajax.sendPacket(packet,do_getCust_M_workName);
				packet = null;
}

function do_getCust_M_workName(packet){
	var login_M_name = packet.data.findValueByName("login_M_name");
	var workNo_orgCode_flag = packet.data.findValueByName("workNo_orgCode_flag");
	
	if(workNo_orgCode_flag == "1"){
		rdShowMessageDialog("操作工号与输入的客户经理工号不在同一地市！");
		$("#cust_M_workNO").val("")
		$("#cust_M_workName").text("");
	}else{
		if(login_M_name!=""){
			$("#cust_M_workName").text(login_M_name);
			$("#cust_M_workNO").attr("readyOnly","readyOnly");
			$("#cust_M_workNO").addClass("InputGrey");
			$("#btn_go_getCust_M_workName").attr("disabled","disabled");
		}else{
			rdShowMessageDialog("校验客户经理工号失败");
			$("#cust_M_workNO").val("")
			$("#cust_M_workName").text("");
		}
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
              <TABLE cellspacing="0" style="display:none;">
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
                    <font class=orange> *</font>
                    <!--<font class=orange> *&nbsp;(上级客户名称为汉字且不得超过六个)</font>-->
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
                  <TD width=34%> 
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
          /** try
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
            //out.println("<option class='button' value='" + resultt[i][0] + "'>" + resultt[i][1] + "</option>");
            if("1993".equals(opCode)){
              if("02".equals(resultt[i][0])||"04".equals(resultt[i][0])){ //展示集团，或EC集团
                out.println("<option class='button' value='" + resultt[i][0] + "'>" + resultt[i][1] + "</option>");
              }
            }else if("1100".equals(opCode)){
              if(!("02".equals(resultt[i][0]))&&!("04".equals(resultt[i][0]))){
                out.println("<option class='button' value='" + resultt[i][0] + "'>" + resultt[i][1] + "</option>");
              }
            }else{
              out.println("<option class='button' value='" + resultt[i][0] + "'>" + resultt[i][1] + "</option>");
            }
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
                    <input name="custId" v_type="0_9" class="button" v_must="1" v_name="客户ID" maxlength="14" readonly>
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
                      <option class="button" value="0">普通客户</option>
                    System.out.println(" zhouby workChnFlag " + workChnFlag);  
<%
                    if (!(workChnFlag.equals("1") && openFav == false)){
%>
                        <option class="button" value="1">单位客户</option>
<%
                    }
%>
                    </select>
                    &nbsp;&nbsp;&nbsp;
                    <span  id="sendProjectPhonesbiaozhi" name="sendProjectPhonesbiaozhi">开户号码</span>
                     <input type="text" id="sendProjectPhones"  name="sendProjectPhones"  value=""  v_minlength=0 v_maxlength=14  v_type="0_9" maxlength="14" onkeyup="this.value=this.value.replace(/\D/g,'')" onafterpaste="this.value=this.value.replace(/\D/g,'')" style="display:none" />                    
                    &nbsp;&nbsp;&nbsp;
										<input type="button" id="sendProjectList" name="sendProjectList" class="b_text" value="下发工单" onclick="sendProLists()" style="display:none" />                    
                  	&nbsp;&nbsp;&nbsp;                 	                  	
                  	<input type="button" id="qryListResultBut" name="qryListResultBut" class="b_text" value="工单结果查询" onclick="qryListResults()" style="display:none" />     
                  </TD>
                </tr>
                <!-- tianyang add for custNameCheck end -->
        <!--zhangyan add 客户服务等级 b-->
                <tr id="trU00020003"  style="display:none">
                  <TD width=16% class="blue" > 
                      <div align="left">总部直管客户</div>
                  </TD>
                    <TD  width="16%" class="blue" >
            <select align="left"  name = "selU0002" id = "selU0002" >
              <option class="button"  value="X" >---请选择---</option>
              <option class="button"  value="1" >1—>是</option>
              <option class="button"  value="0" >0—>否</option>
            </select>
                    </TD>
                  <TD width=16% class="blue" > 
                      <div align="left">省级客户</div>
                  </TD>
                    <TD  width="16%" class="blue" >
            <select align="left"  name = "selU0003" id = "selU0003" >
              <option class="button"  value="X" >---请选择---</option>
              <option class="button"  value="1" >1—>是</option>
              <option class="button"  value="0" >0—>否</option>
            </select>
                    </TD>                   
                </tr>         
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
                    <input name=custName id="custName" value=""  v_must=1 v_maxlength=60 v_type="string"   maxlength="60" size=20 index="9"  onblur="if(checkElement(this)){checkCustNameFunc16New(this,0,0)}">
                    <div id="checkName" style="display:none"><input type="button" class="b_text" value="验证" onclick="checkName()"></div>
                   <font class=orange>*</font>
                    </TD>
                </TR>
                <tr> 
                  <td width=16% class="blue" > 
                    <div align="left">证件类型</div>
                  </td>
                  <td id="tdappendSome" width=34%> 
                    
                  </td>
                  <td width=16% class="blue" > 
                    <div align="left">证件号码</div>
                  </td>
                  <td width=34%> 
                    <input name="idIccid"  id="idIccid"   value=""  v_minlength=4 v_maxlength=20 v_type="string" onChange="change_idType('1')" maxlength="20"   index="11" value="" onBlur="checkIccIdFunc16New(this,0,0);rpc_chkX('idType','idIccid','A');">
                    <input name=IDQueryJustSee type=button class="b_text" style="cursor:hand" onClick="getInfo_IccId_JustSee()" id="custIdQueryJustSee" value=信息查询 >
                    <input type="button" name="iccIdCheck" class="b_text" value="校验" onclick="checkIccId()" disabled>
        						<input type="hidden" name="IccIdAccept" value="<%=IccIdAccept%>">
                    </td>
                </tr>
                
<TR id="card_id_type">
      
      <td colspan=2 align=center>
        <input type="button" name="read_idCard_one" style="display:none;" class="b_text"   value="扫描一代身份证" onClick="RecogNewIDOnly_one()" disabled>
        <input type="button" name="read_idCard_two" class="b_text"   value="扫描二代身份证" onClick="RecogNewIDOnly_two()"disabled>
        <input type="button" name="scan_idCard_two" class="b_text"   value="读卡" onClick="Idcard()" disabled>
        <input type="button" name="scan_idCard_two222" id="scan_idCard_two222" class="b_text"   value="读卡(2代)" onClick="Idcard2('1')" disabled>
         <input type="hidden"  class="b_text"   value="上传身份证图像" onClick="sfztpsc1100()">
         <input type="button" name="highView"  class="b_text" style="display:none"   value="高拍仪识读" onClick="highViewBtn()">	
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
          <input type="button" name="get_Photo" class="b_text"   value="显示照片" onClick="getPhoto()" disabled>
        
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
        
         <input type="button" name="uploadpic_b" class="b_text"   value="上传身份证图像" onClick="uploadpic()"  disabled>
        
        </td>
     </tr>
                <tr> 
                  <td class="blue" > 
                    <div id="idAddrDiv" align="left">证件地址</div>
                  </td>
                  <td> 
                    <input name=idAddr  id="idAddr" value=""   v_must=1 v_type="addrs"  maxlength="60" v_maxlength=60 size=30 index="12" onblur="if(checkElement(this)){checkAddrFunc(this,0,0)}">
                    <font class=orange>*</font> </td>
                  <td class="blue" > 
                    <div align="left">证件有效期</div>
                  </td>
                  <td> 
                    <input class="button" name="idValidDate" id="idValidDate" v_must=0 v_maxlength=8 v_type="date"  maxlength=8 size="8" index="13" onblur="if(checkElement(this)){chkValid();}">
                    <!--
                    <img src="../../js/common/date/button.gif" style="cursor:hand"  onclick="fPopUpCalendarDlg(idValidDate);return false" alt=弹出日历下拉菜单 align=absMiddle readonly>
                     -->
                  </td>
                </tr>
        
            
      <TR id ="divPassword" style="display:;"> 
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
                    <input name=custAddr class="button"  v_type="addrs" v_must=1 v_maxlength=60   maxlength="60" size=35 index="18" onblur="if(checkElement(this)){checkAddrFunc(this,1,0)}">
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
                    <input name=contactPerson class="button" value="" v_type="string"  maxlength="5" size=20 index="19" v_must=1 v_maxlength=15 onblur="if(checkElement(this)){checkCustNameFunc(this,1,0)}">
                    <font class=orange>*</font>
                    <font class=orange></font>
                    <!--<font class=orange>*&nbsp;(联系人姓名为汉字且不得超过六个)</font>-->
                  </TD>
                  <TD class="blue" > 
                    <div align="left">联系人电话</div>
                  </TD>
                  <TD> 
                    <input name=contactPhone class="button" v_must=1 v_type="phone" maxlength="20"  index="20" size="20" onblur="checkElement(this);" value="">
                    <font class=orange>*</font> </TD>
                </TR>
                <TR> 
                  <TD class="blue" > 
                    <div align="left">联系人地址</div>
                  </TD>
                  <TD> 
                    <input name=contactAddr  class="button" v_must=1 v_type="addrs"  maxlength="60" v_maxlength=60 size=30 index="21"  onblur="if(checkElement(this)){ checkAddrFunc(this,2,0);}">
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
                    <input name=contactMAddr class="button" v_must=1 v_maxlenth=60 v_type="addrs"  maxlength="60" size=35 index="25" onblur="if(checkElement(this)){checkAddrFunc(this,3,0)}">
                    <font class=orange>*</font></TD>
                </TR>
                
                <!-- 20131216 gaopeng 2013/12/16 10:29:28 关于在BOSS入网界面增加单位客户经办人信息的函 加入经办人信息 start -->
                <%@ include file="/npage/sq100/gestoresInfo.jsp" %>  
								             
                <TR id="isDirectManageCustTr1" style="display:none"> 
                  <td width=16% class="blue" > 
                    <div align="left">是否直管客户</div>
                  </td>
                  <td width=34%> 
                    <select name="isDirectManageCust" id="isDirectManageCust" onchange="qryDirectManageCustInfo1(this)">
                    	<option value="0" selected>否</option>
                    	<option value="1">是</option>
                    </select>
                  </td>
									<TD width=16%  class="blue" > 
										<div align="left">直管客户编码</div>
									</TD>
									<TD width=34%> 
										<input name="directManageCustNo" id="directManageCustNo"  class="button" v_must='0' v_type="string"  maxlength="60" v_maxlength=60 size=30 index="21" />
									</TD>
                </TR>
                <tr id="isDirectManageCustTr2" style="display:none"> 
                  <TD width=16% class="blue" > 
										<div align="left">组织机构代码</div>
									</TD>
									<TD width=34% colspan="3"> 
										<input name="groupNo" id="groupNo"  class="button" v_must='0' v_type="string"  maxlength="60" v_maxlength=60 size=30 index="21"  onblur="qryDirectManageCustInfo2(this)" />
									</TD>
                </tr>
                <%@ include file="/npage/sq100/responsibleInfo.jsp" %>
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
           
                String sqlStr11 ="select trim(owner_code), owner_NAME from dbvipadm.sGrpOwnerCode  where owner_code in ('C1','C2','C3','E','C4','C5')";                    
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
  
      <tr>
      <td width=16% class="blue" >是否测试集团</td>
      <td width=34% colspan="3">
        <select align="left" name="isceshijt_flag"  width=50 index="42">
          <option class="button" value="0">否->0</option>
          <option class="button" value="1">是->1</option>         
        </select>
      </td>
  </tr>  
  
<%
	if("1993".equals(opCode)){
%>
  <tr>
      <td width=16% class="blue" >客户经理工号</td>
      <td width=34%>
         <input type="text"  name="cust_M_workNO" id="cust_M_workNO" maxlength="6"  />
         <input type="button" class="b_text" value="验证" id="btn_go_getCust_M_workName" onclick="go_getCust_M_workName()" />
      </td>
      <td width=16% class="blue" >客户经理姓名</td>
      <td width=34%>
      	<span id="cust_M_workName"></span>
      </td>
  </tr>  
<%
}
%>  
    
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
          <input class="b_foot" name=reset1 type=button  onclick=" window.location.href='sq100_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>';" value=清除 index="40">
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
  <input type="hidden" name="opCode" value="<%=opCode%>">
  <input type="hidden" name="regionCode" value=<%=regionCode%>> 
  <input type="hidden" name="unitCode" value=<%=orgCode%>>
  <input type="hidden" id=in6 name="belongCode" value=<%=belongCode%>>  
  <input type="hidden" id=in1 name="hidPwd" v_name="原始密码">
  <input type="hidden" name="hidCustPwd">       <!--加密后的客户密码-->
  <input type="hidden" name="temp_custId">
  <input type="hidden" name="ip_Addr" value=<%=ip_Addr%>>
  <input type="hidden" name="inParaStr" >
  <input type="hidden" name="checkPwd_Flag" value="false">    <!--密码校验标志-->
  <input type="hidden" name="workName" value=<%=workName%> >
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
  <input type="hidden" name="isSendListFlag" id="isSendListFlag" value="N" />
  <input type="hidden" name="isQryListResultFlag" id="isQryListResultFlag" value="N" />
  <input type="hidden" name="sendListOpenFlag" id="sendListOpenFlag" value="<%=sendListOpenFlag%>" />
  <input type="hidden" name="input_accept" id="input_accept" value="<%=input_accept%>"> <!--产品部流水-->
  <input type="hidden" name="isse276_100" id="isse276_100" value="0">
  
  
  <%@ include file="/npage/include/footer.jsp" %> 
 
<jsp:include page="/npage/common/pwd_comm.jsp"/>
</form>
</body>
<OBJECT id="CardReader_CMCC" height="0" width="0"  classid="clsid:FFD3E742-47CD-4E67-9613-1BB0D67554FF" codebase="/npage/public/CardReader_AGILE.cab#version=1,0,0,6"></OBJECT>
<%@ include file="interface_provider.jsp" %>   
<%@ include file="/npage/include/public_smz_check.jsp" %>
</html>
