<%
/********************
 version v2.0
开发商: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opName = "促销品统一付奖";
	response.setHeader("Pragma","No-Cache");
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
	
	String loginNo = (String)session.getAttribute("workNo");
	String strPhoneNo = request.getParameter("phoneno");
	String resCode = request.getParameter("resCode");
    String resName = request.getParameter("resname");
	String ressum = request.getParameter("ressum");
	String num = request.getParameter("num");
	String opCode = request.getParameter("opcode");
	String resCodeFlag = resCode.substring(0,1);
		String[][] PacketName= new String[][]{};
		String[][] ResName= new String[][]{};
		String[][] ResNum= new String[][]{};	
	System.out.println("resCodeFlag="+resCodeFlag);
	if(resCodeFlag.equals("D"))
	{

		String TmpresCode =resCode.substring(1, 9); 
		String strSql = "select a.package_name,c.res_name,b.res_sum "+                                 
                                    "from dDynamicPackage a, dDynamicPackageDetail b,dbgiftrun.rs_code_info c ,dcustmsg d "+
                                    "where a.package_code = b.package_code "+
                                    "and b.res_code = c.RES_CODE "+
                                    "and a.id_no=d.id_no "+
                                    "and a.package_code = '"+ TmpresCode +"' "+
                                    "and d.phone_no = '" + strPhoneNo + "'";  
       System.out.println("strSql="+strSql);                             
       %>
		    <wtc:pubselect name="sPubSelect" outnum="3">
		    <wtc:sql><%=strSql%></wtc:sql>
		    </wtc:pubselect>
		    <wtc:array id="result1"  start="0" length="1" scope="end"/>
			<wtc:array id="result2"  start="1" length="1" scope="end"/>
			<wtc:array id="result3"  start="2" length="1" scope="end"/>
		<%      		                       
    	      PacketName = result1;
    	      ResName = result2;
    	      ResNum = result3;          
    }

	%>
<html>
	<head>
		<title>充值卡查询</title>
	</head>
<script type="text/javascript">
    var tempOldrescode = "";
    var temprescode = "";
//Load RPC Lib
window.onload=function()
{
	if("D" == document.frm.resCode.value.substring(0,1))
	{
		document.all.selectaward.style.display = "none";
		document.all.OpNote.style.display = "none";
		document.all.backList.style.display = "";	
		document.all.checkConfirm.style.display = "none";		
		document.all.Backfirm.style.display = "";			
	}
}

/**查询奖品**/
function getAwardInfo()
{
    document.all.confirm.disabled = false;
    //调用公共js得到奖品
    var pageTitle = "促销品代码查询";
    var fieldName = "选择|促销品代码|促销品名称|数量|";//弹出窗口显示的列、列名
    var sqlStr = "";
    var params="";
    var pos;
    if ("P" == document.frm.resCode.value.substring(0,1))//礼品包
    {
    	  sqlStr = "90000107";
  	    params = document.frm.resCode.value.substring(1,document.frm.resCode.value.length)+"|<%=loginNo%>|";
  	    
    }else if ("G" == document.frm.resCode.value.substring(0,1))//礼品等级
    {
    
        pos = document.frm.resCode.value.indexOf("|");
        tempOldrescode = document.frm.resCode.value.substring(0,pos);
        temprescode = document.frm.resCode.value.substring(pos+1,document.frm.resCode.value.length);

		sqlStr = "90000103";
  	params = "<%=loginNo%>|"+tempOldrescode.substring(1,tempOldrescode.length)+"|<%=loginNo%>|"+tempOldrescode.substring(1,tempOldrescode.length)+"|";
  
  
    }else
    {
    sqlStr = "90000105";
  	params = document.frm.resCode.value+"|";
  	  
    }

    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "2|1|2|";//返回字段
    var retToField = "awardNo|awardInfo|";//返回赋值的域
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,params))
        changeResCode();
}

function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField,params)
{
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType+ "&params=" + params;
    retInfo = window.showModalDialog(path);
    if(retInfo ==undefined)
    {
    	return false;
    }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    var iRec = 0;
    while(chPos_field > -1)
    {
        iRec = iRec+1;
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
		if (iRec ==2)
		{			
			document.all(obj).value = valueStr;
       	}
       	else
       	{
            document.all(obj).value = valueStr;
       	}
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
    }
    
	return true;
}

