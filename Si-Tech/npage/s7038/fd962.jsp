<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ��Ӫҵ������ͳ�Ʊ���2147
   * �汾: 1.0
   * ����: 200/01/04
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%	request.setCharacterEncoding("GBK");%>
<%
	String opCode="d962";
	String opName="���ӻ������޸�";
	String work_no = (String)session.getAttribute("workNo");
	String org_code = (String)session.getAttribute("orgCode");
	String town="";
    String sqlStr="";
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());

%>

<script language="JavaScript">
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>���ӻ������޸�</TITLE>
</HEAD>
<body>

<!-------------------------------------------------------------------------------->

	
<!-------------------------------------------------------------------------------->
<script language=JavaScript>
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
	form1.action="fd962_2.jsp";
	document.form1.submit();
}

</SCRIPT>

<FORM method=post name="form1">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
    <div id="title_zi">���ӻ�������ѯ</div>
	</div>
<table cellSpacing="0">
	<tr>
		<td class="blue">��֯�ڵ�</td>
		<td colspan="3">
			<input type="hidden" name="groupId">
			<input type="text" name="groupName" v_must="1" v_type="string" maxlength="60" class="button" readonly>&nbsp;<font color="orange">*</font>
			<input name="addButton" class="b_text" type="button" value="ѡ��" onClick="select_groupId()" >	
		</td>
	</tr>
                
	<tr>
		<td class="blue">��ʼ����</td>
		<td>
			<input type="text" name="begin_login" class="button" maxlength="6" size="8" onChange="changeBeginLogin()">
			<input type="text" name="begin_name" class="button" disabled>&nbsp;<font color="orange">*</font>
			<input name="loginNoQuery" class="b_text" type="button" onClick="getBeginLogin()" value="��ѯ">
		</td>
		<td class="blue">��������</td>
		<td>
			<input type="text" name="end_login" class="button" maxlength="6" size="8" onChange="changeEndLogin()">
			<input type="text" name="end_name" class="button" disabled>&nbsp;<font color="orange">*</font>
			<input name="loginNoQuery" class="b_text" type="button" onClick="getEndLogin()" value="��ѯ">
		</td>
    </tr>
	<tr>
		<td class="blue">��ʼʱ��</td>
		<td>
			<input type="text"   name="begin_time" value=<%=dateStr%> size="17" maxlength="17">
		</td>
		<td class="blue">����ʱ��</td>
		<td>
			<input type="text"   name="end_time" value=<%=dateStr%> size="17" maxlength="17">
		</td>
	</tr>
	
	<tr> 
		<td align="center" id="footer" colspan="4">
			&nbsp; <input id=submits class="b_foot" name=submits onclick="doSubmit()" type=button value="��ѯ">
			&nbsp; <input class="b_foot" name=reee  type=button onClick="form1.reset()" value="���">
			&nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value="�ر�">
		</td>
	</tr>
</table>
	
	<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>

<script language="javascript">
/*----------------------------����RPC������������------------------------------------------*/

 onload=function(){
	form1.reset();
	}
var change_flag = "";//����RPC����ȫ�ֱ��� ��ѯ����:flag_dis  ��ѯӪҵ��:flag_town Ĭ��:""
function tochange(par)
{       if(par == "change_dis")//��ѯ����
			{   
				change_flag = "flag_dis";
				var region_code = document.all.region_code[document.all.region_code.selectedIndex].value.substring(0,2);
				var myPacket = new AJAXPacket("select_rpc.jsp","���ڻ��������Ϣ�����Ժ�......");
				//var sqlStr = "select region_code||district_code,district_code||'-- >'||district_name from sDisCode where region_code = '"+region_code+"' Order By district_code";
				
				var sqlStr ="90000094";
				var params = region_code+"|";
				var outNum = "2";
				
			}
		
		if(par == "change_town")//��ѯӪҵ��
			{
				change_flag = "flag_town";
				var region_code = document.all.region_code[document.all.region_code.selectedIndex].value.substring(0,2);
				var district_code = document.all.district_code[document.all.district_code.selectedIndex].value.substring(2,4);
				var myPacket = new AJAXPacket("select_rpc.jsp","���ڻ��Ӫҵ����Ϣ�����Ժ�......");
				//var sqlStr = "select region_code||district_code||town_code,town_code||'-- >'||TOWN_NAME from sTownCode where region_code = '"+region_code+"' and district_code = '"+district_code+"' Order By town_code";
				
				var sqlStr ="90000095";
				var params = region_code+"|"+district_code+"|";
				var outNum = "2";
			}
		if(par == "change_workno")//��ѯӪԱ
			{
				change_flag = "flag_workno";
				var town_code = document.all.town_code[document.all.town_code.selectedIndex].value.substring(0,7);
				var myPacket = new AJAXPacket("select_rpc.jsp","���ڻ�ù�����Ϣ�����Ժ�......");
				//var sqlStr = "select login_no,login_no||'-- >'||nvl(login_name,login_no) from dLoginMsg where org_code like '"+town_code+"%' Order By login_no";
				
				var sqlStr ="90000096";
				var params = town_code+"|";
				var outNum = "2";				
			}
			//alert(change_flag);
		myPacket.data.add("sqlStr",sqlStr);
		core.ajax.sendPacket(myPacket);
		delete(myPacket);
}

