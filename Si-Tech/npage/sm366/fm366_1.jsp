<%
/********************
 version v2.0
开发商: si-tech
create by wanglm 20110321
********************/
%>	
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.util.page.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%
  request.setCharacterEncoding("GBK");
  String opCode = (String)request.getParameter("opCode");
  String opName = (String)request.getParameter("opName");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=opName%></title>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%
    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String current_timeNAME=new SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date());
		String regionCode= (String)session.getAttribute("regCode");
		String loginNoPass = (String)session.getAttribute("password");
		String ipAddrss = (String)session.getAttribute("ipAddr");

%>
  
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=regionCode%>" id="printAccept"/>
		
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>

<script type="text/javascript">
	var v_printAccept = "<%=printAccept%>";
 
function pub_set_radio(bt){
	$(bt).prev().click();
}
function show_p_div(bt,val){
	if(val=="0"){
		location = "fm366.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
	}
}



function Idcard()
{
	//读取二代身份证	

	var picName = getCuTime();
	var fso = new ActiveXObject("Scripting.FileSystemObject");  //取系统文件对象
	var tmpFolder = fso.GetSpecialFolder(0); //取得系统安装目录
	var strtemp= tmpFolder+"";
	var filep1 = strtemp.substring(0,1)//取得系统目录盘符
	var cre_dir = filep1+":\\custID";//创建目录
	//判断文件夹是否存在，不存在则创建目录
	if(!fso.FolderExists(cre_dir)) {
	var newFolderName = fso.CreateFolder(cre_dir);  
	}
	var picpath_n = cre_dir +"\\"+picName+".jpg";
	
		
	var result;
	var result2;
	var result3;
	
	result=IdrControl1.InitComm("1001");
	if (result==1)
	{
		result2=IdrControl1.Authenticate();
		if ( result2>0)
		{              
			result3=IdrControl1.ReadBaseMsgP(picpath_n); 
			if (result3>0)           
			{     
				var code = IdrControl1.GetCode();
				var xm   = IdrControl1.GetName();
				document.all.idIccid.value  = code;//身份证号
		  	document.all.custName.value = xm;
			}
			else
			{
				rdShowMessageDialog(result3); 
				IdrControl1.CloseComm();
			}
		}
		else
		{
			IdrControl1.CloseComm();
			rdShowMessageDialog("请重新将卡片放到读卡器上");
		}
	}
	else
	{
		IdrControl1.CloseComm();
		rdShowMessageDialog("端口初始化不成功",0);
	}
	IdrControl1.CloseComm();
}

function getCuTime(){
 var curr_time = new Date(); 
 with(curr_time) 
 { 
 var strDate = getYear()+"-"; 
 strDate +=getMonth()+1+"-"; 
 strDate +=getDate()+" "; //取当前日期，后加中文“日”字标识 
 strDate +=getHours()+"-"; //取当前小时 
 strDate +=getMinutes()+"-"; //取当前分钟 
 strDate +=getSeconds(); //取当前秒数 
 return strDate; //结果输出 
 } 
}


  function Idcard2(str){
			//扫描二代身份证
		var fso = new ActiveXObject("Scripting.FileSystemObject");  //取系统文件对象
		var tmpFolder = fso.GetSpecialFolder(0); //取得系统安装目录
		var strtemp= tmpFolder+"";
		var filep1 = strtemp.substring(0,1)//取得系统目录盘符
		var cre_dir = filep1+":\\custID";//创建目录
		if(!fso.FolderExists(cre_dir)) {
			var newFolderName = fso.CreateFolder(cre_dir);
		}
	var ret_open=CardReader_CMCC.MutiIdCardOpenDevice(1000);
	if(ret_open!=0){
		ret_open=CardReader_CMCC.MutiIdCardOpenDevice(1001);
	}	
	var cardType ="11";
	if(ret_open==0){

			//多功能设备RFID读取
			var ret_getImageMsg=CardReader_CMCC.MutiIdCardGetImageMsg(cardType,"c:\\custID\\cert_head_"+v_printAccept+str+".jpg");

			if(ret_getImageMsg==0){
				//二代证正反面合成
				var zjhm = CardReader_CMCC.MutiIdCardNumber; //证件号码
				var xm   = CardReader_CMCC.MutiIdCardName;		
					document.all.idIccid.value  = zjhm;//身份证号
					document.all.custName.value = xm;//身份证号
				
			}else{
					rdShowMessageDialog("获取信息失败");
					return ;
			}
	}else{
					rdShowMessageDialog("打开设备失败");
					return ;
	}
	//关闭设备
	var ret_close=CardReader_CMCC.MutiIdCardCloseDevice();
	if(ret_close!=0){
		rdShowMessageDialog("关闭设备失败");
		return ;
	}
	
}


