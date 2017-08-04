<%
/********************
 version v2.0
 开发商: si-tech
 update hejw@2009-2-5
********************/
%>

<%
  String opCode = "6714";
  String opName = "彩铃功能暂停/恢复";
%>            

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../include/remark1.htm" %>
<%
		
    ArrayList arr = (ArrayList)session.getAttribute("allArr");
    String[][] favInfo = (String[][])session.getAttribute("favInfo");
    
    String ip_Addr = (String)session.getAttribute("ipAddr");
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
    String org_code = (String)session.getAttribute("orgCode");
    String nopass  = (String)session.getAttribute("password");
    int    nextFlag=1;
    String regionCode = (String)session.getAttribute("regCode");
    
    
    String OpCode ="6714";
    String sInOpNote  ="号码信息初始化"; 
    
    String[][] temfavStr=(String[][])arr.get(3);
    String[] favStr=new String[temfavStr.length];
    for(int i=0;i<favStr.length;i++)
    favStr[i]=temfavStr[i][0].trim();
    boolean pwrf=false;
    if(WtcUtil.haveStr(favStr,"a272"))
	  pwrf=true;
    
	  
	  //获取从上页得到的信息
	  String loginAccept = request.getParameter("login_accept");
		if(loginAccept == null)
		{			
			//获取系统流水
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
<%	 		
			loginAccept=sysAcceptl;			
		}
	  String op_code = "6710"  ;	
	  String dateStr=new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
	  
	  String phone_no           ="";
	  String password           ="";
	  	  
	  String sOutCustId         ="";             //客户ID_NO          
	  String sOutCustName       ="";             //客户姓名           
	  String sOutSmCode         ="";             //服务品牌代码       
	  String sOutSmName         ="";             //服务品牌名称       
	  String sOutProductCode    ="";             //主产品代码         
	  String sOutProductName    ="";             //主产品名称         
	  String sOutPrePay         ="";             //可用预存           
	  String sOutRunCode        ="";             //运行状态代码       
	  String sOutRunName        ="";             //运行状态名称       
	  String sOutUsingCRProdCode="";             //已订购彩铃产品     
	  String sOutUsingCRProdName="";             //已订购彩铃产品名称 
	  String sOutCRColorType    ="";             //彩铃类型           
	  String sOutCRColorTypeName="";             //彩铃类型名称       
	  String sOutCRRunCode      ="";             //彩铃运行状态代码   
	  String sOutCRRunName      ="";             //彩铃运行状态名称   
	  String sOutCRBellBeginTime="";             //彩铃开通时间       
	  String sOutCRBellEndTime  ="";             //彩铃结束时间   
	  String sOutCustAddress ="";     //用户地址
    String sOutIdIccid     ="";     //证件号码    
	  	  
	  String action=request.getParameter("action");     
	  if (action!=null&&action.equals("select")){
	    phone_no = request.getParameter("phone_no");     
	    password = request.getParameter("password");
	    String Pwd1 = Encrypt.encrypt(password);      	//在此对用户传来的密码进行加密
	    	    
      //在此对用户密码进行判断
      if(pwrf==false){
			String[][] rt1 = new String[][]{};
      String sql="";
			sql = "select user_passwd from dcustmsg  where phone_no='"+phone_no+"'";
			//retPwd1 = co.sPubSelect("1",sql,"region",regionCode);
%>

		<wtc:pubselect name="sPubSelect" outnum="3" retmsg="msg2" retcode="code2" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sql%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>

<%			
			rt1 = result_t;
			String i3=rt1[0][0];
	    
	  	//if(0==Encrypt.checkpwd2(i3.trim(),Pwd1.trim())){				//比较用户传来加密的密码和服务取出加密的密码是否相同
       %>
       <!-- <script language='jscript'>
           rdShowMessageDialog("用户密码错误！",0);
           history.go(-1);
        </script>-->
       <%
    	 // }
    	}
		 	String paramsIn[] = new String[6];
		 	
		 	 paramsIn[0]=workno;                                 //操作工号         
	     paramsIn[1]=nopass;                                 //操作工号密码     
	     paramsIn[2]=OpCode;                                 //操作代码         
	     paramsIn[3]=sInOpNote;                              //操作描述         
	     paramsIn[4]=phone_no;                               //用户手机号码     
	     paramsIn[5]=Pwd1;                                   //用户密码         
		 	
			//acceptList = callView.callFXService("s6714Init", paramsIn, "19");
%>

    <wtc:service name="s6714InitEx" outnum="19" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=paramsIn[0]%>" />
			<wtc:param value="<%=paramsIn[1]%>" />
			<wtc:param value="<%=paramsIn[2]%>" />
			<wtc:param value="<%=paramsIn[3]%>" />
			<wtc:param value="<%=paramsIn[4]%>" />
			<wtc:param value="<%=paramsIn[5]%>" />				
		</wtc:service>
		<wtc:array id="result_t1" scope="end"  />

<%			
			String errCode = code1;
			String errMsg = msg1;     
      if(!errCode.equals("000000"))
			{
				%>        
			    <script language='jscript'>
			       rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
			       history.go(-1);
		      </script> 
		         
				<%  
			}					
			if(errCode.equals("000000"))
			{
				nextFlag = 2;				
				sOutCustId          =result_t1[0][0];           
				sOutCustName        =result_t1[0][1];           
				sOutSmCode          =result_t1[0][2];           
				sOutSmName          =result_t1[0][3];           
				sOutProductCode     =result_t1[0][4];           
				sOutProductName     =result_t1[0][5];           
				sOutPrePay          =result_t1[0][6].trim();           
				sOutRunCode         =result_t1[0][7];           
				sOutRunName         =result_t1[0][8];           
				sOutUsingCRProdCode =result_t1[0][9];           
				sOutUsingCRProdName =result_t1[0][10]; 
				sOutCRColorType     =result_t1[0][11]; 
				sOutCRColorTypeName =result_t1[0][12]; 
				sOutCRRunCode       =result_t1[0][13]; 
				sOutCRRunName       =result_t1[0][14]; 
				sOutCRBellBeginTime =result_t1[0][15]; 
				sOutCRBellEndTime   =result_t1[0][16]; 	
				sOutCustAddress  =result_t1[0][17];            // 用户地址
        sOutIdIccid      =result_t1[0][18];            // 证件号码 			 
	   }  
	 }    
