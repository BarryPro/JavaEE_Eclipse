<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-19 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%/*
* ע����������������ҳ���ı����λ�õ��Ⱥ�˳�����һ���ı���Ϊi1���Դ����ơ�
		���ֱ������������ݶԴ˱���ʹ�õ����壬����;��
*/%>
<%
	String opCode = "1270";
	String opName = "���ʷѱ��";
	String aftertrim = (String)session.getAttribute("powerRight");
	String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
	String work_no = (String)session.getAttribute("workNo");
%>
<%!
  //splitString()���ڽ�ȡ�ַ�������jdk�ϰ汾û��String.split()����
  public Vector splitString(String sign, String sourceString) 
   {
        Vector splitArrays = new Vector();
        int i = 0;
        int j = 0;
        if (sourceString.length()==0) {return splitArrays;}
        while (i <= sourceString.length()) {
               j = sourceString.indexOf(sign, i);
               if (j < 0) {j = sourceString.length();}
               splitArrays.addElement(sourceString.substring(i, j));
               i = j + 1;
        }
        return splitArrays;
  }
%>

<!----------------------------------ҳͷ��ʾ����----------------------------------------->

<%    
                                //��ù�����Ϣ
  String phone = WtcUtil.repNull(request.getParameter("i1"));
  if(phone==null||phone.length()==0){
  	phone = request.getParameter("activePhone");
  }
  String op_code = WtcUtil.repNull(request.getParameter("iOpCode"));
  String iadd_str = WtcUtil.repNull(request.getParameter("iAddStr"));
	String thepassword = WtcUtil.repNull(request.getParameter("ipassword"));  
  String ret_code = "";
  String ret_msg = "";

  String rowNum = "16";    
  String getselect = WtcUtil.repNull(request.getParameter("select1"));    
	String do_note = WtcUtil.repNull(request.getParameter("i222"));

	String sNewSmName="";
		
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
	String i25="";
	String i26="";
	String i27="";
	String i28="";
	String i31="";
	String subi20="";
	String disCode="";
	String ibig_cust_ls="";
	String old_mode_type="",twoPhoneFlag="",highFlag="";
	String strCurrentPoint = "";//�û���ǰ����/Mֵ

/*******«ѧ�20060301add,��ѯ����ʱ�� *****  begin******/
	String[] inParas1 =new String[]{""};
	String showopentime = "";
	inParas1[0]="select to_char(a.open_time,'YYYY-MM-DD HH24:MI:SS') from dcustinnet a,dCustMsg b where a.id_no=b.id_no and substr(b.run_code,2,1)<'a' and b.phone_no='"+phone+"'";
%>
		<wtc:pubselect name="sPubSelect"  routerKey="phone" routerValue="<%=phone%>" outnum="1">
		<wtc:sql><%=inParas1[0]%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
<%
	if(result==null||result.length==0)
		showopentime ="δ�鵽";
	else if(result.length==1)
		showopentime = result[0][0];
	else
		showopentime ="����������ʱ��";
 /*****«ѧ�20060301add,��ѯ����ʱ�� ***** end******/	
 /*****����÷20080715���ӣ���ѯ�û��ĺڰ�������Ϣ********/
 String sqlB=" select to_char(count(*))	from dBlakWhiteList a,dcustmsg b where a.id_no=b.id_no and b.phone_no=:phone and a.list_type='B'";
 String [] paraIn1 = new String[4];
 String liststr="";
	paraIn1[0] = "region";
	paraIn1[1] = regionCode;
	paraIn1[2] = sqlB;
	paraIn1[3] = "phone="+phone;
%>
	<wtc:service name="sPubSelectNew" routerKey="phone" routerValue="<%=phone%>" outnum="1" >
	<wtc:param value="<%=paraIn1[0]%>"/>
	<wtc:param value="<%=paraIn1[1]%>"/>
	<wtc:param value="<%=paraIn1[2]%>"/>
	<wtc:param value="<%=paraIn1[3]%>"/>
	</wtc:service>
	<wtc:array id="offnodataArray" scope="end"/>
