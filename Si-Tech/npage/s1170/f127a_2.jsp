<%
/********************
* ����: ���ʷ�ԤԼȡ�� 127a || ���ʷѳ��� 127b
* version v3.0
* ������: si-tech
* update by qidp @ 2008-12-01
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%request.setCharacterEncoding("GBK");%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.CreatePlanerArray"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ page import="com.sitech.boss.util.*"%>
<%@ page import="org.apache.log4j.Logger"%>
<%@ include file="getMaxAccept.jsp" %>
<%
/*
 * ע����������������ҳ���ı����λ�õ��Ⱥ�˳�����һ���ı���Ϊi1���Դ����ơ�
 *		���ֱ������������ݶԴ˱���ʹ�õ����壬����;��
 */%>
<%
    String opCode = (String)request.getParameter("opCode");
	String opName = (String)request.getParameter("opName");
	System.out.println("-------opCode="+opCode+",opName="+opName);


    //�ڴ˴���ȡsession��Ϣ
    Logger logger = Logger.getLogger("f127a_2.jsp");
    ArrayList arr = (ArrayList)session.getAttribute("allArr");
    String aftertrim = ((String)session.getAttribute("powerRight")).trim();
    String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
    String result222[][]=new String[][]{};
    String result111[][]=new String[][]{};
    String strArray="var arrMsg; ";  //must


	/*
	 ****�õ���Ч��ʽ
	 ****127a:���Է�ԤԼȡ��  127b�����Էѳ���  1204:���ݿ�����  1206�������������ײͳ��� 126c:Ԥ���������� 126i:ǩԼ�������� 1207:�����������ײ�ȡ��
	*/

	String  tbselect = "0 24Сʱ֮����Ч";

	/****�õ���ӡ��ˮ****/
	String printAccept="";
	printAccept = getMaxAccept();
	System.out.println("---------ly-----------");
	System.out.println("printAccept="+printAccept);

	/****�õ���Чʱ��,���ڹ�����ӡ****/
	String exeDate="";
    exeDate = getExeDate(tbselect.substring(0,1),opCode);

    String[][] str1 = (String[][])arr.get(0);//��ȡ��½��Ϣ

	String goodbz="N";
	String bdbz = "N";
%>

<!----------------------------------ҳͷ��ʾ����----------------------------------------->

