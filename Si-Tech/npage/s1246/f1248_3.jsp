<%
/********************
 * version v2.0
 * ������: si-tech
 * update by qidp @ 2009-01-09
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%request.setCharacterEncoding("GBK");%>
<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.*" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
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
<%
    String opCode = "1248";
    String opName = "HLR��Ϣ��ѯ";
    String phoneNo = (String)request.getParameter("i1");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>������BOSS-���ػ�����HLR��Ϣ��ѯ</TITLE>
</HEAD>
<body>
<FORM action="" method=post name="form1"> 
<%@ include file="/npage/include/header.jsp" %>
<div class="title">
	<div id="title_zi">�û���Ϣ</div>
</div>
<%@ include file="head_1248.jsp"%>

<TABLE cellSpacing=0>
<% 
    //S1270View  callView = new S1270View();
    /*
    System.out.println("result_1[0]=["+result_1[0]+"]");
    System.out.println("oret_code=["+oret_code+"]");
    System.out.println(retArray.size());
    */
%>
    <TR> 
        <TD class="blue">�������</TD>
        <TD colspan="3">
            <input class="InputGrey" name="i1" value="<%=ReqUtil.get(request,"i1")%>" size="20"  readonly>
        </TD>
    </TR>
    <TR> 
        <TD class="blue">�ͻ�����</TD>
        <TD>
            <input class="InputGrey" name="ocust_name" size="20"  value="<%=ReqUtil.get(request,"ocust_name")%>" readonly >
        </TD>
        <TD class="blue">�ͻ�סַ</TD>
        <TD>
            <input class="InputGrey" name="ocust_addr" size="20"  value="<%=ReqUtil.get(request,"ocust_addr")%>" readonly>
        </TD>
    </TR>
    <TR> 
        <TD class="blue">֤������</TD>
        <TD>
            <input class="InputGrey" name="oid_type" value="<%=ReqUtil.get(request,"oid_type")%>" size="20" readonly>
        </TD>
        <TD class="blue">֤������</TD>
        <TD>
            <input class="InputGrey" name="oid_iccid" size="20"  value="<%=ReqUtil.get(request,"oid_iccid")%>"   readonly >
        </TD>
    </TR>
    <TR> 
        <TD class="blue">״̬����</TD>
        <TD>
            <input class="InputGrey" name="orun_code" size="20"  value="<%=ReqUtil.get(request,"orun_code")%>" readonly>
        </TD>
        <TD class="blue">״̬����</TD>
        <TD>
            <input class="InputGrey" name="orun_name" size="20"  value="<%=ReqUtil.get(request,"orun_name")%>" readonly>
        </TD>
    </TR>
    <TR> 
        <TD class="blue">HLR����</TD>
        <TD>
            <input class="InputGrey" name="ohlr_code" value="<%=ReqUtil.get(request,"ohlr_code")%>" size="20" readonly>
        </TD>
        <TD class="blue">HLR��Ϣ</TD>
        <TD>
            <input class="InputGrey" name="ohlr_name" size="20"  value="<%=ReqUtil.get(request,"ohlr_name")%>"   readonly >
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
	if(result_favor.length > 0)
       {
          hand_fee = result_favor[0][0];
          favor_code = result_favor[0][1];
       }
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
                <input type="hidden" name="ishould_fee" size="20"maxlength=20 value="<%=hand_fee%>" readonly>
            </TD>
            <script language="jscript">
                document.all.ohand_cash.focus();
            </script>
        <%}else{%>
        
            <TD width="34%" colspan="4">
                <input type="hidden" name="ohand_cash" size="20" maxlength=20 value="<%=hand_fee%>" readonly>
                <input type="hidden" name="ishould_fee" size="20" maxlength=20 value="<%=hand_fee%>" readonly>
            </TD>
        <%}%>
    </TR>
    <TR>
        <TD class="blue" colspan=4>HLR��Ϣ����</TD>
    </TR>
