   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-17
********************/
%>
              
<%
  String opCode = "5240";
  String opName = request.getParameter("opName");
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=gb2312"%>

<%@ page import="org.apache.log4j.Logger"%>
<%@ page import="java.text.*"%>

<%
	//��ȡ�û�session��Ϣ
	String region_code = (String)session.getAttribute("regCode");
	DateFormat df = new SimpleDateFormat("yyyyMMdd");
	Date d1=new Date();
	String sysdate=df.format(d1);
	
%>

<html>
<head>
<base target="_self">
<title>��Ʒ����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript"> 
//ѡ���������
function queryRegionCode()
{
	
	if(document.form1.region_code.value!="")
	{
	    window.open("f5240_queryRegionCode.jsp","","height=600,width=400,scrollbars=yes");
	}
	else
	{
		rdShowMessageDialog("����ѡ���Ʒ���룡",0);
		document.form1.mode_code.focus();
	}
}

//ѡ�����ش���
function queryDistrictCode()
{
	
	if(document.form1.region_code.value=="")
	{
		rdShowMessageDialog("����ѡ����д��룡",0);
		return false;
	}

    var region_code= document.form1.region_code.value;
	var retToField = "district_code|";
	var url = "f5240_queryDistrictCode.jsp?region_code="+region_code+"&retToField="+retToField;
	
	window.open(url,"","height=600,width=400,scrollbars=yes");
	
}


function queryModeType()
{
	if(!checkElement("region_code")) return ;
	if(!checkElement("sm_code")) return ;

    var retToField = "mode_type|mode_type_name|";
    var url = "f5238_queryModeType.jsp?clear_mode_use=1&region_code="+document.form1.region_code.value+"&smCodeCond="+document.form1.sm_code.value+"&retToField="+retToField;
	window.open(url,'','height=600,width=400,scrollbars=yes');
}






//ѡ��Ʒ�ƴ���
function querySmCode()
{
	if(document.form1.region_code.value!="")
	{
	    var url = "f5240_querySmCode.jsp?region_code="+document.form1.region_code.value;
		window.open(url,'','height=600,width=400,scrollbars=yes');
	}
	else
	{
		rdShowMessageDialog("����ѡ���Ʒ���룡",0);
		document.form1.mode_code.focus();
	}
}

//ѡ�����ʷ�
function queryNextModeCode()
{

	  var url = "f5240_queryNextModeCode.jsp?region_code="+document.form1.region_code.value+"&nextModeCode="+document.form1.nextModeCode.value;
		window.open(url,'','height=600,width=600,scrollbars=yes');
}

//ѡ���Ʒ����
function queryModeCode()
{
	var url = "f5240_queryModeCode.jsp?mode_code="+document.all.mode_code.value+"&login_accept="+document.all.login_accept.value;
	escape(url);
	window.open(url,"","height=600,width=600,scrollbars=yes");
}

//ѡ���ƷĿ¼
function queryDirectId()
{
	var url = "productTree.jsp?productType=2"
	escape(url);
	window.open(url,"","height=600,width=400,scrollbars=yes");
}

//��Ʒ���
function f5240_show()
{
	var url = "f5240_show.jsp?mode_code="+document.all.mode_code.value
	+"&login_accept="+document.all.login_accept.value
	+"&region_code="+document.all.region_code.value
	+"&sm_code="+document.all.sm_code.value
	+"&mode_name="+document.all.mode_name.value
	+"&begin_time="+document.all.mode_begin_time.value
	+"&end_time="+document.all.mode_end_time.value;
	escape(url);
	window.open(url,"","height=650,width=1000,scrollbars=yes");
}
//ѡ��ҵ����
function queryFuncCode()
{
	window.open("f5240_queryFuncCode.jsp","","height=600,width=400,scrollbars=yes");
}

/*--------- �ύ -------------*/
function submitRelease()
{
	getAfterPrompt();
	var myPacket = new AJAXPacket("f5240_release_rpc.jsp?note="+document.all.note.value,"�����ύ��Ϣ�����Ժ�......");		
	myPacket.data.add("mode_code",document.all.mode_code.value);
	myPacket.data.add("group_id",document.all.group_id.value);
	myPacket.data.add("sm_code",document.all.sm_code.value);
	myPacket.data.add("direct_id",document.all.direct_id.value);
	myPacket.data.add("op_code",document.all.op_code.value);
	myPacket.data.add("before_ctrl_code",document.all.before_ctrl_code.value);
	myPacket.data.add("end_ctrl_code",document.all.end_ctrl_code.value);
	myPacket.data.add("begin_time",document.all.begin_time.value);
	myPacket.data.add("end_time",document.all.end_time.value);
	myPacket.data.add("power_right",document.all.power_right.value);
	myPacket.data.add("region_code",document.all.region_code.value);
	myPacket.data.add("cfg_login_accept",document.all.login_accept.value);
	myPacket.data.add("district_code",document.all.district_code.value);
	myPacket.data.add("markFlag",document.all.markFlag.value);
	myPacket.data.add("nextModeCode",document.all.nextModeCode.value);
	core.ajax.sendPacket(myPacket);
	myPacket = null;

}
//---------------------------��ȡrpc���ص��û���Ϣ--------------------------------
function doProcess(myPacket)
{
	var errCode    = myPacket.data.findValueByName("errCode");
	var retMessage = myPacket.data.findValueByName("errMsg");//�������ص���Ϣ		
	var retFlag    = myPacket.data.findValueByName("retFlag");	
	self.status="";
	//�����ɹ�
	if(retFlag=="submit")
	{
		if (errCode==000000)
		{
			
			rdShowMessageDialog("�����ɹ���",2);	
			self.status="�����ɹ���";
			window.location.reload();
		}
		else
		{
			rdShowMessageDialog("����ʧ�ܣ��������"+errCode+"��������Ϣ"+retMessage,0);
		}
	}	
	
}

