<%
/********************
 
 -->>描述创建人、时间、模块的功能
 -------------------------创建-----------何敬伟2015-7-27 16:56:29------------------
十一、在营业前台新增中奖查询功能，查询条件为预约年月，展示结果为手机号码，姓名，证件号码，联系人，联系人电话
 -------------------------后台人员：dujl--------------------------------------------
 
********************/
%>
              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
<%@ include file="/npage/include/public_title_name.jsp" %> 

<%
	String opCode    = WtcUtil.repNull(request.getParameter("opCode"));
  String opName    = WtcUtil.repNull(request.getParameter("opName"));
  
  String workNo    = (String)session.getAttribute("workNo");
  String password  = (String)session.getAttribute("password");
  String workName  = (String)session.getAttribute("workName");
  String orgCode   = (String)session.getAttribute("orgCode");
  String ipAddrss  = (String)session.getAttribute("ipAddr");
  
  java.util.Calendar j_calendar = java.util.Calendar.getInstance();
  //j_calendar.add(java.util.Calendar.MONTH, -1);// 月份减1  
	String p_month_date = new java.text.SimpleDateFormat("yyyyMM").format(j_calendar.getTime());
	
	
%> 
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=JavaScript>
var regioncount=0;

//重置刷新页面
function reSetThis(){
	  location = location;	
}



//查询动态展示IMEI号码列表
function go_sM289Cfm(){
	if($("#region_code").val()==""&&$("#region_code").find("option:selected").text().trim()!="全省"){
		rdShowMessageDialog("请选择地市");
		return;
	}
	if(rdShowConfirmDialog('是否确定抽奖？')!=1) return;
	var packet = new AJAXPacket("fm289_2.jsp","正在执行,请稍后...");
			packet.data.add("opCode","<%=opCode%>");//opcode
			packet.data.add("y_year_month",$("#y_year_month").val().trim());//
			packet.data.add("region_code",$("#region_code").val().trim());//
			core.ajax.sendPacket(packet,do_sM290Qry);
			packet = null; 
}
//查询动态展示IMEI号码列表，回调
function do_sM290Qry(packet){
	var code = packet.data.findValueByName("code"); //返回代码
	var msg = packet.data.findValueByName("msg"); //返回信息
	if(code=="000000"){//查询成功后动态展示列表
			var retArray = packet.data.findValueByName("retArray");
			//获取数组成功，动态拼接列表
			var trObjdStr = "";
			//第二次以后查询会有多余行数据，所以删除除了title以外行的数据
			$("#upgMainTab tr:gt(0)").remove();
			
			for(var i=0;i<retArray.length;i++){
				  //如果有一条空记录不展示，服务返回数据为空字符串，服务改进后此逻辑可删除
						trObjdStr += "<tr>"+
														 "<td>"+retArray[i][0]+"</td>"+ // 
														 "<td>"+retArray[i][1]+"</td>"+ // 
														 "<td>"+retArray[i][2]+"</td>"+ // 
														 "<td>"+retArray[i][3]+"</td>"+// 
														 "<td>"+retArray[i][4]+"</td>"+// 
														 "<td>"+retArray[i][5]+"</td>"+// 
														 "<td>"+retArray[i][6]+"</td>"+// 
												 "</tr>";
			}
			//将拼接的行动态添加到table中
			$("#upgMainTab tr:eq(0)").after(trObjdStr);
	}else{
		  rdShowMessageDialog("查询失败，"+code+"："+msg,0);
	}
}

function to_excel_file(){
	exportTables(['upgMainTab']);
}

