<%
/********************
 * version v2.0
 * 开发商: si-tech
 * update by qidp @ 2009-02-05
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%
        	String opCode = "9911";
          String opName = "手机邮箱商用申请";
          
        String workNo = (String)session.getAttribute("workNo");
        String workName = (String)session.getAttribute("workName");
        String regionCode=(String)session.getAttribute("regCode");
        String op_name =  "用户信息服务功能受理";
        
        //ArrayList arr = (ArrayList)session.getAttribute("allArr");
        //String[][] baseInfo = (String[][])arr.get(0);
        
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
        
        String accountType = (String)session.getAttribute("accountType");
        if(accountType==null) accountType = "1";
        System.out.println("------------------accountType-------------------"+accountType);
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE><%=op_name%></TITLE>
        
<script language="JavaScript">
<!--

//定义应用全局的变量
var SUCC_CODE   = "0";                  //自己应用程序定义
var ERROR_CODE  = "1";                  //自己应用程序定义
var YE_SUCC_CODE = "000000";            //根据营业系统定义而修改
var dynTbIndex=1;                               //用于动态表数据的索引位置,开始值为1.考虑表头

var js_pwFlag="false";
js_pwFlag="<%=pwrf%>";

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
                        document.all.value201.value=custname;
                        document.all.runname.value=runcode;
                        document.form.busy_type.value=document.form.busytype.value;
                        document.all.idNo.value=idNo;
                        //判断用户状态
                        if(document.all.runname.value.substring(1,2)!="A" &&document.all.runname.value.substring(1,2)!="K"){
                rdShowMessageDialog("用户状态不正常，不允许受理业务!",0);
                                return false;
            }
                        backArrMsg = packet.data.findValueByName("backArrMsg");
 
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
                        getOperCode();
                }
                else{
                        rdShowMessageDialog("<br>错误代码:["+error_code+"]</br>错误信息:["+error_msg+"]",0);
                        return false;
                }
        }
        else if(verifyType=="opercode"){
                backArrMsg = packet.data.findValueByName("backArrMsg");
 
               
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
        if(form.busytype.value.length<=0 ||form.busytype.value=="00"){
                rdShowMessageDialog("请选择业务类别!");
                return false;
        }
        if(form.phoneno.value.length<11 || isNumberString(form.phoneno.value,"1234567890")!=1) {
                rdShowMessageDialog("请输入手机号码,长度为11位数字!!");
                document.form.phoneno.focus();
                return false;
        }
        else if (!forMobil(form.phoneno)){
                
                document.form.phoneno.focus();
                return false;
        }
        else if(js_pwFlag=="false" && trim(form.accountpassword.value).length<6) {
                rdShowMessageDialog("请输入6位非空用户密码!!");
                document.form.accountpassword.focus();
                return false;
        }
        //免密码
        var accountpassword=document.form.accountpassword.value;
        if(js_pwFlag=="true"){
                accountpassword="";
        }
        var myPacket = new AJAXPacket("f9911_rpc_check.jsp","正在确认，请稍候......");
        
        myPacket.data.add("verifyType","phoneno");
        myPacket.data.add("phoneno",document.form.phoneno.value);
        myPacket.data.add("passwd",accountpassword);
        core.ajax.sendPacket(myPacket);
        myPacket = null;                
}

function getOperCode()
{
        var myPacket = new AJAXPacket("f9911_oper_code.jsp","正在确认，请稍候......");
        myPacket.data.add("verifyType","opercode");
        myPacket.data.add("busytype",document.form.busytype.value);
        core.ajax.sendPacket(myPacket);
        myPacket = null;                
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

function docheck()
{
				
				
        if(form.opnote.value.length<1){
                        form.opnote.value=form.phoneno.value+form.optype.options[form.optype.selectedIndex].innerText+form.busytype.options[form.busytype.selectedIndex].innerText+"业务";                      
        }
        var busy_code=document.all.busytype.value;
        
        if(form.phoneno.value.length<11 || isNumberString(form.phoneno.value,"1234567890")!=1) {
        rdShowMessageDialog("请输入手机号码,长度为11位数字!!");
        document.form.phoneno.focus();
        return false;
        }
        else if (parseInt(form.phoneno.value.substring(0,2),10)!=15 && parseInt(form.phoneno.value.substring(0,3),10)!=188 && parseInt(form.phoneno.value.substring(0,2),10)!=18 && (parseInt(form.phoneno.value.substring(0,3),10)<134 || parseInt(form.phoneno.value.substring(0,3),10)>139)){
        rdShowMessageDialog("请输入134-139,15开头的手机号码 !!");
        document.form.phoneno.focus();
        return false;
        }
        if(document.all.runname.value.substring(1,2)!="A" &&document.all.runname.value.substring(1,2)!="K"){
                rdShowMessageDialog("用户状态不正常，不允许受理业务!");
                return false;
        }
        if( form.optype.value==""||form.optype.value=="00") {
        rdShowMessageDialog("请选择交易类型!!");
        document.form.optype.focus();
        return false;
        }
         
       
 
        //else if((busy_code=="01"||busy_code=="02")&&form.optype.value=="01"){
        if((busy_code=="02")&&form.optype.value=="01"){
            if(form.value001.value=="01"){
                    rdShowMessageDialog("不能单独开通国际漫游!");
                    document.form.value001.focus();
                    return false;
            }else if(form.value001.value==""){
                    rdShowMessageDialog("请选择你需要的漫游业务!");
                    document.form.value001.focus();
                    return false;
            }
        }
        //else if((busy_code=="01"||busy_code=="02")&&(form.optype.value=="02"||form.optype.value=="04")&&form.value001.value=="10"){
        else if((busy_code=="02")&&(form.optype.value=="02"||form.optype.value=="04")&&form.value001.value=="10"){
                rdShowMessageDialog("不能单独取消国内业务!");
                document.form.value001.focus();
                return false;
        }
        //else if((busy_code=="01"||busy_code=="02")&&(form.optype.value=="02"||form.optype.value=="04")&&form.value001.value=="12"){
        else if((busy_code=="02")&&(form.optype.value=="02"||form.optype.value=="04")&&form.value001.value=="12"){
                rdShowMessageDialog("不能单独取消国际漫游业务!");
                document.form.value001.focus();
                return false;
        }
        if(busy_code=="10"){
                document.form.value201.value="";
        }
        if(busy_code=="03"||busy_code=="04"||busy_code=="05"||busy_code=="13"){
                //判断梦网开关
                var switchType="switch99";
                var switchName="switchName99";
                //if(form[eval('switchType')].value=="0"){
                //      rdShowMessageDialog(form[eval('switchName')].value+"已关闭，不能受理任何梦网业务!");
                //      return false;
                //}
                switchType="switch"+busy_code;
                switchName="switchName"+busy_code;
                if(form[eval('switchType')].value=="0"){
                        rdShowMessageDialog(form[eval('switchName')].value+"开关已关闭，不允许受理业务!");
                        return false;
                }
              
        }
        
 
     
      


        //打印工单并提交表单
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
}

function frmCfm(){
        
        if(document.all.busytype.value=="Y2") document.all.busytypeHit.value = "YX20"; //数据库中字段长度最大2位，这里增加
				if(document.all.busytype.value=="Y5") document.all.busytypeHit.value = "YX5"; //数据库中字段长度最大2位，这里增加
				if(document.all.busytype.value=="16") document.all.busytypeHit.value = "YX"; //数据库中字段长度最大2位，这里增加
								
				if(document.all.optype.value=="23"){
					document.all.busytypeHit.value = "KT" + document.all.busytypeHit.value;
				}else if(document.all.optype.value=="24"){
					document.all.busytypeHit.value = "QX" + document.all.busytypeHit.value;
				}else if(document.all.optype.value=="25"){
					document.all.busytypeHit.value = "HFYX";
				}
				
        document.form.action="f9911_2.jsp";
        form.submit();
        document.form.sure.disabled = true;
        return true;
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框 
   var h=198;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   
   var printStr = printInfo(printType);
   
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var path = "<%=request.getContextPath()%>/npage/innet/hljPrint.jsp?DlgMsg=" + DlgMessage;
   var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
   var ret=window.showModalDialog(path,"",prop);
   return ret;    
}

function printInfo(printType)
{
        var retInfo = "";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+='操作员：<%=workNo%>'+' '+'<%=workName%>'+"        ";  
        retInfo+='受理时间：<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
        retInfo+="用户号码："+document.all.phoneno.value+"|";
        retInfo+="用户姓名："+document.all.value201.value+"|";
        retInfo+="业务类型："+document.all.busytype.options[document.all.busytype.selectedIndex].text+"|";
        retInfo+="操作类型："+document.all.optype.options[document.all.optype.selectedIndex].text+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        retInfo+=" "+"|";
        return retInfo; 
}

function changeBusyType(){      
        document.all.phoneno.value="";
        document.all.accountpassword.value="";
        document.all.code201.value="";
        document.all.runname.value="";
        document.all.value201.value="";
        document.all.openinfo1.style.display="none";
        document.all.openinfo3.style.display="none";
        document.all.dyntb.style.display="none";
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

        document.all.iChnSourceTr.style.display = "none";
                
        
        var busy_code=document.all.busytype.value;
        if(busy_code=="01"||busy_code=="02"){
                document.all.style001.style.display="";
                document.form.value001[1].selected=true;
                document.all.spinfo.disabled=false;
                document.all.style298.style.display="none";
                document.all.style299.style.display="none";
        }
        else if(busy_code=="10"){
                document.form.value001[0].selected=true;
                document.all.psml.style.display="none";
                document.form.value001[0].selected=true;
                document.all.style002.style.display="";
                document.all.style003.style.display="";
                document.all.style004.style.display="";
        }
        else if(busy_code=="17"||busy_code=="23"){
                document.form.value001[0].selected=true;
                document.all.psml.style.display="none";
                document.all.style001.style.display="none";
                document.all.gddp.style.display="";
        }
        else if(busy_code=="15"){
                document.form.value001[0].selected=true;
                document.all.style001.style.display="none";
                document.all.psml.style.display="";
                document.all.style298.style.display="none";
                document.all.style299.style.display="none";
        }
        else if(busy_code=="21"){
                document.form.value001[0].selected=true;
                document.all.style001.style.display="none";
                document.all.cash.style.display="";
                document.all.style298.style.display="none";
                document.all.style299.style.display="none";
        }
        else if(busy_code=="16"||busy_code=="Y2"||busy_code=="Y5"){
        	      document.form.value001[0].selected=true;
                document.all.style001.style.display="none";
                document.all.style298.style.display="none";
                document.all.style299.style.display="none";
                
                document.all.iChnSourceTr.style.display = "";
                
        	
        }else{
                document.all.psml.style.display="none";
                document.all.gddp.style.display="none";
                document.all.style001.style.display="none";
                document.form.value001[0].selected=true;
                document.all.style298.style.display="none";
                document.all.style299.style.display="none";
        }
        document.all.openinfo1.style.display="none";
        document.all.openinfo3.style.display="none";
        document.all.dyntb.style.display="none";
        //密码问题和密码答案域始终不现实
        document.all.style298.style.display="none";
        document.all.style299.style.display="none";
}

function changeOpType() {       
        var i = form.optype.value;
        var biz = form.busytype.value;
        document.form.opnote.value="";
        document.all.style005.style.display = "none";
        if (i == "01") {//注册
                document.all.value298.disabled=false;
                document.all.value299.disabled=false;
                document.all.value298.value="";
                document.all.value299.value="";
                if(document.all.busytype.value!="10"){
                        document.all.style298.style.display = "";
                        document.all.style299.style.display = "";
                }
                if(document.all.busytype.value=="21"){
                        document.all.cash.style.display = "";
                }
                if(document.all.busytype.value=="01"||document.all.busytype.value=="02"){
                        document.all.style001.style.display = "";
                }
                
                document.all.modiPasswd.disabled=true;
                document.all.modiPasswd.value="";       
                document.all.modiPass.style.display="none";
                document.all.cmgp.style.display = "none";
                if(document.all.busytype.value=="16" ||document.all.busytype.value=="21"){
                        document.all.gddp.style.display="";
                }
    }
        else if (i == "02") {//业务取消
                document.all.value298.value="";
                document.all.value299.value="";
                document.all.value298.disabled=true;
                document.all.value299.disabled=true;
                document.all.style298.style.display = "none";
                document.all.style299.style.display = "none";
                document.all.modiPasswd.disabled=true;
                document.all.modiPasswd.value="";       
                document.all.modiPass.style.display="none";
                document.all.gddp.style.display="none";
                document.all.cash.style.display = "none";
                document.all.cmgp.style.display = "none";
                if(document.all.busytype.value=="16"){
                        document.all.gddp.style.display="";
                }
                if(document.all.busytype.value=="21"){
                }
                if(document.all.busytype.value=="01"||document.all.busytype.value=="02"){
                        document.all.style001.style.display = "";
                }
        }
        else if (i == "03") {//修改密码
                document.all.modiPasswd.disabled=false;
                document.all.modiPasswd.value="";       
                document.all.modiPass.style.display="";
                document.all.value298.disabled=true;
                document.all.value299.disabled=true;
                document.all.value298.value="";
                document.all.value299.value="";
                document.all.style298.style.display = "none";
                document.all.style299.style.display = "none";
                document.all.value001.value="";
                document.all.style001.style.display = "none";
                document.all.cash.style.display = "none";
                document.all.cmgp.style.display = "none";
        }
        else if (i == "09") {//修改密码
                document.all.modiPasswd.disabled=false;
                document.all.modiPasswd.value="";       
                document.all.modiPass.style.display="";
                document.all.value298.disabled=true;
                document.all.value299.disabled=true;
                document.all.value298.value="";
                document.all.value299.value="";
                document.all.style298.style.display = "none";
                document.all.style299.style.display = "none";
                document.all.value001.value="";
                document.all.style001.style.display = "none";
                document.all.cash.style.display = "none";
                document.all.cmgp.style.display = "none";
        }
        else if (i == "08") {//资料变更
                document.all.value298.value="";
                document.all.value299.value="";
                if(document.all.busytype.value=="16"){
                document.all.gddp.style.display="";
                
                }
                if(document.all.busytype.value!="10"){
                document.all.value298.disabled=false;
                document.all.value299.disabled=false;
                document.all.style298.style.display = "";
                document.all.style299.style.display = "";
                }
                document.all.modiPasswd.disabled=true;
                document.all.modiPasswd.value="";       
                document.all.modiPass.style.display="none";
                document.all.cash.style.display = "none";
                document.all.cmgp.style.display = "none";
        }  
        else if (i == "89"){//SP退订
                document.all.value298.value="";
                document.all.value299.value="";
                document.all.value298.disabled=true;
                document.all.value299.disabled=true;
                document.all.style298.style.display = "none";
                document.all.style299.style.display = "none";
                document.all.modiPasswd.disabled=true;
                document.all.modiPasswd.value="";       
                document.all.modiPass.style.display="none";   
                document.all.cash.style.display = "none";
                document.all.cmgp.style.display = "none";
                if(i == "06" &&(document.all.busytype.value=="16"||document.all.busytype.value=="17"||document.all.busytype.value=="23")){
                        document.all.gddp.style.display="";
                }
                else{
                        document.all.gddp.style.display="none";
                }
                if(i == "21" && document.all.busytype.value=="28"){//游戏平台充值
                        document.all.cmgp.style.display = "";                   
                }
                /* wugl 20090617 暂时屏蔽赠送业务
                if(i=="11" && (biz=="04" || biz=="05")){
                        document.all.style005.style.display = "";
                }
                */
        }
        else if (i == "99"){//全业务退订
                document.all.value298.value="";
                document.all.value299.value="";
                document.all.value298.disabled=true;
                document.all.value299.disabled=true;
                document.all.style298.style.display = "none";
                document.all.style299.style.display = "none";
                document.all.modiPasswd.disabled=true;
                document.all.modiPasswd.value="";       
                document.all.modiPass.style.display="none";   
                
                document.all.cash.style.display = "none";
                document.all.cmgp.style.display = "none";
                if(i == "06" &&(document.all.busytype.value=="16"||document.all.busytype.value=="17"||document.all.busytype.value=="23")){
                        document.all.gddp.style.display="";
                }
                else{
                        document.all.gddp.style.display="none";
                }
                if(i == "21" && document.all.busytype.value=="28"){//游戏平台充值
                        document.all.cmgp.style.display = "";                   
                }
                /* wugl 20090617 暂时屏蔽赠送业务
                if(i=="11" && (biz=="04" || biz=="05")){
                        document.all.style005.style.display = "";
                }
                */
        }
        else {//其他
                document.all.value298.value="";
                document.all.value299.value="";
                document.all.value298.disabled=true;
                document.all.value299.disabled=true;
                document.all.style298.style.display = "none";
                document.all.style299.style.display = "none";
                document.all.modiPasswd.disabled=true;
                document.all.modiPasswd.value="";       
                document.all.modiPass.style.display="none";   
                document.all.cash.style.display = "none";
                document.all.cmgp.style.display = "none";
                if(i == "06" &&(document.all.busytype.value=="16"||document.all.busytype.value=="17"||document.all.busytype.value=="23")){
                        document.all.gddp.style.display="";
                }
                else{
                        document.all.gddp.style.display="none";
                }
                if(i == "21" && document.all.busytype.value=="28"){//游戏平台充值
                        document.all.cmgp.style.display = "";                   
                }
                /* wugl 20090617 暂时屏蔽赠送业务
                if(i=="11" && (biz=="04" || biz=="05")){
                        document.all.style005.style.display = "";
                }
                if(i=="07" && (biz=="04" || biz=="05")){
                        document.all.style005.style.display = "";
                }
                if(i=="14" && (biz=="04" || biz=="05")){
                        document.all.style005.style.display = "";
                }
                if(i=="15" && (biz=="04" || biz=="05")){
                        document.all.style005.style.display = "";
                }
                */
        }
        //密码问题和密码答案域始终不现实
        document.all.style298.style.display="none";
        document.all.style299.style.display="none";

}

