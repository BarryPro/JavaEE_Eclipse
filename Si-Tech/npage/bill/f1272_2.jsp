<%
    /********************
     version v2.0
     ������: si-tech
     *
		 *update:zhanghonga@2008-08-26 ҳ�����,�޸���ʽ
		 *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
    /*
    * ����BOSS-�ײ�ʵ�֣���ѡ�ʷѱ��  2003-10  
    * @author  ghostlin
    * @version 1.0
    * @since   JDK 1.4
    * Copyright (c) 2002-2003 si-tech All rights reserved.
    */
%>
<%
    /*
    * ע����������������ҳ���ı����λ�õ��Ⱥ�˳�����һ���ı���Ϊi1���Դ����ơ�
            ���ֱ������������ݶԴ˱���ʹ�õ����壬����;��
    */
%>

<%
	String opCode = "1272";
	String opName = "��ѡ�ʷѱ��";
			
	String[][] favInfo = (String[][])session.getAttribute("favInfo");
	String kf_workno = (String)session.getAttribute("workNo");//��ÿͷ�����
	String kf_PhoneNo = (String)session.getAttribute("userPhoneNo");//��ÿͷ��ֻ�����
	String hdword_no = (String)session.getAttribute("workNo");//����
	String workNo = (String)session.getAttribute("workNo");
	String phone = WtcUtil.repNull(request.getParameter("i1"));
	String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0, 2);
	String loginNote = "";
	String sqlStr2 = "select back_char1 from snotecode where region_code='" + regionCode + "' and op_code='XXXX'";
%>
		<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phone%>"  retcode="retCode1" retmsg="retMsg1" outnum="1">
		<wtc:sql><%=sqlStr2%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result2" scope="end" />
<%
    for (int i = 0; i < result2.length; i++) {
        loginNote = (result2[i][0]).trim();
    }
    loginNote = loginNote.replaceAll("\"", "");
    loginNote = loginNote.replaceAll("\'", "");
    loginNote = loginNote.replaceAll("\r\n", "   ");
    loginNote = loginNote.replaceAll("\r", "   ");
    loginNote = loginNote.replaceAll("\n", "   ");
%>
<%
    String do_note = WtcUtil.repNull(request.getParameter("i222"));
    String work_no = hdword_no;                                    //��ù�����Ϣ
    String op = "1272";
    String ret_code = "";
    String ret_msg = "";
    String rowNum = "16";
    String thepassword = WtcUtil.repNull(request.getParameter("i2"));         //��ô����ļ�������
    String pw_favor = WtcUtil.repNull(request.getParameter("pw_favor"));             //�����Ż�Ȩ�ޱ�־λ1:��0:
    String getselect = WtcUtil.repNull(request.getParameter("select1"));
    String i1 = "";
    String i2 = "";
    String i3 = "";
    String i4 = "";
    String i5 = "";
    String i6 = "";
    String i7 = "";
    String i8 = "";
    String i9 = "";
    String i10 = "";
    String i11 = "";
    String i12 = "";
    String i13 = "";
    String i14 = "";
    String i15 = "";
    String i16 = "";
    String i17 = "";
    String i18 = "";
    String i19 = "";
    String i20 = "";
    String i21 = "";
    String i22 = "";
    String i23 = "";
    String i24 = "";
    String i25 = "";
    String i26 = "";
    String i27 = "";
    String i28 = "";
    String i29 = "";
    String i30 = "";
    String subi20 = "";
    String disCode = "";
    String ibig_cust_ls = "";
    
    String loginPswInput = (String)session.getAttribute("password");
%>
	<wtc:service name="s1270GetMsg" routerKey="phone" routerValue="<%=phone%>"  outnum="32" >
	<wtc:param value=""/>
  <wtc:param value="01"/>
  <wtc:param value="<%=op%>"/>
	<wtc:param value="<%=work_no%>"/>
	<wtc:param value="<%=loginPswInput%>"/>
	<wtc:param value="<%=phone%>"/>
	<wtc:param value="<%=thepassword%>"/>
	</wtc:service>
	<wtc:array id="result" scope="end"/>
<%
    //retArray = callView.s1270GetMsgProcess(work_no, phone, op, thepassword).getList();
		if(result!=null&&result.length>0){
	    ret_code = result[0][0];          // ���ش���                                 
	    ret_msg = result[0][1];              // ��ʾ��Ϣ  
	    //�Է�����Ϣ�Ŀ���
	    if (ret_msg.equals("")) {
	        ret_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(ret_code));
	        if (ret_msg.equals("null")) {
	            ret_msg = "δ֪������Ϣ";
	        }
	    }
	    i2 = result[0][2];                  // �û�ID          						  
	    i3 = result[0][3];                  // �ͻ�����        						  
	    i4 = result[0][4];                  // �ͻ�����        						  
	    i5 = result[0][5];                  // �ͻ���ַ        						  
	    i6 = result[0][6];                  // �ͻ�֤���������� 						  
	    i7 = result[0][7];                  // �ͻ�֤������     						  
	    i8 = result[0][8];                  // ҵ��Ʒ��        						  
	    i9 = result[0][9];                  // ҵ��Ʒ������     						  
	    i10 = result[0][10];              // �û�����״̬     						  
	    i11 = result[0][11];              // �û�����״̬���� 						  
	    i12 = result[0][12];              // ��Ƿ��          						  
	    i13 = result[0][13];              // ��Ԥ���        						  
	    i14 = result[0][14];              // ��һǷ���ʺ�     						  
	    i15 = result[0][15];              // ��һǷ��        						  
	    i16 = result[0][16];              // ��ǰ���ײʹ���       					  
	    i17 = result[0][17];              // ��ǰ���ײ�����     					  
	    i18 = result[0][18];              // ��ǰ���ײͿ�ͨ��ˮ 					  
	    i19 = result[0][19];              // ������          						  
	    i20 = result[0][20];              // belong_code  							  
	    i21 = result[0][21];              //��ͻ�����								  
	    i22 = result[0][22];              //��ͻ���������							  
	    i23 = result[0][23];              // �������Żݴ���        					  
	    i24 = result[0][24];              // ���ſͻ����           				  
	    i25 = result[0][25];              // ���ſͻ�������� 						  
	    i26 = result[0][26];              // �������ʷ�            oNextMode       	  
	    i27 = result[0][27];              // �������ʷ�����        oNextModeName   	  
	    i28 = result[0][28];              // �������ʷѿ�ͨ��ˮ    oNextModeAccept 	
		}      
    ibig_cust_ls = i21 + " " + i22;   //��ͻ���������ҳ����ʾ
    if(i20.length()>=3){
		    subi20 = i20.substring(0, 2);
		    disCode = i20.substring(2, 4);
    }
    System.out.println("#############here is right");
    /****�õ���ӡ��ˮ****/
    String printAccept = "";
