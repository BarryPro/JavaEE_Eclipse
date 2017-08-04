<%@ page import="org.apache.log4j.Logger"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="java.util.*" %>

<%
    Logger logger = Logger.getLogger("f4523_main.jsp");
	String opName="�޸��ʷ�FAQ-���������޸�";
	String opCode = "5144";
	String workNo = (String)session.getAttribute("workNo");
	String work_name = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String group_id = (String)session.getAttribute("groupId");      
    //��ȡ�û�session��Ϣ   
    String nopass  = (String)session.getAttribute("password");                        //��½���� 
    String regionCode = org_code.substring(0,2);
    String faq_id = request.getParameter("faq_id");
   
    String mode_code = "";
    String mode_name = "";
    String show_type = "";
    String request_privs = "";
    String show_index = "";
    String begin_time = "";
    String end_time = "";
    String faq_bit_region = "";
    String valid_flag = "";
    
    if( "10014".equals(group_id) )
    {
    	regionCode = "99";
    }
    
	String paraArray[] = new String[3];
	paraArray[0] = faq_id;
	paraArray[1] = regionCode;
	paraArray[2] = workNo;
	
	//SPubCallSvrImpl impl = new SPubCallSvrImpl();
	
	//String []result = impl.callService("s5144ModifyInit",paraArray,"11","region",org_code.substring(0,2));
%>
           <wtc:service name="s5144ModifyInit" routerKey="regionCode" routerValue="<%=org_code.substring(0,2)%>"  retcode="errCode" retmsg="errMsg"  outnum="11" >
			       <wtc:param value="<%=paraArray[0]%>"/>
			       <wtc:param value="<%=paraArray[1]%>"/>
			       <wtc:param value="<%=paraArray[2]%>"/>
			</wtc:service>
			<wtc:array id="result0" start="0" length="1" scope="end" />
			<wtc:array id="result1" start="1" length="1" scope="end" />
			<wtc:array id="result2" start="2" length="1" scope="end" />
			<wtc:array id="result3" start="3" length="1" scope="end" />
			<wtc:array id="result4" start="4" length="1" scope="end" />
			<wtc:array id="result5" start="5" length="1" scope="end" />
			<wtc:array id="result6" start="6" length="1" scope="end" />
			<wtc:array id="result7" start="7" length="1" scope="end" />
			<wtc:array id="result8" start="8" length="1" scope="end" />			
			<wtc:array id="result9" start="9" length="1" scope="end" />
			<wtc:array id="result10" start="10" length="1" scope="end" />
<% 	
  if(!errCode.equals("000000"))
  {
%>
<script language="javascript">
    rdShowMessageDialog("<%=errMsg%>");
    window.parent.opener="";
    window.parent.close();
</script>
<%  
	}
	if( result2 != null)
	{
		mode_name    =    result2[0][0];
		show_type =       result3[0][0];
		request_privs =   result4[0][0];
		show_index =      result5[0][0];
		begin_time =      result6[0][0];
		end_time =        result7[0][0];
		valid_flag =      result8[0][0];
		faq_bit_region =  result9[0][0];
		mode_code =       result10[0][0];
	}
    
    String op_name = "�޸��ʷ�FAQ-���������޸�";
%>

<html>
<head>
<title><%=op_name%></title>
<meta http-equiv="Expires" content="0">

</head> 
<body>
    <form name="frm" id="frm" action="f5144ModifyCfm.jsp" method="post">
    	<%@ include file="/npage/include/header.jsp" %>
