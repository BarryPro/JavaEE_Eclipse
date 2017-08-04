<%request.setCharacterEncoding("GBK");%>
<%@ page contentType= "text/html;charset=GBK" %>
<%
    /********************
     version v2.0
     开发商: si-tech
     s4244Snd异地写卡sim卡激活发起
     gaopeng 20130107
     ********************/
%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>

<script type="text/javascript">
onload=function()
{		

}

</script>

<%
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	//String opCode = (String)request.getParameter("opCode");		
	//String opName = (String)request.getParameter("opName");
	String opCode = "g412";
	String opName = "异地单卡写卡";
	String Brand = (String)request.getParameter("Brand");
	String[][] baseInfoSession = (String[][])arrSession.get(0);
	String[][] otherInfoSession = (String[][])arrSession.get(2);
	String[][] pass = (String[][])arrSession.get(4);
	
	String loginNo = baseInfoSession[0][2];
	String loginName = baseInfoSession[0][3];
	String powerCode= otherInfoSession[0][4];
	String orgCode = baseInfoSession[0][16];
	String ip_Addr = request.getRemoteAddr();
	
	String regionCode = orgCode.substring(0,2);
	String regionName = otherInfoSession[0][5];
	String loginNoPass = pass[0][0];

	//String errorMsg="系统错误，请与系统管理员联系，谢谢!!";
	//String errorCode="444444";
	//String[][] errCodeMsg = null;
	List al = null;
		//流水号
 		String iLoginAccept = getMaxAccept();
  	int valid = 1;	//0:正确，1：系统错误，2：业务错误
	String op_code = "g412";
	
		 
	String phoneNo  =request.getParameter("phoneNo");
	String iccid =request.getParameter("iccid");	 
	String imsi   =request.getParameter("imsi");
	String handFee  =request.getParameter("handFee");	
	String opNote=request.getParameter("opNote");

	String tmpBusyAccept=iccid.substring(13,19);
	String testFlag=request.getParameter("test_flag");
	String cardID=request.getParameter("cardID");
	String cust_name=request.getParameter("custName");
	String simFee=request.getParameter("simFee");
	String ifDLS=request.getParameter("ifDLS");
	String retCode2 = "";
	String retMsg2 = "";
	//MyLog.debugLog("yidisimkajihuo11111");
	//MyLog.debugLog("cust_name"+cust_name);
	//cust_name= "";
 	// al = f4244Req.doProcess(loginNo, orgCode,op_code,phoneNo,testFlag,imsi,phoneNo,iccid,handFee,simFee,opNote,tmpBusyAccept);
 	// MyLog.debugLog("yidisimkajihuo22222");
 	//s4244Snd
 		String  inputParsm [] = new String[10];
		inputParsm[0] = loginNo;
		inputParsm[1] = orgCode;
		inputParsm[2] = op_code;
		inputParsm[3] =	phoneNo;
		inputParsm[4] = testFlag;
		inputParsm[5] = imsi;
		inputParsm[6] = iccid;
		inputParsm[7] = handFee;
		inputParsm[8] = simFee;
		inputParsm[9] = opNote;
 	%>
 	<wtc:service name="s4244Snd" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="2">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<wtc:param value="<%=inputParsm[7]%>"/>
				<wtc:param value="<%=inputParsm[8]%>"/>
				<wtc:param value="<%=inputParsm[9]%>"/>
		</wtc:service>
		<wtc:array id="ret" scope="end"/>
 	
 	<%
  if(ret.length<=0){
		valid = 1;
		//MyLog.debugLog("###############################################");
	}
	else
	{
		if( !"0000".equals(retCode))
		{
			valid = 2;
		}
		else
		{
			valid = 0;
		}
	}
%>

<%
	/* sim卡型号名称 */
	String  inParams [] = new String[2];
	inParams[0] = "select b.res_name from dsimres a,srescode b where a.sim_type=b.res_code and a.sim_no=:iccid ";
	inParams[1] = "iccid="+iccid;
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1"> 
		<wtc:param value="<%=inParams[0]%>"/>
		<wtc:param value="<%=inParams[1]%>"/> 
	</wtc:service>  
	<wtc:array id="ret_simTypeName"  scope="end"/>
