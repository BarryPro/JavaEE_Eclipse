 <%
	System.out.println("###################zhanghongzhanghong################System.currentTimeMillis()->"+System.currentTimeMillis());
%>
<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-20 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%String Readpaths = request.getRealPath("npage/properties")+"/getRDMessage.properties";%>
<html>
<HEAD>
<META http-equiv=Content-Type content="text/html; charset=GBK">
</HEAD>
<body>
<%
/** ע����������������ҳ���ı����λ�õ��Ⱥ�˳�����һ���ı���Ϊi1���Դ����ơ�
		���ֱ������������ݶԴ˱���ʹ�õ����壬����;��
*/%>
<%
		System.out.println("###################zhanghongzhanghong2################System.currentTimeMillis()->"+System.currentTimeMillis());
    String opCode = "1270";
		String opName = "���ʷѳ���";
		String opCode2 = (String)request.getParameter("opCode");
		String opName2 = (String)request.getParameter("opName");
		if (opCode2!= ""){
		    opCode = opCode2;
		    opName = opName2;
		}
		/* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 begin */
		String op_strong_pwd = (String) session.getAttribute("password");
	  /* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 end */
		String[][] favInfo = (String[][])session.getAttribute("favInfo");
		String workNo = (String)session.getAttribute("workNo");
		String workName = (String)session.getAttribute("workName");
		String subi20 = WtcUtil.repNull(request.getParameter("belong_code")).substring(0,2); //��������
		String groupId =(String)session.getAttribute("groupId");
		/**** tianyang add for pos start ****/
		String orgCode =(String)session.getAttribute("orgCode");
		String payType       = WtcUtil.repNull(request.getParameter("payType"));
		/*** ningtn ���̷��ڸ��� ���ڸ�������**/
		String installmentNum = WtcUtil.repNull(request.getParameter("installmentList"));
		System.out.println("========= ningtn installmentNum["+installmentNum+"]");
		if(payType.equals("")){
			payType="0";
		}
		String Response_time = WtcUtil.repNull(request.getParameter("Response_time"));
		String TerminalId    = WtcUtil.repNull(request.getParameter("TerminalId"));
		String Rrn           = WtcUtil.repNull(request.getParameter("Rrn"));
		String Request_time  = WtcUtil.repNull(request.getParameter("Request_time"));
		String monitorValue  = WtcUtil.repNull(request.getParameter("monitorValue"));
		/**** tianyang add for pos end ****/
		//-----------wanghyd----start------------//�����жϲ���Ϊ����ʵ���Ƶ��û�Ʒ��תΪ������Ʒ��ʱ���Ӳ������ֵ���ʾ������ֵΪ3ʱ��Ҫ������ϴ�ӡ��ʾ
		String smzvalue  = WtcUtil.repNull(request.getParameter("smzvalue"));
	  //-----------wanghyd------end----------//
		String ret_code1 = "";
		String ret_msg1 = "";
		String ipower_right = ((String)session.getAttribute("powerRight")).trim();                         //��½����Ȩ��
		String icust_id = WtcUtil.repNull(request.getParameter("i2"));                            //�ͻ�ID
		String iold_m_code = WtcUtil.repNull(request.getParameter("i16"));         //�����ײʹ��루�ϣ�
		if(iold_m_code.indexOf("-")!=-1){
			iold_m_code = iold_m_code.substring(0,iold_m_code.indexOf("-"));
		}
		System.out.println("=========ipower_right=========="+ipower_right);
		System.out.println("###################iold_m_codeiold_m_codeiold_m_codeiold_m_codeiold_m_code="+iold_m_code);
		String inew_m_code = WtcUtil.repNull(request.getParameter("ip"));             					  //�������ײʹ���(��)
		System.out.println("-----------------inew_m_code-------------------"+inew_m_code);
		String ibelong_code = WtcUtil.repNull(request.getParameter("belong_code"));   						//belong_code
		String print_note = WtcUtil.repNull(request.getParameter("print_note"));      						//��������
		String iop_code = WtcUtil.repNull(request.getParameter("iOpCode"));                       //����,�ǳ���Ҫ
		System.out.println("12703-----------------iop_code-------------------"+iop_code);

		String next_mode = WtcUtil.repNull(request.getParameter("next_mode"));
		System.out.println("-----------------next_mode-------------------"+next_mode);
		String NextNew_m_code = WtcUtil.repNull(request.getParameter("Nmode_code"));
		System.out.println("-----------------NextNew_m_code-------------------"+NextNew_m_code);
		String nextName = "",new_smCode="";

		if(iop_code == "1200"){
			String next_begin = WtcUtil.repNull(request.getParameter("next_begin"));				//�µ��ʷѿ�ʼʱ��
		}
		String e505_sale_name = ""; //liujian �׶λ����
		String sale_name = ""; //liujian �׶λ����
		String new_Mode_Name = WtcUtil.repNull(request.getParameter("new_Mode_Name")); //���ʷѴ��������
		System.out.println("-----------------new_Mode_Name-------------------"+new_Mode_Name);
		opCode=iop_code;
		String regionCode = ibelong_code.substring(0,2);
		String sqlStr2 = "";
		String erpi = "";
		String note="";
		String note1="";
		String daima = "";
		String erpi_flag=WtcUtil.repNull(request.getParameter("flag_code"));
		System.out.println("erpi_flag="+erpi_flag);
		System.out.println("###################zhanghongzhanghong3################System.currentTimeMillis()->"+System.currentTimeMillis());
		//���Ӳ���������վԤԼ��ǰ̨���� ningtn
		String banlitype =request.getParameter("banlitype");
			erpi = erpi_flag;
			String[] inParas = new String[]{""};
			inParas = new String[3];
			inParas[0] = regionCode;
			inParas[1] = inew_m_code;
			inParas[2] = erpi;
			//value = viewBean.callService("0", null, "s1270ModeNote", "7", inParas);
			System.out.println("###################zhanghongzhanghong7################System.currentTimeMillis()->"+System.currentTimeMillis());
%>
		<wtc:service name="s1270NoteNew" routerKey="region" routerValue="<%=regionCode%>" outnum="7" >
			<wtc:param value=""/>
			<wtc:param value="01"/>
			<wtc:param value="<%=iop_code%>"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=op_strong_pwd%>"/>
			<wtc:param value=""/>
			<wtc:param value=""/>
			<wtc:param value="<%=inParas[0]%>"/>
			<wtc:param value="<%=inParas[1]%>"/>
			<wtc:param value="<%=inParas[2]%>"/>
			<wtc:param value="<%=groupId%>"/>
		</wtc:service>
		<wtc:array id="result3" scope="end"/>
<%

	System.out.println("###################zhanghongzhanghong8################System.currentTimeMillis()->"+System.currentTimeMillis());
			if(result3!=null){
				if(result3.length>0){
						String before_mode_note = result3[0][4];
						String after_mature_note = result3[0][6];
						daima = daima +" "+erpi;
						note= note+" "+before_mode_note;
						note1 = note1+" "+after_mature_note;
						System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
						System.out.println("before_mode_note="+before_mode_note);
						System.out.println("note="+note);
				}
			}

		note = note.replaceAll("\"","");
		note = note.replaceAll("\'","");
		note = note.replaceAll("\r\n","");
		note1 = note1.replaceAll("\"","");
		note1 = note1.replaceAll("\'","");


		String tbselect = "";

		/**********���ñ�ͷ**************/
		String titleStr="";
		String showFlag = "style=\"display:block\"";
		if(iop_code.equals("1198"))
		{
			titleStr = "�����������ײ���ǩ����";
			showFlag = "style=\"display:none\"";
		}else if(iop_code.equals("1200"))
		{
		   titleStr = "�����������ײ���ǩ";
           showFlag = "style=\"display:none\"";
		}else if(iop_code.equals("1205"))
		{
		   titleStr = "�����������ײ�";
		}else if(iop_code.equals("1206"))
		{
		   titleStr = "��������������";
           showFlag = "style=\"display:none\"";
		}else if(iop_code.equals("1207"))
		{
		   titleStr = "����������ȡ��";
		}else if(iop_code.equals("126b"))
		{
		   titleStr = "Ԥ�滰������";
		}
		else if(iop_code.equals("126c"))
		{
		   titleStr = "Ԥ�滰����������";
		   showFlag = "style=\"display:none\"";
		}else if(iop_code.equals("8034"))
		{
		   titleStr = "������ũ�塢�ֻ������";
		}
		else if(iop_code.equals("8035"))
		{
		   titleStr = "������ũ�塢�ֻ�����ҳ���";
		    showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("8070"))
		{
		   titleStr = "�¸���Ϣ��Ӫ����";
		}
		else if(iop_code.equals("8071"))
		{
		   titleStr = "�¸���Ϣ��Ӫ��������";
		    showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("8042"))
		{
		   titleStr = "Ԥ�����ֻ������ѹ�����";
		}
		else if(iop_code.equals("8043"))
		{
		   titleStr = "Ԥ�����ֻ������ѹ��������";
		    showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("7671"))
		{
		   titleStr = "Ԥ�����̻������ѿɷ���";
		}
		else if(iop_code.equals("7672"))
		{
		   titleStr = "Ԥ�����̻������ѿɷ������";
		    showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("8044"))
		{
		   titleStr = "������ũ���������ֻ�Ӫ��";
		}
		else if(iop_code.equals("8045"))
		{
		   titleStr = "������ũ���������ֻ�Ӫ������";
		    showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("126h"))
		{
		   titleStr = "ǩԼ����";
		}
		else if(iop_code.equals("126i"))
		{
		   titleStr = "ǩԼ��������";
		   showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("7960"))
		{
		   titleStr = "����Ӫ��������";
		}
		else if(iop_code.equals("7964"))
		{
		   titleStr = "����Ӫ��������";
		}
		else if(iop_code.equals("7965"))
		{
		   titleStr = "����Ӫ������ǩ";
		}
		else if(iop_code.equals("7966"))
		{
		   titleStr = "����Ӫ������ǩ����";
		}
		else if(iop_code.equals("7967"))
		{
		   titleStr = "����Ӫ����ȡ��";
		}
		else if(iop_code.equals("8023"))
		{
		   titleStr = "���ſͻ�Ԥ����������";
		}
		else if(iop_code.equals("8024"))
		{
		   titleStr = "���ſͻ�Ԥ����������";
		   showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("8094"))
		{
		   titleStr = "��������ʷ�Ӫ��������";
		}
		else if(iop_code.equals("8091"))
		{
		   titleStr = "��������ʷ�Ӫ��������";
		   showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("2264"))
		{
		   titleStr = "���еش�ǩԼ����Ʒ";
		}

		else if(iop_code.equals("2265"))
		{
		   titleStr = "���еش�ǩԼ����Ʒ����";
		   showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("2281"))
		{
		   titleStr = "ǩԼ����Ʒ";
		}
		else if(iop_code.equals("2282"))
		{
		   titleStr = "ǩԼ����Ʒ����";
		   showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("2283"))
		{
		   titleStr = "ȫ��ͨǩԼ����";
		}
		else if(iop_code.equals("2284"))
		{
		   titleStr = "ȫ��ͨǩԼ�������";
		   showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("7371"))
		{
		   titleStr = "Ԥ���Ż���������Ӫ����";
		}
		else if(iop_code.equals("7374"))
		{
		   titleStr = "Ԥ���Ż���������Ӫ��������";
		   showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("7981"))
		{
		   titleStr = "��TD�̻���ͨ�ŷ�";
		}
		else if(iop_code.equals("7982"))
		{
		   titleStr = "��TD�̻���ͨ�ŷѳ���";
		   showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("8551"))
		{
		   titleStr = "��TD�̻���ͨ�ŷ�(��ͨ)";
		}
		else if(iop_code.equals("8552"))
		{
		   titleStr = "��TD�̻���ͨ�ŷ�(��ͨ)����";
		   showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("g068"))
		{
		   titleStr = "TD�̻��Ա�������";
		}
		else if(iop_code.equals("g069"))
		{
		   titleStr = "TD�̻��Ա�����������";
		   showFlag = "style=\"display:none\"";
		}		
		else if(iop_code.equals("7898"))
		{
		   titleStr = "Ԥ�滰����TD����̻�";
		}
		else if(iop_code.equals("7899"))
		{
		   titleStr = "Ԥ�滰����TD����̻�����";
		   showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("7688"))
		{
		   titleStr = "Ԥ�滰����TD����̻�(��ͨ)";
		}
		else if(iop_code.equals("7689"))
		{
		   titleStr = "Ԥ�滰����TD����̻�(��ͨ)����";
		   showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("8688"))
		{
		   titleStr = "TD�̻����ʷѱ��";
		}
		else if(iop_code.equals("8687"))
		{
		   titleStr = "TD����̻����ʷѱ��";
		}
		else if(iop_code.equals("7379"))
		{
		   titleStr = "Ԥ���Żݹ���Ӫ����";
		}
		else if(iop_code.equals("7382"))
		{
		   titleStr = "Ԥ���Żݹ���Ӫ��������";
		   showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("7975"))
		{
		   titleStr = "����Ӫ����";
		}
		else if(iop_code.equals("7976"))
		{
		   titleStr = "����Ӫ��������";
		   showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("7116"))
		{
		   titleStr = "���ݿ�����";
		}
		else if(iop_code.equals("7118"))
		{
		   titleStr = "���ݿ��������";
		   showFlag = "style=\"display:none\"";
		}
		else if(iop_code.equals("1208"))
		{
		   titleStr = "��̨��GPRS����";
		}else if(iop_code.equals("1253"))
		{
		   titleStr = "���Ŀ�����";
		}else if(iop_code.equals("1254"))
		{
		   titleStr = "���Ŀ�ȡ��";
		}else if(iop_code.equals("7977"))
		{
		   titleStr = "���������ϰ��Ŀ�����";
		}else if(iop_code.equals("7978"))
		{
		   titleStr = "���������ϰ��Ŀ�ȡ��";
		}else if(iop_code.equals("127a"))
		{
		   titleStr = "���ʷ�ԤԼȡ��";
		   showFlag = "style=\"display:none\"";
		}else if(iop_code.equals("127b"))
		{
		   titleStr = "���ʷѳ���";
		   showFlag = "style=\"display:none\"";
		}else if(iop_code.equals("125b"))
		{
		   titleStr = "�����������";
		}else if(iop_code.equals("125c"))
		{
		   titleStr = "��������������";
		   showFlag = "style=\"display:none\"";
		}else if(iop_code.equals("7117"))
		{
		   titleStr = "����ҵ�����ȡ��";
		}else if(iop_code.equals("7119"))
		{
		   titleStr = "�����������ȡ��";
		}else if(iop_code.equals("8046"))
		{
		   titleStr = "Ӫ����ȡ��";
		}else if(iop_code.equals("8027"))
		{
		   titleStr = "���ֻ�,�ͻ���";
		}else if(iop_code.equals("8028"))
		{
		   titleStr = "���ֻ�,�ͻ��ѳ���";
		}else if(iop_code.equals("e505"))
		{
		   titleStr = "��Լ�ƻ�����";
			 e505_sale_name = WtcUtil.repNull(request.getParameter("e505_sale_name"));
		   if(e505_sale_name == null) {
	    		e505_sale_name = "";
	  	 }
		}else if(iop_code.equals("e506"))
		{
		   titleStr = "��Լ�ƻ���������";
		   e505_sale_name = WtcUtil.repNull(request.getParameter("e505_sale_name"));
		   if(e505_sale_name == null) {
		   		e505_sale_name = "";
		  	}
		}else if(iop_code.equals("e528"))
		{
		   titleStr = "�Ա�����Լ�ƻ�";
			 sale_name = WtcUtil.repNull(request.getParameter("sale_name"));
		   if(sale_name == null) {
	    		sale_name = "";
	  	 }
		}else if(iop_code.equals("e529"))
		{
		   titleStr = "�Ա�����Լ�ƻ�����";
		   sale_name = WtcUtil.repNull(request.getParameter("sale_name"));
		   if(sale_name == null) {
		   		sale_name = "";
		  	}
		}
		else if(iop_code.equals("e720"))
		{
		   titleStr = "��������-�����ƻ�";
			 sale_name = WtcUtil.repNull(request.getParameter("sale_name"));
		   if(sale_name == null) {
	    		sale_name = "";
	  	 }
	  	 }
	  	else if(iop_code.equals("e721"))
		{
		   titleStr = "��������-�����ƻ�����";
			 sale_name = WtcUtil.repNull(request.getParameter("sale_name"));
		   if(sale_name == null) {
	    		sale_name = "";
	  	 }
	  	}else if(iop_code.equals("g122")){
		   titleStr = "��TD����̻���ͨ�ŷ�";
	  	}else if(iop_code.equals("g123")){
		   titleStr = "��TD����̻���ͨ�ŷѳ���";
	  	}else if(iop_code.equals("g124")){
		   titleStr = "��TD����̻���ͨ�ŷ�(��ͨ)";
	  	}else if(iop_code.equals("g125")){
		   titleStr = "��TD����̻���ͨ�ŷ�(��ͨ)����";
	  	}
		else
		{
		   titleStr = "���ʷѱ��SAAAA";
		}
		if(iop_code.equals("7960") || iop_code.equals("7965"))
		{
			/***********gonght add 2009-3-20 14:50:27 ***********/
		    //SPubCallSvrImpl co = new SPubCallSvrImpl();
			String  inputParsm [] = new String[1];
		    String sqlStr4 = "select offer_name from product_offer where  offer_id="+next_mode+"";
			inputParsm[0] = sqlStr4;
		%>
				<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
				<wtc:param value="<%=sqlStr4%>"/>
				</wtc:service>
				<wtc:array id="result0" scope="end" />
		<%
			nextName = WtcUtil.repNull(result0[0][0]);
			/***************gonght add end***************/
		if(iop_code.equals("7965"))
			inew_m_code = NextNew_m_code;
		String  inputParemeter [] = new String[1];
		String sqlString = "select sm_code from product_offer a,band b where a.band_id = b.band_id and a.offer_id="+inew_m_code+"";
		%>
		<wtc:service name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  outnum="1">
				<wtc:param value="<%=sqlString%>"/>
				</wtc:service>
				<wtc:array id="result1" scope="end" />
		<%
			new_smCode = WtcUtil.repNull(result1[0][0]);

		}
System.out.println("###################zhanghongzhanghong9################System.currentTimeMillis()->"+System.currentTimeMillis());
		/******************************׼������s1270Must��������ѭ���б�******************************/
		//getList_must = callView.s1270MustProcess(ipower_right,icust_id,iold_m_code, inew_m_code,ibelong_code,iop_code).getList();
%>
				<wtc:service name="s1270Must" routerKey="region" routerValue="<%=regionCode%>" outnum="18" >
					<wtc:param value=""/>
					<wtc:param value="01"/>
					<wtc:param value="<%=iop_code%>"/>
					<wtc:param value="<%=workNo%>"/>
					<wtc:param value="<%=op_strong_pwd%>"/>
					<wtc:param value=""/>
					<wtc:param value=""/>
					<wtc:param value="<%=ipower_right%>"/>
					<wtc:param value="<%=icust_id%>"/>
					<wtc:param value="<%=iold_m_code%>"/>
					<wtc:param value="<%=inew_m_code%>"/>
					<wtc:param value="<%=ibelong_code%>"/>
				</wtc:service>
				<wtc:array id="result_must" start="0" length="4" scope="end"/>
				<wtc:array id="result_must_2" start="4" length="12" scope="end"/>
<%
		System.out.println("###################zhanghongzhanghong10################System.currentTimeMillis()->"+System.currentTimeMillis());
		String zzfmc=""; //���ʷ�����
		if(result_must!=null&&result_must.length>0){
				ret_code1 = result_must[0][0];
    		ret_msg1 = result_must[0][1];
    		zzfmc = result_must[0][2];
    		tbselect = result_must[0][3]; //��Чʱ��,���ڹ�����ӡ
				System.out.println("----tbselect------lj---------tbselect=" + tbselect);    		
		}

	    //�Է�����Ϣ�Ŀ���
		if(ret_msg1.equals(""))
		{
			ret_msg1 = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(ret_code1));
			if( ret_msg1.equals("null"))
			{
				ret_msg1 ="δ֪������Ϣ";
			}
		}

		if(!ret_code1.equals("000000")){
%>
	<script language="JavaScript">
			var ret_code = "<%=ret_code1%>";
			var ret_msg = "<%=ret_msg1%>";
			rdShowMessageDialog("��ѯ����<br>������룺'<%=ret_code1%>'��<br>������Ϣ��'<%=ret_msg1%>'��");
			<%
				if(iop_code.equals("e505") || iop_code.equals("e506")) {
					String phone = WtcUtil.repNull(request.getParameter("i1")); 
			%>
					location = "/npage/se505/se505_login.jsp?activePhone=<%=phone%>&opCode=<%=iop_code%>&opName=<%=opName%>";
			<%
				}else if(iop_code.equals("e528") || iop_code.equals("e529")) {
					String phone = WtcUtil.repNull(request.getParameter("i1")); 
			%>
					location = "/npage/se528/se528_login.jsp?activePhone=<%=phone%>&opCode=<%=iop_code%>&opName=<%=opName%>";
			<%
				}else if(iop_code.equals("e720") || iop_code.equals("e721")) {
					String phone = WtcUtil.repNull(request.getParameter("i1")); 
			%>
					location = "/npage/se720/fE720Login.jsp?activePhone=<%=phone%>&opCode=<%=iop_code%>&opName=<%=opName%>";
			<%
				}else {
			%>
					history.go(-1);
			<%		
				} 
			%>
  </script>
<%
		return;
		}

		//getList_must_1.add(0,getList_must.get(1));

    /*
		 ****�õ���Ч��ʽ
		 ****127a:���Է�ԤԼȡ��  127b�����Էѳ���  1204:���ݿ�����  k206�������������ײͳ��� 126c:Ԥ���������� 126i:ǩԼ�������� a207:�����������ײ�ȡ��
		
		if(iop_code.equals("127a")||iop_code.equals("127b")||iop_code.equals("1204")||iop_code.equals("1206")||iop_code.equals("126c")||iop_code.equals("126i")||iop_code.equals("125c")||iop_code.equals("7118")||iop_code.equals("1207")||iop_code.equals("7117")||iop_code.equals("7119")||iop_code.equals("8046")||iop_code.equals("7977")||iop_code.equals("7978")||iop_code.equals("7981")||iop_code.equals("7898")||iop_code.equals("g068")||iop_code.equals("7982")||iop_code.equals("7899")||iop_code.equals("g069")||iop_code.equals("7671")||iop_code.equals("7672")||iop_code.equals("8551")||iop_code.equals("8552")||iop_code.equals("7688")||iop_code.equals("7689"))
		{
		     tbselect = "0 24Сʱ֮����Ч";
		}
 **/
		/****�õ���ӡ��ˮ****/
		String printAccept="";
		System.out.println("###################zhanghongzhanghong11################System.currentTimeMillis()->"+System.currentTimeMillis());
%>
		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" id="sLoginAccept"/>
<%
		System.out.println("###################zhanghongzhanghong12################System.currentTimeMillis()->"+System.currentTimeMillis());
		printAccept = sLoginAccept;
		/****�õ���Чʱ��,���ڹ�����ӡ****/
		String exeDate="";
		String dateSqlStr="";
		String flag = "";
		System.out.println("-------------------------tbselect-----------------"+tbselect);
		flag = tbselect.substring(0,1);
	  if(flag.equals("0"))
	  {
		  if(iop_code.equals("1255") || iop_code.equals("1258"))
		  {
		    dateSqlStr = "select to_char(sysdate+1,'yyyymmdd')||' 0001' from dual";
		  }else{
		    dateSqlStr = "select to_char(sysdate,'yyyymmdd hh24mi') from dual";
		  }
	  }else if(flag.equals("2")){//ԤԼ��Ч
		  if(iop_code.equals("1258"))
		  {
		    dateSqlStr = "select to_char(sysdate+1,'yyyymmdd')||' 0001' from dual";
		  }else if(iop_code.equals("3530")){
				dateSqlStr = "select  to_char(add_months(sysdate,12),'yyyymmdd') from dual";
		  }else if(iop_code.equals("1141")){
				dateSqlStr = "select  to_char(add_months(sysdate,11),'yyyymm') from dual";
		  }else{
		    dateSqlStr = "select  to_char(add_months(sysdate,1),'yyyymm')||'01 0001' from dual";
		  }
	  }else if(flag.equals("1")){//�ڶ�����Ч
		    dateSqlStr = "select  to_char(sysdate+1,'yyyymm')||'01 0001' from dual";
	  }else{
	  		dateSqlStr = "select  to_char(sysdate+1,'yyyymm')||'01 0001' from dual";
	  }
	  System.out.println("dateSqlStr||||||||"+dateSqlStr);
	  System.out.println("###################zhanghongzhanghong13################System.currentTimeMillis()->"+System.currentTimeMillis());
%>
		<wtc:pubselect name="sPubSelect"  outnum="1">
		<wtc:sql><%=dateSqlStr%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="time_result_0" scope="end" />
<%
	System.out.println("###################zhanghongzhanghong15################System.currentTimeMillis()->"+System.currentTimeMillis());
	  if(time_result_0!=null&&time_result_0.length>0){
			exeDate  = time_result_0[0][0];
		}
		System.out.println("exeDate==============================+++++++"+exeDate);
%>
<%
	/******************new add*********************/
	String goodbz="";
	String phone_good=WtcUtil.repNull(request.getParameter("i1"));
	String modedxpay="";
	String sqlStrgood = "select mode_dxpay "+
  						 "from dgoodphoneres a, sGoodBillCfg b "+
 						 "where a.bill_code = b.mode_code "+
   						 " and b.region_code = '"+regionCode+"'"+
   						 " and a.phone_no = '"+phone_good+"' and b.valid_flag='Y' and a.bak_field='1' and end_time>sysdate and b.mode_dxpay>0";
  System.out.println("############################f1270_3->sqlStrgood->"+sqlStrgood);
	System.out.println("###################zhanghongzhanghong16################System.currentTimeMillis()->"+System.currentTimeMillis());
%>
		<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="1">
		<wtc:sql><%=sqlStrgood%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="resultx" scope="end" />
