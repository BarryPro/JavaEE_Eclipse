<%
  /*
   * 功能: 动感地带M值兑换1299
   * 版本: 1.8.2
   * 日期: 2003-12-08 
   * 作者: yuanby
   * 版权: si-tech
   * update:leimd@2008-12-1
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ include file="../../npage/public/fPubPrintNote.jsp" %>

<%!
//    ArrayList retArray = new ArrayList();
//    String[][] result = new String[][]{};
//    S1100View callView = new S1100View();
%>
<%
	Logger logger = Logger.getLogger("f1250_1.jsp");
//    ArrayList arr = (ArrayList)session.getAttribute("allArr");
//    String[][] baseInfo = (String[][])arr.get(0);
//    String[][] agentInfo = (String[][])arr.get(2);
//    String workNo = baseInfo[0][2];
//    String nopass = "111111";
//    String workName = baseInfo[0][3];
//    String Role = baseInfo[0][5];
//    String Department = baseInfo[0][16];
//    String regionCode = (baseInfo[0][16]).substring(0,2);
//    String OrgCode = Department;
//    String sop_code = "1299";
//    String ip_Addr = agentInfo[0][2];
//    String deptCode = agentInfo[0][3];
//    String powerName = agentInfo[0][4];
//    String townName = agentInfo[0][6];
//	  String rpt_right = agentInfo[0][6];
//	  String org_code = agentIn[16];

	  String workNo = (String)session.getAttribute("workNo");
	  String nopass = "111111";
	  String OrgCode = (String)session.getAttribute("orgCode");
	  String regionCode = (String)session.getAttribute("regCode");
	  String sop_code = "1299";
	  String ip_Addr = (String)session.getAttribute("ipAddr");
	  String opCode = request.getParameter("op_code");
	  
//    int recordNum=0;
//    int j=0;
    
    String dateStr=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
    /* 业务变量 */
//  String sqlStr = "";
    String passflag = "1";

    String pass = "";
    
// 	String paraStr[]=new String[1];
//	   comImpl co1=new comImpl();
	   String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
//	   paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();
%>
    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2">
    	<wtc:sql><%=prtSql%>
    	</wtc:sql>
	</wtc:pubselect>
	<wtc:array id="paraStr" scope="end"/>
<%
	   System.out.println("11111111111：" +paraStr[0]);

%>

<%
  request.setCharacterEncoding("GBK");

  HashMap hm=new HashMap();
  hm.put("1","没有客户ID！");
  hm.put("3","密码错误！");
  hm.put("4","手续费不确定，您不能进行任何操作！");
  
  hm.put("2","未取到数据1，请核查数据或咨询系统管理员！");
  hm.put("10","未取到数据2，请核查数据或咨询系统管理员！");
  hm.put("11","未取到数据3，请核查数据或咨询系统管理员！");
  hm.put("12","未取到数据4，请核查数据或咨询系统管理员！");
  hm.put("13","未取到数据5，请核查数据或咨询系统管理员！");
  hm.put("14","未取到数据6，请核查数据或咨询系统管理员！");
  String opName="";
  
  //System.out.println("op_code === "+ op_code );
  //op_code="1250";
 
  if(opCode.equals("1220"))
    opName="换卡变更";
  else if(opCode.equals("1217"))
    opName="预销恢复";
  else if(opCode.equals("1260"))
    opName="预拆恢复";
  else if(opCode.equals("2419"))
    opName="积分转赠业务受理";
  else if(opCode.equals("1296"))
    opName="动感地带积分转赠";
  else if(opCode.equals("1250"))
    opName="积分兑奖";
  else if(opCode.equals("1221"))
    opName="换卡冲正";
  else if(opCode.equals("1353"))
    opName="工单补打";
  else if(opCode.equals("1290"))
    opName="身份证挂失";
  else if(opCode.equals("1291"))
    opName="手机证券申请";
  else if(opCode.equals("1295"))
    opName="手续费";
  else if(opCode.equals("1299"))
    opName="动感地带M值兑换";
  else if(opCode.equals("2420"))
    opName="积分转赠业务冲正";
  else if(opCode.equals("2421"))
    opName="改号通知业务";
  else if(opCode.equals("1442"))
    opName="SIM卡营销";
  else if(opCode.equals("1445"))
    opName="全球通签约计划";
  else if(opCode.equals("1448"))
    opName="邮寄帐单";
  else if(opCode.equals("7114"))
    opName="详单查询短信提醒";
  else if(opCode.equals("1458"))
    opName="信息收集";
  else if(opCode.equals("1469"))
    opName="全网sp业务退费";
  else if(opCode.equals("7115"))
    opName="商务电话免费换机";
  else if(opCode.equals("2299"))
    opName="二代身份证读卡器设置";
  else if(opCode.equals("1499"))
    opName="数据业务付奖类型维护";
  else if(opCode.equals("1451"))
    opName="电子帐单受理";
  else if(opCode.equals("1452"))
    opName="二代身份证";
  else if(opCode.equals("5036"))
    opName="客服系统套餐配制";
  else if(opCode.equals("5037"))
    opName="卡类费用查询";
  else if(opCode.equals("1577"))
    opName="彩信核检话单查询";
  else if(opCode.equals("1446"))
    opName="改号通知";
  else if(opCode.equals("1440"))
    opName="新业务兑奖";
  else if(opCode.equals("5118"))
    opName="数据业务付奖";
  else if(opCode.equals("1449"))
    opName="全球通签约计划冲正";
  else if(opCode.equals("1450"))
    opName="积分兑换冲正";
  else if(opCode.equals("1443"))
    opName="四季有礼";
  else if(opCode.equals("2267"))
    opName="手机用户实名预登记查询/确认";
  else if(opCode.equals("2266"))
    opName="促销品统一付奖";
  else if(opCode.equals("2849"))
    opName="垃圾短信集团反馈结果信息查询";
  else if(opCode.equals("5303"))
    opName="工号登陆短信提醒配置";
  else if(opCode.equals("5309"))
    opName="工号登陆短信提醒配置历史查询";
