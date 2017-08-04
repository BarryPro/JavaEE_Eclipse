
<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>

<%
        String opCode = "9119";
        String opName = "魔百和异常订购数据查询";
        String op_name =  "魔百和异常订购数据查询";
        String workNo = (String)session.getAttribute("workNo");
        String workName = (String)session.getAttribute("workName");
        String regionCode=(String)session.getAttribute("regCode");
    	String result[][] = null;
    
    	
    	int recNum = 0;
        /*yanpx@20100903为客服 不打印免填单添加 开始*/
        String accountType = (String)session.getAttribute("accountType"); //1 为营业工号 2 为客服工号
        /*结束*/
        
     
        
        ArrayList arr = (ArrayList)session.getAttribute("allArr");
        String[][] baseInfo = (String[][])arr.get(0);
        
        String loginNo = baseInfo[0][2];
       
        
        String[][] temfavStr=(String[][])session.getAttribute("favInfo");
        String[] favStr=new String[temfavStr.length];
        for(int i=0;i<favStr.length;i++)
        favStr[i]=temfavStr[i][0].trim();
        boolean pwrf=false;
        boolean hfrf=false;
        String passFlag="true";
        /*四级以上营业员免密码*/
        String power_right=(String)session.getAttribute("powerRight");
        System.out.println("--------------power_right==="+power_right);
        if(Integer.parseInt(power_right.trim())>=0){
                pwrf=true;
        }
       
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept" />
	
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE><%=op_name%></TITLE>

<script language="JavaScript">
<!--

//定义应用全局的变量
var SUCC_CODE   = "0";                  //自己应用程序定义
var ERROR_CODE  = "1";                  //自己应用程序定义
var YE_SUCC_CODE = "000000";            //根据营业系统定义而修改
var dynTbIndex=1;                               //用于动态表数据的索引位置,开始值为1.考虑表头

var js_pwFlag="true";

//core.loadUnit("debug");
//core.loadUnit("rpccore"); 

onload=function()
{               
        //core.rpc.onreceive = doProcess;       
}

//---------1------RPC处理函数------------------
function doProcess(packet){
        //使用RPC的时候,以下三个变量作为标准使用.
        var error_code = packet.data.findValueByName("errorCode");
        var error_msg =  packet.data.findValueByName("errorMsg");
        var verifyType = packet.data.findValueByName("verifyType");
        self.status="";

        if(verifyType=="phoneno"){

                if( parseInt(error_code) == 0 ){
                        var custname= packet.data.findValueByName("custname");
                        var runcode= packet.data.findValueByName("runcode");
                        var brand=packet.data.findValueByName("brand");
                        var idNo=packet.data.findValueByName("idNo");
                        var idType=packet.data.findValueByName("idtype");
                        var iccid=packet.data.findValueByName("iccid");

                        document.all.runname.value=runcode;
                        document.all.idNo.value=idNo;
                        document.all.idtype.value=idType;
                        document.all.iccid.value=iccid;    
                        //判断用户状态
                        if(document.all.runname.value.substring(1,2)!="A" &&document.all.runname.value.substring(1,2)!="K"){
                						rdShowMessageDialog("用户状态不正常，不允许受理业务!",0);
														return false;
            						}
                        backArrMsg = packet.data.findValueByName("backArrMsg");
                       //	getOperCode();
                       //	getRhCount();
                       //	getYxCount();
                        getCibpInfo();
                }
                else{
                        rdShowMessageDialog("<br>错误代码:["+error_code+"]</br>错误信息:["+error_msg+"]",0);
                        return false;
                }
        }
        else if(verifyType=="cibpInfo"){
        
					backArrMsg = packet.data.findValueByName("backArrMsg");
		
					if(error_code=="000000"){
					
						if(backArrMsg[0].length>0){
						
							var workType = backArrMsg[0][3];
							var TypeName ="";
							document.all.workType.value=workType;
							
							if(workType=="1"){
								TypeName="已有订购关系";
							}else if(workType=="2"){
								TypeName="无订购关系 也无异常数据";
								document.form.sure.disabled = true;
							}else if(workType=="3"){
								TypeName="有异常数据 可补发";
							}else if(workType=="4"){
								TypeName="有异常数据 已补发";
								document.form.sure.disabled = true;
							}
							document.all.TypeName.value=TypeName;
							
							

							document.all.opTime.value=backArrMsg[0][4];
							//document.all.workType.value=backArrMsg[0][5];
							document.all.spId.value=backArrMsg[0][6];
							document.all.bizCode.value=backArrMsg[0][7];

							
							var infoCode = backArrMsg[0][8].split("|");
							var infoValue = backArrMsg[0][9].split("|");
							
							for(var i=0; i<infoCode.length ; i++){
									if(infoCode[i]=="302"){
									 	document.all.value302.value=infoValue[i];
									}
									else if(infoCode[i]=="303"){
										 document.all.value303.value=infoValue[i];
									}
									else if(infoCode[i]=="304"){
										 document.all.value304.value=infoValue[i];
									}
									else if(infoCode[i]=="305"){
										 document.all.value305.value=infoValue[i];
									}
									
							}
							
						}
						
					}
				
        }
        
}
function deleteRow(msgId, obj) {
	var tableTemp = document.getElementById(msgId).children[0];
	tableTemp.deleteRow(obj.parentElement.parentElement.rowIndex);
}
function dinggou(index){
	var row = document.getElementById("newSpinfoTable").rows[index-1];
	var dgSpinfoTable = document.getElementById("dgSpinfoTable").rows;
	for (var i = 1; i < dgSpinfoTable.length; i++) {
		if(dgSpinfoTable[i].cells[1].innerHTML == row.cells[1].innerHTML)
		{
			rdShowMessageDialog("代码["+row.cells[1].innerHTML+"]已经订购",0);
			return;
		}
	}
	var trTemp = document.getElementById("dgSpinfoTable").insertRow();
	 for(var j=0;j<row.cells.length-1;j++){  
         trTemp.insertCell().innerHTML = row.cells[j].innerHTML;
     } 
	trTemp.insertCell().innerHTML = "<input type='button' class='b_text' name='' id='' value='删除' onclick='deleteRow(\"dgSpinfoTable\", this)'/>";
}
function clearRow(id,a){ 
	   var length= document.getElementById(id).rows.length; 
	   for( var i=a; i<length; i++ ) 
	   { 
		   document.getElementById(id).deleteRow(a);
	   } 
	} 
