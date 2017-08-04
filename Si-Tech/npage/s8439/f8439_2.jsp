   
<%
/********************
 version v2.0
 开发商 si-tech
 create wangzc@2010-5-29 :10:48
********************/
%>
            
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 


<%@ page contentType= "text/html;charset=gb2312" %>
<%
String opCode = request.getParameter("opCode");
String opName = request.getParameter("opName");
String phoneNo1 = request.getParameter("phone_no1");
String phoneNo2 = request.getParameter("phone_no2");
String vBackAccept = request.getParameter("vBackAccept");
String viccid=request.getParameter("iccid1");

%> 
<HTML><HEAD><TITLE><%=opName%></TITLE>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>


<%
String regionCode = (String)session.getAttribute("regCode");

String iChnSource = "01";
String workNo =  (String)session.getAttribute("workNo");
String loginPwd = (String)session.getAttribute("password");

System.out.println("-------------regionCode----------------"+regionCode); 
System.out.println("-------------opCode----------------"+opCode); 
System.out.println("-------------opName------------"+opName); 
System.out.println("-------------workNo----------------"+workNo); 
System.out.println("-------------loginPwd----------------"+loginPwd); 
System.out.println("-------------iChnSource------------"+iChnSource);
System.out.println("-------------phoneNo1------------"+phoneNo1);
System.out.println("-------------phoneNo2------------"+phoneNo2);
System.out.println("-------------vBackAccept------------"+vBackAccept);
 String userYe = "";
 String phone_no1="",phone_no2="";
 String custName="";
 String smName="";
 String idName="";
 String iccid="";
 String modeName="";
 String modeCode="";
 String offerId = "",offerName="",offerDesc="",fprodId="";
 String custAdd="";
 String groupId="";
 String accNbr="";
 String vStateDate="";
 String vExpDate="";
 String vEffDate="";
%>	 	

		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAcceptl" /> 
		<wtc:service name="s8439Qry" outnum="23" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=sysAcceptl%>" />
			<wtc:param value="<%=iChnSource%>" />	
			<wtc:param value="<%=opCode%>" />		
			<wtc:param value="<%=workNo%>" />			
			<wtc:param value="<%=loginPwd%>" />				
			<wtc:param value="<%=phoneNo1%>" />					
			<wtc:param value="" />
			<wtc:param value="<%=phoneNo2%>" />
			<wtc:param value="" />
			<wtc:param value="<%=vBackAccept%>" />						
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
		phone_no1 = result_t2[0][2];
		smName = result_t2[0][5];
		custName = result_t2[0][4];
		userYe = result_t2[0][6];  
		idName = result_t2[0][7];
		iccid = result_t2[0][8];
		modeCode = result_t2[0][9];
		modeName = result_t2[0][10];
		custAdd = result_t2[0][11];
		groupId= result_t2[0][12];
		accNbr = result_t2[0][13];
		vStateDate = result_t2[0][14];
		vExpDate = result_t2[0][15];
		vEffDate = result_t2[0][16];
		}
	}
%>
<%
if(!opCode.equals("8444"))
{
	%>
	<wtc:service name="s5584Qry" outnum="4" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="<%=opCode%>" />
			<wtc:param value="" />
			<wtc:param value="" />
			<%
			  if(opCode.equals("8439")||opCode.equals("8443")||opCode.equals("8441")||opCode.equals("8442")){
			  %>
			  <wtc:param value="<%=phoneNo1%>" />
			  <%
			  }
			  if(opCode.equals("8440"))
			  	{
			  		%>
			  	<wtc:param value="<%=phoneNo2%>" />
			  	<%
			  	}
			%>
								
			<wtc:param value="" />						
			<wtc:param value="13" />							
		</wtc:service>
		<wtc:array id="result_t3" scope="end" />
<%
		if(!code1.equals("000000")){
%>
<script language="JavaScript">
	 rdShowMessageDialog("<%=code1%>:<%=msg1%>",0);
	 history.go(-1);
</script>
<%}else{
		offerId = result_t3[0][0];
		offerName = result_t3[0][1];
		offerDesc = result_t3[0][2];
		fprodId = result_t3[0][3];
	
	} 
%>					
	<%
}
%>
	