%>

<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
	<title><%=opName%></title>
<%
	//String opCode = "1299";
	//String opName = "动感地带M值兑换";
	String phone_no = (String)request.getParameter("activePhone");
%>	
</head>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<%@ include file="../../npage/common/pwd_comm.jsp" %>
<script type=text/javascript>
//core.loadUnit("debug");
//core.loadUnit("ajaxcore");
var FavourCode;
var iFavourCount;

onload=function(){
	//core.ajax.onreceive = doProcess;
}

//---------1------RPC处理函数------------------
function doProcess(packet)
{
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
    var retMessage = packet.data.findValueByName("retMessage");
    //alert("luxc:"+retType+"|"+retCode+"|"+retMessage);
    if(retType == "call_s1250Init")
    {
        //读取原有库中数量
        if(retCode=="000000")
        {
            var iCount = packet.data.findValueByName("iCount");
			//alert("iCount = " + iCount);
            var retFavourCode = packet.data.findValueByName("FavourCode");
            var retCust_name = packet.data.findValueByName("Cust_name");
            var retRun_name = packet.data.findValueByName("Run_name");
            var retSm_name = packet.data.findValueByName("Sm_name");
            var retId_name = packet.data.findValueByName("Id_name");
            var retId_iccid = packet.data.findValueByName("Id_iccid");
            var retGrade_code = packet.data.findValueByName("Grade_code");
            var retGrade_name = packet.data.findValueByName("Grade_name");
            var retCurrent_point = packet.data.findValueByName("Current_point");
            var totalUsedPoint = packet.data.findValueByName("totalUsedPoint");
			var id_address = packet.data.findValueByName("id_address");
            document.frm1250.Ed_CustNane.value = retCust_name;
            document.frm1250.Ed_RunName.value = retRun_name;
            document.frm1250.Ed_SmCode.value = retSm_name;
            document.frm1250.Ed_Id_type.value = retId_name;
            document.frm1250.Ed_Id_iccid.value = retId_iccid;
            document.frm1250.Ed_Grade_name.value = retGrade_name;
            document.frm1250.Ed_Current_point.value = retCurrent_point;
            document.frm1250.init_user_point.value = retCurrent_point;
            document.frm1250.Ed_UsedCount.value = '1';
			document.frm1250.Ed_totalUsedPoint.value = totalUsedPoint;
			document.frm1250.Ed_address.value = id_address;
            var temLength = retFavourCode.length+1;
	    	var arr = new Array(temLength);

            if(document.frm1250.Ed_Favour_point.value != "")
            {
            	var a = parseInt(document.frm1250.Ed_UsedCount.value,10) ;
    			var b = parseInt(document.frm1250.Ed_Favour_point.value,10) ;
    			var c = a*b;
				document.frm1250.consumeFee.value= c;
            }
            else
            {
            	document.frm1250.consumeFee.value=""
            }
            frm1250.print.disabled = false;

        }
        else
        {
            retMessage = retMessage + "[errorCode:" + retCode + "]";
            rdShowMessageDialog(retMessage,0);
            return;
        }
    }
   	else if(retType=="s1299Init")
    {
    	var retCode = packet.data.findValueByName("retCode");
    	var retMsg 	= packet.data.findValueByName("retMsg");
		var grade_name = packet.data.findValueByName("grade_name");

		if(retCode == 0)
		{
			document.all.grade_name.value = grade_name;
		}
		else
		{
			rdShowMessageDialog("错误:"+ retCode + "->" + retMsg);
			return;
		}
    }
    else if(retType=="chg_giftclasscode")
    {
    	if(retCode == 0)
		{
			var arr_Favour_code=packet.data.findValueByName("code_Array");
			var arr_Favour_name=packet.data.findValueByName("name_Array");
			var retFavourCode = packet.data.findValueByName("FavourCode");
			document.all.Sel_Favour_name.options.length=0;
			for(var i=0; i<arr_Favour_code.length;i++)
    		{
     	 		var option = new Option(arr_Favour_name[i],arr_Favour_code[i]);
      			document.all.Sel_Favour_name.add(option);
   			}
   			//全局变量赋值
   			FavourCode = new Array(arr_Favour_code.length);
   			iFavourCount = arr_Favour_code.length;
            for (var i = 0; i< arr_Favour_code.length ;i++)
            {
                FavourCode[i] = new Array(8);
                FavourCode[i][0] = retFavourCode[i][0];
                FavourCode[i][1] = retFavourCode[i][1];
                FavourCode[i][2] = retFavourCode[i][2];
				FavourCode[i][3] = retFavourCode[i][3];
				FavourCode[i][4] = retFavourCode[i][4];
				FavourCode[i][5] = retFavourCode[i][5];
				FavourCode[i][6] = retFavourCode[i][6];
				FavourCode[i][7] = retFavourCode[i][7];
				FavourCode[i][8] = retFavourCode[i][8];
            }
            change_Favour();
		}
    	else
		{
			rdShowMessageDialog("错误:"+ retCode + "->" + retMsg);
			return;
		}
    }
}

