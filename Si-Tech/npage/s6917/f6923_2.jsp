<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
   /*
   * 功能:世博会门票定单查询
   * 版本: 1.0
   * 日期: 2009/5/13
   * 作者: wangjya
   * 版权: si-tech
   */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%
	response.setHeader("Pragma","No-Cache"); 
	response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0); 
 
	String opCode = request.getParameter("op_code");
	String opName = request.getParameter("op_name");
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String workNo = (String)session.getAttribute("workNo");
	String infoCode = request.getParameter("info_code_array");
	String infoValue = request.getParameter("info_value_array");

	String  id_type = request.getParameter("sRoleCode");
	String  id_card = request.getParameter("idcard");
	String  OriginalTime = request.getParameter("OriginalTime");
	String  EndTime = request.getParameter("EndTime");
	String  phoneNo = request.getParameter("phone_no");
	String  codeType = request.getParameter("code_type");

	String  inputParsm [] = new String[8];
	inputParsm[0] = workNo;
	inputParsm[1] = opCode;
	inputParsm[2] = id_type;
	inputParsm[3] = id_card;
	inputParsm[4] = OriginalTime;
	inputParsm[5] = EndTime;	
	inputParsm[6] = infoCode;
	inputParsm[7] = infoValue;
%>	
    <wtc:service name="s6923Query" routerKey="region" routerValue="<%=regionCode%>" retcode="errCode" retmsg="errMsg" outnum="16">			
	<wtc:param value="<%=inputParsm[0]%>"/>	
	<wtc:param value="<%=inputParsm[1]%>"/>	
	<wtc:param value="<%=inputParsm[2]%>"/>
	<wtc:param value="<%=inputParsm[3]%>"/>	
	<wtc:param value="<%=inputParsm[4]%>"/>
	<wtc:param value="<%=inputParsm[5]%>"/>	
	<wtc:param value="<%=inputParsm[6]%>"/>
	<wtc:param value="<%=inputParsm[7]%>"/>	
	</wtc:service>	
	<wtc:array id="tempArr" start="0" length="16"  scope="end"/>
<% 		
	if(!(errCode.equals("000000"))){
%>
		<script language="javascript">
	 	rdShowMessageDialog("查询失败！" + "<%=errMsg%>",0);	
	 	window.location="f6923_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>&phone_no=<%=phoneNo%>&code_type=<%=codeType%>";
		</script>
<%		
		return;				 			
	}
	if(!(tempArr[0][0].equals("0000"))){
%>
		<script language="javascript">
	 	rdShowMessageDialog("查询失败！" + "<%=tempArr[0][1]%>",0);	
	 	window.location="f6923_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>&phone_no=<%=phoneNo%>&code_type=<%=codeType%>";	
		</script>
<%		
		return;				 			
	}
	String[] OrderCodeList = tempArr[0][2].split("[|]");
	String[] OrderTypeList = tempArr[0][3].split("[|]");
	String[] OprNumList = tempArr[0][4].split("[|]");
	
	if(null == OrderCodeList)
	{
		%>
		<script language="javascript">
	 	rdShowMessageDialog("没有查到符合条件的定单！",0);	
	 	window.location="f6923_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>&phone_no=<%=phoneNo%>&code_type=<%=codeType%>";	
		</script>
		<%		
		return;	
	}
	if(0 == OrderCodeList.length)
	{
		%>
		<script language="javascript">
	 	rdShowMessageDialog("没有查到符合条件的定单！",0);	
	 	window.location="f6923_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>&phone_no=<%=phoneNo%>&code_type=<%=codeType%>";	
		</script>
		<%		
		return;	
	}
	if( OrderTypeList.length != OrderCodeList.length || OrderTypeList.length != OprNumList.length)
	{
		%>
		<script language="javascript">
	 	rdShowMessageDialog("查询信息错误，定单号和定单状态个数不符！",0);	
	 	window.location="f6923_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>&phone_no=<%=phoneNo%>&code_type=<%=codeType%>";	
		</script>
		<%		
		return;	
	}
	StringBuffer  insql = new StringBuffer();

	insql.append("select ordertype_code,ordertype_name ");
	insql.append(" from sorderstatuscode ");
	insql.append(" where use_flag='Y' and biz_type='01' ");
	insql.append(" order by ordertype_code  ");
	System.out.println("insql====="+insql);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
