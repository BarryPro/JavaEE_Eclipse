<%
/********************
 version v2.0
开发商: si-tech
*
*update:liutong@2008.08.21       
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="java.text.*"%>

<%        
	//Logger logger = Logger.getLogger("f1104_1.jsp");
	ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
	//S1100View callView = new S1100View();
	int iiii=1;
	String sys_Date=new java.text.SimpleDateFormat("yyyyMMddHHmmss", Locale.getDefault()).format(new java.util.Date());
%>
<%
		/**
			String opCode = "1104";
			String opName = "普通开户";
			ArrayList arr = (ArrayList)session.getAttribute("allArr");
			String[][] baseInfo = (String[][])arr.get(0);
			//基本信息
			String[][] agentInfo = (String[][])arr.get(2);
			String workNo = baseInfo[0][2];
			String workName = baseInfo[0][3];
			String powerRight = baseInfo[0][5];    
			String Role = baseInfo[0][5];
			String orgCode = baseInfo[0][16];
			String rowNum = "500";
			String printAccept = "";
			String getAcceptFlag = "";
			String xyd_bz="";
			String regionCode = (baseInfo[0][16]).substring(0,2);
			String strDistrictCode = (baseInfo[0][16]).substring(2,4);
			String belongCode = orgCode.substring(0,7);
			System.out.println("---------------------------------------f1104_1belongCode=["+belongCode+"]");
			String ip_Addr = agentInfo[0][2];
			String deptCode = agentInfo[0][3];      
			String powerName = agentInfo[0][4];      
			String townName = agentInfo[0][6];
			//String groupId = baseInfo[0][21];
			String groupId =(String)session.getAttribute("groupId");
			String op_code = "1104";
			//优惠信息
			String[][] favInfo = (String[][])arr.get(3);   //数据格式为String[0][0]---String[n][0]  
		**/
        
        
		String op_code = "1104";
		String opCode = "1104";
		String opName = "普通开户";
        String workNo =(String)session.getAttribute("workNo");
        String workName =(String)session.getAttribute("workName");
        String powerRight =(String)session.getAttribute("powerRight");
        String Role =(String)session.getAttribute("Role");
        String orgCode =(String)session.getAttribute("orgCode");
        String rowNum = "500";
		String printAccept = "";
		String getAcceptFlag = "";
		String xyd_bz="";
		
        String regionCode = orgCode.substring(0,2);
        String groupId =(String)session.getAttribute("groupId");
        String ip_Addr =(String)session.getAttribute("ip_Addr");
        String[][]  favInfo = (String[][])session.getAttribute("favInfo");
        String belongCode =orgCode.substring(0,7);
        String strDistrictCode =orgCode.substring(2,4);
        ArrayList arr = (ArrayList)session.getAttribute("allArr");        
%>

<%
        //解析营业员优惠权限
        String Mach_Favourable = "readonly";        //a001  开户机器费优惠
        //String Innet_Favourable = "readonly";     //a002  开户入网费优惠
        String Innet_Favourable = "";
        //String Sim_Favourable = "readonly";       //a003  开户SIM卡费优惠
        String Sim_Favourable = "readonly";
        String Choice_prepay="readonly";
        String No_Favourable = "readonly";          //a004  开户选号费优惠
        String Validate_Favourable = "readonly";    //a006  开户验机费优惠
        String HandFee_Favourable = "readonly";     //a007  开户手续费优惠
        int infoLen = favInfo.length;
        String tempStr = "";
        for(int i=0;i<infoLen;i++)
        {
            tempStr = (favInfo[i][0]).trim();
            if(tempStr.compareTo("a001") == 0)
            {     Mach_Favourable = "readonly";        }
            if(tempStr.compareTo("a002") == 0)
            {     Innet_Favourable = "";       }
            if(tempStr.compareTo("a090") == 0)  
            {     Sim_Favourable = "";  }
            if(tempStr.compareTo("a091") == 0)  
            {     Choice_prepay="";       }
            if(tempStr.compareTo("a004") == 0)
            {     No_Favourable = "";          }
            if(tempStr.compareTo("a006") == 0)
            {     Validate_Favourable = "";        }
            if(tempStr.compareTo("a007") == 0)
            {     HandFee_Favourable = "";     }
            if(tempStr.compareTo("a009") == 0)
            {     xyd_bz = "0";     }
        } 
        
	
    	//-------------------------------
		String sqlStrOut = "select sm_code, trim(sm_name) from ssmcode where REGION_CODE='"+regionCode+"' order by sm_code";	
    //ArrayList outArr=new ArrayList();
		//String[][] outRet=new String[][]{};
	  /**
		try
	 	{			
			outArr = callView.view_spubqry32("2",sqlStrOut);
			outRet = (String[][])outArr.get(0);
     	}catch(Exception e){
       		logger.error("Call sunView is Failed!");
     	}
     	**/   
     	%>
     	<wtc:pubselect name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
		<wtc:sql><%=sqlStrOut%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="outRet" scope="end" />
     	<%
     	
      if(!retCode1.equals("000000")){
%>
   <script language="javascript">
   	  rdShowMessageDialog("服务未能成功,服务代码:<%=retCode1%><br>服务信息:<%=retMsg1%>");
   	   parent.removeTab('<%=opCode%>');
	</script>
<%	
	}
		
	    String[][] allNewSmInfo=(String[][])arr.get(5);
		//-------------------------------
%>
<%
	ArrayList retArray9 = new ArrayList();
	//String[][] result9 = new String[][]{};
	//SPubCallSvrImpl callView9 = new SPubCallSvrImpl();
	String loginNote="";
	String sqlStr9 = "select back_char1 from snotecode where region_code='"+regionCode+"' and op_code='XXXX'";

	//retArray9 = callView9.sPubSelect("1",sqlStr9);
	
	%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode9" retmsg="retMsg9" outnum="1">
	<wtc:sql><%=sqlStr9%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="result9" scope="end" />

	<%
	//result9  = (String[][])retArray9.get(0);
	
	 	
      if(!retCode9.equals("000000")){
%>
   <script language="javascript">
   	  rdShowMessageDialog("服务未能成功,服务代码:<%=retCode9%><br>服务信息:<%=retMsg9%>");
   	  parent.removeTab('<%=opCode%>');
	</script>
<%	
	}
	
	System.out.println("@@@@@@@@@result="+result9);
		
  for(int i=0;i<result9.length;i++){
		loginNote = (result9[i][0]).trim();
	}
	
	loginNote = loginNote.replaceAll("\"","");
	loginNote = loginNote.replaceAll("\'","");
	loginNote = loginNote.replaceAll("\r\n","   ");  
	loginNote = loginNote.replaceAll("\r","   "); 
	loginNote = loginNote.replaceAll("\n","   "); 
%>

<%
	//王良 2007年10月18日 增加 取赠送充值卡的配制信息 
	//ArrayList retArrayCard = new ArrayList();
	//String[][] resultCard = new String[][]{};
	//SPubCallSvrImpl callViewCard = new SPubCallSvrImpl();
	String strCardSum="0";
	String strSql = "select card_sum from sInnetCard where region_code='"+regionCode+"' and district_code = '"+strDistrictCode+"' and op_code='1104' and card_type='00' and sysdate between begin_time and end_time";
	System.out.println("strSql="+strSql);



	%>
	
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="1">
	<wtc:sql><%=strSql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="resultCard" scope="end" />
	
	<%
	//retArrayCard = callViewCard.sPubSelect("1",strSql);
	//resultCard  = (String[][])retArrayCard.get(0);
	System.out.println("resultCard="+resultCard);
	
	
	  if(!retCode2.equals("000000")){
%>
   <script language="javascript">
   	  rdShowMessageDialog("服务未能成功,服务代码:<%=retCode2%><br>服务信息:<%=retMsg2%>");
   	  parent.removeTab('<%=opCode%>');
	</script>
<%	
  
	}
		
  if (resultCard.length > 0){
		strCardSum = (resultCard[0][0]).trim();
		if(strCardSum.compareTo("") == 0){
			strCardSum = "0";
		}  
	}
%>


<HTML><HEAD><TITLE>全球通普通开户</TITLE>
</HEAD>

<script type="text/javascript" src="/njs/si/validate_pack.js"></script>



<SCRIPT type=text/javascript>
var modeCode = "";      //主资费代码
var chinaFee = "";      //大写费用
var chkPassFlag=false;  //是否通过密码校验
var subPassFlag=true;   //必须选中可选资费标志
var preFlag=false;      //预开通标志
var blackFlag=true;     //入网人黑名单标志
var assuBlackFlag=true; //担保人黑名单标志


var QryForeSimNoFlag="";

var pack_re_mainName="";
var pack_re_mainCode="";
var pack_re_choiName="";
var pack_re_choiCode="";
var pack_re_choiFlag="";
var pack_re_prefee="";

var pack_addifeeCode = "";
var pack_addifeeName = "";

var js_newSm=new Array(new Array(),new Array(),new Array(),new Array(),new Array(),new Array());
var js_oldSm=new Array(new Array(),new Array());
var js_regionCode="";

var numStr="0123456789"; 
	var ltflag = 0; 

onload=function(){
    js_regionCode="<%=regionCode%>";
    //----------------------------------------------
<%
    for(int i=0;i<allNewSmInfo.length;i++)
	{
	  for(int j=0;j<allNewSmInfo[i].length;j++)
	  {
%>
	    js_newSm[<%=j%>][<%=i%>]="<%=allNewSmInfo[i][j]%>";
<%		
	  } 
	}
%>	
	//----------------------------------------------

	//----------------------------------------------
<%
    for(int i=0;i<outRet.length;i++)
	{
	  for(int j=0;j<outRet[i].length;j++)
	  {
%>
	    js_oldSm[<%=j%>][<%=i%>]="<%=outRet[i][j]%>";
<%		
	  } 
	}
%>	

    chgNewSm();
	//----------------------------------------------
    document.all.idIccid.focus();
    document.all.innetCode.options.length=0;
	document.all.innetCode.options.length=document.all("dnInnetCode").length;		
	for(var i=0;i<document.all("dnInnetCode").length;i++)
	{
	  document.all.innetCode.options[i].value=document.all("dnInnetCode").options[i].value;
	  document.all.innetCode.options[i].text=document.all("dnInnetCode").options[i].text;
	  document.all.innetCode.options[i].mainCode=document.all("dnInnetCode").options[i].mainCode;   
	  document.all.innetCode.options[i].mainName=document.all("dnInnetCode").options[i].mainName;
  	  document.all.innetCode.options[i].subCount=document.all("dnInnetCode").options[i].subCount;
	}

	frm1104.sysAccept.value = "";

		if(typeof(frm1104.post)!="undefined")          //恢复到提交前的寄送显示状态
		{	if(frm1104.post.checked == true) {postStatus();}		}; 
		if(typeof(frm1104.checkRadio)!="undefined")     //恢复到提交前的支票付费显示状态
		{   if(frm1104.checkRadio.checked == true)	{checkWay();}         }
		if(typeof(frm1104.checkuserIDRadio)!="undefined")              //恢复到提交前的用户ID查询按钮的显示状态
		{   
			if(frm1104.userID.value != "")
			{
				document.frm1104.userIdQuery.disabled = true;   
			}
		}
		if((typeof(frm1104.accountID)!="undefined")&&(typeof(frm1104.accountIdQuery)!="undefined"))           //恢复到提交前的帐户ID查询按钮的显示状态
		{   
			if(frm1104.accountID.value != "")
			{	document.frm1104.accountIdQuery.disabled = true;		}
		}
    	if((typeof(frm1104.innetFee)!="undefined")&&(typeof(frm1104.innetPreFee)!="undefined")&&(typeof(frm1104.hid_innetPreFee)!="undefined")) 
    	{		changeInCode();	  		}//得到入网费用信息
		
		//document.all.b_select.style.display="none";   
	}
	
	
	
function chgcardtype()

{
	document.frm1104.simNo.value="";
    	document.all.simType.value="";
    	document.all.simTypeName.value="";
    	document.all.cardcard.value="";
	 if(document.all.cardtype[1].checked==true)  //空卡
  	{	document.all.b_qrySimType.disabled=true;
  		document.all.cardtype_bz.value="k";
  		 var phone = (document.frm1104.phoneNo.value).trim();
  		 /****新增调大唐功能取SIM卡类型****/
  		 /* 
  		  * diling update for 修改营业系统访问远程写卡系统的访问地址，由现在的10.110.0.125地址修改成10.110.0.100！@2012/6/4
  		  */
  		 path ="http://10.110.0.100:33000/writecard/writecard/ReadCardInfo.jsp";
  		 var retInfo1 = window.showModalDialog("Trans.html",path,"","dialogWidth:10;dialogHeight:10;"); 
		 if(typeof(retInfo1) == "undefined")     
    	 {	
    		 rdShowMessageDialog("读卡类型出错!");
    		return false;   
    	 }
    	
    	var chPos;
    	chPosn = retInfo1.indexOf("&");
    	if(chPosn < 0)
    	{	
    		rdShowMessageDialog("读卡类型出错!");
    		return false ;	
    	} 
   		//alert( retInfo1.substring(0,chPos));
    	retInfo1=retInfo1+"&";
    	var retVal=new Array();   
    	for(i=0;i<4;i++)
    	{   	   
    	
    		var chPos = retInfo1.indexOf("&");
        	valueStr = retInfo1.substring(0,chPos);
        	var chPos1 = valueStr.indexOf("=");
        	valueStr1 = valueStr.substring(chPos1+1);
        	retInfo1 = retInfo1.substring(chPos+1);
        	retVal[i]=valueStr1;
        	//alert(valueStr);
        	
    	} 
    	//alert("retVal[0]"+retVal[0]);
    	if(retVal[0]=="0")
    	{
    		
    		var rescode_str=retVal[2]+"|";
    		
    		//alert("rescode_str"+rescode_str);
    		var rescode_strstr="";
    		//alert("rescode_str="+rescode_str)
    		var chPosm = rescode_str.indexOf("|");
    		for(i=0;i<4;i++)
    		{   	   
    	
    			var chPos1 = rescode_str.indexOf("|");
        		valueStr = rescode_str.substring(0,chPos1);
        		rescode_str = rescode_str.substring(chPos1+1);
        		//alert("rescode_str="+rescode_str)
        		if(i==0 && valueStr=="")
        		{
        			rdShowMessageDialog("读卡类型出错!");
    		 		return false;
        		}
        		//alert("valueStr="+valueStr);
        		if(valueStr!=""){
        			rescode_strstr=rescode_strstr+"'"+valueStr+"'"+",";
        			//alert("rescode_strstr="+rescode_strstr);
        		}
        	
    		} 
    		rescode_strstr=rescode_strstr.substring(0,rescode_strstr.length-1);
    		if(rescode_strstr=="")
    		{
    			rdShowMessageDialog("读卡类型出错!");
    		 	return false;   
    		}
  			 //alert("rescode_strstr="+rescode_strstr);
  		}
  		else{
  			 rdShowMessageDialog("读卡类型出错!");
    		 return false;   
    	}
  		 /****取SIM卡类型结束******/
    		 var path = "<%=request.getContextPath()%>/npage/innet/fgetsimno_1104.jsp";
    		 path = path + "?regioncode=" + "<%=regionCode%>";
    	         path = path + "&phone=" + phone + "&rescode=" + rescode_strstr+ "&pageTitle=" + "生成SIM卡号码";
    	       
    		 var retInfo = window.showModalDialog(path,"","dialogWidth:40;dialogHeight:20;");
    		 
    		 if(typeof(retInfo) == "undefined")     
    			{	return false;   }
    		
    		var simsim=oneTok(oneTok(retInfo,"~",1));
    		var typetype=oneTok(oneTok(retInfo,"~",2));
    		var cardcard=oneTok(oneTok(retInfo,"~",3));
    		document.frm1104.simNo.value=simsim;
    		document.all.simType.value=(cardcard).trim();
    		
    		if((typetype).trim()=="null"){
    			
    			
    			}else{
		 document.all.simTypeName.value=(typetype).trim();
    	}
  	}else{
  		document.all.b_write.disabled=true;
  		document.all.cardtype_bz.value="s";
  		document.all.b_qrySimType.disabled=false;
  	}

}
function okDialog() {
   var inputPassword = document.all.custPwd.value; 
   
   if (inputPassword.length == 0) {
       rdShowMessageDialog("密码不能为空，请重新输入！");
	   document.all.custPwd.focus();
	   return false;
   } else if (inputPassword.length < 6){
       rdShowMessageDialog("密码长度至少为6位，请重新输入！");
	   document.all.custPwd.focus();
       return false;
   }

   window.returnValue = inputPassword;     
   window.close();
}
function writechg(){
	if(document.frm1104.simNo.value==""){
		rdShowMessageDialog("sim卡号不能是空!");
		return false;
	}
	if(document.all.cardtype_bz.value=="k"){
		var phone = (document.frm1104.phoneNo.value).trim();
  			document.all.b_write.disabled=true;
    		 var path = "<%=request.getContextPath()%>/npage/innet/fwritecard.jsp";
    		 path = path + "?regioncode=" + "<%=regionCode%>";
    		 path = path + "&sim_type=" +document.frm1104.simType.value;
    		 path = path + "&sim_no=" +document.frm1104.simNo.value;
    		 path = path + "&op_code=" +"1104";
    	         path = path + "&phone=" + phone + "&pageTitle=" + "写卡";
    	       
    		 var retInfo = window.showModalDialog(path,"","dialogWidth:40;dialogHeight:20;");
    		 if(typeof(retInfo) == "undefined")     
    			{	rdShowMessageDialog("写卡失败"); document.frm1104.writecardbz.value="1"; 
    				document.all.b_write.disabled=false;
    				return false;   }
    		 
    		 var retsimcode=oneTok(oneTok(retInfo,"|",1));
    		 var retsimno=oneTok(oneTok(retInfo,"|",2));
    		 var cardstatus=oneTok(oneTok(retInfo,"|",3))
    		 
    		 if(retsimcode=="0"){rdShowMessageDialog("写卡成功");
    		 document.frm1104.writecardbz.value="0";
    		 document.all.simNo.value=retsimno;
    		 	document.all.cardstatus.value=cardstatus;
    		 	if(cardstatus=="3"){document.frm1104.simFee.value="0";}
    		 
    		 }else{
    		 	document.frm1104.writecardbz.value="1";
    		 	document.all.b_write.disabled=false;
    		 	rdShowMessageDialog("写卡失败");
    		 }
		// rdShowMessageDialog(document.frm1104.writecardbz.value);
	}
	else{
		rdShowMessageDialog("实卡不能写卡");
		document.all.b_write.disabled=true;
		return false;
	}
}

function qrySimType()
{
  if(checkElement(document.all.simNo)==false) return false;

   //得到sim卡类型
    var getAccountId_Packet = new AJAXPacket("pubGetSimType.jsp","正在获得sim卡类型，请稍候......");
    getAccountId_Packet.data.add("retType","getSimType");
	getAccountId_Packet.data.add("region_code","<%=regionCode%>");
	getAccountId_Packet.data.add("simNo",(document.all.simNo.value).trim());
	core.ajax.sendPacket(getAccountId_Packet);
	getAccountId_Packet=null;

}
 function getTokNums(str,tok)
{
   var temStr=str;
   if(str.charAt(0)==tok) temStr=str.substring(1,str.length);
   if(str.charAt(str.length-1)==tok) temStr=temStr.substring(0,temStr.length-1);

   var temLen;
   var temNum=1;
   while(temStr.indexOf(tok)!=-1)
   {	
      temLen=temStr.length;
      temLoc=temStr.indexOf(tok);
      temStr=temStr.substring(temLoc+1,temLen);
	  temNum++;
   }
   return temNum;
}


