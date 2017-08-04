<% 
  /*
   * 功能: 彩铃卡申请
　 * 版本: v1.00
　 * 日期: 2007/09/13
　 * 作者: liubo
　 * 版权: sitech
   * 修改历史
   * update by qidp @ 2008-12-17
   *  
   */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.config.*" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ include file="../../include/remark1.htm" %>
    

<%
    String opCode = "6718";
    String opName = "彩铃卡业务申请";
    //ArrayList arr = (ArrayList)session.getAttribute("allArr");
    //String[][] baseInfo = (String[][])arr.get(0);
    //String[][] agentInfo = (String[][])arr.get(2);
    ////String[][] favInfo = (String[][])arr.get(3);
    //String[][] pass = (String[][])arr.get(4);
    
    //String ip_Addr = agentInfo[0][2];
    //String workno = baseInfo[0][2];
    //String power_right=baseInfo[0][5];
    //String workname = baseInfo[0][3];
    //String org_code = baseInfo[0][16];
    //String nopass  = pass[0][0];
    
    String ip_Addr = (String)session.getAttribute("ipAddr");
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
    String power_right = (String)session.getAttribute("powerRight");
    String org_code = (String)session.getAttribute("orgCode");
    String nopass = (String)session.getAttribute("password");
    String  groupId = (String)session.getAttribute("groupId");
    

    //System.out.println("baseInfo[0][16]="+baseInfo[0][16]);
    System.out.println("daixy test 11111111 groupId="+groupId+"power_right="+power_right);

   
    int    nextFlag=1;
    String regionCode = org_code.substring(0,2);   
    String OpCode  ="6718";
    String sInOpNote  ="号码信息初始化"; 
    
    //String[][] temfavStr=(String[][])arr.get(3);
    //String[][] temfavStr = (String[][])session.getAttribute("favInfo");
    //String[] favStr=new String[temfavStr.length];
    //for(int i=0;i<favStr.length;i++)
    //favStr[i]=temfavStr[i][0].trim();
    //boolean pwrf=false;
    //if(WtcUtil.haveStr(favStr,"a272"))
	//pwrf=true;
    
    String sqlStr1="";
    String[][] retListString1 = null;
    
    //获取从上页得到的信息
    String loginAccept = request.getParameter("login_accept");
    
    //SPubCallSvrImpl impl = new SPubCallSvrImpl();
    ArrayList retList1 = new ArrayList();  
    if(loginAccept == null)
    {			
        //获取系统流水
        //sqlStr1 ="SELECT sMaxSysAccept.nextval FROM dual";
        //retList1 = impl.sPubSelect("1",sqlStr1,"region",regionCode);
        //retListString1 = (String[][])retList1.get(0);
        //loginAccept=retListString1[0][0];			
    
    %>
        <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="login_accept"/>
    <%
        loginAccept=login_accept;
    }
    String dateStr=new java.text.SimpleDateFormat("yyyyMM").format(new java.util.Date());
    
    String phone_no           = activePhone;
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

    if (action!=null&&action.equals("select")){
    phone_no = request.getParameter("phone_no");     
	//password = request.getParameter("password");
	//String Pwd1 = Encrypt.encrypt(password);      	//在此对用户传来的密码进行加密
	    	    
    String Pwd1 ="";

    //SPubCallSvrImpl callView = new SPubCallSvrImpl();
    String paramsIn[] = new String[6];
    
    paramsIn[0]=workno;                                 //操作工号         
    paramsIn[1]=nopass;                                 //操作工号密码     
    paramsIn[2]=OpCode;                                 //操作代码         
    paramsIn[3]=sInOpNote;                              //操作描述         
    paramsIn[4]=phone_no;                               //用户手机号码     
    paramsIn[5]=Pwd1;                                   //用户密码         
    
    //ArrayList acceptList = new ArrayList();
    //acceptList = callView.callFXService("s6710Init", paramsIn, "13");
    //callView.printRetValue();
%>
    <wtc:service name="s6710Init" routerKey="region" routerValue="<%=regionCode%>" retcode="s6710InitCode" retmsg="s6710InitMsg" outnum="13">
        <wtc:param value="<%=paramsIn[0]%>"/>
        <wtc:param value="<%=paramsIn[1]%>"/>
        <wtc:param value="<%=paramsIn[2]%>"/>
        <wtc:param value="<%=paramsIn[3]%>"/>
        <wtc:param value="<%=paramsIn[4]%>"/>
        <wtc:param value="<%=paramsIn[5]%>"/>
    </wtc:service>
    <wtc:array id="s6710InitArr" scope="end" />
<%
    //int errCode = callView.getErrCode();
    //String errMsg = callView.getErrMsg();     
    String errCode = s6710InitCode;
    String errMsg = s6710InitMsg;
    
    //if(errCode !=0)
    if (!(errCode.equals("000000")))
    {
%>        
        <script language='jscript'>
           rdShowMessageDialog("<%=errCode%>" + "[" + "<%=errMsg%>" + "]" ,0);
           history.go(-1);
        </script> 
     
<%  
    }					
	//if(errCode == 0)
    if(errCode.equals("000000"))
    {
        nextFlag = 2;				
        //String result2  [][]	= (String[][])acceptList.get(0);
        //String result3  [][]  = (String[][])acceptList.get(1);
        //String result4  [][]	= (String[][])acceptList.get(2);
        //String result5  [][]	= (String[][])acceptList.get(3);
        //String result6  [][]	= (String[][])acceptList.get(4);
        //String result7  [][]	= (String[][])acceptList.get(5);
        //String result8  [][]	= (String[][])acceptList.get(6);
        //String result9  [][]	= (String[][])acceptList.get(7);
        //String result10 [][]	= (String[][])acceptList.get(8);
        //String result11 [][]  = (String[][])acceptList.get(9);
        //String result12 [][]	= (String[][])acceptList.get(10);
        //String result13 [][]  = (String[][])acceptList.get(11);
        //String result14 [][]	= (String[][])acceptList.get(12);
        //sOutCustId          =result2  [0][0];           
        //sOutCustName        =result3  [0][0];           
        //sOutSmCode          =result4  [0][0];           
        //sOutSmName          =result5  [0][0];           
        //sOutProductCode     =result6  [0][0];           
        //sOutProductName     =result7  [0][0];           
        //sOutPrePay          =result8  [0][0].trim();           
        //sOutRunCode         =result9  [0][0];           
        //sOutRunName         =result10 [0][0];           
        //sOutUsingCRProdCode =result11 [0][0];           
        //sOutUsingCRProdName =result12 [0][0];  
        //sOutCustAddress     =result13 [0][0];            // 用户地址
        //sOutIdIccid         =result14 [0][0];            // 证件号码     
        
        sOutCustId          =s6710InitArr[0][0];           
        sOutCustName        =s6710InitArr[0][1];
        sOutSmCode          =s6710InitArr[0][2];
        sOutSmName          =s6710InitArr[0][3];
        sOutProductCode     =s6710InitArr[0][4];
        sOutProductName     =s6710InitArr[0][5];
        sOutPrePay          =s6710InitArr[0][6].trim();           
        sOutRunCode         =s6710InitArr[0][7];
        sOutRunName         =s6710InitArr[0][8];
        sOutUsingCRProdCode =s6710InitArr[0][9];
        sOutUsingCRProdName =s6710InitArr[0][10];
        sOutCustAddress     =s6710InitArr[0][11];       // 用户地址
        sOutIdIccid         =s6710InitArr[0][12];       // 证件号码      				       
    }  
}    
%>      
        