<%
	String work_no = (String)session.getAttribute("workNo");                                   //��ù�����Ϣ
	String phone = (String)request.getParameter("servno");                      //��ô����ֻ�����
	String iadd_str = ReqUtil.get(request,"iAddStr");
	String pw_favor = ReqUtil.get(request,"pw_favor");                //�����Ż�Ȩ�ޱ�־λ1:��0:��

	String ret_code = "";
	String ret_msg = "";

    String do_note = ReqUtil.get(request,"i222");
	String rowNum = "16";
	String getselect = ReqUtil.get(request,"select1");

	String[] paraAray1 = new String[4];
	String titleStr = "";

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
	String subi20="";
	String disCode="";
	String ibig_cust_ls="";
	String before_mode_code="",before_mode_code_name="";
	String ip="",iq="";
	String return_page="f1170Main.jsp";
	try
 	{
         paraAray1[0] = work_no;		/* ��������   */
         paraAray1[1] = phone; 	        /* �ֻ�����   */
         paraAray1[2] = opCode;
		 paraAray1[3] = "";	/* ����   */

         //retArray = impl.callFXService("s127aInit", paraAray1, "31","phone", phone);
%>
        <wtc:service name="s127aInit" routerKey="phone" routerValue="<%=phone%>" outnum="32" retcode="s1270GetMsgCode" retmsg="s1270GetMsgMsg">
            <wtc:param value="<%=paraAray1[0]%>"/>
            <wtc:param value="<%=paraAray1[1]%>"/>
            <wtc:param value="<%=paraAray1[2]%>"/>
            <wtc:param value="<%=paraAray1[3]%>"/>
    	</wtc:service>
    	<wtc:array id="retS127aInitArr"  scope="end"/>
<%
        String errCode = s1270GetMsgCode;
        String errMsg = s1270GetMsgMsg;
        if(errCode.equals("000000"))
        {
            ret_code = "000000";          // ���ش���
        }else
        {
            ret_code = errCode;
        }
        ret_msg = errMsg;			  // ��ʾ��Ϣ

        //�Է�����Ϣ�Ŀ���
        if(ret_msg.equals(""))
        {
            ret_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(ret_code));
            if( ret_msg.equals("null")){ret_msg ="δ֪������Ϣ";}
        }
        if(errCode.equals("000000"))
        {
            i2 = retS127aInitArr[0][2];				  // �û�ID
            i3 = retS127aInitArr[0][3];				  // �ͻ�����
            i4 = retS127aInitArr[0][4];				  // �ͻ�����
            i5 = retS127aInitArr[0][5];				  // �ͻ���ַ
            i6 = retS127aInitArr[0][6];				  // �ͻ�֤����������
            i7 = retS127aInitArr[0][7];				  // �ͻ�֤������
            i8 = retS127aInitArr[0][8];				  // ҵ��Ʒ��
            i9 = retS127aInitArr[0][9];				  // ҵ��Ʒ������
            i10 = retS127aInitArr[0][10];			  // �û�����״̬
            i11 = retS127aInitArr[0][11];			  // �û�����״̬����
            i12 = retS127aInitArr[0][12];			  // ��Ƿ��
            i13 = retS127aInitArr[0][13];			  // ��Ԥ���
            i14 = retS127aInitArr[0][14];			  // ��һǷ���ʺ�
            i15 = retS127aInitArr[0][15];			  // ��һǷ��
            i16 = retS127aInitArr[0][16];			  // ��ǰ���ײʹ���
            i17 = retS127aInitArr[0][17];			  // ��ǰ���ײ�����
            i18 = retS127aInitArr[0][18];			  // ��ǰ���ײͿ�ͨ��ˮ
            i19 = retS127aInitArr[0][19];			  // ������
            i20 = retS127aInitArr[0][20];              // belong_code
            i21 = retS127aInitArr[0][21];              // ��ͻ�����
            i22 = retS127aInitArr[0][22];              // ��ͻ���������
            i23 = retS127aInitArr[0][23];              // �������Żݴ���
            i24 = retS127aInitArr[0][24];              // ���ſͻ����
            i25 = retS127aInitArr[0][25];              // ���ſͻ��������
            i26 = retS127aInitArr[0][26];              // �������ʷ�            oNextMode
            i27 = retS127aInitArr[0][27];    		  // �������ʷ�����        oNextModeName
            i28 = retS127aInitArr[0][28];			  // �������ʷѿ�ͨ��ˮ    oNextModeAccept
            before_mode_code = retS127aInitArr[0][29];	// �ϸ����ײʹ���
            before_mode_code_name = retS127aInitArr[0][30];	// �ϸ����ײʹ�������
        }

        if(opCode.equals("127a"))
        {
        	System.out.println("------------------");
            titleStr = "���ʷ�ԤԼȡ��";
            return_page = "f1170Main.jsp";

            ip = i16;
            iq = i17;
            System.out.println("ip="+ip+",iq="+iq);
            System.out.println("------------------");
        }else if(opCode.equals("127b"))
        {
            titleStr = "���ʷѳ���";
            return_page = "s127b_1.jsp";
            ip = before_mode_code;
            iq = before_mode_code_name;
        }

        ibig_cust_ls = i21 + " " + i22;   //��ͻ���������ҳ����ʾ
        subi20 = i20.substring(0,2);
        disCode = i20.substring(2,4);

        //String[][] allNewSmInfo=(String[][])arr.get(5);
      //  sNewSmName=WtcUtil.getNewSm(((String[][])arr.get(0))[0][16].substring(0,2),i8,allNewSmInfo,"1");
        //System.out.println("----------ly--------"+allNewSmInfo);
    }
    catch(Exception e)
    {
        System.out.println("ҳ�淢���������£�");
        e.printStackTrace();
    }
    String sNewSmName=i8;
%>
<%
	//�����������
	String sqlStrgood = "select mode_dxpay "+
					 "from dgoodphoneres a, sGoodBillCfg b "+
					 "where a.bill_code = b.mode_code "+
					 " and b.region_code = '"+regionCode+"'"+
					 " and a.phone_no = '"+phone+
					 "' and b.valid_flag='Y' and a.bak_field='1' and end_time>sysdate and b.mode_dxpay>0";

	System.out.println(sqlStrgood);

%>

