<%
/********************
 version v2.0
������: si-tech
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
 <html xmlns="http://www.w3.org/1999/xhtml">
	<%@ page contentType="text/html; charset=GBK" %>
	<%@ include file="/npage/include/public_title_name.jsp" %>
	<%@ page import="java.text.SimpleDateFormat"%>
	
 	 <%
 	 	response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
		
		ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
 	 	String[][] temfavStr=(String[][])arrSession.get(3);
    String[] favStr=new String[temfavStr.length];
    for(int i=0;i<favStr.length;i++)
     favStr[i]=temfavStr[i][0].trim();
    boolean pwrf=false;
    if(WtcUtil.haveStr(favStr,"a272")){
    	pwrf=true;
    }
	  
	  
		 boolean hfrf=false;
 	 	/*
  	 comImpl co=new comImpl();
 		 ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
 		 String[][] baseInfoSession = (String[][])arrSession.get(0);
 		 String work_no = baseInfoSession[0][2];
 		 String loginName = baseInfoSession[0][3];
 		 String org_code = baseInfoSession[0][16];
		 String[][] temfavStr=(String[][])arrSession.get(3);
		 String[] favStr=new String[temfavStr.length];
		 for(int i=0;i<favStr.length;i++)
		  favStr[i]=temfavStr[i][0].trim();
         boolean pwrf=false;
		 boolean hfrf=false;
		 if(Pub_lxd.haveStr(favStr,"a272"))
           pwrf=true;
		String regionCode = (baseInfoSession[0][16]).substring(0,2);
 		 String op_code = "6236";          
 		 
 		 String paraStr[]=new String[1];
	   comImpl co1=new comImpl();
	   String prtSql="select to_char(sMaxSysAccept.nextval) from dual";
	   paraStr[0]=(((String[][])co1.fillSelect(prtSql))[0][0]).trim();
	   System.out.println("11111111111��" +paraStr[0]);
	   */
	   
	    String regionCode = (String)session.getAttribute("regCode");    
	    String work_no = (String)session.getAttribute("workNo");
	    String loginName = work_no;
 		String noPass = (String)session.getAttribute("password");
 		String groupID = (String)session.getAttribute("groupId");
	 		String opCode = "6236";
			String opName = "���еȴ�����";
		String srv_no = (String)request.getParameter("activePhone");

	  

 	 //---------------�����ύҳ�������������-----------------------------
 		
 		/*
  	 //------------------�������------------------------------------------
 		String srv_no=Pub_lxd.repNull(request.getParameter("srv_no"));
 		 if(srv_no.equals(""))
		{
			response.sendRedirect("s6236Login.jsp?ReqPageName=s6236Main&retMsg=1");
		}
		*/
		/*
		S1210Impl im=new S1210Impl();
		ArrayList custDoc=im.sPubUsrBaseInfo(srv_no,op_code,"phone",srv_no,work_no);
     	if(custDoc==null)
		{
			response.sendRedirect("s6236Login.jsp?ReqPageName=s6236Main&retMsg=2");
		}
		*/
		%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone"  routerValue="<%=srv_no%>" id="sLoginAccept"/>
			
		<wtc:service name="sPubUsrBaseInfo" routerKey="phone" routerValue="<%=srv_no%>" retcode="retCode1" retmsg="retMsg1" outnum="30" >
			<wtc:param value=" "/>
			<wtc:param value="01"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=work_no%>"/>	
			<wtc:param value="<%=noPass%>"/>		
			<wtc:param value="<%=srv_no%>"/>	
			<wtc:param value=" "/>
			</wtc:service>
		<wtc:array id="sPubUsrBaseInfoArr" scope="end"/>
	<%

    System.out.println("---6236-------retCode1="+retCode1);
    if(!"000000".equals(retCode1)){
%>
      <script language=javascript>
        rdShowMessageDialog('������룺<%=retCode1%><br>������Ϣ��<%=retMsg1%>');
        removeCurrentTab();
      </script>
<%
      return;
    }
		ArrayList baseInfoList = new ArrayList();
		if(sPubUsrBaseInfoArr!=null&&sPubUsrBaseInfoArr.length>0&&retCode1.equals("000000")){
			for(int i=0;i<sPubUsrBaseInfoArr.length;i++){
				for(int j=0;j<sPubUsrBaseInfoArr[i].length;j++){
					baseInfoList.add(sPubUsrBaseInfoArr[i][j]);
					System.out.println("6236======sPubUsrBaseInfoArr["+i+"]["+j+"]="+sPubUsrBaseInfoArr[i][j]);
				}
			}
		}else{
		  
		}
