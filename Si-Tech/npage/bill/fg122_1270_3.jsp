<%@ page contentType="text/html; charset=GBK" %>
<%@ page import="java.text.*"%>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%@ include file="/npage/properties/getRDMessage.jsp" %>
<%String Readpaths = request.getRealPath("npage/properties")+"/getRDMessage.properties";%>
<%
	String printAccept = request.getParameter("printAccept");
	String bdbz = request.getParameter("bdbz");
	String bdts = request.getParameter("bdts");
	String note = request.getParameter("note");
	String note1 = request.getParameter("note1");
	String smzvalue = request.getParameter("smzvalue");
	String goodbz = request.getParameter("goodbz");
	String oSmCode = request.getParameter("oSmCode")==null?"":request.getParameter("oSmCode");
	String m_smCode = request.getParameter("m_smCode")==null?"":request.getParameter("m_smCode");
%>
<script language="JavaScript">
function printInfoG122()
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
	opr_info+="ҵ������: ��TD����̻���ͨ�ŷ�����"+"|";
	<%if(goodbz.equals("Y")){%>
	opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
	<%}else{%>
	opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
	<%}%>
	opr_info+="TD����̻�Ʒ�ƣ�"+agent_code+"���ͺţ�"+phone_type+"��IMEI�ţ�"+imeino+"|";
	opr_info+="���ͻ���"+base_fee+"Ԫ|";

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
	   var old_SmCode = "<%=oSmCode%>";
       var new_SmCode = "<%=m_smCode%>";
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
		  		note_info1+="<%=readValue("g122","ps","jf",Readpaths)%>"+"|";
		  		<%}%>
  		
	note_info3+=" "+"|";
	note_info4+="��ע�� "+"|";
    retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
    retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
    return retInfo;

}
//��TD����̻���ͨ�ŷѳ���  sunaj��20090828
function printInfoG123()
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
	opr_info+="ҵ������: ��TD����̻���ͨ�ŷѳ���"+"|";
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

function printInfoG124()
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
	opr_info+="ҵ������: ��TD����̻���ͨ�ŷ�(��ͨ)����"+"|";
	<%if(goodbz.equals("Y")){%>
	opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
	<%}else{%>
	opr_info+="������ˮ��"+"<%=printAccept%>"+"|";
	<%}%>
	opr_info+="������Ϣ��Ʒ��"+agent_code+"���ͺ�"+phone_type+"������IMEI"+imeino+"|";
	opr_info+="���ͻ��ѣ�"+base_fee+"Ԫ|";

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
	  var old_SmCode = "oSmCode%>";
	  var new_SmCode = "m_smCode%>";
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
function printInfoG125()
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
	opr_info+="ҵ������: ��TD����̻���ͨ�ŷ�(��ͨ)����"+"|";
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

</script>