<html xmlns="http://www.w3.org/1999/xhtml"> 
<HEAD>
<TITLE>彩铃卡业务申请</TITLE>
<META content="text/html; charset=GBK" http-equiv=Content-Type>

<script language="JavaScript">
//core.loadUnit("debug");
//core.loadUnit("rpccore");

onload=function(){ 
	 //core.rpc.onreceive = doProcess;
}

function doProcess(packet)
{
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode"); 
    var retMessage = packet.data.findValueByName("retMessage"); 
    self.status="";
    
    //返回彩铃卡信息  
    if(retType == "checkColor")
    {	
        if(retCode!=0){
            retMessage = retMessage + "[errorCode:" + retCode + "]";
            rdShowMessageDialog(retMessage,0);
            return false;    	
        }else{
            var   CardMonth    =packet.data.findValueByName("CardMonth");
            var   CardValue    =packet.data.findValueByName("CardValue");
            var   ColorType    =packet.data.findValueByName("ColorType");
            var   ColorTypeName=packet.data.findValueByName("ColorTypeName");
            var   ProductCode  =packet.data.findValueByName("ProductCode");
            var   ProductName  =packet.data.findValueByName("ProductName");
            
            document.all.CardMonth.value=CardMonth;
            document.all.CardValue.value=CardValue;
            document.all.ColorType.value=ColorType;
            document.all.ColorTypeName.value=ColorTypeName;
            document.all.ProductCode.value=ProductCode;
            document.all.ProductName.value=ProductName;
            document.all.sysNote.value="[<%=phone_no%>]办理彩铃卡业务["+ProductName+"],卡号["+document.all.colorRing_no.value+"]";
        }
    }
}

