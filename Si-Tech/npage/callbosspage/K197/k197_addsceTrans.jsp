<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * 功能: 特殊名单
　 * 版本: 1.0.0
　 * 日期: 2009/10/28
　 * 作者: yinzx
　 * 版权: sitech
   *
　 */
%>

<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
String boss_login_no =  request.getParameter("boss_login_no");
%>
<html>
<head>
<title>新增特殊名单</title>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/csp/checkWork_dialog.js"></script>
<script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js"></script>
<script language=javascript>

/**
  *
  */
function addsceTrans(){
	var SPECIALTYPE_ID=document.getElementById('SPECIALTYPE_ID').value;


	if(SPECIALTYPE_ID=="" )
	{
		  	rdShowMessageDialog("特殊名单类型不能为空");
		  	return false;
	}

	if(!check(sitechform))
	{
		return false;
	}

	var xinval="";
	var yinval="";

	for(var i=0;i<6;i++)
	{
			 xinval+=$("input")[i].value+",";
  }

  for(var i=0;i<3;i++)
	{
			 yinval+=$("select")[i].value+",";
  }

	var packet = new AJAXPacket("k197_sceTrans_rpc.jsp","...");
	packet.data.add("retType","addsceTrans");
	packet.data.add("addvalxin" ,xinval);
	packet.data.add("addvalyin" ,yinval);
	packet.data.add("addvalzhi" ,document.getElementById("messegecontent").value);



	core.ajax.sendPacket(packet,doProcessaddsceTrans,true);
	packet=null;
}

//added by tangsong 20100613 验证是否存在该手机号码的特殊名单记录
//begin
function checkRecordValid() {
	var packet = new AJAXPacket("checkRecordValid.jsp","...");
	packet.data.add("phone_no", document.getElementById("ACCEPT_PHONE").value);
	core.ajax.sendPacket(packet,doProcessCheck,true);
	packet=null;
}

function doProcessCheck(packet) {
	var isExist = packet.data.findValueByName("isExist");
	if (isExist) {
  	rdShowMessageDialog("已存在该号码的特殊名单，无法添加");
	} else {
		addsceTrans();
	}
}
//end
/**
  *返回处理函数
  */