function chgCustType()
{
  document.all.idIccid.value="";
  document.all.custName.value="";
  document.all.custId.value="";
  document.all.custPwd.value="";
  document.all.idType.value="";
  document.all.custAddr.value="";

  if(document.all.customType[0].checked==true)  //已有客户
  {
	var divPassword = document.getElementById("divPassword");	
  	var divCustPad1 = document.getElementById("divCustPad1");
	var divCustPad2 = document.getElementById("divCustPad2");
		
	  divPassword.style.display="";
	  divCustPad1.style.display="";
	  divCustPad2.style.display="";
	
    document.all.str6.value=document.all.customType[0].value;

    document.all.custIdQuery.style.display="";
	document.all.chkPass.style.display="";
	document.all.resourceValid.disabled=true;

	document.all.custPwd.readOnly=false;
	document.all.idIccid.readOnly=false;
	document.all.custName.readOnly=false;
	document.all.custId.readOnly=false;
	document.all.custPwd.value=""; 
	chkPassFlag=false;
	document.all.idIccid.focus();
  }
  else                                   //新建客户
  {
	var divPassword = document.getElementById("divPassword");
	var divCustPad1 = document.getElementById("divCustPad1");
	var divCustPad2 = document.getElementById("divCustPad2");
	
  	if("09" == "<%=regionCode%>"){
			
			divPassword.style.display="none";
			divCustPad1.style.display="none";
			divCustPad2.style.display="none";
	}

    document.all.str6.value=document.all.customType[1].value;

    document.all.custIdQuery.style.display="none";
	document.all.chkPass.style.display="none";
	document.all.resourceValid.disabled=false;

	document.all.custPwd.readOnly=true;
	document.all.idIccid.readOnly=true;
	document.all.custName.readOnly=true;
	document.all.custId.readOnly=true;
	document.all.custPwd.value="";
	chkPassFlag=true;
	document.all.smCodeList.focus();
	window.open("f1100_1c.jsp","","width="+(screen.availWidth*1-70)+",height="+(screen.availHeight*1-90) +",left=30,top=20,resizable=yes,scrollbars=yes,status=yes,location=no,menubar=no");    		
  }
}
//---------1------RPC处理函数------------------
function doProcess(packet)
{	
     //RPC处理函数findValueByName
	var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode"); 
    var retMessage = packet.data.findValueByName("retMessage");	
    self.status="";

 	if((retCode).trim()=="")
	{
      rdShowMessageDialog("调用"+retType+"服务时失败！");
      return false;
	}
   	if(retType == "AccountId")
	{   //得到帐户ID
        if(retCode=="000000")
    	{
            var retAccountId = packet.data.findValueByName("retnewId");    	    
    	    document.frm1104.accountID.value = retAccountId;
    	   // document.frm1104.userIdQuery.disabled = true;
    	    //if(frm1104.userID.value == "")  //生成帐户ID的同时自动生成用户ID
			//{	getUserId();		}
    	}
    	else
    	{
    	    retMessage = retMessage + "[errorCode1:" + retCode + "]";
    		rdShowMessageDialog(retMessage,0);
			return false;
    	}
    	
		if(frm1104.userID.value == "")  //生成帐户ID的同时自动生成用户ID
			{	
				getUserId();	
					}
	}

	if(retType=="getSimType")
	{
      if(retCode=="000000")
	  {  
         var sim_type = packet.data.findValueByName("sim_type");    	    
         var sim_typename = packet.data.findValueByName("sim_typename");
         
		 document.all.simType.value=(sim_type).trim();
		 if(sim_typename=="null"){
		 		
		 	}else{
		 		document.all.simTypeName.value=(sim_typename).trim();
		 		}
	
	  }
      else
      {
		retMessage = retMessage + "[errorCode2:" + retCode + "]";
		rdShowMessageDialog(retMessage,0);
		return false;
      }
	}
 
	//---------------
  	if(retType == "UserId")
	{   //得到用户ID
        if(retCode=="000000")
    	{
    	
           var retUserId = packet.data.findValueByName("retnewId");    	    
    	    document.frm1104.userID.value = retUserId;
    	    document.frm1104.userIdQuery.disabled = true;
			//if(frm1104.accountID.value == "")  //生成用户ID的同时自动生成帐户ID
			//{	getAccountId();		}    	    
    	}
    	else
    	{
    	    retMessage = retMessage + "[errorCode2:" + retCode + "]";
    		rdShowMessageDialog(retMessage,0);
			return false;
    	}
    	frm1104.accountID.value ="";
		if(frm1104.accountID.value == "")  //生成用户ID的同时自动生成帐户ID
		{	
			getAccountId();
					}    	    
	}	
	//---------------
  	if(retType == "getAssuInfo")
	{   //得到担保人信息
    	if(retCode=="000000")
    	{
            var assuNum = packet.data.findValueByName("assuNum"); 
            var assuMaxNum = packet.data.findValueByName("assuMaxNum"); 
            var assuName = packet.data.findValueByName("assuName"); 
            var assuPhone = packet.data.findValueByName("assuPhone"); 
            var assuAddr = packet.data.findValueByName("assuAddr"); 
            var assuZip = packet.data.findValueByName("assuZip");         
            if((typeof(assuName)=="undefined") ||(assuNum == ""))
            {   return false;   }
            if(1*assuNum < 1*assuMaxNum)
            {
                document.frm1104.assuName.value = assuName;
                document.frm1104.assuPhone.value = assuPhone;
                document.frm1104.assuAddr.value = assuAddr;
                document.frm1104.assuZip.value = assuZip; 
    	        //document.frm1104.assuQuery.disabled = true;                 
            }
            else
            {
        		rdShowMessageDialog("此担保人已担保数量已经达到了最大值，不能在继续担保！",0); 
        		return false;               
            }
			rpc_chkX_2("assuIdType","assuId","A","chkX_2");
    	}
    	else
    	{
    	    retMessage = retMessage + "[errorCode3:" + retCode + "]";
    		rdShowMessageDialog(retMessage,0);
			return false;
    	}	
	}
	//-------------------------------------
	if(retType == "QryForeSimNo")
	{
		if(retCode=="000000")
    	{
			var foreFlag = packet.data.findValueByName("foreFlag");  
			var simNo = packet.data.findValueByName("simNo"); 
			var simType = packet.data.findValueByName("simType");
			var simTypeName = packet.data.findValueByName("simTypeName");
			if(foreFlag != "N") 
			{
				frm1104.simNo.value = simNo;
				preFlag=true;		
			    frm1104.simType.value = simType;
			    if( simTypeName.trim()=="null"){
			    	}else{
				frm1104.simTypeName.value = simTypeName.trim();				
			       }
			}
			else
			{
               preFlag=false;
			}
 			//================
			var QryForeSimNo_Packet = new AJAXPacket("fGetBindAddi.jsp","正在获得绑定附加资费，请稍候......");
 			QryForeSimNo_Packet.data.add("retType","fGetBindAddi");
 			QryForeSimNo_Packet.data.add("Phone_no",frm1104.phoneNo.value);
 			QryForeSimNo_Packet.data.add("org_code","<%=belongCode%>");			
 			QryForeSimNo_Packet.data.add("Sm_code",frm1104.smCodeList.value);		
 			core.ajax.sendPacket(QryForeSimNo_Packet);
 			QryForeSimNo_Packet=null; 
    	}
    	else
    	{
    	    retMessage = retMessage + "[errorCode0:" + retCode + "]";
    		rdShowMessageDialog(retMessage,0);       	
			return false;
    	}
	}
	//========================================
 
	if(retType == "getInfo_withID")
	{   //根据客户ID获得相应信息
		
	    if(retCode == "000000")
	    {
	       var retInfo = packet.data.findValueByName("retInfo");
	       if(retInfo != "")
           {
               //var recordNum = packet.data.findValueByName("recordNum"); 
               //showParentInfo(retInfo);	
               for(i=0;i<8;i++)
               {   	   
        	        var chPos = retInfo.indexOf("|");
                    valueStr = retInfo.substring(0,chPos);
                    retInfo = retInfo.substring(chPos+1);
                    var obj = "in" + i;
                    document.all(obj).value = valueStr;
                } 
	        }
			else
			{
			  rdShowMessageDialog("客户不存在！",0);  
			  return false;
			}
            //sCheckIccid();
	    }	        
	    else
	    {
	        retMessage = retMessage + "[errorCode4:" + retCode + "]";
    		rdShowMessageDialog(retMessage,0);
			return false;
	    }
    
	  <%
	    //------------------------------------zuming修改代码@20071220
	    //sunwt 修改 20080429
	    String paramsIn[] = new String[2];
		
		System.out.println("1111111111111sunwt111111120080429");
		
	 	paramsIn[0] = workNo;       //工号
	 	paramsIn[1] = "a272";        //操作代码
	 	
	 	//SPubCallSvrImpl callViewCheck = new SPubCallSvrImpl();
		//ArrayList acceptList = new ArrayList();
		//int errCode = -1;
		//String errMsg ="";
		
	/**	try
		{
			acceptList = callViewCheck.callFXService("sFuncCheck", paramsIn, "1","region", regionCode);	
			errCode = callViewCheck.getErrCode();
			errMsg = callViewCheck.getErrMsg();
		}
		catch(Exception e)
		{
			e.printStackTrace();
			logger.error("Call sFuncCheck is Failed!");
		}
		**/
		%>
		<wtc:service name="sFuncCheck" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg"  outnum="1" >
        <wtc:params value="<%=paramsIn%>"/>
		</wtc:service>
		<wtc:array id="strReturnArray" scope="end" />

		<%
		System.out.println(retCode+"   retCode in sFuncCheck in f1104_1.jsp");
		/*添加服务调用是否成功标志  刘通 2008.08.21*/
		String sFuncCheckClose="";
		  if(!retCode.equals("000000")){
		       sFuncCheckClose="close";
			}
		
		//int recordNum1 = Integer.parseInt(((String[][])acceptList.get(0))[0][0]);       //把count(*)取出
		int recordNum1 =Integer.parseInt( strReturnArray[0][0]);
	    /*
	    String sqlStr1 = "select count(*) from sfuncpower where function_code='a272' and power_code in (select power_code from dloginmsg where login_no='" +workNo+ "')";            //function_code为a272的为指定权限，可以不受限制继续开户
			retArray = callView.view_spubqry32("1",sqlStr1);                              //取出sql语句执行结果
			int recordNum1 = Integer.parseInt(((String[][])retArray.get(0))[0][0]);       //把count(*)取出
		*/
	    if(recordNum1 == 0)
	    {
	    System.out.println("recordNum1 == 0 in sFuncCheck f1104_1.jsp");
	  %>
	  	sCheckIccid();
		
		<%
		  }
		
		  //------------------------------------zuming修改代码@20071220
    %>
		
	}
	//-----------------------------------
    if(retType == "getSysAccept")
    { 
    	if(retCode=="000000")
    	{	
    		frm1104.sysAccept.value = packet.data.findValueByName("sysAccept");
    		printInfo("Detail");	
    	}
    	else
    	{  	
    		rdShowMessageDialog(retMessage+"-------------------------------------------------------------------",0); 
			  return false;
    	}
   	}
   	//-----------------------------------
  if(retType=="getlike"){
   	if(retCode=="000000")
    	{	
    		frm1104.getlike.value = packet.data.findValueByName("award");
    		return false;
    	}
    	else
    	{  	
    		rdShowMessageDialog("校验是否能参与入网新惊喜出错!",0); 
    		
			return false;
    	}
   
   } 
   	//---------------------------------------------------

//王良 2008年1月7日 封掉
/*	 
	 if(retType == "getNote")
    {
    	if(retCode=="000000")
    	{	
    		frm1104.advNote.value = packet.data.findValueByName("note");
    		frm1104.detailcode.value = packet.data.findValueByName("detailcode");
    		frm1104.adddetailcode.value = packet.data.findValueByName("adddetailcode");
    		frm1104.adddetailcodenote.value = packet.data.findValueByName("adddetailcodenote");
    		frm1104.mode_note.value = packet.data.findValueByName("mode_note");
    		frm1104.re_funcstr.value = packet.data.findValueByName("re_funcstr");

			showPrtDlg("Detail","确实要打印电子免填单吗？","Yes");
			if(rdShowConfirmDialog("确认要提交全球通普通开户信息吗？")==1){
				if(frm1104.post.checked == true){
					frm1104.postFlag.value = "1";             
				}else{
					frm1104.postFlag.value = "0";
				}
		
				frm1104.operType.value = frm1104.smCodeList.value;
				document.frm1104.upBillType.value = document.frm1104.billType.value;
					 
				if(typeof(frm1104.CredId)!="undefined"){
					frm1104.hid_CredId.value = frm1104.CredId.value;	
				}else{	
					frm1104.hid_CredId.value = "";	
				}
				
				frm1104.action="f1104_2.jsp";
				document.frm1104.phoneNo.disabled=false;
		    document.frm1104.simNo.disabled=false;
		    document.all.printcount.value="1";
				frm1104.submit();
			}		
	  	}else if(retCode=="000001"){
				frm1104.advNote.value = "";
				frm1104.detailcode.value = packet.data.findValueByName("detailcode");
				frm1104.adddetailcode.value = packet.data.findValueByName("adddetailcode");
				frm1104.mode_note.value = packet.data.findValueByName("mode_note");
				frm1104.adddetailcodenote.value = packet.data.findValueByName("adddetailcodenote");
				frm1104.re_funcstr.value = packet.data.findValueByName("re_funcstr");
				showPrtDlg("Detail","确实要打印电子免填单吗？","Yes");
				if(rdShowConfirmDialog("确认要提交全球通普通开户信息吗？")==1){
			 		if(frm1104.post.checked == true){
			 			frm1104.postFlag.value = "1";             
			 		}else{
			 			frm1104.postFlag.value = "0";
			 		}

			    frm1104.operType.value = frm1104.smCodeList.value;
			    document.frm1104.upBillType.value = document.frm1104.billType.value;
			 
			    if(typeof(frm1104.CredId)!="undefined"){	
			    	frm1104.hid_CredId.value = frm1104.CredId.value;	
			    }else{	
			    	frm1104.hid_CredId.value = "";	 
			    }
		      
		      frm1104.action="f1104_2.jsp";
		      document.frm1104.phoneNo.disabled=false;
        	document.frm1104.simNo.disabled=false;
        	document.all.printcount.value="0";
				  frm1104.submit();
				}		
			}else{  	
    		rdShowMessageDialog(retMessage,0); 
				return false;
    	}
   	}
 */
 //王良 2008年1月7日 修改
	if(retType == "getNote")
  {
  	if(retCode=="000000")
    {	
    	frm1104.advNote.value = packet.data.findValueByName("note");
    	frm1104.detailcode.value = packet.data.findValueByName("detailcode");
    	frm1104.adddetailcode.value = packet.data.findValueByName("adddetailcode");
    	frm1104.adddetailcodenote.value = packet.data.findValueByName("adddetailcodenote");
    	frm1104.mode_note.value = packet.data.findValueByName("mode_note");
    	frm1104.re_funcstr.value = packet.data.findValueByName("re_funcstr");
      var falgl=document.all.payWay.value;
		if(falgl.length <=0 || falgl.length == "")
		{
			rdShowMessageDialog("请选择主资费方式!");  return false; }
			showPrtDlg("Detail","确实要打印电子免填单吗？","Yes");
			var iReturn = 0;
			iReturn = showEvalConfirmDialog('确认要提交全球通普通开户信息吗？')
			if(iReturn==1||2==iReturn){
		   	if(2==iReturn){
      		var vEvalValue = GetEvalReq(1);
      		document.all.haseval.value="1";
      		document.all.evalcode.value = vEvalValue;
      	}else{
    			document.all.haseval.value="0";
      		document.all.evalcode.value="0";
       	}
				
				if(frm1104.post.checked == true){
					frm1104.postFlag.value = "1";             
				}else{
					frm1104.postFlag.value = "0";
				}
		
				frm1104.operType.value = frm1104.smCodeList.value;
				document.frm1104.upBillType.value = document.frm1104.billType.value;
					 
				if(typeof(frm1104.CredId)!="undefined"){
					frm1104.hid_CredId.value = frm1104.CredId.value;	
				}else{	
					frm1104.hid_CredId.value = "";	
				}
				
				frm1104.action="f1104_2.jsp";
				document.frm1104.phoneNo.disabled=false;
		    document.frm1104.simNo.disabled=false;
		    document.all.printcount.value="1";
				frm1104.submit();
			}		
	  	}else if(retCode=="000001"){
				frm1104.advNote.value = "";
				frm1104.detailcode.value = packet.data.findValueByName("detailcode");
				frm1104.adddetailcode.value = packet.data.findValueByName("adddetailcode");
				frm1104.mode_note.value = packet.data.findValueByName("mode_note");
				frm1104.adddetailcodenote.value = packet.data.findValueByName("adddetailcodenote");
				frm1104.re_funcstr.value = packet.data.findValueByName("re_funcstr");
				showPrtDlg("Detail","确实要打印电子免填单吗？","Yes");
				var iReturn =0;			
				iReturn = showEvalConfirmDialog('确认要提交全球通普通开户信息吗？'); 
				if(iReturn==1||2==iReturn){
					
			   	if(2==iReturn){
      			var vEvalValue = GetEvalReq(1);
      			document.all.haseval.value="1";
      			document.all.evalcode.value = vEvalValue;
      		}else{
      			document.all.haseval.value="0";
      			document.all.evalcode.value="0";
       		}
   		
			 		if(frm1104.post.checked == true){
			 			frm1104.postFlag.value = "1";             
			 		}else{
			 			frm1104.postFlag.value = "0";
			 		}

			    frm1104.operType.value = frm1104.smCodeList.value;
			    document.frm1104.upBillType.value = document.frm1104.billType.value;
			 
			    if(typeof(frm1104.CredId)!="undefined"){	
			    	frm1104.hid_CredId.value = frm1104.CredId.value;	
			    }else{	
			    	frm1104.hid_CredId.value = "";	 
			    }
		      
		      frm1104.action="f1104_2.jsp";
		      document.frm1104.phoneNo.disabled=false;
        	document.frm1104.simNo.disabled=false;
        	document.all.printcount.value="0";
        	
				  frm1104.submit();
				}		
			}else{  	
    		rdShowMessageDialog(retMessage,0); 
				return false;
    	}
  }
 ///////////////////////////  	
	//---------------------------------------------------
 
  	if(retType == "sCheckIccid")
	{   //查询客户的开户数、最大开户数
        if(retCode=="000000")
    	{
            var Count = packet.data.findValueByName("Count"); 
            var MaxCount = packet.data.findValueByName("MaxCount");
            if(1*Count >= 1*MaxCount)
            {
                var msg = "客户'" + frm1104.custName.value + "'的开户数量已经达到或超过了最大开户数，不能继续开户！" 
                rdShowMessageDialog(msg ,0);
                for(i=0;i<7;i++)
                {   	   
                    var obj = "in" + i;
                    document.all(obj).value = "";
                }                 
            }
			else
			{
              rpc_chkX_2("idType","idIccid","A","chkX_1");
			}
    	}
    	else
    	{
    	    retMessage = retMessage + "[errorCode5:" + retCode + "]";
    		rdShowMessageDialog(retMessage,0);
            for(i=0;i<7;i++)
            {   	   
                var obj = "in" + i;
                document.all(obj).value = "";
            }
			return false;
    	}
	}	
    //---------------------------------------------------	
	if(retType == "getFeeInfo")
	{   //获得费用信息
	    if(retCode == "000000")
	    {
    	    var sV_Choice_fee = packet.data.findValueByName("sV_Choice_fee"); 
            var sV_Sim_fee = packet.data.findValueByName("sV_Sim_fee"); 
            var sV_Hand_fee = packet.data.findValueByName("sV_Hand_fee");
            var sV_Phone_prepay = packet.data.findValueByName("sV_Phone_prepay");
            var sV_Innet_fee = packet.data.findValueByName("sV_Innet_fee");
            var sV_Innet_prepay = packet.data.findValueByName("sV_Innet_prepay");  
			var sV_Main_fee=packet.data.findValueByName("sV_Main_fee");
            document.frm1104.choiceFee.value = sV_Choice_fee;           //选号费
            if(frm1104.simType.value!="10013" && frm1104.simType.value!="10014" && frm1104.simType.value!="10015"){
            document.frm1104.simFee.value = sV_Sim_fee;   }              //sim卡费
            document.frm1104.handFee.value = sV_Hand_fee;               //手续费
            document.frm1104.choicePreFee.value = sV_Phone_prepay;      //号码预存
            document.frm1104.innetFee.value = sV_Innet_fee;             //入网费
			if((frm1104.innetPreFee.value).trim().length==0)
			  document.frm1104.innetPreFee.value = sV_Innet_prepay;       //入网预存
			else
			{
			  if(parseFloat(frm1104.innetPreFee.value)<=0)
                document.frm1104.innetPreFee.value = sV_Innet_prepay;       //入网预存
			}			 
		 
            //初始计算交款金额、交款总额
            frm1104.sumPay.value = 1*frm1104.handFee.value  + 1*frm1104.choiceFee.value
                               + 1*frm1104.machFee.value + 1*frm1104.simFee.value
                               + 1*frm1104.choicePreFee.value + 1*frm1104.innetFee.value 
                               + 1*frm1104.innetPreFee.value+1*frm1104.espPreFee.value;
            frm1104.cashPay.value=frm1104.sumPay.value;							   
                             
            //为临时费用框赋值----- 
            //document.frm1104.hid_MachFee.value = document.frm1104.machFee.value;
            document.frm1104.hid_ChoiceFee.value = sV_Choice_fee;
            //document.frm1104.hid_SimFee.value = sV_Sim_fee;
            document.frm1104.hid_SimFee.value =document.frm1104.simFee.value
            document.frm1104.hid_HandFee.value = sV_Hand_fee;
            document.frm1104.hid_choicePreFee.value = sV_Phone_prepay;
            document.frm1104.hid_innetFee.value = sV_Innet_fee;
            document.frm1104.hid_innetPreFee.value = sV_Innet_prepay;
            frm1104.sumParCount.disabled = false;
	    }	        
	    else
	    {
	        retMessage = retMessage + "[errorCode6:" + retCode + "]";
    		rdShowMessageDialog(retMessage,0);
    		return false;
	    }
	}
 
    //-----------------------------------------
    if(retType == "checkPwd")
    {
         //进行密码校验
		 
		chkPassFlag=false;
        var retResult = packet.data.findValueByName("retResult");
		frm1104.checkPwd_Flag.value = retResult; 
		
/* 王良 2008年1月7日 测试封掉源服务,需要恢复*/
		
 	    if(frm1104.checkPwd_Flag.value == "false")
	    {
	    	rdShowMessageDialog("客户密码校验失败，请重新输入！",0);
	    	frm1104.custPwd.value = "";
	    	frm1104.custPwd.focus();
	    	frm1104.checkPwd_Flag.value = "false";	    	
	    	return false;	        	
	    }
		else
		{
 		  if("09" == "<%=regionCode%>")
 		  {
			if(document.frm1104.custPwd.value == "000000"||document.frm1104.custPwd.value == "111111"||document.frm1104.custPwd.value == "222222"
		 	 ||document.frm1104.custPwd.value == "333333"||document.frm1104.custPwd.value == "444444"||document.frm1104.custPwd.value == "555555"
		 	 ||document.frm1104.custPwd.value == "666666"||document.frm1104.custPwd.value == "777777"||document.frm1104.custPwd.value == "888888"
		 	 ||document.frm1104.custPwd.value == "999999"||document.frm1104.custPwd.value == "123456")
	   		{
	   			rdShowMessageDialog("业务规定：简单密码不允许办理业务，请修改后再办理!");
	   			return false;
	   		}
	   	  }
 		   rdShowMessageDialog("客户密码校验成功！");
 		   frm1104.userPwd.value=frm1104.custPwd.value;
   		   frm1104.cfmuserPwd.value=frm1104.custPwd.value;
		   
		   document.all.resourceValid.disabled=false;
		   chkPassFlag=true;
		}

		var iccid = document.frm1104.idIccid.value;
		var len = document.frm1104.idIccid.value.length;
		var iccid1 = iccid.substr(len-4,4);
		var pass = "00"+iccid1; 
		if("09" != "<%=regionCode%>")
 		{
			if(document.frm1104.custPwd.value == "000000"||document.frm1104.custPwd.value == "001234"||document.frm1104.custPwd.value == pass)
	   		{
	         	rdShowMessageDialog("密码过于简单，请及时修改！");
	    	}
	    }
	    
     }	
	//------------------
	if(retType == "checkCred")
	{
        if(retCode=="000000")
    	{
			rdShowMessageDialog("凭证密码校验成功！");
    		var credPwd = packet.data.findValueByName("credPwd"); 
			 
			frm1104.hidEInfo.value = packet.data.findValueByName("eInfo"); 			
    	}
    	else
    	{
    	    retMessage = retMessage + "[errorCode7:" + retCode + "]";
    		rdShowMessageDialog(retMessage,0);
			return false;
    	}	
	}
	//----------------
	if(retType=="chkX_1")
	{
        var retObj = packet.data.findValueByName("retObj");

		if(retCode == "000000")
        {
          blackFlag=true;
		}
		/**
        else 
        {
             retMessage = "错误" + retCode + "："+retMessage;			 
             rdShowMessageDialog(retMessage,0);
			 blackFlag=false;
			 document.all(retObj).focus();
			 return false;
        }
		*/
		  else if(retCode=="100001")
        {
             retMessage = retCode + "："+retMessage;			 
            // rdShowMessageDialog(retMessage,0);
			 blackFlag=false;
			 frm1104.custPwd.focus();
			 /**
			 frm1104.custName.value="";
			 frm1104.idType.value="";
			 frm1104.custId.value="";
			 frm1104.custAddr.value="";
			 */
			 return true;
        }
		else
		{
			 retMessage = "错误" + retCode + "："+retMessage;			 
             rdShowMessageDialog(retMessage,0);
		     document.all.print.disabled=true;
			 document.all(retObj).focus();
			 return false;
		}
	}

	if(retType=="chkX_2")
	{
        var retObj = packet.data.findValueByName("retObj");

		if(retCode == "000000")
        {
          assuBlackFlag=true;
		}
		  else if(retCode=="100001")
        {
             retMessage = retCode + "："+retMessage;			 
             //rdShowMessageDialog(retMessage,0);
			 blackFlag=false;
			 //frm1104.custPwd.focus();
			 return true;
        }
        else
        {
		  retMessage = "错误" + retCode + "："+retMessage;			 
		  rdShowMessageDialog(retMessage,0);
		  assuBlackFlag=false;
		  document.all(retObj).focus();
		  return false;
        }
	}

	//---------------
  	if(retType == "checkResource")
	{   //进行资源校验
		//alert(frm1104.simType.value);
        if(retCode=="0"||retCode=="000000")
    	{
    	    //getFee();   //得到费用参数
				    	    if(frm1104.simType.value>="10013" && frm1104.simType.value<="10015"){
												if(frm1104.simType.value=='10013' && frm1104.newSmCode.value!='bgn'){
												rdShowMessageDialog("只有业务品牌是全球通的用户才能用全球64KOTA卡！");
												return false;}
												if(frm1104.simType.value=='10014' && frm1104.newSmCode.value!='bdn'){
												rdShowMessageDialog("只有业务品牌是动感地带的用户才能用动感地带64KOTA卡！");
												return false;}
												if(frm1104.simType.value=='10015' && frm1104.newSmCode.value!='bzn'){
												rdShowMessageDialog("只有业务品牌是神洲行的用户才能用神洲行64KOTA卡！");
												return false;}
							}
		            rdShowMessageDialog("资源校验成功！");
		            document.frm1104.phoneNo.disabled=true;
		            document.frm1104.simNo.disabled=true;
		            frm1104.hid_checkRes.value = "1";
					getGoodPhoneMainBill();
					if(frm1104.simType.value=="10013" ||frm1104.simType.value=="10014" ||frm1104.simType.value=="10015"){
					getnew_simfee();
					frm1104.innetPreFee.value=parseFloat(frm1104.innetPreFee.value,10)+parseFloat(frm1104.simpre.value,10);
					}
					 if(document.all.cardtype_bz.value=='k'){
			  			document.all.b_write.disabled=false;
			  
			  		}
    	}
    	else
    	{
    		document.frm1104.phoneNo.value="";
            document.frm1104.simNo.value="";
    	    retMessage = retMessage + "[errorCode8:" + retCode + "]";
    		rdShowMessageDialog(retMessage,0);
    		return false;
    	}
		getFee();   //得到费用参数
	}
	//---------------
  	if(retType == "getChinaFee")
	{   //进行资源校验
        if(retCode=="000000")
    	{	  
    		chinaFee = packet.data.findValueByName("chinaFee"); 
    	}
    	else
    	{	return false;    	}	
	}	
	//--------------------------------------------------------
  	if(retType == "getCheckInfo")
	{   //得到支票信息
        var obj = "chPayNum" + 0;        
        if(retCode=="000000")
    	{
            var bankCode = packet.data.findValueByName("bankCode");
            var bankName = packet.data.findValueByName("bankName");
            var checkPrePay = packet.data.findValueByName("checkPrePay");
            if(checkPrePay == "0")
            {
    		    frm1104.checkNo = "";
                frm1104.bankCode.value = "";
                frm1104.bankName.value = "";                
                frm1104.checkNo.focus();
                document.all(obj).style.display = "none";
                rdShowMessageDialog("该支票的帐户余额为0！",0);
            }
            else
            {   document.all(obj).style.display = "";            }
            
            frm1104.bankCode.value = bankCode;
            frm1104.bankName.value = bankName;
            frm1104.checkPrePay.value = checkPrePay;            
    	}
    	else
    	{
    		frm1104.checkNo.value = "";
            frm1104.bankCode.value = "";
            frm1104.bankName.value = "";
            document.all(obj).style.display = "none"; 
            frm1104.checkNo.focus();
    	    retMessage = retMessage + "[errorCode9:" + retCode + "]";
    		rdShowMessageDialog(retMessage,0);               		
			return false;
    	}	
	}
	if(retType == "PackInfo")
	{		//alert("sssssssssssss22222222222222");
		
		//得到营销包信息
        if(retCode=="000000")
    	{
            var pack_backcode = packet.data.findValueByName("pack_backcode");
            var pack_prefee = packet.data.findValueByName("pack_prefee");
            pack_addifeeCode = packet.data.findValueByName("pack_addifeeCode");
			pack_addifeeName = packet.data.findValueByName("pack_addifeeName");
			var pack_mainfeeCode = packet.data.findValueByName("pack_mainfeeCode");
			var pack_mainfeeName = packet.data.findValueByName("pack_mainfeeName");
			
            document.all.tr_pack_creditNo.style.display="";

			//营销包绑定的主资费，它对界面的主资费和可选资费产生影响
			frm1104.payWay.value = pack_mainfeeName;
			//alert("mmmmmmmmm="+frm1104.payWay.value);
			frm1104.payCode.value = pack_mainfeeCode;

			frm1104.additivePayWay.value="";
            frm1104.additiveCode.value="";
			
            if(pack_mainfeeCode!="")
			{                         
			  frm1104.selectMode.disabled=true;			  
			  //frm1104.selectAdditive.disabled=true;
			  subPassFlag=true;
			}
            
			//营销包绑定的预存
			frm1104.innetPreFee.value=pack_prefee;
			getTtFee();

			//营销包绑定的可选资费
			//frm1104.pack_addifeeCode.value=pack_addifeeCode;
			//frm1104.pack_addifeeName.value=pack_addifeeName;      
			frm1104.additivePayWay.value=pack_addifeeName; 
			frm1104.additiveCode.value=pack_addifeeCode;
    	}
    	else
    	{
			if(retCode!="000001")
			{    		  
    	      retMessage = retMessage + "[errorCode10:" + retCode + "]";
    		  rdShowMessageDialog(retMessage,0);               		
			  return false;
			}
			else
			{
               document.all.tr_pack_creditNo.style.display="none";

               //对界面值进行恢复 
               //frm1104.payWay.value=pack_re_mainName;
               /*********liucm修改，购机入网也要手工选资费*/
               frm1104.payWay.value="";
              // alert("nnnnnnn="+frm1104.payWay.value);
               frm1104.payCode.value=pack_re_mainCode;
               frm1104.additivePayWay.value=pack_re_choiName;
               frm1104.additiveCode.value=pack_re_choiCode;
               subPassFlag=pack_re_choiFlag;
               frm1104.innetPreFee.value=pack_re_prefee;
			   getTtFee();
               
			   //恢复按钮状态
		       frm1104.selectMode.disabled=false;
			   frm1104.selectAdditive.disabled=false;

			   //营销包绑定的可选资费
			   //frm1104.pack_addifeeCode.value="";
			   //frm1104.pack_addifeeName.value="";
			   frm1104.additivePayWay.value=""; 
			   frm1104.additiveCode.value="";
			}
    	}	
	}
	if(retType == "packCreInfo")
	{		
		//得到营销包凭证信息
        if(retCode!="000000")
    	{
          if(retCode!="000001")
		  {    		  
    	      retMessage = retMessage + "[errorCode11:" + retCode + "]";
    		  rdShowMessageDialog(retMessage,0);               		
			  return false;
		  }
		  else
		  {
              rdShowMessageDialog(retMessage);   
		  }
		}
	}
	if(retType == "fGetBindAddi")
	{
		//得到绑定附加资费信息
        if(retCode=="000000")
    	{
		  var bindModeCode = packet.data.findValueByName("bindModeCode");
		  var bindModeName = packet.data.findValueByName("bindModeName");

		  document.all.bindModeName.value=bindModeName;
		  document.all.bindModeCode.value=bindModeCode;
		
		}
		else
		{
		   retMessage = retMessage + "[errorCode12:" + retCode + "]";
    	   rdShowMessageDialog(retMessage,0);               		
		   return false;
		}           
	}
	if(retType == "fGetBindAddi_conf")
	{
		
		//得到绑定附加资费信息
		if(retCode=="000000")
    	{ 
		  var bindModeCode = packet.data.findValueByName("bindModeCode");
		  var bindModeName = packet.data.findValueByName("bindModeName");
		
		  document.all.bindModeName.value=bindModeName;
		  document.all.bindModeCode.value=bindModeCode;
		  printCommit();
		}
		else
		{  rdShowMessageDialog("得到绑定附加资费信息失败");
		   retMessage = retMessage + "[errorCode13:" + retCode + "]";
    	   rdShowMessageDialog(retMessage,0);               		
		   return false;
		}           
	}
	if(retType == "checkGoodPhone")
	{
		//判断此手机号码是否被占用
        if(retCode=="000000")
    	{
		   retMessage="此手机号码已经被占用，不能开户！";
    	   rdShowMessageDialog(retMessage,0);    
		   frm1104.phoneNo.value=""; 
		   document.all.phoneNo.focus();
		   return false;
		}
		else if(retCode=="000001")
		{
			checkResource();
		}
		else
		{
			if(retCode=="000002")
			rdShowMessageDialog(retMessage,0);  
		 	return false;
		}           
	}
	if(retType == "getGoodPhoneMainBill")
	{
		//得到好号的主资费及最小预存
	//alert(retCode);
        if(retCode=="000000")
        
    	{	frm1104.goodphone.value='Y';
    		//document.all.is_not_adward1.style.display="none";
    		//frm1104.is_not_adward.value='N';
		  modeCode = packet.data.findValueByName("payCode");
		  frm1104.smallestPrepay.value = packet.data.findValueByName("smallestPrepay");
		 
		 // alert(frm1104.smallestPrepay.value);
		 // alert(frm1104.smallestPrepay.value);
		 // frm1104.payWay.value = packet.data.findValueByName("payWay");
		 // alert("iiiiiii="+frm1104.payWay.value);
		  frm1104.modedxpay.value = modeCode;//这里存的是底线金额
		  //alert(frm1104.modedxpay.value);
		 // frm1104.selectMode.disabled = true;
		 // frm1104.selectModeFlag.value=1;
		  
		}
		else if(retCode=="000001")
		{
			frm1104.goodphone.value='N';
			//if(frm1104.innetCode.options[frm1104.innetCode.selectedIndex].text!="商务电话" && frm1104.innetCode.options[frm1104.innetCode.selectedIndex].text!="IP超市" ){
				//document.all.is_not_adward1.style.display="";
				//frm1104.is_not_adward.value='Y';
			//}
			return false;
		}
		else 
		{
		   retMessage = retMessage + "[errorCode14:" + retCode + "]";
    	   rdShowMessageDialog(retMessage,0);               		
		   return false;
		}           
	}
	
	
	
}

