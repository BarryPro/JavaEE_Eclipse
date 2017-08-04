<%
    /*************************************
    * 功  能: 领取网上选号SIM卡 e964
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-7-6
    **************************************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    response.setHeader("Pragma", "No-cache");
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<%
		String opCode=request.getParameter("opCode");
		System.out.println("gaopengSeeLog================opCode="+opCode);
    String opName=request.getParameter("opName");
    String loginNo = (String)session.getAttribute("workNo");
    String password = (String)session.getAttribute("password");
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
    String phoneNo = WtcUtil.repNull((String)request.getParameter("phoneNo"));
	  String userCardNo = WtcUtil.repNull((String)request.getParameter("userCardNo"));
	  String custName = WtcUtil.repNull((String)request.getParameter("custName"));
	  String qryPhoneNo = WtcUtil.repNull((String)request.getParameter("qryPhoneNo"));
	  String brandName = WtcUtil.repNull((String)request.getParameter("brandName"));
	  String idName = WtcUtil.repNull((String)request.getParameter("idName"));
	  String custIccid = WtcUtil.repNull((String)request.getParameter("custIccid"));
	  String simCaidName = WtcUtil.repNull((String)request.getParameter("simCaidName"));
	  String custAddr = WtcUtil.repNull((String)request.getParameter("custAddr"));
	  String idNo = WtcUtil.repNull((String)request.getParameter("idNo"));
	  String simType = WtcUtil.repNull((String)request.getParameter("simType"));/*sim卡类型*/
	  String saleFlag = WtcUtil.repNull((String)request.getParameter("saleFlag"));
	  String hlrCodeName = WtcUtil.repNull((String)request.getParameter("hlrCodeName"));
	  String simNo = WtcUtil.repNull((String)request.getParameter("simNo"));
	  String prePayFee = WtcUtil.repNull((String)request.getParameter("prePayFee"));/*预存款*/
	  String simPayFee = WtcUtil.repNull((String)request.getParameter("simPayFee"));/*sim卡费*/
	  String workNo =(String)session.getAttribute("workNo");
	  String groupId =(String)session.getAttribute("groupId");
    
    /***************
     * begin 资费编码+资费名称   
     ***************/
	  String offerIdStr = WtcUtil.repNull((String)request.getParameter("offerIdStr"));/*资费编码列表：主资费+可选资费*/
	  //offerIdStr = "1200,1201,1202,1203,1204,";
	  String[] offerIds = offerIdStr.split("\\,");
	  String offerIdMain = offerIds[0]; /*主资费编码*/
	  
	  String offerNameStr = WtcUtil.repNull((String)request.getParameter("offerNameStr"));/*资费名称列表：主资费+可选资费*/
	  //offerNameStr = "主资费名称,可选资费名称1,可选资费名称2,可选资费名称3,可选资费名称4,可选资费名称5,";
	  String[] offerNames = offerNameStr.split("\\,");
	  String offerNameMain = offerNames[0]; /*主资费名称*/
	  String offerInfoOptional = "";        /*可选资费编码+名称 字符串*/
	  for(int i=1;i<offerIds.length;i++){
	    offerInfoOptional = offerInfoOptional +"("+ offerIds[i]+"、"+offerNames[i] +")。";
	  }
    /**********************
     *end 资费编码+资费名称 
     ***********************/
	  
	  /*******************
	   *begin 资费描述 
	   ******************/
	  String offerComStr = WtcUtil.repNull((String)request.getParameter("offerComStr"));/*资费描述列表：主资费+可选资费*/
	  //offerComStr = "主资费描述,可选资费描述1,可选资费描述2,可选资费描述3,可选资费描述4,";
	  String[] offerComs = offerComStr.split("\\,");
	  String offerComMain = offerComs[0]; /*主资费描述*/
	  String offerComOptional = "";       /*可选资费描述*/
	  for(int j=1;j<offerComs.length;j++){
	    offerComOptional = offerComOptional + offerComs[j] +"。";
	  }
	  /*******************
	   *end 资费描述 
	   ******************/
	  /***************
     * begin 特服编码+特服名称   
     ***************/
	  String spelServIdStr = WtcUtil.repNull((String)request.getParameter("spelServIdStr"));/*特服编码列表*/
	  //spelServIdStr = "特服编码1,特服编码2,特服编码3,特服编码4,";
	  String[] spelServIds = spelServIdStr.split("\\,");
	  String spelServInfo = "";        /*特服编码+名称 字符串*/
	  
	  String spelServNameStr = WtcUtil.repNull((String)request.getParameter("spelServNameStr"));/*特服名称列表*/
	  //spelServNameStr = "特服名称1,特服名称2,特服名称3,特服名称4,";
	  String[] spelServNames = spelServNameStr.split("\\,");
	  
	  for(int z=0;z<spelServIds.length;z++){
	    spelServInfo = spelServInfo + spelServIds[z]+":"+spelServNames[z] +"、";
	  }
	  if(spelServInfo!=""){
	    spelServInfo = spelServInfo.substring(0,spelServInfo.length()-1);
	  }
	  /***************
     * end 特服编码+特服名称   
     ***************/
     
    /***************
     *begin 获取系统时间
     ***************/
    Date currentTime = new Date(); 
    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
    String currentTimeString = formatter.format(currentTime);
    java.text.SimpleDateFormat formatter1 = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String currentTimeStringFormat = formatter1.format(currentTime);
    /***************
     *end 获取系统时间
     ***************/
     
     String simResBrandCode = "";
