<%
/********************
 
 -->>���������ˡ�ʱ�䡢ģ��Ĺ���
 -------------------------����-----------�ξ�ΰ2015-7-27 16:56:29------------------
ʮһ����Ӫҵǰ̨�����н���ѯ���ܣ���ѯ����ΪԤԼ���£�չʾ���Ϊ�ֻ����룬������֤�����룬��ϵ�ˣ���ϵ�˵绰
 -------------------------��̨��Ա��dujl--------------------------------------------
 
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
  //j_calendar.add(java.util.Calendar.MONTH, -1);// �·ݼ�1  
	String p_month_date = new java.text.SimpleDateFormat("yyyyMM").format(j_calendar.getTime());
	
	
%> 
<%@ page contentType="text/html;charset=GBK"%>
<HTML><HEAD><TITLE><%=opName%></TITLE>
<script type="text/javascript" src="/njs/extend/My97DatePicker/WdatePicker.js"></script>
<SCRIPT language=JavaScript>
var regioncount=0;

//����ˢ��ҳ��
function reSetThis(){
	  location = location;	
}



//��ѯ��̬չʾIMEI�����б�
function go_sM289Cfm(){
	if($("#region_code").val()==""&&$("#region_code").find("option:selected").text().trim()!="ȫʡ"){
		rdShowMessageDialog("��ѡ�����");
		return;
	}
	if(rdShowConfirmDialog('�Ƿ�ȷ���齱��')!=1) return;
	var packet = new AJAXPacket("fm289_2.jsp","����ִ��,���Ժ�...");
			packet.data.add("opCode","<%=opCode%>");//opcode
			packet.data.add("y_year_month",$("#y_year_month").val().trim());//
			packet.data.add("region_code",$("#region_code").val().trim());//
			core.ajax.sendPacket(packet,do_sM290Qry);
			packet = null; 
}
//��ѯ��̬չʾIMEI�����б��ص�
function do_sM290Qry(packet){
	var code = packet.data.findValueByName("code"); //���ش���
	var msg = packet.data.findValueByName("msg"); //������Ϣ
	if(code=="000000"){//��ѯ�ɹ���̬չʾ�б�
			var retArray = packet.data.findValueByName("retArray");
			//��ȡ����ɹ�����̬ƴ���б�
			var trObjdStr = "";
			//�ڶ����Ժ��ѯ���ж��������ݣ�����ɾ������title�����е�����
			$("#upgMainTab tr:gt(0)").remove();
			
			for(var i=0;i<retArray.length;i++){
				  //�����һ���ռ�¼��չʾ�����񷵻�����Ϊ���ַ���������Ľ�����߼���ɾ��
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
			//��ƴ�ӵ��ж�̬��ӵ�table��
			$("#upgMainTab tr:eq(0)").after(trObjdStr);
	}else{
		  rdShowMessageDialog("��ѯʧ�ܣ�"+code+"��"+msg,0);
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
      //����excel�ɼ�����
      oXL.Visible = true;
  }catch(e){
        if((!+'\v1')){ //ie�����  
           alert("�޷�����Excel����ȷ���������Ѿ���װ��Excel!\n\n����Ѿ���װ��Excel��" + 
               "�����IE�İ�ȫ����\n\n���������\n\n"+"���� �� Internetѡ�� �� ��ȫ �� �Զ��弶�� �� ActiveX �ؼ��Ͳ�� �� ��δ���Ϊ�ɰ�ȫִ�нű���ActiveX �ؼ���ʼ����ִ�нű� �� ���� �� ȷ��"); 
        }else{ 
            alert("��ʹ��IE��������С����뵽EXCEL��������");  //�������ð�ȫ�ȼ�������Ϊie�����  
        } 
    }
}

  function ExportToExcel(targetTable, flag) { 
      //ȡ�ñ������
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
              oSheet.Cells(rowIndex + 1, j + 1).NumberFormatLocal="@" ;//���õ�Ԫ��Ϊ�ı�
              oSheet.Cells(rowIndex + 1, j + 1).value = value;
          });
          
          rowIndex++;
      });
  }
  function judgeCount(){
  		if($("#region_code").find(":selected").text()=="ȫʡ"){
  			var packet = new AJAXPacket("fm289_ajax_qrycount.jsp","����ִ��,���Ժ�...");
				packet.data.add("y_year_month",$("#y_year_month").val().trim());
				core.ajax.sendPacket(packet,do_judgeCount);
				packet = null; 
  		}
  }
  function do_judgeCount(packet){
  		regioncount=packet.data.findValueByName("results");
  		if((regioncount/1)>10000){
  			rdShowMessageDialog("��ЧԤԼ�����ѳ����޶�ֵ����ֵ��г�ѡ��",0);
  			$("#region_code").select(0);
  			$("#region_code").find("[text='--��ѡ��--']").attr("selected",true);
  		}
  }

</SCRIPT>
</HEAD>	
<BODY>
<FORM name="msgFORM" action="" method="post"> 
	<input type="hidden" name="opCode" value="<%=opCode%>">
	<%@ include file="/npage/include/header.jsp" %>	
<div class="title"><div id="title_zi">��ѯ����</div></div>
<table cellSpacing="0">
	<tr>
	    <td class="blue" width="15%">ԤԼ���£�</td>
		  <td width="35%">
			    <input type="text"  name="y_year_month" id="y_year_month" readOnly="readOnly" value="<%=p_month_date%>"  onclick="WdatePicker({dateFmt:'yyyyMM',autoPickDate:true,onpicked:function(){}})" />  
		  </td>
		  <td class="blue" width="15%">ѡ����У�</td>
		  <td width="35%">
		  	<select name="region_code" id="region_code" onchange="judgeCount()">
					  <option value="" >--��ѡ��--</option>
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
						<option value="" >ȫʡ</option>
				</select>
		  </td>
	</tr>
	<tr>
		<td colspan="4" align="center" id="footer">
			<input type="button" class="b_text" value="�齱" onclick="go_sM289Cfm()">
		</td>
	</tr>
	
</table>

<div class="title"><div id="title_zi">����б�</div></div>
<TABLE cellSpacing="0" id="upgMainTab">
    <tr>
        <th width="15%">ԤԼ����</th>
        <th width="15%">����</th>
        <th width="20%">֤������</th>
        <th width="15%">��ϵ�˵绰</th>	
        <th width="10%">����</th>
        <th width="10%">����</th>
        <th width="15%">����Ӫҵ��</th>
    </tr>
     
</table>
<table cellSpacing="0">
	 <tr>
	 	<td id="footer">
	 		<input type="button" class="b_foot" value="����" onclick="to_excel_file()"           />
	 		<input type="button" class="b_foot" value="����" onclick="reSetThis()"         /> 
			<input type="button" class="b_foot" value="�ر�" onclick="removeCurrentTab()"  /> 
	 	</td>
	</tr>
</table>

<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