/*奖品名称变化触发函数*/
function changeResCode()
{
	if (document.frm.opcode.value == "2266")
	{
		var res_code = document.forms[0].awardNo.value;
		checkResName(res_code);
	}
}
function checkResName(res_code)
{
	//数据初始化
	document.forms[0].cardType.value = "";
	document.forms[0].cardNum.value = "";
	document.forms[0].card_no.value = "";
	document.all.checkCardNo.style.display = "none";
    //alert(res_code);
	if(res_code != "00000000")
	{
		//一定要是同步调用.
		var myPacket = new AJAXPacket("fGetCardInfo.jsp", "查询奖品类别明细,请稍等...");
		myPacket.data.add("res_code",res_code);
	    core.ajax.sendPacket(myPacket);
	    myPacket = null;
	}
}
function doProcess(packet)
{
	var result = packet.data.findValueByName("result");
	if(result == "true")
	{
	  var rescode = document.forms[0].awardNo.value;
		document.forms[0].cardType.value = packet.data.findValueByName("card_type");
		document.forms[0].cardNum.value = packet.data.findValueByName("card_num");
		document.all.checkCardNo.style.display = "block";
    /*begin 关于协助开发WLAN实体卡BOSS销售和渠道酬金结算需求的函 22013/6/10 */
    var packet = new AJAXPacket("f2266_ajax_showCardName.jsp","正在获得数据，请稍候......");
    packet.data.add("rescode",rescode);
    core.ajax.sendPacket(packet,doChangeCardName);
    packet = null;
    /*end 关于协助开发WLAN实体卡BOSS销售和渠道酬金结算需求的函 22013/6/10 */
	}
	else
	{
	    document.frm.card_no.value="N";
	}
}

/*begin 关于协助开发WLAN实体卡BOSS销售和渠道酬金结算需求的函 22013/6/10 */
function doChangeCardName(packet){
  var retCode = packet.data.findValueByName("retCode");
  var retMsg = packet.data.findValueByName("retMsg");
  var showName = packet.data.findValueByName("showName");
  if(retCode!="000000"){
    rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
    return false;
  }else{
    if(showName!=""){
      $("#phoneCardShowName").html(showName);
    }
  }
}
/*end 关于协助开发WLAN实体卡BOSS销售和渠道酬金结算需求的函 22013/6/10 */

