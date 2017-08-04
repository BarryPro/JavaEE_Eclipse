<%
 /**
 * 作者:zhaohaitao
 * 日期:2008.12.2
 * 模块:积分兑换
 **/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html  xmlns="http://www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %>

<%@ page import="com.sitech.crmpd.boss.bo.ContactInfo"%>
<%@ page contentType="text/html; charset=gb2312" %>
<%@ taglib uri="weblogic-tags.tld" prefix="wl" %>
<%@ page import="org.apache.log4j.Logger"%>

<%@ page import="java.io.*" %>

<%
    String opCode = "1250";
    String opName = "积分兑换";
	Logger logger = Logger.getLogger("f1250_1.jsp");
    
    String workNo = (String)session.getAttribute("workNo");
    String nopass = "111111";
    String OrgCode = (String)session.getAttribute("orgCode");
    String regionCode = (String)session.getAttribute("regCode");
	String op_code = "1250";
    String ip_Addr = (String)session.getAttribute("ipAddr");

    /* 业务变量 */
    String passflag = "0";

    //优惠信息
    //String[][] favInfo = (String[][])arr.get(3);   //数据格式为String[0][0]---String[n][0]
    String[][] favInfo = (String[][])session.getAttribute("favInfo"); //优惠代码为数组
    String tempStr = "";
    String passValue ="";

	//2011/6/23 wanghfa添加 对密码权限整改 start
  boolean pwrf=false;
	String pubOpCode = opCode;
	String pubWorkNo = workNo;
%>
	<%@ include file="/npage/public/pubCheckPwdPower.jsp" %>
<%
	System.out.println("====wanghfa====f1250_1.jsp==== pwrf = " + pwrf);
	if (pwrf) {
		passflag = "1";
	}
	//2011/6/23 wanghfa添加 对密码权限整改 end

    
    if(passflag.equals("0")){
         Map map = (Map)session.getAttribute("contactInfoMap");
		 ContactInfo contactInfo = (ContactInfo) map.get(activePhone);
         passValue=contactInfo.getPasswdVal(2);
    }

	String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
	//paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();
%>
    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1">
    <wtc:sql><%=prtSql%>
    </wtc:sql>
	</wtc:pubselect>
	<wtc:array id="paraStr" scope="end"/>
<%
    System.out.println("paraStr[0][0]---SysAccept==========" +paraStr[0][0]);
%>

<HEAD><TITLE>积分兑换</TITLE>
</HEAD>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META http-equiv=Content-Type content="text/html; charset=gb2312">

<SCRIPT type=text/javascript>

var FavourCode;
var iFavourCount;

onload=function(){
	
}