<!--------------------------------------------����HLR��Ϣ��ѯ����------------------------------------->
<%      
    //ArrayList retArray = new ArrayList();
	//ArrayList getList = new ArrayList();
//    String[][] result = new String[][]{};
	//String [] result_1 = new String [2];
/*--------------------------------��֯s1246Cfm�Ĵ������-------------------------------*/
    String ilogin_accept = ReqUtil.get(request,"stream");             //ϵͳ��ˮ
    String iop_Code ="1248";                                          //��������					 
    String iwork_no = (String)session.getAttribute("workNo");         //��������                  
    String iwork_pwd = (String)session.getAttribute("password");      //��������						 
    String iorg_code = (String)session.getAttribute("orgCode");       //org_code 
    String icust_id = ReqUtil.get(request,"cust_id");                 //�ͻ�ID
    String ihlr_code = ReqUtil.get(request,"hlr_code");               //HLR����
    String ishould_fee = ReqUtil.get(request,"ishould_fee");          //Ӧ��������
    String ireal_fee = ReqUtil.get(request,"ohand_cash");             //ʵ��������
    String isys_note = ReqUtil.get(request,"sysnote");                //ϵͳ��ע					 
    String ido_note = ReqUtil.get(request,"donote");                  //������ע
    String ithe_ip = (String)session.getAttribute("ipAddr");          //��½IP		
    String iphone_no = ReqUtil.get(request,"i1");					  //�ֻ�����
    String ret_code = "";
    String ret_msg = "";
    String login_accept="";                                           //��ˮ
    String str_hlr_code="";                                           //HLR���봮

    if(ireal_fee.equals(""))
        ireal_fee = "0";
    if(ishould_fee.equals(""))
        ishould_fee = "0";
    float handcash = Float.parseFloat(ireal_fee);                    //�����ѵ�����
/*--------------------------------��ʼ����s1248Cfm--------------------------------*/			                        
try{
    /*
    retArray = callView.s1248CfmProcess(ilogin_accept,iop_Code,
                                        iwork_no,iwork_pwd,
                                        iorg_code,icust_id,
                                        ihlr_code,ishould_fee,
                                        ireal_fee,isys_note,
                                        ido_note,ithe_ip,iphone_no).getList();
     */
%>
    <wtc:service name="s1248Cfm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="s1248CfmCode" retmsg="s1248CfmMsg" outnum="2" >
    	<wtc:param value="<%=ilogin_accept%>"/>
    	<wtc:param value="<%=iop_Code%>"/> 
        <wtc:param value="<%=iwork_no%>"/>
        <wtc:param value="<%=iwork_pwd%>"/>
        <wtc:param value="<%=iorg_code%>"/>
        
        <wtc:param value="<%=icust_id%>"/>
        <wtc:param value="<%=ihlr_code%>"/>
        <wtc:param value="<%=ishould_fee%>"/>
        <wtc:param value="<%=ireal_fee%>"/>
        <wtc:param value="<%=isys_note%>"/>
        
        <wtc:param value="<%=ido_note%>"/>
        <wtc:param value="<%=ithe_ip%>"/>
        <wtc:param value="<%=iphone_no%>"/>
    </wtc:service>
    <wtc:array id="s1248CfmArr" scope="end"/>
<%

    ret_code = s1248CfmCode;
    ret_msg  = s1248CfmMsg;
    if(s1248CfmArr.length > 0 && s1248CfmCode.equals("000000"))
    {

      String[][]  result = s1248CfmArr;   //ȡ�������

    }
        
}
catch(Exception e){
      e.printStackTrace() ;
	  //System.err.println("***********call service is failed****************"+e.getMessage());

}

				