function rpc_chkX_2(x_type,x_no,chk_kind,retFlag)
{
  var obj_type=document.all(x_type);
  var obj_no=document.all(x_no);
  var idname="";

  if(obj_type.type=="text")
  {
    idname=(obj_type.value).trim();
  }
  else if(obj_type.type=="select-one")
  {
    idname=(obj_type.options[obj_type.selectedIndex].text).trim();  
  }

  if((obj_no.value).trim().length>0)
  {
    if((obj_no.value).trim().length<5)
	{
      rdShowMessageDialog("证件号码长度有误（至少5位）！");
	  obj_no.focus();
  	  return false;
	}
	else
	{
      if(idname=="身份证")
	  {
        if(checkElement(obj_no)==false) return false;
	  }
	}
  }
  else 
	return;

  var myPacket = new AJAXPacket("/npage/innet/chkX.jsp","正在验证黑名单信息，请稍候......");
  myPacket.data.add("retType",retFlag);
  myPacket.data.add("retObj",x_no);
  myPacket.data.add("x_idType",getX_idno(idname));
  myPacket.data.add("x_idNo",obj_no.value);
  myPacket.data.add("x_chkKind",chk_kind);
  core.ajax.sendPacket(myPacket);
  myPacket=null;
  
}

function getX_idno(xx)
{
  if(xx==null) return "0";
  
  if(xx=="身份证") return "0";
  else if(xx=="军官证") return "1";
  else if(xx=="驾驶证") return "2";
  else if(xx=="警官证") return "4";
  else if(xx=="学生证") return "5";
  else if(xx=="单位") return "6";
  else if(xx=="校园") return "7";
  else if(xx=="营业执照") return "8";
  else return "0";
}

//------------------------------------------
function getAccountId()
{
    //得到帐户ID
    var getAccountId_Packet = new AJAXPacket("f1100_getId.jsp","正在获得帐户ID，请稍候......");
    getAccountId_Packet.data.add("retType","AccountId");
	getAccountId_Packet.data.add("region_code","<%=regionCode%>");
	getAccountId_Packet.data.add("idType","1");
	getAccountId_Packet.data.add("oldId","0");
	core.ajax.sendPacket(getAccountId_Packet);
	getAccountId_Packet=null;
}
//------------------------------------------
function getUserId()
{
    //得到用户ID
    var getUserId_Packet = new AJAXPacket("f1100_getId.jsp","正在获得帐户ID，请稍候......");
	getUserId_Packet.data.add("retType","UserId");
	getUserId_Packet.data.add("region_code","<%=regionCode%>");
	getUserId_Packet.data.add("idType","1");
	getUserId_Packet.data.add("oldId","0");
	core.ajax.sendPacket(getUserId_Packet);
	getUserId_Packet=null;
}

//------------------------------------------
function getpack_creditNo()
{
    if(document.all.tr_pack_creditNo.style.display=="")
	{
       if((document.all.pack_creditNo.value).trim().length==0)
	   {
         rdShowMessageDialog("营销包凭证号码不能为空！"); 
		 document.all.pack_creditNo.focus();
	     return;
	   }
	   else
	   {
 		 if((document.all.pack_creditNo.value).trim().length<10)
		 {
			 rdShowMessageDialog("营销包凭证号码不能少于10位！"); 
			 document.all.pack_creditNo.focus();
			 return;
		 }
         if(checkElement(document.all.pack_creditNo)==false) return;
	   }
	} 
    //查询营销包凭证信息是否存在
    var getUserId_Packet = new AJAXPacket("f1104_11.jsp","正在查询营销包凭证信息，请稍候......");
	getUserId_Packet.data.add("retType","packCreInfo");
	getUserId_Packet.data.add("region_code","<%=regionCode%>");
	getUserId_Packet.data.add("pack_creditNo",(document.all.pack_creditNo.value).trim());	
	core.ajax.sendPacket(getUserId_Packet);
	getUserId_Packet=null;

}


function myParseInt(nu)
{
  var ret=0;
  if(nu.length>0)
  {
    if(nu.substring(0,1)=="0")
	{
       ret=parseInt(nu.substring(1,nu.length));
	}
	else
	{
       ret=parseInt(nu);
	}
  }
  return ret;
}
function isMadeOf(val,str)
{

	var jj;
	var chr;
	for (jj=0;jj<val.length;++jj){
		chr=val.charAt(jj);
		if (str.indexOf(chr,0)==-1)
			return false;			
	}
	
	return true;
}
//-----------------------------------------
function choiceSelWay()
{	//选择客户信息的查询方式
	if(frm1104.custId.value != "")
	{	//按客户ID进行查询
		getInfo_withId();	
		return true;
	}
	if(frm1104.idIccid.value != "")
	{	//客户证件号码
		getInfo_IccId();
		return true;
	}
	if(frm1104.custName.value != "")
	{	//客户名称
		getInfo_withName();
		return true;
	}
	rdShowMessageDialog("客户信息可以以ID、证件号码或名称进行查询，请输入其中任意项作为查询条件！",0);
}
//------------------------------------------
function getInfo_withId()
{
    //根据上级客户ID得到相关信息
    if(document.frm1104.custId.value == "")
    {
        rdShowMessageDialog("请输入客户ID！",0);
        return false;
    }
	else
	{
	  if(checkElement(document.all.custId)==false) return false;
	}
    if(forNonNegInt(frm1104.custId) == false){	return false;	}
    var getIdPacket = new AJAXPacket("f1100_rpc.jsp","正在获得客户信息，请稍候......");
		getIdPacket.data.add("retType","getInfo_withID");
		getIdPacket.data.add("fieldNum","8");
		getIdPacket.data.add("sqlStr","select to_char(a.CUST_ID),a.CUST_PASSWD,a.ID_ICCID,a.id_type||'-'||b.ID_NAME,a.CUST_NAME," +	           "a.CUST_ADDRESS,a.REGION_CODE||a.DISTRICT_CODE||a.TOWN_CODE,trim(a.contact_phone)" +
	            " from DCUSTDOC a,SIDTYPE b where a.CUST_ID=" +
                document.frm1104.custId.value + " and b.ID_TYPE = a.ID_TYPE and rownum<500");
	core.ajax.sendPacket(getIdPacket);
	getIdPacket=null;  
}
//-----------------------------------------------------
function change_assuIdType()
{   //判断是否是身份证，如果是指定类型
    var Str = document.frm1104.assuIdType.value;
    if(Str.indexOf("身份证") > -1)
    {   document.frm1104.assuId.v_type = "idcard";   }
    else
    {   document.frm1104.assuId.v_type = "string";   }
}
function assuInfoQuery()
{
    //担保人证件号码得到相关信息   
    if(document.frm1104.assuId.value == "")
    {
        rdShowMessageDialog("请输入担保人证件号码！",0);
        return false;
    }
    change_assuIdType();
    if(checkElement(document.all.assuId)==false)   //判断证件号码的有效性
    {	return false;		}

    var getAssuInfo_Packet = new AJAXPacket("f1104_3.jsp","正在获得担保人信息，请稍候......");
	getAssuInfo_Packet.data.add("retType","getAssuInfo");
    getAssuInfo_Packet.data.add("iccType",(frm1104.assuIdType.value).substring(0,(frm1104.assuIdType.value).indexOf("|")));
    getAssuInfo_Packet.data.add("iccId",document.frm1104.assuId.value);
    getAssuInfo_Packet.data.add("sIn_Belong_code","<%=belongCode%>");
	core.ajax.sendPacket(getAssuInfo_Packet);
	getAssuInfo_Packet=null;  
}
//-----------------------------------------------------
/**   liutong@20080822 封掉  
function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
	var theFirstRetToField=retToField;
   
    参数1(pageTitle)：查询页面标题
    参数2(fieldName)：列中文名称，以'|'分隔的串
    参数3(sqlStr)：sql语句
    参数4(selType)：类型1 rediobutton 2 checkbox
    参数5(retQuence)：返回域信息，返回域个数＋ 返回域标识，以'|'分隔，如"3|0|2|3"表示返回3个域0，2，3
    参数6(retToField))：返回值存放域的名称,以'|'分隔
    注意：sql的校验，防止sql注射
    使用window.open实现新窗口的打开，否则opener不生效.
    可通过opener.arg4.values=''赋值
   
    var path = "../../page/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    retInfo = window.showModalDialog(path);
    if(typeof(retInfo)=="undefined")      
    {   return false;   }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
        
    }
	document.frm1104.hid_MachFee.value = document.frm1104.machFee.value;
    if(document.all.buyMach.checked==true && theFirstRetToField=="machCode|machName|machFee|")
	{//alert("sssssssssss1111111111");
      var PackInfo_Packet = new AJAXPacket("f1104_10.jsp","正在获得营销包信息，请稍候......");
	  PackInfo_Packet.data.add("retType","PackInfo");
	  PackInfo_Packet.data.add("sm_code",frm1104.smCodeList.value);
	  PackInfo_Packet.data.add("pack_code",frm1104.machCode.value);
      PackInfo_Packet.data.add("region_code",frm1104.regionCode.value);
 	  core.ajax.sendPacket(PackInfo_Packet);
	  PackInfo_Packet=null;
	}
}
**/ 
//----------------------------------------------------
function QryForeSimNo()
{
	//自动查询预先开通的sim卡号
    if((document.frm1104.phoneNo.value).trim().length > 0)
    {
      //rdShowMessageDialog("请输入手机号码号码！",0);
      //document.frm1104.phoneNo.focus();
      //return false;
	  if(!checkElement(document.all.phoneNo))
	  {
	    return false;
	  }
      var QryForeSimNo_Packet = new AJAXPacket("f1108_3.jsp","正在判断是否是预开通号码，请稍候......");
	  QryForeSimNo_Packet.data.add("retType","QryForeSimNo");
      QryForeSimNo_Packet.data.add("Phone_no",frm1104.phoneNo.value);
	  core.ajax.sendPacket(QryForeSimNo_Packet);
	  QryForeSimNo_Packet=null; 	
	   
	}
}

//-----------------------------------------------------
function custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    /*
    参数1(pageTitle)：查询页面标题
    参数2(fieldName)：列中文名称，以'|'分隔的串
    参数3(sqlStr)：sql语句
    参数4(selType)：类型1 rediobutton 2 checkbox
    参数5(retQuence)：返回域信息，返回域个数＋ 返回域标识，以'|'分隔，如"3|0|2|3"表示返回3个域0，2，3
    参数6(retToField))：返回值存放域的名称,以'|'分隔
    */
    var path = "pubGetCustInfo.jsp";   //密码为*
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
   
   
    retInfo = window.showModalDialog(path,"","dialogWidth:55;dialogHeight:35");
	
	
    if(typeof(retInfo) == "undefined")     
    {   return false;   }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr.toString().replace(/~/g,'～');/*王梅 修改 20070629 字符串中‘~’由‘～’代替 防止程序coredump*/
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
        
    }
    sCheckIccid();  
}
//---------------------------------------------
function simfeeQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    /*
    参数1(pageTitle)：查询页面标题
    参数2(fieldName)：列中文名称，以'|'分隔的串
    参数3(sqlStr)：sql语句
    参数4(selType)：类型1 rediobutton 2 checkbox
    参数5(retQuence)：返回域信息，返回域个数＋ 返回域标识，以'|'分隔，如"3|0|2|3"表示返回3个域0，2，3
    参数6(retToField))：返回值存放域的名称,以'|'分隔
    */
    var path = "pubGetsimfee.jsp";   
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;
    retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:35;");
    if(typeof(retInfo) == "undefined")     
    {   return false;   }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
 
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
        
    }
    
    
    
    
    
    
     
}
//-------------------------------------------------
function getInfo_IccId()
{  
  	//根据客户证件号码得到相关信息
  	if((document.frm1104.idIccid.value).trim().length == 0)
    {
        rdShowMessageDialog("请输入客户证件号码！",0);
        return false;
    }
	else if((document.frm1104.idIccid.value).trim().length < 5)
    {
        rdShowMessageDialog("证件号码长度有误（最少五位）！",0);
        return false;
    }
    var pageTitle = "客户信息查询";
    var fieldName = "客户ID|客户名称|开户时间|证件类型|证件号码|客户地址|归属代码|客户密码|联系电话|";
    var sqlStr = "select to_char(a.CUST_ID),a.CUST_NAME,to_char(a.CREATE_TIME,'YYYY-MM-DD HH24:MI:SS'),a.id_type||'-'||b.ID_NAME,a.ID_ICCID," +"replace(cust_address,'~',' '),a.REGION_CODE||a.DISTRICT_CODE||a.TOWN_CODE,a.CUST_PASSWD,trim(a.contact_phone)" + " from DCUSTDOC a,SIDTYPE b where b.ID_TYPE = a.ID_TYPE " +" and a.ID_ICCID = '" + (document.frm1104.idIccid.value).trim() + "' and rownum<500 order by a.cust_name asc,a.create_time desc "; 	
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "8|0|1|3|4|5|6|7|8|";
    var retToField = "in0|in4|in3|in2|in5|in6|in1|in7|";
    custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);;
    //PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,50,800,600);
    //sCheckIccid(); 
}
//---------------------------------------------------
function getnew_simfee()
{ 
  	//根据客户证件号码得到相关信息
  	
    var pageTitle = "新增全球通客户";
    var fieldName = "sim卡费|预存|";
    var sqlStr = "select to_char(sim_fee,'99999'),to_char(pre_fee,'99999.99') from sgnsimfeenew  where region_code= '" +document.frm1104.regionCode.value + "' and sim_type='"+frm1104.simType.value+"' order by sim_fee"; 	
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|0|1|";
    var retToField = "ins|ins1|";
    simfeeQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField); 
}
//-------------------------------------------------
function getInfo_withName()
{ 
  	////根据上级客户名称得到相关信息
  	if(document.frm1104.custName.value == "")
    {
        rdShowMessageDialog("请输入客户名称！",0);
        return false;
    }
    var pageTitle = "客户信息查询";
    var fieldName = "客户ID|客户名称|开户时间|证件类型|证件号码|客户地址|归属代码|客户密码|联系电话|";
    var sqlStr = "select to_char(a.CUST_ID),a.CUST_NAME,to_char(a.CREATE_TIME,'YYYY-MM-DD HH24:MI:SS'),a.id_type||'-'||b.ID_NAME,a.ID_ICCID,"+"a.CUST_ADDRESS,a.REGION_CODE||a.DISTRICT_CODE||a.TOWN_CODE," + " a.CUST_PASSWD,trim(a.contact_phone) from DCUSTDOC a,SIDTYPE b where " + " a.CUST_NAME like '" + frm1104.custName.value  + "%'" +" and b.ID_TYPE = a.ID_TYPE and rownum<500  order by a.cust_name asc,a.create_time desc ";	                      
    var selType = "S";    //'S'单选；'M'多选  
    var retQuence = "8|0|1|3|4|5|6|7|8|";
    var retToField = "in0|in4|in3|in2|in5|in6|in1|in7";
    custInfoQuery(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);    
    //PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,50,800,600);    
    //sCheckIccid(); 	       	   
}
//-------------------------------------------------
function sCheckIccid()
{
    //查询客户的开户数，最大开户数
    var CheckIccid_Packet = new AJAXPacket("f1104_7.jsp","正在获得客户开户数相关信息，请稍候......");
	CheckIccid_Packet.data.add("retType","sCheckIccid");
    CheckIccid_Packet.data.add("iccId",document.frm1104.idIccid.value);
    CheckIccid_Packet.data.add("belongCode","<%=belongCode%>");
    CheckIccid_Packet.data.add("idType",(frm1104.idType.value).substring(0,(frm1104.idType.value).indexOf("-")));
	core.ajax.sendPacket(CheckIccid_Packet);
	CheckIccid_Packet=null;     
}
//-------------------------------------------------
function machQuery()
{ 
  	//得到机器相关信息
    var pageTitle = "机器信息查询";
    var fieldName = "机器代码|机器名称|机器价格|"; 
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "0|1|2";
    var retToField = "machCode|machName|machFee";
    var sqlStr = "select machine_code,machine_name,nvl(machine_price,0.00) as machine_price from smachcode " +
             "where rownum <" + <%=rowNum%> + " and region_code ='" + 
             document.frm1104.regionCode.value + "'";
	if(document.all.rentMach.checked==true)
	{
       sqlStr+=" and machine_code not in (select Mach_code from sPackCode)";
	}
	//if(document.frm1104.machName.value != "")
    //{   sqlStr = sqlStr + " and machine_name like '%" + document.frm1104.machName.value + "%'";  }             
    PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);   
}
//-----------------------------------------------------------------

function selfMachType()
{
    if(frm1104.selfMach.checked == true)
    {  
	    document.all.serviceResult.value="";
		
		document.all.serviceNow.value="";
  	    document.all.serviceAfter.value="";
  	    document.all.serviceAddNo.value="";
	  
		document.all.tfFlag.value="n";
		
		document.all.machCode.value="";
		document.all.machName.value="";

	    document.all.tr_rentFeeMode.style.display="none";
        mach_Type = "self";          
        frm1104.buyMach.checked = false;
        frm1104.rentMach.checked = false;
        frm1104.machCode.value = "";
        frm1104.machName.value = "";
        frm1104.machCodeQuery.disabled = true;
		document.all.hidMachineType.value="s";

 	     //对界面值进行恢复 
       //  frm1104.payWay.value=pack_re_mainName;
       frm1104.payWay.value="";
        // alert("eeeeeeee="+frm1104.payWay.value);
         frm1104.payCode.value=pack_re_mainCode;
         frm1104.additivePayWay.value=pack_re_choiName;
         frm1104.additiveCode.value=pack_re_choiCode;
         subPassFlag=pack_re_choiFlag;
         frm1104.innetPreFee.value=pack_re_prefee;
		 getTtFee();
               
		 //恢复按钮状态
		 frm1104.selectMode.disabled=false;
		 frm1104.selectAdditive.disabled=false;

		 //营销包绑定的可选资费
		 //frm1104.pack_addifeeCode.value="";
		 //frm1104.pack_addifeeName.value="";
		 frm1104.additivePayWay.value=""; 
		 frm1104.additiveCode.value="";

		 document.all.tr_pack_creditNo.style.display="none";
    }
}    
function buyMachType()
{
    if(frm1104.buyMach.checked == true)
    {  
		document.all.machCode.value="";
		document.all.machName.value="";

	    document.all.tr_rentFeeMode.style.display="none"; 
        mach_Type = "buy";
        frm1104.selfMach.checked = false;
        frm1104.rentMach.checked = false;
        frm1104.machCodeQuery.disabled = false;                
		document.all.hidMachineType.value="b";
    }
}
function rentMachType()
{    
    if(frm1104.rentMach.checked == true)
    { 	
	    document.all.serviceResult.value="";
		
		document.all.serviceNow.value="";
  	    document.all.serviceAfter.value="";
  	    document.all.serviceAddNo.value="";
	  
		document.all.tfFlag.value="n";
		  
		document.all.machCode.value="";
		document.all.machName.value="";

	    document.all.tr_rentFeeMode.style.display="";	 
        mach_Type = "rent";
        frm1104.selfMach.checked = false;
         
        frm1104.buyMach.checked = false;
        frm1104.machCodeQuery.disabled = false;
         
		document.all.hidMachineType.value="r";
		
  	    //对界面值进行恢复 
         //frm1104.payWay.value=pack_re_mainName;
         frm1104.payWay.value="";
         //alert("oooooooooooo"+frm1104.payWay.value);
         frm1104.payCode.value=pack_re_mainCode;
          
         frm1104.additivePayWay.value=pack_re_choiName;
         
         
         frm1104.additiveCode.value=pack_re_choiCode;
         subPassFlag=pack_re_choiFlag;
         frm1104.innetPreFee.value=pack_re_prefee;
         
		 getTtFee();
              
		 //恢复按钮状态
		 if(frm1104.selectModeFlag.value==1)
		 {
		 	 frm1104.selectMode.disabled=true;
		 }else{
		 	frm1104.selectMode.disabled=false;
		}
		 frm1104.selectAdditive.disabled=false;

	   //营销包绑定的可选资费
	   //frm1104.pack_addifeeCode.value="";
	   //frm1104.pack_addifeeName.value="";
	   frm1104.additivePayWay.value=""; 
	   frm1104.additiveCode.value="";

		 document.all.tr_pack_creditNo.style.display="none";
    }
}    
//------------------------------------------------------------------
function getBankCode()
{ 
  	//调用公共js得到银行代码
    if((frm1104.checkNo.value).trim() == "")
    {
        rdShowMessageDialog("请输入支票号码！",0);
        frm1104.checkNo.focus();
        return false;
    }
    var getCheckInfo_Packet = new AJAXPacket("f1104_6.jsp","正在获得支票相关信息，请稍候......");
	getCheckInfo_Packet.data.add("retType","getCheckInfo");
    getCheckInfo_Packet.data.add("checkNo",document.frm1104.checkNo.value);
	core.ajax.sendPacket(getCheckInfo_Packet);
	getCheckInfo_Packet=null;   
 } 