function trim(val)
{
        var exp = /(^\s+)|(\s+$)/g;
        var resVal = val.replace(exp,"");
        return resVal;
}

function isNumberString (InString,RefString)
{
        if(InString.length==0) return (false);
        for (Count=0; Count < InString.length; Count++)  {
        TempChar= InString.substring (Count, Count+1);
        if (RefString.indexOf (TempChar, 0)==-1)  
        return (false);
        }
        return (true);
}
function getUserInfo()
{

        if(form.phoneno.value.length<11 || isNumberString(form.phoneno.value,"1234567890")!=1) {
                rdShowMessageDialog("请输入手机号码,长度为11位数字!!");
                document.form.phoneno.focus();
                return false;
        }
        else if (!forMobil(form.phoneno)){
                
                document.form.phoneno.focus();
                return false;
        }
       
        //免密码
        var accountpassword=document.form.accountpassword.value;
        if(js_pwFlag=="true"){
                accountpassword="";
        }

        var myPacket = new AJAXPacket("f9113_rpc_check.jsp","正在确认，请稍候......");
        
        myPacket.data.add("verifyType","phoneno");
        myPacket.data.add("phoneno",document.form.phoneno.value);
        myPacket.data.add("passwd",accountpassword);
        core.ajax.sendPacket(myPacket);
        myPacket = null;             
}
function getRhCount()
{
        var myPacket = new AJAXPacket("f9118_rhcount.jsp","正在确认，请稍候......");
        myPacket.data.add("verifyType","rhcount");
        myPacket.data.add("phoneno",document.form.phoneno.value);
        core.ajax.sendPacket(myPacket);
        myPacket = null;                
}
function getYxCount()
{
        var myPacket = new AJAXPacket("f9118_yxcount.jsp","正在确认，请稍候......");
        myPacket.data.add("verifyType","yxcount");
        myPacket.data.add("phoneno",document.form.phoneno.value);
        core.ajax.sendPacket(myPacket);
        myPacket = null;                
}
function getOperCode()
{
        var myPacket = new AJAXPacket("f9113_oper_code.jsp","正在确认，请稍候......");
        myPacket.data.add("verifyType","opercode");
        myPacket.data.add("busytype",document.form.busytype.value);
        core.ajax.sendPacket(myPacket);
        myPacket = null;                
}
function getCibpInfo()
{

        var myPacket = new AJAXPacket("s9119_getCibpInfo.jsp","正在确认，请稍候......");
        myPacket.data.add("verifyType","cibpInfo");

        myPacket.data.add("phoneno",document.form.phoneno.value);
        core.ajax.sendPacket(myPacket);

        myPacket = null;                
}
function getKdInfo(id)
{
		if(id!=""&&id!=null){
	        var myPacket = new AJAXPacket("s9118_getKdInfo.jsp","正在确认，请稍候......");
	        myPacket.data.add("verifyType","kdInfo");
	        myPacket.data.add("netcode",id);
	        myPacket.data.add("loginNo",document.form.loginNo.value);
	        myPacket.data.add("phoneno",document.form.phoneno.value);
	        core.ajax.sendPacket(myPacket);
	        myPacket = null;
		}                
} 
function checkImei(id,name)
{

		//document.all.value302.value="12345678901234567890123456789"+id;
		if(id!=""&&id!=null){
	        var myPacket = new AJAXPacket("s9118_checkImei.jsp","正在确认，请稍候......");
	        myPacket.data.add("verifyType","checkImei");
	        myPacket.data.add("imei",id);
	        myPacket.data.add("inputName",name);
	        core.ajax.sendPacket(myPacket);
	        myPacket = null;
		}              
} 