<%
		System.out.println("###################zhanghongzhanghong17################System.currentTimeMillis()->"+System.currentTimeMillis());
		if(resultx!=null&&resultx.length>0){
			if(resultx[0][0].equals(""))
			{
				goodbz="N";
			}else{
				goodbz="Y";
				modedxpay = resultx[0][0];
				System.out.println("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
				System.out.println(modedxpay);
			}
		}
		/***********************end*********************/
		String bdbz = "N";
		String bdts = "";
		/******************liucm add �ʷ���������ʾ********************/
		String back_bz="";
		String phoneno=WtcUtil.repNull(request.getParameter("i1"));
		if(iop_code.equals("127b")||iop_code.equals("127a")||iop_code.equals("k206")||iop_code.equals("a198")||iop_code.equals("126c")||iop_code.equals("126i")||iop_code.equals("8035")||iop_code.equals("125c")||iop_code.equals("2282")||iop_code.equals("2265")||iop_code.equals("2284")||iop_code.equals("7118")||iop_code.equals("8071")||iop_code.equals("8043")||iop_code.equals("8045"))
		{
		  back_bz="N";
		}else{
			back_bz="Y";
		}
		
		
			String[] inParas1 = new String[]{""};
			inParas1 = new String[4];
			inParas1[0] = regionCode;
			inParas1[1] = inew_m_code;
			inParas1[2] = back_bz;
			inParas1[3] = phoneno;
			//value1= viewBean1.callService("0", null, "sModeBindDet", "6", inParas1);
			System.out.println("###################zhanghongzhanghong18################System.currentTimeMillis()->"+System.currentTimeMillis());
%>
				<wtc:service name="sModeBindDet" routerKey="region" routerValue="<%=regionCode%>" outnum="6" >
					<wtc:param value=""/>
					<wtc:param value="01"/>
					<wtc:param value="<%=iop_code%>"/>
					<wtc:param value="<%=workNo%>"/>
					<wtc:param value=""/>
					<wtc:param value="<%=inParas1[3]%>"/>
					<wtc:param value=""/>
					<wtc:param value="<%=inParas1[0]%>"/>
					<wtc:param value="<%=inParas1[1]%>"/>
					<wtc:param value="<%=inParas1[2]%>"/>
				</wtc:service>
				<wtc:array id="result4" scope="end"/>
<%
		System.out.println("###################zhanghongzhanghong19################System.currentTimeMillis()->"+System.currentTimeMillis());
		if(result4!=null&&result4.length>0){
			String return_code1 = result4[0][0];
			String return_msg1 = result4[0][1];
			bdbz = result4[0][4];
			bdts = result4[0][5];
			System.out.println("lcmlcmlcmlcmlcmbdbz="+bdbz);
			System.out.println("lcmlcmlcmlcmlcmbdts="+bdts);
		}
		/**************liucm add end ************/

			String loginNote="";
			String sqlStr9 = "select back_char1 from snotecode where region_code='"+regionCode+"' and op_code='XXXX'";
			System.out.println("###################zhanghongzhanghong20################System.currentTimeMillis()->"+System.currentTimeMillis());
%>
			<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="1">
			<wtc:sql><%=sqlStr9%></wtc:sql>
			</wtc:pubselect>
			<wtc:array id="result9" scope="end" />
<%
	System.out.println("###################zhanghongzhanghong21################System.currentTimeMillis()->"+System.currentTimeMillis());
      for(int i=0;i<result9.length;i++){
				 loginNote = (result9[i][0]).trim();
			}
			loginNote = loginNote.replaceAll("\"","");
			loginNote = loginNote.replaceAll("\'","");
			loginNote = loginNote.replaceAll("\r\n","   ");
			loginNote = loginNote.replaceAll("\r","   ");
			loginNote = loginNote.replaceAll("\n","   ");
%>
<%@ include file="/npage/include/header.jsp" %>
<form action="" method=post name="form1">
	    <input type="hidden" name="monitorValue" value="<%=monitorValue%>"/>
	    <input type="hidden" id="iInstNum" name="iInstNum" value=""/>
			<input type="hidden" name="e505_sale_name" id="e505_sale_name">
			<input type="hidden" name="sale_name" id="sale_name">
			<input type="hidden" name="mon_prepay_limit" id="mon_prepay_limit">
      <input type="hidden" name="cust_info">
      <input type="hidden" name="opr_info">
      <input type="hidden" name="note_info1">
      <input type="hidden" name="haseval">
      <input type="hidden" name="evalcode">
      <input type="hidden" name="note_info2">
      <input type="hidden" name="note_info3">
      <input type="hidden" name="note_info4">
      <input type="hidden" name="printcount">
			<!-- tianyang add at 20100201 for POS�ɷ�����*****start*****-->			
			<input type="hidden" name="payType"  value="<%=payType%>" ><!-- �ɷ����� payType=BX �ǽ��� payType=BY �ǹ��� -->			
			<input type="hidden" name="MerchantNameChs"  value=""><!-- �Ӵ˿�ʼ����Ϊ���в��� -->
			<input type="hidden" name="MerchantId"  value="">
			<input type="hidden" name="TerminalId"  value="">
			<input type="hidden" name="IssCode"  value="">
			<input type="hidden" name="AcqCode"  value="">
			<input type="hidden" name="CardNo"  value="">
			<input type="hidden" name="BatchNo"  value="">
			<input type="hidden" name="Response_time"  value="">
			<input type="hidden" name="Rrn"  value="">
			<input type="hidden" name="AuthNo"  value="">
			<input type="hidden" name="TraceNo"  value="">
			<input type="hidden" name="Request_time"  value="">
			<input type="hidden" name="CardNoPingBi"  value="">
			<input type="hidden" name="ExpDate"  value="">
			<input type="hidden" name="Remak"  value="">
			<input type="hidden" name="TC"  value="">
			<input type="hidden" name="transType"  value=""><!-- ���вཻ������ -->
			<input type="hidden" name="bMoney"  value=""><!-- ���׽�� -->
			<input type="hidden" name="transTotal" id="transTotal"  value=""><!-- �������� -->
			<!-- tianyang add at 20100201 for POS�ɷ�����*****end*******-->
			<input type="hidden" name="yhje_8046" id="yhje_8046"  value=""><!-- �ͻ��轻�ɵĲ����Żݽ�� -->
		<div class="title">
			<div id="title_zi">�û���Ϣ</div>
		</div>
      			<table cellspacing="0">
      				 <tr>
      				 	<td class="blue" width="15%">�������</td>
      				 	<td width="35%">
      				 		<input name="phone" class="InputGrey" readonly value="<%=WtcUtil.repNull(request.getParameter("i1"))%>" size="20">
      				 	</td>
      				 	<td class="blue" width="15%">�ͻ�����</td>
      				 	<td>
      				 		<input name="i4" size="20" maxlength=30 class="InputGrey" readonly value="<%=WtcUtil.repNull(request.getParameter("i4"))%>">
      				 	</td>
      				 	<!--����Ϊ����  �ͻ�ID���ͻ���ַ��֤���������ƣ�֤�����룬belong_code,-->
				 				<input type="hidden" name="i2" size="20"  value="<%=WtcUtil.repNull(request.getParameter("i2"))%>" maxlength=30  readonly >
				 				<input type="hidden" name="i5" size="60" maxlength=60 value="<%=WtcUtil.repNull(request.getParameter("i5"))%>" readonly>
				 				<!--�ͻ���ַ-->
				 				<input type="hidden" name="i6" size="20" maxlength=30 value="<%=WtcUtil.repNull(request.getParameter("i6"))%>" readonly>
				 				<!--֤������-->
 								<input type="hidden" name="i7" size="20" maxlength=30 value="<%=WtcUtil.repNull(request.getParameter("i7"))%>" readonly>
 								<!--֤������-->
 								<input type="hidden" name="belong_code" value="<%=WtcUtil.repNull(request.getParameter("belong_code"))%>">
 								<input type="hidden" name="maincash_no" value="<%=WtcUtil.repNull(request.getParameter("maincash_no"))%>">
 								<input type="hidden" name="kx_code_bunch">
 								<!--��ѡ�ʷѴ��봮-->
 								<input type="hidden" name="kx_habitus_bunch">
 								<!--��ѡ�ʷ�״̬��-->
 								<input type="hidden" name="kx_operation_bunch">
 								<!--��ѡ�ײ͵���Ч��ʽ��-->
 								<input type="hidden" name="kx_explan_bunch">
 								<!--��ѡ�ײ�˵��-->
 								<input type="hidden" name="kx_code_name_bunch">
 								<!--��ѡ�ײ�����-->
 								<input type="hidden" name="kx_erpi_bunch">
 								<!--��ѡ�ײͶ���-->
					      <input type="hidden" name="toprintdata">
					      <input type="hidden" name="stream" value="<%=printAccept%>">
					      <input type="hidden" name="handcash" value="<%=WtcUtil.repNull(request.getParameter("i19"))%>">
					      <input type="hidden" name="kx_stream_bunch"><!--ԭ��ѡ�ײ͵Ŀ�ͨ��ˮ��-->
					      <input type="hidden" name="main_cash_stream" value="<%=WtcUtil.repNull(request.getParameter("imain_stream"))%>">
					      <input type="hidden" name="next_main_cash" value="<%=WtcUtil.repNull(request.getParameter("i18"))%>">
					      <input type="hidden" name="next_main_stream" value="<%=WtcUtil.repNull(request.getParameter("next_main_stream"))%>">
					      <input type="hidden" name="kx_want"><!--��ӡ�������������--->
					      <input type="hidden" name="kx_cancle"><!--��ӡ������ȡ������--->
					      <input type="hidden" name="kx_running"><!--��ӡ�����п�ͨ���ײ�--->
					      <input type="hidden" name="i1" value="<%=WtcUtil.repNull(request.getParameter("i1"))%>"><!--���ǰһҳ�洫����phone_no--->
					      <input type="hidden" name="ipassword" value="<%=WtcUtil.repNull(request.getParameter("ipassword"))%>">
					      <!--���ǰһҳ�洫����password--->
					      <input type="hidden" name="iAddStr" value="<%=WtcUtil.repNull(request.getParameter("iAddStr"))%>">
					      <input type="hidden" name="iOpCode" value="<%=WtcUtil.repNull(request.getParameter("iOpCode"))%>">
					      <input type="hidden" name="opCode" value="<%=opCode%>">
		                  <input type="hidden" name="opName" value="<%=opName%>">
					      <input type="hidden" name="favorcode" value="<%=WtcUtil.repNull(request.getParameter("favorcode"))%>">
					      <!--���ǰһҳ�洫����favorcode--->
					      <input type="hidden" name="iAddRateStr" value="<%=WtcUtil.repNull(request.getParameter("iAddRateStr"))%>">
					      <!--���ǰһҳ�洫����iAddRateStr--->
					      <input type="hidden" name="beforeOpCode" value="<%=WtcUtil.repNull(request.getParameter("beforeOpCode"))%>">
					      <!--����ʱ���Ͷ�Ӧ����ҵ���opCode--->
						  <input type="hidden" name="modestr">
					  <input type ="hidden" name ="hljNotePrint" value="">
					  <input type="hidden" name="flag_code" value="<%=WtcUtil.repNull(request.getParameter("flag_code"))%>">
					  <input type="hidden" name="rateCode" value="<%=WtcUtil.repNull(request.getParameter("rate_code"))%>">
					  <input type="hidden" name="returnPage" value="<%=WtcUtil.repNull(request.getParameter("return_page"))%>">
					  <input type="hidden" name="next_begin" value="<%=WtcUtil.repNull(request.getParameter("next_begin"))%>">
					  <input type="hidden" name="ipAddr" value="<%=WtcUtil.repNull(request.getParameter("ipAddr"))%>">
					  <input type="hidden" name="banlitype" value="<%=banlitype%>">
                 </tr>

	      		 <tr>
					 <td class="blue" width="15%">���ſͻ����</td>
					 <td width="35%">
					   <input name="group_type" size="20" value="<%=WtcUtil.repNull(request.getParameter("group_type"))%>" class="InputGrey" readonly>
					 </td>
					 <td class="blue" width="15%">��ͻ����</td>
					 <td width="35%">
					   <font class="orange"><%=WtcUtil.repNull(request.getParameter("ibig_cust"))%></font>
					 </td>
			    </tr>
				  <tr>
					 <td class="blue">��ǰ���ײ�</td>
					 <td id="showHitz1">
					   <input name="i16" size="30" value="<%=WtcUtil.repNull(request.getParameter("i16"))%>" class="InputGrey" readonly>
					 </td>
					 <td class="blue">�������ײ�</td>
					 <td id="showHitz2">
					  <input name="i18" size="30" value="<%=WtcUtil.repNull(request.getParameter("i18"))%>" class="InputGrey" readonly>
					 </td>
				  </tr>

			  	<tr>
                 <td class="blue" width="15%">�������ײ�</td>
			     <td width="35%" id="showHitz">
                   <input type="text" name="ip" value="<%=WtcUtil.repNull(request.getParameter("ip"))%>" size="40" class="InputGrey" readonly >
			       <script>
			         document.all.ip.value=document.all.ip.value+' <%=zzfmc%>';
			       </script>
                 </td>
			     <td class="blue" width="15%">��Ч��ʽ</td>
			     <td width="35%">
			       <input type="text" name="tbselect" value="<%=tbselect%>" size="20" class="InputGrey" readonly v_must =1 v_name=��Ч��ʽ>
			     </td>
				</tr>
		      <%
			    String favorcode = WtcUtil.repNull(request.getParameter("favorcode"));
			    int m =0;
			    for(int p = 0;p< favInfo.length;p++){//�Ż��ʷѴ���
						for(int q = 0;q< favInfo[p].length;q++){
							 if(favInfo[p][q].trim().equals(favorcode)){
								   ++m;
							 }
						}
		          }
	 		  %>
		      		<tr>
		      <%
		      	if(m != 0){
		      %>
 					 <td class="blue" width="15%">������</td>
					 <td colspan="3">
					   <input name="i19" size="20" maxlength=20 value="<%=WtcUtil.repNull(request.getParameter("i19"))%>" v_must=1 v_name=������ v_type=float >
					   <input type="hidden" name="i20" size="20"maxlength=20 value="<%=WtcUtil.repNull(request.getParameter("i20"))%>" readonly v_name=���������>
					 </td>
					 <script language="jscript">
					   document.all.i19.focus();
					 </script>
		      <%
		      	}else{
		      %>
					 <td class="blue" width="15%">������</td>
					 <td colspan="3">
					   <input name="i19" size="20" maxlength=20 value="<%=WtcUtil.repNull(request.getParameter("i19"))%>" v_must=1 v_name=������ v_type=float class="InputGrey" readonly>
					   <input type="hidden" name="i20" size="20"maxlength=20 value="<%=WtcUtil.repNull(request.getParameter("i20"))%>" readonly v_name=���������>
					 </td>
		      <%
		      	}
		      %>
		      		</tr>
		      		<tr <%=showFlag%>>
								 <td class="blue" width="15%">��ѡ�ײ����</td>
								 <td colspan="3">
                          <%
								String sm_code = WtcUtil.repNull(request.getParameter("i8")).substring(0,2);//���ҵ��Ʒ��
								System.out.println("------------------------sm_code---------------------"+sm_code);
								String sqlStr="";
						        //sqlStr ="SELECT a.offer_attr_type, c.name, a.min_num, a.max_num  FROM product_offer a, product_offer_detail b , offer_category c  WHERE a.offer_id = b.offer_id AND a.offer_type = '40' and a.offer_attr_type NOT IN ('YnD3', 'YnD4') and a.offer_attr_type = c.offer_attr_type and c.region_code='"+WtcUtil.repNull(request.getParameter("belong_code")).substring(0,2)+"' and a.offer_id="+WtcUtil.repNull(request.getParameter("ip")).trim()+" ";

										sqlStr =" SELECT a.offer_detail_role_cd,d.mem_role_name,c.role_down_num,c.role_up_num,b.offer_attr_type  "
										+" FROM product_offer_detail a,product_offer b,PROD_OFFER_DETAIL_ROLE c, group_mbr_role d "
										+" WHERE a.element_type = '10C' "
										+" AND a.offer_id = "+WtcUtil.repNull(request.getParameter("ip")).trim()+" "
										+" AND a.sel_flag = '2' "
										+" AND a.state = 'A'  "
										+" AND a.element_id = b.offer_id"
										+" AND SYSDATE BETWEEN b.eff_date AND b.exp_date              "
										+" AND b.state = 'A' "
										+" and a.offer_detail_role_cd = c.offer_detail_role_cd "
										+" and b.offer_attr_type not in ('YnD3','YnD4') "
										+" and c.mem_role_cd = d.mem_role_cd "
										+" and exists (select 1 from product_offer_scene where op_code = '"+iop_code+"' and b.offer_id = offer_id)";
										if(sm_code.equals("gn")||sm_code.equals("hn")||sm_code.equals("dn")||sm_code.equals("d0")||sm_code.equals("cb")||sm_code.equals("zn"))
										{
											sqlStr +=" and b.band_id in('21','23','24')";
										}
										if(sm_code.equals("ip"))
										{
											sqlStr +=" and b.band_id in('29')";
										}
						        sqlStr +=" group by a.offer_detail_role_cd,d.mem_role_name,c.role_down_num,c.role_up_num, b.offer_attr_type";
						        System.out.println("yanpxsqlStr==="+sqlStr);
						        System.out.println("###################zhanghongzhanghong22################System.currentTimeMillis()->"+System.currentTimeMillis());
							 %>
	 							<wtc:pubselect name="sPubSelect"  routerKey="region" routerValue="<%=regionCode%>" outnum="5">
								<wtc:sql><%=sqlStr%></wtc:sql>
								</wtc:pubselect>
								<wtc:array id="result_select" scope="end" />
							    <%
							 		System.out.println("###################zhanghongzhanghong23################System.currentTimeMillis()->"+System.currentTimeMillis());
							        int recordNum = result_select.length;
							        System.out.println("recordNum����:"+sqlStr);
							        for(int i=0;i<recordNum;i++){
								        //System.out.println("wwwwwwwwwwwww");
										//System.out.println(result_select[i][0]);
										//System.out.println(result_select[i][1]);
									    out.println("<a Href='#' onClick='openwindow("+'"'+
									          +i+'"'+","+'"'+result_select[i][4]+'"'+","+'"'+result_select[i][1]+'"'+")'>"+result_select[i][0]+" "+result_select[i][1]+"</a>");
									    out.println("<input type=hidden name=oActualOpen value='0'>");    //ʵ�ʿ�ͨ����
										out.println("<input type=hidden name=oDefaultFlag value='N'>");   //�Ƿ���Ĭ�����������
										out.println("<input type=hidden name=oDefaultOpen value='N'>");   //�Ƿ�Ĭ�������Ƿ����һ������
										out.println("<input type=hidden name=oTypeValue value="+result_select[i][0]+">");
										out.println("<input type=hidden name=oTypeName value="+result_select[i][1]+">");
										out.println("<input type=hidden name=oMinOpen value="+result_select[i][2].trim()+">");
										out.println("<input type=hidden name=oMaxOpen value="+result_select[i][3].trim()+">");
							        }
                                  %>

						     </td>
						  </tr>
		   	</table>
		   </div>
			<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">�ײ���Ϣ</div>
			</div>
		   <table id=tr cellSpacing="0" style="display:block">
          <tr align="center">
	     		 <th <%=showFlag%> nowrap>ѡ��</th>
					 <th nowrap>��ѡ�ײ�����</th>
					 <th nowrap>״̬</th>
					 <th nowrap>��ʼʱ��</th>
					 <th nowrap>����ʱ��</th>
					 <th nowrap>�ײ����</th>
					 <th nowrap>��Ч��ʽ</th>
           <th nowrap>��ѡ��ʽ</th>
			  </tr>
			  <tr id="tr0" style="display:none">
			     <td><div align="center"><input type="checkbox" name="checkId" id="checkId"></div></td>
			     <td><div align="center"><input type="text" name="R0" value=""></div></td>
           		 <td><div align="center"><input type="text" name="R1" value=""></div></td>
			     <td><div align="center"><input type="text" name="R2" value=""></div></td>
			     <td><div align="center"><input type="text" name="R3" value=""></div></td>
			     <td><div align="center"><input type="text" name="R4" value=""></div></td>
			     <td><div align="center"><input type="text" name="R5" value=""></div></td>
			     <td>
					<div align="center">
						<input type="text" name="R6" value="">
						<input type="text" name="R7" value="">
						<input type="text" name="R8" value="">
						<input type="text" name="R9" value="">
						<input type="text" name="R10" value="">
						<input type="text" name="R11" value="">
						<input type="text" name="R12" value="">
					</div>
			     </td>
			  </tr>

         <%
					  	String[][] data= new String[][]{};
						  data = result_must_2;
        String test[][] = result_must_2;

        System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++");
        for(int outer=0 ; test != null && outer< test.length; outer++)
        {
                for(int inner=0 ; test[outer] != null && inner< test[outer].length; inner++)
                {
                        System.out.print(" | "+test[outer][inner]);
                }
                System.out.println(" | ");
        }
        System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++");
						  for(int y=0;y<data.length;y++)
						  {
						    String addstr = data[y][0] +"#" +data[y][1]+"#"+y;
			   %>
					  <tr id="tr<%=y+1%>" align="center">
         <%
         		if(data[y][data[0].length-1].equals("0") || data[y][data[0].length-1].equals("1")||data[y][data[0].length-1].equals("4")){//Ĭ������
         %>
							<td <%=showFlag%>><input type="checkbox" name="checkId" checked></td>
				 <%
				 		}

				 		if(data[y][data[0].length-1].equals("2")){//������
				 %>
							<td <%=showFlag%>>
								<input type="checkbox" name="checkId" checked onclick="if(document.all.checkId[<%=y%>+1].checked==false){ document.all.checkId[<%=y%>+1].checked=true;} rdShowMessageDialog('�����룡');return false;">
							</td>
				 <%
				 		}

				 		if(data[y][data[0].length-1].equals("a")){//Ĭ������������Чʱ������ʷʱ���ͻ����������
				 %>
							<td <%=showFlag%>>
								<input type="checkbox" name="checkId" onclick="if(document.all.checkId[<%=y%>+1].checked==true){document.all.checkId[<%=y%>+1].checked=false;} rdShowMessageDialog('Ĭ������������Чʱ������ʷʱ���ͻ���������룡');return false;">
							</td>
				 <%
				 		}

				 		if(data[y][data[0].length-1].equals("b")){//ǿ������������Чʱ������ʷʱ���ͻ����������
				 %>
							<td <%=showFlag%>>
								<input type="checkbox" name="checkId" onclick="if(document.all.checkId[<%=y%>+1].checked==true){document.all.checkId[<%=y%>+1].checked=false;} rdShowMessageDialog('ǿ������������Чʱ������ʷʱ���ͻ���������룡');return false;">
							</td>
				 <%
				 		}

				 		if(data[y][data[0].length-1].equals("d")){//ǿ��ȡ��
				 %>
							<td <%=showFlag%>>
								<input type="checkbox" name="checkId"disabled onclick="if(document.all.checkId[<%=y%>+1].checked==true ){document.all.checkId[<%=y%>+1].checked=false;} rdShowMessageDialog('ǿ��ȡ���������룡');return false;">
							</td>
				 <%
				 		}

				 		if(data[y][data[0].length-1].equals("9")){//����ȡ��
				 %>
							<td <%=showFlag%>>
								<input type="checkbox" name="checkId" checked onclick="if(document.all.checkId[<%=y%>+1].checked==false){document.all.checkId[<%=y%>+1].checked=true;} rdShowMessageDialog('�����ѡ�ʷѣ��뵽����ҵ��������');return false;">
							</td>
				 <%
				 		}

						for(int j=0;j<data[0].length+1;j++){
							 String tbstr="";
							 if(j==0)
								{
									tbstr = "<td><a Href='#' onClick='openhref("+'"'+data[y][7].trim()+'"'+")'>" +
									data[y][j].trim() + "</a><input type='hidden' " +
									" id='R" + j  + "' name='R" + j + "' class='button' value='" +
									(data[y][j]).trim() + "'readonly></td>";
								}
							 else if(j==1)
								{
									String habitus = "";
									if(data[y][j].trim().equals("Y"))habitus="�ѿ�ͨ";
									if(data[y][j].trim().equals("N"))habitus="δ��ͨ";
									 tbstr = "<td>" + habitus + "<input type='hidden' " +
									" id='R" + j  + "' name='R" + j + "' class='button' value='" +
									(data[y][j]).trim() + "'readonly></td>";
								}
							 else if(j>6&&j<12)
								{
									 tbstr = "<input type='hidden' " +
									" id='R" + j  + "' name='R" + j + "' class='button' value='" +
									(data[y][j]).trim() + "'readonly>";
								}
							 else if(j==12)
							   {
									tbstr = "<input type='hidden' " +
									" id='R" + j  + "' name='R" + j + "' class='button' value=' '>";
							   }
							  else
								{
									 tbstr = "<td>" + data[y][j].trim() + "<input type='hidden' " +
									" id='R" + j  + "' name='R" + j + "' class='button' value='" +
									(data[y][j]).trim() + "'readonly></td>";
								}
									out.println(tbstr);
						   }
				 %>
					  </tr>
			   <%
						}
         %>
	       </table>
			</div>

			<div id="Operation_Table">
			<div class="title">
				<div id="title_zi">��ע��Ϣ</div>
			</div>
           <table cellSpacing="0">
						  <tr>
							 <td class="blue">ϵͳ��ע</td>
							 <td colspan="3">
							   <input name="sysnote" size="100" class="InputGrey" readonly>
							 </td>
						  </tr>
						  <tr style="display:none">
						     <td class="blue">�û���ע</td>
							 <td>
								<input name="tonote" id="tonote" size="100" maxlength="60" value="<%=WtcUtil.repNull(request.getParameter("do_note"))%>" >
							 </td>
						  </tr>
	       		</table>

<!-- ningtn 2011-7-12 13:13:21 ������ӹ��� -->
<jsp:include page="/npage/public/hwReadCustCard.jsp">
	<jsp:param name="hwAccept" value="<%=printAccept%>"  />
	<jsp:param name="showBody" value="01"  />
</jsp:include>
       <table cellSpacing="0">
           <tbody>
              <tr>
                 <td id="footer">
					         <input class="b_foot" name=sure  type=button value="ȷ��&��ӡ" onclick="if(checknum(i19,i20)) if(senddata()) if(checksel()) if(check(form1)) printCommit();"> &nbsp;&nbsp;
					         <input class="b_foot" name=kkkk  onClick="removeCurrentTab()" type=button value=�ر�>&nbsp;&nbsp;
					         <input class="b_foot" name=kkkk  onClick="pageSubmit(1)" type=button value=����>
                 </td>
              </tr>
           </tbody>
       </table>
       <%@ include file="/npage/include/footer_new.jsp" %>
  </form>
  <frameset rows="0,0,0,0" cols="0" frameborder="no" border="0" framespacing="0" >
  <frame src="../common/evalControlFrame.jsp"    name="evalControlFrame" id="evalControlFrame" />
</frameset>
<noframes></noframes>

<!-- **** tianyang add for pos ******���ؽ��пؼ�ҳ BankCtrl ******** -->
<%@ include file="/npage/public/posCCB.jsp" %>
<!-- **** tianyang add for pos ******���ع��пؼ�ҳ KeeperClient ******** -->
<%@ include file="/npage/public/posICBC.jsp" %>

</body>
<%@ include file="/npage/public/hwObject.jsp" %>
</HTML>
<%/*------------------------javascript��----------------------------*/%>
<%

String tempStrV1 = WtcUtil.repNull(request.getParameter("ip"));
if(tempStrV1.indexOf(" ")!=-1){
tempStrV1 = tempStrV1.substring(0,tempStrV1.indexOf(" "));
}

String tempStrV2 = WtcUtil.repNull(request.getParameter("i16"));
if(tempStrV2.indexOf("-")!=-1){
tempStrV2 = tempStrV2.substring(0,tempStrV2.indexOf("-"));
}

String tempStrV3 = WtcUtil.repNull(request.getParameter("i18"));

if(tempStrV3.indexOf("-")!=-1){
tempStrV3 = tempStrV3.substring(0,tempStrV3.indexOf("-"));
}

%>
<script language="javascript">
	var offerIdV1 = "<%=tempStrV1%>";
	var offerIdV2 = "<%=tempStrV2%>";
	var offerIdV3 = "<%=tempStrV3%>";
	getMidPrompt("10442",offerIdV1,"showHitz");
	getMidPrompt("10442",offerIdV2,"showHitz1");
	getMidPrompt("10442",offerIdV3,"showHitz2");

  var oActualOpenObj = document.getElementsByName("oActualOpen"); //�����ж�
  var oDefaultFlagObj = document.getElementsByName("oDefaultFlag"); //�����ж�
  var oDefaultOpenObj = document.getElementsByName("oDefaultOpen"); //�����ж�
  var oTypeValueObj = document.getElementsByName("oTypeValue"); //�����ж�
  var oTypeNameObj = document.getElementsByName("oTypeName"); //�����ж�
  var oMinOpenObj = document.getElementsByName("oMinOpen"); //�����ж�
  var oMaxOpenObj = document.getElementsByName("oMaxOpen"); //�����ж�
  
  /**** tianyang add for AJAX�ص� start ****/
  function doProcess(packet)
 	{
			var verifyType = packet.data.findValueByName("verifyType");
			var sysDate = packet.data.findValueByName("sysDate");
			if(verifyType=="getSysDate"){
				document.all.Request_time.value = sysDate;
				return false;
			}
 	}
  /**** tianyang add for AJAX�ص� end ****/
  
/*--------------------------��ӡ���̺���---------------------------*/
/*function showPrtDlg()
{
	document.all.sure.disabled=true;
	document.all.sysnote.value=document.all.i16.value.substring(0,8)+document.all.tbselect.value.substring(2)+document.all.ip.value.substring(0,8);//����ҳ����ʾ��ϵͳ��ע
   /*����ģʽ�Ի��𣬲����û��������д���*/
/*    document.all.tonote.value = document.all.phone.value+ "���ʷѱ��";
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
}*/
/*-------------------------��ӡ�����ύ������-------------------*/
function conf()
{
   var h=200;
   var w=300;
   var t=screen.availHeight-h-20;
   var l=screen.availWidth/2-w/2;

   /***********************��ӡ����Ĳ���**********************************/
   var phone = document.all.i1.value;								//�û��ֻ�����
   var date = '<%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>'+'<%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>'+'<%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>';	// ϵͳ����
   var name = document.all.i4.value;								//�û�����
   var address = document.all.i5.value;								//�û���ַ
   var cardno = document.all.i7.value;								//֤������
   var stream = document.all.stream.value;							//��ӡ��ˮ
   var kx_want = document.all.kx_want.value;				        //��ӡ�������������-��
   var kx_cancle = document.all.kx_cancle.value;                    //��ӡ������ȡ������-��
   var kx_running = document.all.kx_running.value;                  //��ӡ�����п�ͨ���ײ�-��
   var work_no = '<%=workNo%>';                                 //�õ�����
   var sysnote = document.all.i16.value.substring(9)+document.all.tbselect.value.substring(2)+document.all.ip.value.substring(9);
   var tonote = document.all.tonote.value;                          //�õ���ӡ�Ĳ���
   /**********************��ӡ����Ĳ�����֯���****************************/

   var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no"
   var ret_value=window.showModalDialog("f1270_print.jsp?phone="+phone+"&date="+date+"&name="+name+"&address="+address+"&cardno="+cardno+"&stream="+stream+"&sysnote="+sysnote+"&work_no="+work_no+"&kx_want="+kx_want+"&kx_cancle="+kx_cancle+"&kx_running="+kx_running+"&tonote="+tonote,"",prop);                                //���ȷ�ϣ����ô�ӡҳ��
   ifretvalue = ret_value.substring(0,4);
   if(ifretvalue == "true")
	 {
	 document.all.stream.value = ret_value.substring(4);//������ȡ������ˮ������ֵ���˱�ҵ�����ˮ��һֱ�����
	 crmsubmit()                                        //�����ύȷ�Ϸ���
     }

 }
 function crmsubmit()
 {
 if(rdShowConfirmDialog("�Ƿ��ύ�˴β�����")==1)
		 {
           form1.action="f1270_4.jsp";
           form1.submit();
	     }
 else
	 {
	 canc()
	 }

 }

 function canc()
 {
	 document.all.sure.disabled=false;
 }

 /****************************************add by Mengqk begin********************************************/
  function printCommit(){
  	getAfterPrompt();
	//document.all.sure.disabled=true;
	document.all.sysnote.value=document.all.i16.value.substring(0,8)+document.all.tbselect.value.substring(2)+document.all.ip.value.substring(0,8);//ϵͳ��ע
	if(document.all.tonote.value.trim().len()==0){//����û���ע�ǿյĻ�,�͸�Ĭ��ֵ.�����������60,����f1270_4�и��ض�
		document.all.tonote.value = document.all.sysnote.value.trim();
	}
/********************e505 506�׶λ���� begin****************************/
	if("<%=opCode%>"=="e505" || "<%=opCode%>"=="e506") { 
		var sale_name = '<%=e505_sale_name%>';
		/*
			var tempStr = document.form1.iAddStr.value; 
			var sale_name = oneTokSelf(tempStr,"|",12);//�׶λ����
		*/
			$('#e505_sale_name').val(sale_name);
	}
/********************e505 506�׶λ���� end****************************/
/********************liujian e528 529�׶λ���� begin****************************/
	if("<%=opCode%>"=="e528" || "<%=opCode%>"=="e529") { 
		var sale_name = '<%=sale_name%>';
		$('#sale_name').val(sale_name);
	}
/********************liujian e528 529�׶λ���� end****************************/
/********************zhangyan e720 e721  begin****************************/
	if("<%=opCode%>"=="e720" || "<%=opCode%>"=="e721") { 
		var sale_name = '<%=sale_name%>';
		$('#sale_name').val(sale_name);
	}
/********************liujian e720 e721   end****************************/


// 4264�޸�start----------------------------------------------------------------------------------
	if(("<%=opCode%>"=="4264")||("<%=opCode%>"=="4265")||("<%=opCode%>"=="4263"))
	{
		frmCfm();
		return;
	}
// 4264�޸�end------------------------------------------------------------------------------------
var ret=showPrtDlg("Detail","ȷʵҪ���е��������ӡ��","Yes");
var iReturn=0;
if(typeof(ret)!="undefined"){
	if((ret=="confirm")){
		iReturn=showEvalConfirmDialog("ȷ�ϵ��������?");
		if(iReturn==1||2==iReturn){
			if(2==iReturn){
				var vEvalValue = GetEvalReq(1);
				document.all.haseval.value="1";
				document.all.evalcode.value=vEvalValue;
			}else{
				document.all.haseval.value="0";
				document.all.evalcode.value="0";
			}
      document.all.printcount.value="1";
      frmCfm();
   	}
  }
	if(ret=="continueSub"){
		iReturn=showEvalConfirmDialog("ȷ��Ҫ�ύ��Ϣ��?");
		if(iReturn==1||2==iReturn){
			if(2==iReturn){
				var vEvalValue = GetEvalReq(1);
				document.all.haseval.value="1";
				document.all.evalcode.value = vEvalValue;
			}else{
				document.all.haseval.value="0";
				document.all.evalcode.value="0";
			}
   		document.all.printcount.value="0";
   		frmCfm();
     }
   }
	}else{
		iRetrun = showEvalConfirmDialog("ȷ��Ҫ�ύ��Ϣ��");
		if(iRetrun==1||2==iReturn){
			if(2==iReturn){
				var vEvalValue = GetEvalReq(1);
				document.all.haseval.value="1";
				document.all.evalcode.value = vEvalValue;
			}else{
				document.all.haseval.value="0";
				document.all.evalcode.value="0";
			}
			document.all.printcount.value="0";
			frmCfm();
		}
	}
	document.all.sure.disabled=true;
	return true;
  }
  /****/
  function frmCfm(){
		document.form1.action="f1270_4.jsp";
		/**** tianyang add for pos start ****/
		if(document.all.payType.value=="BX")
  	{
    		/*set �������*/
				var transerial    = "000000000000";  	                     //����Ψһ�� ������ȡ��
				var trantype      = document.all.transType.value;          //��������
				var bMoney        = document.all.bMoney.value; 					   //�ɷѽ��
				if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";
				var tranoper      = "<%=workNo%>";                         //���ײ���Ա
				var orgid         = "<%=groupId%>";                        //ӪҵԱ��������
				var trannum       = "<%=phoneno%>";                        //�绰����
				getSysDate();       /*ȡbossϵͳʱ��*/
				var respstamp     = document.all.Request_time.value;       //�ύʱ��
				var transerialold = "<%=Rrn%>";			                       //ԭ����Ψһ��,�ڽɷ�ʱ�����
				var org_code      = "<%=orgCode%>";                        //ӪҵԱ����						
				CCBCommon(transerial,trantype,bMoney,tranoper,orgid,trannum,respstamp,transerialold,org_code);
				if(ccbTran=="succ") posSubmitForm();
  	}
		else if(document.all.payType.value=="BY")
		{
				var transType     = document.all.transType.value;					/*�������� */         
				var bMoney        = document.all.bMoney.value;            /*���׽�� */
				if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";         
				var response_time = "<%=Response_time%>";                 /*ԭ�������� */				
				response_time     = response_time.substr(0,8);	
				var rrn           = "<%=Rrn%>";                           /*ԭ����ϵͳ������ */ 
				var instNum       = "";                                   /*���ڸ������� */     
				var terminalId    = "<%=TerminalId%>";                    /*ԭ�����ն˺� */			
				getSysDate();       //ȡbossϵͳʱ��                                            
				var request_time  = document.all.Request_time.value;      /*�����ύ���� */     
				var workno        = "<%=workNo%>";                        /*���ײ���Ա */       
				var orgCode       = "<%=orgCode%>";                       /*ӪҵԱ���� */       
				var groupId       = "<%=groupId%>";                       /*ӪҵԱ�������� */   
				var phoneNo       = "<%=phoneno%>";                       /*���׽ɷѺ� */       
				var toBeUpdate    = "";						                        /*Ԥ���ֶ� */         
				var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);									
				//����POS������ҵ�񷵻�ֵ������ 20121011 gaopeng ���п�ҵ�񵥱��ʴ�������
				if("<%=iop_code%>"=="e505")
				{
					if(icbcTran=="succ")
					{
						SsPosPayPre();
					}
				}
				
				//һ���չ��
				if(icbcTran=="succ") posSubmitForm();
		}else if(document.all.payType.value=="EI")
		{
				var transType     = document.all.transType.value;					/*�������� */         
				var bMoney        = document.all.bMoney.value;            /*���׽�� */
				if(bMoney.indexOf(".") == -1) bMoney=bMoney+"00";         
				var response_time = "<%=Response_time%>";                 /*ԭ�������� */				
				response_time     = response_time.substr(0,8);				       
				var rrn           = "<%=Rrn%>";                           /*ԭ����ϵͳ������ */ 
				var instNum       = "<%=installmentNum%>";                /*���ڸ������� */     
				var terminalId    = "<%=TerminalId%>";                    /*ԭ�����ն˺� */			
				getSysDate();       //ȡbossϵͳʱ��                                            
				var request_time  = document.all.Request_time.value;      /*�����ύ���� */     
				var workno        = "<%=workNo%>";                        /*���ײ���Ա */       
				var orgCode       = "<%=orgCode%>";                       /*ӪҵԱ���� */       
				var groupId       = "<%=groupId%>";                       /*ӪҵԱ�������� */   
				var phoneNo       = "<%=phoneno%>";                       /*���׽ɷѺ� */       
				var toBeUpdate    = "";						                        /*Ԥ���ֶ� */         
				var posFlag = ICBCCommon(transType,bMoney,response_time,rrn,instNum,terminalId,request_time,workno,orgCode,groupId,phoneNo,toBeUpdate);									
				//����POS������ҵ�񷵻�ֵ������ 20121011 gaopeng ���п�ҵ�񵥱��ʴ�������
				if("<%=iop_code%>"=="e505")
				{
					if(icbcTran=="succ")
					{
						SsPosPayPre();
					}
				}
				if(icbcTran=="succ") posSubmitForm();
		}else{
				posSubmitForm();
		}
		/**** tianyang add for pos end ****/
  }
  /**����POS������ҵ�񷵻�ֵ������ 20121011 gaopeng ���п�ҵ�񵥱��ʴ������� start**/
  function SsPosPayPre()
  {
  		var MydataPacket = new AJAXPacket("/npage/sg175/fg175_1.jsp","���ڴ���POS���ݣ����Ժ�......");
			//��ˮ��
			MydataPacket.data.add("iLoginAccept","<%=printAccept%>");
			//������ʶ
			MydataPacket.data.add("iChnSource","01");
			//��������
			MydataPacket.data.add("iOpCode","<%=iop_code%>");
			//����
			MydataPacket.data.add("iLoginNo","<%=workNo%>");
			//��������
			MydataPacket.data.add("iLoginPwd","<%=op_strong_pwd%>");
			//�û�����
			MydataPacket.data.add("iPhoneNo","<%=phoneno%>");
			//��������
			MydataPacket.data.add("iUserPwd","");
			//�ɷ�����
			MydataPacket.data.add("iPayType",document.all.payType.value);
			//�ɷѽ��
			MydataPacket.data.add("iPayFee",document.all.bMoney.value);
			//�����к�
			MydataPacket.data.add("iCatdNo",document.all.CardNo.value);
			//���ڸ�������
			MydataPacket.data.add("iInstNum",$("#iInstNum").val());
			//ԭ��������
			var response_time = "<%=Response_time%>";                		
			response_time = response_time.substr(0,8);				       
			MydataPacket.data.add("iResponseTime",response_time);
			//ԭ�����ն˺�
			MydataPacket.data.add("iTerminalId",document.all.TerminalId.value);
			//ԭ����ϵͳ������
			MydataPacket.data.add("iRrn",document.all.Rrn.value);
			//�ύ����
			MydataPacket.data.add("iRequestTime",document.all.Request_time.value);
			//Ԥ���ֶ�
			MydataPacket.data.add("iOtherS","");
			
			core.ajax.sendPacket(MydataPacket,dsPosPayPre12);
			
			MydataPacket = null;
  	
  }
  function dsPosPayPre12(packet)
  {
		var ErrorCode = packet.data.findValueByName("retCode12");
		var ErrorMsg = packet.data.findValueByName("retMsg12");
		if(ErrorCode!="0" && ErrorCode!="000000")
		{
			rdShowMessageDialog(ErrorMsg,1);
		}
  	else
  		{
  			return true;
  		}
  }
	/**����POS������ҵ�񷵻�ֵ������ 20121011 gaopeng ���п�ҵ�񵥱��ʴ������� end**/
	/*tianyang add POS�ɷ� start*/
	function getSysDate()
	{
		var myPacket = new AJAXPacket("../public/pos_getSysDate.jsp","���ڻ��ϵͳʱ�䣬���Ժ�......");
		myPacket.data.add("verifyType","getSysDate");
		core.ajax.sendPacket(myPacket);
		myPacket = null;
	
	}
	function padLeft(str, pad, count)
	{
			while(str.length<count)
			str=pad+str;
			return str;
	}
	function getCardNoPingBi(cardno)
	{
			var cardnopingbi = cardno.substr(0,6);
			for(i=0;i<cardno.length-10;i++)
			{
				cardnopingbi=cardnopingbi+"*";
			}
			cardnopingbi=cardnopingbi+cardno.substr(cardno.length-4,4);
			return cardnopingbi;
	}
	/* POS�ɷ��� ҳ���ύ  start*/
	function posSubmitForm(){
			var tmpStr = $("#transTotal").val();
			tmpStr = replaceStr(tmpStr);
			$("#transTotal").val(tmpStr);
			form1.submit();
			return true;
	}
	/*tianyang add POS�ɷ� end*/
	function replaceStr(str){
		str = str.replace(/\s+/g, " ");
		return str;
	}


  function showPrtDlg(printType,DlgMessage,submitCfm)
  {  //��ʾ��ӡ�Ի���
	var h=210;
	var w=400;
	var t=screen.availHeight/2-h/2;
	var l=screen.availWidth/2-w/2;
	//var kx_code = document.all.kx_code_bunch.value; //��ѡ�ʷ�
	//kx_code = kx_code.replace(new RegExp("#","gm"),"~");
	var kx=""; //��ѡ�ײʹ���
		for (var i = 0; i < document.all.checkId.length; i++){
		if (document.all.checkId[i].checked == true&& document.all.R1[i].value=="N"){
			kx=kx+document.all.R7[i].value+"~";
		}
	}
	var printStr = printInfo();

	var old_code = "<%=iold_m_code%>"; //���ʷѴ���
	var new_code = "<%=inew_m_code%>"; //���ʷѴ���
	var pType="subprint";              // ��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
	var billType="1";               //  Ʊ�����ͣ�1���������2��Ʊ��3�վ�
	var sysAccept="<%=printAccept%>";               // ��ˮ��
	var mode_code=codeChg(new_code)+"~"+codeChg(kx);               //�ʷѴ���
	var fav_code=null;                 //�ط�����
	var area_code="<%=WtcUtil.repNull(request.getParameter("rate_code"))%>";             //С������
	var opCode="1270";

	var phoneNo=document.all.i1.value;                  //�ͻ��绰
	<%

	System.out.println("---------------opCode------------------"+opCode);
	%>
	/* ningtn */
	var iccidInfoStr = $("#firstId").val() + "|" + $("#secondId").val();	
	var accInfoStr = $("#accInfoHid1").val() + "|" +$("#accInfoHid2").val()+ "|" +$("#accInfoHid3").val()+ "|" +$("#accInfoHid4").val();
	/* ningtn */
     var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
	<%if(iop_code.equals("1270") || iop_code.equals("127a") || iop_code.equals("127b")|| iop_code.equals("125b")|| iop_code.equals("125c")|| iop_code.equals("7119")){%>
	  var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
	  path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+document.form1.phone.value+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr.trim();
	<%}else{%>
	  var path = "<%=request.getContextPath()%>/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage+ "&submitCfm=" + submitCfm+ "&iccidInfo=" + iccidInfoStr + "&accInfoStr="+accInfoStr;
	  path=path+"&mode_code="+mode_code+"&fav_code="+fav_code+"&area_code="+area_code+"&opCode=<%=opCode%>&sysAccept="+sysAccept+"&phoneNo="+document.form1.phone.value+"&submitCfm="+submitCfm+"&pType="+pType+"&billType="+billType+ "&printInfo=" + printStr.trim();
	<%}%>

	 var ret=window.showModalDialog(path.trim(),printStr,prop);
     return ret;
  }

  function printInfo()
  {
    var retInfo = "";

	<%if(iop_code.equals("1205")){%>
		retInfo = printInfo1205();
	<%}else if(iop_code.equals("1200")){%>
		retInfo = printInfo1200();
	<%}else if(iop_code.equals("1198")){%>
		retInfo = printInfo1198();
	<%}else if(iop_code.equals("1206")){%>
		retInfo = printInfo1206();
	<%}else if(iop_code.equals("1207")){%>
		retInfo = printInfo1207();
	<%}else if(iop_code.equals("1270")){%>
		retInfo = printInfo1270();
	<%}else if(iop_code.equals("127b")){%>
		retInfo = printInfo127b();
	<%}else if(iop_code.equals("127a")){%>
		retInfo = printInfo127a();
	<%}else if(iop_code.equals("126b")){%>
		retInfo = printInfo126b();
	<%}else if(iop_code.equals("126c")){%>
		retInfo = printInfo126c();
	<%}else if(iop_code.equals("8034")){%>
		retInfo = printInfo8034();
	<%}else if(iop_code.equals("8035")){%>
		retInfo = printInfo8035();
	<%}else if(iop_code.equals("8070")){%>
		retInfo = printInfo8070();
	<%}else if(iop_code.equals("8071")){%>
		retInfo = printInfo8071();
	<%}else if(iop_code.equals("8042")){%>
		retInfo = printInfo8042();
	<%}else if(iop_code.equals("8043")){%>
		retInfo = printInfo8043();
	<%}else if(iop_code.equals("8044")){%>
		retInfo = printInfo8044();
	<%}else if(iop_code.equals("7671")){%>
		retInfo = printInfo7671();
	<%}else if(iop_code.equals("7672")){%>
		retInfo = printInfo7672();
	<%}else if(iop_code.equals("8045")){%>
		retInfo = printInfo8045();
	<%}else if(iop_code.equals("126h")){%>
		retInfo = printInfo126h();
	<%}else if(iop_code.equals("126i")){%>
		retInfo = printInfo126i();
	<%}else if(iop_code.equals("7960")){%>
		retInfo = printInfo7960();
	<%}else if(iop_code.equals("7964")){%>
		retInfo = printInfo7964();
	<%}else if(iop_code.equals("7965")){%>
		retInfo = printInfo7965();
	<%}else if(iop_code.equals("7966")){%>
		retInfo = printInfo7966();
	<%}else if(iop_code.equals("7967")){%>
		retInfo = printInfo7967();
	<%}else if(iop_code.equals("8023")){%>
		retInfo = printInfo8023();
	<%}else if(iop_code.equals("8024")){%>
		retInfo = printInfo8024();
	<%}else if(iop_code.equals("8094")){%>
		retInfo = printInfo8094();
	<%}else if(iop_code.equals("8091")){%>
		retInfo = printInfo8091();
	<%}else if(iop_code.equals("2264")){%>
		retInfo = printInfo2264();
	<%}else if(iop_code.equals("2265")){%>
		retInfo = printInfo2265();
	<%}else if(iop_code.equals("2281")){%>
		retInfo = printInfo2281();
	<%}else if(iop_code.equals("2282")){%>
		retInfo = printInfo2282();
	<%}else if(iop_code.equals("2283")){%>
		retInfo = printInfo2283();
	<%}else if(iop_code.equals("2284")){%>
		retInfo = printInfo2284();
	<%}else if(iop_code.equals("7371")){%>
		retInfo = printInfo7371();
	<%}else if(iop_code.equals("7374")){%>
		retInfo = printInfo7374();
	<%}else if(iop_code.equals("7379")){%>
		retInfo = printInfo7379();
	<%}else if(iop_code.equals("7382")){%>
		retInfo = printInfo7382();
	<%}else if(iop_code.equals("7981")){%>
		retInfo = printInfo7981();
	<%}else if(iop_code.equals("7982")){%>
		retInfo = printInfo7982();
	<%}else if(iop_code.equals("8551")){%>
		retInfo = printInfo8551();
	<%}else if(iop_code.equals("8552")){%>
		retInfo = printInfo8552();
	<%}else if(iop_code.equals("7898")){%>
		retInfo = printInfo7898();
	<%}else if(iop_code.equals("g068")){%>
		retInfo = printInfoG068();		
	<%}else if(iop_code.equals("7899")){%>
		retInfo = printInfo7899();
	<%}else if(iop_code.equals("g069")){%>
		retInfo = printInfoG069();
	<%}else if(iop_code.equals("8687")){%>
		retInfo = printInfo8687();
	<%}else if(iop_code.equals("8688")){%>
		retInfo = printInfo8688();
	<%}else if(iop_code.equals("7975")){%>
		retInfo = printInfo7975();
	<%}else if(iop_code.equals("7976")){%>
		retInfo = printInfo7976();
	<%}else if(iop_code.equals("7116")){%>
		retInfo = printInfo7116();
	<%}else if(iop_code.equals("7118")){%>
		retInfo = printInfo7118();
	<%}else if(iop_code.equals("1253")){%>
		retInfo = printInfo1253();
	<%}else if(iop_code.equals("1254")){%>
		retInfo = printInfo1254();
	<%}else if(iop_code.equals("7977")){%>
		retInfo = printInfo7977();
	<%}else if(iop_code.equals("7978")){%>
		retInfo = printInfo7978();
	<%}else if(iop_code.equals("1208")){%>
		retInfo = printInfo1208();
	<%}else if(iop_code.equals("125b")){%>
		retInfo = printInfo125b();
	<%}else if(iop_code.equals("125c")){%>
		retInfo = printInfo125c();
	<%}else if(iop_code.equals("7117")){%>
		retInfo = printInfo7117();
	<%}else if(iop_code.equals("7119")){%>
		retInfo = printInfo7119();
	<%}else if(iop_code.equals("8046")){%>
		retInfo = printInfo8046();
	<%}else if(iop_code.equals("8027")){%>
		retInfo = printInfo8027();
	<%}else if(iop_code.equals("8028")){%>
		retInfo = printInfo8028();
	<%}else if(iop_code.equals("7688")){%>
		retInfo = printInfo7688();
	<%}else if(iop_code.equals("7689")){%>
		retInfo = printInfo7689();
	<%}else if(iop_code.equals("e505")){%>
		retInfo = printInfoE505();
	<%}else if(iop_code.equals("e506")){%>
		retInfo = printInfoE506();
	<%}else if(iop_code.equals("e528")){%>
		retInfo = printInfoE528();
	<%}else if(iop_code.equals("e529")){%>
		retInfo = printInfoE529();
	<%}else if(iop_code.equals("e720")){%>
		retInfo = printInfoE720();
	<%}else if(iop_code.equals("e721")){%>
		retInfo = printInfoE721();
	<%}else if(iop_code.equals("g122")){%>
		retInfo = printInfoG122();
	<%}else if(iop_code.equals("g123")){%>
		retInfo = printInfoG123();
	<%}else if(iop_code.equals("g124")){%>
		retInfo = printInfoG124();
	<%}else if(iop_code.equals("g125")){%>
		retInfo = printInfoG125();
	<%}%>
    return retInfo;
  }

  /********��֯��ӡ��Ϣ��һ�麯��  begin***********/
