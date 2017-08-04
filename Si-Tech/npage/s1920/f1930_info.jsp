<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
	/********************
	 version v2.0
	 开发商: si-tech
	 update zhaohaitao at 2009.01.14
	 模块:统一查询退订
	 ********************/
%>

<%
	/*
	 * 功能: 用户定购关系查询显示页面
	 * 版本: 1.8.2
	 * 日期: 2005/11/09
	 * 作者: huyan
	 * 版权: si-tech
	 */
%>

<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page contentType="text/html; charset=gbk"%>

<%
	String opName = "统一查询退订";
	String opCode = "1930";
	String org_code = request.getParameter("org_code");
	String work_no = request.getParameter("work_no");
	String password = request.getParameter("login_passwd");
	String ip_address = request.getParameter("ip_address");
	String op_code = "1930";
	String op_note = "";
	String phone_no = request.getParameter("phoneNo");
	String begin_pos = "";
	String maxretnum = "";
	String workName = request.getParameter("loginName");
	String regioncode=(String)session.getAttribute("regCode");
	String cccTime=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
	
%>
<%
	String ipAddrM = (String)session.getAttribute("ipAddr");
 		String inst = "通过phoneNo[" + phone_no  + "]查询";
		String gCustId = "";
		String custSql = "";
		String custName = "";
		String  inParamsMail [] = new String[2];
    inParamsMail[0] = "select trim(t.cust_id) from dcustmsg t where phone_no =:phoneNo";
    inParamsMail[1] = "phoneNo="+phone_no ;
		
%>
 <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regioncode%>" retcode="retCode_mail" retmsg="retMessage_mail" outnum="1"> 
    <wtc:param value="<%=inParamsMail[0]%>"/>
    <wtc:param value="<%=inParamsMail[1]%>"/> 
  </wtc:service>  
  <wtc:array id="result_mail"  scope="end"/>
<%
	if("000000".equals(retCode_mail) && result_mail.length > 0){
		gCustId = result_mail[0][0];
	}else{
		%>
		<script language="javascript">
			rdShowMessageDialog("获取客户信息失败！");
			removeCurrentTab();
		</script>
		<%
	}

String beizhussdese1="根据custid=["+gCustId+"]进行查询";
%>  	
	 	
	<wtc:service name="sUserCustInfo" outnum="100" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regioncode%>">
			<wtc:param value="0" />
			<wtc:param value="01" />	
			<wtc:param value="<%=opCode%>" />	
			<wtc:param value="<%=work_no%>" />
			<wtc:param value="<%=password%>" />
			<wtc:param value="" />
			<wtc:param value="" />
			<wtc:param value="<%=ipAddrM%>" />
			<wtc:param value="<%=beizhussdese1%>" />
			<wtc:param value="<%=gCustId%>" />
</wtc:service>
<wtc:array id="result_custInfo" scope="end"/>	
<%	 	

String custidNo = "";
String custiccids = "";
String custAddr = "";
String custiccidtypes = "";
String custditypesnames="";
if(result_custInfo.length>0){
if(result_custInfo[0][0].equals("01")) {
	custAddr = result_custInfo[0][11];
	custiccids = result_custInfo[0][13];
	custName = result_custInfo[0][5];
	custiccidtypes = result_custInfo[0][12].trim();
	custidNo = result_custInfo[0][30];
	}
}
if("0".equals(custiccidtypes)) {
		custditypesnames="身份证";
  }else if("1".equals(custiccidtypes)) {
  	custditypesnames="军官证";
 	}else if("2".equals(custiccidtypes)) {
 		custditypesnames="军官证";
 	}else if("3".equals(custiccidtypes)) {
 		custditypesnames="港澳通行证";
 	}else if("4".equals(custiccidtypes)) {
 		custditypesnames="警官证";
 	}else if("5".equals(custiccidtypes)) {
 		custditypesnames="台湾通行证";
 	}else if("6".equals(custiccidtypes)) {
 		custditypesnames="外国公民护照";
 	}else if("7".equals(custiccidtypes)) {
 		custditypesnames="其它";
 	}else if("8".equals(custiccidtypes)) {
 		custditypesnames="营业执照";
 	}else if("9".equals(custiccidtypes)) {
 		custditypesnames="护照";
 	}else if("A".equals(custiccidtypes)) {
 		custditypesnames="组织机构代码";
 	}else if("B".equals(custiccidtypes)) {
 		custditypesnames="单位法人证书";
 	}else if("C".equals(custiccidtypes)) {
 		custditypesnames="单位证明";
 	}else if("00".equals(custiccidtypes)) {
 		custditypesnames="身份证";
 	}