//-----------------------------------------------------------------
function checkWay()
{   //支票支付方式
    var obj = "check"+0;
    if(frm1104.checkRadio.checked == true)
    {
        frm1104.checkRadio.checked = true;
        frm1104.NocheckRadio.checked = false;
        document.all(obj).style.display = "";	
    }
}    
function NocheckWay()
{   //非支票支付方式 
    var obj = "check"+0;
    var obj1 = "chPayNum" + 0;
    if(frm1104.NocheckRadio.checked == true)
    {
        frm1104.checkRadio.checked = false;
        frm1104.NocheckRadio.checked = true;
        document.all(obj).style.display = "none";
        document.all(obj1).style.display = "none";
		
        frm1104.checkNo.value = "";
        frm1104.bankCode.value = "";
        frm1104.bankName.value = "";
        frm1104.checkPay.value = "";
		frm1104.checkPrePay.value = "";        	
     }    
}
//-----------------------------------------
function changeSmCode()
{
	frm1104.simNo.value=""; 
	frm1104.simTypeName.value="";
	frm1104.simType.value="";
	frm1104.phoneNo.value="";
	frm1104.serviceResult.value="";
	if(chkPassFlag==true)
	{
 	  frm1104.resourceValid.disabled=false;
	  //frm1104.phoneNo.focus();
	}
	else
	{
 	  //rdShowMessageDialog("您还未进行密码校验！");
	  //frm1104.custPwd.focus();
	  //return false;
	}  
	frm1104.sumParCount.disabled=true;  //交款计算按钮
	frm1104.print.disabled=true;
 	//业务品牌选择
	document.all.serviceType.options.length=0;
	document.all.serviceType.options.length=1;
	if(frm1104.smCodeList.value == "gn")
	{
		document.all.serviceType.options[0].value="01";
		document.all.serviceType.options[0].text="普通语音服务";
		check_gnRadio();	
	} 
	if(frm1104.smCodeList.value == "dn")
	{
		document.all.serviceType.options[0].value="01";
		document.all.serviceType.options[0].text="普通语音服务";
		check_dnRadio();	
	} 
	if(frm1104.smCodeList.value == "d0")
	{
		document.all.serviceType.options[0].value="20";
		document.all.serviceType.options[0].text="数据服务";
		check_d0Radio();
	}
	if(frm1104.smCodeList.value == "zn")
	{
		//alert("frm1104.hnInnetCode[i].text"+frm1104.hnInnetCode[i].text);
		document.all.serviceType.options[0].value="01";
		document.all.serviceType.options[0].text="普通语音服务";
		check_hnRadio();
	}                     	

}
//-----------------------------------------
function check_gnRadio()
{
    var gnNum = document.all("gnInnetCode").length;
	document.all("innetCode").length = 0;
    document.all("innetCode").length = gnNum;
    for(i=0;i<gnNum;i++)
    {
        frm1104.innetCode[i].value = frm1104.gnInnetCode[i].value;
        frm1104.innetCode[i].text = frm1104.gnInnetCode[i].text;
		frm1104.innetCode[i].mainCode=frm1104.gnInnetCode[i].mainCode;
		frm1104.innetCode[i].mainName=frm1104.gnInnetCode[i].mainName;
		frm1104.innetCode[i].subCount=frm1104.gnInnetCode[i].subCount;
    }
	changeInCode();

 
	
}
function check_dnRadio()
{
    var dnNum = document.all("dnInnetCode").length;
	document.all("innetCode").length = 0;
    document.all("innetCode").length = dnNum;
    for(i=0;i<dnNum;i++)
    {
        frm1104.innetCode[i].value = frm1104.dnInnetCode[i].value;
        frm1104.innetCode[i].text = frm1104.dnInnetCode[i].text;
		frm1104.innetCode[i].mainCode=frm1104.dnInnetCode[i].mainCode;
		frm1104.innetCode[i].mainName=frm1104.dnInnetCode[i].mainName;
		frm1104.innetCode[i].subCount=frm1104.dnInnetCode[i].subCount;
    } 
	changeInCode();
   
   
}
function check_d0Radio()
{
    var dnNum = document.all("d0InnetCode").length;
	document.all("innetCode").length = 0;
    document.all("innetCode").length = dnNum;
    for(i=0;i<dnNum;i++)
    {
        frm1104.innetCode[i].value = frm1104.d0InnetCode[i].value;
        frm1104.innetCode[i].text = frm1104.d0InnetCode[i].text;
		frm1104.innetCode[i].mainCode=frm1104.d0InnetCode[i].mainCode;
		frm1104.innetCode[i].mainName=frm1104.d0InnetCode[i].mainName;
		frm1104.innetCode[i].subCount=frm1104.d0InnetCode[i].subCount;
    }
    changeInCode();


}
function check_hnRadio()
{
    var hnNum = document.all("hnInnetCode").length;
	document.all("innetCode").length = 0;
    document.all("innetCode").length = hnNum;
    for(i=0;i<hnNum;i++)
    {
    	//alert("frm1104.hnInnetCode[i].text"+frm1104.hnInnetCode[i].text);
        frm1104.innetCode[i].value = frm1104.hnInnetCode[i].value;
        frm1104.innetCode[i].text = frm1104.hnInnetCode[i].text;
		frm1104.innetCode[i].mainCode=frm1104.hnInnetCode[i].mainCode;
		frm1104.innetCode[i].mainName=frm1104.hnInnetCode[i].mainName;
		frm1104.innetCode[i].subCount=frm1104.hnInnetCode[i].subCount;
    }
    changeInCode();
  
 
}

//------------------------------------------------------------------
function checkPostInfo()
{
	//邮寄信息校验
	if(frm1104.post.checked == false)
	{	return true;	}
	if(frm1104.postName.value == "")
	{	
		rdShowMessageDialog("采用帐单寄送方式收件人信息不能为空！",0);
		frm1104.postName.focus();
		return false;
	}
	if(frm1104.postType.value == "1")
	{
		if((frm1104.postAdd.value == "")||(frm1104.postZip.value == ""))
		{
			rdShowMessageDialog("采用邮寄帐单方式邮寄地址和邮编不能为空！",0);
			return false;			
		}
	}
	if(frm1104.postType.value == "2")
	{
		if(frm1104.postMail.value == "")
		{
			rdShowMessageDialog("采用Email邮寄方式Email地址项不能为空！",0);
			return false;			
		}
	}
	if(frm1104.postType.value == "3")
	{
		if(frm1104.postFax.value == "")
		{
			rdShowMessageDialog("采用传真寄送方式传真号码不能为空！",0);
			return false;			
		}
	}	
	return true;
}
//------------------------------------------------------------------
function printCommit()
{	
	if(document.all.rentMach.checked==true || document.all.buyMach.checked==true){
  	if(document.all.machCode.value.length==0){
    	rdShowMessageDialog("请选择机器代码！"); 
	    return;
	  }       
	}
	if (document.all.serviceResult.value==""){
		rdShowMessageDialog("请选择特服定购！");
		return;
	}
	
	if(subPassFlag==false){
  	rdShowMessageDialog("您必须选择与主资费相关的可选资费！"); 
	  return;
	}

	/**
	if(blackFlag==false)
    {
      rdShowMessageDialog("用户在黑名单中，不能继续办理业务！"); 
	  return;
	}
	if(assuBlackFlag==false)
    {
      rdShowMessageDialog("担保人在黑名单中，不能继续办理业务！"); 
	  return;
	}
	*/
	
  if((self.status).trim()!=""){
      rdShowMessageDialog("正在获取相关信息，请稍候！"); 
	  return;
	}
	if(frm1104.hid_countFlag.value == "0"){   
		//费用是否计算标志
		rdShowMessageDialog("打印之前请先进行费用计算！",0);
	  return false;
	}
    /*if(jtrim(frm1104.custPwd.value) == "")
    {
	    rdShowMessageDialog("请输入客户密码！",0);
	    frm1104.custPwd.focus();
	    return false;    	
    }*/
	  if(frm1104.post.checked){
 		if(forString(document.all.postName)==false){        
 			frm1104.postName.focus();   
		 	return false;
	  }
	  if(document.all.postType.options[document.all.postType.selectedIndex].value=="1"){
    	if(forString(document.all.postAdd)==false) 
    		return false;
		 	if(forPostCode(document.all.postZip)==false) 
		 		return false;
		 	if((document.all.postFax.value).trim().length>0){
		  	if(forTel(document.all.postFax)==false) return false;
		 	}
		 	if((document.all.postMail.value).trim().length>0){
		    if(forMail(document.all.postMail)==0){
			  	rdShowMessageDialog("电子邮件地址非法！");
          return false;
	    	}
		 	}
	   }else if(document.all.postType.options[document.all.postType.selectedIndex].value=="2"){
     	var obj=document.all.postMail;
      if((obj.value).trim().length==0){
				rdShowMessageDialog("电子邮件地址不能为空！");
				if(obj.style.display=="")
			  	obj.focus();
				return false;
		 	}	
		 	if(forMail(obj)==0){
				rdShowMessageDialog("电子邮件地址非法！");
				obj.focus();
        return false;
	    }
		 	if((document.all.postFax.value).trim().length>0){
		  	if(forTel(document.all.postFax)==false) return false;
		 	}	
		 	if((document.all.postAdd.value).trim().length>0){
		  	if(forString(document.all.postAdd)==false) return false;
		 	}
		 	if((document.all.postZip.value).trim().length>0){
		   if(forPostCode(document.all.postZip)==false) return false;
		 	} 
	   }else if(document.all.postType.options[document.all.postType.selectedIndex].value=="3"){
     	if(forTel(document.all.postFax)==false) return false;
		  if((document.all.postAdd.value).trim().length>0){
		  	if(forString(document.all.postAdd)==false) return false;
		  }
		  if((document.all.postZip.value).trim().length>0){
		   if(forPostCode(document.all.postZip)==false) return false;
		  } 
		  if((document.all.postMail.value).trim().length>0){
		    if(forMail(document.all.postMail)==0){
			  	rdShowMessageDialog("电子邮件地址非法！");
          return false;
	      }	 
		  }
 	  }
 	}

/**
	if((frm1104.innetCode[frm1104.innetCode.options.selectedIndex].text).indexOf("E") > 0)
    {    
      if(jtrim(document.all.CredId.value).length==0)
	  {
         rdShowMessageDialog("凭证序列号不能为空！");
		 document.all.CredId.focus();		 
         return false;
	  }
	}
*/
		if(check(frm1104)){ 
				if((frm1104.userPwd.value).trim().length > 0){
					if(frm1104.userPwd.value.length!=6){
							rdShowMessageDialog("用户密码长度有误！",0);
							frm1104.userPwd.focus();
							return false;    	
							}
					if(checkPwd(document.all.userPwd,document.all.cfmuserPwd)==false)
					return false;
					}
					var sysNote = "普通开户:" + "主资费[" + document.all.payCode.value + "]手机号码[" + 
					document.frm1104.phoneNo.value + "]"; 
					document.frm1104.sysNote.value = sysNote;
								    	
					if((document.all.opNote.value).trim().length==0){								    	
					}
											  
					if(feeCount()==true){  
						getNote();
						if(frm1104.sysAccept.value == ""){
							return false;		
							}
					}
		}
		document.frm1104.print.disabled = true;
 }
 
 function comm(){  
 	getAfterPrompt();  
 	if((document.frm1104.writecardbz.value!="0") && (document.all.cardtype_bz.value=="k")){
 		rdShowMessageDialog("写卡未成功不能确认!");
 		return false;
 	}
 	if(frm1104.is_not_adward.value=="Y"){
 		if(frm1104.getlike.value=="0"){
    	rdShowMessageDialog("不能参与入网有礼活动!",0); 
    	frm1104.print.disabled = true;
			return false;
        }//else{
    			//alert("恭喜您获得"+frm1104.getlike.value+"类奖品!");
    		//}
	}
	if(1*frm1104.cashPay.value>100000)
	{
		rdShowMessageDialog("交费金额不能大于100000!",0); 
    	frm1104.print.disabled = true;
		return false;
	  	
	}
   //================
	if(feeCount()==true){
		var QryForeSimNo_Packet = new AJAXPacket("fGetBindAddi.jsp","正在获得绑定附加资费，请稍候......");
		QryForeSimNo_Packet.data.add("retType","fGetBindAddi_conf");
		QryForeSimNo_Packet.data.add("Phone_no",frm1104.phoneNo.value);
		QryForeSimNo_Packet.data.add("org_code","<%=belongCode%>");			
		QryForeSimNo_Packet.data.add("Sm_code",frm1104.smCodeList.value);		
		core.ajax.sendPacket(QryForeSimNo_Packet);
		QryForeSimNo_Packet=null;
	}
	document.frm1104.print.disabled = true;
}

//---------------------------------------------------------------
function postStatus()
{
    var temp1="tbPost"+0; 
    document.frm1104.post.checked = true;
    document.frm1104.Nopost.checked = false;       
	document.all(temp1).style.display = "";	
	document.all.postName.disabled=false; 
	document.all.postFax.disabled=false; 
	document.all.postMail.disabled=false; 
	document.all.postAdd.disabled=false; 
	document.all.postZip.disabled=false; 
	   
}
function NopostStatus()
{
    var temp1="tbPost"+0; 
    document.frm1104.post.checked = false;
    document.frm1104.Nopost.checked = true;
    document.all(temp1).style.display = "none";	    
    document.all.postName.disabled=true;
    document.all.postFax.disabled=true;  
    document.all.postMail.disabled=true;  
    document.all.postAdd.disabled=true;  
    document.all.postZip.disabled=true;      
}

//-----------------------------------------
function checkResourceFirst()
{
	//判断此手机号码是否被占用
	if(document.frm1104.idIccid.value!="" && document.frm1104.phoneNo.value!="")
	{
		checkGoodPhone();
	}
}
function checkResource()
{      

	
	//资源校验
	if(document.all.customType[1].checked==true)
	{
		if((document.all.str1.value).trim().length==0 && (document.all.str2.value).trim().length==0 && (document.all.str3.value).trim().length==0 && (document.all.str4.value).trim().length==0 && (document.all.str5.value).trim().length==0)
	    {
           rdShowMessageDialog("您没有新建客户资料！",0);
	       return false;
	    }
	}

    if(document.frm1104.phoneNo.value == "")
    {
        rdShowMessageDialog("请输入服务号码！",0);
        document.frm1104.phoneNo.focus();
        return false;
    }
    if(forMobil(frm1104.phoneNo) == false){	return false;	}	//验证输入的手机号码的有效性
    var belongCode = "<%=belongCode%>";    
    //业务类型
    var operType = frm1104.smCodeList.value;
    var sim_type = document.frm1104.simType.value;
    if(document.frm1104.simNo.value == "")
    {
        rdShowMessageDialog("请输入SIM卡号码！",0);
        return false;
    } 
   
    
    if(checkElement(document.all.simNo) == false){	return false;	}	//验证输入的sim卡号码的有效性  
	//getFee();   //得到费用参数
    var checkResource_Packet = new AJAXPacket("f1104_5.jsp","正在进行资源校验，请稍候......");
	checkResource_Packet.data.add("retType","checkResource");
    checkResource_Packet.data.add("sIn_Phone_no",document.frm1104.phoneNo.value);
    checkResource_Packet.data.add("sIn_OrgCode",document.frm1104.org_Code.value);
    checkResource_Packet.data.add("sIn_Sm_code",operType);
    checkResource_Packet.data.add("sIn_Sim_no",document.frm1104.simNo.value);
    checkResource_Packet.data.add("sIn_Sim_type",sim_type);
    checkResource_Packet.data.add("workno",document.frm1104.workno.value);
    var szph=document.all.zph.value;
    if(szph==""){szph="aaa";}
  // alert(szph);
    checkResource_Packet.data.add("zph",szph);
    checkResource_Packet.data.add("sIn_cardtype",document.frm1104.cardtype_bz.value);
    
	core.ajax.sendPacket(checkResource_Packet);
	checkResource_Packet=null;  
	
}
//-----------改变入网代码下拉框------------
function changeInCode()
{
    frm1104.selfMach.checked=true;
    
	selfMachType();
	
    var tempFee = frm1104.innetCode.value;
    tempFee = tempFee.substring(tempFee.indexOf("-")+1);
    frm1104.innetFee.value = tempFee.substring(0,tempFee.indexOf("-"));
    frm1104.hid_innetFee.value = frm1104.innetFee.value;
    tempFee = tempFee.substring(tempFee.indexOf("-")+1);
    frm1104.innetPreFee.value = tempFee.substring(0,tempFee.indexOf("-"));
    frm1104.hid_innetPreFee.value = frm1104.innetPreFee.value; 
    
    var obj = "cred" + 0;
    if (frm1104.innetCode.options.selectedIndex < 0 && frm1104.innetCode.options.length > 0)
	{
		frm1104.innetCode.options.selectedIndex = 0;
	}
	
	if(frm1104.innetCode.options.selectedIndex >= 0 && (frm1104.innetCode[frm1104.innetCode.options.selectedIndex].text).indexOf("E") > 0)
    {    
		//document.all(obj).style.display = "";      
		document.all(obj).style.display = "none";      
    }
  	else
  	{	 
    	frm1104.CredId.value = "";
  		frm1104.CredPwd.value = "";  	
  		document.all(obj).style.display = "none";
   	}	
	
	if (document.all.innetCode.selectedIndex >= 0)
	{//alert("5555555558"+frm1104.payWay.value);
	    document.all.payWay.value=document.all.innetCode.options[document.all.innetCode.selectedIndex].mainName;
		//alert("5555555559"+frm1104.payWay.value);
		document.all.payCode.value=document.all.innetCode.options[document.all.innetCode.selectedIndex].mainCode;
	
		modeCode=document.all.payCode.value;
	
		document.all.additivePayWay.value="";
		/**
		if(document.all.innetCode.options[document.all.innetCode.selectedIndex].subCount!="0")   
	      subPassFlag=false;
		else if(document.all.innetCode.options[document.all.innetCode.selectedIndex].subCount=="0")   
	      subPassFlag=true;
		 */
		 if(document.all.innetCode.options[document.all.innetCode.selectedIndex].subCount=="2")   
	      subPassFlag=false;
		else if(document.all.innetCode.options[document.all.innetCode.selectedIndex].subCount!="2")   
	      subPassFlag=true;
		else
		{
	        rdShowMessageDialog("可选资费绑定表cBillBaDepend有误！",0);        
	        return false;
		}
	}
	//先对界面值进行保存 
    pack_re_mainName=frm1104.payWay.value;
   // alert("5555555555"+frm1104.payWay.value);
    pack_re_mainCode=frm1104.payCode.value;
    pack_re_choiName=frm1104.additivePayWay.value;
    pack_re_choiCode=frm1104.additiveCode.value;
    pack_re_choiFlag=subPassFlag;
    pack_re_prefee=frm1104.innetPreFee.value;
	document.all.tr_pack_creditNo.style.display="none";
	getTtFee();
	frm1104.payWay.value ="";
   //if(frm1104.innetCode.options[frm1104.innetCode.selectedIndex].text=="商务电话" || frm1104.innetCode.options[frm1104.innetCode.selectedIndex].text=="IP超市" )
    //{
    //document.all.is_not_adward1.style.display="none";
    //frm1104.is_not_adward.value='N';
    
    
   // }else
    //{
    //document.all.is_not_adward1.style.display="";
   // frm1104.is_not_adward.value='Y';
    
   // }
}
//-------------------------------------------
function getFee()
{   //得到各种费项信息
    if(document.frm1104.phoneNo.value == "")
    {
        rdShowMessageDialog("请输入服务号码！",0);
        document.frm1104.phoneNo.focus();
        return false;
    }
    if(document.frm1104.simNo.value == "")
    {
        rdShowMessageDialog("请输入SIM卡号码！",0);
        return false;
    } 
    var getFeeInfo_Packet = new AJAXPacket("f1104_4.jsp","正在获得费用信息，请稍候......");
	  getFeeInfo_Packet.data.add("retType","getFeeInfo");
    getFeeInfo_Packet.data.add("sIn_Phone_no",document.frm1104.phoneNo.value);
    getFeeInfo_Packet.data.add("sIn_Sim_no",document.frm1104.simNo.value);
    getFeeInfo_Packet.data.add("sIn_Op_code","1104");
    getFeeInfo_Packet.data.add("sIn_Belong_code","<%=belongCode%>");
    var inCode = frm1104.innetCode.value;
    getFeeInfo_Packet.data.add("sIn_Inland_Toll",inCode.substring(0,inCode.indexOf("-")));
    var operType = frm1104.smCodeList.value;			//业务类型

    getFeeInfo_Packet.data.add("sIn_Sm_code",operType);
    getFeeInfo_Packet.data.add("sIn_Sim_type",document.frm1104.simType.value);
	core.ajax.sendPacket(getFeeInfo_Packet);
	getFeeInfo_Packet=null;     
}

//-----------------------------------------
function checkPwd(obj1,obj2)
{
	var pwd1 = obj1.value;
	var pwd2 = obj2.value;
	if(pwd1 != pwd2)
	{
		var message = "'" + obj1.v_name + "'和'" + obj2.v_name + "'不一致，请重新输入！";
		rdShowMessageDialog(message,0);
		obj1.value = "";
		obj2.value = "";
		obj1.focus();
		return false;
	}
	return true;
}
//-----------------------------------
function change_custPwd()
{   //验证密码（密码）
     check_HidPwd(frm1104.custPwd.value,"show",(frm1104.in1.value).trim(),"hid");
}
//-----------------------------------------
function check_HidPwd(Pwd1,Pwd1Type,Pwd2,Pwd2Type)
{
	/*
  		Pwd1,Pwd2:密码
  		wd1Type:密码1的类型；Pwd2Type：密码2的类型      show:明码；hid：密码
  	*/
	/*if(jtrim(Pwd1).length==0)
	{
        rdShowMessageDialog("客户密码不能为空！",0);
        frm1104.custPwd.focus();
		return false;
	}
    else 
	{
	   if((Pwd2).trim().length==0)
	   {
         rdShowMessageDialog("原始客户密码为空，请核对数据！",0);
         frm1104.custPwd.focus();
		 return false;
	   }
	}
	alert("Pwd1=="+Pwd1);
	alert("Pwd2=="+Pwd2);
	*/
    var checkPwd_Packet = new AJAXPacket("pubCheckPwd.jsp","正在进行密码校验，请稍候......");
    checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("Pwd1",Pwd1);
	checkPwd_Packet.data.add("Pwd1Type",Pwd1Type);
	checkPwd_Packet.data.add("Pwd2",Pwd2);
	checkPwd_Packet.data.add("Pwd2Type",Pwd2Type);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet=null;
	
}
//------------------------------------
function openwin()
{ 
	window.open ("Bank_Code.jsp", "银行代码", 
	   "height=200, width=400,left=200, top=200,toolbar=no,menubar=no, scrollbars=yes, resizable=no, location=no, status=yes"); 
}
//-----------------------------------------
function checkCred()
{
    if(frm1104.CredId.value == "")
    {
    	rdShowMessageDialog("请输入凭证序列号！",0);
    	frm1104.CredId.focus();
    	return false;
    }
    if(frm1104.CredPwd.value == "")
    {
    	rdShowMessageDialog("请输入凭证密码！",0);
    	frm1104.CredPwd.focus();
    	return false;
    }
    //验证随e行凭证号、密码的有效性
  frm1104.hidEInfo.value = "";
  var checkCred_Packet = new AJAXPacket("f1104_8.jsp","正在验证凭证的有效性，请稍候......");
  checkCred_Packet.data.add("retType","checkCred");
	checkCred_Packet.data.add("Cred_id",frm1104.CredId.value);
	checkCred_Packet.data.add("Cred_pwd",frm1104.CredPwd.value);
	core.ajax.sendPacket(checkCred_Packet);
	checkCred_Packet=null;
}
function checkGoodPhone()
{
    //验证手机号码是否被占用
  var checkGoodPhone_Packet = new AJAXPacket("f1104_12.jsp","正在验证手机号码的有效性，请稍候......");
  checkGoodPhone_Packet.data.add("retType","checkGoodPhone");
	checkGoodPhone_Packet.data.add("idIccid",frm1104.idIccid.value);
	checkGoodPhone_Packet.data.add("phoneNo",frm1104.phoneNo.value);
	checkGoodPhone_Packet.data.add("phoneTime",frm1104.phoneTime.value);
	core.ajax.sendPacket(checkGoodPhone_Packet);
	checkGoodPhone_Packet=null;
}
function getGoodPhoneMainBill()
{
	//得到好号的主资费，同时得到最小预存
  var getGoodPhoneMainBill_Packet = new AJAXPacket("f1104_13.jsp","正在获得好号的主资费，请稍候......");
  getGoodPhoneMainBill_Packet.data.add("retType","getGoodPhoneMainBill");
	getGoodPhoneMainBill_Packet.data.add("phoneNo",frm1104.phoneNo.value);
	getGoodPhoneMainBill_Packet.data.add("region_code",frm1104.regionCode.value);
	core.ajax.sendPacket(getGoodPhoneMainBill_Packet);
	getGoodPhoneMainBill_Packet=null;
}
//------------------------
function credDetail()
{
    //查看随e行凭详细信息
    if(frm1104.hidEInfo.value == "")
    {
    	rdShowMessageDialog("没有随e行详细信息！",0);
    	return false;    	
    }
    var path = "/npage/innet/f1104_9.jsp";
    path = path + "?eInfo=" + frm1104.hidEInfo.value; 
    var retInfo = window.showModalDialog(path,"","dialogWidth:550px;dialogHeight:200px;status:no;help:no");    
}
//-------------------------------
function getChinaFee(inFee)
{
  //得到帐户ID
  var getChinaFee_Packet = new AJAXPacket("pubChinaFee.jsp","正在进行费用的大小写转换，请稍候......");
  getChinaFee_Packet.data.add("retType","getChinaFee");
	getChinaFee_Packet.data.add("inFee",inFee);
	core.ajax.sendPacket(getChinaFee_Packet);
	getChinaFee_Packet=null;
}
//--------------------------------
function getSysAccept()
{
	var getSysAccept_Packet = new AJAXPacket("pubSysAccept.jsp","正在生成操作流水，请稍候......");
	getSysAccept_Packet.data.add("retType","getSysAccept");
	core.ajax.sendPacket(getSysAccept_Packet);
	getSysAccept_Packet=null;  
}

