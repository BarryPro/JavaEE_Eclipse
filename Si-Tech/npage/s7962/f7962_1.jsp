<%
/********************
version v2.0
开发商: si-tech
update:anln@2009-02-23 页面改造,修改样式
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../include/remark1.htm" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<%
	String opCode = (String)request.getParameter("opCode");
	String OpCode =opCode;
	String opName = (String)request.getParameter("opName");	
	
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String workno = (String)session.getAttribute("workNo");
	String workname = (String)session.getAttribute("workName");
	
	String org_code =(String)session.getAttribute("orgCode");
	String nopass  = (String)session.getAttribute("password");
	int    nextFlag=1;
	String regionCode = (String)session.getAttribute("regCode");
    
    	String sqlStr1="";
    	
    	//String[][] retListString1 = null;
	//获取从上页得到的信息
    	String loginAccept = request.getParameter("login_accept");
    	String loginAcceptOld="";    
    
    	//ArrayList retList1 = new ArrayList();  
	if(loginAccept == null)
	{           
		//获取系统流水
		/*sqlStr1 ="SELECT sMaxSysAccept.nextval FROM dual";
		retList1 = impl.sPubSelect("1",sqlStr1,"region",regionCode);
		retListString1 = (String[][])retList1.get(0);
		loginAccept=retListString1[0][0];*/		
		loginAccept = getMaxAccept();
	}

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
	String sOutCustAddress    ="";             //用户地址
	String sOutIdIccid        ="";             //证件号码
      
    	String action=request.getParameter("action");     

    if (action!=null&&action.equals("select"))
    {
        phone_no = request.getParameter("phone_no");    
        loginAcceptOld = request.getParameter("loginAcceptOld");
         
        //SPubCallSvrImpl callView = new SPubCallSvrImpl();
        String paramsIn[] = new String[6];

        paramsIn[0]=workno;                                 //操作工号
        paramsIn[1]=nopass;                                 //操作工号密码
        paramsIn[2]=OpCode;                                 //操作代码
        paramsIn[3]=phone_no;                               //用户手机号码
        paramsIn[4]=loginAcceptOld;                         //冲正流水
	if(activePhone==null){
		activePhone=phone_no;
	}
        ArrayList acceptList = new ArrayList();

       // acceptList = callView.callFXService("s7962Init", paramsIn, "13");
     
 %> 	
	<wtc:service name="s7962Init" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="13" >
		<wtc:param value="<%=paramsIn[0]%>"/>
		<wtc:param value="<%=paramsIn[1]%>"/>
		<wtc:param value="<%=paramsIn[2]%>"/>
		<wtc:param value="<%=paramsIn[3]%>"/>
		<wtc:param value="<%=paramsIn[4]%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
 <%     

        String errCode = retCode1;
        String errMsg = retMsg1;

        if(!errCode.equals("000000"))
        {
%>
            <script language="javascript">
                rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
                history.go(-1);
            </script> 
<%
        }                   
        if(errCode.equals("000000"))
        {
            nextFlag = 2;               
           /* String result2  [][] = (String[][])acceptList.get(0);
            String result3  [][] = (String[][])acceptList.get(1);
            String result4  [][] = (String[][])acceptList.get(2);
            String result5  [][] = (String[][])acceptList.get(3);
            String result6  [][] = (String[][])acceptList.get(4);
            String result7  [][] = (String[][])acceptList.get(5);
            String result8  [][] = (String[][])acceptList.get(6);
            String result9  [][] = (String[][])acceptList.get(7);
            String result10 [][] = (String[][])acceptList.get(8);
            String result11 [][] = (String[][])acceptList.get(9);
            String result12 [][] = (String[][])acceptList.get(10);
            String result13 [][] = (String[][])acceptList.get(11);
            String result14 [][] = (String[][])acceptList.get(12);*/
            
            sOutCustId          =result[0][0];           
            sOutCustName        =result[0][1];           
            sOutSmCode          =result[0][2];           
            sOutSmName          =result[0][3];           
            sOutProductCode     =result[0][4];           
            sOutProductName     =result[0][5];           
            sOutPrePay          =result[0][6].trim();           
            sOutRunCode         =result[0][7];           
            sOutRunName         =result[0][8];           
            sOutUsingCRProdCode =result[0][9];           
            sOutUsingCRProdName =result[0][10];   
            sOutCustAddress     =result[0][11];            // 用户地址
            sOutIdIccid         =result[0][12];            // 证件号码                            
        }  
    }    