%>  
  <wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>

<%
	/*2014/05/26 11:10:47 gaopeng 关于我省“网上选号”和“18元套卡省内版”增加SIM卡类型选择功能的需求 调用sql语句查询服务*/
	/*gaopeng 2014/05/26 11:07:39 关于我省“网上选号”和“18元套卡省内版”增加SIM卡类型选择功能的需求 查询sql 如果是K06 再进行校验*/
	String simResSql = "select brand_code from srescode where res_code = '"+simType+"'";
%>	
	<wtc:pubselect name="sPubSelect" outnum="1"  routerKey="region" 
		 routerValue="<%=regionCode%>" retcode="retCodeRes" retmsg="retMsgRes">
		<wtc:sql><%=simResSql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="resultRes" scope="end"/>

<%
	if(resultRes.length > 0 && "000000".equals(retCodeRes)){
		simResBrandCode = resultRes[0][0];
		System.out.println("gaopengSeeLog===simResBrandCode="+simResBrandCode);
	}
%>
			 <wtc:service name="sG842Chk" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="2">
	    <wtc:param value=" "/>
	    <wtc:param value="01"/>
	    <wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=loginNo%>"/>
			<wtc:param value="<%=password%>"/>
	 		<wtc:param value="<%=qryPhoneNo%>"/>
			<wtc:param value=""/>
			<wtc:param value="查询此号码是否已经写卡成功过"/>		
	</wtc:service>				
		<wtc:array id="dcust2s" scope="end" />	
<%	
String kongkakahao="";
String biaozhiwei="";/*0是写卡成功直接调用确认服务即可，1是未写卡成功，需要按照流程操作*/
if(retCode2.equals("000000")) {
		if(dcust2s.length>0) {
				biaozhiwei=dcust2s[0][0];
				kongkakahao=dcust2s[0][1];
		}
}
//biaozhiwei="0";
//kongkakahao="0806001650003224";
System.out.println("是否已经写卡成功"+biaozhiwei);
System.out.println("空卡卡号"+kongkakahao);
		
%>
			
<HTML>
<HEAD>
    <TITLE>领取网上选号SIM卡</TITLE>
<script language="javascript">
 	function goBack(){
	  window.location.href="fe964_queryInfo.jsp?opCode=<%=opCode%>&opName=<%=opName%>&idIccid=<%=userCardNo%>&phoneNo=<%=phoneNo%>";
	}
