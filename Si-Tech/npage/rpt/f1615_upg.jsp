<!DOCTYPE html PUBLIC "-//W3C//DTD Xhtml 1.0 Transitional//EN" "http://www.w3.org/tr/xhtml1/DTD/xhtml1-transitional.dtd">
<%
  /*
   * ����: ��ӪҵԱ����ͳ�Ʊ���2146
   * �汾: 1.0
   * ����: 2008/01/04
   * ����: leimd
   * ��Ȩ: si-tech
   * update:
  */
%>
<%@	page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%  request.setCharacterEncoding("GBK");%>
<%@ page import="org.apache.log4j.Logger"%>
<%
	String opCode="2146";
	String opName="��ӪҵԱ����ͳ�Ʊ���";
	Logger logger = Logger.getLogger("f1615_upg.jsp");
	String work_no = (String)session.getAttribute("workNo");
	String rpt_right = (String)session.getAttribute("rptRight");
	String org_code = (String)session.getAttribute("orgCode");

    String sqlStr="";
	String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());

	String workName   = (String)session.getAttribute("workName");
	String groupId    = (String)session.getAttribute("groupId");
	String orgName    = (String)session.getAttribute("orgName");
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

function changerpt()
{
  if(document.form1.rpt_type.value==1)
  {
    document.all("rpt_format").options.length=6;
    document.all("rpt_format").options[0].text='��ϸ';
    document.all("rpt_format").options[0].value='10000';
    document.all("rpt_format").options[1].text='ҵ��С��';
    document.all("rpt_format").options[1].value='01000';
    document.all("rpt_format").options[2].text='����С��';
    document.all("rpt_format").options[2].value='00100';
    document.all("rpt_format").options[3].text='��ϸ+ҵ��С��';
    document.all("rpt_format").options[3].value='11000';
    document.all("rpt_format").options[4].text='��ϸ+����С��';
    document.all("rpt_format").options[4].value='10100';
    document.all("rpt_format").options[5].text='��ϸ+ҵ��С��+����С��';
    document.all("rpt_format").options[5].value='11100';
  }
  else if(document.form1.rpt_type.value==2)
  {
    document.all("rpt_format").options.length=6;
    document.all("rpt_format").options[0].text='��ϸ';
    document.all("rpt_format").options[0].value='10000';
    document.all("rpt_format").options[1].text='���ѷ�ʽС��';
    document.all("rpt_format").options[1].value='01000';
    document.all("rpt_format").options[2].text='����';
    document.all("rpt_format").options[2].value='00100';
    document.all("rpt_format").options[3].text='��ϸ+���ѷ�ʽС��';
    document.all("rpt_format").options[3].value='11000';
    document.all("rpt_format").options[4].text='��ϸ+����';
    document.all("rpt_format").options[4].value='10100';
    document.all("rpt_format").options[5].text='��ϸ+���ѷ�ʽС��+����';
    document.all("rpt_format").options[5].value='11100';
  }
  else if(document.form1.rpt_type.value==3)
  {
    document.all("rpt_format").options.length=1;
    document.all("rpt_format").options[0].text='��ϸ';
    document.all("rpt_format").options[0].value='10000';
  }
  else if(document.form1.rpt_type.value==4)
  {
    document.all("rpt_format").options.length=6;
    document.all("rpt_format").options[0].text='��ϸ';
    document.all("rpt_format").options[0].value='10000';
    document.all("rpt_format").options[1].text='����С��';
    document.all("rpt_format").options[1].value='01000';
    document.all("rpt_format").options[2].text='����С��';
    document.all("rpt_format").options[2].value='00100';
    document.all("rpt_format").options[3].text='��ϸ+����С��';
    document.all("rpt_format").options[3].value='11000';
    document.all("rpt_format").options[4].text='��ϸ+����С��';
    document.all("rpt_format").options[4].value='10100';
    document.all("rpt_format").options[5].text='��ϸ+����С��+����С��';
    document.all("rpt_format").options[5].value='11100';
  }
  else if(document.form1.rpt_type.value==5)
  {
    document.all("rpt_format").options.length=6;
    document.all("rpt_format").options[0].text='��ϸ';
    document.all("rpt_format").options[0].value='10000';
    document.all("rpt_format").options[1].text='����С��';
    document.all("rpt_format").options[1].value='01000';
    document.all("rpt_format").options[2].text='�ط�С��';
    document.all("rpt_format").options[2].value='00100';
    document.all("rpt_format").options[3].text='��ϸ+����С��';
    document.all("rpt_format").options[3].value='11000';
    document.all("rpt_format").options[4].text='��ϸ+�ط�С��';
    document.all("rpt_format").options[4].value='10100';
    document.all("rpt_format").options[5].text='��ϸ+����С��+�ط�С��';
    document.all("rpt_format").options[5].value='11100';
  }
  else if(document.form1.rpt_type.value==7)
  {
    document.all("rpt_format").options.length=6;
    document.all("rpt_format").options[0].text='��ϸ';
    document.all("rpt_format").options[0].value='10000';
    document.all("rpt_format").options[1].text='����С��';
    document.all("rpt_format").options[1].value='01000';
    document.all("rpt_format").options[2].text='�Ż�С��';
    document.all("rpt_format").options[2].value='00100';
    document.all("rpt_format").options[3].text='��ϸ+����С��';
    document.all("rpt_format").options[3].value='11000';
    document.all("rpt_format").options[4].text='��ϸ+�Ż�С��';
    document.all("rpt_format").options[4].value='10100';
    document.all("rpt_format").options[5].text='��ϸ+����С��+�Ż�С��';
    document.all("rpt_format").options[5].value='11100';
  }
  else if(document.form1.rpt_type.value==8)
  {
    document.all("rpt_format").options.length=6;
    document.all("rpt_format").options[0].text='��ϸ';
    document.all("rpt_format").options[0].value='10000';
    document.all("rpt_format").options[1].text='����С��';
    document.all("rpt_format").options[1].value='01000';
    document.all("rpt_format").options[2].text='�һ�����С��';
    document.all("rpt_format").options[2].value='00100';
    document.all("rpt_format").options[3].text='��ϸ+����С��';
    document.all("rpt_format").options[3].value='11000';
    document.all("rpt_format").options[4].text='��ϸ+�һ�����С��';
    document.all("rpt_format").options[4].value='10100';
    document.all("rpt_format").options[5].text='��ϸ+����С��+�һ�����С��';
    document.all("rpt_format").options[5].value='11100';
  }
  else if(document.form1.rpt_type.value==9)
  {
    document.all("rpt_format").options.length=6;
    document.all("rpt_format").options[0].text='��ϸ';
    document.all("rpt_format").options[0].value='10000';
    document.all("rpt_format").options[1].text='����С��';
    document.all("rpt_format").options[1].value='01000';
    document.all("rpt_format").options[2].text='Ӫ����С��';
    document.all("rpt_format").options[2].value='00100';
    document.all("rpt_format").options[3].text='��ϸ+����С��';
    document.all("rpt_format").options[3].value='11000';
    document.all("rpt_format").options[4].text='��ϸ+Ӫ����С��';
    document.all("rpt_format").options[4].value='10100';
    document.all("rpt_format").options[5].text='��ϸ+����С��+Ӫ����С��';
    document.all("rpt_format").options[5].value='11100';
  }
  else if(document.form1.rpt_type.value==10)
  {
    document.all("rpt_format").options.length=6;
    document.all("rpt_format").options[0].text='��ϸ';
    document.all("rpt_format").options[0].value='10000';
    document.all("rpt_format").options[1].text='����С��';
    document.all("rpt_format").options[1].value='01000';
    document.all("rpt_format").options[2].text='��������С��';
    document.all("rpt_format").options[2].value='00100';
    document.all("rpt_format").options[3].text='��ϸ+����С��';
    document.all("rpt_format").options[3].value='11000';
    document.all("rpt_format").options[4].text='��ϸ+��������С��';
    document.all("rpt_format").options[4].value='10100';
    document.all("rpt_format").options[5].text='��ϸ+����С��+��������С��';
    document.all("rpt_format").options[5].value='11100';
  }
  else if(document.form1.rpt_type.value==11)
  {
    document.all("rpt_format").options.length=6;
    document.all("rpt_format").options[0].text='��ϸ';
    document.all("rpt_format").options[0].value='10000';
    document.all("rpt_format").options[1].text='ҵ��С��';
    document.all("rpt_format").options[1].value='01000';
    document.all("rpt_format").options[2].text='����С��';
    document.all("rpt_format").options[2].value='00100';
    document.all("rpt_format").options[3].text='��ϸ+ҵ��С��';
    document.all("rpt_format").options[3].value='11000';
    document.all("rpt_format").options[4].text='��ϸ+����С��';
    document.all("rpt_format").options[4].value='10100';
    document.all("rpt_format").options[5].text='��ϸ+ҵ��С��+����С��';
    document.all("rpt_format").options[5].value='11100';
  }
  else
  {
    document.all("rpt_format").options.length=1;
    document.all("rpt_format").options[0].text='��ϸ';
    document.all("rpt_format").options[0].value='10000';
  }
}