function getNote()
{

	//得到工单的广告词
	
	var strstr="";
	var funccode=frm1104.serviceNow.value;
	var funcstr="";
	for(var la=1;la<=getTokNums(funccode,"|");la++){
	var strstr=oneTok(oneTok(funccode,"|",la));
	  funcstr=funcstr+"'"+strstr+"',";	
   }
  funcstr=funcstr.substring(0,funcstr.length-1);
  
  var smsmcode="";
  if (frm1104.newSmCode.value=="bdn"){smsmcode="dn";}
  if (frm1104.newSmCode.value=="bgn"){smsmcode="gn";}
  if (frm1104.newSmCode.value=="bzn"){smsmcode="zn";}
	var getNote_Packet = new AJAXPacket("f1104_getNote.jsp","正在获得工单广告词，请稍候......");
    getNote_Packet.data.add("retType","getNote");
	getNote_Packet.data.add("opCode","1104");
	getNote_Packet.data.add("regionCode","<%=regionCode%>");
	getNote_Packet.data.add("mode_code",document.all.payCode.value);
	getNote_Packet.data.add("add_detail",document.all.add_detail.value);
	getNote_Packet.data.add("add_detail2",document.all.add_detail2.value); //无格式附加资费组
	getNote_Packet.data.add("funcstr",funcstr);
	getNote_Packet.data.add("smcode",smsmcode);
	core.ajax.sendPacket(getNote_Packet);
	getNote_Packet=null;
}
//---------------------------------
function printInfo(printType)
{
   var retInfo = "";
   var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
	 
    //getChinaFee(frm1104.sumPay.value);
    if(printType == "Detail")
    {	//打印电子免填单
        
		//retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss ", Locale.getDefault()).format(new java.util.Date())%>'+"|";
		//retInfo+= frm1104.workno.value+" "+frm1104.workName.value+"|";
		
		cust_info+= "手机号码：    "+frm1104.phoneNo.value+"|";
		cust_info+= "客户姓名：    "+frm1104.custName.value+"|";
		cust_info+= "证件号码：    "+frm1104.idIccid.value+"|";
		cust_info+= "客户地址：    "+frm1104.custAddr.value+"|";
		
		
		
		if(frm1104.newSmCode.value=="bdn")
		{
			opr_info+= opr_info+="业务受理时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:MM:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"用户品牌:"+"动感地带"+"|";
		}else if(frm1104.newSmCode.value=="bgn"){
			opr_info+="业务受理时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:MM:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"用户品牌:"+"全球通"+"|";
		}else{
			opr_info+="业务受理时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:MM:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"用户品牌:"+"神州行"+"|";
		}
		if((frm1104.modedxpay.value).trim().length!=0){
			opr_info+="办理业务:普通开户"+"  "+"操作流水："+frm1104.sysAccept.value+"   底线消费金额"+frm1104.modedxpay.value+"元"+"|";
		}else{
			opr_info+="办理业务:普通开户"+"  "+"操作流水："+frm1104.sysAccept.value+"|";
		}
		var fffs="";
		if(frm1104.checkRadio.checked == true)
		{
			fffs= "付费方式:"+"支票交款";//+++
		}else{
			fffs= "付费方式:"+"现金交款";//++++
		}
		opr_info+= "SIM卡号:"+frm1104.simNo.value+"    "+"SIM卡费:"+frm1104.simFee.value+"|";
		opr_info+=fffs+"    "+"预存款:"+frm1104.prepayFee.value+"|";
		
		
		opr_info+="主资费:"+document.all.payCode.value+" "+"["+document.all.payWay.value+"]"+"|";
		opr_info+="主资费二次批价:"+frm1104.detailcode.value+"|";
		opr_info+="可选资费："+document.all.additiveCode.value+" "+document.all.additivePayWay.value+"|";
		opr_info+="可选资费二次批价:"+frm1104.adddetailcode.value+"|";
		
		//去掉带附加号码的特服
		var aaaaa=oneTok(oneTok(document.all.serviceResult.value,"带附加",1));
		//只剩立即开通的特服
		var aaa=oneTok(oneTok(aaaaa,"预约特服",1));
		//预约特服
		var aa=aaaaa.substring(aaa.length,aaaaa.length);
		
		//frm1104.serviceAddNo.value 
		//if(frm1104.serviceAfter.value =="") {
    		
			opr_info+="开通特服："+aaa+"|";
		//}else 
		//{
			//retInfo+=aa+"|";
		//}
		 var tfsj="";
		for(var lm=1;lm<=getTokNums(frm1104.serviceAfter.value,"|");lm++){
			var temStrsj=oneTok(oneTok(frm1104.serviceAfter.value,"|",lm));
			tfsj=tfsj+temStrsj.substring(2,10)+',';
			
		}
		
		if(frm1104.serviceAfter.value !="") {
			opr_info+=aa+"|";
			opr_info+="生效时间:"+tfsj+"|";
		}
		else{
			
		}
		
		if(frm1104.is_not_adward.value=="Y"){
		
			if("<%=regionCode%>"=="12"){
				note_info1+="您参与入网抽奖活动后，开户预存款未消费完结办理预销，需由您按原价购回礼品，并按剩余开户预存款的30%向移动公司支付违约金。"+"|";
				note_info1+="您参与活动并领取礼品后，不能进行开户及预存款冲正，所交话费不能退费。"+"|";
			}else if("<%=regionCode%>"=="02"){
				note_info1+="您参与活动并领取礼品后，不能进行开户及预存款冲正，所交话费不能退费。开户预存款没有使用完毕前,不能办理销号业务。"+"|";									
   				note_info1+="请您在入网当天在入网营业厅领取礼品，过期无效。"+"|";

			}
			else{
				note_info1+="您参与入网抽奖活动后，三个月(含入网当月)内不能进行资费变更。三个月内若变更资费，所得礼品需由您按原价买回,并按剩余预存款的30％向移动公司支付违约金。"+"|";
				note_info1+="您参与活动并领取礼品后，不能进行开户及预存款冲正，所交话费不能退费。"+"|";
			}
		}
		
		
		
		note_info2+=" "+"|";
		note_info2+="主资费描述："+"|";
		note_info2+=frm1104.mode_note.value+"|";
		//retInfo+="可选资费描述："+"|";
		var ss_addnot=frm1104.adddetailcodenote.value;
		for(var li=1;li<=getTokNums(ss_addnot,"~");li++){
			var temStrnote=oneTok(oneTok(ss_addnot,"~",li));
			if(li==1){
			    note_info3+=" "+"|";
				note_info3+="可选资费描述："+"|";
				note_info3+=temStrnote+"|";
			}else{
			    note_info3+=" "+"|";
				note_info3+=temStrnote+"|";
			}
		}
	
		/*add by zlc 增加特殊号码入网工单*/
	    //alert(frm1104.modedxpay.value);
		//alert(frm1104.modedxpay.value.length);
		if((frm1104.modedxpay.value).trim().length!=0){
		    note_info4+=" "+"|";
			note_info4+="备注：该号码为特殊号码，需在您选择的资费的基础上设置底线消费（底线不包含信息费），如您当月消费的话费（不包括信息费）不足底线额度，将按底线标准收取。"+"|";
		}
		//王良 2006年11月13日 新增		
	    //note_info4+="查费方式: 移动营业厅查询; 移动网站查询; 多媒体机查询; 邮寄帐单查询; 电子帐单查询; 服务热线10086按1号键查询; 168短信查询。"+"|";
	    //note_info4+="交费方式: 手机充值卡交费; 招商银行信用卡交费; 银行托收交费; 银行柜台交费; 自助电话银行交费; 自助网上银行交费; 移动公司营业厅交费。"+"|";
	    //note_info4+="服务密码修改和重置方式: 移动营业厅; 服务热线10086; 移动网站; 168短信。"+"|";
	    //note_info4+="详单密码修改和重置方式: 移动营业厅; 服务热线10086; 168短信。"+"|";

  
	  if(frm1104.largess_card.value=="Y"){
			note_info4+="您获赠"+"<%=strCardSum%>" + "张10元面值充值卡,请您凭入网发票和服务密码于入网当日起的30天内到当地指定营业厅领取，过期作废。"+"|";			
		}else{
			note_info4+=" "+"|";
		}
    note_info4+="备注："+frm1104.opNote.value+"|";
		
		/*
		if(frm1104.smCodeList.value=="dn")
		{retInfo+= "业务类型：    "+"动感地带"+"*打印流水:     "+frm1104.sysAccept.value+"*主资费方式：  "+document.all.payCode.value+" "+document.all.payWay.value+"*可选资费方式："+document.all.additiveCode.value+" "+document.all.additivePayWay.value+"*开通特服：    "+document.all.serviceResult.value+"*|";}
		else if(frm1104.smCodeList.value=="gn")
		{retInfo+= "业务类型：    "+"全球通"+"*打印流水:     "+frm1104.sysAccept.value+"*主资费方式：  "+document.all.payCode.value+" "+document.all.payWay.value+"*可选资费方式："+document.all.additiveCode.value+" "+document.all.additivePayWay.value+"*开通特服：    "+document.all.serviceResult.value+"*|";}
		else if(frm1104.smCodeList.value=="zn")
		{retInfo+= "业务类型：    "+"神州行"+"*打印流水:     "+frm1104.sysAccept.value+"*主资费方式：  "+document.all.payCode.value+" "+document.all.payWay.value+"*可选资费方式："+document.all.additiveCode.value+" "+document.all.additivePayWay.value+"*开通特服：    "+document.all.serviceResult.value+"*|";}
		if(frm1104.checkRadio.checked == true)
		{
			frm1104.cashPay.value="0.00";
		}else{
			frm1104.checkPay.value="0.00";
		}
		retInfo+=document.all.phoneNo.value+"全球通普通开户现金款："+frm1104.cashPay.value+"支票款："+frm1104.checkPay.value+"|";
			    retInfo+=document.all.advNote.value+"|";
		retInfo+="请注意:1.我公司免费为新入网客户开通关机呼转全球呼业务,如果不需要可自行取消;  "+"|";
		retInfo+=" "+"|";
		*/
		/**
		retInfo+= "全球通普通开户。*主资费方式："+document.all.payWay.value+"*可选资费方式："+document.all.additivePayWay.value+"*绑定附加资费："+document.all.bindModeName.value+"*特服："+document.all.serviceResult.value+"*入网机器：";
        if(document.all.selfMach.checked)
          retInfo+="自备机*|";
		else if(document.all.buyMach.checked)
		{
          retInfo+="购机入网    机器类型："+document.all.machName.value+"*|";
		}
		else if(document.all.rentMach.checked)
		{
          retInfo+="租机入网    机器类型："+document.all.machName.value+"*|";
		}

		retInfo+=document.all.sysNote.value+"|";
		retInfo+=document.all.opNote.value+"|";
		
		
    //担保人信息(oneTok:12-15)
    retInfo+=document.all.assuName.value+"|";
		retInfo+=document.all.assuPhone.value+"|";
		retInfo+=document.all.assuAddr.value+"|";
		retInfo+=document.all.assuId.value+"|";
		retInfo+=document.all.assuAddr.value+"|";
		*/
	     
 	}  
  if(printType == "Bill")
  {	//打印发票
    
	}
	frm1104.printInfo.value = retInfo;
	document.all.cust_info.value=cust_info+"#";
	document.all.opr_info.value=opr_info+"#";
	document.all.note_info1.value=note_info1+"#";
	document.all.note_info2.value=note_info2+"#";
	document.all.note_info3.value=note_info3+"#";
	document.all.note_info4.value=note_info4+"#";
	//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  //alert(retInfo);
 	return retInfo;	
}
//-----------------------------------------
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框 
   var h=210;
   var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var pType="printstore";
	 var billType="1";
	 var sysAccept = frm1104.sysAccept.value;
	 
	 var mode_code=document.all.payCode.value+"~"+document.all.additiveCode.value;
	 var fav_code=frm1104.serviceNow.value+frm1104.serviceAfter.value+frm1104.serviceAddNo.value;
	 var area_code=null;
 
   var printStr = printInfo(printType);
   if(frm1104.sysAccept.value == "")
   {		return false;		}
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   	 var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		 var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+document.frm1104.phoneNo.value+"&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   var ret=window.showModalDialog(path,printStr,prop);
   return true;    
}
//-----------------------------------------
function getMainBill()
{	
	if(document.all.smCodeList.value==""){
	  rdShowMessageDialog("页面未完全加载请稍候");
	  return false;
	}
	//得到主资费信息(2003-11-25资费修改)
    var smCode = frm1104.smCodeList.value;
	//var existModeCode=modeCode;	
	//frm1104.smCodeList.value	
	
	if(frm1104.phoneNo.value=="")
	{
		rdShowMessageDialog("请输入手机号码");
	  	return false;
	}
		
    var   existModeCode = document.all.innetCode.options[document.all.innetCode.selectedIndex].mainCode;
   
    
	var   smCode = frm1104.smCodeList.options[frm1104.smCodeList.selectedIndex].value;
	
	var   innetCode = frm1104.innetCode.value.substring(0,2);
	
	var fieldName = "资费模式代码|资费模式名称|";
	
    var path = "pubMainBill.jsp";
    path = path + "?orgCode=" + "<%=orgCode%>";	
    path = path + "&smCode=" + smCode;
    path = path + "&innetCode=" + innetCode;
    path = path + "&phoneNo=" + frm1104.phoneNo.value;
    path = path + "&existModeCode="+existModeCode;
    
	var retInfo = window.showModalDialog(encodeURI(path),"","dialogWidth:60;dialogHeight:25;");
	
 
	if(typeof(retInfo) == "undefined")     
    {   return false;   }
    modeCode = retInfo.substring(0,retInfo.indexOf("|")); 
	
	//------主资费发生变化-----s------
	if(modeCode!=frm1104.payCode.value)
	{
	  frm1104.serviceResult.value="";
	  
	  frm1104.serviceNow.value="";
  	  frm1104.serviceAfter.value="";
  	  frm1104.serviceAddNo.value="";
	  
	  frm1104.tfFlag.value ="n";
	}
	//------主资费发生变化-----e------
	
	frm1104.payCode.value = modeCode;
	var arrClassValue = new Array();
	arrClassValue.push(modeCode);
	getMidPrompt("10442",arrClassValue,"prompt2");
    frm1104.payWay.value = retInfo.substring(1*retInfo.indexOf("|") + 1,retInfo.indexOf("~"));
	//alert("llllllll="+frm1104.payWay.value);
	var modeFlagFromChoice=retInfo.substring(1*retInfo.indexOf("~") + 1);	
	//alert(modeFlagFromChoice);
 	if(parseInt(modeFlagFromChoice,10)>=2) 
	  subPassFlag=false;
	else
      subPassFlag=true;

	if(document.all.tr_pack_creditNo.style.display=="none")
	{ 
		frm1104.additiveCode.value = "";
		frm1104.additivePayWay.value = "";	
	}
	else
	{
		frm1104.additiveCode.value = pack_addifeeCode;
		frm1104.additivePayWay.value = pack_addifeeName;	
	}
 }
//------------------------------------------
function getAdditiveBill()
{
	//得到可选资费信息(2003-11-25资费修改)
    var smCode = frm1104.smCodeList.value;
	var existModeCode=frm1104.additiveCode.value;			
       
    var path = "pubAdditiveBill_1104.jsp";
    path = path + "?pageTitle=" + "可选资费选择";
    path = path + "&orgCode=" + "<%=orgCode%>";
    path = path + "&smCode=" + smCode ;
    path = path + "&modeCode=" + modeCode;
		path = path + "&existModeCode="+existModeCode;
		path = path + "&machineCode=" + document.all.machCode.value;
	 	path = path + "&machineType=" + document.all.hidMachineType.value;
    //alert(path);
	<%//System.out.println("see+++++++++++++++++++++++++++++"+path);%>
	  //window.open(path);
	  //return false;
    var retInfo = window.showModalDialog(path,"","dialogWidth:45;dialogHeight:30;");
	if(typeof(retInfo) == "undefined")     
    {   return false;   }
	
	var addiMode=retInfo.substring(0,retInfo.indexOf("|"));
	//------可选资费发生变化-----s------
	if(addiMode!=frm1104.additiveCode.value)
	{
	  frm1104.serviceResult.value="";
	  
	  frm1104.serviceNow.value="";
  	  frm1104.serviceAfter.value="";
  	  frm1104.serviceAddNo.value="";
	  
	  frm1104.tfFlag.value ="n";
	}
	//------可选资费发生变化-----e------
	//alert(addiMode);
	var detailstr="";
	var arrClassValue = Array();
    for(var ll=1;ll<=getTokNums(addiMode,"~");ll++){
    	var temStr=oneTok(oneTok(addiMode,"~",ll));
    	detailstr=detailstr+"'"+temStr+"',";	
    	arrClassValue.push(temStr)
    }
    getMidPrompt("10442",arrClassValue,"prompt1");			  
    detailstr=detailstr.substring(0,detailstr.length-1);
    //alert(detailstr);
    frm1104.additiveCode.value =  addiMode;
    frm1104.add_detail.value =  detailstr;
    frm1104.add_detail2.value = arrClassValue;
    frm1104.additivePayWay.value = retInfo.substring(1*retInfo.indexOf("|") + 1);
	  subPassFlag=true;
}

//-----------------改变附加资费------------------
function chgRentFee()
{
  	//------附加资费发生变化-----s------
	  frm1104.serviceResult.value="";
	  frm1104.serviceNow.value="";
	  frm1104.serviceAfter.value="";
	  frm1104.serviceAddNo.value="";
	  
	  frm1104.tfFlag.value ="n";
 	//------附加资费发生变化-----e------
}

//-------------------------------------------
function serviceWay()
{
    //特服定购
    var smCode = frm1104.smCodeList.value;
  
    var path = "pubService.jsp";
    path = path + "?orgCode=" + "<%=orgCode%>";
    path = path + "&smCode=" + smCode + "&pageTitle=" + "特服选择";
    path = path + "&modeCode=" + modeCode;
    path = path + "&showType=" + "All";
    path = path + "&belongCode=" + "<%=belongCode%>" + "&regionCode=" + "<%=regionCode%>";
    var retInfo = window.showModalDialog(path,"","dialogWidth:50;dialogHeight:40;");
	 	if(typeof(retInfo) == "undefined")     
	    {	return false;   }
    var chPos;
    chPos = retInfo.indexOf("~");
    if(chPos < 0)
    {	return false ;	}

	  document.all.tfFlag.value="y"; 

    var retCode = retInfo.substring(0,chPos);
	  var totalPrepay = 0;
    var chPos2 = retInfo.indexOf("#");
    if(chPos2 < 0)
    {	return false ;	}
	  totalPrepay = retInfo.substring(1*chPos+1, chPos2);
	  frm1104.espPreFee.value = totalPrepay;
    frm1104.serviceResult.value = retInfo.substring(1*chPos2 + 1);
    frm1104.serviceNow.value = retCode.substring(0,retCode.indexOf("&")); 
    retCode = retCode.substring(retCode.indexOf("&")+1);
    frm1104.serviceAfter.value = retCode.substring(0,retCode.indexOf("&"));
    retCode = retCode.substring(retCode.indexOf("&")+1);
    frm1104.serviceAddNo.value = retCode.substring(0,retCode.indexOf("&"));     
}
//-----------------------------------------
function feeCount()
{

    //资源校验
   
    
	var iccid = document.frm1104.idIccid.value;
	var len = document.frm1104.idIccid.value.length;
	var iccid1 = iccid.substr(len-4,4);
	var pass = "00"+iccid1;
	var userId=document.frm1104.userID.value;
	
	//alert(document.all.pname.value);
	//alert(document.userPwd.pname.value);
	if(userId==""||userId.length<0){
		rdShowMessageDialog("用户ID不能为空，请获得用户ID！",0);
		return false;
	}
	

	 if(document.frm1104.userPwd.value == "000000"||document.frm1104.userPwd.value == "001234"||document.frm1104.userPwd.value == pass)
	   {
	           rdShowMessageDialog("密码过于简单，请重新设置！");
			   frm1104.userPwd.focus();
			   return false;	   
	   }


  if(frm1104.xyd_bz.value!="0"){
  	if(parseInt(frm1104.xinYiDu.value,10)>0){
  		 rdShowMessageDialog("没有权限设置正信誉度！",0);
        	frm1104.xinYiDu.focus();
        	return false;
  	}
  }

	if(isnotawardhange()==false){
    return false;}
	
	
    if(frm1104.hid_checkRes.value == "0")
    {   
    	    if(checkResource()==false)      
    	    {   return false;           }
    }    
    if(1*frm1104.hid_MachFee.value > 1*frm1104.machFee.value)
    {
        rdShowMessageDialog("优惠后的机器费不能大于初始费用！",0);
        frm1104.machFee.focus();
        return false;
    }
    if(1*frm1104.hid_ChoiceFee.value < 1*frm1104.choiceFee.value)
    {
        rdShowMessageDialog("优惠后的选号费不能大于初始费用！",0);
        frm1104.choiceFee.focus();
        return false;
    }    
   // if(1*frm1104.hid_SimFee.value < 1*frm1104.simFee.value)
   // {
        //rdShowMessageDialog("优惠后的SIM卡费不能大于初始费用！",0);
        //frm1104.simFee.focus();
       // return false;
    //}    
    if(1*frm1104.simFee.value >200)
    {
        rdShowMessageDialog("SIM卡费不能大于200！",0);
        frm1104.simFee.focus();
        return false;
    } 
    if(1*frm1104.cashPay.value>100000)
	{
		rdShowMessageDialog("交费金额不能大于100000!",0); 
    	frm1104.print.disabled = true;
		return false;
	  	
	}  
    if(1*frm1104.hid_HandFee.value < 1*frm1104.handFee.value)
    {
        rdShowMessageDialog("优惠后的手续费不能大于初始费用！",0);
        frm1104.handFee.focus();
        return false;
    }    
    //比较时间
    if(checkElement(document.all.favourableTime) != true){ return false}; 
    var beginDate = frm1104.favourableTime.value;
    var endDate = frm1104.hid_favourableTime.value;         
    if(beginDate > endDate)
    {   
        rdShowMessageDialog("优惠时间不能大于当前系统时间！",0);        
        frm1104.favourableTime.value = frm1104.hid_favourableTime.value;
        frm1104.favourableTime.focus();
        return false;
    }    
	
	//by huy
	
	frm1104.prepayFee.value="0.00";
   var  smallestPrepay=document.all.smallestPrepay.value;
	var curentPrepay = 1*frm1104.innetPreFee.value + 1*frm1104.choicePreFee.value + 1*frm1104.espPreFee.value + 1*frm1104.prepayFee.value;
	var payPrepay = 1*smallestPrepay - 1*curentPrepay;
	if(1*curentPrepay < 1*smallestPrepay)
	{
		rdShowMessageDialog("当前预存款之和不能小于最小预存款:("+1*smallestPrepay+"),至少还需预存:("+1*payPrepay+")!",0);        
        frm1104.innetPreFee.focus();
        return false;
	}
            
    var tempSumPay = 1*frm1104.handFee.value  + 1*frm1104.choiceFee.value
              + 1*frm1104.machFee.value + 1*frm1104.simFee.value
              + 1*frm1104.choicePreFee.value + 1*frm1104.innetFee.value 
              + 1*frm1104.innetPreFee.value+1*frm1104.espPreFee.value;    
	frm1104.sumPay.value=Math.round(tempSumPay*100)/100;
/**
	alert("10"+1*frm1104.cashPay.value + 1*frm1104.checkPay.value);
	alert("11"+1*frm1104.handFee.value + 1*frm1104.choiceFee.value
                               + 1*frm1104.machFee.value + 1*frm1104.simFee.value
                               + 1*frm1104.choicePreFee.value + 1*frm1104.innetFee.value
                               + 1*frm1104.innetPreFee.value + 1*frm1104.espPreFee.value);
*/
    var prepay_Fee = 1*frm1104.cashPay.value + 1*frm1104.checkPay.value 
                               - (1*frm1104.handFee.value + 1*frm1104.choiceFee.value
                               + 1*frm1104.machFee.value + 1*frm1104.simFee.value
                               + 1*frm1104.choicePreFee.value + 1*frm1104.innetFee.value
                               + 1*frm1104.innetPreFee.value + 1*frm1104.espPreFee.value);
							   
    if(1*prepay_Fee < 0)
    {
        rdShowMessageDialog("交款金额不足(还需交款：" + (-1)*prepay_Fee + ")！",0);
		document.all.cashPay.select();
		document.all.cashPay.focus();
        return false;
    }

    var checkPay = 1*frm1104.checkPay.value;
    var checkPrePay = 1*frm1104.checkPrePay.value;
    if((checkPay > checkPrePay)&&(frm1104.checkRadio.checked == true))
    {
        rdShowMessageDialog("支票剩余金额不足，不能支付本次交费！(剩余：" + checkPrePay + ")",0);
		document.all.cashPay.select();
		document.all.cashPay.focus();
        return false;    
    }
    var tempPrepayFee = 1*frm1104.cashPay.value + 1*frm1104.checkPay.value 
                               - 1*frm1104.handFee.value - 1*frm1104.choiceFee.value
                               - 1*frm1104.machFee.value - 1*frm1104.simFee.value
                               - 1*frm1104.innetFee.value;
	
	frm1104.prepayFee.value=Math.round(tempPrepayFee*100)/100;
	frm1104.hid_countFlag.value = "1";
  //入网赠送充值卡判断
  //在活动期间入网收取SIM卡卡费（即sim卡费>0），且预存款金额不低于50元的客户	
	if (document.all.simFee.value <= 0 || document.all.prepayFee.value < 50){
		document.all.largess_card[1].selected = true;
	}
    //------------------------------------
    if(frm1104.sysAccept.value == ""){
      getSysAccept();
    }else{
      printInfo("Detail");
    }
    
    getChinaFee((frm1104.cashPay.value*1)+(frm1104.checkPay.value*1));
    //------------------------------------
    var sysNote = "普通开户:" + "主资费[" + document.all.payCode.value + "]手机号码[" + 
    	         document.frm1104.phoneNo.value + "]"; 
    frm1104.sysNote.value = sysNote;    
    frm1104.print.disabled = false;
    return true;              
}
//-----------------------------------------
function clearnew(){
	//alert("ssssssssss");
	    document.frm1104.phoneNo.disabled=false;
      document.frm1104.simNo.disabled=false;
      document.frm1104.resourceValid.disabled=true;
      document.frm1104.sumParCount.disabled=true;
      document.frm1104.print.disabled=true;
      
}