function dynDelRow(){
	var bb=parseInt(frm1250.lines.value);
	if( bb<=1){
		rdShowMessageDialog("最后一行不许删除！！");
	  return false;
  }else{
		dyntb.deleteRow();
		document.frm1250.inp.disabled=false;
		document.frm1250.lines.value=bb-1;
	}
	//frm1250.lines.value=bb-1;
	frm1250.lines_sum.value=bb+1;
	redo_cal();
}

function dynAddRow(){
	if (frm1250.giftclasscode.value==null){
		rdShowMessageDialog("请选择兑换物品类别!");
	  return false;
	}

	if (document.frm1250.Sel_Favour_name.value=="" ){
		rdShowMessageDialog("没有要兑换的物品");
	  return false;
	}

	if (parseInt(document.frm1250.Ed_Current_point.value) - parseInt(document.frm1250.consumeFee.value) <0){
		rdShowMessageDialog("当前M值不够兑换物品");
		return false;
	}

	frm1250.lines.value=parseInt(frm1250.lines.value)+1;
	frm1250.lines_sum.value=parseInt(frm1250.lines_sum.value)+1;
	var tr1=dyntb.insertRow();
	tr1.id="tr";
	tr1.insertCell().innerHTML = '<td> <div align=center><input type=button name="del_line" size=4 value=× onClick="dynDelRow()"></div></td>';
 	tr1.insertCell().innerHTML = '<td> <div align=center><input type=text readonly name="goods_name" size=14 class=button  value='+document.all.Sel_Favour_name.options[document.all.Sel_Favour_name.options.selectedIndex].text+'></div></td>';
  tr1.insertCell().innerHTML = '<td> <div align=center><input type=text readonly name="goods_code" size=14 class=button  value='+document.all.Sel_Favour_name.options[document.all.Sel_Favour_name.options.selectedIndex].value+'></div></td>';
  tr1.insertCell().innerHTML = '<td> <div align=center><input type=text readonly name="goods_sum"  size=6  class=button value='+document.all.Ed_UsedCount.value+'></div></td>';
  tr1.insertCell().innerHTML = '<td> <div align=center><input type=text readonly name="goods_consumed" size=20 class=button value='+document.all.consumeFee.value+'></div></td>';

	if (7<=parseInt(frm1250.lines.value)){
		document.frm1250.inp.disabled=true;
	}
	redo_cal();
}

function redo_cal(){
  var varAllConsumed = 0;
  //兑换物品代码 总串
  document.frm1250.Sel_Favour_name_all.value = "";

 	if (parseInt(frm1250.lines.value)==1){
 		if (parseInt(frm1250.lines_sum.value) > 1){
			varAllConsumed = parseInt(varAllConsumed) + parseInt(document.frm1250.goods_consumed[0].value);
			document.frm1250.Sel_Favour_name_all.value = document.frm1250.goods_code[0].value;
			document.frm1250.Ed_UsedCount_all.value = parseInt(document.frm1250.goods_sum[0].value);
			document.frm1250.Ed_Favour_point_all.value = parseInt(document.frm1250.goods_consumed[0].value)/parseInt(document.frm1250.goods_sum[0].value);
			document.frm1250.Ed_Favour_point_this.value = parseInt(document.frm1250.goods_consumed[0].value);
		}else{
			varAllConsumed = parseInt(varAllConsumed) + parseInt(document.frm1250.goods_consumed.value);
			document.frm1250.Sel_Favour_name_all.value = document.frm1250.goods_code.value;
			document.frm1250.Ed_UsedCount_all.value = parseInt(document.frm1250.goods_sum.value);
			document.frm1250.Ed_Favour_point_all.value = parseInt(document.frm1250.goods_consumed.value)/parseInt(document.frm1250.goods_sum.value);
			document.frm1250.Ed_Favour_point_this.value = parseInt(document.frm1250.goods_consumed.value);
		}
 	}else{
  	for (var i=0;i< parseInt(document.frm1250.goods_code.length);i++) {
			varAllConsumed = parseInt(varAllConsumed) + parseInt(document.frm1250.goods_consumed[i].value);
			if (0 == i){
				document.frm1250.Ed_Favour_point_all.value = parseInt(document.frm1250.goods_consumed[i].value)/document.frm1250.goods_sum[i].value;
				document.frm1250.Ed_Favour_point_this.value = parseInt(document.frm1250.goods_consumed[i].value);
			}else{
				document.frm1250.Ed_Favour_point_all.value = document.frm1250.Ed_Favour_point_all.value + "|" + parseInt(document.frm1250.goods_consumed[i].value)/document.frm1250.goods_sum[i].value;
				document.frm1250.Ed_Favour_point_this.value = parseInt(document.frm1250.Ed_Favour_point_this.value) + parseInt(document.frm1250.goods_consumed[i].value);
			}
			if (0 == i){
				document.frm1250.Sel_Favour_name_all.value = document.frm1250.goods_code[i].value;
			}else{
				document.frm1250.Sel_Favour_name_all.value = document.frm1250.Sel_Favour_name_all.value + "|" + document.frm1250.goods_code[i].value;
			}
			if (0 == i){
				document.frm1250.Ed_UsedCount_all.value = document.frm1250.goods_sum[i].value;
			}else{
				document.frm1250.Ed_UsedCount_all.value = document.frm1250.Ed_UsedCount_all.value + "|" + document.frm1250.goods_sum[i].value;
			}
		}
	}

	//当前M值
	document.frm1250.Ed_Current_point.value=parseInt(document.frm1250.init_user_point.value) - parseInt(varAllConsumed);
	//消费后经验值
	document.frm1250.Ed_vFavMoney.value=parseInt(document.frm1250.Ed_totalUsedPoint.value) + parseInt(varAllConsumed);
}