//彩铃卡验证
function dovalidate()
{
    var colorRing_no = (document.all.colorRing_no.value).trim();
    if(colorRing_no == "")
    {
       rdShowMessageDialog("请输入彩铃卡号");
       return false;
    }
    var checkColor_Packet = new AJAXPacket("f6718_validate.jsp","正在进行彩铃卡号校验，请稍候......");
    checkColor_Packet.data.add("retType","checkColor");
    checkColor_Packet.data.add("colorRing_no",colorRing_no);
    core.ajax.sendPacket(checkColor_Packet);
    checkColor_Packet = null;			
	
}

//确认提交
function refain()
{ 
    getAfterPrompt();
    if(document.form.CardValue.value=="")
    {   
        rdShowMessageDialog("请输入校验卡号！");
        return false;
    }
    
    if(document.form.matureFlag.value=="Y")
    {   
        if(document.form.matureProdCode.value=="" )
        {   
            rdShowMessageDialog("请选择包年到期转包月产品代码！");
            return false;
        }
    }
    if(((document.all.opNote.value).trim()).length==0)
    {
        document.all.opNote.value="<%=workno%>[<%=workname%>]"+"对手机["+((document.all.phone_no.value).trim())+"]进行彩铃"+((document.all.ColorTypeName.value).trim())+"业务申请";
    } 
    
    showPrtDlg("Detail","确实要打印电子免填单吗？","Yes");
    if (rdShowConfirmDialog("是否提交确认操作？")==1){
        document.form.action="f6718_2.jsp";
        document.form.submit();
        return true;
    }  
}
//输入手机号和密码，查询具体信息
function doQuery()
{		
	if(!check(form)) return false; 
//	if(js_pwFlag=="false")
//  {
//   if(((document.all.password.value).trim()).length==0)
//   {
//     rdShowMessageDialog("用户密码不能为空！");
//	   document.all.password.focus();
//     return false;
//   }
//  }
	document.form.action = "f6718_1.jsp?action=select";
	document.form.submit(); 
}
	
