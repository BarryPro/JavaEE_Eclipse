<%
    /********************
     version v2.0
     ������: si-tech
     *
     *update:zhanghonga@2008-08-28 ҳ�����,�޸���ʽ
     *
     ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>

<html>
<META http-equiv=Content-Type content="text/html; charset=GBK">
<head>
<title>�ط����</title>
<%
    String opCode = "1219";
    String opName = "�ط����";
    String vPayCode = "0";

    String work_no = (String) session.getAttribute("workNo");
    String loginName = (String) session.getAttribute("workName");
    String org_code = (String) session.getAttribute("orgCode");
    String regionCode = org_code.substring(0, 2);
    String op_code = "1219";

    String[][] temfavStr = (String[][]) session.getAttribute("favInfo");
    String[] favStr = new String[temfavStr.length];
    int favPrePay = 0;
    for (int i = 0; i < favStr.length; i++)
        favStr[i] = temfavStr[i][0].trim();

    //�ж��Ƿ��й�������Ԥ�����Ȩ��
    boolean hfrf = false;
    if (WtcUtil.haveStr(favStr, "a281"))
        favPrePay = 1;

    int srvStrIndex = 0;
    activePhone = WtcUtil.repNull(request.getParameter("activePhone"));
    String srv_no = WtcUtil.repNull(request.getParameter("srv_no"));
    System.out.println("#######################################srv_no->" + srv_no);
    String ReqPageName = WtcUtil.repNull(request.getParameter("ReqPageName"));
    //-----------���������-------------
    String sqHf = "select hand_fee ,trim(favour_code) from snewFunctionFee where region_code=substr(:org_code,1,2) and FUNCTION_CODE=:op_code";
    String paraIn="org_code="+org_code+",op_code="+op_code;
%>
<wtc:service name="TlsPubSelCrm" routerKey="phone"  routerValue="<%=srv_no%>" outnum="2">
<wtc:param value="<%=sqHf%>"/>
<wtc:param value="<%=paraIn%>"/>
</wtc:service>
<wtc:array id="oriHandFeeArr" scope="end"/>
<%
    String oriHandFee = "0";
    String oriHandFeeFlag = "";
    if (oriHandFeeArr.length > 0) {
        oriHandFee = oriHandFeeArr[0][0];
        oriHandFeeFlag = oriHandFeeArr[0][1];
        if (Double.parseDouble(oriHandFee) < 0.01) {
            hfrf = true;
        } else {
            if (!WtcUtil.haveStr(favStr, oriHandFeeFlag.trim())) {
                hfrf = true;
            }
        }
    } else {
        hfrf = true;
    }

    //��÷������˳�ʼ����Ϣ����
    //initArr = im1210.s1219Init(srv_no, work_no, op_code, org_code, "phone", srv_no);

    /****************************************************************************************
     *@service information
     *@name s1219Init
     *@description ȡ�����û��Ļ�����Ϣ���ط���Ϣ�����ڴ˷������жϴ��û��Ƿ���������
     *@author lugz
     *@created 20020721 03:27:5
     *@input parameter information
     *@inparam loginNo    ��������
     *@inparam phoneNo    �������
     *@inparam opCode    ��������
     *@inparam orgCode    ��������
     *@output parameter information
     *@outparam idNo            �û�id
     *@outparam smCode            ҵ�����ʹ���
     *@outparam smName            ҵ����������
     *@outparam custName        �ͻ�����
     *@outparam userPassword    �û�����
     *@outparam runCode            ״̬����
     *@outparam runName            ״̬����
     *@outparam ownerGrade        �ȼ�����
     *@outparam gradeName        �ȼ�����
     *@outparam ownerType        �û�����
     *@outparam ownerTypeName    �û���������
     *@outparam custAddr        �ͻ�סַ
     *@outparam idType            ֤������
     *@outparam idName            ֤������
     *@outparam idIccid            ֤������
     *@outparam totalOwe        ��ǰǷ��
     *@outparam totalPrepay        ��ǰԤ��
     *@outparam firstOweConNo    ��һ��Ƿ���ʺ�
     *@outparam firstOweFee        ��һ��Ƿ���ʺŽ��
     *--------------------------------------------------------------*
     *@outparam19 cust_name        ����������
     *@outparam20 contact_phone    ��������ϵ�绰
     *@outparam21 id_type        ������֤������
     *@outparam22 id_iccid        ������֤������
     *@outparam23 id_address         ������֤����ַ
     *@outparam24 contact_address��������ϵ��ַ
     *@outparam25 notes            ������ע
     *--------------------------------------------------------------*
     *@outparam funcCode        �ط�����
     *@outparam addNo            �̺���		û��Ϊ��
     *@outparam funcStatus        �ط�״̬	'0'ԤԼ '1'��ͨ��
     *@outparam beginDate        ��ʼ����	ԤԼ�Ŀ�ͨʱ�䣬û��Ϊ��
     *@outparam endDate            �ر�����	ԤԼ�Ĺر�ʱ�䣬û��Ϊ��
     *@outparam notFuncCode        �����Կ�ͨ��Ҳ�����Թرյ��ط�����
     *@outparam funcName        �ط�����

     *@return SVR_ERR_NO
     **********************************************************************/
%>
<wtc:service name="s1219Init" routerKey="phone" retCode="initRetCode" retMsg="initRetMsg" routerValue="<%=srv_no%>" outnum="35">
<wtc:param value="<%=work_no%>"/>
<wtc:param value="<%=srv_no%>"/>
<wtc:param value="<%=op_code%>"/>
<wtc:param value="<%=org_code%>"/>
</wtc:service>
<wtc:array id="initStr_1" start="0" length="26" scope="end"/>
<wtc:array id="initStr_2" start="26" length="5" scope="end"/>
<wtc:array id="initStr_3" start="31" length="1" scope="end"/>

<%
	System.out.println("retCoderetCoderetCode="+retCode);
	System.out.println("initRetMsginitRetMsginitRetMsg="+initRetMsg);
    if (initStr_1 == null || initStr_1.length == 0) {
        System.out.println("###########################initStr_1.length->" + initStr_1.length);
        response.sendRedirect("s1219Login.jsp?ReqPageName=s1219Main&retMsg=10");
    }

    if (initRetCode != "") {
        if (Integer.parseInt(initRetCode) == 1007 || Integer.parseInt(initRetCode) == 1008) {
            response.sendRedirect("s1219Login.jsp?ReqPageName=s1219Main&retMsg=100&oweAccount=" + new String(initStr_1[0][17]) + "&oweFee=" + initStr_1[0][18]);
        } else if (Integer.parseInt(initRetCode) != 0) {
            response.sendRedirect("s1219Login.jsp?ReqPageName=s1219Main&retMsg=101&errCode=" + initRetCode + "&errMsg=" + initRetMsg);
        }
    } else {
        response.sendRedirect("s1219Login.jsp?ReqPageName=s1219Main&retMsg=12");
    }
%>

<%
    //String[] twoFlag = im1210.s1210Index(srv_no, "phone", srv_no);
    //���ݷ������ȡ����ͻ���־�����ű�־
    //������δ����ǶԴ�ejb�ĸ���
    String cardName = "";
    String grpName = "";
    String attrCodeSqlStr = "select trim(attr_code) from dcustMsg where phone_no='" + srv_no + "' and substr(run_code,2,1)<'a' and rownum<2";
%>
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
    <wtc:sql><%=attrCodeSqlStr%>
    </wtc:sql>
</wtc:pubselect>
<wtc:array id="attrCodeArr" scope="end"/>
<%
    if (attrCodeArr != null && attrCodeArr.length > 0) {
        String attrCode = attrCodeArr[0][0];
        String bigFlag = "";
        String grpFlag = "";
        if (!"".equals(attrCode)) {
            bigFlag = attrCode.substring(2, 4);
            grpFlag = attrCode.substring(4, 5);
            String cardNameSqlStr = "select trim(card_name) from sBigCardCode where card_type='" + bigFlag + "'";
            String grpNameSqlStr = "select trim(grp_name) from sGrpBigFlag where grp_flag='" + grpFlag + "'";
%>
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
    <wtc:sql><%=cardNameSqlStr%>
    </wtc:sql>
</wtc:pubselect>
<wtc:array id="cardNameArr" scope="end"/>

<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
    <wtc:sql><%=grpNameSqlStr%>
    </wtc:sql>
</wtc:pubselect>
<wtc:array id="grpNameArr" scope="end"/>
<%
            if ((cardNameArr == null || cardNameArr.length == 0) && (grpNameArr == null || grpNameArr.length == 0)) {
                response.sendRedirect("s1219Login.jsp?ReqPageName=s1219Main&retMsg=2");
            }

            if (cardNameArr != null && cardNameArr.length > 0) {
                cardName = cardNameArr[0][0];
            }

            if (grpNameArr != null && grpNameArr.length > 0) {
                grpName = grpNameArr[0][0];
            }
        }
    }

    //-----------��÷��������ط���Ϣ����-------------
    vPayCode = initStr_1[0][9];
    String sq1 = "select trim(FUNCTION_CODE),trim(FUNCTION_NAME),FUNCTION_FEE,decode('" + vPayCode + "','4',0,PREPAY_LIMIT),sm_code,trim(addno_flag) from sFuncList where region_code = (select substr(belong_code,1,2) from dCustMsg where phone_no='" + srv_no + "') and sm_code='" + initStr_1[0][1].trim() + "' and show_flag='Y' union select trim(FUNCTION_CODE),trim(FUNCTION_NAME),FUNCTION_FEE,decode('0','4',0,PREPAY_LIMIT),sm_code,trim(addno_flag) from sFuncList where region_code = (select substr(belong_code,1,2) from dCustMsg where phone_no='" + srv_no + "') and sm_code='" + initStr_1[0][1].trim() + "' and function_code in(select a.function_code from dcustfunc a,sFuncListShow b where a.id_no=" + initStr_1[0][0].trim() + " and a.function_code=b.function_code and b.region_code = (select substr(belong_code,1,2) from dCustMsg where phone_no='" + srv_no + "') and sm_code='" + initStr_1[0][1].trim() + "' and del_flag='Y')";
    String sqlDaqing =  "SELECT DISTINCT a.function_code,d.op_time FROM scallremindbind a, dcustfunc b, dcustmsg c,dbillcustdetail d  WHERE c.phone_no = '" + srv_no + "' AND c.id_no = b.id_no AND b.function_code = a.function_code AND a.region_code = SUBSTR (c.belong_code, 1, 2) AND d.mode_code = a.mode_code and d.id_no = c.id_no and  d.mode_flag = 0  and ROWNUM =1 ORDER BY d.op_time desc";
    
    System.out.println( sqlDaqing )  ;     
         
            