//---------1------RPC处理函数------------------
function doProcess(packet)
{
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
    var retMessage = packet.data.findValueByName("retMessage");


    //--------------------------------
    if(retType == "call_s1250Init")
    {
        //读取原有库中数量
        if(retCode=="000000")
        {
            var iCount = packet.data.findValueByName("iCount");
            var retFavourCode = packet.data.findValueByName("FavourCode");
            var retCust_name = packet.data.findValueByName("Cust_name");
            var retRun_name = packet.data.findValueByName("Run_name");
            var retSm_name = packet.data.findValueByName("Sm_name");
            var retId_name = packet.data.findValueByName("Id_name");
            var retId_iccid = packet.data.findValueByName("Id_iccid");
            var retGrade_code = packet.data.findValueByName("Grade_code");
            var retGrade_name = packet.data.findValueByName("Grade_name");

            var retCurrent_point = packet.data.findValueByName("Current_point");
            var higmsg=packet.data.findValueByName("higmsg");
            var id_address=packet.data.findValueByName("id_address");

            document.frm1250.Ed_CustNane.value = retCust_name;
            document.frm1250.Ed_RunName.value = retRun_name;
            document.frm1250.Ed_SmCode.value = retSm_name;
            document.frm1250.Ed_Id_type.value = retId_name;
            document.frm1250.Ed_Id_iccid.value = retId_iccid;
            document.frm1250.Ed_Grade_name.value = retGrade_name;
            document.frm1250.Ed_Current_point.value = retCurrent_point;
            document.frm1250.init_user_point.value = retCurrent_point;
            document.frm1250.Ed_UsedCount.value = '1';
			document.frm1250.Ed_Address.value = id_address;
			
            //var temLength = FavourCode.length+1;
            var a = parseInt(document.frm1250.Ed_UsedCount.value,10) ;
    		var b = parseInt(document.frm1250.Ed_Favour_point.value,10) ;
    		var c = a*b;
			//document.frm1250.consumeFee.value= c;
            document.frm1250.print.disabled=false;
             if(higmsg>0){rdShowMessageDialog("该用户为中高端用户!");}
        }
        else
        {
            retMessage = retMessage + "[errorCode:" + retCode + "]";
            rdShowMessageDialog(retMessage,0);
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
	frm1250.lines.value=bb-1;
	frm1250.lines_sum.value=bb+1;

	redo_cal();
}

function dynAddRow(){

	if (frm1250.giftclasscode.value==""){
		rdShowMessageDialog("请选择兑换物品类别!");
	  return false;
	}

	if (document.frm1250.Sel_Favour_name.value=="" ){
		rdShowMessageDialog("当前用户积分不够兑换物品!");
	  return false;
	}

	if (parseInt(document.frm1250.Ed_Current_point.value) - parseInt(document.frm1250.consumeFee.value) <0){
		rdShowMessageDialog("当前用户积分不够兑换物品!");
		return false;
	}

	frm1250.lines.value=parseInt(frm1250.lines.value)+1;
	frm1250.lines_sum.value=parseInt(frm1250.lines_sum.value)+1;
	var tr1=dyntb.insertRow();
	tr1.id="tr";
	
	tr1.insertCell().innerHTML = '<td> <div align=center><input type=button name=del_line size=4 value=× onClick="dynDelRow()"></div></td>';
 	tr1.insertCell().innerHTML = '<td> <div align=center><input type=text readonly name=goods_name size=14 class=button  value='+document.all.Sel_Favour_name.options[document.all.Sel_Favour_name.options.selectedIndex].text+'></div></td>';
  	tr1.insertCell().innerHTML = '<td> <div align=center><input type=text readonly name=goods_code size=14 class=button  value='+document.all.Sel_Favour_name.options[document.all.Sel_Favour_name.options.selectedIndex].value+'></div></td>';
  	tr1.insertCell().innerHTML = '<td> <div align=center><input type=text readonly name=goods_sum  size=6  class=button value='+document.all.Ed_UsedCount.value+'></div></td>';
  	tr1.insertCell().innerHTML = '<td> <div align=center><input type=text readonly name=goods_consumed size=20 class=button value='+document.all.consumeFee.value+'></div></td>';
	

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
				document.frm1250.Ed_Favour_point_all.value = parseInt(document.frm1250.goods_consumed[i].value)/parseInt(document.frm1250.goods_sum[i].value);
				document.frm1250.Ed_Favour_point_this.value = parseInt(document.frm1250.goods_consumed[i].value);
			}else{
				document.frm1250.Ed_Favour_point_all.value = document.frm1250.Ed_Favour_point_all.value + "|" + parseInt(document.frm1250.goods_consumed[i].value)/parseInt(document.frm1250.goods_sum[i].value);
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
	//alert(document.frm1250.lines.value+"===="+document.frm1250.lines_sum.value+"==="+frm1250.goods_code[0].value);
	
	//当前积分
	document.frm1250.Ed_Current_point.value=parseInt(document.frm1250.init_user_point.value) - parseInt(varAllConsumed);
	//奖品积分
	//document.frm1250.Ed_Favour_point.value= parseInt(varAllConsumed);

}


function s1250Init()
{
    //读取原有库中数量
    if (checkPhone() != true)
    {
        return false;
    }
   
    document.frm1250.Ed_Phone_no.readOnly=true;
    document.frm1250.tmp_phone_no.value=document.frm1250.Ed_CustNane.value;
     
    var s1250Init_Packet = new AJAXPacket("s1250Init.jsp","正在验证密码，请稍候......");
    s1250Init_Packet.data.add("retType","call_s1250Init");
    s1250Init_Packet.data.add("region_code","<%=regionCode%>");
    s1250Init_Packet.data.add("OrgCode","<%=OrgCode%>");
	s1250Init_Packet.data.add("op_code","1250");

    s1250Init_Packet.data.add("phone_no",document.frm1250.Ed_Phone_no.value);
    s1250Init_Packet.data.add("user_pass",document.frm1250.Ed_UserPass.value);
    s1250Init_Packet.data.add("PassFlag","<%=passflag%>");
    
    core.ajax.sendPacket(s1250Init_Packet);
    s1250Init_Packet=null;
}



function checkPhone()
{
    var password_flag = "<%= passflag %>";
   
    if(document.frm1250.Ed_Phone_no.value == "")
    {
        rdShowMessageDialog("请输入手机号码！",0);
        document.frm1250.Ed_Phone_no.focus();
        return false;
    }
    /*
    if (password_flag == "0" )
    {
        if(document.frm1250.Ed_UserPass.value == "")
        {
            rdShowMessageDialog("请输入用户密码！",0);
            document.frm1250.Ed_UserPass.focus();
            return false;
        }
    }
   */

    if(checkElement(document.frm1250.Ed_Phone_no) == false)
		return false;
    return true;
}

function consumeFee1()
{
    var a = parseInt(document.frm1250.Ed_UsedCount.value,10) ;
    var b = parseInt(document.frm1250.Ed_Favour_point.value,10) ;
    var c = a*b;
	document.frm1250.consumeFee.value= c;
	if(parseInt(document.all.Ed_Current_point.value,10) < c)
	{
		rdShowMessageDialog("用户当前积分小于兑换积分！",0);
		document.all.print.disabled=true;
		return false;
	}else
	{
		document.all.print.disabled=false;
	}
	return true;
}


</SCRIPT>

<!--**************************************************************************************-->

</HEAD>
<body>   
      <FORM method=post name="frm1250" action="f1250_2.jsp">
      	<%@ include file="/npage/include/header.jsp" %>   
  	
		<div class="title">
			<div id="title_zi">积分兑换</div>
		</div>         

        <TABLE cellspacing="0">        
          <TR>
                <TD class="blue">用户号码</TD>
	            <TD colspan="3">
		        	<input v_must="1" v_type="mobphone" name="Ed_Phone_no" id="Ed_Phone_no" class="InputGrey" maxlength=11 value="<%=activePhone%>" readOnly>
		        	<font color="orange">*</font> 		            
		            <input name=Bt_Qry1 type=button class="b_text" onclick="s1250Init()" value=验证>
	            </TD>	            
                <TD class="blue" style="display:none">用户密码</TD>              
                <td style="display:none">
                	<input type="text" name="Ed_UserPass" value="<%=passValue%>">
            	</td>
               
            </TR>
            <TR>
                <TD class="blue">客户姓名</TD>
	            <TD>
		            <input class="InputGrey" v_must=1  name=Ed_CustNane  readonly>
	            </TD>
                <TD class="blue"> 业务品牌</TD>
                <TD>
                    <input class="InputGrey" name=Ed_SmCode  v_must=1 readonly>
                 </TD>
            </TR>
            <TR>
                <TD class="blue">证件类型</TD>
	            <TD>
		            <input class="InputGrey" v_must=1 name=Ed_Id_type  readonly>
	            </TD>
                <TD class="blue">证件号码</TD>
                <TD>
                    <input class="InputGrey" v_must=1 name=Ed_Id_iccid  readonly>
                </TD>
            </TR>
            <TR>
                <TD class="blue">当前状态</TD>
	            <TD colspan="3">
		            <input class="InputGrey" v_must=1  name=Ed_RunName  readonly>
                    <input v_must=1  type="hidden" name=Ed_Grade_name readonly>
	            </TD>	        
                <!--TD> 用户积分级别:</TD>
                <TD>
                    <input class="button" v_must=1 v_name="用户积分级别:" name=Ed_Grade_name readonly style="background=#EEEEEE" >

                 </TD-->
            </TR>
        </table>
    	</div>
    	<div id="Operation_Table">
        <div class="title">
		<div id="title_zi">兑换信息</div>
		</div> 
		<table cellspacing="0">
            <TR>
                <TD class="blue">当前积分&nbsp;&nbsp;&nbsp;&nbsp;</TD>
	            <TD>
		            <input class="InputGrey" v_must=1 readonly  name=Ed_Current_point size="30">
	            </TD>
	            <TD class="blue">兑换产品类别</TD>
        		<TD>
					<input type="text" name="giftclasscode" id="giftclasscode" readOnly>
					<input type="hidden" name="giftclassname" id="giftclassname">
					<input type="hidden" name="battery_type" id="battery_type">   
					<font color="orange">*</font>     			
        		    <input type="button" class="b_text" value="查询" onclick="displayWinForGroup('giftclasscode','frm1250')">       		    
        		</TD>
            </TR>
            <TR>
            	<TD class="blue">兑换物品</TD>
            	<TD>
             		<div id="FavourNameDiv">
              		<select align=left name=Sel_Favour_name onchange="change_Favour()">
		   		    </div>
            	</TD>
            	<TD class="blue">奖品积分</TD>
            	<TD>
		   			<input class="InputGrey" type="text" name= Ed_Favour_point readonly>
            	</TD>
            </TR>
			<TR>
            	<TD class="blue">兑奖期限</TD>
            	<TD>
					<input class="InputGrey" type="text" name=Ed_vlimitDay readonly>
					<input type="hidden" name=Ed_vGoodID readonly>
					<input type="hidden" name=Ed_vGoodFlag>
					<input type="hidden" name=Ed_vFavMoney readonly>
				</td>
            	<TD class="blue">兑奖地址</TD>
            	<TD>
		   			<input class="InputGrey" type="text" name=Ed_vFavAdd readonly>
            	</TD>           	
			</TR>
            <TR>
                <TD class="blue">数量</TD>
	            <TD>
		            <input type="text" v_must=1 v_type="0_9" name=Ed_UsedCount onChange= "consumeFee1()" onkeyup="if(event.keyCode==13)consumeFee1()">
		            <font color="orange">*</font>
	            </TD>
                <TD class="blue">本次消费积分</TD>
                <TD><input class="InputGrey" type="text" name=consumeFee readonly></TD>
            </TR>
           
                <!--<TD>补交金额:</TD>-->
                <input class="button" type="hidden" name=fee>
       <!-- dujl 修改_封掉 at 20090429 -->                 
          	<!--<TR style="display:none">-->
          	<TR>
            	<TD class="blue">操作备注</TD>
            	<TD colspan="3">
              		<input type="text" name=Ed_Op_note size=60 >
            		<input type="hidden" name="cust_info">
      				<input type="hidden" name="opr_info">
      				<input type="hidden" name="note_info1">																													
      				<input type="hidden" name="note_info2">																													
      				<input type="hidden" name="note_info3">																													
      				<input type="hidden" name="note_info4">																													
      				<input type="hidden" name="printcount">																													
            	</TD>
            </TR>   
        </table>
              
		<table id="dyntb" cellspacing="0">
    		<tr>	
    			<td>
    				<input type="button" class="b_text" name="inp" id="inp" value="添加" onClick="dynAddRow()">  
    			</td>    			     		 	
          		<th class="blue">
          			<div align="center">兑换物品</div>
          		</th>
          		<th class="blue">
          			<div align="center">兑换物品代码</div>
          		</th>
         		<th class="blue">
          			<div align="center">兑换数量</div>
          		</th>
          		<th class="blue">
          			<div align="center">兑换扣减积分</div>
          		</th>		
      		</tr>
        </TABLE>
<!-- ningtn 2011-8-4 15:23:17 扩大电子工单 -->
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=paraStr[0][0]%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
         <TABLE cellspacing="0">         
            <TR>
              <TD align="center">
              <input class="b_foot" name=print  onClick="printCommit()" type=button  value=确认> &nbsp;
              <input class="b_foot" name=back  onClick="parent.removeTab('<%=opCode%>')" type=button value=关闭>
			  <!--
              <input class="button" name=goback  onClick="location='f1450.jsp?op_code=1450'" type=button  value=业务回退  >-->
             </TD>
            </TR>               
        </TABLE>
      

  <!------------------------>
  <input type="hidden" name="workno" value="<%=workNo %>">
  <input type="hidden" name="favOurName" value="">
  <input type="hidden" name="nopass" value="<%=nopass %>">
  <input type="hidden" name="op_code" value="<%=op_code %>">
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
  <input type="hidden" name="loginAccept" value="<%=paraStr[0][0]%>">
  <input type="hidden" name="Ed_Address" value="">
  <input type="hidden" name="lines" value="0">
  <input type="hidden" name="lines_sum" value="0">
  <input type="hidden" name="init_user_point" value="0">
  <input type="hidden" name="Ed_Favour_point_all" value="0">
  <input type="hidden" name="Ed_Favour_point_this" value="0">
  <input type="hidden" name="Sel_Favour_name_all" value="0">
  <input type="hidden" name="Ed_UsedCount_all" value="0">
  <input type="hidden" name="tmp_phone_no" value="">

	<%@ include file="../../include/remark.htm" %>
    <%@ include file="/npage/include/footer.jsp" %>   
    <%@ include file="../../npage/common/pwd_comm.jsp" %>
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
					consumeFee.value = FavourCode[i][2];
                    Ed_vGoodFlag.value = FavourCode[i][3];
                    Ed_vFavRate.value = FavourCode[i][4];
                    Ed_vFavAdd.value = FavourCode[i][5];
                    Ed_vlimitDay.value = FavourCode[i][6];
                    Ed_vFavMoney.value = FavourCode[i][7];

								//程序bug
								Ed_UsedCount.value ="1";

            		favour=FavourCode[i][0];

		    		a = document.frm1250.Ed_Current_point.value * document.frm1250.Ed_vFavRate.value ;
		    		b = document.frm1250.Ed_Favour_point.value;
		    		c = document.frm1250.Ed_vFavMoney.value;
		    		d = b * document.frm1250.Ed_vFavRate.value ;
		 			if(a >= b)
            		{
            		    document.frm1250.fee.value = 0;
            		}
        			else
        			{
        			 	 document.frm1250.fee.value = c - a;
        			}
                }
            }
        }
        if (favour.substr(0,2)=='a2')
        {
        	 document.frm1250.Ed_UsedCount.value ="1";
        	 document.frm1250.Ed_UsedCount.readOnly=true;
        }
        else
        {
        	 document.frm1250.Ed_UsedCount.readOnly=false;
        }
    }