function doSubmit()
{
	var sdate = document.form1.begin_time.value;
	var edate = document.form1.end_time.value;
  if(document.form1.all("begin_time").value.length == 8)
      document.form1.begin_time.value=document.form1.begin_time.value+" 00:00:00";
  if(document.form1.all("end_time").value.length == 8)
      document.form1.end_time.value=document.form1.end_time.value+" 23:59:59";

  if(!check(form1))
  {
    return false;
  }

  var begin_time=document.form1.begin_time.value;
  var end_time=document.form1.end_time.value;
  if(begin_time>end_time)
  {
    rdShowMessageDialog("��ʼʱ��Ƚ���ʱ���");
    return false;
  }
  
  sdate = sdate.substring(0,4) + "-" + sdate.substring(4,6) + "-" + sdate.substring(6,8);
  edate = edate.substring(0,4) + "-" + edate.substring(4,6) + "-" + edate.substring(6,8);
  if(DateDiff(sdate,edate) > 30){
  	rdShowMessageDialog("Ϊ�����ӡʱ���ȹ��������������޷�������ӡ�����뽫��ӡʱ�䷶Χ������һ�������ڣ�");
    return false;
  }

	//wanghfa 20100602 �����޸� start
	select_boss(document.forms[0]);
	select_crm(document.forms[0]);
	select_crm_bao(document.forms[0]);
	document.forms[0].submit();
	//wanghfa 20100602 �����޸� end
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


/***
	hejwa  2015-3-9 10:03:50
	������ǰӪҵ������ǰӪҵԱ����
***/
function getLoginGroupInfo(){
	$("input[name='groupId']").val("<%=groupId%>");
	$("input[name='groupName']").val("<%=orgName%>");
	
} 

function getLoginInfo(){
	if(document.all.groupName.value==''){
	    rdShowMessageDialog("���Ȳ�ѯ��֯�ڵ�!");
	    return;
	}
	
	$("input[name='login_no']").val("<%=work_no%>");
	$("input[name='login_name']").val("<%=workName%>");
	
}

</SCRIPT>

<FORM method=post name="form1" action="#">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi">��ѡ���������</div>
	</div>
<table cellSpacing="0">
				<!-- ningtn @ 2010-10-26 �Ż���Ŀ -->
   <tr>
		<td class="blue" >
			ģ������
		</td>
		<td colspan="3">
			<input type="text" id="searchTextrpt" name="searchTextrpt" 
			 value="�������ѯ����" 
			 size="40"
			 style="padding-top:3px;"
			 onFocus="form1.searchTextrpt.value='';clearResults();"  
			 onpropertychange="blurSearchFunc('rpt_type','searchTextrpt','->')" />
		</td>
	</tr>
	<tr>
		<td class="blue">��������</td>
		<td>
			<select name=rpt_type onChange="changerpt()" style='width:400px'>
				<!--wanghfa 20100602 �����޸� start-->
				<wtc:qoption name="sPubSelect" outnum="2">
					<wtc:sql>select select_value,select_name from sreportfunc where function_code = '<%=opCode%>' order by select_value asc</wtc:sql>
				</wtc:qoption>
				<!--wanghfa 20100602 �����޸� end-->
			</select>
		</td>
		<td class="blue">�����ʽ</td>
		<td>
			<select name=rpt_format>
				<option class='button' value=10000>��ϸ</option>
				<option class='button' value=01000>ҵ��С��</option>
				<option class='button' value=00100>����С��</option>
				<option class='button' value=11000>��ϸ+ҵ��С��</option>
				<option class='button' value=10100>��ϸ+����С��</option>
				<option class='button' value=11100>��ϸ+ҵ��С��+����С��</option>
			</select>
		</td>
	</tr>
                
	<tr>
		<td class="blue">��֯�ڵ�</td>
		<td>
			<input type="text" name="groupId">
			<input type="text" name="groupName" v_must="1" v_type="string" maxlength="60" class="InputGrey" readonly>&nbsp;<font color="orange">*</font>
			<input name="addButton" class="b_text"  type="button" value="ѡ��" onClick="select_groupId()" >	
			<input type="button" class="b_text" value="��ǰӪҵ��" onclick="getLoginGroupInfo()" />
		</td>
		<td class="blue">Ӫ ҵ Ա</td>
		<td>
			<input type="text" name="login_no" class="button" maxlength="6" size="8" onChange="changeLoginNo()">
			<input type="text" name="login_name" class="button" disabled>
			<input name="loginNoQuery" class="b_text" type="button" onClick="getLoginNo()" value="��ѯ">
			<input type="button" class="b_text" value="��ǰӪҵԱ" onclick="getLoginInfo()" />
		</td>
	</tr>
	
	<tr id=a_time style="display=''">
		<td class="blue">��ʼʱ��</td>
		<td>
			<input type="text"   name="begin_time" value=<%=dateStr%>  size="17" maxlength="17">
		</td>
		<td class="blue">����ʱ��</td>
		<td>
			<input type="text"   name="end_time" value=<%=dateStr%>  size="17" maxlength="17">
		</td>
	</tr>
	
	<tr> 
		<td align="center" id="footer" colspan="4">
			&nbsp; <input id=submits class="b_foot" name=submits onclick="return(doSubmit())" type=button value=ȷ��>
			&nbsp; <input class="b_foot" name=reee  type=button onClick="form1.reset()" value=���>
			&nbsp; <input class="b_foot" name=back onClick="history.go(-1)" type=button value=����>
			&nbsp; <input class="b_foot" name=back onClick="removeCurrentTab()" type=button value=�ر�>
		</td>
	</tr>
</table>
      <input type="hidden" name="workNo" value="<%=work_no%>">
      <input type="hidden" name="org_code" value="<%=org_code%>">
      <input type="hidden" name="rptRight" value="L">
      <input type="hidden" name="hDbLogin" value ="dbchange">
      <input type="hidden" name="hParams1" value="">
      <input type="hidden" name="hTableName" value="">
  <%@ include file="/npage/public/pubSearchText.jsp" %>
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
				var sqlStr = "select region_code||district_code,district_code||'-- >'||district_name from sDisCode where region_code = '"+region_code+"' Order By region_code";
			}
		
		else if(par == "change_town")//��ѯӪҵ��
			{
				change_flag = "flag_town";
				var region_code = document.all.region_code[document.all.region_code.selectedIndex].value.substring(0,2);
				var district_code = document.all.district_code[document.all.district_code.selectedIndex].value.substring(2,4);
				var myPacket = new AJAXPacket("select_rpc.jsp","���ڻ��Ӫҵ����Ϣ�����Ժ�......");
				var sqlStr = "select region_code||district_code||town_code,town_code||'-- >'||TOWN_NAME from sTownCode where region_code = '"+region_code+"' and district_code = '"+district_code+"' Order By town_code";
			}
		else if(par == "change_workno")//��ѯӪҵ��
			{
				change_flag = "flag_workno";
				var town_code = document.all.town_code[document.all.town_code.selectedIndex].value.substring(0,7);
				var myPacket = new AJAXPacket("select_rpc.jsp","���ڻ�ù�����Ϣ�����Ժ�......");
				var sqlStr = "select login_no,login_no||'-- >'||nvl(login_name,login_no) from dLoginMsg where org_code like '"+town_code+"%' Order By login_no ";
				
			}
		myPacket.data.add("sqlStr",sqlStr);
		core.ajax.sendPacket(myPacket);
		delete(myPacket);
}

