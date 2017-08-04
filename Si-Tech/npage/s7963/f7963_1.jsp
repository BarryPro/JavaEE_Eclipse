<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% 
  /*
   * 功能: 彩铃秀取消7963
　 * 版本: v1.00
　 * 日期: 2008/03/24
　 * 作者: sunzx
　 * 版权: sitech
   * 修改历史
   * 修改日期2008-1-3   修改人leimd   修改目的
   *  
  */
%>
<%@ page contentType= "text/html;charset=gbk" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../include/remark1.htm" %>

<%
	String opCode="7963";
	String opName="彩铃秀取消";
	String phone_no = (String)request.getParameter("activePhone");
    String ip_Addr = (String)session.getAttribute("ipAddr");
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
    String power_right=(String)session.getAttribute("powerRight");
    String org_code = (String)session.getAttribute("orgCode");
    String nopass  = (String)session.getAttribute("password");
    int    nextFlag=1;
    String regionCode = (String)session.getAttribute("regCode");   
    String OpCode ="7963";
    String sInOpNote  ="号码信息初始化"; 

%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept"/>
<%	  
	
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
	String sOutCustAddress    ="";             //用户地址
    String sOutIdIccid        ="";             //证件号码
	  
	String action=request.getParameter("action");     

	if (action!=null&&action.equals("select"))
	{
	    phone_no = request.getParameter("phone_no");     
	    password = request.getParameter("password");
	    String Pwd1 = Encrypt.encrypt(password);      	//在此对用户传来的密码进行加密
	
//		SPubCallSvrImpl callView = new SPubCallSvrImpl();
		String paramsIn[] = new String[6];
		 	
		paramsIn[0]=workno;                                 //操作工号         
		paramsIn[1]=nopass;                                 //操作工号密码     
		paramsIn[2]=OpCode;                                 //操作代码         
		paramsIn[3]=sInOpNote;                              //操作描述         
		paramsIn[4]=phone_no;                               //用户手机号码     
		paramsIn[5]=Pwd1;                                   //用户密码         
		 	
//		ArrayList acceptList = new ArrayList();
				   
//		acceptList = callView.callFXService("s7963Init", paramsIn, "13");
//		callView.printRetValue();
%>
	<wtc:service name="s7963Init" routerKey="region" routerValue="<%=regionCode%>" outnum="13" retcode="retCode" retmsg="retMsg">
		<wtc:param value="<%=paramsIn[0]%>"/>
		<wtc:param value="<%=paramsIn[1]%>"/>
		<wtc:param value="<%=paramsIn[2]%>"/>
		<wtc:param value="<%=paramsIn[3]%>"/>
		<wtc:param value="<%=paramsIn[4]%>"/>
		<wtc:param value="<%=paramsIn[5]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%			
		String errCode = retCode;
		String errMsg = retMsg;
      
		if(!(errCode.equals("000000")||errCode.equals("0")))
		{
%>        
			<script language='jscript'>
				rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
				history.go(-1);
			</script> 
<%  
		}					
		if(errCode.equals("000000")||errCode.equals("0"))
		{
			nextFlag = 2;				
/*			String result2  [][]	= (String[][])acceptList.get(0);
			String result3  [][]  = (String[][])acceptList.get(1);
			String result4  [][]	= (String[][])acceptList.get(2);
			String result5  [][]	= (String[][])acceptList.get(3);
			String result6  [][]	= (String[][])acceptList.get(4);
			String result7  [][]	= (String[][])acceptList.get(5);
			String result8  [][]	= (String[][])acceptList.get(6);
			String result9  [][]	= (String[][])acceptList.get(7);
			String result10 [][]	= (String[][])acceptList.get(8);
			String result11 [][]  = (String[][])acceptList.get(9);
			String result12 [][]	= (String[][])acceptList.get(10);
			String result13 [][]  = (String[][])acceptList.get(11);
			String result14 [][]	= (String[][])acceptList.get(12);
	*/		
			sOutCustId          =result  [0][0];           
			sOutCustName        =result  [0][1];           
			sOutSmCode          =result  [0][2];           
			sOutSmName          =result  [0][3];           
			sOutProductCode     =result  [0][4];           
			sOutProductName     =result  [0][5];           
			sOutPrePay          =result  [0][6].trim();           
			sOutRunCode         =result  [0][7];           
			sOutRunName         =result  [0][8];           
			sOutUsingCRProdCode =result  [0][9];           
			sOutUsingCRProdName =result  [0][10];   
			sOutCustAddress     =result  [0][11];            // 用户地址
			sOutIdIccid         =result  [0][12];            // 证件号码        				       
		}  
	}    
%>
        
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>黑龙江BOSS-彩铃秀取消</TITLE>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<script language="JavaScript" src="/npage/s1300/common_1300.js"></script>

<script language="JavaScript">
	 var js_pwFlag="false";
 
onload=function()
{
}

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
		document.all("mebProdCode").options[j].value=triListData[j][1];
	  }
	  document.all("mebProdCode").options[0].selected=true; 
  }  
}
		