function exportTables(tableIds, flag){
  try{   
      rowIndex = 0;
      oXL = new ActiveXObject("Excel.Application");
      oWB = oXL.Workbooks.Add();
      oSheet = oWB.ActiveSheet;
      if (tableIds.length <= 0){
          return;
      }
      
      for (var i = 0; i < tableIds.length; i++){
          ExportToExcel(tableIds[i], flag);
      }
      //设置excel可见属性
      oXL.Visible = true;
  }catch(e){
        if((!+'\v1')){ //ie浏览器  
           alert("无法启动Excel，请确保电脑中已经安装了Excel!\n\n如果已经安装了Excel，" + 
               "请调整IE的安全级别。\n\n具体操作：\n\n"+"工具 → Internet选项 → 安全 → 自定义级别 → ActiveX 控件和插件 → 对未标记为可安全执行脚本的ActiveX 控件初始化并执行脚本 → 启用 → 确定"); 
        }else{ 
            alert("请使用IE浏览器进行“导入到EXCEL”操作！");  //方便设置安全等级，限制为ie浏览器  
        } 
    }
}

  function ExportToExcel(targetTable, flag) { 
      //取得表格行数
      $('#'+targetTable+' tr').each(function(i, e){
          var cols = $('td, th', this);
          cols.each(function(j, e){
              var value = $.trim($(this).text().replace(/\n/g, ''));
              if (value == ""){
                  value = $(this).find('input').val();
              }
              
              if (flag && (j + 1) == cols.length){
                  return true;
              }
              oSheet.Cells(rowIndex + 1, j + 1).NumberFormatLocal="@" ;//设置单元格为文本
              oSheet.Cells(rowIndex + 1, j + 1).value = value;
          });
          
          rowIndex++;
      });
  }
  function judgeCount(){
  		if($("#region_code").find(":selected").text()=="全省"){
  			var packet = new AJAXPacket("fm289_ajax_qrycount.jsp","正在执行,请稍后...");
				packet.data.add("y_year_month",$("#y_year_month").val().trim());
				core.ajax.sendPacket(packet,do_judgeCount);
				packet = null; 
  		}
  }
  function do_judgeCount(packet){
  		regioncount=packet.data.findValueByName("results");
  		if((regioncount/1)>10000){
  			rdShowMessageDialog("有效预约人数已超过限定值，请分地市抽选。",0);
  			$("#region_code").select(0);
  			$("#region_code").find("[text='--请选择--']").attr("selected",true);
  		}
  }

</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">查询条件</div></div>
<table cellSpacing="0">
	<tr>
	    <td class="blue" width="15%">预约年月：</td>
		  <td width="35%">
			    <input type="text"  name="y_year_month" id="y_year_month" readOnly="readOnly" value="<%=p_month_date%>"  onclick="WdatePicker({dateFmt:'yyyyMM',autoPickDate:true,onpicked:function(){}})" />  
		  </td>
		  <td class="blue" width="15%">选择地市：</td>
		  <td width="35%">
		  	<select name="region_code" id="region_code" onchange="judgeCount()">
					  <option value="" >--请选择--</option>
						<wtc:qoption name="sPubSelect" outnum="2">
								<wtc:sql>
										select 
											a.region_code,a.region_name 
										from 
											sregioncode a
										where 
											a.toll_no!='000'	
								</wtc:sql>
						</wtc:qoption>
						<option value="" >全省</option>
				</select>
		  </td>
	</tr>
	<tr>
		<td colspan="4" align="center" id="footer">
			<input type="button" class="b_text" value="抽奖" onclick="go_sM289Cfm()">
		</td>
	</tr>
	
</table>

<div class="title"><div id="title_zi">结果列表</div></div>
<TABLE cellSpacing="0" id="upgMainTab">
    <tr>
        <th width="15%">预约号码</th>
        <th width="15%">姓名</th>
        <th width="20%">证件号码</th>
        <th width="15%">联系人电话</th>	
        <th width="10%">地市</th>
        <th width="10%">区县</th>
        <th width="15%">办理营业厅</th>
    </tr>
     
</table>
<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="导出" onclick="to_excel_file()"           />
	 		<input type="button" class="b_foot" value="重置" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="关闭" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
