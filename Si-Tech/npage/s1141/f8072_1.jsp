 <%
	/********************
	 version v2.0
	������: si-tech
	update:anln@2009-02-16 ҳ�����,�޸���ʽ
	********************/
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=Gb2312"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="/npage/bill/getMaxAccept.jsp" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%		
	  String opCode = "8072";	
	  String opName = "���˰���ǩԼ����";	//header.jsp��Ҫ�Ĳ���  
	  
	  String regionCode = (String)session.getAttribute("regCode");
	  String loginNo =(String)session.getAttribute("workNo");  
	  String loginName = (String)session.getAttribute("workName");
	  String child_code = "010194";
 
  
%>
<%
	String retFlag="",retMsg=""; 
  	String[] paraAray1 = new String[4];
  	String phoneNo = request.getParameter("srv_no");
  	String opcode = request.getParameter("opcode");
  	String passwordFromSer="";
  	String back_accept = "";
  	String op_name = "";
  	String disable_type = "";
	if(opcode.equals("8072")){
		  back_accept = "0";
		  op_name = "����";
		  disable_type ="";
	}else{
		  back_accept = request.getParameter("backaccept");
		  op_name = "����";
		  disable_type ="disabled";		
	}
	  
	  paraAray1[0] = phoneNo;		/* �ֻ�����   */ 
	  paraAray1[1] = opcode; 	    /* ��������   */
	  paraAray1[2] = loginNo;	    /* ��������   */
	  paraAray1[3] = back_accept;	    /* ������ˮ   */

	  for(int i=0; i<paraAray1.length; i++)
	  {		
		if( paraAray1[i] == null )
		{
		  paraAray1[i] = "";
		  
		}
	  }
	
  	//retList = impl.callFXService("s8072Init", paraAray1, "18","phone",phoneNo);
  %>
  	<wtc:service name="s8072Init" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode1" retmsg="retMsg1" outnum="18" >
		<wtc:param value="<%=paraAray1[0]%>"/>
		<wtc:param value="<%=paraAray1[1]%>"/>
		<wtc:param value="<%=paraAray1[2]%>"/>
		<wtc:param value="<%=paraAray1[3]%>"/>		
	</wtc:service>	
	<wtc:array id="tempArr"  scope="end"/>	
  <%
  	String  bp_name="",bp_add="",cardId_type="",cardId_no="",sm_code="",region_name="",run_name="",posint="",prepay_fee="",
  	vContactPhone="",vContactPost="",vResCode="",vResName="", vPrepayFee="",vLogicCode="";
  	//String[][] tempArr= new String[][]{};
  	String  errCode = retCode1;
  	String errMsg = retMsg1;
  if(tempArr == null)
  {
	if(!retFlag.equals("1"))
	{
	   System.out.println("retFlag="+retFlag);
	   retFlag = "1";
	   retMsg = "s8072Init��ѯ���������ϢΪ��!<br>errCode: " + errCode + "<br>errMsg+" + errMsg;
    }    
  }
  else
  {
  	System.out.println("errCode="+errCode);
  	System.out.println("errMsg="+errMsg);
	if(!errCode.equals("000000")){%>
		<script language="JavaScript">
			rdShowMessageDialog("������룺<%=errCode%>��������Ϣ��<%=errMsg%>",0);
			history.go(-1);
		</script>
	<%}
	else
	{
	  //tempArr = (String[][])retList.get(2);
	  if(tempArr.length>0){
		    bp_name = tempArr[0][2];//��������
		    System.out.println(bp_name);			
		    bp_add = tempArr[0][3];//�ͻ���ַ		
		    cardId_type = tempArr[0][4];//֤������		
		    cardId_no = tempArr[0][5];//֤������		
		    sm_code = tempArr[0][6];//ҵ��Ʒ��		
		    region_name = tempArr[0][7];//������		
		    run_name = tempArr[0][8];//��ǰ״̬		
		    posint = tempArr[0][9];//��ǰ����		
		    prepay_fee = tempArr[0][10];//����Ԥ��		
		    vContactPhone = tempArr[0][11];//��ϵ�绰	
		    vContactPost = tempArr[0][12];//�����ʱ�		
		    vResCode = tempArr[0][13];//res_code
			System.out.println(vResCode);		
		    vResName = tempArr[0][0];//res_name
			System.out.println(vResName);	 		 
		    vPrepayFee = tempArr[0][15];//���ѵ�Ԥ��
		    System.out.println(vPrepayFee);	 		 
		    vLogicCode = tempArr[0][16];//�ȼ�����
		    System.out.println(vLogicCode);	 		 
		    passwordFromSer = tempArr[0][17];  //����
	 }
	}
  }