function s1250Init()
{
    //读取原有库中数量
    if (checkPhone() != true)
    {
        return false;
    }

    document.frm1250.Ed_Phone_no.readOnly=true;
    var s1250Init_Packet = new AJAXPacket("s1250Init.jsp","正在验证密码，请稍候......");

    s1250Init_Packet.data.add("retType","call_s1250Init");
    s1250Init_Packet.data.add("region_code","<%=regionCode%>");
    s1250Init_Packet.data.add("OrgCode","<%=OrgCode%>");
	s1250Init_Packet.data.add("op_code","1299");

    s1250Init_Packet.data.add("phone_no",document.frm1250.Ed_Phone_no.value);
    s1250Init_Packet.data.add("user_pass",document.frm1250.Ed_UserPass.value);
    s1250Init_Packet.data.add("PassFlag","<%=passflag%>");
    core.ajax.sendPacket(s1250Init_Packet);
    s1250Init_Packet = null;
}

function s1299Init()
{
    var s1299Init_Packet = new AJAXPacket("s1299Init.jsp","正在验证密码，请稍候......");
    s1299Init_Packet.data.add("retType","s1299Init");
    s1299Init_Packet.data.add("Grade_num",document.frm1250.Grade_num.value);
    core.ajax.sendPacket(s1299Init_Packet);
    s1299Init_Packet=null;
}

function checkPhone()
{
    if(document.frm1250.Ed_Phone_no.value == "")
    {
        rdShowMessageDialog("请输入手机号码！",0);
        document.frm1250.Ed_Phone_no.focus();
        return false;
    }

    if(checkElement(document.frm1250.Ed_Phone_no) == false)
    {   return false;      
     }
    return true;
}

function  modify()
{
	var M = parseInt(document.all.Ed_Current_point.value,10) ;
	var a = parseInt(document.all.Ed_Current_point.value,10) ;
  	var b = parseInt(document.all.Ed_Favour_point.value,10);
 	var c = parseInt(document.all.Ed_UsedCount.value,10);
	var e = parseInt(document.all.Ed_totalUsedPoint.value,10) ;

 	//alert("totalUsedPotin=" + document.all.Ed_totalUsedPoint.value);

 	var d = b * c
 	document.all.Grade_num.value =  e + d ;
	document.all.Ed_vFavAdd.value = a - d;
	document.all.Ed_vFavMoney.value = e + d;

	var a = parseInt(document.frm1250.Ed_UsedCount.value,10) ;
	var b = parseInt(document.frm1250.Ed_Favour_point.value,10) ;
 	var c = a*b;
	document.frm1250.consumeFee.value= c;

  if(document.all.Ed_UsedCount.value == "" || document.all.Ed_UsedCount.value == 0)
         {
        	rdShowMessageDialog("数量不能为空或0，请重新输入！");
        	document.frm1250.Ed_UsedCount.focus();
        	return false;
        }
		if( M < c)
		{
			rdShowMessageDialog("用户消费M值不能大于当前M值！");
			frm1250.print.disabled=true;
		}
		else
			frm1250.print.disabled=false;
		if(document.all.Grade_num.value != "")
        {
			s1299Init();
        }
}

