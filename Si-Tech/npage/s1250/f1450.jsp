<%
  /**
  * 模块：积分兑换冲正
  * 日期：2008.12.1
  * 作者：zhaohaitao
  **/ 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%

	String opCode = "1450";
	String opName = "积分兑换冲正";
	
	String regionCode = (String)session.getAttribute("regCode");
	String orgCode = (String)session.getAttribute("orgCode");
	String workNo = (String)session.getAttribute("workNo");
	String nopass = (String)session.getAttribute("password");
	String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
	
	//paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="paraStr"/>
<%
	System.out.println("paraStr[0][0]---sysAccept======:" +paraStr);   
%>
<%@ include file="../../include/title_name.jsp" %>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>

</HEAD>
<script language="javascript">

onload=function(){
	
}
function validDateNoFocus(obj)
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
	rdShowMessageDialog("日期格式有误，请重新输入！");
	return false;
  }
  else
  {
     var year=theDate.substring(0,4);
	 var month=theDate.substring(4,6);
	 var day=theDate.substring(6,8);
	 if(myParseInt(year)<1900 || myParseInt(year)>3000)
	 {
       rdShowMessageDialog("年的格式有误，请重新输入！");
	   return false;
	 }
     if(myParseInt(month)<1 || myParseInt(month)>12)
	 {
       rdShowMessageDialog("月的格式有误，请重新输入！");
	   return false;
	 }
     if(myParseInt(day)<1 || myParseInt(day)>31)
	 {
       rdShowMessageDialog("日的格式有误，请重新输入！");
	   return false;
	 }

     if (month == "04" || month == "06" || month == "09" || month == "11")  	         
	 {
         if(myParseInt(day)>30)
         {
	 	     rdShowMessageDialog("该月份最多30天,没有31号！");
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
             return false;
		   }
		 }
		 else
		 {
           if(myParseInt(day)>28)
		   {
 		     rdShowMessageDialog("非闰年二月份最多28天！");
      	     //obj.value="";
             return false;
		   }
		 }
      }
  }
  return true;
}

function addRow(favname,favcount,usepoint)
{
	var dymTab = document.getElementById("dymTab");
	var newRow=dymTab.insertRow();
	newRow.insertCell().innerHTML='<td ><input name="favname" type="text"  align="center" readonly value='+favname+'></td>';
	newRow.insertCell().innerHTML='<td ><input name="favcount" type="text" align="center" readonly value='+favcount+'></td>';
	newRow.insertCell().innerHTML='<td ><input name="usepoint" type="text" align="center" readonly value='+usepoint+'></td>';
}

function doProcess(packet){
	
	var backString = packet.data.findValueByName("backString");
	var cfmFlag = packet.data.findValueByName("flag");
	var errCode = packet.data.findValueByName("errCode");
	var errMsg = packet.data.findValueByName("errMsg");

    var varNameStr =""; 
    var varString  = "";
  		
	var errCodeInt = parseInt(errCode);
	if(cfmFlag==0){
		if(errCodeInt==0){
			while (dymTab.rows.length > 0){
				dymTab.deleteRow(0);
			}
			document.frm.vIdNo.value=backString[0][0];
			document.frm.vSmCode.value=backString[0][1];
			document.frm.vSmName.value=backString[0][2];
			document.frm.vCustName.value=backString[0][3];
			document.frm.vIdName.value=backString[0][4];
			document.frm.vIdIccid.value=backString[0][5];
			document.frm.vOpTime.value=backString[0][6];
	//		document.frm.vFavName.value=backString[0][8];
	//		document.frm.vFavCount.value=backString[0][9];
	//		document.frm.vUsePoint.value=backString[0][10];
	
			document.frm.vFavCount.value = 0;
			document.frm.vUsePoint.value = 0;
			document.frm.vOldOpNote.value=backString[0][11];
			infoDiv.style.display="";
			document.frm.print.disabled=false;
			
			var tmpresult1 = new Array();
			var tmpresult2 = new Array();
			var tmpresult3 = new Array();
			
			document.frm.lines.value = 0;
		
			var i = 0;
			varNameStr = backString[0][8];
			for(;varNameStr.indexOf("|") > 0;)
			{
				varString = varNameStr.substring(0,varNameStr.indexOf("|"));
				tmpresult1[i] = varString;
				i++;
				varNameStr= varNameStr.substring(varNameStr.indexOf("|")+1,varNameStr.length);
				document.frm.lines.value = parseInt(document.frm.lines.value)+1;
			}
	
			i = 0;
			varNameStr = "";
			varNameStr = backString[0][9];
			for(;varNameStr.indexOf("|") > 0;)
			{
				varString = varNameStr.substring(0,varNameStr.indexOf("|"));
				tmpresult2[i] = varString;
				i++;
				document.frm.vFavCount.value =  parseInt(document.frm.vFavCount.value) + parseInt(varString);
				varNameStr= varNameStr.substring(varNameStr.indexOf("|")+1,varNameStr.length);
			}

			i = 0;
			varNameStr = "";
			varNameStr = backString[0][10];
			for(;varNameStr.indexOf("|") > 0;)
			{
				varString = varNameStr.substring(0,varNameStr.indexOf("|"));
				tmpresult3[i] = varString;
				i++;
				document.frm.vUsePoint.value =  parseInt(document.frm.vUsePoint.value) + parseInt(varString);
				varNameStr= varNameStr.substring(varNameStr.indexOf("|")+1,varNameStr.length);
			}
			
			for(var j=0; j<tmpresult1.length;j++)
			{
				addRow(tmpresult1[j],tmpresult2[j],tmpresult3[j]);
			}
			
		}else{			
			rdShowMessageDialog(errCodeInt+errMsg);
			infoDiv.style.display="none";
			document.frm.print.disabled=true;
		}
	}
	
	if(cfmFlag==9){		
		rdShowMessageDialog(errCodeInt+errMsg);
		infoDiv.style.display="none";
		document.frm.print.disabled=true;
	}
	
}