<%
	String simTypeName = "";
	if("000000".equals(retCode1)){
		if(ret_simTypeName.length>0){
			simTypeName = ret_simTypeName[0][0];
		}
	}
%>

<!--取流水号方法 -->
<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="seq"/>
<%
		String printAccept = seq;
		/*获取当前时间*/
		java.util.Date sysdate = new java.util.Date();
		java.text.SimpleDateFormat sf1 = new java.text.SimpleDateFormat("yyyyMMdd");
		String init_tme = sf1.format(sysdate);
		/*调用渠道押金扣款服务 liyang开发 2014/04/15 10:45:11 gaopeng调用*/
%>
<%if("1".equals(ifDLS) && valid == 0 ){%>
<wtc:service name="s6005Cfm" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode22" retmsg="retMsg22" outnum="2">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=printAccept%>"/>
				<wtc:param value="<%=inputParsm[8]%>"/>
				<wtc:param value="<%=init_tme%>"/>
				<wtc:param value=""/>
				
		</wtc:service>
<wtc:array id="ret2" scope="end"/>

<%
			retCode2 = retCode22;
			retMsg2 = retMsg22;
	if(ret2.length <= 0){
		valid = 1;
	}else{
		if( !"000000".equals(retCode22) && !"0".equals(retCode22))
		{
			valid = 3;
		}
		else
		{
			valid = 0;
		}
	}
%>			
<%}%>
<%if( valid == 1){%>
<script language="JavaScript">

	rdShowMessageDialog("系统错误，请与系统管理员联系，谢谢!!");
	window.location="s4244.jsp";

</script>

<%}else if( valid == 2){%>
<script language="JavaScript">

	rdShowMessageDialog("<br>错误代码:["+"<%=retCode %>]</br>"+"错误信息:["+"<%=retMsg %>"+"]");
	window.location="s4244.jsp";

</script>
<%}else if( valid == 3){%>
<script language="JavaScript">

	rdShowMessageDialog("<br>错误代码:["+"<%=retCode2 %>]</br>"+"错误信息:["+"<%=retMsg2 %>"+"]");
	window.location="s4244.jsp";

</script>

<%}else{%>
<script language="JavaScript">

	rdShowMessageDialog("操作成功!!");
	 conf();
	window.location="s4244.jsp";

	/*--------------------------打印流程函数---------------------------*/


function conf()
{

   /***********************打印所需的参数**********************************/

  								//业务类别
   var work_no = "<%=loginNo%>";                                 //受理工号
         
   var date = '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+'<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+'<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>';	// 系统日期
   var phone = "<%=phoneNo%>";					//移动号码
   var cust_name = "<%=cust_name%>";						//客户名称
   var pay_money ="<%=handFee%>";					//交费金额
  var oldSim_no=   "";
  var tmpBusyAccept="<%=tmpBusyAccept%>";
 var newSim_no=  "<%=iccid%>";
 var simFee= "<%=simFee%>";
/* liuyl modify by 20100520
var busi_type="异地业务";
*/
var busi_type="跨区服务";
   
   printfp(busi_type,work_no,date,phone,cust_name,simFee,tmpBusyAccept,oldSim_no,newSim_no);                                //点击确认，调用打印页面

  
 }
function printfp(busi_type,work_no,date,phone,cust_name,simFee,tmpBusyAccept,oldSim_no,newSim_no)
{
	//业务类别|年|月|日|受理流水号|手机号码|客户名称|用户品牌|办理业务:跨区补卡|操作流水|SIM卡费|旧SIM卡号|新SIM卡号|受理工号|交费时间
//工号|年|月|日|用户名称|卡号|移动台号|协议号码|支票号码|合计金额(大写)|金额(小写)|业务项目|操作员|收款员|IMEINo|是否参与赠送礼品活动|支付方式|POS缴费条目
		var infoStr = "";
		infoStr = work_no + "|";
		infoStr += <%=iLoginAccept%>+"|";
		infoStr += "跨区补卡|";
		infoStr+='<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	  infoStr+='<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+"|";
	  infoStr+='<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		infoStr += cust_name+"|";
		infoStr += "|";
		infoStr += phone+"|";
		infoStr += "|";
		infoStr += "|";
		infoStr += simFee+"|";
		infoStr += simFee+"|";
		var yhpp="";
		var pinpais="";
		
		//01：全球通；02：神州行；03：动感地带；09：其他品牌
		if("<%=Brand%>"=="01")
		{
			yhpp="全球通";
			pinpais="gn";
		}
			if("<%=Brand%>"=="02")
		{
			yhpp="神州行";
			pinpais="zn";
		}
			if("<%=Brand%>"=="03")
		{
			yhpp="动感地带";
			pinpais="dn";
		}
			if("<%=Brand%>"=="09")
		{
			yhpp="其他品牌";
			pinpais="";
		}
		infoStr += "用户品牌："+yhpp+"~";
		//infoStr += "旧SIM卡号："+oldSim_no+"~";
		infoStr += "新SIM卡号："+newSim_no+"~";
		infoStr += "交费时间："+date+"~";
		infoStr += "备注：提醒您将原SIM卡中的电话簿及短信自行备份。|";
		infoStr+=	work_no+"|";//开票人
	 	infoStr+=" "+"|";//收款人
	 	infoStr+=" "+"|";

		/*
		var h=180;
		var w=350;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
		
		var path = "/npage/innet/pubBillPrintCfm.jsp?dlgMsg=客户<"+cust_name+"><%=opName%>已成功，下面将打印发票！";
		var loginAccept = tmpBusyAccept;
		var path = path + "&infoStr="+infoStr+"&loginAccept="+<%=iLoginAccept%>+"&opCode=<%=opCode%>&submitCfm=Single";
		var ret=window.showModalDialog(path, "", prop);
		removeCurrentTab();
		*/
		var  billArgsObj = new Object();
		$(billArgsObj).attr("10001",work_no);
		$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
	 	$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
	 	$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
		$(billArgsObj).attr("10005",cust_name);
		$(billArgsObj).attr("10006","<%=opName%>");
		$(billArgsObj).attr("10008",phone);
		$(billArgsObj).attr("10015",simFee);//小写
		$(billArgsObj).attr("10016",simFee);//合计金额(大写) 传小写，公共页转换
		$(billArgsObj).attr("10017","*");//现金
		$(billArgsObj).attr("10030","<%=iLoginAccept%>");//业务流水
		$(billArgsObj).attr("10036","<%=opCode%>");
		$(billArgsObj).attr("10031",work_no);//开票人
		$(billArgsObj).attr("10041","SIM卡");//品名规格
		$(billArgsObj).attr("10061","<%=simTypeName%>");//型号
		$(billArgsObj).attr("10042","张");//单位
		$(billArgsObj).attr("10043","1");//数量
		$(billArgsObj).attr("10044",simFee);//单价
		$(billArgsObj).attr("10046",simFee);//合计
		$(billArgsObj).attr("10028","");//参与的营销活动名称
		$(billArgsObj).attr("10047","");//活动代码
		$(billArgsObj).attr("10071","7");//模板
		$(billArgsObj).attr("10007",pinpais);
		$(billArgsObj).attr("10074","0");
 		$(billArgsObj).attr("10075","0");

		
		var printInfo = "";
		var h=210;
		var w=400;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
		var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=客户<"+cust_name+"><%=opName%>已成功，下面将打印发票！";
		var path = path + "&infoStr="+printInfo+"&loginAccept=<%=iLoginAccept%>&opCode=<%=opCode%>&submitCfm=submitCfm";
		var ret = window.showModalDialog(path,billArgsObj,prop); 
		removeCurrentTab();
	}
	
</script>
<%}%>