String userRegionCode = ((String)baseInfoList.get(2)).length()>=2?((String)baseInfoList.get(2)).substring(0,2):"";
		String handFeeSqlStr = "select hand_fee ,trim(favour_code) from snewFunctionFee where region_code='"+userRegionCode+"' and function_code='"+opCode+"'";
%>
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="2">
    <wtc:sql><%=handFeeSqlStr%>
    </wtc:sql>
		</wtc:pubselect>
		<wtc:array id="handFeeSqlArr" scope="end"/>
<%
		if(handFeeSqlArr!=null&&handFeeSqlArr.length>0){
			for(int i=0;i<handFeeSqlArr[0].length;i++){
				baseInfoList.add(handFeeSqlArr[0][i]);
			}
		}else{
				baseInfoList.add("");
				baseInfoList.add("");
		}

		//���񷵻ز������ܲ��淶,���緵����λ�ȵ�.��������ת����,������Ϊ����������淶�����Ĵ���
		int returnCode = retCode1==""?999999:Integer.parseInt(retCode1);
		String returnMsg = retMsg1;
		baseInfoList.add(String.valueOf(returnCode));
		baseInfoList.add(returnMsg);

		//�������������ת��һ��
		ArrayList custDoc = baseInfoList;
	
	if(((String)custDoc.get(30)).trim().equals("") || ((String)custDoc.get(30)).trim().equals("0") || Double.parseDouble(((String)(custDoc.get(30))))==0)
		{
 			hfrf=true;
		}else{
      if(!WtcUtil.haveStr(favStr,((String)custDoc.get(31)).trim())){
 				hfrf=true;
		  }
		}	
%>


<head>
  <title><%=opName%></title>
	<script language="javascript" type="text/javascript" src="/npage/public/knockout-2.0.0.js" ></script>

	<script src="<%=request.getContextPath()%>/npage/callbosspage/js/datepicker/WdatePicker.js" type="text/javascript"></script>
	
	 <script language=javascript>	  
	   onload=function()
	   {
 		 self.status="";
		 document.all.s_optype.focus();
	   }	   

//ȥ���ַ����Ŀո�
function jtrim(str)
        { while (str.charAt(0)==" ")
        {str=str.substr(1);}
    while (str.charAt(str.length-1)==" ")
                                    {str=str.substr(0,str.length-1);}
    return(str);
    }
    

function printCommit()
{
	ChkHandFee();
	//showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
	if(check(frm))
	{
		document.all.t_sys_remark.value="�û�"+jtrim(document.all.srv_no.value)+"���еȴ�"+document.all.s_optype.options[document.all.s_optype.selectedIndex].text;
	 	if(jtrim(document.all.t_op_remark.value).length==0)
    {
			document.all.t_op_remark.value="����Ա<%=work_no%>"+"���û��ֻ�"+jtrim(document.all.srv_no.value)+"���еȴ�����"
	  }
		conf();
	}
}