<!--������-->
<input type="hidden" name="faq_id" maxlength="8" value="<%=faq_id%>" >
<input type="hidden" name="request_privs" maxlength="8" value="<%=request_privs%>" >
<input type="hidden" name="show_type" maxlength="8" value="<%=show_type%>"  >
<input type="hidden" name="faq_bit_region" maxlength="8" value="<%=faq_bit_region%>"  >
<input type="hidden" name="real_mode_name" value="">

      <table cellspacing="0">
      	<tr > 
          <td class="blue">�ʷ�����</td>
          <td > 
            <input type="text" name="mode_name" maxlength="30" value="<%=mode_name%>" class="button" >
			<font class="orange"> *</font>
          </td>
          <td >
		&nbsp;
          </td>
	  <td>
	   <input type="hidden" name="mode_code" maxlength="30" value="<%=mode_code%>" class="button" >
	  </td>
        </tr>
        <tr> 
          <td class="blue">�ʷѿɼ���Χ</td>
          <td> 
            <input type="radio" name="privs" value="128" onclick="changePrivs()"> ����Ա
			<input type="radio" name="privs" value="32" onclick="changePrivs()"> ӪҵԱ<br>
			<input type="radio" name="privs" value="8" onclick="changePrivs()" > ��½�ͻ�
			<input type="radio" name="privs" value="2" onclick="changePrivs()"> ����
			<font class="orange"> *</font>
          </td>
          <td class="blue">�������</td>
          <td> 
            <input type="text" name="show_index" maxlength="2" value="<%=show_index%>" class="button" >
			<font class="orange"> * </font>
			<font class="orange">(���������)</font>
          </td>
        </tr>
		<tr> 
          <td class="blue">��ʼʱ�䣺</td>
          <td> 
            <input type="text" name="begin_time" maxlength="8" value="<%=begin_time%>" class="button" readonly="readonly">
          </td>
          <td class="blue">����ʱ��</td>
          <td> 
            <input type="text" name="end_time" maxlength="8" value="<%=end_time%>" class="button" readonly="readonly">
			<img src="../../images/calender_btn.gif" style="cursor:hand"  onclick="dispDateWindow(document.all.end_time);return false" alt=���ѡ��ʱ�� align=absMiddle readonly>
          </td>
        </tr>
<%
		if("99".equals(regionCode) )
		{
%>
        <tr> 
        	<td class="blue">չʾ����</td>
        	<td>ȫѡ/ȫ��ѡ <input type="checkbox" name="all_region" onclick="selectAllRegion(this.checked)">
        	<td colspan="2"/>
        </tr>
        <tr> 
          <td colspan="4" align="center"> 
          	<input type="hidden" value="0" name="bit_region" >

			<input type="checkbox" value="4096" name="bit_region" onclick="changeBitRegion()">������
			<input type="checkbox" value="2048" name="bit_region" onclick="changeBitRegion()">�������
			<input type="checkbox" value="1024" name="bit_region" onclick="changeBitRegion()">ĵ����
			<input type="checkbox" value="512" name="bit_region" onclick="changeBitRegion()">��ľ˹
			<input type="checkbox" value="256" name="bit_region" onclick="changeBitRegion()">˫Ѽɽ
			<input type="checkbox" value="128" name="bit_region" onclick="changeBitRegion()">��̨��
			<br>
			<input type="checkbox" value="64" name="bit_region" onclick="changeBitRegion()">����
			<input type="checkbox" value="32" name="bit_region" onclick="changeBitRegion()">�׸�
			<input type="checkbox" value="16" name="bit_region" onclick="changeBitRegion()">����
			<input type="checkbox" value="8" name="bit_region" onclick="changeBitRegion()">�ں�
			<input type="checkbox" value="4" name="bit_region" onclick="changeBitRegion()">�绯
			<input type="checkbox" value="2" name="bit_region" onclick="changeBitRegion()">���˰���
			<input type="checkbox" value="1" name="bit_region" onclick="changeBitRegion()">����
          </td>
        </tr>

<%
		}
/*		else
		{
%>
			<input type="checkbox" value="<%="heihei"%>" name="bit_region" onclick="changeBitRegion()"><%="������"%>
<%
		}*/
%>

      	<tr id = "footer"> 
      		<td colspan="4" align="center">
      			<input class="b_foot" type="button" value="ȷ��" onclick="doNext()"/>
      		</td>
      	</tr>
      </table>
 <%@ include file="/npage/include/footer.jsp" %>
    </form>
  </body>
</html>