if(ret_msg.equals(""))
{
    ret_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(ret_code));
    if( ret_msg.equals("null"))
	{
	    ret_msg ="δ֪������Ϣ";
	}
}
	/*System.out.println("in page ret_code="+ret_code);
    System.out.println("in page ret_msg="+ret_msg);  
    //response.data.add("str_hlr_code",'<%=str_hlr_code
	System.out.println("str_hlr_code="+str_hlr_code);
	int hlrlength = str_hlr_code.length();
	*/
%>
<%
if(!ret_code.equals("000000")){%>

<script language="javascript">
	 var ret_code = "<%=ret_code%>";
      var ret_msg = "<%=ret_msg%>";
      rdShowMessageDialog("��ѯ����<br>������룺"+ret_code+"��<br>������Ϣ��"+ret_msg+"��",0);
      document.location.replace("<%=request.getContextPath()%>/npage/s1246/f1248_1.jsp?activePhone=<%=iphone_no%>");
</script>

<%}
String phone_no = "";
String imsi="";
String otoll = "";
String oroam = "";
String ono_out = "";
String ono_in = "";
String oconfine_out = "";
String oconfine_in = "";
String omsm_send = "";
String omsm_receive = "";
String odiversion = "";
String obusy_div = "";
String ono_con_ans = "";
String ocan_no_ans = "";
String ocall_bide = "";
String ocall_keep = "";
String othird_call = "";
String ofax = "";
String odata_comm = "";
String ophone_dis = "";
String omain_hidden = "";
String ogprs = "";
String ovisa = "";