<%
    //ArrayList offonArr = callViewn.callFXService("sPubSelectNew",paraIn1,"1");
    if(offnodataArray!=null&&offnodataArray.length>0){
	    if(!offnodataArray[0][0].equals("0"))
	    {
	    	liststr="�˿ͻ��ں���������!";
	    }else{
	 		String sqloffon="select to_char(count(*)) from dBlakWhiteList a,dcustmsg b where a.id_no=b.id_no and b.phone_no=:phone "
	 				+" and op_Type='0' and op_code='0' and list_type='W' ";
	  		System.out.println("sqloffon====="+sqloffon);
	    	String [] paraIn2 = new String[4];
	    	paraIn2[0] = "region";
	    	paraIn2[1] = regionCode;
	    	paraIn2[2] = sqloffon;
	    	paraIn2[3] = "phone="+phone;  
	%>
				<wtc:service name="sPubSelectNew" routerKey="phone" routerValue="<%=phone%>" outnum="1" >
				<wtc:param value="<%=paraIn2[0]%>"/>
				<wtc:param value="<%=paraIn2[1]%>"/>
				<wtc:param value="<%=paraIn2[2]%>"/>
				<wtc:param value="<%=paraIn2[3]%>"/>
				</wtc:service>
				<wtc:array id="offnodataArray" scope="end"/>
	<%
	    	//offonArr = callViewn.callFXService("sPubSelectNew",paraIn2,"1");
				if(offnodataArray!=null&&offnodataArray.length>0){
		    	if(offnodataArray[0][0].equals("0")){
		    		liststr="�˿ͻ����ڰ���������!";
		    	}
	    	}
	    }
  	}
 
 /**************liucm end **************/	
 
 /*******��ѩ�� 20080505 add,�ʷѱ��ʱ����ʾ��Ϣ *****  begin******/
	
	String showchgmsg = " ";
	inParas1[0]="select trim(msg_text) from sbillchgnote  where region_code='"+regionCode+"'";
%>
		<wtc:pubselect name="sPubSelect"  routerKey="phone" routerValue="<%=phone%>" outnum="1">
		<wtc:sql><%=inParas1[0]%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
<%
	if(result==null||result.length==0)
		showchgmsg ="(δ�鵽�κ�����)";
	if (result.length==1)
		showchgmsg = result[0][0];
	
 /******��ѩ�� 20080505 add,�ʷѱ��ʱ����ʾ��Ϣ  ***** end******/		
    
	    //retArray = callView.s1270GetMsgProcess(work_no,phone,op_code,thepassword).getList();//s1270GetMsg@R1270Msg.cp
      String loginPswInput = (String)session.getAttribute("password");
%>
				<wtc:service name="s1270GetMsg" routerKey="phone" routerValue="<%=phone%>" outnum="32" >
				<wtc:param value=""/>
        <wtc:param value="01"/>
        <wtc:param value="<%=op_code%>"/>
				<wtc:param value="<%=work_no%>"/>
				<wtc:param value="<%=loginPswInput%>"/>
				<wtc:param value="<%=phone%>"/>
				<wtc:param value="<%=thepassword%>"/>
				</wtc:service>
				<wtc:array id="result" scope="end"/>	
<%
		if(result==null||result.length==0){
%>
		<script language="javascript">
			rdShowMessageDialog("û�д˷������������Ϣ!");
			parent.removeTab("<%=opCode%>");
		</script>
<%
			return;
		}
		
		ret_code = result[0][0];          // ���ش���        
		ret_msg = result[0][1];			  // ��ʾ��Ϣ
		
		if(ret_msg.equals(""))
		{
		  ret_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(ret_code));
			if( ret_msg.equals("null"))
			{
				ret_msg ="δ֪������Ϣ";
			}
		}

	if(!ret_code.equals("000000")){
%>
	<script language='jscript'>
	   var ret_code = "<%=ret_code%>";
       var ret_msg = "<%=ret_msg%>";
       rdShowMessageDialog("��ѯ����<br>������룺'<%=ret_code%>'��<br>������Ϣ��'<%=ret_msg%>'��");
       parent.removeTab("<%=opCode%>");
	</script>
<%
		return;
	}
	
		i2 = result[0][2];				  // �û�ID          
		i3 = result[0][3];				  // �ͻ�����        
		i4 = result[0][4];				  // �ͻ�����        
		i5 = result[0][5];				  // �ͻ���ַ        
		i6 = result[0][6];				  // �ͻ�֤���������� 
		i7 = result[0][7];				  // �ͻ�֤������     
		i8 = result[0][8];				  // ҵ��Ʒ��        
		i9 = result[0][9];				  // ҵ��Ʒ������     
		System.out.println("***************i9="+i9);
		i10 = result[0][10];			  // �û�����״̬     
		i11 = result[0][11];			  // �û�����״̬���� 
		i12 = result[0][12];			  // ��Ƿ��          
		i13 = result[0][13];			  // ��Ԥ���        
		i14 = result[0][14];			  // ��һǷ���ʺ�     
		i15 = result[0][15];			  // ��һǷ��        
		i16 = result[0][16];			  // ��ǰ���ײʹ���        
		i17 = result[0][17];			  // ��ǰ���ײ�����     
		i18 = result[0][18];			  // ��ǰ���ײͿ�ͨ��ˮ 
		i19 = result[0][19];			  // ������          
		i20 = result[0][20];              // belong_code  
		i21 = result[0][21];              // ��ͻ�����
		i22 = result[0][22];              // ��ͻ���������
		i23 = result[0][23];              // �������Żݴ��� 
    i24 = result[0][24];              // ���ſͻ����           
    i25 = result[0][25];              // ���ſͻ��������      
    i26 = result[0][26];              // �������ʷ�            oNextMode       
    i27 = result[0][27];    		  // �������ʷ�����        oNextModeName   
		i28 = result[0][28];			  // �������ʷѿ�ͨ��ˮ    oNextModeAccept 
		i31 = result[0][31];			  // �����Ϣ     ��ǰ�ײ����ʹ���|һ��˫�ű�־|