%>
	<%
	//******************�õ�����������***************************//
	String printAccept="";
	printAccept = getMaxAccept();
	System.out.println(printAccept);		  
       //�ֻ�Ʒ��
	 
	%>

<html>
<head>
<title>���˰���ǩԼ����</title>
<script type="text/javascript" src="/npage/s3000/js/S3000.js"></script>
<script language="JavaScript" src="/npage/s1400/pub.js"></script>
	<%if(retFlag.equals("1")){%>
		<script language=javascript>
	    		rdShowMessageDialog("<%=retMsg%>");
	   	 	history.go(-1);
	   	</script>
	  <%}%>
	 <script language=javascript>
		<!-- 
		  onload=function()
		  {	
			 init();  	 
		  }  
				
		  //����Ӧ��ȫ�ֵı���
		  var SUCC_CODE	= "0";   		//�Լ�Ӧ�ó�����
		  var ERROR_CODE  = "1";			//�Լ�Ӧ�ó�����
		  var YE_SUCC_CODE = "0000";		//����Ӫҵϵͳ������޸�
		
		  var oprType_Add = "a";
		  var oprType_Upd = "u";
		  var oprType_Del = "d";
		  var oprType_Qry = "q";
		
		  var arrPhoneType = new Array();//�ֻ��ͺŴ���
		  var arrPhoneName = new Array();//�ֻ��ͺ�����
		  var arrAgentCode = new Array();//�����̴���
		  var selectStatus = 0;
		  
		  var arrsalecode =new Array();
		  var arrsaleName=new Array();
		  var arrsalePrice=new Array();
		  var arrsaleLimit=new Array();
		  var arrsaletype=new Array();
		
		  //***
		  function frmCfm()
		  {
		 	frm.submit();
			return true;
		  }
		 //***
		
		function init()
		{
			if("<%=opcode%>"=="8073")
			{
				document.frm.logic_code.value="<%=vLogicCode%>";
				document.frm.res_code.value="<%=vResCode%>";
				document.frm.out_prepay_fee.value="<%=vPrepayFee%>";
		
			}
		}
		 
		 function printCommit()
		 { 
		 	getAfterPrompt();
		  //У��
		  //if(!check(frm)) return false;
		    with(document.frm){
		    if("<%=opcode%>"=="8072"){
				if(logic_code.value==""){
					rdShowMessageDialog("��ѡ���н��ȼ�!");
					logic_code.focus();
					confirm.disabled=true;
					return false;
				}
				if(res_code.value==""){
					rdShowMessageDialog("��ѡ��Ʒ����!");
					res_code.focus();
					confirm.disabled=true;
					return false;
				}
			
				if(parseFloat(prepay_fee.value)<parseFloat(out_prepay_fee.value)){
					rdShowMessageDialog("Ԥ���С�����ѽ�����������ҵ��!");
					confirm.disabled=true;
					return false;
				}
			}
		  }
		 //��ӡ�������ύ��
		  var ret = showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes"); 
		  if(typeof(ret)!="undefined")
		  {
		    if((ret=="confirm"))
		    {
		      if(rdShowConfirmDialog('ȷ�ϵ��������')==1)
		      {
			    frmCfm();
		      }
			}
			if(ret=="continueSub")
			{
		      if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
		      {
			    frmCfm();
		      }
			}
		  }
		  else
		  {
		     if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1)
		     {
			   frmCfm();
		     }
		  }
		  return true;
		}
		
	       function showPrtDlg(printType,DlgMessage,submitCfm)
		  {  	//��ʾ��ӡ�Ի��� 
		  	
		  	var pType="subprint";                     // ��ӡ����print ��ӡ subprint �ϲ���ӡ
	     	var billType="1";                      //  Ʊ������1���������2��Ʊ��3�վ�
			var sysAccept ="<%=printAccept%>";                       // ��ˮ��
			var printStr = printInfo(printType);   //����printinfo()���صĴ�ӡ����
			var mode_code=null;                        //�ʷѴ���
			var fav_code=null;                         //�ط�����
			var area_code=null;                    //С������
			var opCode =   "<%=opCode%>";                         //��������
			var phoneNo = <%=phoneNo%>;                           //�ͻ��绰		  
	  
			var h=210;
			var w=400;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;

		     
		    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no" 	   
		   	var path= "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm;
			var path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
			var ret=window.showModalDialog(path,printStr,prop);     	
		  }
		
		function printInfo(printType)
		{
		 	vUnitId="",vUnitName="",vUnitAddr="",vUnitZip="",vServiceNo="",vServiceName="",vContactPhone="",vContactPost="";
			var pay = document.all.out_prepay_fee.value;
			
		  
			/*var retInfo = "";
			retInfo+='<%=loginNo%>'+' '+'<%=loginName%>'+"|";
			retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			retInfo+="�ƶ��绰���룺"+document.all.phone_no.value+"|";
			retInfo+="�ͻ����ƣ�"+document.all.cust_name.value+"|";
			retInfo+="��ϵ�绰:"+'<%=vContactPhone%>'+"|";
			retInfo+="סլ��ַ��"+document.all.cust_addr.value+"|";	
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+="ҵ�����ࣺ���˰������ǩԼ����--<%=op_name%>"+"|";
		  	retInfo+="ҵ����ˮ��"+document.all.login_accept.value+"|";
		  	retInfo+="�н��ȼ�: "+document.all.logic_code[document.all.logic_code.selectedIndex].text+"|";
			retInfo+="��Ʒ���ƣ�"+document.all.res_code[document.all.res_code.selectedIndex].text+"|";
		 	retInfo+="Ԥ�滰��"+parseInt(document.all.out_prepay_fee.value)+"Ԫ"+"|";
			retInfo+="ҵ��ִ��ʱ��:"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd ", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
			retInfo+=" "+"|";
		    	return retInfo;	*/
		    	
	    	var cust_info=""; //�ͻ���Ϣ
      	    var opr_info=""; //������Ϣ
      		var retInfo = "";  //��ӡ����
      		var note_info1=""; //��ע1
      		var note_info2=""; //��ע2
      		var note_info3=""; //��ע3
      		var note_info4=""; //��ע4 
      		
      		cust_info+="�ͻ�������"+document.all.cust_name.value+"|";
  			cust_info+="�ֻ����룺"+document.all.phone_no.value+"|";
  			cust_info+="�ͻ���ַ��"+document.all.cust_addr.value+"|";
  				
  			opr_info+="��ϵ�˵绰��"+'<%=vContactPhone%>'+"|";
      		opr_info+="ҵ�����ࣺ���˰������ǩԼ����--<%=op_name%>"+"|";
		  	opr_info+="ҵ����ˮ��"+document.all.login_accept.value+"|";
		  	opr_info+="�н��ȼ���"+document.all.logic_code[document.all.logic_code.selectedIndex].text+"|";
			opr_info+="��Ʒ���ƣ�"+document.all.res_code[document.all.res_code.selectedIndex].text+"|";
		 	opr_info+="Ԥ�滰�ѣ�"+parseInt(document.all.out_prepay_fee.value)+"Ԫ"+"|";
			opr_info+="ҵ��ִ��ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd ", Locale.getDefault()).format(new java.util.Date())%>'+"|";
			
			note_info1+="��ע��"+"|";
		    			    	
			retInfo= strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  	      	retInfo=retInfo.replace(new RegExp("#","gm"),"%23"); //�ѡ�#"�滻Ϊurl��ʽ
    	    return retInfo;		
		    	
		}
		var change_flag = "";//����RPC����ȫ�ֱ��� ��ѯ�ȼ�:flag_grade  ��ѯ��Ʒ:flag_res Ĭ��:""
		
		function chagePrepayFee()
		{
			var logic_code=document.frm.logic_code.value;
		
			switch(logic_code){
				case '01' :
					document.frm.out_prepay_fee.value="10000";
					break;
				case '02':
					document.frm.out_prepay_fee.value="8000";
					break;
				case '03':
					document.frm.out_prepay_fee.value="5000";
					break;
				case '04':
					document.frm.out_prepay_fee.value="2000";
					break;
				case '05':
					document.frm.out_prepay_fee.value="1200";
					break;
				case '06':
					document.frm.out_prepay_fee.value="800";
					break;
				case '07':
					document.frm.out_prepay_fee.value="500";
					break;
				default :
					document.frm.out_prepay_fee.value="0";
			}
			change_flag = "flag_res";
			var myPacket = new AJAXPacket("resCode_rpc.jsp","���ڻ�ý�Ʒ������Ϣ�����Ժ�......");
			var sqlStr = "select a.res_code,b.res_name from dbgiftrun.sChnActiveGradeCfg a, dbgiftrun.schngiftrescode b ,dbgiftrun.sChnActiveGrade c ,dbgiftrun.schnresactivecode d where a.res_code =b.res_code and a.grade_code=c.grade_code and c.active_code=d.active_code  and c.grade_logic_code='"+logic_code+"' and d.child_code='<%=child_code%>'";
			myPacket.data.add("sqlStr",sqlStr);
			core.ajax.sendPacket(myPacket);
			myPacket=null;
					
		}
		function doProcess(packet)
		{
			var retCode = packet.data.findValueByName("retCode");
		    	var retMsg = packet.data.findValueByName("retMsg");
			var retResult = packet.data.findValueByName("retResult");
			var rpc_page=packet.data.findValueByName("rpc_page");
			var triListData = packet.data.findValueByName("tri_list"); 
		  	var triList=new Array(triListData.length);
		   	if(change_flag == "flag_res")
				{
					triList[0]="res_code";
					document.all("res_code").length=0;
					document.all("res_code").options.length=triListData.length+1;//triListData[i].length;
					for(j=0;j<triListData.length;j++)
					{
						document.all("res_code").options[j+1].text=triListData[j][1];
						document.all("res_code").options[j+1].value=triListData[j][0];
					}//��Ʒ����
				}
		}
		
		//-->
	</script>
