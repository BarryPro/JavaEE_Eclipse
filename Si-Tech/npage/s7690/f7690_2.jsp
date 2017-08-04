   
<%
/********************
 version v2.0
 开发商 si-tech
 create hejw@2010-5-25 :10:48
********************/
%>

              
<%
	String opCode = request.getParameter("opCode");
  String opName = request.getParameter("opName");
%>              
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 


<%@ page contentType= "text/html;charset=gb2312" %>
 
<HTML><HEAD><TITLE><%=opName%></TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>


<%
String regionCode = (String)session.getAttribute("regCode");

String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
String loverNo = WtcUtil.repNull(request.getParameter("loverNo"));
String user_passwd = WtcUtil.repNull(request.getParameter("user_passwd"));

System.out.println("-------------phoneNo----------------"+phoneNo); 
System.out.println("-------------loverNo----------------"+loverNo); 
System.out.println("-------------user_passwd------------"+user_passwd); 

String iChnSource = "01";
String workNo =  (String)session.getAttribute("workNo");
String loginPwd = (String)session.getAttribute("password");
 
 String userPhNo="",userName = "",userPp = "",userYe = "";
 String loverPhNo = "",loverName="",loverPp="",loverYe="";
 String offerId = "",offerName="",offerDesc="",fprodId="";

%>	 	
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
		<wtc:service name="s7690Qry" outnum="13" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=sysAcceptl%>" />
			<wtc:param value="<%=iChnSource%>" />	
			<wtc:param value="<%=opCode%>" />		
			<wtc:param value="<%=workNo%>" />			
			<wtc:param value="<%=loginPwd%>" />				
			<wtc:param value="<%=phoneNo%>" />					
			<wtc:param value="" />						
			<wtc:param value="<%=loverNo%>" />							
			<wtc:param value="" />							
		</wtc:service>
		<wtc:array id="result_t2" scope="end" />
			
<%
		if(!code.equals("000000")){
%>
<script language="JavaScript">
	 rdShowMessageDialog("<%=code%>:<%=msg%>",0);
	 history.go(-1);
</script>
<%}else{
	if(result_t2.length>0){
		userPhNo = result_t2[0][2];
		userName = result_t2[0][4];
		userPp = result_t2[0][5];
		userYe = result_t2[0][6];
		
		loverPhNo = result_t2[0][7];
		loverName = result_t2[0][9];
		loverPp = result_t2[0][10];
		loverYe = result_t2[0][11];
		}
	}
	
	%>


<script language="JavaScript">
	function sub(){
		
		document.all.opNote.value="<%=workNo%>为客户"+document.frm1.userName.value+"办理<%=opName%>";
		getAfterPrompt();
		var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
		if(typeof(ret)!="undefined")
		    {
		      if((ret=="confirm"))
		      {
		        if(rdShowConfirmDialog('确认电子免填单吗？如确认,将提交本次业务!')==1)
		        {
			      frmCfm();
		        }
			  }
			  if(ret=="continueSub")
			  {
		        if(rdShowConfirmDialog('确认要提交信息吗？')==1)
		        {
			      frmCfm();
		        }
			  }
		    }
		    else
		    {
		       if(rdShowConfirmDialog('确认要提交信息吗？')==1)
		       {
			     frmCfm();
		       }
		    }		
	
		
	}
	function frmCfm(){
		document.frm1.action= "f7690_3.jsp"	;
		document.frm1.submit();
		}
  function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //显示打印对话框 
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			
			var pType="subprint";                                      // 打印类型：print 打印 subprint 合并打印
			var billType="1";                                          //  票价类型：1电子免填单、2发票、3收据
			var sysAccept=<%=sysAcceptl%>;                            // 流水号
			var printStr=printInfo(printType);                         //调用printinfo()返回的打印内容
			var mode_code=null;                                        //资费代码
			var fav_code=null;                                         //特服代码
			var area_code=null;                                        //小区代码
			var opCode="<%=opCode%>";                                  //操作代码
			var phoneNo=document.frm1.userPhNo.value;                 //客户电话
		
			
			
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
			var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
			path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);
			return ret;
			
  }

  function printInfo(printType)
  {
	  var cust_info="";
		var opr_info="";
		var note_info1="";
		var note_info2="";
		var note_info3="";
		var note_info4="";
		
		var retInfo = "";
		
		cust_info+="手机号码："+document.frm1.userPhNo.value+"|";
		cust_info+="客户姓名："+document.frm1.userName.value+"|";
		
		opr_info+="申请号码："+document.frm1.userPhNo.value+"|";
		opr_info+="业务类型："+"<%=opName%>"+"|";
		opr_info+="业务流水："+"<%=sysAcceptl%>"+"|";
		opr_info+="情侣号码："+"<%=loverPhNo%>"+"|";
		if("<%=opCode%>".trim()=="7690")
			opr_info+="生效时间：24小时内生效|";
		if("<%=opCode%>".trim()=="7691")
			opr_info+="生效时间：下月生效|";
			
		note_info1+="备注："+document.all.opNote.value+"|";
		
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;	
	  	  
  }

  function getOff(){
  		var packet = new AJAXPacket("ajaxGetOff.jsp");
			packet.data.add("opCode" ,"<%=opCode%>");
			packet.data.add("phoneNo" ,"<%=phoneNo%>");
			core.ajax.sendPacket(packet,doGetOff);
			packet =null;
  }
  function doGetOff(packet){
		var retCode = packet.data.findValueByName("code"); 
	  var retMsg = packet.data.findValueByName("msg"); 
	  
	  if(retCode=="000000"){
	  	document.all.offerId.value = packet.data.findValueByName("offerId"); 
	  	document.all.offerName.value = packet.data.findValueByName("offerName"); 
	  	document.all.offerDesc.value = packet.data.findValueByName("offerDesc"); 
	  	document.all.fprodId.value = packet.data.findValueByName("fprodId"); 
	  	document.all.subBut.disabled=false;
	  	document.all.getOffBut.disabled=true;
	  	getMidPrompt("10442",codeChg(document.all.offerId.value),"offerIdTd");	
	  }else{
	  	rdShowMessageDialog(retCode+":"+retMsg,0);
	  	document.all.getOffBut.disabled=false;
	  	document.all.subBut.disabled=true;
	  }
	  		
  }
   
