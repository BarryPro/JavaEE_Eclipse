   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-23
********************/
%>
              
<%
  String opCode = "1414";
  String opName = "����ҵ�񸶽�";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=gb2312"%>
<%@ include file="/npage/common/pwd_comm.jsp" %>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%
  
    request.setCharacterEncoding("GBK");
%>

<html>

<head>
<title>����ҵ�񸶽�</title>
<%
	String phoneNo = (String)request.getParameter("activePhone");
    String workNoFromSession=(String)session.getAttribute("workNo");
	  String userPhoneNo=(String)session.getAttribute("userPhoneNo");
 	  boolean workNoFlag=false;
 	  if(workNoFromSession.substring(0,1).equals("k"))
	  workNoFlag=true;

    String work_no = (String)session.getAttribute("workNo");
    String loginName = (String)session.getAttribute("workName");
    String org_Code = (String)session.getAttribute("orgCode");
		String[][] temfavStr= (String[][])session.getAttribute("favInfo");
		String regionCode = (String)session.getAttribute("regCode");
    String[] favStr=new String[temfavStr.length];
    for(int i=0;i<favStr.length;i++)
     favStr[i]=temfavStr[i][0].trim();
     
    System.out.println("fasle"); 
    boolean pwrf=false;
    if(WtcUtil.haveStr(favStr,"a272")){
	  	pwrf=true;
	  	System.out.println("true");
	  }
   String printAccept="";
   printAccept = getMaxAccept();  
%>
<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
  
  js_pwFlag="<%=pwrf%>";


 function sel_type1() {
            window.location.href='s1414.jsp?ph_no='+document.frm.srv_no.value;
 }

 function sel_type2(){
           window.location.href='s1414Del.jsp?ph_no='+document.frm.srv_no.value;
 }
 
//----------------��֤���ύ����-----------------
 function verifyCust(){
  
    if (document.frm.srv_no.value.length == 0) {
      rdShowMessageDialog("�ֻ����벻��Ϊ�գ����������� !!");
      document.frm.srv_no.focus();
      return false;
     } 
	
	var myPacket = new AJAXPacket("dataqry1414.jsp","���ڲ�ѯ�ͻ���Ϣ�����Ժ�......");
	myPacket.data.add("phoneNo",(document.frm.srv_no.value).trim());
	myPacket.data.add("type","0");
	core.ajax.sendPacket(myPacket);
	myPacket = null;
    
	
 }