function doProcessaddsceTrans(packet) {
	var retType = packet.data.findValueByName("retType");
	var retCode = packet.data.findValueByName("retCode");

	if (retCode == "000000") {
		rdShowMessageDialog("新增特殊名单数据成功！");
		opener.document.location.replace("result.jsp");
    closeWin();
	} else {
		rdShowMessageDialog("新增特殊名单数据失败！");

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

function tochange()
{
		var SPECIALTYPE_ID = document.all.SPECIALTYPE_ID[document.all.SPECIALTYPE_ID.selectedIndex].value;
		var myPacket = new AJAXPacket("select_rpc.jsp","正在获得信息，请稍候......");
		//update by tangsong 20100501 应该截前两位
		//var sqlStr = "  select  funcid SPECIALTYPE_ID, funcname SPECIALTYPE_name from scallspeciallist where is_leaf='Y' and is_del='N' and substr(funcid,0,1)= :SPECIALTYPE_ID    order by SPECIALTYPE_ID    ";
		var sqlStr = "  select  funcid SPECIALTYPE_ID, funcname SPECIALTYPE_name from scallspeciallist where is_leaf='Y' and is_del='N' and substr(funcid,0,2)= :SPECIALTYPE_ID    order by SPECIALTYPE_ID    ";
    var para="SPECIALTYPE_ID="+SPECIALTYPE_ID;
		myPacket.data.add("sqlStr",sqlStr);
		myPacket.data.add("para",para);
		core.ajax.sendPacket(myPacket);
		myPacket=null;
}


 function doProcess(packet)
  {
	  var triListData = packet.data.findValueByName("tri_list");
	  var triList=new Array(triListData.length);

       document.all("6_=_GRADE_CODE").length=0;
			  document.all("6_=_GRADE_CODE").options.length=triListData.length  ;//triListData[i].length;

			  for(j=0;j<triListData.length;j++)
			  {

				document.all("6_=_GRADE_CODE").options[j].text=triListData[j][1];
				document.all("6_=_GRADE_CODE").options[j].value=triListData[j][0];
			  }
			  document.all("6_=_GRADE_CODE").options[0].selected=true;

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

<body onload="tochange()" >
	<%
	  String org_code = (String)session.getAttribute("orgCode");
 	  String regionCode = org_code.substring(0,2);
 	  String workName = (String)session.getAttribute("workName");
	%>
<form id="sitechform" name="sitechform">
	<div id="Operation_Table">
		<div class="title"><div id="title_zi">新增特殊名单数据</div></div>
		<table>
	      <tr>
      <td class="blue" >特殊客户类别</td>
      <td>
				<select id="SPECIALTYPE_ID" name="SPECIALTYPE_ID"  onChange="tochange()">
		      <wtc:qoption name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				    <wtc:sql>
					       select  funcid SPECIALTYPE_ID, funcname SPECIALTYPE_name from scallspeciallist where is_leaf='N' and is_del='N'      order by SPECIALTYPE_ID
					 </wtc:sql>
				   </wtc:qoption>
        </select>
      </td>
     </tr>
		 <tr>
      <td class="blue"> 申请人帐号 </td>
      <td>
			  <input id="SQ_LOGIN_NO" name ="1_=_SQ_LOGIN_NO" type="text" v_must="1" >
		  </td>
		 </tr>
		 <tr>
		   <td class="blue"> 操作人 </td>
      <td >
      	<%//updated by tangsong 20100531 操作人为当前登录工号
      		String workNo = (String)session.getAttribute("workNo");
      	%>
			  <input id="OP_LOGIN_NO" name ="2_=_OP_LOGIN_NO" type="text" value="<%=(workNo==null)?"":workNo%>" readonly="readonly"  >
		  </td>
			</tr>

		 <tr>
			 <td class="blue"> 受理号码 </td>
      <td   >
			  <input id="ACCEPT_PHONE" name ="3_=_ACCEPT_PHONE" type="text" v_must="1" onkeyup="value=value.replace(/[^\d]/g,'');queryCstmMsg(this)" >


		  </td>
		</tr>
		<tr>

		  <td class="blue"> 客户名称 </td>
      <td   >
			  <input id="CUST_NAME" name ="4_like_CUST_NAME" type="text" readonly="readonly"  >


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

	 	<tr>

			 <td class="blue"> 客户类别等级 </td>
      <td  >
			  <select name="6_=_GRADE_CODE"   >
			  </select>


		  </td>

		</tr>
		<tr>
		  <td class="blue"> 有效起始时间 </td>
      <td>
			   <input id="start_date" name ="start_date" v_must="1" type="text"  value="" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);return false;">
		    <img onclick="WdatePicker({el:$dp.$('start_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});return false;" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">
      	 <script>
      	 	//added by tangsong 20100531 起始时间默认为当前时刻
      	 	var d = new Date();
      	 	var s = d.getYear() + "";
      	 	if (d.getMonth() < 9)
      	 		s += "0" + (d.getMonth() + 1);
      	 	else
      	 		s += (d.getMonth() + 1);
      	 	if (d.getDate() < 10)
      	 		s += "0" + d.getDate();
      	 	else
      	 		s += d.getDate();
      	 	if (d.getHours() < 10)
      	 		s += " 0" + d.getHours() + ":";
      	 	else
      	 		s += " " + d.getHours() + ":";
      	 	if (d.getMinutes() < 10)
      	 		s += "0" + d.getMinutes() + ":";
      	 	else
      	 		s += d.getMinutes() + ":";
      	 	if (d.getSeconds() < 10)
      	 		s += "0" + d.getSeconds();
      	 	else
      	 		s += d.getSeconds();
      	 	document.getElementById("start_date").value = s;
      	 </script>
		  </td>
		  </tr>
		 <tr>
      <td class="blue" >有效结束时间</td>
      <td>
				 <input id="end_date" name ="end_date"  v_must="1" type="text"  value="" onclick="WdatePicker({dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});hiddenTip(document.sitechform.start_date);return false;">
		    <img onclick="WdatePicker({el:$dp.$('end_date'),dateFmt:'yyyyMMdd HH:mm:ss',position:{top:'under'}});return false;" src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/skin/datePicker.gif" width="16" height="22" align="absmiddle">

      </td>
		</tr>

		<tr>
  				<td class="blue">加入原因 </td>
  				<td   width="70%">
  					<textarea id="messegecontent" name="messegecontent" cols="40" rows="8"  value="" ></textarea>
	  			</td>
	 </tr>
			<tr >
  				<td colspan="4" align="center" id="footer">
  				<!-- updated by tangsong 20100613 先验证是否存在该手机号的特殊名单记录，如果不存在才添加
   					<input name="add" type="button" class="b_text" id="add" value="添加" onClick="addsceTrans()">
   				-->
   				  <input name="add" type="button" class="b_text" id="add" value="添加" onClick="checkRecordValid()">
   				<!--	<input name="clean" type="button" class="b_text" id="clean" value="重设" onClick="cleanValue()">  -->
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