%>
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="6">
    <wtc:sql><%=sq1%>
    </wtc:sql>
</wtc:pubselect>



<wtc:array id="srvStr" scope="end"/>
	
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
    <wtc:sql><%=sqlDaqing%>
    </wtc:sql>
</wtc:pubselect>
<wtc:array id="srvDaQingStr" scope="end"/>

<%
    if (srvStr.length == 0) {
        response.sendRedirect("s1219Login.jsp?ReqPageName=s1219Main&retMsg=13");
    }
	/**����ע�������,���"������ʾ";
	*classCodeΪ10431,����"�ط�";
	*���������ĵ�,��ȷ��classCode��ֵ;
	**/
	String [] classValueArr = new String[srvStr.length];
	String [] insertImpPrompt = new String[srvStr.length];
	String classCode = "10431";
	
	/**������ҪclassValue��һά����**/
	if(srvStr!=null){
		for(int i=0;i<srvStr.length;i++){
		classValueArr[i] = srvStr[i][0].trim();
		System.out.println("#############"+classValueArr[i] );
		}
	}
    
    String groupId =(String)session.getAttribute("groupId");
    String smCode = initStr_1[0][1].trim();
%>
		<!--�����������������,���������ʾ����-->
		<wtc:service name="s9611Cfm2" routerKey="regionCode" routerValue="<%=regionCode%>"  retcode="ret_code" retmsg="ret_message"  outnum="4" >
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="1"/>
			<wtc:param value="12"/>
			<wtc:param value="<%=groupId%>"/>
			<wtc:params value="<%=classValueArr%>"/>
			<wtc:param value="<%=classCode%>"/>
			<wtc:param value="<%=regionCode%>"/>
			<wtc:param value="<%=smCode%>"/>
		</wtc:service>	
		<wtc:array id="s9611Cfm2Arr" scope="end" />	
<%
	String addNo_Flag = "N";  //���Ӻ����־
	int recordNum1 = srvStr.length;
	outer:for(int i=0;i<recordNum1;i++)
	{
		/**����ע�������,���"������ʾ"**/
		String insertImpPromptStr = "";
		String impPromptStr = "";
		int pos=0;
		if(ret_code.equals("000000")){
			if(s9611Cfm2Arr!=null){
				for(int m=0;m<s9611Cfm2Arr.length;m++){ //�������(classValue)��ֵһ��.��ƴ�ɴ�.����tr����input��
					if(s9611Cfm2Arr[m][2].equals(srvStr[i][0])){//ʵ����,s9611Cfm2Arr[m][2]��ֵ(classValue)��s9611Cfm2Arr�п������ظ���.
							if(m==0)
							{
								impPromptStr += s9611Cfm2Arr[m][2]+"-"+s9611Cfm2Arr[m][3]+"<br/>"
														+(pos+1)+"."+s9611Cfm2Arr[m][0]+"<br/>";
							}else
									{
										if(s9611Cfm2Arr[m][2].equals(s9611Cfm2Arr[m-1][2]))//ͬһcode
										{
											impPromptStr +=(pos+1)+"."+s9611Cfm2Arr[m][0].trim()+"<br/>";
										}else //��һ��code
										{
											pos=0;
											impPromptStr +=s9611Cfm2Arr[m][2].trim()+"-"+s9611Cfm2Arr[m][3].trim()+"<br/>"
													   +(pos+1)+"."+s9611Cfm2Arr[m][0].trim()+"<br/>";
										}
									}
					pos++;
					}
					
				}
			}
		}
		
		/**���ƴ�ӵĲ�����д��tr����input**/
		insertImpPromptStr += "class='promptBlue' title='"+impPromptStr+"' classCode='"+classCode+"'  classValue='"+srvStr[i][0]+"' ";
		insertImpPrompt[i]=insertImpPromptStr;
		System.out.println("###############insertImpPromptStr->"+insertImpPrompt[i]);
		}
		
%>
<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="phone" routerValue="<%=srv_no%>" id="sLoginAccept"/>
<%
    //��ˮ   
    String loginAccept = sLoginAccept;

    String loginNote = "";
    String sqlStr9 = "select back_char1 from snotecode where region_code='" + regionCode + "' and op_code='XXXX'";
%>
<wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="1">
    <wtc:sql><%=sqlStr9%>
    </wtc:sql>
</wtc:pubselect>
<wtc:array id="result9" scope="end"/>
<%
    System.out.println("@@@@@@@@@result=" + result9);

    for (int i = 0; i < result9.length; i++) {
        loginNote = (result9[i][0]).trim();
    }
    loginNote = loginNote.replaceAll("\"", "");
    loginNote = loginNote.replaceAll("\'", "");
    loginNote = loginNote.replaceAll("\r\n", "   ");
    loginNote = loginNote.replaceAll("\r", "   ");
    loginNote = loginNote.replaceAll("\n", "   ");
%>

<META content=no-cache http-equiv=Pragma>
<META content=no-cache http-equiv=Cache-Control>
<META content="MSHTML 5.00.3315.2870" name=GENERATOR>
<script language=javascript>
$(function(){
	$("*[classCode]")&&$("*[classValue]").each(function(){
		$(this).tooltip();
	}); 
}); 
var js_srv = new Array(new Array(), new Array(), new Array(), new Array(), new Array());
var aa_info = new Array(new Array(), new Array(), new Array(), new Array(), new Array(), new Array());

var delStr = "";
var modValidStr = "";
var modInvalidStr = "";
var addValidStr = "";
var addInvalidStr = "";
var addShortnoStr = "";

onload = function()
{
    self.status = "";

<%
    //-----------��ÿͻ��˷�����Ϣ����-------------
    for(int i=0;i<srvStr.length;i++)
    {
      for(int j=0;j<srvStr[i].length;j++)
      {
      System.out.println("wwwwwwwwwwwwwwwwwwwwwwwwwwwww"+srvDaQingStr.length);
      	if((srvDaQingStr.length!=0)&&srvStr[i][j].trim().equals("�������Ѱ���"))
      	{
      		srvStr[i][j]="�ײ�����������";
      	}
%>
    aa_info[<%=j%>][<%=i%>] = "<%=srvStr[i][j].trim()%>";
<%
	System.out.println("mmmmmmmmmmmm"+srvStr[i][1]);
 	  }
	}
%>

	
    for (var i = 0; i < document.all.ck_1.length; i++)
    {
        js_srv[0][i] = document.all.t_st[i].value.trim();
        js_srv[1][i] = document.all.t_et[i].value.trim();
        js_srv[2][i] = document.all.t_flag[i].value.trim();
        js_srv[3][i] = document.all.t_hao[i].value.trim();
    }

    for (var i = 0; i < document.all.ck_1.length; i++)
    {
        /****liucm add****/
        if (document.all.t_srvno[i].value.trim() == "k6")
        {
            document.all.t_st[i].disabled = "true";
            document.all.t_et[i].disabled = "true";
        }
        /*wangdx add 2009.4.27*/
        
        if (document.all.ck_1[i].checked)
        {
            //���ݶ̺���Լ����ʼʱ��ͽ���ʱ��
            if (document.all.t_hao[i].value.trim().length > 0)
            {
                document.all.t_st[i].disabled = "true";
                document.all.t_et[i].disabled = "true";
            }
		
			//���ݿ�ͨ״̬Լ����ʼʱ��
            if (document.all.t_flag[i].value.trim() == "��ͨ")
            {
                document.all.t_st[i].disabled = "true";
            }
        } else {
            //���ݶ̺ű�־Լ���̺���
            if (document.all.Id_shortno[i].value.trim() == "Y")
                document.all.t_hao[i].readOnly = "true";
            else
            {
                //�˶�Ԥ�������ڽ�����
                document.all.t_hao[i].readOnly = "true";
            }
        }
    }
}

//-------2--------ʵ����ר�ú���----------------
function ChkHandFee()
{
    if (document.all.oriHandFee.value.trim().len() >= 1 && document.all.t_handFee.value.trim().len() >= 1)
    {
        if (parseFloat(document.all.oriHandFee.value) < parseFloat(document.all.t_handFee.value))
        {
            rdShowMessageDialog("ʵ�������Ѳ��ܴ���ԭʼ�����ѣ�");
            document.all.t_handFee.value = document.all.oriHandFee.value;
            document.all.t_handFee.select();
            document.all.t_handFee.focus();
            return;
        }
    }

    if (document.all.oriHandFee.value.trim().len() >= 1 && document.all.t_handFee.value.trim().len() == 0)
    {
        document.all.t_handFee.value = "0";
    }
}
function getFew()
{
    if (window.event.keyCode == 13)
    {
        var fee = document.all.t_handFee;
        var fact = document.all.t_factFee;
        var few = document.all.t_fewFee;
        if (fact.value.trim().len() == 0)
        {
            rdShowMessageDialog("ʵ�ս���Ϊ�գ�");
            fact.value = "";
            fact.focus();
            return;
        }
        if (parseFloat(fact.value) < parseFloat(fee.value))
        {
            rdShowMessageDialog("ʵ�ս��㣡");
            fact.value = "";
            fact.focus();
            return;
        }

        var tem1 = ((parseFloat(fact.value) - parseFloat(fee.value)) * 100 + 0.5).toString();
        var tem2 = tem1;
        if (tem1.indexOf(".") != -1) tem2 = tem1.substring(0, tem1.indexOf("."));
        few.value = (tem2 / 100).toString();
        few.focus();
    }
}