//    consumeFee1();
}

//------资费-----s------
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

	if(document.frm1250.favour_type.value == 00)
 	{
 	 	alert("请选择电池品牌");
 	 	document.frm1250.battery_type.style.display = "";
	}else
	{
		document.frm1250.battery_type.style.display = "none";
	}

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
	if(document.frm1250.favour_type.value != 00)
	{
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
    	    FavourNameDiv.innerHTML = "<select align=left name='Sel_Favour_name' onchange='change_Favour()' width=50>" + arr.join() + "</SELECT>";
    	    change_Favour();
		}
	}
	else
	{
		getBattery();
	}
}

function  getBattery()
{
	with(document.frm1250)
	{
	    var tmpLength = 1;
	    var  vbatteryType = battery_type.options[battery_type.options.selectedIndex].value;

	    for(var i = 0 ; i < FavourCode.length ; i ++)
		{
				if(FavourCode[i][0].substr(0,2) == vbatteryType)
				{
                	tmpLength = tmpLength + 1;
				 }
        }
		var  j = 0;
		var arr = new Array(tmpLength);
	    for(var i = 0 ; i < FavourCode.length ; i ++)
		{
			if(FavourCode[i][0].substr(0,2) == vbatteryType)
				{
                	arr[j] = "<OPTION value='"+FavourCode[i][0] + "' > " + FavourCode[i][1] + "</OPTION>";
				 	j++;
				 }
        }
        FavourNameDiv.innerHTML = "<select align=left name='Sel_Favour_name' onchange='change_Favour()' width=50>" + arr.join() + "</SELECT>";
        change_Favour();
	 }

}

