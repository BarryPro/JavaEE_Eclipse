
<%request.setCharacterEncoding("GB2312");%>
   
<%
/********************
 version v2.0
 ������ si-tech
 update hejw@2009-2-13
********************/
%>
              
<%
  String opCode = "1584";
  String opName = "�����ӳ���Ч��";
%>              

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http//www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http//www.w3.org/1999/xhtml">
	
<%@ include file="/npage/include/public_title_name.jsp" %> 
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.*"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.util.*"%>

<%
//�ڴ˴���ȡsession��Ϣ
String[][] favInfo = (String[][])session.getAttribute("favInfo");//��ȡ�Ż��ʷѴ���

%>


<HTML>
<HEAD>
<TITLE>������BOSS-������Ч���ӳ�</TITLE>
</HEAD>

<%  
String[][] result = new String[][]{};
String [] result_1 = new String [2];
String regionCode = (String)session.getAttribute("regCode");
%>

<%
String do_note = ReqUtil.get(request,"i222");
String work_no = (String)session.getAttribute("workNo");                                   //��ù�����Ϣ
String phone = ReqUtil.get(request,"i1");                      //��ô����ֻ�����
String org_code = (String)session.getAttribute("orgCode");					                 //org_code 
String op = "1584";
String ret_code = "";
String ret_msg = "";
String rowNum = "16";
String thepassword = ReqUtil.get(request,"i2");                //��ô����ļ�������
String pw_favor = ReqUtil.get(request,"pw_favor");			       //�����Ż�Ȩ�ޱ�־λ1:��0:��
String getselect = ReqUtil.get(request,"select1");
String pw_flag = ReqUtil.get(request,"pw_flag");
				
				String i0="";
        String i1="";
        String i2="";
				String i3="";
        String i4="";
				String i5="";
				String i6="";
				String i7="";
				String i8="";
        String i9="";
				String i10="";
				String i11="";
				String i12="";
				String i13="";
        String i14="";
				String i15="";
				String i16="";
				String i17="";
				String i18="";
				String i19="";
				String i20="";
				String i21="";
				String i22="";
				String i23="";
				String i24="";
				
				String expire="";
				String old_expire="";
				
				
try
{
		//retArray = callView.s1258InitProcess(work_no,phone,op,org_code).getList();
%>

    <wtc:service name="s1258Init" outnum="25" retmsg="msg1" retcode="code1" routerKey="region" routerValue="<%=regionCode%>">
			<wtc:param value="<%=work_no%>" />
			<wtc:param value="<%=phone%>" />	
			<wtc:param value="<%=op%>" />
			<wtc:param value="<%=org_code%>" />		
		</wtc:service>
		<wtc:array id="result_t" scope="end" />

<%


   			ret_code = code1;
        ret_msg  =msg1;
        String errMsg_h="��ѯ�û�ҵ��Ʒ��ʱ����";
        if(ret_msg.equals(""))
        ret_msg = errMsg_h;
    if(result_t.length>0&&code1.equals("000000"))
    {
        result_t = result_t;    //ȡ�������
				i0 = result_t[0][0];					  //�ͻ�id             
				i1 = result_t[0][1];				  	//ҵ�����ʹ���       
				i2 = result_t[0][2];				  	//ҵ����������       
				i3 = result_t[0][3];				  	//�ͻ�����           
			  i4 = result_t[0][4];				  	//�û�����           
				i5 = result_t[0][5];				  	//״̬����           
				i6 = result_t[0][6];				  	//״̬����           
				i7 = result_t[0][7];				  	//�ȼ�����           
				i8 = result_t[0][8];				  	//�ȼ�����           
				i9 = result_t[0][9];				  	//�û�����           
				i10 = result_t[0][10];			  	//�û���������       
				i11 = result_t[0][11];			  	//�ͻ�סַ           
				i12 = result_t[0][12];			  	//֤������           
				i13 = result_t[0][13];			  	//֤������           
				i14 = result_t[0][14];			  	//֤������           
				i15 = result_t[0][15];			  	//�ͻ�������         
				i16 = result_t[0][16];			  	//��ǰǷ��           
				i17 = result_t[0][17];			  	//��ǰԤ��           
				i18 = result_t[0][18];			  	//��һ��Ƿ���ʺ�     
				i19 = result_t[0][19];			  	//��һ��Ƿ���ʺŽ�� 
				i20 = result_t[0][20];          //�����ֶ�
				i21 = result_t[0][21];          //ϵͳʱ��
				i22 = result_t[0][22];          //�ӳ�ʱ�� 
				i23 = result_t[0][23];          //������ 
				i24 = result_t[0][24];          //�Żݴ��� 
				
     
	

 
}
}
catch(Exception e){
	ret_code = "999999";
  ret_msg  ="Call services is Failed!";
  System.out.println("Call services is Failed!"+e);
}
     	
