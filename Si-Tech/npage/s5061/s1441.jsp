<%
/********************
 version v2.0
 ������: si-tech
 update hejw@2009-1-13
********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<%@ include file="/npage/include/public_title_name.jsp"%>
<%@ page contentType="text/html;charset=GBK"%>

<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ include file="/npage/bill/getMaxAccept.jsp"%>

<head>

<%
  String opCode = "1441";
  String opName = "����ǩ��Э��Ǽ�";
%>

<%
    String workno = (String)session.getAttribute("workNo");
    String workname = (String)session.getAttribute("workName");
  	String org_code = (String)session.getAttribute("orgCode");
  	/*gaopeng 2014/01/08 9:20:10 ���ڹ��ֹ�˾�����Ż�ģ����֤���ܵ���ʾ ��ת�����Ĳ���������У��*/
  	String pwrfNeed = WtcUtil.repNull(request.getParameter("pwrfNeed"));
  	  //add by wanglma 20110425 
  	  boolean pwrf=false;
  	  String[][] temfavStr = (String[][])session.getAttribute("favInfo");
  	  
      String[] favStr=new String[temfavStr.length];
      for(int i=0;i<favStr.length;i++){
        favStr[i]=temfavStr[i][0].trim();
        System.out.println("0000000000000000000favStr["+i+"]000000000000000000000000        "+favStr[i]);
      }
	  if(WtcUtil.haveStr(favStr,"a272")){
         pwrf=true;
      }
      /*gaopeng 2014/01/08 9:20:10 ���ڹ��ֹ�˾�����Ż�ģ����֤���ܵ���ʾ ��ת�����Ĳ���������У��*/
      if(pwrfNeed != null && !"".equals(pwrfNeed)){
      System.out.println("gaopengSeeLog++++==============pwrfNeed:"+pwrfNeed);
      	if("N".equals(pwrfNeed)){
      		pwrf=true;
      	}
     	}
      System.out.println("gaopengSeeLog++++==============pwrf:"+pwrf);
      
      
	  String dateStr = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
	  String printAccept = WtcUtil.repNull(request.getParameter("accept"));
		boolean printFlag = true;
		if ("".equals(printAccept)){
		%>				
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="region" routerValue="<%=org_code.substring(0,2)%>"  id="retListString1"/>					
		<%
				printFlag = false;
				printAccept = retListString1;//��ӡ��ˮ
		}

	System.out.println("printAccept==="+printAccept);
%>


	
</head>
<BODY>
<FORM action="s1441Cfm.jsp" method="post" name="frm" >

	<%@ include file="/npage/include/header.jsp" %> 
 <input type="hidden" name="opCode"    value="1441"> 
 
 <input type="hidden" name="cus_id"  value="">
 <input type="hidden" name="time"    value="<%=dateStr%>">
 <input type="hidden" name="qry_cond"  value="2">
 <% if(pwrf){%>  
	<input type="hidden" name="cus_pass"  value="">
 <%}%>
 <input type="hidden" name="smcode"    value="">
 <input type="hidden" name="printAccept"  value="<%=printAccept%>">
 <input type="hidden" name="ReqPageName" id="ReqPageName" value="s1210Login">
	<div class="title">
		<div id="title_zi">����ǩ��Э��Ǽ�</div>
	</div>
             <table cellspacing="0" >
                <tr> 
                  <td class="blue">�ֻ�����</td>
                  <td> 
                   <input type="text"  value =<%=activePhone%>  Class="InputGrey" readOnly   name="phone_no" >
				           <input type="button"  value=��ѯ onclick= "check()" class="b_text" >
                  </td>
                  
                <%
                if(!pwrf){%>  
				<td class="blue">����</td><td>
				   	<input type="password" name="cus_pass" id="cus_pass" maxlength="6" />
				</td>
				<%}else{%>
				  <td>&nbsp;</td><td>&nbsp;</td>
				<%}%>
                </tr>
               

				<tr> 
                  <td class="blue">�ͻ�����</td>
                  <td> 
                    <input type="text"  name="Contract_name" value="">
                  </td>
                  <td class="blue">�ͻ�Ʒ�� </td>
                  <td> 
                    <input type="text"  name="sm_name" value="">
                  </td>
                </tr>

                <tr > 
                  <td class="blue">�Ƿ���ǩ��Э��</td>
                  <td> 
                   <select   name="protocal" onchange = "dochange()" >
                      <option value="1"  >��</option>
                      <option value="0"  >��</option>
                     </select>
					
                  </td>
				  				<td class="blue">ǩ������</td>
                  <td> 
                    <input type="text"   readonly name="date" value="<%=dateStr%>" >
                  </td>
                </tr>
						<tr>
                  <td colspan="6"> 
				 <font class="orange">
                     ˵����<br>
					&nbsp;&nbsp;&nbsp;&nbsp;��Ϣ��ʵ����Ĳ������޸Ŀͻ�������Ϣ�������������<br>
				  </font>
				   </td>
                </tr>
              
			  </table>
			  
             <table cellspacing=0>	
				<tr> 
                  <td> 
                  	<input type="hidden" name="iccid"  value="">
                  	<input type="hidden" name="custaddress"  value="">
                    <div align="center"> 
                      <input type="button" name="dofind" class="b_foot_long" value="��Ϣ��ʵ" onClick="dofound()"   >
                      &nbsp;
					  <input type="button" name="makesure" class="b_foot_long" value="ȷ��&��ӡ" onClick="dosure()"   >
                      &nbsp;
                      <input type="button" name="close" class="b_foot" value="�ر�" onClick="removeCurrentTab()">
                    </div>
                  </td>
                </tr>
            </table> 

 <%@ include file="/npage/include/footer.jsp" %>