%>		

<%
    ibig_cust_ls = i21 + " " + i22;   //��ͻ���������ҳ����ʾ
		subi20 = i20.substring(0,2);
		disCode = i20.substring(2,4);
		/***
		ArrayList arr = (ArrayList)session.getAttribute("allArr");
		String[][] allNewSmInfo=(String[][])arr.get(5);
		sNewSmName=Pub_lxd.getNewSm(regionCode,(String)result[0][8],allNewSmInfo,"1");
		***/
    sNewSmName=(String)result[0][9];
		System.out.println("&&&&&&&sNewSmName="+sNewSmName);
    Vector vec = new Vector();
		vec = splitString("|",i31);
		old_mode_type = (String)vec.get(0);//��ǰ���ײ�����
		twoPhoneFlag = (String)vec.get(1);//һ��˫�ű�־
		highFlag = (String)vec.get(2);//�и߶��û���־
		strCurrentPoint = (String)vec.get(3);//�û���ǰ����/Mֵ
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>���ʷѱ��</TITLE>
</HEAD>
<body>
<form action="" method=post name="form1"> 
	<%@ include file="/npage/include/header.jsp" %> 
		<div class="title">
			<div id="title_zi">�û���Ϣ</div>
		</div>
       <table cellspacing="0">
         <tr> 
				  <td class="blue" width="15%">�������</td>
				  <td>
				    <input name="i1" value="<%=phone%>" size="20" maxlength=11  v_name=�ƶ����� class="InputGrey" readonly>
				  </td>
				  <td class="blue" width="15%">�ͻ�ID</td>
				  <td>
				    <input name="i2" size="20"  value="<%=result[0][2]%>" maxlength=30 class="InputGrey" readonly>
				  </td>
        </tr>
	    </table>

      <table cellspacing="0">		
			 <tr> 
				  <td class="blue" width="15%">�ͻ�����</td>
				  <td>
				    <input name="i4" size="20" maxlength=30 value="<%=result[0][4]%>" class="InputGrey" readonly>
				  </td>
				  <td class="blue" width="15%">�ͻ���ַ</td>
				  <td>
				    <input name="i5" size="30" maxlength=30 value="<%=result[0][5]%>" class="InputGrey" readonly>
				  </td>
       </tr>
			 <tr> 
				  <td class="blue">֤����������</td>
				  <td>
				    <input name="i6" size="20" maxlength=30 value="<%=result[0][6]%>" class="InputGrey" readonly>
				  <td class="blue">֤������</td>
				  <td>
				    <input name="i7" size="20" maxlength=30 value="<%=result[0][7]%>" class="InputGrey" readonly>
				  </td>
       </tr>
       <tr>
          <td class="blue">ҵ��Ʒ��</td>
          <td>
          	<!-- added by Hanfa 20070117 begin-->
          	<input type="hidden" name="old_smcode" value="<%=result[0][8]%>">
          	<!-- added by hanfa 20070117 end-->
		    		<input type=text name="sNewSmName" value="<%=sNewSmName%>" maxlength="15" class="InputGrey" readonly>
				  </td>
				  <td class="blue">����ʱ��</td><!-- «ѧ�20060301add---begin -->
				  <td>
				  <input type="text" class="InputGrey" readonly name="showopentime" value="<%=showopentime%>" size="20" maxlength="20">
				  </td>       <!-- «ѧ�20060301add---end -->
       </tr>
			 <tr> 
				  <td class="blue">ҵ������</td>
				  <td>
				    <%String add = result[0][8]+" "+result[0][9];%>
				    <input name="i8" size="20" maxlength=20 value="<%=add%>" class="InputGrey" readonly>
				    <input type="hidden" name="i9" size="13" maxlength=20  class="InputGrey" readonly>
				  </td>
				  <td class="blue">����״̬</td>
				  <td>
				    <%String add1 = result[0][10]+" "+result[0][11];%>
				    <input name="i10" size="20" maxlength=2 value="<%=add1%>" class="InputGrey" readonly>
				    <input type="hidden" name="i11" size="20" maxlength=20  class="InputGrey" readonly>
				  </td>
       </tr>
			 <tr> 
				  <td class="blue">δ���ʻ���</td>
				  <td>
				    <input name="i12" size="20" maxlength=2 value="<%=result[0][12]%>" class="InputGrey" readonly>
				  </td>
				  <td class="blue">����Ԥ��</td>
				  <td>
				    <input name="i13" size="20"maxlength=20 value="<%=result[0][13]%>" class="InputGrey" readonly>
				  </td>
       </tr>
			 <tr>  
			    <td class="blue">���ſͻ����</td>
				  <td>
				    <input name="group_type" size="20" value="<%=result[0][24]%> <%=result[0][25]%>" class="InputGrey" readonly>
				  </td>
		      <td class="blue">��ͻ����</td>
				  <td>
				    <input name="ibig_cust" size="20" value="<%=ibig_cust_ls%>"  class="InputGrey" readonly>
				    <input type="hidden" name="ibig_cust_1" size="20" maxlength=20 value="<%=i21%>" readonly>
            <input type="hidden" name="ibig_cust_2" size="20" maxlength=20 value="<%=i22%>" readonly>
 			    </td>  
			  </tr>
				<tr> 
				  <td class="blue">��ǰ���ײ�</td>
				  <td>
				    <%String add2 = result[0][16]+" "+result[0][17];%>
				    <input name="i16" size="30" maxlength=20 value="<%=add2%>" class="InputGrey" readonly>
				    <input type="hidden" name="maincash" size="20" value="<%=result[0][16]%>" class="InputGrey" readonly>
				  </td>
          <td class="blue">�������ײ�</td>
				  <td>
				    <input name="i18" size="30" maxlength=20 value="<%=result[0][26]%> <%=result[0][27]%>" class="InputGrey" readonly>
				  </td>
		   	</tr>	
	   	
			 <tr>  
			    <td class="blue">��ǰ����/Mֵ</td>
				  <td colspan="3">
				    <input name="current_point" size="20" value="<%=strCurrentPoint%> " class="InputGrey" readonly>
				  </td>  
			 </tr>
			</table>
			</div>
			<div id="Operation_Table"> 
			<div class="title">
				<div id="title_zi">ҵ�����</div>
			</div>
			<table cellspacing="0">
        <tr> 
  	      <td class="blue" width="15%">ҵ��Ʒ��</td>
  	      <td colspan="3"> 
            <select align="left" name="newSmCode" width=50 index="1" onChange="chgNewSm()">
            	<wtc:qoption name="sPubSelect" outnum="2">
							<wtc:sql>select distinct bsm_code, trim(bsm_name) from snewsmcode where REGION_CODE='<%=regionCode%>'order by bsm_code</wtc:sql>
							</wtc:qoption>	
    <%
             			String sqlStr = "select distinct a.BSM_CODE ,a.sm_code ,b.sm_name from snewsmcode a,ssmcode b where a.sm_code=b.sm_code";
		%>
									<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phone%>" outnum="3">
									<wtc:sql><%=sqlStr%></wtc:sql>
									</wtc:pubselect>
									<wtc:array id="result222" scope="end" />
		<%
  		            int xDimension = result222.length;
  		            String strArray = "var arrMsg = new Array(";
					        int flag = 1;
					        for(int i=0;i<xDimension;i++){
					            if(flag==1){
					                strArray = strArray + "new Array()";
					                flag = 0;
					                continue;
					            }
					            if(flag==0){
					                strArray = strArray + ",new Array()";
					            }
					        }
					        strArray = strArray + ");";
      %>
           </select>
						<font class="orange">*</font>
          </td>
	      </tr>
				<tr> 
				  <td class="blue">ҵ������</td>
				  <td>
				     <select name="s_city" id="s_city" onchange="tochange()"></select>	
					 	<font class="orange">*</font>
          </td>
          <td class="blue">�ײ����</td>
			      <input type="hidden"  name="subi20" value="<%=subi20%>" >
          <td>
				    <select name="s_spot" id="s_spot" onChange="controlFlagCodeTdView()"></select>
				   	<font class="orange">*</font>
				  </td>
		    </tr>
				<tr> 
        <td class="blue">�������ײ�</td>
			   <td colspan="3" id="ipTd">
            <input type="text" name="ip" id="mainModeCode" size="8" maxlength="8" v_must=1 onChange="changeRateCode()" onclick="" >
			      <input type="text" name="iq" size="18" v_must=1 v_name=�������ʷ�����>&nbsp;&nbsp;
				  	<font class="orange">*</font>
			      <input name="bankCodeQuery" type="button" class="b_text" style="cursor:hand" onClick='getBankCode();' value=��ѯ>&nbsp;&nbsp;
			      <!--input name="sBillModeCodeNoteQuery" id="sBillModeCodeNoteQuery" type="button" class="b_text" style="cursor:hand"  value="�ʷ�����"-->
        		
        		<!------------------------------------------------------------------->
      			<input type="hidden" name="ip1" size="8" maxlength="8">
            <input type="hidden" name="iq1" size="8" maxlength="8">
            <input type="hidden" name="modecodetmp" size="8" maxlength="8">
            <input type="hidden" name="modecodetmp1" size="8" maxlength="8">
            <input type="hidden" name="sBillModeCodeNote" id="sBillModeCodeNote" value="">
			      <!--------------------------------------------------------------------->
         </td>
        </tr>
        <tr>
         <td id = "flagCodeTextTd" class="blue" style="display:none">С������</td>
			   <td id = "flagCodeTd" colspan="3" style="display:none">
			      <!--------------------------------------------------------------------->
            <input type="text" name="flag_code" size="8" maxlength="10" v_must=1  >
			      <input type="text" name="flag_code_name" size="18" v_must=0 v_name="������������" v_type="string" readonly>&nbsp;&nbsp;
            <input type="hidden" name="rate_code">
			      <input type="hidden" name="iAddRateStr">
			      <input name=flagCodeQuery type=button class="b_text" style="cursor:hand" onClick="getFlagCode()" value=��ѯ>
         </td>         
		   </tr>
		   
			<!------------------------------------------------------------------>
      <input type="hidden" name="maincash_no" value="<%=result[0][16]%>">
      <input type="hidden" name="belong_code" value="<%=i20%>">
      <input type="hidden" name="strCurrentPoint" value="">
      <input type="hidden" name="do_string_add">
			<input type="hidden" name="addcash_string">
      <input type="hidden" name="toprintdata">
		  <input type="hidden" name="i19" size="20" maxlength=20 value="<%=result[0][19]%>">
		  <input type="hidden" name="i20" size="20" maxlength=20 value="<%=result[0][19]%>">
      <input type="hidden" name="favorcode" size="20" maxlength=20 value="<%=result[0][23]%>">
		  <input type="hidden" name="imain_stream" size="20" maxlength=20 value="<%=result[0][18]%>" class="InputGrey" readonly>
		  <input type="hidden" name="next_main_stream" value="<%=result[0][28]%>">
		  <input type="hidden" name="ipassword" value="<%=thepassword%>">
		  <!------------------huhx add for ������Ʒ�ĸ��Ի���Ϣ--------->
		  <input type="hidden" name="iAddStr" value="<%=iadd_str%>">
		  <input type="hidden" name="iOpCode" value="<%=op_code%>">
    	<!-------------------------------------------------------------->
		</table>
        <table cellSpacing="0">
          <tbody>
            <tr> 
              <td id="footer">  
	              <!--            
				  <input name=next type=button  onclick="if(check(form1))
				  if(thelength()) pageSubmit(2)"value=��һ��>
				  -->			  
				  <!-- modified by hanfa 20070117-->			  
				  <input class="b_foot" name=next type=button  onclick="submitNext()"value=��һ��>
				  <input class="b_foot" name=1111   type=button  onClick="toclean()" value=���>
				  <input class="b_foot" name="goback"  onClick="history.go(-1)" type=button value="����">				  
				  <input class="b_foot" name=close  onClick="parent.removeTab('<%=opCode%>')" type=button value=�ر�>
	            	<!--<input class="b_foot" name=back  onClick="history.go(-1)" type=button value=����>-->
              </td>
            </tr>
          </tbody>
        </table>
			<%@ include file="/npage/include/footer.jsp" %>
  </form>