%>
  <%
  	if(!ret_code.equals("000000")){
  %>
	  <script language='jscript'>
	  var ret_code = "<%=ret_code%>";
      var ret_msg = "<%=ret_msg%>";
      rdShowMessageDialog("��ѯ����<br>�������'<%=ret_code%>'��<br>������Ϣ'<%=ret_msg%>'��",0);
      document.location.replace("<%=request.getContextPath()%>/npage/s3070/f1584_1.jsp?ph_no=<%=phone%>");
      </script>
	<%}	
	if(pw_favor.equals("0")){//"0"˵���������Ż�Ȩ��,��Ҫ��������,"1"�������Ż�Ȩ�����ж�
	   String passTrans=WtcUtil.repNull(thepassword);
	   String passFromPage=Encrypt.encrypt(passTrans);
	   if(i3==""){
  %>
	   	 <script language='jscript'>
	    	rdShowMessageDialog("�û�<%=phone%>δ�ҵ�����ȷ����������ֻ�����Ϊ���ã�");
	    	history.go(-1);
	   	 </script>
  <%
	   }
		 else if(0 == Encrypt.checkpwd2(i4,passFromPage)){
  %>
			  <script language='jscript'>
			  rdShowMessageDialog("�û� <%=i3%> �������",0);
			  document.location.replace("<%=request.getContextPath()%>/npage/s3070/f1584_1.jsp?ph_no=<%=phone%>");
			  </script>
	<%}}
		//��Ч���ӳ�95��
		 if(i22.equals("")){
		 	System.out.println("i22=null");
		 	%>
			  <script language='javascript'>
			    rdShowMessageDialog("δ�ҵ��û�<%=phone%>����Ч����Ϣ������������Ч���ӳ���");
			    history.go(-1);
	   	  </script>
	   	  <%}
		 else{
		 	  System.out.println("i22OK:"+i22);
		 	  old_expire=i22.substring(0,8);
				expire=i22.substring(0,8);				
				Date expireJ=new Date();
				DateFormat df = new SimpleDateFormat("yyyyMMdd");
	      expireJ=df.parse(expire);
				GregorianCalendar cal=new GregorianCalendar();
			  cal.setTime(expireJ);     
			  cal.add(GregorianCalendar.DAY_OF_YEAR,95);
				expire=df.format(cal.getTime());
			}
	
  //��֤����,�����ҳ���·����
	if(pw_flag.equals("0")){
	   String passTrans=WtcUtil.repNull(thepassword);
	   String passFromPage=Encrypt.encrypt(passTrans); 
	   if(1 == Encrypt.checkpwd2(i4,passFromPage)){
	%>
		 	 <script language='jscript'>
			 rdShowMessageDialog("�û� <%=i3%> ������ȷ��",0);
			 history.go(-1);
			 </script>
  <%}}%>
	