</FORM>

<SCRIPT >
  
  

  function doProcess(packet)
  {
  //alert();
	var cussid = packet.data.findValueByName("cussid");
	var custnumber = packet.data.findValueByName("custnumber");
	var idno = packet.data.findValueByName("idno");
	var custname = packet.data.findValueByName("custname");
	var smcode = packet.data.findValueByName("smcode");
	var smname = packet.data.findValueByName("smname");
	var iccid = packet.data.findValueByName("iccid");
	var custaddress = packet.data.findValueByName("custaddress");
	
	//alert(idno);
	//alert(custname);
	//alert(smcode);
	document.frm.cus_id.value = idno ;
	if(custname.substring(0,5)=="��׼������")
	{
   rdShowMessageDialog("�ÿͻ�Ϊ��׼�������û���ǩԼǰ����пͻ����ϱ����");
	}

	       if(idno==""){
	       rdShowConfirmDialog("�ֻ�������Ч������Ҫ���µǼǣ�");
	       document.frm.makesure.disabled=true;
		   return false;
		    window.close();
	       }else{
			  if(custnumber !=""){
			  	
				  document.frm.protocal.value="1";
				  // add by wanglma 20110422 start �����û� ��ֹ����ѡ
				  document.frm.protocal.disabled = true;
				   // add by wanglma 20110422 end 
                  document.frm.Contract_name.value=custname;
				  document.frm.sm_name.value=smname;
				  document.frm.smcode.value=smcode;
	              document.frm.date.value=custnumber;
				  document.frm.makesure.disabled=true;
				  document.frm.iccid.value=iccid;
				  document.frm.custaddress.value=custaddress;
				  
		          return ;
				
		         }else{
		             document.frm.protocal.value="0";
	                 document.frm.Contract_name.value=custname;
					 document.frm.sm_name.value=smname;
					 document.frm.smcode.value=smcode;
					 document.frm.date.value=<%=dateStr%>;
					 document.frm.makesure.disabled=true;
					 document.frm.iccid.value=iccid;
				   document.frm.custaddress.value=custaddress;
		             return ;
		         }
		
	        }
  
   }


 function check()
  {
  if (document.frm.phone_no.value.length == 0) 
	  {
      rdShowMessageDialog("�ֻ����벻��Ϊ�գ����������� !!");
      document.frm.phone_no.focus();
      return false;
      }
  
  if (document.frm.phone_no.value.length < 11) 
	  {
        rdShowMessageDialog("�ֻ����벻��С��11λ������������ !!");
        document.frm.phone_no.focus();
         return false;
       } 
  var myPacket = new AJAXPacket("qrycustmsg.jsp","���ڲ�ѯ�ͻ���Ϣ�����Ժ�......");
	myPacket.data.add("Phoneno",document.all.phone_no.value);
	core.ajax.sendPacket(myPacket);
	myPacket = null;

 }
/* function change(){
  with(document.frm){
   if(protocal.value=="0"){
    window.close();
   }
  }
 }
 */
 function dofound(){
	if("<%=pwrf%>" == "false"){
		if($("#cus_pass").val() == ""){
			rdShowMessageDialog("���벻��Ϊ��!!");
			return;
		}
	}
	document.frm.action = "<%=request.getContextPath()%>/npage/s1210/s1210Main.jsp?vopcode=1441&pwrfNeed=<%=pwrfNeed%>";
    document.frm.submit();
    
 }
 function dochange(){
	if(document.frm.protocal.value=="1")
	 {
		document.frm.makesure.disabled=false;
	 }
 }
 
 function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի��� 
    
     var h=180;
     var w=350;
     var t=screen.availHeight/2-h/2;
     var l=screen.availWidth/2-w/2;
   
     var printStr = printInfo(printType);
   
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"; 

     var pType="subprint";                  // ��ӡ����print ��ӡ subprint �ϲ���ӡ
     var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
     var sysAccept ='<%=printAccept%>';       // ��ˮ��
     var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
     var mode_code=null;                        //�ʷѴ���
     var fav_code=null;                         //�ط�����
     var area_code=null;                        //С������
     var opCode =   "<%=opCode%>";                         //��������
     var phoneNo = '<%=activePhone%>';                            //�ͻ��绰
     
	   var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
	       path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+document.frm.phone_no.value+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	   var ret=window.showModalDialog(path,printStr,prop);   
}