<wtc:pubselect name="sPubSelect"  retcode="retCodeNo2" retmsg="retMsgNo2" outnum="1">
 <wtc:sql><%=sqlStrgood%>
 </wtc:sql>
 </wtc:pubselect>
<wtc:array id="retarr" scope="end"/>
<%
	String modedxpay = "0";
	if(retarr.length!=0)
	{
		goodbz="Y";
		modedxpay = retarr[0][0];
		System.out.println("----ly----modedxpay="+modedxpay);
	}
	else
	{
		goodbz="N";
		modedxpay = "0";
	}

%>

<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE><%=titleStr%></TITLE>
</HEAD>
<%
    if(!ret_code.equals("000000")){%>
        <script language='jscript'>
            var ret_code = "<%=ret_code%>";
            var ret_msg = "<%=ret_msg%>";
            rdShowMessageDialog("��ѯ����<br>������룺'<%=ret_code%>'��<br>������Ϣ��'<%=ret_msg%>'��",0);
            <%if(opCode.equals("127a")){%>
                //document.location.replace("f1170Main.jsp");
                removeCurrentTab();
            <%}else if(opCode.equals("127b")){%>
                document.location.replace("<%=request.getContextPath()%>/npage/bill/f127b_1.jsp?activePhone=<%=phone%>");
            <%}%>
        </script>
<%  }%>

<body>
<FORM action="" method=post name="form1">
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
   <div id="title_zi">�û���¼</div>
</div>

<!--------------------------------�ڴ�Ƿ�׵ڶ�����------------------------------------>
    <TABLE border=0>
        <TR>
            <TD class="blue">�ƶ�����
            <TD >
            	<input type="hidden" name="phone" value="<%=phone%>">
                <input class="InputGrey" name="i1" value="<%=phone%>" size="20" maxlength=11 v_must=1 v_type=0_9 readonly>
            </TD>
            <TD class="blue">�ͻ�ID</TD>
            <TD>
            	<input type="hidden" name="id_no"  value="<%=i2%>" >
                <input class="InputGrey" name="i2" size="20"  value="<%=i2%>" maxlength=30  readonly >
            </TD>
        </TR>
        <TR>
            <TD class="blue">�ͻ�����</TD>
            <TD>
                <input class="InputGrey" name="i4" size="20" maxlength=30 value="<%=i4%>" readonly>
            </TD>
            <TD class="blue">�ͻ���ַ</TD>
            <TD>
                <input class="InputGrey" name="i5" size="30" maxlength=30 value="<%=i5%>" readonly>
            </TD>
        </TR>
        <TR>
            <TD class="blue">֤����������</TD>
            <TD>
                <input class="InputGrey" name="i6" size="20" maxlength=30 value="<%=i6%>" readonly>
            </TD>
            <TD class="blue">֤������</TD>
            <TD>
                <input class="InputGrey" name="i7" size="20" maxlength=30 value="<%=i7%>" readonly>
            </TD>
        </TR>
        <tr>
            <td nowrap class="blue">ҵ��Ʒ��</td>
            <td nowrap >
            	<%String add = i8+" "+i9;
            	  sNewSmName = add;	%>
            	<input class="InputGrey" type=text name="sNewSmName" value="<%=sNewSmName%>"
            	maxlength="15"/> </td>
           <!--
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <TR>
            <TD class="blue">ҵ������</TD>
            <TD>

                <input class="InputGrey" name="i8" size="20" maxlength=20 value="<%=add%>" readonly>
                <input type="hidden" name="i9" size="13" maxlength=20  readonly>
            </TD> -->
            <TD class="blue">����״̬</TD>
            <TD>
                <%String add1 = i10+" "+i11;%>
                <input class="InputGrey" name="i10" size="20" maxlength=2 value="<%=add1%>" readonly>
                <input type="hidden" name="i11" size="20" maxlength=20  readonly>
            </TD>
        </TR>
        <TR>
            <TD class="blue">δ���ʻ���</TD>
            <TD>
                <input class="InputGrey" name="i12" size="20" maxlength=2 value="<%=i12%>" readonly>
            </TD>
            <TD class="blue">����Ԥ��</TD>
            <TD>
                <input class="InputGrey" name="i13" size="20"maxlength=20 value="<%=i13%>" readonly>
            </TD>
        </TR>
        <TR>
            <TD class="blue">���ſͻ����</TD>
            <TD>
                <input class="InputGrey" name="group_type" size="20" value="<%=i24%> <%=i25%>" readonly>
            </TD>
            <TD class="blue">��ͻ����</TD>
            <TD>
                <input class="InputGrey" class="text_redFat" name="ibig_cust" size="20" value="<%=ibig_cust_ls%>"  maxlength=20  v_must=1 v_type=string readonly>
                <input type="hidden" name="ibig_cust_1" size="20" maxlength=20 value="<%=i21%>" readonly >
                <input type="hidden" name="ibig_cust_2" size="20" maxlength=20 value="<%=i22%>" readonly >
            </TD>
        </TR>
        <TR>
            <TD class="blue">��ǰ���ײ�</TD>
            <TD>
                <%String newModeCode = i16+" "+i17;%>
                <input class="InputGrey" name="i16" size="30" maxlength=20 value="<%=newModeCode%>" readonly>
                <input type="hidden" name="maincash" size="20"maxlength=20 value="<%=i16%>" readonly>
                <input type="hidden" name="newModeCode" value="<%=newModeCode%>">
            </TD>
            <TD class="blue">�������ײ�</TD>
            <TD>
            	<%String nextModeCode = i26+" "+i27;%>
            	<input type="hidden" name="nextModeCode" value="<%=nextModeCode%>">
                <input class="InputGrey" name="i18" size="30"maxlength=20 value="<%=nextModeCode%>" readonly>
            </TD>
        </TR>
        <TR>
            <TD class="blue">�������ײ�</TD>
            <TD id="ipTd">  <input class="InputGrey" name="i160" size="30" maxlength=20 value="<%=newModeCode%>" readonly>
           <!--     <input class="InputGrey" type="text" class="button" name="ip" size="8" value="<%=ip%>" readonly>
                <input class="InputGrey" type="text" class="button" name="iq" size="18" value="<%=iq%>" readonly>&nbsp;&nbsp;
			-->
                <!------------------------------------------------------------------->
                <input type="hidden" class="button" name="ip1" size="8" maxlength="8">
                <input type="hidden" class="button" name="iq1" size="8" maxlength="8">
                <input type="hidden" class="button" name="ip" size="8" maxlength="8" value="<%=ip%>">
                <input type="hidden" class="button" name="iq" size="8" maxlength="8"  value="<%=iq%>">
                <!--------------------------------------------------------------------->

            </TD>
            <td>&nbsp;</td>
            <td>&nbsp;</td>

        </TR>

