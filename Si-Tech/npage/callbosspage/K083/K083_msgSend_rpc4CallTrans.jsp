<%
  /*
   * ����: ���ŷ���
   * yanghy. 2009.09.08
 ��*/
 %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_ajax.jsp"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>
<%!//#########################���ȫ�ֺ���.
/**
 * @param to_cut_str Ҫת�����ַ���.
 * @param max_byte_size ����byte��.
 * @return ����һ��list ����.
 */
public static List getArrayByByteSize(String to_cut_str, int max_byte_size){
	List list = new ArrayList();
	double str_byte_length = to_cut_str.getBytes().length ;
	//ȡ���ַ�����byte ����.����ط�Ҫ��double����.
	//System.out.println(str_byte_length+""+Math.round( str_byte_length / max_byte_size));
	for( double i = 0; i < Math.ceil( str_byte_length / max_byte_size ); i ++){
		//�ж� Ҫ�����ַ���������.��double / int�Ľ��.��ȡceil.ȡ��.
		//��ʣ���ַ���ȡ.
		int cut_str_end = cutStrByByteSize(to_cut_str, max_byte_size);
		//ȡ�ÿ�ʼ��ȡ���ַ�λ��.
		list.add(to_cut_str.substring(0 , cut_str_end + 1));
		//���������ȡ.�� 0 �� n
		to_cut_str = to_cut_str.substring(cut_str_end + 1);
		//�����´��ۼӵ��ַ���.ѭ����.��ȡʣ���ַ���.�� n�����.
		//System.out.println(to_cut_str);
	}
	return list;
}
/**
 * @param to_cut_str Ҫ��ȡ���ַ���.
 * @param max_byte_size ��Ҫ��ȡ��  byte ����.
 * @return ���ؽ�ȡ�ַ���λ��.
 */
private static int cutStrByByteSize(String to_cut_str, int max_byte_size) {
	int str_byte_size = 0;
	//�����ַ���byte ����.
	char[] strArray = to_cut_str.toCharArray();
	//���ַ���ת����char ����.
	for (int i = 0; i < strArray.length; i++) {
		int before_add_size = str_byte_size;
		//������ʱ����.������һ����ȡ byte ����.
		str_byte_size += (strArray[i] + "").getBytes().length;
		if (max_byte_size > before_add_size
				&& max_byte_size < str_byte_size) {
			//�����ж�����������һ��byte ����� byte ֮��.˵�����λ�øպ���һ��
			//����.���ʱ�򷵻� ��һ��byte. ��ֹ�ַ�����.���Ҳ���λ��.
			return ( i - 1);
		} else if (str_byte_size == max_byte_size) {
			//���λ�øպ���ȷ���.
			return i;
		}
	}
	return to_cut_str.length() - 1;//���û���ҵ�����to_cut_str.length() - 1.
}//#########################���ȫ�ֺ���.
%>
<%
//���ŷ�����Ҫ4 ������.
String opCode="K029";//˵���Ƕ��ŷ���.����Ǻ���ת�Ƶ�Opcode.
String loginNo = (String)session.getAttribute("workNo"); 
//�õ�Ҫ���͵ĵ绰.�ں���ת������ֻ��һ���绰.
String user_phone = (String)request.getParameter("user_phone");
String[] msg_content = request.getParameterValues("msg_content");
//�õ����Ͷ��ŵ�����.����Ƕ��.
String scucc_flag = "1";
//�ж��ֻ�����λ��.

try{
	if(msg_content != null){//�������Ϊ�ղ�����.
		for(int i = 0; i < msg_content.length; i ++){//�������Ϊ�ղ�����.
			if(msg_content[i] != null && !msg_content[i].equals("") ){
				//�ж϶��������Ƿ�Ϊ��.
				
				List list = getArrayByByteSize(msg_content[i],250);
				for(int j = 0; j < list.size(); j ++){
					System.out.println(i+"###############"+list.get(j));
					/**old sql :String logSql =
					" insert into sms_push_rec_log (serial_no,user_phone,serv_no,insert_time,send_content,success_flag,send_login_no, serv_code) "
					+" select to_char(sysdate,'yyyymmdd')||lpad(SEQ_SMS_PUSH_REC.nextval,10,'0'),'"+user_phone+"','10086',sysdate,'"
					+list.get(j).toString()//������־.
					+"','1','"+loginNo+"' ,'"+opCode+"' from  dual";//opcCode��ӵ�serv_code�ֶ�����.
					*/
					String orgCode = (String)session.getAttribute("orgCode");
					String regionCode = orgCode.substring(0,2);
					String logSql = " insert into sms_push_rec_log (serial_no,user_phone,serv_no,insert_time,send_content,success_flag,send_login_no, serv_code) "
						+" select to_char(sysdate,'yyyymmdd')||lpad(SEQ_SMS_PUSH_REC.nextval,10,'0'), :v1,'10086',sysdate, :v2,'1', :v3 , :v4 from  dual";
					System.out.println("######################################");
					System.out.println(list.get(j).toString());
					System.out.println(opCode);
					System.out.println(loginNo);
					System.out.println(user_phone);
					System.out.println("######################################");
					//�������־��%>
					<wtc:service name="sPubModifyKfCfm" outnum="2" routerKey="region" routerValue="<%=regionCode%>">
						<wtc:param value="<%=logSql%>"/>
						<wtc:param value="dbchange"/>
						<wtc:param value="<%=user_phone%>"/>
						<wtc:param value="<%=list.get(j).toString()%>"/>
						<wtc:param value="<%=loginNo%>"/>
						<wtc:param value="<%=opCode%>"/>
					 </wtc:service>
					 
					<wtc:service name="sK083InsertNew" outnum="2">
						<wtc:param value="<%=list.get(j).toString()%>" />
						<wtc:param value="<%=opCode%>" />
						<wtc:param value="<%=loginNo%>" />
						<wtc:param value="<%=user_phone%>"/>
					</wtc:service>
					<wtc:array id="retList" scope="end" />
				<%}
				System.out.println("retList=");
			}
		}	
	}//���û�д��󷵻�1����.
	System.out.println("���Ͷ��ųɹ�.");
	out.print("1");//ֱ�����..
}catch(Exception e){
	out.print("-1");//ֱ�����..
}%>