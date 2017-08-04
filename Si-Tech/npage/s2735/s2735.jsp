<%
/********************
 version v2.0
开发商: si-tech
白雪峰修改20070518
boss2.0 新界面:功能:  证件号码:_________      【查号】     集团客户id:__________
                      集团编号：________                 集团客户名称：________
                      查询月份:_________                 集团客户密码：______  【验证】
                                          【查询】【清除】 
               说明: 用户输入'证件号'后,点击[查询]可以在新增窗体中选择客户id,选定后
                     自动填写'集团编号'和'客户名称'内容;
                     用户输入查询月份YYYYMM 后,验证密码后【查询】。
                                                  

********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="org.apache.log4j.Logger"%>
<%
    Logger logger = Logger.getLogger("s2735.jsp");
    
    String opCode = "2735";
    String opName = "集团客户详单查询";
    
    String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
    String workno = WtcUtil.repNull((String)session.getAttribute("workNo"));
    String workname = WtcUtil.repNull((String)session.getAttribute("workName"));
    String org_code = WtcUtil.repNull((String)session.getAttribute("orgCode"));
    String nopass  = WtcUtil.repNull((String)session.getAttribute("password"));
    String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));

       String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
        String[] mon = new String[]{"", "", "", "", "", ""};

        Calendar cal = Calendar.getInstance(Locale.getDefault());
        cal.set(Integer.parseInt(dateStr.substring(0, 4)),
                (Integer.parseInt(dateStr.substring(4, 6)) - 1), Integer.parseInt(dateStr.substring(6, 8)));
        for (int i = 0; i <= 5; i++) {
            if (i != 5) {
                mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
                //cal.add(Calendar.MONTH, -1);
            } else
                mon[i] = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
        }
   
    String typeStr = "";
    String inputStr = "";
    
    String sqlStr1 = "";
    String sqlStrNum="";
	String sqlStr="";
	String cust_address = "";
        ArrayList retArray = new ArrayList();
	ArrayList retArray1 = new ArrayList();
        String return_code,return_message;
        String[][] result = new String[][]{};
	String[][] allNumStr =  new String[][]{};
 	String resultPrintTemplet[][] = new String[][]{}; //打印模板
	String resultPrintTemplet1[][] = new String[][]{}; 
		
//得到页面参数 
	String iccid =request.getParameter("iccid")==null?"":request.getParameter("iccid");       //证件号码
	String cust_id = "";     //集团客户ID
	String unit_id = "";     //集团编号
	String cust_name = "";   //集团客户名称
	String contract_no="" ;
	String unit_name="" ;
	String selType="radio";
	String account_id="";   //账户编号
	int recordNum = 0;      //查询得到的记录行数
	//String dateStr=request.getParameter("dateStr")==null?"":request.getParameter("dateStr");
	
//传给查询页面的参数
        String selected_contract_no="";
        String selected_login_accept="0";
        String selected_year_month="";	
        String selected_work_no="";
        String selected_op_code="";
        String selected_show_code="";
        String selected_print_type="";
        String selected_iccid_no="";
	
//得到列表操作
	String action=request.getParameter("action");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>集团客户详单查询</TITLE>
</HEAD>
<SCRIPT type=text/javascript>

//core.loadUnit("debug");
//core.loadUnit("rpccore");
onload=function(){
	
    //core.rpc.onreceive = doProcess;
}
function doProcess(packet)
{
    var retType = packet.data.findValueByName("retType");
    var retCode = packet.data.findValueByName("retCode");
		var retMessage=packet.data.findValueByName("retMessage");
    self.status="";
 //---------------------------------------
     if(retType == "checkPwd") //集团客户密码校验
     {
        if(retCode == "000000")
        {
            var retResult = packet.data.findValueByName("retResult");
            if (retResult == "false") {
    	    	rdShowMessageDialog("客户密码校验失败，请重新输入！",0);
	        	frm.custPwd.value = "";
	        	frm.custPwd.focus();
    	    	return false;	        	
            } else {
                rdShowMessageDialog("客户密码校验成功！",2);
                document.frm.commit.disabled=false;
            }
         }
        else
        {
            rdShowMessageDialog("客户密码校验出错，请重新校验！",0);
            document.frm.commit.disabled=true;
    		return false;
        }
     }	

     //---------------------------------------
 }
function check_HidPwd()
{
    if(document.frm.custPwd.value != "" ) 
   {
    var cust_id = document.all.cust_id.value;
    var Pwd1 = document.all.custPwd.value;
    var checkPwd_Packet = new AJAXPacket("pubCheckPwd.jsp","正在进行密码校验，请稍候......");
    checkPwd_Packet.data.add("retType","checkPwd");
	checkPwd_Packet.data.add("cust_id",cust_id);
	checkPwd_Packet.data.add("Pwd1",Pwd1);
	core.ajax.sendPacket(checkPwd_Packet);
	checkPwd_Packet = null;
     document.frm.str_Begin.focus();
    }
    else
    {
       rdShowMessageDialog("请填写密码！",0);    
    } 
}


//调用公共界面，进行集团客户选择
function getInfo_Cust()
{
    var pageTitle = "集团客户选择";
    var fieldName = "证件号码|客户ID|客户名称|集团ID|集团名称|";
	var sqlStr = "";
    var selType = "S";    //'S'单选；'M'多选
    var retQuence = "5|0|1|2|3|4|";
    var retToField = "iccid|cust_id|cust_name|unit_id|unit_name|";
    var cust_id = document.frm.cust_id.value;

    if(document.frm.iccid.value == "" &&
       document.frm.cust_id.value == "" &&
       document.frm.unit_id.value == "")
    {
        rdShowMessageDialog("请输入身份证号、客户ID或集团ID进行查询！",0);
        document.frm.iccid.focus();
        return false;
    }

    if(document.frm.cust_id.value != "" && forNonNegInt(frm.cust_id) == false)
    {
    	frm.cust_id.value = "";
        rdShowMessageDialog("必须是数字！",0);
    	return false;
    }

    if(document.frm.unit_id.value != "" && forNonNegInt(frm.unit_id) == false)
    {
    	frm.unit_id.value = "";
        rdShowMessageDialog("必须是数字！",0);
    	return false;
    }

    if(PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
}



function PubSimpSelCust(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/s2735/f2735_sel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType+"&iccid=" + document.all.iccid.value;
    path = path + "&cust_id=" + document.all.cust_id.value;
    path = path + "&unit_id=" + document.all.unit_id.value;
   

    retInfo = window.open(path,"newwindow","height=450, width=680,top=50,left=200,scrollbars=yes, resizable=no,location=no, status=yes");

	return true;
}

//公共界面-进行集团客户选择 返回赋值
function getvaluecust(retInfo)
{
 		  
  var retToField = "iccid|cust_id|cust_name|unit_id|account_id|";
  if(retInfo ==undefined)      
    {   return false;   }

	var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
        
    }
    
 document.frm.custPwd.focus();

}
function searchTO()
{
	var year_month_str="";
   if(document.all.str_Begin.value!=""&&document.all.iccid.value!="")
    {
    	//时间范围
     	if(document.frm.searchType.value == "0")
     		year_month_str=document.frm.beginTime.value+"^"+document.frm.endTime.value+"^" ;
     	else
     		year_month_str=document.frm.str_Begin.value.substring(0,6);
     		
     
     	document.frm.selected_year_month.value=document.frm.str_Begin.value.substring(0,6);//日期
     	document.frm.selected_iccid_no.value=document.frm.iccid.value;//日期
     	document.frm.selected_contract_no.value=document.frm.cust_id.value;//帐号
     	      
     	var path = "<%=request.getContextPath()%>/npage/s2735/f2735.jsp?";
    path = path + "selected_iccid_no=" + document.frm.selected_iccid_no.value;
    path = path + "&selected_contract_no=" + document.frm.selected_contract_no.value;
    path = path + "&selected_year_month=" + year_month_str;
    path = path + "&selectType=" + document.frm.selectType.value;
    path = path + "&meetingId=" + document.frm.meetingId.value;
    path = path + "&meetingInitiator=" + document.frm.meetingInitiator.value;
    path = path + "&searchType=" + document.frm.searchType.value;
//alert(path);

		window.open(path,"newwindow","height=450, width=1000,top=50,left=50,scrollbars=yes, resizable=no,location=no, status=yes");

    }
    else
        {
        	rdShowMessageDialog("请输入证件号码，查询月份等信息！",0);
    	}

}

// add by wanglma 20110602
function selChange(selType){
   	if(selType.value == "02"){
   		$("#mettingTd").show();
   	}else{
   		$("#mettingTd").hide();
   	}
}


    function seltimechange() {
        if (document.frm.searchType.selectedIndex == 0) {
            IList1.style.display = "";
            IList2.style.display = "none";
        } else {
            IList1.style.display = "none";
            IList2.style.display = "";
        }
    }
</script>

<BODY>
<FORM action="" method="post" name="frm" >
<input type="hidden" name="account_id"  value="<%=account_id%>">
<input type="hidden" name="selected_contract_no"  value="<%=selected_contract_no%>">
<input type="hidden" name="selected_year_month"  value="<%=selected_year_month%>">
<input type="hidden" name="selected_iccid_no"  value="<%=selected_iccid_no%>">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">集团客户详单查询</div>
</div>
<table cellspacing=0>
	      <TR>
            <TD width="18%" class='blue'>查询类型</TD>
            <TD colspan="3">
                <select name="selectType" id="selectType" onchange="selChange(this)" style="width:150px">
                	<option value="01" >行业网关</option>
                	<option value="02" >移动会议</option>
                	<option value="03" >集团客户IDC公众服务云</option>
                	<option value="04" >呼叫中心直连</option>
                	<option value="05" >企业阅读</option>
                	<option value="06" >企业彩漫</option>
                	<option value="07" >云视频会议</option>
									<option value="08" >企业智运会</option>
									<option value="09" >企业互联网电视</option>
                	<option value="00" >全部</option>
            	</select>
            </TD>
            
          </TR>
          <TR style="display:none" id="mettingTd" name="mettingTd">
          	<td width="18%" class='blue'>会议ID</td>
          	<td><input type="text" id="meetingId" name="meetingId" size="24" /></td>	
          	<td width="18%" class='blue'>会议发起人</td>
          	<td><input type="text" id="meetingInitiator" name="meetingInitiator" size="30" /></td>
     	  </TR>	
          
          <TR>
            <TD width="18%" class='blue'>证件号码</TD>
            <TD width="32%">
                <input name=iccid id="iccid" size="24" maxlength="20" v_type="string" v_must=1 index="1" value="<%=iccid%>" onKeyDown="if(event.keyCode==13)getInfo_Cust();" >
                <font class='orange'>*</font>
                <input name=custQuery type=button id="custQuery" class="b_text" onMouseUp="getInfo_Cust();" onKeyDown="if(event.keyCode==13)getInfo_Cust();" style="cursor:hand" value="查询">
            </TD>
            <TD width="18%" class='blue'>集团客户ID</TD>
            <TD width="32%">
              <input type="text"  name="cust_id" size="30" maxlength="11" v_type="0_9" v_must=1 index="2" value="<%=cust_id%>">
            </TD>
          </TR>
         
          <TR>
            <TD class='blue'>集团编号</TD>
            <TD>
		    <input name=unit_id  id="unit_id" size="24" maxlength="11" v_type="0_9" v_must=1  index="3" value="<%=unit_id%>">
            
            </TD>
            <TD class='blue'>集团客户名称</TD>
            <TD>
              <input name="cust_name" size="30" readonly v_must=1 v_type=string index="4" value="<%=cust_name%>">
          </TR>
          <TR>
            <TD width="18%" class='blue'>查询类型</TD>
            <TD colspan="3">
              <select name="searchType" onchange="seltimechange()">
                    <option value="0" >时间范围</option>
                    <option value="1" selected>出帐年月</option>
              </select>
            </TD>
            
        <TR style="display:none" id="IList1">
            <TD class="blue" width=16%>开始日期</TD>
            <TD width=34%>
                <input type="text" name="beginTime" id="beginTime" size="20" maxlength="8" value=<%=mon[1]+"01"%>>
            </TD>
            <TD class="blue" width=16%>结束日期</TD>
            <TD width=34%>
                <input type="text" name="endTime" id="endTime" size="20" maxlength="8" value=<%=mon[1]+"02"%>>
            </TD>
        </TR>

        <TR style="display:''" id="IList2">
            <TD class="blue" width=16%>出帐年月</TD>
            <TD colspan="3">
                <input type="text" id="str_Begin" name="str_Begin" size="20" maxlength="6" value=<%=mon[1]%>>
            </TD>
        </TR>
          
          <TD class='blue'>集团客户密码</TD>
            <TD colspan="3">
                <jsp:include page="/npage/common/pwd_1.jsp">
                    <jsp:param name="width1" value="16%"  />
                    <jsp:param name="width2" value="34%"  />
                    <jsp:param name="pname" value="custPwd"  />
                    <jsp:param name="pwd" value="<%=123%>"  />
                </jsp:include>
               <input name=chkPass type=button onClick="check_HidPwd();" class="b_text" style="cursor:hand" id="chkPass2" value=校验>
               <font class='orange'>*</font>
            </TD>
	   </tr>
 			<TR id='footer'>
          <td align=center	colspan=4 >
          <input class="b_foot" name=commit onClick="searchTO();" style="cursor:hand" type=button value=查询  disabled >
   	  		<input class="b_foot" name=back  type=button value="清除" onclick="window.location='s2735.jsp'">
   	  		<input class="b_foot" name=back onClick="removeCurrentTab()" style="cursor:hand" type=button value=关闭>
  	 			</td>
  	 </tr>
  </TABLE>
<jsp:include page="/npage/common/pwd_comm.jsp"/>
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
<script language="JavaScript">
document.frm.iccid.focus();
</script>
</BODY>
</HTML>