<BODY>
<FORM action="" method=post name="form1"> 
<%@ include file="/npage/include/header.jsp" %>                         


	<div class="title">
		<div id="title_zi">�����ӳ���Ч��</div>
	</div>


         <TABLE cellpadding="0">  
            <TR > 
				      <TD  class="blue">�������</TD>
				      <TD ><input  name="i1" value="<%=phone%>" size="20" maxlength=11 v_must=1 v_type=mobphone v_name=�ƶ����� readonly Class="InputGrey">
				      </TD>
				      <TD   class="blue">�ͻ�ID</TD>
				      <TD >
				      <input  name="icust_id" size="20"  value="<%=i0%>" maxlength=30  readonly  Class="InputGrey">
				      </TD>
            </TR>
	   		    <TR > 
				      <TD   class="blue">�ͻ�����</TD>
				      <TD >
				      <input  name="iname" size="20" maxlength=30 value="<%=i3%>" readonly Class="InputGrey">
				      </TD>
				      <TD   class="blue">�ͻ���ַ</TD>
				      <TD >
				      <input  name="iaddr" size="30" maxlength=30 value="<%=i11%>" readonly Class="InputGrey">
				      </TD>
            </TR>
			      <TR > 
				      <TD   class="blue">֤����������</TD>
				      <TD ><input  name="icard_type" size="20" maxlength=30 value="<%=i13%>" readonly Class="InputGrey">
				      <TD   class="blue">֤������</TD>
				      <TD >
				      <input  name="icard_no" size="20" maxlength=30 value="<%=i14%>" readonly Class="InputGrey">
				      </TD>
            </TR>
			      <TR > 
				      <TD   class="blue">ϵͳʱ��</TD>
				      <TD >
				      <input  name="sysdate" size="20" maxlength=30 value="<%=i21%>" readonly Class="InputGrey">
				      </TD>
				      <TD   class="blue">����ʱ��</TD>
				      <TD >
				      <input  name="expire_time1" size="30" maxlength=30 value="<%=old_expire%>" v_must=1 v_name=����ʱ�� v_type=string  maxlength=16 readonly Class="InputGrey">
				      </TD>
            </TR>
            
	            <%
			        String favorcode = i24;
		          int m =0;
		        	for(int p = 0;p< favInfo.length;p++){//�Ż��ʷѴ���
			        	for(int q = 0;q< favInfo[p].length;q++)
			        	{
			       	  	//out.println("�Ż��ʷѴ���["+ favInfo[p][q]+"]");
			      	  	if(favInfo[p][q].trim().equals(favorcode))
			      	    {
				      	  	// out.println("wwww");
				      	  	++m;
				        	}
			          }
              }
	           	System.out.println("favorcode:"+favorcode);
	     	    	//out.println("m="+m);
              %>
			
			      <TR > 
				     <%if(m != 0){%>		 
				     <TD   class="blue">������</TD>
				     <TD colspan="3">
				     <input  name="i19" size="20" maxlength=20 value="<%=i23%>" v_must=1 v_name=������ v_type=float >
				     <input  type="hidden" name="i20" size="20"maxlength=20 value="<%=i23%>" readonly  Class="InputGrey" v_name=���������>
				     </TD>
		         <%}else{%>
				     <TD   class="blue" >������</TD>
				     <TD  colspan="3">
				     <input  name="i19" size="20" maxlength=20 value="<%=i23%>" v_must=1 v_name=������ v_type=float readonly  Class="InputGrey" >
				     <input  type="hidden" name="i20" size="20"maxlength=20 value="<%=i23%>" readonly  Class="InputGrey"  v_name=���������>
			    	 </TD>
		         <%}%>
		       </TR>
           <TR >
			       <TD   class="blue">ϵͳ��ע</TD>
			       <TD colspan="3">
			       <input  name="sysnote" size="60" value="�û�<%=phone%>��Ч���ӳ�95��,��Ч���ӳ���<%=expire%>"��readonly  Class="InputGrey" >
			       <input  name="tonote" size="60" value="<%=ReqUtil.get(request,"do_note")%>" type="hidden">
			       </TD>
		       </TR>

		     </TABLE>
		     <TABLE cellpadding="0">  
           <tr > 
			        <td colspan="4" >
			         	<div align="center">
			         		<input  type="hidden" name="expire_time" size="30" maxlength=30 value="<%=expire%>" v_must=1 v_name=����ʱ�� v_type=string  maxlength=16 readonly  Class="InputGrey" >
				          <input  name=next type="button"   onclick="if(check(document.all.form1)) if(checktime()) showPrtDlg();" value=��ӡ&ȷ�� class="b_foot_long">&nbsp;
			            <input  name=1111    type=reset  onClick="" value=��� class="b_foot">&nbsp;
                  <input  name=back  onClick="history.go(-1)" type="button"  class="b_foot"  value=����>&nbsp;
			            <input  name=close  onClick="removeCurrentTab()" type="button"  value=�ر� class="b_foot">&nbsp;
				        </div>
              </td>
             </tr>
         </TABLE>  


