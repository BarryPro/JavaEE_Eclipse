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
<%@ page import="com.sitech.boss.util.page.*"%>
<%
	String op_code="9127";
	String op_name = "SP订购关系查询";
	String opCode = op_code;
	String workNo = (String)session.getAttribute("workNo");
	String workpw = (String)session.getAttribute("password");
	String errcode="000000";
	String errmsg="";
	String[][] result=null;
	String beginDate = request.getParameter("beginDate");//开始日期
	beginDate = beginDate + "000000";
	String endDate = request.getParameter("endDate"); //结束日期
	endDate = endDate + "235959";
	String phoneNo = request.getParameter("phoneNo");//电话号码
	String iQryType = request.getParameter("iQryType");//查询类型
	String iFeeType = request.getParameter("iFeeType");//收费类型
	iQryType=iQryType==null?"0":iQryType;
	iFeeType=iFeeType==null?"2":iFeeType;
%>
	<wtc:service name="splatBusiQry" outnum="12" routerKey="phone" routerValue="<%=phoneNo%>">
		<wtc:param value="0"/>
		<wtc:param value="02"/>
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=workpw%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=iQryType%>"/>
		<wtc:param value="<%=iFeeType%>"/>
		<wtc:param value="<%=beginDate%>"/>
		<wtc:param value="<%=endDate%>"/>
	</wtc:service>
	<wtc:array id="r1" scope="end" />

	<!-- add by jiyk 2012-07-18 添加wangwg的服务-->
	<wtc:service name="sKFSpInfoQry" outnum="12" routerKey="phone" routerValue="<%=phoneNo%>">
		<wtc:param value="0"/>
		<wtc:param value="02"/>
		<wtc:param value="<%=op_code%>"/>
		<wtc:param value="<%=workNo%>"/>
		<wtc:param value="<%=workpw%>"/>
		<wtc:param value="<%=phoneNo%>"/>
		<wtc:param value=""/>
		<wtc:param value="<%=iQryType%>"/>
		<wtc:param value="<%=iFeeType%>"/>
		<wtc:param value="<%=beginDate%>"/>
		<wtc:param value="<%=endDate%>"/>
	</wtc:service>
	<wtc:array id="r2" scope="end" />
<%
	result=r1;
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE><%=op_name%></TITLE>

<script language="javascript">
var SPNameArr = new Array();
function choose(checkBoxObj) {
	if (checkBoxObj.checked) {
		SPNameArr.push(checkBoxObj.value);
	} else {
		for (i=0; i < SPNameArr.length; i++) {
			if (SPNameArr[i]==checkBoxObj.value) {
				SPNameArr.splice(i, 1);
				break;
			}
		}
	}
}
	
<!-- add by jiyk 2012-07-26 -->
function toW001() {
	//取投诉号码。先取为受理号码，如果为空，就取为主叫号码
	var phone_no = window.top.document.getElementById('acceptPhoneNo').value;
	if (phone_no == '') {
		phone_no = window.top.cCcommonTool.getCaller();
	}
	if(phone_no ==''){
		rdShowMessageDialog('受理号码为空！',1);
		return;
	}
	//取主叫号码
	var caller_no = window.top.cCcommonTool.getCaller();
	//业务类型:服务类→客户投诉→梦网业务→梦网短信→定制类→业务办理→其他不知情定制
	var callcauseId = "1001010401010104";
	//SP名称
	var SPNames = SPNameArr.toString();
	SPNames = SPNames.replace(/,/g, "、");
	//处理内容模板
	var content;
	if (SPNames == "") {
		content = "客户投诉，未订制过***业务，客户要求：****";
	} else {
		content = "客户投诉，未订制过"+SPNames+"业务，客户要求：****";
	}
	//生产地址：10.110.0.100:21000
	//测试地址：10.110.26.23:6600
	//准生产地址：10.110.0.126:61100
	var path="http://10.110.0.100:21000/workflow/common/cspAuth.jsp?login_no=<%=workNo%>"
				+"&phone_no="+phone_no+"&caller_no="+caller_no
				+"&callcauseId="+callcauseId+"&content="+content;
	window.top.addTab(true,"w001","工单生成",path);
}

window.onload = function() {
	window.parent.ableOperate();
}
</script>
</HEAD>

<body>
<form  method=post name="form" >
<div id="Operation_Table">
	<div class="title">
		<div id="title_zi">SP及自有业务使用查询结果</div>
	</div>
	<table cellspacing="0">
		<tr>
			<th align=center width="5%;">选择</th>
			<th align=center width="5%;">序号</th>
			<th align=center width="8%;">服务商</th>
			<th align=center width="8%;">操作时间</th>
			<th align=center width="8%;">办理时间</th>
			<th align=center width="8%;">企业代码</th>
			<th align=center width="7%;">服务代码</th>
			<th align=center width="8%">订购业务名称</th>
			<th align=center width="10%;">业务类型</th>
			<th align=center width="6%;">收费类型</th>
			<th align=center width="8%;">业务费用</th>
			<th align=center width="8%;">自有业务标识</th>
			<th align=center width="6%;">操作名称</th>
			<th align=center width="12%;">操作状态</th>
			<th align=center width="20%;">特殊说明</th>
			
		</tr>