<script language="JavaScript">
	function sub(){
		document.all.opNote.value="<%=workNo%>为客户"+document.frm1.custName.value+"办理<%=opName%>";
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
		document.frm1.action= "f8439_3.jsp"	;
		document.frm1.submit();
		}
  function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //显示打印对话框 
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			var pType="subprint";
			var billType="1";  
			var printStr = printInfo(printType);
			
			var mode_code=null;
			var fav_code=null;
			var area_code=null;
			
			var sysAccept = "<%=sysAcceptl%>" ;
			
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
			var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
			var path = path + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=phoneNo1%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
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
		
		cust_info+="手机号码："+document.frm1.phone_no1.value+"|";
		cust_info+="客户姓名："+document.frm1.custName.value+"|";
		

		opr_info+="业务受理时间：" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "  " + "用户品牌：" + document.frm1.smName.value + "|";
		opr_info+="业务类型：三城一网-"+"<%=opName%>"+" " + "业务流水：" +"<%=sysAcceptl%>"+ "|";
		if("<%=opCode%>".trim()=="8439"||"<%=opCode%>".trim()=="8440")
			opr_info+="生效时间：立即|";
		if("<%=opCode%>".trim()=="8442"||"<%=opCode%>".trim()=="8443")
			opr_info+="生效时间：下月生效|";
		
		note_info1+="备注："+document.all.opNote.value+"|";
		//if("<%=opCode%>".trim()!="8443"){
		//note_info2+="三城一网资费描述："+document.all.offerDesc1.value+"|";
		//}
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;	
	  	  
  }