<!---------------------------��from1������������----------------------------------------->
 <input type="hidden" name="stream" value="0">
<!---------------------------������һ����Ƿ��------------------------------------------->
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<%/*------------------------javascript��----------------------------*/%>
<script language="javascript">
	
/*-------------------------ҳ���ύ��ת����----------------------------*/

function checktime()
	{
		with(document.form1)
			{   
				if(expire_time.value<=sysdate.value)
					{
						rdShowMessageDialog("'����ʱ��'�������'ϵͳʱ��'��");
						return false;
					}
				
			}
		return true;		
	}
	
/*---------------------���д�ӡȷ������--------------------------------*/

function showPrtDlg()
{
	getAfterPrompt();
	if((document.all.tonote.value).trim().length==0)
   {
	 document.all.tonote.value="����Ա<%=work_no%>"+"���û�"+document.all.i1.value+"�����ӳ���Ч��"
   }
   /*����ģʽ�Ի��𣬲����û��������д���*/
   var h=105;
   var w=260;
   var t=screen.availHeight-h-20;
   var l=screen.availWidth/2-w/2;
   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" 
   var ret=rdShowConfirmDialog("�Ƿ��ӡ���������");
    if(typeof(ret)!="undefined")
    {
        if(ret==1)                      //����Ͽ�
        {
            conf();                          
        }
        else if(ret==0)                 //���ȡ��,���Ƿ��ύ
        {    
            crmsubmit();                     
        }
    }
}

/*-------------------------��ӡ�����ύ������-------------------*/

function conf()
{ 
   var h=200;
   var w=300;
   var t=screen.availHeight-h-20;
   var l=screen.availWidth/2-w/2;

   var phone = document.all.i1.value;								        //�û��ֻ�����
   var date = '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+'<%=new java.text.SimpleDateFormat("MM", 						Locale.getDefault()).format(new java.util.Date())%>'+'<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>';	// ϵͳ����
   var name = document.all.iname.value;								      //�û�����
   var address = document.all.iaddr.value;						    	//�û���ַ
   var cardno = document.all.icard_no.value;					    	//֤������
   var stream = document.all.stream.value;						    	//��ӡ��ˮ
   var work_no = '<%=work_no%>';                         //�õ�����
   var toprintdata = "��Ч���ӳ���:"+document.all.expire_time.value+"|";  //��������
   var sysnote = "�����ӳ���Ч��"+document.all.i1.value;        //�õ���ӡ��ϵͳ��־
   

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" 
   var ret_value=window.showModalDialog("<%=request.getContextPath()%>/npage/change/f1276_print.jsp?phone="+phone+"&date="+date+"&name="+name+"&address="+address+"&cardno="+cardno+"&stream="+stream+"&sysnote="+sysnote+"&work_no="+work_no+"&toprintdata="+toprintdata,"",prop); //���ȷ�ϣ����ô�ӡҳ��
  	var ifretvalue = ret_value.substring(0,4);
   
   if(ifretvalue == "true")
	 {
	   document.all.stream.value = ret_value.substring(4);   //������ȡ������ˮ������ֵ���˱�ҵ�����ˮ��һֱ�����
	   crmsubmit()                                           //�����ύȷ�Ϸ���
   }  
}

function crmsubmit()
{
 if(rdShowConfirmDialog("�Ƿ��ύ�˴β�����")==1)
		 {
           form1.action="f1584_3.jsp";
           form1.submit();
	     }
 else
	 {
	
	 }
 
}

</script>