</script>
</HEAD>
<body>
<form name="frme964" method="post" >
 	<input type="hidden" id="opCode" name="opCode"  value="<%=opCode%>" />
 	<input type="hidden" id="opName" name="opName"  value="<%=opName%>" />
	<%@ include file="/npage/include/header.jsp" %>
  <div class="title">
    <div id="title_zi">用户信息</div>
  </div>
	<table>
		<tr>
		  <td class="blue" width="15%">服务号码</td>
			<td>
				<%=qryPhoneNo%>
			</td>
			<td class="blue" width="15%">客户姓名</td>
			<td width="15%">
				<%=custName%>
			</td>
				<td class="blue" width="15%">证件名称</td>
			<td>
				<%=idName%>
			</td>
		</tr>
		<tr>
		  <td class="blue" width="15%">证件号码</td>
			<td>
				<%=custIccid%>
			</td>
		  <td class="blue" width="15%">用户编码</td>
			<td>
				<%=idNo%>
			</td>
			<td class="blue" width="15%">sim卡名</td>
			<td>
				<%=simCaidName%>
			</td>
		</tr>
		<tr>
		   <td class="blue" width="15%">订单状态</td>
			<td>
				<%=saleFlag%>
			</td>
		 <td class="blue" width="15%">用户品牌</td>
			<td>
				<%=brandName%>
			</td>
		  <td class="blue" width="15%">号码归属</td>
			<td>
				<%=hlrCodeName%>
			</td>
		</tr>
		<tr>
			<td class="blue" width="15%">客户地址</td>
			<td colspan="6">
				<%=custAddr%>
			</td>
		</tr>
		<tr>
			<td class="blue" width="15%">客户姓名</td>
			<td>
				<input name="realUserName" id="realUserName" value="" v_type="string"  maxlength="60" size=20 index="19" v_maxlength=60 class="InputGrey" readonly />
			</td>
			<td class="blue" width="15%">证件号码</td>
			<td>
				<input name="realUserIccId"  id="realUserIccId"  value=""  v_minlength=4 v_maxlength=20 v_type="string"  maxlength="18" value="" class="InputGrey" readonly />
				<input type="hidden" name="subFlag"  id="subFlag"  value="0"/>
			</td>
			<td colspan="2">
				<input type="button" id="dukaBut1" name="dukaBut1" class="b_text" value="读卡" onclick="Idcard_realUser()" <%if(biaozhiwei.equals("0")){%> disabled<%}%>/>
    			<input type="button" id="dukaBut2" name="dukaBut2" class="b_text" value="读卡(2代)" onclick="Idcard2()" <%if(biaozhiwei.equals("0")){%> disabled<%}%> />
    			<input type="button" id="jiaoyanBut" name="jiaoyanBut" class="b_text" value="校验" onclick="go_checkIdCard()" disabled="disabled" />
			</td>
		</tr>
		<tr>
      <td colspan="6">
        <hr>
      </td>
    </tr>
    <tr>
			<td class="blue" width="15%">sim卡号</td>
			<td colspan="6">
			  <div align="left">
			    <%=simNo%>
          <font color="red">*</font>
           <input class="b_text" id="ducard" type="button" name="ducard" value="读卡" onClick="readcardss()"  index="19"  disabled/>&nbsp;
           <input class="b_text" id="b_write" type="button" name="b_write" value="写卡" onmouseup="writechg(this)" onkeyup="if(event.keyCode==13)writechg()"  index="19"  disabled/>
          <input type="hidden" name="flg_normal" id="flg_normal" value="0">
        </div>
			</td>
		</tr>
		<tr > 
			  <td colspan="6" align="center" id="footer">
			  				<input class="b_foot" name="gengxins" onClick="gengxinsj()" type="button" value="更新SIM信息" disabled/>
			&nbsp;
			<input class="b_foot" name="subUptBtn" id="subUptBtn" onClick="printCommit()" type="button"  value="确认"  <%if(!biaozhiwei.equals("1")){%> disabled<%}%>/>
			&nbsp; 
			<input class="b_foot" name="back" onClick="goBack()" type="button" value="返回" />
			&nbsp; 
			<input name="back" onClick="removeCurrentTab();" type="button" class="b_foot" value="关闭" />
			&nbsp;
			</td>
		</tr>
	</table>