if(ret_code.equals("000000")&&str_hlr_code.length()>0){
    phone_no = str_hlr_code.substring(0,11);//��ȡǰ11λ�õ�---�ֻ�����
    str_hlr_code = str_hlr_code.substring(11);
    imsi = str_hlr_code.substring(0,15);//��ȡ�ӵ�12λ����26λ---imsi����
    str_hlr_code = str_hlr_code.substring(15);
    otoll = str_hlr_code.substring(0,1);//��ȡ��27λ---��;��ʽ
    if(otoll.equals("1"))otoll="����";
    if(otoll.equals("2"))otoll="����";
    oroam = str_hlr_code.substring(1,2);//��ȡ��28λ---���η�ʽ
    if(oroam.equals("1"))oroam="����";
    if(oroam.equals("2"))oroam="����";
    if(oroam.equals("3"))oroam="ʡ��";
    if(oroam.equals("4"))oroam="����";
    if(oroam.equals("5"))oroam="����";
    ono_out = str_hlr_code.substring(2,3);//��ȡ��29λ---Ƿ�ѽ�ֹ����
    if(ono_out.equals("y"))ono_out="��";
    if(ono_out.equals("n"))ono_out="��";
    ono_in = str_hlr_code.substring(3,4);//��ȡ��30λ---Ƿ�ѽ�ֹ����
    if(ono_in.equals("y"))ono_in="��";
    if(ono_in.equals("n"))ono_in="��";
    oconfine_out = str_hlr_code.substring(4,5);//��ȡ��31λ---��������
    if(oconfine_out.equals("y"))oconfine_out="��";
    if(oconfine_out.equals("n"))oconfine_out="��";
    oconfine_in = str_hlr_code.substring(5,6);//��ȡ��32λ---��������
    if(oconfine_in.equals("y"))oconfine_in="��";
    if(oconfine_in.equals("n"))oconfine_in="��";
    omsm_send = str_hlr_code.substring(6,7);//��ȡ��33λ---���ŷ���
    if(omsm_send.equals("y"))omsm_send="��";
    if(omsm_send.equals("n"))omsm_send="��";
    omsm_receive = str_hlr_code.substring(7,8);//��ȡ��34λ---���Ž���
    if(omsm_receive.equals("y"))omsm_receive="��";
    if(omsm_receive.equals("n"))omsm_receive="��";
    odiversion = str_hlr_code.substring(8,9);//��ȡ��35λ---��������ת
    if(odiversion.equals("y"))odiversion="��";
    if(odiversion.equals("n"))odiversion="��";
    obusy_div = str_hlr_code.substring(9,10);//��ȡ��36λ---��æת��
    if(obusy_div.equals("y"))obusy_div="��";
    if(obusy_div.equals("n"))obusy_div="��";
    ono_con_ans = str_hlr_code.substring(10,11);//��ȡ��37λ---��Ӧ��ת��
    if(ono_con_ans.equals("y"))ono_con_ans="��";
    if(ono_con_ans.equals("n"))ono_con_ans="��";
    
    ocan_no_ans = str_hlr_code.substring(11,12);//��ȡ��38λ---���ɼ�ת��
    if(ocan_no_ans.equals("y"))ocan_no_ans="��";
    if(ocan_no_ans.equals("n"))ocan_no_ans="��";
    
    ocall_bide = str_hlr_code.substring(12,13);//��ȡ��39λ---���еȴ�
    if(ocall_bide.equals("y"))ocall_bide="��";
    if(ocall_bide.equals("n"))ocall_bide="��";
    ocall_keep = str_hlr_code.substring(13,14);//��ȡ��40λ---���б���
    if(ocall_keep.equals("y"))ocall_keep="��";
    if(ocall_keep.equals("n"))ocall_keep="��";
    othird_call = str_hlr_code.substring(14,15);//��ȡ��41λ---����ͨ��
    if(othird_call.equals("y"))othird_call="��";
    if(othird_call.equals("n"))othird_call="��";
    ofax = str_hlr_code.substring(15,16);//��ȡ��42λ---����
    if(ofax.equals("y"))ofax="��";
    if(ofax.equals("n"))ofax="��";
    odata_comm = str_hlr_code.substring(16,17);//��ȡ��43λ---����ͨ��
    if(odata_comm.equals("y"))odata_comm="��";
    if(odata_comm.equals("n"))odata_comm="��";
    ophone_dis = str_hlr_code.substring(17,18);//��ȡ��44λ---������ʾ
    if(ophone_dis.equals("y"))ophone_dis="��";
    if(ophone_dis.equals("n"))ophone_dis="��";
    omain_hidden = str_hlr_code.substring(18,19);//��ȡ��45λ---��������
    if(omain_hidden.equals("y"))omain_hidden="��";
    if(omain_hidden.equals("n"))omain_hidden="��";
    ogprs = str_hlr_code.substring(19,20);//��ȡ��46λ---gprs
    if(ogprs.equals("y"))ogprs="��";
    if(ogprs.equals("n"))ogprs="��";
    ovisa = str_hlr_code.substring(20,21);//��ȡ��47λ---ǩԼ�û�
    if(ovisa.equals("y"))ovisa="��";
    if(ovisa.equals("n"))ovisa="��";
}
%>
    <TR> 
        <TD class="blue">�ֻ�����</TD>
        <TD>
            <input class="InputGrey" name="ophone_no" size="20"  value="<%=phone_no%>" readonly>
        </TD>
        <TD class="blue">imis��</TD>
        <TD>
            <input class="InputGrey" name="oimis_no" size="20"  value="<%=imsi%>" readonly>
        </TD>
    </TR>
    <TR>
        <TD class="blue">��;��ʽ</TD>
        <TD>
            <input class="InputGrey" name="otoll" size="20"  value="<%=otoll%>" readonly>
        </TD>
        <TD class="blue">���η�ʽ</TD>
        <TD>
            <input class="InputGrey" name="oroam" size="20"  value="<%=oroam%>" readonly>
        </TD>
    </TR>
    <TR> 
        <TD class="blue">Ƿ�ѽ�ֹ����</TD>
        <TD>
            <input class="InputGrey" name="ono_out" size="20"  value="<%=ono_out%>" readonly>
        </TD>
        <TD class="blue">Ƿ�ѽ�ֹ����</TD>
        <TD>
            <input class="InputGrey" name="ono_in" size="20"  value="<%=ono_in%>" readonly>
        </TD>
    </TR>
    <TR> 
        <TD class="blue">��������</TD>
        <TD>
            <input class="InputGrey" name="oconfine_out" size="20"  value="<%=oconfine_out%>" readonly>
        </TD>
        <TD class="blue">��������</TD>
        <TD>
            <input class="InputGrey" name="oconfine_in" size="20"  value="<%=oconfine_in%>" readonly>
        </TD>
    </TR>
    <TR> 
        <TD class="blue">���ŷ���</TD>
        <TD>
            <input class="InputGrey" name="omsm_send" size="20"  value="<%=omsm_send%>" readonly>
        </TD>
        <TD class="blue">���Ž���</TD>
        <TD>
            <input class="InputGrey" name="omsm_receive" size="20"  value="<%=omsm_receive%>" readonly>
        </TD>
    </TR>
    <TR> 
        <TD class="blue">��������ת</TD>
        <TD>
            <input class="InputGrey" name="odiversion" size="20"  value="<%=odiversion%>" readonly>
        </TD>
        <TD class="blue">��æת��</TD>
        <TD>
            <input class="InputGrey" name="obusy_div" size="20"  value="<%=obusy_div%>" readonly>
        </TD>
    </TR>
    <TR> 
        <TD class="blue">��Ӧ��ת��</TD>
        <TD>
            <input class="InputGrey" name="ono_con_ans" size="20"  value="<%=ono_con_ans%>" readonly>
        </TD>
        <TD class="blue">���ɼ�ת��</TD>
        <TD>
            <input class="InputGrey" name="ocan_no_ans" size="20"  value="<%=ocan_no_ans%>" readonly>
        </TD>
    </TR>
    <TR> 
        <TD class="blue">���еȴ�</TD>
        <TD>
            <input class="InputGrey" name="ocall_bide" size="20"  value="<%=ocall_bide%>" readonly>
        </TD>
        <TD class="blue">���б���</TD>
        <TD>
            <input class="InputGrey" name="ocall_keep" size="20"  value="<%=ocall_keep%>" readonly>
        </TD>
    </TR>
    <TR> 
        <TD class="blue">����ͨ��</TD>
        <TD>
            <input class="InputGrey" name="othird_call" size="20"  value="<%=othird_call%>" readonly>
        </TD>
        <TD  class="blue">����</TD>
        <TD>
            <input class="InputGrey" name="ofax" size="20"  value="<%=ofax%>" readonly>
        </TD>
    </TR>
    <TR> 
        <TD class="blue">����ͨ��</TD>
        <TD>
            <input class="InputGrey" name="odata_comm" size="20"  value="<%=odata_comm%>" readonly>
        </TD>
        <TD class="blue">������ʾ</TD>
        <TD>
            <input class="InputGrey" name="ophone_dis" size="20"  value="<%=ophone_dis%>" readonly>
        </TD>
    </TR>
    <TR> 
        <TD  class="blue">��������</TD>
        <TD >
            <input class="InputGrey" name="omain_hidden" size="20"  value="<%=omain_hidden%>" readonly>
        </TD>
        <TD class="blue">GPRS</TD>
        <TD>
            <input class="InputGrey" name="ogprs" size="20"  value="<%=ogprs%>" readonly>
        </TD>
    </TR>
    <TR> 
        <TD class="blue">�Ƿ�ǩԼ�û�</TD>
        <TD colspan="3">
            <input class="InputGrey" name="ovisa" size="20"  value="<%=ovisa%>" readonly>
        </TD>
    </TR>
    <TR id="footer"> 
        <TD colspan=4>
            <input class="b_foot" name=close  onClick="removeCurrentTab()" type=button value=�ر�>
        </TD>
    </TR>
</TABLE>
<%@ include file="/npage/include/footer.jsp" %>	  
</FORM>
</BODY>
</HTML>
  
 