//-------3--------checkBoxר�ú���----------------
function bnk(ord)
{
    if (document.all.Id_Checked[ord].value == "0") { //��ʼʱδ��ѡ�е��� 
        if (!document.all.ck_1[ord].disabled && document.all.ck_1[ord].checked) {
            document.all.Id_type[ord].value = "add";
            if (document.all.favPrePay.value != 1) {
                if (parseFloat(document.all.t_prepay[ord].value) > parseFloat(document.all.userPrepay.value)) {
                    document.all.ck_1[ord].checked = false;
                    rdShowMessageDialog("�û���ǰ���С��" + document.all.t_prepay[ord].value + "��������ѡ��");
                    return false;
                }
            }

            if (document.all.Id_shortno[ord].value == "Y") {
                document.all.t_flag[ord].value = "��ͨ";
                document.all.t_st[ord].disabled = true;
                document.all.t_et[ord].disabled = true;
                if (document.all.t_hao[ord].value.trim().len() == 0) {
                    rdShowMessageDialog("��ѡ���˴����Ӻ�����ط�����ʱ��������Ϊ�ط�ѡ��һ�����Ӻ��룡");
                }
                return true;
            }

            if (document.all.t_hao[ord].value.length > 0) {
                document.all.t_flag[ord].value = "��ͨ";
                document.all.t_st[ord].disabled = true;
                document.all.t_et[ord].disabled = true;
            } else {
                if (document.all.t_st[ord].value.trim().len() > 0) {
                    document.all.t_flag[ord].value = "ԤԼ";
                    document.all.t_st[ord].disabled = false;
                    document.all.t_et[ord].disabled = false;
                    document.all.t_et[ord].focus();
                } else {
                    if (document.all.t_et[ord].value.trim().len() >= 0) {
                        document.all.t_flag[ord].value = "��ͨ";
                        document.all.t_st[ord].disabled = false;
                        document.all.t_et[ord].disabled = false;
                        document.all.t_st[ord].focus();
                    }
                }
            }
        } else if (!document.all.ck_1[ord].disabled && !document.all.ck_1[ord].checked) {
            //alert("2=" + document.all.Id_shortno[ord].value);
            document.all.Id_type[ord].value = "";
            document.all.t_st[ord].value = "";
            document.all.t_et[ord].value = "";
            document.all.t_hao[ord].value = "";
            document.all.t_flag[ord].value = "";
        }
    } else { //��ʼʱ��ѡ�е���
        if (!document.all.ck_1[ord].disabled && document.all.ck_1[ord].checked) {
            document.all.Id_type[ord].value = "mod";
		//alert("3=" + document.all.Id_shortno[ord].value);
            //if(!document.all.t_st[ord].disabled)
            document.all.t_st[ord].value = js_srv[0][ord];
            document.all.t_et[ord].value = js_srv[1][ord];
            document.all.t_hao[ord].value = js_srv[3][ord];
            if (js_srv[2][ord] == "ԤԼ")
            {

                document.all.t_flag[ord].value = "ԤԼ";
                document.all.t_st[ord].disabled = false;
                document.all.t_et[ord].disabled = false;
            }
            else
            {
                document.all.t_flag[ord].value = "��ͨ";
                document.all.t_st[ord].disabled = true;
                if (js_srv[3][ord] != "")
                    document.all.t_et[ord].disabled = true;
                else
                    document.all.t_et[ord].disabled = false;
            }
        }
        else if (!document.all.ck_1[ord].disabled && !document.all.ck_1[ord].checked)
        {
            document.all.Id_type[ord].value = "del";
		//alert("4=" + document.all.Id_shortno[ord].value);
            document.all.t_st[ord].value = "";
            document.all.t_et[ord].value = "";
            document.all.t_hao[ord].value = "";
            document.all.t_flag[ord].value = "";
        }
    }
    /*liucm add*/
    if (document.all.t_srvno[ord].value.trim() == "k6")
    {
        document.all.t_st[ord].disabled = "true";
        document.all.t_et[ord].disabled = "true";
    }
}

//---------δѡ����ĸ��Ӻ������������---------
function chgStatus(rowNum)
{
    if (document.all.Id_Checked[rowNum].value == "0" && document.all.ck_1[rowNum].checked)
    {
        if ((document.all.t_hao[rowNum].value).trim().len() > 0)
        {
            document.all.t_flag[rowNum].value = "��ͨ";
            document.all.t_st[rowNum].value = "";
            document.all.t_et[rowNum].value = "";
            document.all.t_st[rowNum].disabled = true;
            document.all.t_et[rowNum].disabled = true;
        }
        else
        {
            document.all.t_st[rowNum].disabled = true;
            document.all.t_et[rowNum].disabled = true;
            if (document.all.t_st[rowNum].value.trim().len() == 0 && document.all.t_et[rowNum].value.trim().len() == 0)
            {
                document.all.t_flag[rowNum].value = "��ͨ";
            }
            else if (document.all.t_st[rowNum].value.trim().len() == 0 && document.all.t_et[rowNum].value.trim().len() > 0)
            {
                document.all.t_flag[rowNum].value = "��ͨ";
            }
            else if (document.all.t_st[rowNum].value.trim().len() > 0 && document.all.t_et[rowNum].value.trim().len() == 0)
            {
                document.all.t_flag[rowNum].value = "��ͨ";
            }
            else if (document.all.t_st[rowNum].value.trim().len() > 0 && document.all.t_et[rowNum].value.trim().len() > 0)
            {
                document.all.t_flag[rowNum].value = "��ͨ";
            }
        }
    }
}

//------���뿪ʼʱ���ʱ��------------------------
function chgSt(ord)
{
    if (document.all.Id_Checked[ord].value == "0")  //��ʼʱδ��ѡ�е���
    {
        if (!document.all.ck_1[ord].disabled && document.all.ck_1[ord].checked)
        {
            if (document.all.t_st[ord].value.trim().len() > 0)
            {
                document.all.t_flag[ord].value = "ԤԼ";
            }
            else
            {
                document.all.t_flag[ord].value = "��ͨ";
            }
        }
    }
    else
    {
        if (document.all.t_flag[ord].value = "ԤԼ")
        {
            if (document.all.t_st[ord].value.trim().len() < 1)
            {
                rdShowMessageDialog("���ط�����ԤԼ״̬����ʼʱ�䲻��Ϊ�գ�");
                document.all.t_st[ord].focus();
            }
        }
    }
}

//------�������ʱ���ʱ��------------------------
function chgEt(ord)
{
    if (document.all.Id_Checked[ord].value == "0")  //��ʼʱδ��ѡ�е���
    {
        if (!document.all.ck_1[ord].disabled && document.all.ck_1[ord].checked)
        {
            if (document.all.t_st[ord].value.trim().len() == 0 && document.all.t_et[ord].value.trim().len() > 0)
            {
                document.all.t_flag[ord].value = "��ͨ";
            }
            else if (document.all.t_st[ord].value.trim().len() == 0 && document.all.t_et[ord].value.trim().len() == 0)

            {
                document.all.t_flag[ord].value = "��ͨ";
            }
        }
    }
}

//-------------��ѯ��ť������------------------
function qry(ord)
{
    var h = 200;
    var w = 250;
    var t = screen.availHeight / 2 - h / 2;
    var l = screen.availWidth / 2 - w / 2;
    var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
    var ret = window.showModalDialog("AllShort_No.jsp", "", prop);
    if (typeof(ret) != "undefined")
    {
        document.all.t_hao[ord].value = ret;
        document.all.t_st[ord].value = "";
        document.all.t_et[ord].value = "";
        document.all.t_st[ord].disabled = true;
        document.all.t_et[ord].disabled = true;
        if (document.all.ck_1[ord].checked)
            document.all.t_flag[ord].value = "��ͨ";
    }
    else
    {
        document.all.t_hao[ord].value = "";
        document.all.t_st[ord].disabled = false;
        document.all.t_et[ord].disabled = false;
        if (document.all.ck_1[ord].checked)
        {
            if (document.all.t_st[ord].value.trim().len() == 0 && document.all.t_et[ord].value.trim().len() == 0)
            {
                document.all.t_flag[ord].value = "��ͨ";
                document.all.t_et[ord].focus();
            }
            else if (document.all.t_st[ord].value.trim().len() > 0 && document.all.t_et[ord].value.trim().len() > 0)
            {
                document.all.t_flag[ord].value = "ԤԼ";
                document.all.t_st[ord].focus();
            }
            else if (document.all.t_st[ord].value.trim().len() == 0 && document.all.t_et[ord].value.trim().len() > 0)
            {
                document.all.t_flag[ord].value = "��ͨ";
                document.all.t_et[ord].focus();
            }
            else if (document.all.t_st[ord].value.trim().len() > 0 && document.all.t_et[ord].value.trim().len() == 0)
            {
                document.all.t_flag[ord].value = "ԤԼ";
                document.all.t_et[ord].focus();
            }

        }
    }
}

