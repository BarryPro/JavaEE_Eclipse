<%
  /*
   * ����: m197���ͼ�ͥ--�����ײ�ҵ������ѯ 
   * �汾: 1.0
   * ����: 2014/11/26 
   * ����: diling
   * ��Ȩ: si-tech
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
<HEAD><TITLE>��ӪҵԱ����ͳ�Ʊ�</TITLE>

</HEAD>
<body>
<!--wanghfa 20100602 �����޸� start-->
<script src="f1615_crm.js" type="text/javascript"></script>	
<script src="f1615_crm_report.js" type="text/javascript"></script>	
<script src="f1615_boss.js" type="text/javascript"></script>	
<!--wanghfa 20100602 �����޸� end-->
<script language="JavaScript">
//----����һ����ҳ��ѡ����֯�ڵ�--- ����
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
	var slecOperType =$("input[@name=opType][@checked]").val();  //��������
	var groupId = "";
	var login_no = $("#login_no").val();
	var operChannel = $("#operChannel").val();//��������
	if(slecOperType == "0"){ //��֯�ṹ
		groupId = $("input[name='groupId']").val();	
		if(groupId == ""){
			rdShowMessageDialog("��ѡ����֯�ṹ�����в�ѯ��");
    	return false;
		}
	}else{
		if(login_no == ""){
			rdShowMessageDialog("������ӪҵԱ���ţ�");
    	return false;
		}
	}
  var begin_time=document.form1.begin_time.value;
  var end_time=document.form1.end_time.value;
  if(begin_time>end_time)
  {
    rdShowMessageDialog("��ʼʱ��Ƚ���ʱ���!");
    return false;
  }
  
  if(end_time > "<%=currentTime%>"){
  	rdShowMessageDialog("����ʱ�䲻�ܴ��ڵ�ǰʱ�䣡");
    return false;
  }
  
  var sdate = begin_time.substring(0,4) + "-" + begin_time.substring(4,6) + "-" + begin_time.substring(6,8);
  var edate = end_time.substring(0,4) + "-" + end_time.substring(4,6) + "-" + end_time.substring(6,8);
  if(DateDiff(sdate,edate) > 30){
  	rdShowMessageDialog("Ϊ�����ѯʱ���ȹ����뽫��ѯʱ�䷶Χ������һ����Ȼ�����ڣ�");
    return false;
  }
  
  if(begin_time.substring(4,6) != end_time.substring(4,6)){
  	rdShowMessageDialog("�뽫��ѯʱ�䷶Χ������һ����Ȼ�����ڣ�");
    return false;
  }

	var packet = new AJAXPacket("fm197_ajax_query.jsp","���ڻ�����ݣ����Ժ�......");
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
	//�ҵ���ӱ���div
	var markDiv=$("#intablediv"); 
	markDiv.empty();
	markDiv.append(data);
  var retCode = $("#retCode").val();
  var retMsg = $("#retMsg").val();
  if(retCode!="000000"){
     rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
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
    var workB = excelObj.Workbooks.Add(); ////����µĹ�����   
   var sheet = workB.ActiveSheet;   

  sheet.Columns("E").ColumnWidth =16;//�����п�
  sheet.Columns("E").numberformat="@";  
  sheet.Columns("F").ColumnWidth =16;//�����п�
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
					alert('����excelʧ��!');
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
   var workB = excelObj.Workbooks.Add(); ////����µĹ�����   
   var sheet = workB.ActiveSheet;   

  sheet.Columns("E").ColumnWidth =16;//�����п�
  sheet.Columns("E").numberformat="@"; 
  sheet.Columns("F").ColumnWidth =16;//�����п�
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
				alert('����excelʧ��!');
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

function  DateDiff(sDate1,  sDate2){    //sDate1��sDate2��2002-12-18��ʽ  
   var  aDate,  oDate1,  oDate2,  iDays;  
   aDate  =  sDate1.split("-");  
   oDate1  =  new  Date(aDate[1]  +  '-'  +  aDate[2]  +  '-'  +  aDate[0]) ;   //ת��Ϊ12-18-2002��ʽ  
   aDate  =  sDate2.split("-");  
   oDate2  =  new  Date(aDate[1]  +  '-'  +  aDate[2]  +  '-'  +  aDate[0]);  
   iDays  =  parseInt(Math.abs(oDate1  -  oDate2)  /  1000  /  60  /  60  /24);    //�����ĺ�����ת��Ϊ����  
   return  iDays;  
}

function selOpType(obj){
	if(obj.value == "0"){ //��֯�ṹ
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
		<div id="title_zi">��ѯ����</div>
	</div>
<table cellSpacing="0">
	<tr>
		<td class="blue">��������</td>
		<td colspan="3">
			&nbsp;
			<input type="radio" id="opType1" name="opType" value="0" checked onclick="selOpType(this)" />��֯�ṹ
			&nbsp;&nbsp;&nbsp;
			<input type="radio" id="opType2" name="opType" value="1" onclick="selOpType(this)" />ӪҵԱ
		</td>
	</tr>
	<tr id="groupTr">
		<td class="blue">��֯�ڵ�</td>
		<td colspan="3">
			<input type="hidden" name="groupId">
			<input type="text" name="groupName" v_must="1" v_type="string" maxlength="60" class="InputGrey" readonly>&nbsp;
			<input name="addButton" class="b_text"  type="button" value="ѡ��" onClick="select_groupId()" >	
		</td>
	</tr>
	<tr id="loginNoTr" style="display:none">
		<td class="blue">ӪҵԱ����</td>
		<td colspan="3">
			<input type="text" id="login_no" name="login_no" value="<%=work_no%>" class="InputGrey" readonly  />
		</td>
	</tr>
	<tr>
		<TD class="blue">��������</td>
		<td colspan="3">
			<select id="operChannel" name="operChannel">
				<option value="0">ʡ���</option>
				<option value="1">�ƶ�</option>
				<option value="2">ȫ��</option>
			</select>
		</td>
	</tr>
	<tr id=a_time style="display=''">
		<td class="blue">��ʼʱ��</td>
		<td>
			<input type="text" id="begin_time"   name="begin_time" value="<%=currFirstDay%>"  maxlength="8" v_must="1" v_type="date" />
			&nbsp;<font color="orange">*</font>
		</td>
		<td class="blue">����ʱ��</td>
		<td>
			<input type="text" id="end_time"   name="end_time" value="<%=currentTime%>"  maxlength="8" v_must="1" v_type="date"  />
			&nbsp;<font color="orange">*</font>
		</td>
	</tr>
	<tr> 
		<td align="center" id="footer" colspan="4">
			&nbsp; <input id=submits class="b_foot" name=submits onclick="doSubmit()" type=button value="��ѯ" />
			&nbsp; <input class="b_foot" name=retBtn  type=button onClick="form1.reset()" value="����" />
			&nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر� />
		</td>
	</tr>
</table>
  <div id="intablediv"></div>
	<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>