</script>
<body>
	<form method=post name="frm1250" action="f1250_2.jsp">
	<%@ include file="/npage/include/header.jsp" %> 
	<div class="title">
	<div id="title_zi">客户资料</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">用户号码</td>
			<td colspan="3">
				<input id="Ed_Phone_no" v_must="1"  v_type="mobphone" name="Ed_Phone_no" Class="InputGrey" readOnly  maxlength=11 value="<%=activePhone%>">
				<font color="orange">*</font>
				<input name=Bt_Qry1 type=button class="b_text"  onclick="s1250Init()" value=验证>
			</td>
			<td class="blue" style="display:none">用户密码</td>
			<td style="display:none">
				
				<input name="Ed_UserPass" value="<%=pass%>"/>
				
	    	</td>
		</tr>
		
		<tr>
    		<td class="blue">客户姓名</td>
  			<td>
    			<input v_must=1 name=Ed_CustNane  Class="InputGrey" readOnly >
  			</td>
    		<td class="blue">业务品牌</td>
    		<td>
        		<input class="InputGrey" name=Ed_SmCode  v_must=1  readOnly >
     		</td>
		</tr>
		
		<tr>
    		<td class="blue">证件类型</td>
  			<td>
    			<input v_must=1 name=Ed_Id_type  Class="InputGrey" readOnly >
  			</td>
    		<td class="blue">证件号码</td>
    		<td>
        		<input v_must=1 name=Ed_Id_iccid  Class="InputGrey" readOnly 
        		 onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
      		</td>
		</tr>
		
		<tr>
    		<td class="blue">当前状态</td>
  			<td>
    			<input v_must=1 name=Ed_RunName  Class="InputGrey" readOnly >
  			</td>
    		<td class="blue">当前级别</td>
    		<td>
         		<input v_must=1 name=Ed_Grade_name Class="InputGrey" readOnly >
      		</td>
		</tr>
		
        <tr>
            <td class="blue">当前M值</td>
            <td>
	            <input v_must=1  name=Ed_Current_point Class="InputGrey" readOnly >
            </td>
            <td class="blue">当前经验值</td>
            <td>
	            <input name=Ed_totalUsedPoint Class="InputGrey" readOnly v_must=1>
            </td>
        </tr>
    </table> 
      
	 </div>
	        <div id="Operation_Table"> 
	        <div class="title">
	            <div id="title_zi">兑换操作</div>
	        </div> 
	<table cellspacing="0">   
        <tr>
            <td class="blue">兑换产品类别</td>
    		<td colspan="3">
				<input type="text" name="giftclasscode" size="12" readOnly >
				<input type="hidden" name="giftclassname" id="giftclassname">
    			<font class="orange">*</font>
    			<input type="button" class="b_text" value="查询" onclick="displayWinForGroup('giftclasscode','frm1250')">
    		</td>
        </tr>
    
        <tr>
            <td class="blue">兑换物品</td>
            <td>
            	<div id=FavourNameDiv>
              	<select align=left name=Sel_Favour_name onchange=change_Favour() width=50 />
		    	</div>
            </td>
            <td class="blue">奖品M值</td>
            <td>
		   		<input class="InputGrey" type="text" name= Ed_Favour_point readonly >
            </td>
        </tr>

		<tr>
            <td class="blue">消费后M值</td>
            <td>
		   		<input type="text" name=Ed_vFavAdd Class="InputGrey" readOnly >
				<input class="InputGrey" type="hidden" name=Ed_vGoodID readonly maxlength=20>
				<input type="hidden" name=Ed_vGoodFlag maxlength=20>
            </td>
            <td class="blue">消费后经验值</TD>
            <td>
		        <input type="text" name=Ed_vFavMoney Class="InputGrey" readOnly >
            </td>
		</tr>
		
		<tr>
            <td class="blue">兑奖期限</td>
            <td>
                <input type="text" name=Ed_vlimitDay Class="InputGrey" readOnly >
            </td>
			<td class="blue">消费后级别</td>
			<td>
				<input type="text" name="grade_name" Class="InputGrey" readOnly>
				<input type="hidden" value = "0" name=fee>
			</td>
		</tr>

        <tr>
            <td class="blue">数量</td>
            <td>
	        	<input class="button" v_must=1 v_type="0_9" name=Ed_UsedCount maxlength=8 onKeyUp="if(event.keyCode==13)modify();" onchange='modify()' >
		            <font color="orange">*</font>
            </td>
            <td class="blue">本次扣减M值</td>
            <td colspan=1><input class="InputGrey" type="text" name=consumeFee readonly ></td>
        </tr>
        
        <tr>
        	<td class="blue">操作备注</td>
	        <td colspan="3">
	          	<input class="button" name="Ed_Op_note" size=60 >
	        </td>
	      
        </tr>
    </table>
		<table id="dyntb" height=25 border=0 align="center" cellspacing=1 >
    	<tbody>
    		<tr>
        		
          		<th nowrap>
          			<input type="button" name="inp" class="b_text" id="inp" value="添加" onClick="dynAddRow()">
          		</th>
         	 	<th nowrap align="center">	
          			兑换物品
          		</th>
         	 	<th nowrap align="center">
          			兑换物品代码
          		</th>
          		<th nowrap align="center">
          			兑换数量
          		</th>
          		<th nowrap align="center">
          			兑换扣减M值
          		</th>
     	 </tbody>
     	</table>
		<!-- ningtn 2011-8-4 15:38:27 扩大电子工单 -->
		<jsp:include page="/npage/public/hwReadCustCard.jsp">
			<jsp:param name="hwAccept" value="<%=paraStr[0][0]%>"  />
			<jsp:param name="showBody" value="01"  />
		</jsp:include>
         <table>
          <tbody>
            <tr>
              <td align=center>
              <input class="b_foot" name=print  onClick="printCommit()" type=button  value=确认 disabled=true> &nbsp;
              <input class="b_foot" name=back  onClick="parent.removeTab('<%=opCode%>')" type=button value=关闭>
             </td>
            </tr>
          </tbody>
        </table>
       
        

  <!------------------------>
  <input type="hidden" name="workno" value="<%=workNo %>">
  <input type="hidden" name="nopass" value="<%=nopass %>">
  <input type="hidden" name="op_code" value="<%=sop_code %>">
  <input type="hidden" name= "OrgCode" value= "<%=OrgCode %>">
  <input type="hidden" name= "sSm_Code" value= "">
  <input type="hidden" name="region_code" value="<%=regionCode%>">
  <input type="hidden" name="ip_Addr" value="<%=ip_Addr%>">
  <input type="hidden" name="system_note" value="">
  <input type="hidden" name="passflag" value="<%=passflag%>">
  <input type="hidden" name="Ed_vFavRate">
  <input type="hidden" name="name1" value="扣减积分数量：">
  <input type="hidden" name="name2" value="未兑换积分余额：">
  <input type="hidden" name="name3" value="兑换内容：">
  <input type="hidden" name="Grade_num" value="">
  <input type="hidden" name="loginAccept" value="<%=paraStr[0][0]%>">
  <input type="hidden" name="favOurName" value="">
  <input type="hidden" name="Ed_address" onkeyup="value=value.replace(/[@#$%!^&*()<>?|]/g,'');">
  <input type="hidden" name="lines" value="0">
  <input type="hidden" name="lines_sum" value="0">
  <input type="hidden" name="init_user_point" value="0">
  <input type="hidden" name="Ed_Favour_point_all" value="0">
  <input type="hidden" name="Ed_Favour_point_this" value="0">
  <input type="hidden" name="Sel_Favour_name_all" value="0">
  <input type="hidden" name="Ed_UsedCount_all" value="0">
  <input type="hidden" name="cust_info">
  <input type="hidden" name="opr_info">
  <input type="hidden" name="note_info1">
  <input type="hidden" name="note_info2">
  <input type="hidden" name="note_info3">
  <input type="hidden" name="note_info4">
  <input type="hidden" name="printcount">

  <%@ include file="../../include/remark.htm" %>

 <%@ include file="/npage/include/footer.jsp" %>