<wtc:sql><%=insql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="roleDetailData" scope="end" />
	<%
	insql = new StringBuffer();
	insql.append("select idtype_code,idtype_name ");
	insql.append(" from sidcardcode ");
	insql.append(" where use_flag='Y' and biz_type='01' ");
	insql.append(" order by idtype_code  ");
	System.out.println("insql====="+insql);
	%>
	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
	<wtc:sql><%=insql%></wtc:sql>
	</wtc:pubselect>
	<wtc:array id="idtypearray" scope="end" />
	
	<%
	insql = new StringBuffer();
	insql.append("select tickettype_code,tickettype_name ");
	insql.append(" from sticketcode ");
	insql.append(" where use_flag='Y' and biz_type='01' ");
	insql.append(" order by tickettype_code  ");
	System.out.println("insql====="+insql);
%>
<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="2">
<wtc:sql><%=insql%></wtc:sql>
</wtc:pubselect>
<wtc:array id="tktTypeArray" scope="end" />
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<script language="JavaScript">
<!--		
function Map() {  
    /** 存放键的数组(遍历用到) */  
    this.keys = new Array();  
    /** 存放数据 */  
    this.data = new Object();  
      
    /** 
     * 放入一个键值对 
     * @param {String} key 
     * @param {Object} value 
     */  
    this.put = function(key, value) {  
        if(this.data[key] == null){  
            this.keys.push(key);  
        }  
        this.data[key] = value;  
    };  
      
    /** 
     * 获取某键对应的值 
     * @param {String} key 
     * @return {Object} value 
     */  
    this.get = function(key) {
    	return null == this.data[key] ? "" : this.data[key];
       // return this.data[key];  
    };  
      
    /** 
     * 删除一个键值对 
     * @param {String} key 
     */  
    this.remove = function(key) {  
        this.keys.remove(key);  
        this.data[key] = null;  
    };  
      
    /** 
     * 遍历Map,执行处理函数 
     *  
     * @param {Function} 回调函数 function(key,value,index){..} 
     */  
    this.each = function(fn){  
        if(typeof fn != 'function'){  
            return;  
        }  
        var len = this.keys.length;  
        for(var i=0;i<len;i++){  
            var k = this.keys[i];  
            fn(k,this.data[k],i);  
        }  
    };  
      
    /** 
     * 获取键值数组(类似Java的entrySet()) 
     * @return 键值对象{key,value}的数组 
     */  
    this.entrys = function() {  
        var len = this.keys.length;  
        var entrys = new Array(len);  
        for (var i = 0; i < len; i++) {  
            entrys[i] = {  
                key : this.keys[i],  
                value : this.data[i]  
            };  
        }  
        return entrys;  
    };  
      
    /** 
     * 判断Map是否为空 
     */  
    this.isEmpty = function() {  
        return this.keys.length == 0;  
    };  
      
    /** 
     * 获取键值对数量 
     */  
    this.size = function(){  
        return this.keys.length;  
    };  
      
    /** 
     * 重写toString  
     */  
    this.toString = function(){  
        var s = "{";  
        for(var i=0;i<this.keys.length;i++,s+=','){  
            var k = this.keys[i];  
            s += k+"="+this.data[k];  
        }  
        s+="}";  
        return s;  
    };  
}  
var order_index = null;	
var idTypeMap = new Map();
var tktTypeMap = new Map();
var getTypeMap = new Map();
var svoucherMap = new Map();

<%for(int j = 0;j < idtypearray.length;j++)
{%>
	idTypeMap.put("<%=idtypearray[j][0]%>","<%=idtypearray[j][1]%>");
<%}%>
<%for(int j = 0;j < tktTypeArray.length;j++)
{%>
	tktTypeMap.put("<%=tktTypeArray[j][0]%>","<%=tktTypeArray[j][1]%>");
<%}%>
	getTypeMap.put("0","送票上门");
	getTypeMap.put("1","自行取票");
	getTypeMap.put("2","手机票"); 
	svoucherMap.put("0","二维码");
	svoucherMap.put("1","订购单");