</div>
<input type="hidden" name="cardtype_bz"  value="s" />
<input name=simType id="simType" type=hidden value="<%=simType%>" />
<input name=simCode id="simCode" type=hidden value="<%=simNo%>" />
<input name=simCodeBack id="simCodeBack" type=hidden value="" />
<input name=phoneNo id="phoneNo" type=hidden value="" />
<input type="hidden" name="simCodeCfm" id="simCodeCfm"   />
<input type="hidden" name="cardstatus" id="cardstatus"   />
<input name="cardNo" id="cardNo" value=""  />
<input type="hidden" name="idNo" id="idNo" value="<%=idNo%>"  />
<input type="hidden" name="prePayFee" id="prePayFee" value="<%=prePayFee%>"  />
<input type="hidden" name="simPayFee" id="simPayFee" value="<%=simPayFee%>"  />
<input name=writecardbz type=hidden value="" />
<input name="qryPhoneNo" id="qryPhoneNo" type=hidden value="<%=qryPhoneNo%>" />

<%@ include file="/npage/include/public_smz_check.jsp" %>
  <%@ include file="/npage/include/footer.jsp" %>
</form>
<script language="javascript">
	/*2013/08/15 10:26:01 gaopeng 加入读卡方法*/
	var simtypess="";
	function readcardss() {
		if($("#subFlag").val()=="0"){
	    	rdShowMessageDialog("身份证校验没有通过不允许读卡!");
	    	return false;
	    }
		//document.all.b_write.disabled=false;
  		 var phone = '<%=qryPhoneNo%>';
  		 simtypess="";
  		 /****新增调大唐功能取SIM卡类型****/
  		 /* 
        * diling update for 修改营业系统访问远程写卡系统的访问地址，由现在的10.110.0.125地址修改成10.110.0.100！@2012/6/4
        */
  		 path ="http://10.110.0.125:33000/writecard/writecard/ReadCardInfo.jsp";
  		 var retInfo1 = window.showModalDialog("<%=request.getContextPath()%>/npage/sg529/Trans.html",path,"","dialogWidth:10;dialogHeight:10;"); 
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
        	
    	} 
    	if(retVal[0]=="0")
    	{
    		var rescode_str=retVal[2]+"|";
    		var rescode_strstr="";
    		var chPosm = rescode_str.indexOf("|");
    		for(i=0;i<4;i++)
    		{   	   
    	
    			var chPos1 = rescode_str.indexOf("|");
        		valueStr = rescode_str.substring(0,chPos1);
        		rescode_str = rescode_str.substring(chPos1+1);
        		if(i==0 && valueStr=="")
        		{
        			rdShowMessageDialog("读卡类型出错!");

    		 		  return false;
        		}
        		if(valueStr!=""){
        			rescode_strstr=rescode_strstr+"'"+valueStr+"'"+",";
        		}
        	
    		} 
    		rescode_strstr=rescode_strstr.substring(0,rescode_strstr.length-1);
    		if(rescode_strstr=="")
    		{
    			rdShowMessageDialog("读卡类型出错!");

    		 	return false;   
    		}
  		}
  		else{
  			 rdShowMessageDialog("读卡类型出错!");

    		 return false;   
    	}
    	simtypess=rescode_strstr.substr(1,rescode_strstr.length-2);
    	 document.all.b_write.disabled=false;
    	 
    	 
    }
	var retsimno="";
  function writechg(obj){
  	<%--if("<%=simResBrandCode%>"=="K06" && "<%=simType%>" != simtypess){
			rdShowMessageDialog("网站提供的sim卡类型与读卡sim卡类型不匹配,不允许写卡！",0);
	    return false;   
		}--%>
  
  	
  	
    var path = "<%=request.getContextPath()%>/npage/se964/fe964_fwritecard.jsp";
    path = path + "?regioncode=" + "<%=regionCode%>";
    path = path + "&sim_type=" + simtypess;
    path = path + "&sim_no=" +"<%=simNo%>";
    path = path + "&op_code=" +"<%=opCode%>";
    path = path + "&phone="+"<%=qryPhoneNo%>"+"&pageTitle=" + "写卡";
    path = path + "&deleteShowCardNoFlag=" +"isDelCardNo"; //add by diling  for 关于哈分公司申请优化远程写卡操作步骤的请示
    var retInfo = window.showModalDialog(path,"","dialogWidth:40;dialogHeight:20;");
    
    if(typeof(retInfo) == "undefined"){	
    	document.all.writecardbz.value="1"; 
    	document.all.subUptBtn.disabled=true;//写卡失败不能提交
    	document.frme964.gengxins.disabled=false;
    	rdShowMessageDialog("写卡失败");
    	return false;   
    } 
    var retsimcode=oneTok(oneTok(retInfo,"|",1));
    retsimno=oneTok(oneTok(retInfo,"|",2));
    var cardstatus=oneTok(oneTok(retInfo,"|",3));
    var cardNo=oneTok(oneTok(retInfo,"|",4));
      /*
    var retsimcode="0";
    var retsimno="89860070089810966258";
    var cardstatus="00";
    var cardNo="0806001650003224";
  */
    if(retsimcode=="0"){
      rdShowMessageDialog("写卡成功");
      document.all.writecardbz.value="0";
      document.all.simCodeBack.value=retsimno;
      document.all.simCodeCfm.value=retsimno;
      document.all.cardstatus.value=cardstatus;
      document.all.cardNo.value=cardNo;/*空卡卡号*/
      document.all.subUptBtn.disabled=false;//写卡成功能提交
    }else{
      document.all.writecardbz.value="1";
      document.all.subUptBtn.disabled=true;
      document.frme964.gengxins.disabled=false;
      rdShowMessageDialog("写卡失败");
    }
  }
  
  	function gengxinsj() {
		var myPacket = new AJAXPacket("<%=request.getContextPath()%>/npage/sg603/fg603Update.jsp","正在更新sim信息请稍后......");
		myPacket.data.add("phonenos",'<%=qryPhoneNo%>');
		myPacket.data.add("opcode",'<%=opCode%>');
		core.ajax.sendPacket(myPacket,doreturnmsgs);
		myPacket = null;
	}
	
	function doreturnmsgs(packet){
		var retcode = packet.data.findValueByName("retcode");
		var retmsg = packet.data.findValueByName("retmsg");
		if(retcode=="000000"){
			rdShowMessageDialog("数据更新成功，请重新操作！",2);
			goBack();
		}else {
			rdShowMessageDialog("数据更新失败！错误代码"+retcode+"，错误原因："+retmsg,0);
		}
	}
	
	
  
  function printCommit()
  {
    getAfterPrompt();

    var ret =showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
    se964_show_Bill_Prt();
    //return false;
    if(typeof(ret)!="undefined"){
      if((ret=="confirm")){
        if(rdShowConfirmDialog('确认电子免填单吗？如确认,将提交本次业务!')==1){
          frmCfm();
        }
      }
      if(ret=="continueSub"){
        if(rdShowConfirmDialog('确认要提交信息吗？')==1){
          frmCfm();
        }
      }
    }else{
      if(rdShowConfirmDialog('确认要提交信息吗？')==1){
        frmCfm();
      }
    }
    return true;
  }
  
  
  function showPrtDlg(printType,DlgMessage,submitCfm)
  {  
  		var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
     		var billType="1";                      //  票价类型1电子免填单、2发票、3收据
		var sysAccept ="<%=printAccept%>";                       // 流水号
		var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
		var mode_code=null;                        //资费代码
		var fav_code=null;                         //特服代码
		var area_code=null;                    //小区代码
		var opCode =   "<%=opCode%>";                         //操作代码
		var phoneNo = "<%=qryPhoneNo%>";                         //客户电话		  
  
	  	//显示打印对话框
	    	var h=200;
	    	var w=410;
	     	var t=screen.availHeight/2-h/2;
	     	var l=screen.availWidth/2-w/2;
	     	
	     	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
	   	var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);     	
  }
  
  function printInfo(printType){
    var retInfo = "";
    var cust_info="";
    var opr_info="";
    var note_info1="";
    var note_info2="";
    var note_info3="";
    var note_info4="";
    
    cust_info+="手机号码："+"<%=qryPhoneNo%>"+"|";
    cust_info+="客户姓名："+"<%=custName%>"+"|";
    cust_info+="客户地址："+"<%=custAddr%>"+"|";
    cust_info+="证件号码："+"<%=custIccid%>"+"|";
    
    opr_info+="受理时间："+"<%=currentTimeStringFormat%>"+""+"  用户品牌："+"<%=brandName%>"+"|";
    opr_info+="办理业务：领取网上选号SIM卡"+""+"  操作流水："+"<%=printAccept%>"+"|";
    opr_info+="SIM卡号："+retsimno+""+"  SIM卡费："+"<%=simPayFee%>"+"|";
    opr_info+="预存款："+"<%=prePayFee%>元"+"|";
    opr_info+="主资费："+"<%=offerIdMain%>"+" "+"<%=offerNameMain%>"+""+"  生效时间:"+"<%=currentTimeString%>"+"|";
    opr_info+="可选资费："+"<%=offerInfoOptional%>"+"|";
    opr_info+="开通特服："+"<%=spelServInfo%>"+"|";
    
    note_info1+="主资费描述："+"<%=offerComMain%>"+"|";
    note_info1+="可选资费描述："+"<%=offerComOptional%>"+"|";
    note_info1+="备注：操作员"+"<%=loginNo%>"+""+"对客户"+"<%=qryPhoneNo%>"+"进行领取网上选号SIM卡业务操作!"+"|";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
  }
  