</form>
   <OBJECT
classid="clsid:28EE9D9D-1A80-4BFF-B464-0E6B69E26B05"
codebase="/ocx/printatl.dll#version=1,0,0,1"
id="printctrl"
style="DISPLAY: none"
VIEWASTEXT
>
</OBJECT>
<script language="JavaScript">

function change_Favour()
{
	var favour="";
    with(document.frm1250)
    {
        if (Sel_Favour_name.options.selectedIndex >= 0)
        {

            for(var i = 0; i < iFavourCount; i++)
            {
                if (FavourCode[i][0] ==  Sel_Favour_name.options[Sel_Favour_name.options.selectedIndex].value)
                {
					favOurName.value = FavourCode[i][1];
                    Ed_Favour_point.value = FavourCode[i][2];
                    Ed_vGoodFlag.value = FavourCode[i][3];
                    Ed_vFavRate.value = FavourCode[i][4];
                    //Ed_vFavAdd.value = FavourCode[i][5];
                    Ed_vlimitDay.value = FavourCode[i][6];
                    //Ed_vFavMoney.value = FavourCode[i][7];
					favour=FavourCode[i][0];

					var a = parseInt(document.frm1250.Ed_UsedCount.value,10) ;
    				var b = parseInt(document.frm1250.Ed_Favour_point.value,10);
    				var c = a*b;
					document.frm1250.consumeFee.value= c;
				}
			}
        }
        if (favour.substr(0,2)=='a2')
        {
        	 document.frm1250.Ed_UsedCount.value ="1";
        	 document.frm1250.Ed_UsedCount.readOnly=true;


        }
        else{
        	 document.frm1250.Ed_UsedCount.readOnly=false;
        }
    }
//	modify();
}

function postHref()
{
    var path = "postHref.jsp";
    path = path + "?pageTitle=" + "主资费信息查询";
    path = path + "&Ed_Phone_no=" + (frm1250.Ed_Phone_no.value);
    path = path + "&Ed_CustNane=" + (frm1250.Ed_CustNane.value);

    var retInfo = window.showModalDialog(path,"","dialogWidth:468 px;dialogHeight:450 px;");

}

function  favTypeChange()
{



	if(document.frm1250.favour_type.value == 05 && document.frm1250.Ed_Phone_no.value != "")
	{
		postHref();
		return false;
	}


	if(document.frm1250.favour_type.value !="" && document.frm1250.Ed_Phone_no.value == "")
	{
		rdShowMessageDialog("请输入数据！");
			return false;
	}



	with(document.frm1250)
	{
	    var tmpLength = 1;
	    var  favCodeType = favour_type.options[favour_type.options.selectedIndex].value;

	    for(var i = 0 ; i < FavourCode.length ; i ++)
		{
				if(FavourCode[i][8] == favCodeType)
				{
                	tmpLength = tmpLength + 1;
				 }

        }

		var  j = 0;
		var arr = new Array(tmpLength);
	    for(var i = 0 ; i < FavourCode.length ; i ++)
		{
			if(FavourCode[i][8] == favCodeType)
				{
                	arr[j] = "<OPTION value='"+FavourCode[i][0] + "' > " + FavourCode[i][1] + "</OPTION>";
				 	j++;
				 }
        }
        FavourNameDiv.innerHTML = "<select align=left name=Sel_Favour_name onchange=change_Favour()   width=50>" + arr.join() + "</SELECT>";
        change_Favour();
	 }
}