function jspReset()
{
        var obj = null;
        var t = null;
    	var i;   	
        for (i=0;i<document.frm1104.length;i++)
        {    
    		obj = document.frm1104.elements[i];		 		 		 
    		packUp(obj); 
    	    obj.disabled = false;
         }        
        document.frm1104.commit.disabled = "none"; 
       
}

function getTtFee()
{
   
   var tempSumPay= (1*document.all.handFee.value  + 1*document.all.choiceFee.value + 1*document.all.machFee.value + 1*document.all.simFee.value+ 1* document.all.choicePreFee.value + 1*document.all.innetFee.value + 1*document.all.innetPreFee.value+1*document.all.espPreFee.value).toString(); 
   document.all.sumPay.value=Math.round(tempSumPay*100)/100;
   if(document.all.NocheckRadio.checked)
     document.all.cashPay.value=document.all.sumPay.value;
}

function getpreFee()
{
 if(event.keyCode==13)
 {
  document.all.prepayFee.value =(1*frm1104.cashPay.value + 1*frm1104.checkPay.value 
                               - 1*frm1104.handFee.value - 1*frm1104.choiceFee.value
                               - 1*frm1104.machFee.value - 1*frm1104.simFee.value
                               - 1*frm1104.innetFee.value).toString();   
 }
}

function ifBlur()
{
  if(preFlag==true)
  {
    //rdShowMessageDialog("手机号码为预开通号码，SIM卡号不可改变！");
    //document.all.simNo.blur();
  }
}

function chgNewSm()
{
  document.all.smCodeList.options.length=0;
  var oldSmStr="";
  var recNum=js_newSm[0].length;
  for(var i=0;i<recNum;i++)
  {
    if(js_newSm[0][i]==js_regionCode && js_newSm[2][i]==document.all.newSmCode.value)
	{
 	    oldSmStr+=js_newSm[1][i]+"#";
	}
  }
  
  //alert(oldSmStr+"oldsmstr");
  
  var smallSmNum=getTokNums(oldSmStr,"#");
  
  //alert(smallSmNum+"    smallSmNum");
  
  var temSm="";
  var temOptionNum=0;
  for(var i=0;i<smallSmNum;i++)
  {
    temSm=oneTok(oldSmStr,"#",i+1);
	
	if(temSm!="z0" && temSm!="cb")
	{
	  temOptionNum=0;
	
	  for(var j=0;j<js_oldSm[0].length;j++)
	  {
	    if(temSm==js_oldSm[0][j])
	    {
	      //alert("js_oldSm[1][j]==="+js_oldSm[1][j]);
	      var newItem=document.createElement("OPTION");
		  newItem.text=js_oldSm[1][j];
		  newItem.value=js_oldSm[0][j];
	      document.all.smCodeList.options.add(newItem);
	    }
	  }
	}
  }
  changeSmCode();
}



//--------------------下面是新增加的开户方式的radio的处理 by mengxin---------------------

function doinnettype(){
document.all.innet_jituan.style.display="none";
document.all.innet_szx.style.display="none";
document.all.innet_pzxl.style.display="none";
document.all.innet_pzdetail.style.display="none";
document.all.innet_kaitong.style.display="none";
document.all.innet_czkye.style.display="none";
	
	if (frm1104.innettype[0].selected || frm1104.innettype[3].selected || frm1104.innettype[4].selected){
		document.all.innet_pzdetail.style.display="none";
	}
	else{
		document.all.innet_pzdetail.style.display="";
	}
	
	if (frm1104.innettype[1].selected){
		document.all.innet_szx.style.display="";
		document.all.innet_czkye.style.display="";
	}

	if (frm1104.innettype[2].selected){
		document.all.innet_jituan.style.display="";
	}

	if (frm1104.innettype[5].selected){
		document.all.innet_pzxl.style.display="";
	}

	if (frm1104.innettype[6].selected){
		document.all.innet_kaitong.style.display="";
	}

}

function changelargesscard(){
	if (parseInt(frm1104.largess_card_sum.value) == 0){
		document.all.largess_card[1].selected = true;
		rdShowMessageDialog("此地市或区县没有入网赠送充值卡活动");
		return false;
	}

	if (document.all.simFee.value <= 0 || document.all.prepayFee.value < 50){
		document.all.largess_card[1].selected = true;
		return false;
	}	
	
}

function isnotawardhange(){
		/*if(frm1104.newSmCode.value=="bgn" && parseInt(frm1104.innetPreFee.value,10)<200 && frm1104.is_not_adward.value=="Y"){
		rdShowMessageDialog("全球通品牌预存小于200元不能参加入网送福活动");
		return false;
		}
		else if (parseInt(frm1104.innetPreFee.value,10)<100 && frm1104.is_not_adward.value=="Y"){
		rdShowMessageDialog("预存小于100元不能参加入网送福活动");
		return false;
    		}
    	else if (frm1104.goodphone.value=='Y' && frm1104.is_not_adward.value=="Y"){
    		rdShowMessageDialog("特殊号码不能参加入网送福活动");
		return false;
    		
    	}
    	else if ((frm1104.innetCode.options[frm1104.innetCode.selectedIndex].text=="商务电话" || frm1104.innetCode.options[frm1104.innetCode.selectedIndex].text=="公免"||frm1104.innetCode.options[frm1104.innetCode.selectedIndex].text=="IP公话")&& frm1104.is_not_adward.value=="Y" )
    	{
		rdShowMessageDialog("商务电话或IP公话或公免不能参加入网送福活动");
		return false;
    	}
    	else{
    		return true;
    	}
    	*/
    	if(frm1104.is_not_adward.value=="Y"){
    		if (frm1104.innetCode.options[frm1104.innetCode.selectedIndex].text=="商务电话" || frm1104.innetCode.options[frm1104.innetCode.selectedIndex].text=="公免"||
			frm1104.innetCode.options[frm1104.innetCode.selectedIndex].text=="IP公话"){
    			rdShowMessageDialog("商务电话或IP公话或公免不能参加入网新惊喜活动");
				return false;
    		}
    	 if (frm1104.goodphone.value=='Y'){
    			rdShowMessageDialog("特殊号码不能参加入网送福活动");
				return false;
    		
    	}
    	/*
    		var getlike_Packet = new AJAXPacket("f1104_getlike.jsp","正在校验是否可以参与入网有礼喜活动，请稍候......");
    		getlike_Packet.data.add("retType","getlike");
				getlike_Packet.data.add("regionCode","<%=regionCode%>");
				getlike_Packet.data.add("mode_code",document.all.payCode.value);
				getlike_Packet.data.add("pay_money",frm1104.innetPreFee.value);
				core.ajax.sendPacket(getlike_Packet);
				getlike_Packet=null;
		*/
		
	}
	
    	
}


function pinPaiQuery()
{
	//品牌查询
    /**
	var path = "qrySmCode.jsp";
	var retInfo = window.showModalDialog(path,"","dialogWidth:60;dialogHeight:25;");
	*/
	window.open ("qrySmCode.jsp", "", 
	   "height=400, width=800,left=100, top=200,toolbar=no,menubar=no, scrollbars=yes, resizable=no, location=no, status=yes"); 
}



 </SCRIPT>
<%
 /*判断sFuncCheckClose服务调用是否成功  刘通 2008.08.21*/
 //   
 	if(sFuncCheckClose.equals("close")){
%>
 		<script lanuage="javascript">
 				rdShowMessageDialog("服务未能成功,服务代码:<%=retCode%><br>服务信息:<%=retMsg%>");
 				parent.removeTab('<%=opCode%>');
 			</script>
<%
}
%>

<!--**************************************************************************************-->
<META http-equiv=Content-Type content="text/html; charset=GBK">

</HEAD>
<body >
<body  onMouseDown="hideEvent()" onKeyDown="hideEvent()" >
<FORM method=post name="frm1104" action="f1104_2.jsp" onKeyUp="chgFocus(frm1104);">

<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">全球通普通开户</div>
		</div>
              <TABLE cellSpacing="0">
                <TR> 
                  <TD class=blue  width=15%> 
                    <div align="left" >客户类型</div>
                  </TD>
                  <TD colspan="3" nowrap   width=85%> 
                    <input  type="radio" name="customType" value="N" checked onclick="chgCustType()" index="-4">
                    已有客户 
                    <input  type="radio" name="customType" value="Y" onclick="chgCustType()" index="-3">
                    新建客户</TD>
                </TR>
                <TBODY> 
                <TR> 
                  <TD class=blue   width=15%> 
                    <div align="left">客户证件号码</div>
                  </TD>
                  <TD   nowrap   width=35%> <font face="宋体"> </font> <font color="red"> 
                    <input id='in2' name=idIccid class="button" v_must=1 v_type="string" v_name="客户证件号码" maxlength="20" onKeyup="if(event.keyCode==13) getInfo_IccId();" index="-2">
                    *</font> 
                    <input name=custIdQuery type=button onClick="choiceSelWay();" class="b_text" style="cursor:hand" id="custIdQuery" value=信息查询>
				  </TD>  
				    
				  <TD  class=blue   width=15% > 
				    <span align="left" id="divCustPad1" style="display:;">客户密码</span>&nbsp;
			      </TD>

			      <TD   width=35% >
			      	<span  id="divCustPad2" style="display:;">
				    <jsp:include page="/npage/common/pwd_1.jsp">
	                <jsp:param name="width1" value=""  />
	                <jsp:param name="width2" value=""  />
	                <jsp:param name="pname" value="custPwd"  />
	                <jsp:param name="pwd" value="12345"  />
 	                </jsp:include>
	   				<input name=chkPass type=button onClick="change_custPwd();" class="b_text" style="cursor:hand" id="chkPass" value=校验>
	   			</span>&nbsp;
	   			  </TD>
	   			  
	   			  
	   <!--
                  <TD   nowrap> 
                    <div align="left">客户密码</div>
                  </TD>
                  <TD  nowrap> 
     
                    <input id='in6' class="button" type="password" name="custPwd" v_must=0 v_type="0_9" v_name="客户密码" maxlength="6" index="-1" onkeyup="if(event.keyCode==13)change_custPwd();">
		</td>
		-->
                </TR>
                <TR   > 
                  <TD   class=blue > 
                    <div align="left">客户名称</div>
                  </TD>
                  <TD   nowrap> <font color="red"> 
                    <input id='in4' class="button" name=custName v_must=1 v_maxlength=60 v_type="string" v_name="客户名称" onKeyup="if(event.keyCode==13) {getInfo_withName();document.all.custPwd.focus();}" >
                    *</font> </TD>
                  <TD   nowrap class=blue > 
                    <div align="left">客户证件类型</div>
                  </TD>
                  <TD   nowrap> 
                    <input id='in3' class="button" name=idType readonly Class="InputGrey">
                  </TD>
                </TR>
                
				<TR   > 
                  <TD class=blue > 
                    <div align="left">客户ID</div>
                  </TD>
                  <TD   nowrap  > <font face="宋体"> 
                    <input  id='in0' class="button" name=custId v_minlength=10 v_maxlength=14 v_type="0_9" v_name="客户ID" maxlength="14" onKeyup="if(event.keyCode==13) {getInfo_withId();document.all.custPwd.focus();}">
                    </font><font color="red">*</font> </TD>
                  <TD   nowrap   class=blue > 
                    <div align="left">客户地址</div>
                  </TD>
                  <TD   nowrap  > 
                    <input id="in5" class="button"  name=custAddr readonly Class="InputGrey">
                  </TD>
                </TR>

				<TR   > 
                  <TD   class=blue > 
                    <div align="left">开户方式</div>
                  </TD>
                  <TD   nowrap  > 
                    
					<select name="innettype" onChange="doinnettype()">
					<option class='button' value='01' selected>普通开户</option>
					<!--
					<option class='button' value='02' >神州行转网</option>
					<option class='button' value='03' >集团直联</option>
					<option class='button' value='04' >二次入网</option>
					<option class='button' value='05' >天府行过期激活</option>
					<option class='button' value='06' >随E行</option>
					<option class='button' value='07' >多方通话</option>
					-->
					</select>
                  </TD>
                  <td colspan=2>
				 <!-- <a href="qrySmCode.jsp">品牌查询</a>--> 
				 <input name="pinPai" type="button" class="b_text" value="品牌查询" onClick="pinPaiQuery()">
				  </td>
				
                </TR>

				
<!-------------------------------------------隐藏区域，根据上面选择来显示-------------------------------------------->				
				<TR   id="innet_jituan" style="display:none"> 
                  <TD    class=blue  > 
                    <div align="left">集团代码</div>
                  </TD>
                  <TD   nowrap  >
                    <input class="button" name=jtcode v_name="集团代码" maxlength="10" onKeyup="if(event.keyCode==13) {}">
                  </TD>
                  <TD   nowrap   class=blue > 
                    <div align="left">集团名称</div>
                  </TD>
                  <TD   nowrap  > 
                    <input class="button"  name=jtname readonly Class="InputGrey">
                  </TD>
                </TR>
				<TR   id="innet_szx" style="display:none"> 
                  <TD     class=blue > 
                    <div align="left">神州行号</div>
                  </TD>
                  <TD   nowrap  >
                    <input class="button" name=szxcode v_name="神州行号" maxlength="10" >
					<input class="button" name=get_szxsim onkeyup="if(event.keyCode==13){getMainBill()}" onmouseup="getMainBill()"  style="cursor:hand" type=button value=查询 index="">
                  </TD>
                  <TD   nowrap   class=blue > 
                    <div align="left">神州行sim卡</div>
                  </TD>
                  <TD   nowrap  > 
                    <input class="button"  name=szxsim readonly Class="InputGrey">
                  </TD>
                </TR>

				<TR   id="innet_pzxl" style="display:none"> 
                  <TD     class=blue > 
                    <div align="left">凭证序列</div>
                  </TD>
                  <TD   nowrap  >
                    <input class="button" name=pzxlcode v_name="凭证序列" maxlength="10" >
					<input class="button" name=get_pzxlcode onkeyup="if(event.keyCode==13){getMainBill()}" onmouseup="getMainBill()"  style="cursor:hand" type=button value=查询 index="">
                  </TD>
                  <TD   nowrap   class=blue > 
                    <div align="left">凭证密码</div>
                  </TD>
                  <TD   nowrap  >
                    <input class="button" name=pzxlpwd v_name="凭证密码" maxlength="10" >
					<input class="button" name=get_pzxlpwd onkeyup="if(event.keyCode==13){getMainBill()}" onmouseup="getMainBill()"  style="cursor:hand" type=button value=校验 index="">
                  </TD>
                </TR>

				<TR   id="innet_pzdetail" style="display:none"> 
                  <TD     class=blue > 
                    <div align="left">凭证详细信息</div>
                  </TD>
                  <TD   nowrap  colspan="3">
                    <input type="radio" name="pzdetail" value="0" onClick="">不列选
					<input type="radio" name="pzdetail" value="1" onClick="">列选
                  </TD>
				
                </TR>
				
				<TR   id="innet_kaitong" style="display:none"> 
                  <TD   nowrap  class=blue   colspan="3"> 
                    <div align="left">开通方数</div>
                  </TD>
                  <TD   nowrap  > 
                    <input class="button"  name=opentype >
                  </TD>
                </TR>
<!-------------------------------------------隐藏区域，根据上面选择来显示end-------------------------------------------->				
				
				<TR   > 
                  <TD   class=blue > 
                    <div align="left">用户级别</div>
                  </TD>
                  <TD nowrap> 
                    <select  align="left" name=custGrade  index="0">
                      <%
        //得到输入参数
     /**
      try
        {
                String sqlStr ="select trim(OWNER_CODE), TYPE_NAME from sCustGradeCode " + 
                   " where REGION_CODE ='" + regionCode + "' and owner_code='00' order by OWNER_CODE";                  
                retArray = callView.view_spubqry32("2",sqlStr);
                //int recordNum = Integer.parseInt((String)retArray.get(0));
                //result = (String[][])retArray.get(1);
                result = (String[][])retArray.get(0);
                int recordNum = result.length;                  
                for(int i=0;i<recordNum;i++){
                        out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
                }
        }catch(Exception e){
                logger.error("Call sunView is Failed!");
        }  
         **/
     			   String sqlStr5 ="select trim(OWNER_CODE), TYPE_NAME from sCustGradeCode " + 
                   " where REGION_CODE ='" + regionCode + "' and owner_code='00' order by OWNER_CODE";      
               %>
               <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode5" retmsg="retMsg5" outnum="2">
				<wtc:sql><%=sqlStr5%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="result5" scope="end" />
               <%
                if(!retCode5.equals("000000")){
                   out.println("<option class='button' value='99'></option>");
					%>
					   <script language="javascript">
					   	  rdShowMessageDialog("服务未能成功,服务代码:<%=retCode5%><br>服务信息:<%=retMsg5%>");
					   	  parent.removeTab('<%=opCode%>');
						</script>
					<%	
						}else{

       			 for(int i=0;i<result5.length;i++){
                        out.println("<option class='button' value='" + result5[i][0] + "'>" + result5[i][1] + "</option>");
                   }}
				 %>
                    </select>
                  </TD>
                  <TD nowrap class=blue >业务品牌</TD>
                  <TD nowrap> 
                     <select align="left" name=newSmCode width=50 index="1" onChange="chgNewSm()">
                      <%
    //得到大的业务品牌
 /**	try
 	{
      		//String sqlStr = "select distinct bsm_code, trim(bsm_name) from snewsmcode where REGION_CODE='"+regionCode+"' and sm_code in('gn','dn','zn') order by bsm_code desc";
		    //String sqlStr = "select distinct bsm_code, trim(bsm_name) from snewsmcode where REGION_CODE='"+regionCode+"' and sm_code in('gn','dn','zn','hn') order by bsm_code desc";
			String sqlStr = "select distinct bsm_code, trim(bsm_name) from snewsmcode where REGION_CODE='"+regionCode+"' and sm_code in('zn','dn','gn') order by bsm_code";
      		retArray = callView.view_spubqry32("2",sqlStr);
       		result = (String[][])retArray.get(0);
      		int recordNum = result.length;      		
      		for(int i=0;i<recordNum;i++){
        		out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
      		}
     	}catch(Exception e){
       		logger.error("Call sunView is Failed!");
     	}   
     	**/
     	
     	
     			   String sqlStr6 ="select distinct bsm_code, trim(bsm_name) from snewsmcode where REGION_CODE='"+regionCode+"' and sm_code in('zn','dn','gn') order by bsm_code";  
               %>
               <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode6" retmsg="retMsg6" outnum="2">
				<wtc:sql><%=sqlStr6%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="result6" scope="end" />
               <%
                if(!retCode6.equals("000000")){
                   out.println("<option class='button' value='99'></option>");
					%>
					   <script language="javascript">
					   	  rdShowMessageDialog("服务未能成功,服务代码:<%=retCode6%><br>服务信息:<%=retMsg6%>");
					   	  parent.removeTab('<%=opCode%>');
						</script>
					<%	
						}else{
       			 for(int i=0;i<result6.length;i++){
                        out.println("<option class='button' value='" + result6[i][0] + "'>" + result6[i][1] + "</option>");
                   }}    	       
%>
                    </select>
                  </TD>
                </TR>
                <TR   > 
                  <TD   class=blue > 
                    <div align="left">业务类型</div>
                  </TD>
                  <TD   nowrap> 
                    <select align="left" name=smCodeList onchange="changeSmCode()"  index="2">                    
                    </select>
                  </TD>
                  <TD   nowrap class=blue > 
                    <div align="left">入网代码</div>
                  </TD>
                  <TD   nowrap> 
                    <select id=innetCode align="left" name=innetCode onchange="changeInCode()"  index="3">
                    </select>
                  </TD>
                </TR>
                </TBODY> 
              </TABLE>      
         
              <TABLE id=cred0  cellSpacing="0" style="display:none">
                <TBODY> 
                <TR  > 
                  <TD  class=blue  nowrap> 
                    <div align="left">凭证序列号</div>
                  </TD>
                  <TD  nowrap> 
                    <input name=CredId class="button" v_must=0 v_type="string" v_name="凭证序列号" index="4">
                    <font color="red">*</font> </TD>
                  <TD  class=blue  nowrap> 
                    <div align="left">凭证密码</div>
                  </TD>
                  <TD  nowrap> 
                    <input name=CredPwd type=password class="button" v_must=0 v_type="string" v_name="凭证密码" onkeyup="if(event.keyCode==13)getInfo_IccId();" index="5">
                    <font color="red">*</font> </TD>
                </TR>
                <TR  > 
                  <TD   nowrap> 
                    <div align="right"></div>
                  </TD>
                  <TD colspan="2" nowrap> 
                    <input name=custIdQuery1 type=button onkeyup="if(event.keyCode==13) checkCred();" onmouseup="checkCred()" class="b_text" style="cursor:hand" id="custIdQuery1" value=凭证校验 index="6">
                  </TD>
                  <TD nowrap> 
                    <input name=custIdQuery2 type=button onKeyUp="if(event.keyCode==13)credDetail();"  onMouseUp="credDetail()" class="b_text" style="cursor:hand" id="custIdQuery2" value=详细信息 index="7">
                  </TD>
                </TR>
                </TBODY> 
              </TABLE>                   
            
              <TABLE  cellSpacing="0">
                <TBODY> 
                <TR  > 
                  <TD class=blue  nowrap   width=15%> 
                    <div align="left">服务号码</div>
                  </TD>
                  <TD  nowrap   width=35%> 
                    <input name=phoneNo class="button" v_must=1 v_type="mobphone"  maxlength=11 index="8" onblur="if(checkElement(this)){QryForeSimNo()}">
                  
                    <font color="red">*</font>
                 <!--   <input name="ph" type="radio" value="ph"  onclick="phtype()" checked >
                    正常开户 
                    <input type="radio" name="yph"   value="yph" onclick="yphtype()" >
                    预占开户 
                    -->
                    </TD>
                  <TD  class=blue  nowrap  width=15%> 
                    <div align="left">服务类型</div>
                  </TD>
                  <TD  nowrap   width=35%> 
                    <select align="left" name=serviceType  index="9">
                      <option value="01" selected>普通语音服务</option>
                    </select>
                  </TD>
                </TR>
                <TR  > 
                  <TD nowrap   class=blue> 
                    <div align="left">SIM卡号</div>
                  </TD>
                  <TD nowrap > 
                    <input class="button" name=simNo  v_must=1 v_type=string v_maxlength=20 v_minlength=20 v_name="SIM卡号" maxlength=20 index="10" onFocus="ifBlur();"  onkeyup="if(event.keyCode==13)qrySimType()">
                    <font color="red">*</font> 
                    <input class="b_text" name=b_qrySimType onclick="qrySimType()" style="cursor:hand" type=button value=查询类型 >
                    		  <td nowrap  colspan="3"> <input type="radio" name="cardtype" value="N" checked onclick="chgcardtype()" index="-4">
                    实卡 
                    <input type="radio" name="cardtype"   value="Y" onclick="chgcardtype()"  index="-3">
                    空卡</td>
                  </TD>
                 
                  </tr>
                  <TR  > 
                  <TD nowrap class=blue > 
                    <div align="left">SIM卡类型</div>
                  </TD>
                  <TD nowrap colspan=3> 
                    <input name=simTypeName type=text  readonly index="11" Class="InputGrey">
                    <input name=simType type=hidden value="">
                    <input name=cardcard type=hidden value="">
                    <input name=cardtype_bz type=hidden value="s">
                    <input name=writecardbz type=hidden value="">
                    <input type="hidden" name="cust_info">
      				<input type="hidden" name="opr_info">
      				<input type="hidden" name="note_info1">
      				<input type="hidden" name="note_info2">
      				<input type="hidden" name="note_info3">
      				<input type="hidden" name="note_info4">
      				<input type="hidden" name="printcount">
                    
                   
                  </TD>
                 
                </TR>
                <TR  > 
                
             <TD nowrap  class=blue   > 
                    <div align="left">预占ID</div>
                  </TD>
                  <TD nowrap  > 
                    <input  class="button" type="text" name="zph"   maxlength="20"    >
                 非自助选号不填
                  
                                     
                  <TD>
               
                 <input class="b_text" name=resourceValid onKeyUp="if(event.keyCode==13)checkResourceFirst()" onMouseUp="checkResourceFirst()"  style="cursor:hand" type=button value=资源校验 disabled index="12">
                      </TD>
                   <TD >  
                    <input class="b_text" type="button" name="b_write" value="写卡" onmouseup="writechg()" onkeyup="if(event.keyCode==13)writechg()" disabled index="19">
                   </TD>
              <!--
                  
             <TD nowrap   ></TD>
                  <TD nowrap   >
               
                  <input class="button" name=resourceValid onKeyUp="if(event.keyCode==13)checkResourceFirst()" onMouseUp="checkResourceFirst()"  style="cursor:hand" type=button value=资源校验 disabled index="12">
                      </TD>
                   <TD >  </TD>
                   <TD >  </TD>
                 -->
                </TR>
                <TR   > 
                  <TD nowrap   class=blue > 
                    <div align="left">入网机器</div>
                  </TD>
                  <TD nowrap  > 
                    <input name="selfMach" type="radio" value="self" onclick="selfMachType()" checked index="13">
                    自备机 
                    <input type="radio" name="buyMach"   value="buy" onclick="buyMachType()" index="14">
                    购机入网 
                    <input type="radio" name="rentMach"   value="rent" onclick="rentMachType()" index="15">
                    租机入网 </TD>
                  <TD nowrap   class=blue > 
                    <div align="left">机器代码</div>
                  </TD>
                  <TD nowrap  > 
                    <input class="button"  name=machCode size="3"  readonly value="" Class="InputGrey">
                    <input class="button"  name=machName   readonly Class="InputGrey">
                    <input class="b_text" name=machCodeQuery onmouseup="machQuery()"  onkeyup="if(event.keyCode==13)machQuery()" style="cursor:hand" type=button value=查询 disabled index="16">
                  </TD>
                </TR>
                <TR    ID="tr_pack_creditNo" style="display:none"> 
                  <TD nowrap   class=blue > 
                    <div align="left">营销包凭证号码</div>
                  </TD>
                  <TD nowrap colspan="3"><font face="宋体"> 
                    <input  id='pack_creditNo' class="button" name=pack_creditNo v_must=0 v_maxlength=20 v_type="0_9" v_name="营销包凭证号码" maxlength="20" onKeyUp="if(event.keyCode==13)getpack_creditNo();" onblur="getpack_creditNo();" index="17">
                    </font><font color="red">*</font><font face="宋体"> 
                    <input name=chk_pack_creditNo type=button onClick="getpack_creditNo();" class="b_text" style="cursor:hand" id="chk_pack_creditNo" value=校验>
                    </font> </TD>
                </TR>
                <TR    ID="tr_tempHide" style="display:none"> 
                  <TD nowrap   class=blue > 
                    <div align="left">营销包附加资费</div>
                  </TD>
                  <TD colspan="3" nowrap> 
                    <input class="button" name=pack_addifeeName readonly Class="InputGrey">
                  </TD>
                </TR>
                <TR    ID="tr_rentFeeMode" style="display:none"> 
                  <TD nowrap  class=blue  > 
                    <div align="left">附加资费方式</div>
                  </TD>
                  <TD colspan="3" nowrap> 
                    <SELECT ALIGN="left" NAME=rentFeeMode WIDTH=50 index="18" onchange="chgRentFee()">
                      <%
    //得到租机时的附加资费方式
 	/**
 	try
 	{
      		String sqlStr = "select trim(MODE_CODE), MODE_NAME from sBillModeCode where REGION_CODE='"+regionCode+"' AND MODE_TYPE='d' and rownum<500 order by MODE_CODE";
      		retArray = callView.view_spubqry32("2",sqlStr);
       		result = (String[][])retArray.get(0);
      		int recordNum = result.length;      		
      		for(int i=0;i<recordNum;i++){
        		out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
      		}
     	}catch(Exception e){
       		logger.error("Call sunView is Failed!");
     	}  
     	**/
     	  String sqlStr7 ="select trim(MODE_CODE), MODE_NAME from sBillModeCode where REGION_CODE='"+regionCode+"' AND MODE_TYPE='d' and rownum<500 order by MODE_CODE";
               %>
               <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode7" retmsg="retMsg7" outnum="2">
				<wtc:sql><%=sqlStr7%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="result7" scope="end" />
               <%
                if(!retCode7.equals("000000")){
                   out.println("<option class='button' value='99'></option>");
					%>
					   <script language="javascript">
					   	  rdShowMessageDialog("服务未能成功,服务代码:<%=retCode7%><br>服务信息:<%=retMsg7%>");
					   	  parent.removeTab('<%=opCode%>');
						</script>
					<%	
						}else{

       			 for(int i=0;i<result7.length;i++){
                        out.println("<option class='button' value='" + result7[i][0] + "'>" + result7[i][1] + "</option>");
                   }} 	        