//打印发票
  function se964_show_Bill_Prt(){
  			var  billArgsObj = new Object();
  			$(billArgsObj).attr("10001","<%=loginNo%>");     //工号
  			$(billArgsObj).attr("10002","<%=new java.text.SimpleDateFormat("yyyy",Locale.getDefault()).format(new java.util.Date())%>");
  			$(billArgsObj).attr("10003","<%=new java.text.SimpleDateFormat("MM",Locale.getDefault()).format(new java.util.Date())%>");
  			$(billArgsObj).attr("10004","<%=new java.text.SimpleDateFormat("dd",Locale.getDefault()).format(new java.util.Date())%>");
  			$(billArgsObj).attr("10005",$("#prt_cust_name").val());   //客户名称
  			$(billArgsObj).attr("10006","领取网上选号sim卡");    //业务类别
  			
  			$(billArgsObj).attr("10008","<%=qryPhoneNo%>");    //用户号码
  			$(billArgsObj).attr("10015","<%=simPayFee%>");   //本次发票金额
  			$(billArgsObj).attr("10016","<%=simPayFee%>");   //大写金额合计
  			$(billArgsObj).attr("10017","*");        //本次缴费：现金
  			/*10028 10029 不打印*/
  		  	$(billArgsObj).attr("10028","");   //参与的营销活动名称：
  			$(billArgsObj).attr("10029","");	 //营销代码	
  			$(billArgsObj).attr("10030","<%=printAccept%>");   //流水号：--业务流水
  			$(billArgsObj).attr("10036","e964");   //操作代码
  			/**/

  			
  			/*型号不打*/
  			$(billArgsObj).attr("10061","");	       //型号
  			$(billArgsObj).attr("10062","");	//税率
  			$(billArgsObj).attr("10063","");	//税额	   
  	    	$(billArgsObj).attr("10071","6");	//
  	 		$(billArgsObj).attr("10076",0);
   			
   			$(billArgsObj).attr("10083", ""); //证件类型
   			$(billArgsObj).attr("10084", ""); //证件号码
   			$(billArgsObj).attr("10086", "尊敬的客户，如您办理业务退订、取消等中止业务使用的操作时，请携带本收据、有效身份证件、办理业务时所得魔百和终端到移动指定自有营业厅办理押金退还手续。"); //备注
   			$(billArgsObj).attr("10065", ""); //宽带账号
   			$(billArgsObj).attr("10087", $("#stb_id").val()); //imei号码
   			
  			$(billArgsObj).attr("10041", "网上选号sim卡费");           //品名规格
  			$(billArgsObj).attr("10042","台");                   //单位
  			$(billArgsObj).attr("10043","1");	                   //数量
  			$(billArgsObj).attr("10044",0);	                //单价
  			
   			$(billArgsObj).attr("10085", "zsj"); //宽带费用收取方式 只弹出打印收据的框
   			$(billArgsObj).attr("10072","1"); //1--正常发票  2--冲正类发票  2--退费类发票

   			$(billArgsObj).attr("10088","e964"); //收据模块
   			
   			
  			var h=210;
  			var w=400;
  			var t=screen.availHeight/2-h/2;
  			var l=screen.availWidth/2-w/2;
  			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
  			//var path = "/npage/public/pubBillPrintCfm_YGZ.jsp?dlgMsg=" + "确实要进行发票打印吗？";
  			
  						//发票项目修改为新路径
  			$(billArgsObj).attr("11216","REC");  //新版发票新增票据标志位，默认空位发票 REC == 只有 打印纸质收据
  			var path = "/npage/public/billPrtNew/Bill_ELE_Prt.jsp?dlgMsg=" + "确实要进行发票打印吗？";

  			var loginAccept = "<%=printAccept%>";
  			var path = path +"&loginAccept="+loginAccept+"&opCode=m358&submitCfm=submitCfm";
  			var ret = window.showModalDialog(path,billArgsObj,prop);		

  }
  
  function frmCfm(){
  		
			<%
			if(biaozhiwei.equals("0")){
			%> 
				$("#cardNo").val("<%=kongkakahao%>");
			<%
		  }else {
		  %> 

		  <%			
			}
			%>
			
    frme964.action="fe964_subInfo.jsp";
    frme964.submit();
    return true;
  }
  
