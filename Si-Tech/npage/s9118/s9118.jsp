
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
        String opCode = "9118";
        String opName = "互联网电视业务受理";
        String workNo = (String)session.getAttribute("workNo");
        String workName = (String)session.getAttribute("workName");
        String regionCode=(String)session.getAttribute("regCode");
    	String result[][] = null;
    	String newresult[][] = null;
    	
    	int iPageNumber = request.getParameter("pageNumber")==null?1:Integer.parseInt(request.getParameter("pageNumber"));
    	int iPageSize = 25;
    	int iStartPos = (iPageNumber-1)*iPageSize;
    	int iEndPos = iPageNumber*iPageSize;
    	
    	int recNum = 0;
    	int newrecNum = 0;
        /*yanpx@20100903为客服 不打印免填单添加 开始*/
        String accountType = (String)session.getAttribute("accountType"); //1 为营业工号 2 为客服工号
        /*结束*/
        
        String op_name =  "互联网电视业务受理";
        
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
        String sql = "select ds.spid,ds.bizcode,ds.biztype from ddsmpordermsg d,ddsmpspbizinfo ds where d.phone_no = '"+activePhone+"' and d.serv_code = '51' and d.opr_code in ('06','05','04','01') and d.spid = ds.spid and d.bizcode = ds.bizcode order by ds.bizcode";
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="loginAccept" />
<wtc:pubselect name="sPubSelect" routerKey="region"
	routerValue="<%=regionCode%>" outnum="3">
	<wtc:sql>
		<%=sql %>
	</wtc:sql>
</wtc:pubselect>
<wtc:array id="callData" scope="end" />
<%
	result = callData;