//包年到期转包月
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
    //var h=150;
    //var w=350;
    //var t=screen.availHeight/2-h/2;
    //var l=screen.availWidth/2-w/2;
    //var printStr = printInfo(printType);
    //if(printStr == "failed")
    //{    return false;   }
    //
    //var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
    //var path = "<%=request.getContextPath()%>/page/innet/hljPrint1.jsp?DlgMsg=" + DlgMessage;
    //var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
    //var ret=window.showModalDialog(path,"",prop);
    
    var h=210;
    var w=400;
    var t=screen.availHeight/2-h/2;
    var l=screen.availWidth/2-w/2;
    
    var pType="subprint";
    var billType="1";
    var sysAccept = "<%=loginAccept%>";
    var mode_code = null;
    var fav_code = null;
    var area_code = null;
    var printStr = printInfo(printType);
    var phoneno = "<%=phone_no%>";
    
    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
    var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneno+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
    var ret=window.showModalDialog(path,printStr,prop);
    return ret;

}
			
function printInfo(printType) { 
    var matureFlag = document.all.matureFlag.value;
    var matureProdCode = document.all.matureProdCode.value;
    var isend = "";
    if(matureFlag=="Y") {
    	isend="转为彩铃包月业务";
    }
    if(matureFlag=="N") {
    	isend="取消彩铃业务";
    }
    //var retInfo = "";
    //retInfo+='<%=workno%>'+"|";
    //retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    //retInfo+="手机号码:"+document.all.phone_no.value+"|";
    //retInfo+="客户名称:"+'<%=sOutCustName%>'+"|";
    //retInfo+="证件号码:"+document.all.sOutIdIccid.value+"|";
    //retInfo+="客户地址:"+document.all.sOutCustAddress.value+"|";				
    //retInfo+="业务品牌:"+document.all.sm_name.value+"|";
    //retInfo+="办理业务:"+"彩铃"+document.all.ColorTypeName.value+"激活"+"|";
    //retInfo+="操作流水:"+'<%=loginAccept%>'+"|";
    //retInfo+="操作时间:"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    //retInfo+="业务生效时间:"+"当日"+"|";
    //retInfo+="业务到期后:"+isend+"|";
    //retInfo+=""+"|";
    //retInfo+=""+"|";
    //retInfo+=""+"|";
    //retInfo+=""+"|";
    //retInfo+=""+"|";
    //retInfo+=""+"|";
    //retInfo+=""+"|";
    //retInfo+=""+"|";
    //retInfo+=""+"|";
    //retInfo+=""+"|";
    //retInfo+=""+"|";
    //retInfo+=""+"|";
    //retInfo+=""+"|";
    //retInfo+=""+"|";
    //retInfo+=""+"|";
    //retInfo+=""+"|";
    //retInfo+=""+"|";
	//retInfo+=""+document.all.simBell.value+"|";
	//return retInfo;
	
	var cust_info="";
    var opr_info="";
    var note_info1="";
    var note_info2="";
    var note_info3="";
    var note_info4="";
    var retInfo = "";
    
    cust_info+="手机号码："+document.all.phone_no.value+"|";
    cust_info+="客户姓名："+'<%=sOutCustName%>'+"|";
    cust_info+="客户地址："+document.all.sOutCustAddress.value+"|";
    cust_info+="证件号码："+document.all.sOutIdIccid.value+"|";
            
    opr_info+="业务品牌："+document.all.sm_name.value+"|";
    opr_info+="办理业务："+"彩铃"+document.all.ColorTypeName.value+"激活"+"|";
    opr_info+="操作流水："+'<%=loginAccept%>'+"|";
    opr_info+="操作时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    opr_info+="业务生效时间："+"当日"+"|";
    opr_info+="业务到期后："+isend+"|";
    note_info1+="备注："+"|";
    //retInfo=cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    return retInfo;

			
}

</script>
</HEAD>
<BODY>
<FORM action="f6718_2.jsp" method=post name=form>
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
    <div id="title_zi">操作信息</div>
