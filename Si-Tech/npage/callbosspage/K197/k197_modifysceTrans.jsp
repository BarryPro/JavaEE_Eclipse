<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * 功能: 人工转自动-转业务咨询维护结点数据
　 * 版本: 1.0.0
　 * 日期: 2009/08/07
　 * 作者: yinzx
　 * 版权: sitech
   * 
　 */
%>

<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    /*midify by yinzx 20091113 公共查询服务替换*/
    String myParams="";
    String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
String sceid =  request.getParameter("sceid");
String accesscode =  request.getParameter("accesscode"); 
String ycitycode =  request.getParameter("citycode"); 
String digitcode =  request.getParameter("digitcode");
  
String serSql="select  ACCEPT_PHONE,CUST_NAME,specialtype_id,GRADE_CODE,to_char(end_date,'yyyymmdd hh24:mi:ss'),nvl(SQ_LOGIN_NO,' '),nvl(op_login_no,' '),nvl(reason,' ')  from dcallspeciallist a   where specialid= :sceid " ;
myParams="sceid="+sceid;
String citycodeSql="select  city_code,region_name from scallregioncode where valid_flag='Y'  order by region_code  ";
 
String specialtypeSql=" select  funcid SPECIALTYPE_ID, funcname SPECIALTYPE_name from scallspeciallist where is_leaf='N' and is_del='N'      order by SPECIALTYPE_ID    ";
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="8">
	<wtc:param value="<%=serSql%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="rows" scope="end" />
	

 
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
	<wtc:param value="<%=citycodeSql%>"/>
</wtc:service>
<wtc:array id="citycode" scope="end" />
	
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
	<wtc:param value="<%=specialtypeSql%>"/>
</wtc:service>
<wtc:array id="specialtype" scope="end" /> 
	
<html>
<head>
<title>修改特殊名单数据</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script language=javascript>
	
/**
  * 
  */
function modifysceTrans(){
	 
	var end_date=document.getElementById('end_date').value;
	
 
	if(end_date=="" )
	{ 
		  	rdShowMessageDialog("有效结束数据不能为空！");	
		  	return;
	}
	 
	var xinval="";
	var yinval="";
  
	for(var i=0;i<5;i++)
	{
			 xinval+=$("input")[i].value+",";
 
  }
  
  xinval+= $("textarea")[0].value+",";
 
  for(var i=0;i<1;i++)
	{
			 yinval+=$("select")[i].value+",";
 
  }
   
   
	var packet = new AJAXPacket("k197_sceTrans_rpc.jsp","...");
	packet.data.add("retType","modifysceTrans");
	packet.data.add("addvalxin" ,xinval);
	packet.data.add("addvalyin" ,yinval);
	packet.data.add("sceid" ,"<%=sceid%>");




	
	core.ajax.sendPacket(packet,doProcessmodsceTrans,true);
	packet=null;
}

//added by tangsong 20100613 验证是否存在该手机号码的特殊名单记录
//begin
function checkRecordValid() {
	var packet = new AJAXPacket("checkRecordValid.jsp","...");
	var phone_no = document.getElementById("ACCEPT_PHONE").value;
	if (phone_no == "<%=rows[0][0]%>") {
		modifysceTrans();
		return;
	}
	packet.data.add("phone_no", phone_no);
	core.ajax.sendPacket(packet,doProcessCheck,true);
	packet=null;
}

function doProcessCheck(packet) {
	var isExist = packet.data.findValueByName("isExist");
	if (isExist) {
  	rdShowMessageDialog("已存在该号码的特殊名单，无法保存");
	} else {
		modifysceTrans();
	}
}
//end

/**
  *返回处理函数
  */
function doProcessmodsceTrans(packet) {
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");

	if (retCode == "000000") {
		rdShowMessageDialog("修改特殊名单数据成功！");	
		opener.document.location.replace("result.jsp");	
    closeWin();
   
	} else {
		rdShowMessageDialog("修改特殊名单数据失败！");

	}
}

 

// 清除表单记录
function cleanValue(){
  
}

function closeWin(){
	window.close();
}

function initValue(){

}

//added by tangsong 20100607 查询显示客户姓名和地址
//begin
var old_phone; //记录电话号码，如果新号码与原号码相同，则不查询
function queryCstmMsg(obj) {
	if (obj.value.length != 11) {
		document.getElementById("CUST_NAME").value = "";
		document.getElementById("CITY_CODE").value = "";
	}
	if (old_phone == obj.value) {
		return;
	}
	old_phone = obj.value;
	var myPacket = new AJAXPacket("queryCstmMsg.jsp","正在获得信息，请稍候......");
	myPacket.data.add("phone_no",obj.value);
	core.ajax.sendPacket(myPacket,showCstmMsg,true);
	myPacket=null;
}