/*-----------------------------RPC������------------------------------------------------*/
  function doProcess(packet)
  {
	  var rpc_page=packet.data.findValueByName("rpc_page");
 
	 
	    var triListData = packet.data.findValueByName("tri_list"); 
    
  	    var triList=new Array(triListData.length);
	if(change_flag == "flag_dis")
		{
			  triList[0]="district_code";
			  document.all("district_code").length=0;
			  document.all("district_code").options.length=triListData.length;//triListData[i].length;
			  for(j=0;j<triListData.length;j++)
			  {
				document.all("district_code").options[j].text=triListData[j][1];
				document.all("district_code").options[j].value=triListData[j][0];
			  }//���ؽ����
			  document.all("district_code").options[0].selected=true;
			  tochange("change_town");
		}
	else if(change_flag == "flag_town")
		{
			  triList[0]="town_code";
			  document.all("town_code").length=0;
			  document.all("town_code").options.length=triListData.length;//triListData[i].length;
			  for(j=0;j<triListData.length;j++)
			  {
				document.all("town_code").options[j].text=triListData[j][1];
				document.all("town_code").options[j].value=triListData[j][0];
			  }//Ӫҵ�������
			  document.all("town_code").options[0].selected=true;
			  tochange("change_workno");
		}
	else if(change_flag == "flag_workno")
		{
			  triList[0]="login_no";
			  document.all("login_no").length=0;
			  document.all("login_no").options.length=triListData.length;//triListData[i].length;
			  for(j=0;j<triListData.length;j++)
			  {
				document.all("login_no").options[j].text=triListData[j][1];
				document.all("login_no").options[j].value=triListData[j][0];
			  }//���Ž����
		}
//////////////////////////////////////////////////////////////////////////////////////////
		
	  
   }