function printCommit(){
	getAfterPrompt();
	// dujl add at 20090429 ************************************
	if(document.frm1250.goods_code==undefined){
		rdShowMessageDialog("请添加兑换物品!",0);
		return false;
	}
   if (checkPhone() != true)
    {
        return false;
    }

    with (document.frm1250)
    {
        if (Ed_UsedCount.value == "")
        {
            rdShowMessageDialog(" 数量不能为空！",0);
            Ed_UsedCount.focus();
            return false;
        }
    }


   //打印工单并提交表单
	if((document.all.Ed_Op_note.value).trim().length==0){
		 document.all.Ed_Op_note.value="操作员<%=workNo%>"+"对用户"+document.all.Ed_Phone_no.value+"进行积分兑换"
	}
 
/*  
  var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
	if((ret=="confirm")){
  	if(rdShowConfirmDialog('确认电子免填单吗？')==1)
    	{
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
	/*王良 2008年1月3日 修改增加用户满意度评价设置*/
  var ret = showPrtDlg("Detail","确实要进行电子免填单打印吗？","Yes");
  var iReturn = 0;
	if((ret=="confirm")){
		iReturn = showEvalConfirmDialog('确认电子免填单吗？'); 
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
  
	return true;
}

  function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //显示打印对话框
     var h=210;
     var w=400;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;

	 var pType="subprint";                           // 打印类型：print 打印 subprint 合并打印
	 var billType="1";                            // 票价类型：1电子免填单、2发票、3收据
	 var sysAccept=<%=paraStr[0][0]%>;            // 流水号
	 var printStr = printInfo(printType);         //调用printinfo()返回的打印内容
	 var mode_code=null;                          //资费代码
	 var fav_code=null;                			  //特服代码
	 var area_code=null;           			      //小区代码
     var opCode="1250";                  			  //操作代码
     var phoneNo=<%=activePhone%>;                //客户电话    

     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
		/* ningtn */
		var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
		/* ningtn */
     var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
	 path = path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;

     var ret=window.showModalDialog(path,printStr,prop);
     return ret;
  }

  function printInfo(printType)
  {
	var after = parseInt(document.all.init_user_point.value)-parseInt(document.all.Ed_Favour_point_this.value);

	var retInfo = "";
	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
   
    cust_info+="客户姓名："+document.all.Ed_CustNane.value+"|";
    cust_info+="手机号码："+document.all.Ed_Phone_no.value+"|";
    cust_info+="证件号码："+document.all.Ed_Id_iccid.value+"|";
    cust_info+="客户地址："+document.all.Ed_Address.value+"|";
    
    opr_info+="业务受理时间："+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"用户品牌: "+document.all.Ed_SmCode.value+ "|";
    opr_info+="办理业务："+"积分兑换"+"  操作流水："+document.all.loginAccept.value+"|";

 		if (parseInt(frm1250.lines.value)==1){
 			if (parseInt(frm1250.lines_sum.value) > 1){
				opr_info+="兑换物品：" + document.frm1250.goods_name[0].value+ "  兑换数量: "+parseInt(document.frm1250.goods_sum[0].value)+" 兑换积分: "+parseInt(document.frm1250.goods_consumed[0].value)+"|";
			}else{
				opr_info+="兑换物品：" + document.frm1250.goods_name.value+ "  兑换数量: "+parseInt(document.frm1250.goods_sum.value)+" 兑换积分: "+parseInt(document.frm1250.goods_consumed.value)+"|";
			}
 		}else{
	  		for (var i=0;i< parseInt(document.frm1250.goods_code.length);i++){
				opr_info+="兑换物品：" + document.frm1250.goods_name[i].value+ "  兑换数量: "+parseInt(document.frm1250.goods_sum[i].value)+" 兑换积分: "+parseInt(document.frm1250.goods_consumed[i].value)+"|";
			}
		}
    opr_info+="兑换前积分: "+document.all.init_user_point.value +"  兑换积分合计："+document.all.Ed_Favour_point_this.value +"  兑换后积分: "+after+"|";
// dujl 修改_封掉备注 at 20090429 *********************************************
    //note_info1+="备注："+document.all.Ed_Op_note.value+"|";
    document.all.cust_info.value=cust_info+"#";
	document.all.opr_info.value=opr_info+"#";
	document.all.note_info1.value=note_info1+"#";
	document.all.note_info2.value=note_info2+"#";
	document.all.note_info3.value=note_info3+"#";
	document.all.note_info4.value=note_info4+"#";
	//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); 
    
    return retInfo;
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
    chg_giftclasscode_Packet=null;
}

</script>
</body>
	<OBJECT classid="clsid:2F593576-E694-46B5-BF4F-9F23C1020642" height=1 id=evalControl width=1 >
  </OBJECT>
<!-- ningtn 2011-7-12 08:35:36 电子化工单扩大范围 -->
<%@ include file="/npage/public/hwObject.jsp" %> 
</html>