%>      
        
<HEAD><TITLE>黑龙江BOSS-彩铃功能暂停恢复</TITLE>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<script language="JavaScript" src="/npage/s1300/common_1300.js"></script>

<script language="JavaScript">
 var js_pwFlag="false";
 js_pwFlag="<%=pwrf%>";
function doProcess(packet)
{
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");
	var retMessage = packet.data.findValueByName("retMessage");
	self.status="";
	//变更产品
  if(retType == "changProd"){  	
	  var triListData = packet.data.findValueByName("tri_list"); 	  
	 	var triList=new Array(triListData.length);
	  triList[0]="mebProdCode";
	  document.all("mebProdCode").length=0;
	  document.all("mebProdCode").options.length=triListData.length;
	  for(j=0;j<triListData.length;j++)
	  {
		document.all("mebProdCode").options[j].text=triListData[j][1];
		document.all("mebProdCode").options[j].value=triListData[j][0];
	  }
	  document.all("mebProdCode").options[0].selected=true; 
  }  
}
		
//确认提交
function refain()
{   
	getAfterPrompt();	
		showPrtDlg("Detail","确实要打印电子免填单吗？","Yes");
		if (rdShowConfirmDialog("是否提交确认操作？")==1){
		document.form.action="ff714_2.jsp";
	  document.form.submit();
	  return true;
	}  
}
//输入手机号和密码，查询具体信息
function doQuery()
	{
    if(!forMobil(document.form.phone_no))
    {
    	return false;
    }
	  //alert(document.form.phone_no.value);
		document.form.action = "ff714_1.jsp?action=select";
		document.form.submit(); 
	}
	
//调用公共界面，进行产品信息选择
function getInfo_Prod()
{
    var pageTitle = "集团产品选择";
    var fieldName = "产品代码|产品名称|";
	  var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|0|1|";
    var retToField = "product_code|";

    //首先判断是否已经选择了服务品牌
    if(document.form.sm_code.value == "")
    {
        rdShowMessageDialog("请首先选择集团信息化产品！",0);
        return false;
    }
    //首先判断是否已经选择了产品属性
    if(document.form.product_attr_hidden.value == "")
    {
        rdShowMessageDialog("请首先选择产品属性！",0);
        return false;
    }

    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}