//���糩������
function printInfo1205()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr��ʽ ��������| ����Ԥ��| �µ���| ��������
      var year_fee = oneTokSelf(tempStr,"|",2);//����Ԥ��
      var mon_base_fee = oneTokSelf(tempStr,"|",3);//�µ���
	  var consume_term = oneTokSelf(tempStr,"|",4);//��������

	  var exeDate = "<%=exeDate%>";//�õ�ִ��ʱ��
	  var time=exeDate.substring(0,8);
	  //rdShowMessageDialog("time="+time);
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
      if ("<%=regionCode%>"=="03")
      	opr_info+="�û�Ʒ��: "+"ȫ��ͨ" + "  *"+ "����ҵ��:ĵ��������ҵ���������"+"|";
      else
      	opr_info+="�û�Ʒ��: "+"ȫ��ͨ" + "  *"+ "����ҵ��:�����������ײ�����"+"|";
      <%if(goodbz.equals("Y")){%>
    		opr_info+="������ˮ: "+"<%=printAccept%>" +"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";;
  		<%}else{%>
  			opr_info+="������ˮ: "+"<%=printAccept%>" +"|";
  		<%}%>
      opr_info+="�ʷ����ͣ�"+codeChg(document.all.ip.value)+"|";
      opr_info+="�ʷ���Чʱ�䣺"+time+"|" ;
      /*******��ע��**********/
		note_info1="��ע��"+"|"
      if("<%=bdbz%>"=="Y"){
      	retInfo+="<%=bdts%>"+"|";
      }else{
	  	retInfo+=" "+"|";
	    }
	  	/**********������*********/
      note_info1+="�ʷ�������"+"<%=note%>"+"|";
      if ("<%=regionCode%>"=="03")
      {
      	note_info1+="���굽�ں��ʷ�Ϊ�������12Ԫ��С����Χ�ڱ���ͨ��������0.25Ԫ/���ӣ�"+"|";
      	note_info1+="������ѣ�С����Χ�Ȿ��ͨ����0.25Ԫ/����"+"|";
      }
      else
      {
				note_info1+=" "+"|";
				note_info1+=" "+"|";
      }
      if(document.all.modestr.value.length>0){
      note_info1+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      note_info1+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			note_info1+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>

		//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;
}
//���糩����ǩ
function printInfo1200()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr��ʽ ��������| ����Ԥ��| �µ���| ��������
      var year_fee = oneTokSelf(tempStr,"|",2);//����Ԥ��
      var mon_base_fee = oneTokSelf(tempStr,"|",3);//�µ���
	  var consume_term = oneTokSelf(tempStr,"|",4);//��������

	  var exeDate = "<%=exeDate%>";//�õ�ִ��ʱ��
	  var time=exeDate.substring(0,8);
	  var real_begin=document.all.next_begin.value;
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
      if ("<%=regionCode%>"=="03")
      	opr_info+="�û�Ʒ��: "+"ȫ��ͨ" + "  *"+ "����ҵ��:ĵ��������ҵ�������ǩ����"+"|";
      else
      	opr_info+="�û�Ʒ��: "+"ȫ��ͨ" + "  *"+ "����ҵ��:�����������ײ���ǩ����"+"|";
      <%if(goodbz.equals("Y")){%>
    		opr_info+="������ˮ: "+"<%=printAccept%>" +"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";;
  		<%}else{%>
  			opr_info+="������ˮ: "+"<%=printAccept%>" +"|";
  		<%}%>
      opr_info+="�ʷ����ͣ�"+codeChg(document.all.ip.value)+"|";
      opr_info+="�ʷ���Чʱ�䣺"+real_begin.substr(0,4)+"��"+real_begin.substr(4,2)+"��"+real_begin.substr(6,2)+"��"+"|" ;
	  	/*******��ע��**********/
	  	note_info1="��ע��"+"|";
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  	/**********������*********/
      note_info1+="�ʷ�������"+"<%=note%>"+"|";
      if ("<%=regionCode%>"=="03")
      {
      	note_info1+="���굽�ں��ʷ�Ϊ�������12Ԫ��С����Χ�ڱ���ͨ��������0.25Ԫ/���ӣ�"+"|";
      	note_info1+="������ѣ�С����Χ�Ȿ��ͨ����0.25Ԫ/����"+"|";
      }
      else
      {
				note_info1+=" "+"|";
				note_info1+=" "+"|";
      }
      if(document.all.modestr.value.length>0){
      note_info1+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      note_info1+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			note_info1+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>
		//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}
//���糩������

<%
System.out.println("-----------------1111111111111-------------------");

%>
function printInfo1206()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr��ʽ ��������| ����Ԥ��| �µ���| ��������
      var year_fee = oneTokSelf(tempStr,"|",2);//����Ԥ��
      var mon_base_fee = oneTokSelf(tempStr,"|",3);//�µ���
	  var consume_term = oneTokSelf(tempStr,"|",4);//��������
	  <%
System.out.println("-----------------2222222222222222222-------------------"+exeDate);
%>
	  var exeDate = "<%=exeDate.substring(0,8)%>";//�õ�ִ��ʱ��

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

     if ("<%=regionCode%>"=="03")
      	opr_info+="�û�Ʒ��: "+"ȫ��ͨ" + "  *"+ "����ҵ��:ĵ��������ҵ��������"+"|";
      else
      	opr_info+="�û�Ʒ��: "+"ȫ��ͨ" + "  *"+ "����ҵ��:�����������ײͳ���"+"|";
      <%if(goodbz.equals("Y")){%>
    		opr_info+="������ˮ: "+"<%=printAccept%>" +"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";;
  		<%}else{%>
  			opr_info+="������ˮ: "+"<%=printAccept%>" +"|";
  		<%}%>
      opr_info+=" "+"|";
      opr_info+="�µ���:  "+mon_base_fee+"Ԫ      Ԥ�滰��:  "+year_fee+"Ԫ|";
      opr_info+="ҵ��ִ��ʱ��:  "+exeDate+"      ����Ԥ������:  "+consume_term+"����|";
      /*******��ע��**********/
      note_info1="��ע��"+"|"
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  	/**********������*********/

      if ("<%=regionCode%>"=="03")
      {
      	note_info1+="���굽�ں��ʷ�Ϊ�������12Ԫ��С����Χ�ڱ���ͨ��������0.25Ԫ/���ӣ�"+"|";
      	note_info1+="������ѣ�С����Χ�Ȿ��ͨ����0.25Ԫ/����"+"|";
      }
      else
      {
        note_info1+="<%=print_note%>"+"|";
      }
       if(document.all.modestr.value.length>0){
      note_info1+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      note_info1+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			note_info1+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>
		//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;
}
//���糩����ǩ����

function printInfo1198()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr��ʽ ��������| ����Ԥ��| �µ���| ��������
      var year_fee = oneTokSelf(tempStr,"|",2);//����Ԥ��
      var mon_base_fee = oneTokSelf(tempStr,"|",3);//�µ���
	  var consume_term = oneTokSelf(tempStr,"|",4);//��������

	  var exeDate = "<%=exeDate.substring(0,8)%>";//�õ�ִ��ʱ��
     var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
	  var retInfo = "";
	   /********������Ϣ��**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      cust_info+="�ͻ�������" +document.all.i4.value+"|";
      cust_info+="�ֻ����룺"+document.all.phone.value+"|";
      cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
      cust_info+="֤�����룺"+document.all.i7.value+"|";

      /********������**********/

      if ("<%=regionCode%>"=="03")
      	opr_info+="�û�Ʒ��: "+"ȫ��ͨ" + "  *"+ "����ҵ��:ĵ��������ҵ�������ǩ����"+"|";
      else
      	opr_info+="�û�Ʒ��: "+"ȫ��ͨ" + "  *"+ "����ҵ��:�����������ײ���ǩ����"+"|";
      <%if(goodbz.equals("Y")){%>
    		opr_info+="������ˮ: "+"<%=printAccept%>" +"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";;
  		<%}else{%>
  			opr_info+="������ˮ: "+"<%=printAccept%>" +"|";
  		<%}%>
      opr_info+=" "+"|";
      opr_info+="�µ���:  "+mon_base_fee+"Ԫ      Ԥ�滰��:  "+year_fee+"Ԫ|";
      opr_info+="ҵ��ִ��ʱ��:  "+exeDate+"      ����Ԥ������:  "+consume_term+"����|";
      /*******��ע��**********/
      note_info1="��ע��"+"|";
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  	/**********������*********/

      if ("<%=regionCode%>"=="03")
      {
      	note_info1+="���굽�ں��ʷ�Ϊ�������12Ԫ��С����Χ�ڱ���ͨ��������0.25Ԫ/���ӣ�"+"|";
      	note_info1+="������ѣ�С����Χ�Ȿ��ͨ����0.25Ԫ/����"+"|";
      }
      else
      {
        note_info1+="<%=print_note%>"+"|";
      }
      if(document.all.modestr.value.length>0){
      note_info1+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      note_info1+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			note_info1+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>
		//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}
//���糩��ȡ��
function printInfo1207()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr��ʽ ��������| ����Ԥ��| �µ���| ��������
      var year_fee = oneTokSelf(tempStr,"|",2);//����Ԥ��
      var mon_base_fee = oneTokSelf(tempStr,"|",3);//�µ���
	  var consume_term = oneTokSelf(tempStr,"|",4);//��������
      var exeDate='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';
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

      if ("<%=regionCode%>"=="03")
      	opr_info+="�û�Ʒ��: "+"<%=WtcUtil.repNull(request.getParameter("smcode_xyz"))%>" + "  *"+ "����ҵ��:ĵ��������ҵ�����ȡ��"+"|";
      else
      	opr_info+="�û�Ʒ�ƣ�"+"<%=WtcUtil.repNull(request.getParameter("smcode_xyz"))%>"+"  *"+"����ҵ��:"+"�����������ײ�ȡ��"+"|";
      <%if(goodbz.equals("Y")){%>
    		opr_info+="������ˮ: "+"<%=printAccept%>" +"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";;
  		<%}else{%>
  			opr_info+="������ˮ: "+"<%=printAccept%>" +"|";
  	  <%}%>
      opr_info+="ȡ���İ����ʷѣ�"+ "<%=WtcUtil.repNull(request.getParameter("i16"))%>"+"|";
      opr_info+="ȡ����ִ���ʷѣ�"+document.all.ip.value+"  *"+"��Чʱ�䣺"+exeDate+"|";
      opr_info+="ȡ����ִ���ʷѶ�ӦƷ�ƣ�"+"<%=WtcUtil.repNull(request.getParameter("smcode_xyz"))%>"+"|";
      opr_info+=" "+"|";
      /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  	/**********������*********/

	  note_info1+="ȡ����ִ���ʷ�������"+"<%=note%>"+"|";
      if(document.all.kx_explan_bunch.value.trim().len()==0)
      {
		note_info1+=" "+"|";
	  }
	  else
	  {
		note_info1+="��ѡ�ʷ�������"+document.all.kx_explan_bunch.value+"|";
	  }
      if ("<%=regionCode%>"=="03")
      {
      	note_info1+="���굽�ں��ʷ�Ϊ�������12Ԫ��С����Χ�ڱ���ͨ��������0.25Ԫ/���ӣ�"+"|";
      	note_info1+="������ѣ�С����Χ�Ȿ��ͨ����0.25Ԫ/����"+"|";
      }
      else
      {
		note_info1+="��ע�����ڰ����ʷ�δ���ڣ�ȡ�������ʷ�����ΥԼ��Ϊ���ڱ��³��ʺ��ҹ�˾����ʣ��"+"|";
		note_info1+="����Ԥ���30����ȡΥԼ��֮��ʣ���Ԥ���Զ�ת�������ֽ��˻��С�"+"|";
      }
          if(document.all.modestr.value.length>0){
      note_info1+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      note_info1+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			note_info1+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>
		//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;
}
//���ʷѱ��
function printInfo1270()
{
  //�õ���ҵ�񹤵���Ҫ�Ĳ���
  var cust_info="";
  var opr_info="";
  var note_info1="";
  var note_info2="";
  var note_info3="";
  var note_info4="";

  var exeDate = "<%=exeDate.substring(0,8)%>";//�õ�ִ��ʱ��
  var smCode = "<%=WtcUtil.repNull(request.getParameter("s_city"))%>";
  var region_code = "<%=WtcUtil.repNull(request.getParameter("belong_code")).substring(0,2)%>"; //��������
  var old_smCode = "<%=WtcUtil.repNull(request.getParameter("sNewSmName"))%>";
  var smName = "";
	if(smCode=="zn")
		smName="������";
	else if(smCode=="gn")
		smName="ȫ��ͨ";
	else if(smCode=="dn")
		smName="���еش�";

  //���� 2006��11��13�� �޸� ���ӵ�����ǩ���ʷ���ϸ˵��,ֻ�޹�����

	var retInfo = "";

	/********������Ϣ��**********/
    cust_info+="�ͻ�������" +document.all.i4.value+"|";
    cust_info+="�ֻ����룺"+document.all.phone.value+"|";
    cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
    cust_info+="֤�����룺"+document.all.i7.value+"|";

    /********������**********/
    opr_info+="ҵ������ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"�û�Ʒ��: "+'<%=WtcUtil.repNull(request.getParameter("sNewSmName"))%>'+ "|";
    <%if(goodbz.equals("Y")){%>
    opr_info+="����ҵ��:���ʷѱ��"+"  "+"������ˮ: "+"<%=printAccept%>" +"    �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
  <%}else{%>
  	opr_info+="����ҵ��:���ʷѱ��"+"  "+"������ˮ: "+"<%=printAccept%>" +"|";
  	<%}%>
    opr_info+="��ǰ���ʷѣ�"+"<%=WtcUtil.repNull(request.getParameter("i16"))%>"+"|";
    opr_info+="���������ʷѣ�"+codeChg(document.form1.ip.value.trim())+"      "+"���ʷ���Чʱ�䣺"+checkdate(exeDate)+"|";
    opr_info+="���������ʷѶ������ۣ�"+ codeChg("<%=daima.trim()%>")+"*"+"���ʷѶ�ӦƷ�ƣ�"+ smName+"|" ;
    if( document.all.kx_want.value != "" )
    {
    	opr_info+=codeChg(document.all.kx_want.value) + "|";
    }
    if( document.all.kx_cancle.value != "" )
    {
    	opr_info+=codeChg(document.all.kx_cancle.value) + "|";
    }

	  /*******��ע��**********/
	//note_info1+="��ע��"+"|";
	  if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }
	  /**********������*********/
	if(old_smCode !=smName && !(old_smCode=="������" && smName=="ȫ��ͨ"))
	note_info1+="���ʷ���Ч������Ʒ�ƽ���"+ old_smCode+"���Ϊ"+ smName+"�����л��֣���Mֵ�������ʷ���Ч�Ĵ��³����㣬������ʱ�һ�����"+"|";
	note_info1+="."+"|";
    note_info1+="���������ʷ�����:"+"|";
    note_info1+=codeChg("<%=note.trim()%>")+"|";
    if(document.all.kx_explan_bunch.value.trim().len()==0){

	  }else{
	    note_info3+="."+"| ";
	  	note_info3+="��ѡ�ʷ�������"+"|";
	  	note_info3+=document.all.kx_explan_bunch.value+"|";
	  	//alert(document.all.kx_explan_bunch.value);
  	}
  	if(document.all.modestr.value.length>0){
  	  note_info4+=" ."+"|";
      note_info4+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{

      }
	<%if(goodbz.equals("Y")){%>
	        note_info4+=" ."+"|";
			note_info4+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
	<%}%>
	note_info4+=" ."+"|";
	note_info4+="��ע:"+codeChg(document.all.tonote.value)+"|";
  //retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  return retInfo;
}
//���ʷѳ���
function printInfo127b()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���

	  var exeDate = "<%=exeDate.substring(0,8)%>";//�õ�ִ��ʱ��

	  var retInfo = "";
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  /********������Ϣ��**********/
     /* retInfo+='<%=workName%>'+"|"; */
     /* retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";  */
      cust_info+="�ͻ�������"+document.all.i4.value+"|";
      cust_info+="�ֻ����룺"+document.all.phone.value+"|";
      cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
      cust_info+="֤�����룺"+document.all.i7.value+"|";
      //cust_info+="Ԥ����: "+"|";
      //cust_info+="�����: "+"|";

      /********������**********/


      opr_info+="ҵ������ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"�û�Ʒ��: "+"<%=WtcUtil.repNull(request.getParameter("sNewSmName"))%>"+"|";

      <%if(goodbz.equals("Y")){%>
      opr_info+="ҵ������: �ʷ��ײͳ���"+"  "+"��ˮ: "+"<%=printAccept%>"+"  �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      opr_info+="ҵ������: �ʷ��ײͳ���"+"  "+"��ˮ: "+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="���ײ�����:       "+codeChg(document.form1.ip.value)+"|";
      opr_info+="������������:     "+""+"|";
      opr_info+="�ײ�˵��:         "+""+"|";
      /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }
	  /**********������*********/
	  /*rdShowMessageDialog("note_info1="+"<%=print_note%>");  */
      note_info1+="<%=print_note%>"+"|";
      if(document.all.modestr.value.length>0){
      note_info2+=" "+"|";
      note_info2+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }
      	<%if(goodbz.equals("Y")){%>
      	    note_info3+=" "+"|";
			note_info3+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>
	note_info4+=" "+"|";
	note_info4+="��ע:"+document.all.tonote.value+"|";
	  document.all.cust_info.value=cust_info+"#";
	  document.all.opr_info.value=opr_info+"#";
	  document.all.note_info1.value=note_info1+"#";
	  document.all.note_info2.value=note_info2+"#";
	  document.all.note_info3.value=note_info3+"#";
	  document.all.note_info4.value=note_info4+"#";
	/*retInfo=document.all.cust_info.value+" "+"|"+"---------------------------------------------"+"|"+" "+"|"+document.all.opr_info.value+" "+"|"+" "+"|"+document.all.note_info1.value+document.all.note_info2.value+document.all.note_info3.value+document.all.note_info4.value+" "+"|"+" "+"|"+" "+"|"+" "+"|"+"<%=loginNote.trim()%>"+"#";*/

	//return retInfo;
	//retInfo=cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}
//���ʷ�ԤԼȡ��
function printInfo127a()
{
	  /*�õ���ҵ�񹤵���Ҫ�Ĳ���

	  var exeDate = "<%=exeDate.substring(0,8)%>";//�õ�ִ��ʱ��

	  var retInfo = "";
	  /������Ϣ��/
      retInfo+='<%=workNo%>  <%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="�ͻ����ƣ�" +document.all.i4.value+"|";
      retInfo+="�ֻ����룺"+document.all.phone.value+"|";
      retInfo+="�ͻ���ַ��"+document.all.i5.value+"|";
      retInfo+="֤�����룺"+document.all.i7.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      /������/
      retInfo+="�û�Ʒ��: "+"<%=WtcUtil.repNull(request.getParameter("sNewSmName"))%>" + "  *"+ "����ҵ��:���ʷ�ԤԼȡ��"+"|";
      <%if(goodbz.equals("Y")){%>
      retInfo+="������ˮ: "+"<%=printAccept%>" +"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
       <%}else{%>
       retInfo+="������ˮ: "+"<%=printAccept%>" +"|";
       <%}%>
      retInfo+="��ǰ���ʷѣ�"+"<%=WtcUtil.repNull(request.getParameter("i16"))%>"+"|";
      retInfo+="ԤԼ���ʷѣ�"+codeChg(document.form1.i18.value)+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+="˵�����û��������ʷ�ԤԼȡ����ԤԼ�����ʷѽ�������Ч����ǰ���ʷѼ���ִ�С�"+"|";
      retInfo+=" "+"|";
       /��ע��/
	  	if("<%=bdbz%>"=="Y"){
      	retInfo+="<%=bdts%>"+"|";
      }else{
	  	retInfo+=" "+"|";
	  }
	  /������/
      if(document.all.modestr.value.length>0){
      retInfo+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      retInfo+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			retInfo+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
		<%}%>


	  return retInfo; */


	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
    var retInfo = "";

    cust_info+="�ֻ����룺"+document.all.phone.value+"|";
	cust_info+="�ͻ�������"+document.all.i4.value+"|";
	cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
	cust_info+="֤�����룺"+document.all.i7.value+"|";

	opr_info+="�û�Ʒ��: "+"<%=WtcUtil.repNull(request.getParameter("sNewSmName"))%>" + "  *"+ "����ҵ��:���ʷ�ԤԼȡ��"+"|";
	<%if(goodbz.equals("Y")){%>
       opr_info+="������ˮ: "+"<%=printAccept%>" +"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
    <%}else{%>
       opr_info+="������ˮ: "+"<%=printAccept%>" +"|";
    <%}%>
    opr_info+="��ǰ���ʷѣ�"+"<%=WtcUtil.repNull(request.getParameter("i16"))%>"+"|";
    opr_info+="ԤԼ���ʷѣ�"+codeChg(document.form1.i18.value)+"|";

	if("<%=bdbz%>"=="Y"){
        note_info2+="<%=bdts%>"+"|";
    }else{
	    note_info2+=" "+"|";
	}
	if(document.all.modestr.value.length>0){
      note_info3+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
    }else{
      note_info3+=" "+"|";
    }
    <%if(goodbz.equals("Y")){%>
	  note_info4+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
	<%}%>
    //retInfo=cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;

}
//Ԥ�滰����������
function printInfo126b()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr��ʽ flag,machine_type,order_code,prepay_fee,base_fee,free_fee,consume_term,mon_base_fee,machine_fee
      var machine_type = oneTokSelf(tempStr,"|",2);//��������
      var order_code = oneTokSelf(tempStr,"|",3);//��������
	  var prepay_fee = oneTokSelf(tempStr,"|",4);//Ԥ���
	  var base_fee = oneTokSelf(tempStr,"|",5);//����Ԥ��
	  var free_fee = oneTokSelf(tempStr,"|",6);//�Ԥ��
	  var consume_term = oneTokSelf(tempStr,"|",7);//��������
	  var mon_base_fee = oneTokSelf(tempStr,"|",8);//�µ���

	  var exeDate = "<%=exeDate.substring(0,8)%>";//�õ�ִ��ʱ��

	  var retInfo = "";
	   /********������Ϣ��**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="�ͻ����ƣ�" +document.all.i4.value+"|";
      retInfo+="�ֻ����룺"+document.all.phone.value+"|";
      retInfo+="�ͻ���ַ��"+document.all.i5.value+"|";
      retInfo+="֤�����룺"+document.all.i7.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      /********������**********/
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+="ҵ������:         Ԥ���������¿۷�"+"|";
      <%if(goodbz.equals("Y")){%>
      retInfo+="��ˮ: "+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      retInfo+="��ˮ:             "+"<%=printAccept%>"+"|";
      <%}%>
      retInfo+=" "+"|";
      retInfo+="ҵ������: Ԥ�滰�����ֻ�"+"    �ֻ��ͺ�: " + machine_type+"|";
      retInfo+="�µ���: "+mon_base_fee+"Ԫ    Ԥ�滰��: "+prepay_fee+"Ԫ    "+"����:  ����Ԥ��: "+base_fee+"Ԫ  �Ԥ��: "+free_fee+"Ԫ|";
      retInfo+="ҵ��ִ��ʱ��:  "+exeDate+"      ����Ԥ������:  "+consume_term+"����|";
		 /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	retInfo+="<%=bdts%>"+"|";
      }else{
	  	retInfo+=" "+"|";
	  	}
	  /**********������*********/
      retInfo+="<%=print_note%>"+"|";
      if(document.all.modestr.value.length>0){
      retInfo+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      retInfo+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			retInfo+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>


	  return retInfo;
}
//Ԥ�滰����������
function printInfo126c()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr��ʽ flag,machine_type,order_code,prepay_fee,base_fee,free_fee,consume_term,mon_base_fee,machine_fee
      var machine_type = oneTokSelf(tempStr,"|",2);//��������
      var order_code = oneTokSelf(tempStr,"|",3);//��������
	  var prepay_fee = oneTokSelf(tempStr,"|",4);//Ԥ���
	  var base_fee = oneTokSelf(tempStr,"|",5);//����Ԥ��
	  var free_fee = oneTokSelf(tempStr,"|",6);//�Ԥ��
	  var consume_term = oneTokSelf(tempStr,"|",7);//��������
	  var mon_base_fee = oneTokSelf(tempStr,"|",8);//�µ���

	  var exeDate = "<%=exeDate.substring(0,8)%>";//�õ�ִ��ʱ��

	  var retInfo = "";
	  /********������Ϣ��**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="�ͻ����ƣ�" +document.all.i4.value+"|";
      retInfo+="�ֻ����룺"+document.all.phone.value+"|";
      retInfo+="�ͻ���ַ��"+document.all.i5.value+"|";
      retInfo+="֤�����룺"+document.all.i7.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      /********������**********/
      retInfo+=" "+"|";
      retInfo+=" "+"|";
       retInfo+="ҵ������:         Ԥ���������¿۷ѳ���"+"|";
      <%if(goodbz.equals("Y")){%>
      retInfo+="��ˮ:"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      retInfo+="��ˮ:             "+"<%=printAccept%>"+"|";
      <%}%>
      retInfo+=" "+"|";
      retInfo+="ҵ������: Ԥ�滰�����ֻ�����"+"    �ֻ��ͺ�: " + machine_type+"|";
      retInfo+="�µ���: "+mon_base_fee+"Ԫ    Ԥ�滰��: "+prepay_fee+"Ԫ    "+"����:  ����Ԥ��: "+base_fee+"Ԫ  �Ԥ��: "+free_fee+"Ԫ|";
      retInfo+="ҵ��ִ��ʱ��:  "+exeDate+"      ����Ԥ������:  "+consume_term+"����|";
			 /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	retInfo+="<%=bdts%>"+"|";
      }else{
	  	retInfo+=" "+"|";
	  	}
	  /**********������*********/
      retInfo+="<%=print_note%>"+"|";
      if(document.all.modestr.value.length>0){
      retInfo+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      retInfo+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			retInfo+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>


	  return retInfo;
}
//Ԥ�滻�ֻ������ѹ���������
function printInfo8042()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	 // rdShowMessageDialog("tempStr = " + tempStr);
	  //iAddStr��ʽ Ӫ������|Ʒ������|Ӧ�ս��|����Ԥ��|����Ԥ��|��������|Ԥ�ۻ���|�����·�|�����µ���|IMEI��|��������|��������|

		/**** ningtn add for pos start *****/
		document.all.bMoney.value = oneTokSelf(tempStr,"|",3);
		if(document.all.payType.value=="BX"){
				document.all.transType.value="00";
		}else if(document.all.payType.value=="BY"){
				document.all.transType.value="05";
		}
		/**** ningtn add for pos end *****/

    var sale_code = oneTokSelf(tempStr,"|",1);     //Ӫ������
    var brand_code = oneTokSelf(tempStr,"|",2);      //�ֻ�Ʒ��
	  var prepay_fee = oneTokSelf(tempStr,"|",3);     //Ԥ�滰��
	  var main_fee = oneTokSelf(tempStr,"|",4);       //����Ԥ��
	  var second_fee = oneTokSelf(tempStr,"|",5);       //����Ԥ��
	  var phone_type = oneTokSelf(tempStr,"|",6);    //�ֻ��ͺ�
	  var mark_subtract = oneTokSelf(tempStr,"|",7);  //Ԥ�ۻ���
	  var consume_term = oneTokSelf(tempStr,"|",8);   //�����·�
	  var monbase_fee = oneTokSelf(tempStr,"|",9);    //�µ���
	  var IMEINo = oneTokSelf(tempStr,"|",10);//IMEI��
	  var second_phone= oneTokSelf(tempStr,"|",11);//��������
	  var second_name= oneTokSelf(tempStr,"|",12);//��������
	  var award_flag = oneTokSelf(tempStr,"|",14);//award_flag

	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

     var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
	    /********������Ϣ��**********/
      cust_info+="�ͻ�������" +document.all.i4.value+"|";
      cust_info+="�ֻ����룺"+document.all.phone.value+"|";
      cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
      cust_info+="֤�����룺"+document.all.i7.value+"|";
      cust_info+="�������ƣ�"+second_name+"|";
      cust_info+="�������룺"+second_phone+"|";

      /********������**********/

      opr_info+="ҵ�����ͣ�Ԥ�����ֻ������ѹ�����"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="���������ʷѣ�"+document.all.ip.value+"|";
      //�������޸�     START                    retInfo+="�ֻ��ͺţ�"+gift_code+deposit_fee+"|";
      opr_info+="�ֻ��ͺţ�"+brand_code+phone_type+"      IMEI�룺"+IMEINo+"|";
      //�������޸�     END
      opr_info+="�ɿ�ϼƣ�"+prepay_fee+"Ԫ��������Ԥ�滰�ѣ�"+main_fee+"Ԫ������Ԥ�滰��"+second_fee+"Ԫ��"+"|";

     /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********������*********/
     if(document.all.modestr.value.length>0){
      note_info1+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      note_info1+=" "+"|";
      }
      note_info1+="��ӭ���μӵġ�Ԥ�����ֻ������ѹ����������������������12�����ھ����ܱ���ʷ��ײ͡�����Ԥ�滰������12����������ϡ��������Ѱ�12���·��������·��������ڵ���������ϡ�Ԥ�滰�Ѳ��ܽ���ת�ʼ��˿������"+"|";
			<%if(goodbz.equals("Y")){%>
			note_info1+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>
	  note_info1+="�ֻ��ն˻��Զ��������϶�Ķ��Ž��в�֣���ͬ�ͺ��ֻ��ն˲��ԭ��ͬ���ҹ�˾�����ֻ��Զ���ֵ������շѡ�"+"|";
	  /***************�ж��Ƿ���ʾ�ַ����******************/
	  var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
      var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
	  if(old_SmCode == "zn")
  		{
  			//ѦӢ�� 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@���ڻ��������������������� zn->gn ���ֲ�����
  			/* ningtn ��������*/
  		}
  		else
  		{
	  		if((new_SmCode !="") && (new_SmCode != old_SmCode))
	  		{
	  			/* ningtn �������� */
		  		
	  		}

  		}
  			  	  			/* wanghyd ȥ������������ʾͬʱ������ʾ */
	  			<%if(smzvalue.equals("3")) {%>
		  		note_info1+="<%=readValue("8042","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
  		
  		
	  if(award_flag == "1")
	  {
	  		note_info1 += "�Ѳ���������Ʒ�"+"|";
	  }
	  else
	  {
	      note_info1 += "  "+"|";
	  }
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	    return retInfo;
}
/*������ũ���������ֻ�Ӫ��*/
function printInfo8044()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	 // rdShowMessageDialog("tempStr = " + tempStr);
 //iAddStr��ʽ Ӫ������|Ʒ������|Ӧ�ս��|���ͻ���|����Ԥ��|��������|�����·�|SIM����|�µ���|IMEI��|������|�ֻ�ԭ��|
             //Ӫ������|Ʒ������|Ӧ�ս��|���ͻ���|����Ԥ��|��������|�����·�|SIM����|�µ���|IMEI��|������|
		/**** ningtn add for pos start *****/
		document.all.bMoney.value = oneTokSelf(tempStr,"|",3);
		if(document.all.payType.value=="BX"){
				document.all.transType.value="00";
		}else if(document.all.payType.value=="BY"){
				document.all.transType.value="05";
		}
		/**** ningtn add for pos end *****/
    var sale_code = oneTokSelf(tempStr,"|",1);     //Ӫ������
    var brand_code = oneTokSelf(tempStr,"|",2);      //Ʒ������
	  var prepay_fee = oneTokSelf(tempStr,"|",3);     //Ӧ�ս��
	  var main_fee = oneTokSelf(tempStr,"|",4);       //���ͻ���
	  var second_fee = oneTokSelf(tempStr,"|",5);       //����Ԥ��
	  var phone_type = oneTokSelf(tempStr,"|",6);    //��������
	  var mark_subtract = oneTokSelf(tempStr,"|",7);  //�����·�
	  var consume_term = oneTokSelf(tempStr,"|",8);   //SIM����
	  var monbase_fee = oneTokSelf(tempStr,"|",9);    //�µ���
	  var IMEINo = oneTokSelf(tempStr,"|",10);//IMEI��


	  var cost_price = oneTokSelf(tempStr,"|",12);//IMEI��
	  var award_flag = oneTokSelf(tempStr,"|",14);//award_flag


	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

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
      opr_info+="ҵ�����ͣ�������ũ���������ֻ�Ӫ��"+"|";
       <%if(goodbz.equals("Y")){%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="�ֻ��ͺţ�"+brand_code+phone_type+"      IMEI�룺"+IMEINo+"|";
      opr_info+="�ֻ�ԭ�ۣ�"+cost_price+"Ԫ"+"|";
      //���� 2007��9��28�� �޸����� 0 != second_fee ���������ҵ��
      if (0 != second_fee){
      	opr_info+="�ɿ�ϼƣ�"+prepay_fee+"Ԫ (���У�Ԥ�滰�� "+main_fee+"Ԫ������ר�� "+second_fee+"Ԫ)"+"|";
      }else{
      	opr_info+="�ɿ�ϼƣ�"+prepay_fee+"Ԫ (���У�Ԥ�滰�� "+main_fee+"Ԫ)"+"|";
      }
      opr_info+="�����ʷѣ�"+(document.all.ip.value).trim()+"|";
      opr_info+="ҵ��ִ��ʱ�䣺"+begin_time+"|";

       /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********������*********/
     if(document.all.modestr.value.length>0){
      note_info2+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      note_info2+=" "+"|";
      }
      note_info3+="�����ʷ�˵����������ҵ�������ķ��ð���Ԥ�滰�ѡ�������Ͳ���ר�����ר������ڰ��³��������ã�������������������ʹ��3���µĲ���ҵ�񣬵�����������ȡ������ȡ������ȡ������ʹ�÷ѡ�Ԥ�滰��ÿ���������ʹ���ܶ������֮һ��������Ļ����������н��ɡ������λ������ֻ�������ֻ�������һ��ʹ�ã����򽫲�����ʹ��Ԥ�滰�ѡ���������Ԥ�滰�ѱ�����һ����������ϣ�ʣ���ȫ�������㡣"+"|";
      note_info3+="���ҵ������Ϊһ�꣬�����ڲ�����ʷѣ������˿ҵ���ں�����а�������ҵ��ҵ����ǰ������ȡ������ΥԼ�涨�����Żݼ۹�����ֻ������ֻ�ԭ�۲���������ʣ��Ԥ����30%����ΥԼ��"+"|";
      note_info3+="δ�漰���ʷѣ������е��ƶ��绰�ʷѱ�׼ִ�С����λ�ֻ������й��ƶ�ҵ����Э����Ч�������������ʷѱ�׼�������������µ��ʷ�����ִ�С�"+"|"
      /***************�ж��Ƿ���ʾ�ַ����******************/
	  var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
      var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
	  if(old_SmCode == "zn")
  		{
  			//ѦӢ�� 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@���ڻ��������������������� zn->gn ���ֲ�����
  		}
  		else
  		{
	  		if((new_SmCode !="") && (new_SmCode != old_SmCode))
	  		{
		  		/* ningtn �������� */
		  	
	  		}

  		}
  		
  			  	  			/* wanghyd ȥ������������ʾͬʱ������ʾ */
	  			<%if(smzvalue.equals("3")) {%>
		  		note_info1+="<%=readValue("8044","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
  		
			<%if(goodbz.equals("Y")){%>
			note_info4+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>
	 note_info4+="�ֻ��ն˻��Զ��������϶�Ķ��Ž��в�֣���ͬ�ͺ��ֻ��ն˲��ԭ��ͬ���ҹ�˾�����ֻ��Զ���ֵ������շѡ�"+"|";
			/*ningtn IMEI���°�����*/
			note_info4 += "�������ֻ���ʧ����Ϊ�𻵵ȸ���ԭ���޷�ʹ�ö���ɻ������룬�뵽Ӫҵ�����¹��������򽫲��ܼ���ʹ��ʣ�໰�ѡ�" + "|";
			if(award_flag == "1")
			{
					note_info4 += "�Ѳ���������Ʒ�"+"|";
			}
			else
			{
			    note_info4 += "  "+"|";
			}



    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}
//Ԥ�滻�ֻ������ѹ��������
function printInfo8043()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	 // rdShowMessageDialog("tempStr = " + tempStr);
	  //iAddStr��ʽ ԭ��ˮ|Ӫ������|Ӧ�ս��|����Ԥ��|����Ԥ��|Ԥ�ۻ���|�����·�|�����µ���|��������|��������|��������|�����ʷ�|

	/**** ningtn add for pos start *****/
	document.all.bMoney.value = oneTokSelf(tempStr,"|",3);
	if(document.all.payType.value=="BX"){
			document.all.transType.value="01";
	}else if(document.all.payType.value=="BY"){
			document.all.transType.value="04";
	}
	/**** ningtn add for pos end *****/	

    var sale_code = oneTokSelf(tempStr,"|",2);     //Ӫ������
	  var prepay_fee = oneTokSelf(tempStr,"|",3);     //Ԥ�滰��
	  var main_fee = oneTokSelf(tempStr,"|",4);       //����Ԥ��
	  var second_fee = oneTokSelf(tempStr,"|",5);       //����Ԥ��
	  var mark_subtract = oneTokSelf(tempStr,"|",6);  //Ԥ�ۻ���
	  var consume_term = oneTokSelf(tempStr,"|",7);   //�����·�
	  var monbase_fee = oneTokSelf(tempStr,"|",8);    //�µ���
	  var brand_code = oneTokSelf(tempStr,"|",9);      //�ֻ�Ʒ��
	  var second_phone= oneTokSelf(tempStr,"|",10);//��������
	  var second_name= oneTokSelf(tempStr,"|",11);//��������
	  var mode_name= oneTokSelf(tempStr,"|",12);//�����ʷ���

	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

     var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
	    /********������Ϣ��**********/
     cust_info+="�ͻ�������" +document.all.i4.value+"|";
     cust_info+="�ֻ����룺"+document.all.phone.value+"|";
     cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
     cust_info+="֤�����룺"+document.all.i7.value+"|";
     cust_info+="�������ƣ�"+second_name+"|";
     cust_info+="�������룺"+second_phone+"|";
      /********������**********/
      opr_info+="ҵ�����ͣ�Ԥ�����ֻ������ѹ��������"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="���������ʷѣ�"+mode_name+"|";
      opr_info+="�ֻ��ͺţ�"+brand_code+"|";
      opr_info+="�˿�ϼƣ�"+prepay_fee+"Ԫ��������Ԥ�滰�ѣ�"+main_fee+"Ԫ������Ԥ�滰��"+second_fee+"Ԫ��"+"|";
      /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
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
//Ԥ�����̻������ѿɷ�������
function printInfo7671()
{
	//�õ���ҵ�񹤵���Ҫ�Ĳ���
	var tempStr = document.form1.iAddStr.value;
		/**** ningtn add for pos start *****/
		document.all.bMoney.value = oneTokSelf(tempStr,"|",3);
		if(document.all.payType.value=="BX"){
				document.all.transType.value="00";
		}else if(document.all.payType.value=="BY"){
				document.all.transType.value="05";
		}
		/**** ningtn add for pos end *****/
	// rdShowMessageDialog("tempStr = " + tempStr);
	//iAddStr��ʽ Ӫ������|Ʒ������|Ӧ�ս��|����Ԥ��|�Ԥ��|��������|�̻�����|�̻��������·�|�ֻ�������������|IMEI��|�ֻ�������|�ֻ�����|�н���־|

    var sale_code = oneTokSelf(tempStr,"|",1);       //Ӫ������
    var brand_code = oneTokSelf(tempStr,"|",2);      //�ֻ�Ʒ��
	var prepay_fee = oneTokSelf(tempStr,"|",3);      //Ӧ�ս��
	var base_fee = oneTokSelf(tempStr,"|",4);        //����Ԥ��
	var free_fee = oneTokSelf(tempStr,"|",5);        //�Ԥ��
	var phone_type = oneTokSelf(tempStr,"|",6);      //�ֻ��ͺ�
	var mach_fee  = oneTokSelf(tempStr,"|",7);       //�̻�����
	var consume_term = oneTokSelf(tempStr,"|",8);    //�̻�������ʱ��
	var active_term = oneTokSelf(tempStr,"|",9);     //�ֻ�������������
	var IMEINo = oneTokSelf(tempStr,"|",10);         //IMEI��
	var second_phone = oneTokSelf(tempStr,"|",11);   //�ֻ�������
	var phone_fee = oneTokSelf(tempStr,"|",12);      //�ֻ�����
	var award_flag = oneTokSelf(tempStr,"|",13);     //award_flag
	var  total_fee=parseFloat(base_fee)+parseFloat(free_fee);
	var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
	/********������Ϣ��**********/
	cust_info+="�ͻ�������" +document.all.i4.value+"|";
	cust_info+="�ֻ����룺"+document.all.phone.value+"|";
	cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
	cust_info+="֤�����룺"+document.all.i7.value+"|";
	cust_info+="�ֻ����룺"+second_phone+"|";

	/********������**********/

	opr_info+="ҵ�����ͣ�Ԥ�����̻������ѿɷ���"+"|";
	<%if(goodbz.equals("Y")){%>
	opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
	<%}else{%>
	opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
	<%}%>
	//opr_info+="�̻��������ʷѣ�"+document.all.ip.value+"|";
	//opr_info+="�̻����ͺţ�"+brand_code+phone_type+"      IMEI�룺"+IMEINo+"|";

	opr_info+="�̻��������ͷ���"+total_fee/consume_term+"Ԫ������Ԥ��"+base_fee+"Ԫ���Ԥ��"+free_fee+"Ԫ��"+consume_term+"�����������|";
	opr_info+="�����ֻ����룺"+second_phone+"���ֻ��������ͷ���"+parseFloat(phone_fee/active_term).toFixed(2)+"Ԫ����"+active_term+"�������ͣ�"+active_term+"�����������|";

	/*******��ע��**********/
	if("<%=bdbz%>"=="Y"){
		note_info1+="<%=bdts%>"+"|";
	}else{
		note_info1+=" "+"|";
	}
	/**********������*********/
	note_info2+="�̻��ʷ�˵����"+"|";
	note_info2+=" "+codeChg("<%=note.trim()%>")+"|";
	note_info2+="������Զ�������ʷ�˵����"+"|";
	note_info2+=" "+codeChg("<%=note1.trim()%>")+"|";
	note_info2+="���Ļ�������ʹ�ã����Զ����Ϊ�����ʷѣ������Ե�Ӫҵ�������ԭ�ʷѣ����°��������Ч��|";

	note_info3+="  "+"|";
	note_info4+="��ע��"+"|";
	/***************�ж��Ƿ���ʾ�ַ����******************/
	  var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
	  var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
	  if(old_SmCode == "zn")
  		{
  			//ѦӢ�� 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@���ڻ��������������������� zn->gn ���ֲ�����
  		}
  		else
  		{
	  		if((new_SmCode !="") && (new_SmCode != old_SmCode))
	  		{
		  		/* ningtn �������� */
		  		
	  		}

  		}
  		
  			  	  			/* wanghyd ȥ������������ʾͬʱ������ʾ */
	  			<%if(smzvalue.equals("3")) {%>
		  		note_info1+="<%=readValue("7671","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
  		 		
	if(award_flag == "1")
	{
		note_info1 += "�Ѳ���������Ʒ�"+"|";
	}
	else
	{
		note_info1 += "  "+"|";
	}
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}
//Ԥ�����̻������ѿɷ������
function printInfo7672()
{
	//�õ���ҵ�񹤵���Ҫ�Ĳ���
	var tempStr = document.form1.iAddStr.value;
	/**** ningtn add for pos start *****/
	document.all.bMoney.value = oneTokSelf(tempStr,"|",3);
	if(document.all.payType.value=="BX"){
			document.all.transType.value="01";
	}else if(document.all.payType.value=="BY"){
			document.all.transType.value="04";
	}
	/**** ningtn add for pos end *****/	
	//iAddStr��ʽ ԭ��ˮ|Ӫ������|Ӧ�ս��|����Ԥ��|�Ԥ��|�̻���|�����·�|���ֻ�����|��������|�ֻ�������|�ֻ�����������|�����ʷ�|

	var sale_code = oneTokSelf(tempStr,"|",2);       //Ӫ������
	var prepay_fee = oneTokSelf(tempStr,"|",3);      //Ԥ�滰��
	var base_fee = oneTokSelf(tempStr,"|",4);        //����Ԥ��
	var free_fee = oneTokSelf(tempStr,"|",5);        //�Ԥ��
	var fixed_fee = oneTokSelf(tempStr,"|",6);       //�̻���
	var consume_term = oneTokSelf(tempStr,"|",7);    //�����·�
	var phone_fee = oneTokSelf(tempStr,"|",8);       //���ֻ�����
	var brand_code = oneTokSelf(tempStr,"|",9);      //�ֻ�Ʒ��
	var second_phone= oneTokSelf(tempStr,"|",10);    //�ֻ�������
	var active_term= oneTokSelf(tempStr,"|",11);     //�ֻ�����������
	var mode_name= oneTokSelf(tempStr,"|",12);       //�����ʷ���
      
	var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';
      
     var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
	    /********������Ϣ��**********/
     cust_info+="�ͻ�������" +document.all.i4.value+"|";
     cust_info+="�ֻ����룺"+document.all.phone.value+"|";
     cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
     cust_info+="֤�����룺"+document.all.i7.value+"|";

     
	  /********������**********/
      opr_info+="ҵ�����ͣ�Ԥ�����̻������ѿɷ������"+"|";
      <%if(goodbz.equals("Y")){%>
      		opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}else{%>
      		opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      //opr_info+="���������ʷѣ�"+mode_name+"|";
      opr_info+="�̻�Ʒ���ͺţ�"+brand_code+"|";
      opr_info+="�˿�ϼƣ�"+prepay_fee+"Ԫ������Ԥ��"+base_fee+"Ԫ���Ԥ��"+free_fee+"Ԫ,"+"|";
      opr_info+="�����ֻ������룺"+second_phone+"���ֻ������ͷ���"+phone_fee+"Ԫ|";
      
      /*******��ע��**********/
	  if("<%=bdbz%>"=="Y")
	  {
			note_info1+="<%=bdts%>"+"|";
      }else{
	  		note_info1+=" "+"|";
	  }
	  
	  /**********������*********/
	  note_info3+=" "+"|";
      note_info4+="��ע��"+"|";
      retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
      retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}
function printInfo8045()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	 // rdShowMessageDialog("tempStr = " + tempStr);
	  //iAddStr��ʽ ����ˮ|Ӫ������|Ӧ��|����Ԥ��|����ר��|��������|�µ���|����|������|�ֻ�ԭ��|IMEI|�����ײʹ��� �����ײ�����|
	  
	/**** ningtn add for pos start *****/
	document.all.bMoney.value = oneTokSelf(tempStr,"|",3);
	if(document.all.payType.value=="BX"){
			document.all.transType.value="01";
	}else if(document.all.payType.value=="BY"){
			document.all.transType.value="04";
	}
	/**** ningtn add for pos end *****/	
	  
    	  var sale_code = oneTokSelf(tempStr,"|",2);     //Ӫ������
    	  var brand_code = oneTokSelf(tempStr,"|",8);      //Ʒ������
	  var prepay_fee = oneTokSelf(tempStr,"|",3);     //Ӧ�ս��
	  var main_fee = oneTokSelf(tempStr,"|",4);       //���ͻ���
	  var second_fee = oneTokSelf(tempStr,"|",5);       //����Ԥ��
	  var mark_subtract = oneTokSelf(tempStr,"|",6);  //�����·�
	  var monbase_fee = oneTokSelf(tempStr,"|",7);    //�µ���
	  var cost_price = oneTokSelf(tempStr,"|",10);//�ֻ�ԭ��
	  var IMEINo=oneTokSelf(tempStr,"|",11);//IMEI��
	  var mode_name= oneTokSelf(tempStr,"|",12);//�����ʷ���



	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

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
      opr_info+="ҵ�����ͣ�������ũ���������ֻ�Ӫ������"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="�ֻ��ͺţ�"+brand_code+"      IMEI�룺"+IMEINo+"|";
      opr_info+="�ֻ�ԭ�ۣ�"+cost_price+"Ԫ"+"|";

      if (0 != second_fee){
      	opr_info+="�˿�ϼƣ�"+prepay_fee+"Ԫ�����У�Ԥ�滰�� "+main_fee+"Ԫ������ר�� "+second_fee+"Ԫ)"+"|";
      }else{
      	opr_info+="�˿�ϼƣ�"+prepay_fee+"Ԫ�����У�Ԥ�滰�� "+main_fee+"Ԫ)"+"|";
      }
      opr_info+="�����ʷѣ�"+mode_name+"|";
      opr_info+="ҵ��ִ��ʱ�䣺"+begin_time+"|";

      /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********������*********/
      if(document.all.modestr.value.length>0){
      note_info2+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      note_info2+=" "+"|";
      }

     <%if(goodbz.equals("Y")){%>
			note_info3+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>
      //retInfo+="�����������ķ��ð���Ԥ�滰�ѡ�������Ͳ���ר�����ר������ڰ��³��������ã�������������������ʹ��3���µĲ���ҵ�񣬵�����������ȡ������ȡ������ȡ������ʹ�÷ѡ�Ԥ�滰��ÿ���������ʹ���ܶ������֮һ��������Ļ����������н��ɡ������λ������ֻ�������ֻ�������һ��ʹ�ã����򽫲�����ʹ��Ԥ�滰�ѡ����������������Ƿ�Ѳ����������⣬�ƶ���˾��Ȩ��ʣ��Ԥ�������ջء���������Ԥ�滰�ѱ�����һ����������ϣ�ʣ���ȫ�������㡣"+"|";
      //retInfo+="�������Ϊһ�꣬�����ڲ��ñ���ʷѣ������˿ҵ���ں���԰��涨���������Żݡ�ҵ����ǰ������ȡ���������Żݼ۹�����ֻ������ֻ�ԭ�۲���������ʣ��Ԥ����30%����ΥԼ��"+"|";
     // retInfo+="δ�漰���ʷѣ������е��ƶ��绰�ʷѱ�׼ִ�С����λ�ֻ������й��ƶ�ҵ����Э����Ч�������������ʷѱ�׼�������������µ��ʷ�����ִ�С�"+"|";

    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");

	  return retInfo;
}
//ǩԼ��������
function printInfo126h()
{	
	
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	 // rdShowMessageDialog("tempStr = " + tempStr);
	  //iAddStr��ʽ ��Ʒ�ȼ�|��Ʒ����|Ԥ�滰��|����Ԥ��|�Ԥ��|��ѺԤ��|Ԥ�ۻ���|�����·�|�µ���|��Ʒ����|

		/**** tianyang add for pos start *****/
		document.all.bMoney.value = oneTokSelf(tempStr,"|",3);
		if(document.all.payType.value=="BX"){
				document.all.transType.value="00";
		}else if(document.all.payType.value=="BY"){
				document.all.transType.value="05";
		}
		/**** tianyang add for pos end *****/

    var gift_grade = oneTokSelf(tempStr,"|",1);     //Ӫ������
    var gift_code = oneTokSelf(tempStr,"|",2);      //�ֻ�Ʒ��
	  var prepay_fee = oneTokSelf(tempStr,"|",3);     //Ԥ�滰��
	  var base_fee = oneTokSelf(tempStr,"|",4);       //����Ԥ��
	  var free_fee = oneTokSelf(tempStr,"|",5);       //�Ԥ��
	  var deposit_fee = oneTokSelf(tempStr,"|",6);    //�ֻ��ͺ�
	  var mark_subtract = oneTokSelf(tempStr,"|",7);  //Ԥ�ۻ���
	  var consume_term = oneTokSelf(tempStr,"|",8);   //�����·�
	  var monbase_fee = oneTokSelf(tempStr,"|",9);    //�µ���
	  var IMEINo = oneTokSelf(tempStr,"|",10);

	  var award_flag = oneTokSelf(tempStr,"|",12);//award_flag
	  var sale_kind=oneTokSelf(tempStr,"|",13);

	  var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
	  var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";

	    var retInfo = "";
	    /********������Ϣ��**********/
	  var cust_info=""; //�ͻ���Ϣ
	  var opr_info=""; //������Ϣ
	  var note_info1=""; //��ע1
	  var note_info2=""; //��ע2
	  var note_info3=""; //��ע3
	  var note_info4=""; //��ע4

	  cust_info+="�ֻ����룺"+document.all.phone.value+"|";
	  cust_info+="�ͻ�������"+document.all.i4.value+"|";
	  cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
	  cust_info+="֤�����룺"+document.all.i7.value+"|";

      /********������**********/

      opr_info+="ҵ�����ͣ�ǩԼ����"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      //�������޸�     START                    opr_info+="�ֻ��ͺţ�"+gift_code+deposit_fee+"|";
      opr_info+="�ֻ��ͺţ�"+gift_code+deposit_fee+"      IMEI�룺"+IMEINo+"|";
      //�������޸�     END
      opr_info+="�ɿ�ϼƣ�"+prepay_fee+"Ԫ�����л���Ԥ��"+prepay_fee+"Ԫ��"+"|";

      /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********������*********/

      note_info2+="��ע����ӭ���μӡ�ǩԼ�����������Ļ���Ԥ�����δ�������ǰ�����ˡ�ת�ǩԼ�ڼ䲻�ܱ���ʷ��ײ͡�"+"|";
      note_info2+="�����ֻ����ۻ�������Ļ���δ�����꣬�ͻ����ܰ�������ҵ��"+"|";
      note_info2+="���μӱ��λ��Ԥ�滰�ѣ�Ҫ��һ���ڣ��������£�������ϣ���ÿ���е������ѣ��������ѽ����μ�����ʱ��ҵ��˵�������μӱ��λ��ǩԼ���ʷ�12�����ڣ��������£��������������ں����ʷ�ʱ�����ʷѵ���Чʱ�䣬������ѡ������ʷѾ����ǵ�����Ч�����Ǵ�����Ч��"+"|";
			if(document.all.modestr.value.length>0){
      note_info2+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      note_info2+=" "+"|";
      }
      note_info2+="�ֻ��ն˻��Զ��������϶�Ķ��Ž��в�֣���ͬ�ͺ��ֻ��ն˲��ԭ��ͬ���ҹ�˾�����ֻ��Զ���ֵ������շѡ�"+"|";
	  /*****sunaj  20091221 �����û���������*****/
	  if(old_SmCode=="zn")
	  {
	  		 note_info2+=" ";
	  }else
	  {
	  		if(old_SmCode != new_SmCode)
	  		{
	  			/* ningtn �������� */

	  		}
	  }
	  	  			/* wanghyd ȥ������������ʾͬʱ������ʾ */
	  			<%if(smzvalue.equals("3")) {%>
		  		note_info1+="<%=readValue("126h","ps","jf",Readpaths)%>"+"|";
		  		<%}%>

			<%if(goodbz.equals("Y")){%>
			note_info3+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>
		if(sale_kind=="1" || sale_kind=="2")
		{
			note_info3 += "���������ͻ����а󶨹������������������ֻ��󶨣�ֻ�и����ͻ�ȡ���������ͻ�ҵ�����ȡ����"+"|";
		}

		if(award_flag == "1")
		{
				note_info3 += "�Ѳ���������Ʒ�"+"|";
		}
		else
		{
		    note_info3 += "  "+"|";
		}

		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}
//����Ӫ��������
function printInfo7960()
{
   //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr=Ӫ��������|�����ʷѴ���|ר��Ԥ��|���忪ʼʱ��|������ע|������ˮ|�����ʷ�
    var sale_code = oneTokSelf(tempStr,"|",1);
      var color_mode = oneTokSelf(tempStr,"|",2);
	  var prepay_fee = oneTokSelf(tempStr,"|",3);
	  var mode_begintime = oneTokSelf(tempStr,"|",4);
	  var op_note = oneTokSelf(tempStr,"|",5);
	  var oldaccept = oneTokSelf(tempStr,"|",6);
	  var next_mode = oneTokSelf(tempStr,"|",7);
    var exeDate = "<%=exeDate.substring(0,8)%>";//��Ч����
    var smName = "";
	var smCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
	var old_smCode = "<%=WtcUtil.repNull(request.getParameter("oSmName"))%>";
	if("<%=new_smCode%>" == "zn")
		smName="������";
	else if("<%=new_smCode%>" == "gn")
		smName="ȫ��ͨ";
	else if("<%=new_smCode%>" == "dn")
		smName="���еش�";

    var retInfo = "";
    var cust_info = "";
    var opr_info = "";
    var note_info1 = "";
    var note_info2 = "";
    var note_info3 = "";
    var note_info4 = "";
    /********������Ϣ��**********/
    cust_info += "�ͻ�������" + document.all.i4.value + "|";
    cust_info += "�ֻ����룺" + document.all.phone.value + "|";
    //cust_info += "�ͻ���ַ��" + document.all.i5.value + "|";
    //cust_info += "֤�����룺" + document.all.i7.value + "|";

    /********������**********/
    opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "   �û�Ʒ�ƣ�"+ old_smCode + "|";
<%if(goodbz.equals("Y")){%>
    opr_info += "ҵ������:" + "����Ӫ��������" + "  " + "������ˮ: " + "<%=printAccept%>" + "|";

<%}else{%>
    opr_info += "ҵ������:" + "����Ӫ��������" + "  " + "������ˮ: " + "<%=printAccept%>" + "|";
<%}%>
    opr_info+="���������ʷѣ�"+codeChg(document.form1.ip.value.trim())+"   "+"��Чʱ�䣺"+checkdate(exeDate)+"|";
    opr_info += "�����ʷ�Ʒ�ƣ�" + smName+ "|";
    opr_info += "���ں�ִ���ʷѣ�" + "<%=WtcUtil.repNull(request.getParameter("next_mode"))%>" +"  "+" <%=nextName%>" +"|";
	opr_info+=""+"|" ;
	if( document.all.kx_want.value != "" )
    {
    	opr_info+=codeChg(document.all.kx_want.value) + "|";
    }
    if( document.all.kx_cancle.value != "" )
    {
    	opr_info+=codeChg(document.all.kx_cancle.value) + "|";
    }
    /*******��ע��**********/
    if ("<%=bdbz%>" == "Y") {
        note_info1 += "<%=bdts%>" + "|";
    } else {

    }
    /**********������*********/
	note_info1+="."+"|";
    note_info1+="���������ʷ�����:"+"|";
    note_info1+=" "+codeChg("<%=note.trim()%>")+"|";
    if(document.all.kx_explan_bunch.value.trim().len()==0){

	  }else{
	    note_info3+="."+"| ";
	  	note_info3+="��ѡ�ʷ�������"+"|";
	  	note_info3+=document.all.kx_explan_bunch.value+"|";
	  	//alert(document.all.kx_explan_bunch.value);
  	}
  	if(document.all.modestr.value.length>0){
  	  note_info4+=" ."+"|";
      note_info4+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{

      }

    note_info2+="���ں��ʷ�����:"+"|";
    note_info2+= " " +"|";
    note_info2+=codeChg("<%=note1.trim()%>")+"|";

<%if(goodbz.equals("Y")){%>
    note_info4 += " " + "|";
    note_info4 += "��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��" + "|";
<%}%>
    note_info4 += " " + "|";
    note_info4 += "��ע��" + "|";
    document.all.cust_info.value = cust_info + "#";
    document.all.opr_info.value = opr_info + "#";
    document.all.note_info1.value = note_info1 + "#";
    document.all.note_info2.value = note_info2 + "#";
    document.all.note_info3.value = note_info3 + "#";
    document.all.note_info4.value = note_info4 + "#";
	//retInfo = cust_info+"#"+opr_info+"#"+note_info1+"#"+note_info2+"#"+note_info3+"#"+note_info4+"#";
	/***************�ж��Ƿ���ʾ�ַ����******************/
	  var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
	  var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
	  if(old_SmCode == "zn")
  		{
  			//ѦӢ�� 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@���ڻ��������������������� zn->gn ���ֲ�����
  		}
  		else
  		{
	  		if((new_SmCode !="") && (new_SmCode != old_SmCode))
	  		{
		  		/* ningtn �������� */
		  		
	  		}

  		}
  		
  			  	  			/* wanghyd ȥ������������ʾͬʱ������ʾ */
	  			<%if(smzvalue.equals("3")) {%>
		  		note_info1+="<%=readValue("7960","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
  		
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;
}
//����Ӫ��������
function printInfo7964()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr=Ӫ��������|�����ʷѴ���|ר��Ԥ��|���忪ʼʱ��|������ע|������ˮ|

      var sale_code = oneTokSelf(tempStr,"|",1);
      var color_mode = oneTokSelf(tempStr,"|",2);
	  var prepay_fee = oneTokSelf(tempStr,"|",3);
	  var mode_begintime = oneTokSelf(tempStr,"|",4);
	  var op_note = oneTokSelf(tempStr,"|",5);
	  var oldaccept = oneTokSelf(tempStr,"|",6);
	    var retInfo = "";
	    /********������Ϣ��**********/
	  var cust_info=""; //�ͻ���Ϣ
	  var opr_info=""; //������Ϣ
	  var note_info1=""; //��ע1
	  var note_info2=""; //��ע2
	  var note_info3=""; //��ע3
	  var note_info4=""; //��ע4

	  cust_info+="�ֻ����룺"+document.all.phone.value+"|";
	  cust_info+="�ͻ�������"+document.all.i4.value+"|";
	  //cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
	  //cust_info+="֤�����룺"+document.all.i7.value+"|";

      /********������**********/

      opr_info+="ҵ�����ͣ�����Ӫ��������"+"|";
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      opr_info+=""+"|";
      /*******��ע��**********/
	  opr_info+=""+"|";
	  /**********������*********/
	<%if(goodbz.equals("Y")){%>
    note_info4 += " " + "|";
    note_info4 += "��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��" + "|";
	<%}%>
    note_info4 += " " + "|";
    note_info4 += "��ע��"+"|";
      	opr_info+=""+"|";
      	opr_info+=""+"|";
      	opr_info+=""+"|";
	  	opr_info+=""+"|";
      	opr_info+=""+"|";
		opr_info+=""+"|";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  	return retInfo;
}
//����Ӫ������ǩ
function printInfo7965()
{
	 //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr=Ӫ��������|�����ʷѴ���|ר��Ԥ��|���忪ʼʱ��|������ע|������ˮ|�����ʷ�
    var sale_code = oneTokSelf(tempStr,"|",1);
      var color_mode = oneTokSelf(tempStr,"|",2);
	  var prepay_fee = oneTokSelf(tempStr,"|",3);
	  var mode_begintime = oneTokSelf(tempStr,"|",4);
	  var op_note = oneTokSelf(tempStr,"|",5);
	  var oldaccept = oneTokSelf(tempStr,"|",6);
	  var next_mode = oneTokSelf(tempStr,"|",7);
    var exeDate = "<%=exeDate.substring(0,8)%>";//��Ч����

    <%

    String tempSqlStr = "select b.band_name from product_offer a,band b where a.offer_id='"+NextNew_m_code+"' and a.band_id=b.band_id";
    System.out.println("--------------------tempSqlStr-----------------"+tempSqlStr);
    %>

 		<wtc:pubselect name="sPubSelect" outnum="1" retmsg="msg" retcode="code" routerKey="region" routerValue="<%=regionCode%>">
  	 <wtc:sql><%=tempSqlStr%></wtc:sql>
 	  </wtc:pubselect>
	 <wtc:array id="result_th3" scope="end"/>

	   <%
	   String tempSmNameStr = "";
	   	if(result_th3.length>0&&result_th3[0][0]!=null)
	   	tempSmNameStr = result_th3[0][0];
	   %>
    var smName = "";

	var smCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
	var old_smCode = "<%=WtcUtil.repNull(request.getParameter("oSmName"))%>";
	if("<%=NextNew_m_code%>" == "zn")
		smName="������";
	else if("<%=NextNew_m_code%>" == "gn")
		smName="ȫ��ͨ";
	else if("<%=NextNew_m_code%>" == "dn")
		smName="���еش�";

    var retInfo = "";
    var cust_info = "";
    var opr_info = "";
    var note_info1 = "";
    var note_info2 = "";
    var note_info3 = "";
    var note_info4 = "";
    /********������Ϣ��**********/
    cust_info += "�ͻ�������" + document.all.i4.value + "|";
    cust_info += "�ֻ����룺" + document.all.phone.value + "|";
    //cust_info += "�ͻ���ַ��" + document.all.i5.value + "|";
    //cust_info += "֤�����룺" + document.all.i7.value + "|";

    /********������**********/
    opr_info += "ҵ������ʱ�䣺" + '<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>' + "  �û�Ʒ�ƣ�"+old_smCode + "|";
<%if(goodbz.equals("Y")){%>
    opr_info += "ҵ������:" + "����Ӫ������ǩ" + "  " + "������ˮ: " + "<%=printAccept%>" + "|";
    ;
<%}else{%>
    opr_info += "ҵ������:" + "����Ӫ������ǩ" + "  " + "������ˮ: " + "<%=printAccept%>" + "|";
<%}%>
	  opr_info += ""+"|";
    opr_info += "����������ʷѣ�"+" " + "<%=WtcUtil.repNull(request.getParameter("Nmode_code"))%>"+"  "+"<%=WtcUtil.repNull(request.getParameter("Nmode_name"))%>"+"  "+"��Чʱ�䣺"+exeDate + "|";
    opr_info += "�����ʷ�Ʒ�ƣ� <%=tempSmNameStr%>"+ "|";
    opr_info += "���ں�ִ���ʷѣ�"+" " + "<%=WtcUtil.repNull(request.getParameter("next_mode"))%>"+"  " + "�ʷ����� : "+" "+" <%=nextName%>"+"|";

    /*******��ע��**********/
    if ("<%=bdbz%>" == "Y") {
        note_info1 += "<%=bdts%>" + "|";
    } else {

    }
    /**********������*********/
	note_info1+=""+"|";
    note_info1+="���������ʷ�����:"+"|";
    note_info1+=" "+codeChg("<%=note.trim()%>")+"|";
	if(document.all.kx_explan_bunch.value.trim().len()==0){

	  }else{
	    note_info3+="."+"| ";
	  	note_info3+="��ѡ�ʷ�������"+"|";
	  	note_info3+=document.all.kx_explan_bunch.value+"|";
	  	//alert(document.all.kx_explan_bunch.value);
  	}
  	if(document.all.modestr.value.length>0){
  	  note_info4+=" ."+"|";
      note_info4+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{

      }

    note_info2 += "���ں�ִ���ʷ�������" + "|";
    note_info2+=" "+codeChg("<%=note1.trim()%>")+"|";
<%if(goodbz.equals("Y")){%>
    note_info4 += " " + "|";
    note_info4 += "��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��" + "|";
<%}%>
    note_info4 += " " + "|";
    note_info4 += "��ע��" + "|";
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
//����Ӫ������ǩ����
function printInfo7966()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr=Ӫ��������|�����ʷѴ���|ר��Ԥ��|���忪ʼʱ��|������ע|������ˮ|

      var sale_code = oneTokSelf(tempStr,"|",1);
      var color_mode = oneTokSelf(tempStr,"|",2);
	  var prepay_fee = oneTokSelf(tempStr,"|",3);
	  var mode_begintime = oneTokSelf(tempStr,"|",4);
	  var op_note = oneTokSelf(tempStr,"|",5);
	  var oldaccept = oneTokSelf(tempStr,"|",6);
	    var retInfo = "";
	    /********������Ϣ��**********/
	  var cust_info=""; //�ͻ���Ϣ
	  var opr_info=""; //������Ϣ
	  var note_info1=""; //��ע1
	  var note_info2=""; //��ע2
	  var note_info3=""; //��ע3
	  var note_info4=""; //��ע4

	  cust_info+="�ֻ����룺"+document.all.phone.value+"|";
	  cust_info+="�ͻ�������"+document.all.i4.value+"|";
	  //cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
	  //cust_info+="֤�����룺"+document.all.i7.value+"|";

      /********������**********/

      opr_info+="ҵ�����ͣ�����Ӫ������ǩ����"+"|";
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      opr_info+=""+"|";

      /*******��ע��**********/
	  opr_info+=""+"|";
	  /**********������*********/
	<%if(goodbz.equals("Y")){%>
    note_info4 += " " + "|";
    note_info4 += "��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��" + "|";
	<%}%>
    note_info4 += " " + "|";
    note_info4 += "��ע��"+"|";
      	opr_info+=""+"|";
      	opr_info+=""+"|";
      	opr_info+=""+"|";
	  	opr_info+=""+"|";
      	opr_info+=""+"|";
		opr_info+=""+"|";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  	return retInfo;
}
//����Ӫ����ȡ��
function printInfo7967()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr=Ӫ��������|�����ʷѴ���|ר��Ԥ��|���忪ʼʱ��|������ע|������ˮ|

      var sale_code = oneTokSelf(tempStr,"|",1);
      var color_mode = oneTokSelf(tempStr,"|",2);
	  var prepay_fee = oneTokSelf(tempStr,"|",3);
	  var mode_begintime = oneTokSelf(tempStr,"|",4);
	  var op_note = oneTokSelf(tempStr,"|",5);
	  var oldaccept = oneTokSelf(tempStr,"|",6);
	    var retInfo = "";
	    /********������Ϣ��**********/
	  var cust_info=""; //�ͻ���Ϣ
	  var opr_info=""; //������Ϣ
	  var note_info1=""; //��ע1
	  var note_info2=""; //��ע2
	  var note_info3=""; //��ע3
	  var note_info4=""; //��ע4

	  cust_info+="�ֻ����룺"+document.all.phone.value+"|";
	  cust_info+="�ͻ�������"+document.all.i4.value+"|";
	  //cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
	  //cust_info+="֤�����룺"+document.all.i7.value+"|";

      /********������**********/

      opr_info+="ҵ�����ͣ�����Ӫ����ȡ��"+"|";
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      opr_info+=""+"|";

      /*******��ע��**********/
	  opr_info+=""+"|";
	  /**********������*********/
	note_info4 += "��ע��"+"|";
	<%if(goodbz.equals("Y")){%>
    note_info4 += " " + "|";
    note_info4 += "��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��" + "|";
	<%}%>
    note_info4 += " " + "|";

      	opr_info+=""+"|";
      	opr_info+=""+"|";
      	opr_info+=""+"|";
	  	opr_info+=""+"|";
      	opr_info+=""+"|";
		opr_info+=""+"|";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  	return retInfo;
}
//ǩԼ��������
function printInfo126i()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	  //rdShowMessageDialog("tempStr = " + tempStr);
	  //iAddStr��ʽ ��Ʒ�ȼ�|��Ʒ����|Ԥ�滰��|����Ԥ��|�Ԥ��|��ѺԤ��|Ԥ�ۻ���|�����·�|�µ���|��Ʒ����|

		/**** tianyang add for pos start *****/
		document.all.bMoney.value = oneTokSelf(tempStr,"|",3);
		if(document.all.payType.value=="BX"){
				document.all.transType.value="01";
		}else if(document.all.payType.value=="BY"){
				document.all.transType.value="04";
		}
		/**** tianyang add for pos end *****/

    var gift_grade = oneTokSelf(tempStr,"|",1);     //������ˮ
    var gift_code = oneTokSelf(tempStr,"|",2);      //Ӫ������
	  var prepay_fee = oneTokSelf(tempStr,"|",3);     //Ԥ�滰��
	  var base_fee = oneTokSelf(tempStr,"|",4);       //����Ԥ��
	  var free_fee = oneTokSelf(tempStr,"|",5);       //�Ԥ��
	  var deposit_fee = oneTokSelf(tempStr,"|",6);    //��ѺԤ��
	  var mark_subtract = oneTokSelf(tempStr,"|",7);  //Ԥ�ۻ���
	  var consume_term = oneTokSelf(tempStr,"|",8);   //�����·�
	  var monbase_fee = oneTokSelf(tempStr,"|",9);    //�µ���
	  var type_name = oneTokSelf(tempStr,"|",10);  //����

	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	    var retInfo = "";
	    /********������Ϣ��**********/
	  var cust_info=""; //�ͻ���Ϣ
	  var opr_info=""; //������Ϣ
	  var note_info1=""; //��ע1
	  var note_info2=""; //��ע2
	  var note_info3=""; //��ע3
	  var note_info4=""; //��ע4

	  cust_info+="�ֻ����룺"+document.all.phone.value+"|";
	  cust_info+="�ͻ�������"+document.all.i4.value+"|";
	  cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
	  cust_info+="֤�����룺"+document.all.i7.value+"|";

     /********������**********/
      opr_info+="ҵ�����ͣ�ǩԼ��������"+"|";

      <%if(goodbz.equals("Y")){%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="�ֻ��ͺţ�"+type_name+"|";
      opr_info+="�˿�ϼƣ�"+prepay_fee+"Ԫ�����л���Ԥ��"+prepay_fee+"Ԫ��"+"|";

       /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********������*********/
     if(document.all.modestr.value.length>0){
      note_info2+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      note_info2+=" "+"|";
      }
			<%if(goodbz.equals("Y")){%>
			note_info2+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>

	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}

//���ſͻ�Ԥ����������
function printInfo8023()
{
	//�õ���ҵ�񹤵���Ҫ�Ĳ���
	var tempStr = document.form1.iAddStr.value;
	// rdShowMessageDialog("tempStr = " + tempStr);
	//iAddStr��ʽ ��Ʒ�ȼ�|��Ʒ����|Ԥ�滰��|����Ԥ��|�Ԥ��|��ѺԤ��|Ԥ�ۻ���|�����·�|�µ���|��Ʒ����|
		
	/**** tianyang add for pos start *****/
	document.all.bMoney.value = oneTokSelf(tempStr,"|",3);
	if(document.all.payType.value=="BX"){
			document.all.transType.value="00";
	}else if(document.all.payType.value=="BY"){
			document.all.transType.value="05";
	}
	/**** tianyang add for pos end *****/
		
	var gift_grade = oneTokSelf(tempStr,"|",1);     //Ӫ������
  var gift_code = oneTokSelf(tempStr,"|",2);      //�ֻ�Ʒ��
	var prepay_fee = oneTokSelf(tempStr,"|",3);     //Ԥ�滰��
	var base_fee = oneTokSelf(tempStr,"|",4);       //����Ԥ��
	var free_fee = oneTokSelf(tempStr,"|",5);       //�Ԥ��
	var deposit_fee = oneTokSelf(tempStr,"|",6);    //�ֻ��ͺ�
	var mark_subtract = oneTokSelf(tempStr,"|",7);  //Ԥ�ۻ���
	var consume_term = oneTokSelf(tempStr,"|",8);   //�����·�
	var monbase_fee = oneTokSelf(tempStr,"|",9);    //�µ���
	var IMEINo = oneTokSelf(tempStr,"|",10);

	var award_flag = oneTokSelf(tempStr,"|",12);//award_flag
	
	var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
  var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";

	var retInfo = "";	
	
	/********������Ϣ��**********/	
	var cust_info=""; //�ͻ���Ϣ
  var opr_info=""; //������Ϣ
  var note_info1=""; //��ע1
  var note_info2=""; //��ע2
  var note_info3=""; //��ע3
  var note_info4=""; //��ע4

  cust_info+="�ֻ����룺"+document.all.phone.value+"|";
  cust_info+="�ͻ�������"+document.all.i4.value+"|";
  cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
  cust_info+="֤�����룺"+document.all.i7.value+"|";
	
		/********������**********/	
	opr_info+="ҵ�����ͣ����ſͻ�Ԥ����������"+"|";
  <%if(goodbz.equals("Y")){%>
  opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
  <%}else{%>
  opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
  <%}%>
  //�������޸�     START                    opr_info+="�ֻ��ͺţ�"+gift_code+deposit_fee+"|";
  opr_info+="�ֻ��ͺţ�"+gift_code+deposit_fee+"      IMEI�룺"+IMEINo+"|";
  //�������޸�     END
  opr_info+="�ɿ�ϼƣ�"+prepay_fee+"Ԫ�����л���Ԥ��"+prepay_fee+"Ԫ��"+"|";

  /*******��ע��**********/
	if("<%=bdbz%>"=="Y"){
  	note_info1+="<%=bdts%>"+"|";
  }else{
		note_info1+=" "+"|";
	}
	/**********������*********/
	note_info2+="�����뼯�ſͻ�Ԥ�滰�����ֻ����Ԥ�滰�Ѳ��˲�ת��ǩԼ��Ϊ1�꣬����Ԥ�水�·�����ǩԼ���ڲ��ܰ����ʷѱ�������Ҫ��ȡ�����ƣ���������Ʒ��������ԭ����ء��ʷ�ȡ����ʣ��İ���Ѱ�30%����ΥԼ��"+"|";
	if(document.all.modestr.value.length>0){
  note_info2+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
  }else{
  note_info2+=" "+"|";
  }
  <%if(goodbz.equals("Y")){%>
		note_info2+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
	<%}%>
  note_info2+="�ֻ��ն˻��Զ��������϶�Ķ��Ž��в�֣���ͬ�ͺ��ֻ��ն˲��ԭ��ͬ���ҹ�˾�����ֻ��Զ���ֵ������շѡ�"+"|";
  /***************�ж��Ƿ���ʾ�ַ����******************/
	  if(old_SmCode == "zn")
  		{
  			//ѦӢ�� 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@���ڻ��������������������� zn->gn ���ֲ�����
  		}
  		else
  		{
	  		if((new_SmCode !="") && (new_SmCode != old_SmCode))
	  		{
		  		/* ningtn �������� */
		  	
	  		}

  		}
  		
  			  	  			/* wanghyd ȥ������������ʾͬʱ������ʾ */
	  			<%if(smzvalue.equals("3")) {%>
		  		note_info1+="<%=readValue("8023","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
		  		
  if(award_flag == "1")
	{
			note_info2 += "�Ѳ���������Ʒ�"+"|";
	}
	else
	{
	    note_info2 += "  "+"|";
	}
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  return retInfo;
}
//���ſͻ�Ԥ����������
function printInfo8024()
{
	//�õ���ҵ�񹤵���Ҫ�Ĳ���
	var tempStr = document.form1.iAddStr.value;
	//rdShowMessageDialog("tempStr = " + tempStr);
	//iAddStr��ʽ ��Ʒ�ȼ�|��Ʒ����|Ԥ�滰��|����Ԥ��|�Ԥ��|��ѺԤ��|Ԥ�ۻ���|�����·�|�µ���|��Ʒ����|
	
	/**** tianyang add for pos start *****/
	document.all.bMoney.value = oneTokSelf(tempStr,"|",3);
	if(document.all.payType.value=="BX"){
			document.all.transType.value="01";
	}else if(document.all.payType.value=="BY"){
			document.all.transType.value="04";
	}
	/**** tianyang add for pos end *****/	


  var gift_grade = oneTokSelf(tempStr,"|",1);     //������ˮ
  var gift_code = oneTokSelf(tempStr,"|",2);      //Ӫ������
	var prepay_fee = oneTokSelf(tempStr,"|",3);     //Ԥ�滰��
	var base_fee = oneTokSelf(tempStr,"|",4);       //����Ԥ��
	var free_fee = oneTokSelf(tempStr,"|",5);       //�Ԥ��
	var deposit_fee = oneTokSelf(tempStr,"|",6);    //��ѺԤ��
	var mark_subtract = oneTokSelf(tempStr,"|",7);  //Ԥ�ۻ���
	var consume_term = oneTokSelf(tempStr,"|",8);   //�����·�
	var monbase_fee = oneTokSelf(tempStr,"|",9);    //�µ���
	var type_name = oneTokSelf(tempStr,"|",10);  //����
	
	var retInfo = "";
	/********������Ϣ��**********/	
	var cust_info=""; //�ͻ���Ϣ
  var opr_info=""; //������Ϣ
  var note_info1=""; //��ע1
  var note_info2=""; //��ע2
  var note_info3=""; //��ע3
  var note_info4=""; //��ע4

  cust_info+="�ֻ����룺"+document.all.phone.value+"|";
  cust_info+="�ͻ�������"+document.all.i4.value+"|";
  cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
  cust_info+="֤�����룺"+document.all.i7.value+"|";
	/********������**********/
	opr_info+="ҵ�����ͣ����ſͻ�Ԥ����������"+"|";

  <%if(goodbz.equals("Y")){%>
  opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
  <%}else{%>
  opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
  <%}%>
  opr_info+="�ֻ��ͺţ�"+type_name+"|";
  opr_info+="�˿�ϼƣ�"+prepay_fee+"Ԫ�����л���Ԥ��"+prepay_fee+"Ԫ��"+"|";

  /*******��ע��**********/
	if("<%=bdbz%>"=="Y"){
		note_info1+="<%=bdts%>"+"|";
	}else{
		note_info1+=" "+"|";
	}
	/**********������*********/
	if(document.all.modestr.value.length>0){
  	note_info2+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
  }else{
  	note_info2+=" "+"|";
  }
	<%if(goodbz.equals("Y")){%>
	note_info2+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
	<%}%>
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  return retInfo;
}



//��������ʷ�Ӫ��������
function printInfo8094()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	   var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
	  var retInfo = "";

	  var tempStr = document.form1.iAddStr.value;

		var gift_code     = oneTokSelf(tempStr,"|",1);	//��Ʒ����
		var prepay_fee    = oneTokSelf(tempStr,"|",2);	//Ԥ�滰��
		var base_fee      = oneTokSelf(tempStr,"|",3);	//����Ԥ��
		var free_fee      = oneTokSelf(tempStr,"|",4);	//�Ԥ��
		var mark_subtract = oneTokSelf(tempStr,"|",5);	//Ԥ�ۻ���
		var consume_term  = oneTokSelf(tempStr,"|",6);	//�����·�
		var monbase_fee   = oneTokSelf(tempStr,"|",7);	//�µ���
		var gift_name     = oneTokSelf(tempStr,"|",8);	//��Ʒ����

	  var begin_time='<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>';

	  /********������Ϣ��**********/

      cust_info+="�ֻ����룺"+document.all.phone.value+"|";
      cust_info+="�ͻ�������" +document.all.i4.value+"|";
      cust_info+="֤�����룺"+document.all.i7.value+"|";
      cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";


      /********������**********/
      opr_info+="�û�Ʒ�ƣ�"+'<%=WtcUtil.repNull(request.getParameter("oSmName"))%>'+"                   ����ҵ����������ʷ�Ӫ��������"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="������ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="�����: "+monbase_fee+"Ԫ     ҵ�����ʱ��: "+begin_time+"|";
      opr_info+="�����: "+prepay_fee+"Ԫ|";
      opr_info+="�������ޣ�"+consume_term+"����"+"         ҵ����Чʱ�䣺"+"<%=exeDate.substring(0,8)%>"+"|";
      opr_info+="ָ���ʷѣ� "+ document.all.ip.value+"|";
      /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
      note_info1+="ָ���ʷ�������"+"<%=note%>"+"|";

      note_info1+="������Ч��Ϊ12���£�һ���ڲ������ʷѱ���������ʷѵ��ں��Զ�תΪ������30��ͨ�����硣��ҵ��������һ����ȡ�����˲�ת��"+"|";
	  /***************�ж��Ƿ���ʾ�ַ����******************/
	  var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
      var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
	  if(old_SmCode == "zn")
  		{
  			//ѦӢ�� 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@���ڻ��������������������� zn->gn ���ֲ�����
  		}
  		else
  		{
	  		if((new_SmCode !="") && (new_SmCode != old_SmCode))
	  		{
		  		/* ningtn �������� */
		  		
	  		}

  		}
  			  	  			/* wanghyd ȥ������������ʾͬʱ������ʾ */
	  			<%if(smzvalue.equals("3")) {%>
		  		note_info1+="<%=readValue("8094","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
		  		
	  <%if(goodbz.equals("Y")){%>
			note_info1+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;

}
//��������ʷ�Ӫ��������
function printInfo8091()
{

	 var cust_info="";
	 var opr_info="";
	 var note_info1="";
	 var note_info2="";
	 var note_info3="";
	 var note_info4="";
	 var retInfo = "";


	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;

		var gift_code     = oneTokSelf(tempStr,"|",1);	//��Ʒ����
		var prepay_fee    = oneTokSelf(tempStr,"|",2);	//Ԥ�滰��
		var base_fee      = oneTokSelf(tempStr,"|",3);	//����Ԥ��
		var free_fee      = oneTokSelf(tempStr,"|",4);	//�Ԥ��
		var mark_subtract = oneTokSelf(tempStr,"|",5);	//Ԥ�ۻ���
		var consume_term  = oneTokSelf(tempStr,"|",6);	//�����·�
		var monbase_fee   = oneTokSelf(tempStr,"|",7);	//�µ���
		var gift_name     = oneTokSelf(tempStr,"|",9);	//��Ʒ����

	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	  var retInfo = "";
	  /********������Ϣ��**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      cust_info+="�ֻ����룺"+document.all.phone.value+"|";
      cust_info+="�ͻ�������" +document.all.i4.value+"|";
      cust_info+="֤�����룺"+document.all.i7.value+"|";
      cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";

      /********������**********/
      opr_info+="ҵ�����ͣ���������ʷ�Ӫ��������"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="�����: "+monbase_fee+"Ԫ     ҵ�����ʱ��: "+begin_time+"|";
      opr_info+="�����: "+prepay_fee+"Ԫ|";
      opr_info+="��������:  "+consume_term+"����|";
      /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
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
//ũ��Ͷ�Ӫ����
function formatFloat(src, pos)
{
    return Math.round(src*Math.pow(10, pos))/Math.pow(10, pos);
}

function printInfo8034()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	  // rdShowMessageDialog("tempStr = " + tempStr);
	  //iAddStr��ʽ Ӫ������|�ֻ�Ʒ��|Ԥ�滰��|ũ�������|����|�շ�|SP����|��Ʒ����|��Ʒ����|IMEI��|

    var gift_grade = oneTokSelf(tempStr,"|",1);     //Ӫ������
    var phone_code = oneTokSelf(tempStr,"|",2);      //�ֻ�Ʒ��

	  var prepay_fee = oneTokSelf(tempStr,"|",3);     //Ԥ�滰��

	  var phone_type = oneTokSelf(tempStr,"|",5);    //�ֻ��ͺ�
	  var sp_fee = oneTokSelf(tempStr,"|",4);  //ũ�������
	  var gift_name = oneTokSelf(tempStr,"|",9);   //��Ʒ����
	  var gift_code=oneTokSelf(tempStr,"|",8);//��Ʒ����
	  var pay_money= oneTokSelf(tempStr,"|",6); //�շ�
	  var IMEINo = oneTokSelf(tempStr,"|",10);  //IMEI��



	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	    var retInfo = "";
	     /********������Ϣ��**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="�ͻ����ƣ�" +document.all.i4.value+"|";
      retInfo+="�ֻ����룺"+document.all.phone.value+"|";
      retInfo+="�ͻ���ַ��"+document.all.i5.value+"|";
      retInfo+="֤�����룺"+document.all.i7.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
     /********������**********/
      retInfo+="ҵ�����ͣ�������ũ�塢�ֻ������"+"|";
      <%if(goodbz.equals("Y")){%>
      retInfo+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      retInfo+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
     //�������޸�     START                    retInfo+="�ֻ��ͺţ�"+phone_code+phone_type+"|";
      retInfo+="�ֻ��ͺţ�"+phone_code+phone_type+"      IMEI�룺"+IMEINo+"|";
      //�������޸�     END
      if(gift_code==""){
      retInfo+="�ɿ�ϼƣ�"+pay_money+"Ԫ����Ԥ�滰�ѣ�"+prepay_fee+"Ԫ��ũ��ͨҵ��������:"+sp_fee+"Ԫ��"+"|";
      }else{
      retInfo+="�ɿ�ϼƣ�"+pay_money+"Ԫ����Ԥ�滰�ѣ�"+prepay_fee+"Ԫ��ũ��ͨҵ��������:"+sp_fee+"Ԫ��������Ʒ��"+gift_name+"��"+"|";
      }
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
			/*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	retInfo+="<%=bdts%>"+"|";
      }else{
	  	retInfo+=" "+"|";
	  	}
	  /**********������*********/
      retInfo+="��ע����ӭ���μӡ�������ũ�塢�ֻ�����ҡ����1�����Ļ���Ԥ���������·������·������Ϊ"+formatFloat(prepay_fee/6, 2)+"Ԫ����ʮ���������ڲ��ܱ���ʷ��ײͣ�2��ũ��ͨҵ��ѷ�12���·������·������3Ԫ�����ڼ�ũ��ͨҵ���ܱ����ȡ����"+"|";
      if(document.all.modestr.value.length>0){
      retInfo+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      retInfo+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			retInfo+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>


	  return retInfo;
}
function printInfo8035()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	 // rdShowMessageDialog("tempStr = " + tempStr);
	  //iAddStr��ʽ ԭ��ˮ|Ӫ������|��������|Ԥ�滰��|ũ�������|�շ�|SP����|��Ʒ����|

    var gift_grade = oneTokSelf(tempStr,"|",1);     //Ӫ������
    var phone_type = oneTokSelf(tempStr,"|",3);      //�ֻ�Ʒ��

	  var prepay_fee = oneTokSelf(tempStr,"|",4);     //Ԥ�滰��


	  var sp_fee = oneTokSelf(tempStr,"|",5);  //ũ�������
	  var gift_name = oneTokSelf(tempStr,"|",8);   //��Ʒ����

	  var pay_money= oneTokSelf(tempStr,"|",6); //�շ�



	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	    var retInfo = "";
	    /********������Ϣ��**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="�ͻ����ƣ�" +document.all.i4.value+"|";
      retInfo+="�ֻ����룺"+document.all.phone.value+"|";
      retInfo+="�ͻ���ַ��"+document.all.i5.value+"|";
      retInfo+="֤�����룺"+document.all.i7.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
     /********������**********/
      retInfo+="ҵ�����ͣ�������ũ�塢�ֻ�����ҳ���"+"|";
      <%if(goodbz.equals("Y")){%>
      retInfo+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      retInfo+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      retInfo+="�ֻ��ͺţ�"+phone_type+"|";

      if(gift_name==""){
      retInfo+="�˿�ϼƣ�"+pay_money+"Ԫ����Ԥ�滰�ѣ�"+prepay_fee+"Ԫ��ũ��ͨҵ��������:"+sp_fee+"Ԫ��"+"|";
      }else{
      retInfo+="�˿�ϼƣ�"+pay_money+"Ԫ����Ԥ�滰�ѣ�"+prepay_fee+"Ԫ��ũ��ͨҵ��������:"+sp_fee+"Ԫ��������Ʒ��"+gift_name+"��"+"|";
      }
     retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	retInfo+="<%=bdts%>"+"|";
      }else{
	  	retInfo+=" "+"|";
	  	}
	  /**********������*********/
      if(document.all.modestr.value.length>0){
      retInfo+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      retInfo+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			retInfo+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>
      //retInfo+="��ע����ӭ���μӡ�������ũ�塢�ֻ��ֳɼҡ�������Ļ���Ԥ���·������·������Ϊ"+formatFloat(prepay_fee/6, 2)+"Ԫ�������������ڲ��ܱ���ʷ��ײ͡�"+"|";
      //retInfo+="�����ֻ����ۻ�������Ļ���δ�����꣬�ͻ����ܰ�������ҵ��"+"|";


	  return retInfo;
}
//�¸���Ϣ��Ӫ����
function printInfo8070()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	  // rdShowMessageDialog("tempStr = " + tempStr);
	  //iAddStr��ʽ Ӫ������|Ԥ�滰��|ũ�������|�շ�|SP����|IMEI��|����ID|��������|������|

    var gift_grade = oneTokSelf(tempStr,"|",1);     //Ӫ������
    var prepay_fee = oneTokSelf(tempStr,"|",2);      //Ԥ�滰��
	  var sp_fee = oneTokSelf(tempStr,"|",3);     //ũ�������
	  var pay_money = oneTokSelf(tempStr,"|",4);    //�շ�
	  var IMEINo = oneTokSelf(tempStr,"|",6);  //IMEI��
	  var grp_id = oneTokSelf(tempStr,"|",7);   //����ID
	  var grp_name=oneTokSelf(tempStr,"|",8);//��������
	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	    var cust_info=""; //�ͻ���Ϣ
		var opr_info=""; //������Ϣ
		var note_info1=""; //��ע1
		var note_info2=""; //��ע2
		var note_info3=""; //��ע3
		var note_info4=""; //��ע4
	    var retInfo = "";  //��ӡ����
	    /********������Ϣ��**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      cust_info+="�ͻ�������" +document.all.i4.value+"|";
      cust_info+="�ֻ����룺"+document.all.phone.value+"|";
      cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
      cust_info+="֤�����룺"+document.all.i7.value+"|";
      retInfo+="����ID: "+grp_id+"|";
      retInfo+="��������: "+grp_name+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
     /********������**********/
      opr_info+="ҵ�����ͣ��¸���Ϣ��Ӫ����"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="IMEI�룺"+IMEINo+"|";
      opr_info+="ҵ���ײͣ�"+document.all.ip.value+"|";
      opr_info+="�ɿ�ϼƣ�"+pay_money+"Ԫ"+"|";
      opr_info+="��Ԥ��"+prepay_fee+"Ԫ"+"|";
			opr_info+=" "+"|";
      opr_info+="Ԥ���ʹ������Ϊһ�꣬���ò��˲�ת�����ں�һ�����ջء�"+"|";
      /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********������*********/
      if(document.all.modestr.value.length>0){
      note_info2+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      note_info2+=" "+"|";
      }
			<%if(goodbz.equals("Y")){%>
			note_info3+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>
	  
	  /***************�ж��Ƿ���ʾ�ַ����******************/
	  var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
      var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
	  if(old_SmCode == "zn")
  		{
  			//ѦӢ�� 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@���ڻ��������������������� zn->gn ���ֲ�����
  		}
  		else
  		{
	  		if((new_SmCode !="") && (new_SmCode != old_SmCode))
	  		{
		  		/* ningtn �������� */
		  		
	  		}

  		}
  		
  			  	  			/* wanghyd ȥ������������ʾͬʱ������ʾ */
	  			<%if(smzvalue.equals("3")) {%>
		  		note_info1+="<%=readValue("8070","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
  		
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");

	    return retInfo;
}
function printInfo8071()
{
	//alert("printInfo8071");
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	  // rdShowMessageDialog("tempStr = " + tempStr);
	  //iAddStr��ʽ ԭ��ˮ|Ԥ�滰��|ũ�������|�շ�|SP����|IMEI��|����ID|��������|Ӫ������|������|

    	  var gift_grade = oneTokSelf(tempStr,"|",1);     //ԭ��ˮ
    	  var prepay_fee = oneTokSelf(tempStr,"|",2);      //Ԥ�滰��
	  var sp_fee = oneTokSelf(tempStr,"|",3);     //ũ�������
	  var pay_money = oneTokSelf(tempStr,"|",4);    //�շ�
	  var IMEINo = oneTokSelf(tempStr,"|",6);  //IMEI��
	  var grp_id = oneTokSelf(tempStr,"|",7);   //����ID
	  var grp_name=oneTokSelf(tempStr,"|",8);//��������


	   var cust_info=""; //�ͻ���Ϣ
		var opr_info=""; //������Ϣ
		var note_info1=""; //��ע1
		var note_info2=""; //��ע2
		var note_info3=""; //��ע3
		var note_info4=""; //��ע4
	    var retInfo = "";  //��ӡ����
	    /********������Ϣ��**********/

      cust_info+="�ֻ����룺"+document.all.phone.value+"|";
      cust_info+="�ͻ�������" +document.all.i4.value+"|";
      cust_info+="֤�����룺"+document.all.i7.value+"|";
      cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";


      opr_info+="����ID: "+grp_id+"|";
      opr_info+="��������: "+grp_name+"|";
     /********������**********/
      opr_info+="ҵ�����ͣ��¸���Ϣ��Ӫ��������"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="IMEI�룺"+IMEINo+"|";
      opr_info+="ҵ���ײͣ�"+document.all.ip.value+"|";
      opr_info+="�˿�ϼƣ�"+pay_money+"Ԫ"+"|";
      opr_info+="��Ԥ��"+prepay_fee+"Ԫ"+"|";
     /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
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
//���еش��û�ǩԼ����Ʒ����
function printInfo2264()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;

		var gift_code     = oneTokSelf(tempStr,"|",1);	//��Ʒ����
		var prepay_fee    = oneTokSelf(tempStr,"|",2);	//Ԥ�滰��
		var base_fee      = oneTokSelf(tempStr,"|",3);	//����Ԥ��
		var free_fee      = oneTokSelf(tempStr,"|",4);	//�Ԥ��
		var mark_subtract = oneTokSelf(tempStr,"|",5);	//Ԥ�ۻ���
		var consume_term  = oneTokSelf(tempStr,"|",6);	//�����·�
		var monbase_fee   = oneTokSelf(tempStr,"|",7);	//�µ���
		var gift_name     = oneTokSelf(tempStr,"|",8);	//��Ʒ����

	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	  var retInfo = "";
	  /********������Ϣ��**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="�ͻ����ƣ�" +document.all.i4.value+"|";
      retInfo+="�ֻ����룺"+document.all.phone.value+"|";
      retInfo+="�ͻ���ַ��"+document.all.i5.value+"|";
      retInfo+="֤�����룺"+document.all.i7.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      /********������**********/
      retInfo+="ҵ�����ͣ����еش�ǩԼ����Ʒ"+"|";
      <%if(goodbz.equals("Y")){%>
      retInfo+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      retInfo+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      retInfo+="��Ʒ����: "+gift_name+"|";
	  retInfo+="Ԥ�滰��: "+prepay_fee+"Ԫ |";
      retInfo+="Ԥ�������:  "+consume_term+"����|";
	  retInfo+="Ԥ�ۻ���: "+mark_subtract+"  ҵ��ִ��ʱ��: "+begin_time+"|";
      retInfo+="���ʷ�:"+ codeChg(document.all.ip.value)+"|";
	  retInfo+="��ѡ�ʷ�:"+ document.all.kx_code_name_bunch.value +"|";
      retInfo+=" "+"|";
      /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	retInfo+="<%=bdts%>"+"|";
      }else{
	  	retInfo+=" "+"|";
	  	}
	  /**********������*********/
      if(document.all.modestr.value.length>0){
      retInfo+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      retInfo+=" "+"|";
      }
      retInfo+="���ʷ�˵����"+"|";
      retInfo+="�����������齱��������£����������£��ڲ��ܽ����ʷѱ��������ǰ����ǰ���������Ʒ��������ԭ����ء�"+"|";
	  retInfo+=" "+"|";

	  return retInfo;

}
//���еش��û�ǩԼ����Ʒ����
function printInfo2265()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;

		var gift_code     = oneTokSelf(tempStr,"|",1);	//��Ʒ����
		var prepay_fee    = oneTokSelf(tempStr,"|",2);	//Ԥ�滰��
		var base_fee      = oneTokSelf(tempStr,"|",3);	//����Ԥ��
		var free_fee      = oneTokSelf(tempStr,"|",4);	//�Ԥ��
		var mark_subtract = oneTokSelf(tempStr,"|",5);	//Ԥ�ۻ���
		var consume_term  = oneTokSelf(tempStr,"|",6);	//�����·�
		var monbase_fee   = oneTokSelf(tempStr,"|",7);	//�µ���
		var gift_name     = oneTokSelf(tempStr,"|",8);	//��Ʒ����

	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	  var retInfo = "";
	  /********������Ϣ��**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="�ͻ����ƣ�" +document.all.i4.value+"|";
      retInfo+="�ֻ����룺"+document.all.phone.value+"|";
      retInfo+="�ͻ���ַ��"+document.all.i5.value+"|";
      retInfo+="֤�����룺"+document.all.i7.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      /********������**********/
      retInfo+="ҵ�����ͣ����еش�ǩԼ����Ʒ����"+"|";
      <%if(goodbz.equals("Y")){%>
      retInfo+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      retInfo+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      retInfo+="��Ʒ����: "+gift_name+"|";
	  retInfo+="Ԥ�滰��: "+prepay_fee+"Ԫ |";
      retInfo+="Ԥ�������:  "+consume_term+"����|";
	  retInfo+="Ԥ�ۻ���: "+mark_subtract+"  ҵ��ִ��ʱ��: "+begin_time+"|";
      retInfo+="���ʷ�:"+ codeChg(document.all.ip.value)+"|";
	  retInfo+="��ѡ�ʷ�:"+ document.all.kx_code_name_bunch.value +"|";
      retInfo+=" "+"|";
      /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	retInfo+="<%=bdts%>"+"|";
      }else{
	  	retInfo+=" "+"|";
	  	}
	  /**********������*********/
      if(document.all.modestr.value.length>0){
      retInfo+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      retInfo+=" "+"|";
      }
      retInfo+="���ʷ�˵����"+"|";
      retInfo+="�����������齱��������£����������£��ڲ��ܽ����ʷѱ��������ǰ����ǰ���������Ʒ��������ԭ����ء�"+"|";
	  retInfo+=" "+"|";

	  return retInfo;

}
//ǩԼ����Ʒ����
function printInfo2281()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;

		var gift_code     = oneTokSelf(tempStr,"|",1);	//��Ʒ����
		var prepay_fee    = oneTokSelf(tempStr,"|",2);	//Ԥ�滰��
		var base_fee      = oneTokSelf(tempStr,"|",3);	//����Ԥ��
		var free_fee      = oneTokSelf(tempStr,"|",4);	//�Ԥ��
		var mark_subtract = oneTokSelf(tempStr,"|",5);	//Ԥ�ۻ���
		var consume_term  = oneTokSelf(tempStr,"|",6);	//�����·�
		var monbase_fee   = oneTokSelf(tempStr,"|",7);	//�µ���
		var gift_name     = oneTokSelf(tempStr,"|",8);	//��Ʒ����

	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	  var retInfo = "";
	  /********������Ϣ��**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="�ͻ����ƣ�" +document.all.i4.value+"|";
      retInfo+="�ֻ����룺"+document.all.phone.value+"|";
      retInfo+="�ͻ���ַ��"+document.all.i5.value+"|";
      retInfo+="֤�����룺"+document.all.i7.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      /********������**********/
      retInfo+="ҵ�����ͣ�ǩԼ����Ʒ"+"|";
      <%if(goodbz.equals("Y")){%>
      retInfo+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      retInfo+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      retInfo+="��Ʒ����: "+gift_name+"|";
      retInfo+="�µ���: "+monbase_fee+"Ԫ     Ԥ�ۻ���: "+mark_subtract+"  ҵ��ִ��ʱ��: "+begin_time+"|";
      retInfo+="Ԥ�滰��: "+prepay_fee+"Ԫ     ����:  ����Ԥ��: "+base_fee+"Ԫ  �Ԥ��: "+free_fee+"Ԫ|";
      retInfo+="Ԥ�������:  "+consume_term+"����|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	retInfo+="<%=bdts%>"+"|";
      }else{
	  	retInfo+=" "+"|";
	  	}
	  /**********������*********/
      if(document.all.modestr.value.length>0){
      retInfo+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      retInfo+=" "+"|";
      }
      retInfo+="��ע���ͻ���������ҵ���ʷѱ��Ϊ30��ҵ����ʷѣ���0���⣬5Ԫ������ʾ����ѡ����"+"|";
      retInfo+="30Ԫ��ҵ�������10Ԫ����/�£�10ԪIVR/�£�5Ԫ12580/�£�5ԪWAP/�£�������ͨ��0.25Ԫ/���ӣ����η�0.60Ԫ/���ӡ�"+"|";
      retInfo+="�ʷ�һ��֮�ڲ��ñ����Ԥ�滰������һ��֮�������꣬����ʣ��Ԥ���ϵͳ���Զ��۳���ͬʱ���ٶ��û����ʷѺ�Ԥ�滰�ѽ������ơ�"+"|";
	  /***************�ж��Ƿ���ʾ�ַ����******************/
	  var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
      var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
	  if(old_SmCode == "zn")
  		{
  			//ѦӢ�� 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@���ڻ��������������������� zn->gn ���ֲ�����
  		}
  		else
  		{
	  		if((new_SmCode !="") && (new_SmCode != old_SmCode))
	  		{
		  		/* ningtn �������� */
		  		
	  		}

  		}
  		
  			  	  			/* wanghyd ȥ������������ʾͬʱ������ʾ */
	  			<%if(smzvalue.equals("3")) {%>
		  		note_info1+="<%=readValue("2281","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
  		
	    <%if(goodbz.equals("Y")){%>
			retInfo+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>
	  return retInfo;

}
//ǩԼ����Ʒ����
function printInfo2282()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;

		var gift_code     = oneTokSelf(tempStr,"|",1);	//��Ʒ����
		var prepay_fee    = oneTokSelf(tempStr,"|",2);	//Ԥ�滰��
		var base_fee      = oneTokSelf(tempStr,"|",3);	//����Ԥ��
		var free_fee      = oneTokSelf(tempStr,"|",4);	//�Ԥ��
		var mark_subtract = oneTokSelf(tempStr,"|",5);	//Ԥ�ۻ���
		var consume_term  = oneTokSelf(tempStr,"|",6);	//�����·�
		var monbase_fee   = oneTokSelf(tempStr,"|",7);	//�µ���
		var gift_name     = oneTokSelf(tempStr,"|",9);	//��Ʒ����

	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	  var retInfo = "";
	  /********������Ϣ��**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="�ͻ����ƣ�" +document.all.i4.value+"|";
      retInfo+="�ֻ����룺"+document.all.phone.value+"|";
      retInfo+="�ͻ���ַ��"+document.all.i5.value+"|";
      retInfo+="֤�����룺"+document.all.i7.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      /********������**********/
      retInfo+="ҵ�����ͣ�ǩԼ����Ʒ����"+"|";
      <%if(goodbz.equals("Y")){%>
      retInfo+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      retInfo+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      retInfo+="��Ʒ����: "+gift_name+"|";
      retInfo+="�µ���: "+monbase_fee+"Ԫ     Ԥ�ۻ���: "+mark_subtract+"  ҵ��ִ��ʱ��: "+begin_time+"|";
      retInfo+="Ԥ�滰��: "+prepay_fee+"Ԫ     ����:  ����Ԥ��: "+base_fee+"Ԫ  �Ԥ��: "+free_fee+"Ԫ|";
      retInfo+="Ԥ�������:  "+consume_term+"����|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
       /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	retInfo+="<%=bdts%>"+"|";
      }else{
	  	retInfo+=" "+"|";
	  	}
	  /**********������*********/
      if(document.all.modestr.value.length>0){
      retInfo+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      retInfo+=" "+"|";
      }

      retInfo+="��ע���ͻ���������ҵ���ʷѱ��Ϊ30��ҵ����ʷѣ���0���⣬5Ԫ������ʾ����ѡ����"+"|";
      retInfo+="30Ԫ��ҵ�������10Ԫ����/�£�10ԪIVR/�£�5Ԫ12580/�£�5ԪWAP/�£�������ͨ��0.25Ԫ/���ӣ����η�0.60Ԫ/���ӡ�"+"|";
      retInfo+="�ʷ�һ��֮�ڲ��ñ����Ԥ�滰������һ��֮�������꣬����ʣ��Ԥ���ϵͳ���Զ��۳���ͬʱ���ٶ��û����ʷѺ�Ԥ�滰�ѽ������ơ�"+"|";
	    <%if(goodbz.equals("Y")){%>
			retInfo+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>
	  return retInfo;
}
//ȫ��ͨǩԼ�������룭202���� ���޸�ȫ��ͨǩԼ����������  baixf��20070612
function printInfo2283()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;

		var gift_code     = oneTokSelf(tempStr,"|",1);	//��Ʒ����
		var prepay_fee    = oneTokSelf(tempStr,"|",2);	//Ԥ�滰��
		var base_fee      = oneTokSelf(tempStr,"|",3);	//����Ԥ��
		var free_fee      = oneTokSelf(tempStr,"|",4);	//�Ԥ��
		var mark_subtract = oneTokSelf(tempStr,"|",5);	//Ԥ�ۻ���
		var consume_term  = oneTokSelf(tempStr,"|",6);	//�����·�
		var monbase_fee   = oneTokSelf(tempStr,"|",7);	//�µ���
		var gift_name     = oneTokSelf(tempStr,"|",8);	//��Ʒ����

	  var begin_time='<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>';

    var cust_info="";
    var opr_info="";
    var note_info1="";
    var note_info2="";
    var note_info3="";
    var note_info4="";

	  var retInfo = "";
	  /********������Ϣ��**********/
      cust_info+="�ֻ����룺"+document.all.phone.value+"|";
      cust_info+="�ͻ�������" +document.all.i4.value+"|";
      //cust_info+="֤�����룺"+document.all.i7.value+"|";
      //cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";

      /********������**********/
      opr_info+="�û�Ʒ�ƣ�"+'<%=WtcUtil.repNull(request.getParameter("oSmName")).trim()%>'+" ����ҵ��ȫ��ͨǩԼ����"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="������ˮ��"+"<%=printAccept%>"+" �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="��Ʒ����: "+gift_name+" �µ���: "+monbase_fee+"Ԫ     Ԥ�ۻ���: "+mark_subtract+"  ҵ�����ʱ��: "+begin_time+"|";
      opr_info+="Ԥ�滰��: "+prepay_fee+"Ԫ        ����:  ����Ԥ��: "+base_fee+"Ԫ  �Ԥ��: "+free_fee+"Ԫ|";
      opr_info+="�Ԥ�����������:  "+consume_term+"����        ǩԼ���ޣ�"+consume_term+"����"+"          ҵ����Чʱ�䣺"+"<%=exeDate.substring(0,8)%>"+"|";
      opr_info+="ָ���ʷѣ� "+ (document.all.ip.value).trim()+"|";

      /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********������*********/
     /* if(document.all.modestr.value.length>0){
      note_info2+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      note_info2+=" "+"|";
      }
     */
      note_info2+="ָ���ʷ�������"+"<%=note%>"+"|";
	  
	  /***************�ж��Ƿ���ʾ�ַ����******************/
	   var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
       var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
	  if(old_SmCode == "zn")
  		{
  			//ѦӢ�� 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@���ڻ��������������������� zn->gn ���ֲ�����
  		}
  		else
  		{
	  		if((new_SmCode !="") && (new_SmCode != old_SmCode))
	  		{
		  		/* ningtn �������� */
		  		
	  		}

  		}
  		
  			  	  			/* wanghyd ȥ������������ʾͬʱ������ʾ */
	  			<%if(smzvalue.equals("3")) {%>
		  		note_info1+="<%=readValue("2283","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
  		
  		
	  /***
      if ("<%=regionCode%>"=="11")
	  {
		  note_info3+="ע������������ҵ��󣬼���Ϊ�ҹ�˾ȫ��ͨǩԼ�ͻ���ǩԼ��Ϊ�ʷ���Ч֮����8���£���Ч���°����¼��㣩��ǩԼ����ʹ��ָ���ʷѣ�����������ǩԼ�ں�ɽ����ʷѱ�����粻���������ִ��ָ���ʷѲ��䡣";
	      note_info3+="���ں����ʷ�ʱ�����ʷѵ���Чʱ�䣬������ѡ������ʷѾ����ǵ�����Ч�����Ǵ�����Ч���Ԥ����������Ϊ"+consume_term+"���£�����ҵ���°����¼��㣩���ڴ��ڼ���������ϣ����Ѳ���ģ��ƶ���˾�����޽�������³��ջء�"+"|";
	  }
      else
	  {
	      if(consume_term=="60"){
	      note_info3+="ע������������ҵ��󣬼���Ϊ�ҹ�˾ȫ��ͨǩԼ�ͻ���ǩԼ��Ϊ�ʷ���Ч֮����12���£���Ч���°����¼��㣩��ǩԼ����ʹ��ָ���ʷѣ�����������ǩԼ�ں�ɽ����ʷѱ�����粻���������ִ��ָ���ʷѲ��䡣���ں����ʷ�ʱ�����ʷѵ���Чʱ�䣬������ѡ������ʷѾ����ǵ�����Ч�����Ǵ�����Ч��";
		  }else{
		  note_info3+="ע������������ҵ��󣬼���Ϊ�ҹ�˾ȫ��ͨǩԼ�ͻ���ǩԼ��Ϊ�ʷ���Ч֮����"+consume_term+"���£���Ч���°����¼��㣩��ǩԼ����ʹ��ָ���ʷѣ�����������ǩԼ�ں�ɽ����ʷѱ�����粻���������ִ��ָ���ʷѲ��䡣���ں����ʷ�ʱ�����ʷѵ���Чʱ�䣬������ѡ������ʷѾ����ǵ�����Ч�����Ǵ�����Ч���Ԥ����������Ϊ"+consume_term+"���£�����ҵ���°����¼��㣩���ڴ��ڼ���������ϣ����Ѳ���ģ��ƶ���˾�����޽�������³��ջء�";
	      }
	      note_info3+="�����ɵ�Ԥ�滰�Ѳ��˲�ת������Ԥ�水��ǩԼʱ��ÿ�·���������������ϡ������Ҫ��ȡ��ǩԼ��������Ʒ��������ԭ����ء�ʣ��Ԥ���Ҫ�۳�30����ΥԼ����Э����Ч�������������ʷѱ�׼����,�������µ��ʷ�����ִ�С�"+"|";
	  }
	  ****/
	  <%if(goodbz.equals("Y")){%>
			note_info4+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
	  <%}%>
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;

}
//ȫ��ͨǩԼ�������
function printInfo2284()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;

		var gift_code     = oneTokSelf(tempStr,"|",1);	//��Ʒ����
		var prepay_fee    = oneTokSelf(tempStr,"|",2);	//Ԥ�滰��
		var base_fee      = oneTokSelf(tempStr,"|",3);	//����Ԥ��
		var free_fee      = oneTokSelf(tempStr,"|",4);	//�Ԥ��
		var mark_subtract = oneTokSelf(tempStr,"|",5);	//Ԥ�ۻ���
		var consume_term  = oneTokSelf(tempStr,"|",6);	//�����·�
		var monbase_fee   = oneTokSelf(tempStr,"|",7);	//�µ���
		var gift_name     = oneTokSelf(tempStr,"|",9);	//��Ʒ����

	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

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
      opr_info+="ҵ�����ͣ�ȫ��ͨǩԼ�������"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="��Ʒ����: "+gift_name+"|";
      opr_info+="�µ���: "+monbase_fee+"Ԫ     Ԥ�ۻ���: "+mark_subtract+"  ҵ�����ʱ��: "+begin_time+"|";
      opr_info+="Ԥ�滰��: "+prepay_fee+"Ԫ     ����:  ����Ԥ��: "+base_fee+"Ԫ  �Ԥ��: "+free_fee+"Ԫ|";
      opr_info+="Ԥ�������:  "+consume_term+"����|";

      /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********������*********/
      if(document.all.modestr.value.length>0){
      note_info2+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      note_info2+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			note_info3+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>

    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}
//Ԥ���Ż���������Ӫ�������룭202���� ���޸�Ԥ���Ż���������Ӫ�����������  sunaj��20090410
function printInfo7371()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;

		var sale_code     = oneTokSelf(tempStr,"|",1);	//��������
		var prepay_fee    = oneTokSelf(tempStr,"|",2);	//Ԥ�滰��
		var base_fee      = oneTokSelf(tempStr,"|",3);	//����Ԥ��
		var free_fee      = oneTokSelf(tempStr,"|",4);	//�Ԥ��
		var base_term     = oneTokSelf(tempStr,"|",5);	//������������
		var free_term     = oneTokSelf(tempStr,"|",6);	//���������
		var monbase_fee   = oneTokSelf(tempStr,"|",7);	//�µ���
		var sale_name     = oneTokSelf(tempStr,"|",8);	//��������

	  var begin_time='<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>';

    var cust_info="";
    var opr_info="";
    var note_info1="";
    var note_info2="";
    var note_info3="";
    var note_info4="";

	  var retInfo = "";
	  /********������Ϣ��**********/
      cust_info+="�ֻ����룺"+document.all.phone.value+"|";
      cust_info+="�ͻ�������"+document.all.i4.value+"|";
      //cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
      //cust_info+="֤�����룺"+document.all.i7.value+"|";


      /********������**********/
      opr_info+="ҵ������:  ��e��ʡ���ײ�  Ԥ������Ż�����������"+"|";
       <%if(goodbz.equals("Y")){%>
      opr_info+="������ˮ�� "+"<%=printAccept%>"+"|";
      <%}else{%>
      opr_info+="������ˮ�� "+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="���������ײͣ�"+ document.all.ip.value.trim()+"    �Ż�ʱ��:  10����|";
      opr_info+="Ԥ�滰��: "+prepay_fee+"Ԫר��          ҵ��ִ��ʱ�䣺"+begin_time+"|";



      /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********������*********/
        note_info2+="�ʷ�������"+"<%=note%>"+"|";

	  note_info3+="ע�����"+"|";
	  /***************�ж��Ƿ���ʾ�ַ����******************/
	  var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
      var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
	  if(old_SmCode == "zn")
  		{
  			//ѦӢ�� 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@���ڻ��������������������� zn->gn ���ֲ�����
  		}
  		else
  		{
	  		if((new_SmCode !="") && (new_SmCode != old_SmCode))
	  		{
		  		/* ningtn �������� */
		  		
	  		}

  		}
  			  	  			/* wanghyd ȥ������������ʾͬʱ������ʾ */
	  			<%if(smzvalue.equals("3")) {%>
		  		note_info1+="<%=readValue("7371","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
		  		
      note_info3+=" "+"|";
	  <%if(goodbz.equals("Y")){%>
			note_info4+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;

}
//Ԥ���Ż���������Ӫ��������
function printInfo7374()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;

		var sale_code     = oneTokSelf(tempStr,"|",1);	//��������
		var prepay_fee    = oneTokSelf(tempStr,"|",2);	//Ԥ�滰��
		var base_fee      = oneTokSelf(tempStr,"|",3);	//����Ԥ��
		var free_fee      = oneTokSelf(tempStr,"|",4);	//�Ԥ��
		var base_term     = oneTokSelf(tempStr,"|",5);	//������������
		var free_term     = oneTokSelf(tempStr,"|",6);	//���������
		var monbase_fee   = oneTokSelf(tempStr,"|",7);	//�µ���
		var sale_name     = oneTokSelf(tempStr,"|",9);	//��������

	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

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
      //cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
      //cust_info+="֤�����룺"+document.all.i7.value+"|";

      /********������**********/
      opr_info+="ҵ������:  ��e��ʡ���ײ�  Ԥ������Ż������ѳ���"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="ҵ����ˮ�� "+"<%=printAccept%>"+"|";
      <%}else{%>
      opr_info+="ҵ����ˮ�� "+"<%=printAccept%>"+"|";
      <%}%>
     /* opr_info+="���������ײͣ� "+ document.all.ip.value.trim()+"   �Ż�ʱ��:  "+free_term+"����|";
      opr_info+="Ԥ�滰��: "+prepay_fee+"Ԫר��       ҵ��ִ��ʱ�䣺"+begin_time+"|";
      */

      /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********������*********/
      <%if(goodbz.equals("Y")){%>
			note_info3+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>
	note_info4+="��ע��"+"|";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}
//Ԥ���Żݹ���Ӫ�������룭202���� ���޸�Ԥ���Żݹ���Ӫ�����������  sunaj��20090414
function printInfo7379()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;

		var sale_code     = oneTokSelf(tempStr,"|",1);	//��������
		var agent_code    = oneTokSelf(tempStr,"|",2);	//�ֻ�Ʒ��
		var phone_type    = oneTokSelf(tempStr,"|",3);	//�ֻ��ͺ�
		var sale_price    = oneTokSelf(tempStr,"|",4);	//Ӧ�ս��
		var base_fee      = oneTokSelf(tempStr,"|",5);	//����Ԥ��
		var consume_term  = oneTokSelf(tempStr,"|",6);	//������������
	    var free_fee      = oneTokSelf(tempStr,"|",7);	//�Ԥ��
		var active_term   = oneTokSelf(tempStr,"|",8);	//���������
		var monbase_fee   = oneTokSelf(tempStr,"|",9);	//�µ���
		var all_gift_price= oneTokSelf(tempStr,"|",10);	//��������
		var market_price  = oneTokSelf(tempStr,"|",11); //�г���
		var imeino        = oneTokSelf(tempStr,"|",12); //IEMI����
		var all_fee       = parseFloat(base_fee)+parseFloat(free_fee);  //Ԥ�����



	  var begin_time='<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>';

    var cust_info="";
    var opr_info="";
    var note_info1="";
    var note_info2="";
    var note_info3="";
    var note_info4="";

	  var retInfo = "";
	  /********������Ϣ��**********/
      cust_info+="�ֻ����룺"+document.all.phone.value+"|";
      cust_info+="�ͻ�������"+document.all.i4.value+"|";
      //cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
      //cust_info+="֤�����룺"+document.all.i7.value+"|";


      /********������**********/
      opr_info+="ҵ������: ��e��ʡ���ײ�   Ԥ�������������������"+"|";
       <%if(goodbz.equals("Y")){%>
      opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
      <%}else{%>
      opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="���������ײͣ�"+ document.all.ip.value.trim()+"|";
      opr_info+="�������ͺţ�"+ phone_type +"   �г��ۣ�"+market_price+"   �Żݽ� "+"<%=WtcUtil.repNull(request.getParameter("Favour_Cost"))%>"+"Ԫ|";
      opr_info+="�����: "+sale_price+"Ԫ(���У�Ԥ�滰�ѣ�"+all_fee+"Ԫ, �������ã�"+all_gift_price+"Ԫ)|";
      opr_info+="ҵ��ִ��ʱ�䣺"+begin_time+"|";

      /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********������*********/
        note_info2+="�ʷ�������"+"<%=note%>"+"|";

	note_info3+="ע�����"+"|";
	/*note_info3+="�����ɵ�Ԥ�滰�Ѳ��˲�ת�������Ҫ��ȡ��ǩԼ,ʣ��Ԥ���Ҫ�۳�30����ΥԼ����Э����Ч�������������ʷѱ�׼����,�������µ��ʷ�����ִ�С�"+"|";
    */
    /***************�ж��Ƿ���ʾ�ַ����******************/
	  var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
      var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
	  if(old_SmCode == "zn")
  		{
  			//ѦӢ�� 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@���ڻ��������������������� zn->gn ���ֲ�����
  		}
  		else
  		{
	  		if((new_SmCode !="") && (new_SmCode != old_SmCode))
	  		{
		  		/* ningtn �������� */
		  		
	  		}

  		}
  		
  			  	  			/* wanghyd ȥ������������ʾͬʱ������ʾ */
	  			<%if(smzvalue.equals("3")) {%>
		  		note_info1+="<%=readValue("7379","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
  		
      note_info3+=" "+"|";
	  <%if(goodbz.equals("Y")){%>
			note_info4+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;

}
//Ԥ���Żݹ���Ӫ��������
function printInfo7382()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;


        var login_accept  = oneTokSelf(tempStr,"|",1);  //ҵ����ˮ
		var sale_code     = oneTokSelf(tempStr,"|",2);	//��������
		var agent_code    = oneTokSelf(tempStr,"|",3);	//�ֻ�Ʒ��
		var phone_type    = oneTokSelf(tempStr,"|",4);	//�ֻ��ͺ�
		var sale_price    = oneTokSelf(tempStr,"|",5);	//Ӧ�ս��
		var base_fee      = oneTokSelf(tempStr,"|",6);	//����Ԥ��
		var consume_term  = oneTokSelf(tempStr,"|",7);	//������������
	    var free_fee      = oneTokSelf(tempStr,"|",8);	//�Ԥ��
		var active_term   = oneTokSelf(tempStr,"|",9);	//���������
		var monbase_fee   = oneTokSelf(tempStr,"|",10);	//�µ���
		var all_gift_price= oneTokSelf(tempStr,"|",11);	//��������
		var market_price  = oneTokSelf(tempStr,"|",12); //�г���
		var imeino        = oneTokSelf(tempStr,"|",13); //IEMI����
		var all_fee       = parseFloat(base_fee)+parseFloat(free_fee);  //Ԥ�����


	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

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
      //cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
      //cust_info+="֤�����룺"+document.all.i7.value+"|";

      /********������**********/
      opr_info+="ҵ������: ��e��ʡ���ײ�   Ԥ�������������������"+"|";
       <%if(goodbz.equals("Y")){%>
      opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
      <%}else{%>
      opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********������*********/
      <%if(goodbz.equals("Y")){%>
			note_info3+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>
    note_info4+="��ע��"+"|";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}
//����Ӫ������������ ������Ӫ�����������  sunaj��20090516
function printInfo7975()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;

		var sale_code     = oneTokSelf(tempStr,"|",1);	//��������
		var agent_code    = oneTokSelf(tempStr,"|",2);	//�ֻ�Ʒ��
		var phone_type    = oneTokSelf(tempStr,"|",3);	//�ֻ��ͺ�
		var sale_price    = oneTokSelf(tempStr,"|",4);	//Ӧ�ս��
		var base_fee      = oneTokSelf(tempStr,"|",5);	//����Ԥ��
		var consume_term  = oneTokSelf(tempStr,"|",6);	//������������
	    var free_fee      = oneTokSelf(tempStr,"|",7);	//�Ԥ��
		var active_term   = oneTokSelf(tempStr,"|",8);	//���������
		//var monbase_fee   = oneTokSelf(tempStr,"|",9);	//�µ���
		var all_gift_price= oneTokSelf(tempStr,"|",9);	//��������
		var market_price  = oneTokSelf(tempStr,"|",10); //�г���
		var imeino        = oneTokSelf(tempStr,"|",11); //IEMI����
		var all_fee       = parseFloat(base_fee)+parseFloat(free_fee);  //Ԥ�����



	  var begin_time='<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>';

    var cust_info="";
    var opr_info="";
    var note_info1="";
    var note_info2="";
    var note_info3="";
    var note_info4="";

	  var retInfo = "";
	  /********������Ϣ��**********/
      cust_info+="�ֻ����룺"+document.all.phone.value+"|";
      cust_info+="�ͻ�������"+document.all.i4.value+"|";
      //cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
      //cust_info+="֤�����룺"+document.all.i7.value+"|";


      /********������**********/
      opr_info+="ҵ������: �����ײ�  Ԥ�����������������"+"|";
       <%if(goodbz.equals("Y")){%>
      opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
      <%}else{%>
      opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="���ײͷ��ã�"+"<%=WtcUtil.repNull(request.getParameter("Favour_Cost"))%>"+"Ԫ|";
      opr_info+="�����ͺţ�"+ phone_type +"   �г��ۣ�"+market_price+"|";
      opr_info+="�����: "+sale_price+"Ԫ(���У�Ԥ�滰�ѣ�"+all_fee+"Ԫ)|";
      opr_info+="ҵ��ִ��ʱ�䣺"+begin_time+"|";

      /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********������*********/
        note_info2+="�ʷ�������"+"<%=note%>"+"|";

	note_info3+="ע�����"+"|";
	/*note_info3+="�����ɵ�Ԥ�滰�Ѳ��˲�ת�������Ҫ��ȡ��ǩԼ,ʣ��Ԥ���Ҫ�۳�30����ΥԼ����Э����Ч�������������ʷѱ�׼����,�������µ��ʷ�����ִ�С�"+"|";
    */
      note_info3+=" "+"|";
	  <%if(goodbz.equals("Y")){%>
			note_info4+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;

}
//����Ӫ������������ ������Ӫ�����������  sunaj��20090516
function printInfo7976()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;

        var login_accept  = oneTokSelf(tempStr,"|",1);  //ҵ����ˮ
		var sale_code     = oneTokSelf(tempStr,"|",2);	//��������
		var agent_code    = oneTokSelf(tempStr,"|",3);	//�ֻ�Ʒ��
		var phone_type    = oneTokSelf(tempStr,"|",4);	//�ֻ��ͺ�
		var sale_price    = oneTokSelf(tempStr,"|",5);	//Ӧ�ս��
		var base_fee      = oneTokSelf(tempStr,"|",6);	//����Ԥ��
		var consume_term  = oneTokSelf(tempStr,"|",7);	//������������
	    var free_fee      = oneTokSelf(tempStr,"|",8);	//�Ԥ��
		var active_term   = oneTokSelf(tempStr,"|",9);	//���������
		//var monbase_fee   = oneTokSelf(tempStr,"|",10);	//�µ���
		var all_gift_price= oneTokSelf(tempStr,"|",10);	//��������
		var market_price  = oneTokSelf(tempStr,"|",11); //�г���
		var imeino        = oneTokSelf(tempStr,"|",12); //IEMI����
		var all_fee       = parseFloat(base_fee)+parseFloat(free_fee);  //Ԥ�����

	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

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
      //cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
      //cust_info+="֤�����룺"+document.all.i7.value+"|";

      /********������**********/
      opr_info+="ҵ������: �����ײ�  Ԥ������������񱦳���"+"|";
       <%if(goodbz.equals("Y")){%>
      opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
      <%}else{%>
      opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********������*********/
      <%if(goodbz.equals("Y")){%>
			note_info3+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>
    note_info4+="��ע��"+"|";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}
//����ҵ���������
function printInfo7116()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;

	  var prepay_fee    = oneTokSelf(tempStr,"|",1);	//Ԥ�滰��
	  var consume_term  = oneTokSelf(tempStr,"|",2);	//��������
	  var exeDate = "<%=exeDate%>";//�õ�ִ��ʱ��
	  var time=exeDate.substring(0,8);

	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	  var retInfo = "";
	  /********������Ϣ��**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="�ͻ����ƣ�" +document.all.i4.value+"|";
      retInfo+="�ֻ����룺"+document.all.phone.value+"|";
      retInfo+="�ͻ���ַ��"+document.all.i5.value+"|";
      retInfo+="֤�����룺"+document.all.i7.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      /********������**********/
      retInfo+="ҵ�����ͣ�����ҵ���������"+"|";
      <%if(goodbz.equals("Y")){%>
      retInfo+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      retInfo+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      retInfo+="ҵ�����ʱ��: "+begin_time+"     ҵ��ִ��ʱ��:  "+time+"|";
      retInfo+="Ԥ�滰��: "+prepay_fee+"Ԫ      Ԥ�������:  "+consume_term+"����|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	retInfo+="<%=bdts%>"+"|";
      }else{
	  	retInfo+=" "+"|";
	  	}
	  /**********������*********/
      if(document.all.modestr.value.length>0){
      retInfo+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      retInfo+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			retInfo+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>
	  return retInfo;

}
//����ҵ��������
function printInfo7118()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;

		var prepay_fee    = oneTokSelf(tempStr,"|",1);	//Ԥ�滰��
		var consume_term  = oneTokSelf(tempStr,"|",2);	//��������

	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	  var retInfo = "";
	  /********������Ϣ��**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="�ͻ����ƣ�" +document.all.i4.value+"|";
      retInfo+="�ֻ����룺"+document.all.phone.value+"|";
      retInfo+="�ͻ���ַ��"+document.all.i5.value+"|";
      retInfo+="֤�����룺"+document.all.i7.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      /********������**********/
      retInfo+="ҵ�����ͣ�����ҵ��������"+"|";
      <%if(goodbz.equals("Y")){%>
      retInfo+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      retInfo+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      retInfo+="ҵ�����ʱ��: "+begin_time+"|";
      retInfo+="Ԥ�滰��: "+prepay_fee+"Ԫ      Ԥ�������:  "+consume_term+"����|";
       retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	retInfo+="<%=bdts%>"+"|";
      }else{
	  	retInfo+=" "+"|";
	  	}
	  /**********������*********/
     if(document.all.modestr.value.length>0){
      retInfo+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      retInfo+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			retInfo+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>
	  return retInfo;
}
//���Ŀ�����
function printInfo1253()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���

	  var exeDate = "<%=exeDate%>";//�õ�ִ��ʱ��
	  var time=exeDate.substring(0,8);
		var cust_info="";  //�ͻ���Ϣ
		var opr_info="";   //������Ϣ
		var note_info1=""; //��ע1
		var note_info2=""; //��ע2
		var note_info3=""; //��ע3
		var note_info4=""; //��ע4
		var retInfo = "";  //��ӡ����
	  /********������Ϣ��**********/
      retInfo+='<%=workNo%>  <%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      cust_info+="�ͻ�������" +document.all.i4.value+"|";
      cust_info+="�ֻ����룺"+document.all.phone.value+"|";
      cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
      cust_info+="֤�����룺"+document.all.i7.value+"|";
      /********������**********/
      retInfo+=" "+"|";
      opr_info+="�û�Ʒ�ƣ�"+'<%=WtcUtil.repNull(request.getParameter("i8"))%>'+"|";
      opr_info+="ҵ�����ͣ����Ŀ�����"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="�ʷѣ����롢���ƣ���"+document.all.ip.value+"|";
      opr_info+="��Чʱ�䣺"+time+"|";
      /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	opr_info+="<%=bdts%>"+"|";
      }else{
	  	opr_info+=" "+"|";
	  	}
	  /**********������*********/
	  note_info1+="<%=note%>"+"|";
      if(document.all.modestr.value.length>0){
      note_info1+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      note_info1+=" "+"|";
      }
      note_info1+="<%=print_note%>"+"|";
      <%if(goodbz.equals("Y")){%>
			note_info1+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}
//���Ŀ�ȡ��
function printInfo1254()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���

	  var exeDate = "<%=exeDate%>";//�õ�ִ��ʱ��
	  var time=exeDate.substring(0,8);

		var cust_info="";  //�ͻ���Ϣ
		var opr_info="";   //������Ϣ
		var note_info1=""; //��ע1
		var note_info2=""; //��ע2
		var note_info3=""; //��ע3
		var note_info4=""; //��ע4
		var retInfo = "";  //��ӡ����
	  /********������Ϣ��**********/
      retInfo+='<%=workNo%>  <%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      cust_info+="�ͻ�������" +document.all.i4.value+"|";
      cust_info+="�ֻ����룺"+document.all.phone.value+"|";
      cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
      cust_info+="֤�����룺"+document.all.i7.value+"|";
       /********������**********/
      opr_info+="�û�Ʒ�ƣ�"+'<%=WtcUtil.repNull(request.getParameter("i8"))%>'+"|";
      opr_info+="ҵ�����ͣ����Ŀ�ȡ��"+"|";
       <%if(goodbz.equals("Y")){%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
	    opr_info+="�ʷѣ����롢���ƣ���"+document.all.ip.value+"|";
      opr_info+="��Чʱ�䣺"+time+"|";
	     /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	opr_info+="<%=bdts%>"+"|";
      }else{
	  	opr_info+=" "+"|";
	  	}
	  /**********������*********/
      if(document.all.modestr.value.length>0){
      note_info1+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      note_info1+=" "+"|";
      }
      note_info1+="<%=print_note%>"+"|";
      <%if(goodbz.equals("Y")){%>
			note_info1+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>
	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}
//��̨��GPRS����
function printInfo1208()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr��ʽ year_fee|pay_type
      var year_fee = oneTokSelf(tempStr,"|",1);//����Ԥ��

	  var retInfo = "";
	  /********������Ϣ��**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="�ͻ����ƣ�" +document.all.i4.value+"|";
      retInfo+="�ֻ����룺"+document.all.phone.value+"|";
      retInfo+="�ͻ���ַ��"+document.all.i5.value+"|";
      retInfo+="֤�����룺"+document.all.i7.value+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      /********������**********/
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+="ҵ������:         ��̨��GPRS����"+"|";
	    retInfo+="������: "+year_fee+"Ԫ|";
      <%if(goodbz.equals("Y")){%>
      retInfo+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      retInfo+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
       /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	retInfo+="<%=bdts%>"+"|";
      }else{
	  	retInfo+=" "+"|";
	  	}
	  /**********������*********/
      if(document.all.modestr.value.length>0){
      retInfo+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      retInfo+=" "+"|";
      }
      retInfo+="<%=print_note%>"+"|";
      <%if(goodbz.equals("Y")){%>
			retInfo+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>

	  return retInfo;
}
//���еش��������
function printInfo125b()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr��ʽ  ����Ԥ�� | ��������
      var year_fee = oneTokSelf(tempStr,"|",1);//����Ԥ��
	  var consume_term = oneTokSelf(tempStr,"|",2);//��������

	  var exeDate = "<%=exeDate.substring(0,8)%>";//�õ�ִ��ʱ��

	  var retInfo = "";
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  /********������Ϣ��**********/
      /*retInfo+='<%=workNo%>  <%=workName%>'+"|"; */
      /*retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";  */
      cust_info+="�ͻ�������" +document.all.i4.value+"|";
      cust_info+="�ֻ����룺"+document.all.phone.value+"|";
      cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
      cust_info+="֤�����룺"+document.all.i7.value+"|";

	    /********������**********/
	  opr_info+="ҵ������ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"�û�Ʒ�ƣ����еش�"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="����ҵ�񣺶��еش�������꣭���� "+"  ������ˮ��"+"<%=printAccept%>"+"  �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      opr_info+="����ҵ�񣺶��еش�������꣭���� "+"  ������ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="���еش����ʷѣ�"+codeChg(document.all.ip.value)+"  ���ʷ���Чʱ�䣺"+checkdate(exeDate)+"|";
      opr_info+="���еش����ʷѶ������ۣ�"+"<%=daima%>"+"|";
      opr_info+="���еش���ѡ�ʷѣ�"+document.all.kx_code_name_bunch.value+"  ��ѡ�ʷ���Чʱ�䣺����"+"|";
	  opr_info+="���еش���ѡ�ʷѶ������ۣ�"+document.all.kx_erpi_bunch.value+"|";

      /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }
	  /**********������*********/
	  note_info1=" "+"|";
	  if(document.all.modestr.value.length>0){
      note_info1+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }
      note_info2=" "+"|";
	  note_info2+="���еش���������ʷ�������"+"<%=note%>"+"|";
	  note_info3=" "+"|";
      if(document.all.kx_explan_bunch.value.trim().len()==0){

	  }else{
		//rdShowMessageDialog("fffffff"+document.all.kx_explan_bunch.value);
	  note_info3+="���еش���ѡ�ʷ�����:"+document.all.kx_explan_bunch.value+"|";

	  }
	  note_info4=" "+"|";
      <%if(goodbz.equals("Y")){%>
			note_info4+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>
	 note_info4+=" "+"|";
	 note_info4+="��ע:"+document.all.tonote.value+"|";
	 document.all.cust_info.value=cust_info+"#";
	document.all.opr_info.value=opr_info+"#";
	document.all.note_info1.value=note_info1+"#";
	document.all.note_info2.value=note_info2+"#";
	document.all.note_info3.value=note_info3+"#";
	document.all.note_info4.value=note_info4+"#";

	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	 return retInfo;
}
//���еش�����������
function printInfo125c()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr��ʽ  ����Ԥ�� | ��������
      var year_fee = oneTokSelf(tempStr,"|",1);//����Ԥ��
	  var consume_term = oneTokSelf(tempStr,"|",2);//��������

	  var exeDate = "<%=exeDate.substring(0,8)%>";//�õ�ִ��ʱ��

	  var retInfo = "";
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  /********������Ϣ��**********/
      /*retInfo+='<%=workName%>'+"|"; */
      /*retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|"; */
      cust_info+="�ͻ�������" +document.all.i4.value+"|";
      cust_info+="�ֻ����룺"+document.all.phone.value+"|";
      cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
      cust_info+="֤�����룺"+document.all.i7.value+"|";

       /********������**********/
      opr_info+="ҵ������ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"�û�Ʒ�ƣ����еش�"+"|";


      <%if(goodbz.equals("Y")){%>
      opr_info+="ҵ������:  ���еش�����������"+"  ҵ����ˮ��"+"<%=printAccept%>"+"  �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      opr_info+="ҵ������:  ���еش�����������"+"  ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}%>

      opr_info+="Ԥ�滰��:  "+year_fee+"|";
      opr_info+="ҵ��ִ��ʱ��:  "+exeDate+"      ��������:  "+consume_term+"����|";
     /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }
	  /**********������*********/
	  note_info1+=" "+"|";
      if(document.all.modestr.value.length>0){
      note_info1+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }
      note_info2+=" "+"|";
      note_info2+="<%=print_note%>"+"|";
      note_info3+=" "+"|";
      <%if(goodbz.equals("Y")){%>
			note_info3+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>
	document.all.cust_info.value=cust_info+"#";
	document.all.opr_info.value=opr_info+"#";
	document.all.note_info1.value=note_info1+"#";
	document.all.note_info2.value=note_info2+"#";
	document.all.note_info3.value=note_info3+"#";
	document.all.note_info4.value=note_info4+"#";

	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	 return retInfo;
}
function printInfo7117()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr��ʽ ��������| ����Ԥ��| �µ���| ��������
      var year_fee = oneTokSelf(tempStr,"|",2);//����Ԥ��
	  var consume_term = oneTokSelf(tempStr,"|",4);//��������

      var exeDate='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	  var retInfo = "";
	  /********������Ϣ��**********/
      retInfo+='<%=workName%>'+"|";
      retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
      retInfo+="�ͻ����ƣ�" +document.all.i4.value+"|";
      retInfo+="�ֻ����룺"+document.all.phone.value+"|";
      retInfo+="�ͻ���ַ��"+document.all.i5.value+"|";
      retInfo+="֤�����룺"+document.all.i7.value+"|";
      retInfo+=" "+"|";
	    retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
      retInfo+=" "+"|";
       /********������**********/
      retInfo+=" "+"|";
      retInfo+=" "+"|";
	  retInfo+="�û�Ʒ�ƣ�"+"<%=WtcUtil.repNull(request.getParameter("smcode_xyz"))%>"+"  *"+"����ҵ��:"+"����ҵ�����ȡ��"+"|";
      <%if(goodbz.equals("Y")){%>
      retInfo+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      retInfo+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      retInfo+="ȡ���İ����ʷѣ�"+ "<%=WtcUtil.repNull(request.getParameter("i16"))%>"+"|";
      retInfo+="ȡ����ִ���ʷѣ�"+document.all.ip.value+"  *"+"��Чʱ�䣺"+exeDate+"|";
      retInfo+="ȡ����ִ���ʷѶ�ӦƷ�ƣ�"+"<%=WtcUtil.repNull(request.getParameter("smcode_xyz"))%>"+"|";
      retInfo+=" "+"|";
      /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	retInfo+="<%=bdts%>"+"|";
      }else{
	  	retInfo+=" "+"|";
	  	}
	  /**********������*********/
      if(document.all.modestr.value.length>0){
      retInfo+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      retInfo+=" "+"|";
      }
	    retInfo+="ȡ����ִ���ʷ�������"+"<%=note%>"+"|";
      if(document.all.kx_explan_bunch.value.trim().len()==0)
      {
				retInfo+=" "+"|";
	  	}
	  	else
	  	{
				retInfo+="��ѡ�ʷ�������"+document.all.kx_explan_bunch.value+"|";
	  	}
	 		 retInfo+="��ע�����ڰ����ʷ�δ���ڣ�ȡ�������ʷ�����ΥԼ��Ϊ���ڱ��³��ʺ��ҹ�˾����ʣ��"+"|";
	  		retInfo+="����Ԥ���30����ȡΥԼ��֮��ʣ���Ԥ���Զ�ת�������ֽ��˻��С�"+"|";
      <%if(goodbz.equals("Y")){%>
			retInfo+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>

	  return retInfo;
}
function printInfo7119()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr��ʽ ��������| ����Ԥ��| �µ���| ��������
      var year_fee = oneTokSelf(tempStr,"|",2);//����Ԥ��
	  var consume_term = oneTokSelf(tempStr,"|",4);//��������

      var exeDate='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	  var retInfo = "";
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  /********������Ϣ��**********/
      /*retInfo+='<%=workName%>'+"|"; */
      /*retInfo+='<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|"; */
      cust_info+="�ͻ����ƣ�" +document.all.i4.value+"|";
      cust_info+="�ֻ����룺"+document.all.phone.value+"|";
      cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
      cust_info+="֤�����룺"+document.all.i7.value+"|";

      /********������**********/
      opr_info+="ҵ������ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"  "+"�û�Ʒ�ƣ�"+"<%=WtcUtil.repNull(request.getParameter("smcode_xyz"))%>"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="����ҵ��:"+"���еش��������ȡ��"+"  ҵ����ˮ��"+"<%=printAccept%>"+"  �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      opr_info+="����ҵ��:"+"���еش��������ȡ��"+"  ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="ȡ���İ����ʷѣ�"+ "<%=WtcUtil.repNull(request.getParameter("i16"))%>"+"|";
      opr_info+="ȡ����ִ���ʷѣ�"+document.all.ip.value+"  *"+"��Чʱ�䣺"+exeDate+"|";
      opr_info+="ȡ����ִ���ʷѶ�ӦƷ�ƣ�"+"<%=WtcUtil.repNull(request.getParameter("smcode_xyz"))%>"+"|";

      /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }
	  /**********������*********/
	  note_info1+=" "+"|";
      if(document.all.modestr.value.length>0){
      note_info1+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }
      note_info2+=" "+"|";
	  note_info2+="ȡ����ִ���ʷ�������"+"<%=note%>"+"|";
	  note_info3+=" "+"|";
      if(document.all.kx_explan_bunch.value.trim().len()==0)
      {

	  	}
	  	else
	  	{
				note_info3+="��ѡ�ʷ�������"+document.all.kx_explan_bunch.value+"|";
	  	}
	  	note_info4+=" "+"|";
	  	note_info4+="��ע�����ڰ����ʷ�δ���ڣ�ȡ�������ʷ�����ΥԼ��Ϊ���ڱ��³��ʺ��ҹ�˾����ʣ��"+"|";
	  	note_info4+="����Ԥ���30����ȡΥԼ��֮��ʣ���Ԥ���Զ�ת�������ֽ��˻��С�"+"|";
     <%if(goodbz.equals("Y")){%>
     		note_info4+=" "+"|";
			note_info4+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>
	document.all.cust_info.value=cust_info+"#";
	document.all.opr_info.value=opr_info+"#";
	document.all.note_info1.value=note_info1+"#";
	document.all.note_info2.value=note_info2+"#";
	document.all.note_info3.value=note_info3+"#";
	document.all.note_info4.value=note_info4+"#";
	retInfo=document.all.cust_info.value+" "+"|"+"---------------------------------------------"+"|"+" "+"|"+document.all.opr_info.value+" "+"|"+" "+"|"+document.all.note_info1.value+document.all.note_info2.value+document.all.note_info3.value+document.all.note_info4.value+" "+"|"+" "+"|"+" "+"|"+" "+"|"+"<%=loginNote.trim()%>"+"#";

	  return retInfo;
}

function printInfo8046()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	  //iAddStr��ʽ Ӫ�������ʹ���|���ֻ���|������Ʒ��|��ˮ|

    var saleType = oneTokSelf(tempStr,"|",1);//Ӫ�������ʹ���
	  var pay_phone_fee = oneTokSelf(tempStr,"|",2);//���ֻ���
	  var pay_product_fee = oneTokSelf(tempStr,"|",3);//������Ʒ��
	  var pay_fee = (parseFloat(pay_phone_fee) + parseFloat(pay_product_fee)) + "";

      var exeDate='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	  var retInfo = "";
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";

	  /********������Ϣ��**********/
      cust_info+="�ֻ����룺"+document.all.phone.value+"|";
      cust_info+="�ͻ�������" +document.all.i4.value+"|";
      cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
      cust_info+="֤�����룺"+document.all.i7.value+"|";

      /********������**********/
      
      if(saleType=="38"){
        var myPacket = new AJAXPacket("f8046_ajax_getYhjeInfo.jsp","���ڻ�ȡ��Ϣ�����Ժ�......");
      	myPacket.data.add("phoneNo",document.all.phone.value);
      	core.ajax.sendPacket(myPacket,doGetYhjeInfo);
      	myPacket=null; 
      }
	  opr_info+="�û�Ʒ�ƣ�"+"<%=WtcUtil.repNull(request.getParameter("smcode_xyz"))%>"+"     *"+"����ҵ��:"+"Ӫ����ȡ��"+"|";
      if(saleType=="38"){
        opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
        alert(document.all.yhje_8046.value);
        opr_info+="�ͻ��轻�ɵĲ����Żݽ�"+document.all.yhje_8046.value+"|";		
      }else{
        opr_info+="������ˮ��"+"<%=printAccept%>     *�ͻ��轻�ɵ���Ʒ���ֻ��"+pay_fee+"|";
        opr_info+="ȡ����Ӫ�����ʷѣ�"+ "<%=WtcUtil.repNull(request.getParameter("i16"))%>"+"|";
        opr_info+="ȡ����ִ���ʷѣ�"+document.all.ip.value+"  *"+"��Чʱ�䣺"+exeDate+"|";
        opr_info+="ȡ����ִ���ʷѶ�ӦƷ�ƣ�"+"<%=WtcUtil.repNull(request.getParameter("smcode_xyz"))%>"+"|";
        opr_info+=" "+"|";
      }
      

      /*******��ע��**********/
		if(saleType=="38")
		{
			note_info1+="�ڱ�ҵ����ǰ����ȡ�����������������Ҫ�˻�Ӫ�����ڼ�ȫ���Ѿ����ܵ���ͨ�ŷ����Żݣ���Ϊȡ��ҵ���ΥԼ��"+"|";
    }
		else
		{
	  		if("<%=bdbz%>"=="Y"){
      		note_info1+="<%=bdts%>"+"|";
      		}else{
          	note_info1+=" "+"|";
	  		}
		}

	  /**********������*********/
      if(document.all.modestr.value.length>0){
      	note_info2+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      	note_info2+=" "+"|";
      }
	  	note_info2+="ȡ����ִ���ʷ�������"+"<%=note%>"+"|";
      if(document.all.kx_explan_bunch.value.trim().len()==0)
		note_info2+=" "+"|";
	  else
		note_info2+="��ѡ�ʷ�������"+document.all.kx_explan_bunch.value+"|";
	  note_info3+="ע���������Ӫ����ʷ�δ���ڣ�ȡ���ʷ�����ΥԼ��Ϊ��������ʱ�����͵���Ʒ"+"|";
	  note_info3+="���ֻ���������ԭ�۹��������Żݼ۸�����ֻ����谴ԭ�۽��ɲ�ۿ������ʱ"+"|";
	  note_info3+="���ɵ�ר��Ԥ���۳��ֻ�����Ʒ����ҹ�˾����ʣ��Ԥ����30����ȡΥԼ��ʣ���"+"|";
	  note_info3+="Ԥ���Զ�ת�������ֽ��˻��С�����������Ʒ�����ֻ���ԭ�ۻ��ۼ�ΥԼ���Ƚ���"+"|";
	  note_info3+="����Ԥ�滰�ѣ�������ȡ���Ϸ��ú����Ƿ��ͣ����"+"|";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}

function doGetYhjeInfo(packet){
  var v_yhje = packet.data.findValueByName("v_yhje");
  $("#yhje_8046").val(v_yhje);
}

/*************************************add by MengQK  end*************************************************************/

function printInfo8027()
{
	  var retInfo = "";
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	  var tempStr = document.form1.iAddStr.value;
	  // rdShowMessageDialog("tempStr = " + tempStr);
	  //iAddStr��ʽ Ӫ������|�ֻ�Ʒ��|Ԥ�滰��|����|�շ�|IMEI��|

    var gift_grade = oneTokSelf(tempStr,"|",1);     //Ӫ������
    var phone_code = oneTokSelf(tempStr,"|",2);      //�ֻ�Ʒ��
	var prepay_fee = oneTokSelf(tempStr,"|",3);     //Ԥ�滰��
	var phone_type = oneTokSelf(tempStr,"|",4);    //�ֻ��ͺ�
	var pay_money= oneTokSelf(tempStr,"|",5); //�շ�
	var IMEINo = oneTokSelf(tempStr,"|",6);  //IMEI��



	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	     /********������Ϣ��**********/
      cust_info+="�ͻ�������" +document.all.i4.value+"|";
      cust_info+="�ֻ����룺"+document.all.phone.value+"|";
      cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
      cust_info+="֤�����룺"+document.all.i7.value+"|";
     /********������**********/
      opr_info+="ҵ�����ͣ����ֻ����ͻ���"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="�ֻ��ͺţ�"+phone_code+phone_type+"      IMEI�룺"+IMEINo+"|";
	  opr_info+="�ɿ�ϼƣ�"+pay_money+"Ԫ�������ͣ�"+prepay_fee+"Ԫ����"+"|";
			/*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********������*********/
      note_info1+="��ӭ���μ�'���ֻ����ͻ��ѻ'��1.����͵�Ԥ�滰��ÿ���������ʹ���ܶ��ʮ��֮һ��������Ļ����������н��ɣ������λ������ֻ�������ֻ�������һ��ʹ�ã����򽫲�����ʹ�����͵�Ԥ�滰�ѡ����͵�Ԥ�滰�ѱ�����10������������ϣ�ʣ���ȫ��������;2.�����͵�Ԥ���δ�������ǰ�����˿ת�12�����ڲ��ð����ʷѱ����ҵ���ں�����а�������ҵ������ǰ����ȡ������ΥԼ�涨�������ͻ��ѣ�����ʣ��Ԥ����30%����ΥԼ��;3.δ�漰���ʷѣ������е��ƶ��绰�ʷѱ�׼ִ�С����λ�ֻ������й��ƶ�ҵ����Э����Ч�������������ʷѱ�׼�������������µ��ʷ�����ִ�С�"+"|";
      if(document.all.modestr.value.length>0){
      note_info1+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      note_info1+=" "+"|";
      }
      note_info1+="�ֻ��ն˻��Զ��������϶�Ķ��Ž��в�֣���ͬ�ͺ��ֻ��ն˲��ԭ��ͬ���ҹ�˾�����ֻ��Զ���ֵ������շѡ�"+"|";
			/* ningtn IMEI ���°�����*/
			note_info4 += "�������ֻ���ʧ����Ϊ�𻵵ȸ���ԭ���޷�ʹ�ö���ɻ������룬�뵽Ӫҵ�����¹��������򽫲��ܼ���ʹ��ʣ�໰�ѡ�" + "|";
	  /***************�ж��Ƿ���ʾ�ַ����******************/
	  var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
      var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
	  if(old_SmCode == "zn")
  		{
  			//ѦӢ�� 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@���ڻ��������������������� zn->gn ���ֲ�����
  		}
  		else
  		{
	  		if((new_SmCode !="") && (new_SmCode != old_SmCode))
	  		{
		  		/* ningtn �������� */
		  		
	  		}

  		}
  		
  			  	  			/* wanghyd ȥ������������ʾͬʱ������ʾ */
	  			<%if(smzvalue.equals("3")) {%>
		  		note_info1+="<%=readValue("8027","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
  		
      <%if(goodbz.equals("Y")){%>
			note_info1+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>

	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}
function printInfo8028()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	var tempStr = document.form1.iAddStr.value;
	  //iAddStr��ʽ ԭ��ˮ|Ӫ������|��������|���ͻ���|������|
	var backaccept = oneTokSelf(tempStr,"|",1);     //ԭ��ˮ
    var SaleCode = oneTokSelf(tempStr,"|",2);      //Ӫ������
	var PhoneName = oneTokSelf(tempStr,"|",3);     //��������
	var preparefee= oneTokSelf(tempStr,"|",4); //���ͻ���
	var PayMoney= oneTokSelf(tempStr,"|",5); //������



	  var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

	  var retInfo = "";
	  var cust_info="";
	  var opr_info="";
	  var note_info1="";
	  var note_info2="";
	  var note_info3="";
	  var note_info4="";
	    /********������Ϣ��**********/
       cust_info+="�ͻ�������" +document.all.i4.value+"|";
       cust_info+="�ֻ����룺"+document.all.phone.value+"|";
       cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
       cust_info+="֤�����룺"+document.all.i7.value+"|";

     /********������**********/
      opr_info+="ҵ�����ͣ����ֻ����ͻ��ѳ���"+"|";
      <%if(goodbz.equals("Y")){%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";
      <%}else{%>
      opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
      <%}%>
      opr_info+="�ֻ��ͺţ�"+PhoneName+"|";
      opr_info+="�˿�ϼƣ�"+PayMoney+"Ԫ�����ͻ��ѣ�"+preparefee+"Ԫ"+"|";
      /*******��ע��**********/
	  	if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }else{
	  	note_info1+=" "+"|";
	  	}
	  /**********������*********/
      if(document.all.modestr.value.length>0){
      note_info1+="���ʷ���Чʱ����ȡ���Ŀ�ѡ�ʷ�:"+document.all.modestr.value+"|";
      }else{
      note_info1+=" "+"|";
      }
      <%if(goodbz.equals("Y")){%>
			note_info1+="��ע���ú���Ϊ������룬������ѡ����ʷѵĻ��������õ������ѣ����߲�������Ϣ�ѣ��������������ѵĻ��ѣ���������Ϣ�ѣ�������߶�ȣ��������߱�׼��ȡ��"+"|";
			<%}%>
      //retInfo+="��ע����ӭ���μӡ�������ũ�塢�ֻ��ֳɼҡ�������Ļ���Ԥ���·������·������Ϊ"+formatFloat(prepay_fee/6, 2)+"Ԫ�������������ڲ��ܱ���ʷ��ײ͡�"+"|";
      //retInfo+="�����ֻ����ۻ�������Ļ���δ�����꣬�ͻ����ܰ�������ҵ��"+"|";

	  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	  return retInfo;
}
//��TD�̻���ͨ�ŷ�����   sunaj��20090828
function printInfo7981()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	var tempStr = document.form1.iAddStr.value;
		/**** ningtn add for pos start *****/
		document.all.bMoney.value = oneTokSelf(tempStr,"|",4);
		if(document.all.payType.value=="BX"){
				document.all.transType.value="00";
		}else if(document.all.payType.value=="BY"){
				document.all.transType.value="05";
		}
		/**** ningtn add for pos end *****/
	var sale_code     = oneTokSelf(tempStr,"|",1);	//��������
	var agent_code    = oneTokSelf(tempStr,"|",2);	//�̻�Ʒ��
	var phone_type    = oneTokSelf(tempStr,"|",3);	//�̻��ͺ�
	var sale_price    = oneTokSelf(tempStr,"|",4);	//Ӧ�ս��
	var base_fee      = oneTokSelf(tempStr,"|",5);	//����
	var consume_term  = oneTokSelf(tempStr,"|",6);	//������������
	var free_fee      = oneTokSelf(tempStr,"|",7);	//����
	var active_term   = oneTokSelf(tempStr,"|",8);	//������������
	var price         = oneTokSelf(tempStr,"|",9);	//���̻�����
	var market_price  = oneTokSelf(tempStr,"|",10); //�г���
	var imeino        = oneTokSelf(tempStr,"|",11); //IEMI����
	var all_fee       = parseFloat(base_fee)+parseFloat(free_fee);  //Ԥ�����



	var begin_time='<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>';

    var cust_info="";
    var opr_info="";
    var note_info1="";
    var note_info2="";
    var note_info3="";
    var note_info4="";

	var retInfo = "";
	/********������Ϣ��**********/
	cust_info+="�ֻ����룺"+document.all.phone.value+"|";
	cust_info+="�ͻ�������"+document.all.i4.value+"|";

	/********������**********/
	opr_info+="ҵ������: ��TD�̻�����������"+"|";
	<%if(goodbz.equals("Y")){%>
	opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
	<%}else{%>
	opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
	<%}%>
	opr_info+="������Ϣ��Ʒ��"+agent_code+"���ͺ�"+phone_type+"������IMEI"+imeino+"|";
	opr_info+="���ͻ���"+base_fee+"Ԫ|";
	if(free_fee>0)
	{
		opr_info+="����������: "+free_fee+"Ԫ��|";
	}
	opr_info+="ҵ��ִ��ʱ�䣺"+begin_time+"|";

	/*******��ע��**********/
	if("<%=bdbz%>"=="Y"){
		note_info1+="<%=bdts%>"+"|";
	}else{
		note_info1+=" "+"|";
	}
	/**********������*********/
	note_info2+="�ʷ�˵����"+"|";
	note_info2+=" "+codeChg("<%=note.trim()%>")+"|";
	note_info2+="������Զ�������ʷ�˵����"+"|";
	note_info2+=" "+codeChg("<%=note1.trim()%>")+"|";
	note_info2+="���Ļ�������ʹ�ã����Զ����Ϊ�����ʷѣ������Ե�Ӫҵ�������ԭ�ʷѡ�|";
	/***************�ж��Ƿ���ʾ�ַ����******************/
	   var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
       var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
	  if(old_SmCode == "zn")
  		{
  			//ѦӢ�� 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@���ڻ��������������������� zn->gn ���ֲ�����
  		}
  		else
  		{
	  		if((new_SmCode !="") && (new_SmCode != old_SmCode))
	  		{
		  		/* ningtn �������� */
		  		
	  		}

  		}
  		
  			  	  			/* wanghyd ȥ������������ʾͬʱ������ʾ */
	  			<%if(smzvalue.equals("3")) {%>
		  		note_info1+="<%=readValue("7981","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
  		
	note_info3+="  "+"|";
	note_info4+="��ע��"+"|";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;

}
//��TD�̻���ͨ�ŷѳ���  sunaj��20090828
function printInfo7982()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	var tempStr = document.form1.iAddStr.value;
	/**** ningtn add for pos start *****/
	document.all.bMoney.value = oneTokSelf(tempStr,"|",5);
	if(document.all.payType.value=="BX"){
			document.all.transType.value="01";
	}else if(document.all.payType.value=="BY"){
			document.all.transType.value="04";
	}
	/**** ningtn add for pos end *****/	
	var login_accept  = oneTokSelf(tempStr,"|",1);  //ҵ����ˮ
	var sale_code     = oneTokSelf(tempStr,"|",2);	//��������
	var agent_code    = oneTokSelf(tempStr,"|",3);	//�ֻ�Ʒ��
	var phone_type    = oneTokSelf(tempStr,"|",4);	//�ֻ��ͺ�
	var sale_price    = oneTokSelf(tempStr,"|",5);	//Ӧ�ս��
	var base_fee      = oneTokSelf(tempStr,"|",6);	//����
	var consume_term  = oneTokSelf(tempStr,"|",7);	//������������
	var free_fee      = oneTokSelf(tempStr,"|",8);	//������
	var active_term   = oneTokSelf(tempStr,"|",9);	//��������������
	var price         = oneTokSelf(tempStr,"|",10);	//��TD����
	var market_price  = oneTokSelf(tempStr,"|",11); //�г���
	var imeino        = oneTokSelf(tempStr,"|",12); //IEMI����
	var all_fee       = parseFloat(base_fee)+parseFloat(free_fee);  //Ԥ�����

	var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

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

	/********������**********/
	opr_info+="ҵ������: ��TD�̻������ѳ���"+"|";
	<%if(goodbz.equals("Y")){%>
	opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
	<%}else{%>
	opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
	<%}%>
	/*******��ע��**********/
	if("<%=bdbz%>"=="Y"){
		note_info1+="<%=bdts%>"+"|";
	}else{
		note_info1+=" "+"|";
	}
	/**********������*********/
	note_info3+=" "+"|";
    note_info4+="��ע��"+"|";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}
//��TD�̻���ͨ�ŷ�����   sunaj��20100427
function printInfo8551()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	var tempStr = document.form1.iAddStr.value;
		/**** ningtn add for pos start *****/
		document.all.bMoney.value = oneTokSelf(tempStr,"|",4);
		if(document.all.payType.value=="BX"){
				document.all.transType.value="00";
		}else if(document.all.payType.value=="BY"){
				document.all.transType.value="05";
		}
		/**** ningtn add for pos end *****/
	var sale_code     = oneTokSelf(tempStr,"|",1);	//��������
	var agent_code    = oneTokSelf(tempStr,"|",2);	//�̻�Ʒ��
	var phone_type    = oneTokSelf(tempStr,"|",3);	//�̻��ͺ�
	var sale_price    = oneTokSelf(tempStr,"|",4);	//Ӧ�ս��
	var base_fee      = oneTokSelf(tempStr,"|",5);	//����
	var consume_term  = oneTokSelf(tempStr,"|",6);	//������������
	var free_fee      = oneTokSelf(tempStr,"|",7);	//����
	var active_term   = oneTokSelf(tempStr,"|",8);	//������������
	var price         = oneTokSelf(tempStr,"|",9);	//���̻�����
	var market_price  = oneTokSelf(tempStr,"|",10); //�г���
	var imeino        = oneTokSelf(tempStr,"|",11); //IEMI����
	var all_fee       = parseFloat(base_fee)+parseFloat(free_fee);  //Ԥ�����



	var begin_time='<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>';

    var cust_info="";
    var opr_info="";
    var note_info1="";
    var note_info2="";
    var note_info3="";
    var note_info4="";

	var retInfo = "";
	/********������Ϣ��**********/
	cust_info+="�ֻ����룺"+document.all.phone.value+"|";
	cust_info+="�ͻ�������"+document.all.i4.value+"|";

	/********������**********/
	opr_info+="ҵ������: ��TD�̻�������(��ͨ)����"+"|";
	<%if(goodbz.equals("Y")){%>
	opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
	<%}else{%>
	opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
	<%}%>
	opr_info+="������Ϣ��Ʒ��"+agent_code+"���ͺ�"+phone_type+"������IMEI"+imeino+"|";
	opr_info+="���ͻ���"+base_fee+"Ԫ|";
	if(free_fee>0)
	{
		opr_info+="����������: "+free_fee+"Ԫ��|";
	}
	opr_info+="ҵ��ִ��ʱ�䣺"+begin_time+"|";

	/*******��ע��**********/
	if("<%=bdbz%>"=="Y"){
		note_info1+="<%=bdts%>"+"|";
	}else{
		note_info1+=" "+"|";
	}
	/**********������*********/
	note_info2+="�ʷ�˵����"+"|";
	note_info2+=" "+codeChg("<%=note.trim()%>")+"|";
	note_info2+="������Զ�������ʷ�˵����"+"|";
	note_info2+=" "+codeChg("<%=note1.trim()%>")+"|";
	note_info2+="���Ļ�������ʹ�ã����Զ����Ϊ�����ʷѣ������Ե�Ӫҵ�������ԭ�ʷѡ�|";

	note_info3+="  "+"|";
	note_info4+="��ע��"+"|";
	/***************�ж��Ƿ���ʾ�ַ����******************/
	  var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
	  var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
	  if(old_SmCode == "zn")
  		{
  			//ѦӢ�� 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@���ڻ��������������������� zn->gn ���ֲ�����
  		}
  		else
  		{
	  		if((new_SmCode !="") && (new_SmCode != old_SmCode))
	  		{
		  		/* ningtn �������� */
		  		
	  		}

  		}
  		
  			  	  			/* wanghyd ȥ������������ʾͬʱ������ʾ */
	  			<%if(smzvalue.equals("3")) {%>
		  		note_info1+="<%=readValue("8551","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
  		
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;

}
//��TD�̻���ͨ�ŷѳ���  sunaj��20100427
function printInfo8552()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	var tempStr = document.form1.iAddStr.value;
	/**** ningtn add for pos start *****/
	document.all.bMoney.value = oneTokSelf(tempStr,"|",5);
	if(document.all.payType.value=="BX"){
			document.all.transType.value="01";
	}else if(document.all.payType.value=="BY"){
			document.all.transType.value="04";
	}
	/**** ningtn add for pos end *****/	
	var login_accept  = oneTokSelf(tempStr,"|",1);  //ҵ����ˮ
	var sale_code     = oneTokSelf(tempStr,"|",2);	//��������
	var agent_code    = oneTokSelf(tempStr,"|",3);	//�ֻ�Ʒ��
	var phone_type    = oneTokSelf(tempStr,"|",4);	//�ֻ��ͺ�
	var sale_price    = oneTokSelf(tempStr,"|",5);	//Ӧ�ս��
	var base_fee      = oneTokSelf(tempStr,"|",6);	//����
	var consume_term  = oneTokSelf(tempStr,"|",7);	//������������
	var free_fee      = oneTokSelf(tempStr,"|",8);	//������
	var active_term   = oneTokSelf(tempStr,"|",9);	//��������������
	var price         = oneTokSelf(tempStr,"|",10);	//��TD����
	var market_price  = oneTokSelf(tempStr,"|",11); //�г���
	var imeino        = oneTokSelf(tempStr,"|",12); //IEMI����
	var all_fee       = parseFloat(base_fee)+parseFloat(free_fee);  //Ԥ�����

	var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

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

	/********������**********/
	opr_info+="ҵ������: ��TD�̻�������(��ͨ)����"+"|";
	<%if(goodbz.equals("Y")){%>
	opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
	<%}else{%>
	opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
	<%}%>
	/*******��ע��**********/
	if("<%=bdbz%>"=="Y"){
		note_info1+="<%=bdts%>"+"|";
	}else{
		note_info1+=" "+"|";
	}
	/**********������*********/
	note_info3+=" "+"|";
    note_info4+="��ע��"+"|";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}
//TD����̻����ʷѱ��
function printInfo8687()
{
  //�õ���ҵ�񹤵���Ҫ�Ĳ���
  var cust_info="";
  var opr_info="";
  var note_info1="";
  var note_info2="";
  var note_info3="";
  var note_info4="";

  var exeDate = "<%=exeDate.substring(0,8)%>";//�õ�ִ��ʱ��
  var region_code = "<%=WtcUtil.repNull(request.getParameter("belong_code")).substring(0,2)%>"; //��������
  var old_smCode = "<%=WtcUtil.repNull(request.getParameter("sNewSmName"))%>";

  var retInfo = "";

	/********������Ϣ��**********/
    cust_info+="�ͻ�������" +document.all.i4.value+"|";
    cust_info+="�ֻ����룺"+document.all.phone.value+"|";
    cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
    cust_info+="֤�����룺"+document.all.i7.value+"|";

    /********������**********/
    opr_info+="ҵ������ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    <%if(goodbz.equals("Y")){%>
    opr_info+="����ҵ��:���ʷѱ��"+"  "+"������ˮ: "+"<%=printAccept%>" +"|";
  <%}else{%>
  	opr_info+="����ҵ��:���ʷѱ��"+"  "+"������ˮ: "+"<%=printAccept%>" +"|";
  	<%}%>
    opr_info+="��ǰ���ʷѣ�"+"<%=WtcUtil.repNull(request.getParameter("i16"))%>"+"|";
    opr_info+="���������ʷѣ�"+codeChg(document.form1.ip.value.trim())+"      "+"���ʷ���Чʱ�䣺"+checkdate(exeDate)+"|";
    opr_info+="���������ʷѶ������ۣ�"+ codeChg("<%=daima.trim()%>")+"*|" ;
    if( document.all.kx_want.value != "" )
    {
    	opr_info+=codeChg(document.all.kx_want.value) + "|";
    }
    if( document.all.kx_cancle.value != "" )
    {
    	opr_info+=codeChg(document.all.kx_cancle.value) + "|";
    }

	  /*******��ע��**********/
	//note_info1+="��ע��"+"|";
	  if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }
	  /**********������*********/
	note_info1+="  "+"|";
	note_info1+="  "+"|";
    note_info1+="���������ʷ�����: "+"|";
    note_info1+=codeChg("<%=note.trim()%>")+"|";
    note_info2+="  "+"|";
    note_info3+="  "+"|";

	<%if(goodbz.equals("Y")){%>
	        note_info4+=" "+"|";
			note_info4+="��ע��"+"|";
	<%}%>
	note_info4+=" "+"|";
	note_info4+="��ע:"+codeChg(document.all.tonote.value)+"|";
  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  return retInfo;
}
//TD�̻����ʷѱ��
function printInfo8688()
{
  //�õ���ҵ�񹤵���Ҫ�Ĳ���
  var cust_info="";
  var opr_info="";
  var note_info1="";
  var note_info2="";
  var note_info3="";
  var note_info4="";

  var exeDate = "<%=exeDate.substring(0,8)%>";//�õ�ִ��ʱ��
  var region_code = "<%=WtcUtil.repNull(request.getParameter("belong_code")).substring(0,2)%>"; //��������
  var old_smCode = "<%=WtcUtil.repNull(request.getParameter("sNewSmName"))%>";

  var retInfo = "";

	/********������Ϣ��**********/
    cust_info+="�ͻ�������" +document.all.i4.value+"|";
    cust_info+="�ֻ����룺"+document.all.phone.value+"|";
    cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
    cust_info+="֤�����룺"+document.all.i7.value+"|";

    /********������**********/
    opr_info+="ҵ������ʱ�䣺"+'<%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date())%>'+"|";
    <%if(goodbz.equals("Y")){%>
    opr_info+="����ҵ��:���ʷѱ��"+"  "+"������ˮ: "+"<%=printAccept%>" +"|";
  <%}else{%>
  	opr_info+="����ҵ��:���ʷѱ��"+"  "+"������ˮ: "+"<%=printAccept%>" +"|";
  	<%}%>
    opr_info+="��ǰ���ʷѣ�"+"<%=WtcUtil.repNull(request.getParameter("i16"))%>"+"|";
    opr_info+="���������ʷѣ�"+codeChg(document.form1.ip.value.trim())+"      "+"���ʷ���Чʱ�䣺"+checkdate(exeDate)+"|";
    opr_info+="���������ʷѶ������ۣ�"+ codeChg("<%=daima.trim()%>")+"*|" ;
    if( document.all.kx_want.value != "" )
    {
    	opr_info+=codeChg(document.all.kx_want.value) + "|";
    }
    if( document.all.kx_cancle.value != "" )
    {
    	opr_info+=codeChg(document.all.kx_cancle.value) + "|";
    }

	  /*******��ע��**********/
	//note_info1+="��ע��"+"|";
	  if("<%=bdbz%>"=="Y"){
      	note_info1+="<%=bdts%>"+"|";
      }
	  /**********������*********/
	note_info1+="  "+"|";
	note_info1+="  "+"|";
    note_info1+="���������ʷ�����:"+"|";
    note_info1+=codeChg("<%=note.trim()%>")+"|";
    note_info2+="  "+"|";
    note_info3+="  "+"|";

	<%if(goodbz.equals("Y")){%>
	        note_info4+=" "+"|";
			note_info4+="��ע��"+"|";
	<%}%>
	note_info4+=" "+"|";
	note_info4+="��ע:"+codeChg(document.all.tonote.value)+"|";
  retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
  retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
  return retInfo;
}

function printInfoG068() 
{
	var cust_info="";
	var opr_info="";
	var note_info1="";
	var note_info2="";
	var note_info3="";
	var note_info4="";
	
	var exeDate = "<%=exeDate.substring(0,8)%>";//�õ�ִ��ʱ��
	var region_code = "<%=WtcUtil.repNull(request.getParameter("belong_code")).substring(0,2)%>"; //��������
	var old_smCode = "<%=WtcUtil.repNull(request.getParameter("sNewSmName"))%>";

	var tempStr = document.form1.iAddStr.value;	
	var phone_type    = oneTokSelf(tempStr,"|",3);	//�̻��ͺ�
	var imeino        = oneTokSelf(tempStr,"|",11); //IEMI����
	var agent_code    = oneTokSelf(tempStr,"|",2);	//�ֻ�Ʒ��
	
	cust_info+="�ֻ����룺"+document.all.phone.value+"|";
	cust_info+="�ͻ�������" +document.all.i4.value+"|";
	opr_info+="�û�Ʒ�ƣ�"+"<%=WtcUtil.repNull(request.getParameter("oSmName")).trim()%>"+"    ����ҵ��:TD�̻��Ա�������"+"|";
	opr_info+="������ˮ��<%=printAccept%>"+"|";
	opr_info+="TD�̻��ͺţ�"+agent_code+"-"+phone_type+"      IMEI�룺"+imeino+"|";
	note_info1+="��ӭ������TD�̻��Ա���������ҵ��"
		+"�����λ�����TD�̻���������Ա���TD�̻�������һ��ʹ�ã�"
		+"����ϵͳ����ִ���������TD�̻��ʷѣ��Զ����Ϊ30��ͨ�ʷѡ�"
		+"������TD�̻���ʧ�������������������ԭ����ɲ��ܼ���ʹ�ã�"
		+"�ɵ�Ӫҵ����������ҵ��"
		+"�����µ�TD�̻�����Ӫҵ���������°�ҵ�񣬲ſ��Լ���ʹ�á�"+"|";
	note_info2+="  "+"|";
    	note_info3+="  "+"|";
    	note_info4+="  "+"|";
	var retInfo = "";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}


//��TD����̻���ͨ�ŷ�����   sunaj��20090828
function printInfo7898()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	var tempStr = document.form1.iAddStr.value;
		/**** ningtn add for pos start *****/
		document.all.bMoney.value = oneTokSelf(tempStr,"|",4);
		if(document.all.payType.value=="BX"){
				document.all.transType.value="00";
		}else if(document.all.payType.value=="BY"){
				document.all.transType.value="05";
		}
		/**** ningtn add for pos end *****/
	var sale_code     = oneTokSelf(tempStr,"|",1);	//��������
	var agent_code    = oneTokSelf(tempStr,"|",2);	//�̻�Ʒ��
	var phone_type    = oneTokSelf(tempStr,"|",3);	//�̻��ͺ�
	var sale_price    = oneTokSelf(tempStr,"|",4);	//Ӧ�ս��
	var base_fee      = oneTokSelf(tempStr,"|",5);	//����
	var consume_term  = oneTokSelf(tempStr,"|",6);	//������������
	var free_fee      = oneTokSelf(tempStr,"|",7);	//����
	var active_term   = oneTokSelf(tempStr,"|",8);	//������������
	var all_gift_price= oneTokSelf(tempStr,"|",9);	//���̻�����
	var market_price  = oneTokSelf(tempStr,"|",10); //�г���
	var imeino        = oneTokSelf(tempStr,"|",11); //IEMI����
	var all_fee       = parseFloat(base_fee)+parseFloat(free_fee);  //Ԥ�����

	var begin_time='<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>';

    var cust_info="";
    var opr_info="";
    var note_info1="";
    var note_info2="";
    var note_info3="";
    var note_info4="";

	var retInfo = "";
	/********������Ϣ��**********/
	cust_info+="�ֻ����룺"+document.all.phone.value+"|";
	cust_info+="�ͻ�������"+document.all.i4.value+"|";

	/********������**********/
	opr_info+="ҵ������: Ԥ�滰����TD����̻�����"+"|";
	<%if(goodbz.equals("Y")){%>
	opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
	<%}else{%>
	opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
	<%}%>
	opr_info+="������Ϣ��Ʒ��"+agent_code+"���ͺ�"+phone_type+"������IMEI"+imeino+"|";
	opr_info+="���ͻ���"+base_fee+"Ԫ����"+consume_term+"�������ͣ�"+consume_term+"����������ϣ�|";
	if(free_fee>0)
	{
		opr_info+="����������: "+free_fee+"Ԫ��|";
	}
	opr_info+="ҵ��ִ��ʱ�䣺"+begin_time+"|";

	/*******��ע��**********/
	if("<%=bdbz%>"=="Y"){
		note_info1+="<%=bdts%>"+"|";
	}else{
		note_info1+=" "+"|";
	}
	/**********������*********/
	note_info2+="�ʷ�˵����"+"|";
	note_info2+=" "+codeChg("<%=note.trim()%>")+"|";
	note_info2+="������Զ�������ʷ�˵����"+"|";
	note_info2+=" "+codeChg("<%=note1.trim()%>")+"|";
	note_info2+="���Ļ�������ʹ�ã����Զ����Ϊ���ϵ��ʷѣ������Ե�Ӫҵ�������ԭ�ʷѡ�|";
	/***************�ж��Ƿ���ʾ�ַ����******************/
	   var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
       var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
	  if(old_SmCode == "zn")
  		{
  			//ѦӢ�� 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@���ڻ��������������������� zn->gn ���ֲ�����
  		}
  		else
  		{
	  		if((new_SmCode !="") && (new_SmCode != old_SmCode))
	  		{
		  		/* ningtn �������� */
		  		
	  		}

  		}
  		
  			  	  			/* wanghyd ȥ������������ʾͬʱ������ʾ */
	  			<%if(smzvalue.equals("3")) {%>
		  		note_info1+="<%=readValue("7898","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
  		
	note_info3+=" "+"|";
	note_info4+="��ע�� "+"|";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;

}
//��TD����̻���ͨ�ŷѳ���  sunaj��20090828
function printInfo7899()
{
	//�õ���ҵ�񹤵���Ҫ�Ĳ���
	var tempStr = document.form1.iAddStr.value;
	/**** ningtn add for pos start *****/
	document.all.bMoney.value = oneTokSelf(tempStr,"|",5);
	if(document.all.payType.value=="BX"){
			document.all.transType.value="01";
	}else if(document.all.payType.value=="BY"){
			document.all.transType.value="04";
	}
	/**** ningtn add for pos end *****/	
	var login_accept  = oneTokSelf(tempStr,"|",1);  //ҵ����ˮ
	var sale_code     = oneTokSelf(tempStr,"|",2);	//��������
	var agent_code    = oneTokSelf(tempStr,"|",3);	//�ֻ�Ʒ��
	var phone_type    = oneTokSelf(tempStr,"|",4);	//�ֻ��ͺ�
	var sale_price    = oneTokSelf(tempStr,"|",5);	//Ӧ�ս��
	var base_fee      = oneTokSelf(tempStr,"|",6);	//����Ԥ��
	var consume_term  = oneTokSelf(tempStr,"|",7);	//������������
	var free_fee      = oneTokSelf(tempStr,"|",8);	//�Ԥ��
	var active_term   = oneTokSelf(tempStr,"|",9);	//���������
	var all_gift_price= oneTokSelf(tempStr,"|",10);	//��������
	var market_price  = oneTokSelf(tempStr,"|",11); //�г���
	var imeino        = oneTokSelf(tempStr,"|",12); //IEMI����
	var all_fee       = parseFloat(base_fee)+parseFloat(free_fee);  //Ԥ�����

	var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

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

	/********������**********/
	opr_info+="ҵ������: Ԥ�滰����TD����̻�����"+"|";
	<%if(goodbz.equals("Y")){%>
	opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
	<%}else{%>
	opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
	<%}%>
	/*******��ע��**********/
	if("<%=bdbz%>"=="Y"){
		note_info1+="<%=bdts%>"+"|";
	}else{
		note_info1+=" "+"|";
	}
	/**********������*********/
	note_info3+=" "+"|";
    note_info4+="��ע��"+"|";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}

//TD�̻��Ա�����������  
function printInfoG069()
{
	//�õ���ҵ�񹤵���Ҫ�Ĳ���
	var tempStr = document.form1.iAddStr.value;
	/**** ningtn add for pos start *****/
	document.all.bMoney.value = oneTokSelf(tempStr,"|",5);
	if(document.all.payType.value=="BX"){
			document.all.transType.value="01";
	}else if(document.all.payType.value=="BY"){
			document.all.transType.value="04";
	}
	/**** ningtn add for pos end *****/	
	var login_accept  = oneTokSelf(tempStr,"|",1);  //ҵ����ˮ
	var sale_code     = oneTokSelf(tempStr,"|",2);	//��������
	var agent_code    = oneTokSelf(tempStr,"|",3);	//�ֻ�Ʒ��
	var phone_type    = oneTokSelf(tempStr,"|",4);	//�ֻ��ͺ�
	var sale_price    = oneTokSelf(tempStr,"|",5);	//Ӧ�ս��
	var base_fee      = oneTokSelf(tempStr,"|",6);	//����Ԥ��
	var consume_term  = oneTokSelf(tempStr,"|",7);	//������������
	var free_fee      = oneTokSelf(tempStr,"|",8);	//�Ԥ��
	var active_term   = oneTokSelf(tempStr,"|",9);	//���������
	var all_gift_price= oneTokSelf(tempStr,"|",10);	//��������
	var market_price  = oneTokSelf(tempStr,"|",11); //�г���
	var imeino        = oneTokSelf(tempStr,"|",12); //IEMI����
	var all_fee       = parseFloat(base_fee)+parseFloat(free_fee);  //Ԥ�����

	var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

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

	/********������**********/
	var smName="";
	if("<%=WtcUtil.repNull(request.getParameter("i8"))%>" == "zn")
		smName="������";
	else if("<%=WtcUtil.repNull(request.getParameter("i8"))%>" == "gn")
		smName="ȫ��ͨ";
	else if("<%=WtcUtil.repNull(request.getParameter("i8"))%>" == "dn")
		smName="���еش�";	
	opr_info+="�û�Ʒ�ƣ�"+smName+"|";
	opr_info+="����ҵ�� TD�̻��Ա�����������"+"|";

	<%if(goodbz.equals("Y")){%>
	opr_info+="ҵ����ˮ��"+"<%=printAccept%>"+"|";
	<%}else{%>
	opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
	<%}%>
	opr_info+="TD�̻��ͺţ�"+agent_code+"-"+phone_type+"      IMEI�룺"+imeino+"|";
	/*******��ע��**********/

	/**********������*********/
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}


//��TD����̻�,��ͨ�ŷ�(��ͨ)����   wangyua��20100511
function printInfo7688()
{
	  //�õ���ҵ�񹤵���Ҫ�Ĳ���
	var tempStr = document.form1.iAddStr.value;
		/**** ningtn add for pos start *****/
		document.all.bMoney.value = oneTokSelf(tempStr,"|",4);
		if(document.all.payType.value=="BX"){
				document.all.transType.value="00";
		}else if(document.all.payType.value=="BY"){
				document.all.transType.value="05";
		}
		/**** ningtn add for pos end *****/
	var sale_code     = oneTokSelf(tempStr,"|",1);	//��������
	var agent_code    = oneTokSelf(tempStr,"|",2);	//�̻�Ʒ��
	var phone_type    = oneTokSelf(tempStr,"|",3);	//�̻��ͺ�
	var sale_price    = oneTokSelf(tempStr,"|",4);	//Ӧ�ս��
	var base_fee      = oneTokSelf(tempStr,"|",5);	//����
	var consume_term  = oneTokSelf(tempStr,"|",6);	//������������
	var free_fee      = oneTokSelf(tempStr,"|",7);	//����
	var active_term   = oneTokSelf(tempStr,"|",8);	//������������
	var all_gift_price= oneTokSelf(tempStr,"|",9);	//���̻�����
	var market_price  = oneTokSelf(tempStr,"|",10); //�г���
	var imeino        = oneTokSelf(tempStr,"|",11); //IEMI����
	var all_fee       = parseFloat(base_fee)+parseFloat(free_fee);  //Ԥ�����

	var begin_time='<%=new java.text.SimpleDateFormat("yyyy-MM-dd", Locale.getDefault()).format(new java.util.Date())%>';

    var cust_info="";
    var opr_info="";
    var note_info1="";
    var note_info2="";
    var note_info3="";
    var note_info4="";

	var retInfo = "";
	/********������Ϣ��**********/
	cust_info+="�ֻ����룺"+document.all.phone.value+"|";
	cust_info+="�ͻ�������"+document.all.i4.value+"|";

	/********������**********/
	opr_info+="ҵ������: Ԥ�滰����TD����̻�(��ͨ)����"+"|";
	<%if(goodbz.equals("Y")){%>
	opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
	<%}else{%>
	opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
	<%}%>
	opr_info+="������Ϣ��Ʒ��"+agent_code+"���ͺ�"+phone_type+"������IMEI"+imeino+"|";
	opr_info+="���ͻ��ѣ�"+base_fee+"Ԫ����"+consume_term+"�������ͣ�"+consume_term+"����������ϣ�|";
	if(free_fee>0)
	{
		opr_info+="���������ѣ�"+free_fee+"Ԫ��|";
	}
	opr_info+="ҵ��ִ��ʱ�䣺"+begin_time+"|";

	/*******��ע��**********/
	if("<%=bdbz%>"=="Y"){
		note_info1+="<%=bdts%>"+"|";
	}else{
		note_info1+=" "+"|";
	}
	/**********������*********/
	note_info2+="�ʷ�˵����"+"|";
	note_info2+=" "+codeChg("<%=note.trim()%>")+"|";
	note_info2+="������Զ�������ʷ�˵����"+"|";
	note_info2+=" "+codeChg("<%=note1.trim()%>")+"|";
	note_info2+="���Ļ�������ʹ�ã����Զ����Ϊ���ϵ��ʷѣ������Ե�Ӫҵ�������ԭ�ʷѡ�|";

	note_info3+=" "+"|";
	note_info4+="��ע�� "+"|";
	/***************�ж��Ƿ���ʾ�ַ����******************/
	  var old_SmCode = "<%=WtcUtil.repNull(request.getParameter("oSmCode"))%>";
	  var new_SmCode = "<%=WtcUtil.repNull(request.getParameter("m_smCode"))%>";
	  if(old_SmCode == "zn")
  		{
  			//ѦӢ�� 20070716 R_HLJMob_cuisr_CRM_PD3_2007_226@���ڻ��������������������� zn->gn ���ֲ�����
  		}
  		else
  		{
	  		if((new_SmCode !="") && (new_SmCode != old_SmCode))
	  		{
		  		/* ningtn �������� */
		  		
	  		}

  		}
  		
  			  	  			/* wanghyd ȥ������������ʾͬʱ������ʾ */
	  			<%if(smzvalue.equals("3")) {%>
		  		note_info1+="<%=readValue("7688","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
  		
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;

}
//��TD����̻���ͨ�ŷ�(��ͨ)����  wangyua��20100511
function printInfo7689()
{
	//�õ���ҵ�񹤵���Ҫ�Ĳ���
	var tempStr = document.form1.iAddStr.value;
	/**** ningtn add for pos start *****/
	document.all.bMoney.value = oneTokSelf(tempStr,"|",5);
	if(document.all.payType.value=="BX"){
			document.all.transType.value="01";
	}else if(document.all.payType.value=="BY"){
			document.all.transType.value="04";
	}
	/**** ningtn add for pos end *****/	
	var login_accept  = oneTokSelf(tempStr,"|",1);  //ҵ����ˮ
	var sale_code     = oneTokSelf(tempStr,"|",2);	//��������
	var agent_code    = oneTokSelf(tempStr,"|",3);	//�ֻ�Ʒ��
	var phone_type    = oneTokSelf(tempStr,"|",4);	//�ֻ��ͺ�
	var sale_price    = oneTokSelf(tempStr,"|",5);	//Ӧ�ս��
	var base_fee      = oneTokSelf(tempStr,"|",6);	//����Ԥ��
	var consume_term  = oneTokSelf(tempStr,"|",7);	//������������
	var free_fee      = oneTokSelf(tempStr,"|",8);	//�Ԥ��
	var active_term   = oneTokSelf(tempStr,"|",9);	//���������
	var all_gift_price= oneTokSelf(tempStr,"|",10);	//��������
	var market_price  = oneTokSelf(tempStr,"|",11); //�г���
	var imeino        = oneTokSelf(tempStr,"|",12); //IEMI����
	var all_fee       = parseFloat(base_fee)+parseFloat(free_fee);  //Ԥ�����

	var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

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

	/********������**********/
	opr_info+="ҵ������: Ԥ�滰����TD����̻�(��ͨ)����"+"|";
	<%if(goodbz.equals("Y")){%>
	opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
	<%}else{%>
	opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
	<%}%>
	/*******��ע��**********/
	if("<%=bdbz%>"=="Y"){
		note_info1+="<%=bdts%>"+"|";
	}else{
		note_info1+=" "+"|";
	}
	/**********������*********/
	note_info3+=" "+"|";
    note_info4+="��ע��"+"|";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}

//��Լ�ƻ�����
function printInfoE505() {
		//�õ���ҵ�񹤵���Ҫ�Ĳ���
		var tempStr = document.form1.iAddStr.value;
		/**** pos start *****/
		document.all.bMoney.value = oneTokSelf(tempStr,"|",10);
		if(document.all.payType.value=="BX"){
				document.all.transType.value="00";
		}else if(document.all.payType.value=="BY"){
				document.all.transType.value="05";
		}else if(document.all.payType.value=="EI"){
				document.all.transType.value="12";
		}
		/**** pos end *****/
		var login_accept   = '<%=printAccept%>';        //ҵ����ˮ
		var old_code			 = '<%=iold_m_code%>';        //���ʷѴ���
		var sale_code 		 = '<%=inew_m_code%>';        //�����ʷѴ���
		var phone_brand    = oneTokSelf(tempStr,"|",1); //�ֻ�Ʒ��
		var phone_type     = oneTokSelf(tempStr,"|",2);	//�ֻ��ͺ�
		var sale_ways      = oneTokSelf(tempStr,"|",3);	//Ӫ������
		var mode_sale   	 = oneTokSelf(tempStr,"|",4);	//�����ʷ�
		var prepay_limit   = oneTokSelf(tempStr,"|",5);	//����Ԥ��
		var prepay_gift    = oneTokSelf(tempStr,"|",6);	//�Ԥ��
		var consume_term   = oneTokSelf(tempStr,"|",7);	//Ԥ����������
		var mon_base_fee   = oneTokSelf(tempStr,"|",8);	//�µ�������
		var base_fee   		 = oneTokSelf(tempStr,"|",9);	//������
		var sale_price     = oneTokSelf(tempStr,"|",10);//�û��ɷѺϼ�
		var active_term    = oneTokSelf(tempStr,"|",11);//�������
		var sale_name  		 = oneTokSelf(tempStr,"|",12);//�׶λ����
		var imeino         = oneTokSelf(tempStr,"|",13);//IMEI��
		var mon_prepay_limit  = oneTokSelf(tempStr,"|",14);//�µ���Ԥ��
		var feeMark         = oneTokSelf(tempStr,"|",15);//IMEI��
		var pointMoney  = oneTokSelf(tempStr,"|",16);//�µ���Ԥ��
		var instalNum = oneTokSelf(tempStr,"|",17);//������
		var instalIncome = oneTokSelf(tempStr,"|",18);//���ڱ���
		var yuCunKuan = parseFloat(prepay_limit) + parseFloat(prepay_gift);
		//����iAddStr��ֵ
		/**Ӫ������|Ʒ������|Ʒ���ͺţ��û��ɷѺϼƣ�����Ԥ����������ޣ��Ԥ���������ޣ����������0��imei��|�������**/
		base_fee = parseFloat(base_fee-pointMoney).toFixed(2);//liujian 2012-7-30 16:11:53 ������ѻ���
		var txt = sale_ways     + "|" + 
				phone_brand   + "|" +
				phone_type    + "|" + 
				sale_price    + "|" + 
				prepay_limit  + "|" + 
				consume_term  + "|" + 
				prepay_gift   + "|" + 
				active_term  + "|" + 
				base_fee      + "|" + 
				"0"           + "|" + 
				imeino        + "|" +
				feeMark       + "|" +
				parseFloat(pointMoney).toFixed(2)    + "|";//liujian 2012-7-30 16:11:53 ������ѻ���
				txt += instalNum + "|";
				txt += instalIncome + "|";
		$("input[name='iAddStr']").val(txt);
		
		var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

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
	cust_info+="֤�����룺" +document.all.i7.value+"|";
	cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
	
	/********������**********/
//	var saleName = sale_name ? (sale_name+"--") : "";
  opr_info+="�û�Ʒ��: "+ "<%=WtcUtil.repNull(request.getParameter("i8"))%>" + "       ����ҵ��:" + "<%=e505_sale_name%>" + "<%=opName%>"+"|";
  <%if(goodbz.equals("Y")){%>
		opr_info+="������ˮ: "+"<%=printAccept%>" +"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";;
	<%}else{%>
		opr_info+="������ˮ: "+"<%=printAccept%>" +"|";
	<%}%>
  opr_info+="�ֻ��ͺţ�" + phone_type + "          IMEI��:" + imeino + "|";
  opr_info+="�ɷѺϼƣ�" + sale_price  +"Ԫ  ����������" + base_fee + "Ԫ����ʹ��"+feeMark+"���ֵ���"+parseFloat(pointMoney).toFixed(2)+"Ԫ�������Ԥ���" + yuCunKuan + "Ԫ��ÿ�·������" + mon_prepay_limit +"Ԫ��һ���Է���" + prepay_gift + "Ԫ��ҵ����Ч��" + consume_term + "����" + "|" ;
	/*******��ע��**********/
	if("<%=bdbz%>"=="Y"){
		note_info1+="<%=bdts%>"+"|";
	}else{
		note_info1+=" "+"|";
	}
	note_info2+=" "+"|";
	/**********������*********/
	note_info3+="ǩԼ�ʷ�: " + "<%=new_Mode_Name%>" + "��" + "<%=note%>" + "|";
  note_info4+="��ע��" + document.all.tonote.value + "|";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	
	
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}
//��Լ�ƻ���������
function printInfoE506() {
		//�õ���ҵ�񹤵���Ҫ�Ĳ���
		var tempStr = document.form1.iAddStr.value;
		/**** pos start *****/
		document.all.bMoney.value = oneTokSelf(tempStr,"|",5);
		if(document.all.payType.value=="BX"){
				document.all.transType.value="01";
		}else if(document.all.payType.value=="BY"){
				document.all.transType.value="04";
		}else if(document.all.payType.value=="EI"){
				document.all.transType.value="04";
		}
		/**** pos end *****/
		
		/*
			������ˮ��Ӫ������|Ʒ������|Ʒ���ͺţ��û��ɷѺϼƣ�����Ԥ����������ޣ��Ԥ�������ޣ����������0��imei���
			loginAccept1
			saleCode 2
			brandName 3
			resName 4
			cashPay 5
			baseFee 6
			consumeTerm 7
			prepay_Gift 8
			consumeTerm 9 
			machPrice 10
			0
			imeiNo 12
		*/
		var login_accept   = '<%=printAccept%>';        //ҵ����ˮ
		var old_code			 = '<%=iold_m_code%>';        //���ʷѴ���
		var sale_code 		 = '<%=inew_m_code%>';        //�����ʷѴ���
		
		var phone_brand    = oneTokSelf(tempStr,"|",1); //������ˮ
		var saleCode     = oneTokSelf(tempStr,"|",2);	//Ӫ������
		var brandName      = oneTokSelf(tempStr,"|",3);	//Ʒ������
		var resName   	 = oneTokSelf(tempStr,"|",4);	//Ʒ���ͺ�
		var cashPay   = oneTokSelf(tempStr,"|",5);	//�û��ɷѺϼ�
		var baseFee    = oneTokSelf(tempStr,"|",6);	//����Ԥ��
		var consumeTerm   = oneTokSelf(tempStr,"|",7);	//��������
		var prepay_Gift   = oneTokSelf(tempStr,"|",8);	//�Ԥ��
		var consumeTerm   		 = oneTokSelf(tempStr,"|",9);	//�����
		var machPrice     = oneTokSelf(tempStr,"|",10);//������
		var imeiNo    		 = oneTokSelf(tempStr,"|",12);//imei��
		
		var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

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
		cust_info+="֤�����룺" +document.all.i7.value+"|";
		cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
		
		/********������**********/
	  opr_info+="�û�Ʒ��: "+ "<%=WtcUtil.repNull(request.getParameter("i8"))%>" + "       ����ҵ��:" + "<%=e505_sale_name%>" +"<%=opName%>"+"|";
		opr_info+="������ˮ: "+"<%=printAccept%>" +"|";
	  opr_info+="�˿" + cashPay  +"Ԫ|" ;
		/*******��ע��**********/
		if("<%=bdbz%>"=="Y"){
			note_info1+="<%=bdts%>"+"|";
		}else{
			note_info1+=" "+"|";
		}
		note_info2+=" "+"|";
		/**********������*********/
	  note_info4+="��ע��" + document.all.tonote.value + "|";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		
		
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;
}
//�Ա�����Լ�ƻ�
function printInfoE721() {
		//�õ���ҵ�񹤵���Ҫ�Ĳ���
		var tempStr = document.form1.iAddStr.value;
		/**** pos start *****/
		document.all.bMoney.value = oneTokSelf(tempStr,"|",4);
		if(document.all.payType.value=="BX"){
				document.all.transType.value="01";
		}else if(document.all.payType.value=="BY"){
				document.all.transType.value="04";
		}

		var login_accept   = '<%=printAccept%>';        //ҵ����ˮ
		var old_code			 = '<%=iold_m_code%>';        //���ʷѴ���
		var sale_code 		 = '<%=inew_m_code%>';        //�����ʷѴ���
		var oldAccept      = oneTokSelf(tempStr,"|",1);	//������ˮ
		var saleCode    = oneTokSelf(tempStr,"|",2); //
		var brandName     = oneTokSelf(tempStr,"|",3);	//Ʒ��
		var resName   = oneTokSelf(tempStr,"|",4);	//
		var cashPay     = oneTokSelf(tempStr,"|",5);	//
		var consume_term   = oneTokSelf(tempStr,"|",6);	//
		var free_fee		=oneTokSelf(tempStr,"|",7);//�Ż��ܽ��
		var active_term		=oneTokSelf(tempStr,"|",8);//�������
		var base_fee		=oneTokSelf(tempStr,"|",9);//�Żݱ���
		var phoneOther 	= oneTokSelf(tempStr,"|",10);//
		var imeino         = oneTokSelf(tempStr,"|",11);//IMEI��
		//����iAddStr��ֵ
		/**Ӫ������|Ʒ������|Ʒ���ͺţ��û��ɷѺϼƣ�����Ԥ����������ޣ��Ԥ���������ޣ�������Ԥ������0��imei��|**/
		var temp = tempStr.substring(0,tempStr.lastIndexOf("|"));
	
		var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

    var cust_info="";
    var opr_info="";
    var note_info1="";
    var note_info2="";
    var note_info3="";
    var note_info4="";
	
	var retInfo = "";
	/********������Ϣ��**********/
	cust_info+="�ֻ����룺"+document.all.phone.value+"|";
	cust_info+="�ͻ�������" +document.all.i4.value+"|";
	cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";	
	cust_info+="֤�����룺" +document.all.i7.value+"|";
	/********������**********/
	 var exeDate = "<%=exeDate.substring(0,6)%>"

//	var saleName = sale_name ? (sale_name+"--") : "";
  	opr_info+="�û�Ʒ��: "	+'<%=WtcUtil.repNull(request.getParameter("i8"))%>'+ "       ����ҵ��:" + "<%=sale_name%>"+"--" + "<%=opName%>"+"|";
	opr_info+="	ҵ����ˮ��"+login_accept+"|";
	opr_info+="	�ֻ��ͺţ�"+resName  +"|";
	opr_info+="	��Ԥ���:"+cashPay+"Ԫ"+"|";

	/*******��ע��**********/
	if("<%=bdbz%>"=="Y"){
		note_info1+="<%=bdts%>"+"|";
	}else{
		note_info1+=" "+"|";
	}
	note_info2+=" "+"|";
	/**********������*********/

  note_info4+="��ע:|" ;
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}


function printInfoE720() {
		//�õ���ҵ�񹤵���Ҫ�Ĳ���
		var tempStr = document.form1.iAddStr.value;
		/**** pos start *****/
		document.all.bMoney.value = oneTokSelf(tempStr,"|",4);
		if(document.all.payType.value=="BX"){
				document.all.transType.value="01";
		}else if(document.all.payType.value=="BY"){
				document.all.transType.value="04";
		}
		/**** iSaleCode|iBrandName|iTypeName|�ɷѽ��|iBaseFee|�Ż�����|�Ż��ܽ��|�������
		|�Żݱ���|���˺���|iImeiNo|*****/
		var login_accept   = '<%=printAccept%>';        //ҵ����ˮ
		var old_code			 = '<%=iold_m_code%>';        //���ʷѴ���
		var sale_code 		 = '<%=inew_m_code%>';        //�����ʷѴ���
		var sale_ways      = oneTokSelf(tempStr,"|",1);	//Ӫ������
		var phone_brand    = oneTokSelf(tempStr,"|",2); //�ֻ�Ʒ��
		var phone_type     = oneTokSelf(tempStr,"|",3);	//�ֻ��ͺ�
		var prepay_limit   = oneTokSelf(tempStr,"|",4);	//�ɷѽ��
		var iBaseFee     = oneTokSelf(tempStr,"|",5);	//iBaseFee
		var consume_term   = oneTokSelf(tempStr,"|",6);	//��Լ����
		var free_fee		=oneTokSelf(tempStr,"|",7);//�Ż��ܽ��
		var active_term		=oneTokSelf(tempStr,"|",8);//�������
		var base_fee		=oneTokSelf(tempStr,"|",9);//�Żݱ���
		var phoneOther 	= oneTokSelf(tempStr,"|",10);//�µ���Ԥ��
		var imeino         = oneTokSelf(tempStr,"|",11);//IMEI��
		var temp = tempStr.substring(0,tempStr.lastIndexOf("|"));
	

    var cust_info="";
    var opr_info="";
    var note_info1="";
    var note_info2="";
    var note_info3="";
    var note_info4="";
	
	var retInfo = "";


	/********������Ϣ��**********/
	cust_info+="�ֻ����룺"+document.all.phone.value+"|";
	cust_info+="�ͻ�������" +document.all.i4.value+"|";
	cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";	
	cust_info+="֤�����룺" +document.all.i7.value+"|";
	/********������**********/
		
	var	dt1 =new Date ();
	var ctBY=dt1.getFullYear();
	var ctBM= dt1.getMonth()+1;
		
	var ctEnd = new Date(dt1.getFullYear(), ( dt1.getMonth()+parseInt(consume_term , 10 ) ));
	var ctEndY=ctEnd.getFullYear();
	var ctEndM=ctEnd.getMonth()+1;
//	var saleName = sale_name ? (sale_name+"--") : "";
	var login_accept   = '<%=printAccept%>';        //ҵ����ˮ
  opr_info+="�û�Ʒ��: "	+'<%=WtcUtil.repNull(request.getParameter("i8"))%>'+ "       ����ҵ��:" + "<%=sale_name%>" + "<%=opName%>"+"|";
  opr_info+="�ʷ��ײͣ�" 	+document.all.ip.value    +"|";       
  opr_info+="�ʷ�������"	+ "<%=note%>"			+"|";      
  opr_info+= "��Լ�ڣ�"+ctBY+"��"+ctBM+"����"+ctEndY+"��"+ctEndM+"��	"+"|";      
  opr_info+="ҵ����ˮ��"+login_accept+"|";   
  opr_info+="�ֻ��ͺ�:"+phone_type+"    IMEI�룺"+imeino+"|";   
  opr_info+="�ɷѺϼ�:"+prepay_limit+"����Ԥ�滰��"+prepay_limit+"Ԫ��"+"|"; 
  opr_info+="��Լ������ͨ�ŷ����Ż��ܶ��Ϊ"+free_fee+"Ԫ��"+"|"; 
  opr_info+="ͨ�ŷ����Żݱ���Ϊ�ͻ��ƶ��绰������ʵ�����Ѷ�ȵ�"+base_fee+"%��"+"|"; 
	/*******��ע��**********/
	if("<%=bdbz%>"=="Y"){
		note_info1+="<%=bdts%>"+"|";
	}else{
		note_info1+=" "+"|";
	}
	note_info2+=" "+"|";
	/**********������*********/

  note_info4+="��ע��|" ;

	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}

function printInfoE528() {
		//�õ���ҵ�񹤵���Ҫ�Ĳ���
		var tempStr = document.form1.iAddStr.value;
		/**** pos start *****/
		document.all.bMoney.value = oneTokSelf(tempStr,"|",4);
		if(document.all.payType.value=="BX"){
				document.all.transType.value="01";
		}else if(document.all.payType.value=="BY"){
				document.all.transType.value="04";
		}
		/**** pos end *****/
		var login_accept   = '<%=printAccept%>';        //ҵ����ˮ
		var old_code			 = '<%=iold_m_code%>';        //���ʷѴ���
		var sale_code 		 = '<%=inew_m_code%>';        //�����ʷѴ���
		var sale_ways      = oneTokSelf(tempStr,"|",1);	//Ӫ������
		var phone_brand    = oneTokSelf(tempStr,"|",2); //�ֻ�Ʒ��
		var phone_type     = oneTokSelf(tempStr,"|",3);	//�ֻ��ͺ�
		var sale_price     = oneTokSelf(tempStr,"|",4);	//�ɷѺϼ�
		var prepay_limit   = oneTokSelf(tempStr,"|",5);	//����Ԥ��
		var consume_term   = oneTokSelf(tempStr,"|",6);	//��������
		var prepay_gift    = oneTokSelf(tempStr,"|",7);	//�Ԥ��
		var mon_base_fee   = oneTokSelf(tempStr,"|",9);	//������Ԥ���
		var imeino         = oneTokSelf(tempStr,"|",11);//IMEI��
		var mon_prepay_limit = oneTokSelf(tempStr,"|",12);//�µ���Ԥ��
		var sale_name			 = oneTokSelf(tempStr,"|",13);//�׶λ����
		var yuCunKuan =  parseFloat(prepay_limit) + parseFloat(prepay_gift);
		//����iAddStr��ֵ
		/**Ӫ������|Ʒ������|Ʒ���ͺţ��û��ɷѺϼƣ�����Ԥ����������ޣ��Ԥ���������ޣ�������Ԥ������0��imei��|**/
		var temp = tempStr.substring(0,tempStr.lastIndexOf("|"));
		$("input[name='iAddStr']").val(temp.substring(0,temp.lastIndexOf("|")+1));
		$('#mon_prepay_limit').val(mon_prepay_limit);
		var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

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
	cust_info+="֤�����룺" +document.all.i7.value+"|";
	cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
	
	/********������**********/
//	var saleName = sale_name ? (sale_name+"--") : "";
  opr_info+="�û�Ʒ��: "+ "<%=WtcUtil.repNull(request.getParameter("i8"))%>" 
  	+ "       ����ҵ��:" + "<%=sale_name%>" + "<%=opName%>"+"|";
  <%if(goodbz.equals("Y")){%>
		opr_info+="������ˮ: "+"<%=printAccept%>" +"       �������ѽ�"+"<%=modedxpay%>"+"Ԫ"+"|";;
	<%}else{%>
		opr_info+="������ˮ: "+"<%=printAccept%>" +"|";
	<%}%>
  opr_info+="�ֻ��ͺţ�" + phone_type + "            IMEI��:" + imeino + "|";
  opr_info+="�ɷѺϼƣ�" + sale_price  +"Ԫ  ����Ԥ�滰��" + yuCunKuan + "Ԫ��ÿ�·������" + mon_prepay_limit + "Ԫ��һ���Է���" + prepay_gift + "Ԫ��ÿ�����ͷ���" + mon_base_fee + "Ԫ,ҵ����Ч��" + parseInt(consume_term) + "���¡�" + "|" ;
	/*******��ע��**********/
	if("<%=bdbz%>"=="Y"){
		note_info1+="<%=bdts%>"+"|";
	}else{
		note_info1+=" "+"|";
	}
	note_info2+=" "+"|";
	/**********������*********/
	note_info3+="ǩԼ�ʷ�: " + "<%=new_Mode_Name%>" + "��" + "<%=note%>" + "|";
  note_info4+="��ע��" + document.all.tonote.value + "|";
	retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
	retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
	return retInfo;
}
//�Ա�����Լ�ƻ�����
function printInfoE529() {
		//�õ���ҵ�񹤵���Ҫ�Ĳ���
		var tempStr = document.form1.iAddStr.value;
		/**** pos start *****/
		document.all.bMoney.value = oneTokSelf(tempStr,"|",5);
		if(document.all.payType.value=="BX"){
				document.all.transType.value="01";
		}else if(document.all.payType.value=="BY"){
				document.all.transType.value="04";
		}
		/**** pos end *****/
		
		/*
			������ˮ��Ӫ������|Ʒ������|Ʒ���ͺţ��û��ɷѺϼƣ�����Ԥ����������ޣ��Ԥ�������ޣ�������Ԥ������0��imei���
			loginAccept1
			saleCode 2
			brandName 3
			resName 4
			cashPay 5
			baseFee 6
			consumeTerm 7
			prepay_Gift 8
			consumeTerm 9 
			machPrice 10
			0
			imeiNo 12
		*/
		var login_accept   = '<%=printAccept%>';        //ҵ����ˮ
		var old_code			 = '<%=iold_m_code%>';        //���ʷѴ���
		var sale_code 		 = '<%=inew_m_code%>';        //�����ʷѴ���
		
		var phone_brand    = oneTokSelf(tempStr,"|",1); //������ˮ
		var saleCode     = oneTokSelf(tempStr,"|",2);	//Ӫ������
		var brandName      = oneTokSelf(tempStr,"|",3);	//Ʒ������
		var resName   	 = oneTokSelf(tempStr,"|",4);	//Ʒ���ͺ�
		var cashPay   = oneTokSelf(tempStr,"|",5);	//�û��ɷѺϼ�
		var baseFee    = oneTokSelf(tempStr,"|",6);	//����Ԥ��
		var consumeTerm   = oneTokSelf(tempStr,"|",7);	//��������
		var prepay_Gift   = oneTokSelf(tempStr,"|",8);	//�Ԥ��
		var consumeTerm   		 = oneTokSelf(tempStr,"|",9);	//�����
		var machPrice     = oneTokSelf(tempStr,"|",10);//������Ԥ���
		var imeiNo    		 = oneTokSelf(tempStr,"|",12);//imei��
		var yuCunKuan = parseFloat(baseFee) + parseFloat(prepay_Gift) + "";
		var begin_time='<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>';

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
		cust_info+="֤�����룺" +document.all.i7.value+"|";
		cust_info+="�ͻ���ַ��"+document.all.i5.value+"|";
		
		/********������**********/
	  opr_info+="�û�Ʒ��: "+ "<%=WtcUtil.repNull(request.getParameter("i8"))%>" + "       ����ҵ��:" + "<%=sale_name%>" +"<%=opName%>"+"|";
		opr_info+="������ˮ: "+"<%=printAccept%>" +"|";
		//  ����Ԥ�滰��XXԪ��ÿ�·�����XXԪ��һ���Է�����XXԪ��ÿ�����ͷ��ã�XXԪ��
	  opr_info+="�˿��ܼƣ�" + cashPay  +"Ԫ   ����Ԥ�滰��" + yuCunKuan + "Ԫ��|" ;
		/*******��ע��**********/
		if("<%=bdbz%>"=="Y"){
			note_info1+="<%=bdts%>"+"|";
		}else{
			note_info1+=" "+"|";
		}
		note_info2+=" "+"|";
		/**********������*********/
	  note_info4+="��ע��" + document.all.tonote.value + "|";
		retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
		
		
		retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
		return retInfo;
}

/*--------------------------������У�麯��--------------------------*/

function checknum(obj1,obj2)
{
    var num2 = parseFloat(obj2.value);
    var num1 = parseFloat(obj1.value);

    if(num2<num1)
    {
        var themsg = "'" + obj1.v_name + "'���ô���'" + obj2.value + "'���������룡";
        rdShowMessageDialog(themsg);
        obj1.focus();
        return false;
    }
    return true;
}
/*-------------------------ҳ���ύ��ת����----------------------------*/
function pageSubmit(flag){
 	if(flag==1){
	/*document.form1.action="<%=request.getContextPath()%>/npage/bill/f1270_1.jsp"; */
  //form1.submit();
      history.go(-1);
	}
	if(flag==2)
	{
	    document.form1.action="<%=request.getContextPath()%>/npage/bill/f1270_3.jsp";
        form1.submit();
	}
	if(flag==3)
	{
	    document.form1.action="f1270_2.jsp";
        form1.submit();
	}
}

var dynTbIndex=0;
var token = "|";

/*------------------------- ɾ����Ӧҵ���߼����---------------------------*/

function tohidden(s)// s ��ʾ �ײ����ͣ���openwindow ����
{
	var tmpTr = "";
	for(var a = document.all('tr').rows.length-2 ;a>0; a--)//ɾ����tr1��ʼ��Ϊ������
	{
        if(document.all.R8[a].value==s && document.all.R1[a].value=="N")
        {   			if(document.all.R11[a].value.trim()=="0"||document.all.R11[a].value.trim()=="c")//choice_flag0��cɾ��
            {
                document.all.tr.deleteRow(a+1);
						}
        }
	}

    return true;
}

function openwindow(theNo,p,q)
{
	//���崰�ڲ���
    var h=600;
    var w=720;
    var t=screen.availHeight-h-20;
    var l=screen.availWidth/2-w/2;
    var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" ;
    var belong_code = document.all.belong_code.value;
    var maincash_no = document.all.maincash_no.value;
    var ip = document.all.ip.value.substring(0,8);
    var cust_id = document.all.i2.value;
    var sendflag = document.all.tbselect.value.substring(0,1);
	//-----------------linxd--1---------------------------
	var minopen="";
	var maxopen="";
    minopen = oMinOpenObj[theNo].value;
	maxopen = oMaxOpenObj[theNo].value;


    var ret_code = window.showModalDialog("f1270_6.jsp?mode_type="+p+"&belong_code="+belong_code+"&maincash_no="+codeChg(maincash_no)+"&ip="+codeChg(ip)+"&cust_id="+cust_id+"&sendflag="+sendflag+"&mode_name="+q+"&minopen="+minopen+"&maxopen="+maxopen,"",prop);
    var srcStr = ret_code;
    if(ret_code==null)
    {
        return false;
    }

    if(typeof(srcStr)!="undefined")
	  {
    	tohidden(p);
        getStr(srcStr,token);
    }
    return true;
}
function getStr(srcStr,token)
	{
		var field_num = 13;
		var i =0;
		var inString = srcStr;
		var retInfo="";
		var tmpPos=0;
	    var chPos;
	    var valueStr;
	    var retValue="";

	    var a0="";
	    var a1="";
	    var a2="";
	    var a3="";
	    var a4="";
		var a5="";
		var a6="";
		var a7="";
        var a8="";
		var a9="";
		var a10="";
		var a11="";
		var a12="";
		var a1Tmp="";
		retInfo = inString;
		chPos = retInfo.indexOf(token);
	    while(chPos > -1)
	    {
		  for( i=0; i<field_num; i++)
		  {
			valueStr = retInfo.substring(0,chPos);

			if(i == 0) a0 = valueStr;
			if(i == 1) a1 = valueStr;
			if(a1=="Y")a1Tmp="�ѿ�ͨ";
			if(a1=="N")a1Tmp="δ��ͨ";
			if(i == 2) a2 = valueStr;
			if(i == 3) a3 = valueStr;
			if(i == 4) a4 = valueStr;
            if(i == 5) a5 = valueStr;
			if(i == 6) a6 = valueStr;
            if(i == 7) a7 = valueStr;
            if(i == 8) a8 = valueStr;
			if(i == 9) a9 = valueStr;
			if(i == 10) a10 = valueStr;
            if(i == 11) a11 = valueStr;
			if(i == 12) a12 = valueStr;
			//rdShowMessageDialog("a12="+a12);
			retInfo = retInfo.substring(chPos + 1);
			chPos = retInfo.indexOf(token);
            if( !(chPos > -1)) break;
	       }
			  insertTab(a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a1Tmp);
	    }
	}
function insertTab(a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a1Tmp)
{

    var tr1=tr.insertRow();
    tr1.id="tr"+dynTbIndex;
    var divid = "div"+dynTbIndex;
    //rdShowMessageDialog(tr1.id);
	//rdShowMessageDialog("a12="+a12);
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
    td2.innerHTML = '<div align="center"><a Href="#"  onClick="openhref('+"'"+a7+"'"+')">'+a0+'</a><input id=R0 type=hidden value='+a0+'  size=10 readonly></input></div>';
    td3.innerHTML = '<div align="center">'+a1Tmp+'<input id=R1 type=hidden value='+a1+'  size=10 readonly></input></div>';
    td4.innerHTML = '<div align="center">'+a2+'<input id=R2 type=hidden value='+a2+'  size=18 readonly></input></div>';
    td5.innerHTML = '<div align="center">'+a3+'<input id=R3 type=hidden value='+a3+'  size=10 readonly></input></div>';
    td6.innerHTML = '<div align="center">'+a4+'<input id=R4 type=hidden value='+a4+'  size=10 readonly></input></div>';
    td7.innerHTML = '<div align="center">'+a5+'<input id=R5 type=hidden value='+a5+'  size=10 readonly></input></div>';
    td8.innerHTML = '<div align="center">'+a6+'<input id=R6 type=hidden value='+a6+'  size=10 readonly><input id=R7 type=hidden value='+a7+'  size=10 readonly><input id=R8 type=hidden value='+a8+'  size=10 readonly><input id=R9 type=hidden value='+a9+'  size=10 readonly><input id=R10 type=hidden value='+a10+'  size=10 readonly><input id=R11 type=hidden value='+a11+'  size=10 readonly><input name="R12" id="R12'+dynTbIndex+'" type=hidden  size=10 readonly></input></div>';
	$("#R12"+dynTbIndex).val(a12);   //Ϊ�˽������������Ϣ�еĻس����������ʾ��ȫ
    getMidPrompt("10442",a7,divid);

    dynTbIndex++;


}
/*------------------------------��֯��������һҳ����---------------------------------------*/
function senddata()
{
 var kx_code_bunch = "";                                     //��ѡ�ʷѴ��봮
 var kx_code_name_bunch = "";                                 //��ѡ�ʷ����ƴ�
 var kx_habitus_bunch ="";                                   //��ѡ�Է�״̬��
 var kx_erpi_bunch="";										//��ѡ�ײͶ���
 var kx_operation_bunch="";                                  //��ѡ�ײ͵���Ч��ʽ��
 var kx_stream_bunch="";                                     //��ѡ�ײ�ԭ��ͨ��ˮ��
 var kx_explan_bunch="";									//��ѡ�ײ�����
 var tempnm="";												 //��ʱ��������
 var kx_want="";											 //��ӡ���������
 var kx_cancle="";											 //��ӡ��ȡ������
 var kx_running="";											 //��ӡ�����п�ͨ����
 var kx_want_chgrow="0";								     //��ӡ���������,���б�־
 var kx_cancle_chgrow= "0";									 //��ӡ��ȡ������,���б�־
 var kx_running_chgrow="0";									 //��ӡ�����п�ͨ����,���б�־
	kx_want =  "���������ѡ�ײͣ�";
	kx_cancle = "����ȡ����ѡ�ײͣ�";

	//rdShowMessageDialog("["+document.all.i16.value.substring(0,8)+"*"+document.all.i18.value.substring(0,8)+"]");
	if(document.all.i16.value.substring(0,8)!=document.all.i18.value.substring(0,8))
			kx_cancle = kx_cancle + " " + document.all.i18.value.substring(8);
    var modestr="";
    var modestr_lj="";
    var modestr_yy="";
	  for(var i=0;i<document.all.checkId.length;i++)
		  {

		/********liucm��ѡ�ʷ�ȡ����ʾ*******************/
		 <% if(iop_code.equals("a198")||iop_code.equals("k200")||iop_code.equals("k206")||iop_code.equals("126c")
		 ||iop_code.equals("8035")||iop_code.equals("8071")||iop_code.equals("8043")||iop_code.equals("8045")
		 ||iop_code.equals("126i")||iop_code.equals("2282")||iop_code.equals("2265")||iop_code.equals("2284")||iop_code.equals("7118")
		 ||iop_code.equals("127a")||iop_code.equals("127b")||iop_code.equals("125c")) {%>

		<%}else{%>
		   if(document.all.checkId[i].checked==false && document.all.R1[i].value=="Y"){
		    	//modestr=modestr+document.all.R7[i].value+"("+document.all.R0[i].value+")����";

		   		if(document.all.R9[i].value=="0"){
		   			modestr_lj=modestr_lj+document.all.R7[i].value+"("+document.all.R0[i].value+"),";
		   		}else{
		   			modestr_yy=modestr_yy+document.all.R7[i].value+"("+document.all.R0[i].value+"),";
		   		}��

		   }

		 <%}%>

		    if(document.all.checkId[i].checked==true && document.all.R1[i].value=="N" ||//����
			   document.all.checkId[i].checked==false && document.all.R1[i].value=="Y" )//ȡ��
				  {
						kx_code_bunch = kx_code_bunch + document.all.R7[i].value + "#"; //��ѡ�ʷѴ��봮
						kx_habitus_bunch = kx_habitus_bunch + document.all.R1[i].value + "#";       //��ѡ�ʷ�״̬��
						kx_operation_bunch = kx_operation_bunch + document.all.R9[i].value + "#";   //��ѡ�ײ͵���Ч��ʽ��
						kx_stream_bunch = kx_stream_bunch + document.all.R10[i].value + "#";//��ѡ�ײ�ԭ��ͨ��ˮ��



						if(document.all.R12[i].value=="��������Ϣ"){
							kx_explan_bunch = kx_explan_bunch ;
						}else{
							kx_explan_bunch = kx_explan_bunch +" "+ document.all.R12[i].value ;
						}
						if(document.all.checkId[i].checked==true && document.all.R1[i].value=="N") //���п�ͨ���
						  {
								kx_want = kx_want +  " (" + document.all.R7[i].value+"��"+ document.all.R0[i].value+"��"+document.all.R5[i].value +")" ;  //���봮
								kx_want_chgrow = 1*kx_want_chgrow+1;
						  }
						if(document.all.checkId[i].checked==false && document.all.R1[i].value=="Y")//ȡ�����
						  {
							kx_cancle = kx_cancle +  " (" + document.all.R7[i].value+"��"+ document.all.R0[i].value+"��"+document.all.R5[i].value +")" ;  //ȡ����
							kx_cancle_chgrow = 1*kx_cancle_chgrow+1;
						  }

				  }
			if(document.all.checkId[i].checked==true)
				  {
			           kx_running = kx_running  + " " + document.all.R0[i].value  ;     //���п�ͨ��
					   kx_running_chgrow = 1*kx_running_chgrow+1;
					   kx_erpi_bunch=kx_erpi_bunch+ document.all.R8[i].value + " ";
					   kx_code_name_bunch = kx_code_name_bunch +document.all.R7[i].value+document.all.R0[i].value+" ";


					   if(kx_running_chgrow==3) kx_running+="|";
			      }
		  }
    	document.all.modestr.value="";
    	//����δ���߷�
		if (modestr_lj.length>0){
		   	document.all.modestr.value=document.all.modestr.value+modestr_lj+"��������ȡ��, "
		}
		if(modestr_yy.length>0){
		    document.all.modestr.value=document.all.modestr.value+modestr_yy+"��������1�ձ�ȡ��, "
		}
		if(document.all.modestr.value.length>0){

			rdShowMessageDialog("��ѡ�ʷ�"+document.all.modestr.value+"����ʾ�ͻ�!");
		}
		  if(modestr.length>0){
		    document.all.modestr.value=modestr;
			rdShowMessageDialog("��ѡ�ʷ�"+document.all.modestr.value+"����һ���ʷ���Чʱ����ȡ��������ʾ�ͻ���");
			}


	if(kx_running=="")kx_running="��";
	kx_running = "��ͨ��ѡ�ײͣ�" +  kx_running +"|";
	kx_want = kx_want + "|";
	kx_cancle = kx_cancle + "|";


		  if(kx_habitus_bunch==""){kx_habitus_bunch = " #";}
		  if(kx_operation_bunch==""){kx_operation_bunch=" #";}
		  if(kx_stream_bunch==""){kx_stream_bunch=" #";}

		  document.all.kx_code_bunch.value=kx_code_bunch;                        //��ѡ�ʷѴ��봮
		  document.all.kx_habitus_bunch.value=kx_habitus_bunch;                  //��ѡ�ʷ�״̬��
		  document.all.kx_operation_bunch.value = kx_operation_bunch;            //��ѡ�ײ͵���Ч��ʽ��
		  document.all.kx_stream_bunch.value = kx_stream_bunch;                  //��ѡ�ײ͵Ŀ�ͨ��ˮ��
		  document.all.kx_explan_bunch.value = kx_explan_bunch;						//��ѡ�ײ�����

		  document.all.kx_erpi_bunch.value = kx_erpi_bunch;
		  document.all.kx_code_name_bunch.value = kx_code_name_bunch;

		  document.all.kx_want.value = kx_want;                                  //��ӡ�������������-��
		  document.all.kx_cancle.value = kx_cancle;                              //��ӡ������ȡ������-��
		  document.all.kx_running.value = kx_running;                            //��ӡ�����п�ͨ���ײ�-��
		/*  rdShowMessageDialog(document.all.kx_code_bunch.value);
		  rdShowMessageDialog(document.all.kx_habitus_bunch.value);
		  rdShowMessageDialog(document.all.kx_operation_bunch.value);
		  rdShowMessageDialog(document.all.kx_stream_bunch.value);
		  rdShowMessageDialog(document.all.kx_want.value);
		  rdShowMessageDialog(document.all.kx_cancle.value);
		  rdShowMessageDialog(document.all.kx_running.value);*/
		  return true;
}
/*----------------------------------�ж�ҵ���ײ��Ƿ���Բ���-----------------------------------*/
function checksel()
{
    with(document.all)
    {
        for(j=0;j<oTypeNameObj.length;j++)
        {
            oDefaultFlagObj[j].value="N";
            oDefaultOpenObj[j].value="N";
            oActualOpenObj[j].value = "0" ;
        }
        for(var i=1;i<checkId.length;i++)
        {
            if(R11[i].value=="b")
            {
                rdShowMessageDialog("��"+R0[i].value+"������Чʱ������ʷʱ���ͻ���������뵼�´˴β���ʧ�ܣ�");
                return false;
            }
            for(var j=0;j<oTypeNameObj.length;j++)
            {
                if(oTypeValueObj[j].value==R8[i].value)
                {
                    if(checkId[i].checked==true)
                    {
                        oActualOpenObj[j].value = 1*oActualOpenObj[j].value+1;
                    }
                    if(R11[i].value=="1"||R11[i].value=="a")
                    {
                        oDefaultFlagObj[j].value="Y";
                        if(checkId[i].checked==true) oDefaultOpenObj[j].value="Y";
                    }
                    break;
                }
            }
        }
        for(j=0;j<oTypeNameObj.length;j++)
        {
            if(Math.round(oActualOpenObj[j].value)<Math.round(oMinOpenObj[j].value)||Math.round(oActualOpenObj[j].value)>Math.round(oMaxOpenObj[j].value))
            {
                rdShowMessageDialog("��"+oTypeNameObj[j].value+"�����ײ�ʵ�ʿ�ͨ"+oActualOpenObj[j].value+"��Ӧ��"+oMinOpenObj[j].value+"��"+oMaxOpenObj[j].value+"֮��");
                return false;
            }
            if(oDefaultFlagObj[j].value=="Y"&&oDefaultOpenObj[j].value=="N")
            {
                rdShowMessageDialog("��ȷ�ϡ�"+oTypeNameObj[j].value+"�����ѡ��ʽΪ��Ĭ�ϡ����ײ����ٿ�ͨһ��");
                return false;
            }
        }
		var tempflag="0";
		var threeflag = "0";
		for(V=0;V<R11.length;V++)
			{
				if(R11[V].value == "4")
					{
						tempflag = 1*tempflag+1;
					}//��ͳ����û�е���3�����ݣ����������һ���ж�
			}
		if(tempflag>0)
			{
				for(m=0;m<R11.length;m++)
					{
					if(R11[m].value == "4" && checkId[m].checked == true)
						{
							threeflag = 1*threeflag+1;
						}
					}
				if(threeflag < 1)
					{
						rdShowMessageDialog("����'����ѡһ'�ײ����ٿ�ͨһ��");
						return false;
					}
			}

    }
    return true;
}
/*-----------------------------------�ж��Ƿ�����Чʱ������ʷʱ���ͻ����������Ĵ�������-----------------------*/
//��ȡҳ��ʱ
onload=function()
{
	if("<%=bdbz%>"=="Y"){
		rdShowMessageDialog("<%=bdts%>");
	}
	for(var i=1;i<document.all.checkId.length;i++)
	{
	if(document.all.R11[i].value=="b")
	  {
	 	rdShowMessageDialog("��"+document.all.R0[i].value+"������Чʱ������ʷʱ���ͻ���������뵼�´˴β���ʧ�ܣ�");
	  }
	}
}

function openhref(p)
	{
		var h=600;
		var w=550;
		var t=screen.availHeight-h-20;
		var l=screen.availWidth/2-w/2;
		var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no" ;
		var region_code = '<%=ibelong_code.substring(0,2)%>';
		var ret_code = window.showModalDialog("f1270m_detail.jsp?mode_code="+p+"&region_code="+region_code,"",prop);
	}
function checkdate(s)
{
	var extdate=s;
	var	date_note;
	var year = s.substr(0,4);
	var month = s.substr(4,2);
	var date = s.substr(6,2);
	var sysyear = <%=new java.text.SimpleDateFormat("yyyy", Locale.getDefault()).format(new java.util.Date())%>;
	var sysmonth = <%=new java.text.SimpleDateFormat("MM", Locale.getDefault()).format(new java.util.Date())%>;
	var sysday = <%=new java.text.SimpleDateFormat("dd", Locale.getDefault()).format(new java.util.Date())%>;
	var sysdate=<%=new java.text.SimpleDateFormat("yyyyMMdd", Locale.getDefault()).format(new java.util.Date())%>;
	if(year==sysyear)
	{	if(month==sysmonth){
			if(date==sysday){
				date_note="����";
			}else if(date-sysday>1){
				date_note="����";
			}else{
				date_note="����";
			}
		}else{
			date_note="����";
		}

	}else{
		date_note="����";
	}
	return date_note;
}

/**************
	//���ַ�������tok�ֽ�ȡֵ
   function oneTok(str,tok,loc){
		   var temStr=str;
		   if(str.charAt(0)==tok) temStr=str.substring(1,str.length);
		   if(str.charAt(str.length-1)==tok) temStr=temStr.substring(0,temStr.length-1);

			 var temLoc;
			 var temLen;
		    for(ii=0;ii<loc-1;ii++)
			{
		       temLen=temStr.length;
		       temLoc=temStr.indexOf(tok);
		       temStr=temStr.substring(temLoc+1,temLen);
		 	}
			if(temStr.indexOf(tok)==-1)
			  return temStr;
			else
		    return temStr.substring(0,temStr.indexOf(tok));
  }
**************/

	//�ֽ��ַ���
	function oneTokSelf(str,tok,loc)
  {
    var temStr=str;
    //if(str.charAt(0)==tok) temStr=str.substring(1,str.length);
    //if(str.charAt(str.length-1)==tok) temStr=temStr.substring(0,temStr.length-1);

	var temLoc;
	var temLen;
    for(ii=0;ii<loc-1;ii++)
	{
       temLen=temStr.length;
       temLoc=temStr.indexOf(tok);
       temStr=temStr.substring(temLoc+1,temLen);
 	}
	if(temStr.indexOf(tok)==-1)
	  return temStr;
	else
      return temStr.substring(0,temStr.indexOf(tok));
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
<%
	System.out.println("###################zhanghongzhanghong24################System.currentTimeMillis()->"+System.currentTimeMillis());
%>

<jsp:include page="fg122_1270_3.jsp">
	<jsp:param name="printAccept" value="<%=printAccept%>"  />
	<jsp:param name="bdbz" value="<%=bdbz%>"  />
	<jsp:param name="bdts" value="<%=bdts%>"  />
	<jsp:param name="note" value="<%=note%>"  />
	<jsp:param name="note1" value="<%=note1%>"  />
	<jsp:param name="smzvalue" value="<%=smzvalue%>"  />
	<jsp:param name="goodbz" value="<%=goodbz%>"  />
</jsp:include>