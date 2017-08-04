<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * 功能: 客服一级报表录入信息表
　 * 版本: 1.0.0
　 * 日期: 2009/09/07
　 * 作者: yinzx
　 * 版权: sitech
   * 
　 */
%>

<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
String sceid =  request.getParameter("sceid");
String orgCode = (String)session.getAttribute("orgCode");
String regionCode = orgCode.substring(0,2);
String myParams="";

String serSql="select SERIALNO,TO_CHAR(CENTER10086),TO_CHAR(CALLAG10086), TO_CHAR(CALLPE10086),TO_CHAR(CALLEN10086),TO_CHAR(CALLER10086),TO_CHAR(CALLPER10086),TO_CHAR(CENTER12580), TO_CHAR(CALLOUTAG10086),TO_CHAR(CALLEROUT10086),TO_CHAR(OUTAG10086),TO_CHAR(AG12580),TO_CHAR(AGER12580),TO_CHAR(OUTAGER10086),TO_CHAR(ENER10086),TO_CHAR(OUTMAIN), TO_CHAR(OTHERAG1008612580),TO_CHAR(WAVEBD),    	TO_CHAR(OUTTOTAL),    TO_CHAR(OTHERER1008612580),TO_CHAR(MALFUNCTION),to_char(datetime,'YYYY-MM-DD HH24:MI:SS') AS datetime,TO_CHAR(AGENTAVGNUM),TO_CHAR(CALLTIME) from difagfirst where 1=1  and SERIALNO= :sceid " ;
 myParams = "sceid="+sceid;

 
 
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="25">
	<wtc:param value="<%=serSql%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="rows" scope="end" />
	
 
	
 
	
<html>
<head>
<title>客服一级报表录入信息表</title>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<script language=javascript>
	
/**
  * 
  */
function modifysceTrans(){
	 
	var xinval="";
	var yinval="";
  
	for(var i=0;i<23;i++)
	{
		   if ($("input")[i].value=="")
		   {
		   	  $("input")[i].value=" ";
		   }
			 xinval+=$("input")[i].value+",";
			 
  }
 
   
	var packet = new AJAXPacket("k190_sceTrans_rpc.jsp","...");
	packet.data.add("retType","modifysceTrans");
	packet.data.add("addvalxin" ,xinval);
	packet.data.add("sceid" ,"<%=sceid%>");
	 


	
	core.ajax.sendPacket(packet,doProcessmodsceTrans,true);
	packet=null;
}

/**
  *返回处理函数
  */
function doProcessmodsceTrans(packet) {
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");

	if (retCode == "000000") {
		rdShowMessageDialog("修改数据成功！");	
		opener.document.location.replace("k190_Main.jsp");	
    closeWin();
   
	} else {
		rdShowMessageDialog("修改数据失败！");

	}
}

 

// 清除表单记录
function cleanValue(){
  	var e = document.sitechform.elements;
			for(var i=0;i<e.length;i++){
				if(e[i].type=="select-one"||e[i].type=="text"||e[i].type=="hidden"){
				  e[i].value="";
				}else{
			  		e[i].checked=false;
			    }
			}   
}

function closeWin(){
	window.close();
}

function initValue(){

}

</script>
</head>

