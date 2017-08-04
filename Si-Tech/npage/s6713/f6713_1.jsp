<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% 
  /*
   * 功能: 个人彩铃申请冲正
　 * 版本: v1.00
　 * 日期: 2007/09/13
　 * 作者: liubo
　 * 版权: sitech
   * 修改历史
   * 修改日期 200-01-08     修改人 leimd     修改目的
   *  
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="../../include/remark1.htm" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%
	String opCode="6713";
	String opName="个人彩铃申请/变更冲正";
	String  phone_no=(String)request.getParameter("activePhone"); 
    String ip_Addr = (String)session.getAttribute("ipAddr");			//Ip地址
    String workno = (String)session.getAttribute("workNo");				//操作工号
    String workname = (String)session.getAttribute("workName");			//工号名
    String org_code = (String)session.getAttribute("orgCode");			//归属代码
    String nopass  = (String)session.getAttribute("password");			//操作工号密码
    String regionCode=(String)session.getAttribute("regCode");			//地市代码
    int nextFlag=1;
//	SPubCallSvrImpl impl = new SPubCallSvrImpl();
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="loginAccept"/>
<%		
	String loginAcceptOld="";			//原操作流水		
	String OpCode = "6713"  ;
	String sInOpNote="个人彩铃申请冲正初始化";
	String sOutPhoneNo    ="";         //用户手机号码      
	String sOutLoginAccept="";         //待冲正流水号      
	String sOutCustId     ="";         //客户ID_NO         
	String sOutCustName   ="";         //客户姓名          
	String sOutSmCode     ="";         //服务品牌代码      
	String sOutSmName     ="";         //服务品牌名称      
	String sOutProductCode="";         //主产品代码        
	String sOutProductName="";         //主产品名称        
	String sOutCRProdCode1="";         //在用彩铃产品      
	String sOutCRProdName1="";         //在用彩铃产品名称  
	String sOutCRProdCode2="";         //预约彩铃产品      
	String sOutCRProdName2="";         //预约彩铃产品名称  
	String sOutLoginNo    ="";         //操作工号          
	String sOutLoginName  ="";         //操作员姓名        
	String sOutLoginTime  ="";         //操作时间          
	String sOutOpNote     ="";         //原系统备注        
	String sOutSystemNote ="";         //原操作备注   
	String sOutCustAddress ="";     //用户地址
    String sOutIdIccid     ="";     //证件号码    
	   
	String action=request.getParameter("action");   

	if (action!=null&&action.equals("select"))
	{
	    phone_no = request.getParameter("phone_no");     
	    loginAcceptOld = request.getParameter("loginAcceptOld");
	   	    
//	    SPubCallSvrImpl callView = new SPubCallSvrImpl();
		String paramsIn[] = new String[6];
		paramsIn[0]=workno;             //操作工号         
		paramsIn[1]=nopass;             //操作工号密码     
		paramsIn[2]=OpCode;             //操作代码         
		paramsIn[3]=sInOpNote;          //操作描述         
		paramsIn[4]=phone_no;           //用户手机号码     
		paramsIn[5]=loginAcceptOld;     //操作流水
					 	
//		ArrayList acceptList = new ArrayList();
//		acceptList = callView.callFXService("s6713Init", paramsIn, "19");
%>
	<wtc:service name="s6713Init" routerKey="region" routerValue="<%=regionCode%>" outnum="19" retcode="retCode" retmsg="retMsg">
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
	/*				
			String result2 [][] = (String[][])acceptList.get(0);
			String result3 [][] = (String[][])acceptList.get(1);
			String result4 [][] = (String[][])acceptList.get(2);
			String result5 [][]	= (String[][])acceptList.get(3);
			String result6 [][]	= (String[][])acceptList.get(4);
			String result7 [][]	= (String[][])acceptList.get(5);
			String result8 [][]	= (String[][])acceptList.get(6);
			String result9 [][]	= (String[][])acceptList.get(7);
			String result10[][]	= (String[][])acceptList.get(8);
			String result11[][] = (String[][])acceptList.get(9);
			String result12[][]	= (String[][])acceptList.get(10);
			String result13[][]	= (String[][])acceptList.get(11);
			String result14[][]	= (String[][])acceptList.get(12);
			String result15[][]	= (String[][])acceptList.get(13);
			String result16[][]	= (String[][])acceptList.get(14);
			String result17[][] = (String[][])acceptList.get(15);
			String result18[][]	= (String[][])acceptList.get(16);
			String result19[][] = (String[][])acceptList.get(17);
			String result20[][]	= (String[][])acceptList.get(18);
		*/					
			sOutPhoneNo      =result [0][0];
			sOutLoginAccept  =result [0][1];
			sOutCustId       =result [0][2];
			sOutCustName     =result [0][3];
			sOutSmCode       =result [0][4];
			sOutSmName       =result [0][5];
			sOutProductCode  =result [0][6];
			sOutProductName  =result [0][7];
			sOutCRProdCode1  =result[0][8];
			sOutCRProdName1  =result[0][9];
			sOutCRProdCode2  =result[0][10];
			sOutCRProdName2  =result[0][11];
			sOutLoginNo      =result[0][12];
			sOutLoginName    =result[0][13];
			sOutLoginTime    =result[0][14];
			sOutOpNote       =result[0][15];
			sOutSystemNote   =result[0][16]; 
			sOutCustAddress  =result[0][17];            // 用户地址
			sOutIdIccid      =result[0][18];            // 证件号码  
		}  
	}    