function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "/npage/s6710/fpubprod_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
	  path = path + "&op_code=" + document.all.op_code.value;
	  path = path + "&sm_code=" + document.all.sm_code.value; 
	  path = path + "&cust_id=" + document.all.cust_id.value; 
    path = path + "&product_attr=" + document.all.product_attr.value; 

    retInfo = window.open(path,"newwindow","height=450, width=650,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");
    
	return true;
}

function getvalue(retInfo)
{
  var retToField = "product_code|";
  if(retInfo ==undefined)      
    {   return false;   }    
  document.form.product_code.value = retInfo ;
}

function changeOthers(){
	var mebMonthFlag=document.form.mebMonthFlag.value;
	if(payType=="0"){
		  document.form.matureProdCode.value="";
		  document.form.matureFlag.value="";
			tbs2.style.display="";
			tbs3.style.display="";			
			if(mebMonthFlag=="Y"){
				tbs2.style.display="none";
				tbs3.style.display="none";
				tbs4.style.display="";	
				tbs5.style.display="none";				  		  			         
			}else{		
				tbs4.style.display="none";
				tbs5.style.display="";							
			}				         
	}else{
		  	tbs2.style.display="none";
				tbs3.style.display="none";
			if(mebMonthFlag=="Y"){
				tbs4.style.display="";	
				tbs5.style.display="none";				  		  			         
			}else{
				document.form.matureProdCode.value="";
		    document.form.matureFlag.value="";
				tbs4.style.display="none";
				tbs5.style.display="";							
			}	
	}	
}
//根据产品类型进行产品变更
function tochange()
{  
		var mebMonthFlag = document.form.mebMonthFlag.value;
		var mode_type="";
		if(mebMonthFlag=="1")
		{
			mode_type="CR01";
		}else {
			mode_type= "CR02";
		}
		var sqlStr = "select mode_code,mode_name from sbillmodecode where  mode_type='"+mode_type+"'";	
		var myPacket = new AJAXPacket("select_rpc.jsp","正在获得业务模式信息，请稍候......");
		myPacket.data.add("retType","changProd");
		myPacket.data.add("sqlStr",sqlStr);
		core.ajax.sendPacket(myPacket);
		myPacket = null;
}

function changeMatureFlag(){
	var matureFlag=document.form.matureFlag.value;
	if(matureFlag=="N"){
	 document.form.matureProdCode.value="";
	 document.form.matureProdCode.disabled=true;
   }else{   
   document.form.matureProdCode.disabled=false;
   }	
}

function showPrtDlg(printType,DlgMessage,submitCfm) {  //显示打印对话框
   var h=150;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var printStr = printInfo(printType);
   if(printStr == "failed")
   {    return false;   }
			   
		 var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"	   
     var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
     var billType="1";                      //  票价类型1电子免填单、2发票、3收据
     var sysAccept =<%=loginAccept%>;                       // 流水号
     var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
     var mode_code=null;                        //资费代码
     var fav_code=null;                         //特服代码
     var area_code=null;                        //小区代码
     var opCode =   "<%=opCode%>";                         //操作代码
     var phoneNo =document.all.phone_no.value;                          //客户电话
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);    
		
			}
			
function printInfo(printType) { 
	var OnOff = document.all.OnOff.value;
	if(OnOff==1) {
		OnOff="彩铃业务恢复";
	}
	if(OnOff==0) {
		OnOff="彩铃业务暂停";
	}
				
				
		var retInfo = "";
		var note_info1 = "";
		var note_info2 = "";
		var note_info3 = "";
		var note_info4 = "";
		var opr_info = "";
		var cust_info = "";
		
		
		cust_info+="手机号码："+document.all.phone_no.value+"|";
		cust_info+="客户姓名："+document.all.cust_name.value+"|";
		cust_info+="证件号码："+document.all.sOutIdIccid.value+"|";
		cust_info+="客户地址："+document.all.sOutCustAddress.value+"|";
		
		opr_info+="业务品牌："+document.all.sm_name.value+"|";
		opr_info+="办理业务："+OnOff+"|";
		opr_info+="操作流水："+'<%=loginAccept%>'+"|";
		opr_info+="操作时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		opr_info+="生效时间："+"当日"+"|";
			
		note_info1+=""+"|";	
						
	    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
        retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式

   		 return retInfo;
    
			}