<!------------------------------------------------------------------>
<input type="hidden" name="maincash_no" value="<%=i16%>">
<input type="hidden" name="belong_code" value="<%=i20%>">
<input type="hidden" name="do_string_add">
<input type="hidden" name="addcash_string">
<input type="hidden" name="toprintdata">
<input type="hidden" name="i19" size="20" maxlength=20 value="<%=i19%>">
<input type="hidden" name="i20" size="20" maxlength=20 value="<%=i19%>">
<input type="hidden" name="favorcode" size="20" maxlength=20 value="<%=i23%>">
<input class="button" type="hidden" name="imain_stream" size="20" maxlength=20 value="<%=i18%>" readonly>
<input type="hidden" name="next_main_stream" value="<%=i28%>">
<!------------------huhx add for ������Ʒ�ĸ��Ի���Ϣ--------->
<input type="hidden" name="iAddStr" value="<%=iadd_str%>">
<input type="hidden" name="iOpCode" value="<%=opCode%>">
<input type="hidden" name="beforeOpCode" value="1270"><!--����ʱ���Ͷ�Ӧ����ҵ���opCode-->
<input type="hidden" name="opCode" value="<%=opCode%>">
<input type="hidden" name="opName" value="<%=opName%>">
<input type="hidden" name="printAccept" value="<%=printAccept%>">
<input type="hidden" name="modestr">
<!-------------------------------------------------------------->
        <tr>
            <td nowrap colspan="4" id="footer">
                <div align="center">
                    <input class="b_foot" name=next type=button  onclick="printCommit()" value=����ȷ��>
                    <input class="b_foot" name=close  onClick="parent.removeTab('<%=opCode%>')" type=button value=�ر�>
                    <input class="b_foot" name=back  onClick="history.go(-1)" type=button value=����>
                </div>
            </td>
        </tr>
    </TABLE>
