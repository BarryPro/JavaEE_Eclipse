<%
/********************
 version v2.0
 开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<%
  response.setDateHeader("Expires", 0);
%>
<%
		String opCode = request.getParameter("opCode");
		String opName = request.getParameter("opName");
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%

  String loginNo = (String)session.getAttribute("workNo");
  String loginName =  (String)session.getAttribute("workName");
  String orgCode = (String)session.getAttribute("orgCode");
  String regionCode = (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
  String workNo = (String)session.getAttribute("workNo");
  String ipAddr = (String)session.getAttribute("ipAddr");
  String notestr="根据phoneNo==["+activePhone+"]进行查询";
  String custname="";

%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="printAccept" />
			
					<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="confimAccept" />

<%
			String  inputParsm [] = new String[6];
			inputParsm[0] = printAccept;
			inputParsm[1] = "01";
			inputParsm[2] = opCode;
			inputParsm[3] = workNo;
			inputParsm[4] = password;
			inputParsm[5] = activePhone;
%>
		<wtc:service name="se382Qry" routerKey="region" routerValue="<%=regionCode%>"
					 retcode="retCode" retmsg="retMsg" outnum="8">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
		</wtc:service>
		<wtc:array id="result1" scope="end"  />
<%
if(retCode.equals("000000")) {
 if(result1.length<=0){
  	%>
 	<script language="javascript">
 	rdShowMessageDialog("用户当前没有生效的活动，不能办理取消业务！",0);
 	removeCurrentTab();
 	</script>
 	<%	
 }	
}
else {
 	%>
 	<script language="javascript">
 	rdShowMessageDialog("错误代码：<%=retCode%> ，错误信息：<%=retMsg%>",0);
 	removeCurrentTab();
 	</script>
 	<%	
}
%>
<wtc:service name="sUserCustInfo" routerKey="region" routerValue="<%=regionCode%>" retcode="RetCode1" retmsg="RetMsg1" outnum="100" >
  <wtc:param value="0"/>
  <wtc:param value="01"/>
  <wtc:param value="<%=opCode%>"/>
  <wtc:param value="<%=loginNo%>"/>	
  <wtc:param value="<%=password%>"/>		
  <wtc:param value="<%=activePhone%>"/>	
  <wtc:param value=""/>
  <wtc:param value="<%=ipAddr%>"/>
  <wtc:param value="<%=notestr%>"/>
  <wtc:param value=""/>
  <wtc:param value=""/>
  <wtc:param value=""/>
  <wtc:param value=""/>
</wtc:service>
<wtc:array id="returnFlag" start="0" length="1" scope="end"/>
<wtc:array id="result2" start="1" length="5" scope="end"/>
		<%
		  if("000000".equals(RetCode1)){
        if(result2.length>0){
          if("00".equals(returnFlag[0][0])){
            custname = result2[0][4];
          }
        }
      }
 else {
 	%>
 	<script language="javascript">
 	rdShowMessageDialog("错误代码：" + RetCode1 + "，错误信息：" + RetMsg1,0);
 	removeCurrentTab()；
 	</script>
 	<%
	}
	%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>


<script language="JavaScript">

      $(function() {
        init();
       });
  function init() {
  	var radio1 = document.getElementsByName("statesRadio");
  	var sm= new Array();
        			for(var i=0;i<radio1.length;i++)
				  {
					    if(radio1[i].checked)
						{
						  var opFlag = radio1[i].value;
							 sm =opFlag.split("|");
							var ogins =sm[0];
							if(sm[1]=="0") {
							rdShowMessageDialog("业务申请当日不能取消，可以冲正！");
							var oButton = document.getElementById("next"); 
              oButton.disabled = true;
							return false;
							}
							var oButton = document.getElementById("next"); 
              oButton.disabled = false;
							var getdataPacket = new AJAXPacket("fe382_query.jsp","正在获得操作代码路径，请稍候......");
							getdataPacket.data.add("phoneNo","<%=activePhone%>");
							getdataPacket.data.add("oldlogins",ogins);
							getdataPacket.data.add("projectType",sm[2]);
							getdataPacket.data.add("projectCode",sm[3]);
							core.ajax.sendPacket(getdataPacket);
							getdataPacket = null;
							$("#projectType").val(sm[2]);
							$("#projectCode").val(sm[3]);
							
				    }
		     }
  }
  		function doProcess(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			if(retCode == "000000"){
			var bodefutypes1 = packet.data.findValueByName("bodefutypes");
			var bodefusamount1 = packet.data.findValueByName("bodefusamount");
			var acdefutypes1 = packet.data.findValueByName("acdefutypes");
			var acdefusamount1 = packet.data.findValueByName("acdefusamount");
			var giadefuntype1 = packet.data.findValueByName("giadefuntype");
			var gitdeamount1 = packet.data.findValueByName("gitdeamount");
			var prgitefutypes1 = packet.data.findValueByName("prgitefutypes");
			var prgiteconamount1 = packet.data.findValueByName("prgiteconamount");
			var codeamount1 = packet.data.findValueByName("codeamount");
			var prgitereamount1 = packet.data.findValueByName("prgitereamount");
			var fillcash1 = packet.data.findValueByName("fillcash");
		  document.frm.bodefutypes.value=bodefutypes1;
		  document.frm.bodefusamount.value=bodefusamount1;
		  document.frm.acdefutypes.value=acdefutypes1;
		  document.frm.acdefusamount.value=acdefusamount1;
		  document.frm.giadefuntype.value=giadefuntype1;
		  document.frm.gitdeamount.value=gitdeamount1;
		  document.frm.prgitefutypes.value=prgitefutypes1;
		  document.frm.prgiteconamount.value=prgiteconamount1;
		  if (prgitefutypes1 == "DL") {
		  	$("#prgitefutypes1Tr").hide();
		  	$("#prgitefutypes2Tr").show();
			  document.frm.prgitefutypes2.value=prgitefutypes1 + "---自有业务专款";
			  document.frm.prgiteconamount2.value=prgiteconamount1;
		  } else if (prgitefutypes1 == "CZ") {
		  	$("#prgitefutypes1Tr").show();
		  	$("#prgitefutypes2Tr").hide();
			  document.frm.prgitefutypes1.value=prgitefutypes1 + "---预存赠话费";
			  document.frm.prgiteconamount1.value=prgiteconamount1;
		  } else if (prgitefutypes1 == "T") {
		  	$("#prgitefutypes1Tr").show();
		  	$("#prgitefutypes2Tr").hide();
			  document.frm.prgitefutypes1.value=prgitefutypes1 + "---赠送预存款";
			  document.frm.prgiteconamount1.value=prgiteconamount1;
		  }
		  document.frm.codeamount.value=codeamount1;
		  document.frm.prgitereamount.value=prgitereamount1;
		  document.frm.fillcash.value=fillcash1;
		  document.frm.prgitereamountsss.value=prgitereamount1;
		  		var oButton = document.getElementById("next"); 
          oButton.disabled = false;
			}else{
				rdShowMessageDialog("错误代码：" + retCode + "，错误信息：" + retMsg,0);
					var oButton = document.getElementById("next"); 
          oButton.disabled = true;
				return false;
			}
		}


  function frmCfm()
  {
    	var radio1 = document.getElementsByName("statesRadio");
    	var sm3= new Array();	
        			for(var i=0;i<radio1.length;i++)
				  {
					    if(radio1[i].checked)
						{
						  var opFlag = radio1[i].value;
									sm3=opFlag.split("|");
									var oldlgisw=sm3[0];
									document.frm.oldlogins.value=oldlgisw;
									if(sm3[1]=="0") {
									rdShowMessageDialog("业务申请当日不能取消，可以冲正！");
									return false;
									}
				    }
		     }
 	frm.submit();
	return true;
  }

  function printCommit()
  {
	//校验
	setOpNote();//为备注赋值
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
  return true;
}

 function showPrtDlg(printType,DlgMessage,submitCfm)
{  //显示打印对话框

	var h=210;
	var w=400;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

   var printStr = printInfo(printType);

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";



     var pType="subprint";                  // 打印类型print 打印 subprint 合并打印
     var billType="1";                      //  票价类型1电子免填单、2发票、3收据
     var sysAccept =<%=confimAccept%>;       // 流水号
     var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
     var mode_code=null;                    //资费代码
     var fav_code=null;                     //特服代码
     var area_code=null;                    //小区代码
     var opCode =   "<%=opCode%>";                         //操作代码
     var phoneNo = <%=activePhone%>;                            //客户电话
       /* ningtn */
    var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
    /* ningtn */

    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm+"&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+document.frm.phoneNo.value+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);
}
function printInfo(printType)
{


		var retInfo = "";
		var note_info1 = "";
		var note_info2 = "";
		var note_info3 = "";
		var note_info4 = "";
		var opr_info = "";
		var cust_info = "";


		cust_info+="手机号码："+"<%=activePhone%>"+"|";
		cust_info+="客户姓名："+document.frm.bp_name.value+"|";

		opr_info+="业务类型：赠送预存款营销案取消 "+"|";
		//opr_info+="操作流水："+"<%=printAccept%>"+"|";
		opr_info+="客户需补交话费金额："+document.frm.fillcash.value+"元|";

	note_info1+="您的预存话费在未消费完毕前，不能重复办理该业务，同时不能办理其他预存赠送话费类营销案。本业务到期前若申请取消，按违约规定您应补交所享受的赠送预存款金额，并按照剩余预存款的30%缴纳违约金。"+"|";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式

    return retInfo;


}