function doProcess(packet)
{
    var retCode = packet.data.findValueByName("retCode");
    var retMsg = packet.data.findValueByName("retMsg");
	var retResult = packet.data.findValueByName("retResult");
    var type = packet.data.findValueByName("type");
    var custName = packet.data.findValueByName("cust_name");
	var iccid = packet.data.findValueByName("id_iccid");
	var custAddress = packet.data.findValueByName("id_address");

  if (type == "0"){
		if(custName!=""){
			document.frm.cust_name.value = custName;
			document.frm.iccid.value = iccid;
			document.frm.custAddress.value = custAddress;
			if(js_pwFlag!="false")
			{
				document.frm.confirm.disabled = false;
			}
 
		}else{
			rdShowMessageDialog("�޴˺��룡",0);
			document.frm.srv_no.focus();
			return false;
		}
	}else{
		if(retResult == "000000"){
		 rdShowMessageDialog("��������׼ȷ��",2);
	     document.frm.confirm.disabled = false;
		 return true; 
		 }else{
		 rdShowMessageDialog("��������������������룡",0);
		 document.frm.confirm.disabled = true;
		 return false;
		 
		 }
	}
	

}
function printCommit()
{          
	getAfterPrompt();
	if (document.frm.srv_no.value.length == 0) {
      rdShowMessageDialog("�ֻ����벻��Ϊ�գ����������� !!",0);
      document.frm.srv_no.focus();
      return false;
     } 
     
  if (document.frm.op_note.value.length > 30){   
      rdShowMessageDialog("������ע���ܴ���30������!",0);
      document.frm.srv_no.focus();
      return false;
     } 
   
	if (document.frm.award_sum.value < 1){
  	rdShowMessageDialog("������������С��1!",0);
    document.frm.award_sum.focus();
    return false;
 	}
      
     
 
	if (document.all("award_type").value == "")
	{
      rdShowMessageDialog("�������Ͳ���Ϊ��!",0);
      document.frm.srv_no.focus();
      return false;
	}
	
	if(document.frm.cust_name.value!="")
  {
  	if (document.frm.op_note.value==""){
  		document.frm.op_note.value="����Ա"+"<%=loginName%>"+"���û�"+document.frm.cust_name.value+"��������ҵ�񸶽�";
  	}
  	
		var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
    if((ret=="confirm"))
    {
    	if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
      {  
	      frm.submit();
      }

	    if(ret=="remark")
	    {
      	if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
        {
	       	frm.submit();
        }
	   }
		}else
  	{
    	if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
      {
	    	frm.submit();
      }
  	}
 	}
  
  return true;  	 
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի��� 
   var h=150;
   var w=350;
   var t=screen.availHeight/2-h/2;
   var l=screen.availWidth/2-w/2;

   var printStr = printInfo(printType);

   	
    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 
     var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
     var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
     var sysAccept =<%=printAccept%>;                       // ��ˮ��
     var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
     var mode_code=null;                        //�ʷѴ���
     var fav_code=null;                         //�ط�����
     var area_code=null;                        //С������
     var opCode =   "<%=opCode%>";                         //��������
     var phoneNo = <%=phoneNo%>;                            //�ͻ��绰
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
		var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
		var ret=window.showModalDialog(path,printStr,prop);   
     return ret;    
}


function printInfo(printType)
{
   
  if(document.frm.op_note.value==""){ 		
  			document.frm.op_note.value="����Ա"+"<%=loginName%>"+"���û�"+document.frm.cust_name.value+"��������ҵ�񸶽�����Ʒ����Ϊ"+document.frm.award_type.value;
  }
  	var retInfo = "";
		var note_info1 = "";
		var note_info2 = "";
		var note_info3 = "";
		var note_info4 = "";
		var opr_info = "";
		var cust_info = "";
		
    cust_info+="�ֻ����룺"+document.frm.srv_no.value+"|";
    cust_info+="�ͻ�������"+document.frm.cust_name.value+"|";
    cust_info+="֤�����룺"+document.frm.iccid.value+"|";
    cust_info+="�ͻ���ַ��"+document.frm.custAddress.value+"|";

		opr_info+="ҵ�����ͣ�"+"����ҵ�񸶽�"+"|";
		opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
		opr_info+="�������ͣ�"+document.frm.award_type.value+"|";
		opr_info+="����������"+document.frm.award_sum.value+"|";
		note_info1+="    ��ע�� "+document.frm.op_note.value+"|";
    note_info1+="�����������־��ֲ�: 1���༭����PT��12530���뿪ͨ��ͨ��Ա����;(��ѷ���)"+"|";
    note_info1+="                    2���༭����GJ��12530���뿪ͨ�߼���Ա����;(5Ԫ/��)"+"|";

		
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ

  return retInfo;
}



</script>
</head>
<body>
<form name="frm" method="POST" action="s1414Cfm.jsp" >
	<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">����ҵ�񸶽�</div>
	</div>