/*-----------------------------RPC������------------------------------------------------*/
  function doProcess(packet)
  {
	  var rpc_page=packet.data.findValueByName("rpc_page");
 
	 
	    var triListdata = packet.data.findValueByName("tri_list"); 
    
  	    var triList=new Array(triListdata.length);
	if(change_flag == "flag_dis")
		{
			  triList[0]="district_code";
			  document.all("district_code").length=0;
			  document.all("district_code").options.length=triListdata.length;//triListdata[i].length;
			  for(j=0;j<triListdata.length;j++)
			  {
				document.all("district_code").options[j].text=triListdata[j][1];
				document.all("district_code").options[j].value=triListdata[j][0];
			  }//���ؽ����
			  document.all("district_code").options[0].selected=true;
			  tochange("change_town");
		}
	else if(change_flag == "flag_town")
		{
			  triList[0]="town_code";
			  document.all("town_code").length=0;
			  document.all("town_code").options.length=triListdata.length;//triListdata[i].length;
			  for(j=0;j<triListdata.length;j++)
			  {
				document.all("town_code").options[j].text=triListdata[j][1];
				document.all("town_code").options[j].value=triListdata[j][0];
			  }//Ӫҵ�������
			  document.all("town_code").options[0].selected=true;
			  tochange("change_workno");
		}
	else if(change_flag == "flag_workno")
		{
			  triList[0]="begin_login";
			  document.all("begin_login").length=0;
			  document.all("begin_login").options.length=triListdata.length+1;//triListdata[i].length;
				document.all("begin_login").options[0].text='δѡ��';
				document.all("begin_login").options[0].value=document.all.town_code[document.all.town_code.selectedIndex].value.substring(0,7);
			  for(j=0;j<triListdata.length;j++)
			  {
				document.all("begin_login").options[j+1].text=triListdata[j][1];
				document.all("begin_login").options[j+1].value=triListdata[j][0];
			  }//��ʼ���Ž����

			  document.all("end_login").length=0;
			  document.all("end_login").options.length=triListdata.length+1;//triListdata[i].length;
				document.all("end_login").options[0].text='δѡ��';
				document.all("end_login").options[0].value=document.all.town_code[document.all.town_code.selectedIndex].value.substring(0,7);
			  for(j=triListdata.length-1;j>=0;j--)
			  {
			  	k=triListdata.length-1-j
				document.all("end_login").options[k+1].text=triListdata[j][1];
				document.all("end_login").options[k+1].value=triListdata[j][0];
			  }//�������Ž����
			  
		}
//////////////////////////////////////////////////////////////////////////////////////////
		
	  
   }