/******为备注赋值********/
  function setOpNote()
  {
	if(document.frm.opNote.value.trim()=="")
	{
	  	document.frm.opNote.value = "赠送预存款营销案取消; 手机号码:<%=activePhone%>";
	}
		return true;
  }
 function sradios(obj) {
              var sm1= new Array();
              sm1=obj.value.split("|");
              var olgis=sm1[0];
             if(sm1[1]=="0") {
							rdShowMessageDialog("业务申请当日不能取消，可以冲正！");
							var oButton = document.getElementById("next"); 
              oButton.disabled = true;
							return false;
							}
							var oButton = document.getElementById("next"); 
              oButton.disabled = false;
 							var getdataPacket = new AJAXPacket("fe382_query.jsp","正在获得操作代码路径，请稍候......");
							getdataPacket.data.add("phoneNo","<%=activePhone%>");
							getdataPacket.data.add("oldlogins",olgis);
							getdataPacket.data.add("projectType",sm1[2]);
							getdataPacket.data.add("projectCode",sm1[3]);
							core.ajax.sendPacket(getdataPacket);
							getdataPacket = null;
							$("#projectType").val(sm1[2]);
							$("#projectCode").val(sm1[3]);
 }
</script>


</head>


<body>
<form name="frm" action = "fe382Cfm.jsp" method="post"    >
<input name="prgitefutypes" type="hidden" id="prgitefutypes">
<input name="prgiteconamount" type="hidden" id="prgiteconamount">
<%@ include file="/npage/include/header.jsp" %> 
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
      <table cellspacing="0" >
		  <tr>
		    <td class="blue">手机号码</td>
            <td>
			  <input name="phoneNo" type="text"   id="phoneNo" value="<%=activePhone%>"  Class="InputGrey" readonly>
			</td>
		    <td class="blue">客户姓名</td>
            <td>
			  <input name="bp_name" type="text"   id="bp_name" value="<%=custname%>"  Class="InputGrey" readonly>
			</td>
          </tr>

          <tr >
          
          	<td class="blue">可取消的活动</td>
            <td colspan="3" height="32">
              <table>
              	<tr>
              		<th width="4%"></th>
              		<th width="14%">类型名称</th>
              		<th width="21%">方案名称</th>
              		<th width="22%">活动开始时间</th>
              		<th width="22%">活动结束时间</th>
              		<th>流水</th>             		
              	</tr>
