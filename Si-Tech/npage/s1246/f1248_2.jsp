<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-01-08
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.boss.util.*"%>
<%/*
* ������BOSS-���ػ�����HLR��Ϣ��ѯ  2003-12-13
* @author  ghostlin
* @version 1.0
* @since   JDK 1.4
* Copyright (c) 2002-2003 si-tech All rights reserved.
*/%>
<%/*
* ע����������������ҳ���ı����λ�õ��Ⱥ�˳�����һ���ı���Ϊi1���Դ����ơ�
		���ֱ������������ݶԴ˱���ʹ�õ����壬����;��
*/%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>������BOSS-���ػ�����HLR��Ϣ��ѯ</TITLE>
</HEAD>
<body>
<%
    String opCode = "1248";
    String opName = "HLR��Ϣ��ѯ";
%>
<FORM action="" method=post name="form1"> 
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">HLR��Ϣ��ѯ</div>
</div>
<%@ include file="head_1248.jsp"%>
<%
/*********************************����ǰһҳ�洫������ֵ**************************************/
%>
<%      
    ArrayList retArray = new ArrayList();
	//ArrayList retArray_chinasim = new ArrayList();
    String[][] result = new String[][]{};
	//String[] result_1 = new String[2];
	String[][] result_chinasim = new String[][]{};
    //S1270View  callView = new S1270View();   
    
    String phoneNo = (String)request.getParameter("i1");
	String	chinasim = "";
	String  hlrcode = "";
	String PHONENO_HEAD = ReqUtil.get(request,"i1").substring(0,7);
	//String sqlStr = "select CHINASIM_FLAG,HLR_CODE from sHlrCode where PHONENO_HEAD = '"+PHONENO_HEAD+"' ";
	//retArray_chinasim = callView.spubqry32Process("2","",sqlStr).getList();
	
	String sqlStr = "select CHINASIM_FLAG,HLR_CODE from sHlrCode where PHONENO_HEAD = :PHONENO_HEAD ";
	String [] paraIn = new String[2];
    paraIn[0] = sqlStr;    
    paraIn[1]="PHONENO_HEAD="+PHONENO_HEAD;

%>
<wtc:service name="TlsPubSelCrm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode" retmsg="retMsg" outnum="2" >
	<wtc:param value="<%=paraIn[0]%>"/>
	<wtc:param value="<%=paraIn[1]%>"/> 
</wtc:service>
<wtc:array id="recordArr" scope="end"/>
<%

	//int recordNum = Integer.parseInt((String)retArray_chinasim.get(0));
	if(recordArr.length>0)
	{
		chinasim = recordArr[0][0];
		hlrcode = recordArr[0][1];
	}
%>
<%
/***********************************���巵�ز���*********************************************/
String oret_code="";                                           //    �������               
String oret_msg="";											   //    ������Ϣ
String oid_no="�������û�";			                           // 0  �û�id            
String osm_code="";				                               // 1  ҵ�����ʹ���      
String osm_name="";			                                   // 2  ҵ����������      
String ocust_name="�������û�";		                           // 3  �ͻ�����          
String ouser_password="";			                           // 4  �û�����          
String orun_code="";				                           // 5  ״̬����          
String orun_name="";			                               // 6  ״̬����          
String oowner_grade="";			                               // 7  �ȼ�����          
String ograde_name="";			                               // 8  �ȼ�����          
String oowner_type="";				                           // 9  �û�����          
String oowner_typename="";				                       //10  �û���������      
String ocust_addr="";			                               //11  �ͻ�סַ          
String oid_type="";		                                       //12  ֤������          
String oid_name="";			                                   //13  ֤������          
String oid_iccid="";			                               //14  ֤������          
String ocard_name="";		                                   //15  �ͻ�������        
String ototal_owe="";			                               //16  ��ǰǷ��          
String ototal_prepay="";   	                                   //17  ��ǰԤ��          
String ofirst_oweconno="";								       //18  ��һ��Ƿ���ʺ�    
String ofirst_owefee="";				                       //19  ��һ��Ƿ���ʺŽ��		 
String obak_field=""; 			                               //20  �����ֶ� 
String ohlr_code = hlrcode;                                           //21  HLR����
String ohlr_name="";                                           //22  HLR����


/**********************************����s1248Init�����**********************************/
String iwork_no = hdword_no;                                 //��������
String iphone_no = ReqUtil.get(request,"i1");                //�ֻ�����
String iop_code = "1248";                                    //op_code 
String iorg_code = hdorg_code;                               //org_code