</script>
</HEAD>
<BODY>
<FORM action="" method=post name=form>
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">彩铃功能暂停恢复</div>
	</div>
 <table cellspacing="0">
    <input type="hidden" name="opCode" value="<%=OpCode%>"> 
    <input type="hidden" name="loginAccept" value="<%=loginAccept%>">
    <input type="hidden" name="loginNo" value="<%=workno%>">
    <input type="hidden" name="loginPwd" value="<%=nopass%>">
    <input type="hidden" name="orgCode" value="<%=org_code%>">
    <input type="hidden" name="ip_Addr" value="<%=ip_Addr%>">     

<%
	if(nextFlag==1)
	{
	String ph_no = (String)request.getParameter("ph_no");
%>
		     <TR >   
		  	     <td class="blue">手机号码</td>                                 
              <td class="blue" >                     
               <input  type="text"  v_type="string"  v_must=1 v_minlength=1 v_maxlength=11 v_name="手机号码"  name="phone_no"  maxlength="11"  onkeydown="if(event.keyCode==13)doQuery()"  value ="<%=(activePhone!=null?activePhone:ph_no)%>" readOnly Class="InputGrey">
               <font class="orange">*</font>
               </td>

            </TR>
            
			<tr >
				<td class="blue" colspan="4" id="footer" >
					<div align="center">
					<input  name=sure22 type=button value="确定" onClick="doQuery();" style="cursor:hand" class="b_foot">
            		<input  name=reset22 type=reset value="清除" class="b_foot">
            		<input  name=close22 type=button value="关闭"  onClick="removeCurrentTab()"  class="b_foot">
					</div>
				</td>
			</tr>
<%
	}