</div>
<table border="0">
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
    <TR>   
        <td class=blue width="15%">手机号码</td>                                 
        <td colspan=3>                     
            <input type="text" Class="InputGrey" v_type="mobphone"  v_must=1 v_minlength=1 v_maxlength=11 value="<%=phone_no%>" name="phone_no"  maxlength="11"  onkeydown="if(event.keyCode==13)doQuery()" readOnly>
            <font class="orange">*</font>
        </td>
        
    </TR>
    <tr>
        <td colspan="4" id="footer">
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
    <TR>   
        <td class=blue>手机号码</td>                                 
        <td>                     
            <input type="text"  Class="InputGrey" v_type="mobphone"  v_must=1 v_minlength=1 v_maxlength=11 value="<%=phone_no%>" name="phone_no"  maxlength="11"  onkeydown="if(event.keyCode==13)doQuery()" readOnly>
            <font class="orange">*</font>
        </td>
        <td class=blue>客户ID</td>
        <td> 
            <input type="text" name="cust_id" maxlength="6"  value="<%=sOutCustId%>" Class="InputGrey" readOnly>
            <font class="orange">*</font>
        </td>
    </tr>
    <tr> 
        <td class=blue>客户名称</td>
        <td> 
            <input type="text" name="cust_name" value="<%=sOutCustName%>"  Class="InputGrey" readOnly>
            <font class="orange">*</font>
            <input type="hidden" readonly name="sOutCustAddress" value="<%=sOutCustAddress%>">
            <input type="hidden" readonly name="sOutIdIccid" value="<%=sOutIdIccid%>">
        
        </td>
        <td class=blue>可用预存</td>
        <td>
            <input type="text"  Class="InputGrey" readonly name="PrePay" value="<%=sOutPrePay%>">
            <font class="orange">*</font>
        </td>
    </tr>
    <tr> 
        <td class=blue>业务品牌</td>
        <td> 
            
            <input type="text"   Class="InputGrey"  readonly name="sm_name" value="<%=sOutSmName%>">
            <font class="orange">*</font>
            <input type="hidden" readonly name="sm_code" value="<%=sOutSmCode%>">
        </td>
        <td class=blue>运行状态</td>
        <td> 
        
            <input type="text"   Class="InputGrey"  readonly name="RunName" value="<%=sOutRunName%>">
            <font class="orange">*</font>
            <input type="hidden" readonly name="RunCode" value="<%=sOutRunCode%>">
        </td>
    </tr>
    <tr> 
        <td class=blue>资费套餐</td>
        <td> 
            
            <input type="text"   Class="InputGrey"  readonly name="sOutProductName" maxlength="5" value="<%=sOutProductName%>">
            <font class="orange">*</font>
            <input type="hidden" readonly name="sOutProductCode" maxlength="5" value="<%=sOutProductCode%>">
        </td>
        <td class=blue>已订购彩铃产品</td>
        <td> 
        
            <input type="text" readonly  name="UsingCRProdName" maxlength="20" value="<%=sOutUsingCRProdName%>">
            <input type="hidden" readonly name="UsingCRProdCode" maxlength="20" value="<%=sOutUsingCRProdCode%>">
        </td>
    </tr>                
    <TR>
        <td class=blue>彩铃卡号</td>
        <td colspan=3> 
            <input type="text"  v_type="string"  v_must=1 v_minlength=1 v_maxlength=15 name="colorRing_no"  maxlength="15"  onkeydown="if(event.keyCode==13)dovalidate()" >
            <input class="b_text" name=sure33 type=button value=验证 onClick="dovalidate();" style="cursor:hand" >
            <font class="orange">*</font>
        </td>
    </TR>
    <tr> 
        <td class=blue>卡使用期</td>
        <td> 
            <input type="text"   readonly name="CardMonth">
            <font class="orange">*</font>
        </td>
        <td class=blue>卡面额</td>
        <td> 
            <input type="text"   readonly name="CardValue" readonly >
            <font class="orange">*</font>
        </td>
    </tr>
    <tr> 
        <td class=blue>卡 类 型</td>
        <td> 
        
            <input type="text"   readonly name="ColorTypeName" maxlength="5" >
            <font class="orange">*</font>
            <input type="hidden" readonly name="ColorType" maxlength="5" >
        </td>
        <td class=blue>彩铃卡产品</td>
        <td> 
        
            <input type="text" readonly   name="ProductName"  maxlength="20" >
            <font class="orange">*</font>
            <input type="hidden" readonly name="ProductCode"  maxlength="20" >
        </td>
    </tr> 
                
    <TR span=1>
        <TD class=blue>
            <div id=tbs2 style="display:">包年到期转包月</div>
        </TD>															   
        <TD colspan=3>
            <div id=tbs3 style=display="">									
                <SELECT name="matureFlag" id="change_year" onChange="changeMatureFlag()" >
                    <option value="Y" >是</option>
                    <option value="N" selected>否 </option>
                </SELECT>
                <SELECT name="matureProdCode" id="matureProdCode" onChange="" disabled>
                    //<%
                        //
                        //SPubCallSvrImpl callView2 = new SPubCallSvrImpl();
                        //ArrayList retArray2 = new ArrayList();
                        //String[][] result2 = new String[][]{};
                        //String sqlStr2="";
                        //int recordNum2=0;
                        //sqlStr2 = "select mode_code,mode_code||'->'||mode_name from sbillmodecode where mode_code like 'CR%'  and mode_type='CR01' and start_time<sysdate  and stop_time>sysdate  and power_right<="+power_right+" and mode_status='Y' and region_code="+regionCode;
                        //retArray2 = callView2.sPubSelect("2",sqlStr2);
                        //result2 = (String[][])retArray2.get(0);
                        //recordNum2 = result2.length;
                        //for(int i=0;i<recordNum2;i++)
                        //{
                        //out.println("<option  value='" + result2[i][0] + "'><font size=2>"+result2[i][1] + "</font></option>");
                        //}<!--wtc:sql>select mode_code,mode_code||'->'||mode_name from sbillmodecode where mode_code like 'CR%'  and mode_type='CR01' and start_time<sysdate  and stop_time>sysdate  and power_right<='?' and mode_status='Y' and region_code='?'</wtc:sql-->
                        //<!--wtc:param value="<%=regionCode%>"/-->
                        //
                    //%>
                    
                    <wtc:qoption name="sPubSelect" outnum="2">
                        <wtc:sql>select a.offer_id,a.offer_id||'->'||a.offer_name from product_offer a ,region b,dchngroupinfo c where a.OFFER_ID = b.OFFER_ID and b.group_id = c.PARENT_GROUP_ID and a.OFFER_ATTR_TYPE = 'CR01' and a.EFF_DATE <sysdate and a.exp_date >sysdate and c.GROUP_ID='?' and a.state='A' and b.right_limit<='?'</wtc:sql>
                        <wtc:param value="<%=groupId%>"/>
                        <wtc:param value="<%=power_right%>"/>
                    </wtc:qoption>
                
                
                </SELECT>
                <font class="orange">*</font>
            </div>	
        </td>	                
    </TR>
                                            

    <tr> 
        <td class=blue>备注</td>
        <td colspan=3>
            <input readonly name=sysNote size=60 maxlength="60" >
        </td>
    </tr>
    <tr> 
        <td style="display:none">用户备注</td>
        <td style="display:none"> 
            <input class="button" name=opNote size=60 maxlength="60">
        </td>
    </tr>



    <tr id="footer"> 
        <td colspan=4> 
            <input class="b_foot" name=sure type="button" value=确认 onclick="refain()">
            <input class="b_foot" name=clear type=reset value=清除>
            <input class="b_foot" name=reset type=button value=关闭 onClick="removeCurrentTab()">
        </td>
    </tr>                


    <script language='jscript'>
    document.all.matureProdCode.value="";
    </script >        
    <%
    }//end   if(nextFlag==2)    
    %>
</table>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>