if(!chinasim.equals("1"))//���������û�
	{
try
 	{
        //retArray = callView.s1248InitProcess(iwork_no,iphone_no,iop_code,iorg_code).getList();
%>
<wtc:service name="s1248Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="s1248InitCode" retmsg="s1248InitMsg" outnum="23" >
	<wtc:param value="<%=iwork_no%>"/>
	<wtc:param value="<%=iphone_no%>"/> 
    <wtc:param value="<%=iop_code%>"/>
    <wtc:param value="<%=iorg_code%>"/>
</wtc:service>
<wtc:array id="s1248InitArr" scope="end"/>

<%
String[] result_1 = new String[]{s1248InitCode,s1248InitMsg};
              if(s1248InitArr.length > 0 && s1248InitCode.equals("000000"))
              {
                result = s1248InitArr;   //ȡ�������
              }
              
				     oid_no  = result[0][0];                  // 0 �û�id                            
				   osm_code  = result[0][1];			      // 1 ҵ�����ʹ���       
				    osm_name = result[0][2];				  // 2 ҵ����������       
				  ocust_name = result[0][3];				  // 3 �ͻ�����           
			  ouser_password = result[0][4];				  // 4 �û�����           
				   orun_code = result[0][5];				  // 5 ״̬����           
				   orun_name = result[0][6];				  // 6 ״̬����           
				oowner_grade = result[0][7];				  // 7 �ȼ�����           
				 ograde_name = result[0][8];				  // 8 �ȼ�����           
				 oowner_type = result[0][9];				  // 9 �û�����           
			 oowner_typename = result[0][10];				  //10 �û���������       
				  ocust_addr = result[0][11];				  //11 �ͻ�סַ           
				    oid_type = result[0][12];				  //12 ֤������           
				    oid_name = result[0][13];				  //13 ֤������           
				   oid_iccid = result[0][14];				  //14 ֤������           
				  ocard_name = result[0][15];				  //15 �ͻ�������         
				  ototal_owe = result[0][16];				  //16 ��ǰǷ��           
			   ototal_prepay = result[0][17];				  //17 ��ǰԤ��           
			ofirst_oweconno	 = result[0][18];				  //18 ��һ��Ƿ���ʺ�     
		       ofirst_owefee = result[0][19];				  //19 ��һ��Ƿ���ʺŽ��	
				  obak_field = result[0][20];                 //20 �����ֶ�
				  ohlr_code  = result[0][21];                 //21 HLR����
                  ohlr_name  = result[0][22];				  //22 HLR����
				  oret_code =  result_1[0];                   //   �������
			       oret_msg  = result_1[1];	                  //   ������Ϣ
				   if(oret_msg.equals(""))
					{
    					oret_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(oret_code));
    					if( oret_msg.equals("null"))
						{
						    oret_msg ="δ֪������Ϣ";
						}
					}
   }
		catch(Exception e){
       		//System.out.println("Call services is Failed!");
     	}
%>
<%
     if(!oret_code.equals("000000")){%>
	  <script language='jscript'>
	  var ret_code = "<%=oret_code%>";
      var ret_msg = "<%=oret_msg%>";
      rdShowMessageDialog("��ѯ����<br>������룺'<%=oret_code%>'��<br>������Ϣ��'<%=oret_msg%>'��",0);
      document.location.replace("<%=request.getContextPath()%>/npage/s1246/f1248_1.jsp?activePhone=<%=phoneNo%>");</script>
	  <%}
	%>
<%}%>
      <TABLE cellSpacing=0>
<% 
   /*
   System.out.println("result_1[0]=["+result_1[0]+"]");
   System.out.println("oret_code=["+oret_code+"]");
   System.out.println(retArray.size());
   */