//-----------��֤���Ϸ��Ե�ϵ�к���--------------
function chkCancelStr(i)
{
    return true;
}

function chkMod_ValidStr(i)
{
    var d = (new Date().getFullYear().toString() + (((new Date().getMonth() + 1).toString().length >= 2) ? (new Date().getMonth() + 1).toString() : ("0" + (new Date().getMonth() + 1))) + (((new Date().getDate()).toString().length >= 2) ? (new Date().getDate()) : ("0" + (new Date().getDate()))).toString());

    if (document.all.t_st[i].disabled == false && document.all.t_et[i].disabled == false)
    {
        if (document.all.t_st[i].value.length != 0)
        {
            rdShowMessageDialog("��֣��ط�" + i + "���ڿ�ͨ״̬����ʼʱ��ȴ��Ϊ�գ�");
            return false;
        }
        else
        {
            if (!validDate(document.all.t_et[i]))
            {
                return false;
            }
            else
            {
                if (to_date(document.all.t_et[i]) <= d)
                {
                    rdShowMessageDialog("����ʱ�䲻�����ڵ�ǰʱ�䣬���������룡");
                    document.all.t_et[i].focus();
                    return false;
                }
            }
        }
    }
    else if
            (document.all.t_st[i].disabled == true && document.all.t_et[i].disabled == false)
    {
        if (document.all.t_et[i].value.trim().len() > 0)
        {
            if (!validDate(document.all.t_et[i]))
                return false;

            if (to_date(document.all.t_et[i]) <= d)
            {
                rdShowMessageDialog("����ʱ�䲻�����ڵ�ǰʱ�䣬���������룡");
                document.all.t_et[i].focus();
                return false;
            }
        }
    }
    return true;
}

function chkMod_InvalidStr(i)
{
    if (document.all.t_st[i].disabled == true && document.all.t_et[i].disabled == true)
    {
        return true;
    }
    var d = (new Date().getFullYear().toString() + (((new Date().getMonth() + 1).toString().length >= 2) ? (new Date().getMonth() + 1).toString() : ("0" + (new Date().getMonth() + 1))) + (((new Date().getDate()).toString().length >= 2) ? (new Date().getDate()) : ("0" + (new Date().getDate()))).toString());

    if (document.all.t_st[i].disabled == false && document.all.t_et[i].disabled == true)
    {
        if (!validDate(document.all.t_st[i])) return false;
        if (to_date(document.all.t_st[i]) <= d)
        {
            document.all.t_st[i].value = "";
            rdShowMessageDialog("��ʼʱ�䲻�����ڵ�ǰʱ�䣬���������룡");
            document.all.t_st[i].focus();
            return false;
        }
    }
    if (document.all.t_st[i].disabled == false && document.all.t_et[i].disabled == false)
    {
        if (!validDate(document.all.t_st[i])) return false;
        if (!validDate(document.all.t_et[i])) return false;

        if (to_date(document.all.t_st[i]) >= to_date(document.all.t_et[i]))
        {
            document.all.t_st[i].value = "";
            document.all.t_et[i].value = "";
            rdShowMessageDialog("��ʼʱ�䲻�����ڽ���ʱ�䣬���������룡");
            document.all.t_st[i].focus();
            return false;
        }
        if (to_date(document.all.t_st[i]) <= d)
        {
            document.all.t_st[i].value = "";
            rdShowMessageDialog("��ʼʱ�䲻�����ڵ�ǰʱ�䣬���������룡");
            document.all.t_st[i].focus();
            return false;
        }
        if (to_date(document.all.t_et[i]) <= d)
        {
            document.all.t_et[i].value = "";
            rdShowMessageDialog("����ʱ�䲻�����ڵ�ǰʱ�䣬���������룡");
            document.all.t_et[i].focus();
            return false;
        }
    }
    if (document.all.t_st[i].disabled == true && document.all.t_et[i].disabled == false)
    {
        if (!validDate(document.all.t_et[i])) return false;

        if (to_date(document.all.t_et[i]) <= d)
        {
            document.all.t_et[i].value = "";
            rdShowMessageDialog("����ʱ�䲻�����ڵ�ǰʱ�䣬���������룡");
            document.all.t_et[i].focus();
            return false;
        }
    }
    return true;
}

function chkAdd_ValidStr(i)
{
    if (document.all.t_et[i].disabled == false)
    {
        if (document.all.t_et[i].value.trim().len() > 0)
        {
            if (!validDate(document.all.t_et[i]))

                return false;

            var d = (new Date().getFullYear().toString() + (((new Date().getMonth() + 1).toString().length >= 2) ? (new Date().getMonth() + 1).toString() : ("0" + (new Date().getMonth() + 1))) + (((new Date().getDate()).toString().length >= 2) ? (new Date().getDate()) : ("0" + (new Date().getDate()))).toString());
            if (to_date(document.all.t_et[i]) <= d)
            {
                rdShowMessageDialog("����ʱ�䲻�����ڵ�ǰʱ�䣬���������룡");
                document.all.t_et[i].focus();
                return false;
            }
        }

    }
    return true;
}

function chkAdd_InvalidStr(i)
{
    if (document.all.t_st[i].disabled == true && document.all.t_et[i].disabled == true)
    {
        return true;
    }
    var d = (new Date().getFullYear().toString() + (((new Date().getMonth() + 1).toString().length >= 2) ? (new Date().getMonth() + 1).toString() : ("0" + (new Date().getMonth() + 1))) + (((new Date().getDate()).toString().length >= 2) ? (new Date().getDate()) : ("0" + (new Date().getDate()))).toString());
    if (document.all.t_st[i].disabled == false && document.all.t_et[i].disabled == true)
    {
        if (!validDate(document.all.t_st[i])) return false;
        if (to_date(document.all.t_st[i]) <= d)
        {
            document.all.t_st[i].value = "";
            rdShowMessageDialog("��ʼʱ�䲻�����ڵ�ǰʱ�䣬���������룡");
            document.all.t_st[i].focus();
            return false;
        }
    }
    if (document.all.t_st[i].disabled == false && document.all.t_et[i].disabled == false)
    {
        if (!validDate(document.all.t_st[i])) return false;
        if (!validDate(document.all.t_et[i])) return false;

        if (to_date(document.all.t_st[i]) >= to_date(document.all.t_et[i]))
        {
            document.all.t_st[i].value = "";
            document.all.t_et[i].value = "";
            rdShowMessageDialog("��ʼʱ�䲻�����ڽ���ʱ�䣬���������룡");
            document.all.t_st[i].focus();
            return false;
        }
        if (to_date(document.all.t_st[i]) <= d)
        {
            document.all.t_st[i].value = "";
            rdShowMessageDialog("��ʼʱ�䲻�����ڵ�ǰʱ�䣬���������룡");
            document.all.t_st[i].focus();
            return false;
        }
        if (to_date(document.all.t_et[i]) <= d)
        {
            document.all.t_et[i].value = "";
            rdShowMessageDialog("����ʱ�䲻�����ڵ�ǰʱ�䣬���������룡");
            document.all.t_et[i].focus();
            return false;
        }
    }
    if (document.all.t_st[i].disabled == true && document.all.t_et[i].disabled == false)
    {
        if (!validDate(document.all.t_et[i])) return false;

        if (to_date(document.all.t_et[i]) <= d)
        {
            document.all.t_et[i].value = "";
            rdShowMessageDialog("����ʱ�䲻�����ڵ�ǰʱ�䣬���������룡");
            document.all.t_et[i].focus();
            return false;
        }
    }
    return true;
}

function chkAdd_ShortnoStr(i)
{
    return true;
}

function docheck()
{
    // in here form check
    var j = 0;
    var u = 0;
    for (var i = 0; i < document.all.ck_1.length; i++)
    {
        if (!document.all.ck_1[i].disabled && document.all.ck_1[i].checked == true)
        {
            if (document.all.t_srvno[i].value == "15" ||
                document.all.t_srvno[i].value == "16" ||
                document.all.t_srvno[i].value == "17" ||
                document.all.t_srvno[i].value == "23")
                j++;

            if (document.all.t_srvno[i].value == "00" ||
                document.all.t_srvno[i].value == "01")
                u++;
        }

    }
}

function printCommit()
{
    getAfterPrompt();
    // in here form check
    if (docheck() == false)
    {
        return false;
    }
    showPrtDlg("Detail", "ȷʵҪ���е��������ӡ��", "Yes");
}