</script>
</HEAD>
<BODY >
<FORM  method=post name=frm1 >
	<%@ include file="/npage/include/header.jsp" %>

	<div class="title">
		<div id="title_zi">用户信息</div>
	</div> 
            <table cellspacing="0">
	
 							 		<tr>
 							 			<td class="blue" width="15%">手机号码</td>
 							 			<td width="35%"><input type="text" id="userPhNo" name="userPhNo" value="<%=userPhNo%>" readOnly class="InputGrey"></td>
 							 			<td class="blue" width="15%">用户名称</td>
 							 			<td width="35%"><input type="text" id="userName" name="userName" value="<%=userName%>" readOnly class="InputGrey"></td>
 							 		</tr>
 							 		<tr>
 							 			<td class="blue">手机品牌</td>
 							 			<td><input type="text" id="userPp" name="userPp" value="<%=userPp%>" readOnly class="InputGrey"></td>
 							 			<td class="blue">用户余额</td>
 							 			<td><input type="text" id="userYe" name="userYe" value="<%=userYe%>" readOnly class="InputGrey"></td>
 							 		</tr>
 							 	</table>
 							 	
<br>
 							 	<table cellspacing="0">
 							 		<tr>
 							 			<td class="blue" width="15%">情侣号码</td>
 							 			<td width="35%"><input type="text" id="loverPhNo" name="loverPhNo" value="<%=loverPhNo%>" readOnly class="InputGrey"></td>
 							 			<td class="blue" width="15%">情侣名称</td>
 							 			<td width="35%"><input type="text" id="loverName" name="loverName" value="<%=loverName%>" readOnly class="InputGrey"></td>
 							 		</tr>
 							 		<tr>
 							 			<td class="blue">情侣号品牌</td>
 							 			<td><input type="text" id="loverPp" name="loverPp" value="<%=loverPp%>" readOnly class="InputGrey"></td>
 							 			<td class="blue">情侣号余额</td>
 							 			<td><input type="text" id="loverYe" name="loverYe" value="<%=loverYe%>" readOnly class="InputGrey"></td>
 							 		</tr>
 							 		</table>
 							 		<table cellspacing="0">
 							 <br>		
 							 		<tr>
 							 			<td class="blue" width="15%">资费代码</td>
 							 			<td width="35%" id="offerIdTd"><input type="text" id="offerId" name="offerId" value="" readOnly class="InputGrey">
 							 			&nbsp;
 							 			<input type="button" id="getOffBut" class="b_text" value="获取" onclick="getOff()">	
 							 			</td>
 							 			<td class="blue" width="15%">资费名称</td>
 							 			<td width="35%"><input type="text" id="offerName" name="offerName"  size="30" value="" readOnly class="InputGrey"></td>
 							 		</tr>
 							 		
 							 		<tr>
 							 			<td class="blue">资费描述</td>
 							 			<td colspan="3"><input type="text" id="offerDesc" size="80" name="offerDesc" value="" readOnly class="InputGrey"></td>
 							 		</tr>
 							 		
 							 		<tr>
 							 			<td class="blue">操作备注</td>
 							 			<td colspan="3"><input type="text" id="opNote" name="opNote" value="" readOnly size="80" class="InputGrey"></td>
 							 		</tr>
 							 			 
 							 		<td id="footer" colspan="4">
 							 			<input type="button" id="subBut" class="b_foot" value="确定" onclick="sub()" disabled>
 							 			<input type="button" id="retBut" class="b_foot" value="返回" onclick="history.go(-1)">
 							 			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()">
 							 		</td>
 							 	</td>
            </table>

<%@ include file="/npage/include/footer_new.jsp" %>
<input type="hidden" name="sysAcceptl" id="sysAcceptl" value="<%=sysAcceptl%>">
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">
<input type="hidden" name="fprodId" id="fprodId" value="<%=fprodId%>">

</FORM>
</BODY>
 		<%if(opCode.equals("7691")){%>
 			<script language="JavaScript">
    		getOff();
    	</script>	
  	<%}%>
</HTML>
						
  					