%>
             <TR> 
				  <TD class=blue>�������</TD>
				  <TD colspan="3">
				    <input class="InputGrey" name="i1" value="<%=ReqUtil.get(request,"i1")%>" size="20"  readonly>
				  </TD>
             </TR>
			 <TR> 
			      <TD class=blue>�ͻ�����</TD>
				  <TD>
				  <input class="InputGrey" name="ocust_name" size="20"  value="<%=ocust_name%>" readonly >
				  </TD>
				  <TD class=blue>�ͻ�סַ</TD>
				  <TD>
				  <input class="InputGrey" name="ocust_addr" size="20"  value="<%=ocust_addr%>" readonly>
				  </TD>
             </TR>
			 <TR> 
				  <TD class=blue>֤������</TD>
				  <TD >
				    <input class="InputGrey" name="oid_type" value="<%=oid_type%>" size="20" readonly>
				  </TD>
				  <TD class=blue>֤������</TD>
				  <TD>
				  <input class="InputGrey" name="oid_iccid" size="20"  value="<%=oid_iccid%>"   readonly >
				  </TD>
             </TR>
			 <TR> 
				  <TD class=blue>״̬����</TD>
				  <TD>
				  <input class="InputGrey" name="orun_code" size="20"  value="<%=orun_code%>" readonly>
				  </TD>
				  <TD class=blue>״̬����</TD>
				  <TD>
				  <input class="InputGrey" name="orun_name" size="20"  value="<%=orun_name%>" readonly>
				  </TD>
             </TR>
			 <TR> 
				  <TD class=blue>HLR����</TD>
				  <TD>
				    <input class="InputGrey" name="ohlr_code" value="<%=ohlr_code%>" size="20" readonly>
				  </TD>
				  <TD class=blue>HLR��Ϣ</TD>
				  <TD>
				  <input class="InputGrey" name="ohlr_name" size="20"  value="<%=ohlr_name%>"   readonly >
				  </TD>
             </TR>

			 <%
				  //ArrayList  retArray_favor = new ArrayList();
				  //String[][] result_favor = new String[][]{};
				  String strsql = "";
				  String favor_code = "";
				  String hand_fee = "";
			  try{
				  strsql = "select HAND_FEE, FAVOUR_CODE from sNewFunctionFee where region_code='05' and function_code='1248'";
				  //retArray_favor = callView.spubqry32Process("2","",strsql).getList();
                %>
                    <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phoneNo%>" outnum="2">
                    	<wtc:sql><%=strsql%></wtc:sql>
                    </wtc:pubselect>
                    <wtc:array id="result_favor" scope="end"/>
                <%
				  
				  //result_favor = (String[][])retArray_favor.get(1);
				  hand_fee = result_favor[0][0];
				  favor_code = result_favor[0][1];
			  }
			  catch(Exception e)
			  {
				  e.printStackTrace() ;
				  System.out.println("Call services is Failed!");
			  }
			  
			 %>
			 <%
			//out.println(favorcode);
			int m =0;
			   for(int p = 0;p< favInfo.length;p++){//�Ż��ʷѴ���
						for(int q = 0;q< favInfo[p].length;q++)
						{
						 //out.println("�Ż��ʷѴ��룺["+ favInfo[p][q]+"]");
						 if(favInfo[p][q].trim().equals(favor_code.trim()))
							 {
						// out.println("wwww");
							   ++m;
						     }
							}
                   }
			//out.println("m="+m);
			%>
             <TR>
			     <%if(m != 0){%>		 
				 <TD colspan="4">
				 <input type="hidden" name="ohand_cash" size="20" maxlength=20 value="<%=hand_fee%>" v_must=1 v_type=float >
				 <input type="hidden" name="ishould_fee" size="20"maxlength=20 value="<%=hand_fee%>" readonly >
				 </TD>
		         <%}else{%>
				 <TD colspan="4">
				 <input type="hidden" name="ohand_cash" size="20" maxlength=20 value="<%=hand_fee%>" readonly>
				 <input type="hidden" name="ishould_fee" size="20" maxlength=20 value="<%=hand_fee%>" readonly>
				 </TD>
		         <%}%>
             </TR>
			 <TR>
			 <TD class=blue colspan=4>HLR��Ϣ����</TD>
			 </TR>
			 <TR> 
				  <TD class=blue>�ֻ�����</TD>
				  <TD>
				  <input class="InputGrey" name="ophone_no" size="20"  value="" readonly>
				  </TD>
				  
      <TD class=blue>IMSI��</TD>
				  <TD>
				  <input class="InputGrey" name="oimis_no" size="20"  value="" readonly>
				  </TD>
             </TR>
			 <TR> 
				  <TD class=blue>��;��ʽ</TD>
				  <TD>
				  <input class="InputGrey" name="otoll" size="20"  value="" readonly>
				  </TD>
				  <TD class=blue>��������</TD>
				  <TD>
				  <input class="InputGrey" name="oroam" size="20"  value="" readonly>
				  </TD>
             </TR>
			 <TR> 
				  <TD class=blue>Ƿ�ѽ�ֹ����</TD>
				  <TD>
				  <input class="InputGrey" name="orun_code" size="20"  value="" readonly>
				  </TD>
				  <TD class=blue>Ƿ�ѽ�ֹ����</TD>
				  <TD>
				  <input class="InputGrey" name="orun_name" size="20"  value="" readonly>
				  </TD>
             </TR>
			 <TR> 
				  <TD class=blue>��������</TD>
				  <TD>
				  <input class="InputGrey" name="orun_code" size="20"  value="" readonly>
				  </TD>
				  <TD class=blue>��������</TD>
				  <TD>
				  <input class="InputGrey" name="orun_name" size="20"  value="" readonly>
				  </TD>
             </TR>
			 <TR> 
				  <TD class=blue>���ŷ���</TD>
				  <TD>
				  <input class="InputGrey" name="orun_code" size="20"  value="" readonly>
				  </TD>
				  <TD class=blue>���Ž���</TD>
				  <TD>
				  <input class="InputGrey" name="orun_name" size="20"  value="" readonly>
				  </TD>
             </TR>
			 <TR> 
				  <TD class=blue>��������ת</TD>
				  <TD>
				  <input class="InputGrey" name="orun_code" size="20"  value="" readonly>
				  </TD>
				  <TD class=blue>��æת��</TD>
				  <TD>
				  <input class="InputGrey" name="orun_name" size="20"  value="" readonly>
				  </TD>
             </TR>
			 <TR> 
				  <TD class=blue>��Ӧ��ת��</TD>
				  <TD>
				  <input class="InputGrey" name="orun_code" size="20"  value="" readonly>
				  </TD>
				  <TD class=blue>���ɼ�ת��</TD>
				  <TD>
				  <input class="InputGrey" name="orun_name" size="20"  value="" readonly>
				  </TD>
             </TR>
			 <TR> 
				  <TD class=blue>���еȴ�</TD>
				  <TD>
				  <input class="InputGrey" name="orun_code" size="20"  value="" readonly>
				  </TD>
				  <TD class=blue>���б���</TD>
				  <TD>
				  <input class="InputGrey" name="orun_name" size="20"  value="" readonly>
				  </TD>
             </TR>
			 <TR> 
				  <TD class=blue>����ͨ��</TD>
				  <TD>
				  <input class="InputGrey" name="orun_code" size="20"  value="" readonly>
				  </TD>
				  <TD class=blue>����</TD>
				  <TD>
				  <input class="InputGrey" name="orun_name" size="20"  value="" readonly>
				  </TD>
             </TR>
			 <TR> 
				  <TD class=blue>����ͨ��</TD>
				  <TD>
				  <input class="InputGrey" name="orun_code" size="20"  value="" readonly>
				  </TD>
				  <TD class=blue>������ʾ</TD>
				  <TD>
				  <input class="InputGrey" name="orun_name" size="20"  value="" readonly>
				  </TD>
             </TR>
			 <TR> 
				  <TD class=blue>��������</TD>
				  <TD>
				  <input class="InputGrey" name="orun_code" size="20"  value="" readonly>
				  </TD>
				  <TD class=blue>GPRS</TD>
				  <TD>
				  <input class="InputGrey" name="orun_name" size="20"  value="" readonly>
				  </TD>
             </TR>
			 <TR> 
				  <TD class=blue>�Ƿ�ǩԼ�û�</TD>
				  <TD colspan="3">
				  <input class="InputGrey" name="ovisa" size="20"  value="" readonly>
				  </TD>
             </TR>
           <TR>
			   <TD class=blue>��ע</TD>
			   <TD colspan="3">
			   <input class="InputGrey" name="sysnote" size="60" readonly>
			   </TD>
		   </TR>
		    <TR style="display:none"> 
				<TD class=blue>������ע</TD>
				<TD colspan=3>  
				<input name="donote" size="60" value="" >
				</TD>
		   </TR>

            <TR id="footer"> 
              <TD colspan=4>
              <input class="b_foot" name=sure onClick="document.all.sysnote.value=document.all.i1.value + document.all.ohlr_name.value ;if(check(form1)) pageSubmit('s1246/f1248_3.jsp');" type=button value=��ѯ>
			  <input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=�ر�>
			  <input class="b_foot" name=back  onClick="history.go(-1)" type=button value=����>
              </TD>
            </TR>
       </TABLE>
	   <!-----------------------------------����������----------------------------------------------->
	   <input type="hidden" name="stream" value="0">	                                                               
       <input type="hidden" name="work_no" value="<%=hdword_no%>">       
	   <input type="hidden" name="work_pwd" value="<%=hdwork_pwd%>">     
	   <input type="hidden" name="org_code" value="<%=hdorg_code%>"> 	 
	   <input type="hidden" name="cust_id" value="<%=oid_no%>">			 
	   <input type="hidden" name="hlr_code" value="<%=ohlr_code%>">			
	   <input type="hidden" name="ip_address" value="<%=hdthe_ip%>">									
	   <!-------------------------------------------------------------------------------------------->
	   <%@ include file="/npage/include/footer.jsp" %>
	   </FORM>
     </BODY>
   </HTML>
  
  <script language="javascript">
/*-----------------------------ҳ����ת����-----------------------------------------------*/
function pageSubmit(page)
{
    document.form1.action="<%=request.getContextPath()%>/npage/"+page;
	form1.submit();
}

</script>