function showPrtDlg(printType,DlgMessage,submitCfm)
{
	if(check(frm))
	{
		document.all.t_sys_remark.value="�û�"+jtrim(document.all.srv_no.value)+"���еȴ�"+document.all.s_optype.options[document.all.s_optype.selectedIndex].text;
	 	if(jtrim(document.all.t_op_remark.value).length==0)
    {
			document.all.t_op_remark.value="����Ա<%=work_no%>"+"���û��ֻ�"+jtrim(document.all.srv_no.value)+"���еȴ�����"
	  }

		//��ʾ��ӡ�Ի���
		var h=210;
	  var w=400;
	  var t=screen.availHeight/2-h/2;
	  var l=screen.availWidth/2-w/2;
		var pType="subprint";
    var billType="1";

    var mode_code="";
 		var fav_code=null;
 		var area_code=null
 		var sysAccept = document.all.loginAccept.value;
	 		
		var printStr = printInfo(printType);
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no;	scrollbars:yes; resizable:no;location:no;status:no;help:no"
		/*
		var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage;
    var path = path + "&printInfo=" + printStr + "&submitCfm=" + submitCfm;
    */
    /* ningtn */
		var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
		var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
				
    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + "ȷʵҪ���е��������ӡ��"+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
  	var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=srv_no%>&loginacceptJT="+$("#loginacceptJT").val()+"&submitCfm=" + "Yes"+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
  	  
    var ret=window.showModalDialog(path,"",prop);

		if(typeof(ret)!="undefined")
		{
			if((ret=="confirm")&&(submitCfm == "Yes"))
			{
			  if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
			  {
			   conf();
			  }
		    }
		    if(ret=="continueSub")
		    {
			  if(rdShowConfirmDialog('ȷ��Ҫ�ύ���еȴ����� ��Ϣ��')==1)
			  {
			   conf();
			  }
    		}
		}else
		{
			if(rdShowConfirmDialog('ȷ��Ҫ�ύ���еȴ����� ��Ϣ��')==1)
			{
			   conf();
			}
		}
	}
}

	 function printInfo(printType)
	 {
	 	
	 		var retInfo = "";

 		  var cust_info="";
	    var opr_info="";
	    var note_info1="";
	    var note_info2="";
	    var note_info3="";
	    var note_info4="";
	    
	    cust_info+="�ֻ����룺   <%=srv_no%>|";
	    cust_info+="�ͻ�������   <%=(String)custDoc.get(5)%>|";
	    cust_info+="�ͻ���ַ��   <%=(String)custDoc.get(13)%>|";
	    cust_info+="֤�����룺   <%=(String)custDoc.get(16)%>|";
	    
	    opr_info+="�������ͣ�"+document.all.s_optype.options[document.all.s_optype.selectedIndex].text+"���еȴ� "+"|";
    	opr_info+="��ˮ��"+document.all.loginAccept.value+"|";
	    
	    note_info1+=document.all.t_sys_remark.value+"|";
    	note_info1+=document.all.t_op_remark.value+"|";
	    
	 		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			return retInfo;
	 }

	 //--------5----------�ύ������-------------------
	 function conf()
	 {
		document.all.b_print.disabled=true;
		document.all.b_clear.disabled=true;
		document.all.b_back.disabled=true;

		 frm.action="/npage/s1210/s6236_conf.jsp";
		 frm.submit();
	 }

	 function canc()
	 {
		frm.submit();
	 }

    //-------6--------ʵ����ר�ú���----------------
     function ChkHandFee()
	 {
       if(jtrim(document.all.oriHandFee.value).length>=1 && jtrim(document.all.t_handFee.value).length>=1)
	   {
         if(parseFloat(document.all.oriHandFee.value)<parseFloat(document.all.t_handFee.value))
	     {
          rdShowMessageDialog("ʵ�������Ѳ��ܴ���ԭʼ�����ѣ�");
		  document.all.t_handFee.value=document.all.oriHandFee.value;
		  document.all.t_handFee.select();
		  document.all.t_handFee.focus();
		  return;
	     }
	   }
	  
	   if(jtrim(document.all.oriHandFee.value).length>=1 && jtrim(document.all.t_handFee.value).length==0)
	   {
         document.all.t_handFee.value="0";
	   }
	   document.all.t_factFee.value = document.all.t_handFee.value;
	 }

	 function getFew()
	 {
	   if(window.event.keyCode==13)
	   {
		 var fee=document.all.t_handFee;
		 var fact=document.all.t_factFee;
		 var few=document.all.t_fewFee;
		 if(jtrim(fact.value).length==0)
		 {
		  rdShowMessageDialog("ʵ�ս���Ϊ�գ�");
		  fact.value="";
		  fact.focus();
		  return;
		 }
		 if(parseFloat(fact.value)<parseFloat(fee.value))
		 {
		  rdShowMessageDialog("ʵ�ս��㣡");
		  fact.value="";
		  fact.focus();
		  return;
		 }

		var tem1=((parseFloat(fact.value)-parseFloat(fee.value))*100+0.5).toString();
		var tem2=tem1;
		if(tem1.indexOf(".")!=-1) tem2=tem1.substring(0,tem1.indexOf("."));
	    few.value=(tem2/100).toString();
		few.focus();
	   }
	 }
	 
	 function callTypeChg(){
	 	if(document.all.callType.value=="52"){
	 		document.all.s_optype_id.style.display = "";
	 		document.all.s_optype_new.value = "1";
	 	}else{
	 		document.all.s_optype_id.style.display = "none";
	 		document.all.next_no.value="";
	 		document.all.s_optype_new.value = "1";
	 	}
	}
	function opTypeNewChg(){
		if(document.all.s_optype_new.value=="0"){
			document.all.next_no.value="";
		}else{
			document.all.next_no.value="";
		}
	}
	

	 function assuWin()
	 {
 	    var h=260;
		var w=450;
		var t=screen.availHeight/2-h/2;
		var l=screen.availWidth/2-w/2;

        window.open("../../page/sAssure/fcust_assure.jsp?phone_no=<%=srv_no%>&user_id= &op_code=6236","","width="+w+",height="+h+",left="+l+",top="+t+",resizable=no,scrollbars=yes,status=no,location=no,menubar=no");
	 }
	 	 
	 </script>
	 </head>
	 
	 <body>
	<form action="" method="post" name="frm"id="frm">
	<%@ include file="/npage/include/header.jsp" %>
	<div class="title">
		<div id="title_zi"><%=opName%></div>
	</div>
	<div>
		<table>
	    <tr style="display:none">
	  		<td class="blue" width="20%" > 
          �ͻ����ƣ�
        <td  width="30%"> 
          <%=(String)custDoc.get(5)%>
        </td>
        <td class="blue" width="20%"> 
          ��ͻ���־��
        </td>
        <td  width="30%"> 
          <%=(String)custDoc.get(17)%>
        </td>
	    </tr>
	    <tr style="display:none">
	  		<td class="blue" width="20%"> 
          ���ű�־��
        </td>
        <td width="30%"> 
          <%=(String)custDoc.get(18)%>
        </td>
		    <td class="blue" width="20%"> 
	        �ͻ�״̬��
	      </td>
	      <td  width="30%"> 
	        <%=(String)custDoc.get(8)%>
	      </td>
      </tr>
      <tr style="display:none">
      	<td class="blue" width="20%"> 
          �ͻ�����
        </td>
        <td  width="30%"> 
          <%=(String)custDoc.get(10)%>
        </td>
        <td class="blue" width="20%"> 
          �ͻ����
        </td>
        <td  width="30%"> 
          <%=(String)custDoc.get(12)%>
        </td>
      </tr>
      <tr>
      	<td class="blue" width="20%"> 
          �û����룺
        </td>
        <td  width="30%" ><%=srv_no%> </td>
       	<td class="blue" width="20%"> 
          �������ͣ�
        </td>
        <td  width="30%"> 
          <select name="s_optype" id="s_optype" index="0">
            <option value="1" selected>����</option>
            <option value="0">ȥ����</option>
          </select>
        </td>
      </tr>
      <tr style="display:none">
      	<td class="blue" width="20%"> 
          �ͻ���ַ��
        </td>
        <td  width="30%"> 
          <%=(String)custDoc.get(13)%>
        </td>
        <td class="blue" width="20%"> 
         ֤�����ͣ�
        </td>
        <td  width="30%"> 
          <%=(String)custDoc.get(15)%>
        </td>
      </tr>
      <tr style="display:none">
      	<td class="blue" width="20%"> 
          ֤�����룺
        </td>
        <td  width="30%"> 
          <%=(String)custDoc.get(16)%>
        </td>
         <td class="blue" width="20%"> 
          ҵ�����ͣ�
        </td>
        <td  width="30%"> 
          <%=(String)custDoc.get(4)%>
        </td>
      </tr>
      <tr style="display:none">
      	<td class="blue" width="20%"> 
          ��ǰԤ�棺
        </td>
        <td  width="30%"> 
          <%=(String)custDoc.get(20)%>
        </td>
        <td class="blue" width="20%"> 
          ��ǰǷ�ѣ�
        </td>
        <td  width="30%"> 
          <%=(String)custDoc.get(19)%>
        </td>
      </tr>
      <tr style="display:none">
      	<td class="blue" width="20%"> 
          �����ѣ�
        </td>
        <td  width="30%"> 
            <input type="text"  name="t_handFee" id="t_handFee" size="16"