<%
								if(retCode.equals("000000")) {
									if(result1.length>0){
										 String smoren="";
                     for(int i=0;i<result1.length;i++) {
                     if(i==0) {
                     smoren=" checked";
                     }else {
                     	smoren="";
                     }
%>
							<tr> 
								<td ><input type="radio" name="statesRadio" value="<%=result1[i][4]%>|<%=result1[i][5]%>|<%=result1[i][6]%>|<%=result1[i][7]%>"  onclick="sradios(this)" <%=smoren%>></td>
								<td ><%=result1[i][0]%></td>
								<td ><%=result1[i][1]%></td>
								<td ><%=result1[i][2]%></td>
								<td ><%=result1[i][3]%></td>
								<td ><%=result1[i][4]%></td>
							</tr>
<%                   }
											
                   }	
                }
%>
 
							</table>
            </td>

          <tr>

			<td class="blue">底线预存专款类型</td>
            <td>
			  <input name="bodefutypes" type="text"   id="bodefutypes"   value=""  Class="InputGrey" readonly>
			</td>
			<td class="blue">底线预存专款剩余金额</td>
            <td>
			   <input name="bodefusamount" type="text"    id="bodefusamount" value="" Class="InputGrey" readonly>
			</td>
          </tr>
                    <tr>

			<td class="blue">活动预存专款类型</td>
            <td>
			  <input name="acdefutypes" type="text"   id="acdefutypes"   value=""  Class="InputGrey" readonly>
			</td>
			<td class="blue">活动预存专款剩余金额</td>
            <td>
			   <input name="acdefusamount" type="text"    id="acdefusamount" value="" Class="InputGrey" readonly>
			</td>
          </tr>
      
      <tbody name="prgitefutypes1Tr" id="prgitefutypes1Tr">
				<tr>
					<td class="blue">预存赠话费专款</td>
					<td>
						<input name="prgitefutypes1" type="text"    id="prgitefutypes1" value="" Class="InputGrey" readonly>
					</td>
					<td class="blue">预存赠话费剩余金额</td>
					<td>
						<input name="prgiteconamount1" type="text"    id="prgiteconamount1" maxlength="60" Class="InputGrey" readonly>
					</td>
				</tr>
      </tbody>
      <tbody name="prgitefutypes2Tr" id="prgitefutypes2Tr">
				<tr>
					<td class="blue">自有业务专款</td>
					<td >
						<input name="prgitefutypes2" type="text"    id="prgitefutypes2" maxlength="60" Class="InputGrey" readonly>
					</td>
					<td class="blue">自有业务专款剩余金额</td>
					<td>
						<input name="prgiteconamount2" type="text"    id="prgiteconamount2" maxlength="60" Class="InputGrey" readonly>
					</td>
				</tr>
			</tbody>
			<tr>
				<td class="blue">可转预存金额</td>
				<td>
					<input name="codeamount" type="text"    id="codeamount" value="" Class="InputGrey" readonly>
				</td>
				<td class="blue">预存赠话费应回收累计金额</td>
				<td>
					<input name="prgitereamount" type="text"    id="prgitereamount" maxlength="60" Class="InputGrey" readonly>
				</td>
			</tr>
                    
			<tr>
				<td class="blue">用户应补收现金</td>
				<td >
					<input name="fillcash" type="text"    id="fillcash" maxlength="60" Class="InputGrey" readonly>
				</td>
				<td class="blue">预存赠话费已消费累计金额</td>
				<td>
					<input name="prgitereamountsss" type="text"    id="prgitereamountsss" maxlength="60" Class="InputGrey" readonly>
				</td>
			</tr>
          <tr  >
            <td class="blue">备注</td>
            <td colspan="3" height="32">
             <input name="opNote" type="text"   id="opNote" size="60" maxlength="60" value="" >
            </td>
          </tr>
         
          	<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=confimAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
         
          </table>
