<%
   /*
   * ����: �����´������¹�����Ϣ
�� * �汾: v1.0
�� * ����: 2008��11��19��
�� * ��Ȩ: sitech
 ��*/
%>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%@ page import="java.security.*" %>
<%@ page import="javax.crypto.*;" %>
<%@ page contentType= "text/html;charset=gb2312" %>
<%
		System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
	  String org_code = (String)session.getAttribute("orgCode");
		String regionCode=org_code.substring(0,2);
		String workNo = (String)session.getAttribute("workNo");
		String sqlStmt = 
		" select b.group_name, msg.group_name, e1.group_name," + 
		" decode(c.wf_status,'10','9718','975i'), c.wf_id " +
	    " from dbresadm.dchngroupinfo a, schnregionlist b,dbchnterm.dchnresexchangemsg c,"+
	    "      dchngroupmsg e1,dchngroupinfo info2,dchngroupmsg msg " +
	    " where a.parent_group_id = b.group_id and a.group_id = c.group_id and c.group_id = e1.group_id "+
	    " and a.group_id = info2.group_id and info2.parent_group_id = msg.group_id and msg.root_distance = 3"+
	    " and c.deal_login = '"+workNo+"'";
%>

		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" outnum="5">
			<wtc:sql><%=sqlStmt%></wtc:sql>
			<wtc:param value="<%=workNo%>"/> 
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
	<div class="itemContent">
		<div id="form">

				<table width="100%" border=0 cellpadding="0" cellspacing=1 cellpadding="0" class="list">
					<tr>
						<th>����</th>
						<th>����</th>
						<th>����</th>
						<th>Ӫҵ��</th>
						<th>��ʾ��Ϣ</th>
					</tr>
					<%
					if(retCode.equals("000000")){
					for(int i=0; i<result.length; i++)
					{
						String classes="";
						if(i%2==1){classes="grey";}
					%>
					<tr>
					  <td class="<%=classes%>" align="center"><%=result[i][4]%></td>
						<td class="<%=classes%>" align="center"><%=result[i][0]%></td>
						<td class="<%=classes%>" align="center"><%=result[i][1]%></td>
						<td class="<%=classes%>" align="center"><%=result[i][2]%></td>
						<td class="<%=classes%>" align="center"><a href="#" onclick="open_newpage('<%=result[i][3]%>','<%=result[i][4]%>');" >�д���������Ӫ�������ۻ��µ���</a></td>
					</tr>
					<%}
					}
					else
					{
						out.println("<tr><td>��ȡ���ݴ���</td></tr>");
					}
					%>
				</table>
		  </div>
		</div>
		
<script>
   $("#wait6").hide();		   
</script>		
<%!
private String getHostE(String host){
	if (host==null || "".equals(host)){
		return "";
	}
	try{
		Cipher encryptCipher = null;
		String strDefaultKey = "MumuLee";
		//Security.addProvider(new com.sun.crypto.provider.SunJCE());
		Key key = getKey(strDefaultKey.getBytes());
	
		encryptCipher = Cipher.getInstance("DES");
		encryptCipher.init(Cipher.ENCRYPT_MODE, key);
		
		return byteArr2HexStr(encryptCipher.doFinal(host.getBytes()));
	}
	catch(Exception e){
		e.printStackTrace();
		return "";
	}	
}
private static String byteArr2HexStr(byte[] arrB) throws Exception {
	int iLen = arrB.length;
	//ÿ��byte�������ַ����ܱ�ʾ�������ַ����ĳ��������鳤�ȵ�����
	StringBuffer sb = new StringBuffer(iLen * 2);
	for (int i = 0; i < iLen; i++) {
		int intTmp = arrB[i];
		//�Ѹ���ת��Ϊ����
		while (intTmp < 0) {
			intTmp = intTmp + 256;
		}
		//С��0F������Ҫ��ǰ�油0
		if (intTmp < 16) {
			sb.append("0");
		}
		sb.append(Integer.toString(intTmp, 16));
	}
	return sb.toString();
}	

private Key getKey(byte[] arrBTmp) throws Exception {
	//����һ���յ�8λ�ֽ����飨Ĭ��ֵΪ0��
	byte[] arrB = new byte[8];
	//��ԭʼ�ֽ�����ת��Ϊ8λ
	for (int i = 0; i < arrBTmp.length && i < arrB.length; i++) {
		arrB[i] = arrBTmp[i];
	}
	//������Կ
	Key key = new javax.crypto.spec.SecretKeySpec(arrB, "DES");
	return key;
}
%>
<%
  String workGroupId = "10031";
	String op_code = "";
	int num = result.length;        
	if(num != 0)
	{
		op_code = result[0][3];
	}
    	
	String tmpE = "";
	if (op_code.equals("9718"))
	{
		tmpE = op_code + ",����Ӫ�������ۻ�����������,";
	}	
	if (op_code.equals("975i"))
	{
		tmpE = op_code + ",����Ӫ�������ۻ��´����ѯ,";
	}	
	
	
	tmpE = tmpE+workNo+",";
	tmpE = tmpE+workGroupId+",";
	tmpE = tmpE+request.getServerName();
	tmpE = tmpE+","+op_code;
	
	StringBuffer chnSb = new StringBuffer().append("&chnLee=").append(getHostE(tmpE));
	//String ip = "http://10.110.0.200:10002/"; //���Ի���ʹ��
	String ip = "http://10.110.0.100:46000/"; //�ϴ���ʽ����ʱʹ��
%>
<SCRIPT  language=JavaScript1.2> 

function open_newpage(op_code,wf_id)
{
	var winwidth=screen.width; 
	var winheight=screen.height; 
	window.open("<%=ip%>f"+op_code+".do?operate=waylist&workbase.wf_id="+wf_id+"&func_type=0&deal_role=20&func_code="+op_code+"<%=chnSb%>","title",'top=0,left=0,resizable =yes,width='+screen.width+',height='+screen.height);
	window.close();
}
</script>		
		