function Idcard_realUser() {
	//读取二代身份证
	var fso = new ActiveXObject("Scripting.FileSystemObject"); //取系统文件对象
	var tmpFolder = fso.GetSpecialFolder(0); //取得系统安装目录
	var strtemp = tmpFolder + "";
	var filep1 = strtemp.substring(0, 1)//取得系统目录盘符
	var cre_dir = filep1 + ":\\custID";//创建目录
	//判断文件夹是否存在，不存在则创建目录
	if (!fso.FolderExists(cre_dir)) {
		var newFolderName = fso.CreateFolder(cre_dir);
	}
	
	var picpath_n = cre_dir + "\\aaa_100.jpg";
	var result;
	var result2;
	var result3;
	$("#dukaBut1").attr("disabled","");
	$("#dukaBut2").attr("disabled","");
	$("#jiaoyanBut").attr("disabled","disabled");
	result = IdrControl1.InitComm("1001");
	if (result == 1) {
		result2 = IdrControl1.Authenticate();
		if (result2 > 0) {
			result3 = IdrControl1.ReadBaseMsgP(picpath_n);
			if (result3 > 0) {
				var name = IdrControl1.GetName();
				var code = IdrControl1.GetCode();
				document.all.realUserName.value = name;//姓名
				document.all.realUserIccId.value = code;//身份证号
				if(document.all.realUserName.value!=""&&document.all.realUserIccId.value!=""){
					$("#dukaBut1").attr("disabled","disabled");
					$("#dukaBut2").attr("disabled","disabled");
					$("#jiaoyanBut").attr("disabled","");
				}
			} else {
				IdrControl1.CloseComm();
				rdShowMessageDialog("请重新将卡片放到读卡器上");
			}
		} else {
			IdrControl1.CloseComm();
			rdShowMessageDialog("端口初始化不成功", 0);
		}
		IdrControl1.CloseComm();
	}
	fso.DeleteFolder(cre_dir);
}


	function Idcard2() {
		//扫描二代身份证
		var fso = new ActiveXObject("Scripting.FileSystemObject"); //取系统文件对象
		tmpFolder = fso.GetSpecialFolder(0); //取得系统安装目录
		var strtemp = tmpFolder + "";
		var filep1 = strtemp.substring(0, 1)//取得系统目录盘符
		var cre_dir = filep1 + ":\\custID";//创建目录
		if (!fso.FolderExists(cre_dir)) {
			var newFolderName = fso.CreateFolder(cre_dir);
		}
		var ret_open = CardReader_CMCC.MutiIdCardOpenDevice(1000);
		if (ret_open != 0) {
			ret_open = CardReader_CMCC.MutiIdCardOpenDevice(1001);
		}
		var cardType = "11";
		$("#dukaBut1").attr("disabled","");
		$("#dukaBut2").attr("disabled","");
		$("#jiaoyanBut").attr("disabled","disabled");
		if (ret_open == 0) {
			//alert(v_printAccept+"--"+str);
			//多功能设备RFID读取
			var ret_getImageMsg = CardReader_CMCC.MutiIdCardGetImageMsg(cardType, "c:\\aaa.jpg");
			if (ret_getImageMsg == 0) {
				//二代证正反面合成
				var xm = CardReader_CMCC.MutiIdCardName;
				var zjhm = CardReader_CMCC.MutiIdCardNumber; //证件号码		
				document.all.realUserName.value = xm;//姓名
				document.all.realUserIccId.value = zjhm;//身份证号
				if(document.all.realUserName.value!=""&&document.all.realUserIccId.value!=""){
					$("#dukaBut1").attr("disabled","disabled");
					$("#dukaBut2").attr("disabled","disabled");
					$("#jiaoyanBut").attr("disabled","");
				}
			} else {
				rdShowMessageDialog("获取信息失败");
				return;
			}
		} else {
			rdShowMessageDialog("打开设备失败");
			return;
		}
		fso.DeleteFolder(cre_dir);
		//关闭设备
		var ret_close = CardReader_CMCC.MutiIdCardCloseDevice();
		if (ret_close != 0) {
			rdShowMessageDialog("关闭设备失败");
			return;
		}
	}
	function go_checkIdCard(){
		var myPacket = new AJAXPacket("fe964_checkIdCard.jsp","正在校验身份证号码......");
		myPacket.data.add("cust_name",$("#realUserName").val());
		myPacket.data.add("id_iccid",$("#realUserIccId").val());
		core.ajax.sendPacket(myPacket,do_checkIdCard);
		myPacket = null;
	}
	function do_checkIdCard(packet){
		var retcode = packet.data.findValueByName("return_code");
		var retmsg = packet.data.findValueByName("return_msg");
		if(retcode=="000000"){
			var s_result = packet.data.findValueByName("s_result");
			if(s_result=="0"){
				$("#dukaBut1").attr("disabled","");
				$("#dukaBut2").attr("disabled","");
				$("#jiaoyanBut").attr("disabled","disabled");
				rdShowMessageDialog("身份证校验失败!");
				$("#subFlag").val("0");
			}
			else{
				$("#dukaBut1").attr("disabled","disabled");
				$("#dukaBut2").attr("disabled","disabled");
				$("#jiaoyanBut").attr("disabled","disabled");
				rdShowMessageDialog("身份证校验成功!");
				$("#subFlag").val("1");
				document.all.ducard.disabled=false;
			}
		}
	}
</script>
</body>


<object id="CardReader_CMCC" height="0" width="0"  classid="clsid:FFD3E742-47CD-4E67-9613-1BB0D67554FF" codebase="/npage/public/CardReader_AGILE.cab#version=1,0,0,6"/> 
<%@ include file="/npage/sq100/interface_provider.jsp" %>
</HTML>