//--------4---------��ʾ��ӡ�Ի���----------------
function showPrtDlg(printType, DlgMessage, submitCfm)
{
    delStr = "";
    modValidStr = ""; 
    modInvalidStr = "";
    addValidStr = "";
    addInvalidStr = "";
    addShortnoStr = "";
    var fav_code = "";                 //�ط�����
    for (var i = 0; i < document.all.ck_1.length; i++)
    {
        if (!document.all.ck_1[i].disabled)
        {
            //------------------------s---------------------------        
            if (document.all.Id_Checked[i].value == "1")
            {
                if (document.all.Id_type[i].value == "del")
                {
                    //����ȡ����
                    if (chkCancelStr(i))
                    {
                        delStr += document.all.t_srvno[i].value + "|";
                    }
                    else
                        return;
                }
                else if (document.all.Id_type[i].value == "mod")
                {
                    if (document.all.t_flag[i].value == "��ͨ")
                    {
                        //�����޸���Ч��
                        if (chkMod_ValidStr(i)) {
                            modValidStr += document.all.t_srvno[i].value + to_date(document.all.t_et[i]) + "|";
                    //alert(document.all.t_srvno[i].value);
                            if (document.all.t_srvno[i].value == "19")
                            {
                                document.all.radio3.value = "19"
                            }


                        }
                        else
                            return;
                    }
                    else if (document.all.t_flag[i].value == "ԤԼ")
                    {
                        //�����޸�δ��Ч��
                        if (chkMod_InvalidStr(i))
                        {
                            modInvalidStr += document.all.t_srvno[i].value + to_date(document.all.t_st[i]) + to_date(document.all.t_et[i]) + "|";
					//alert("@@@@@@@@@@@@@@@"+document.all.t_srvno[i].value);
                            if (document.all.t_srvno[i].value == "19")
                            {
                                document.all.radio3.value = "19"
                            }

                        }
                        else
                            return;
                    }
                }
            }
            else
            {
                if (document.all.Id_type[i].value == "add")
                {
                    if (document.all.t_flag[i].value == "��ͨ")
                    {
                        if (document.all.Id_shortno[i].value == "Y")
                        {
                            if (document.all.t_hao[i].value.trim().len() == 0)
                            {
                                rdShowMessageDialog("��ѡ���˴����Ӻ�����ط�����ʱ��������Ϊ�ط�ѡ��һ�����Ӻ��룡");
                                document.all.t_hao[i].focus();
                                return false;
                            }
                        }

                        if (document.all.t_hao[i].value.trim().len() == 0)
                        {
                            //����������Ч��
                            if (chkAdd_ValidStr(i))
                            {
                                addValidStr += document.all.t_srvno[i].value + to_date(document.all.t_et[i]) + "|";
                                fav_code += document.all.t_srvno[i].value +"|";
				   	//alert(document.all.t_srvno[i].value);
                                if (document.all.t_srvno[i].value == "19")
                                {
                                    document.all.radio3.value = "19"
                                }
                                if (document.all.t_srvno[i].value == "k6")
                                {
                                    document.all.ldtxbz.value = "k6"
                                }
                            }
                            else
                                return;
                        }
                        else
                        {
                            //�������Ӵ����봮
                            if (chkAdd_ShortnoStr(i))
                            {
                                addShortnoStr += document.all.t_srvno[i].value + document.all.t_hao[i].value + "|";
                                fav_code += document.all.t_srvno[i].value +"|";
                            }
                            else
                                return;
                        }
                    }
                    else if (document.all.t_flag[i].value == "ԤԼ")
                    {
                        //��������δ��Ч��
                        if (chkAdd_InvalidStr(i))
                        {
                            addInvalidStr += document.all.t_srvno[i].value + to_date(document.all.t_st[i]) + to_date(document.all.t_et[i]) + "|";
                            fav_code += document.all.t_srvno[i].value +"|";
                        }
                        else
                            return;
                    }
                }
                else if (document.all.Id_type[i].value = "")
                {
                    //�����κδ���
                }
            }
		 //--------------------------e----------------------------
        }//disabled
    }//forѭ��

    if (document.all.assuId.value.trim().len() > 0)
    {
        if (document.all.assuId.value.length < 5)
        {
            rdShowMessageDialog("֤�����볤������(����5λ)��");
            document.all.assuId.focus();
            return false;
        }
    }

    if (check(frm))
    {
        document.all.t_sys_remark.value = "�û�" + "<%=initStr_1[0][0].trim()%>" + "�ط����";
        if (document.all.t_op_remark.value.trim().len() == 0)
        {
            document.all.t_op_remark.value = "����Ա<%=work_no%>" + "���û�" + "<%=initStr_1[0][0].trim()%>" + "�����ط����"
        }
        if (document.all.assuNote.value.trim().len() == 0)
        {
            document.all.assuNote.value = "����Ա<%=work_no%>" + "���û�" + "<%=initStr_1[0][0].trim()%>" + "�����ط����"
        }
		 
		 //��ʾ��ӡ�Ի��� 
		var h=210;
		var w=400;
        var t = screen.availHeight / 2 - h / 2;
        var l = screen.availWidth / 2 - w / 2;

        //var printStr = printInfo(printType);
		    
			var pType="subprint";              // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	      var billType="1";               //  Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	      var sysAccept=document.all.loginAccept.value;               // ��ˮ��
	      var printStr = printInfo(printType); //����printinfo()���صĴ�ӡ����
	      var mode_code=null;               //�ʷѴ���
		//alert(fav_code);
	      var area_code=null;             //С������
        var opCode="1219";                   //��������
        var phoneNo=document.all.srv_no.value;                  //�ͻ��绰

        var prop = "dialogHeight:" + h + "px; dialogWidth:" + w + "px; dialogLeft:" + l + "px; dialogTop:" + t + "px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no"
        var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc.jsp?DlgMsg=" + DlgMessage + "&submitCfm=" + submitCfm+
                   "&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+phoneNo+
                   "&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr;
        
        var ret = window.showModalDialog(path, printStr, prop);

        if (typeof(ret) != "undefined")
        {
            if ((ret == "confirm") && (submitCfm == "Yes"))
            {
                if (rdShowConfirmDialog('ȷ�ϵ��������') == 1)
                {
                    document.all.printcount.value = "1";
                    conf();
                }
            }
            if (ret == "continueSub")
            {
                if (rdShowConfirmDialog('ȷ��Ҫ�ύ�ط������Ϣ��') == 1)
                {
                    document.all.printcount.value = "0";
                    conf();
                }
            }
        }
        else
        {
            if (rdShowConfirmDialog('ȷ��Ҫ�ύ�ط������Ϣ��') == 1)
            {
                document.all.printcount.value = "0";
                conf();
            }
        }
    }
}

function setTranPreTimeLine() {

    var strPreTime = "";
 	 
 	//ȡ����ԤԼʱ�� 
    for (var i = 0; i < document.all.ck_1.length; i++) {
        if (!document.all.ck_1[i].disabled) {
            if (document.all.Id_Checked[i].value == "1") {
                if (document.all.Id_type[i].value == "mod") {
                    if (document.all.t_flag[i].value == "ԤԼ") {//�����޸�δ��Ч��
                        if (strPreTime == "") {
                            strPreTime += to_date(document.all.t_st[i]);
                        } else {
                            strPreTime += "," + to_date(document.all.t_st[i]);
                        }
                    }
                }
            } else {
                if (document.all.Id_type[i].value == "add") {
                    if (document.all.t_flag[i].value == "ԤԼ") {//��������δ��Ч��
                        if (strPreTime == "") {
                            strPreTime += to_date(document.all.t_st[i]);
                        } else {
                            strPreTime += "," + to_date(document.all.t_st[i]);
                        }
                    }
                }//disabled
            }//forѭ��
        }
    }
    return strPreTime;
}

//ȡ�����ط�ʱ�� 
function getPreTranName() {

    var strPreTranName = "";
 	 
 	//ȡ����ԤԼʱ�� 
    for (var i = 0; i < document.all.ck_1.length; i++) {
        if (!document.all.ck_1[i].disabled) {
            if (document.all.Id_Checked[i].value == "1") {
                if (document.all.Id_type[i].value == "mod") {
                    if (document.all.t_flag[i].value == "ԤԼ") {//�����޸�δ��Ч��
                        if (strPreTranName == "") {
                            strPreTranName += document.all.t_func_name[i].value;
                        } else {
                            strPreTranName += "," + document.all.t_func_name[i].value;
                        }
                    }
                }
            } else {
                if (document.all.Id_type[i].value == "add") {
                    if (document.all.t_flag[i].value == "ԤԼ") {//��������δ��Ч��
                        if (strPreTranName == "") {
                            strPreTranName += document.all.t_func_name[i].value;
                        } else {
                            strPreTranName += "," + document.all.t_func_name[i].value;
                        }
                    }
                }//disabled
            }//forѭ��
        }
    }
    return strPreTranName;
}

//ȡ��ԤԼ�ط���Ŀ 
function setCancelTranPreTimeLine() {

    var strLine = "";
    var strTimeLine = "";
    var strBeginTime = "";
    var strEndTime = "";
 	//ȡ��ԤԼ�ط���Ŀ 

    for (var i = 0; i < document.all.ck_1.length; i++) {
        if (!document.all.ck_1[i].disabled) {
            if (document.all.Id_Checked[i].value == "1") {
                if (document.all.Id_type[i].value == "mod") {
                    if (document.all.t_flag[i].value == "��ͨ") {//�����޸�δ��Ч��
                        strEndTime = to_date(document.all.t_et[i]);
                        if (strEndTime != "") {
                            if (strLine == "") {
                                strLine += document.all.t_func_name[i].value;
                            } else {
                                strLine += "," + document.all.t_func_name[i].value;
                            }
                            if (strTimeLine == "") {
                                strTimeLine += strEndTime;
                            } else {
                                strTimeLine += "," + strEndTime;
                            }
                        }
                    }
                }
            } else {
                if (document.all.Id_type[i].value == "add") {
                    if (document.all.t_flag[i].value == "��ͨ") {//��������δ��Ч��
                        strEndTime = to_date(document.all.t_et[i]);
                        if (strEndTime != "") {
                            if (strLine == "") {
                                strLine += document.all.t_func_name[i].value;
                            } else {
                                strLine += "," + document.all.t_func_name[i].value;
                            }
                            if (strTimeLine == "") {
                                strTimeLine += strEndTime;
                            } else {
                                strTimeLine += "," + strEndTime;
                            }
                        }
                    }
                }//disabled
            }//forѭ��
        }
    }

    document.all.strCancelPreName.value = strLine;
    document.all.strCancelPreTime.value = strTimeLine;
    return;
}