</body>
</html>
<%/*------------------------javascript��----------------------------*/%>
<script language="javascript">
<%=strArray%>
<%
  for(int i = 0 ; i < result222.length ; i++){
      for(int j = 0 ; j < result222[i].length ; j++){
        if(result222[i][j].trim().equals("") || result222[i][j] == null)
		{
          result222[i][j] = "";
    }
%>
arrMsg[<%=i%>][<%=j%>] = "<%=result222[i][j].trim()%>";
<%
    }
  }
%>
document.all.ip.focus();
/*------------------------- ���ù�����ѯ����õ����---------------------------*/
function chgNewSm(){	
	temp_select_value=document.all.newSmCode.value;
	document.all.s_city.length=0;
	for(temp_i=0;temp_i<arrMsg.length;temp_i++){
		if(arrMsg[temp_i][0]==temp_select_value){
			var newItem=document.createElement("OPTION");
		  	newItem.text=arrMsg[temp_i][1]+"-->"+arrMsg[temp_i][2];
		  	newItem.value=arrMsg[temp_i][1];
	      	document.all.s_city.options.add(newItem);
		}
	}
	tochange();
}
/**��ѯ���ײ�**/
function getBankCode()
{ 
  	//���ù���js�õ����д���
  	//���ù���js�õ����д���
    var pageTitle = "�ʷѴ����ѯ";
    var fieldName = "�ʷѴ���|�ʷ�����|��Ч��ʽ|��������-------��Ч����|�ʷ�����|";//����������ʾ���С�����
	document.form1.rate_code.value = "";
	document.form1.flag_code.value="";
	document.form1.modecodetmp1.value = document.form1.ip.value;
	document.form1.ip.value="";
	/*
	var sqlStr ="select a.new_mode,b.mode_name,decode(a.SEND_FLAG,'0','0 24Сʱ֮����Ч','1','1 һ��ԤԼ ','2','2 ����ԤԼ'),a.open_days||'��',b.note ";
    sqlStr=sqlStr+" from cBillBBChg a,sBillModeCode b where a.region_code='<%=subi20%>' and a.district_code in ('<%=disCode%>','99')";
    sqlStr=sqlStr+" and a.op_code='<%=op_code%>' and a.OLD_MODE ='<%=java.net.URLEncoder.encode(result[0][16])%>' and a.new_mode like '";
    sqlStr=sqlStr+codeChg("%"+(document.all.modecodetmp1.value)+"%").trim()+"' and b.mode_name like '%"+(document.all.iq.value).trim();
    sqlStr=sqlStr+"%' and b.region_code=a.region_code and b.mode_code=a.new_mode and a.POWER_RIGHT <= <%=aftertrim%> and b.POWER_RIGHT <= <%=aftertrim%>  and b.SM_CODE ='";
    sqlStr=sqlStr+ document.all.s_city.options[document.all.s_city.selectedIndex].value.substring(0,2);
    sqlStr=sqlStr + "' and b.MODE_TYPE ='" + document.all.s_spot.value+"'";
    sqlStr=sqlStr + " and b.start_time<=sysdate and b.stop_time>sysdate and select_flag='0'";
	sqlStr=sqlStr + " order by a.new_mode";
	*/
	var sqlStr =" select a.offer_z_id, b.offer_name, decode(a.effect_type,'0', '0 24Сʱ֮����Ч','2', '2 һ��ԤԼ ','3', '3 ����ԤԼ','1', '1 �ڶ�����Ч'),1, b.offer_comments ";
		sqlStr=sqlStr+" from product_offer_relation a, product_offer b where a.op_code = '<%=op_code%>'  and a.offer_z_id = b.offer_id ";
		sqlStr=sqlStr+" and a.offer_z_id like '%"+codeChg(document.all.modecodetmp1.value).trim()+"%' and b.offer_name like '%"+(document.all.iq.value).trim()+"%' and a.offer_a_id = <%=java.net.URLEncoder.encode(result[0][16])%> and a.right_limit <= <%=aftertrim%> ";
		sqlStr=sqlStr+" and sysdate between b.eff_date and b.exp_date";
		sqlStr=sqlStr+" order by a.offer_z_id ";	
	//alert(sqlStr); 
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "2|0|1|";//�����ֶ�
    var retToField = "ip|iq|";//���ظ�ֵ����
    if(PubSimpSelTwo(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
    if (document.form1.iq.value != "");
    	document.form1.modecodetmp.value = document.form1.ip.value;
    getMidPrompt("10442",codeChg(document.getElementById("mainModeCode").value),"ipTd");
}

function changeRateCode()
{
    document.form1.flag_code.value="";
	document.form1.flag_code_name.value="";
	document.form1.rate_code.value="";
}

/**��ѯ��������**/
function getFlagCode()
{ 
  	//���ù���js�õ����д���
    var pageTitle = "���������ѯ";
    var fieldName = "��������|������������|�������۴���|";//����������ʾ���С�����
    //var sqlStr ="select a.flag_code, a.flag_code_name, a.rate_code from sRateFlagCode a, sBillModeDetail b where a.region_code=b.region_code and a.rate_code=b.detail_code and b.detail_type='0' and a.region_code='<%=subi20%>' and b.mode_code='" + codeChg(document.form1.ip.value) + "' and a.flag_code like '"+codeChg("%"+(document.all.flag_code.value).trim()+"%")+"' order by a.flag_code" ;
    var sqlStr ="select a.flag_code, a.flag_code_name from sofferflagcode a, sregioncode b where a.group_id = b.group_id and b.region_code = '<%=subi20%>' and a.offer_id =" + codeChg(document.form1.ip.value) +" and a.flag_code like '"+codeChg("%"+(document.all.flag_code.value).trim()+"%")+"' order by a.flag_code";
	//alert(sqlStr); 
    var selType = "S";    //'S'��ѡ��'M'��ѡ
    var retQuence = "3|0|1|2|";//�����ֶ�
    var retToField = "flag_code|flag_code_name|rate_code|";//���ظ�ֵ����
    
    if(PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField));
    if (document.form1.flag_code_name.value != "")
    	document.form1.flag_code.readOnly=true;
    else
    	document.form1.flag_code.readOnly=false;
    getMidPrompt("10702",codeChg(document.all.flag_code.value),"flagCodeTextTd");
}
function PubSimpSelTwo(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel_1270.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType + "&opCode=1270";  
    retInfo = window.showModalDialog(path,"","dialogWidth:60");
    if(retInfo ==undefined)      
    {   return false;   }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
        
    }
	return true;
}

