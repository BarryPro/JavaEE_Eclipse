<%
  /*
   * 功能: 关于开发本省短厅和前台积分兑换话费功能及取消兑换限制的需求
   * 版本: 1.0
   * 日期: 2015/10/21 17:28:43
   * 作者: gaopeng
   * 版权: si-tech
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    String regionCode = (String)session.getAttribute("regionCode");
    String loginNo = (String)session.getAttribute("workNo");
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
 		String opCode = (String)request.getParameter("opCode");
 		String opName = (String)request.getParameter("opName");
		String phoneNo = (String)request.getParameter("activePhone");
		String loginAccept = getMaxAccept();
		
		String ipAddrM = (String)session.getAttribute("ipAddr");
 		String inst = "通过phoneNo[" + phoneNo + "]查询";
		String custName = "";
		String canUseJfNum = "";
		
		String  inParamsJF [] = new String[2];
    inParamsJF[0] = "select a.favour_code, a.favour_name, a.favour_point"
+"  from dbcustadm.smarkfavcode a, dcustmsg b"
+" where b.phone_no =:phoneNo"
+"   and a.region_code = substr(b.belong_code, 1, 2)"
+"   and a.sm_code = b.sm_code"
+"   and a.favour_code in"
+"       ('2003', '2004', '2005', '2002', '2001', '2056', '2057', '2058') order by a.favour_point";
    inParamsJF[1] = "phoneNo="+phoneNo;
		
%>

<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode_mail" retmsg="retMessage_mail" outnum="3"> 
    <wtc:param value="<%=inParamsJF[0]%>"/>
    <wtc:param value="<%=inParamsJF[1]%>"/> 
  </wtc:service>  
  <wtc:array id="result_mail"  scope="end"/>

<wtc:service name="sm004Qry" routerKey="regionCode" routerValue="<%=regionCode%>" retcode="retCode22" retmsg="retMsg22" outnum="2" >
      <wtc:param value="<%=loginAccept%>"/>
      <wtc:param value="01"/>
      <wtc:param value="<%=opCode%>"/>
      <wtc:param value="<%=loginNo%>"/>
      <wtc:param value="<%=noPass%>"/>
      <wtc:param value="<%=phoneNo%>"/>
      <wtc:param value=""/>
      <wtc:param value="2003"/>
  </wtc:service>

	<wtc:array id="result22" scope="end" />

<wtc:service name="sUserCustInfo" outnum="41" >
      <wtc:param value="<%=loginAccept%>"/>
      <wtc:param value="01"/>
      <wtc:param value="<%=opCode%>"/>
      <wtc:param value="<%=loginNo%>"/>
      <wtc:param value="<%=noPass%>"/>
      <wtc:param value="<%=phoneNo%>"/>
      <wtc:param value=""/>
      <wtc:param value="<%=ipAddrM%>"/>
      <wtc:param value="<%=inst%>"/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
      <wtc:param value=""/>
  </wtc:service>

	<wtc:array id="result11" scope="end" />

<%
		if(result11.length <= 0)
		{
%>
<script language="JavaScript">
			rdShowMessageDialog("该用户状态不正常！");
			removeCurrentTab();
</script>
<%
			return ;
		}
		else
		{
			custName = result11[0][5];
		}
%>

<%
	if(result22.length > 0 && "000000".equals(retCode22)){
		canUseJfNum = result22[0][0];
		System.out.println("gaopengSeeLogM331=========canUseJfNum="+canUseJfNum);
	}else{
	%>
	<script language="JavaScript">
			rdShowMessageDialog("错误代码：<%=retCode22%>，错误信息：该用户状态不正常！");
			removeCurrentTab();
	</script>
	<%	
		
	}
%>

<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>"  id="sysAccept" />

  	
<html>
<head>
	<title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>
	<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
	<script language="javascript">
		
		$(document).ready(function(){
			
		});
		
		
		

		
		
		function showPrtDlg(printType,DlgMessage,submitCfm)
		  {  //显示打印对话框
			var pType="subprint";                     // 打印类型print 打印 subprint 合并打印
		  var billType="1";                      //  票价类型1电子免填单、2发票、3收据
			var sysAccept ="<%=sysAccept%>";                       // 流水号
			var printStr = printInfo(printType);   //调用printinfo()返回的打印内容
			var mode_code=null;                        //资费代码
			var fav_code=null;                         //特服代码
			var area_code=null;                    //小区代码
			var opCode =   "<%=opCode%>";                         //操作代码
			var phoneNo = "<%=phoneNo%>";                           //客户电话

		   	var h=300;
		   	var w=400;
		   	var t=screen.availHeight/2-h/2;
		   	var l=screen.availWidth/2-w/2;

		   	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
			var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
			var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);
		  }

		  function printInfo(printType)
		  {	
		  	var giftInfo = $.trim($("select[name='giftInfo']").find("option:selected").val());
				
				var giftArray = new Array();
				giftArray = giftInfo.split("|");
				
				var giftName = giftArray[2];
				var giftPoint = giftArray[1];
				
        var cust_info=""; //客户信息
      	var opr_info=""; //操作信息
      	var retInfo = "";  //打印内容
      	var note_info1=""; //备注1
      	var note_info2=""; //备注2
      	var note_info3=""; //备注3
      	var note_info4=""; //备注4

				cust_info+=" "+"|";
				
				cust_info+="手机号码："+"<%=phoneNo%>"+"|";
      	cust_info+="客户姓名：<%=custName%>|";
      	
				opr_info+="办理业务："+giftName+"|";
				opr_info+="兑换扣减积分数："+giftPoint+"|";
				opr_info+="业务流水：<%=sysAccept%>"+"|";
				note_info1+= "注意事项：积分兑换话费，一经兑出，不予退换。|";
					
				retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //把“#"替换为url格式
				
	    	return retInfo;
		  }
		
	
		function doCfm(){
			
			var giftInfo = $.trim($("select[name='giftInfo']").find("option:selected").val());
			if(giftInfo.length == 0){
				rdShowMessageDialog("请选择礼品！");
				return false;
			}
			
			var giftArray = new Array();
			giftArray = giftInfo.split("|");
			
			var giftPoint = giftArray[1];
			
			if(Number(giftPoint) > Number("<%=canUseJfNum%>")){
				rdShowMessageDialog("当前可用积分值不足，不允许兑换！");
				return false;
			}
			
			var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
			if(typeof(ret)!="undefined")
			  {
			    if((ret=="confirm"))
			    {
			      if(rdShowConfirmDialog('确认电子免填单吗？')==1)
			      {
				   		formConfirm();
			      }
					}
				if(ret=="continueSub")
				{
			      if(rdShowConfirmDialog('确认提交信息么？')==1)
			      {
				    	formConfirm();
			      }
				}
			  }
			else
			  {
			     if(rdShowConfirmDialog('确认提交信息么？')==1)
			     {
				     formConfirm();
			     }
			  }	
			  return true;
			
			
			
			
		}
		function formConfirm(){
			
			var giftInfo = $.trim($("select[name='giftInfo']").find("option:selected").val());
			var giftArray = new Array();
			giftArray = giftInfo.split("|");
			
			var giftCode = giftArray[0];
			
			/*提交*/
				/*ajax start*/
			var getdataPacket = new AJAXPacket("/npage/sm331/fm331Cfm.jsp","正在获得数据，请稍候......");
			
			var printAccept = "<%=sysAccept%>";
			var iOpCode = "<%=opCode%>";
			var iPhoneNo = "<%=phoneNo%>";
			
			getdataPacket.data.add("printAccept",printAccept);
			getdataPacket.data.add("opCode",iOpCode);
			getdataPacket.data.add("phoneNo",iPhoneNo);
			getdataPacket.data.add("giftCode",giftCode);
			getdataPacket.data.add("giftNo",$("#giftNo").val());
			
			
			core.ajax.sendPacket(getdataPacket,doRetCfm);
			getdataPacket = null;
					
		
		}
		
		function doRetCfm(packet){
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			if(retCode == "000000"){
				rdShowMessageDialog("操作成功！",2);
				window.location.reload();
			}else{
				rdShowMessageDialog("错误代码："+retCode+",错误信息："+retMsg,1);
				window.location.reload();
			}
			
		}
		
		
	
		
	</script>
	</head>
