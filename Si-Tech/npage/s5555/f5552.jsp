<%
  /*
   * 功能: 数据清理控制表
   * 版本: 1.0
   * 日期: 2009/04/04
   * 作者: yanpx
   * 版权: si-tech
   * update:
   */
%>
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
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
	for(int i=0;i<=2;i++)
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
		<title><%=opName%></title>   
		<script>
			function checkValue(){
				var owner_name=document.all.owner_name.value;
				var table_name=document.all.table_name.value;
				if (owner_name=="")
				{
				  rdShowMessageDialog("请输入属主！");
				  document.form1.owner_name.focus();
				  return false;
				}					
				if(table_name==""){
				  rdShowMessageDialog("请输入表名！");
				  document.form1.table_name.focus();
				  return false;
				}				

				var myPacket=new AJAXPacket("f5552_ajax.jsp","正在获取idNo，请稍候......");
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
							checkSelect(document.all.ol_use_flag,arrMsg[0][2]);
							checkSelect(document.all.ol_store_flag,arrMsg[0][3]);
							checkSelect(document.all.need_clean,arrMsg[0][4]);
							document.all.clean_stime.value=arrMsg[0][5];
							document.all.clean_freq.value=arrMsg[0][6];
							checkSelect(document.all.back_type,arrMsg[0][7]);
							document.all.back_add_type.value=arrMsg[0][8];
							document.all.back_path.value=arrMsg[0][9];
							checkSelect(document.all.back_ind_type,arrMsg[0][10]);
							checkSelect(document.all.back_ana_type,arrMsg[0][11]);
							checkSelect(document.all.clean_type,arrMsg[0][12]);
							document.all.clean_add_type.value=arrMsg[0][13];
							document.all.clean_desc.value=arrMsg[0][14];
							
							checkSelect(document.all.index_pos,arrMsg[0][15].substring(0,1));
							checkSelect(document.all.water_line,arrMsg[0][15].substring(1,2));
							checkSelect(document.all.table_analyse,arrMsg[0][15].substring(2,3));
							checkSelect(document.all.table_reb,arrMsg[0][15].substring(3,4));
							
							checkSelect(document.all.need_docum,arrMsg[0][16]);
				    	if(arrMsg[0][16]=="1"){
								document.all.docum_stime.disabled=false;
								document.all.docu_store_type.disabled=false;
								document.all.docu_store_time.disabled=false;
				    	}else{
								document.all.docum_stime.disabled=true;
								document.all.docu_store_type.disabled=true;
								document.all.docu_store_time.disabled=true;
								document.all.docu_store_type.value="";		    		
				    	}							
							
							document.all.docum_stime.value=arrMsg[0][17];
							checkSelect(document.all.docu_store_type,arrMsg[0][18]);
							document.all.docu_store_time.value=arrMsg[0][19];
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
					document.all.confirm.disabled=false;
				}
			}			
			function doCfm(){
				var table_name=document.form1.table_name.value;
				var owner_name=document.form1.owner_name.value;
				var clean_type=document.all.clean_type.value;
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
				if(clean_type=="0"){
					document.all.clean_add_type.value=document.all.owner_name.value+document.all.table_name.value+"整表迁移";
		    		document.all.back_add_type.value=document.all.owner_name.value+document.all.table_name.value+"整表迁移";					
				}else if(clean_type=="1"){	
					if(document.all.clean_add_type.value==""){
						  rdShowMessageDialog("请输入清理附加机制！");
						  document.form1.clean_add_type.focus();
						  return false;						
					}
					if(document.all.back_add_type.value==""){
						  rdShowMessageDialog("请输入备份附加机制！");
						  document.form1.back_add_type.focus();
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
		    function changeCon(){
		    	var need_docum=document.all.need_docum.value;
		    	if(need_docum=="1"){
						document.all.docum_stime.disabled=false;
						document.all.docu_store_type.disabled=false;
						document.all.docu_store_time.disabled=false;
		    	}else{
						document.all.docum_stime.disabled=true;
						document.all.docu_store_type.disabled=true;
						document.all.docu_store_time.disabled=true;
						document.all.docu_store_type.value="";		    		
		    	}

		    }
		    function claenChange(){
		    	var clean_type=document.all.clean_type.value;
		    	if(clean_type=="0"){
		    		document.getElementById("qlfjjz").style.display="none";
		    		document.getElementById("bffjjz").style.display="none";
		    	}else if(clean_type=="1"){
		    		document.getElementById("qlfjjz").style.display="";
		    		document.getElementById("bffjjz").style.display="";
		    	}else{
			    	document.getElementById("qlfjjz").style.display="";
		    		document.getElementById("bffjjz").style.display="";	    	
		    	}
		    }
		</script>
	</head>
	<body>
		<form name="form1" action="f5552_1.jsp">
   <DIV id="Operation_Table"> 
			<table cellspacing="0">
				<tr> 
					<td nowrap class="blue">属主 </td>
					<td nowrap > 
						<input type="text" name="owner_name" id="owner_name" v_type="string" maxlength="30"/>
						<font class="orange">*</font>
					</td>
					<td nowrap class="blue">表名称 </td>
					<td nowrap > 
						<input type="text" name="table_name" id="table_name" v_type="string" maxlength="30"/>
						<font class="orange">*</font>
						<input type="button" class="b_text" value="验证" onclick="checkValue();">
					</td>					
				</tr>
				<tr> 
					<td nowrap class="blue">可离线使用标识 </td>
					<td nowrap> 
						<select name="ol_use_flag">
		          			<option value="0" selected>否</option>
		          			<option value="1">是</option>	          			
		          		</select>
		          		<font class="orange">*</font>
					</td>
					<td nowrap class="blue">可离线保留标识 </td>
					<td nowrap > 
						<select name="ol_store_flag">
		          			<option value="0" selected>否</option>
		          			<option value="1">是</option>	          			
		          		</select>
		          		<font class="orange">*</font>
					</td>											
				</tr>		
				<tr> 
					<td nowrap class="blue">清理标识 </td>
					<td nowrap> 
						<select name="need_clean">
		          			<option value="0" selected>否</option>
		          			<option value="1">是</option>	          			
		          		</select>
		          		<font class="orange">*</font>
					</td>
					<td nowrap class="blue">数据可清理起始时长（单位月） </td>
					<td nowrap > 
						<input type="text" name="clean_stime" id="clean_stime" v_type="cfloat" v_must="1"/>
						<font class="orange">永久 0</font>
						<font class="orange">*</font>
					</td>											
				</tr>	
				<tr> 
					<td nowrap class="blue">清理频度（单位月） </td>
					<td nowrap > 
						<input type="text" name="clean_freq" id="clean_freq" v_type="cfloat" v_must="1"/>
						<font class="orange">*</font>
					</td>
					<td nowrap class="blue">备份机制 </td>
					<td nowrap > 
						<select name="back_type">
		          			<option value="0" selected>整表备份</option>
		          			<option value="1">SQL备份</option>
		          			<option value="2">自定义应用备份</option>
		          			<option value="3">垃圾数据不备份</option>
		          			<option value="4">分区备份</option>
		          		</select>
		          		<font class="orange">*</font>
					</td>					
				</tr>	
				<tr> 
					<td nowrap class="blue">清理机制 </td>
					<td nowrap> 
						<select name="clean_type" onchange="claenChange();">
		          			<option value="0" selected>整表迁移</option>
		          			<option value="1">SQL迁移</option>
		          			<option value="2">自定义应用迁移</option>
		          			<option value="3">分区表迁移</option>
		          		</select>
						<font class="orange">*</font>
					</td>					
					<td nowrap class="blue">备份数据位置 </td>
					<td nowrap > 
						<input type="text" name="back_path" id="back_path" v_type="string" v_must="1" maxlength="250"/>
						<font class="orange">*</font>
					</td>											
				</tr>			
				<tr> 
					<td nowrap class="blue">备份数据索引要求 </td>
					<td nowrap > 
						<select name="back_ind_type">
		          			<option value="0" selected>无索引</option>
		          			<option value="1">单独建立</option>
		          			<option value="2">与生产一致</option>
		          		</select>
						<font class="orange">*</font>
					</td>
					<td nowrap class="blue">备份数据表分析要求 </td>
					<td nowrap > 
						<select name="back_ana_type">
		          			<option value="0" selected>否</option>
		          			<option value="1">是</option>	          			
		          		</select>
						<font class="orange">*</font>
					</td>					
				</tr>	
				<tr id="qlfjjz" style="display:none"> 
					<td nowrap class="blue">清理附加机制 </td>
					<td nowrap colspan="3"> 
						<input size="90" type="text" name="clean_add_type" id="clean_add_type" v_type="string" maxlength="500"/>
						<font class="orange">*</font>
					</td>											
				</tr>
				<tr id="bffjjz" style="display:none"> 				
					<td nowrap class="blue">备份附加机制 </td>
					<td nowrap colspan="3"> 
						<input size="90" type="text" name="back_add_type" id="back_add_type" v_type="string"  maxlength="500"/>
		          		<font class="orange">*</font>
					</td>
				</tr>					
				<tr> 
					<td nowrap class="blue" style="background:#c4dffb">索引位 </td>
					<td nowrap style="background:#c4dffb"> 
					    <select name="index_pos">
		          			<option value="0" selected>无</option>
		          			<option value="1">更新</option>
		          			<option value="2">重建</option>
		          		</select>
						<font class="orange">*</font>
					</td>		
					<td nowrap class="blue" style="background:#c4dffb">水位线 </td>
					<td nowrap style="background:#c4dffb"> 
					    <select name="water_line">
		          			<option value="0" selected>无</option>
		          			<option value="1">回收</option>
		          		</select>
						<font class="orange">*</font>
					</td>								
				</tr>	
				<tr> 
					<td nowrap class="blue" style="background:#c4dffb">表分析 </td>
					<td nowrap style="background:#c4dffb"> 
					    <select name="table_analyse">
		          			<option value="0" selected>无</option>
		          			<option value="1">重新分析</option>
		          			<option value="2">更新表分析策略</option>
		          		</select>
						<font class="orange">*</font>
					</td>	
					<td nowrap class="blue" style="background:#c4dffb">表重建 </td>
					<td nowrap style="background:#c4dffb"> 
					    <select name="table_reb">
		          			<option value="0" selected>无</option>
		          			<option value="1">重建</option>
		          		</select>
						<font class="orange">*</font>
					</td>									
				</tr>	
				<tr> 
					<td nowrap class="blue">可归档标识 </td>
					<td nowrap> 
						<select name="need_docum" onchange="changeCon();">
							<option value="2" selected>请选择</option>
		          			<option value="0">否</option>
		          			<option value="1">是</option>	          			
		          		</select>
		          		<font class="orange">*</font>
					</td>
					<td nowrap class="blue">数据可归档保存起始时长（单位月） </td>
					<td nowrap > 
						<input type="text" name="docum_stime" id="docum_stime" v_type="cfloat" v_must="1" disabled/>
						<font class="orange">*</font>
					</td>											
				</tr>		
				<tr> 
					<td nowrap class="blue">归档保存方式 </td>
					<td nowrap > 
					    <select name="docu_store_type" disabled>
					    	<option value="" selected>请选择</option>
		          			<option value="0" >磁带归档</option>
		          			<option value="1">归档库归档</option>
		          			<option value="2">文件归档</option>
		          		</select>
						<font class="orange">*</font>
					</td>
					<td nowrap class="blue">归档保存时长（单位年） </td>
					<td nowrap > 
						<input type="text" name="docu_store_time" id="docu_store_time" v_type="cfloat" v_must="1" disabled/>
						<font class="orange">*</font>
					</td>					
				</tr>
				<tr>
					<td  nowrap class="blue">清理方法描述 </td>
					<td nowrap colspan="3"> 
						<input size="60" type="text" name="clean_desc" id="clean_desc" v_type="string" v_must="1"/>
						<font class="orange">*</font>
					</td>					
			    </tr>																													
				<tr> 
					<td colspan="4" id="footer"> 
						<input class="b_foot" type="button" name="confirm" value="确认" onClick="doCfm()" disabled/>  
						<input class="b_foot" type="button" name="back" value="清除" onClick="document.form1.reset()">  
					</td>
				</tr>
			</table>			
		</div>
		</br>
		</br>
		</br>
		<input type="hidden" name="opCode" value="<%=opCode%>"/>
		<input type="hidden" name="opName" value="<%=opName%>"/>
		<input type="hidden" name="flag" value=""/>
		</form>
	</body>
</html>