function printInfo(printType)
{		
	/*
	  var retInfo = "";
      retInfo+='<%=workno%>  <%=workname%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:MM:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      
	    retInfo+="�ֻ�����"+document.frm.phone_no.value+"|";
      retInfo+="�ͻ�����" +document.frm.Contract_name.value+"|";
      retInfo+="֤������: "+document.frm.iccid.value+"|";
      retInfo+="�ͻ���ַ: "+document.frm.custaddress.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";

      
      retInfo+="�û�Ʒ��"+document.frm.sm_name.value+"  "+"����ҵ��ǩԼ"+"|";
      retInfo+="������ˮ"+"<%=printAccept%>"+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";  
      retInfo+=" "+"|";
      retInfo+=" "+"|";     
      retInfo+=" "+"|";
      retInfo+=" "+"|";
	    retInfo+=" "+"|";
	    
      retInfo+="���ʷ�����"+"|";
      retInfo+="�����ݲ��򡰱�׼�����С��ͻ��ṩ����ת�ơ�GPRSҵ��ǩԼ��������굥��ѯ���ʵ���ѯ����"+"|";
      retInfo+="��ͻ������ʷѱ���󣬿���������ͨ�ͻ�ͬ�ȵķ���"
	    retInfo+=" "+"|";
	    retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";

	  return retInfo;
	  */
	  
	    var retInfo    = "";
			var note_info1 = "";
			var note_info2 = "";
			var note_info3 = "";
			var note_info4 = "";
			var opr_info   = "";
			var cust_info  = "";
		
		
			cust_info+="�ֻ����룺"+document.frm.phone_no.value+"|";
			cust_info+="�ͻ�������" +document.frm.Contract_name.value+"|";
			cust_info+="֤�����룺 "+document.frm.iccid.value+"|";
			cust_info+="�ͻ���ַ�� "+document.frm.custaddress.value+"|";
      
 
      opr_info+="�û�Ʒ�ƣ�"+document.frm.sm_name.value+"  "+"����ҵ��ǩԼ"+"|";
      opr_info+="������ˮ��"+"<%=printAccept%>"+"|";

      note_info1+="���ʷ�������"+"|";
      note_info2+="�����ݲ��򡰱�׼�����С��ͻ��ṩ����ת�ơ�GPRSҵ��ǩԼ��������굥��ѯ���ʵ���ѯ����"+"|";
      note_info3+="��ͻ������ʷѱ���󣬿���������ͨ�ͻ�ͬ�ȵķ���|";
<%
			if (printFlag){
%>
					note_info3 += '������ǩԼҵ����ͨ��ģ����֤�ķ�ʽ���а�����δ����ҵ�񹤵�ƾ�ݣ����պ����������ͻ�|';
					note_info3 += '�������ƾ�ݶ��������ף��ҹ�˾��Ȩ�ջغ��벢���´��ã��ɴ�����ķ��������������ге���';
<%					
			}
%>
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ

    return retInfo;
    
}

 function dosure(){
 	getAfterPrompt();
  if (document.frm.Contract_name.value.length == 0) {
      rdShowMessageDialog("�ͻ����Ʋ���Ϊ�գ����������� !!");
      document.frm.Contract_name.focus();
      return false;
   } 

  if (document.frm.sm_name.value.length == 0) {
      rdShowMessageDialog("�ͻ�Ʒ�Ʋ���Ϊ�գ����������� !!");
      document.frm.sm_name.focus();
      return false;
   } 
   
    var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
    if(typeof(ret)!="undefined")
     {
        if((ret=="confirm"))
        {
          if(rdShowConfirmDialog('ȷ�ϵ����������ȷ��,���ύ����ҵ��!')==1)
          {
	           document.frm.action="s1441Cfm.jsp"; 
             document.frm.submit();
          }
	      }
	      if(ret=="continueSub")
	      {
          if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
          {
	          document.frm.action="s1441Cfm.jsp"; 
            document.frm.submit();
          }
	      }
	    }
	    else
      {
        if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
        {
	          document.frm.action="s1441Cfm.jsp"; 
            document.frm.submit();
        }
      }	
  
 }
</SCRIPT>