//确认提交
function refain()
{ 	
	getAfterPrompt();
	document.all.sysNote.value = "手机["+(document.all.phone_no.value).trim()+"]取消彩铃秀业务";
	if((document.all.opNote.value).trim().length==0)
	{
      document.all.opNote.value="<%=workno%>[<%=workname%>]"+"对手机["+(document.all.phone_no.value).trim()+"]进行彩铃秀业务取消";
	} 
    showPrtDlg("Detail","确实要打印电子免填单吗？","Yes");
	if (rdShowConfirmDialog("是否提交确认操作？")==1){
		document.form.action="f7963_2.jsp";
	    document.form.submit();
	    return true;
	}   
}
//输入手机号和密码，查询具体信息

function doQuery()
	{	
	/*	if(!check(form)) return false; 
		
		if(js_pwFlag=="false")
	  {
	   if(jtrim(document.all.password.value).length==0)
	   {
	     rdShowMessageDialog("用户密码不能为空！");
		   document.all.password.focus();
 	     return false;
	   }
	  }*/	
		document.form.action = "f7963_1.jsp?action=select";
		document.form.submit();
		//document.form.phone.visible=false; 
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
    var path = "<%=request.getContextPath()%>/page/s7963/fpubprod_sel.jsp";
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
		
			if(mebMonthFlag=="1"){
				tbs2.style.display="none";
				tbs3.style.display="none";
			}else{
				tbs2.style.display="";
				tbs3.style.display="";	
				document.form.matureFlag.value="N";
				document.form.matureProdCode.value="";
				document.form.matureProdCode.disabled=true;		
			}	
}
//根据产品类型进行产品变更
function tochange()
{  
	  document.all.sysNote.value="";
	  document.all.opNote.value="";
		var mebMonthFlag = document.form.mebMonthFlag.value;
		var mode_type="";
		if(mebMonthFlag=="1")
		{
			mode_type="CR01";
		}else if(mebMonthFlag=="2"){
			mode_type= "CR02";
		}else{
		 mode_type= "CR03";
		}
		var sqlStr = "select mode_code,mode_code||'->'||mode_name from sbillmodecode where mode_code like 'CR%' and start_time<sysdate  and stop_time>sysdate  and power_right<=" + "<%=power_right%>" + " and mode_status='Y' and region_code='" + "<%=regionCode%>" + "' and mode_type='"+mode_type+"'";	
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
	var h=180;
	var w=350;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	
    var pType="subprint";             				 		//打印类型：print 打印 subprint 合并打印
	var billType="1";              				 			//票价类型：1电子免填单、2发票、3收据
	var sysAccept =<%=loginAccept%>;             			//流水号
	var printStr = printInfo(printType);			 		//调用printinfo()返回的打印内容
	var mode_code=null;           							//资费代码
	var fav_code=null;                				 		//特服代码
	var area_code=null;             				 		//小区代码
	var opCode="7963" ;                   			 		//操作代码
	var phoneNo="<%=phone_no%>";                  	 		//客户电话
	if(printStr == "failed")
		{    return false;   }
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
    path+="&mode_code="+mode_code+
			"&fav_code="+fav_code+"&area_code="+area_code+
			"&opCode=<%=opCode%>&sysAccept="+<%=loginAccept%>+
			"&phoneNo="+document.form.phone_no.value+
			"&submitCfm="+submitCfm+"&pType="+
			pType+"&billType="+billType+ "&printInfo=" + printStr;
     var ret=window.showModalDialog(path,printStr,prop);
      return ret;
}
			
function printInfo(printType) { 
	var istime="当日";
	var isyear="彩铃秀业务取消";
	var cust_info="";  				//客户信息
	var opr_info="";   				//操作信息
	var note_info1=""; 				//备注1
	var note_info2=""; 				//备注2
	var note_info3=""; 				//备注3
	var note_info4=""; 				//备注4
	var retInfo = "";
	opr_info+='<%=workno%>'+"|";
	opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="手机号码："+document.all.phone_no.value+"|";
	cust_info+="客户姓名："+'<%=sOutCustName%>'+"|";
	cust_info+="证件号码："+document.all.sOutIdIccid.value+"|";
	cust_info+="客户地址："+document.all.sOutCustAddress.value+"|";
	opr_info+="业务品牌："+document.all.sm_name.value+"|";
	opr_info+="办理业务："+isyear+"|";
	opr_info+="操作流水："+'<%=loginAccept%>'+"|";
	opr_info+="操作时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	opr_info+="业务生效时间："+istime+"|";

	retInfo=cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
	return retInfo;	
				
}