<body >
<form id=sitechform name=sitechform>
	<div id="Operation_Table">
		<div class="title"><div id="title_zi">客服一级报表录入信息表</div></div>
		<table>
		 
			 <TR class=content3>
          <td noWrap>全省10086客户服务中心数量<font color=#ff0000 
            >*</FONT></TD></TD>
          <td><input class=form1 id=text1  v_must=1
             type=text size=18     value="<%=rows[0][1] %>" readonly>
          
          <td noWrap>10086呼入总座席数<font color=#ff0000 
            >*</FONT></TD></TD>
          <td><input class=form1 id=text2  v_must=1
             type=text size=18 value="<%=rows[0][2] %>" ></TD>
          <td noWrap>10086呼入专家坐席数<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text3  v_must=1
             type=text size=18 value="<%=rows[0][3] %>" ></TD></TR>
        <TR class=content2>
          <td noWrap>10086外语座席数<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text4  v_must=1
             type=text size=18 value="<%=rows[0][4] %>" ></TD>
          <td noWrap>10086呼入话务员数<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text5  v_must=1
             type=text size=18 value="<%=rows[0][5] %>" </TD>
          <td noWrap>10086呼入专席话务员数<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text6  v_must=1
             type=text size=18 value="<%=rows[0][6] %>" > </TD></TR>
        <TR class=content3>
          <td noWrap>12580客户服务中心数量<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text7  v_must=1
             type=text size=18 value="<%=rows[0][7] %>" ></TD>
          <td noWrap>10086呼出座席数<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text8  v_must=1
             type=text size=18 value="<%=rows[0][8] %>"></TD>
          <td noWrap>10086呼出话务员数<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text9  v_must=1
             type=text size=18 value="<%=rows[0][9] %>" ></TD></TR>
        <tr class=content2>
          <td noWrap><font color=#ff0000 
            ><font color=#0f384b 
            >10086承接的外包项目的坐席数</FONT>*</FONT> </TD>
          <td noWrap><input class=form1 id=text10  v_must=1
             type=text size=18 value="<%=rows[0][10] %>" ></TD>
          <td noWrap>12580座席数量<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text11  v_must=1
             type=text size=18 value="<%=rows[0][11] %>" > </TD>
          <td noWrap>12580话务员数量<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text12  v_must=1
             type=text size=18 value="<%=rows[0][12] %>" > </TD></TR>
        <tr class=content3>
          <td noWrap>10086承接的外包项目的话务员数<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text13  v_must=1
             type=text size=18 value="<%=rows[0][13] %>" ></TD>
          <td noWrap>10086外语话务员数<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text14  v_must=1
             type=text size=18 value="<%=rows[0][14] %>" > </TD>
          <td noWrap><font 
            color=#0000ff>主动流失率</font><font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text15  v_must=1
             type=text size=18 value="<%=rows[0][15] %>" > </TD></TR>
        <tr class=content2>
          <td noWrap><font color=#ff0000 
            ><font color=#0f384b 
            >外包公司承接10086/12580业务的坐席数</FONT>*</FONT></TD>
          <td noWrap><input class=form1 id=text16  v_must=1
             type=text size=18 value="<%=rows[0][16] %>" ></TD>
          <td noWrap><font 
            color=#0000ff>话务拨动系数</font><font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text17  v_must=1
             type=text size=18 value="<%=rows[0][17] %>" > </TD>
          <td noWrap><font 
            color=#0000ff>总体流失率</font><font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text18  v_must=1
             type=text size=18 value="<%=rows[0][18] %>"> </TD></TR>
        <tr class=content3>
          <td noWrap>外包公司承接10086/12580业务的话务员数<font 
            color=#ff0000>*</FONT></TD>
          <td noWrap><input class=form1 id=text19  v_must=1
             type=text size=18 value="<%=rows[0][19] %>" ></TD>
          <td noWrap>系统故障次数<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text20 
             type=text size=18 value="<%=rows[0][20] %>" > </TD>
          <td noWrap><font color=#00ff00>提交日期</font><font 
            color=#ff0000>*</FONT></TD>
           <td >
			  <input id="start_date" name ="start_date" type="text" v_must=1  value="<%=rows[0][21] %>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);return false;">
		    <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});return false;" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
		    <font color="orange">*</font>
		  	</td>
		  </TR>
          
          <tr class=content3>
          <td noWrap>人均每小时电话处理量<font 
            color=#ff0000>*</FONT></TD>
          <td noWrap><input class=form1 id=text22 
             type=text size=18 value="<%=rows[0][22] %>" ></TD>
          <td noWrap>工时合理率<font color=#ff0000 
            >*</FONT></TD>
          <td noWrap><input class=form1 id=text23 
             type=text size=18 value="<%=rows[0][23] %>" > </TD>
          <td noWrap><font color=#00ff00> </font><font 
            color=#ff0000></FONT></TD>
          <td noWrap>
          </TD></TR>
          
        <tr class=content2>
          <td noWrap colSpan=6>
            <p><font color=#ff0000><strong>注：以上数据均为数字型！输入时请注意！<font 
            color=#0000ff>主动流失率</font> 、<font color=#0000ff>话务拨动系数</font>、<font 
            color=#0000ff>总体流失率</font>若为百分率制请将其转化为小数型（例：23.58%转化后为0.2358）</strong></font></p>
            <p><strong><font color=#ff0000>&nbsp;&nbsp;&nbsp; <font 
            color=#00ff00>提交日期</font>在插入数据时不能为空，以方便后面修改数据时按提交日期查询数据用</font></strong></p></TD></TR>
			<tr >
  				<td colspan="6" align="center" id="footer">
   					<input name="add" type="button" class="b_text" id="add" value="保存" onClick="modifysceTrans()">
   					<input name="clean" type="button" class="b_text" id="clean" value="重设" onClick="cleanValue()">
   					<input name="close" type="button" class="b_text" id="close" value="关闭" onClick="closeWin()">
  				</td>
			</tr>
		</table>
	</div>
</form>
</body>
</html>
<script language=javascript>
</script>