<!---------------------------������һ����Ƿ��------------------------------------------->
<%@ include file="/npage/include/footer.jsp" %>
</FORM>
</BODY>
</HTML>
<script language="javascript">

/*-------------------------ҳ���ύ��ת����----------------------------*/
function pageSubmit(flag){

    var maincash = document.all.maincash.value;//��ǰ���ײ�
    var i18 = document.all.i18.value.substring(0,8);//�������ײ�
    var ip = document.all.ip.value; //�������ײ�
    if(i18 == ip && ip == maincash)
    {
        rdShowMessageDialog('�������ײͲ����뵱ǰ���ײ�,�������ײ���ͬ!',0);
        document.all.ip.focus();
        return false;
    }
    if(i18 == ip && ip != maincash)
    {
        rdShowMessageDialog('�������ײͲ������������ײ���ͬ!',0);
        document.all.ip.focus();
        return false;
    }
 	if(flag==1){
    	document.form1.action="f1270_1.jsp";
        form1.submit();
	}
	if(flag==2)
	{
	    document.form1.action="f127a_3.jsp";
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
    var length = document.all.ip.value.length;
    /*
    if(length<8)
    {
        //alert("�������ײʹ��볤��Ӧ��Ϊ8λ��");
        rdShowMessageDialog('�������ײʹ��볤��Ӧ��Ϊ8λ��',0);
        document.all.ip.focus();//���ؽ���
        return false;
    }
    else
    {
        return true;
    }*/
	/* 20100101 Ҫ���Ƿſ�
	if(length<=0)
    {
        //alert("�������ײʹ��볤��Ӧ��Ϊ8λ��");
        rdShowMessageDialog('�������ײʹ��볤�Ȳ�Ӧ��Ϊ0��',0);
        document.all.ip.focus();//���ؽ���
        return false;
    }
    else
    {
        return true;
    }*/
    return true;
}
//���ʷ�ԤԼȡ��
function printInfo127a()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
     var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
	  var retInfo = "";
	  /********������Ϣ��**********/
      cust_info+="�ͻ�������" +document.all.i4.value+"|";
      cust_info+="�ֻ����룺"+document.all.phone.value+"|";
      cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
      cust_info+="֤�����룺"+document.all.i7.value+"|";

      /********������**********/
      opr_info+="�û�Ʒ��: "+"<%=sNewSmName%>" + "  *"+ "����ҵ��:���ʷ�ԤԼȡ��"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="������ˮ: "+"<%=printAccept%>" +"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
       <%}else{%>
       opr_info+="������ˮ: "+"<%=printAccept%>" +"|";
       <%}%>
      opr_info+="��ǰ���ʷѣ�"+"<%=newModeCode%>" +"|";
      opr_info+="ԤԼ���ʷѣ�"+"<%=nextModeCode%>"+"|";
      note_info1+="˵�����û��������ʷ�ԤԼȡ����ԤԼ�����ʷѽ�������Ч����ǰ���ʷѼ���ִ�С�"+"|";

	  /**********������*********/
      if(document.all.modestr.value.length>0){
      	  note_info1+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
     	  note_info1+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			note_info1+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
	  <%}%>
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}
function showPrtDlg(printType,DlgMessage,submitCfm)
{  //��ʾ��ӡ�Ի���
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	var pType="subprint";
	var billType="1";
	var printStr = printInfo127a(printType);

	var mode_code=null;
	var fav_code=null;
	var area_code=null;

	var sysAccept = "<%=printAccept%>";

	var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage;
	var path = path  + "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo=<%=phone%>&submitCfm=" + submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
	var ret=window.showModalDialog(path,printStr,prop);
	return ret;
}
function printCommit()
{
	//document.all.sure.disabled=true;
	//document.all.sysnote.value=document.all.i16.value.substring(0,8)+document.all.tbselect.value.substring(2)+document.all.ip.value.substring(0,8);//ϵͳ��ע

	var ret=showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
	var iReturn=0;
	if(typeof(ret)!="undefined")
	{
		if((ret=="confirm")){
			iReturn=showEvalConfirmDialog("ȷ�ϵ��������?");
	        pageSubmit(2);
      	}
    }
	if(ret=="continueSub")
	{
		iReturn=showEvalConfirmDialog("ȷ��Ҫ�ύ��Ϣ��?");
		pageSubmit(2);
		return true;
   }
}

</script>