function getUserInfo(){
	
	document.frm.print.disabled=true;
			
	if(!forNonNegInt(document.frm.loginAccept)){			
		return false;
	}
			
	if(!forMobil(document.frm.phoneNo)){
		return false;
	}
		  
	if(document.frm.loginAccept.value.length==0){
		rdShowMessageDialog("请输入流水号!");
		return;
	}
	
	document.frm.checkDate.value=document.frm.totalDate.value;
			
	if(!validDateNoFocus(document.frm.checkDate)){
		return false;
	}
	if(document.frm.totalDate.value>document.frm.nowDate.value){
		rdShowMessageDialog("输入的日期应该小于当前日期！");
		return false;
	}
		
	var myPacket = new AJAXPacket("getUserInfo.jsp","正在提交，请稍候......");
		myPacket.data.add("phoneNo",document.frm.phoneNo.value);
		myPacket.data.add("loginAccept",document.frm.loginAccept.value);
		myPacket.data.add("totalDate",document.frm.totalDate.value);
    	core.ajax.sendPacket(myPacket);
    	myPacket=null;
    		
   
}
function resett(){
document.frm.phoneNo.value="";
document.frm.loginAccept.value="";
document.frm.totalDate.value="";

document.frm.vIdNo.value="";
document.frm.vSmCode.value="";
document.frm.vSmName.value="";				
document.frm.vCustName.value="";				
document.frm.vIdName.value="";
document.frm.vIdIccid.value="";
document.frm.vFavCount.value="";
//document.frm.vFavName.value="";
document.frm.vUsePoint.value="";
document.frm.vOldOpNote.value="";
document.frm.vOpNote.value="";
infoDiv.style.display="none";
document.frm.print.disabled=true;

}


function printCommit()
{  
	getAfterPrompt();
    var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
    
     if((ret=="confirm"))
      {
        if(rdShowConfirmDialog('确认电子免填单吗？')==1)
        {
          document.all.printcount.value="1";
	      frm.submit();
        }
    }
    else
    {
       if(rdShowConfirmDialog('确认要提交信息吗？')==1)
       {
       	 document.all.printcount.value="0";
	     frm.submit();
       }
    }
      
    	
    return true;
}

 function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //显示打印对话框 
     var h=210;
     var w=400;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
   
     var pType="subprint";                           // 打印类型：print 打印 subprint 合并打印
	 var billType="1";                            // 票价类型：1电子免填单、2发票、3收据
	 var sysAccept="<%=paraStr%>";            // 流水号
	 var printStr = printInfo(printType);         //调用printinfo()返回的打印内容
	 var mode_code=null;                          //资费代码
	 var fav_code=null;                			  //特服代码
	 var area_code=null;           			      //小区代码
     var opCode="1450";                  		  //操作代码
     var phoneNo=<%=activePhone%>;                //客户电话    
		/* ningtn */
		var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
		/* ningtn */
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
     var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
	 path = path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;

     var ret=window.showModalDialog(path,printStr,prop);
     return ret; 
  }

  function printInfo(printType)
  {
 
    var retInfo = "";
    var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
	
	cust_info+="手机号码："+document.all.phoneNo.value+"|";  
    cust_info+="客户姓名："+document.all.vCustName.value+"|";
    cust_info+="证件号码："+document.all.vIdIccid.value+"|";
    
    opr_info+="业务受理时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"用户品牌: "+document.all.vSmName.value+ "|";
    opr_info +="办理业务："+'<%=op_name%>'+ "  业务流水："+document.all.newLoginAccept.value+"|";

 		if (parseInt(document.frm.lines.value)==1){
				opr_info+="冲正物品:" + document.frm.favname.value+ " 冲正数量:"+parseInt(document.frm.favcount.value)+" 冲正积分/M值:"+parseInt(document.frm.usepoint.value)+"|";
 		}else{ 
  		for (var i=0;i< parseInt(document.frm.favname.length);i++){
				opr_info+="冲正物品:" + document.frm.favname[i].value+ " 冲正数量:"+parseInt(document.frm.favcount[i].value)+" 冲正积分/M值:"+parseInt(document.frm.usepoint[i].value)+"|";
			}
		}
		
	note_info1 +="备注："+document.all.vOpNote.value+"|";
	
	retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    return retInfo;	
  }