function getLoginNo(){
    if(document.all.groupName.value==''){
	    rdShowMessageDialog("���Ȳ�ѯ��֯�ڵ�!");
		form1.town_code.focus();
	    return;
	}
    var pageTitle = "ӪҵԱ��ѯ";
    var fieldName = "ӪҵԱ����|ӪҵԱ����";
	/****************************************************
	var sqlStr=" select rtrim(login_no),rtrim(login_name)   from dloginmsg" +
				         " where org_code like '" +document.all.district_code.value+document.all.town_code.value+
				         "%' ";
    *****************************************************/
    var sqlStr=" select rtrim(login_no),rtrim(login_name)   from dloginmsg" +
				         " where  vilid_flag='1' and group_id= '"+document.all.groupId.value+"'";
    if("<%=rpt_right%>" >= "9")
    {
    	sqlStr = sqlStr + " and login_no = '<%=work_no%>'";
    }
    
    if(document.form1.login_no.value != "")
    {
        sqlStr = sqlStr + " and login_no like '" + document.form1.login_no.value + "%'";
    }
    sqlStr = sqlStr + " order by login_no" ;
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "0|1";
    var retToField = "login_no|login_name";
    PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField);
}
function changeLoginNo(){
   document.all.login_name.value="";
}	
</script>