<script language="javascript" >
	function doNext()
	{
		var year1=document.all.begin_time.value.substring(0,4);
	    var month1=document.all.begin_time.value.substring(4,6)
	    var day1=document.all.begin_time.value.substring(6,8); 
	    var year2=document.all.end_time.value.substring(0,4);   
	    var month2=document.all.end_time.value.substring(4,6);
	    var day2=document.all.end_time.value.substring(6,8); 
		if (document.all.mode_name.value == "") 
		{
        rdShowMessageDialog("�ʷ����Ʋ���Ϊ�գ����������룡");
	      document.all.mode_name.focus();
	      return false;
    }
    else if (document.all.show_index.value.length == "")
    {
        rdShowMessageDialog("������벻��Ϊ�գ����������룡");
	      document.all.show_index.focus();
        return false;
    } 
    else if (document.all.begin_time.value.length < 8)
    {
        rdShowMessageDialog("��ʼʱ�䲻�����ʽҪ�����������룡");
	      document.all.begin_time.focus();
        return false;
    } 
    else if (document.all.end_time.value.length < 8)
    {
        rdShowMessageDialog("����ʱ�䲻�����ʽҪ�����������룡");
	      document.all.end_time.focus();
        return false;
    }
    else if (Date.parse(month1+"/"+day1+"/"+year1) > Date.parse(month2+"/"+day2+"/"+year2))
	{                                                                                             
        rdShowMessageDialog("¼��������ڲ������ڿ�ʼ���ڣ�");
          document.all.faq_bit_region.focus();
        return false;
	}
    else if (document.all.faq_bit_region.value == 0)
    {
        rdShowMessageDialog("չʾ���в���Ϊ�գ����������룡");
	      document.all.faq_bit_region.focus();
        return false;     	
    }
		else
		{
			  document.frm.submit();
		}
	}
	
	function changePrivs()
	{
		for(var i=0; i< document.all.privs.length; i++)
		{
			if(document.all.privs[i].checked)
			{
				document.all.request_privs.value=document.all.privs[i].value;
			}
		}
	}
	
	function changeBitRegion()
	{
		var bitValue = 0;
		for(var i=0; i< document.all.bit_region.length; i++)
		{
			if(document.all.bit_region[i].checked)
			{
				bitValue += parseInt(document.all.bit_region[i].value);
			}
		}
		document.all.faq_bit_region.value = bitValue;
	}
	
	function selectAllRegion(check)
	{
		for(var i=0; i< document.all.bit_region.length; i++)
		{
			document.all.bit_region[i].checked = check;
		}
		changeBitRegion();
	}
	
	function getModeCode(form_name)
	{
		var form = document.getElementById(form_name);
			
		var title_name="�ʷѴ���,�ʷ�����";
		var element_name="mode_code,mode_name,";
		var element_return="mode_code,real_mode_name,";
		
		var sql_str="select a.mode_code,a.mode_name from sbillmodecode a where a.region_code = '<%=org_code.substring(0,2)%>' and power_right != '99' and sysdate between start_time and stop_time";
		
		var op_name1="�ʷѴ���ѡ��";
		var request_url = "../s5087/fpublicQuery.jsp?form_name="+form_name+"&element_num=2&return_num=2&op_name1="+op_name1+"&title_name="+title_name+"&element_name="+element_name+"&element_return="+element_return+"&sql_str="+sql_str;
		window.open(request_url ,"","height=600,width=400,scrollbars=yes");
	}
	
    function dispDateWindow(node)
    {
		var s = "./calendar.html";                                                       
		var ret = window.showModalDialog(s,"","dialogWidth:440px;dialogHeight:483px;center:1");
		if(String(ret) != "undefined" && ret != "$$$") node.value = ret.replace('-','').replace('-','');                       
	} 
	
	function chgContent()
    {
        var k=0;
        for(k=0;k<document.all.privs.length;k++)
        {
            if(document.all.privs[k].value==document.all.request_privs.value)
            {
        		document.all.privs[k].checked = true;
            }
        }
    }
</script>