function PubSimpSel(pageTitle,fieldName,sqlStr,selType,retQuence,retToField)
{
    var path = "<%=request.getContextPath()%>/npage/public/fPubSimpSel.jsp";
    path = path + "?sqlStr=" + sqlStr + "&retQuence=" + retQuence;
    path = path + "&fieldName=" + fieldName + "&pageTitle=" + pageTitle;
    path = path + "&selType=" + selType;  
    retInfo = window.showModalDialog(path);
    if(retInfo ==undefined)      
    {   return false;   }
    var chPos_field = retToField.indexOf("|");
    var chPos_retStr;
    var valueStr;
    var obj;
    while(chPos_field > -1)
    {
        obj = retToField.substring(0,chPos_field);
        chPos_retInfo = retInfo.indexOf("|");
        valueStr = retInfo.substring(0,chPos_retInfo);
        document.all(obj).value = valueStr;
        retToField = retToField.substring(chPos_field + 1);
        retInfo = retInfo.substring(chPos_retInfo + 1);
        chPos_field = retToField.indexOf("|");
        
    }
	return true;
}
/*----------------------------����RPC������������------------------------------------------*/

 onload=function(){
 		if("<%=liststr%>"!=""){
 			rdShowMessageDialog("<%=liststr%>");
 		}
		chgNewSm();
 }