onload=function()
{		
	init();
}
var cust_name_array = "<%=tempArr[0][5]%>".split("|");
var mobile_no_array = "<%=tempArr[0][6]%>".split("|");
var id_type_array = "<%=tempArr[0][7]%>".split("|");
var id_card_array = "<%=tempArr[0][8]%>".split("|");
var get_type_array = "<%=tempArr[0][9]%>".split("|");
var svoucher_array = "<%=tempArr[0][10]%>".split("|");
var BrSerNumb_array = "<%=tempArr[0][14]%>".split("|");
var OperatorNumb_array = "<%=tempArr[0][15]%>".split("|");
var ticket_type_array = "<%=tempArr[0][11]%>".split("|");
var ticket_sum_array = "<%=tempArr[0][12]%>".split("|");
var ticket_date_array = "<%=tempArr[0][13]%>".split("|");
var order_code_value="";
// 初始化
function init()
{
	document.getElementById("tabList2").style.display = "none";
	document.getElementById("tabList3").style.display = "none";
}
function commitjsp()
{
	getAfterPrompt();
	if(null == order_index)
	{
		rdShowMessageDialog("请选择定单!");
		return false;
	}
	<%
		if(opCode.trim().equals("6921"))//配送信息变更
		{%>
			if(document.all.get_type.value.trim() != "送票上门")//0-送票上门
			{
				rdShowMessageDialog("该定单配送方式不是送票上门，不能变更配送信息!");
				return false;
			}
			<% if(1 == OrderCodeList.length)
			{%>
				if(document.all.order_status.value.trim() != "未配送")
				{
					rdShowMessageDialog("该定单非未配送，不能变更配送信息!");
					return false;
				}
			<%}
			else
			{%>
				if(document.all.order_status[order_index].value.trim() != "未配送")
				{
					rdShowMessageDialog("该定单非未配送，不能变更配送信息!");
					return false;
				}
			<%}	
		}
		if(opCode.trim().equals("6922"))
		{%>
			if(document.all.svoucher.value.trim() != "二维码")//0-二维码
			{
				rdShowMessageDialog("该定单取票凭证不是二维码，不能补发二维码!");
				return false;
			}
		<%}
	%>

	document.getElementById("ticket_type").value = ticket_type_array[order_index].replace(/\,/g,'').trim().replace(/\-/g,'|').trim();
	document.getElementById("ticket_sum").value = ticket_sum_array[order_index].replace(/\,/g,'').trim().replace(/\-/g,'|').trim();
	document.getElementById("ticket_date").value = ticket_date_array[order_index].replace(/\,/g,'').trim().replace(/\-/g,'|').trim();

	form6923.submit();
}
function selectInput(choose)
{
	<% if(1 == OrderCodeList.length)
	{%>
		if(document.all.order_code.checked)
		{
			order_index = 0;
			order_code_value = document.all.order_code.value;
			document.getElementById("tabList2").style.display = "";
			document.getElementById("tabList3").style.display = "";
			document.getElementById("cust_name").value = cust_name_array[0].replace(/\,/g,'').replace(/\-/g,'');
			document.getElementById("mobile_no").value = mobile_no_array[0].replace(/\,/g,'').replace(/\-/g,'');
			document.getElementById("id_type").value = idTypeMap.get(id_type_array[0].replace(/\,/g,'').replace(/\-/g,'').trim());
			document.getElementById("id_card").value = id_card_array[0].replace(/\,/g,'').replace(/\-/g,'');
			document.getElementById("get_type").value = getTypeMap.get(get_type_array[0].replace(/\,/g,'').replace(/\-/g,'').trim());
			if(get_type_array[0].replace(/\,/g,'').replace(/\-/g,'').trim() == "1")
			{
				document.getElementById("svoucher").value = svoucherMap.get(svoucher_array[0].replace(/\,/g,'').replace(/\-/g,'').trim());
			}
			else
			{
				document.getElementById("svoucher").value ="";
			}
			document.getElementById("BrSerNumb").value = BrSerNumb_array[0].replace(/\,/g,'').replace(/\-/g,'');
			document.getElementById("OperatorNumb").value = OperatorNumb_array[0].replace(/\,/g,'').replace(/\-/g,'');
			var tmpTktTypeArray = ticket_type_array[0].replace(/\,/g,'').trim().split("-");
			var tmpTktSumArray = ticket_sum_array[0].replace(/\,/g,'').trim().split("-");
			var tmpTktDateArray = ticket_date_array[0].replace(/\,/g,'').trim().split("-");
			while(IList.rows.length >1)
			{
				IList.deleteRow();
			}
			for(var j = 0; j < tmpTktTypeArray.length; j++)
			{
				newRow=IList.insertRow();   
				newCell=newRow.insertCell();   
				newCell.innerHTML="<tr ><th align='center'>"+tktTypeMap.get(tmpTktTypeArray[j])+"</th>";
				newCell = newRow.insertCell();
				newCell.innerHTML="<th align='center'>"+tmpTktSumArray[j]+"</th>";
				newCell = newRow.insertCell();
				newCell.innerHTML="<th align='center'>"+(tmpTktDateArray[j] =="00000000" ? "-" :tmpTktDateArray[j]) +"</th></tr>"; 
			}
		
		}
	<%}
	else
	{
	%>
		for(var i = 0; i < document.all.order_code.length; i++)
		{
			
			if(document.all.order_code[i].checked)
			{
				order_index = i;
				order_code_value = document.all.order_code[i].value;
				document.getElementById("tabList2").style.display = "";
				document.getElementById("tabList3").style.display = "";
				document.getElementById("cust_name").value = cust_name_array[i].replace(/\,/g,'').replace(/\-/g,'');
				document.getElementById("mobile_no").value = mobile_no_array[i].replace(/\,/g,'').replace(/\-/g,'');
				document.getElementById("id_type").value = idTypeMap.get(id_type_array[i].replace(/\,/g,'').replace(/\-/g,'').trim());
				document.getElementById("id_card").value = id_card_array[i].replace(/\,/g,'').replace(/\-/g,'').trim();
				document.getElementById("get_type").value = getTypeMap.get(get_type_array[i].replace(/\,/g,'').replace(/\-/g,'').trim());
				if(get_type_array[i].replace(/\,/g,'').replace(/\-/g,'').trim() == "1")
				{
					document.getElementById("svoucher").value = svoucherMap.get(svoucher_array[i].replace(/\,/g,'').replace(/\-/g,'').trim());
				}
				else
				{
					document.getElementById("svoucher").value ="";
				}
				document.getElementById("BrSerNumb").value = BrSerNumb_array[i].replace(/\,/g,'').replace(/\-/g,'').trim();
				document.getElementById("OperatorNumb").value = OperatorNumb_array[i].replace(/\,/g,'').replace(/\-/g,'').trim();
				var tmpTktTypeArray = ticket_type_array[i].replace(/\,/g,'').trim().split("-");
				var tmpTktSumArray = ticket_sum_array[i].replace(/\,/g,'').trim().split("-");
				var tmpTktDateArray = ticket_date_array[i].replace(/\,/g,'').trim().split("-");
				while(IList.rows.length >1)
				{
					IList.deleteRow();
				}
				for(var j = 0; j < tmpTktTypeArray.length; j++)
				{
					newRow=IList.insertRow();   
					newCell=newRow.insertCell();   
					newCell.innerHTML="<tr ><th align='center'>"+tktTypeMap.get(tmpTktTypeArray[j])+"</th>";
					newCell = newRow.insertCell();
					newCell.innerHTML="<th align='center'>"+tmpTktSumArray[j]+"</th>";
					newCell = newRow.insertCell();
					newCell.innerHTML="<th align='center'>"+(tmpTktDateArray[j] =="00000000" ? "-" :tmpTktDateArray[j])+"</th></tr>"; 
				}
			
			}
		}
	<%}%>
}
</script> 
 