value="<%=(((String)custDoc.get(30)).trim().equals(""))?("0"):(((String)custDoc.get(30)).trim()) %>" v_type=float v_name="������" <%if(hfrf){%>readonly<%}%> onblur="ChkHandFee()"  index="2">
          
        </td>
        <td class="blue" width="20%"> 
          ʵ�գ�
        </td>
        <td  width="30%"> 
            <input type="text"  name="t_factFee" id="t_factFee" size="16" value="0" index="3" 
v_type=float v_name="ʵ��" <%
                     if(hfrf)
                     {
				 if(((String)custDoc.get(30)).trim().equals("") || ((String)custDoc.get(30)).trim().equals("0")  || Double.parseDouble(((String)(custDoc.get(30))))==0)
				 {
		   %>
			   readonly
		  <%
				 }
			 }
		   %>
		   >
        </td>
      </tr>
      
      <tr style="display:none">
      	<td class="blue" width="20%"> 
          Ӧ�գ�
        </td>
        <td  width="30%" > 
            <input type="text"  name="ys_fewFee" id="ys_fewFee" size="16" readonly value="<%=((String)custDoc.get(30)).trim().equals("")?"0":((String)custDoc.get(30)).trim()%>">
        </td>
      	<td class="blue" width="20%"> 
          ���㣺
        </td>
        <td  width="3%"> 
            <input type="text"  name="t_fewFee" id="t_fewFee" size="16" readonly>
        </td>
      </tr>
      <tr style="display:none">
				<td class="blue" width="20%"> 
          ϵͳ��ע��
        </td>
        <td colspan="3"> 
            <input type="text"  name="t_sys_remark" id="t_sys_remark" size="60" readonly maxlength=30>
        </td>
      </tr>
      <tr style="display:none">
      	<td class="blue" width="20%"> 
          �û���ע��
        </td>
        <td colspan="3"> 
            <input type="text"  name="t_op_remark" id="t_op_remark" size="60" v_maxlength=60  v_type=string  v_name="�û���ע" maxlength=60 index="4">
        </td>
      </tr>
	  </table>
	  <table>
	   <tr>
			<td align=center colspan="4" id="footer">
				<!-- <input class="b_text"  name=back2 type=button onmouseup="assuWin();" onkeyup="if(event.keyCode==13)assuWin()" value="������¼��" index="5" style="display='none'"> -->
        <input  class="b_text" type="button" name="b_print" value="ȷ��" onmouseup="printCommit()" onkeyup="if(event.keyCode==13)printCommit()" index="6">
        <input class="b_text" " type="button" name="b_clear" value="�ر�" onClick="removeCurrentTab();" index="7">
        <input  class="b_text" type="button" name="b_back" value="����" onClick="location='s6236Login.jsp'" index="8">
			</td>
		</tr>
		</table>
	</div>
	  
	<%@ include file="/npage/include/footer.jsp" %>
	
	<input type="hidden" name="op_code" value="<%=opCode%>">
  <input type="hidden" name="region_code" value="<%=regionCode%>">
  <input type="hidden" name="srv_no" id="srv_no" value="<%=srv_no%>">
	<input type="hidden" name="cust_name" id="cust_name" value="<%=(String)custDoc.get(5)%>">
  <input type="hidden" name="cust_addr" id="cust_addr" value="<%=(String)custDoc.get(13)%>">
 	<input type="hidden" name="ic_no" id="ic_no" value="<%=(String)custDoc.get(16)%>">
	<input type="hidden" name="ReqPageName" id="ReqPageName" value="s6236Main">
	<input type="hidden" name="user_id" id="user_id" value="<%=(String)custDoc.get(0)%>">
 	<input type="hidden" name="oriHandFee" id="oriHandFee" value="<%=((String)custDoc.get(30)).trim().equals("")?"0":((String)custDoc.get(30)).trim()%>">
  <input type="hidden" name="oldPass" id="oldPass" value="<%=((String)custDoc.get(6)).trim()%>">
  <input type="hidden" name="assu_name" value="">
  <input type="hidden" name="assu_phone" value="">
  <input type="hidden" name="assu_idAddr" value="">
  <input type="hidden" name="assu_idIccid" value="">
  <input type="hidden" name="assu_conAddr" value="">
  <input type="hidden" name="assu_idType" value="">
	<input type="hidden" name="loginAccept" value="<%=sLoginAccept%>">
</form>
</body>
</html>