function form_load()
{
        document.all.gddp.style.display="none";
        var busy_code=document.all.busytype.value;
        if(busy_code=="01"||busy_code=="02"){
                document.all.style001.style.display="";
                document.form.value001[1].selected=true;
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
        document.all.opnote.value="";
}

//-->
</script>

</HEAD>

<BODY>
        <FORM action="" method=post name=form>
            <%@ include file="/npage/include/header.jsp"%>
        <div class="title">
        <div id="title_zi">用户信息服务功能受理</div>
    </div>
                <input type="hidden" name="busy_type"  value="1">
                <input type="hidden" name="custpassword"  value="">
                <input type="hidden" name="busy_name"  value="">
                
 
                                	
<table cellSpacing="0"> 
	
                <tr> 
                                  <td class=blue>业务类别</td>
                  <td colspan=3> 
                  	
                  	<select name="busytype"     onChange="changeBusyType()">
                  	
                  	<%if(!accountType.equals("2")){%>
                  		<option value="16">手机邮箱免费版</option>
                  	<%}else{%>
                  		<option value="16">手机邮箱免费版</option>
		                  <option value="Y5">手机邮箱5元版</option>
		                  <option value="Y2">手机邮箱20元版</option>
                  	<%}%>
                  
                   
                  </select>
                </tr>
                  
                <tr> 
                  <td class=blue>手机号码</td>
                  <td> 
                    <input type="text" name="phoneno" id="phoneno" maxlength="11" onKeyDown="if(event.keyCode==13)document.all.accountpassword.focus()" onKeyPress="return isKeyNumberdot(0)" onchange="chgPhone()">
                  </td>
                  <td class=blue><div >用户密码</div></td>
                  <td>
                    <input type="password" name="accountpassword"  maxlength="6" onKeyDown="if(event.keyCode==13)getUserInfo()">
                    <input class="b_text" type="button" name="query" value="查询" onclick="getUserInfo()">
                  </td>
                </tr>                        
                <tr> 
                  <td class=blue><div >用户姓名</div></td>
                  <td>
                    <input type="text"  readonly name="value201" value="">
                    <input type="hidden"  readonly name="code201" value="201">
                  </td>
                  <td class=blue><div >运行状态</div></td>
                  <td>
                    <input type="text" readonly name="runname" value="">
                  </td>
                </tr> 
                <tr id="openinfo1"  style="display:none"> 
                        <th colspan="4" align="center">梦网业务开关状态信息</th>
                        </tr>  
                        <tbody id="dyntb" align="center">
                        <tr id="openinfo3" style="display:none"> 
                          <td class=blue align="center" colspan=2><B>开关类型</B></td>
                          <td class=blue align="center" colspan=2><B>开关状态</B></td>
                        </tr>
                        <tr id="tr0" style="display:none"> 
                          <td colspan=2><div align="center"> 
                              <input type="text" align="left" id="R1" value="">
                            </div></td>
                          <td colspan=2><div align="center"> 
                              <input type="text" align="left" id="R2" value="">
                            </div></td>                           
                        </tr>                
                        </tbody>
                <tr> 
                  <td class=blue><div >交易类型</div></td>
                  <td colspan=3>
                      <select name="optype"    onChange="changeOpType()">
                      	  <option  value="23" selected>开通邮箱</option>                      
                          <option  value="25">恢复邮箱</option>                      
                          <option  value="24">取消邮箱</option>                      
                      </select>
                  </td>
                </tr>
                
                <tr id="iChnSourceTr"  style="display:none">
                	<td class="blue">
                		渠道标识
                	</td>
                	
                	<td colspan="3">
                		<select id="iChnSource" name="iChnSource">
                			<option value="01">BOSS</option>
                			<option value="02">网上营业厅</option>
                			<option value="03">掌上营业厅</option>
                			<option value="04">短信营业厅</option>
                			<option value="05">多媒体查询机</option>
                			<option value="06">10086</option>

                		</select>
                	</td>
                	
                </tr>
                <tr id="style005"  style="display:none"> 
                  <td class=blue>赠送手机号</td>
                  <td colspan="3"> 
                    <input type="text" name="thirdNo" v_type="mobilephone" maxlength="11">
                  </td>
                </tr>  
                
                
 
        
                



                <tr id="modiPass"  style="display:none"> 
                  <td class=blue><div >新业务密码</div></td>
                  <td colspan=3>
                    <input type="password"  maxlength="6" name="modiPasswd">
                  </td>
                </tr>
                <tr id ="style298"  style="display:none"> 
                  <td class=blue><div >密码问题</div></td>
                  <td colspan=3>
                    <input type="text"   name="value298">
                    <input type="hidden"  readonly name="code298" value="298">
                  </td>
                </tr>
                <tr id ="style299"  style="display:none"> 
                  <td class=blue><div >密码答案</div></td>
                  <td colspan=3>
                    <input type="text"   name="value299">
                    <input type="hidden"  readonly name="code299" value="299">
                  </td>
                </tr>
                <tr id="style002"  style="display:none"> 
                  <td class=blue><div >密码使用方式</div></td>
                  <td colspan=3> 
                    <select name="value002">
                            <option value="" selected>请选择密码使用方式</option>
                            <option value="1">使用密码</option>
                            <option value="0">不使用密码</option>
                    </select>
                    <input type="hidden"  readonly name="code002" value="002">
                  </td>
                </tr> 
                        
                <tr id="style003"  style="display:none"> 
                  <td class=blue><div >套餐编号</div></td>
                  <td colspan=3> 
                    <select name="value003">
                      <option value="" selected>请选择套餐编号</option>
                      <option value="01">01套餐</option>
                      <option value="02">02套餐</option>
                    </select>
                    <input type="hidden"  readonly name="code003" value="003">
                  </td> 
                </tr>
                <tr id="style004"  style="display:none"> 
                  <td class=blue><div >同步逻辑</div></td>
                  <td colspan=3> 
                    <select name="value004">
                      <option value="" selected>请选择同步逻辑</option>
                      <option value="1">以服务器为准</option>
                      <option value="0">以终端为准</option>
                      <option value="2">互相忽略</option>
                    </select>
                    <input type="hidden"  readonly name="code004" value="004">
                  </td>
                </tr>
                <!--17201相关属性-->
                <tr id="style001"  style="display:none"> 
                  <td class=blue><div >漫游方式</div></td>
                  <td colspan=3> 
                    <select name="value001">
                      <option value="" selected>请选择漫游方式</option>
                      <option value="10">仅国内漫游</option>
                      <option value="01">仅国际漫游</option>
                      <option value="11">国内国际漫游</option>
                      <option value="12">追加国际漫游</option>
                    </select>
                    <input type="hidden"  readonly name="code001" value="001">
                  </td>
                </tr>
                <!--通用下载相关-->
                <tr id="gddp"  style="display:none"> 
                  <td class=blue><div >套餐包号</div></td>
                  <td> 
                    <input type="text"  name="PackNumb" value="">
                  </td>
                  <td class=blue><div >增值业务代码</div></td>
                  <td> 
                    <input type="text"  name="ServCode" value="">
                  </td>
                </tr>
                <!--PUSHMAIL相关-->
                <tr id="psml"  style="display:none"> 
                  <td class=blue><div >PushMail业务类别</div></td>
                  <td colspan=3> 
                    <select name="value300">
                      <option value="" selected>请选择业务类别</option>
                      <option value="01">集团业务</option>
                      <option value="02">个人业务</option>
                    </select>
                    <input type="hidden"  readonly name="code300" value="300">
                  </td>
                </tr>
                <!--手机钱包相关-->
                <tr id="cash"  style="display:none"> 
                  <td class=blue><div >帐户类别</div></td>
                  <td> 
                    <select name="code301">
                      <option value="" selected>请选择帐户类别</option>
                      <option value="001">银行帐户</option>
                      <option value="002">充值帐户</option>
                      <option value="003">话费帐户</option>
                    </select>
                  </td>
                  <td class=blue><div >帐户号码</div></td>
                  <td> 
                    <input type="text"  name="value301" value="">
                  </td>
                </tr>
                <!--游戏平台相关-->
                <tr id="cmgp"  style="display:none"> 
                  <td class=blue><div >充值金额</div></td>
                  <td colspan=3> <input type="text"  name="cmgp001" value="">
                  </td>
                </tr>
                <tr> 
                  <td class=blue><div >备注</div></td>
                  <td colspan="3"> <input type="text"  name="opnote" value="" size="60" maxlength="40" class="InputGrey" readOnly>
                  </td>
                </tr>
              <tr> 
                <td align=center id="footer" colspan="4"> 
                  <input type="hidden"  name="bizType" value="">
                  <input type="hidden"  name="idNo" value="">
                  <input type="hidden"   name="busytypeHit"  id="busytypeHit" value="">
                  
                  <input type="hidden" name="oprSource" value="08">
                  <input class="b_foot" name=sure type=button value=确认 onclick="docheck()">
                                  &nbsp;
                  <input class="b_foot" name=clear type=reset value=清除>
                                  &nbsp;
                  <input class="b_foot" name=reset type=reset value=关闭 onClick="removeCurrentTab()">
                  
                </td>
              </tr>
          </table>
      <%@include  file="/npage/include/footer.jsp"%>
</FORM>
</BODY>
</HTML>