//��ѯ�ʷѿ��ƴ���
function queryCtrlCode(flag)
{
	//alert(flag);
	var region_code = document.all.group_id.value;
	window.open("f5240_qryBillCtrlCode.jsp?region_code=" + region_code + "&ctrlFlag=" + flag + "&clear_sm_code=1&clear_mode_use=1","","height=600,width=400,scrollbars=yes");
}	

</script>
</head>

<body>

      	  <form name="form1"  method="post">
      	  		  <input type="hidden" name="region_code" value="">
	  <input type="hidden" name="mode_begin_time" value="">
	  <input type="hidden" name="mode_end_time" value="">
	  	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">��Ʒ����</div>
	</div>


				<table cellspacing="0" >
					<tr  height="22">
	  					<TD width="15%" class="blue">&nbsp;&nbsp;��Ʒ����</TD>
	  					<TD width="35%">
	  						<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=8 v_name="��Ʒ����"  name=mode_code maxlength=8 >
	  					</TD>
					    <TD width="15%" class="blue">
					    	&nbsp;&nbsp;������ˮ</TD>
				        <TD width="35%">
				        	<input type=text  v_type="string"  v_must=0 v_minlength=1 v_maxlength=12 v_name="������ˮ"  name=login_accept maxlength=12 >
				        	<input  type="button" name="query_mode"  value="��ѯ" onclick="queryModeCode()" class="b_text">
				        </TD>
				    </tr>
					<tr  height="22">
					  <TD class="blue">&nbsp;&nbsp;��Ʒ����</TD>
				      <TD width="15%"><input type=text  v_type="string"  v_must=0 v_minlength=1 v_maxlength=20 v_name="��Ʒ����"  name=mode_name maxlength=20></TD>

				     <TD class="blue">&nbsp;&nbsp;��ǰ״̬</TD>
				      <TD width="35%"><input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=20 v_name="��ǰ״̬"  name=statusName maxlength=60 ></TD>
				   </tr>
					<tr  height="22">
					  <TD colspan="4"> &nbsp;&nbsp; <font class="orange">��� �� &gt; </font><input name="add_info" type="button"  class="b_text" value="������Ϣ" onClick="f5240_show()">
				       <font class="orange">�Բ�Ʒ���ý�����ˣ����ͨ����ſɷ����� </font></TD>
				  </tr>
				</table>
	  			<TABLE  cellSpacing="0">
	  				<tr >
	  					<TD width="15%" class="blue">&nbsp;&nbsp;��������</TD>
	  					<TD width="85%">
	  						<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=10 v_name="��������Ⱥ"  name=group_id maxlength=10 size="31" readonly  Class="InputGrey" >
	  					</TD>
	  				</tr>
					<tr >
	  					<TD width="15%" class="blue">&nbsp;&nbsp;��������</TD>
	  					<TD width="85%">
	  						<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=100 v_name="��������"  name=district_code maxlength=100 size="31" readonly  Class="InputGrey" >
							<input  type="button"  class="b_text" name="query_districtCode" onclick="queryDistrictCode()" value="ѡ��"> 
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;Ʒ�ƴ���</TD>
	  					<TD>
	  						<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=2 v_name="Ʒ�ƴ���"  name=sm_code maxlength=10 size="8" readonly  Class="InputGrey" >
	  						<input type=text  v_type="string"  v_must=0 v_minlength=1 v_maxlength=20 v_name="Ʒ�ƴ���"  name=sm_name maxlength=20 readonly  Class="InputGrey" >
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;��ƷĿ¼</TD>
  					 	 <TD>
	  						<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=8 v_name="��ƷĿ¼"  name=direct_id maxlength=8 size="8" readonly   Class="InputGrey" ></input>
	  						<input type=text  v_type="string"  v_must=1 v_minlength=1 v_maxlength=20 v_name="��ƷĿ¼"  name=direct_name maxlength=20 readonly   Class="InputGrey" ></input>
                            <input  type="button" class="b_text"  name="query_regioncode"  value="ѡ��" onClick="queryDirectId()">
						</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;�����ʷ�</TD>
  					  	<TD>
	  						<input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=8 v_name="�����ʷ�"  name=nextModeCode maxlength=8  size="8"></input>
	  						<input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=30 v_name="�����ʷ�����"  name=nextModeCodeName maxlength=30 readonly  Class="InputGrey" >

	  						<input  type="button" class="b_text"  name="query_nextModeCode" onclick="queryNextModeCode()" value="ѡ��">
                            
						</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;ҵ��Χ</TD>
  					  	<TD>
	  						<input type=text  v_type="string"  v_must=1 v_minlength=4 v_maxlength=4 v_name="ҵ��Χ"  name=op_code maxlength=4 size="8"  ></input>
	  						<input type=text  v_type="string"  name=op_code_name></input>
                <input  type="button" class="b_text"  name="query_Funccode"  value="ѡ��" onclick="queryFuncCode()">	            
						</TD>
	  				</tr>
	  				
	  				<tr  >
	  					<TD class="blue">&nbsp;&nbsp;ǰ�����</TD>
  					  	<TD>
  					  		<input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=5 v_name="ǰ�����"  name=before_ctrl_code maxlength=5 size="8" value="" readonly  Class="InputGrey" >
  					  		<input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=80 v_name="ǰ�����"  name=befCtrlCodeName maxlength=30 readonly  Class="InputGrey" ></input>
	  					  	<input  type="button" class="b_text"  name="query_befCtrlCode" onclick="queryCtrlCode('B')" value="ѡ��">
  						</TD>
	  				</tr>
	  				<tr >
	  				  	<TD class="blue">&nbsp;&nbsp;������� </TD>
  				      	<TD>
  				      		<input type=text  v_type="string"  v_must=0 v_minlength=0 v_maxlength=5 v_name="�������"  name=end_ctrl_code maxlength=5 size="8" value="" readonly  Class="InputGrey" >
				      	    <input type=text  v_type="string"  v_must=0 v_minlength=5 v_maxlength=80 v_name="�������"  name=endCtrlCodeName maxlength=30 readonly  Class="InputGrey" ></input>
				      	    <input  type="button" class="b_text"  name="query_endCtrlCode" onclick="queryCtrlCode('E')" value="ѡ��">							
				      	</TD>
  				  	</tr>
		         <tr >
	  					<TD class="blue">&nbsp;&nbsp;���ּ����־</TD>
  					  	<TD>
	  					<select name="markFlag" >
										<option value="Y" >Y->������ּ���</option>
										<option value="N" >N->��������ּ���</option>
						  </select>        
						</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;��ʼʱ��</TD>
	  					<TD>
	  						<input type=text  v_type="date" v_must=1 v_minlength=8 v_maxlength=8 v_name="��ʼʱ��" name=begin_time maxlength=8 value="<%=sysdate%>"></input>&nbsp; <font class="orange">��ʽYYYYMMDD<font>
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;����ʱ��</TD>
	  					<TD>
	  						<input type=text  v_type="date" v_must=1 v_minlength=8 v_maxlength=8 v_name="����ʱ��" name=end_time maxlength=8 value="20500101"></input>&nbsp; <font class="orange">��ʽYYYYMMDD<font>
	  					</TD>
	  				</tr>
	  				<tr  style="display:none">
	  					<TD class="blue">&nbsp;&nbsp;Ȩ�޴���</TD>
	  					<TD>
	  						<select name="power_right" v_name="Ȩ�޴���">
	  						<%
								//��ȡȨ�޴���
								String sqlStr1="";
 								sqlStr1 ="SELECT power_right,right_name FROM SPOWERVALUECODE";
 								%>
 								
 	 <wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=region_code%>">
  	 <wtc:sql><%=sqlStr1%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>
 								
 								<%
 							//	retList1 = impl.sPubSelect("2",sqlStr1,"region",regionCode);
 								String[][] retListString1 = new String[][]{};
 								if(code.equals("000000")&&result_t.length>0)
 								retListString1 = result_t;
								for(int i=0;i < retListString1.length;i ++)
								{
							%>
    		          				<option value='<%=retListString1[i][0]%>'><%=retListString1[i][1]%></option>
							<%		
								}
							%>
	  						</select>
	  					</TD>
	  				</tr>
	  				<tr >
	  					<TD class="blue">&nbsp;&nbsp;������Ϣ</TD>
	  					<TD>
	  						<input type=text  v_type="string2" v_must=1 v_minlength=0 v_maxlength=100 v_name="��Ʒ����" name=note maxlength=60 size="50"> <font class="orange">*</font></input>
	  					</TD>
	  				</tr>
	  			</table>
	          	<TABLE  cellSpacing="0">
	  			  <TR >
	  				<TD height="30" align="center" id="footer">
	          	 	    <input name="nextButton" type="button" class="b_foot" value="ȷ��" onClick="submitRelease()" >
	          	 	    &nbsp;
	          	 	    <input name="reset" type="reset"  class="b_foot" value="����"  >
	          	 	    &nbsp;
	          	 	    <input name="reset" type="button"  class="b_foot"  value="�ر�"  onClick="removeCurrentTab()">
	          	 	    &nbsp;
	  				</TD>
	  			  </TR>
	  	    	</TABLE>
	 <%@ include file="/npage/include/footer.jsp" %>
	  </form>
 
</body>
</html>