</script>
</HEAD>
<BODY >
<FORM  method=post name=frm1 >
	<%@ include file="/npage/include/header.jsp" %>

	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div> 
            <table cellspacing="0">
	                                
 							 		<tr>
 							 			<td class="blue">手机号码</td>
 							 			<td><input type="text" id="phone_no1" name="phone_no1" value="<%=phone_no1%>" readOnly class="InputGrey"></td>
 							 			<td class="blue">用户名称</td>
 							 			<td><input type="text" id="custName" name="custName" value="<%=custName%>" readOnly class="InputGrey"></td>
 							 		</tr>
 							 		<tr>
 							 			<td class="blue">手机品牌</td>
 							 			<td><input type="text" id="smName" name="smName" value="<%=smName%>" readOnly class="InputGrey"></td>
 							 			<td class="blue">用户余额</td>
 							 			<td><input type="text" id="userYe" name="userYe" value="<%=userYe%>" readOnly class="InputGrey"></td>
 							 		</tr>
 							 		<tr>
 							 			<td class="blue">证件类型</td>
 							 			<td><input type="text" id="idName" name="idName" value="<%=idName%>" readOnly class="InputGrey"></td>
 							 			<td class="blue">证件号码</td>
 							 			<td><input type="text" id="iccid" name="iccid" value="<%=iccid%>" readOnly class="InputGrey"></td>
 							 		</tr>
 							 		<tr>
 							 			<td class="blue">当前主套餐</td>
 							 			<td><input type="text" id="modeName" name="modeName" value="<%=modeName%>--<%=modeCode%>" readOnly class="InputGrey"></td>
 							 			<td class="blue">下月主套餐</td>
 							 			<td><input type="text" id="nextmodeName" name="nextmodeName" value="<%=modeName%>--<%=modeCode%>" readOnly class="InputGrey"></td>
 							 		</tr>
 							 		    <tr>
			
			<td class="blue">操作备注</td>
			<td colspan=3>
				<input class="InputGrey"  type="text" name="opNote" id="opNote"  size="80"   v_type="string" v_must=1 index="0" >
        	</td>
        </tr>
 							 		
 							 	</table>
 	<%
 	if(opCode.equals("8439")||opCode.equals("8440"))
 	{
 	%>
 		<div class="title">
		<div id="title_zi">选择资费</div>
	</div> 
	
	
		<TABLE cellSpacing="0">
          <TBODY>
          <tr>
			<td class="blue">
				资费代码
			</td>
            <td colspan=3>
				<input class="InputGrey"  type="text" name="offer_id" size="50" id="offer_id" value="<%=offerId%>--<%=offerName%>" readonly >
			</td>
        </tr>
         
		  	 <tr>
		  	 	<td class="blue">
					资费描述
				</td>
				 <td colspan=3>
					<input class="InputGrey"  type="text" size="80" name="offerdesc" id="offerdesc"  value="<%=offerDesc%>" readonly >
				</td>
			</tr>
		  	 <tr></tr>
		  	 <tr></tr>
            <td id="footer" colspan="4"> <div align="center">
            	 &nbsp;
				<input name="confirm" id="confirm" type="button" class="b_foot"  value="确认" onClick="sub()"  >
                 &nbsp;
                <input name="reset" type="hidden" class="b_foot" value="清除" >
                &nbsp;
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="返回">
                &nbsp;

				</div>
			</td>
          </tr>
        </tbody>
        </table>
 	<%
 	
 	}
 	%>
 	
 	<%
 	if(opCode.equals("8443")||opCode.equals("8441"))
 	{
 	%>
 			<div class="title">
		<div id="title_zi">虚拟网信息</div>
	</div> 
	
	
		<TABLE cellSpacing="0">
          <TBODY>
          <tr>
			<td class="blue">
				虚拟网代码
			</td>
            <td>
				<input class="InputGrey"  type="text" name="groupId" id="groupId" value="<%=groupId%>" readOnly  v_type="string" v_must=1 index="0" >
			</td>
			<td class="blue">
				建网号码
			</td>
            <td>
				<input class="InputGrey"  type="text" name="buildPhoneNo" id="buildPhoneNo" value="<%=accNbr%>" readOnly v_type="string" v_must=1 index="0" >
			</td>
			
        </tr>
		  	 <tr>
		  	 <td class="blue">
				业务受理时间
			</td>
            <td>
				<input class="InputGrey"  type="text" name="stateDate" id="stateDate" value="<%=vStateDate%>" readOnly  v_type="string" v_must=1 index="0" >
			</td>
			<td class="blue">
				生效时间
			</td>
            <td>
				<input class="InputGrey"  type="text" name="effdate" id="effdate" value="<%=vEffDate%>" readOnly  v_type="string" v_must=1 index="0" >
			</td>
		  	 </tr>
		  	 <td class="blue">
				失效时间
			</td>
            <td>
				<input class="InputGrey"  type="text" name="expdate" id="groupId" value="<%=vExpDate%>" readOnly  v_type="string" v_must=1 index="0" >
			</td>
		  	 
		  	 <tr>
		  	 
		  	 </tr>
		  	 <tr></tr>
            <td id="footer" colspan="4"> <div align="center">
            	 &nbsp;
				<input name="confirm" id="confirm" type="button" class="b_foot"  value="确认" onClick="sub()"  >
                 &nbsp;
                <input name="reset" type="hidden" class="b_foot" value="清除" >
                &nbsp;
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="返回">
                &nbsp;

				</div>
			</td>
          </tr>
        </tbody>
        </table>
 	<%
 	}
 	%>
 	
 	<%
 	if(opCode.equals("8442"))
 	{
 	%>
 			<div class="title">
		<div id="title_zi">要加入的虚拟网信息</div>
	</div> 
	
	
		<TABLE cellSpacing="0">
          <TBODY>
          <tr>
			<td class="blue">
				虚拟网代码
			</td>
            <td>
				<input class="InputGrey"  type="text" name="groupId1" id="groupId1" value="<%=groupId%>" readOnly  v_type="string" v_must=1 index="0" >
			</td>
			<td class="blue">
				成员号码
			</td>
            <td>
				<input class="InputGrey"  type="text" name="buildPhoneNo1" id="buildPhoneNo1" value="<%=accNbr%>" readOnly v_type="string" v_must=1 index="0" >
			</td>
			
        </tr>
         <tr>
		  	 <tr></tr>
		  	 <tr></tr>
		  	 <tr></tr>
            <td id="footer" colspan="4"> <div align="center">
            	 &nbsp;
				<input name="confirm" id="confirm" type="button" class="b_foot"  value="确认" onClick="sub()"  >
                 &nbsp;
                <input name="reset" type="hidden" class="b_foot" value="清除" >
                &nbsp;
                <input name="back" onClick="history.go(-1);" type="button" class="b_foot" value="返回">
                &nbsp;

				</div>
			</td>
          </tr>
        </tbody>
        </table>
 	<%
 	}
 	%>
 
<%@ include file="/npage/include/footer.jsp" %>
<input type="hidden" name="sysAcceptl" id="sysAcceptl" value="<%=sysAcceptl%>">
<input type="hidden" name="vBackAccept" id="vBackAccept" value="<%=vBackAccept%>">
<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" id="opName" value="<%=opName%>">
<input type="hidden" name="fprodId" id="fprodId" value="<%=fprodId%>">
<input type="hidden" name="phone_no2" id="phone_no2" value="<%=phoneNo2%>">
<input type="hidden" name="iccid1" id="phone_no2" value="<%=viccid%>">
<input type="hidden" name="offerDesc1" id="offerDesc1" value="<%=offerDesc%>">




</FORM>
</BODY></HTML>
						
  					