%>	

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regioncode%>"  id="printAccept" />

<%
	/**
	 String[][] temp=new String[][]{};
	 String[][] tmpresult1= new String[][]{};
	 String[][] tmpresult2= new String[][]{};
	 String[][] tmpresult3= new String[][]{};
	 String[][] tmpresult4= new String[][]{};
	 String[][] tmpresult5= new String[][]{};
	 String[][] tmpresult6= new String[][]{};
	 String[][] tmpresult7= new String[][]{};
	 String[][] tmpresult8= new String[][]{};
	 String[][] tmpresult9= new String[][]{};
	 String[][] tmpresult10= new String[][]{};

	 String[][] tmpresult11= new String[][]{};
	 String[][] tmpresult12= new String[][]{};
	 String[][] tmpresult13= new String[][]{};
	 String[][] tmpresult14= new String[][]{};
	 String[][] tmpresult15= new String[][]{};

	 String[][] tmpresult16= new String[][]{};
	 String[][] tmpresult17= new String[][]{};
	 String[][] tmpresult18= new String[][]{};
	 String[][] tmpresult19= new String[][]{};
	 String[][] tmpresult20= new String[][]{};
	 String[][] tmpresult21= new String[][]{};
	 String[][] tmpresult22= new String[][]{};
	 **/

	//String retCode = "";
	//String retMsg ="";
	String errcode = "000000";
	String errmsg = "";
	String retMessage = "";
%>

<wtc:service name="sUnifyQry" outnum="17" routerKey="phone"
	routerValue="<%=phone_no%>">
	<wtc:param value="0" />
	<wtc:param value="01" />
	<wtc:param value="<%=op_code%>" />
	<wtc:param value="<%=work_no%>" />
	<wtc:param value="<%=password%>" />
	<wtc:param value="<%=phone_no%>" />
	<wtc:param value="" />
</wtc:service>
<wtc:array id="result1Temp" start="0" length="2" scope="end" />
<wtc:array id="result2Temp" start="2" length="15" scope="end" />