function  printCommit()
{
	getAfterPrompt();
	if(document.frm1250.goods_code==undefined){
		rdShowMessageDialog("请添加兑换物品!",0);
		return false;
	}
	if (checkPhone() != true)
  {
  	return false;
  }
  with (document.frm1250){
  	if (parseInt(Ed_Current_point.value) < 0){
 			rdShowMessageDialog("当前M值不能为负数!",0);
      return false;
  	}
        if (Ed_UsedCount.value == "")
        {
            rdShowMessageDialog(" 数量不能为空！",0);
            Ed_UsedCount.focus();
            return false;
        }
    }

	if(check(frm1250)){
		if(document.all.Ed_Op_note.value.trim().length==0){
			document.all.Ed_Op_note.value="操作员<%=workNo%>"+"对用户"+document.all.Ed_Phone_no.value+"进行积分兑奖"
	  }
/*
		var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
		if((ret=="confirm")){
			if(rdShowConfirmDialog('确认电子免填单吗？')==1){
				document.all.printcount.value="1";
				frm1250.submit();
			}
		}else{
			if(rdShowConfirmDialog('确认要提交信息吗？')==1){
				document.all.printcount.value="0";
				frm1250.submit();
			}
		}
*/

//alert(1);

	/*王良 2008年1月3日 修改增加用户满意度评价设置*/
  var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
//  alert(11);
  var iReturn = 0;
	if((ret=="confirm")){
//		alert(2);
		iReturn = showEvalConfirmDialog('确认电子免填单吗？'); 
//		alert(3);
   	if(iReturn==2){
//   		alert(4);
 	 		var vEvalValue = GetEvalReq(1);
// 	 		alert(5);
			if (vEvalValue==4){
				rdShowMessageDialog("用户未进行评价!");
			}
//			alert(6);
			var vEvalPacket = new AJAXPacket("../../npage/public/evalCfm.jsp?vEvalValue="+vEvalValue,"正在提交用户满意度评价，请稍候......");
			vEvalPacket.data.add("vLoginAccept",document.all.loginAccept.value);
			vEvalPacket.data.add("vOpCoce",document.all.op_code.value);
			vEvalPacket.data.add("vLoginNo",document.all.workno.value);
			vEvalPacket.data.add("vPhoneNo",document.all.Ed_Phone_no.value);
			core.ajax.sendPacket(vEvalPacket);
   		vEvalPacket=null;
		}
  	
 		if(iReturn==1||iReturn==2){
   		document.all.printcount.value="1";
	    frm1250.submit();
   	}
 	}else{

 		iReturn = showEvalConfirmDialog('确认要提交信息吗？'); 
  	if(iReturn==2){
		 	var vEvalValue = GetEvalReq(1);
			if (vEvalValue==4){
				rdShowMessageDialog("用户未进行评价!");
			}
			
			var vEvalPacket = new AJAXPacket("../../npage/public/evalCfm.jsp?vEvalValue="+vEvalValue,"正在提交用户满意度评价，请稍候......");
			vEvalPacket.data.add("vLoginAccept",document.all.loginAccept.value);
			vEvalPacket.data.add("vOpCoce",document.all.op_code.value);
			vEvalPacket.data.add("vLoginNo",document.all.workno.value);
			vEvalPacket.data.add("vPhoneNo",document.all.Ed_Phone_no.value);
			core.ajax.sendPacket(vEvalPacket);
   		vEvalPacket=null;
		}

  	if(iReturn==1||iReturn==2){
    	document.all.printcount.value="0";
	    frm1250.submit();
   	}
  }
	
	}
}

  function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //显示打印对话框
     //var h=150;
     //var w=350;
     //var t=screen.availHeight/2-h/2;
     //var l=screen.availWidth/2-w/2;
     //
     //var printStr = printInfo(printType);
     //
     //var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
     ////var path = "<%=request.getContextPath()%>/include/hljPrint.jsp?DlgMsg=" + DlgMessage;
     ////var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
     ////var ret=window.showModalDialog(path,"",prop);
     //var path = "<%=request.getContextPath()%>/page/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
     //var ret=window.showModalDialog(path,printStr,prop);
     //
     //return ret;
     
   var h=198;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;
   var pType="subprint";
   var billType="1";
   var sysAccept = "<%=paraStr[0][0]%>";
   var phone_no = "<%=activePhone%>"
   var mode_code = null;
   var fav_code = null;
   var area_code = null;
   var printStr = printInfo(printType);

   
   //var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   //var path = "<%=request.getContextPath()%>/page/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
   //var ret=window.showModalDialog(path,printStr,prop);
		/* ningtn */
		var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
		/* ningtn */
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 
   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
   var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=sop_code%>&sysAccept="+sysAccept+"&phoneNo="+phone_no+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
   var ret=window.showModalDialog(path,printStr,prop);

   return ret;
  }

  function printInfo(printType)
  {
        var   opType = document.all.Sel_Favour_name.options[document.all.Sel_Favour_name.options.selectedIndex].value;

    var retInfo = "";
    var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
    //retInfo+='<%=workNo%>    '+"|";
    //retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    cust_info+="客户姓名："+document.all.Ed_CustNane.value+"|";
    cust_info+="手机号码："+document.all.Ed_Phone_no.value+"|";
    cust_info+="证件号码："+codeChg(document.all.Ed_Id_iccid.value)+"|";
    cust_info+="客户地址："+codeChg(document.all.Ed_address.value)+"|";
    
    opr_info+="业务受理时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"用户品牌: 动感地带"+"|";
    opr_info+="办理业务："+"动感地带M值兑换"+" 操作流水: "+document.all.loginAccept.value+"|";
    opr_info+="军衔等级："+document.all.Ed_Grade_name.value+"兑换后军衔等级："+document.all.grade_name.value+ "|";
 		if (parseInt(frm1250.lines.value)==1){
 			if (parseInt(frm1250.lines_sum.value) > 1){
				opr_info+="兑换物品：" + document.frm1250.goods_name[0].value+ " 兑换数量: "+parseInt(document.frm1250.goods_sum[0].value)+" 兑换M值: "+parseInt(document.frm1250.goods_consumed[0].value)+"|";
			}else{
				opr_info+="兑换物品：" + document.frm1250.goods_name.value+ " 兑换数量: "+parseInt(document.frm1250.goods_sum.value)+" 兑换M值: "+parseInt(document.frm1250.goods_consumed.value)+"|";
			}
 		}else{
  		for (var i=0;i< parseInt(document.frm1250.goods_code.length);i++){
				opr_info+="兑换物品：" + document.frm1250.goods_name[i].value+ " 兑换数量: "+parseInt(document.frm1250.goods_sum[i].value)+" 兑换M值: "+parseInt(document.frm1250.goods_consumed[i].value)+"|";
			}
		}
    opr_info+="兑换前M值: "+document.all.init_user_point.value +" 本次兑换M值合计："+document.all.Ed_Favour_point_this.value+" 剩余M值: "+document.all.Ed_Current_point.value+"|";


   // retInfo+="兑换前积分: "+document.all.Ed_Current_point.value+"*"+"本次兑换积分:"+document.all.consumeFee.value+"|";
  //  retInfo+="兑换前积分: "+document.all.init_user_point.value+"*"+"本次兑换积分:"+document.all.Ed_Favour_point_this.value+"|";
    //retInfo+="剩余积分："+ document.all.Ed_vFavAdd.value+"*"+"兑换后军衔等级："+document.all.grade_name.value+"|";
   // retInfo+="剩余积分："+ document.all.Ed_Current_point.value+"*"+"兑换后军衔等级："+document.all.grade_name.value+"|";
// dujl 修改_封上备注 at 20090429**********************************************
    //note_info1+="备注："+document.all.Ed_Op_note.value+"|";
    //document.all.cust_info.value=cust_info+"#";
	//document.all.opr_info.value=opr_info+"#";
	//document.all.note_info1.value=note_info1+"#";
	//document.all.note_info2.value=note_info2+"#";
	//document.all.note_info3.value=note_info3+"#";
	//document.all.note_info4.value=note_info4+"#";
	//retInfo=document.all.cust_info.value+" "+"|"+"---------------------------------------------"+"|"+" "+"|"+document.all.opr_info.value+" "+"|"+" "+"|"+document.all.note_info1.value+document.all.note_info2.value+document.all.note_info3.value+document.all.note_info4.value+" "+"|"+" "+"|"+" "+"|"+" "+"|"+"<%=loginNote.trim()%>"+"#";
    //
    //return retInfo;
    //retInfo=cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
	
  }