function showCstmMsg(packet) {
	var cust_name = packet.data.findValueByName("cust_name");
	var city_code = packet.data.findValueByName("city_code");
	document.getElementById("CUST_NAME").value = cust_name;
	document.getElementById("CITY_CODE").value = city_code;
}
//end
</script>
</head>

<body >
<form id=sitechform name=sitechform>
	<div id="Operation_Table">
		<div class="title"><div id="title_zi">修改特殊名单数据</div></div>
		<table>
		 
			    <tr>
      <td class="blue" >特殊客户类别</td>
      <td>
				<select id="SPECIALTYPE_ID" name="0_=_SPECIALTYPE_ID"  readonly>
		      <%
      			    for(int i=0;i<specialtype.length;i++)
      					{
      						String flag="";
      						if(rows[0][2].trim().equals(specialtype[i][0].trim()))
      						{
      						
      							flag="selected";
      							out.println("<option value="+specialtype[i][0].trim()+" "+flag+">"+specialtype[i][1]+"</option>");      	
      						}
      	          
      										
      					}
      				%>	
        </select>
      </td>
     </tr>
		 <tr>  
      <td class="blue"> 申请人帐号 </td>
      <td>
			  <input id="SQ_LOGIN_NO" name ="1_=_SQ_LOGIN_NO" type="text"   value="<%=rows[0][5] %>" >
		    
 
		  </td> 
		 </tr>
		 <tr> 
		   <td class="blue"> 操作人 </td>
      <td >
			  <input id="OP_LOGIN_NO" name ="2_=_OP_LOGIN_NO" type="text"  value="<%=rows[0][6] %>"  >
		    
 
		  </td> 
		      
		 
			</tr>
		 <tr> 
			 <td class="blue"> 受理号码 </td>
      <td   >
			  <input id="ACCEPT_PHONE" name ="3_=_ACCEPT_PHONE" type="text"  value="<%=rows[0][0] %>" onkeyup="value=value.replace(/[^\d]/g,'');queryCstmMsg(this)" >
		    <script type="text/javascript">
		    	queryCstmMsg(document.getElementById("ACCEPT_PHONE"));
		    </script>
 
		  </td> 
		</tr>
		<tr>
		  
		  <td class="blue"> 客户名称 </td>
      <td   >
			  <input id="CUST_NAME" name ="4_like_CUST_NAME" type="text"    value="<%=rows[0][1] %>" readonly="readonly" >
		    
 
		  </td> 
		 </tr>
		 
		 <tr>
      <td class="blue" >业务地市</td>
      <td>
				<select id="CITY_CODE" name="5_=_CITY_CODE" disabled="disabled" >
		      <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				    <wtc:sql>
								  select  city_code,region_name from scallregioncode where valid_flag='Y'    order by city_code  desc  </wtc:sql>
				   </wtc:qoption>
        </select>
      </td>
		</tr>
		
	<!--	<tr>
			
			 <td class="blue"> 客户级别 </td>
      <td   >
			  <input id="GRADE_CODE" name ="6_=_GRADE_CODE" type="text"   >
		    
 
		  </td> 
		 
		</tr>   -->
	 
		 <tr> 
      <td class="blue" >有效结束时间</td>
      <td>
				 <input id="end_date" name ="end_date" type="text" v_must="1" value="<%=rows[0][4] %>" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);return false;">
		    <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});return false;" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
 
      </td>  
		</tr>
		
		<tr>
  				<td class="blue">加入原因 </td>
  				<td   width="70%">
  					<textarea id="messegecontent" name="messegecontent" cols="40" rows="8"  value=""  ><%=rows[0][7]%></textarea>
	  			</td>
	 </tr>
			<tr >
  				<td colspan="2" align="center" id="footer">
  				<!-- updated by tangsong 20100613 先验证是否存在该手机号的特殊名单记录，如果不存在才保存
   					<input name="add" type="button" class="b_text" id="add" value="保存" onClick="modifysceTrans()">
   				-->
   					<input name="add" type="button" class="b_text" id="add" value="保存" onClick="checkRecordValid()">
   			 	<!--	<input name="clean" type="button" class="b_text" id="clean" value="重设" onClick="cleanValue()"> -->
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