<%
	if(r1.length<=0&&r2.length<=0) {
%>
		<tr><td colspan="15" align = "left"><b><font class="orange">无查询结果</font></td></tr>
<%
	} else if (r1.length>0) {
		for(int i=0;i<r1.length;i++){
%>
		<tr onmouseout="this.style.backgroundColor=''" onmouseover="this.style.backgroundColor='#E8E8E8';">
			<td><input type="checkbox" value="<%=result[i][4]%>" onclick="choose(this)" /></td>
			<td align=center><%=(i+1)%>&nbsp;</td>
			<td align=center><%=result[i][0]%>&nbsp;</td>
			<td align=center><%=result[i][1]%>&nbsp;</td>
			<td align=center><%=result[i][1]%>&nbsp;</td>
			<td align=center><%=result[i][2]%>&nbsp;</td>
			<td align=center><%=result[i][3]%>&nbsp;</td>
			<td align=center><%=result[i][4]%>&nbsp;</td>
			<td align=center><%=result[i][5]%>&nbsp;</td>
			<td align=center><%=result[i][6]%>&nbsp;</td>
			<td align=center><%=result[i][7]%>&nbsp;</td>
			<td align=center><%=result[i][8]%>&nbsp;</td>
			<td align=center><%=result[i][9]%>&nbsp;</td>
			<td align=center><%=result[i][10]%>&nbsp;</td>
			<td align=center><%=result[i][11]%>&nbsp;</td>
		</tr>
<%
		}
	} else if (r2.length>0) {
%>
	<!-add by jiyk  2012-07-18 添加wangwg服务查询结果-->
<%
		result=r2;
		for(int j=0;j<r2.length;j++){
%>
		<tr onmouseout="this.style.backgroundColor=''" onmouseover="this.style.backgroundColor='#E8E8E8';">
			<td><input type="checkbox" value="<%=result[j][4]%>" onclick="choose(this)" /></td>
			<td><%=(j+1)%>&nbsp;</td>
			<td><%=result[j][0]==null?"":result[j][0]%>&nbsp;</td>
			<td><%=result[j][1]==null?"":result[j][1]%>&nbsp;</td>
			<td><%=result[j][1]==null?"":result[j][1]%>&nbsp;</td>
			<td><%=result[j][2]==null?"":result[j][2]%>&nbsp;</td>
			<td><%=result[j][3]==null?"":result[j][3]%>&nbsp;</td>
			<td><%=result[j][4]==null?"":result[j][4]%>&nbsp;</td>
			<td><%=result[j][5]==null?"":result[j][5]%>&nbsp;</td>
			<td>
<%
	    String fee=result[j][6]==null?"":result[j][6];
	    if(fee.equals("")){
	      out.print("其他");
	    }else if(fee.trim().equals("0")){
	    	out.print("免费");
	    }else if(fee.trim().equals("1")){
	    	out.print("按次/按条");
	    }else if(fee.trim().equals("2")){
	    	out.print("包月");
	    }else if(fee.trim().equals("3")){
	    	out.print("包时");
			}else if(fee.trim().equals("4")){
	    	out.print("包次");
	    }else if(fee.trim().equals("5")){
	    	out.print("栏目包月");
			}else if(fee.trim().equals("7")){
	    	out.print("包天");
	    }else if(fee.trim().equals("12")){
	    	out.print("包周");
	    }
%>
			</td>
			<td><%=result[j][7]==null?"":result[j][7]%>&nbsp;</td>
			<td>
<%
			String isSelfBusi=result[j][8]==null?"":result[j][8];
			if(isSelfBusi.equals("")){
				out.print("");
			}else if(isSelfBusi.trim().equals("1")){
				out.print("自有业务");
			}else if(isSelfBusi.trim().equals("0")){
		  	out.print("非自有");
			}
%>
			</td>
			<td><%=result[j][9]==null?"":result[j][9]%>&nbsp;</td>
			<td><%=result[j][10]==null?"":result[j][10]%>&nbsp;</td>
			<td>
<%
			String specialDec=(result[j][11]==null?"":result[j][11]);
			if(specialDec.trim().equals("")||specialDec.trim().equals("0")){
				out.print("无资费捆绑");
		  }else{
				out.print(specialDec);
			}
%>
			</td>
			
		</tr>
<%
		}
	}
%>
		<tr>
		 	<td colspan="15" align="center">
		 		<input type="button" class="b_text" value="快捷成立案件" onclick="toW001()">
		 	</td>
		</tr>
	</table>
</div>
</form>
</BODY>
</HTML>