%>
                    </select>
                  </TD>
                </TR>
                <TR  > 
                  <TD nowrap   class=blue > 
                    <div align="left">主资费</div>
                  </TD>
                  <TD nowrap  id="prompt2" > 
                    <input class="button" name=payWay readonly v_type=string v_must=1  Class="InputGrey">
                    <font color="red">*</font> 
                    <input class="b_text" name=selectMode onkeyup="if(event.keyCode==13){getMainBill()}" onmouseup="getMainBill()"  style="cursor:hand" type=button value=选择 index="19">
                    &nbsp; </TD>
                  <TD nowrap   class=blue > 
                    <div align="left">可选资费</div>
                  </TD>
                  <TD nowrap  id="prompt1" > 
                    <input class="button" name=additivePayWay readonly Class="InputGrey">
                    <input class="b_text" name=selectAdditive onkeyup="if(event.keyCode==13)getAdditiveBill()" onmouseup="getAdditiveBill()" style="cursor:hand" type=button value=选择  index="20" >
                    &nbsp; </TD>
                </TR>
                <TR  > 
                  <TD nowrap   class=blue >绑定附加资费</TD>
                  <TD nowrap colspan="3">
                    <input  name=bindModeName readonly Class="InputGrey">
                  </TD>
				
                </TR>
                <TR  > 
                  <TD nowrap   class=blue > 
                    <div align="left">特服订购</div>
                  </TD>
                  <TD nowrap colspan="3"> 
                    <input class="button" name=serviceResult readonly Class="InputGrey">&nbsp;<font color="red">*</font>&nbsp;<input class="b_text" name=selectFunc onkeyup="if(event.keyCode==13)serviceWay()" onmouseup="serviceWay()" style="cursor:hand" type=button value=特服选择 index="21"></TD>
                </TR>
                <TR  > 
                  <TD nowrap  class=blue  > 
                    <div align="left">用户ID</div>
                  </TD>
                  <TD nowrap  > 
                    <input class="button" v_must=1 v_name="用户ID" v_type="0_9" name=userID maxlength=22 readonly Class="InputGrey">
                    <font color="red">*</font> 
                    <input name=userIdQuery type=button  onclick ="getUserId()" class="b_text" style="cursor:hand" value=获得 index="22">
                  </TD>
                  <TD nowrap   class=blue > 
                    <div align="left">帐户ID</div>
                  </TD>
                  <TD nowrap  > 
                    <input class="button" v_must=1 v_name="帐户ID" v_type="0_9" name=accountID maxlength=22 readonly Class="InputGrey">
                    <font color="red">*</font> </TD>
                </TR>
				<TR  id ="divPassword" style="display:;">      
				   <jsp:include page="/npage/common/pwd_2.jsp">
					  <jsp:param name="width1" value=""  />
					  <jsp:param name="width2" value=""  />
					  <jsp:param name="pname" value="userPwd"  />
					  <jsp:param name="pcname" value="cfmuserPwd"  />
				   </jsp:include>
			   </TR>
				<!--
                <TR  > 
                  <TD nowrap  > 
                    <div align="left">用户密码</div>
                  </TD>
                  <TD nowrap  > 
                    <input class="button" type=password v_type="pwd"
	pwd2="cfmuserPwd" v_name="用户密码" v_must=0 v_maxlength=6 name=userPwd maxlength=6 index="23">
                  </TD>
                  <TD nowrap  > 
                    <div align="left">用户确认密码</div>
                  </TD>
                  <TD nowrap  > 
                    <input class="button" type=password v_must=0 v_maxlength=6 v_name="用户确认密码" name=cfmuserPwd maxlength=6 index="24">
                  </TD>
                </TR>
				-->
                <TR  > 
                  <TD nowrap  class=blue  > 
                    <div align="left">帐单寄送标志</div>
                  </TD>
                  <TD nowrap  > 
                    <input name="Nopost" type="radio" onclick="NopostStatus()" value="send" checked index="25">
                    不寄送 
                    <input type="radio" name="post" onclick="postStatus()" value="nosend" index="26">
                    寄送 </TD>
                  <TD nowrap   class=blue > 
                    <div align="left">出帐周期</div>
                  </TD>
                  <TD nowrap   > 
                    <select align="left" name=billType  index="27">
                      <%
    //得到输入参数帐户类型
 	/**
 	try
 	{
      		String sqlStr = "select trim(BILL_TYPE), BILL_UNIT from sBillType where REGION_CODE ='" + regionCode.substring(0,2) + "'";
      		retArray = callView.view_spubqry32("2",sqlStr);
       		result = (String[][])retArray.get(0);
      		int recordNum = result.length;      		
      		for(int i=0;i<recordNum;i++){
        		out.println("<option class='button' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
      		}
     	}catch(Exception e){
       		logger.error("Call sunView is Failed!");
     	}       
     	**/
     	
     	 String sqlStr8 ="select trim(BILL_TYPE), BILL_UNIT from sBillType where REGION_CODE ='" + regionCode.substring(0,2) + "'";
               %>
               <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode8" retmsg="retMsg8" outnum="2">
				<wtc:sql><%=sqlStr8%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="result8" scope="end" />
               <%
                if(!retCode8.equals("000000")){
                   out.println("<option class='button' value='99'></option>");
					%>
					   <script language="javascript">
					   	  rdShowMessageDialog("服务未能成功,服务代码:<%=retCode8%><br>服务信息:<%=retMsg8%>");
					   	  parent.removeTab('<%=opCode%>');
						</script>
					<%	
						}else{

       			 for(int i=0;i<result8.length;i++){
                        out.println("<option class='button' value='" + result8[i][0] + "'>" + result8[i][1] + "</option>");
                   }}
     	
     	
     	   
%>
                    </select>
                  </TD>
                </TR>
                </TBODY> 
              </TABLE>
        
              <TABLE id=tbPost0  cellSpacing="0" style="display:none">
                <TBODY> 
                <TR  > 
                  <TD  class=blue  nowrap  width=15%> 
                    <div align="left">邮寄类型</div>
                  </TD>
                  <TD  nowrap  width=35%> 
                    <select align="left" name=postType  index="28">
                      <option value="1" selected>邮寄帐单</option>
                      <!--<option value="2">Email</option> by wangdx 2009.7.8 139邮箱改造，此时用户无139邮箱所以无法申请电子账单-->
                      <option value="3">传真</option>
                    </select>
                  </TD>
                  <TD  class=blue  nowrap  width=15%> 
                    <div align="left">收件人</div>
                  </TD>
                  <TD  nowrap  width=35%> 
                    <input class="button" name=postName  maxlength=40 v_must=1  v_maxlength=40 index="29" disabled>
                    <font color="red">*</font> </TD>
                </TR>
                <TR  > 
                  <TD nowrap  class=blue  > 
                    <div align="left">传真</div>
                  </TD>
                  <TD nowrap  > 
                    <input class="button"  name=postFax maxlength=30 v_must=1 v_maxlength=30 v_name="传真" index="30" disabled>
                  </TD>
                  <TD nowrap  class=blue  > 
                    <div align="left">E_MAIL</div>
                  </TD>
                  <TD nowrap  > 
                    <input class="button" v_name="E_MAIL" name=postMail maxlength=30 v_must=1 v_maxlength=30  index="31" disabled>
                  </TD>
                </TR>
                <TR  > 
                  <TD   nowrap class=blue > 
                    <div align="left">邮寄地址</div>
                  </TD>
                  <TD nowrap  > 
                    <input class="button" name=postAdd   maxlength=30 v_must=0 v_maxlength=30 v_name="邮寄地址" index="32" disabled>
                  </TD>
                  <TD nowrap  > 
                    <div align="left" class=blue >邮寄编码</div>
                  </TD>
                  <TD nowrap  > 
                    <input class="button" name=postZip maxlength=10 v_must=0 v_maxlength=30 v_name="邮寄编码" index="33" disabled>
                  </TD>
                </TR>
                </TBODY> 
              </TABLE>

              <TABLE  cellSpacing="0">
                <TBODY> 
                <TR> 
                  <TD  nowrap class=blue   width=15%> 
                    <div align="left">担保人证件类型</div>
                  </TD>
                  <TD  nowrap   width=35%> 
                    <select align="left" name=assuIdType onchange="change_assuIdType()"  index="34">
                      <%
        //得到输入参数
     /**
        try
        {
                String sqlStr ="select trim(ID_TYPE), ID_NAME,ID_NAME from sIdType order by id_type";                      
                retArray = callView.view_spubqry32("3",sqlStr);
                 result = (String[][])retArray.get(0);
                int recordNum = result.length;                  
                for(int i=0;i<recordNum;i++){
                        out.println("<option class='button' value='" + result[i][0] + "|" + result[i][2] + "'>" + result[i][1] + "</option>");
                }
        }catch(Exception e){
                logger.error("Call sunView is Failed!");
        }     
        **/
         String sqlStr10 ="select trim(ID_TYPE), ID_NAME,ID_NAME from sIdType order by id_type";
         
               %>
               <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode10" retmsg="retMsg10" outnum="3">
				<wtc:sql><%=sqlStr10%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="result10" scope="end" />
               <%
                if(!retCode10.equals("000000")){
                   out.println("<option class='button' value='99'>99</option>");
					%>
					   <script language="javascript">
					   	  rdShowMessageDialog("服务未能成功,服务代码:<%=retCode10%><br>服务信息:<%=retMsg10%>");
					   	  parent.removeTab('<%=opCode%>');
						</script>
					<%	
						}else{

       			 for(int i=0;i<result10.length;i++){
                          out.println("<option class='button' value='" + result10[i][0] + "|" + result10[i][2] + "'>" + result10[i][1] + "</option>");
                   }}
                 
%>
                    </select>
                  </TD>
                  <TD  nowrap class=blue   width=15%> 
                    <div align="left">担保人证件号码</div>
                  </TD>
                  <TD  nowrap   width=35%> 
                    <input class="button" v_type="string" v_must=0  v_name="担保人证件号码"  name=assuId maxlength=20 onchange="change_assuIdType()" onkeyup="if(event.keyCode==13)assuInfoQuery();" index="35" >
                    <input class="b_text" name=assuQuery type=button onclick="assuInfoQuery()" style="cursor:hand" value="查询">
                  </TD>
                </TR>
                <TR  > 
                  <TD  class=blue  nowrap> 
                    <div align="left">担保人姓名</div>
                  </TD>
                  <TD  nowrap> 
                    <input class="button" name=assuName maxlength=60 index="36" v_must=0 v_maxlength=60 v_type="string" v_name="担保人姓名" >
                  </TD>
                  <TD nowrap   class=blue > 
                    <div align="left">担保人电话</div>
                  </TD>
                  <TD nowrap  > 
                    <input class="button" name=assuPhone maxlength=20 index="37" v_must=0 v_maxlength=20 v_type="phone" v_name="担保人电话">
                  </TD>
                </TR>
                <TR  > 
                  <TD nowrap    class=blue > 
                    <div align="left">担保人通信地址</div>
                  </TD>
                  <TD nowrap    > 
                    <input class="button"  name=assuAddr maxlength=60  index="38" v_must=0 v_maxlength=60 v_type="string" v_name="担保人通信地址">
                  </TD>
                  <TD nowrap     class=blue > 
                    <div align="left">担保人邮编</div>
                  </TD>
                  <TD nowrap    > 
                    <input class="button" name=assuZip maxlength=6 index="39"  v_must=0 v_maxlength=6 v_type="zip" v_name="担保人通信地址">
                  </TD>
                </TR>
                <TR  style="display:none"> 
				
                  <TD  nowrap > &nbsp;
                   <!-- <div align="left">手续费</div> -->
                  </TD>
				
                  <TD  nowrap> &nbsp;
                    <input class="button" type="hidden" v_type=money v_name="手续费" name=handFee value=0.00 maxlength=15 <%=HandFee_Favourable%> index="40" onkeyup="getTtFee()">
                  </TD>
				  
                  <TD  nowrap> &nbsp;
                   <!-- <div align="left">选号费</div> -->
                  </TD>
				 
                  <TD  nowrap> &nbsp;
                    <input class="button" type="hidden" v_type=money v_name="选号费" name=choiceFee value=0.00 maxlength=15 <%=No_Favourable%> index="41" onkeyup="getTtFee()">
                  </TD>
                </TR>
                <TR> 
                  <TD nowrap   class=blue > 
                    <div align="left">SIM卡费</div>
                  </TD>
                  <TD nowrap> 
                  <input id="ins" class="button" v_type=money v_name="SIM卡费" name=simFee value=0.00  <%=Sim_Favourable%> index="42" onkeyup="getTtFee()" onblur="if(this.value!=''){if(checkElement(document.all.simFee)==false){return false;}}">
                   <input type="hidden" name="xyd_bz" value="<%=xyd_bz%>">
                  </TD>
                  <TD nowrap  class=blue  > 
                    <div align="left">机器费</div>
                  </TD>
                  <TD nowrap  > 
                    <input class="button" v_type=money v_name="机器费" name=machFee value=0.00  maxlength=15 <%=Mach_Favourable%> index="43" onkeyup="getTtFee()" onblur="if(this.value!=''){if(checkElement(document.all.machFee)==false){return false;}}">
                  </TD>
                </TR>
                <TR  > 
				
                  <!--
				  <TD nowrap  > 
                     <div align="left">入网费</div> 
                  </TD>
				  -->
				    <td nowrap   class=blue >
					<div align="left">信誉度</div>
					</td>
				  <td nowrap  >
				  	<input  name= "xinYiDu" type="text" v_type="int" v_must=1 maxlength="6" value="0" onblur="checkElement(this)"  readonly>
                    <font color="red">*</font>				  </td>
				<!--
                  <TD nowrap  > 
                    <input class="button" type="hidden" v_type=money v_name="入网费" name=innetFee value=0.00 maxlength=15 readonly>
                  </TD>
				  -->
                  <TD nowrap   class=blue > 
                    <div align="left">入网预存费</div>
                  </TD>
                  <TD nowrap  > 
                    <input class="button" v_type=money v_name="入网预存费" name=innetPreFee value="0.00" maxlength=15  onkeyup="getTtFee()" onblur="if(this.value!=''){if(checkElement(document.all.innetPreFee)==false){return false;}}" <%=Innet_Favourable%> index="44">
                  </TD>
                </TR>

				<TR   id="innet_czkye" style="display:none"> 
                  <TD   nowrap   class=blue > 
                    <div align="left">储值卡余额</div>
                  </TD>
                  <TD   nowrap  > 
                    <input class="button"  name=czkye >
                  </TD>
				  <td></td><td></td>
                </TR>

                <TR  > 
                  <TD nowrap   class=blue > 
                    <div align="left">开户预存费</div>
                  </TD>
                  <TD nowrap  > 
                    <input class="button" v_type=money v_name="选号预存费" name=choicePreFee value=0.00 maxlength=15 <%=Choice_prepay%> >
                  </TD>
                  <TD nowrap   class=blue > 
                    <div align="left">特服预存费</div>
                  </TD>
                  <TD nowrap  > 
                    <input class="button" v_type=money v_name="特服预存费" name=espPreFee value=0.00 maxlength=15 readonly onkeyup="getTtFee()" index="45" Class="InputGrey">
                  </TD>
                </TR>
                <TR  > 
                  <TD nowrap   class=blue > 
                    <div align="left">预存款</div>
                  </TD>
                  <TD nowrap  > 
                    <input class="button" v_type=money v_name="预存款" name=prepayFee value=0.00 maxlength=15 readonly Class="InputGrey">
                  </TD>
                  <TD  nowrap class=blue > 
                    <div align="left">应交金额</div>
                  </TD>
                  <TD  nowrap> 
                    <input class="button" name=sumPay v_account=total value=0  readonly Class="InputGrey">
                  </TD>
                </TR>
                <TR   > 
                  <TD nowrap   class=blue > 
                    <div align="left">现金交款</div>
                  </TD>
                  <TD nowrap  > 
                    <input class="button" v_must=1  v_type=money v_account=subentry name=cashPay value=0.00 maxlength=15 index="46" onkeyup="getpreFee()" onblur="checkElement(this)">
                    <font color="red">*</font> </TD>
                  <TD nowrap   class=blue > 
                    <div align="left">计费时间</div>
                  </TD>
                  <TD nowrap  > 
                    <input class="button" v_must=0 v_name="计费时间" name=favourableTime v_type="date_time" value="<%=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new Date())%>" maxlength=20 index="47">
                  </TD>
                </TR>

				<TR   > 
                  <TD nowrap   class=blue > 
                    <div align="left">是否短信关注</div>
                  </TD>
                  <TD nowrap  > 
                  <select name ="is_sms_call">
				  <option class='button' value='Y' >是</option>
				  <option class='button' value='N' selected>否</option>
				  </select>
				  </TD>
          <TD  nowrap   class=blue >
				  	<div align="left">入网有礼活动</div>
				  	<input type="hidden" name="goodphone">
				  </TD>
          <TD  nowrap  >
				  	<select name ="is_not_adward"  onchange="isnotawardhange()">
				 		 <option class='button' value='Y' >是</option>
				  	<option class='button' value='N' selected>否</option>
				  	</select>
				  </TD>
		
         </TR>

                <TR  > 
                  <TD nowrap   class=blue > 
                    <div align="left">交款方式</div>
                  </TD>
                  <TD nowrap  > 
                    <input name="checkRadio" type="radio" onclick="checkWay()" value="check"  index="48">
                    支票交款 
                    <input type="radio" name="NocheckRadio" onClick="NocheckWay()" value="nocheck" checked index="49">
                    非支票交款 </TD>
			          
			          <TD  nowrap   class=blue >
							  	<div align="left">免费体验彩铃</div>
							  	<input type="hidden" name="cailing">
							  </TD>
			          <TD  nowrap  >
							  	<select name ="has_cailing" >
							  	<!--<option class='button' value='Y' >是</option>-->
							  	<option class='button' value='N' selected>否</option>
							  	</select>
							  </TD>
                </TR>

						<!-- 王良 2007年10月18日 增加 R_HLJMob_cuisr_CRM_PD3_2007_330@关于开发入网赠送充值卡业务的需求.xls-->					
						<TR   id = "id_largess_card" > 
					  	<TD nowrap class=blue  width=15%> 
					    	<div align="left">赠送充值卡</div>
					    </TD>
							<TD nowrap  colspan="3"> 
								<select name ="largess_card" onchange="changelargesscard()">
								<option class='button' value='Y' >是</option>
								<option class='button' value='N' selected>否</option>
								</select>
							</TD>
						</TR>
                </TBODY> 
              </TABLE>

              <TABLE id=check0  cellSpacing="0" style="display:none">
                <TBODY> 
                <TR > 
                  <TD  nowrap class=blue   width=15%> 
                    <div align="left">支票号码</div>
                  </TD>
                  <TD  nowrap   width=35%> 
                    <input class="button" v_must=0 v_name="支票号码" v_type="0_9" name=checkNo maxlength=20 onkeyup="if(event.keyCode==13)getBankCode();" index="50">
                    <font color="red">*</font>