function tochange()
{
   var subi20 = document.all.subi20.value;
 	 var sm = document.all.s_city[document.all.s_city.selectedIndex].value.substring(0,2);
	 var myPacket = new AJAXPacket("f1270_5.jsp","���ڻ���ʷ������Ϣ�����Ժ�......");
	 myPacket.data.add("subi20",subi20);
	 myPacket.data.add("sm",sm);
	 core.ajax.sendPacket(myPacket);
	 myPacket=null;
}

/*-----------------------------RPC������------------------------------------------------*/
function doProcess(packet)
{
   var rpc_page=packet.data.findValueByName("rpc_page");
   var triListData = packet.data.findValueByName("tri_list"); 
   var triList=new Array(triListData.length);
 
   triList[0]="s_spot";
 
   document.all("s_spot").length=0;
   document.all("s_spot").options.length=triListData.length;//triListData[i].length;
   for(j=0;j<triListData.length;j++)
   {
      document.all("s_spot").options[j].text=triListData[j][1];
      document.all("s_spot").options[j].value=triListData[j][0];
   }
}

/*** �ύʱ����Ʒ��ת������ʾ��Ϣ added by hanfa 20070117 begin ***/
function submitNext()
{
	if(document.all.ip.value.trim().len()==0){
		rdShowMessageDialog("���ײͲ���Ϊ��,��ѡ��!");
		return false;	
	}
	
	//added and modified by hanfa 20070116
	var sm = document.all.s_city[document.all.s_city.selectedIndex].value.substring(0,2);
	if(document.all.old_smcode.value == "zn" && sm == "gn")
	{
		//ѦӢ�� 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@���ڻ��������������������� zn->gn ���ֲ�����
	}
	else
	{
		if(sm != document.all.old_smcode.value)
			rdShowMessageDialog("�ò����漰��Ʒ�Ʊ�����������л��֣���Mֵ�������ʷ���Ч�Ĵ��³����㣬������ʱ�һ�");
	}

  //if(thelength())
  //{
  	 pageSubmit(2);
  //}
}	
/*** �ύʱ����Ʒ��ת������ʾ��Ϣ added by hanfa 20070117 end ***/