</script>
</HEAD>
<BODY>
<FORM action="" method=post name=form>
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">彩铃秀取消</div>
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
%>
	<tr>   
		<td class="blue">手机号码</td>                                 
		<td>                     
			<input class="InputGrey" type="text"  v_type="mobphone"  v_must=1 v_minlength=1 v_maxlength=11 value="<%=phone_no%>" name="phone_no"  maxlength="11"  onkeydown="if(event.keyCode==13)doQuery()" <%if(nextFlag==2){out.print("readonly");}%> readOnly>
			<font color="orange">*</font>
		</td>
	</tr>

	<tr>
		<td colspan="4" align="center" id="footer">
			<input class="b_foot" name=sure22 type=button value="确定" onClick="doQuery();" style="cursor:hand">

			<input class="b_foot" name=close22 type=button value="关闭" onclick="removeCurrentTab()">
		</td>
	</tr>
<%
	}
%>
            <%
             if(nextFlag==2)//查询后结果
             {
            %> 
	<tr style="display:none">  
		<td class="blue">手机号码</td>                                 
		<td>                     
			<input class="InputGrey" type="text"  v_type="mobphone"  v_must=1 v_minlength=1 v_maxlength=11 value="<%=phone_no%>" name="phone_no"  maxlength="11"  onkeydown="if(event.keyCode==13)doQuery()" <%if(nextFlag==2){out.print("readonly");}%> readOnly>
			<font color="orange">*</font>
		</td>              
		<td class="blue">客户ID</td>
		<td> 
			<input type="text" name="cust_id" maxlength="6" class="button" value="<%=sOutCustId%>">
			<font color="orange">*</font>
		</td>
	</tr>
	<tr> 
		<td class="blue">客户名称</td>
		<td> 
			<input type="text" name="cust_name" class="InputGrey" value="<%=sOutCustName%>" <%if(nextFlag==2){out.print("readonly");}%> >
			<input type="hidden" readonly name="sOutCustAddress" class="InputGrey" value="<%=sOutCustAddress%>">
			<input type="hidden" readonly name="sOutIdIccid" class="InputGrey" value="<%=sOutIdIccid%>">
			<font color="orange">*</font>
		</td>
		<td class="blue">可用预存</td>
		<td>
			<input type="text" readonly name="PrePay" class="InputGrey" value="<%=sOutPrePay%>" <%if(nextFlag==2){out.print("readonly");}%>>
			<font color="orange">*</font>
		</td>
	</tr>
	<tr> 
		<td class="blue">业务品牌</td>
		<td> 
			<input type="hidden" readonly name="sm_code" class="InputGrey" value="<%=sOutSmCode%>">
			<input type="text"   readonly name="sm_name" class="InputGrey" value="<%=sOutSmName%>" <%if(nextFlag==2){out.print("readonly");}%>>
			<font color="orange">*</font>
		</td>
		<td class="blue">运行状态</td>
		<td> 
			<input type="hidden" readonly name="RunCode" class="InputGrey" value="<%=sOutRunCode%>">
			<input type="text"   readonly name="RunName" class="InputGrey" value="<%=sOutRunName%>" <%if(nextFlag==2){out.print("readonly");}%>>
			<font color="orange">*</font>
		</td>
	</tr>
	<tr> 
		<td class="blue">资费套餐</td>
		<td> 
			<input type="hidden" readonly name="ProductCode" maxlength="5" class="InputGrey" value="<%=sOutProductCode%>">
			<input type="text"   readonly name="ProductName" maxlength="5" class="InputGrey" value="<%=sOutProductName%>" <%if(nextFlag==2){out.print("readonly");}%>>
			<font color="orange">*</font>
		</td>
		<td class="blue">已订购彩铃产品 </td>
		<td> 
			<input type="hidden" readonly name="UsingCRProdCode" class="InputGrey" maxlength="20" value="<%=sOutUsingCRProdCode%>">
			<input type="text" readonly  name="UsingCRProdName" class="InputGrey" maxlength="20" value="<%=sOutUsingCRProdName%>" <%if(nextFlag==2){out.print("readonly");}%>>
		</td>
	</tr>
	  <tr bgcolor="F5F5F5" style="display:none"> 
                  <td width=13%>系统备注</td>
                  <td width="87%" colspan="3">
                    <input class="button" readonly name=sysNote value="" size=60 maxlength="60">
                  </td>
                </tr>
	<tr> 
		<td class="blue">备注</td>
		<td colspan="3"> 
			<input class="InputGrey" readOnly name=opNote size=60 value="" maxlength="60">
		</td>
	</tr>
	<tr> 
		<td align="center" id="footer" colspan="4"> 
			<input class="b_foot" name=sure type="button" value=确认 onclick="refain()">
			&nbsp;
			<input class="b_foot" name=clear type=reset value=上一步 onClick="history.go(-1);">
			&nbsp;
			<input class="b_foot" name=reset type=button value=关闭 onClick="removeCurrentTab()">
		</td>
	</tr>                
</table>
 <%@ include file="/npage/include/footer.jsp" %>
				    <%
				    }//end   if(nextFlag==2)    
				   %>
    <%@ include file="/npage/include/footer_simple.jsp" %>
</FORM>
</BODY>
</HTML>
<%
//密码小键盘公用文件
%>