<body>
	<form action="" method="post" name="f1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<div>
		<table>
	    <tr>
	  		<td width="20%" class="blue">服务号码</td>
	  		<td width="30%">
	  			<input type="text" id="phoneNo" name="phoneNo" value="<%=phoneNo%>" class="InputGrey" readonly />
	  		</td>
	  		<td width="20%" class="blue">客户名称</td>
	  		<td width="30%">
	  			<input type="text" id="custName" name="custName" value="<%=custName%>" class="InputGrey" readonly />
	  		</td>
	  	</tr>
	  	<tr >
	  		<td width="20%" class="blue">可用积分值</td>
	  		<td width="30%">
	  			<input type="text" id="canUseJfNum" name="canUseJfNum" value="<%=canUseJfNum%>"  class="InputGrey" readonly/>
	  		</td>
	  		<td width="20%" class="blue">礼品个数</td>
	  		<td width="30%">
	  			<input type="text" id="giftNo" name="giftNo" value="1" class="InputGrey" readonly />
	  		</td>
	  	</tr>
		  <tr >
	  		<td width="20%" class="blue">礼品信息</td>
	  		<td width="80%" colspan="3">
	  			<select name="giftInfo" style="width:260px">
	  				<option value="">-请选择-</option>	
	  				<%
	  					if(result_mail.length > 0 && "000000".equals(retCode_mail)){
	  						for(int i=0;i<result_mail.length;i++){
	  				%>
	  					<option value="<%=result_mail[i][0]%>|<%=result_mail[i][2]%>|<%=result_mail[i][1]%>"><%=result_mail[i][1]%>--><%=result_mail[i][2]%>积分</option>
	  				<%
	  						}
	  					}
	  				%>
	  			</select>
	  		</td>
	  		
	  	</tr>
	  	
	  </table>
	  <table>	
	  	<tr>
				<td align=center colspan="4" id="footer">
					<input class="b_foot" name="sure"  type="button" value="确认&打印"  onclick="doCfm();">&nbsp;&nbsp;
					<input class="b_foot" name="sure"  type="button" value="重置"  onclick="javascript:window.location.reload();">&nbsp;&nbsp;
					<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=关闭>
				</td>
			</tr>
		</table>
	</div>
	<div id="OfferAttribute"></div><!--销售品属性-->
	<!-- 查询结果列表 -->
	<div id="resultContent" style="display:none">
		<div class="title">
			<div id="title_zi">查询结果列表</div>
		</div>
		<table id="exportExcel" name="exportExcel">
			<tbody id="appendBody">
				
			
			</tbody>
		</table>
		<table>
			<tr>
				<td align=center colspan="4" id="footer">
					<input class="b_foot" name="sure"  type="button" value="确定"  onclick="doCfm();">&nbsp;&nbsp;
					<input class="b_foot" name="close"  onClick="removeCurrentTab()" type=button value=关闭>
				</td>
			</tr>
		</table>
	</div>

	<%@ include file="/npage/include/footer.jsp" %>
</form>
<script>
var excelObj;
function printTable(object)
{
	var obj=document.all.exportExcel;
	rows=obj.rows.length;
	if(rows>0){
		try{
			excelObj = new ActiveXObject("excel.Application");
			excelObj.Visible = true;
			excelObj.WorkBooks.Add;
			  for(i=0;i<rows;i++){
			    cells=obj.rows[i].cells.length;
			    for(j=0;j<cells;j++)
			      excelObj.Cells(i+1,j+1).Value="'" + obj.rows[i].cells[j].innerText;
			}
		}
		catch(e){}
	} else {
		
	}
}
</script>
</body>


</html>