<title><%=opName%></title>
<meta http-equiv="Content-Type" content="text/html; charset=GBK">
<meta http-equiv="Expires" content="0">

</head>
<BODY>
<%if(opCode.trim().equals("6921"))
{
%>
	<form name="form6923" method="post" action="f6921_3.jsp">
<%
}
else if(opCode.trim().equals("6922"))
{%>
<form name="form6923" method="post" action="f6922_4.jsp">
<%
}%>	
	<%@ include file="/npage/include/header.jsp" %>
	<input type="hidden" name="op_code" value="<%=opCode%>">
	<input type="hidden" name="op_name" value="<%=opName%>">
	<input type="hidden" name="ticket_type" value="">
	<input type="hidden" name="ticket_sum" value="">
	<input type="hidden" name="ticket_date" value="">	

	<%if(opCode.trim().equals("6922"))
	{
	%>
		<input type="hidden" name="phone_no" value="<%=phoneNo%>">
		<input type="hidden" name="code_type" value="<%=codeType%>">
	<%
	}%>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
		<table width="100%" id="tabList" border=0 align="center" cellspacing=0>			
			<tr>		
				<td nowrap align='center' class="blue" width="10%"><div ><b>查询</b></div></td>		
				<td nowrap align='center' class="blue"><div ><b>定单号</b></div></td>
				<td nowrap align='center' class="blue"><div ><b>操作流水号</b></div></td>
				<td nowrap align='center' class="blue"><div ><b>定单状态</b></div></td>
			</tr>
	<%	
	if(OrderCodeList.length >0)
	{
		for(int i = 0; i < OrderCodeList.length; i++)
		{
		%>			
			<tr>	
				<td nowrap align='center'><input type="radio" id="order_code" name="order_code" value="<%=OrderCodeList[i].trim()%>" onclick="selectInput(this)"></td>			
						
				<td nowrap align='center'><%=OrderCodeList[i].trim()%>&nbsp;</td>
				<td nowrap align='center'><%=OprNumList[i].trim()%>&nbsp;</td>
				<%	
				int j = 0;
				for(; j < roleDetailData.length; j++)
				{
					
					if(OrderTypeList[i].trim().equals(roleDetailData[j][0]))
					{
					%>
						<td nowrap align='center'> <input name="order_status" value="<%=roleDetailData[j][1].trim()%>" type="text" class="InputGrey" v_must=1 readonly id="order_status" maxlength="20" ></td>
					<%
						break;
					}
				}
				
				if(j == roleDetailData.length)
				{
				%>
					<td nowrap align='center'> <input name="order_status" value="未知定单状态<%=OrderTypeList[i].trim()%>" type="text" class="InputGrey" v_must=1 readonly id="order_status" maxlength="20" ></td>
				<%
				}
				%>
			</tr>
		<%
		}
	}%>	
	<tr> 
		<td align="center" id="footer" colspan="4"> 
			<%if(opCode.trim().equals("6921"))
			{
			%>
				<input type="button" name="commit"  class="b_foot" value="更改" onclick=commitjsp();>
				&nbsp;
			<%
			}else if(opCode.trim().equals("6922"))
			{
			%>
				<input type="button" name="commit"  class="b_foot" value="补发" onclick=commitjsp();>
				&nbsp;
			<%
			}%>
			<input type="button" name="add"  class="b_foot" value="返回" onclick=window.location="f6923_1.jsp?opCode=<%=opCode%>&opName=<%=opName%>&phone_no=<%=phoneNo%>&code_type=<%=codeType%>";>
			&nbsp;
			<input type="button" name="delete" class="b_foot" value="关闭" onclick=removeCurrentTab();>
		</td>
	</tr>
		</table>
		
		<table width="100%" id="tabList2" border=0 align="center" cellspacing=0>			
    		<tr>				
				<td width="20%" class="blue"><b>收票人姓名</b></td>
				<td > 
					<input name="cust_name"  value="" type="text" class="InputGrey"  readonly id="cust_name" maxlength="30" > 
    			</td>				
				<td width="20%" class="blue"><b>收票人手机号码</b></td>
				<td> 
					<input name="mobile_no"  value="" type="text" class="InputGrey"  readonly id="mobile_no" maxlength="30" > 
    			</td>
    		</tr>
    		<tr>				
				<td width="20%" class="blue"><b>收票人有效证件类型</b></td>
				<td>
					<input name="id_type"  value="" type="text" class="InputGrey"  readonly id="id_type" maxlength="30" > 
    			</td>			
				<td width="20%" class="blue"><b>收票人有效证件号码</b></td>
				<td> 
					<input name="id_card"  value="" type="text" class="InputGrey"  readonly id="id_card" maxlength="30" > 
    			</td>
    		</tr>
    		<tr>				
				<td width="20%" class="blue"><b>取票方式</b></td>
				<td> 
					<input name="get_type"  value="" type="text" class="InputGrey"  readonly id="get_type" maxlength="30" > 
     			</td>			
				<td width="20%" class="blue"><b>取票凭证</b></td>
				<td> 
					<input name="svoucher"  value="" type="text" class="InputGrey"  readonly id="svoucher" maxlength="30" > 
    			</td>
    		</tr>
    		<tr>				
				<td width="20%" class="blue"><b>营业厅编号</b></td>
				<td> 
					<input name="BrSerNumb"  value="" type="text" class="InputGrey"  readonly id="BrSerNumb" maxlength="30" > 
    			</td>				
				<td width="20%" class="blue"><b>操作员编号</b></td>
				<td> 
					<input name="OperatorNumb"  value="" type="text" class="InputGrey"  readonly id="OperatorNumb" maxlength="30" > 
    			</td>
    		</tr>
    	</table>
    	<table " border="4"  id="tabList3" align="center" cellPadding=0 cellSpacing=0  width="95%">
		   <tr>
		   <td>
		   <table  id="IList" align="center" valign="top" border="1" cellPadding=4 cellSpacing=0  width="100%">
		   	<tr><th align="center">票种</th><th align="center">票数</th><th align="center">日期</th></tr>
			  </table>
			  <p>&nbsp;</p>
			  <p>&nbsp;</p>
		
			</td>
			</tr>
		</table>		
<%@ include file="/npage/include/footer.jsp" %>
</form>
</BODY>
</HTML>