%>
	<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="workno"  routerValue="<%=workNo%>" id="sLoginAccept"/>
<%
    printAccept = sLoginAccept;

/*****
    //�ڴ˶��û���������ж�
    if (pw_favor.equals("0"))//"0"˵���������Ż�Ȩ��,��Ҫ��������,"1"�������Ż�Ȩ�����ж�
    {
        //out.println("�������Ż�Ȩ��");
        thepassword = Encrypt.encrypt(thepassword);                //�ڴ˶��û�������������м���
        //out.println(thepassword);
        if (0 == Encrypt.checkpwd2(i3.trim(), thepassword.trim())) {                //�Ƚ��û��������ܵ�����ͷ���ȡ�����ܵ������Ƿ���ͬ
					//������벻��ȷ.dosomething
        }
    }
*****/

    if (!ret_code.equals("000000")) {%>
				<script language='jscript'>
				    var ret_code = "<%=ret_code%>";
				    var ret_msg = "<%=ret_msg%>";
				    rdShowMessageDialog("��ѯ����<br>������룺'<%=ret_code%>'��<br>������Ϣ��'<%=ret_msg%>'��");
				    parent.removeTab("<%=opCode%>");
				</script>
	<%
			return;
		}
	%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>��ѡ�ʷѱ��</TITLE>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<script language="javascript">
	<!--
		 /*****��ȡҳ��ʱ*****/
			onload = function(){
			    for (var i = 1; i < document.all.checkId.length; i++){
			        if (document.all.R11[i].value == "b"){
			            rdShowMessageDialog("��" + document.all.R0[i].value + "������Чʱ������ʷʱ���ͻ���������뵼�´˴β���ʧ�ܣ�");
			        }
			    }
			}
	
		/*******�򿪿�ѡ�ײ����*******/
		function openwindow(theNo, p, q) {
			var token = "|";
	    //���崰�ڲ���
	    var h = 600;
	    var w = 720;
	    var t = screen.availHeight - h - 20;
	    var l = screen.availWidth / 2 - w / 2;
	    var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no"
	    var belong_code = document.all.belong_code.value;
	    var maincash_no = document.all.maincash_no.value;
	    var cust_id = document.all.i2.value;
	    var minopen = "";// document.all.oMinOpen[theNo].value;
	    var maxopen = ""; //document.all.oMaxOpen[theNo].value;
	    if (typeof(document.all.oMinOpen.length) != "undefined") {
	        minopen = document.all.oMinOpen[theNo].value;
	        maxopen = document.all.oMaxOpen[theNo].value;
	    } else {
	        minopen = document.all.oMinOpen.value;
	        maxopen = document.all.oMaxOpen.value;
	    }
	    var ret_msg = window.showModalDialog("f1272_6.jsp?mode_type=" + p + "&belong_code=" + belong_code + "&maincash_no=" + codeChg(maincash_no) + "&cust_id=" + cust_id + "&mode_name=" + q + "&minopen=" + minopen + "&maxopen=" + maxopen, "", prop);
	    //var ret_code = "";
	    //window.open("f1272_6.jsp?mode_type=" + p + "&belong_code=" + belong_code + "&maincash_no=" + codeChg(maincash_no) + "&cust_id=" + cust_id + "&mode_name=" + q + "&minopen=" + minopen + "&maxopen=" + maxopen, "", prop);
	    var srcStr = ret_msg;
	
	    if (ret_msg == null) {
	        return false;
	    }
	    if (typeof(srcStr) != "undefined") {
	        tohidden(p);
	        getStr(srcStr, token);
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
	  str = str.replace(/\,/g, "%2C").replace(/\./g, "%2E").replace(/#/g, "%23").replace(/\\/g, "%2C"); // , . # \
	  return str;
	}
	
		function tohidden(s)// s ��ʾ �ײ����ͣ���openwindow ����
	{
	    var tmpTr = "";
	    for (var a = document.all('tr').rows.length - 2; a > 0; a--) {//ɾ����tr1��ʼ��Ϊ������
	        if (document.all.R8[a].value == s && document.all.R1[a].value == "N") {
	            if (document.all.R11[a].value.trim() == "0" || document.all.R11[a].value.trim() == "c") {//choice_flag0��cɾ��
	                document.all.tr.deleteRow(a + 1);
	            }
	        }
	    }
	    return true;
	}

	/***�Ȼ�ȡ����,�ٶ�̬��������**/
	function getStr(srcStr, token) {
    var field_num = 13;
    var i = 0;
    var inString = srcStr;
    var retInfo = "";
    var tmpPos = 0;
    var chPos;
    var valueStr;
    var retValue = "";

    var a0 = "";
    var a1 = "";
    var a2 = "";
    var a3 = "";
    var a4 = "";
    var a5 = "";
    var a6 = "";
    var a7 = "";
    var a8 = "";
    var a9 = "";
    var a10 = "";
    var a11 = "";
    var a12 = "";
    var a1Tmp = "";

    retInfo = inString;
    chPos = retInfo.indexOf(token);
    while (chPos > -1)
    {
        for (i = 0; i < field_num; i++)
        {
            valueStr = retInfo.substring(0, chPos);

            if (i == 0) a0 = valueStr;
            if (i == 1) a1 = valueStr;
            if (a1 == "Y")a1Tmp = "�ѿ�ͨ";
            if (a1 == "N")a1Tmp = "δ��ͨ";
            if (i == 2) a2 = valueStr;
            if (i == 3) a3 = valueStr;
            if (i == 4) a4 = valueStr;
            if (i == 5) a5 = valueStr;
            if (i == 6) a6 = valueStr;
            if (i == 7) a7 = valueStr;
            if (i == 8) a8 = valueStr;
            if (i == 9) a9 = valueStr;
            if (i == 10) a10 = valueStr;
            if (i == 11) a11 = valueStr;
            if (i == 12) a12 = valueStr;
            retInfo = retInfo.substring(chPos + 1);
            chPos = retInfo.indexOf(token);
            if (!(chPos > -1)) break;
        }
        insertTab(a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a1Tmp);
    	}
		}

		/***��̬������***/
		var dynTbIndex = 0;
		var token = "|";
		function insertTab(a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a1Tmp)
		{
		    var tr1 = tr.insertRow();
		    tr1.id = "tr" + dynTbIndex;
		    var divid = "div"+ dynTbIndex;
			td1 = tr1.insertCell();
			td2 = tr1.insertCell();
			td3 = tr1.insertCell();
			td4 = tr1.insertCell();
			td5 = tr1.insertCell();
			td6 = tr1.insertCell();
			td7 = tr1.insertCell();
			td8 = tr1.insertCell();
			td2.id="div"+dynTbIndex;		    
		    td1.innerHTML = '<div align="center"><input type="checkbox" name="checkId" checked></input></div>';
		    td2.innerHTML = '<div align="center"><a Href="#"  onClick="openhref(' + "'" + a7 + "'" + ')"><font color="#0000FF">' + a0 + '</a><input id=R0 type=hidden value=' + a0 + ' class=button size=10 readonly></input></div>';
		    td3.innerHTML = '<div align="center">' + a1Tmp + '<input id=R1 type=hidden value=' + a1 + ' class=button size=10 readonly></input></div>';
		    td4.innerHTML = '<div align="center">' + a2 + '<input id=R2 type=hidden value=' + a2 + ' class=button size=18 readonly></input></div>';
		    td5.innerHTML = '<div align="center">' + a3 + '<input id=R3 type=hidden value=' + a3 + ' class=button size=10 readonly></input></div>';
		    td6.innerHTML = '<div align="center">' + a4 + '<input id=R4 type=hidden value=' + a4 + ' class=button size=10 readonly></input></div>';
		    td7.innerHTML = '<div align="center">' + a5 + '<input id=R5 type=hidden value=' + a5 + ' class=button size=10 readonly></input></div>';
		    td8.innerHTML = '<div align="center">' + a6 + '<input id=R6 type=hidden value=' + a6 + ' class=button size=10 readonly><input id=R7 type=hidden value=' + a7 + ' class=button size=10 readonly><input id=R8 type=hidden value=' + a8 + ' class=button size=10 readonly><input id=R9 type=hidden value=' + a9 + ' class=button size=10 readonly><input id=R10 type=hidden value=' + a10 + ' class=button size=10 readonly><input id=R11 type=hidden value=' + a11 + ' class=button size=10 readonly></input><input name=R12 id="R12'+dynTbIndex+'" type=hidden size=10 readonly></input></div>';
		    $("#R12"+dynTbIndex).val(a12);   //Ϊ�˽������������Ϣ�еĻس����������ʾ��ȫ
		    getMidPrompt("10442",a7,divid);
		    dynTbIndex++;
		}
		
		/*******������У��*******/
		function checknum(obj1, obj2)
		{
		    var num2 = parseFloat(obj2.value);
		    var num1 = parseFloat(obj1.value);
		
		    if (num2 < num1)
		    {
		        var themsg = "'" + obj1.v_name + "'���ô���'" + obj2.value + "'���������룡";
		        rdShowMessageDialog(themsg);
		        obj1.focus();
		        return false;
		    }
		    return true;
		}
		
		
		/***********��֯��������һҳ����********/
		function senddata(){
		    var kx_code_bunch = "";                                     //��ѡ�ʷѴ��봮
		    var kx_habitus_bunch = "";                                   //��ѡ�Է�״̬��
		    var kx_operation_bunch = "";                                  //��ѡ�ײ͵���Ч��ʽ��
		    var kx_stream_bunch = "";                                     //��ѡ�ײ�ԭ��ͨ��ˮ��
		    var tempnm = "";												 //��ʱ��������
		    var kx_want = "";											 //��ӡ���������
		    var kx_cancle = "";											 //��ӡ��ȡ������
		    var kx_explan_bunch = "";									//��ѡ�ײ�����
		    var kx_running = "";											 //��ӡ�����п�ͨ����
		    var kx_want_chgrow = "0";								     //��ӡ���������,���б�־
		    var kx_cancle_chgrow = "0";									 //��ӡ��ȡ������,���б�־
		    var kx_running_chgrow = "0";									 //��ӡ�����п�ͨ����,���б�־
		    var modestr = "";
		    for (var i = 0; i < document.all.checkId.length; i++)
		    {
		        if (document.all.checkId[i].checked == false && document.all.R1[i].value == "Y") {
		            //rdShowMessageDialog(document.all.R7[i].value);
		            //rdShowMessageDialog(document.all.R0[i].value);
		            modestr = modestr + document.all.R7[i].value + "(" + document.all.R0[i].value + ")����";
		            document.all.modestr.value = modestr;
		        }
		        if (document.all.checkId[i].checked == true && document.all.R1[i].value == "N" || //����
		            document.all.checkId[i].checked == false && document.all.R1[i].value == "Y")//ȡ��
		        {
		            kx_code_bunch = kx_code_bunch + document.all.R7[i].value + "#"; //��ѡ�ʷѴ��봮
		            kx_habitus_bunch = kx_habitus_bunch + document.all.R1[i].value + "#";       //��ѡ�ʷ�״̬��
		            kx_operation_bunch = kx_operation_bunch + document.all.R9[i].value + "#";   //��ѡ�ײ͵���Ч��ʽ��
		            kx_stream_bunch = kx_stream_bunch + document.all.R10[i].value + "#";//��ѡ�ײ�ԭ��ͨ��ˮ��
		
		            //sunzx add @20071115
		            if (document.all.R12[i].value == "��������Ϣ") {
		                kx_explan_bunch = kx_explan_bunch;
							//��ѡ�ײ�����
							//alert("kx_explan_bunch="+kx_explan_bunch);
		            } else {
		                kx_explan_bunch = kx_explan_bunch + " " + document.all.R12[i].value;
		            }
								//sunzx add end
		
		            if (document.all.checkId[i].checked == true && document.all.R1[i].value == "N") //���п�ͨ���
		            {
		                //kx_want = kx_want +  " " + document.all.R0[i].value ;  //���봮
		                kx_want = kx_want + " (" + document.all.R7[i].value + "��" + document.all.R0[i].value + "��" + document.all.R5[i].value + ")";  //���봮
		                kx_want_chgrow = 1 * kx_want_chgrow + 1;
										//if(kx_want_chgrow==2) kx_want+="|";
		            }
		            if (document.all.checkId[i].checked == false && document.all.R1[i].value == "Y")//ȡ�����
		            {
		                //kx_cancle = kx_cancle +  " " + document.all.R0[i].value ;              //ȡ����
		                kx_cancle = kx_cancle + " (" + document.all.R7[i].value + "��" + document.all.R0[i].value + "��" + document.all.R5[i].value + ")";  //ȡ����
		                kx_cancle_chgrow = 1 * kx_cancle_chgrow + 1;
									//if(kx_cancle_chgrow==2) kx_cancle+="|";
		            }
		
		        }
		        if (document.all.checkId[i].checked == true)
		        {
		            kx_running = kx_running + " " + document.all.R0[i].value;     //���п�ͨ��
		            kx_running_chgrow = 1 * kx_running_chgrow + 1;
		            if (kx_running_chgrow == 3) kx_running += "|";
		        }
		    }
		
		    if (kx_want == "")kx_want = "��";
		    if (kx_cancle == "")kx_cancle = "��";
		    if (kx_running == "")kx_running = "��";
		    kx_want = "���������ѡ�ײͣ�" + kx_want + "|";
		    kx_cancle = "����ȡ����ѡ�ײͣ�" + kx_cancle + "|";
		    kx_running = "��ͨ��ѡ�ײͣ�" + kx_running + "|";
		
		    if (kx_code_bunch == "") {
		        rdShowMessageDialog('�����������ȡ��һ����ѡ�ײͣ�');
		        return false;
		    }
		    if (kx_habitus_bunch == "") {
		        kx_habitus_bunch = " #";
		    }
		    if (kx_operation_bunch == "") {
		        kx_operation_bunch = " #";
		    }
		    if (kx_stream_bunch == "") {
		        kx_stream_bunch = " #";
		    }
		
		    document.all.kx_code_bunch.value = kx_code_bunch;                        //��ѡ�ʷѴ��봮
		    document.all.kx_habitus_bunch.value = kx_habitus_bunch;                  //��ѡ�ʷ�״̬��
		    document.all.kx_operation_bunch.value = kx_operation_bunch;            //��ѡ�ײ͵���Ч��ʽ��
		    document.all.kx_stream_bunch.value = kx_stream_bunch;                  //��ѡ�ײ͵Ŀ�ͨ��ˮ��
		    document.all.kx_explan_bunch.value = kx_explan_bunch;						//��ѡ�ײ�����
		    document.all.kx_want.value = kx_want;                                  //��ӡ�������������-��
		    document.all.kx_cancle.value = kx_cancle;                              //��ӡ������ȡ������-��
		    document.all.kx_running.value = kx_running;                            //��ӡ�����п�ͨ���ײ�-��
		    return true;
		}
		
		
		/*****************�ж�ҵ���ײ��Ƿ���Բ���*****************/
		function checksel(){
    	with (document.all){
        for (j = 0; j < oTypeName.length; j++)
        {
            if (oTypeName[j].value != "")
            {
                oDefaultFlag[j].value = "N";
                oDefaultOpen[j].value = "N";
                oActualOpen[j].value = "0";
            }
        }
        for (var i = 1; i < checkId.length; i++)
        {
            if (R11[i].value == "b")
            {
                rdShowMessageDialog("��" + R0[i].value + "������Чʱ������ʷʱ���ͻ���������뵼�´˴β���ʧ�ܣ�");
                return false;
            }
            for (var j = 0; j < oTypeName.length; j++)
            {
                if (oTypeValue[j].value == R8[i].value)
                {
                    if (checkId[i].checked == true)
                    {
                        oActualOpen[j].value = 1 * oActualOpen[j].value + 1;
                    }
                    if (R11[i].value == "1" || R11[i].value == "a")
                    {
                        oDefaultFlag[j].value = "Y";
                        if (checkId[i].checked == true) oDefaultOpen[j].value = "Y";
                    }
                    break;
                }
            }
        }
        for (j = 0; j < oTypeName.length; j++)
        {
            if (Math.round(oActualOpen[j].value) < Math.round(oMinOpen[j].value) || Math.round(oActualOpen[j].value) > Math.round(oMaxOpen[j].value))
            {
                rdShowMessageDialog("��" + oTypeName[j].value + "�����ײ�ʵ�ʿ�ͨ" + oActualOpen[j].value + "��Ӧ��" + oMinOpen[j].value + "��" + oMaxOpen[j].value + "֮��");
                return false;
            }
            if (oDefaultFlag[j].value == "Y" && oDefaultOpen[j].value == "N")
            {
                rdShowMessageDialog("��ȷ�ϡ�" + oTypeName[j].value + "�����ѡ��ʽΪ��Ĭ�ϡ����ײ����ٿ�ͨһ��");
                return false;
            }
        }
        var tempflag = "0";
        var threeflag = "0";
        for (V = 0; V < R11.length; V++)
        {
            if (R11[V].value == "4")
            {
                tempflag = 1 * tempflag + 1;
            }//��ͳ����û�е���3�����ݣ����������һ���ж�
        }
        if (tempflag > 0)
        {
            for (m = 0; m < R11.length; m++)
            {
                if (R11[m].value == "4" && checkId[m].checked == true)
                {
                    threeflag = 1 * threeflag + 1;
                }
            }
            if (threeflag < 1)
            {
                rdShowMessageDialog("����'����ѡһ'�ײ����ٿ�ͨһ��");
                return false;
            }
        }
    }
    return true;
}
	//-->
</script>

</HEAD>
<!----------------------------------ҳͷ��ʾ����----------------------------------------->
<body>
<FORM action="" method=post name="form1">
<%@ include file="/npage/include/header.jsp" %>     	
		<div class="title">
			<div id="title_zi">�û���Ϣ</div>
		</div>
		<table cellspacing="0">
		    <tr>
		        <td class="blue" width="15%">�������
		        <td width="35%">
		        	<input name="i1" value="<%=phone%>" size="20" class="InputGrey" readonly>
		        </td>
		        <td class="blue" width="15%">�ͻ�ID</td>
		        <td>
		            <input name="i2" size="20" value="<%=i2%>" maxlength=30 class="InputGrey"  readonly>
		        </td>
		    </tr>
<tr>
    <td class="blue" width="15%">�ͻ�����</td>
    <td width="35%">
        <input name="i4" size="20" maxlength=30 value="<%=i4%>" class="InputGrey"  readonly>
    </td>
    <td class="blue">֤����������</td>
    <td>
    	<input name="i6" size="20" maxlength=30 value="<%=i6%>" class="InputGrey"  readonly>
    </td>
</tr>
<tr style="display:none">
    <td class="blue" width="15%">&nbsp;</td>
    <td>
        <input name="i5" size="40" type="hidden" maxlength=30 value="<%=i5%>" class="InputGrey"  readonly>
    </td>
    <td class="blue">&nbsp;</td>
    <td>
        <input name="i7" size="20" type="hidden" maxlength=30 value="<%=i7%>" class="InputGrey"  readonly>
    </td>
</tr>
<tr>
    <td class="blue">ҵ��Ʒ��</td>
    <td>
        <%String add = i8 + " " + i9;%>
        <input name="i8" size="20" maxlength=20 value="<%=add%>" class="InputGrey" readonly>
        <input type="hidden" name="i9" size="13" maxlength=20 readonly>
        <input type="hidden" name="cust_info">
        <input type="hidden" name="opr_info">
        <input type="hidden" name="note_info1">
        <input type="hidden" name="note_info2">
        <input type="hidden" name="note_info3">
        <input type="hidden" name="note_info4">
        <input type="hidden" name="printcount">
    </td>
    <td class="blue">����״̬</td>
    <td>
        <%String add1 = i10 + " " + i11;%>
        <input name="i10" size="20" maxlength=2 value="<%=add1%>" class="InputGrey" readonly>
        <input type="hidden" name="i11" size="20" maxlength=20 readonly>
    </td>
</tr>
<tr>
    <td class="blue">��Ƿ��</td>
    <td>
        <input name="i12" size="20" maxlength=2 value="<%=i12%>" class="InputGrey" readonly>
    </td>
    <td class="blue">��Ԥ���</td>
    <td>
        <input name="i13" size="20" maxlength=20 value="<%=i13%>" class="InputGrey" readonly>
    </td>
</tr>
<tr>
    <td class="blue">��ǰ���ײ�</td>
    <td>
        <%String add2 = i16+" "+i17;%>
        <input name="i16" size="30" maxlength=20 value="<%=add2%>" class="InputGrey" readonly>
        <input type="hidden" name="maincash" size="20" maxlength=20 value="<%=i16%>" readonly>
    <td class="blue">�������ײ�</td>
    <td>
        <input name="i18" size="30" maxlength=20 value="<%=i26%> <%=i27%>" class="InputGrey" readonly>
    </td>
    </td>
</tr>
<tr>
    <td class="blue">���ſͻ����</td>
    <td>
        <input name="group_type" size="20" value="<%=i24%> <%=i25%>" class="InputGrey" readonly>
    </td>
    <td class="blue">&nbsp;</td>
    <td>
    		<!--<input class="InputGrey" name="ibig_cust" size="20" value="<%=ibig_cust_ls%>" readonly>-->
        <font class="orange">&nbsp;</font>
        <input type="hidden" name="ibig_cust_1" size="20" maxlength=20 value="<%=i21%>" readonly>
        <input type="hidden" name="ibig_cust_2" size="20" maxlength=20 value="<%=i22%>" readonly>
    </td>
</tr>
<%
    String favorcode = i23;
    int m = 0;
    for (int p = 0; p < favInfo.length; p++) {//�Ż��ʷѴ���
        for (int q = 0; q < favInfo[p].length; q++) {
            if (favInfo[p][q].trim().equals(favorcode)) {
                ++m;
            }
        }
    }
%>

<tr>
    <%if (m != 0) {%>
    <td class="blue">������</td>
    <td colspan="3">
        <input name="i19" size="20" maxlength=20 value="<%=i19%>" v_must=1 v_name=������ v_type=float>
        <input type="hidden" name="i20" size="20" maxlength=20 value="<%=i19%>" readonly v_name=���������>
    </td>

    <%} else {%>
    <td class="blue">������</td>
    <td colspan="3">
        <input name="i19" size="20" maxlength=20 value="<%=i19%>" v_must=1 v_name=������ v_type=float  class="InputGrey" readonly>
        <input type="hidden" name="i20" size="20" maxlength=20 value="<%=i19%>" readonly v_name=���������>
    </td>
    <%}%>
</tr>
</table>
<table cellspacing="0">
<tr>
    <td class="blue" width="15%">��ѡ�ײ����</td>
    <td>
        <input type=hidden name=oActualOpen value="">
        <input type=hidden name=oDefaultFlag value="">
        <input type=hidden name=oDefaultOpen value="">
        <input type=hidden name=oTypeValue value="">
        <input type=hidden name=oTypeName value="">
        <input type=hidden name=oMinOpen value="0">
        <input type=hidden name=oMaxOpen value="100">
        <%
		            String sm_code = i8;
		            String sqlStr = "";
		            
                sqlStr = "select a.MODE_TYPE,a.TYPE_NAME,a.MIN_OPEN,a.MAX_OPEN  from sbillmodetype a,cBillBaDepend b,sBillModeCode c where a.region_code=b.region_code and a.region_code=c.region_code and b.region_code='" + i20.substring(0, 2) + "' and b.MODE_CODE='" + i16 + "' and b.add_mode=c.MODE_CODE and c.mode_type=a.mode_type and a.mode_flag='2'";
                if (sm_code.equals("gn") || sm_code.equals("hn") || sm_code.equals("dn") || sm_code.equals("d0") || sm_code.equals("cb") || sm_code.equals("z0")) {
                    sqlStr += " and a.sm_code in('gn','dn','zn')";
                }
                if (sm_code.equals("ip") || sm_code.equals("ww")) {
                    sqlStr += " and a.sm_code in('ip','ww')";
                }
                sqlStr += " and a.mode_type not in(select distinct mode_type from sAddModeType where active_flag='Y')";
                sqlStr += " group by a.MODE_TYPE,a.TYPE_NAME,a.MIN_OPEN,a.MAX_OPEN";
                System.out.println("sqlStr===" + sqlStr);
				%>
								<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=phone%>"  outnum="4">
								<wtc:sql><%=sqlStr%></wtc:sql>
								</wtc:pubselect>
								<wtc:array id="result_select" scope="end" />
				<%  
								int recordNum = result_select.length;
                for (int i = 0; i < recordNum; i++) {
                    out.println("<a Href='#' onClick='openwindow("
                            + i + "," + '"' + result_select[i][0] + '"' + "," + '"' + result_select[i][1] + '"' + ")'>" + result_select[i][0] + " " + result_select[i][1] + "</a>");
                    out.println("<input type=hidden name=oActualOpen value='0'>");    //ʵ�ʿ�ͨ���� 
                    out.println("<input type=hidden name=oDefaultFlag value='N'>");   //�Ƿ���Ĭ�����������
                    out.println("<input type=hidden name=oDefaultOpen value='N'>");   //�Ƿ�Ĭ�������Ƿ����һ������
                    out.println("<input type=hidden name=oTypeValue value=" + result_select[i][0] + ">");
                    out.println("<input type=hidden name=oTypeName value=" + result_select[i][1] + ">");
                    out.println("<input type=hidden name=oMinOpen  value=" + result_select[i][2].trim() + ">");
                    out.println("<input type=hidden name=oMaxOpen  value=" + result_select[i][3].trim() + ">");
                }
        %>
    </td>

</tr>
</TBODY>
</table>
</div>
<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">�ײ���Ϣ</div>
</div>
<table id=tr cellspacing="0" style="display=''">
<tr align="center">
    <th>ѡ��</th>
    <th>��ѡ�ײ�����</th>
    <th>״̬</th>
    <th>��ʼʱ��</th>
    <th>����ʱ��</th>
    <th>�ײ����</th>
    <th>��Ч��ʽ</th>
    <th>��ѡ��ʽ</th>
</tr>
<tr id="tr0" style="display:none" align="center">
    <td><input type="checkbox" name="checkId" id="checkId"></td>
    <td><input type="text" name="R0" value=""></td>
    <td><input type="text" name="R1" value=""></td>
    <td><input type="text" name="R2" value=""></td>
    <td><input type="text" name="R3" value=""></td>
    <td><input type="text" name="R4" value=""></td>
    <td><input type="text" name="R5" value=""></td>
    <td><input type="text" name="R6" value=""></td>
    <td>
  	  <input type="text" name="R7" value="">
      <input type="text" name="R8" value="">
      <input type="text" name="R9" value="">
      <input type="text" name="R10" value="">
      <input type="text" name="R11" value="">
      <input type="text" name="R12" value="">
    </td>
</tr>
<%
    if (ret_code.equals("000000")) {
        /******************************׼������s1272Must��������ѭ���б�******************************/
        //���巵�ؽ����
        String ret_code1 = "";
        String ret_msg1 = "";
        String icust_id = i2;                                                  //�ͻ�ID
        String iold_m_code = i16;                                    //�����ײʹ��루�ϣ�  
        String ibelong_code = i20;                                             //belong_code
        String iop_code = "1272";
%>
				<wtc:service name="s1272Must" routerKey="phone" routerValue="<%=phone%>"  outnum="14" >
				<wtc:param value="<%=icust_id%>"/>
				<wtc:param value="<%=iold_m_code%>"/>
				<wtc:param value="<%=ibelong_code%>"/>
				<wtc:param value="<%=iop_code%>"/>
				</wtc:service>
				<wtc:array id="result_must" start="0" length="2" scope="end"/>
				<wtc:array id="dataArr" start="2" length="12" scope="end"/>
<%
        //getList_must = callView.s1272MustProcess(icust_id, iold_m_code,ibelong_code, iop_code).getList();
				if(result_must!=null&&result_must.length>0){
		        ret_code1 = result_must[0][0];
		        ret_msg1 = result_must[0][1];
        }
        //�Է�����Ϣ�Ŀ���
        if (ret_msg1.equals("")) {
            ret_msg1 = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(ret_code1));
            if (ret_msg1.equals("null")) {
                ret_msg1 = "δ֪������Ϣ";
            }
        }
        
    if (!ret_code1.equals("000000")) {
 %>
			<script language='jscript'>
			    rdShowMessageDialog("��ѯ����<br>������룺'<%=ret_code1%>'��<br>������Ϣ��'<%=ret_msg1%>'��");
			    parent.removeTab("<%=opCode%>");
			</script>
<%
		}
%>
<%
    		String[][] data = new String[][]{};
        data = dataArr;
        for (int y = 0; y < data.length; y++) {
            String addstr = data[y][0] + "#" + data[y][1] + "#" + y;
%>
<tr id="tr<%=y+1%>" align="center">
    <%if (data[y][data[0].length - 1].equals("0") || data[y][data[0].length - 1].equals("1") || data[y][data[0].length - 1].equals("4")) {//Ĭ������%>
    <td><input type="checkbox" name="checkId" checked></td>

    <%
        }
        if (data[y][data[0].length - 1].equals("2")) {//������
    %>
    <td><input type="checkbox" name="checkId" checked
               onclick="if(document.all.checkId[<%=y%>+1].checked==false){
									 document.all.checkId[<%=y%>+1].checked=true;}
									 rdShowMessageDialog('�����룡');return false;"></td>

    <%
        }
        if (data[y][data[0].length - 1].equals("a")) {//Ĭ������������Чʱ������ʷʱ���ͻ����������
    %>
    <td><input type="checkbox" name="checkId"
               onclick="if(document.all.checkId[<%=y%>+1].checked==true){
									 document.all.checkId[<%=y%>+1].checked=false;}
									 rdShowMessageDialog('Ĭ������������Чʱ������ʷʱ���ͻ���������룡');return false;"></td>

    <%
        }
        if (data[y][data[0].length - 1].equals("b")) {//ǿ������������Чʱ������ʷʱ���ͻ����������
    %>
    <td><input type="checkbox" name="checkId"
               onclick="if(document.all.checkId[<%=y%>+1].checked==true){
									 document.all.checkId[<%=y%>+1].checked=false;}
									 rdShowMessageDialog('ǿ������������Чʱ������ʷʱ���ͻ���������룡');return false;"></td>

    <%
        }
        if (data[y][data[0].length - 1].equals("d")) {//ǿ��ȡ��
    %>
    <td><input type="checkbox" name="checkId"
               onclick="if(document.all.checkId[<%=y%>+1].checked==true){
									 document.all.checkId[<%=y%>+1].checked=false;}
									 rdShowMessageDialog('ǿ��ȡ���������룡');return false;"></td>
    <%
        }
        if (data[y][data[0].length - 1].equals("9")) {//����ȡ��
    %>
    <td><input type="checkbox" name="checkId" checked
               onclick="if(document.all.checkId[<%=y%>+1].checked==false){
									 document.all.checkId[<%=y%>+1].checked=true;}
									 rdShowMessageDialog('�����ѡ�ʷѣ��뵽����ҵ��������');return false;"></td>
    <%}%>
    <%
        for (int j = 0; j < data[0].length; j++) {
            String tbstr = "";

            if (j == 0) {
                tbstr = "<td><a Href='#' onClick='openhref(" + '"' + data[y][7].trim() + '"' + ")'>" +
                        data[y][j].trim() + "</a><input type='hidden' " +
                        " id='R" + j + "' name='R" + j + "' class='button' value='" +
                        (data[y][j]).trim() + "'readonly></td>";
            } else if (j == 1) {
                String habitus = "";
                if (data[y][j].trim().equals("Y")) habitus = "�ѿ�ͨ";
                if (data[y][j].trim().equals("N")) habitus = "δ��ͨ";
                tbstr = "<td>" + habitus + "<input type='hidden' " +
                        " id='R" + j + "' name='R" + j + "' class='button' value='" +
                        (data[y][j]).trim() + "'readonly></td>";
            } else if (j > 6) {
                tbstr = "<input type='hidden' " +
                        " id='R" + j + "' name='R" + j + "' class='button' value='" +
                        (data[y][j]).trim() + "'readonly>";
            } else {
                tbstr = "<td>" + data[y][j].trim() + "<input type='hidden' " +
                        " id='R" + j + "' name='R" + j + "' class='button' value='" +
                        (data[y][j]).trim() + "'readonly></td>";
            }
            out.println(tbstr);
    %>


    <%
        }
        ///R12
        out.println("<input type='hidden' id='R12' name='R12' class='button' value='' readonly>");
    %>