%>
        
<HTML>
<HEAD>
<TITLE>黑龙江BOSS-彩铃秀冲正</TITLE>
<script language="JavaScript" src="/npage/s1300/common_1300.js"></script>
<script language="JavaScript"> 
onload=function()
{    
}
//确认提交
function refain()
{   
	getAfterPrompt();
	document.all.sysNote.value = "手机["+document.all.phone_no.value.trim()+"]冲正彩铃秀业务";
	if((document.all.opNote.value.trim()).length==0)
	{
		document.all.opNote.value="<%=workno%>[<%=workname%>]"+"对手机["+document.all.phone_no.value.trim()+"]进行彩铃秀业务冲正";
	} 
	showPrtDlg("Detail","确实要打印电子免填单吗？","Yes");
	if (rdShowConfirmDialog("是否提交确认操作？")==1){
		document.form.action="f7962_2.jsp";
		document.form.submit();
		return true;
	}   
}
//输入手机号和密码，查询具体信息
function doQuery()
{   
	if(!check(form)) 
		return false;  
	document.form.action = "f7962_1.jsp?action=select";
	document.form.submit();
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  	
	//显示打印对话框
	//显示打印对话框 		
	var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
	var billType="1";                      //  票价类型1电子免填单、2发票、3收据
	var sysAccept ="<%=loginAccept%>";                       // 流水号
	var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
	var mode_code=null;                        //资费代码
	var fav_code=null;                         //特服代码
	var area_code=null;                    //小区代码
	var opCode =   "<%=opCode%>";                         //操作代码
	var phoneNo = "<%=phone_no%>";                           //客户电话		
	var h=162;
	var w=352;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
	var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);    	
}
            
function printInfo(printType) 
{ 
	var istime="当日";
	var isyear="彩铃秀业务冲正";

	var cust_info=""; //客户信息
	var opr_info=""; //操作信息
	var retInfo = "";  //打印内容
	var note_info1=""; //备注1
	var note_info2=""; //备注2
	var note_info3=""; //备注3
	var note_info4=""; //备注4 
	
	cust_info+="客户姓名：   "+'<%=sOutCustName%>'+"|";
	cust_info+="手机号码：   "+document.all.phone_no.value+"|";
	cust_info+="客户地址：   "+document.all.sOutCustAddress.value+"|";
	cust_info+="证件号码：   "+document.all.sOutIdIccid.value+"|";
	
	opr_info+="业务品牌："+document.all.sm_name.value+"|";
	opr_info+="办理业务："+isyear+"|";
	opr_info+="操作流水:"+'<%=loginAccept%>'+"|";
	opr_info+="操作时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	opr_info+="业务生效时间："+istime+"|";
		
	retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式
	return retInfo;	
}

</script>
</HEAD>
<BODY>
<FORM action="" method=post name=form>
	<%@ include file="/npage/include/header.jsp" %>  
	<div class="title">
			<div id="title_zi">个人彩铃秀冲正</div>
	</div> 
	
	<input type="hidden" name="opCode" value="<%=OpCode%>"> 
	<input type="hidden" name="opName" value="<%=opName%>"> 
	<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
	<input type="hidden" name="loginNo" value="<%=workno%>">
	<input type="hidden" name="loginPwd" value="<%=nopass%>">
	<input type="hidden" name="orgCode" value="<%=org_code%>">
	<input type="hidden" name="ip_Addr" value="<%=ip_Addr%>"> 

    <table  cellspacing="0">
	<TR>   
		<td class="blue" width="13%">手机号码</td>                                 
		<td width="35%">                     
			<input  type="text"  v_type="mobphone" value =<%=activePhone%>  readonly class="InputGrey"  v_must=1 v_minlength=1 v_maxlength=11 name="phone_no"  maxlength="11"  onkeydown="if(event.keyCode==13)doQuery()" <%if(nextFlag==2){out.print("readonly");}%>>
			<font class="orange">*</font>	
		</td>
		<TD class="blue" width="13%">冲正流水</TD>
		<TD width="39%">
			<input type="text"  name="loginAcceptOld"  v_type="string" v_must=1 value="<%=loginAcceptOld%>"  <%if(nextFlag==2){out.print("readonly ");out.print("class='InputGrey'");}%>>
			<font class="orange">*</font>
		</TD>
	</TR>
	</table>