<input type="hidden" name="iccid" value="">
<input type="hidden" name="custAddress" value="">
 <input type="hidden" name="printAccept" value="<%=printAccept%>">
      <table  cellspacing="0"  >
          <tr> 
            <td class="blue"  nowrap height=10>��������</td>
            <td  class="blue" nowrap colspan="3" height=10>
            <input name="spType1" type="radio" onClick="sel_type1()" value="1" checked> 
            ¼�� 	
            <input name="spType2" type="radio" onClick="sel_type2()" value="2"> 
            ���� 	
            </td>
          </tr>
          <tr> 
           
			<td width="16%"  nowrap class="blue"> 
              <div align="left">�ֻ�����</div>
            </td>
            <td nowrap  width="28%"> 
            <div align="left"> 
            	<%
            	String ph_no=request.getParameter("ph_no");
            	System.out.println("--------------ph_no------------"+ph_no);
            	%>
                <input "  type="text"  name="srv_no"size="12" id="srv_no" v_minlength=1 v_maxlength=16 v_type="mobphone" v_must=1  maxlength="11" index="0" value =<%=activePhone!=null?activePhone:ph_no%>  Class="InputGrey" readOnly >
                <font class="orange">*
				<input " type="button" class="b_text" name="infor" value="��ѯ" onClick="verifyCust()">
				</font></div>
            </td>
            <td nowrap  width="16%"> &nbsp;
              
            </td>
            <td width="40%"  nowrap> &nbsp;
			</td>
         </tr>
        <tr >
		     <td nowrap  width="16%"> 
              <div align="left" class="blue">�û�����</div>
            </td>
            <TD  width="34%">
			     <input type="text"  name="cust_name"  maxlength="8" readonly  Class="InputGrey" > 		    
		    </TD>
			 <td  nowrap   class="blue">��������</td>
             <td class=Input nowrap  width="40%">
              <select name="award_type" " index="15" >
							<%
                    try
                    {
                      String[][] result = new String[][]{};
                      String sqlStr = "select award_name,award_name from sdataawardcfg a, dloginmsg b where a.region_code = substr(b.org_code,1,2) and a.valid_flag = '1' and b.login_no = '"+work_no+"'";
                     // retArray = callView.view_spubqry32("2",sqlStr);
                     %>
                     
		<wtc:pubselect name="sPubSelect" outnum="2" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=sqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_t" scope="end"/>                     
                     
                     <%
                      result = result_t;
                      int recordNum = result.length;      		
                      for(int i=0;i<recordNum;i++)
                      {
                        out.println("<option   value='" + result[i][0] + "'>" + result[i][1] + "</option>");
                      }
                    }catch(Exception e)
                    {
                      //System.out.println("Call sunView is Failed!");
                    }          
%>
	            </select>             
                  </TD>
               
            </td>
			<td>
		       <div align="left"></div>
		    </td>
         </tr>
 
	<tr >
		<td nowrap  width="16%"> 
    	<div align="left" class="blue">��������</div>
    </td>
    <TD  width="34%">
			<input type="text" " name="award_sum"  maxlength="8" value="1"> 		    
		</TD>
		<td  nowrap  >&nbsp;</td>
			<td>&nbsp;
		       <div align="left"></div>
		    </td>
         </tr>         
	
		  <tr >
		    <td width="16%"  nowrap> 
               <div align="left" class="blue">��ע</div>
			</td>
		    <td> 
			   <INPUT TYPE=text NAME="op_note" size="60" readOnly class="InputGrey">
			</td>
			<td width="16%"  nowrap>&nbsp;</td>
		    <td width="34%"  nowrap>&nbsp;</td>
         </tr>
 
         <tr > 
            <td colspan="5" id="footer"> 
              <div align="center"> 
              <input class="b_foot" type=button name="confirm" value="ȷ��" onClick="printCommit()" index="2"  >    
              <input class="b_foot" type=button name=back value="���" onClick="frm.reset()">
		      <input class="b_foot" type=button name=qryP value="�ر�" onClick="removeCurrentTab();">
              </div>
           </td>
        </tr>
      </table>
 
  </table>
   <%@ include file="/npage/common/pwd_comm.jsp" %>
   <%@ include file="/npage/include/footer.jsp" %>
   </form>
</body>
</html>