/*-------------------------ҳ���ύ��ת����----------------------------*/
function pageSubmit(flag){
	var maincash = document.all.maincash.value;//��ǰ���ײ�
	var i18 = document.all.i18.value.substring(0,8);//�������ײ�
	var ip = document.all.ip.value; //�������ײ�
	
	if((document.form1.s_spot.value=='Yn20')||(document.form1.s_spot.value=="Yn40"))
	{
	  if(document.form1.flag_code.value=="")
	  {
	    rdShowMessageDialog("���<��ѯ>��ťѡ�� '"+document.all.flagCodeTextTd.innerText+"'");
	    document.form1.flag_code.focus();
	    return false;
	  }
	  //alert("document.form1.flag_code_name.value="+document.form1.flag_code_name.value);
	  if(document.form1.flag_code_name.value=="")
	  {
	    rdShowMessageDialog("���<��ѯ>��ťѡ�� '"+document.all.flagCodeTextTd.innerText+"'");
	    document.form1.flag_code_name.focus();
	    return false;
	  }
	}
	document.form1.iAddRateStr.value = document.form1.rate_code.value + "$" + document.form1.flag_code.value;
	
	if( document.form1.ip.value != document.form1.modecodetmp.value)
	{
	  rdShowMessageDialog('���á���ѯ���õ����ʷѴ���!');
	  document.all.ip.focus();
	  return false;
	}
	if( ip==i18  || ip==maincash)
	{
	  rdShowMessageDialog('�������ײͲ����뵱ǰ���ײͻ��������ײ���ͬ!');
	  document.all.ip.focus();
	  return false;
	}
 	if(flag==1){
	  document.form1.action="<%=request.getContextPath()%>/npage/bill/f1270_1.jsp";  
      form1.submit();
	}
	if(flag==2)
	{
	  if(document.all.i13.value-document.all.i12.value<30 
	    && document.all.i8.value.substring(0,2)!=document.all.s_city.value.substring(0,2) 
	    && document.all.s_city.value.substring(0,2)=='cb')
	  {
	    rdShowMessageDialog('�û���Ԥ���-��Ƿ��<30,���ܱ���ɳ������û�!');
	    document.all.ip.focus();
	    return false;
	  }
	  document.form1.action="<%=request.getContextPath()%>/npage/bill/f1270_3.jsp";
    form1.submit();
	}
	if(flag==3)
	{
	  document.form1.action="f1270_2.jsp";
      form1.submit();
	}
}