function docheck(printflag)
{
	           if(rdShowConfirmDialog('确认要提交信息吗？')==1)
	           {
	           	document.form.action="s9119_cfm.jsp";
	           }    	
	    
}



     





function chgPhone(){
        document.all.accountpassword.value="";
        document.all.code201.value="";
        document.all.runname.value="";
        document.all.value201.value="";
        document.all.openinfo1.style.display="none";
        document.all.openinfo3.style.display="none";
        document.all.dyntb.style.display="none";
        document.all.optype.value="";
        document.all.spCode.value="";
        document.all.spBizCode.value="";
        document.all.NewPasswd.value="";
        document.all.ConfirmPasswd.value="";
        document.all.opnote.value="";
}

$(document).ready(function(){
	getUserInfo();
});


//-->
</script>

</HEAD>

<BODY>
<FORM action="" method=post name=form id="frm1"><%@ include
	file="/npage/include/header.jsp"%>
<div class="title">
<div id="title_zi">魔百和订购信息</div>
</div>
<input type="hidden"	name="loginAccept" value="<%=loginAccept%>" />
	<input type="hidden" name="rhcount" value="">
	
	<input type="hidden" name="runname" value="">
	
	<input type="hidden" name="yxcount" value="">
	<input type="hidden" name="dgflag" value="0">
		<input type="hidden" name="idtype" value="">
		<input type="hidden" name="iccid" value="">
		
		<input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>">
	
<table cellSpacing="0">
	<tr>
		<td class=blue>手机号码</td>
		<td>
			<input type="text" name="phoneno" id="phoneno" readonly value="<%=activePhone%>" onchange="chgPhone()" size="40"> 
			<input type="hidden" name="accountpassword" maxlength="6" />
		</td>
		<td class=blue>操作时间</td>
		<td>
			<input type="text" readonly name="opTime" value="" size="40">
		</td>
	</tr>
	<tr>
		<td class=blue>
		<div>企业代码</div>
		</td>
		<td>
			<input type="text" readonly name="spId" value="" size="40">
		</td>
		<td class=blue>
		<div>业务代码</div>
		</td>
			<td><input type="text" readonly name="bizCode" value="" size="40">
		</td>
	</tr>
	
	<tr>
		<!-- <td class=blue>
		<div>原IMEI</div>
		</td>
		<td>
			<input type="text" readonly name="value311" value="" size="40">
		</td>
		-->
		<td class=blue>
		<div>机顶盒id</div>
		</td>
		<td  colspan="3">
				<input type="text" readonly name="value302" value="" size="40">
		</td>
	</tr>
	<tr>
		<td class=blue>
		<div>宽带账号</div>
		</td>
		<td colspan="3">
			<input type="text" readonly name="value303" value="" size="40">
		</td>
		
	</tr>
	
	<tr>
		<td class=blue>
			<div>装机地址</div>
		</td>
		<td  colspan="3">
			<input type="text" readonly name="value305" value="" size="60" maxlength="40" class="InputGrey"> 
			
		</td>
	</tr>
	<tr>
		<td class=blue>
			<div>当前状态</div>
		</td>
		<td  colspan="3">
			<input type="hidden" name="workType" value="" > 
			<input type="text" name="TypeName" readonly value="" size="60" maxlength="40" > 
		</td>
	</tr>
</table>

<table cellspacing="0">
	<tr>
		<td align=center id="footer" colspan="4">
			<input type="hidden" class="button" name="bizType" value="">
			<input type="hidden" class="button" name="idNo" value="">
			<input type="hidden" name="oprSource" value="08">
			<input class="b_foot" name=sure type=button value=补发 onclick="docheck()"> &nbsp; 
			<input class="b_foot" name=reset type=reset value=关闭 onClick="removeCurrentTab()"> 
			
			</td>
	</tr>
	
</table>
<%@include file="/npage/include/footer.jsp"%></FORM>
</BODY>
</HTML>