</tr>
<%
       }
    }
%>
</table>
</div>
<div id="Operation_Table"> 
<div class="title">
	<div id="title_zi">��ע��Ϣ</div>
</div>
<table cellspacing="0">
    <tr>
        <td class="blue" width="15%">ϵͳ��ע</td>
        <TD colspan="3">
            <input name="sysnote" size="100" maxlength="60" value="�û�<%=phone%>��ѡ�ʷѱ��">
        </td>
    </tr>
    <tr style='display:none'>
        <td class="blue" width="15%">�û���ע</td>
        <td>
            <input name="tonote" size="100" value="<%=WtcUtil.repNull(request.getParameter("do_note"))%>">
        </td>
    </tr>
</table>
<TABLE cellSpacing="0">
    <TBODY>
        <tr>
            <td id="footer">
                <input name=sure class="b_foot" type=button value="ȷ��&��ӡ" onclick="if(checknum(i19,i20)) if(senddata()) if(checksel()) if(check(form1)) printCommit();">
                <input name=close class="b_foot" onClick="removeCurrentTab()" type=button value=�ر�>
                <input name=back class="b_foot" onClick="history.go(-1)" type=button value=����>
            </td>
        </tr>
    </TBODY>
</table>
<!--����Ϊ����  �ͻ�ID ���ͻ���ַ��֤���������ƣ�֤�����룬belong_code,-->
<input type="hidden" name="flag_string">
<input type="hidden" name="stream" value="<%=printAccept%>">
<input type="hidden" name="handcash" value="<%=WtcUtil.repNull(request.getParameter("i19"))%>">
<input type="hidden" name="maincash_no" value="<%=i16%>">
<input type="hidden" name="belong_code" value="<%=i20%>">
<input type="hidden" name="do_string_add">
<input type="hidden" name="modestr">
<input type="hidden" name="addcash_string">
<input type="hidden" name="toprintdata">
<input type="hidden" name="add_stream_str">
<input type="hidden" name="kx_code_bunch"><!--��ѡ�ʷѴ��봮-->
<input type="hidden" name="kx_habitus_bunch"><!--��ѡ�ʷ�״̬��-->
<input type="hidden" name="kx_operation_bunch"><!--��ѡ�ײ͵���Ч��ʽ��-->
<input type="hidden" name="kx_stream_bunch"><!--ԭ��ѡ�ײ͵Ŀ�ͨ��ˮ��-->
<input type="hidden" name="kx_want"><!--��ӡ�������������--->
<input type="hidden" name="kx_cancle"><!--��ӡ������ȡ������--->
<input type="hidden" name="kx_running"><!--��ӡ�����п�ͨ���ײ�--->
<input type="hidden" name="kx_explan_bunch"><!--��ѡ�ײ�˵��-->
<input type="hidden" name="haseval">
<input type="hidden" name="evalcode">
<!----------------------------------------------------------------------->
<%@ include file="/npage/include/footer.jsp" %> 
</FORM>
  <frameset rows="0,0,0,0" cols="0" frameborder="no" border="0" framespacing="0" >
  <frame src="../common/evalControlFrame.jsp"    name="evalControlFrame" id="evalControlFrame" />
