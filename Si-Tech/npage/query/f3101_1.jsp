<%
   /*
   * 功能: 集团客户历史信息查询
　 * 日期: 2007-12-24
　 * 作者: 芦学琛
   * update by qidp @ 2009-09-07 for 集团新版产品管理改造
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
	Logger logger = Logger.getLogger("f3101_1.jsp");
	 
	String workName = WtcUtil.repNull((String)session.getAttribute("workName"));
	String orgCode = WtcUtil.repNull((String)session.getAttribute("orgCode"));
	String workNo = WtcUtil.repNull((String)session.getAttribute("workNo"));
	String ip_Addr = WtcUtil.repNull((String)session.getAttribute("ipAddr"));
	String regionCode = WtcUtil.repNull((String)session.getAttribute("regCode"));
		
	String returnFlag = request.getParameter("returnFlag");
	
	String op_name = "集团客户历史信息查询";
	
	String opCode = "3101";
	String opName = "集团客户历史信息查询";
	
%>

<html>
<head>
<title><%=op_name%></title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
</head> 
<script language=javascript>
	

//core.loadUnit("debug");
//core.loadUnit("rpccore");
onload=function() 
{
	self.status="";
	//core.rpc.onreceive = doProcess;
}

function doProcess(packet) 
{
	var errCode=packet.data.findValueByName("errCode");
	var errMsg=packet.data.findValueByName("errMsg");

	if(parseInt(errCode)!=0)
	{
		rdShowMessageDialog("错误代码："+errCode+",错误信息："+errMsg,0);
		return false;
	}
	else
	{
		
		var unit_id		=packet.data.findValueByName("unit_id");
		
		var unit_name  	=packet.data.findValueByName("unit_name");
		
		var service_no 	=packet.data.findValueByName("service_no");
		var update_time =packet.data.findValueByName("update_time");
		var update_login=packet.data.findValueByName("update_login");
		var update_code =packet.data.findValueByName("update_code");
		var update_name =packet.data.findValueByName("update_name");
		
		var update_type =packet.data.findValueByName("update_type");
		
		var new_service_no =packet.data.findValueByName("new_service_no");		
		
		var num         =packet.data.findValueByName("num");

		for(i=0;i<unit_id.length;i++)
		{
			var tr1=tab1.insertRow();
			tr1.id="tr";
			if((i+1)%2==1){
				tr1.bgColor="#f5f5f5";
			}
			else{
				tr1.bgColor="#e8e8e8";
			}
			tr1.insertCell(0).innerHTML = '<td>'+unit_id[i]		+'</td>';
			tr1.insertCell(1).innerHTML = '<td>'+unit_name[i]		+'</td>';
			tr1.insertCell(2).innerHTML = '<td>'+service_no[i]	+'</td>';
			tr1.insertCell(3).innerHTML = '<td>'+update_time[i]	+'</td>';
			tr1.insertCell(4).innerHTML = '<td>'+update_login[i]	+'</td>';
			tr1.insertCell(5).innerHTML = '<td>'+update_code[i]	+'</td>';
			tr1.insertCell(6).innerHTML = '<td>'+update_name[i]	+'</td>';
			tr1.insertCell(7).innerHTML = '<td>'+update_type[i]	+'</td>';
			tr1.insertCell(8).innerHTML = '<td>'+new_service_no[i]	+'</td>';			
		}
	}
}

function validDate(obj)
{
    var theDate = "";
    var one = "";
    var flag = "0123456789";
    for (i = 0; i < obj.value.length; i++)
    {
        one = obj.value.charAt(i);
        if (flag.indexOf(one) != -1)
            theDate += one;
    }
    if (theDate.length != 8)
    {
        rdShowMessageDialog("日期格式有误，正确格式为“年年年年月月日日”，请重新输入！");
	//obj.value="";
        obj.select();
        obj.focus();
        return false;
    }
    else
    {
        var year = theDate.substring(0, 4);
        var month = theDate.substring(4, 6);
        var day = theDate.substring(6, 8);
        if (myParseInt(year) < 1900 || myParseInt(year) > 3000)
        {
            rdShowMessageDialog("年的格式有误，有效年份应介于1900-3000之间，请重新输入！");
	   //obj.value="";
            obj.select();
            obj.focus();
            return false;
        }
        if (myParseInt(month) < 1 || myParseInt(month) > 12)
        {
            rdShowMessageDialog("月的格式有误，有效月份应介于01-12之间，请重新输入！");
  	   //obj.value="";
            obj.select();
            obj.focus();
            return false;
        }
        if (myParseInt(day) < 1 || myParseInt(day) > 31)
        {
            rdShowMessageDialog("日的格式有误，有效日期应介于01-31之间，请重新输入！");
	   //obj.value="";
            obj.select();
            obj.focus();
            return false;
        }

        if (month == "04" || month == "06" || month == "09" || month == "11")
        {
            if (myParseInt(day) > 30)
            {
                rdShowMessageDialog("该月份最多30天,没有31号！");
 	         //obj.value="";
                obj.select();
                obj.focus();
                return false;
            }
        }

        if (month == "02")
        {
            if (myParseInt(year) % 4 == 0 && myParseInt(year) % 100 != 0 || (myParseInt(year) % 4 == 0 && myParseInt(year) % 400 == 0))
            {
                if (myParseInt(day) > 29)
                {
                    rdShowMessageDialog("闰年二月份最多29天！");
      	     //obj.value="";
                    obj.select();
                    obj.focus();
                    return false;
                }
            }
            else
            {
                if (myParseInt(day) > 28)
                {
                    rdShowMessageDialog("非闰年二月份最多28天！");
      	     //obj.value="";
                    obj.select();
                    obj.focus();
                    return false;
                }
            }
        }
    }
    return true;
}
function commitJsp(){
	if(!check(form1)) return false;
	
	var rows=tab1.rows.length;
	for(i=1;i<rows;i++){
		tab1.deleteRow(1);
	}
	if(document.all.begin_time.value!="")
	{
		if(!validDate(document.all.begin_time))
		{
			return false;
		}
	}
	if(document.all.end_time.value!="")
	{
		if(!validDate(document.all.end_time)&&document.all.end_time.value!="")
		{
			return false;
		}
	}
	var unit_id=document.all.unit_id.value;
	var begin_time=document.all.begin_time.value;
	var end_time=document.all.end_time.value;
	
	var myPacket = new AJAXPacket("f3101_2.jsp","正在查询,请稍候......");
	myPacket.data.add("unit_id",unit_id);
	myPacket.data.add("begin_time",begin_time);
	myPacket.data.add("end_time",end_time);
	core.ajax.sendPacket(myPacket);
	myPacket = null;
}
	
</script>

<body>
<form name="form1" method="post" action="">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">集团客户历史信息查询</div>
</div>
	<TABLE id="mainOne" cellspacing="0" >
		<TBODY>
			<tr id="line_1"> 
				<td class='blue' nowrap>
					集团编码
				</td>
				<td>
					<input   type="text"  v_type="0_9"   v_maxlength=14 v_must="1" name="unit_id" maxlength="14" >
					<font class="orange">*</font>
				</td>
				<td class='blue' nowrap>开始时间</td>
				<td>
					<input type=text  v_type="0_9"  name="begin_time" maxlength="8">
					(YYYYMMDD)
				</td>
				<td class='blue' nowrap>结束时间</td>
				<td>
					<input type=text  v_type="0_9" name="end_time" maxlength="8">
					(YYYYMMDD)
				</td>
			</tr>
		</TBODY>
	</TABLE> 
	<TABLE cellSpacing=0>
		<TR id="footer"> 
			<TD> 
		    	<input name="bSubmit1" style="cursor:hand" type="button" class="b_foot" value="查询列表" onClick="commitJsp()">
		    	<input name="" style="cursor:hand" type="reset" class="b_foot" value="重置">
		    	<input name="" style="cursor:hand" type="button" class="b_foot" value="关闭" onClick="javascript:removeCurrentTab();">
			</TD>
		</TR>
		
	</TABLE>
	<table width="98%" cellspacing=0 height="20" id="tab1" name="tab1">
		<tr>
			<th align='center'>集团代码</th>         
			<th align='center'>集团名称</th>
			<th align='center'>历史客户经理工号</th>
			<th align='center'>操作时间</th>
			<th align='center'>操作工号</th>
			<th align='center'>操作代码</th>
			<th align='center'>操作名称</th>
			<th align='center'>数据标识</th>
			<th align='center'>当前客户经理工号</th>				
		</tr>
	</table>
<%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>