<%
	errcode = retCode;
	errmsg = retMsg;
	for (int i = 0; i < result2Temp.length; i++) {
		for (int j = 0; j < result2Temp[i].length; j++) {
			System.out
					.println("zhouby ##########result2Temp["
							+ i + "][" + j + "]->" + result2Temp[i][j]);
		}
	}
	retCode = retCode;
	retMessage = retMsg;
	System.out.println("result2Temp===" + result2Temp.length);
	if (!retCode.equals("000000")) {
%>

<script language='jscript'>
	rdShowMessageDialog('<%=retMessage%>' + '[' + '<%=retCode%>' + ']',0);
	history.go(-1);
</script>

<%
	} else {
%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
		<TITLE>统一查询退订</TITLE>
	</HEAD>

	<script language="JavaScript">
		var checke177flag="yes";
		function docheckbox(seq,ojb){
			/**王乐 delete on 20110526 for 添加批量处理需求
		    for(var i=0;i<document.form1.cancle.length;i++)	{
		        if(!document.form1.cancle[seq].checked){
		            document.form1.cancle[i].disabled="";
		        }
		        else if(document.form1.cancle[i].checked){
		        }
		        else{
		            document.form1.cancle[i].disabled="none";
		        }
		    } 
		    **/
			
			if(ojb.checked){
			    
				var biztype="name"+seq+"0";
				var spid="name"+seq+"1";
				var spbizcode="name"+seq+"3";
				var qianshu="name"+seq+"5";
				
				/*王乐add on 20110531*/
				var bizName="name"+seq+"4";
				
				var iJtId="name"+seq+"7";
				var iIntelNkId="name"+seq+"8";
				var iFlag="name"+seq+"9";
				var JtId=form1[eval('iJtId')].value;
				var IntelNkId=form1[eval('iIntelNkId')].value;
				var Flag=form1[eval('iFlag')].value;
				if(JtId.length<=0){
				    JtId = " ";
			    }
			    if(IntelNkId.length<=0){
				    IntelNkId = " ";
			    }
			    if(Flag.length<=0){
				    Flag = " ";
			    }
				ojb.value=form1[eval('biztype')].value+","+form1[eval('spid')].value+","+form1[eval('spbizcode')].value+","+form1[eval('bizName')].value+","+JtId+","+IntelNkId+","+Flag;
				
				if(form1[eval('bizName')].value=="手机邮箱标准版") {
					var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/s1141/checkQuitType.jsp","请稍后...");
					packet.data.add("phoneno","<%=phone_no%>");
					packet.data.add("seseq","80005");
					core.ajax.sendPacket(packet,dochecke177);
					packet =null;
				}
				
					if(form1[eval('bizName')].value=="无线音乐特级会员") {
					var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/s1141/checkQuitType.jsp","请稍后...");
					packet.data.add("phoneno","<%=phone_no%>");
					packet.data.add("seseq","80006");
					core.ajax.sendPacket(packet,dochecke177);
					packet =null;
				}
				
					if(form1[eval('spid')].value=="801234" && form1[eval('spbizcode')].value=="110301") {
					var packet = new AJAXPacket("<%=request.getContextPath()%>/npage/s1141/checkQuitType.jsp","请稍后...");
					
					packet.data.add("phoneno","<%=phone_no%>");
					packet.data.add("seseq","80007");
					core.ajax.sendPacket(packet,dochecke177);
					packet =null;
				}
				
			}
		}
		
				function dochecke177(packet){
	var errorCode = packet.data.findValueByName("errorCode");
	var errormsg = packet.data.findValueByName("errorMsg");
	if(errorCode =="000000"){
	checke177flag="yes";		
	var returncode = packet.data.findValueByName("returncode");
	var returnmsg11 = packet.data.findValueByName("returnmsg");
	if(returncode=="000000") {
	}else {
	rdShowMessageDialog(returnmsg11);
	}
	}else{
		rdShowMessageDialog(errormsg);
		checke177flag="no";
		return false;
	}
}
		
		//--------全选--------------
		function allSelect()
		{
			var i = 0;
			
			//一行都没有
			if(document.all.check==undefined)
			{
				rdShowMessageDialog("此目录下没有权限,无法全部选中！");
				return;
			}
			//只有一行
			if(document.all.check.length==undefined)
			{
				document.all.check.checked=true;	
			}
			for(i=0;i<document.all.check.length;i++)
			{
				document.all.check[i].checked=true;	
			}
			
		}
		
		/*王乐 add on20110526 统一查询退订加批量处理需求*/
		function allSelect2(){
			//alert("1");
			var checkbox = document.form1.cancle;
			var count = 0;
			//有选中的先重置为都不选中
			for(var i = 0; i < checkbox.length; i ++){
				if(checkbox[i].checked == true){
					checkbox[i].checked = false;
					count ++;
				}
			}
			//System.out.println("==========checkbox.length============" + checkbox.length);
			//如果都没有选中，则都选中
			if(count == 0){
				for(var j = 0; j < checkbox.length; j ++){
					//System.out.println("==========j============" + j);
					checkbox[j].checked = true;
					docheckbox(j,checkbox[j]);
				}
			}
		}
		
		function doconfirm(){
			var flag=0;
			if(document.all.cancle.length==undefined)
			{
				if(document.form1.cancle.checked){
					flag=1;
				}	
			}	
			else{
				for(var i=0;i<document.form1.cancle.length;i++)	{
					if(document.form1.cancle[i].checked){
						flag=1;
						break;
					}
				}
			}
			if(flag==0){
				rdShowMessageDialog("请选择要退订的订购关系!!");
				return false;
			}
			if(!printCfm()){
				return false;
			}
			var ret=rdShowConfirmDialog("是否退订?");
		    if(typeof(ret)!="undefined")
		    {
		        if(ret==1)                      //点击认可
		        {
		            document.form1.action="f1930_cfm.jsp?custidNo=<%=custidNo%>";
			        document.form1.submit();
		        }
		        else if(ret==0)                 //点击取消,问是否提交
		        {    
		        }
		    }
			
		}
		
		function printCfm(){
	var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
	if(typeof(ret)!="undefined"){
		if((ret=="confirm")){
			if(rdShowConfirmDialog('确认电子免填单吗？')==1){
				return true;
			}else{
				return false;
			}
		}
		if(ret=="continueSub"){
			if(rdShowConfirmDialog('确认要提交信息吗？')==1){
				return true;
			}else{
				return false;
			}
		}else{
			if(rdShowConfirmDialog('确认要提交信息吗？')==1){
				return true;
			}else{
				return false;
			}
		}
	}
	else{
		if(rdShowConfirmDialog('确认要提交信息吗？')==1){
			return true;
		}else{
			return false;
		}
	}
}
		
		
		function showPrtDlg(printType,DlgMessage,submitCfm){
		var h=198;
		var w=350;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;
		var pType="subprint";
		var billType="1";
		var sysAccept = "<%=printAccept%>";
		var phone_no = "<%=phone_no%>";
		var mode_code = "";


		var fav_code = "";
		var area_code = "";
		var printStr = printInfo(printType);
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phone_no+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);
		return path;
}
function printInfo(printType){
	var retInfo = "";
	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
	var servNo = "<%=phone_no%>";
	
	cust_info+="手机号码："+servNo+"|";
	cust_info+="客户姓名："+"<%=custName%>"+"|";

	var cTime = "<%=cccTime%>";
	opr_info += "业务受理时间："+cTime +"|";
	opr_info += "业务类型：<%=opName%>      操作流水:"+"<%=printAccept%>"+"|";
	opr_info += "业务名称："+"|";
	$("#tab01 tr:gt(0):visible").each(function(i,bt){
		var chkFlag = $(bt).find("td:eq(0)").find("input").attr("checked"); 
		var ywmc = $(bt).find("td:eq(3)").find("input").val().trim(); 
		if(chkFlag == true){
			opr_info += ywmc+"|";
		}
	});
	

	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}

	</script>

	<body>
		<FORM method=post name="form1" onKeyUp="chgFocus(form1)">

			<%@ include file="/npage/include/header.jsp"%>

			<div class="title">
				<div id="title_zi"><%=opName%></div>
			</div>

			<table cellspacing="0" id="tab01">
				<TBODY>
					<tr>
						<td>
							<input type="button" value="全选" onclick="allSelect2()" class="b_text"
								style="width: 100%" />
						</td>
						
						<%
							String sqlStr1 = "select dispflag,item_name from oneboss.SOBORDERQUERYLIST where item_type='ORDER' and qryflag='1' order by item_index";
							//ArrayList al=callSvrImpl.sPubSelect("2",sqlStr1);
						%>
						
						<wtc:pubselect name="sPubSelect" routerKey="phone"
							routerValue="<%=phone_no%>" retcode="retCode2" retmsg="retMsg2"
							outnum="2">
							<wtc:sql><%=sqlStr1%></wtc:sql>
						</wtc:pubselect>
						<wtc:array id="alTemp" scope="end" />
						
						<%
							if (alTemp.length > 0) {
									String[][] tmp = alTemp;
									for (int i = 0; i < tmp.length; i++) {
										String dispflag = tmp[i][0];			//0, 1
										String item_name = tmp[i][1];			//序号, 业务名称, 费用信息, and so on
										if (Integer.parseInt(dispflag) == 1) {
						%>
						
						<th align=center nowrap><%=item_name%></th>
						
						<%
										}
									}
							}
						%>

					</tr>

					<%
						String[][] countArray = result1Temp;
						int retNum = Integer.parseInt(countArray[0][0]);	//该用户订购关系数量
						System.out.println("retNum=" + retNum);
						String sqlStr2 = "select dispflag,item_seq from oneboss.SOBORDERQUERYLIST where item_type='ORDER' and qryflag='1' order by item_index";
						//ArrayList result=callSvrImpl.sPubSelect("2",sqlStr2);
					%>
					
					<wtc:pubselect name="sPubSelect" routerKey="phone"
						routerValue="<%=phone_no%>" retcode="retCode3" retmsg="retMsg3"
						outnum="2">
						<wtc:sql><%=sqlStr2%></wtc:sql>
					</wtc:pubselect>
					<wtc:array id="tmpArrTemp" scope="end" />
					
					<%
						for (int k = 0; k < retNum; k++) {
					%>
					
					<tr>
						<td align=center>
							<input type="checkbox" name="cancle" style="" value=""
								onclick="docheckbox('<%=k%>',this)">
						</td>
						
						<%
							if (tmpArrTemp.length > 0) {
								String[][] tmpArr = tmpArrTemp;
	
								for (int i = 0; i < tmpArr.length; i++) {
									String dispflag = tmpArr[i][0];
									String item_seq = tmpArr[i][1];
									String centername = "";
	
									int item_seqTemp = Integer.parseInt(item_seq);			//5 费用信息, 98 序号, 99 业务名称
	
									/*0 vBizType, 1 vSpid, 2 vSpName, 3 vBizCode, 4 vServName, 5 vBillingType, 6 vBeginTime, 7 "", 8 "", 9 "", 10 vServFlag*/
									String[][] tmpresult = result2Temp;																						
									if (Integer.parseInt(dispflag) == 1) {
										if (item_seqTemp == 99) {
											if (tmpresult[k][0].equals("JT") || tmpresult[k][0].equals("ZY")) {
													
												//王乐删除于20110905 取消中国移动字样需求
																			
												centername = tmpresult[k][4];				
												
												
												//王乐增加于20110905 取消中国移动字样需求
												// hejwa 又给加中国移动字样了，2014年2月21日15:46:26 
												/*			
												System.out.println("======tmpresult[k][4].length()======" + tmpresult[k][4].length() );
												if(		tmpresult[k][4].trim().endsWith(	"(中国移动)"		)	 || 		tmpresult[k][4].trim().endsWith(	"（中国移动）"		)	){
													int length = tmpresult[k][4].length();
													
													//System.out.println(" zhouby +111+" + tmpresult[k][4]);
													
													String temp = tmpresult[k][4].substring(0, length - 6); 	
													centername = temp;
												} else {
													centername = tmpresult[k][4];														
												}
												*/
												
											} else {

												//王乐删除于20110905 取消中国移动字样需求
												/*
												centername = tmpresult[k][4] + "(" + tmpresult[k][2] + ")";			
												*/
												
												//王乐增加于20110905 取消中国移动字样需求
												if(tmpresult[k][2].equals("中国移动")){
													centername = tmpresult[k][4];
												} else {
													centername = tmpresult[k][4] + "(" + tmpresult[k][2] + ")";													
												}
											}
										} else if (item_seqTemp == 5) {
											centername = tmpresult[k][item_seqTemp];
											if(tmpresult[k].length >=14&&tmpresult[k][14]!=null)
											{
												if("1".equals(tmpresult[k][14]))
												{
													centername = centername + "元/半年";
												}
												else if("2".equals(tmpresult[k][14]))
												{
													centername = centername + "元/全年";
												}
												else if("3".equals(tmpresult[k][14]))
												{
													centername = centername + "元/季";
												}
												else
												{
													centername = centername + "元/月";
												}
											}
											else
											{
												centername = centername + "元/月";
											}
										} else if (item_seqTemp == 98) {
											centername = k + 1 + "";
										} else {
											centername = tmpresult[k][item_seqTemp];
										}
						%>
						<td style="display: none">
							<input type=hidden name="name<%=k%><%=item_seq%>"             	
								value="<%=centername%>">									<!-- 第k条订购关系，item_seq:5 费用信息, 98 序号, 99 业务名称-->
						</td>
						<TD align=center><%=centername%>&nbsp;
						</TD>
						
						<%
									} else {
						%>
						
						<td style="display: none">
							<input type=hidden name="name<%=k%><%=item_seq%>"
								value="<%=tmpresult[k][item_seqTemp]%>">
						</td>
						
						<%
									}
								}
							}
						%>

					</tr>

					<%
						}
					%>

				</TBODY>
			</TABLE>

			<table cellspacing="0">
				<TR>
					<TD align=center id="footer">
						<input class="b_foot" name=sure type=button value=确认
							onclick="doconfirm()">
						<input class="b_foot" name=reset type=reset value=关闭
							onClick="window.close()">
						<input name="back" onClick="history.go(-1)" type="button"
							class="b_foot" value="返回">
					</td>
				</TR>
			</TABLE>

			<input type="hidden" name="phoneno" value="<%=phone_no%>">
			<input type="hidden" name="printAccept" value="<%=printAccept%>">
			
			<%@ include file="/npage/include/footer.jsp"%>

		</form>
	</body>
	
</html>

<%
	}
%>