//ȡ������Ч��ʱ��
function setTranNowTimeLine() {

    var strReturn = "";
    var strInLine = document.all.strTranTmp.value;
    var iPos = 0;

    alert("strInLine:" + strInLine);

    iPos = strInLine.indexOf(",");
    while (iPos != -1) {
        if (strReturn == "") {
            strReturn += "����";
        } else {
            strReturn += ",����"
        }
        strInLine = strInLine.substring(strInLine.indexOf(",") + 1, strInLine.value.length - strInLine.indexOf(","));
        alert("strInLine:" + strInLine);
    }

    return strReturn;
}

function printInfo(printType)
{

    document.all.delStr.value = delStr;
    document.all.modValidStr.value = modValidStr;
    document.all.modInvalidStr.value = modInvalidStr;
    document.all.addValidStr.value = addValidStr;
    document.all.addInvalidStr.value = addInvalidStr;
    document.all.addShortnoStr.value = addShortnoStr;

    var retInfo = "";
    var strLine = "";
    var strFullLine = "";
    var strCancelLine = "";
    var strAddLIine = "";
    var strTranLine = "";		  //�����ط�
    var strTranTimeLine = ""  //�����ط�����ʱ��

    var cust_info = "";
    var opr_info = "";
    var note_info1 = "";
    var note_info2 = "";
    var note_info3 = "";
    var note_info4 = "";

    cust_info += "�ͻ�������" + document.all.cust_name.value + "|";
    cust_info += "�ֻ����룺" + document.all.srv_no.value + "|";
    cust_info += "�ͻ���ַ��" + "<%=initStr_1[0][11].trim()%>" + "|";
    cust_info += "֤�����룺" + "<%=initStr_1[0][14].trim()%>" + "|";

    opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "  " + "�û�Ʒ��: " + document.all.sm_name.value + "|";
    document.all.strTmp.value = "";
    document.all.strTmp.value = "����ҵ��: �ط����  ������ˮ: " + document.all.loginAccept.value;
    opr_info += document.all.strTmp.value + "|";
		
	//����������Ч
    strTranLine = "";
    strAddLIine = retOtherStr(addValidStr, "|", ",", aa_info[0], aa_info[1]);
    if (strAddLIine != "") {
        strTranLine += "�����ط�(24Сʱ֮����Ч):" + strAddLIine + " ";
    } else {
        strTranLine += "�����ط�(24Сʱ֮����Ч):" + strAddLIine + " ";
    }
    opr_info += strTranLine + "|";
	
	
  //����ԤԼ��Ч
    strTranLine = "";
    strTranLine = "�����ط�(ԤԼ��Ч):" + getPreTranName();
    opr_info += strTranLine + "|";
		
	
	//��Чʱ��
    strTranTimeLine = ""
    strTranTimeLine += "��Чʱ��:" + setTranPreTimeLine();
    opr_info += strTranTimeLine + "|";	
	
	//ȡ���ط�������Ч
    strCancelLine = "";
    strTranLine = "";
    strCancelLine = retOtherStr(delStr, "|", ",", aa_info[0], aa_info[1]);
    if (strCancelLine != "") {
        strTranLine += "ȡ���ط�(24Сʱ֮����Ч):" + strCancelLine + " ";
    } else {
        strTranLine += "ȡ���ط�(24Сʱ֮����Ч):" + strCancelLine + " ";
    }
    opr_info += strTranLine + "|";


    setCancelTranPreTimeLine();
	//ȡ���ط�ԤԼ��Ч
    opr_info += "ȡ���ط�(ԤԼ��Ч):" + document.all.strCancelPreName.value + "|";
	
	//��Чʱ��
    opr_info += "��Чʱ��:" + document.all.strCancelPreTime.value + "|";

    note_info1 = "��ע:" + document.all.assuNote.value + "|";

    /*if (document.all.ldtxbz.value == "k6") {
        note_info2 = " " + "|";
        note_info2 += "1�����������¹��ܷ�3Ԫ����ʱ���룬24Сʱ����Ч����ʱȡ����24Сʱ����Ч��" + "|";
        note_info2 += "2�������������Ѱ����൱�����ò��ɼ���ת��13800XYZ309���ֻ��ն˲���ȡ�����������ò��ɼ���ת����������,���ɼ���ת��13800XYZ309�Ĺ��ܽ�ʧЧ��ͬʱ������˶��������Ѱ���ҵ���Լ�����ȡ���·��ã�" + "|";
        note_info2 += "3���˶����������Ͷ���qxldtx��10086������10086���ߡ���¼��վwww.hl.chinamobile.com������Ӫҵǰ̨����" + "|";
    } */
    document.all.cust_info.value = cust_info + "#";
    document.all.opr_info.value = opr_info + "#";
    document.all.note_info1.value = note_info1 + "#";
    document.all.note_info2.value = note_info2 + "#";
    document.all.note_info3.value = note_info3 + "#";
    document.all.note_info4.value = note_info4 + "#";
    //retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}


//--------5----------�ύ������-------------------
function conf()
{
    document.all.b_print.disabled = true;
    document.all.b_clear.disabled = true;
    document.all.delStr.value = delStr;
    document.all.modValidStr.value = modValidStr;
    document.all.modInvalidStr.value = modInvalidStr;
    document.all.addValidStr.value = addValidStr;
    document.all.addInvalidStr.value = addInvalidStr;
    document.all.addShortnoStr.value = addShortnoStr;

    frm.action = "s1219_conf.jsp";
    frm.submit();
}

function canc()
{
    frm.submit();
}

//ת������
function to_date(obj)
{
    var theTotalDate = "";
    var one = "";
    var flag = "0123456789";
    for (i = 0; i < obj.value.length; i++)
    {
        one = obj.value.charAt(i);
        if (flag.indexOf(one) != -1)
            theTotalDate += one;
    }
    return theTotalDate;
}


function retOtherStr(str, tok1, tok2, pack1, pack2)
{
    var num = getTokNums(str, tok1);
    var temStr = "";
    var retStr = "";
    for (var i = 1; i < num + 1; i++)
    {
        temStr = oneTok(str, tok1, i).substring(0, 2);
        for (var j = 0; j < pack1.length; j++)
        {
            if (pack1[j] == temStr.trim())
            {
                retStr += pack2[j] + tok2;
                break;
            }
        }
    }
    if (retStr.trim().len() == 0) return "";
    return retStr.substring(0, retStr.length - 1);
}

function getTokNums(str, tok)
{
    var temStr = str;
    if (str.charAt(0) == tok) temStr = str.substring(1, str.length);
    if (str.charAt(str.length - 1) == tok) temStr = temStr.substring(0, temStr.length - 1);

    var temLen;
    var temNum = 1;
    while (temStr.indexOf(tok) != -1)
    {
        temLen = temStr.length;
        temLoc = temStr.indexOf(tok);
        temStr = temStr.substring(temLoc + 1, temLen);
        temNum++;
    }
    return temNum;
}

function oneTok(str, tok, loc)
{

    var temStr = str;
    if (str.charAt(0) == tok) temStr = str.substring(1, str.length);
    if (str.charAt(str.length - 1) == tok) temStr = temStr.substring(0, temStr.length - 1);

    var temLoc;
    var temLen;
    for (ii = 0; ii < loc - 1; ii++)
    {
        temLen = temStr.length;
        temLoc = temStr.indexOf(tok);
        temStr = temStr.substring(temLoc + 1, temLen);
    }
    if (temStr.indexOf(tok) == -1)
        return temStr;
    else
        return temStr.substring(0, temStr.indexOf(tok));
}

function validDate(obj)
{
    var theDate = "";
    var one = "";
    var flag = "0123456789";
    for (i = 0; i < obj.value.length; i++)
    {
        one = obj.value.charAt(i);
        if (flag.indexOf(one) != -1)
            theDate += one;
    }
    if (theDate.length != 8)
    {
        rdShowMessageDialog("���ڸ�ʽ������ȷ��ʽΪ�����������������ա������������룡");
	//obj.value="";
        obj.select();
        obj.focus();
        return false;
    }
    else
    {
        var year = theDate.substring(0, 4);
        var month = theDate.substring(4, 6);
        var day = theDate.substring(6, 8);
        if (myParseInt(year) < 1900 || myParseInt(year) > 3000)
        {
            rdShowMessageDialog("��ĸ�ʽ������Ч���Ӧ����1900-3000֮�䣬���������룡");
	   //obj.value="";
            obj.select();
            obj.focus();
            return false;
        }
        if (myParseInt(month) < 1 || myParseInt(month) > 12)
        {
            rdShowMessageDialog("�µĸ�ʽ������Ч�·�Ӧ����01-12֮�䣬���������룡");
  	   //obj.value="";
            obj.select();
            obj.focus();
            return false;
        }
        if (myParseInt(day) < 1 || myParseInt(day) > 31)
        {
            rdShowMessageDialog("�յĸ�ʽ������Ч����Ӧ����01-31֮�䣬���������룡");
	   //obj.value="";
            obj.select();
            obj.focus();
            return false;
        }

        if (month == "04" || month == "06" || month == "09" || month == "11")
        {
            if (myParseInt(day) > 30)
            {
                rdShowMessageDialog("���·����30��,û��31�ţ�");
 	         //obj.value="";
                obj.select();
                obj.focus();
                return false;
            }
        }

        if (month == "02")
        {
            if (myParseInt(year) % 4 == 0 && myParseInt(year) % 100 != 0 || (myParseInt(year) % 4 == 0 && myParseInt(year) % 400 == 0))
            {
                if (myParseInt(day) > 29)
                {
                    rdShowMessageDialog("������·����29�죡");
      	     //obj.value="";
                    obj.select();
                    obj.focus();
                    return false;
                }
            }
            else
            {
                if (myParseInt(day) > 28)
                {
                    rdShowMessageDialog("��������·����28�죡");
      	     //obj.value="";
                    obj.select();
                    obj.focus();
                    return false;
                }
            }
        }
    }
    return true;
}


function myParseInt(nu)
{
    var ret = 0;
    if (nu.length > 0)
    {
        if (nu.substring(0, 1) == "0")
        {
            ret = parseInt(nu.substring(1, nu.length));
        }
        else
        {
            ret = parseInt(nu);
        }
    }
    return ret;
}
</script>
</head>
<body>
<form name="frm" method="POST">
<%@ include file="/npage/include/header.jsp" %>
<input type="hidden" name="activePhone" value="<%=activePhone%>">
<input type="hidden" name="cust_info">
<input type="hidden" name="opr_info">
<input type="hidden" name="note_info1">
<input type="hidden" name="note_info2">
<input type="hidden" name="note_info3">
<input type="hidden" name="note_info4">
<input type="hidden" name="printcount">
<input type="hidden" name="ReqPageName" id="ReqPageName" value="s1219Main">
<input type="hidden" name="cust_id" id="cust_id" value="<%=initStr_1[0][0].trim()%>">
<input type="hidden" name="srv_no" id="srv_no" value="<%=srv_no%>">
<input type="hidden" name="sm_name" id="sm_name" value="<%=initStr_1[0][2].trim()%>">
<input type="hidden" name="cust_name" id="cust_name" value="<%=initStr_1[0][3].trim()%>">
<input type="hidden" name="iccid" id="iccid" value="<%=initStr_1[0][14].trim()%>">
<input type="hidden" name="comm_addr" id="comm_addr" value="<%=initStr_1[0][11].trim()%>">
<input type="hidden" name="userPrepay" id="userPrepay" value="<%=initStr_1[0][16].trim()%>">
<input type="hidden" name="vSmCode" value="<%=initStr_1[0][1].trim()%>">
<input type="hidden" name="transFeeCode" id="transFeeCode">
<input type="hidden" name="transFeeName" id="transFeeName">
<input type="hidden" name="oriHandFee" id="oriHandFee" value="<%=oriHandFee.trim()%>">
<input type="hidden" name="loginAccept" value="<%=loginAccept%>">
<input type=hidden name=simBell
       value="   �ֻ�������ѡ�ײ��Żݵ�GPRS������ָCMWAP�ڵ����������.  �������أ�1.��������꿨,�ͼ�ֵ88Ԫ������ء�  2.��½������ɣ�wap.hljmonternet.com��ʹ���ֻ�����������ͼ�����ء�������Ѷ�����������������������������ʱ������,������Ϣ�ѣ�����1860��ͨGPRS ��">
<input type=hidden name=worldSimBell
       value="    �������ҵ��󣬼���Ϊ�ҹ�˾ȫ��ͨǩԼ�ͻ�����ǩԼ������ʹ���ҹ�˾ҵ�񼰲�Ʒ��ͬʱִ���µ����������ߡ������ɵ�Ԥ�����������������������ϣ�ͬʱ�������Ļ����ڻ���ʹ�����޺󷽿�ʹ�á�       ��Э����Ч�������������ʷѱ�׼�������������µ��ʷ�����ִ�С�       ��Ϊȫ��ͨ�ͻ������������ҹ�˾Ϊ���ṩ��������">

<div class="title">
    <div id="title_zi">�û���Ϣ</div>
</div>
<table cellspacing="0">
<tr>
    <td class="blue">��ͻ���־</td>
    <td nowrap colspan="2">
        <b><font class="orange"><%=cardName%>
        </font></b>
    </td>
    <td class="blue" nowrap>���ű�־</td>
    <td nowrap colspan="2">
        <%=grpName%>
    </td>
</tr>
<tr>
    <td class="blue" nowrap>�û�ID</td>
    <td nowrap colspan="2"><%=initStr_1[0][0].trim()%>
    </td>
    <td class="blue" nowrap>�ͻ�����</td>
    <td nowrap colspan="2"><%=initStr_1[0][3].trim()%>
    </td>
</tr>
<tr>
    <td class="blue" nowrap>��ǰ״̬</td>
    <td nowrap colspan="2"><%=initStr_1[0][6].trim()%>
    </td>
    <td nowrap class="blue">����</td>
    <td nowrap colspan="2"><%=initStr_1[0][8].trim()%>
    </td>
</tr>


<tr>
    <td class="blue" nowrap>֤������</td>
    <td nowrap colspan="2"><%=initStr_1[0][13].trim()%>
    </td>
    <td class="blue" nowrap>֤������</td>
    <td nowrap colspan="2"><%=initStr_1[0][14].trim()%>
    </td>
</tr>


<tr>
    <td class="blue" nowrap>��ǰԤ��</td>
    <td nowrap colspan="2"><%=initStr_1[0][16].trim()%>
    </td>
    <td class="blue" nowrap>��ǰǷ��</td>
    <td nowrap colspan="2"><%=initStr_1[0][15].trim()%>
    </td>
</tr>

<tr style="display:none ">
    <td class="blue" nowrap>����������</td>
    <td nowrap colspan="2">
        <input name=assuName v_must=0 v_maxlength=30 v_type="string" v_name="����������" maxlength="30"
               size=20 index="0" value="<%=initStr_1[0][19].trim()%>">
    </td>
    <td class="blue" nowrap>�����˵绰</td>
    <td nowrap colspan="2">
        <input name=assuPhone v_must=0 v_maxlength=20 v_type="string" v_name="�����˵绰" maxlength="20"
               size=20 index="1" value="<%=initStr_1[0][20].trim()%>">
    </td>
</tr>
<tr style="display:none ">
    <td class="blue" nowrap>������֤������</td>
    <td nowrap colspan="2">
        <select name="assuIdType" id="assuIdType" index="2">
            <%
                String sqlStr = "select trim(ID_TYPE), ID_NAME,ID_NAME from sIdType order by id_type";
            %>
            <wtc:pubselect name="sPubSelect" routerKey="phone" routerValue="<%=srv_no%>" outnum="3">
                <wtc:sql><%=sqlStr%>
                </wtc:sql>
            </wtc:pubselect>
            <wtc:array id="result" scope="end"/>
            <%
                int recordNum = result.length;
                for (int i = 0; i < recordNum; i++) {
                    if (result[i][0].trim().equals(initStr_1[0][21].trim())) {
                        out.println("<option value='" + result[i][0] + "' selected>" + result[i][1] + "</option>");
                    } else {
                        out.println("<option value='" + result[i][0] + "'>" + result[i][1] + "</option>");
                    }
                }
            %>
        </select>
    </td>
    <td class="blue" nowrap style="display:none ">������֤������</td>
    <td nowrap colspan="2">
        <input name=assuId index="3" value="<%=initStr_1[0][22].trim()%>">
    </td>
</tr>
<tr style="display:none ">
    <td class="blue" nowrap>������֤����ַ</td>
    <td nowrap colspan="5">
        <input name=assuIdAddr size=60 index="4" value="<%=initStr_1[0][23].trim()%>">
    </td>
</tr>
<tr style="display:none ">
    <td class="blue" nowrap>��������ϵ��ַ</td>
    <td nowrap colspan="5">
        <input name=assuAddr index="5" value="<%=initStr_1[0][24].trim()%>">
    </td>
</tr>
<tr style="display:none">
    <td class="blue" nowrap>�����˱�ע��Ϣ</td>
    <td nowrap colspan="5">
        <input name=assuNote0 index="6" value="<%=initStr_1[0][25].trim()%>">
    </td>
</tr>
</table>

</div>
<div id="Operation_Table">
<div class="title">
    <div id="title_zi">�����ϸ</div>
</div>
<table cellspacing="0" id="tr_iframe">
<tr align="center">
    <th>ѡ��</th>
    <th>����</th>
    <th>����</th>
    <th>�·�</th>
    <th>Ԥ��</th>
    <th>��ʼʱ��</th>
    <th>����ʱ��</th>
    <th>��ͨ��־</th>
    <th>���Ӻ���</th>
</tr>
<%
    boolean chk = false;
    boolean dis = false;
    int j = 0;
    int k = 0;
    String tbclass = "";
    for (int i = 0; i < srvStr.length; i++) {
        if (i % 2 == 0) {
            tbclass = "Grey";
        } else {
            tbclass = "";
        }
        chk = false;
        dis = false;
        for (j = 0; j < initStr_2.length; j++) {
            if (initStr_2[j][0].equals(srvStr[i][0])) {
                chk = true;
                break;
            }
        }
        for (k = 0; k < initStr_3.length; k++) {
            if (initStr_3[k][0].equals(srvStr[i][0])) {
                dis = true;
                break;
            }
        }
%>
<tr align="center" <%=insertImpPrompt[i]%>>
<td nowrap width="6%" class="<%=tbclass%>">
    <div align="center">
        <!----------s-----ѡ���-------------------->
        <%
            if (chk) {
                out.println("<input type=hidden name=Id_type id=Id_type value='mod'>");
                out.println("<input type=hidden name=Id_Checked id=Id_Checked value=1>");
                out.println("<input type=hidden name=Id_shortno id=Id_shortno value='" + srvStr[i][5].trim() + "'>");

                //if(dis || (!srvStr[i][0].trim().equals("27") && !srvStr[i][0].trim().equals("03") && !srvStr[i][0].trim().equals("05") && !srvStr[i][0].trim().equals("24")))
                if (dis) {
                    srvStrIndex = i;
        %>
        <input type="checkbox" name="ck_1" value="<%=i%>" checked disabled onclick="bnk('<%=i%>')">
        <%
        } else {
            srvStrIndex = i;
        %>
        <input type="checkbox" name="ck_1" value="<%=i%>" checked onclick="bnk('<%=i%>')" classCode="10431"  classValue="11">
        <%
            }
        } else {
            out.println("<input type=hidden name=Id_type id=Id_type value=''>");
            out.println("<input type=hidden name=Id_Checked id=Id_Checked value=0>");
            out.println("<input type=hidden name=Id_shortno id=Id_shortno value='" + srvStr[i][5].trim() + "'>");

            //if(dis || (!srvStr[i][0].trim().equals("27") && !srvStr[i][0].trim().equals("03") && !srvStr[i][0].trim().equals("05") && !srvStr[i][0].trim().equals("24")))
            if (dis) {
                srvStrIndex = i;
        %>
        <input type="checkbox" name="ck_1" value="<%=i%>" disabled onclick="bnk('<%=i%>')" classCode="10431"  classValue="11">
        <%
        } else {
            srvStrIndex = i;
        %>
        <input type="checkbox" name="ck_1" value="<%=i%>" onclick="bnk('<%=i%>')" classCode="10431"  classValue="11">
        <%
                }
            }
        %>
        <!----------e-----ѡ���-------------------->
    </div>
</td>
<td nowrap width="7%" class="<%=tbclass%>">
    <div align="center">
        <input class=button2 type=text name=t_srvno size=5 value="<%=srvStr[i][0].trim()%>" readonly>
    </div>
</td>
<td class="<%=tbclass%>" nowrap>
    <div align="center"><%=srvStr[i][1].trim()%>
    </div>
    <input type=hidden class=button2 type="text" name="t_func_name" size="10" value="<%=srvStr[i][1]%>" readonly>
</td>
<td nowrap width="8%" class="<%=tbclass%>">
    <div align="center"><%=srvStr[i][2].trim()%>
    </div>
</td>
<td nowrap width="8%" class="<%=tbclass%>">
    <!--<div align="center"><%=srvStr[i][3].trim()%></div> -->
    <input class=button2 type=text name=t_prepay size=5 value="<%=srvStr[i][3].trim()%>" readonly>
    <%
    System.out.println(srvStr[i][3].trim());
    %>
</td>
<td nowrap width="14%" class="<%=tbclass%>">
    <div align="center">
        <!----------s-----��ʼʱ��-------------------->
        <%
            if (chk) {
                if (dis) {
        %>
        <input type="text" name="t_st" size="10" value="<%=initStr_2[j][3]%>" onKeyUp="chgSt('<%=i%>')"
               disabled>
        <%
        } else {
        %>
        <input type="text" name="t_st" size="10" value="<%=initStr_2[j][3]%>" onKeyUp="chgSt('<%=i%>')"
               maxlength=8 v_must=0 v_maxlength=8 v_type=date v_name=��ʼʱ��>
        <%
            }
        } else {
            if (dis) {
        %>
        <input type="text" name="t_st" size="10" onKeyUp="chgSt('<%=i%>')" value="" disabled>
        <%
        } else {
        %>
        <input type="text" name="t_st" size="10" onKeyUp="chgSt('<%=i%>')" value="" maxlength=8 v_must=0
               v_maxlength=8 v_type=date v_name=��ʼʱ��>
        <%
                }
            }
        %>
        <!----------e-----��ʼʱ��-------------------->
    </div>
</td>
<td nowrap width="14%" class="<%=tbclass%>">
    <div align="center">
        <!----------s-----����ʱ��-------------------->
        <%
            if (chk) {
                if (dis) {
        %>
        <input type="text" name="t_et" size="10" value="<%=initStr_2[j][4]%>" onKeyUp="chgEt('<%=i%>')"
               disabled>
        <%
        } else {
        %>
        <input type="text" name="t_et" size="10" value="<%=initStr_2[j][4]%>" onKeyUp="chgEt('<%=i%>')"
               maxlength=8 v_must=0 v_maxlength=8 v_type=date v_name=����ʱ��>
        <%
            }
        } else {
            if (dis) {
        %>
        <input type="text" name="t_et" size="10" onKeyUp="chgEt('<%=i%>')" value="" disabled>
        <%
        } else {
        %>
        <input type="text" name="t_et" size="10" onKeyUp="chgEt('<%=i%>')" value="" maxlength=8 v_must=0
               v_maxlength=8 v_type=date v_name=����ʱ��>
        <%
                }
            }
        %>
        <!----------e-----����ʱ��-------------------->
    </div>
</td>
<td nowrap width="9%" class="<%=tbclass%>">
    <div align="center">
        <!----------s-----��ͨ״̬-------------------->
        <%
            if (chk) {
                if (initStr_2[j][2].equals("0"))
                    out.println("<input class=button2 type=text name=t_flag size=5 value=ԤԼ readonly>");
                else
                    out.println("<input class=button2 type=text name=t_flag size=5 value=��ͨ readonly>");
            } else {
                out.println("<input class=button2 type=text name=t_flag size=5 readonly value=''>");

            }
        %>
        <!----------e-----��ͨ״̬-------------------->
    </div>
</td>
<td nowrap width="18%" class="<%=tbclass%>">
    <div align="center">
        <!----------s-----�̺���-------------------->
        <%
            if (chk) {
                if (srvStr[i][5].equals("Y")) {
        %>
        <input class="text_likeDisabled" type="text" name="t_hao" size="10" value="<%=initStr_2[j][1].trim()%>"
               readonly>
        <%
        } else {
        %>
        <input class="likebutton2" type="text" name="t_hao" size="10" value="<%=initStr_2[j][1].trim()%>" readonly>
        <%
            }
        } else {
            if (srvStr[i][5].equals("Y")) {
        %>
        <input type="text" name="t_hao" size="10" onkeyup="chgStatus('<%=i%>')" value="">
        <%
        } else {
        %>
        <input class="likebutton2" type="text" name="t_hao" size="10" onkeyup="chgStatus('<%=i%>')" value="" readonly>
        <%
                }
            }
        %>
        <!----------e-----�̺���-------------------->
        <!----------s-----��ѯ��ť-------------------->
        <%
            if (!chk && !dis) {
                if (srvStr[i][5].equals("Y")) {
        %>
        <input type="button" class="b_text" name="b_hao" id="b_hao" value="��ѯ" onclick="qry('<%=i%>')">
        <%
                }
            }
        %>
        <!----------e-----��ѯ��ť-------------------->
    </div>
</td>
</tr>
<%
    }
%>
</table>
</div>
<div id="Operation_Table">
    <div class="title">
        <div id="title_zi">ҵ�����</div>
    </div>
    <table cellspacing="0">
        <tr>
            <td class="blue" nowrap>������</td>
            <td nowrap>
                <input type="text" name="t_handFee" id="t_handFee" size="16"
                       value="<%=(oriHandFee.trim().equals(""))?("0"):(oriHandFee.trim()) %>" v_type=float v_name="������"
                       <%if(hfrf){%>readonly<%}%> onblur="ChkHandFee()">
            </td>
            <td class="blue" nowrap>ʵ��</td>
            <td nowrap>
                <input type="text" name="t_factFee" id="t_factFee" size="16" onKeyUp="getFew()"
                       v_type=float
                       v_name="ʵ��" <%
                                        if(hfrf)
                                        {									
                                      
                %>
                       readonly
                <%
                                        }
                %>
                        >
            </td>
            <td class="blue" nowrap>����</td>
            <td class="blue" nowrap>
                <input type="text" name="t_fewFee" id="t_fewFee" size="16" readonly>
            </td>
        </tr>
        <tr>
            <td class="blue" nowrap>ϵͳ��ע</td>
            <td nowrap colspan="5">
                <input type="text" name="t_sys_remark" id="t_sys_remark" size="60" maxlength=30 readonly>
            </td>
        </tr>
        <tr style="display:none">
            <td class="blue" nowrap>�û���ע</td>
            <td nowrap colspan="5">
                <input type="text" name="t_op_remark" id="t_op_remark" size="60" v_maxlength=60
                       v_type=string
                       v_name="�û���ע" maxlength=60>
            </td>
        </tr>
        <tr>
            <td class="blue" nowrap>�û���ע</td>
            <td nowrap colspan="5">
                <input name=assuNote v_must=0 v_maxlength=60 v_type="string" v_name="�û���ע" maxlength="60"
                       size=60
                       index="6" value="">
            </td>
        </tr>
        <tr>
            <td colspan="7" id="footer">
                <input class="b_foot" type="button" name="b_print" value="ȷ��&��ӡ" onClick="printCommit();">
                <input class="b_foot" type="button" name="b_clear" value="���" onClick="frm.reset();">
            </td>
        </tr>
    </table>


    <input type="hidden" name="radio2" value="�𾴵��û��������ҹ�˾�µ׳��ʣ�����������ʾԤԼȡ�����û���ԤԼȡ���������һ����18:00 �������賿û��������ʾ���ܡ������½⣡">
    <input type="hidden" name="radio3" value="">
    <input type="hidden" name="ldtxbz" value="">
    <input type=hidden name=delStr id=delStr>
    <input type=hidden name=modValidStr id=modValidStr>
    <input type=hidden name=modInvalidStr id=modInvalidStr>
    <input type=hidden name=addValidStr id=addValidStr>
    <input type=hidden name=addInvalidStr id=addInvalidStr>
    <input type=hidden name=addShortnoStr id=addShortnoStr>
    <input type=hidden name=strTmp size=60 value="">
    <input type=hidden name=strLengthTmp size=60 value="40">
    <input type=hidden name=strTranTmp size=60 value="">
    <input type=hidden name=strCancelPreName size=100 value="">
    <input type=hidden name=strCancelPreTime size=100 value="">
    <input type=hidden name=favPrePay value="<%=favPrePay%>">

    <%@ include file="/npage/include/footer.jsp" %>
</form>
</body>
</html>