%>      
        
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD><TITLE>黑龙江BOSS-个人彩铃申请/变更冲正</TITLE>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
        
<script language="JavaScript">
//确认提交
function refain()
{
	getAfterPrompt();
	showPrtDlg("Detail","确实要打印电子免填单吗？","Yes");
	if (rdShowConfirmDialog("是否提交确认操作？")==1){
		document.form.action="f6713_2.jsp";
		document.form.submit();
		return true;
	}
  
}
//输入手机号和密码，查询具体信息
function doQuery()
{	
	if(document.form.loginAcceptOld.value=="")
	{
		rdShowMessageDialog("申请操作流水不能为空！",0);
		return false;
	}

	if(document.form.loginAcceptOld.value.length<11)
	{
		rdShowMessageDialog("操作流水不能小于11位！",0);
		return false;
	}
	
	document.form.action = "f6713_1.jsp?action=select&activePhone=<%=phone_no%>";
	document.form.submit(); 
}
	

function showPrtDlg(printType,DlgMessage,submitCfm)  //显示打印对话框
{	
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
	var opCode="6713" ;                   			 		//操作代码
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
			
function printInfo(printType) 
{
	var cust_info="";  				//客户信息
	var opr_info="";   				//操作信息
	var note_info1=""; 				//备注1
	var note_info2=""; 				//备注2
	var note_info3=""; 				//备注3
	var note_info4=""; 				//备注4
	var retInfo = "";  				//打印内容
	
	opr_info+='<%=workname%>'+"|";
	opr_info+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	cust_info+="手机号码："+document.all.phone_no.value+"|";
	cust_info+="客户姓名："+document.all.cust_name.value+"|";
	cust_info+="证件号码："+document.all.sOutIdIccid.value+"|";
	cust_info+="客户地址："+document.all.sOutCustAddress.value+"|";
	opr_info+="业务品牌:"+document.all.sm_name.value+"|";
	opr_info+="办理业务:"+"彩铃业务冲正"+"|";
	opr_info+="操作流水:"+'<%=loginAccept%>'+"|";
	opr_info+="操作时间:"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	opr_info+="生效时间:"+"当日"+"|";

	retInfo+=document.all.simBell.value+"|";
	retInfo=strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    return retInfo;	
}
</script>
</HEAD>
<BODY>
<FORM action="s1310_2.jsp" method=post name=form>
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">个人彩铃申请/变更冲正</div>
	</div>
<table cellspacing="0">
	    <input type="hidden" name="opCode" value="<%=OpCode%>"> 
	    <input type="hidden" name="loginNo" value="<%=workno%>">
	    <input type="hidden" name="loginPwd" value="<%=nopass%>">
	    <input type="hidden" name="orgCode" value="<%=org_code%>">
	    <input type="hidden" name="loginAccept" value="<%=loginAccept%>">
	    <input type="hidden" name="ip_Addr" value="<%=ip_Addr%>">     	 	          
	<TR>   		  	      
		<td class="blue" width="15%">服务号码</td>                                 
		<td width="35%">                     
			<input class="InputGrey" readOnly type="text" v_type="string" v_must=1 v_minlength=1 v_maxlength=11 name="phone_no" value="<%=phone_no%>" maxlength="11"  onkeydown="if(event.keyCode==13)doQuery()" <%if(nextFlag==2){out.print("readonly");}%>>
		</td>
		<td class="blue" width="15%">操作流水</td>  
		<td width="35%">                     
			<input <%if(nextFlag==2){%> class="InputGrey"<%} %> type="text" v_type="string" v_must=1 v_minlength=1 v_maxlength=11 name="loginAcceptOld" value="<%=sOutLoginAccept%>" maxlength="14" <%if(nextFlag==2){out.print("readonly");}%>>
			
		</td>
	</TR>
<%
	if(nextFlag==1)
	{
%>
	
	<tr>
		<td colspan="4" align="center">
			<input class="b_foot" name=sure22 type=button value="确定" onClick="doQuery();" style="cursor:hand">
			<input class="b_foot" name=reset22 type=reset value="清除">
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
	<tr> 
		<td class="blue">客户名称</td>
		<td> 
			<input type="text" name="cust_name" class="InputGrey" readOnly value="<%=sOutCustName%>" >
			
		</td>
		<td class="blue">客户ID</td>
		<td> 
			<input type="text" name="cust_id" maxlength="6" class="InputGrey" readOnly value="<%=sOutCustId%>">
			<input type="hidden" readonly name="sOutCustAddress" class="InputGrey" value="<%=sOutCustAddress%>">
			<input type="hidden" readonly name="sOutIdIccid" class="InputGrey" value="<%=sOutIdIccid%>">
		</td>
	</tr>
	<tr> 
	<td class="blue">业务品牌</td>
	<td> 
		<input type="hidden" readonly name="sm_code" class="InputGrey" value="<%=sOutSmCode%>">
		<input type="text"   readonly name="sm_name" class="InputGrey" value="<%=sOutSmName%>">
		
	</td>
	<td class="blue">原彩铃产品</td>
	<td> 
		<input type="hidden" readonly name="CRProdCode1" class="InputGrey" value="<%=sOutCRProdCode1%>">
		<input type="text"   readonly name="CRProdName1" class="InputGrey" value="<%=sOutCRProdName1%>">
	</td>
	</tr>
	<tr> 
		<td class="blue">资费套餐</td>
		<td> 
			<input type="hidden" readonly name="ProductCode" maxlength="5" class="InputGrey" value="<%=sOutProductCode%>">
			<input type="text"   readonly name="ProductName" size="30" class="InputGrey" value="<%=sOutProductName%>">
		</td>
		<td class="blue">预约彩铃产品 </td>
		<td> 
			<input type="hidden" readonly name="CRProdCode2" class="InputGrey" maxlength="20" value="<%=sOutCRProdCode2%>">
			<input type="text" readonly  name="CRProdName2" class="InputGrey" maxlength="20" value="<%=sOutCRProdName2%>">
			
		</td>
	</tr> 
	<tr> 
	<td class="blue">原系统备注</td>
	<td> 
		<input type="text" readonly name="sOutSystemNote" maxlength="8" class="InputGrey" value="<%=sOutSystemNote%>" size="40">
	</td>
	<td class="blue">原用户备注 </td>
	<td> 
		<input type="text" readonly name="sOutOpNote" class="InputGrey" maxlength="20" value="<%=sOutOpNote%>" size="45">
	</td>
	</tr> 
            
	<tr> 
		<td class="blue">系统备注</td>
		<td colspan="3">
			<input class="InputGrey" readonly name=sysNote size=60 maxlength="60" value="员工<%=workno%>对流水<%=sOutLoginAccept%>业务冲正">
		</td>
		</tr>
	<tr> 
		<td class="blue">用户备注</td>
		<td colspan="3"> 
			<input class="InputGrey" readonly name=opNote size=60 maxlength="60" value="个人彩铃<%if(sOutCRProdCode2.equals("")){%>申请<%}else{%>变更<%}%>冲正">
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
	
	<%
	}//end   if(nextFlag==2)    
	%>
</table>
       <%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