</head>


<body>
<form name="frm" method="post" action="f8072Cfm.jsp" onKeyUp="chgFocus(frm)" >
	<%@ include file="/npage/include/header.jsp" %>     	
	<div class="title">
		<div id="title_zi">���˰���ǩԼ����</div>
	</div>	
        <table  cellspacing="0" >
	 <tr> 
            <td class="blue">��������</td>
            <td colspan="3">���˰���ǩԼ����--<%=op_name%></td>           
          </tr>     
            
	  <tr> 
            <td class="blue">�ͻ�����</td>
            <td>
		<input name="cust_name" value="<%=bp_name%>" type="text"  v_must=1 readonly class="InputGrey" id="cust_name" maxlength="20"> 
            </td>
            <td class="blue">�ͻ���ַ</td>
            <td>
		<input name="cust_addr" value="<%=bp_add%>" type="text"  v_must=1 readonly class="InputGrey" id="cust_addr" maxlength="20" > 
            </td>
         </tr>
         
         <tr> 
            <td class="blue">֤������</td>
            <td>
		<input name="cardId_type" value="<%=cardId_type%>" type="text"  v_must=1 readonly class="InputGrey" id="cardId_type" maxlength="20" > 
            </td>
            <td class="blue">֤������</td>
            <td>
		<input name="cardId_no" value="<%=cardId_no%>" type="text"  v_must=1 readonly class="InputGrey" id="cardId_no" maxlength="20" > 
            </td>
         </tr>
         
         <tr> 
            <td class="blue">ҵ��Ʒ��</td>
            <td>
		<input name="sm_code" value="<%=sm_code%>" type="text"  v_must=1 readonly class="InputGrey" id="sm_code" maxlength="20" > 
            </td>
            <td class="blue">����״̬</td>
            <td>
		<input name="run_type" value="<%=run_name%>" type="text"  v_must=1 readonly class="InputGrey" id="run_type" maxlength="20" > 
            </td>
        </tr>
        
        <tr> 
            <td class="blue">����Ԥ��</td>
            <td>
		<input name="prepay_fee" value="<%=prepay_fee%>" type="text"  v_must=1 readonly class="InputGrey" id="prepay_fee" maxlength="20" > 
            </td>
	    <td class="blue">�û�����</td>
	    <td>
		<input name="region_name" value="<%=region_name%>" type="text"  v_must=1 readonly class="InputGrey" id="region_name" maxlength="20" > 
	    </td>
	</tr>
	
	<tr>
	   <td class="blue">�н��ȼ�</td>
	   <td>	
			<select size=1 name="logic_code" id="logic_code" v_must=1  onchange="chagePrepayFee()" <%=disable_type%> >
			  <option value ="">--��ѡ��--</option>
			  <option value ="01">һ�Ƚ� </option>
			  <option value ="02">���Ƚ� </option>
			  <option value ="03">���Ƚ� </option>
			  <option value ="04">�ĵȽ� </option>
			  <option value ="05">��Ƚ� </option>
			  <option value ="06">���Ƚ� </option>
			  <option value ="07">�ߵȽ� </option>
              		</select>
			<font class="orange">*</font>
	  </td>
	 
	 <td class="blue">���ѽ��</td>
	 <td>
		<input name="out_prepay_fee" value="0" type="text"  v_must=1 readonly class="InputGrey" id="out_prepay_fee" maxlength="5" > Ԫ
	 </td>
       </tr>
       
       <tr>
		<td class="blue">��Ʒ����</td>
		  <td colspan="3">
			<select name="res_code"   <%=disable_type%> >
			<%
                 try
                 {
                      //ArrayList retArray1 = new ArrayList();
                     // String[][] result1 = new String[][]{};
                      //S1100View callView1 = new S1100View();                    
                      
                      String sqlStr1 = "select a.res_code,b.res_name from dbgiftrun.sChnActiveGradeCfg a, dbgiftrun.schngiftrescode b  ,dbgiftrun.sChnActiveGrade c ,dbgiftrun.schnresactivecode d where a.res_code =b.res_code and a.grade_code=c.grade_code and c.active_code=d.active_code and d.child_code='"+child_code+"'"  ;
                      System.out.println("sqlStr1="+sqlStr1);
                      //retArray1 = callView1.view_spubqry32("2",sqlStr1);
                       %>
                     	<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode2" retmsg="retMsg2" outnum="2">
				<wtc:sql><%=sqlStr1%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result1" scope="end" />
                     <%
                      //result1 = (String[][])retArray1.get(0);
                      int recordNum1 = result1.length;      		
                      for(int i=0;i<recordNum1;i++)
                      {
                        out.println("<option class='button' value='" + result1[i][0] + "'>" + result1[i][1] + "</option>");
                      }
                 }catch(Exception e){
                      
				 }          
			%>
	        </select>             
		  </td>		  
	</tr>
	
	<tr> 
            <td class="blue">��ע</td>
            <td colspan="3" >
             <input name="opNote" type="text"  readonly class="InputGrey" id="opNote" size="60" maxlength="60" value="���˰���ǩԼ����" > 
            </td>
       </tr>
       </table>
       
       <table  cellspacing="0" >
          <tr> 
            <td id="footer"> 
                <input name="confirm" class="b_foot_long" type="button"  index="2" value="ȷ��&��ӡ" onClick="printCommit()">
                &nbsp; 
                <input name="reset" class="b_foot"  type="reset"  value="���" >
                &nbsp; 
                <input name="back" class="b_foot" onClick="history.go(-1);" type="button"  value="����">
                &nbsp; 
            </td>
          </tr>
        </table>
 
    	<input type="hidden" name="phone_no" value="<%=phoneNo%>">
    	<input type="hidden" name="work_no" value="<%=loginName%>">
	<input type="hidden" name="opcode" value="<%=opcode%>">
    	<input type="hidden" name="login_accept" value="<%=printAccept%>">
	<input type="hidden" name="child_code" value="<%=child_code%>">  
	<input type="hidden" name="back_accept" value="<%=back_accept%>">
	<input type="hidden" name="logic_code_back" value="<%=vLogicCode%>">
	<input type="hidden" name="res_code_back" value="<%=vResCode%>">
	
	<%@ include file="/npage/include/footer.jsp" %>    

</form>
</body>
</html>