/******为备注赋值********/
function setOpNote()
{
	if(document.frm.opNote.value=="")
	{
		if (document.frm.opcode.value == "2279")
		{
	  	    document.frm.opNote.value = "用户"+document.frm.phoneNo.value+"领奖冲正";
	    }
	    else if (document.frm.opcode.value == "2249")
	    {
	  	    document.frm.opNote.value = "用户"+document.frm.phoneNo.value+"预约登记";
		}
		else
		{
			document.frm.opNote.value = "用户"+document.frm.phoneNo.value+"领奖";
		}
	}
	return true;
}
/*查询手机充值卡*/
function checkCard()
{
    document.all.confirm.disabled = false;
	var prop="dialogHeight:600px; dialogWidth:550px; dialogLeft:400px; dialogTop:400px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no";
	card_num = parseInt(document.forms[0].cardNum.value);
	if(card_num == -1)
	{
		card_num = document.forms[0].ressum.value;
	}
	card_type = document.forms[0].cardType.value;
	var libaodaima = document.forms[0].awardNo.value;
	var ret = window.showModalDialog("./f2266_query_card.jsp?card_num="+card_num+"&card_type="+card_type+"&libaodaima="+libaodaima,"",prop);
	if(ret)
	{
		document.all.card_no.value = ret;
	}
	else
	{
		//do Nothing
		;
	}
}
function reValue()
{
    setOpNote();//备注赋值
    document.all.confirm.disabled = true;
	with(document.frm)
	{
		if (opcode.value == "2266" || opcode.value == "2249" || opcode.value == "2279")
		{
			if (opcode.value != "2279" )
		    {
					if(awardNo.value=="" )
					{
						rdShowConfirmDialog("请选择促销品!");
						awardNo.focus();
						return false;
					}
			 }
			
			if (document.frm.opNote.value.length > 30)
			{
                rdShowConfirmDialog("输入的备注信息过长");
                return false;
		    }
		    if(document.all.card_no.value=='')
		    {
		      var phoneCardShowName = $("#phoneCardShowName").html();
		        rdShowConfirmDialog("请查询"+phoneCardShowName+"！");
                return false;
		    }
		}
		else
		{
			document.frm.opNote.value = "促销品统一付奖冲正";
		}
	}
	if("G" == document.frm.resCode.value.substring(0,1))
	{
	        var retvalue="<%=num%>"+"%"+tempOldrescode+"|"+
                 document.frm.awardNo.value+"%"+
                 document.frm.opNote.value+"%"+
                 document.frm.card_no.value+"%"+
                 document.frm.cardType.value+"%"+
                 document.frm.cardNum.value+"%"+
                 document.frm.awardInfo.value+"%";
                 
    }
	else
    {
            var retvalue="<%=num%>"+"%"+
                 document.frm.awardNo.value+"%"+
                 document.frm.opNote.value+"%"+
                 document.frm.card_no.value+"%"+
                 document.frm.cardType.value+"%"+
                 document.frm.cardNum.value+"%"+
                 document.frm.awardInfo.value+"%";
    }
    //alert(document.frm.awardInfo.value);
    window.returnValue = retvalue;
    window.close();
}
</script>
<body>
<form name="frm" method="POST">
<%@ include file="/npage/include/header_pop.jsp" %>
  <table cellspacing="0">
		<tr id = "selectaward" style="display:" >
			<td class="blue">奖品名称</td>
			<td colspan="3">
				<input type="text" name="awardNo" size="8" maxlength="8" v_must=1 readonly>
				<input type="text" name="awardInfo" size="30" v_must=1 v_name=奖品名称  onchange="changeResCode()" readonly>&nbsp;&nbsp;
				<font class="orange">*</font>
			  <input name=awardInfoQuery type=button class="b_text"  style="cursor:hand" onClick="getAwardInfo()" value=查询>
      </tr>
          <!-- 手机充值卡输入卡卡号 -->
     <tr  id="checkCardNo" style="display:none">
 		<td id="phoneCardShowName" class="blue">手机充值卡卡号</td>
   		<td nowrap>
  	  	<input id="card_no"  type="text" name="card_no" size="40" value=""  readonly >
  	  	<font color="orange">*</font>
      	<input  type="button" name="card_no_qry" class="b_text" value="查询" onClick="checkCard()">
      	<input type="hidden" name="cardType">
		<input type="hidden" name="cardNum">
   		</td>
  	</tr>

	  <tr id="OpNote" style="display:">
    	<td class="blue">备注</td>
      <td colspan="3">
      	<input name="opNote" type="text" id="opNote" class="button" size="60" maxlength="60" onFocus="setOpNote();" readonly>
    	</td>
    </tr>
    </table>
    <TABLE cellSpacing="0" id="backList" style="display:none">
      <tr align="center">        
        <th>礼包名称</th>
        <th>礼品名称</th>
        <th>礼品数量</th>
        <%
        String tbclass="";
        		for(int k=0;k<PacketName.length;k++)
                {
                    if(k%2==0)
                    {
                        tbclass="Grey";
                    }
                    else
                    {
                        tbclass="";
                    }

        %>
            <tr align="center">
				<td class="<%=tbclass%>"><%=PacketName[k][0]%></TD>
				<td class="<%=tbclass%>"><%=ResName[k][0]%></TD>
				<td class="<%=tbclass%>"><%=ResNum[k][0]%></TD>
            </tr>
        <%
            }         
            %>
      </tr>
     </TABLE>
    <table cellspacing="0">
    <tr id="checkConfirm" style="display:">
    	<td colspan="4" id="footer">
				<div align="center">
				<input name="confirm" class="b_foot" id="confirm" type="button"  value="确认" onClick="reValue()" >
					&nbsp;
				<input name="reset" class="b_foot" type="button" value="关闭" onClick="window.close();">
					&nbsp;
				</div>
			</td>
   	</tr>
	</TABLE>
	<table cellspacing="0">
    <tr id="Backfirm" style="display:none">
    	<td colspan="4" id="footer">
				<div align="center">
				<input name="back" onClick="history.go(-1); window.close();" type="button" class="b_foot" value="返回">
					&nbsp;			
			</td>
   	</tr>
	</TABLE>
	<input type="hidden" name="resCode" value="<%=resCode%>">
    <input type="hidden" name="resName" value="<%=resName%>">
	<input type="hidden" name="opcode" value="<%=opCode%>">
	<input type="hidden" name="phoneNo" value="<%=strPhoneNo%>">
	<input type="hidden" name="ressum" value="<%=ressum%>">
<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>
