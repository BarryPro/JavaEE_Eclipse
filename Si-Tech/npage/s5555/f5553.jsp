<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%
  /*
   * ����: ���ݿ���Ϣ��
   * �汾: 1.0
   * ����: 2009/04/04
   * ����: yanpx
   * ��Ȩ: si-tech
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
				  rdShowMessageDialog("������������");
				  document.form1.owner_name.focus();
				  return false;
				}				
				if (table_name=="")
				{
				  rdShowMessageDialog("�����������");
				  document.form1.table_name.focus();
				  return false;
				}	
				var myPacket=new AJAXPacket("f5553_ajax.jsp","���ڻ�ȡidNo�����Ժ�......");
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
							rdShowMessageDialog('�����Ѵ��ڣ����޸�'); 
					    }else{
					    	var owner_name=packet.data.findValueByName("owner_name");
							var table_name=packet.data.findValueByName("table_name");
					    	document.form1.reset();
					    	document.all.owner_name.value=owner_name;
					    	document.all.table_name.value=table_name;
					    	document.all.flag.value="a";
					    	rdShowMessageDialog('���ݲ����ڣ�������'); 
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
				  rdShowMessageDialog("�����������");
				  document.form1.table_name.focus();
				  return false;
				}
				if (owner_name=="")
				{
				  rdShowMessageDialog("������������");
				  document.form1.owner_name.focus();
				  return false;
				}
				var struc_main_type =document.all.struc_main_type.value;
				if(struc_main_type=="1"){
					if(table_name.indexOf(fmt1)==-1&&table_name.indexOf(fmt2)==-1&&table_name.indexOf(fmt3)==-1&&table_name.indexOf(fmt5)==-1&&table_name.indexOf(fmt5)==-1)
					{
						  rdShowMessageDialog("������ʽ����ȷ");
						  document.form1.table_name.focus();
						  return false;					
					}
				}			
					
				document.form1.submit();
			}
			//���ݲ�ѯ��ֵ�����������ѡ���aΪselect����bΪֵ
			function checkSelect(a,b){
				var lengths = a.options.length;//������ĳ��� 
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
					$("#tableName").attr("title","�ֱ������ʽΪ������$YYYYMM,����$YYYY,����$MM,����$XX,����$X");
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
					$("#tableName").attr("title","�ֱ������ʽΪ������$YYYYMM,����$YYYY,����$MM,����$XX,����$X </br> ������ʽ������");
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
					<td nowrap class="blue">���� </td>
					<td nowrap > 
						<input type="text" name="owner_name" id="owner_name" v_type="string" maxlength="30"/>
						<font class="orange">*</font>
					</td>
					<td nowrap class="blue">������ </td>
					<td nowrap id="tableName"> 
						<input type="text" name="table_name" id="table_name" v_type="string" maxlength="30"/>
						<font class="orange">*</font>
						<input type="button" class="b_text" value="��֤" onclick="checkValue();">
					</td>					
				</tr>
				<tr> 
					<td nowrap class="blue">����Ӧ��ϵͳ </td>
					<td nowrap> 
						<select name="app_belong">
		          			<option value="0" selected>Ӫҵ</option>
		          			<option value="1">�Ʒ�</option>
		          			<option value="2">����</option>
		          			<option value="3">����</option>
		          			<option value="4">BOMC</option>	          			
		          		</select>
		          		<font class="orange">*</font>
					</td>
					<td nowrap class="blue">������Ա </td>
					<td nowrap > 
						<input type="text" name="create_login" id="create_login" v_type="string" v_must="1" maxlength="100"/>
						<font class="orange">��������|�ָ�</font>
						<font class="orange">*</font>
					</td>															
				</tr>		
				<tr> 
					<td nowrap class="blue">������ </td>
					<td nowrap> 
						<select name="table_type">
		          			<option value="0" selected>��ˮ��</option>
		          			<option value="1">���ϱ�</option>
		          			<option value="2">���ñ�</option>
		          			<option value="3">��ʱ��</option>
		          		</select>
		          		<font class="orange">*</font>
					</td>
					<td nowrap class="blue">��ռ� </td>
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
					<td nowrap class="blue">ҵ����Ա </td>
					<td nowrap > 
						<input type="text" name="busi_login" id="busi_login" v_type="string" maxlength="100"/>
					</td>
					<td nowrap class="blue">��Ӧҵ������ </td>
					<td nowrap > 
						<input type="text" name="busi_desc" id="busi_desc" v_type="string" maxlength="200"/>
					</td>					
				</tr>	
				<tr> 
					<td nowrap class="blue">�ؼ���Ϣ��� </td>
					<td nowrap> 
						<select name="key_info">
		          			<option value="0" selected>����ṹ��</option>
		          			<option value="1">���ӹ��ܱ�</option>
		          			<option value="2">��ϵͳ����ṹ��</option>
		          		</select>
		          		<font class="orange">*</font>
					</td>
					<td nowrap class="blue">�ṹ�������� </td>
					<td nowrap > 
						<select name="struc_main_type" onchange="chg()">
		          			<option value="0" selected>������</option>
		          			<option value="1">�ֱ�</option>
		          			<option value="2">��һ��</option>
		          		</select>
						<font class="orange">*</font>
					</td>											
				</tr>			
				<tr> 
					<td nowrap class="blue">ҵ������ʱ�� </td>
					<td nowrap > 
						<input type="text" name="busi_crtime" id="busi_crtime" v_type="date" v_must="1"/>
						<!--input type="button" class="b_text" value="ʱ��" onclick="fPopCalendar(busi_crtime,busi_crtime);return false"/-->
						<font class="orange">*</font>
					</td>
					<td nowrap class="blue">�洢�ռ䣨��λM�� </td>
					<td nowrap > 
						<input type="text" name="space_msize" id="space_msize" v_type="cfloat" v_must="1"/>
						<font class="orange">*</font>
					</td>					
				</tr>	
				<tr> 
					<td nowrap class="blue">ʹ������ </td>
					<td nowrap> 
						<select name="use_type">
		          			<option value="0" selected>����ѯ</option>
		          			<option value="1">ҵ�����</option>
		          		</select>
					</td>
					<td nowrap class="blue">������ʹ�ñ�ʶ </td>
					<td nowrap > 
						<select name="offline_use_flag">
		          			<option value="0" selected>��</option>
		          			<option value="1">��</option>
		          		</select>
					</td>											
				</tr>		
				<tr> 
					<td nowrap class="blue">���ݱ���ҵ�����ޣ���λ�£� </td>
					<td nowrap > 
						<input type="text" name="data_bus_time" id="data_bus_time" v_type="cfloat" v_must="1"/>
						<font class="orange">*</font>
					</td>
					<td nowrap class="blue">�������ʶ </td>
					<td nowrap > 
						<select name="need_clean">
		          			<option value="0" selected>��</option>
		          			<option value="1">��</option>
		          		</select>
						<font class="orange">*</font>
					</td>					
				</tr>	
				<tr> 
					<td nowrap class="blue">��������ʹ��Ŀ�� </td>
					<td nowrap> 
						<select name="back_use_target">
		          			<option value="0" selected>�û���ѯ��Ҫ</option>
		          			<option value="1">�ϰ���ѯ</option>
		          			<option value="2">ͳ�Ʒ���</option>
		          		</select>
					</td>
					<td nowrap class="blue">��������ʹ��Ҫ�� </td>
					<td nowrap > 
						<select name="back_use_demand">
		          			<option value="0" selected>���������ѯ</option>
		          			<option value="1">��ʷ�����ѯ</option>
		          			<option value="2">�ļ���ѯ</option>
		          			<option value="3">���ݿ��ѯ</option>
		          		</select>
					</td>											
				</tr>		
				<tr> 
					<td nowrap class="blue">��������ʹ��֧�� </td>
					<td nowrap > 
						<select name="back_use_support">
		          			<option value="0" selected>�����������ѯ</option>
		          			<option value="1">�ɽ����ѯ</option>
		          			<option value="2">���ļ���ѯ</option>
		          			<option value="3">�����ݿ��ѯ</option>
		          		</select>
					</td>
					<td nowrap class="blue">��������ʹ�÷��� </td>
					<td nowrap > 
						<input type="text" name="back_use_mathod" id="back_use_mathod" v_type="string" maxlength="50"/>
					</td>					
				</tr>																									
				<tr> 
					<td colspan="4" id="footer"> 
						<input class="b_foot" type="button" name="confirm" value="ȷ��" onClick="doCfm()" disabled/>  
						<input class="b_foot" type="button" name="back" value="���" onClick="document.form1.reset()">  
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