</script>
<body>

<FORM  method=post name="frm" onKeyUp="chgFocus(frm)" action="f1250_4.jsp">
	
	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">积分兑换冲正</div>
		</div>
     
     <table id=tbs9 cellspacing="0">
     <tbody>
           <tr> 
               <td class="blue">移动号码</td>
               <td> 
           		  <input class="InputGrey" id=Text2 type=text size=15 name=phoneNo  maxlength=11 value="<%=activePhone%>">
               </td> 
               <td class="blue">流水号</td>
               <td> 
                   <input id=Text1 size=14 name=loginAccept v_type="0_9" type=text v_name="流水号" value="">
                   <font class="orange">*</font>
               </td>               
         	  <td class="blue">日期</td>
               <td> 
                  <input type=text size=17 name=totalDate maxlength=8 value=""> 
                   <font class="orange">*</font>
                  <input class="b_text" type=button name=inp value="查询" onclick="getUserInfo()">
               </td>
           </tr>
     </tbody>
     </table>
         
     <div id=infoDiv style="display:none">
     <table id=tbs9 cellspacing="0">
     <tbody>
     		<tr> 
               <td class="blue">用户I D</td>
               <td> 
                 <input class=button id=Text2 type=text size=17 name=vIdNo disabled >
               </td>
               <td class="blue">用户名称</td>
               <td> 
                 <input name=vCustName type=text disabled class="button" id="vCustName" size=17 >
               </td>
          </tr>	  
          <tr> 
               <td class="blue">品牌代码</td>
               <td> 
                 <input name=vSmCode type=text disabled class="button" id="vSmCode" size=17 >
               </td>
               <td class="blue">品牌名称</td>
               <td> 
                 <input name=vSmName type=text disabled class="button" id="vSmName" size=17 > 
               </td>
          </tr>		  
          <tr> 
               <td class="blue">证件名称</td>
               <td> 
                 <input class=button id=Text2 type=text size=17 name=vIdName disabled >
               </td>
               <td class="blue">证件号码</td>
               <td> 
                 <input class=button id=Text2 type=text size=17 name=vIdIccid disabled >
               </td>     
           </tr>
    </table>          
	<TABLE  cellspacing="0">
		  <tr>
			  <td class="blue">兑换物品</td>
			  <td class="blue">兑换数量</td>
			  <td class="blue">扣减积分</td>
		  </tr>	
	</TABLE>	
	<table id="dymTab" cellspacing="0">
	</table>		 
	<table id=tbs9 cellspacing="0">
 		<tr> 
    		<td class="blue">累计兑换数量</td>
      		<td> 
      	        <input type=text name=vFavCount  disabled class="button"  id="vFavCount">
      	    </td>
            <td class="blue">累计扣减积分/M值</td>
            <td> 
                <input name=vUsePoint type=text disabled class="button" id="vUsePoint" size=17 >
            </td>
        </tr>
        <tr> 
            <td class="blue">操作时间</td>
            <td colspan="3"> 
                <input class=button id=Text2 type=text size=17 name=vOpTime disabled >
            </td>                
        </tr>
        <!--tr style="display:none"--> 
        <tr>
            <td class="blue">原业务备注</td>
            <td colspan="3"> 
                <input class=button id=Text2 type=text size=75 name=vOldOpNote disabled >
            </td>
        </tr>
        <!--tr style="display:none"-->
        <tr> 
            <td class="blue">操作备注</td>
            <td colspan="3"> 
                <input class=button id=Text2 type=text size=75 name=vOpNote >            
		 	</td>          
        </tr>            
     </TABLE>
     </div>	
<!-- ningtn 2011-8-4 15:30:06 扩大电子工单 -->
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=paraStr%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
    <TABLE cellspacing="0">
        
         <TR align="center">
              <TD>
              <input class="b_foot" name=print  type=button value="确认" onclick="printCommit()" disabled>             
              <input class="b_foot" name=back  type=button value="关闭" onclick="parent.removeTab('<%=opCode%>')">             
              <input class="b_foot" name=back  type=button value="复位" onclick="document.getElementById('infoDiv').style.display='none';reset()">  
              </TD>
         </TR>
       
    </TABLE>
  
<input type=hidden name=opCode value="1450">
<input type="hidden" name="newLoginAccept" value="<%=paraStr%>">
<input type=hidden name=workNo value=<%=workNo%>>
<input type=hidden name=noPass value=<%=nopass%>>
<input type=hidden name=orgCode value=<%=orgCode%>>
<input type=hidden name=ipAdd value="<%=request.getRemoteAddr()%>">
<input type=hidden name=nowDate value="<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>">
<input type=hidden name=idCardNo>
<input type=hidden name=backLoginAccept>
<input type=hidden name=checkDate>
<input type="hidden" name="lines" value="0">
<input type="hidden" name="cust_info">
<input type="hidden" name="opr_info">
<input type="hidden" name="printcount">
<%@ include file="/npage/include/footer.jsp" %>   
</FORM>
</BODY>
<!-- ningtn 2011-8-4 15:30:56 电子化工单扩大范围 -->
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>
