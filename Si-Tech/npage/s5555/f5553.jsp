<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * 功能: 数据库信息表
   * 版本: 1.0
   * 日期: 2009/04/04
   * 作者: yanpx
   * 版权: si-tech
   * update:
   */
%>
<%@ page contentType= "text/html;charset=gbk" %> 
<%@ page import="java.util.*"%>
<%@ include file="/npage/include/public_title_name.jsp" %>              
<%


 	String opCode = request.getParameter("opCode");
 	String opName = request.getParameter("opName");
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	String begin_date = "";

	Calendar cal = Calendar.getInstance(Locale.getDefault());
	cal.set(Integer.parseInt(dateStr.substring(0,4)),
                      (Integer.parseInt(dateStr.substring(4,6)) - 1),Integer.parseInt(dateStr.substring(6,8)));
	for(int i=0;i<=3;i++)
        {
              if(i!=3)
              {
                begin_date = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
                cal.add(Calendar.MONTH,-1);
              }
              else
                begin_date = new java.text.SimpleDateFormat("yyyyMM", Locale.getDefault()).format(cal.getTime());
        }
        begin_date=begin_date+"01"; 
%>                 

	<head>         
		<script type="text/javascript" src="/js/common/date/calendar.script"></script>	        
		<title><%=opName%></title>   
		<script type="text/javascript">
			function checkValue(){
				var owner_name=document.all.owner_name.value;
				var table_name=document.all.table_name.value;
				if(owner_name==""){
				  rdShowMessageDialog("请输入属主！");
				  document.form1.owner_name.focus();
				  return false;
				}				
				if (table_name=="")
				{
				  rdShowMessageDialog("请输入表名！");
				  document.form1.table_name.focus();
				  return false;
				}	
				var myPacket=new AJAXPacket("f5553_ajax.jsp","正在获取idNo，请稍候......");
				myPacket.data.add("owner_name",owner_name.trim());
				myPacket.data.add("table_name",table_name.trim());
				core.ajax.sendPacket(myPacket);
				myPacket=null;  
			}
			function doProcess(packet){
				var retType = packet.data.findValueByName("retType");
				if(retType=="1"){
					var retCode=packet.data.findValueByName("retCode");
					var retMsg=packet.data.findValueByName("retMsg");
					var arrMsg=packet.data.findValueByName("arrMsg");
					if(retCode=="000000"){
						if(arrMsg.length>0){
							checkSelect(document.all.app_belong,arrMsg[0][2]);
							checkSelect(document.all.table_space,arrMsg[0][3]);
							checkSelect(document.all.table_type,arrMsg[0][4]);
							document.all.create_login.value=arrMsg[0][5];
							document.all.busi_login.value=arrMsg[0][6];
							document.all.busi_desc.value=arrMsg[0][7];
							checkSelect(document.all.key_info,arrMsg[0][8]);
							checkSelect(document.all.struc_main_type,arrMsg[0][9]);
							document.all.busi_crtime.value=arrMsg[0][10].substring(0,8);
							document.all.space_msize.value=arrMsg[0][11];
							checkSelect(document.all.use_type,arrMsg[0][12]);
							checkSelect(document.all.offline_use_flag,arrMsg[0][13]);
							document.all.data_bus_time.value=arrMsg[0][14];
							checkSelect(document.all.need_clean,arrMsg[0][15]);
							checkSelect(document.all.back_use_target,arrMsg[0][16]);
							checkSelect(document.all.back_use_demand,arrMsg[0][17]);
							checkSelect(document.all.back_use_support,arrMsg[0][18]);
							document.all.back_use_mathod.value=arrMsg[0][19];
							document.all.flag.value="u";
							rdShowMessageDialog('数据已存在，可修改'); 
					    }else{
					    	var owner_name=packet.data.findValueByName("owner_name");
							var table_name=packet.data.findValueByName("table_name");
					    	document.form1.reset();
					    	document.all.owner_name.value=owner_name;
					    	document.all.table_name.value=table_name;
					    	document.all.flag.value="a";
					    	rdShowMessageDialog('数据不存在，可新增'); 
					    } 
						document.all.confirm.disabled=false;
					}else{
						rdShowMessageDialog(retMsg,0);
					}
				}
			}					
			function doCfm(){
				var table_name=document.form1.table_name.value;
				var owner_name=document.form1.owner_name.value;
				var fmt1="$YYYYMM";
				var fmt2="$YYYY";
				var fmt3="$MM";
				var fmt4="$XX";
				var fmt5="$X";

				if(!check(document.form1)){
					return false;
				}				
				if (table_name=="")
				{
				  rdShowMessageDialog("请输入表名！");
				  document.form1.table_name.focus();
				  return false;
				}
				if (owner_name=="")
				{
				  rdShowMessageDialog("请输入属主！");
				  document.form1.owner_name.focus();
				  return false;
				}
				var struc_main_type =document.all.struc_main_type.value;
				if(struc_main_type=="1"){
					if(table_name.indexOf(fmt1)==-1&&table_name.indexOf(fmt2)==-1&&table_name.indexOf(fmt3)==-1&&table_name.indexOf(fmt5)==-1&&table_name.indexOf(fmt5)==-1)
					{
						  rdShowMessageDialog("表名格式不正确");
						  document.form1.table_name.focus();
						  return false;					
					}
				}			
					
				document.form1.submit();
			}
			//根据查询的值更改下拉框的选中项，a为select对象，b为值
			function checkSelect(a,b){
				var lengths = a.options.length;//下拉项的长度 
				for(var i=0;i<lengths;i++){   
					if(b == a.options[i].value){       
						a.options[i].selected=true;       
					}   
				} 
			}			
			/***************************	
			function al(){
				var struc_main_type =document.all.struc_main_type.value;
				if(struc_main_type=="1"){
					document.getElementById("tableName").className = "promptBlue";
					$("#tableName").attr("title","分表表名格式为：表名$YYYYMM,表名$YYYY,表名$MM,表名$XX,表名$X");
					$("#tableName").tooltip();
				}
			}
			function rm(){
				document.getElementById("tableName").className = "";
				$("#tableName").attr({title:""});
				$("#tableName").tooltip();
			}
			*******************************/
			function chg(){
				var struc_main_type =document.all.struc_main_type.value;
				if(struc_main_type=="1"){
					document.getElementById("tableName").className = "promptBlue";
					$("#tableName").attr("title","分表表名格式为：表名$YYYYMM,表名$YYYY,表名$MM,表名$XX,表名$X </br> 其他格式不限制");
					$("#tableName").tooltip();
				}else{
					document.getElementById("tableName").className = "";
					$("#tableName").attr("title","");
					$("#tableName").tooltip();					
				}				
			}
		</script>
	</head>
	<body>
		<form name="form1" action="f5553_1.jsp">