<input name=bankCodeQuery type=button class="b_text" style="cursor:hand" onClick="getBankCode()" value=查询>
            </TD>
                  <TD nowrap class=blue   width=15%> 
                    <div align="left">银行代码</div>
                  </TD>
                  <TD  nowrap   width=35%> 
                    <input name=bankCode  class="button" maxlength="12" readonly Class="InputGrey" size="8">
				<input name=bankName  class="button" readonly Class="InputGrey">
                  </TD>                                              
            </TR>
           </TBODY>
         </TABLE>
         <TABLE id=chPayNum0  cellSpacing="0" style="display:none">
          <TBODY> 
            <TR> 
                  <TD  nowrap class=blue width="15%"> 
                    <div align="left">支票交款</div>
                  </TD>
            <TD  width="35%">
              	    <input class="button" v_must=1 v_type=money v_account=subentry name=checkPay value=0.00 maxlength=15 onkeyup="getpreFee()" index="51" onblur="checkElement(this)">
                    <font color="red">*</font> </TD> 
                  <TD  class=blue width="15%"> 
                    <div align="left">支票余额</div>
                  </TD>
                  <TD  width="35%"> 
                    <input class="button" name="checkPrePay" value=0.00 readonly Class="InputGrey">
                  </TD>               
            </TR>            
          </TBODY>
        </TABLE>
        
              <TABLE  cellSpacing="0">
                <TBODY> 
                <TR> 
                  
                  <TD> 
                    <input class="b_text" name=sumParCount type=button onkeyup="if(event.keyCode==13)feeCount();"  onmouseup="feeCount();" value=交款计算 disabled index="52">
                  </TD>
                </TR>
                </TBODY> 
              </TABLE>

              <TABLE  cellSpacing="0">
                <TBODY> 
                <TR  > 
                  <TD  class=blue width=15%> 
                    <div align="left">系统备注</div>
                  </TD>
                  <TD width=85%> 
                    <input class="button" name=sysNote  readonly maxlength="30" Class="InputGrey">
                  </TD>
                </TR>
                <TR> 
                  <TD  class=blue > 
                    <div align="left">用户备注</div>
                  </TD>
                  <TD> 
                    <input name=opNote class="button"  maxlength="60"  index="53" v_must=0 v_maxlength=60 v_type="string" v_name="用户备注">
                  </TD>
                </TR>
                </TBODY> 
              </TABLE>
                        
        <TABLE  cellSpacing="0">
          <TBODY>
            <TR  > 
              <TD align=center  id="footer">
				    <input class="b_foot" name=print  onmouseup="comm()" onkeyup="if(event.keyCode==13)comm()" type=button value=确认&打印 disabled index="54">

				    <input class="b_foot" name=reset1 type=button onclick="frm1104.reset();" onmouseup="clearnew()" value=清除 index="55">
                 
				    <input class="b_foot" name=back onclick="parent.removeTab('<%=opCode%>')" type=button value=关闭 index="56">
                 
            <!--input type="button" value="test" onclick="promtFrame('222');"-->
                    &nbsp;    
                  </TD>
            </TR>
          </TBODY>
        </TABLE>

  <!------------------------>
  <input type="hidden" id=in1 name="hidPwd" v_name="原始密码" value="~!@">
  <input type="hidden" name=hidUserPwd >	<!--隐藏界面用户的加密密码-->
  <input type="hidden" name="workno" value="<%=workNo%>">
  <input type="hidden" name="ip_Addr" value="<%=ip_Addr%>">
  <input type="hidden" id=in6 name="belongCode" value="<%=belongCode%>">
  <input type="hidden" name="regionCode" value="<%=regionCode%>">
  <input type="hidden" name="groupId" value="<%=groupId%>">
  <input type="hidden" name="op_code" value="<%=op_code %>">
  <input type="hidden" name= "org_Code" value="<%=orgCode%>">
  <input type="hidden" name="workName" value=<%=workName%> >
  <input type="hidden" name="operType" >    		<!--业务类型-->
  <input type="hidden" name="upBillType" >    		<!--帐务类型-->
  <input type="hidden" name="postFlag" >    		<!--帐单寄送标志---->
  <input type="hidden" name="payCode" >     		<!--资费代码---->
  <input type="hidden" name="additiveCode" value="">     	<!--可选资费代码---->
  <input type="hidden" name="rentpayCode" value="">	<!--租机时的附加资费代码---->
  <input type="hidden" name="serviceCode" >     	<!--特服代码---->
  <input type="hidden" name="serviceNow" >			<!--立即生效特服---->
  <input type="hidden" name="serviceAfter" >		<!--预约生效特服---->
  <input type="hidden" name="serviceAddNo" >		<!--附加号码特服---->
  <input type="hidden" name="sysAccept" value="">
  <input type="hidden" name="getlike">			<!--系统流水号---->  
  <input type="hidden" name="printInfo" >			<!--打印信息----> 
  <input type="hidden" name="hidSmCode" >			<!--业务代码----> 
  <input type="hidden" name="hidEInfo"> 		    <!--随e行信息-->
  <input type="hidden" name="smallestPrepay"> 		    <!--好号的最小预存-->
 
  <input type="hidden" name="modedxpay">
  <input id="ins1" type="hidden" name="simpre">
  <input name="cardstatus" type=hidden value="">

  <input type="hidden" name="hidMachineType" value="s"> 	    <!--入网机器类型-->
    
  <input type="hidden" name= "hid_HandFee" value=0.00>
  <input type="hidden" name= "hid_ChoiceFee" value=0.00>
  <input type="hidden" name= "hid_MachFee" value=0.00>
  <input type="hidden" name= "hid_SimFee" value=0.00>
  <input type="hidden" name= "hid_choicePreFee" value=0.00>
  <input type="hidden" name= "hid_innetFee" value=0.00>
  <input type="hidden" name= "tfFlag" value="n">
  
  <input type="hidden" name= "hid_innetPreFee" value=0.00>
  <input type="hidden" name= "hid_favourableTime" value="<%=sys_Date%>">
  <input type="hidden" name= "largess_card_sum" value="<%=strCardSum%>"> <!-- 入网赠送充值卡的数量级-->
  <input type="hidden" name= "hid_checkRes" value="0">    <!--资源校验状态标志  0：未校验；1：已校验-->
  <input type="hidden" name="hid_countFlag" value="0">    <!--费用计算标志-->
  <input type="hidden" name="nopass" value="111111">
  <input type="hidden" name="checkPwd_Flag" value="false">		<!--密码校验标志-->
  <input type="hidden" name="hid_CredId" value="">		<!--密码校验标志-->
  <input id='in7' type="hidden" name="contactPhone" value="">
   <input id='in9' type="hidden" name="in9" value="">
  <input name="selectModeFlag" type="hidden" value="" >	<!--主资费方式可否改变的标志-->
  <input class="button" type="hidden" name=innetFee >
  
    <input type="hidden" name="regionFlg" value="<%=regionCode%>">
  <input type="hidden" name="regionFlg1" value="1">
  
  <input type="hidden" name="str1" value=" ">
  <input type="hidden" name="str2" value=" ">
  <input type="hidden" name="str3" value=" ">
  <input type="hidden" name="str4" value=" ">
  <input type="hidden" name="str5" value=" ">
  <input type="hidden" name="str6" value="N"> 
  
  <input type="hidden" name="bindModeCode" value="">
  <input type="hidden" name="phoneTime" value="<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>">
  <input type="hidden" name="advNote" value="">
  <input type="hidden" name="detailcode" value="">
  <input type="hidden" name="add_detail" value="">
  <input type="hidden" name="add_detail2" value="">
 <input type="hidden" name="adddetailcode" value="">
 <input type="hidden" name="adddetailcodenote" value="">
 <input type="hidden" name="re_funcstr" value="">
 <input type="hidden" name="mode_note" value="">
 <input type="hidden" name="haseval">
 <input type="hidden" name="evalcode">

  <!------------------------>

  <select type="hidden" align="left" name=gnInnetCode style="display:none">
<%
    //得到全球通入网代码
 /**
 	try
 	{
      		String sqlStr = 
			  "select trim(b.INLAND_TOLL)||'-'||b.INNET_FEE||'-'||b.INNET_PREPAY||'-',"
             +" b.INNET_NAME,b.MODE_CODE,trim(c.MODE_NAME),"
             +" sum(to_number(nvl(a.choiced_flag, '0'))),"
             +"b.INLAND_TOLL, b.innet_name"
             +" from cBillBaDepend a, sInnetCode  b, sbillmodecode c "
             +"where a.region_code(+) = b.region_code "
             //+" and to_number(c.power_right)<to_number("+powerRight+")"
             +" and a.mode_code (+)= b.mode_code "
             +" and b.region_code = c.region_code "
             +" and b.mode_code = c.mode_code "
             +" and b.region_code = '"+regionCode+"'"
             +" and b.sm_code = 'gn'"
			 +" and b.sm_code = c.sm_code"
			 +" and c.start_time<=sysdate and c.stop_time>sysdate"
			 +" and c.select_flag='0'"
             +" and c.mode_flag = '0'"
             +" and c.mode_type not in ('Yn20','Yn40')"
			 +" and c.region_code||c.mode_code not in(select substr(group_id,1,2)||mode_code from sbillmoderelease)"
             +" group by b.INLAND_TOLL,b.innet_name, b.mode_code, "
             +"c.MODE_NAME,trim(b.INLAND_TOLL)||'-'||b.INNET_FEE||'-'||b.INNET_PREPAY||'-',"
             +" b.INNET_NAME,b.MODE_CODE,trim(c.MODE_NAME)"
             +" order by b.INLAND_TOLL,b.innet_name, b.mode_code, "
             +"c.MODE_NAME,trim(b.INLAND_TOLL)||'-'||b.INNET_FEE||'-'||b.INNET_PREPAY||'-',"
             +" b.INNET_NAME,b.MODE_CODE,trim(c.MODE_NAME)";

      		retArray = callView.view_spubqry32("7",sqlStr);
      		System.out.println("mxsql-----------------"+sqlStr);
			result = (String[][])retArray.get(0);
      		int recordNum = result.length;      		
      		for(int i=0;i<recordNum;i++){
        	  out.println("<option class='button' mainCode='"+result[i][2]+"' mainName='"+result[i][3]+"' subCount='"+result[i][4].trim()+"' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
      		}
     	}catch(Exception e){
       		logger.error("Call sunView is Failed!");
     	}   
     	**/       
     	
     	String sqlStr11 = 
			  "select trim(b.INLAND_TOLL)||'-'||b.INNET_FEE||'-'||b.INNET_PREPAY||'-',"
             +" b.INNET_NAME,b.MODE_CODE,trim(c.MODE_NAME),"
             +" sum(to_number(nvl(a.choiced_flag, '0'))),"
             +"b.INLAND_TOLL, b.innet_name"
             +" from cBillBaDepend a, sInnetCode  b, sbillmodecode c "
             +"where a.region_code(+) = b.region_code "
             //+" and to_number(c.power_right)<to_number("+powerRight+")"
             +" and a.mode_code (+)= b.mode_code "
             +" and b.region_code = c.region_code "
             +" and b.mode_code = c.mode_code "
             +" and b.region_code = '"+regionCode+"'"
             +" and b.sm_code = 'gn'"
			 +" and b.sm_code = c.sm_code"
			 +" and c.start_time<=sysdate and c.stop_time>sysdate"
			 +" and c.select_flag='0'"
             +" and c.mode_flag = '0'"
             +" and c.mode_type not in ('Yn20','Yn40')"
			 +" and c.region_code||c.mode_code not in(select substr(group_id,1,2)||mode_code from sbillmoderelease)"
             +" group by b.INLAND_TOLL,b.innet_name, b.mode_code, "
             +"c.MODE_NAME,trim(b.INLAND_TOLL)||'-'||b.INNET_FEE||'-'||b.INNET_PREPAY||'-',"
             +" b.INNET_NAME,b.MODE_CODE,trim(c.MODE_NAME)"
             +" order by b.INLAND_TOLL,b.innet_name, b.mode_code, "
             +"c.MODE_NAME,trim(b.INLAND_TOLL)||'-'||b.INNET_FEE||'-'||b.INNET_PREPAY||'-',"
             +" b.INNET_NAME,b.MODE_CODE,trim(c.MODE_NAME)";
             
             System.out.println("全球通入网代码  sqlStr11===="+sqlStr11);
               %>
               <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode11" retmsg="retMsg11" outnum="7">
				<wtc:sql><%=sqlStr11%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="result11" scope="end" />
               <%
                if(!retCode11.equals("000000")){
                   out.println("<option class='button' value='99'></option>");
					%>
					   <script language="javascript">
					   	  rdShowMessageDialog("服务未能成功,服务代码:<%=retCode11%><br>服务信息:<%=retMsg11%>");
					   	  parent.removeTab('<%=opCode%>');
						</script>
					<%	
						}else{
       			 for(int i=0;i<result11.length;i++){
                         	  out.println("<option class='button' mainCode='"+result11[i][2]+"' mainName='"+result11[i][3]+"' subCount='"+result11[i][4].trim()+"' value='" + result11[i][0] + "'>" + result11[i][1] + "</option>");
                   }}
     	
     	
     	
%>
  </select> 
  <select type="hidden" align="left" name=dnInnetCode style="display:none">
<%
    //得到动感地带入网代码
 /**	try
 	{
      		String sqlStr = 
			  "select trim(b.INLAND_TOLL)||'-'||b.INNET_FEE||'-'||b.INNET_PREPAY||'-',"
             +"b.INNET_NAME,b.MODE_CODE,trim(c.MODE_NAME),"
             +" sum(to_number(nvl(a.choiced_flag, '0'))),"
             +"b.INLAND_TOLL, b.innet_name"
             +" from cBillBaDepend a, sInnetCode  b, sbillmodecode c "
             +"where a.region_code(+) = b.region_code "
             +" and a.mode_code (+)= b.mode_code"
             +" and b.region_code = c.region_code"
             //+" and to_number(c.power_right)<to_number("+powerRight+")"
             +" and b.mode_code = c.mode_code "
             +" and b.region_code = '"+regionCode+"'"
             +" and b.sm_code = 'dn'"
			 +" and b.sm_code = c.sm_code"
			 +" and c.start_time<=sysdate and c.stop_time>sysdate"
			 +" and c.select_flag='0'"
             +" and c.mode_flag = '0'"
             +" and c.mode_type not in ('Yn20','Yn40')"
			 +" and c.region_code||c.mode_code not in(select substr(group_id,1,2)||mode_code from sbillmoderelease)"
             +" group by b.INLAND_TOLL,b.innet_name, b.mode_code, "
             +"c.MODE_NAME,trim(b.INLAND_TOLL)||'-'||b.INNET_FEE||'-'||b.INNET_PREPAY||'-',"
             +" b.INNET_NAME,b.MODE_CODE,trim(c.MODE_NAME)"
             +" order by b.INLAND_TOLL,b.innet_name, b.mode_code, "
             +"c.MODE_NAME,trim(b.INLAND_TOLL)||'-'||b.INNET_FEE||'-'||b.INNET_PREPAY||'-',"
             +" b.INNET_NAME,b.MODE_CODE,trim(c.MODE_NAME)";
			 
			retArray = callView.view_spubqry32("7",sqlStr);
      		result = (String[][])retArray.get(0);
      		int recordNum = result.length;
			
      		for(int i=0;i<recordNum;i++){				
        		out.println("<option class='button'  mainCode='"+result[i][2]+"' mainName='"+result[i][3]+"' subCount='"+result[i][4].trim()+"' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
      		}
     	}catch(Exception e){
       		logger.error("Call sunView is Failed!");
     	}   **/       
     	
     	
      		String sqlStr12 = 
			  "select trim(b.INLAND_TOLL)||'-'||b.INNET_FEE||'-'||b.INNET_PREPAY||'-',"
             +"b.INNET_NAME,b.MODE_CODE,trim(c.MODE_NAME),"
             +" sum(to_number(nvl(a.choiced_flag, '0'))),"
             +"b.INLAND_TOLL, b.innet_name"
             +" from cBillBaDepend a, sInnetCode  b, sbillmodecode c "
             +"where a.region_code(+) = b.region_code "
             +" and a.mode_code (+)= b.mode_code"
             +" and b.region_code = c.region_code"
             //+" and to_number(c.power_right)<to_number("+powerRight+")"
             +" and b.mode_code = c.mode_code "
             +" and b.region_code = '"+regionCode+"'"
             +" and b.sm_code = 'dn'"
			 +" and b.sm_code = c.sm_code"
			 +" and c.start_time<=sysdate and c.stop_time>sysdate"
			 +" and c.select_flag='0'"
             +" and c.mode_flag = '0'"
             +" and c.mode_type not in ('Yn20','Yn40')"
			 +" and c.region_code||c.mode_code not in(select substr(group_id,1,2)||mode_code from sbillmoderelease)"
             +" group by b.INLAND_TOLL,b.innet_name, b.mode_code, "
             +"c.MODE_NAME,trim(b.INLAND_TOLL)||'-'||b.INNET_FEE||'-'||b.INNET_PREPAY||'-',"
             +" b.INNET_NAME,b.MODE_CODE,trim(c.MODE_NAME)"
             +" order by b.INLAND_TOLL,b.innet_name, b.mode_code, "
             +"c.MODE_NAME,trim(b.INLAND_TOLL)||'-'||b.INNET_FEE||'-'||b.INNET_PREPAY||'-',"
             +" b.INNET_NAME,b.MODE_CODE,trim(c.MODE_NAME)";
             
             System.out.println("动感地带入网代码  sqlStr12===="+sqlStr12);
               %>
               <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode12" retmsg="retMsg12" outnum="7">
				<wtc:sql><%=sqlStr12%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="result12" scope="end" />
               <%
                if(!retCode12.equals("000000")){
                   out.println("<option class='button' value='99'></option>");
					%>
					   <script language="javascript">
					   	  rdShowMessageDialog("服务未能成功,服务代码:<%=retCode12%><br>服务信息:<%=retMsg12%>");
					   	  parent.removeTab('<%=opCode%>');
						</script>
					<%	
						}else{
       			 for(int i=0;i<result12.length;i++){
                         	 out.println("<option class='button'  mainCode='"+result12[i][2]+"' mainName='"+result12[i][3]+"' subCount='"+result12[i][4].trim()+"' value='" + result12[i][0] + "'>" + result12[i][1] + "</option>");
                   }
                   }
%>
  </select>  
  <select type="hidden" align="left" name=d0InnetCode style="display:none">
<%
    //得到数据卡入网代码
 /**
 	try
 	{
      		String sqlStr = 
			  "select trim(b.INLAND_TOLL)||'-'||b.INNET_FEE||'-'||b.INNET_PREPAY||'-',"
             +" b.INNET_NAME,b.MODE_CODE,trim(c.MODE_NAME),"
             +" sum(to_number(nvl(a.choiced_flag, '0'))),"
             +"b.INLAND_TOLL, b.innet_name"
             +" from cBillBaDepend a, sInnetCode  b, sbillmodecode c "
             +"where a.region_code(+) = b.region_code "
             //+" and to_number(c.power_right)<to_number("+powerRight+")"
             +" and a.mode_code (+)= b.mode_code"
             +" and b.region_code = c.region_code"
             +" and b.mode_code = c.mode_code "
             +" and b.region_code = '"+regionCode+"'"
             +" and b.sm_code = 'd0'" 
             +" and b.sm_code = c.sm_code" 
			 +" and c.start_time<=sysdate and c.stop_time>sysdate"
			 +" and c.select_flag='0'"
             +" and c.mode_flag = '0'"
             +" and c.mode_type not in ('Yn20','Yn40')"
			 +" and c.region_code||c.mode_code not in(select substr(group_id,1,2)||mode_code from sbillmoderelease)"
             +" group by b.INLAND_TOLL,b.innet_name, b.mode_code, "
             +"c.MODE_NAME,trim(b.INLAND_TOLL)||'-'||b.INNET_FEE||'-'||b.INNET_PREPAY||'-',"
             +" b.INNET_NAME,b.MODE_CODE,trim(c.MODE_NAME)"
             +" order by b.INLAND_TOLL,b.innet_name, b.mode_code, "
             +"c.MODE_NAME,trim(b.INLAND_TOLL)||'-'||b.INNET_FEE||'-'||b.INNET_PREPAY||'-',"
             +" b.INNET_NAME,b.MODE_CODE,trim(c.MODE_NAME)";
			 
      		retArray = callView.view_spubqry32("7",sqlStr);
      		result = (String[][])retArray.get(0);
      		int recordNum = result.length;      		
      		for(int i=0;i<recordNum;i++){
        	  out.println("<option class='button'  mainCode='"+result[i][2]+"' mainName='"+result[i][3]+"' subCount='"+result[i][4].trim()+"' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
      		}
     	}catch(Exception e){
       		logger.error("Call sunView is Failed!");
     	}          **/
     	
     	 String sqlStr13 = "select trim(b.INLAND_TOLL)||'-'||b.INNET_FEE||'-'||b.INNET_PREPAY||'-',"
             +" b.INNET_NAME,b.MODE_CODE,trim(c.MODE_NAME),"
             +" sum(to_number(nvl(a.choiced_flag, '0'))),"
             +"b.INLAND_TOLL, b.innet_name"
             +" from cBillBaDepend a, sInnetCode  b, sbillmodecode c "
             +"where a.region_code(+) = b.region_code "
             //+" and to_number(c.power_right)<to_number("+powerRight+")"
             +" and a.mode_code (+)= b.mode_code"
             +" and b.region_code = c.region_code"
             +" and b.mode_code = c.mode_code "
             +" and b.region_code = '"+regionCode+"'"
             +" and b.sm_code = 'd0'" 
             +" and b.sm_code = c.sm_code" 
			 +" and c.start_time<=sysdate and c.stop_time>sysdate"
			 +" and c.select_flag='0'"
             +" and c.mode_flag = '0'"
             +" and c.mode_type not in ('Yn20','Yn40')"
			 +" and c.region_code||c.mode_code not in(select substr(group_id,1,2)||mode_code from sbillmoderelease)"
             +" group by b.INLAND_TOLL,b.innet_name, b.mode_code, "
             +"c.MODE_NAME,trim(b.INLAND_TOLL)||'-'||b.INNET_FEE||'-'||b.INNET_PREPAY||'-',"
             +" b.INNET_NAME,b.MODE_CODE,trim(c.MODE_NAME)"
             +" order by b.INLAND_TOLL,b.innet_name, b.mode_code, "
             +"c.MODE_NAME,trim(b.INLAND_TOLL)||'-'||b.INNET_FEE||'-'||b.INNET_PREPAY||'-',"
             +" b.INNET_NAME,b.MODE_CODE,trim(c.MODE_NAME)";
             
              System.out.println("数据卡入网代码  sqlStr13===="+sqlStr13);
               %>
               <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode13" retmsg="retMsg13" outnum="2">
				<wtc:sql><%=sqlStr13%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="result13" scope="end" />
               <%
                if(!retCode13.equals("000000")){
                   out.println("<option class='button' value='99'></option>");
					%>
					   <script language="javascript">
					   	  rdShowMessageDialog("服务未能成功,服务代码:<%=retCode13%><br>服务信息:<%=retMsg13%>");
					   	  parent.removeTab('<%=opCode%>');
						</script>
					<%	
						}else{
       			 for(int i=0;i<result13.length;i++){
                    out.println("<option class='button'  mainCode='"+result13[i][2]+"' mainName='"+result13[i][3]+"' subCount='"+result13[i][4].trim()+"' value='" + result13[i][0] + "'>" + result13[i][1] + "</option>");
                   }}
%>
  </select>   
  <select type="hidden" align="left" name=hnInnetCode style="display:none">
<%
    //得到省内套餐入网代码
 	/**try
 	{
      		String sqlStr = 
			  "select trim(b.INLAND_TOLL)||'-'||b.INNET_FEE||'-'||b.INNET_PREPAY||'-',"
             +" b.INNET_NAME,b.MODE_CODE,trim(c.MODE_NAME),"
             +" sum(to_number(nvl(a.choiced_flag, '0'))),"
             +"b.INLAND_TOLL, b.innet_name"
             +" from cBillBaDepend a, sInnetCode  b, sbillmodecode c "
             +"where a.region_code(+) = b.region_code "
             //+" and to_number(c.power_right)<to_number("+powerRight+")"
             +" and a.mode_code (+)= b.mode_code"
             +" and b.region_code = c.region_code"
             +" and b.mode_code = c.mode_code "
             +" and b.region_code = '"+regionCode+"'"
             +" and b.sm_code = 'zn'" 
             +" and b.sm_code = c.sm_code" 
			 +" and c.start_time<=sysdate and c.stop_time>sysdate"
			 +" and c.select_flag='0'"
             +" and c.mode_flag = '0'"
             +" and c.mode_type not in ('Yn20','Yn40')"
			 +" and c.region_code||c.mode_code not in(select substr(group_id,1,2)||mode_code from sbillmoderelease)"
             +" group by b.INLAND_TOLL,b.innet_name, b.mode_code, "
             +"c.MODE_NAME,trim(b.INLAND_TOLL)||'-'||b.INNET_FEE||'-'||b.INNET_PREPAY||'-',"
             +" b.INNET_NAME,b.MODE_CODE,trim(c.MODE_NAME)"
             +" order by b.INLAND_TOLL,b.innet_name, b.mode_code, "
             +"c.MODE_NAME,trim(b.INLAND_TOLL)||'-'||b.INNET_FEE||'-'||b.INNET_PREPAY||'-',"
             +" b.INNET_NAME,b.MODE_CODE,trim(c.MODE_NAME)";
			 
      		retArray = callView.view_spubqry32("7",sqlStr);
      		result = (String[][])retArray.get(0);
      		int recordNum = result.length;      		
      		for(int i=0;i<recordNum;i++){
        	  out.println("<option class='button'  mainCode='"+result[i][2]+"' mainName='"+result[i][3]+"' subCount='"+result[i][4].trim()+"' value='" + result[i][0] + "'>" + result[i][1] + "</option>");
      		}
     	}catch(Exception e){
       		logger.error("Call sunView is Failed!");
     	}**/        
     	
     	 String sqlStr14 =  "select trim(b.INLAND_TOLL)||'-'||b.INNET_FEE||'-'||b.INNET_PREPAY||'-',"
             +" b.INNET_NAME,b.MODE_CODE,trim(c.MODE_NAME),"
             +" sum(to_number(nvl(a.choiced_flag, '0'))),"
             +"b.INLAND_TOLL, b.innet_name"
             +" from cBillBaDepend a, sInnetCode  b, sbillmodecode c "
             +"where a.region_code(+) = b.region_code "
             //+" and to_number(c.power_right)<to_number("+powerRight+")"
             +" and a.mode_code (+)= b.mode_code"
             +" and b.region_code = c.region_code"
             +" and b.mode_code = c.mode_code "
             +" and b.region_code = '"+regionCode+"'"
             +" and b.sm_code = 'zn'" 
             +" and b.sm_code = c.sm_code" 
			 +" and c.start_time<=sysdate and c.stop_time>sysdate"
			 +" and c.select_flag='0'"
             +" and c.mode_flag = '0'"
             +" and c.mode_type not in ('Yn20','Yn40')"
			 +" and c.region_code||c.mode_code not in(select substr(group_id,1,2)||mode_code from sbillmoderelease)"
             +" group by b.INLAND_TOLL,b.innet_name, b.mode_code, "
             +"c.MODE_NAME,trim(b.INLAND_TOLL)||'-'||b.INNET_FEE||'-'||b.INNET_PREPAY||'-',"
             +" b.INNET_NAME,b.MODE_CODE,trim(c.MODE_NAME)"
             +" order by b.INLAND_TOLL,b.innet_name, b.mode_code, "
             +"c.MODE_NAME,trim(b.INLAND_TOLL)||'-'||b.INNET_FEE||'-'||b.INNET_PREPAY||'-',"
             +" b.INNET_NAME,b.MODE_CODE,trim(c.MODE_NAME)";
             
               
              System.out.println("省内套餐入网代码  sqlStr14===="+sqlStr14);
               %>
               <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode14" retmsg="retMsg14" outnum="7">
				<wtc:sql><%=sqlStr14%></wtc:sql>
				</wtc:pubselect>
				<wtc:array id="result14" scope="end" />
               <%
                if(!retCode14.equals("000000")){
                   out.println("<option class='button' value='99'></option>");
					%>
					   <script language="javascript">
					   	  rdShowMessageDialog("服务未能成功,服务代码:<%=retCode14%><br>服务信息:<%=retMsg14%>");
					   	  parent.removeTab('<%=opCode%>');
						</script>
					<%	
				 }else{

       			 for(int i=0;i<result14.length;i++){
       			         System.out.println("result14[i][1]=="+result14[i][1]);
                         out.println("<option class='button'  mainCode='"+result14[i][2]+"' mainName='"+result14[i][3]+"' subCount='"+result14[i][4].trim()+"' value='" + result14[i][0] + "'>" + result14[i][1] + "</option>");
                   }}
     	
     	  
%>
  </select>   

  <%@ include file="/npage/include/footer.jsp" %> 
   
  <jsp:include page="/npage/common/pwd_comm.jsp"/>
</form>
  <frameset rows="0,0,0,0" cols="0" frameborder="no" border="0" framespacing="0" >
  <frame src="../common/evalControlFrame.jsp"    name="evalControlFrame" id="evalControlFrame" />
</frameset>
<noframes></noframes>
</body>
</html>