<table cellspacing="0">
		  <tr >

            <td colspan="4"> <div align="center">
                &nbsp;
			       	<input name="next" id="next" type="button" class="b_foot"   value="确定&打印" onClick="printCommit()" >
                &nbsp;
                <input name="back" onClick="history.go(-1)" type="button" class="b_foot"  value="返回">
                &nbsp;
                <input name="closedd" onClick="removeCurrentTab();" type="button" class="b_foot"  value="关闭">

				</div>
			</td>
          </tr>
          </table >
      
		<input type="hidden" name="oldlogins" id="oldlogins" >
		<input type="hidden" name="opCode" id="opCode" value="<%=opCode%>">
		<input type="hidden" name="opName" id="opName" value="<%=opName%>">
		<input type="hidden" name="giadefuntype" id="giadefuntype" ><%//赠送预存款专款类型(该字段前台隐藏，仅作为取消时传给计费的产生)%>
		<input type="hidden" name="gitdeamount" id="gitdeamount" ><%//赠送预存款金额(该字段前台隐藏，仅作为取消时传给计费的产生)%>
		<input type="hidden" name="confimAccept" id="confimAccept" value="<%=confimAccept%>">
		<input type="hidden" name="projectType" id="projectType" value="">
		<input type="hidden" name="projectCode" id="projectCode" value="">
  <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>


