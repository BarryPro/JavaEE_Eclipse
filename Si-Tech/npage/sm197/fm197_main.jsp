<%
  /*
   * 功能: m197·和家庭--爱家套餐业务办理查询 
   * 版本: 1.0
   * 日期: 2014/11/26 
   * 作者: diling
   * 版权: si-tech
   * update:
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/tr/xhtml1/DTD/xhtml1-transitional.dtd">
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%  request.setCharacterEncoding("GBK");%>
<%
	String opCode = request.getParameter("opCode");
 	String opName = request.getParameter("opName");
	String work_no = (String)session.getAttribute("workNo");
	String rpt_right = (String)session.getAttribute("rptRight");
	String org_code = (String)session.getAttribute("orgCode");

  String sqlStr="";
	String currentTime = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String currFirstDay = currentTime.substring(0,6)+"01";
%>

<script language=JavaScript>
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>新营业员操作统计表</TITLE>

</HEAD>
<body>
<!--wanghfa 20100602 解耦修改 start-->
<script src="f1615_crm.js" type="text/javascript"></script>	
<script src="f1615_crm_report.js" type="text/javascript"></script>	
<script src="f1615_boss.js" type="text/javascript"></script>	
<!--wanghfa 20100602 解耦修改 end-->
<script language="JavaScript">
//----弹出一个新页面选择组织节点--- 增加
function select_groupId()
{
	var path = "<%=request.getContextPath()%>/npage/rpt/common/grouptree.jsp";
    window.open(path,'_blank','height=600,width=300,scrollbars=yes');
}
</script>
<SCRIPT language="JavaScript">
function doSubmit()
{
	if(!check(form1)){
    return false;
  }
	var slecOperType =$("input[@name=opType][@checked]").val();  //操作类型
	var groupId = "";
	var login_no = $("#login_no").val();
	var operChannel = $("#operChannel").val();//办理渠道
	if(slecOperType == "0"){ //组织结构
		groupId = $("input[name='groupId']").val();	
		if(groupId == ""){
			rdShowMessageDialog("请选择组织结构树进行查询！");
    	return false;
		}
	}else{
		if(login_no == ""){
			rdShowMessageDialog("请输入营业员工号！");
    	return false;
		}
	}
  var begin_time=document.form1.begin_time.value;
  var end_time=document.form1.end_time.value;
  if(begin_time>end_time)
  {
    rdShowMessageDialog("开始时间比结束时间大!");
    return false;
  }
  
  if(end_time > "<%=currentTime%>"){
  	rdShowMessageDialog("结束时间不能大于当前时间！");
    return false;
  }
  
  var sdate = begin_time.substring(0,4) + "-" + begin_time.substring(4,6) + "-" + begin_time.substring(6,8);
  var edate = end_time.substring(0,4) + "-" + end_time.substring(4,6) + "-" + end_time.substring(6,8);
  if(DateDiff(sdate,edate) > 30){
  	rdShowMessageDialog("为避免查询时间跨度过大，请将查询时间范围限制在一个自然月以内！");
    return false;
  }
  
  if(begin_time.substring(4,6) != end_time.substring(4,6)){
  	rdShowMessageDialog("请将查询时间范围限制在一个自然月以内！");
    return false;
  }

	var packet = new AJAXPacket("fm197_ajax_query.jsp","正在获得数据，请稍候......");
	packet.data.add("login_no",login_no);
	packet.data.add("opCode","<%=opCode%>");
	packet.data.add("opName","<%=opName%>");
	packet.data.add("begin_time",begin_time);
	packet.data.add("end_time",end_time);
	packet.data.add("groupId",groupId);
	packet.data.add("operChannel",operChannel);
	core.ajax.sendPacketHtml(packet,doQuery);
	packet = null;
}

function doQuery(data){
	//找到添加表格的div
	var markDiv=$("#intablediv"); 
	markDiv.empty();
	markDiv.append(data);
  var retCode = $("#retCode").val();
  var retMsg = $("#retMsg").val();
  if(retCode!="000000"){
     rdShowMessageDialog("错误代码："+retCode+"<br>错误信息："+retMsg,0);
     window.location.href="fm197_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
  }
}

var excelObj;

function printTable(obj){
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	if(document.all.t1.length > 1)	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 //excelObj.WorkBooks.Add; 
    var workB = excelObj.Workbooks.Add(); ////添加新的工作簿   
   var sheet = workB.ActiveSheet;   

  sheet.Columns("E").ColumnWidth =16;//设置列宽
  sheet.Columns("E").numberformat="@";  
  sheet.Columns("F").ColumnWidth =16;//设置列宽
  sheet.Columns("F").numberformat="@"; 

		for(a=0;a<document.all.t1.length;a++)
		{
			rows=obj[a].rows.length;
			if(rows>0)
			{
 				try
				{
					for(i=0;i<rows;i++)					{
						cells=obj[a].rows[i].cells.length;
						var g=0;
						for(j=0;j<cells;j++)
						{
							if(obj[a].rows[i].cells[j].colSpan > 1)
							{
							var colspan = obj[a].rows[i].cells[j].colSpan;
							for(g=0;g<colspan-1;g++)
								{
									excelObj.Cells(i+1+(total_row),1*g+1).Value='';
					            }
								g++;
					  		    excelObj.Cells(i+1+(total_row),g).Value=obj[a].rows[i].cells[j].innerText;
							}
							else
							{
							excelObj.Cells(i+1+(total_row),1*g+1).Value=obj[a].rows[i].cells[j].innerText;
							g++;
							}
						}
					}
				}
				catch(e)
				{
					alert('生成excel失败!');
				}
			}
			else
			{
				alert('no data');
 			}
 			total_row = eval(total_row+rows);
		}
	}
	else
	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 //excelObj.WorkBooks.Add; 
   var workB = excelObj.Workbooks.Add(); ////添加新的工作簿   
   var sheet = workB.ActiveSheet;   

  sheet.Columns("E").ColumnWidth =16;//设置列宽
  sheet.Columns("E").numberformat="@"; 
  sheet.Columns("F").ColumnWidth =16;//设置列宽
  sheet.Columns("F").numberformat="@"; 
		rows=obj.rows.length;
		if(rows>0)
		{
 			try
			{
				for(i=0;i<rows;i++)
				{
					cells=obj.rows[i].cells.length;
					var g=0;
					for(j=0;j<cells;j++)
					{
							if(obj.rows[i].cells[j].colSpan > 1)
							{
							var colspan = obj.rows[i].cells[j].colSpan;
							for(g=0;g<colspan-1;g++)
								{
									excelObj.Cells(i+1+(total_row),1*g+1).Value = '';
					            }
								g++;
					  		    excelObj.Cells(i+1+(total_row),g).Value=obj.rows[i].cells[j].innerText;
							}
							else
							{
							excelObj.Cells(i+1+(total_row),1*g+1).Value=obj.rows[i].cells[j].innerText;
							g++;
							}
					}
				}
			}
			catch(e)
			{
				alert('生成excel失败!');
			}
			total_row = eval(total_row+rows);
		}
		else
		{
			alert('no data');
		}
	}
	excelObj.Range('A1:'+str.charAt(cells+colspan-2)
+total_row).Borders.LineStyle=1;
}

function  DateDiff(sDate1,  sDate2){    //sDate1和sDate2是2002-12-18格式  
   var  aDate,  oDate1,  oDate2,  iDays;  
   aDate  =  sDate1.split("-");  
   oDate1  =  new  Date(aDate[1]  +  '-'  +  aDate[2]  +  '-'  +  aDate[0]) ;   //转换为12-18-2002格式  
   aDate  =  sDate2.split("-");  
   oDate2  =  new  Date(aDate[1]  +  '-'  +  aDate[2]  +  '-'  +  aDate[0]);  
   iDays  =  parseInt(Math.abs(oDate1  -  oDate2)  /  1000  /  60  /  60  /24);    //把相差的毫秒数转换为天数  
   return  iDays;  
}

function selOpType(obj){
	if(obj.value == "0"){ //组织结构
		$("#groupTr").show();
		$("#loginNoTr").hide();
	}else{
		$("#loginNoTr").show();
		$("#groupTr").hide();
	}
}

$("table[vColorTr='set']").each(function(){
  $(this).find("tr").each(function(i,n){
    $(this).bind("mouseover",function(){
    	$(this).addClass("even_hig");
    });
    
    $(this).bind("mouseout",function(){
    	$(this).removeClass("even_hig");
    });
    
    if(i%2==0){
    	$(this).addClass("even");
    }
  });
});

</SCRIPT>

<FORM method=post name="form1" action="#">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">查询条件</div>
	</div>
<table cellSpacing="0">
	<tr>
		<td class="blue">操作类型</td>
		<td colspan="3">
			&nbsp;
			<input type="radio" id="opType1" name="opType" value="0" checked onclick="selOpType(this)" />组织结构
			&nbsp;&nbsp;&nbsp;
			<input type="radio" id="opType2" name="opType" value="1" onclick="selOpType(this)" />营业员
		</td>
	</tr>
	<tr id="groupTr">
		<td class="blue">组织节点</td>
		<td colspan="3">
			<input type="hidden" name="groupId">
			<input type="text" name="groupName" v_must="1" v_type="string" maxlength="60" class="InputGrey" readonly>&nbsp;
			<input name="addButton" class="b_text"  type="button" value="选择" onClick="select_groupId()" >	
		</td>
	</tr>
	<tr id="loginNoTr" style="display:none">
		<td class="blue">营业员工号</td>
		<td colspan="3">
			<input type="text" id="login_no" name="login_no" value="<%=work_no%>" class="InputGrey" readonly  />
		</td>
	</tr>
	<tr>
		<TD class="blue">办理渠道</td>
		<td colspan="3">
			<select id="operChannel" name="operChannel">
				<option value="0">省广电</option>
				<option value="1">移动</option>
				<option value="2">全部</option>
			</select>
		</td>
	</tr>
	<tr id=a_time style="display=''">
		<td class="blue">开始时间</td>
		<td>
			<input type="text" id="begin_time"   name="begin_time" value="<%=currFirstDay%>"  maxlength="8" v_must="1" v_type="date" />
			&nbsp;<font color="orange">*</font>
		</td>
		<td class="blue">结束时间</td>
		<td>
			<input type="text" id="end_time"   name="end_time" value="<%=currentTime%>"  maxlength="8" v_must="1" v_type="date"  />
			&nbsp;<font color="orange">*</font>
		</td>
	</tr>
	<tr> 
		<td align="center" id="footer" colspan="4">
			&nbsp; <input id=submits class="b_foot" name=submits onclick="doSubmit()" type=button value="查询" />
			&nbsp; <input class="b_foot" name=retBtn  type=button onClick="form1.reset()" value="重置" />
			&nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=关闭 />
		</td>
	</tr>
</table>
  <div id="intablediv"></div>
	<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>