function getBeginLogin(){
    if(document.all.groupName.value==''){
	    rdShowMessageDialog("���Ȳ�ѯ��֯�ڵ�!");
		form1.town_code.focus();
	    return;
	}
    var pageTitle = "ӪҵԱ��ѯ";
    var fieldName = "ӪҵԱ����|ӪҵԱ����|";
	/****************************************************
	var sqlStr=" select rtrim(login_no),rtrim(login_name)   from dloginmsg" +
				         " where org_code like '" +document.all.district_code.value+document.all.town_code.value+
				         "%' ";
    *****************************************************/
    //var sqlStr=" select rtrim(login_no),rtrim(login_name)   from dloginmsg" +
		//		         " where group_id= '"+document.all.groupId.value+"'";
    
    var sqlStr = "90000090"
    var params = document.all.groupId.value+"|";
		var outNum = "2";
		
    if(document.form1.begin_login.value != "")
    {
        //sqlStr = sqlStr + " and login_no like '" + document.form1.begin_login.value + "%'";
            var sqlStr = "90000091"
				    var params = document.all.groupId.value+"|"+document.form1.begin_login.value+"|";
						var outNum = "2";
        
    }
    //sqlStr = sqlStr + " order by login_no" ;
    
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1";
    var retToField = "begin_login|begin_name|";
    //PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
			path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
			path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
			path = path + "&selType=" + selType+ "&params=" + params;
			var retInfo = window.showModalDialog(path,"","dialogWidth:70;dialogHeight:35;");
			if(typeof(retInfo)!="undefined"){
				var tempArr = retInfo.split("|");
				document.form1.begin_login.value = tempArr[0];
				document.form1.begin_name.value = tempArr[1];
			}
}
function changeBeginLogin(){
   document.all.begin_name.value="";
}
function getEndLogin(){
    if(document.all.groupName.value==''){
	    rdShowMessageDialog("���Ȳ�ѯ��֯�ڵ�!");
		form1.town_code.focus();
	    return;
	}
    var pageTitle = "ӪҵԱ��ѯ";
    var fieldName = "ӪҵԱ����|ӪҵԱ����|";
	/****************************************************
	var sqlStr=" select rtrim(login_no),rtrim(login_name)   from dloginmsg" +
				         " where org_code like '" +document.all.district_code.value+document.all.town_code.value+
				         "%' ";
    *****************************************************/
    //var sqlStr=" select rtrim(login_no),rtrim(login_name)   from dloginmsg" +
		//		         " where group_id= '"+document.all.groupId.value+"'";
		
    var sqlStr = "90000092"
    var params = document.all.groupId.value+"|";
		var outNum = "2";    
		
    if(document.form1.end_login.value != "")
    {
        //sqlStr = sqlStr + " and login_no like '" + document.form1.end_login.value + "%'";
            var sqlStr = "90000093"
				    var params = document.all.groupId.value+"|"+document.form1.end_login.value+"|";
						var outNum = "2";        
    }
    //sqlStr = sqlStr + " order by login_no desc" ;
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1";
    var retToField = "end_login|end_name|";
    //PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
        var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
			path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
			path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
			path = path + "&selType=" + selType+ "&params=" + params;
			var retInfo = window.showModalDialog(path,"","dialogWidth:70;dialogHeight:35;");
			if(typeof(retInfo)!="undefined"){
				var tempArr = retInfo.split("|");
				document.form1.end_login.value = tempArr[0];
				document.form1.end_name.value = tempArr[1];
			}
}
function changeEndLogin(){
   document.all.end_name.value="";
}
var queryField ;
var result_table_body = document.getElementById("result_table_body");
var tableDiv = document.getElementById("table_div");

function searchrpt(serchId,serchType){	
        var array1 = document.getElementById(serchType).value.split(' ');
	    queryField = document.getElementById(serchType);
		result_table_body = document.getElementById("result_table_body");
		tableDiv = document.getElementById("table_div");
		clearResults();
		setOffsets();
		var row, cell, txtNode;
		$("select[name="+serchId+"] option:contains('"+array1+"')").each(function(i,n){	
			var nextNode =$(n).text();
			row = document.createElement("tr");
            cell = document.createElement("td");            
            cell.onmouseout = function() {this.className='mouseOver';};
            cell.onmouseover = function() {this.className='mouseOut';};
            cell.setAttribute("bgcolor", "#FFFAFA");
            cell.setAttribute("border", "0");
		    cell.setAttribute("align", "left");
            cell.onclick = function() { populateResult(this);searchrpt(serchId,serchType); clearResults();} ;                             
            txtNode = document.createTextNode(nextNode);
            cell.appendChild(txtNode);
            row.appendChild(cell);
            result_table_body.appendChild(row);
		});
}


function setOffsets() {
     var end = queryField.offsetWidth;
     var left  = calculateOffsetLeft(queryField);
     var top  = calculateOffsetTop(queryField) + queryField.offsetHeight;

     tableDiv.style.border = "red 1px solid";
     tableDiv.style.left = left + "px";
     tableDiv.style.top = top + "px";
     result_table.style.width = end + "px";
  }
  
function populateResult(cell){
	  queryField.value = cell.firstChild.nodeValue;
	  document.all.rpt_type.value=cell.firstChild.nodeValue.split("->")[0];
	  changerpt();
      clearResults();
}

function clearResults(){
    /*
	for(var i=0;i<result_table_body.childNodes.length;i++){
	   result_table_body.removeChild(result_table_body.childNodes[i]);
	}
	*/
	$("#result_table_body").html("");
	tableDiv.style.border = "none";
}

function calculateOffsetLeft(field){
      return calculateOffset(field, "offsetLeft");
    }

function calculateOffsetTop(field) {
      return calculateOffset(field, "offsetTop");
    }

function calculateOffset(field, attr) {
      var offset = 0;
      while(field) {
        offset += field[attr]; 
        field = field.offsetParent;
      }
      return offset;
}
</script>