function set_iccidIpt(){
	$("#idIccid").val("");
	if($("#id_typess").val()=="00"){//身份证只能读卡
		$("#idIccid").attr("readOnly","readOnly");
		$("#idIccid").addClass("InputGrey");
		
		//$("#custName").attr("readOnly","readOnly");
		//$("#custName").addClass("InputGrey");
		
		
		$("#scan_idCard_two222").show();
		$("#scan_idCard_two").show();
	}else{
		$("#idIccid").removeAttr("readOnly");
		$("#idIccid").removeClass("InputGrey");
		
		//$("#custName").removeAttr("readOnly");
		//$("#custName").removeClass("InputGrey");
		
		$("#scan_idCard_two222").hide();
		$("#scan_idCard_two").hide();
	}
}


function go_Query(){
	if($("#idIccid").val().trim()==""){
		rdShowMessageDialog("请输入证件号码");
		return;
	}
	
	 
 	var pactket = new AJAXPacket("fm366_PhonQuery.jsp","正在进行电子工单状态修改，请稍候......");
			pactket.data.add("opCode","<%=opCode%>");
			pactket.data.add("id_typess",$("#id_typess").val().trim());
			pactket.data.add("idIccid",$("#idIccid").val().trim());
			//pactket.data.add("custName",$("#custName").val().trim());
			core.ajax.sendPacket(pactket,do_Query);
			pactket=null;
}
// 回调
function do_Query(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){//查询成功后动态展示列表
			var retArray = packet.data.findValueByName("retArray");
			//获取数组成功，动态拼接列表
			var trObjdStr = "";
			//第二次以后查询会有多余行数据，所以删除除了title以外行的数据
			$("#upgMainTab tr:gt(0)").remove();
			
			var idType = "";
			
			var phoneQryNum = packet.data.findValueByName("phoneQryNum");
			$("#phoneQryNum").text("  手机号码数量："+phoneQryNum);
			
			if(phoneQryNum!="0"){
					for(var i=0;i<retArray.length;i++){
						
							if(retArray[i][2]=="00"){
								idType = "身份证";
							}
							
							if(retArray[i][2]=="02"){
								idType = "外国公民护照";
							}
							
							if(retArray[i][2]=="04"){
								idType = "军官证";
							}
							
							if(retArray[i][2]=="05"){
								idType = "武装警察身份证";
							}
							
							if(retArray[i][2]=="10"){
								idType = "临时居民身份证";
							}
							
							if(retArray[i][2]=="11"){
								idType = "户口簿";
							}
							
							if(retArray[i][2]=="12"){
								idType = "港澳通行证";
							}
							
							if(retArray[i][2]=="13"){
								idType = "台湾通行证";
							}
							
							if(retArray[i][2]=="99"){
								idType = "其他证件";
							}
							
							
							var j_province_code = retArray[i][4];
							var j_province_name = "";
							
							if(j_province_code == "100" ) j_province_name = "北京";
							if(j_province_code == "471" ) j_province_name = "内蒙古";
							if(j_province_code == "220" ) j_province_name = "天津";
							if(j_province_code == "531" ) j_province_name = "山东";
							if(j_province_code == "311" ) j_province_name = "河北";
							if(j_province_code == "351" ) j_province_name = "山西";
							if(j_province_code == "551" ) j_province_name = "安徽";
							if(j_province_code == "210" ) j_province_name = "上海";
							if(j_province_code == "250" ) j_province_name = "江苏";
							if(j_province_code == "571" ) j_province_name = "浙江";
							if(j_province_code == "591" ) j_province_name = "福建";
							if(j_province_code == "898" ) j_province_name = "海南";
							if(j_province_code == "200" ) j_province_name = "广东";
							if(j_province_code == "771" ) j_province_name = "广西";
							if(j_province_code == "971" ) j_province_name = "青海";
							if(j_province_code == "270" ) j_province_name = "湖北";
							if(j_province_code == "731" ) j_province_name = "湖南";
							if(j_province_code == "791" ) j_province_name = "江西";
							if(j_province_code == "371" ) j_province_name = "河南";
							if(j_province_code == "891" ) j_province_name = "西藏";
							if(j_province_code == "280" ) j_province_name = "四川";
							if(j_province_code == "230" ) j_province_name = "重庆";
							if(j_province_code == "290" ) j_province_name = "陕西";
							if(j_province_code == "851" ) j_province_name = "贵州";
							if(j_province_code == "871" ) j_province_name = "云南";
							if(j_province_code == "931" ) j_province_name = "甘肃";
							if(j_province_code == "951" ) j_province_name = "宁夏";
							if(j_province_code == "991" ) j_province_name = "新疆";
							if(j_province_code == "431" ) j_province_name = "吉林";
							if(j_province_code == "240" ) j_province_name = "辽宁";
							if(j_province_code == "451" ) j_province_name = "黑龙江";	

							
						  //如果有一条空记录不展示，服务返回数据为空字符串，服务改进后此逻辑可删除
								trObjdStr += "<tr>"+
																 "<td>"+retArray[i][0]+"</td>"+ //
																 "<td>"+retArray[i][1]+"</td>"+ //
																 "<td>"+idType+"</td>"+ //
																 "<td>"+$("#idIccid").val().trim()+"</td>"+ //查出的与输入的是一致的
																 "<td>"+j_province_name+"</td>"+ //
																 "<td>"+retArray[i][5]+"</td>"+ //
														 "</tr>";
					}
					//将拼接的行动态添加到table中
					$("#upgMainTab tr:eq(0)").after(trObjdStr);
			}

	}else{
		  rdShowMessageDialog("查询失败，"+code+"："+msg,0);
	}
}
</script>
</head>
<body>
<form name="form1" id="form1" method="POST" >
<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>