//gonght add 2009-12-29 处理特殊字符  
function codeChg(s)
{
  var str = s.replace(/&nbsp;/g,""); 
  str = str.replace(/[@#$%!^&*()<>?|]/g,""); 
  return str;
}
function displayWinForGroup(para1,para2) {
	window.open("getGroupXTree.jsp?form="+para2,"","width=480,height=480,left=250,top=50,resizable=no,scrollbars=yes,status=yes");
}
function chg_giftclasscode() //luxc 20070424add 积分2.0树状结构改造
{
	if (checkPhone() != true)
    {
        return false;
    }
    var chg_giftclasscode_Packet = new AJAXPacket("s1250chg_giftclasscode.jsp","正在获取可兑换物品,请稍候......");

    chg_giftclasscode_Packet.data.add("retType","chg_giftclasscode");
    chg_giftclasscode_Packet.data.add("region_code","<%=regionCode%>");
    chg_giftclasscode_Packet.data.add("Ed_Current_point",document.all.Ed_Current_point.value);
    chg_giftclasscode_Packet.data.add("phone_no",document.frm1250.Ed_Phone_no.value);
    chg_giftclasscode_Packet.data.add("giftclasscode",document.all.giftclasscode.value);

    core.ajax.sendPacket(chg_giftclasscode_Packet);
    delete(chg_giftclasscode_Packet);
}

</script>

</body>
	<OBJECT classid="clsid:2F593576-E694-46B5-BF4F-9F23C1020642" height=1 id=evalControl width=1 >
  </OBJECT>
<!-- ningtn 2011-7-12 08:35:36 电子化工单扩大范围 -->
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>