<div id="Main">
   <DIV id="Operation_Table"> 
			<table cellspacing="0">
				<tr> 
					<td nowrap class="blue">属主 </td>
					<td nowrap > 
						<input type="text" name="owner_name" id="owner_name" v_type="string" maxlength="30"/>
						<font class="orange">*</font>
					</td>
					<td nowrap class="blue">表名称 </td>
					<td nowrap id="tableName"> 
						<input type="text" name="table_name" id="table_name" v_type="string" maxlength="30"/>
						<font class="orange">*</font>
						<input type="button" class="b_text" value="验证" onclick="checkValue();">
					</td>					
				</tr>
				<tr> 
					<td nowrap class="blue">归属应用系统 </td>
					<td nowrap> 
						<select name="app_belong">
		          			<option value="0" selected>营业</option>
		          			<option value="1">计费</option>
		          			<option value="2">帐务</option>
		          			<option value="3">结算</option>
		          			<option value="4">BOMC</option>	          			
		          		</select>
		          		<font class="orange">*</font>
					</td>
					<td nowrap class="blue">建立人员 </td>
					<td nowrap > 
						<input type="text" name="create_login" id="create_login" v_type="string" v_must="1" maxlength="100"/>
						<font class="orange">多人则用|分隔</font>
						<font class="orange">*</font>
					</td>															
				</tr>		
				<tr> 
					<td nowrap class="blue">表类型 </td>
					<td nowrap> 
						<select name="table_type">
		          			<option value="0" selected>流水表</option>
		          			<option value="1">资料表</option>
		          			<option value="2">配置表</option>
		          			<option value="3">临时表</option>
		          		</select>
		          		<font class="orange">*</font>
					</td>
					<td nowrap class="blue">表空间 </td>
					<td nowrap > 
						<select name="table_space">
					       <wtc:qoption name="sPubSelect" outnum="2">
					          <wtc:sql>select tablespace_name,tablespace_name as name from dba_tablespaces</wtc:sql>
					       </wtc:qoption>
		          		</select>
		          		<font class="orange">*</font>
					</td>										
				</tr>	
				<tr> 
					<td nowrap class="blue">业务人员 </td>
					<td nowrap > 
						<input type="text" name="busi_login" id="busi_login" v_type="string" maxlength="100"/>
					</td>
					<td nowrap class="blue">对应业务描述 </td>
					<td nowrap > 
						<input type="text" name="busi_desc" id="busi_desc" v_type="string" maxlength="200"/>
					</td>					
				</tr>	
				<tr> 
					<td nowrap class="blue">关键信息情况 </td>
					<td nowrap> 
						<select name="key_info">
		          			<option value="0" selected>主体结构表</option>
		          			<option value="1">附加功能表</option>
		          			<option value="2">子系统主体结构表</option>
		          		</select>
		          		<font class="orange">*</font>
					</td>
					<td nowrap class="blue">结构主体类型 </td>
					<td nowrap > 
						<select name="struc_main_type" onchange="chg()">
		          			<option value="0" selected>分区表</option>
		          			<option value="1">分表</option>
		          			<option value="2">单一表</option>
		          		</select>
						<font class="orange">*</font>
					</td>											
				</tr>			
				<tr> 
					<td nowrap class="blue">业务新增时间 </td>
					<td nowrap > 
						<input type="text" name="busi_crtime" id="busi_crtime" v_type="date" v_must="1"/>
						<!--input type="button" class="b_text" value="时间" onclick="fPopCalendar(busi_crtime,busi_crtime);return false"/-->
						<font class="orange">*</font>
					</td>
					<td nowrap class="blue">存储空间（单位M） </td>
					<td nowrap > 
						<input type="text" name="space_msize" id="space_msize" v_type="cfloat" v_must="1"/>
						<font class="orange">*</font>
					</td>					
				</tr>	
				<tr> 
					<td nowrap class="blue">使用类型 </td>
					<td nowrap> 
						<select name="use_type">
		          			<option value="0" selected>供查询</option>
		          			<option value="1">业务更新</option>
		          		</select>
					</td>
					<td nowrap class="blue">需离线使用标识 </td>
					<td nowrap > 
						<select name="offline_use_flag">
		          			<option value="0" selected>否</option>
		          			<option value="1">是</option>
		          		</select>
					</td>											
				</tr>		
				<tr> 
					<td nowrap class="blue">数据保留业务期限（单位月） </td>
					<td nowrap > 
						<input type="text" name="data_bus_time" id="data_bus_time" v_type="cfloat" v_must="1"/>
						<font class="orange">*</font>
					</td>
					<td nowrap class="blue">需清理标识 </td>
					<td nowrap > 
						<select name="need_clean">
		          			<option value="0" selected>否</option>
		          			<option value="1">是</option>
		          		</select>
						<font class="orange">*</font>
					</td>					
				</tr>	
				<tr> 
					<td nowrap class="blue">备份数据使用目标 </td>
					<td nowrap> 
						<select name="back_use_target">
		          			<option value="0" selected>用户查询需要</option>
		          			<option value="1">障碍查询</option>
		          			<option value="2">统计分析</option>
		          		</select>
					</td>
					<td nowrap class="blue">备份数据使用要求 </td>
					<td nowrap > 
						<select name="back_use_demand">
		          			<option value="0" selected>生产界面查询</option>
		          			<option value="1">历史界面查询</option>
		          			<option value="2">文件查询</option>
		          			<option value="3">数据库查询</option>
		          		</select>
					</td>											
				</tr>		
				<tr> 
					<td nowrap class="blue">备份数据使用支持 </td>
					<td nowrap > 
						<select name="back_use_support">
		          			<option value="0" selected>可生产界面查询</option>
		          			<option value="1">可界面查询</option>
		          			<option value="2">可文件查询</option>
		          			<option value="3">可数据库查询</option>
		          		</select>
					</td>
					<td nowrap class="blue">备份数据使用方法 </td>
					<td nowrap > 
						<input type="text" name="back_use_mathod" id="back_use_mathod" v_type="string" maxlength="50"/>
					</td>					
				</tr>																									
				<tr> 
					<td colspan="4" id="footer"> 
						<input class="b_foot" type="button" name="confirm" value="确认" onClick="doCfm()" disabled/>  
						<input class="b_foot" type="button" name="back" value="清除" onClick="document.form1.reset()">  
					</td>
				</tr>
			</table>			
		<%@ include file="/npage/include/footer_simple.jsp" %> 
		<input type="hidden" name="opCode" value="<%=opCode%>"/>
		<input type="hidden" name="opName" value="<%=opName%>"/>
		<input type="hidden" name="flag" value=""/>
		</form>
	</body>
</html>