%>

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
                        document.all.value201.value=custname;
                        document.all.runname.value=runcode;
                        document.form.busy_type.value=document.form.busytype.value;
                        document.all.idNo.value=idNo;
                        document.all.idtype.value=idType;
                        document.all.iccid.value=iccid;
                        
                        //判断用户状态
                        if(document.all.runname.value.substring(1,2)!="A" &&document.all.runname.value.substring(1,2)!="K"){
                						rdShowMessageDialog("用户状态不正常，不允许受理业务!",0);
														return false;
            						}
                        backArrMsg = packet.data.findValueByName("backArrMsg");
                        /*for(var i=0;i<document.form.optype.length;i++)
						            {
						                    document.form.optype.length.options[i]=null;
						            }*/     
						            dyn_deleteAll();
						            if(backArrMsg!=null){
                                for(var i=0; i< backArrMsg.length; i++){
                                	
                                        queryAddAllRow(backArrMsg[i][2],backArrMsg[i][0],backArrMsg[i][1],backArrMsg[i][3]);
                                }
                        }               
                        if(document.all.busytype.value=="03"||document.all.busytype.value=="04"||document.all.busytype.value=="05"||document.all.busytype.value=="13"){
                                document.all.openinfo1.style.display="";
                                document.all.openinfo3.style.display="";
                                document.all.dyntb.style.display="";
                        }else{
                            document.all.openinfo1.style.display="none";
                                document.all.openinfo3.style.display="none";
                                document.all.dyntb.style.display="none";
                        }
                        //qucc add wlan密码改为8位
                        var busy_code=document.all.busytype.value;
                        if(busy_code=="02" || busy_code=="92"){
								        	//设置密码最大长度
									        document.all.NewPasswd.maxLength="8";
									        document.all.ConfirmPasswd.maxLength="8";
									        document.all.modiPasswd.maxLength="8";
								        }
                       	getOperCode();
                       	getRhCount();
                       	getYxCount();
                        getCibpInfo();
                }
                else{
                        rdShowMessageDialog("<br>错误代码:["+error_code+"]</br>错误信息:["+error_msg+"]",0);
                        return false;
                }
        }
        else if(verifyType=="cibpInfo"){
					backArrMsg = packet.data.findValueByName("backArrMsg");
					var despositAct = packet.data.findValueByName("despositAct");
					
					if(despositAct!=""){
						document.all.value313.value=despositAct;
					}
					
					var yximeicount = packet.data.findValueByName("yximeicount");
					document.all.yximeicount.value=yximeicount;
					
					
					
					for(var i=0; i<backArrMsg.length ; i++){
						if(backArrMsg[i][0]=="302"){
							 document.all.value302.value=backArrMsg[i][1];
						}
						else if(backArrMsg[i][0]=="303"){
							 document.all.value303.value=backArrMsg[i][1];
						}
						else if(backArrMsg[i][0]=="304"){
							 document.all.value304.value=backArrMsg[i][1];
						}
						else if(backArrMsg[i][0]=="305"){
							 document.all.value305.value=backArrMsg[i][1];
						}
						else if(backArrMsg[i][0]=="306"){
							 document.all.value306.value=backArrMsg[i][1];
						}
						else if(backArrMsg[i][0]=="311"){
							 document.all.value311.value=backArrMsg[i][1];
						}
						else if(backArrMsg[i][0]=="312"){
							 document.all.value312.value=backArrMsg[i][1];
						}
					}
					if(despositAct=="" && document.all.value311.value==""){//没有押金流水 且imei为空 则需要交押金
							document.all.yajinflag.value='1';
					}else{
							document.all.yajinflag.value='0';
					}
        }
        else if(verifyType=="newspinfo"){
        	backArrMsg = packet.data.findValueByName("backArrMsg");
        	clearRow("newSpinfoTable",1);
        	clearRow("dgSpinfoTable",1);
        	for(var i=0;i<backArrMsg.length;i++){
            		var trTemp = document.getElementById("newSpinfoTable").insertRow();
    				trTemp.insertCell().innerHTML = backArrMsg[i][0];
    				trTemp.insertCell().innerHTML = backArrMsg[i][1];
    				trTemp.insertCell().innerHTML = backArrMsg[i][2];
    				if(backArrMsg[i][3]=="2"){
    					trTemp.insertCell().innerHTML = "包月";
        			}
    				else if(backArrMsg[i][3]=="1"){
    					trTemp.insertCell().innerHTML = "按次/按条计费";
        			}
    				trTemp.insertCell().innerHTML = "<input type='button' class='b_text' name='spCfm' value='订购' onclick='dinggou("+document.getElementById("newSpinfoTable").rows.length+")'>";
            }
         }
        else if(verifyType=="opercode"){
			backArrMsg = packet.data.findValueByName("backArrMsg");
			/*for(var i=0;i<document.form.optype.length;i++)
			{
			document.form.optype.length.options[i]=null;
			}*/
			document.form.optype.length=0;
			document.form.optype.options[document.form.optype.options.length]=new Option("请选择操作类型","");
			for(var i=0; i<backArrMsg.length ; i++){
				var msg = "";
				if(backArrMsg[i][0]=="08"){
					msg = "机顶盒换机";
				}
				else if(backArrMsg[i][0]=="09"){
					msg = "牌照变更";
				}
				else msg = 	backArrMsg[i][1];
				document.form.optype.options[document.form.optype.options.length]=new Option(msg,backArrMsg[i][0]);
			}
				}
        else if(verifyType=="rhcount"){
					backArrMsg = packet.data.findValueByName("backArrMsg");
					document.all.rhcount.value=backArrMsg[0][0];
				}
        else if(verifyType=="yxcount"){
					backArrMsg = packet.data.findValueByName("backArrMsg");
					document.all.yxcount.value=backArrMsg[0][0];
				}
        else if(verifyType=="kdInfo"){

					
          if( parseInt(error_code,10) == 0 ){

						backArrMsg = packet.data.findValueByName("backArrMsg");
						document.all.value305.value=backArrMsg[0][2];
					}else{

							 rdShowMessageDialog("<br>错误代码:["+error_code+"]</br>错误信息:[宽带账号查询失败"+error_msg+"]",0);
                        return false;
					}
				}else if(verifyType=="checkImei"){
					backArrMsg = packet.data.findValueByName("backArrMsg");
					var inputName = packet.data.findValueByName("inputName");
					
					if(backArrMsg.length>0){
						document.getElementById(inputName).value=backArrMsg[0][1];
					}else{

						if(document.all.optype.value=="08" && inputName=="value302"){
							
						}else{
							rdShowMessageDialog("错误信息:IMEI不在库或不是基地魔百盒无法销售",0);
							 return false;
						}
						//document.getElementById(inputName).value="";
//						document.all.value302.value="";
                       
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

function getUserInfo()
{
        document.all.style005.style.display = "none";// wugl add 20090207
        /*
        if(form.busytype.value.length<=0 ||form.busytype.value=="00"){
                rdShowMessageDialog("请选择业务类别!");
                return false;
        }
        */
        if(form.phoneno.value.length<11 || isNumberString(form.phoneno.value,"1234567890")!=1) {
                rdShowMessageDialog("请输入手机号码,长度为11位数字!!");
                document.form.phoneno.focus();
                return false;
        }
        else if (!forMobil(form.phoneno)){
                
                document.form.phoneno.focus();
                return false;
        }
        /* ningtn CRM客服系统功能的需求
        else if(js_pwFlag=="false" && trim(form.accountpassword.value).length<6) {
                rdShowMessageDialog("请输入6位非空用户密码!!");
                document.form.accountpassword.focus();
                return false;
        }
        */
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
        var myPacket = new AJAXPacket("s9118_getCibpInfo.jsp","正在确认，请稍候......");
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
function checkImei(id,name,type)
{

		//document.all.value302.value="12345678901234567890123456789"+id;
		if(id!=""&&id!=null){
	        var myPacket = new AJAXPacket("s9118_checkImei.jsp","正在确认，请稍候......");
	        myPacket.data.add("verifyType","checkImei");
	        myPacket.data.add("imei",id);
	        myPacket.data.add("inputName",name);
	        myPacket.data.add("imeiType",type);
	        core.ajax.sendPacket(myPacket);
	        myPacket = null;
		}              
} 
function queryAddAllRow(switchBizType,switchType,switchName,switchStatus)
{
        var tr1="";
        var i=0;
        var switchStatusName="";
        if(switchStatus=="0"){
                switchStatusName="关";
        }
        else if(switchStatus=="1"){
                switchStatusName="开";
        }
        tr1=dyntb.insertRow();  //注意:插入的必须与下面的在一起,否则造成空行.yl.
        tr1.id="tr"+dynTbIndex;
        
           
cell = tr1.insertCell();
cell.colSpan = 2;       
cell.innerHTML='<div align="center">'+ switchName+'</div>';
        //tr1.insertCell().innerHTML = '<div align="center">'+ switchName+'</div>';
cell2 = tr1.insertCell();
cell2.colSpan = 2; 
cell2.innerHTML='<div align="center"><input id=R2    name="switchName'+switchBizType+'" type=hidden   align="center"  value="'+ switchName+'"  readonly></input><input id=R3    name="switch'+switchBizType+'" type=hidden   align="center"  value="'+ switchStatus+'"  readonly></input>'+ switchStatusName+'</div>';      
        //tr1.insertCell().innerHTML = '<div align="center"><input id=R2    name="switchName'+switchBizType+'" type=hidden   align="center"  value="'+ switchName+'"  readonly></input><input id=R3    name="switch'+switchBizType+'" type=hidden   align="center"  value="'+ switchStatus+'"  readonly></input>'+ switchStatusName+'</div>';      
        dynTbIndex++;
  
}       

function dyn_deleteAll()
{
        //清除增加表中的数据
        for(var a = document.all.dyntb.rows.length-2 ;a>0; a--)//删除从tr1开始，为第三行
        {
            document.all.dyntb.deleteRow(a+1);
        }
}

function isKeyNumberdot(ifdot) 
{       
    var s_keycode=(navigator.appname=="Netscape")?event.which:event.keyCode;
        if(ifdot==0)
                if(s_keycode>=48 && s_keycode<=57)
                        return true;
                else 
                        return false;
    else
    {
        if((s_keycode>=48 && s_keycode<=57) || s_keycode==46)
        {
              return true;
        }
        else if(s_keycode==45)
        {
            rdShowMessageDialog('不允许输入负值,请重新输入!');
            return false;
        }
        else
            return false;
    }       
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

function dochecke177(packet){
	var errorCode = packet.data.findValueByName("errorCode");
	if(errorCode =="000000"){
		var returncode = packet.data.findValueByName("returncode");
		if(returncode=="000000") 
		{
			form.checkflag.value = "0";
			form.checkmsg.value = "success";
		}
		else 
		{
			form.checkflag.value = "1";
			form.checkmsg.value = "尊敬的客户，您可自由退订该主资费中底线消费包含的数据业务，但自行退订后底线消费仍然正常收取，详询10086";
		}
	}
	else
	{
		form.checkflag = "2";
		form.checkmsg.value = "查询主资费是否包含该数据业务时失败";
		return false;

	}
}

function checkOfferSP()
{
	if(document.form.spCode.value=="801234"&&document.form.spBizCode.value=="110301")
	{
		var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/s1141/checkQuitType.jsp","请稍后...");
		packet.data.add("phoneno","<%=activePhone%>");
		packet.data.add("seseq","80007");
		core.ajax.sendPacket(packet,dochecke177);
		packet =null;
	}
}

function docheck(printflag)
{

		var spidlist = "";
		var bizcodelist = "";
		var billingtypelist = "";

		var oldspidlist = "";
		var oldbizcodelist = "";
        if(form.phoneno.value.length<11 || isNumberString(form.phoneno.value,"1234567890")!=1) {
        rdShowMessageDialog("请输入手机号码,长度为11位数字!!");
        document.form.phoneno.focus();
        return false;
        }
        
        //else if (parseInt(form.phoneno.value.substring(0,2),10)!=15 && parseInt(form.phoneno.value.substring(0,3),10)!=188 && parseInt(form.phoneno.value.substring(0,3),10)!=147 && parseInt(form.phoneno.value.substring(0,2),10)!=18 && (parseInt(form.phoneno.value.substring(0,3),10)<134 || parseInt(form.phoneno.value.substring(0,3),10)>139)){
        //rdShowMessageDialog("请输入134-139,15开头的手机号码 !!");
        //document.form.phoneno.focus();
        //return false;
        //}
        if(document.all.runname.value.substring(1,2)!="A" &&document.all.runname.value.substring(1,2)!="K"){
                rdShowMessageDialog("用户状态不正常，不允许受理业务!");
                return false;
        }
        if( form.optype.value==""||form.optype.value=="00") {
        rdShowMessageDialog("请选择交易类型!!");
        document.form.optype.focus();
        return false;
        }
        if(form.optype.value=="06"||form.optype.value=="07") {
	        if(form.spCode.value==""||form.spBizCode.value==""){
	       	 rdShowMessageDialog("请选择企业代码及业务代码!");
	            return false;
	        }
        }
		
        if(form.optype.value=="09") {
	        if(form.spCode.value==""){
	       	 rdShowMessageDialog("请选择企业代码并在新业务信息栏选择订购");
	            return false;
	        }
        }
		
				if(form.optype.value=="06") {
					var stdIMEI = form.value311.value;
	        if(stdIMEI.length<=0) {
	            rdShowMessageDialog("IMEI不能为空");
	            document.form.value311.focus();
	            return false;
	        }
      	}
        var stbId = form.value302.value;
        if(stbId.length!=32) {
            rdShowMessageDialog("机顶盒ID必须为32位，请重新输入IMEI信息");
            document.form.value302.focus();
            return false;
        }

		
        var kdzh = form.value303.value;
        if((kdzh==""||kdzh==null)&&form.optype.value!="07") {
            rdShowMessageDialog("请输入宽带账号");
            document.form.value303.focus();
            return false;
        }
		
      //百事通 20160310修改 去除判断
       // if(form.spCode.value == "699212"&&stbId.substr(12,1)!="2"){
        	//rdShowMessageDialog("机顶盒ID有误,百事通品牌机顶盒ID第十三位必须是为2");
           // document.form.value302.focus();
            //return false;
       // }
        //未来电视
        //if(form.spCode.value == "699213"&&stbId.substr(12,1)!="3"){
        	//rdShowMessageDialog("机顶盒ID有误,未来品牌机顶盒ID第十三位必须是为3");
           // document.form.value302.focus();
           //return false;
        //}
         if(form.optype.value=="06" ||(form.optype.value=="08" && document.form.yajinflag.value =="1")) {
            if(form.value307.value==""){
	            rdShowMessageDialog("请输入押金(金额0-200)");
	            document.form.value307.focus();
	            return false;
            }
            else if(isNaN(form.value307.value)){
            	rdShowMessageDialog("押金请输入正确的数字(金额0-200)");
                document.form.value307.focus();
                return false;
            }
            else if(form.value307.value>200||form.value307.value<0){
            	rdShowMessageDialog("押金请输入正确的数字(金额0-200)");
                document.form.value307.focus();
                return false;
             }
        }
        if(form.optype.value=="08") {
            if(form.value312.value==""){
	            rdShowMessageDialog("机顶盒更换必须填写新机顶盒IMEI");
	            document.form.value312.focus();
	            return false;
            }
            else if(form.value306.value.length!=32){
            	rdShowMessageDialog("新机顶盒ID不是32位，请重新填写新机顶盒IMEI");
                document.form.value312.focus();
                return false;
            }
        }
       	//
       	if(document.all.optype.value=="09"){
           	var flag = false;
	        var dgSpinfoTable = document.getElementById("dgSpinfoTable").rows;
	    	for (var i = 1; i < dgSpinfoTable.length; i++) {
		    	if(dgSpinfoTable[i].cells[1].innerHTML=="20830000"){
			    	flag = true;
			    }
	    		spidlist = spidlist + dgSpinfoTable[i].cells[0].innerHTML+";";
	    		bizcodelist = bizcodelist + dgSpinfoTable[i].cells[1].innerHTML+";";
	    		if(dgSpinfoTable[i].cells[3].innerHTML=="包月"){
	    			billingtypelist = billingtypelist +"2"+";";
	    		}
	    		else{
	    			billingtypelist = billingtypelist +"1"+";";
	           }
	    	}
	    	var ShowId = document.getElementById("ShowId").rows;
	       	for (var i = 1; i < ShowId.length; i++) {
	       		oldspidlist = oldspidlist + ShowId[i].cells[0].innerHTML+";";
	       		oldbizcodelist = oldbizcodelist + ShowId[i].cells[1].innerHTML+";";
	       	}

	        if(flag==false) {
	            rdShowMessageDialog("变更品牌必须办理该品牌基础包");
	            return false;
	        }
	    	document.all.strspid.value = spidlist;
	        document.all.strbizcode.value = bizcodelist;
	        document.all.strbillingtype.value = billingtypelist;
	
	        document.all.stroldspid.value = oldspidlist;
	        document.all.stroldbizcode.value = oldbizcodelist;
       	}
		if(printflag==0){
	        print();
		}
      //打印工单并提交表单
      	else {
	          	if("<%=accountType%>" !="2"){
		        var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes"); 
		        if(typeof(ret)!="undefined")
		        {
		          if((ret=="confirm"))
		          {
		            if(rdShowConfirmDialog('确认电子免填单吗？')==1)
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
	    	}else{
	           if(rdShowConfirmDialog('确认要提交信息吗？')==1)
	           {
	           frmCfm();
	           }    	
	    	}
		    if(form.value307.value>0){
	          	 if(rdShowConfirmDialog('确认要打印收据吗？')==1)
	             {
	             	print();
	             }
		    }
      	}
}

function frmCfm(){
		if(document.all.optype.value=="08"||document.all.optype.value=="09"){
        	document.form.action="s9118_cfm.jsp";
		}
		else document.form.action="s9118_cfm2.jsp";
        form.submit();
        document.form.sure.disabled = true;
        return true;
}
//金额转为汉字
function toChnWord(n) {
    if (!/^(0|[1-9]\d*)(\.\d+)?$/.test(n))
         return "数据非法";
    var unit = "千佰拾亿千佰拾万仟佰拾元角分", str = "";
         n += "00";
    var p = n.indexOf('.');
    if (p >= 0)
         n = n.substring(0, p) + n.substr(p+1, 2);
         unit = unit.substr(unit.length - n.length);
    for (var i=0; i < n.length; i++)
         str += '零壹贰叁肆伍陆柒捌玖'.charAt(n.charAt(i)) + unit.charAt(i);
    return str.replace(/零(仟|佰|拾|角)/g, "零").replace(/(零)+/g, "零").replace(/零(万|亿|元)/g, "$1").replace(/(亿)万|壹(拾)/g, "$1$2").replace(/^元零?|零分/g, "").replace(/元$/g, "元整");
}
//发票打印方法
function print(){
	if(document.all.optype.value!="06" && document.all.optype.value!="08"){
		rdShowMessageDialog('只有服务订购操作需要打印收据!');
        return false;
    }
	var depositFee = form.value307.value;
	var depositFeeBig = toChnWord(depositFee);
	var phoneNo = form.phoneno.value;
	//var loginAccept = "<%=loginAccept%>";
	var loginAccept = document.all.value313.value;
	var custName = document.all.value201.value;
	var boxId = document.all.value302.value;
	var netCode = document.all.value303.value;
	var idtype = document.all.idtype.value;
	var iccid = document.all.iccid.value;
	
	var busiId = "";
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	window.showModalDialog("<%=request.getContextPath()%>/npage/s9118/f4793_print.jsp?loginAccept=<%=loginAccept%>"
				+"&custName="+custName+"&smName=&phoneNo="+phoneNo+"&depositFee="+depositFee+"&depositFeeBig="+depositFeeBig+"&boxId="+boxId+"&netCode="+netCode+"&idtype="+idtype+"&iccid="+iccid
				,'魔百盒押金收据打印成功',prop);
	window.close();
	rdShowMessageDialog('打印成功!');
	
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框 
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1";
	var sysAccept = "<%=loginAccept%>";
	var phone_no = form.phoneno.value;
	var mode_code = null;
	var fav_code = null;
	var area_code = null;
	var printStr = printInfo(printType);
	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
	var path = path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>"+"&sysAccept="+sysAccept+"&phoneNo="+phone_no+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	return ret;    
}

function printInfo(printType)
{
    var cust_info="";  //客户信息
	var opr_info="";   //操作信息
	var note_info1=""; //备注1
	var note_info2=""; //备注2
	var note_info3=""; //备注3
	var note_info4=""; //备注4
	var retInfo = "";  //打印内容
	var spname = "";
	
		
	cust_info+="客户姓名：	"+document.all.value201.value+"|";
	cust_info+="手机号码：	"+document.all.phoneno.value+"|";
	opr_info+="业务类型："+document.all.busytype.options[document.all.busytype.selectedIndex].text+"|";
	opr_info+="操作类型："+document.all.optype.options[document.all.optype.selectedIndex].text+"|";
	opr_info+="SP企业代码："+document.all.spCode.value+"|";
	opr_info+="SP业务代码："+document.all.spBizCode.value+"|";
	if(document.all.spCode.value=="699212"){
		spname = "百事通";
	}
	else if(document.all.spCode.value=="699213"){
		spname = "未来";
	}
	opr_info+="备注:订购业务:魔百和-"+spname+"-包月-10元"+"|";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo = retInfo.replace(new RegExp("#","gm"), "%23");
	return retInfo; 
}

function changeBusyType(){      
        //document.all.phoneno.value="";
        document.all.accountpassword.value="";
        document.all.code201.value="";
        //document.all.runname.value="";
        //document.all.value201.value="";
        document.all.openinfo1.style.display="none";
        document.all.openinfo3.style.display="none";
        document.all.dyntb.style.display="none";
        document.all.optype.value="";
        document.all.spCode.value="";
        document.all.spBizCode.value="";
        document.all.NewPasswd.value="";
        document.all.ConfirmPasswd.value="";
        document.all.opnote.value="";
        
        document.form.value001[0].selected=true;
        document.form.value002[0].selected=true;
        document.form.value003[0].selected=true;
        document.form.value004[0].selected=true;
        document.form.value300[0].selected=true;
        document.form.code301[0].selected=true;
        
        document.all.gddp.style.display="none";
        document.all.psml.style.display="none";
        document.all.cash.style.display="none";
        document.all.cmgp.style.display="none";
        
        document.all.style001.style.display="none";
        document.all.style002.style.display="none";
        document.all.style003.style.display="none";
        document.all.style004.style.display="none";
        //设置密码默认长度
        document.all.NewPasswd.maxLength="6";
        document.all.ConfirmPasswd.maxLength="6";
        document.all.modiPasswd.maxLength="6";
        var busy_code=document.all.busytype.value;
        if(busy_code=="01"||busy_code=="02"){
                document.all.style001.style.display="";
                //document.form.value001[1].selected=true;
                document.all.spinfo.disabled=false;
                document.all.spinfo.style.display="none";
                document.all.style298.style.display="none";
                document.all.style299.style.display="none";
        }
        else if(busy_code=="16"||busy_code=="17"||busy_code=="23"){
                document.form.value001[0].selected=true;
                document.all.psml.style.display="none";
                document.all.style001.style.display="none";
                document.all.gddp.style.display="";
                document.all.spinfo.disabled=false;
                document.all.spinfo.style.display = "";
        }
        else if(busy_code=="15"){
                document.form.value001[0].selected=true;
                document.all.style001.style.display="none";
                document.all.psml.style.display="";
                document.all.spinfo.disabled=true;
                document.all.spinfo.style.display = "none";
                document.all.style298.style.display="none";
                document.all.style299.style.display="none";
        }
        else if(busy_code=="21"){
                document.form.value001[0].selected=true;
                document.all.style001.style.display="none";
                document.all.cash.style.display="";
                document.all.spinfo.disabled=false;
                document.all.spinfo.style.display = "";
                document.all.style298.style.display="none";
                document.all.style299.style.display="none";
        }
        else if(busy_code=="51"){
            document.all.cibp.style.display="";
            document.all.spinfo.disabled=false;
            document.all.spinfo.style.display = "";
    	}
        else{
           	    document.all.cibp.style.display="none";
                document.all.psml.style.display="none";
                document.all.gddp.style.display="none";
                document.all.style001.style.display="none";
                document.form.value001[0].selected=true;
                document.all.spinfo.disabled=false;
                document.all.spinfo.style.display="";
                document.all.style298.style.display="none";
                document.all.style299.style.display="none";
        }
        if(busy_code=="02" || busy_code=="92"){
        	//设置密码最大长度
	        document.all.NewPasswd.maxLength="8";
	        document.all.ConfirmPasswd.maxLength="8";
	        document.all.modiPasswd.maxLength="8";
        }
        document.all.openinfo1.style.display="none";
        document.all.openinfo3.style.display="none";
        document.all.dyntb.style.display="none";
        //密码问题和密码答案域始终不现实
        document.all.style298.style.display="none";
        document.all.style299.style.display="none";
        /**** ningtn CRM客服系统****/
        getUserInfo();
        
}

function changeOpType() {       
        var i = form.optype.value;
        if((i=="09"||i=="07")&&(document.all.rhcount.value>0||document.all.yxcount.value>0)){
            var notice = "";
            if(document.all.rhcount.value>0){
            	notice = "融合套餐用户";
            }
            if(document.all.yxcount.value>0){
            	notice = "已办理特定营销案的用户";
            }
            if(i=="09") rdShowMessageDialog(notice+"不可以变更牌照",0);
            else if(i=="07") rdShowMessageDialog(notice+"不可以退订",0);
          	form.optype.value = "";
          	 return false;
        }
       if(i=="08" && document.all.yximeicount.value>0){
       		rdShowMessageDialog("营销活动办理的魔百和不可以机顶盒换机",0);
       		form.optype.value = "";
          return false;
       }
       if(i=="06" || (i=="08" && document.form.yajinflag.value =="1")){
    	   document.all.yajin.style.display = "";
       }
       else {
       		document.all.yajin.style.display = "none";
       }
       if(i=="06"||i=="07"||i=="09"){
    	   document.all.spinfo.style.display = "";
       }
       else document.all.spinfo.style.display = "none";
       if(i=="08"&&document.all.value302.value!=""){
    	   //document.all.value306.value="003903FF00210070";
    	   document.all.value311.readOnly=true;
    	  
        }else{
        	 document.all.value311.readOnly=false;
        }
      if(i=="09"){
	   	      document.all.dgSpinfoTable.style.display = "";
	   	      document.all.newSpinfoTable.style.display = "";
	   		  document.form.spBizCode.disabled = true;
	   		  document.form.spBipQuery.disabled = true;
	   		  document.form.value306.value = "";
      }
      else{
   	   document.all.dgSpinfoTable.style.display = "none";
   	   document.all.newSpinfoTable.style.display = "none";
   	   document.form.spBizCode.disabled = false;
  		document.form.spBipQuery.disabled = false;
      }
}

function form_load()
{
	
        document.all.gddp.style.display="none";
        var busy_code=document.all.busytype.value;
        if(busy_code=="01"||busy_code=="02"){
                document.all.style001.style.display="";
                //document.form.value001[1].selected=true;
                                        document.all.spinfo.disabled=false;
                document.all.spinfo.style.display="";
                document.all.style298.style.display="none";
                document.all.style299.style.display="none";
                if(busy_code=="01") {
                        document.all.style001.style.display="none";
                }
        }
        else if(busy_code=="10"){
                document.form.value001[0].selected=true;
                document.all.style002.style.display="";
                document.all.style003.style.display="";
                document.all.style004.style.display="";
        }
        else if(busy_code=="17"){
                document.all.gddp.style.display="";
                document.all.spinfo.disabled=false;
                document.all.spinfo.style.display = "";
        }
        
}       
        
function getSpInfo(){
        var idNo=document.all.idNo.value;
    if(idNo.length<=0){
        rdShowMessageDialog("请先查询手机信息！",0);
        return false;
    }
    var optype=document.all.optype.value;
    if(optype.length<=0){
        rdShowMessageDialog("请先选择交易类型！",0);
        return false;
    }
    var idFlag=idNo.substring(idNo.length-1,idNo.length);
    var phoneNo=document.all.phoneno.value;
    var busytype=document.all.busytype.value;
    var pageTitle = "SP企业信息查询";
        var fieldName = "sp企业代码|sp企业名称|sp企业英文名称|";
        var sqlStr ="select a.SPID,decode(a.SPNAME,null,a.spshortname,a.SPNAME) SPNAME,a.spenname from DDSMPSPINFO a,sOBSpType b where trim(a.spid) between b.beginspid and b.endspid and a.SPSTATUS='A' and a.BIZTYPE= :busytype and a.spid in (select distinct c.spid from DDSMPSPBIZINFO c where c.BIZSTATUS='A')";
        var varStr="busytype="+busytype;
        if(optype=="99" ||optype=="07"||optype=="02"){
                sqlStr ="select a.SPID,decode(a.SPNAME,null,a.spshortname,a.SPNAME) SPNAME,a.spenname from DDSMPSPINFO a,sOBSpType b where trim(a.spid) between b.beginspid and b.endspid and a.BIZTYPE= :busytype and a.spid in (select distinct c.spid from DDSMPORDERMSG"+idFlag+" c where c.phone_no=:phoneNo and c.opr_code<>'02' and c.opr_code<>'07' and c.opr_code<>'17')";
                varStr="busytype="+busytype+",phoneNo="+phoneNo;
        }
        if(optype=="04"){
                sqlStr ="select a.SPID,decode(a.SPNAME,null,a.spshortname,a.SPNAME) SPNAME,a.spenname from DDSMPSPINFO a,sOBSpType b where trim(a.spid) between b.beginspid and b.endspid and a.BIZTYPE= :busytype and a.spid in (select distinct c.spid from DDSMPORDERMSG"+idFlag+" c where c.phone_no=:phoneNo and c.opr_code<>'06' and c.opr_code<>'05' and c.opr_code<>'01')";
                varStr="busytype="+busytype+",phoneNo="+phoneNo;
        }
        if(optype=="05"){
                sqlStr ="select a.SPID,decode(a.SPNAME,null,a.spshortname,a.SPNAME) SPNAME,a.spenname from DDSMPSPINFO a,sOBSpType b where trim(a.spid) between b.beginspid and b.endspid and a.BIZTYPE= :busytype and a.spid in (select distinct c.spid from DDSMPORDERMSG"+idFlag+" c where c.phone_no=:phoneNo and c.opr_code<>'04')";
                varStr="busytype="+busytype+",phoneNo="+phoneNo;
        }
        var selType = "S";    //'S'单选；'M'多选
        var retQuence = "3|0|1|2|";
        var retToField = "spCode|";
        var serviceName="TlsPubSelCrm";
        var routerKey="userno";
        var routerValue=idNo;
        if(PubSimpSel_BD(pageTitle,fieldName,sqlStr,varStr,selType,retQuence,retToField,serviceName,routerKey,routerValue));
}

function getSpBizInfo(val){
    if(val.length<=0 ||val=="undefined"||val=="[object]"){
        rdShowMessageDialog("请先选择企业代码！",0);
        document.form.spCode.value="";
        document.form.spQuery.focus();
        return false;
    }
    var idNo=document.all.idNo.value;
    if(idNo.length<=0){
        rdShowMessageDialog("请先查询手机信息！",0);
        return false;
    }
    var optype=document.all.optype.value;
    if(optype.length<=0){
        rdShowMessageDialog("请先选择交易类型！",0);
        return false;
    }
    var busytype=document.all.busytype.value;
    var idFlag=idNo.substring(idNo.length-1,idNo.length);
    var spCode=document.all.spCode.value;
    var phoneNo=document.all.phoneno.value;
    
    var pageTitle = "SP业务信息查询";
        var fieldName = "sp业务代码|sp业务名称|业务描述|";
        var sqlStr ="select b.bizcode,b.servname,b.BIZDESC from DDSMPSPINFO a,DDSMPSPBIZINFO b where  a.SPID=b.SPID and  b.BIZSTATUS='A' and a.SPID=:spid";
        var varStr="spid="+spCode;
        
        if(optype=="99" ||optype=="07"||optype=="02"){
                sqlStr ="select b.bizcode,b.servname,b.BIZDESC from DDSMPSPINFO a,DDSMPSPBIZINFO b where  a.SPID=b.SPID and a.SPID=:spid and b.bizcode in (select c.bizcode from DDSMPORDERMSG"+idFlag+" c where c.phone_no=:phoneNo and c.opr_code<>'02' and c.opr_code<>'07' and c.opr_code<>'17')";
                varStr="spid="+spCode+",phoneNo="+phoneNo;
        }
        if(optype=="04"){
                sqlStr ="select b.bizcode,b.servname,b.BIZDESC from DDSMPSPINFO a,DDSMPSPBIZINFO b where  a.SPID=b.SPID and a.SPID=:spid and b.bizcode in (select distinct c.bizcode from DDSMPORDERMSG"+idFlag+" c where c.phone_no=:phoneNo and c.opr_code<>'06' and c.opr_code<>'05' and c.opr_code<>'01')";
                varStr="spid="+spCode+",phoneNo="+phoneNo;
        }
        if(optype=="05"){
                sqlStr ="select b.bizcode,b.servname,b.BIZDESC from DDSMPSPINFO a,DDSMPSPBIZINFO b where  a.SPID=b.SPID and a.SPID=:spid and b.bizcode in (select distinct c.bizcode from DDSMPORDERMSG"+idFlag+" c where c.phone_no=:phoneNo and c.opr_code<>'04')";
                varStr="spid="+spCode+",phoneNo="+phoneNo;
        }
        var selType = "S";    //'S'单选；'M'多选
        var retQuence = "3|0|1|2|";
        var retToField = "spBizCode|";
        var serviceName="TlsPubSelCrm";
        var routerKey="userno";
        var routerValue=idNo;
        if(PubSimpSel_BD(pageTitle,fieldName,sqlStr,varStr,selType,retQuence,retToField,serviceName,routerKey,routerValue));
}

function spBizQry(){
        var busytype=document.all.busytype.value;
        var optype = document.all.optype.value;
        var spBizCode= document.all.spBizCode.value;
        var spCode= document.all.spCode.value;
        var phoneno= document.all.phoneno.value;
        var thirdNo= document.all.thirdNo.value;
        if(busytype=="00"){
                rdShowMessageDialog("请选择业务类型！");
                return false;
        }
        if(optype==""){
                rdShowMessageDialog("请选择交易类型！");
                return false;
        }
        if(spCode==""){
                rdShowMessageDialog("请选择SP代码！");
                return false;
        }
        var path1 ="../s9126/f9126_1.jsp?bizType="+busytype+"&optype="+optype+"&spCode="+spCode+"&spBizCode="+spBizCode+"&ifCall=true"+"&phoneno="+phoneno+"&thirdNo="+thirdNo;
        window.open(path1,"newwindow","height=450, width=790,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

}

function spQry(){
        var busytype=document.all.busytype.value;
        var optype = document.all.optype.value;
        var spCode= document.all.spCode.value;
        var phoneno= document.all.phoneno.value;
        var path ="../s9125/f9125_2.jsp?bizType="+busytype+"&optype="+optype+"&spCode="+spCode+"&ifCall=true"+"&phoneno="+phoneno;
        window.open(path,"newwindow","height=450, width=790,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");     
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
function spvalueChange(){
	if(document.all.optype.value=="06"||document.all.optype.value=="09"){
		if(document.all.spCode.value=="699212"){
			document.all.value302.value="003903FF00210070";
			}
		else if(document.all.spCode.value=="699213"){
			document.all.value302.value="003903FF00210070";
		}
	}
}
function spinfoChange(){
	//spvalueChange();
	if(document.all.spCode.value!=""){
		  var myPacket = new AJAXPacket("s9118_getNewSpInfo.jsp","正在确认，请稍候......");
	        myPacket.data.add("verifyType","newspinfo");
	        myPacket.data.add("spid",document.all.spCode.value);
	        core.ajax.sendPacket(myPacket);
	        myPacket = null;
	}
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
<div id="title_zi">互联网电视业务受理</div>
</div>
<input type="hidden" name="busy_type" value="1"> <input
	type="hidden" name="custpassword" value=""> <input
	type="hidden" name="busy_name" value=""> <input type="hidden"
	name="busy_name" value=""> <input type="hidden"
	name="checkflag" value="0"> <input type="hidden"
	name="checkmsg" value=""> <input type="hidden"
	name="loginAccept" value="<%=loginAccept%>" />
	<input type="hidden" name="rhcount" value="">
	<input type="hidden" name="yxcount" value="">
	<input type="hidden" name="yximeicount" value="">
	<input type="hidden" name="yajinflag" value="">
	
	<input type="hidden" name="dgflag" value="0">
		<input type="hidden" name="idtype" value="">
		<input type="hidden" name="iccid" value="">
		
		<input type="hidden" name="loginNo" id="loginNo" value="<%=loginNo%>">
	
<table cellSpacing="0">
	<tr>
		<td class=blue>手机号码</td>
		<td><input type="text" name="phoneno" id="phoneno" readonly
			value="<%=activePhone%>" onchange="chgPhone()" size="40"> <input
			type="hidden" name="accountpassword" maxlength="6" /></td>
		<td class=blue>业务类别</td>
		<td><select name="busytype" class="button" style="width:250px">
			<option value="51">互联网电视</option>
		</select></td>
	</tr>
	<tr>
		<td class=blue>
		<div>用户姓名</div>
		</td>
		<td><input type="text" readonly name="value201" value="" size="40">
		<input type="hidden" class="button" readonly name="code201"
			value="201"></td>
		<td class=blue>
		<div>运行状态</div>
		</td>
		<td><input type="text" readonly name="runname" value="" size="40">
		</td>
	</tr>
	<tr id="openinfo1" style="display: none">
		<th colspan="4" align="center">梦网业务开关状态信息</th>
	</tr>
	<tbody id="dyntb" align="center">
		<tr id="openinfo3" style="display: none">
			<td class=blue align="center" colspan=2><B>开关类型</B></td>
			<td class=blue align="center" colspan=2><B>开关状态</B></td>
		</tr>
		<tr id="tr0" style="display: none">
			<td colspan=2>
			<div align="center"><input type="text" align="left" id="R1"
				value=""></div>
			</td>
			<td colspan=2>
			<div align="center"><input type="text" align="left" id="R2"
				value=""></div>
			</td>
		</tr>
	</tbody>
	<tr>
		<td class=blue>
		<div>交易类型</div>
		</td>
		<td colspan=3><select name="optype" class="button" onChange="changeOpType()" style="width:250px">
			<option class="button" value="">请选择交易类型</option>
		</select></td>
	</tr>
	<tr id="spinfo"  style="display:none">
                  <td class=blue><div >SP企业代码</div></td>
                  <td id="spinfo1">
                  <!-- onpropertychange="spinfoChange()" -->
                    <input type="text" name="spCode" value="" maxlength="6"  onpropertychange="spinfoChange()" size="40">
                        <input type="button" class="b_text" name="spQuery" value="查询" onclick="spQry()">
                  </td>
                  <td id="spbizinfo3" class=blue><div >SP业务代码</div></td>
                  <td id="spinfo3">
                         <input type="text" name="spBizCode" value="" maxlength="12" size="40">
                        <input type="button" class="b_text" name="spBipQuery" value="查询" onclick="spBizQry()">
                  </td>
     </tr>
	<tr id="style005" style="display: none">
		<td class=blue>赠送手机号</td>
		<td colspan="3"><input type="text" name="thirdNo"
			v_type="mobilephone" maxlength="11"></td>
	</tr>
	<tr id="modiPass" style="display: none">
		<td class=blue>
		<div>新业务密码</div>
		</td>
		<td colspan=3><input type="password" maxlength="6"
			name="modiPasswd"></td>
	</tr>
	<tr id="style298" style="display: none">
		<td class=blue>
		<div>密码问题</div>
		</td>
		<td colspan=3><input type="text" name="value298"> <input
			type="hidden" class="button" readonly name="code298" value="298">
		</td>
	</tr>
	<tr id="style299" style="display: none">
		<td class=blue>
		<div>密码答案</div>
		</td>
		<td colspan=3><input type="text" name="value299"> <input
			type="hidden" class="button" readonly name="code299" value="299">
		</td>
	</tr>
	<tr id="style002" style="display: none">
		<td class=blue>
		<div>密码使用方式</div>
		</td>
		<td colspan=3><select name="value002">
			<option value="" selected>请选择密码使用方式</option>
			<option value="1">使用密码</option>
			<option value="0">不使用密码</option>
		</select> <input type="hidden" class="button" readonly name="code002"
			value="002"></td>
	</tr>

	<tr id="style003" style="display: none">
		<td class=blue>
		<div>套餐编号</div>
		</td>
		<td colspan=3><select name="value003">
			<option value="" selected>请选择套餐编号</option>
			<option value="01">集团客户业务</option>
			<option value="02">集团客户扩展业务</option>
		</select> <input type="hidden" class="button" readonly name="code003"
			value="003"></td>
	</tr>
	<tr id="style004" style="display: none">
		<td class=blue>
		<div>同步逻辑</div>
		</td>
		<td colspan=3><select name="value004">
			<option value="" selected>请选择同步逻辑</option>
			<option value="1">以服务器为准</option>
			<option value="0">以终端为准</option>
			<option value="2">互相忽略</option>
		</select> <input type="hidden" class="button" readonly name="code004"
			value="004"></td>
	</tr>
	<!--17201相关属性-->
	<tr id="style001" style="display: none">
		<td class=blue>
		<div>漫游方式</div>
		</td>
		<td colspan=3><select name="value001">
			<option value="10" selected>国内国际漫游Web认证</option>
			<option value="11">国内国际连同自动认证</option>
			<option value="12">追加国际自动认证</option>
		</select> <input type="hidden" class="button" readonly name="code001"
			value="001"></td>
	</tr>
	<!--通用下载相关-->
	<tr id="gddp" style="display: none">
		<td class=blue>
		<div>套餐包号</div>
		</td>
		<td><input type="text" name="PackNumb" value=""></td>
		<td class=blue>
		<div>增值业务代码</div>
		</td>
		<td><input type="text" name="ServCode" value=""></td>
	</tr>
	<!--PUSHMAIL相关-->
	<tr id="psml" style="display: none">
		<td class=blue>
		<div>PushMail业务类别</div>
		</td>
		<td colspan=3><select name="value300">
			<option value="" selected>请选择业务类别</option>
			<option value="01">集团业务</option>
			<option value="02">个人业务</option>
		</select> <input type="hidden" class="button" readonly name="code300"
			value="300"></td>
	</tr>
	<!--手机钱包相关-->
	<tr id="cash" style="display: none">
		<td class=blue>
		<div>帐户类别</div>
		</td>
		<td><select name="code301">
			<option value="" selected>请选择帐户类别</option>
			<option value="001">银行帐户</option>
			<option value="002">充值帐户</option>
			<option value="003">话费帐户</option>
		</select></td>
		<td class=blue>
		<div>帐户号码</div>
		</td>
		<td><input type="text" name="value301" value=""></td>
	</tr>
	<!--游戏平台相关-->
	<tr id="cmgp" style="display: none">
		<td class=blue>
		<div>充值金额</div>
		</td>
		<td colspan=3><input type="text" name="cmgp001" value="">
		</td>
	</tr>
	<!--互联网电视相关-->
	<tbody id="cibp">
		<tr id="cibp01">
			<td class=blue>
			<div>机顶盒IMEI</div>
			</td>
			<td><input type="text" name="value311" value="" size="40" maxlength="32" onblur="checkImei(this.value,'value302','1')"> 
				<input type="hidden" class="button"  name="code311" value="311">
			</td>
			<td class=blue>
			<div>新机顶盒IMEI</div>
			</td>
			<td><input type="text" name="value312" value="" size="40" maxlength="32" onblur="checkImei(this.value,'value306','2')"> 
					<input type="hidden" class="button"  name="code312" value="312">
			</td>
		</tr>
		<tr id="cibp03">
			<td class=blue>
			<div>机顶盒ID</div>
			</td>
			<td>
				<input id="value302" type="text" name="value302" value="" size="40" maxlength="32" readonly="readonly"> 
				<input type="hidden" class="button"  name="code302" value="302">
			</td>
			<td class=blue>
			<div>新机顶盒ID</div>
			</td>
			<td>
					<input id="value306" type="text" name="value306" value="" size="40" maxlength="32" readonly="readonly"> 
					<input type="hidden" class="button"  name="code306" value="306">
			</td>
		</tr>
		<tr id="cibp02">
			<td class=blue>
			<div>宽带账号</div>
			</td>
			<td><input type="text" name="value303" value="" size="40" maxlength="32" onblur="getKdInfo(this.value)"> 
				<input type="hidden" class="button"  name="code303" value="303">
				
			</td>
			<td class=blue>
			<div>邮政编码</div>
			</td>
			<td><input type="text" name="value304" value="" size="40" maxlength="6" > <input
				type="hidden" class="button"  name="code304" value="304">
			</td>
		</tr>
		<tr id ="yajin" style="display:none">
			<td class=blue>
			<div>押金</div>
			</td>
			<td colspan="3">
			<input type="text" name="value307" value="" size="40" maxlength="6" >
			<input type="hidden" name="value313" value="<%=loginAccept%>">
			</td>
		</tr>
		<tr id="cibp02">
			<td class=blue>
			<div>装机地址</div>
			</td>
			<td  colspan="3"><input type="text" name="value305" value=""
				size="60" maxlength="40" class="InputGrey"> <input
				type="hidden" class="button" readonly name="code305" value="305">
			</td>
		</tr>
		
	</tbody>
</table>
<div class="title">
<div id="title_zi">已办理业务信息</div>
</div>
<table cellspacing="0" id="ShowId">
	<tr id="ShowTotalId">
		<th>
		<div align="center" width="25%">SP企业代码</div>
		</th>
		<th>
		<div align="center" width="25%">业务代码</div>
		</th>
		<th>
		<div align="center" width="25%">业务名称</div>
		</th>
	</tr>
	<%
              	if(result!= null)
              	{
			    	recNum = result.length ;
				}
			 	if(recNum<1){%>
	<tr>
		<td colspan="12" align="center"><b><font class="orange">无查询结果</font></td>
	</tr>
	<%}else{%>
	<%
          		for(int i=0;i<recNum;i++){
                String tdClass = "";            
                if (i%2==0){
                     tdClass = "Grey";
                }
		  	  %>
	<tr onmouseout="this.style.backgroundColor=''"
		onmouseover="this.style.backgroundColor='#E8E8E8';;this.style.cursor='hand'">
		<td class="<%=tdClass%>">
		<%=result[i][0]%>
		</td>
		<td class="<%=tdClass%>">
		<%=result[i][1]%>
		</td>
		<td class="<%=tdClass%>">
		<%=result[i][2]%>
		</td>
	</tr>
	<%}}%>
</table>
<div class="title">
<div id="title_zi">新业务信息</div>
</div>
<table id="newSpinfoTable" cellSpacing="0" style="display: none">
	<!--<tr id="style05">
		<td class="blue" colspan=6><input type="text" name="spCode"
			value="" maxlength="6" onpropertychange="spinfoChange()"><input
			type="button" class="b_text" name="spQuery" value="查询"
			onclick="spQry()"></td>
	</tr>
	--><tr id="ShowTotalId">
		<th>
		<div align="center">SP企业代码</div>
		</th>
		<th>
		<div align="center">业务代码</div>
		</th>
		<th>
		<div align="center">业务名称</div>
		</th>
		<th>
		<div align="center">计费类型</div>
		</th>
		<th>
		<div align="center">操作</div>
		</th>
	</tr>
</table>
<div class="title">
<div id="title_zi">受理列表</div>
</div>
<table id="dgSpinfoTable" cellSpacing="0" style="display: none">
	<tr id="ShowTotalId">
		<th>
		<div align="center">SP企业代码</div>
		</th>
		<th>
		<div align="center">业务代码</div>
		</th>
		<th>
		<div align="center">业务名称</div>
		</th>
		<th>
		<div align="center">计费类型</div>
		</th>
		<th>
		<div align="center">操作</div>
		</th>
	</tr>
</table>
<table cellspacing="0">
	<tr>
		<td align=center id="footer" colspan="4"><input type="hidden"
			class="button" name="bizType" value=""><input type="hidden"
			class="button" name="idNo" value=""><input type="hidden"
			name="oprSource" value="08"><input class="b_foot" name=sure
			type=button value=确认 onclick="docheck()"> &nbsp; <input
			class="b_foot" name=reset type=reset value=关闭
			onClick="removeCurrentTab()"> </td>
	</tr>
		<input type="hidden" class="button" name="strspid" value="">
        <input type="hidden" class="button" name="strbizcode" value="">
        <input type="hidden" class="button" name="strbillingtype" value="">
        <input type="hidden" class="button" name="stroldspid" value="">
        <input type="hidden" class="button" name="stroldbizcode" value="">
</table>
<%@include file="/npage/include/footer.jsp"%></FORM>
</BODY>
</HTML>