%>
            <%
             if(nextFlag==2)//查询后结果
             {
            %> 
            		     <TR >   
		  	     <td class="blue">手机号码</td>                                 
              <td class="blue" >                     
               <input  type="text"  v_type="string"  v_must=1 v_minlength=1 v_maxlength=11 v_name="手机号码"  name="phone_no"  maxlength="11"  onkeydown="if(event.keyCode==13)doQuery()"  value ="<%=phone_no%>" readOnly Class="InputGrey">
               <font class="orange">*</font>
               </td>
							<td>&nbsp;</td>
							<td>&nbsp;</td>
            </TR>
            
                <tr> 

                  <td class="blue">客户ID</td>
                  <td class="blue"> 
                    <input type="text"  readOnly  name="cust_id" maxlength="6"   value="<%=sOutCustId%>">
                    <font class="orange">*</font>
                  </td>
                  <td class="blue">&nbsp;</td>
                  <td class="blue">&nbsp;</td>

                </tr>
                <tr> 
                  <td class="blue" width="13%">客户名称</td>
                  <td class="blue" width="35%"> 
                    <input type="text" readOnly  name="cust_name"  value="<%=sOutCustName%>" >
                    <input type="hidden" readOnly   Class="InputGrey" name="sOutCustAddress"  value="<%=sOutCustAddress%>">
                    <input type="hidden" readOnly   Class="InputGrey" name="sOutIdIccid"  value="<%=sOutIdIccid%>">
                    <font class="orange">*</font>
                  </td>
                  <td class="blue" width="13%">业务品牌 </td>
                  <td class="blue" width="35%"> 
                    <input type="hidden" readOnly   Class="InputGrey" name="sm_code"  value="<%=sOutSmCode%>">
                    <input type="text"   readOnly   Class="InputGrey" name="sm_name"  value="<%=sOutSmName%>">
                    <font class="orange">*</font>
                  </td>
                </tr>
                <tr> 
                  <td class="blue" width="13%">资费套餐</td>
                  <td class="blue" width="35%"> 
                    <input type="hidden" readOnly   Class="InputGrey" name="ProductCode" maxlength="5"  value="<%=sOutProductCode%>">
                    <input type="text"   readOnly   Class="InputGrey" name="ProductName" maxlength="5"      value="<%=sOutProductName%>">
                    <font class="orange">*</font>
                  </td>
                  <td class="blue" width="13%">运行状态</td>
                  <td class="blue" width="39%"> 
                    <input type="hidden" readOnly   Class="InputGrey" name="RunCode"  value="<%=sOutRunCode%>">
                    <input type="text"   readOnly   Class="InputGrey" name="RunName"  value="<%=sOutRunName%>">
                    <font class="orange">*</font>
                  </td>
                </tr>
               <tr> 
                  <td class="blue" width="13%">业务类型</td>
                  <td class="blue" width="35%"> 
                    <input type="hidden" readOnly   Class="InputGrey" name="CRColorType" maxlength="5"  value="<%=sOutCRColorType%>">
                    <input type="text"   readOnly   Class="InputGrey" name="CRColorTypeName" maxlength="5"      value="<%=sOutCRColorTypeName%>">
                    <font class="orange">*</font>
                  </td>
                  <td class="blue" width="13%">开户时间 </td>
                  <td class="blue" width="39%"> 
                    <input type="text" readOnly   Class="InputGrey"  name="CRBellBeginTime"  maxlength="20" value="<%=sOutCRBellBeginTime%>">
                    <font class="orange">*</font>
                  </td>
                </tr>
                  <tr> 
                  <td class="blue" width="13%">彩铃产品</td>
                  <td class="blue" width="35%"> 
                    <input type="hidden" readOnly   Class="InputGrey" name="UsingCRProdCode"  maxlength="20" value="<%=sOutUsingCRProdCode%>">
                    <input type="text" readOnly   Class="InputGrey"  name="UsingCRProdName"  maxlength="20" value="<%=sOutUsingCRProdName%>">
                    <font class="orange">*</font>
                  </td>
                  <td class="blue" width="13%">当前彩铃状态 </td>
                  <td class="blue" width="39%"> 
                    <input type="hidden" readOnly   Class="InputGrey" name="CRRunCode"  maxlength="20" value="<%=sOutCRRunCode%>">
                    <input type="text" readOnly   Class="InputGrey"  name="CRRunName"  maxlength="20" value="<%=sOutCRRunName%>">
                    <font class="orange">*</font>
                  </td>
                </tr>                
            <TR>
               <td class="blue" >操作类型</TD>
					       <td class="blue" >
									<SELECT name="OnOff"  id="OnOff" onChange="" onclick="">
									 <%if(sOutCRRunCode.equals("A")){%>	
										<option value="0" selected>暂停</option>
									<%}else{%>
										<option value="1" selected>恢复 </option>
									<%}%>	
									</SELECT>
									<font class="orange">*</font>
								</TD>
						<td class="blue">&nbsp;</TD>
            <td class="blue">&nbsp;</TD>      
             </TR>  
              <table  cellspacing="0">
                <tbody> 
                	
                <tr> 
                  <td class="blue" width=13%>备注</td>
                  <td class="blue" width="87%">
                    <input  readOnly   Class="InputGrey" name=sysNote value="手机号码<%=phone_no%>办理彩铃功能<%if(sOutCRRunCode.equals("A")){%>暂停<%}else{%>恢复<%}%>" size=60 maxlength="60">
                <input  name=opNote size=60 value="手机号码<%=phone_no%>办理彩铃功能<%if(sOutCRRunCode.equals("A")){%>暂停<%}else{%>恢复<%}%>" maxlength="60" type="hidden">
                  </td>
                </tr>

                
                </tbody> 
              </table>
              <table width="98%" border=0 align=center cellpadding="4" cellspacing=0>
                <tbody> 
                <tr > 
                  <td class="blue" align=center width="100%" id="footer"> 
                    <input  name=sure type="button" value=确认 onclick="refain()" class="b_foot">
                    &nbsp;
                    <input  name=clear type=reset value=上一步 onClick="history.go(-1);" class="b_foot">
                    &nbsp;
                    <input  name=reset type=button value=关闭  onClick="removeCurrentTab()"  class="b_foot">
                  </td>
                </tr>                
                </tbody> 
              </table>
              <p>&nbsp;</p>
				    <%
				    }//end   if(nextFlag==2)    
				   %>
    </table>
    <%if(nextFlag==2){%>
    	<%@ include file="/npage/include/footer.jsp" %>
    <%}else{%>
    	<%@ include file="/npage/include/footer_simple.jsp" %>
    <%}%>
</FORM>
</BODY>
</HTML>
<%
//密码小键盘公用文件
%>
<%@ include file="/npage/common/pwd_comm.jsp" %>