</frameset>
<noframes></noframes>
</BODY>
</HTML>

<script language="javascript">

	function conf(){
    var h = 200;
    var w = 300;
    var t = screen.availHeight - h - 20;
    var l = screen.availWidth / 2 - w / 2;

    /***********************��ӡ����Ĳ���**********************************/
    var phone = document.all.i1.value;								//�û��ֻ�����
    var date = '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>' + '<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>' + '<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>';	// ϵͳ����
    var name = document.all.i4.value;								//�û�����
    var address = document.all.i5.value;								//�û���ַ
    var cardno = document.all.i7.value;								//֤������
    var stream = document.all.stream.value;							//��ӡ��ˮ
    var kx_want = document.all.kx_want.value;				        //��ӡ�������������-��
    var kx_cancle = document.all.kx_cancle.value;                    //��ӡ������ȡ������-��
    var kx_running = document.all.kx_running.value;                  //��ӡ�����п�ͨ���ײ�-��
    var work_no = '<%=workNo%>';                                 //�õ�����
    var sysnote = "�û�<%=phone%>��ѡ�ʷѱ��";                                   //�õ���ӡ��ϵͳ��־
    var tonote = document.all.tonote.value;							//�õ���ӡ�Ĳ�����־
    /**********************��ӡ����Ĳ�����֯���****************************/

    var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no"
    var ret_value = window.showModalDialog("f1270_print.jsp?phone=" + phone + "&date=" + date + "&name=" + name + "&address=" + address + "&cardno=" + cardno + "&stream=" + stream + "&sysnote=" + sysnote + "&work_no=" + work_no + "&kx_want=" + kx_want + "&kx_cancle=" + kx_cancle + "&kx_running=" + kx_running + "&tonote=" + tonote, "", prop);                                //���ȷ�ϣ����ô�ӡҳ��
    ifretvalue = ret_value.substring(0, 4);
    if (ifretvalue == "true")
    {
        document.all.stream.value = ret_value.substring(4);//������ȡ������ˮ������ֵ���˱�ҵ�����ˮ��һֱ�����
        crmsubmit()                                        //�����ύȷ�Ϸ���
    }
	}
		function crmsubmit()
		{
		    if (rdShowConfirmDialog("�Ƿ��ύ�˴β�����") == 1)
		    {
		        form1.action = "f1272_3.jsp";
		        form1.submit();
		    }
		    else
		    {
		        canc()
		    }
		
		}

		function canc(){
		   document.all.sure.disabled = false;
		}
		
	/***********�ύ��ӡ����*************/
	function printCommit() {
	getAfterPrompt();
    document.all.sure.disabled = true;
    var len = document.all('tr').rows.length;
    if (len == 2) {
        rdShowMessageDialog('��ѡ���ѡ�ײͣ�');
        return false;
    }
    
    if(document.all.tonote.value.trim().len()==0){
    	document.all.tonote.value=document.all.sysnote.value.trim();
   	}
	
    var ret = showPrtDlg("Detail", "ȷʵҪ���е��������ӡ��", "Yes");
    var iReturn = 0;
    if (typeof(ret) != "undefined") {
        if ((ret == "confirm")) {
            iReturn = showEvalConfirmDialog('ȷ�ϵ��������');
            if (iReturn == 1 || 2 == iReturn) {
                if (2 == iReturn) {
                    var vEvalValue = GetEvalReq(1);
                    document.all.haseval.value = "1";
                    document.all.evalcode.value = vEvalValue;
                } else {
                    document.all.haseval.value = "0";
                    document.all.evalcode.value = "0";
                }

                document.all.printcount.value = "1";
                frmCfm();

            }
        }

        if (ret == "continueSub") {
            iReturn = showEvalConfirmDialog('ȷ��Ҫ�ύ��Ϣ��');
            if (iReturn == 1 || 2 == iReturn) {
                if (2 == iReturn) {
                    var vEvalValue = GetEvalReq(1);
                    document.all.haseval.value = "1";
                    document.all.evalcode.value = vEvalValue;
                } else {
                    document.all.haseval.value = "0";
                    document.all.evalcode.value = "0";
                }
                document.all.printcount.value = "0";
                frmCfm();
            }
        }
    } else {
        iRetrun = showEvalConfirmDialog('ȷ��Ҫ�ύ��Ϣ��');
        if (iRetrun == 1 || 2 == iReturn) {
            if (2 == iReturn) {
                var vEvalValue = GetEvalReq(1);
                document.all.haseval.value = "1";
                document.all.evalcode.value = vEvalValue;
            } else {
                document.all.haseval.value = "0";
                document.all.evalcode.value = "0";
            }
            document.all.printcount.value = "0";
            frmCfm();
        }
    }

    document.all.sure.disabled = false;
    return true;
	}


	/*********�����ύ����*********/
	function frmCfm() {
	    document.form1.action = "f1272_3.jsp";
	    form1.submit();
	    return true;
	}


	/*********�����ӡ����*********/
	function showPrtDlg(printType, DlgMessage, submitCfm)
	{  //��ʾ��ӡ�Ի��� 
	    var h = 210;
	    var w = 400;
	    var t = screen.availHeight / 2 - h / 2;
	    var l = screen.availWidth / 2 - w / 2;
	
	
	 var pType="subprint";              
	 var billType="1";              
	 var sysAccept="<%=printAccept.trim()%>";               
	 //var printStr = printInfo(printType); 
	 var kx_code="";
	for (var i = 0; i < document.all.checkId.length; i++){
		if (document.all.checkId[i].checked == true && document.all.R1[i].value == "N"){
			kx_code = kx_code + document.all.R7[i].value + "~";
		}
	}
	 //alert(kx_code);
	 var mode_code=codeChg(kx_code);  
	 //alert(mode_code);            
	 var fav_code=null;                 
	 var area_code=null;             
     	 var opCode="1272";                   
     	 var phoneNo=document.form1.i1.value;                  


	    var printStr = printInfo();
	    var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	    var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage + "&submitCfm=" + submitCfm;
	    path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	    var ret = window.showModalDialog(path, printStr, prop);
	    return ret;
	}

	/*********�����ӡ�������õĴ�ӡ����*********/
	function printInfo(){
    var retInfo = "";
    var cust_info = "";
    var opr_info = "";
    var note_info1 = "";
    var note_info2 = "";
    var note_info3 = "";
    var note_info4 = "";
    cust_info += "�ͻ�������" + document.form1.i4.value + "|";
    cust_info += "�ֻ����룺" + document.form1.i1.value + "|";
    /*cust_info += "�ͻ���ַ��" + document.form1.i5.value + "|";
    cust_info += "֤�����룺" + document.form1.i7.value + "|";*/

    opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "   " + "�û�Ʒ�ƣ�" + "<%=i9.trim()%>" + "|";
    if (document.all.kx_want.value == "���������ѡ�ײͣ�15ԪIP�Ż����|")
    {
        opr_info += "ҵ������:��ѡ�ײͽ���17951 IP��;�Ż������15������" + "  " + "��ˮ:" + "<%=printAccept.trim()%>" + "|";
    } else if (document.all.kx_cancle.value == "����ȡ����ѡ�ײͣ� 15ԪIP�Ż����|")
    {
        opr_info += "ҵ������:��ѡ�ײͽ���17951 IP��;�Ż������15��ȡ��" + "  " + "��ˮ:" + "<%=printAccept.trim()%>" + "|";
    } else
    {
        opr_info += "ҵ������:��ѡ�ʷѱ��" + "  " + "��ˮ:" + "<%=printAccept.trim()%>" + "|";
    }


    if ((document.all.kx_want.value == "���������ѡ�ײͣ� 15ԪIP�Ż����|") || (document.all.kx_cancle.value == "����ȡ����ѡ�ײͣ� 15ԪIP�Ż����|"))
    {
        note_info1 += "IP�����Ż��������ʹ�÷�15Ԫ��������������ܵ�������168����" + "|";
        note_info1 += "��17951���ڳ�;IPͨ���ѣ��������֣�����������ȡ��" + "|";
        note_info1 += "�°��£�16����������û������·�����ȡ7.5Ԫ������84���ӵ�" + "|";
        note_info1 += "17951���ڳ�;IPͨ���ѣ��������֣�����������ȡ��" + "|";
        note_info1 += "��ҵ�������룬������Ч��ȡ����������Ч��" + "|";
        note_info1 += "��Э����Ч�������������ʷѱ�׼�������������µ��ʷ�����ִ�С�" + "|";

    } else {
        opr_info += "" + codeChg(document.all.kx_want.value);//�����ʷ�
        opr_info += "" + codeChg(document.all.kx_cancle.value);//ȡ���ʷ�
    }
    note_info2 += " " + "|";
    note_info2 += "��ע:" + document.all.tonote.value + "|";
	  
	  //sunzx add @ 20071115
    if (document.all.kx_explan_bunch.value.trim().len() == 0) {

    } else {
        note_info3 += " " + "|";
        note_info3 += "��ѡ�ʷ�������" + "|";
        note_info3 += codeChg(document.all.kx_explan_bunch.value) + "|";
    }
  	  //sunzx add end


    // if(document.all.modestr.value.length>0){
    // retInfo+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
    // }else{

    //}
    document.all.cust_info.value = cust_info + "#";
    document.all.opr_info.value = opr_info + "#";
    document.all.note_info1.value = note_info1 + "#";
    document.all.note_info2.value = note_info2 + "#";
    document.all.note_info3.value = note_info3 + "#";
    document.all.note_info4.value = note_info4 + "#";
    retInfo = document.all.cust_info.value + " " + "|" + "---------------------------------------------" + "|" + " " + "|" + document.all.opr_info.value + " " + "|" + " " + "|" + document.all.note_info1.value + document.all.note_info2.value + document.all.note_info3.value + document.all.note_info4.value + " " + "|" + " " + "|" + " " + "|" + " " + "|" + "<%=loginNote.trim()%>" + "#";
    //retInfo=cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
	}
	/***************************MengQK add end*****************************/

	/***************�ж��Ƿ�����Чʱ������ʷʱ���ͻ����������Ĵ�������************/
	function openhref(p)
	{
	    var h = 600;
	    var w = 550;
	    var t = screen.availHeight - h - 20;
	    var l = screen.availWidth / 2 - w / 2;
	    var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" ;
	    var region_code = '<%=subi20%>';
	    var ret_code = window.showModalDialog("f1270m_detail.jsp?mode_code=" + p + "&region_code=" + region_code, "", prop);
	}
</script>