<%
	if(nextFlag==1)
	{
%>
	<table  cellspacing="0">         
		<tr>
			<td id="footer"	>		
				<input  name=sure22 type=button class="b_foot" value="确定" onClick="doQuery();" style="cursor:hand">
				<input  name=reset22 type=reset class="b_foot" value="清除">
				<input  name=close22 type=button class="b_foot" value="关闭" onclick="removeCurrentTab()">			
			</td>
		</tr>
	</table>
<%
	}
%>
            
<%
    if(nextFlag==2)//查询后结果
    {
%> 
	<table  cellspacing="0">        
		<tr style="display:none">                
			<td class="blue">客户ID</td>
			<td> 
				<input type="text" name="cust_id" maxlength="6"   value="<%=sOutCustId%>">
				<font class="orange">*</font>
			</td>
		</tr>
		<tr> 
			<td width="13%" class="blue">客户名称</td>
			<td width="35%"> 
				<input type="text" name="cust_name" class="InputGrey" value="<%=sOutCustName%>" <%if(nextFlag==2){out.print("readonly");}%> >
				<input type="hidden" readonly class="InputGrey" name="sOutCustAddress"  value="<%=sOutCustAddress%>">
				<input type="hidden" readonly class="InputGrey" name="sOutIdIccid"  value="<%=sOutIdIccid%>">
				<font class="orange">*</font>
			</td>
			<td width="13%" class="blue">可用预存</td>
			<td width="39%">
				<input type="text" readonly class="InputGrey" name="PrePay"  value="<%=sOutPrePay%>" <%if(nextFlag==2){out.print("readonly");}%>>
				<font class="orange">*</font>
			</td>
		</tr>
		<tr> 
			<td width="13%" class="blue">业务品牌</td>
			<td width="35%"> 
				<input type="hidden" readonly class="InputGrey" name="sm_code"  value="<%=sOutSmCode%>">
				<input type="text"   readonly class="InputGrey" name="sm_name"  value="<%=sOutSmName%>" <%if(nextFlag==2){out.print("readonly");}%>>
				<font class="orange">*</font>
			</td>
			<td width="13%" class="blue">运行状态</td>
			<td width="39%"> 
				<input type="hidden" readonly class="InputGrey" name="RunCode"  value="<%=sOutRunCode%>">
				<input type="text"   readonly class="InputGrey" name="RunName"  value="<%=sOutRunName%>" <%if(nextFlag==2){out.print("readonly");}%>>
				<font class="orange">*</font>
			</td>
		</tr>
		<tr> 
			<td width="13%" class="blue">资费套餐</td>
			<td width="35%"> 
				<input type="hidden" readonly name="ProductCode" maxlength="5"  value="<%=sOutProductCode%>">
				<input type="text"   readonly class="InputGrey" name="ProductName" maxlength="5"      value="<%=sOutProductName%>" <%if(nextFlag==2){out.print("readonly");}%>>
				<font class="orange">*</font>
			</td>
			<td width="13%" class="blue">已订购彩铃产品</td>
			<td width="39%"> 
				<input type="hidden" readonly class="InputGrey" name="UsingCRProdCode"  maxlength="20" value="<%=sOutUsingCRProdCode%>">
				<input type="text" readonly class="InputGrey"  name="UsingCRProdName"  maxlength="20" value="<%=sOutUsingCRProdName%>" <%if(nextFlag==2){out.print("readonly");}%>>
			</td>
		</tr>
	</table>
	<table  cellspacing=0 >
		<tbody> 
			<tr> 
				<td width=13% class="blue">系统备注</td>
				<td width="87%">
					<input  readonly class="InputGrey" name=sysNote value="" size=60 maxlength="60">
				</td>
			</tr>         
		</tbody> 
	</table>
	<table  cellspacing=0>
		<tbody> 
			<tr> 
				<td id="footer"> 
					<input  name=sure class="b_foot" type="button" value=确认 onclick="refain()">
					&nbsp;
					<input  name=clear class="b_foot" type=reset value=上一步 onClick="javaScript:history.go(-1)">
					&nbsp;
					<input  name=reset class="b_foot" type=button value=关闭 onClick="removeCurrentTab()">
				</td>
			</tr>                
		</tbody> 
	</table>	
          <input  type="hidden" name=opNote size=60 value="" maxlength="60">
      <%@ include file="/npage/include/footer.jsp" %>        
<%
    }
%>
   
     <%@ include file="/npage/include/footer_simple.jsp" %>   
</FORM>
</BODY>
</HTML>

