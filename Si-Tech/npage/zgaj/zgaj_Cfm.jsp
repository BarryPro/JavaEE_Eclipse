<%
/********************
 * version v2.0
 * ������: si-tech
 * update by zhangshuaia @ 2009-08-05
 ********************/
%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%	
    //һ���˷�begin
	String tfhm = request.getParameter("tfhm"); 
	String ywsysjArrays= request.getParameter("ywsysjArrays");
	String ywmcArrays= request.getParameter("ywmcArrays");
	String ywdmArrays= request.getParameter("ywdmArrays");
	String fwtgsArrays= request.getParameter("fwtgsArrays");
	String qydmArrays= request.getParameter("qydmArrays");
	String fylxArrays= request.getParameter("fylxArrays");
	String fyArrays= request.getParameter("fyArrays");
	//��ҳѡ����������ֵ������ ��Ϊ�˷�����ԭ��
	String s_tf_type = request.getParameter("s_tf_type");//�˷�����ԭ��
	String tsdzls = request.getParameter("tsdzls");//Ͷ�ߵ�����ˮ

	//  �˷���ˮ��     �����˷�ҵ������
	String bctfywmc= request.getParameter("searchType1");
	String bctfyybz= request.getParameter("otherReason");
	String btje = request.getParameter("btje");
	String stze = request.getParameter("stze");//ʵ���ܶ�
	String s_ds_flag= request.getParameter("s_ds_flag");
	String tfzl= request.getParameter("tfzl");
	String hjlx= request.getParameter("hjlx");
	String jflx = request.getParameter("jflx");
	String hjsj = request.getParameter("hjsj");
	String tfnote = request.getParameter("tfnote");
	System.out.println("fffffaaaaaaaaasssssssssssssfffffffffffffffsssssssssssssssss ywmcArrays is "+ywmcArrays+" and fyArrays is "+fyArrays+" and s_ds_flag is "+s_ds_flag+" and tfzl is "+tfzl+" and hjlx is "+hjlx+" and tfnote is "+tfnote+" and bctfywmc is "+bctfywmc+" and bctfyybz is "+bctfyybz);
	if(btje=="" ||btje.equals(""))
	{
		System.out.println("aaaaaaaaaaaaaaaaaaaaaaaaa ���ò����˷�");
	}
	else
	{
		System.out.println("bbbbbbbbbbbbbbbbbbbbb �ò����˷�");
	}
	String checkds = request.getParameter("checkds");//��˫��
	//end of һ���˷�

	String org_Code = (String)session.getAttribute("orgCode");
    String regionCode = org_Code.substring(0,2);				   
	String op_code = "zgaj";              //��������
	
	String work_no = (String)session.getAttribute("workNo"); 
	
	//work_no="800195";

	String loginName = (String)session.getAttribute("workName");   
	String pass = (String)session.getAttribute("password");
	String paraAray[] = new String[25];
	paraAray[0] = ywsysjArrays;  		    //ҵ��ʹ��ʱ��
	paraAray[1] = ywmcArrays;  				//bizname
	paraAray[2] = ywdmArrays; 				//bizcode
	paraAray[3] = fwtgsArrays; 			    //spname
	paraAray[4] = qydmArrays;			    //spcode
	paraAray[5] = fyArrays; 			    //���� �����˷ѵĽ�� ���ó��Ե�˫��ɶ��
	paraAray[6] = tfhm;			    //�˷Ѻ���
	paraAray[7] = tsdzls;             //Ͷ�ߵ�����ˮ
	paraAray[8] = tfzl;        //�˷�����=��Ԥ��
	paraAray[9] = "1003";           //�˷�һ��ԭ��code ������׿ɲ����Կ� �Ҹо����Կ� ��Ϊ�����Ĳ�ѯ�����������ñ��ѯ����ԭ�򼴿���
	paraAray[10] = "1006";          //�˷Ѷ���ԭ��code
	paraAray[11] = s_tf_type;           //�˷�����ԭ��code ���õ�SREFUNDCheckType
	paraAray[12] = stze;	    //�⳥��� ���˷��ܽ�� SYSTEM_PRICE
	paraAray[13] = tfnote;             //��ע
	paraAray[14] = regionCode;  //���д���
	paraAray[15] = org_Code;   //��������
	paraAray[16] = hjlx; 
	paraAray[17] = jflx; 
	paraAray[18] = hjsj; 
	paraAray[19] = s_ds_flag;//����˫��
	paraAray[20] = btje;	//�����˷� ֻ���벹���˷ѽ��� ѡ�񲹳��˷�ҵ�����ƾ����� 
	paraAray[21] = bctfywmc;
	paraAray[22] = bctfyybz;//ԭ��ѡ��������ʱ �����ֵ
	paraAray[23] = work_no;
	paraAray[24] = pass;
	//xl add for ���� ����
	
	
	
%>
<wtc:service name="szgajCfm" routerKey="phone" routerValue="<%=tfhm%>" retcode="s4141CfmCode" retmsg="s4141CfmMsg" outnum="2" >
    <wtc:param value="<%=paraAray[0]%>"/>
    <wtc:param value="<%=paraAray[1]%>"/> 
    <wtc:param value="<%=paraAray[2]%>"/>
    <wtc:param value="<%=paraAray[3]%>"/>
    <wtc:param value="<%=paraAray[4]%>"/>
    <wtc:param value="<%=paraAray[5]%>"/>
    <wtc:param value="<%=paraAray[6]%>"/>
    <wtc:param value="<%=paraAray[7]%>"/>
    <wtc:param value="<%=paraAray[8]%>"/>
    <wtc:param value="<%=paraAray[9]%>"/>
    <wtc:param value="<%=paraAray[10]%>"/>
    <wtc:param value="<%=paraAray[11]%>"/>
    <wtc:param value="<%=paraAray[12]%>"/>
    <wtc:param value="<%=paraAray[13]%>"/>
    <wtc:param value="<%=paraAray[14]%>"/>	
    <wtc:param value="<%=paraAray[15]%>"/>
    <wtc:param value="<%=paraAray[16]%>"/>
    <wtc:param value="<%=paraAray[17]%>"/>
    <wtc:param value="<%=paraAray[18]%>"/>
    <wtc:param value="<%=paraAray[19]%>"/>
	<wtc:param value="<%=paraAray[20]%>"/>
	<wtc:param value="<%=paraAray[21]%>"/>
	<wtc:param value="<%=paraAray[22]%>"/>
	<wtc:param value="<%=paraAray[23]%>"/>
	<wtc:param value="<%=paraAray[24]%>"/>
</wtc:service>
<wtc:array id="s4141CfmArr" scope="end"/>
<%
	String retCode= s4141CfmCode;
	String retMsg = s4141CfmMsg;

	String errMsg = s4141CfmMsg;
	if (s4141CfmArr.length > 0 && s4141CfmCode.equals("000000"))
	{
 
%>
<script language="JavaScript">
	rdShowMessageDialog("Ͷ���˷�ҵ����ɹ���",2);
	window.location="zgaj_1.jsp";
	</script>
<%
	}else{
%>   
<script language="JavaScript">
	rdShowMessageDialog("Ͷ���˷�ҵ����ʧ��: <%=retMsg%>,<%=retCode%>",0);
	window.location="zgaj_1.jsp";
	</script>
<%}
%>
		 