<table cellSpacing="0">
	<tr>
		<td class="blue" align="center">
			<input type="radio" id="radio_0"  value="0" name="radio_check" style="cursor:hand" onclick="show_p_div(this,'0')" />
			<span style="cursor:hand" onclick="pub_set_radio(this)">本省开户信息</span>
			&nbsp;&nbsp;
			<input type="radio" id="radio_1" checked value="1" name="radio_check" style="cursor:hand" onclick="show_p_div(this,'1')" />
			<span style="cursor:hand" onclick="pub_set_radio(this)">全国开户信息</span>
		</td>
	</tr>
</table>

<table  cellSpacing="0">
  <tr>
    <td class='blue' width="15%">证件类型</td>
    <td   width="35%">
    	<!-- 此证件类型为集团公司规范的类型一致按照规范进行写死，不是数据库中的数据 -->
	    <select align="left" id="id_typess" name="id_typess"  width=50 onchange="set_iccidIpt()">

					<option value="00" selected>身份证</option>
					<option value="02">外国公民护照</option>
		    	<option value="04">军官证</option>
		    	<option value="05">武装警察身份证</option>
		    	<option value="11">户口簿</option>
		    	<option value="12">港澳通行证</option>
		    	<option value="13">台湾通行证</option>
		    	<option value="99">其他证件</option>
		    	
			</select>
			
			 &nbsp;<input type="button" id="scan_idCard_two" class="b_text"   value="读卡" onClick="Idcard()" >
      &nbsp;<input type="button" id="scan_idCard_two222"   class="b_text"   value="读卡(2代)" onClick="Idcard2('1')" >
      
      
    	</td> 
     
    		<td class="blue"  width="15%">证件号码</td>
    		<td>
      		<input name="idIccid"  id="idIccid"   value=""   readOnly class="InputGrey" />
      	</td> 		
		        
    </tr>  

</table> 

<div class="title"><div id="title_zi">查询结果列表<span id="phoneQryNum"></span></div></div>
<TABLE cellSpacing="0" id="upgMainTab">
    <tr>
        <th>手机号码</th>
        <th>客户姓名</th>
        <th>证件类型</th>
        <th>证件号码</th>
        <th>归属省代码</th>
        <th>业务生效时间</th>
    </tr>
</table>

<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="查询" onclick="go_Query()"          />
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>


    <%@ include file="/npage/include/footer_simple.jsp"%>
   </form>
</body>
<OBJECT id="CardReader_CMCC" height="0" width="0"  classid="clsid:FFD3E742-47CD-4E67-9613-1BB0D67554FF" codebase="/npage/public/CardReader_AGILE.cab#version=1,0,0,6"></OBJECT>
<OBJECT classid="clsid:341162BA-3754-448C-BE54-EC34D82D5105" id="objIDCard"  width="0" height="0"></OBJECT>
<OBJECT classid="clsid:5EB842AE-5C49-4FD8-8CE9-77D4AF9FD4FF" id="IdrControl1" width="0" height="0"></OBJECT>
</html>