/****************************�ж��ı���ĳ����Ƿ����Ҫ��**************************/
function thelength()
{
    var length = document.all.ip.value.trim().len();
    if(length<8)
	{
		 rdShowMessageDialog('�������ײʹ��볤��Ӧ��Ϊ8λ��');
		 document.all.ip.focus();//���ؽ���
	   return false;
	}
	else
	{
		return true;
	}
}
/********************************����ı���**********************/
function toclean()
{
   document.form1.ip.value="";
   document.form1.iq.value="";
}
/*���ײ����̬�ı�С�������еĿɼ��ԡ��ı���Ϣ*/
/*�޶������Ϊ���еش�ѡ��С������20061106*/
function controlFlagCodeTdView()
{
  var mode_type = document.form1.s_spot.value;
  if(mode_type=="Yn20")
  {
    document.all.flagCodeTextTd.style.display = "";
    document.all.flagCodeTd.style.display = "";
    document.all.flagCodeTextTd.innerText = "���Ŵ���:";
  }else if(mode_type=="Yn40")
  {
    document.all.flagCodeTextTd.style.display = "";
    document.all.flagCodeTd.style.display = "";
    document.all.flagCodeTextTd.innerText = "С������:";
/*
  }else if(mode_type=="YnA0")
  {
		document.all.ipTd.colSpan = "1";
    document.all.flagCodeTextTd.style.display = "";
    document.all.flagCodeTd.style.display = "";
    document.all.flagCodeTextTd.innerText = "С������";
*/
  }else
  {
    document.all.flagCodeTextTd.style.display = "none";
    document.all.flagCodeTd.style.display = "none";
  }
  return true;
}

/***����������Ҫ�õ��Ĺ��˺���**/
function codeChg(s)
{
  var str = s.replace(/%/g, "%25").replace(/\+/g, "%2B").replace(/\s/g, "+"); // % + \s
  str = str.replace(/-/g, "%2D").replace(/\*/g, "%2A").replace(/\//g, "%2F"); // - * /
  str = str.replace(/\&/g, "%26").replace(/!/g, "%21").replace(/\=/g, "%3D"); // & ! =
  str = str.replace(/\?/g, "%3F").replace(/:/g, "%3A").replace(/\|/g, "%7C"); // ? : |
  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23"); // , . #
  return str;
}
</script>
<script language="JavaScript">
  <%if((old_mode_type.trim()).equals("Yns0")){%>
    rdShowMessageDialog('��ʾ: ��ע��,���û�Ϊ���񹫻��û���');
  <%}%>
  <%if((twoPhoneFlag.trim()).equals("Y")){%>
    rdShowMessageDialog('��ʾ: ��ע��,���û�Ϊһ��˫���û���');highFlag
  <%}%>
  <%if((highFlag.trim()).equals("Y")){%>
    rdShowMessageDialog('��ʾ: ��ע��,���û�Ϊ�и߶��û���');
  <%}%>
</script>
